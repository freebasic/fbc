#!/bin/sh
set -ex

prefix="$PWD"
mkdir -p src

################################################################################
# Build an i486-linux-musl cross compiler toolchain with the help of the
# musl-cross scripts.

toolchainbackup="i486-linux-musl-gcc.tar.bz2"
if [ -f "$toolchainbackup" ]; then
	if [ ! -d i486-linux-musl ]; then
		tar -xf "$toolchainbackup"
	fi
else
	export CFLAGS="-O2"

	if [ ! -d musl-cross ]; then
		hg clone https://bitbucket.org/GregorR/musl-cross
	fi

	if [ ! -d i486-linux-musl ]; then
		cd musl-cross
		echo "ARCH=i486" > config.sh
		echo "CC_BASE_PREFIX=$prefix" >> config.sh
		echo "MUSL_CONFFLAGS=\"--disable-debug --disable-shared --enable-static\"" >> config.sh
		echo "GCC_BUILTIN_PREREQS=yes" >> config.sh
		echo "GCC_CONFFLAGS='--disable-shared'" >> config.sh

		#echo "MUSL_VERSION=master" >> config.sh
		#echo "MUSL_GIT=yes" >> config.sh

		./build.sh
		cd ..

		# Since rebuilding the toolchain takes so long, create a backup,
		# so the tree can easily be restored to its original state,
		# after installing tons of other stuff into it...
		tar -cf "$toolchainbackup" i486-linux-musl
	fi
fi

################################################################################
# Build various libs used by FB rtlib/gfxlib2 (i.e. needed for FB programs),
# including headers needed just to compile the FB rtlib/gfxlib2

export CFLAGS="-Wl,-Bstatic -O2 -D_GNU_SOURCE"
export  CC="$prefix/i486-linux-musl/bin/i486-linux-musl-gcc -static-libgcc"
export CXX=$prefix/i486-linux-musl/bin/i486-linux-musl-g++
export  AR=$prefix/i486-linux-musl/bin/i486-linux-musl-ar

build()
{
	name="$1"
	tarball="$2"
	url="$3"
	build=$name-build

	# download
	if [ ! -f src/$tarball ]; then
		wget $url -O src/$tarball
	fi

	# unpack & build, same directory (separate build directory doesn't
	# work for all)
	if [ ! -d $name ]; then
		tar -xf src/$tarball
		test ! -f $name/build-done
	fi

	if [ ! -f $name/build-done ]; then
		cd $name

		case $name in
		pkg-config*)
			# Build pkg-config for cross-compilation
			./configure \
				--libdir=$prefix/i486-linux-musl/i486-linux-musl/lib \
				--program-prefix=i486-linux-musl- \
				--prefix=$prefix/i486-linux-musl \
				--with-internal-glib --disable-host-tool
			make
			make install
			;;

		util-macros*|*proto*|xtrans*)
			./configure \
				--host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl
			make
			make install
			;;

		ncurses*)
			# We must use --prefix=/usr so it's correct at runtime,
			# because ncurses will hard-code the path into the lib...
			./configure \
				--without-debug --without-profile \
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
				--host=i486-pc-linux-gnu \
				--prefix=/usr
			make
			# but we want to install it into
			#    $prefix/i486-linux-musl/i486-linux-musl
			# and not
			#    $prefix/i486-linux-musl/i486-linux-musl/usr
			# so DESTDIR can't be used either...
			make install prefix=$prefix/i486-linux-musl/i486-linux-musl
			;;

		gpm*)
			# gpm header for rtlib build
			cp src/headers/gpm.h $prefix/i486-linux-musl/i486-linux-musl/include
			;;

		Mesa*)
			# GL headers needed for gfxlib2 build
			mkdir -p $prefix/i486-linux-musl/i486-linux-musl/include/GL
			cp	include/GL/gl.h \
				include/GL/gl_mangle.h \
				include/GL/glext.h \
				include/GL/glx.h \
				include/GL/glx_mangle.h \
				include/GL/glxext.h \
				$prefix/i486-linux-musl/i486-linux-musl/include/GL
			;;

		glu*)
			# glu, ditto
			mkdir -p $prefix/i486-linux-musl/i486-linux-musl/include/GL
			cp	include/GL/glu.h \
				include/GL/glu_mangle.h \
				$prefix/i486-linux-musl/i486-linux-musl/include/GL
			;;

		e2fsprogs*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--disable-nls
			make
			make install
			;;

		*)
			./configure \
				--disable-shared --enable-static \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl
			make
			make install
			;;
		esac

		touch build-done
		cd ..
	fi
}

# pkg-config, needed for the libX11 etc. builds
# (by using a pkg-config separate from any pre-existing one on the build system,
# we can be sure to not accidentally pull in any packages from the build system)
build pkg-config-0.28  pkg-config-0.28.tar.gz   http://pkgconfig.freedesktop.org/releases/pkg-config-0.28.tar.gz

export PKG_CONFIG_PATH=$prefix/i486-linux-musl/i486-linux-musl/lib/pkgconfig:$prefix/i486-linux-musl/i486-linux-musl/share/pkgconfig
export PKG_CONFIG=$prefix/i486-linux-musl/bin/i486-linux-musl-pkg-config
export PKGCONFIG=$PKG_CONFIG

#build gettext-0.18.2        gettext-0.18.2.tar.gz        http://ftp.gnu.org/pub/gnu/gettext/gettext-0.18.2.tar.gz
#build libiconv-1.14         libiconv-1.14.tar.gz         http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
build e2fsprogs-1.42.7      e2fsprogs-1.42.7.tar.gz      http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.42.7.tar.gz

# X protocol headers and libs needed for the libX11 etc. builds
build util-macros-1.17      util-macros-1.17.tar.bz2     http://ftp.x.org/pub/individual/util/util-macros-1.17.tar.bz2
build xproto-7.0.23         xproto-7.0.23.tar.bz2        http://ftp.x.org/pub/individual/proto/xproto-7.0.23.tar.bz2
build xextproto-7.2.1       xextproto-7.2.1.tar.bz2      http://ftp.x.org/pub/individual/proto/xextproto-7.2.1.tar.bz2
build renderproto-0.11.1    renderproto-0.11.1.tar.bz2   http://ftp.x.org/pub/individual/proto/renderproto-0.11.1.tar.bz2
build randrproto-1.4.0      randrproto-1.4.0.tar.bz2     http://ftp.x.org/pub/individual/proto/randrproto-1.4.0.tar.bz2
build kbproto-1.0.6         kbproto-1.0.6.tar.bz2        http://ftp.x.org/pub/individual/proto/kbproto-1.0.6.tar.bz2
build inputproto-2.3        inputproto-2.3.tar.bz2       http://ftp.x.org/pub/individual/proto/inputproto-2.3.tar.bz2
build xtrans-1.2.7          xtrans-1.2.7.tar.bz2         http://ftp.x.org/pub/individual/lib/xtrans-1.2.7.tar.bz2
build xcb-proto-1.8         xcb-proto-1.8.tar.bz2        http://xcb.freedesktop.org/dist/xcb-proto-1.8.tar.bz2

# X11 libs, headers needed to build the rtlib, libs for FB programs
# (more or less in order of dependencies)
build libICE-1.0.8     libICE-1.0.8.tar.bz2     http://ftp.x.org/pub/individual/lib/libICE-1.0.8.tar.bz2
build libSM-1.2.1      libSM-1.2.1.tar.bz2      http://ftp.x.org/pub/individual/lib/libSM-1.2.1.tar.bz2
build libXau-1.0.7     libXau-1.0.7.tar.bz2     http://ftp.x.org/pub/individual/lib/libXau-1.0.7.tar.bz2
build libpthread-stubs-0.3  libpthread-stubs-0.3.tar.bz2  http://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.bz2
build libxcb-1.9       libxcb-1.9.tar.bz2       http://xcb.freedesktop.org/dist/libxcb-1.9.tar.bz2
build libX11-1.5.0     libX11-1.5.0.tar.bz2     http://ftp.x.org/pub/individual/lib/libX11-1.5.0.tar.bz2
build libXt-1.1.3      libXt-1.1.3.tar.bz2      http://ftp.x.org/pub/individual/lib/libXt-1.1.3.tar.bz2
build libXext-1.3.1    libXext-1.3.1.tar.bz2    http://ftp.x.org/pub/individual/lib/libXext-1.3.1.tar.bz2
build libXpm-3.5.10    libXpm-3.5.10.tar.bz2    http://ftp.x.org/pub/individual/lib/libXpm-3.5.10.tar.bz2
build libXrender-0.9.7 libXrender-0.9.7.tar.bz2 http://ftp.x.org/pub/individual/lib/libXrender-0.9.7.tar.bz2
build libXrandr-1.3.2  libXrandr-1.3.2.tar.bz2  http://ftp.x.org/pub/individual/lib/libXrandr-1.3.2.tar.bz2

build Mesa-9.1         MesaLib-9.1.tar.bz2      ftp://ftp.freedesktop.org/pub/mesa/9.1/MesaLib-9.1.tar.bz2
build glu-9.0.0        glu-9.0.0.tar.bz2        ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.0.tar.bz2

# libncurses/libtinfo, ditto
build ncurses-5.9      ncurses-5.9.tar.gz       http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz

# libffi, ditto
build libffi-3.0.12    libffi-3.0.12.tar.gz     ftp://sourceware.org/pub/libffi/libffi-3.0.12.tar.gz

# gpm, headers needed to build the rtlib
build gpm-1.20.7       gpm-1.20.7.tar.bz2       http://www.nico.schottelius.org/software/gpm/archives/gpm-1.20.7.tar.bz2

# libcunit for the FB test suite
build CUnit-2.1-2      CUnit-2.1-2-src.tar.bz2  http://downloads.sourceforge.net/cunit/CUnit-2.1-2-src.tar.bz2?download


################################################################################
# 1. Build an FB setup for native -> musl cross compilation, i.e. a native fbc
#    plus the libraries for cross-compilation to i486-linux-musl, all installed
#    into the $prefix/i486-linux-musl tree
#
# The most important part are the rtlib and gfxlib2 binaries, but the compiler
# itself aswell; building it ensures that we get a native fbc whose ABI matches
# the rtlib/gfxlib2 binaries, so we don't need to make assumptions about the
# host fbc. (though as long as the version matches, the rtlib/gfxlib2 binaries
# can be copied into any FB setup)

fbname=FreeBASIC-`date +%Y.%m.%d`-source
fbtarball=$fbname.tar.gz

# unpack
if [ ! -d musl-fbc ]; then
	tar -xf src/$fbtarball
	mv $fbname musl-fbc
fi

cd musl-fbc
echo "ENABLE_STANDALONE := 1" >  config.mk
echo "CC := $CC"              >> config.mk
echo "AR := $AR"              >> config.mk
echo "CFLAGS := -O2 -D_GNU_SOURCE" >> config.mk
echo "CFLAGS += `$PKG_CONFIG --cflags libffi`" >> config.mk
echo "CFLAGS += -DPTHREAD_MUTEX_RECURSIVE_NP=PTHREAD_MUTEX_RECURSIVE" >> config.mk
make
cd ..

# Copy in the libraries
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.2/*.o  musl-fbc/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.2/*.a  musl-fbc/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/*.o            musl-fbc/lib/linux
cp i486-linux-musl/i486-linux-musl/lib/*.a            musl-fbc/lib/linux

################################################################################
# 2. "Cross-compile" a standalone FB setup using the 1st one, to get a static
#    fbc binary; the i486-linux-musl libs can just be copied over

# unpack
if [ ! -d fbc-static ]; then
	tar -xf src/$fbtarball
	mv $fbname fbc-static
fi

cd fbc-static
echo "ENABLE_STANDALONE := 1" > config.mk
echo "FBC := $prefix/musl-fbc/fbc-new -static -l tinfo"
make compiler
cd ..

# Copy over the libraries
mkdir -p fbc-static/lib/linux
cp musl-fbc/lib/linux/* fbc-static/lib/linux

################################################################################
# Build a set of binutils, statically linked against musl libc, using the
# i486-linux-musl toolchain, for the static standalone FB setup

binutilsname=binutils-2.23.1
binutilstarball=$binutilsname.tar.bz2

# download
if [ ! -f src/$binutilstarball ]; then
	wget http://ftp.gnu.org/gnu/binutils/$binutilstarball -O src/$binutilstarball
fi

# unpack
if [ ! -d $binutilsname ]; then
	tar -xf src/$binutilstarball
fi

# build
if [ ! -d $binutilsname-build ]; then
	mkdir $binutilsname-build
	cd $binutilsname-build

	../$binutilsname/configure \
		--disable-shared --enable-static \
		--disable-nls --disable-werror \
		--host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
		--prefix=/usr

	make
	cd ..
fi

# Copy in the binutils
mkdir -p fbc-static/bin/linux
cp $binutilsname-build/gas/as-new   fbc-static/bin/linux/as
cp $binutilsname-build/binutils/ar  fbc-static/bin/linux/ar
cp $binutilsname-build/ld/ld-new    fbc-static/bin/linux/ld

################################################################################
