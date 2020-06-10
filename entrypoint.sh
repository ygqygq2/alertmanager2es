#!/usr/bin/env bash
##############################################################
# File Name: entrypoint.sh
# Version: V1.0
# Author: Chinge_Yang
# Blog: http://blog.ygqygq2.51cto.com
# Created Time : 2020-06-10 09:20:07
# Description:
##############################################################

addr="${ADDR:-0.0.0.0:9097}"
esURL="${ESURL}:-http://localhost:9200"
esIndexName="${ES_INDEX_NAME}"
esIndexDateFormat="${ES_INDEX_DATE_FORMAT}"
esType="${ES_TYPE}"
PARAMETERS=(addr esURL esIndexName esIndexDateFormat esType)


function check_parameters() {
    option=""
    for p in ${PARAMETERS[@]}; do
        [ ! -z "$(eval echo \${$p})" ] && option="$option -${p}=$(eval echo \${$p})"
    done
}


check_parameters
/alertmanager2es $option
