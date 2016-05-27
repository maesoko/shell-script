#!/bin/sh
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

if [ $# -le 1 ] || [ $# -ge 4 ]; then
  usage
fi

if [ $# -eq 2 ]; then
  DB_USER_NAME=$1
  DB_PASSWORD=$2
fi

if [ $# -eq 3 ]; then
  DB_USER_NAME=$1
  DB_PASSWORD=$2
  DB_NAME=$3
fi

mysqlshow -u ${DB_USER_NAME} -p${DB_PASSWORD} ${DB_NAME}
