#!/bin/sh
set -ex

prefix="$PWD"
mkdir -p src

fetch()
{
	tarball="$1"
	url="$2"

	# download
	if [ ! -f src/$tarball ]; then
		wget $url -O src/$tarball
	fi
}

extract()
{
	name="$1"
	tarball="$2"

	# unpack
	if [ ! -d $name ]; then
		# Extract archive inside tmpextract/
		mkdir tmpextract
		cd tmpextract

		if [ -n "`echo $tarball | grep '\.zip$'`" ]; then
			unzip -q ../src/$tarball
		else
			tar -xf ../src/$tarball
		fi

		# If tmpextract/ now only has a single subdir, then the archive
		# included a toplevel dir already, we can just use that
		if [ "x`ls -1 | wc -l`" = "x1" ]; then
			dir=`echo *`
			if [ -d $dir ]; then
				if [ $dir != $name ]; then
					mv $dir $name
				fi
				mv $name ..
				cd ..
				rmdir tmpextract
			else
				dir=""
			fi
		else
			dir=""
		fi

		# Otherwise, use tmpextract/ as the toplevel dir (and rename it
		# to requested name); the archive didn't include prefix dir.
		if [ -z "$dir" ]; then
			cd ..
			mv tmpextract $name
		fi

		# assert that these files don't exist yet
		test ! -f $name/patch-done
		test ! -f $name/build-done
	fi
}

################################################################################

# Copy patches
cp `dirname "$0"`/libxml2-threads.patch src
cp `dirname "$0"`/gnutls-pc.patch src
cp `dirname "$0"`/freeimage-openexr-memset.patch src

muslcrossrev=74d6e78976bd
muslcrossname=GregorR-musl-cross-$muslcrossrev
muslcrosstarball=$muslcrossname.tar.bz2
fetch  $muslcrosstarball  https://bitbucket.org/GregorR/musl-cross/get/$muslcrossrev.tar.bz2

################################################################################
# Build an i486-linux-musl cross compiler toolchain with the help of the
# musl-cross scripts.

toolchainbackup="i486-linux-musl-gcc.tar.bz2"
if [ -f "$toolchainbackup" ]; then
	if [ ! -d i486-linux-musl ]; then
		tar -xf "$toolchainbackup"
	fi
else
	extract  musl-cross  $muslcrosstarball

	# Relink musl-cross' tarballs dir to our src dir
	rm musl-cross/tarballs/empty
	rmdir musl-cross/tarballs
	ln -s ../src musl-cross/tarballs

	if [ ! -d i486-linux-musl ]; then
		cd $name
		echo "ARCH=i486" > config.sh
		echo "CC_BASE_PREFIX=$prefix" >> config.sh
		echo "MUSL_CONFFLAGS=\"--disable-debug --disable-shared --enable-static\"" >> config.sh
		echo "GCC_BUILTIN_PREREQS=yes" >> config.sh
		echo "GCC_CONFFLAGS='--disable-shared'" >> config.sh

		export CFLAGS="-O2"
		./build.sh
		unset CFLAGS
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

build()
{
	name="$1"
	tarball="$2"
	url="$3"
	build=$name-build

	fetch $tarball $url
	extract $name $tarball

	# patch
	if [ ! -f $name/patch-done ]; then
		cd $name

		case $name in
		FreeImage*)
			patch -p0 < ../src/freeimage-openexr-memset.patch
			;;
		libxml2*)
			patch -p0 < ../src/libxml2-threads.patch
			;;
		gnutls*)
			patch -p0 < ../src/gnutls-pc.patch
			;;
		esac

		touch patch-done
		cd ..
	fi

	# build (same directory; separate build directory doesn't work for all)
	if [ ! -f $name/build-done ]; then
		cd $name

		export CFLAGS="-Wl,-Bstatic -O2"
		export CPPFLAGS=" -D_GNU_SOURCE"
		export  CC="$prefix/i486-linux-musl/bin/i486-linux-musl-gcc -static-libgcc"
		export CXX="$prefix/i486-linux-musl/bin/i486-linux-musl-g++"
		export  AR="$prefix/i486-linux-musl/bin/i486-linux-musl-ar"
		export  LD="$prefix/i486-linux-musl/bin/i486-linux-musl-ld"

		case $name in
		util-macros*|*proto*|xtrans*)
			./configure \
				--host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl
			make
			make install
			;;

		bzip2*)
			make libbz2.a CC="$CC" AR="$AR" CFLAGS="-O2 -D_FILE_OFFSET_BITS=64"
			cp bzlib.h $prefix/i486-linux-musl/i486-linux-musl/include
			cp libbz2.a $prefix/i486-linux-musl/i486-linux-musl/lib
			;;

		curl*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--disable-shared --enable-static \
				--disable-nls \
				--with-gnutls
			make
			make install
			;;

		e2fsprogs*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--disable-debugfs \
				--disable-imager \
				--disable-resizer \
				--disable-defrag \
				--disable-uuidd \
				--disable-fsck \
				--disable-e2initrd-helper \
				--disable-nls
			make
			make install
			;;

		fontconfig*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--disable-shared --enable-static \
				--disable-docs
			make
			make install
			;;

		FreeImage*)
			unset CFLAGS
			make -f Makefile.gnu libfreeimage.a  CC="$CC" CXX="$CXX" AR="$AR"
			cp Source/FreeImage.h $prefix/i486-linux-musl/i486-linux-musl/include
			cp libfreeimage.a $prefix/i486-linux-musl/i486-linux-musl/lib
			;;

		glu*)
			# glu headers for FB gfxlib2 build
			mkdir -p $prefix/i486-linux-musl/i486-linux-musl/include/GL
			cp	include/GL/glu.h \
				include/GL/glu_mangle.h \
				$prefix/i486-linux-musl/i486-linux-musl/include/GL
			;;

		gnutls*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--disable-shared --enable-static \
				--disable-nls
			make
			make install
			;;

		gpm*)
			# gpm header for FB rtlib build
			cp src/headers/gpm.h $prefix/i486-linux-musl/i486-linux-musl/include
			;;

		libidn*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--disable-shared --enable-static \
				--disable-nls \
				--disable-cxx \
				--disable-doc \
				--disable-crywrap \
				--without-p11-kit \
				--without-tpm
			make
			make install
			;;

		libxslt*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--disable-shared --enable-static \
				--without-plugins \
				--without-debug \
				--without-debugger \
				--without-python \
				--without-crypto \
				--with-libxml-prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--with-libxml-include-prefix=$prefix/i486-linux-musl/i486-linux-musl/include \
				--with-libxml-libs-prefix=$prefix/i486-linux-musl/i486-linux-musl/lib
			make
			make install
			;;

		Mesa*)
			# GL headers for FB gfxlib2 build
			mkdir -p $prefix/i486-linux-musl/i486-linux-musl/include/GL
			cp	include/GL/gl.h \
				include/GL/gl_mangle.h \
				include/GL/glext.h \
				include/GL/glx.h \
				include/GL/glx_mangle.h \
				include/GL/glxext.h \
				$prefix/i486-linux-musl/i486-linux-musl/include/GL
			;;

		ncurses*)
			# We must use --prefix=/usr so it's correct at runtime,
			# because ncurses will hard-code the path into the lib...
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--without-debug --without-profile \
				--without-cxx --without-cxx-binding \
				--without-ada --without-manpages \
				--without-progs --without-tests \
				--without-shared \
				--without-libtool --with-termlib \
				--without-gpm --without-dlsym \
				--without-sysmouse \
				--enable-termcap \
				--without-develop \
				--enable-const
			make
			# but we want to install it into
			#    $prefix/i486-linux-musl/i486-linux-musl
			# and not
			#    $prefix/i486-linux-musl/i486-linux-musl/usr
			# so DESTDIR can't be used either...
			make install prefix=$prefix/i486-linux-musl/i486-linux-musl
			;;

		nettle*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--disable-shared --enable-static \
				--disable-openssl \
				--disable-documentation
			make
			make install
			;;

		pcre*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--disable-shared --enable-static \
				--enable-pcre16 --enable-pcre32 \
				--disable-cpp \
				--enable-utf --enable-unicode-properties
			make
			make install
			;;

		tre*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--disable-shared --enable-static \
				--disable-agrep \
				--disable-nls
			make
			make install
			;;

		xz*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--disable-shared --enable-static \
				--disable-xz --disable-xzdec --disable-lzmadec \
				--disable-lzmainfo --disable-lzma-links \
				--disable-scripts --disable-nls
			make
			make install
			;;

		zlib*)
			./configure --static --prefix=$prefix/i486-linux-musl/i486-linux-musl
			make
			make install
			;;

		*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=$prefix/i486-linux-musl/i486-linux-musl \
				--disable-shared --enable-static
			make
			make install
			;;
		esac

		touch build-done
		cd ..
	fi
}

export PKG_CONFIG_PATH=$prefix/i486-linux-musl/i486-linux-musl/lib/pkgconfig:$prefix/i486-linux-musl/i486-linux-musl/share/pkgconfig
export PKG_CONFIG_LIBDIR=$prefix/i486-linux-musl/i486-linux-musl/lib

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

# compression
build zlib-1.2.7     zlib-1.2.7.tar.bz2     http://prdownloads.sourceforge.net/libpng/zlib-1.2.7.tar.bz2?download
build libzip-0.10.1  libzip-0.10.1.tar.bz2  http://www.nih.at/libzip/libzip-0.10.1.tar.bz2
build xz-5.0.4       xz-5.0.4.tar.xz        http://tukaani.org/xz/xz-5.0.4.tar.xz
build bzip2-1.0.6    bzip2-1.0.6.tar.gz     http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz

# xml
build libxml2-2.9.0   libxml2-2.9.0.tar.gz   ftp://xmlsoft.org/libxml2/libxml2-2.9.0.tar.gz
build libxslt-1.1.28  libxslt-1.1.28.tar.gz  ftp://xmlsoft.org/libxml2/libxslt-1.1.28.tar.gz
build expat-2.1.0     expat-2.1.0.tar.gz     http://sourceforge.net/projects/expat/files/expat/2.1.0/expat-2.1.0.tar.gz/download

# regex
build pcre-8.32  pcre-8.32.tar.bz2  ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.32.tar.bz2
build tre-0.8.0  tre-0.8.0.tar.bz2  http://laurikari.net/tre/tre-0.8.0.tar.bz2

build gdsl-1.6           gdsl-1.6.tar.gz            http://download.gna.org/gdsl/gdsl-1.6.tar.gz
build gmp-5.1.1          gmp-5.1.1.tar.lz           ftp://ftp.gmplib.org/pub/gmp-5.1.1/gmp-5.1.1.tar.lz

# curl
build c-ares-1.9.1       c-ares-1.9.1.tar.gz        http://c-ares.haxx.se/download/c-ares-1.9.1.tar.gz
build libidn-1.26        libidn-1.26.tar.gz         http://ftp.gnu.org/gnu/libidn/libidn-1.26.tar.gz
build nettle-2.6         nettle-2.6.tar.gz          http://www.lysator.liu.se/~nisse/archive/nettle-2.6.tar.gz
build libtasn1-3.2       libtasn1-3.2.tar.gz        http://ftp.gnu.org/gnu/libtasn1/libtasn1-3.2.tar.gz
build gnutls-3.1.9       gnutls-3.1.9.1.tar.xz      ftp://ftp.gnutls.org/gcrypt/gnutls/v3.1/gnutls-3.1.9.1.tar.xz
build libmetalink-0.1.2  libmetalink-0.1.2.tar.bz2  https://launchpad.net/libmetalink/trunk/packagingfix/+download/libmetalink-0.1.2.tar.bz2
build curl-7.29.0        curl-7.29.0.tar.bz2        http://curl.haxx.se/download/curl-7.29.0.tar.bz2

# font
build freetype-2.4.11     freetype-2.4.11.tar.bz2  http://sourceforge.net/projects/freetype/files/freetype2/2.4.11/freetype-2.4.11.tar.bz2/download
build fontconfig-2.10.91  fontconfig-2.10.91.tar.bz2 http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.10.91.tar.bz2

# images
build libpng-1.5.14  libpng-1.5.14.tar.xz  http://prdownloads.sourceforge.net/libpng/libpng-1.5.14.tar.xz?download
build giflib-5.0.4   giflib-5.0.4.tar.bz2  http://sourceforge.net/projects/giflib/files/giflib-5.x/giflib-5.0.4.tar.bz2/download
build jpeg-9         jpegsrc.v9.tar.gz     http://www.ijg.org/files/jpegsrc.v9.tar.gz
build FreeImage      FreeImage3154.zip     http://sourceforge.net/projects/freeimage/files/Source%20Distribution/3.15.4/FreeImage3154.zip/download

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
echo "CC := $prefix/i486-linux-musl/bin/i486-linux-musl-gcc" >> config.mk
echo "AR := $prefix/i486-linux-musl/bin/i486-linux-musl-ar"  >> config.mk
echo "CFLAGS := -O2 -D_GNU_SOURCE" >> config.mk
echo "CFLAGS += `pkg-config --cflags libffi`" >> config.mk
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

fetch  $binutilstarball  http://ftp.gnu.org/gnu/binutils/$binutilstarball
extract  $binutilsname  $binutilstarball

# build
if [ ! -d $binutilsname-build ]; then
	mkdir $binutilsname-build
	cd $binutilsname-build

	CFLAGS="-Wl,-Bstatic -O2" \
	CPPFLAGS=" -D_GNU_SOURCE" \
	 CC="$prefix/i486-linux-musl/bin/i486-linux-musl-gcc -static-libgcc" \
	CXX="$prefix/i486-linux-musl/bin/i486-linux-musl-g++" \
	 AR="$prefix/i486-linux-musl/bin/i486-linux-musl-ar" \
	 LD="$prefix/i486-linux-musl/bin/i486-linux-musl-ld" \
	../$binutilsname/configure \
		--host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
		--prefix=/usr \
		--disable-shared --enable-static \
		--disable-nls --disable-werror

	make
	cd ..
fi

# Copy in the binutils
mkdir -p fbc-static/bin/linux
cp $binutilsname-build/gas/as-new   fbc-static/bin/linux/as
cp $binutilsname-build/binutils/ar  fbc-static/bin/linux/ar
cp $binutilsname-build/ld/ld-new    fbc-static/bin/linux/ld

################################################################################
