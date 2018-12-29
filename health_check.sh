#!/bin/sh
if [ $(ps -ef | grep -v grep | grep main | wc -l) -eq 1 ]; then
  exit 0
else
  exit 1
fi
