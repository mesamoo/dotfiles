#!/bin/sh
#wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
wget -q -O - checkip.dyndns.org | sed -e 's/[^[:digit:]\|.]//g'