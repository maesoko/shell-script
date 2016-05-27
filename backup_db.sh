#!/bin/sh
#VARIABLE
DB_USER_NAME=
DB_PASSWORD=
DB_NAME=

function usage() {
cat <<_EOT_
Usage:
  $0 DBユーザ名 DBパスワード [データベース名]

Description:
  MySQLのバックアップを行う

_EOT_
 exit 1
}

function fullBackup() {
  for database in `mysqlshow -u ${DB_USER_NAME} | awk 'NR > 3 {print $2}'`; do
    mkdir -p db/${database}/
    chmod 777 db/${database}/
    backupDatabase ${database}
  done
}

function backupDatabase() {
  for table in `mysqlshow -u ${DB_USER_NAME} $1 | awk 'NR > 3 {print $2}'`; do
    mysqldump -u ${DB_USER_NAME} --tab=`pwd`/db/$1/ --fields-terminated-by=, --fields-optionally-enclosed-by=\" --lines-terminated-by="\r\n" $1 ${table}
  done
}

#argument check
if [ $# -le 1 ] || [ $# -ge 4 ]; then
  usage
fi

if [ $# -eq 2 ]; then
  DB_USER_NAME=$1
  DB_PASSWORD=$2
  export MYSQL_PWD=$2
  fullBackup
fi

if [ $# -eq 3 ]; then
  DB_USER_NAME=$1
  DB_PASSWORD=$2
  DB_NAME=$3
  export MYSQL_PWD=$2
  mkdir -p db/${DB_NAME}/
  chmod 777 db/${DB_NAME}/
  backupDatabase $DB_NAME
fi

mkdir -p etc/
cp /usr/local/mysql/etc/my.cnf etc/my.cnf

find ./db -type f -name "*.txt" -print0 | while read -r -d '' file; do mv "$file" "${file%%.txt}.csv"; done

