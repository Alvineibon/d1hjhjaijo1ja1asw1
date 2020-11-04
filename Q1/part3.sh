#!/bin/bash
zcat access.log | awk '{print $1}' |sort -n | uniq -c | sort -nr |while read COUNT IP; do echo $COUNT $(geoiplookup $IP | cut -c 24- ); done > countrylist
awk '{a[$2] += $1} END{for (i in a) print a[i], i}' < countrylist | sort -nr |head -1|sed 's/.$//'
rm countrylist