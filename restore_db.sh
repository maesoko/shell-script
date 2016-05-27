#!/bin/sh

#VARIABLE
DB_USER_NAME=
DB_PASSWORD=
BACKUP_FILE=

function usage() {
  cat <<_EOT_
Usage:
  $0 DBユーザ名 DBパスワード バックアップファイル

Description:
  MySQLの復元を行う

_EOT_
  exit 1
}

#argument check
if [ ! $# -eq 3 ]; then
  usage
else
  DB_USER_NAME=$1
  DB_PASSWORD=$2
  export MYSQL_PWD=$2
  BACKUP_FILE=$3

  tar zxvf $BACKUP_FILE
  for DB in `ls db`; do
    if [[ $DB =~ .*_schema ]] || [ $DB == "sys" ] || [ $DB == "mysql" ]; then
      continue
    fi
    echo $DB
    mysql -u $DB_USER_NAME -e "CREATE DATABASE IF NOT EXISTS $DB"
    for FILE in `ls db/$DB/*.sql`; do
      TABLE=`basename $FILE | sed -e "s/.sql$//g"`
      mysql -u $DB_USER_NAME $DB < $FILE
      mysql -u $DB_USER_NAME $DB -e "LOAD DATA LOCAL INFILE 'db/$DB/$TABLE.csv' INTO TABLE $TABLE FIELDS TERMINATED BY ',' ENCLOSED BY '\"'"
    done
  done
fi


