#!/bin/sh
set -ex

BASEDIR=$PWD
ENABLE_DEBUG=""

if [ "x" != "x$ENABLE_DEBUG" ]; then
  BASIC_CFLAGS="-g -O2"
else
  BASIC_CFLAGS="-O2"
fi

if [ "x" != "x$ENABLE_DEBUG" ]; then
  BASIC_FBFLAGS="-g -exx"
else
  BASIC_FBFLAGS=""
fi


################################################################################
# Build an i486-linux-musl cross compiler toolchain with the help of the
# musl-cross scripts.

if [ ! -d musl-cross ]; then
  hg clone https://bitbucket.org/GregorR/musl-cross
fi

if [ ! -d i486-linux-musl ]; then
  cd musl-cross
  echo "ARCH=i486" > config.sh
  echo "CC_BASE_PREFIX=$BASEDIR" >> config.sh
  if [ "x" != "x$ENABLE_DEBUG" ]; then
    echo "MUSL_CONFFLAGS=--enable-debug" >> config.sh
  fi

  echo "MUSL_VERSION=master" >> config.sh
  echo "MUSL_GIT=yes" >> config.sh

  ./build.sh
  cd ..
fi


################################################################################
# Build ncurses using the i486-linux-musl toolchain

NCURSES_VERSION=5.9
NCURSES_NAME=ncurses-$NCURSES_VERSION
NCURSES_PACKAGE=$NCURSES_NAME.tar.gz

# download
if [ ! -f $NCURSES_PACKAGE ]; then
  wget http://ftp.gnu.org/pub/gnu/ncurses/$NCURSES_PACKAGE -O $NCURSES_PACKAGE
fi

# unpack
if [ ! -d $NCURSES_NAME ]; then
  tar zxf $NCURSES_PACKAGE
fi

# build
if [ ! -d ncurses-build ]; then
  mkdir ncurses-build
  cd ncurses-build

  if [ "x" != "x$ENABLE_DEBUG" ]; then
    NCURSES_DEBUG_FLAGS=--with-debug
  else
    NCURSES_DEBUG_FLAGS=--without-debug
  fi

  CC=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-gcc \
    CXX=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-g++ \
    AR=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-ar \
    CFLAGS="$BASIC_CFLAGS -D_GNU_SOURCE" \
    ../$NCURSES_NAME/configure \
        $NCURSES_DEBUG_FLAGS --without-profile \
        --without-cxx --without-cxx-binding \
        --without-ada --without-manpages \
        --without-progs --without-tests \
        --without-pkg-config --without-shared \
        --without-libtool --with-termlib \
        --without-gpm --without-dlsym \
        --without-sysmouse \
        --enable-termcap \
        --without-develop \
        --enable-const \
        --host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
        --prefix=/usr

  make
  cd ..
fi


################################################################################
# Build libffi using the i486-linux-musl toolchain

LIBFFI_VERSION=3.0.11
LIBFFI_NAME=libffi-$LIBFFI_VERSION
LIBFFI_PACKAGE=$LIBFFI_NAME.tar.gz

# download
if [ ! -f $LIBFFI_PACKAGE ]; then
  wget ftp://sourceware.org/pub/libffi/$LIBFFI_PACKAGE -O $LIBFFI_PACKAGE
fi

# unpack
if [ ! -d $LIBFFI_NAME ]; then
  tar zxf $LIBFFI_PACKAGE
fi

# build
if [ ! -d libffi-build ]; then
  mkdir libffi-build
  cd libffi-build

  CC=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-gcc \
    AR=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-ar \
    CFLAGS="$BASIC_CFLAGS" \
    ../$LIBFFI_NAME/configure \
        --disable-shared --enable-static \
        --host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
        --prefix=/usr

  make
  cd ..
fi


################################################################################
# Build libbfd 2.17 using the i486-linux-musl toolchain

BINUTILS217_PACKAGE=binutils-2.17.tar.bz2

# download
if [ ! -f $BINUTILS217_PACKAGE ]; then
  wget http://ftp.gnu.org/gnu/binutils/$BINUTILS217_PACKAGE -O $BINUTILS217_PACKAGE
fi

# unpack
if [ ! -d binutils-2.17 ]; then
  tar jxf $BINUTILS217_PACKAGE
fi

# build
if [ ! -d binutils-2.17-build ]; then
  mkdir binutils-2.17-build
  cd binutils-2.17-build

  CC=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-gcc \
    AR=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-ar \
    CFLAGS="$BASIC_CFLAGS" \
    ../binutils-2.17/configure \
        --disable-shared --enable-static \
        --disable-nls --disable-werror \
        --build=i686-pc-linux-gnu --host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
        --prefix=/usr

  make
  cd ..
fi


################################################################################
# Build libcunit using the i486-linux-musl toolchain

CUNIT_NAME=CUnit-2.1-2
CUNIT_PACKAGE=$CUNIT_NAME-src.tar.bz2

# download
if [ ! -f $CUNIT_PACKAGE ]; then
  wget http://downloads.sourceforge.net/cunit/$CUNIT_PACKAGE?download -O $CUNIT_PACKAGE
fi

# unpack & build
if [ ! -d $CUNIT_NAME ]; then
  tar jxf $CUNIT_PACKAGE
  cd $CUNIT_NAME

  CC=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-gcc \
    AR=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-ar \
    CFLAGS="$BASIC_CFLAGS" \
    ./configure \
        --disable-shared --enable-static \
        --build=i686-pc-linux-gnu --host=i486-pc-linux-gnu \
        --prefix=/usr

  make
  cd ..
fi


################################################################################
# Build a set of binutils, statically linked against musl libc, using the
# i486-linux-musl toolchain

BINUTILS_VERSION=2.22
BINUTILS_NAME=binutils-$BINUTILS_VERSION
BINUTILS_PACKAGE=$BINUTILS_NAME.tar.bz2

# download
if [ ! -f $BINUTILS_PACKAGE ]; then
  wget http://ftp.gnu.org/gnu/binutils/$BINUTILS_PACKAGE -O $BINUTILS_PACKAGE
fi

# unpack
if [ ! -d $BINUTILS_NAME ]; then
  tar jxf $BINUTILS_PACKAGE
fi

# build
if [ ! -d $BINUTILS_NAME-build ]; then
  mkdir $BINUTILS_NAME-build
  cd $BINUTILS_NAME-build

  CC="$BASEDIR/i486-linux-musl/bin/i486-linux-musl-gcc -Wl,-Bstatic -static-libgcc" \
    AR=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-ar \
    CFLAGS="$BASIC_CFLAGS" \
    ../$BINUTILS_NAME/configure \
        --disable-shared --enable-static \
        --disable-nls --disable-werror \
        --build=i686-pc-linux-gnu --host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
        --prefix=/usr

  make
  cd ..
fi


################################################################################
# Build a plain standalone fbc, with an rtlib built with the i486-linux-musl
# toolchain and the target libraries from the i486-linux-musl toolchain.
#
# The rtlib must be built with some -I options to let the i486-linux-musl-gcc
# find the headers from libs installed above, and everything that cannot easily
# be built against musl libc must be disabled.

if [ ! -d fbc ]; then
  git clone git://github.com/freebasic/fbc.git fbc
fi

if [ "x" != "x$ENABLE_DEBUG" ]; then
  RTLIB_DEBUG_FLAGS="-DDEBUG"
else
  RTLIB_DEBUG_FLAGS=""
fi

cd fbc
make compiler FBFLAGS="$BASIC_FBFLAGS" DISABLE_OBJINFO=1 ENABLE_STANDALONE=1
make rtlib ENABLE_STANDALONE=1 \
  CC=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-gcc \
  AR=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-ar \
  CFLAGS="$BASIC_CFLAGS $RTLIB_DEBUG_FLAGS -D_GNU_SOURCE \
          -I$BASEDIR/ncurses-build/include \
          -I$BASEDIR/libffi-build/include \
          -DDISABLE_X11 -DDISABLE_GPM -DDISABLE_OPENGL \
          -DPTHREAD_MUTEX_RECURSIVE_NP=PTHREAD_MUTEX_RECURSIVE"
cd ..

# binutils
mkdir -p fbc/bin/linux
cp $BINUTILS_NAME-build/gas/as-new   fbc/bin/linux/as
cp $BINUTILS_NAME-build/binutils/ar  fbc/bin/linux/ar
cp $BINUTILS_NAME-build/ld/ld-new    fbc/bin/linux/ld

# target libraries
cp i486-linux-musl/i486-linux-musl/lib/crt1.o                fbc/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/crti.o                fbc/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/crtn.o                fbc/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/libc.a                fbc/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/libdl.a               fbc/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/libm.a                fbc/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/libpthread.a          fbc/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/libsupc++.a           fbc/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.1/crtbegin.o  fbc/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.1/crtend.o    fbc/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.1/libgcc.a    fbc/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.1/libgcc_eh.a fbc/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.1/libgcov.a   fbc/lib/linux
cp ncurses-build/lib/libncurses.a                            fbc/lib/linux
cp ncurses-build/lib/libtinfo.a                              fbc/lib/linux
cp libffi-build/.libs/libffi.a                               fbc/lib/linux
cp binutils-2.17-build/bfd/libbfd.a                          fbc/lib/linux
cp binutils-2.17-build/libiberty/libiberty.a                 fbc/lib/linux
cp $CUNIT_NAME/CUnit/Sources/.libs/libcunit.a                fbc/lib/linux

# done
$BASEDIR/fbc/fbc-new -static -l tinfo -version
