#!/bin/bash

PROJECT_NAME=$1
VERSION=$2
DEB_DIR=$3
DEB_CONTROL_PATH=${DEB_DIR}/DEBIAN/control

gen_deb_control_info() {
  deb_control_dir=$(dirname ${DEB_CONTROL_PATH})
  deb_project_name=$(gen_deb_project_name)
  if [[ ! -d ${deb_control_dir} ]]; then
      mkdir -p ${deb_control_dir}
  fi
  tee ${DEB_CONTROL_PATH} << EOT
Package: ${deb_project_name}
Version: ${VERSION}
Section: base
Priority: optional
Architecture: amd64
Maintainer: cory <corkang913@gmail.com>
Description: Hello World
EOT
}

convert_to_lower_characters() {
  str=$1
  lower_str=$(echo "${str}" | tr '[:upper:]' '[:lower:]')
  echo "${lower_str}"
}

gen_deb_project_name() {
  deb_project_name=${PROJECT_NAME//_/-}
  deb_project_name=$(convert_to_lower_characters ${deb_project_name})
  echo "${deb_project_name}"
}

gen_deb_package() {
  deb_filename=${PROJECT_NAME}_${VERSION}.deb
  gen_deb_tool=$(which dpkg-deb)
  if [[ -x ${gen_deb_tool} ]]; then
    ${gen_deb_tool} --build ${DEB_DIR} ${DEB_DIR}/${deb_filename}
  else
    echo "dpkg-deb not exist! please run on Debian-like system!"
    exit 1
  fi
}

gen_deb_control_info
gen_deb_package
