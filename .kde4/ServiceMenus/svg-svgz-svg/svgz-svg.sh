#!/bin/sh
# Decompresses svg-file with gzip. (Converts svgz to svg)
# Author: Niko Rentola		niko.rento@gmail.com
# License: GPL		http://www.gnu.org/copyleft/gpl.html
#
gzip -S gz -d "$1" -c >"${1%.svgz}.svg"
rm "$1"
exit 0