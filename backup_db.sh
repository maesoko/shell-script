#!/bin/sh

function usage() {
cat <<_EOT_
Usage:
  $0 

Description:
  hogehogehoge

_EOT_
 exit 1
}

if [ $# -le 1] || [ $# -ge 4 ]; then
  usage
fi

if [ $# -eq 2 ]; then
  echo fuga $#
fi

if [ $# -eq 3 ]; then
  echo hoge $#
fi
