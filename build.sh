#!/usr/bin/env bash

SWD=$(cd $(dirname $0);echo $PWD)

function get_kitsu_version() {
    if [[ $KITSU_VERSION == "latest" ]]; then
        export KITSU_VERSION=`curl https://api.github.com/repos/cgwire/kitsu/commits | jq -r '.[].commit.message | select(. | test("[0-9]+(\\\\.[0-9]+)+"))?' | grep -m1 ""`
        echo "${GREEN}Set KITSU_VERSION to $KITSU_VERSION"
    fi
}


function get_zou_version(){
    if [[ $ZOU_VERSION == "latest" ]]; then
        export ZOU_VERSION=`curl https://api.github.com/repos/cgwire/zou/commits | jq -r '.[].commit.message | select(. | test("[0-9]+(\\\\.[0-9]+)+"))?' | grep -m1 ""`
        echo "${GREEN}Set ZOU_VERSION to $ZOU_VERSION"
    fi
}


function check_dependencies(){
    failed=false
    if [ ! -e "$SWD/kitsu/Dockerfile" ]; then
        echo "${ERROR}Kitsu Dockerfile required"
        failed=true
    fi
    if [ ! -e "$SWD/zou/Dockerfile" ]; then
        echo "${ERROR}Zou Dockerfile required"
        failed=true
    fi
    if $DEVELOP && [ ! -e "$SWD/kitsu-dev/.git" ]; then
        echo "${ERROR}Kitsu repo required"
        failed=true
    fi
    if $DEVELOP && [ ! -e "$SWD/zou-dev/.git" ]; then
        echo "${ERROR}Zou repo required"
        failed=true
    fi

    if $failed; then
        exit 1
    fi
}


function build_images() {
    echo "${MAGENTA}BUILD CONTAINERS"

    check_dependencies

    if $DEVELOP; then
        COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
        dc -f docker-compose.yml -f docker-compose.genesys.yml -f docker-compose.ldap.yml -f docker-compose.aizen.yml -f docker-compose.develop.yml build --force-rm --pull
    else
        command -v curl 1>/dev/null || { echo "${ERROR}curl required" && exit 1; }
        command -v jq 1 >/dev/null || { echo "${ERROR}jq required" && exit 1; }

        get_kitsu_version
        get_zou_version
        COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
        dc -f docker-compose.yml -f docker-compose.genesys.yml -f docker-compose.ldap.yml -f docker-compose.aizen.yml -f docker-compose.build.yml build --force-rm --pull
    fi
}

genesys_file="-f docker-compose.genesys.yml"
ldap_file="-f docker-compose.ldap.yml"
prod_file="-f docker-compose.prod.yml"
build_file="-f docker-compose.build.yml"
develop_file="-f docker-compose.develop.yml"
function compose_up() {
    echo "${YELLOW}START CONTAINERS"
    if $DEVELOP ; then
        eval "dc -f docker-compose.yml $genesys_file $ldap_file $aizen_file $develop_file up -d"
    elif $BUILD ; then
        eval "dc -f docker-compose.yml $genesys_file $ldap_file $aizen_file $prod_file $build_file up -d"
    else
        dc pull --include-deps
        eval "dc -f docker-compose.yml $genesys_file $ldap_file $aizen_file $prod_file up -d"
    fi
    if [[ "${ENABLE_JOB_QUEUE}" != "True" ]]; then
        echo "${YELLOW}DISABLE ZOU ASYNC JOBS"
        dc stop zou-jobs
    fi
    
    until dc exec -T db pg_isready ; do
        sleep 3
        echo "${YELLOW}Waiting for db..."
    done
}


function compose_down() {
    echo "${YELLOW}STOP CONTAINERS"
    # dc down -f docker-compose.yml -f docker-compose.genesys.yml -f docker-compose.ldap.yml -f docker-compose.aizen.yml
    dc down
    # dc down -f docker-compose.genesys.yml
    # dc down -f docker-compose.ldap.yml
    # dc down -f docker-compose.aizen.yml
}


function init_zou() {
    dbowner=postgres
    dbname=zoudb

    if $DEVELOP && ! $KEEP_DB; then
        echo "${MAGENTA}DROP DEV DB"
        dc exec db  su - postgres -c "dropdb ${dbname}"
    fi

    if dc exec db psql -U ${dbowner} ${dbname} -c '' 2>&1; then
        echo "${GREEN}UPGRADE ZOU"
        dc exec zou-app sh /upgrade_zou.sh
    else
        echo "${GREEN}INIT ZOU"
        dc exec db  su - postgres -c "createdb -T template0 -E UTF8 --owner ${dbowner} ${dbname}"
        dc exec zou-app zou reset-search-index
        dc exec zou-app sh /init_zou.sh
    fi
}


function init_aizen() {
    dbowner=postgres
    dbname=aizendb

    if $DEVELOP && ! $KEEP_DB; then
        echo "${MAGENTA}DROP DEV DB"
        dc exec aizen-db  su - postgres -c "dropdb ${dbname}"
    fi

    if dc exec aizen-db psql -U ${dbowner} ${dbname} -c '' 2>&1; then
        echo "${GREEN}UPGRADE Aizen"

        while [[ $(docker inspect -f '{{.State.Status}}' eaxum-aizen) != "running" ]]; do
            echo "Waiting for 'aizen' container to start..."
            sleep 2
        done
        dc exec aizen sh /upgrade_aizen.sh
    else
        echo "${GREEN}INIT Aizen"
        dc exec aizen-db  su - postgres -c "createdb -T template0 -E UTF8 --owner ${dbowner} ${dbname}"
        # check if aizen container is running if not sleep for to sec until its running
        while [[ $(docker inspect -f '{{.State.Status}}' eaxum-aizen) != "running" ]]; do
            echo "Waiting for 'aizen' container to start..."
            sleep 2
        done
        dc exec aizen sh /init_aizen.sh
    fi
}

function init_genesys_addon() {
    echo "${GREEN}INIT ZOU-GENESYS ADDON"
    python3 $SWD/download_genesys_addon.py
    dc cp $SWD/genesys_addon zou-app:/usr/local/lib/python3.11/site-packages/zou/app/services/genesys_addon
    dc cp $SWD/genesys_addon zou-jobs:/usr/local/lib/python3.11/site-packages/zou/app/services/genesys_addon
    dc cp $SWD/genesys_addon zou-event:/usr/local/lib/python3.11/site-packages/zou/app/services/genesys_addon

    echo "${GREEN}RESTART ZOU"
    dc restart zou-app zou-jobs zou-event
}

function init_ldap() {
    echo "${GREEN}INIT LDAP"
    docker cp ./ldap_acl.ldif  eaxum-ldap:/tmp/ldap_acl.ldif
    docker cp ./ldap_default.ldif  eaxum-ldap:/tmp/ldap_default.ldif
    docker exec eaxum-ldap ldapmodify  -Y EXTERNAL -H ldapi:/// -f /tmp/ldap_acl.ldif
    docker exec eaxum-ldap ldapmodify  -Y EXTERNAL -H ldapi:/// -f /tmp/ldap_default.ldif
    ./sync_ldap.sh
    sleep 2
    docker compose exec -T db  psql -U postgres zoudb -c "UPDATE person SET role = 'admin' WHERE desktop_login = 'super-user';"
}

# --------------------------------------------------------------
# ---------------------------- ARGS ----------------------------
# --------------------------------------------------------------

source $SWD/common.sh
echo "${BLUE}PARSE ARGS"

BUILD=false
DOWN=false
case $1 in
  local)
    BUILD=true
    echo "${CYAN}USE LOCAL BUILD"
    shift
    ;;
  down)
    DOWN=true
    echo "${CYAN}STOP INSTANCE"
    shift
    ;;
esac

export ENV_FILE=$SWD/env
DEVELOP=false
KEEP_DB=false
USE_AIZEN=false
aizen_file=""
for i in "$@"; do
    case $i in
        -e=* | --env=*)
            export ENV_FILE="${i#*=}"
            echo "${CYAN}USE CUSTOM ENV FILE"
            shift
            ;;
        --develop)
            if ! $BUILD && ! $DOWN ; then
                echo "${ERROR}Develop flag works only with 'local' and 'down' commands"
                exit 1
            fi
            DEVELOP=true
            echo "${MAGENTA}DEV MODE"
            shift
            ;;
        --aizen)
            USE_AIZEN=true
            aizen_file="-f docker-compose.aizen.yml"
            echo "${MAGENTA}USE AIZEN"
            shift
            ;;
        --keep-db)
            KEEP_DB=true
            echo "${MAGENTA}KEEP DEV DB DATA"
            shift
            ;;
        -h | --help)
            echo "
    Usage:

        build.sh [subcommand] [options]

    Subcommand:

        local                   Use local build of Kitsu and Zou containers
        down                    Compose Down the stack

    Options:
        -e, --env=ENV_FILE      Set custom env file. If not set ./env is used

            --develop           [local, down] Gives access to running code on the host. Clean DB every time it's rebuild.
            --keep-db           [local] Combined with '--develop'. Keep DB data.

        -h, --help              Show this help
                "
            exit 0
        ;;
        *)
            echo "${ERROR}Invalid flag ${i} // Use -h or --help to print help"
            exit 1
        ;;
    esac
done


# --------------------------------------------------------------
# ---------------------------- MAIN ----------------------------
# --------------------------------------------------------------

if $KEEP_DB && ! $DEVELOP; then
    echo "${ERROR}Keep-DB flag works with 'develop' flag only"
    exit 1
fi

source_env ${ENV_FILE}

if $DEVELOP; then
    export COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME}-dev"
fi

compose_down

if ! $DOWN ; then
    if $BUILD ; then
        build_images
    fi

    compose_up
    init_zou
    init_genesys_addon
    init_ldap
    if $USE_AIZEN; then
        init_aizen
    fi
fi
