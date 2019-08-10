#!/bin/sh -e

LIST=$(dpkg --list | grep -E 'dotdeb|\.adition' | awk '{ print $2"="$3 }')
LENGTH=$(echo "${LIST}" | wc -l)
COUNT=0
FILE=role/php/templates/php-pins
cat /dev/null > "${FILE}"

for ELEMENT in ${LIST}; do
    PACKAGE="${ELEMENT%=*}"
    VERSION="${ELEMENT#*=}"

    {
        echo "Package: ${PACKAGE}"
        echo "Pin: version ${VERSION}"
        echo "Pin-Priority: 1000"
    } >> "${FILE}"

    COUNT=$((COUNT + 1))

    if [ ! "${COUNT}" = "${LENGTH}" ]; then
        echo "" >> "${FILE}"
    fi
done
