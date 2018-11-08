#!/usr/bin/env bash
# counts total rows inserted by sql statement
# psql -tAX ohdsi -f /tmp/webapi_link.sql | count_rows.sh
sum=0;
while read -a line ; do
    cmd=${line[0]}
    oid=${line[1]}
    rows=${line[2]}
    sum=`expr $sum + $rows`
done
echo $sum
