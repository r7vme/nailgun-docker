#!/bin/bash

set -e

BOOTSTRAP_DONE="BOOTSTRAP.DONE"

# Prepapre nailgun database in the first run.
# This can not be done inside image, because
# we need postgresql to be running.
if [ ! -f $BOOTSTRAP_DONE ]; then
    # Initialize PostgreSQL
    su - postgres -c '/usr/pgsql-9.3/bin/initdb /var/lib/pgsql/9.3/data'

    # Run temporary PostgreSQL
    su - postgres -c '/usr/pgsql-9.3/bin/postgres -D /var/lib/pgsql/9.3/data -p 5432 &'
    sleep 10

    # Initialize fresh Nailgun database
    echo "CREATE ROLE nailgun PASSWORD 'nailgun' \
          SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN; \
          CREATE DATABASE nailgun OWNER nailgun" | su - postgres -c psql; \
    manage.py dropdb
    manage.py syncdb
    manage.py loaddefault

    # Stop temporary PostgreSQL
    kill $(pgrep postgres)

    # BOOTSTRAPPED
    touch $BOOTSTRAP_DONE
fi

supervisord -n
