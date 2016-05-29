#!/bin/bash

usage() {
  cat <<_EOT_
Usage:
  $0 横幅x縦幅 フォルダのパス
Description:
  指定されたフォルダ以下にあるすべての画像を任意のサイズにリサイズする
_EOT_
  exit 1
}

#ARGUMENT CHECK
if [ ! $# -eq 2 ]; then
  usage
fi

#VARIABLE
SIZE=$1
DIR=$2

#RESIZE
for FILE in `ls $DIR/*.{jpg,png,gif}`; do
  convert $FILE -resize ${SIZE}! $DIR/thumb.`basename $FILE`
done
