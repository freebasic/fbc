#!/bin/bash
#
# This script roughly does the following:
#  * Download DJGPP packages needed to build FB, extracted at DJGPP/
#  * Download an existing FB-dos package for bootstrapping
#  * Download fbc sources from Git, extract 2 copies (normal and standalone)
#      DJGPP/fbc/
#      DJGPP/fbcsa/
#  * Bootstrap the normal fbc, then rebuild the normal fbc with itself, then
#    build the standalone fbc
#  * Copy binutils/libs/etc. from DJGPP into the standalone fbc
#  * Create FB release packages
#
set -e

mkdir -p input/DJGPP

# FB for bootstrapping
./download.sh input/FreeBASIC-1.00.0-dos.zip "https://downloads.sourceforge.net/fbc/FreeBASIC-1.00.0-dos.zip?download"

# FB to build
./download.sh input/fbc-master.zip "https://github.com/freebasic/fbc/archive/master.zip"

DJGPP_MIRROR="ftp://ftp.fu-berlin.de/pc/languages/djgpp/"

function download_djgpp() {
	dir="$1"
	package="$2"
	./download.sh "input/DJGPP/${package}.zip" "${DJGPP_MIRROR}${dir}${package}.zip"
}

# binutils/gcc/gdb (needs updating to new versions)
download_djgpp beta/v2gnu/ bnu225b
download_djgpp beta/v2gnu/ gcc492b
download_djgpp beta/v2gnu/ gpp492b
download_djgpp beta/v2gnu/ gdb771b

# rest to complete the DJGPP install (usually no changes needed)
download_djgpp beta/v2/ djdev204
download_djgpp beta/v2gnu/ fil41b
download_djgpp beta/v2gnu/ mak40b
download_djgpp beta/v2gnu/ shl2011b

# Sources for stuff that goes into the FB-dos package (needs updating to new versions)
download_djgpp current/v2gnu/ bnu225s
download_djgpp beta/v2gnu/ gcc492s
download_djgpp current/v2gnu/ gdb771s
download_djgpp beta/v2/ djlsr204

echo "preparing DJGPP dir"
rm -rf DJGPP
mkdir DJGPP
cd DJGPP
unzip -q ../input/FreeBASIC-1.00.0-dos.zip
unzip -q ../input/fbc-master.zip
mv fbc-master fbc
unzip -q ../input/fbc-master.zip
mv fbc-master fbcsa
unzip -q ../input/djdev204.zip
unzip -q ../input/shl2011b.zip
unzip -q ../input/fil41b.zip
unzip -q ../input/mak40b.zip
unzip -q ../input/gdb771b.zip
unzip -q ../input/bnu225b.zip
unzip -q ../input/gcc492b.zip
unzip -q ../input/gpp492b.zip

dospath=`pwd -W`

echo "prefix := $dospath" > fbc/config.mk
echo "ENABLE_STANDALONE := 1" > fbcsa/config.mk

cat <<EOF > open-djgpp.bat
set DJGPP=$dospath/djgpp.env
set PATH=$dospath/bin;%PATH%
cmd
EOF

cat <<EOF > build.bat
@echo off

set DJGPP=$dospath/djgpp.env
set PATH=$dospath/bin

echo build PATH = %PATH%
echo.

echo uname:
uname
if ERRORLEVEL 1 exit /b
echo.

echo make --version:
make --version
if ERRORLEVEL 1 exit /b
echo.

echo gcc --version:
gcc --version
if ERRORLEVEL 1 exit /b
echo.

echo gcc -print-file-name=libgcc.a:
gcc -print-file-name=libgcc.a
if ERRORLEVEL 1 exit /b
echo.

echo bootstrapping normal fbc:
cd fbc
make FBC=../FreeBASIC-1.00.0-dos/fbc.exe
if ERRORLEVEL 1 exit /b
make install
if ERRORLEVEL 1 exit /b
cd ..

echo rebuilding normal fbc:
cd fbc
make clean-compiler
if ERRORLEVEL 1 exit /b
make
if ERRORLEVEL 1 exit /b
make install
if ERRORLEVEL 1 exit /b
cd ..

echo building standalone fbc:
cd fbcsa
make
if ERRORLEVEL 1 exit /b
cd ..
EOF

cmd /c build.bat

mkdir -p fbcsa/bin/dos
cp bin/ar.exe bin/as.exe bin/gdb.exe bin/gprof.exe bin/ld.exe fbcsa/bin/dos/
cp lib/crt0.o lib/gcrt0.o lib/libdbg.a lib/libemu.a lib/libm.a fbcsa/lib/dos/
cp lib/libstdcxx.a fbcsa/lib/dos/libstdcx.a
cp lib/libsupcxx.a fbcsa/lib/dos/libsupcx.a
cp lib/gcc/djgpp/4.92/libgcc.a fbcsa/lib/dos/

echo "making bindists"
cd fbc
make bindist TARGET_OS=dos DISABLE_DOCS=1
cd ..
cd fbcsa
make bindist TARGET_OS=dos
cd ..

mkdir -p ../output
mv fbc/*.zip fbcsa/*.zip                  ../output
mv fbc/contrib/manifest/fbc-dos.lst       ../output
mv fbc/contrib/manifest/FreeBASIC-dos.lst ../output
