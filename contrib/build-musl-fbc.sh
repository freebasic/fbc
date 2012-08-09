#!/bin/sh
set -ex

BASEDIR=$PWD

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

  CC=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-gcc \
    CXX=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-g++ \
    AR=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-ar \
    CFLAGS="-O2 -D_GNU_SOURCE" \
    ../$NCURSES_NAME/configure \
        --without-cxx --without-cxx-binding \
        --without-ada --without-manpages \
        --without-progs --without-tests \
        --without-pkg-config --without-shared \
        --without-debug --without-profile \
        --without-libtool --with-termlib \
        --without-gpm --without-dlsym \
        --without-sysmouse \
        --enable-termcap \
        --without-develop \
        --enable-const \
        --host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
        --prefix=$BASEDIR/ncurses-prefix

  make
  cd ..
fi

# install
if [ ! -d ncurses-prefix ]; then
  cd ncurses-build
  make install
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
    CFLAGS="-O2" \
    ../$LIBFFI_NAME/configure \
        --disable-shared --enable-static \
        --host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
        --prefix=$BASEDIR/libffi-prefix

  make
  cd ..
fi

# install
if [ ! -d libffi-prefix ]; then
  cd libffi-build
  make install
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
    CFLAGS=-O2 \
    ../binutils-2.17/configure \
        --disable-shared --enable-static \
        --disable-nls --disable-werror \
        --build=i686-pc-linux-gnu --host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
        --prefix=$BASEDIR/binutils-2.17-prefix

  make
  cd ..
fi

# install
if [ ! -d binutils-2.17-prefix ]; then
  cd binutils-2.17-build
  make install
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
    CFLAGS=-O2 \
    ./configure \
        --disable-shared --enable-static \
        --build=i686-pc-linux-gnu --host=i486-pc-linux-gnu \
        --prefix=$BASEDIR/libcunit-prefix
  make
  cd ..
fi

# install
if [ ! -d libcunit-prefix ]; then
  cd $CUNIT_NAME
  make install
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
    CFLAGS=-O2 \
    ../$BINUTILS_NAME/configure \
        --disable-shared --enable-static \
        --disable-nls --disable-werror \
        --build=i686-pc-linux-gnu --host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
        --prefix=$BASEDIR/$BINUTILS_NAME-prefix

  make
  cd ..
fi

# install
if [ ! -d $BINUTILS_NAME-prefix ]; then
  cd $BINUTILS_NAME-build
  make install
  cd ..
fi

################################################################################
# Build a plain standalone fbc, with an rtlib built with the i486-linux-musl
# toolchain and the target libraries from the i486-linux-musl toolchain.
#
# The rtlib must be built with some -I options to let the i486-linux-musl-gcc
# find the headers from libs installed above, and everything that cannot easily
# be built against musl libc must be disabled.

if [ ! -d fbc-native ]; then
  git clone git://github.com/freebasic/fbc.git fbc-native
fi

cd fbc-native
make compiler DISABLE_OBJINFO=1 ENABLE_STANDALONE=1
make rtlib ENABLE_STANDALONE=1 \
  CC=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-gcc \
  AR=$BASEDIR/i486-linux-musl/bin/i486-linux-musl-ar \
  CFLAGS="-O2 -D_GNU_SOURCE \
          -I$BASEDIR/ncurses-prefix/include \
          -I$BASEDIR/ncurses-prefix/include/ncurses \
          -I$BASEDIR/libffi-prefix/lib/$LIBFFI_NAME/include \
          -DDISABLE_X11 -DDISABLE_GPM -DDISABLE_OPENGL \
          -DPTHREAD_MUTEX_RECURSIVE_NP=PTHREAD_MUTEX_RECURSIVE"
cd ..

# binutils
mkdir -p fbc-native/bin/linux
cp $BINUTILS_NAME-prefix/bin/as  fbc-static/bin/linux
cp $BINUTILS_NAME-prefix/bin/ar  fbc-static/bin/linux
cp $BINUTILS_NAME-prefix/bin/ld  fbc-static/bin/linux

# target libraries
cp i486-linux-musl/i486-linux-musl/lib/crt1.o                fbc-native/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/crti.o                fbc-native/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/crtn.o                fbc-native/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/libc.a                fbc-native/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/libdl.a               fbc-native/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/libm.a                fbc-native/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/libpthread.a          fbc-native/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/libsupc++.a           fbc-native/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.1/crtbegin.o  fbc-native/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.1/crtend.o    fbc-native/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.1/libgcc.a    fbc-native/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.1/libgcc_eh.a fbc-native/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.1/libgcov.a   fbc-native/lib/linux
cp ncurses-prefix/lib/libncurses.a                           fbc-native/lib/linux
cp ncurses-prefix/lib/libtinfo.a                             fbc-native/lib/linux
cp libffi-prefix/lib/libffi.a                                fbc-native/lib/linux
cp binutils-2.17-prefix/lib/libbfd.a                         fbc-native/lib/linux
cp binutils-2.17-prefix/lib/libiberty.a                      fbc-native/lib/linux
cp libcunit-prefix/lib/libcunit.a                            fbc-native/lib/linux

################################################################################
# Build another standalone fbc, using the fbc-native setup from above. This fbc
# and will itself be linked against against musl libc.

if [ ! -d fbc-static ]; then
  git clone git://github.com/freebasic/fbc.git fbc-static
fi

cd fbc-static
make compiler ENABLE_STANDALONE=1 ENABLE_FBBFD=217 \
  FBC=$BASEDIR/fbc-native/fbc-new FBLFLAGS="-static -l tinfo"
cd ..

# copy over the rtlib and other target libs
mkdir -p fbc-static/lib/linux
cp fbc-native/lib/linux/fbextra.x    fbc-static/lib/linux
cp fbc-native/lib/linux/fbrt0.o      fbc-static/lib/linux
cp fbc-native/lib/linux/libfb.a      fbc-static/lib/linux
cp fbc-native/lib/linux/libfbmt.a    fbc-static/lib/linux
cp fbc-native/lib/linux/crt1.o       fbc-static/lib/linux
cp fbc-native/lib/linux/crti.o       fbc-static/lib/linux
cp fbc-native/lib/linux/crtn.o       fbc-static/lib/linux
cp fbc-native/lib/linux/libc.a       fbc-static/lib/linux
cp fbc-native/lib/linux/libdl.a      fbc-static/lib/linux
cp fbc-native/lib/linux/libm.a       fbc-static/lib/linux
cp fbc-native/lib/linux/libpthread.a fbc-static/lib/linux
cp fbc-native/lib/linux/libsupc++.a  fbc-static/lib/linux
cp fbc-native/lib/linux/crtbegin.o   fbc-static/lib/linux
cp fbc-native/lib/linux/crtend.o     fbc-static/lib/linux
cp fbc-native/lib/linux/libgcc.a     fbc-static/lib/linux
cp fbc-native/lib/linux/libgcc_eh.a  fbc-static/lib/linux
cp fbc-native/lib/linux/libgcov.a    fbc-static/lib/linux
cp fbc-native/lib/linux/libncurses.a fbc-static/lib/linux
cp fbc-native/lib/linux/libtinfo.a   fbc-static/lib/linux
cp fbc-native/lib/linux/libffi.a     fbc-static/lib/linux
cp fbc-native/lib/linux/libbfd.a     fbc-static/lib/linux
cp fbc-native/lib/linux/libiberty.a  fbc-static/lib/linux
cp fbc-native/lib/linux/libcunit.a   fbc-static/lib/linux

# copy in the static binutils
mkdir -p fbc-static/bin/linux
cp fbc-native/bin/linux/as  fbc-static/bin/linux
cp fbc-native/bin/linux/ar  fbc-static/bin/linux
cp fbc-native/bin/linux/ld  fbc-static/bin/linux

################################################################################
# package

#cd libfb-linux-musl
#tar zcf ../libfb-linux-musl.tar.gz *
#cd ..
