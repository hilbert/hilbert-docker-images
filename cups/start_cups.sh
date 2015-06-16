#!/bin/sh
set -e
set -x

if [ $(grep -ci $CUPS_USER_ADMIN /etc/shadow) -eq 0 ]; then
    pass=$(mkpasswd $CUPS_USER_PASSWORD)
    echo "CupsUserPassword: $CUPS_USER_PASSWORD"
    echo "Password: $pass"
    useradd $CUPS_USER_ADMIN --system -G root,lpadmin --no-create-home --password "$pass"
fi

exec /usr/sbin/cupsd -f
