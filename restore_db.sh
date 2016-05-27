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
fi

