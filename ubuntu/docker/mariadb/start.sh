#!/bin/bash
source /config.sh

# Get the server key & crt, and the ca crt & crl
(has /config/my.key) || curl "$CA_SERVER/my.key" > /config/my.key
(has /config/my.crt) || curl "$CA_SERVER/my.crt" > /config/my.crt
(has /config/ca.crt) || curl "$CA_SERVER/ca.crt" > /config/ca.crt
(has /config/ca.crl) || curl "$CA_SERVER/ca.crl.pem" > /config/ca.crl

# Default user and password if none provided
[[ "$DB_USER" == "" ]] && DB_USER="user"
[[ "$DB_PASS" == "" ]] && DB_PASS="pass"

# Where database data is stored
DATA_DIR="/config/mysql"

# Test if DATA_DIR has content
if [[ ! "$(ls -A $DATA_DIR)" ]]; then
  cp -R /var/lib/mysql/* $DATA_DIR
fi

# Ensure mysql owns the DATA_DIR
chown -R mysql $DATA_DIR
chown root $DATA_DIR/debian*.flag

# Cleanup previous sockets
rm -f /run/mysqld/mysqld.sock

# Start MariaDB
/usr/sbin/service mysql start
# mysqld --ssl-ca=/config/ca.crt --ssl-cert=/config/mariadb.crt --ssl-key=/config/mariadb.key --ssl-crl=/config/ca.crl

# The password for 'debian-sys-maint'@'localhost' is auto generated
DB_MAINT_PASS=$(cat /etc/mysql/debian.cnf | grep -m 1 "password\s*=\s*"| sed 's/^password\s*=\s*//')
mysql -u root -e \
    "GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '$DB_MAINT_PASS';"

# Create the superuser
mysql -u root <<-EOF
    DELETE FROM mysql.user WHERE user = '$DB_USER';
    FLUSH PRIVILEGES;

    CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';
    GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'localhost' WITH GRANT OPTION;
    # GRANT USAGE ON *.* TO '$DB_USER'@'localhost' REQUIRE SSL;

    CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
    GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;
    # GRANT USAGE ON *.* TO '$DB_USER'@'%' REQUIRE SSL;
EOF

# Tail the logs and keep the container alive
tail -F /var/log/mysql.log
