#!/bin/sh

PS=`ps -ef |grep rails | grep -v grep |grep -v stop_rails.sh|awk '{print $2}'`
echo ${PS}
kill -9 ${PS}
