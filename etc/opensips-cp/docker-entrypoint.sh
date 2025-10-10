#!/bin/bash

echo "Checking for directory /docker-entrypoint.d"

if [ -d "/docker-entrypoint.d" ]; then
    echo "Running scripts in /docker-entrypoint.d"
    run-parts --regex '\.sh$' /docker-entrypoint.d
fi

cron &

# ensure pidfile does not exist, otherwise apache won't start
rm -f /var/run/apache2/apache2.pid
exec apachectl -D FOREGROUND
