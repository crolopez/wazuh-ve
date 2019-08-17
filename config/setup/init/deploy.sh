#!/bin/bash

SOURCES_LOCATION=$1
BRANCH=$2
THREADS=$3
INSTALL_TYPE=$4
OS_TYPE=$5

. f_deps && install_deps $OS_TYPE && \
. f_repo && fetch_repo $SOURCES_LOCATION $BRANCH && \
. f_compile && compile_repo $SOURCES_LOCATION $THREADS $INSTALL_TYPE
