#!/bin/bash
set -ex

source "$(dirname "$0")/bootstrap-settings.sh"

make -j$(nproc) FBC="$bootstrap_package/bin/fbc -i $bootstrap_package/inc" </dev/null
mv bin/fbc bin/fbc1
make -j$(nproc) clean-compiler
make -j$(nproc) compiler FBC='bin/fbc1 -i inc' </dev/null
rm bin/fbc1

make cunit-tests </dev/null
make log-tests </dev/null
make warning-tests </dev/null
