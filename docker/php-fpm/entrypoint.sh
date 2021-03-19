#!/usr/bin/env bash

set -e

if [ "$WAIT_FOR" != "" ]
then
    wait-for-tcp-server "$WAIT_FOR" 120
fi

if [ "$RUN_MIGRATIONS" = "1" ]
then
    bin/console doctrine:database:create \
        --connection=chat \
        --if-not-exists
    bin/console doctrine:database:create \
        --connection=connect_four \
        --if-not-exists
    bin/console doctrine:database:create \
        --connection=identity \
        --if-not-exists
    bin/console doctrine:migrations:migrate \
        --configuration=config/chat/migrations.yml \
        --conn=chat \
        --allow-no-migration \
        --no-interaction
    bin/console doctrine:migrations:migrate \
        --configuration=config/connect-four/migrations.yml \
        --conn=connect_four \
        --allow-no-migration \
        --no-interaction
    bin/console doctrine:migrations:migrate \
        --configuration=config/identity/migrations.yml \
        --conn=identity \
        --allow-no-migration \
        --no-interaction
fi

exec "$@"
