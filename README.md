# Docker-cgwire

Docker compose for [Kitsu](https://kitsu.cg-wire.com/), [Zou](https://zou.cg-wire.com/), [Genesys](https://github.com/eaxum/genesys), [Subversion Edge](https://www.collab.net/downloads/subversion), and [Nextcloud](https://nextcloud.com/)

## Usage

```bash
bash build.sh
```

#### First time run

```bash
bash build.sh -g -i -u
```

#### Use local images

```bash
bash get_build_dependencies.sh  #clone Kitsu, Zou, and Genesis Dockerfiles into subfolders

bash build.sh -l 
```

#### Flags:

```
    -i, --init              Init Zou and the database (Required for the first launch)
    -l, --local             Use local images
    -e, --env=ENV_FILE      Set custom env file. If not set ./env is used
    -d, --down              Compose down the stack
    -g | --genesys          add genesys
    -n | --nextcloud        add nextcloud
    -u | --init-ldap-users  INITIALIZE LDAP USERS FOR KITSU
    -h, --help              Show this help
```

## LDAP

Add your [LDAP variables](https://zou.cg-wire.com/configuration/#ldap) to the env file.

```bash
bash sync_ldap.sh
```

#### LDAP flags

```
    -e, --env=ENV_FILE      Set custom env file, must be the same as the env used with build.sh
    -h, --help              Show this help
```

## DB Upgrade

**[- Be sure to backup your datas before upgrading. -]**

```bash
# bash db_upgrade [options] oldDbVersion newDbVersion

# PostgreSql 9.5 to 11

bash db_upgrade 9.5 11
```

Don't forget to update the DB_VERSION key in your 'env' file **after** the upgrade. 

#### DB Upgrade flags

```
    -e, --env=ENV_FILE      Set custom env file, must be the same as the env used with build.sh
    -d, --dry-run           
    -h, --help              Show this help
```

## Default credentials:

* login: super-user
* password: eaxumdef0007

## About authors

Kitsu and Zou Dockerfiles are based on CG Wire work, a company based in France. They help small
to midsize CG studios to manage their production and build a pipeline
efficiently.

They apply software craftsmanship principles as much as possible. They love
coding and consider that strong quality and good developer experience matter a lot.
Through their diverse experiences, they allow studios to get better at doing
software and focus more on  artistic work.

Visit [cg-wire.com](https://cg-wire.com) for more information.

[![CGWire Logo](https://zou.cg-wire.com/cgwire.png)](https://cgwire.com)

Genesys is built and managed by Eaxum

[![Eaxum Logo](https://eaxum.com/wp-content/uploads/2020/07/LogoCapsule_small-300x113.png)](https://eaxum.com)