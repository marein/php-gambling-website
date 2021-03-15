#!/usr/bin/env bash

if [ "$WAIT_FOR" != "" ]
then
    wait-for-tcp-server "$WAIT_FOR" 120
fi

bin/console doctrine:database:create --connection=chat --if-not-exists >/dev/null 2>/dev/null
bin/console doctrine:database:create --connection=connect_four --if-not-exists >/dev/null 2>/dev/null
bin/console doctrine:database:create --connection=identity --if-not-exists >/dev/null 2>/dev/null
bin/console doctrine:migrations:migrate --configuration=config/chat/migrations.yml --conn=chat --no-interaction >/dev/null 2>/dev/null
bin/console doctrine:migrations:migrate --configuration=config/connect-four/migrations.yml --conn=connect_four --no-interaction >/dev/null 2>/dev/null
bin/console doctrine:migrations:migrate --configuration=config/identity/migrations.yml --conn=identity --no-interaction >/dev/null 2>/dev/null

exec "$@"
