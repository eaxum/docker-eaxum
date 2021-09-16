#!/usr/bin/env bash


function build_images() {
    echo "${MAGENTA}BUILD CONTAINERS"

    command -v curl 1>/dev/null || { echo "${ERROR}curl required" && exit 1; }
    command -v jq 1>/dev/null || { echo "${ERROR}jq required" && exit 1; }

    if [[ $KITSU_VERSION == "latest" ]]; then
        export KITSU_VERSION=`curl https://api.github.com/repos/cgwire/kitsu/commits | jq -r '.[].commit.message | select(. | test("[0-9]+(\\\\.[0-9]+)+"))?' | grep -m1 ""`
        echo "${GREEN}Set KITSU_VERSION to $KITSU_VERSION"
    fi
    if [[ $ZOU_VERSION == "latest" ]]; then
        export ZOU_VERSION=`curl https://api.github.com/repos/cgwire/zou/commits | jq -r '.[].commit.message | select(. | test("[0-9]+(\\\\.[0-9]+)+"))?' | grep -m1 ""`
        echo "${GREEN}Set ZOU_VERSION to $ZOU_VERSION"
    fi

    if [ ! -e "./kitsu/Dockerfile" ] || [ ! -e "./zou/Dockerfile" ]; then
        echo "${ERROR}Kitsu and Zou Dockerfiles required"
        exit 1
    fi
    docker-compose -f docker-compose.yml -f docker-compose.build.yml build --force-rm --pull --compress
}


function compose_up() {
    echo "${YELLOW}START CONTAINERS"
    if [ ${BUILD} == 1 ]; then
        eval "docker-compose -f docker-compose.yml $nextcloud_file $genesys_file -f docker-compose.build.yml  up -d"
    else
        eval "docker-compose -f docker-compose.yml $nextcloud_file $genesys_file pull --include-deps"
        eval "docker-compose -f docker-compose.yml $nextcloud_file $genesys_file up -d"
    fi
    if [[ "${ENABLE_JOB_QUEUE}" != "True" ]]; then
        echo "${YELLOW}DISABLE ZOU ASYNC JOBS"
        docker-compose stop zou-jobs
    fi

    until docker-compose exec -T db pg_isready ; do
        sleep 3
        echo "${YELLOW}Waiting for db..."
    done
}


function compose_down() {
    echo "${YELLOW}STOP CONTAINERS"
    eval "docker-compose -f docker-compose.yml $nextcloud_file $genesys_file down"
}


function init_zou() {
    echo "${GREEN}INIT ZOU"
    sleep 2
    docker-compose exec -T db  su - postgres -c "createdb -T template0 -E UTF8 --owner postgres zoudb"
    docker-compose exec -T zou-app sh init_zou.sh

    # dbowner=postgres
    # dbname=zoudb
    
    # if docker-compose exec -T db psql -U ${dbowner} ${dbname} -c '' 2>&1; then
    #     echo "${GREEN}UPGRADE ZOU"
    #     echo "sleeping for 10 seconds"
    #     sleep 10
    #     docker-compose exec -T zou-app sh upgrade_zou.sh
    # else
    #     echo "${GREEN}INIT ZOU"
    #     echo "sleeping 10 seconds"
    #     sleep 10
    #     docker-compose exec -T db  su - postgres -c "createdb -T template0 -E UTF8 --owner ${dbowner} ${dbname}"
    #     docker-compose exec -T zou-app sh init_zou.sh
    # fi
}

function init_ldap() {
    echo "${GREEN}INIT LDAP"
    docker cp ./ldap_acl.ldif  eaxum-ldap:/tmp/ldap_acl.ldif
    docker cp ./ldap_default.ldif  eaxum-ldap:/tmp/ldap_default.ldif
    docker exec eaxum-ldap ldapmodify  -Y EXTERNAL -H ldapi:/// -f /tmp/ldap_acl.ldif
    docker exec eaxum-ldap ldapmodify  -Y EXTERNAL -H ldapi:/// -f /tmp/ldap_default.ldif
    ./sync_ldap.sh
    sleep 2
    docker-compose exec -T db  psql -U postgres zoudb -c "UPDATE person SET role = 'admin' WHERE desktop_login = 'super-user';"
}

# --------------------------------------------------------------
# ---------------------------- ARGS ----------------------------
# --------------------------------------------------------------

source common.sh
nextcloud_file=""
genesys_file=""
build_file=""
BUILD=0
DOWN=0
NEXTCLOUD=0
GENESYS=0
INIT_LDAP=0
export ENV_FILE=./env

echo "${BLUE}PARSE ARGS"
for i in "$@"; do
    case $i in
        -l | --local)
            BUILD=1
            build_file="-f docker-compose.build.yml"
            echo "${CYAN}USE LOCAL BUILD"
            shift
            ;;
        -e=* | --env=*)
            export ENV_FILE="${i#*=}"
            echo "${CYAN}USE CUSTOM ENV FILE"
            shift
            ;;
        -d | --down)
            DOWN=1
            echo "${CYAN}STOP INSTANCE"
            shift
            ;;
        -n | --nextcloud)
            NEXTCLOUD=1
            nextcloud_file="-f docker-compose.nextcloud.yml"
            echo "${CYAN}INSTALL NEXTCLOUD"
            shift
            ;;
        -g | --genesys)
            GENESYS=1
            genesys_file="-f docker-compose.genesys.yml"
            echo "${CYAN}INSTALL GENESYS"
            shift
            ;;
        -h | --help)
            echo "
    Usage:

        build.sh [options]

    Flags:

        -l, --local             Use local images
        -e, --env=ENV_FILE      Set custom env file. If not set ./env is used
        -d, --down              Compose down the stack
        -g | --genesys          add genesys
        -n | --nextcloud        add nextcloud
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

source_env ${ENV_FILE}
compose_down

if [ $DOWN == 0 ]; then
    if [ $BUILD == 1 ]; then
        build_images
    fi

    compose_up
    init_zou
    init_ldap
fi
