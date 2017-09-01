#!/bin/bash
set -ex

source "$(dirname "$0")/bootstrap-settings.sh"

wget -O $bootstrap_package.tar.xz \
  https://github.com/freebasic/fbc/releases/download/$bootstrap_version/$bootstrap_package.tar.xz
tar xf $bootstrap_package.tar.xz

cd $bootstrap_package
make -j$(nproc) bootstrap
cd ..
