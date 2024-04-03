#!/bin/bash

VERSION=0.0.1
#PROJECT_NAME=Hello_Debian_package
SCRIPTS_DIR=$(cd $(dirname $0); pwd)
TOP_DIR=${SCRIPTS_DIR}/..
BUILD_DIR=${TOP_DIR}/build
DEB_DIR=${BUILD_DIR}/deb
DEB_INSTALL_DIR=${DEB_DIR}/opt
gen_deb_script=${SCRIPTS_DIR}/gen_deb.sh

# get project name from path
# "/home/cory/CLionProjects/hello_world/scripts/.." ---> "hello_world"
get_project_name_from_path() {
  arr=(${TOP_DIR//// })
  len=${#arr[@]}
  result=${arr[$len-3]}
  echo $result
}

strip_exe() {
  PROJECT_NAME=$(get_project_name_from_path)
  exe_path=${BUILD_DIR}/${PROJECT_NAME}
  strip ${exe_path}
}

build_exe() {
  if [[ ! -d  ${BUILD_DIR} ]]; then
      mkdir -p ${BUILD_DIR}
  fi

  pushd ${BUILD_DIR}
  cmake .. && make -j
  popd
}

install_exe_into_deb() {
  PROJECT_NAME=$(get_project_name_from_path)
  exe_path=${BUILD_DIR}/${PROJECT_NAME}
  DEB_BIN_DIR=${DEB_INSTALL_DIR}/${PROJECT_NAME}/bin
  if [[ ! -d ${DEB_BIN_DIR} ]]; then
      mkdir -p ${DEB_BIN_DIR}
  fi
  if [[ -e ${exe_path} ]]; then
      install ${exe_path} ${DEB_BIN_DIR}
  fi
}

build_deb() {
  PROJECT_NAME=$(get_project_name_from_path)
  if [[ -e ${gen_deb_script} ]]; then
    bash ${gen_deb_script} ${PROJECT_NAME} ${VERSION} ${DEB_DIR}
  fi
}

build_exe
strip_exe
install_exe_into_deb
build_deb
