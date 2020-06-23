#!/bin/bash

# Funcion de cambio de Nº version a Nº integro
versionToInt() {
  local IFS=.
  parts=($1)
  let val=1000000*parts[0]+1000*parts[1]+parts[2]
  echo $val
}

# Instalador debootstrap
DEBOOTSTRAP_ACT="$(debootstrap --version| sed 's/ubuntu*.*//')"
DEBOOTSTRAP_VER=$(versionToInt ${DEBOOTSTRAP_ACT##*[!0-9.]})
DEBOOTSTRAP_REQ=$(versionToInt 1.0.124)

if [ ${DEBOOTSTRAP_VER} \< ${DEBOOTSTRAP_REQ} ] ; then
DEBOOTSTRAP_URL="${RAWGIT}/debootstrap/master/debootstrap_1.0.124_all.deb"
TEMP_DEB="$(mktemp)"
wget -O "${TEMP_DEB}" "${DEBOOTSTRAP_URL}"
dpkg -i "${TEMP_DEB}"
rm -f "${TEMP_DEB}"
fi
