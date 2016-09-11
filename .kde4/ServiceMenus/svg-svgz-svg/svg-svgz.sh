#!/bin/sh
# Compresses svg-file with gzip. (Converts svg to svgz)
# Author: Niko Rentola		niko.rento@gmail.com
# License: 	GPL	http://www.gnu.org/copyleft/gpl.html
#
gzip "$1" -c >"${1%.svg}.svgz"
rm "$1"
exit 0