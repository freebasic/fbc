#!/bin/bash
set -ex

mkdir -p src prefix prefix/bin prefix/include prefix/lib
mkdir -p fbc/bin/win32 fbc/bin/linux
mkdir -p fbc/lib/win32
mkdir -p fbc/doc/licenses

toplevel="$PWD"
prefix=$toplevel/prefix
licensedir=$toplevel/fbc/doc/licenses

triplet="i686-w64-mingw32"

# TODO: For cross-compiling, we'll need to override pkg-config just as done
# in the FB-musllibc build script
crosstoolprefix=""
#crosstoolprefix="${triplet}-"
export      AS="${crosstoolprefix}as"
export     CPP="${crosstoolprefix}cpp"
export      CC="${crosstoolprefix}gcc"
export     CXX="${crosstoolprefix}g++"
export      AR="${crosstoolprefix}ar"
export  RANLIB="${crosstoolprefix}ranlib"
export      LD="${crosstoolprefix}ld"
export DLLTOOL="${crosstoolprefix}dlltool"
export WINDRES="${crosstoolprefix}windres"
export   STRIP="${crosstoolprefix}strip"
export STRINGS="${crosstoolprefix}strings"

my_report()
{
	echo "------------------------------------------------------------"
	echo $@
}

my_fetch()
{
	local tarball="$1"
	local url="$2"

	# download
	if [ ! -f src/$tarball ]; then
		my_report "downloading $tarball"
		wget $url -O src/$tarball
	fi
}

my_fixdir()
{
	local top="$1"
	local name="$2"

	cd "$top"

	# If the archive included one or multiple prefix directories,
	# remove them

	# Just one dir in current dir?
	# (note: ignoring hidden files here, which helps at least with some
	# packages that have .hg_archival.txt etc. at the toplevel but all other
	# files in a subdir)
	if [ "`ls -1 | wc -l`" = "1" ] && [ -d "`ls -1`" ]; then
		# Recursion to handle nested dirs
		my_fixdir "`ls -1`" "$name"

		mv "$name" ..
		cd ..
		rm -rf "$top"
	else
		cd ..
		if [ "`echo $top | tr '[a-z]' '[A-Z]'`" != "`echo $name | tr '[a-z]' '[A-Z]'`" ]; then
			mv "$top" "$name"
		fi
	fi
}

my_extract()
{
	local name="$1"
	local tarball="$2"

	# unpack
	if [ ! -d $name ]; then
		my_report "extracting $tarball -> $name"

		# Extract archive inside tmpextract/
		mkdir tmpextract
		cd tmpextract

		if [ -n "`echo $tarball | grep '\.zip$'`" ]; then
			unzip -q ../src/$tarball
		else
			tar -xf ../src/$tarball
		fi

		cd ..

		my_fixdir tmpextract $name

		# assert that these files don't exist yet
		test ! -f $name/patch-done
		test ! -f $name/build-done
	fi
}

################################################################################

my_patch()
{
	local name="$1"

	# patch
	if [ ! -f $name/patch-done ]; then
		cd $name

		case $name in
		aspell-*)
			patch -p0 < ../src/aspell.patch
			;;
		cryptlib-*)
			find . -type f -print0 | xargs -0 dos2unix && true
			;;
		DevIL-*)
			patch -p0 < ../src/DevIL.patch
			;;
		FreeImage-*)
			patch -p0 < ../src/FreeImage.patch
			;;
		gd-73cab5d8af96)
			patch -p0 < ../src/gd-73cab5d8af96.patch
			;;
		giflib-5.0.4)
			patch -p0 < ../src/giflib-5.0.4.patch
			;;
		giflib-4.2.1)
			patch -p0 < ../src/giflib-4.2.1.patch
			;;
		jasper-*)
			patch -p0 < ../src/jasper.patch
			;;
		libxml2-*)
			patch -p0 < ../src/libxml2.patch
			;;
		libxslt-*)
			patch -p0 < ../src/libxslt.patch
			;;
		TinyPTC-Windows-*)
			find . -type f -print0 | xargs -0 dos2unix && true
			patch -p1 < ../src/TinyPTC-Windows.patch
			;;
		tinyxml2-*)
			patch -p0 < ../src/tinyxml2.patch
			;;
		esac

		touch patch-done
		cd ..
	fi
}

my_build()
{
	local name="$1"

	# build (same directory; separate build directory doesn't work for all)
	if [ ! -f $name/build-done ]; then
		my_report "building $name"

		cd $name

		export CPPFLAGS="-I$prefix/include"
		export CFLAGS="-O2 -Werror-implicit-function-declaration"
		export CXXFLAGS="-O2 -L$prefix/lib"
		export LDFLAGS="-L$prefix/lib"

		confargs="--host=$triplet --prefix=$prefix --enable-shared --enable-static"

		case $name in
		aspell-*)
			# Aspell hard-codes the prefix path, even with the
			# --enable-win32-relocatable option, but we don't want
			# that at all, so use --prefix=/usr/local for now and
			# hope for the best.
			./configure --build=$triplet --host=$triplet \
				--disable-shared --enable-static \
				--enable-win32-relocatable \
				--disable-nls
			make
			make install prefix="" DESTDIR=$prefix

			# TODO: Much like with libjasper, no DLL is built even
			# when using --enable-shared. However, it works when
			# cross-compiling from Linux, so it's probably a problem
			# with MinGW/MSYS's libtool.

			# Create a DLL manually (aspell doesn't use
			# dllexport/dllimport or other DLL-specifics anyways)
			mkdir build-dll
			cd build-dll
			ar x $prefix/lib/libaspell.a
			g++ -shared -o libaspell-15.dll -Wl,--out-implib,libaspell.dll.a *.o -pthread
			cp *.dll $prefix/bin
			cp *.a $prefix/lib
			cd ..
			;;

		big_int-*)
			cd $name/libbig_int
			$CC $CPPFLAGS $CFLAGS -Wall -c -I include src/*.c src/low_level_funcs/*.c
			$AR rcs libbig_int.a *.o
			cp libbig_int.a $prefix/lib
			mkdir -p $prefix/include/big_int
			cp include/*.h $prefix/include/big_int
			cd ../..
			;;

		bzip2-*)
			$CC $CPPFLAGS $CFLAGS -c \
				blocksort.c huffman.c crctable.c \
				randtable.c compress.c decompress.c bzlib.c
			$AR rcs libbz2.a \
				blocksort.o huffman.o crctable.o \
				randtable.o compress.o decompress.o bzlib.o
			$CC -shared -o libbz2.dll \
				-Wl,--out-implib,libbz2.dll.a \
				blocksort.o huffman.o crctable.o \
				randtable.o compress.o decompress.o bzlib.o
			cp bzlib.h $prefix/include
			cp *.a $prefix/lib
			cp *.dll $prefix/bin
			;;

		cgi-util-*)
			$CC $CPPFLAGS $CFLAGS -c cgi-util.c
			$AR rcs libcgi-util.a cgi-util.o
			cp cgi-util.h $prefix/include
			cp *.a $prefix/lib
			;;

		cryptlib-*)
			# This builds the static lib
			make CPP="$CPP" CC="$CC" CXX="$CXX" LD="$LD" AR="$AR" STRIP="$STRIP" \
				OSNAME="MINGW32_NT-5.1"
			cp libcl.a $prefix/lib

			# The DLL is already precompiled
			cp cl32.dll $prefix/bin
			$DLLTOOL --input-def crypt32.def --dllname cl32.dll --output-lib libcl.dll.a
			cp libcl.dll.a $prefix/lib
			;;

		curl-*)
			./configure $confargs --disable-nls --with-gnutls
			make
			make install
			;;

		DevIL-*-static)
			export CPPFLAGS="-DIL_STATIC_LIB=1 -I$prefix/include"
			export LDFLAGS="-static-libgcc -Wl,-Bstatic -L$prefix/lib"
			export LIBS="-lstdc++"
			./configure --host=$triplet --prefix=$prefix \
				--disable-shared --enable-static \
				--enable-ILU --enable-ILUT \
				--disable-wdp
			make
			make install
			;;

		DevIL-*-dll)
			export CPPFLAGS="-DMNG_USE_DLL=1 -I$prefix/include"
			./configure --host=$triplet --prefix=$prefix \
				--enable-shared --disable-static \
				--enable-ILU --enable-ILUT \
				--disable-wdp
			make
			make install
			;;

		disphelper-*)
			cd source
			$CC $CPPFLAGS $CFLAGS -Wall -c *.c
			$AR rcs libdisphelper.a *.o
			cp libdisphelper.a $prefix/lib
			cp disphelper.h $prefix/include
			cd ..
			;;

		flac-*)
			./configure $confargs \
				--disable-doxygen-docs \
				--disable-thorough-tests \
				--disable-xmms-plugin \
				--disable-cpplibs \
				--disable-oggtest
			make
			make install
			;;

		fontconfig-*)
			FREETYPE_CFLAGS=-I$prefix/include/freetype2 \
			FREETYPE_LIBS="-L$prefix/lib -lfreetype" \
			./configure $confargs
			make
			make install
			;;

		FreeImage-*-static)
			unset CFLAGS
			unset CXXFLAGS
			unset LDFLAGS
			make -f Makefile.mingw all INSTALLDIR=$prefix \
				FREEIMAGE_LIBRARY_TYPE=STATIC \
				CC="$CC" LD="$CXX" DLLTOOL="$DLLTOOL" RC="$WINDRES"
			cp Dist/libFreeImage.a $prefix/lib
			cp Dist/FreeImage.h $prefix/include
			;;

		FreeImage-*-dll)
			unset CFLAGS
			unset CXXFLAGS
			unset LDFLAGS
			make -f Makefile.mingw all INSTALLDIR=$prefix \
				FREEIMAGE_LIBRARY_TYPE=SHARED \
				CC="$CC" LD="$CXX" DLLTOOL="$DLLTOOL" RC="$WINDRES"
			cp Dist/FreeImage.dll $prefix/bin
			cp Dist/FreeImage.lib $prefix/lib/libFreeImage.dll.a
			;;

		gd-73cab5d8af96)
			# -G "MSYS Makefiles"
			cmake . \
				-DCMAKE_SYSTEM_NAME="Windows" \
				-DCMAKE_C_COMPILER="$CC" \
				-DCMAKE_CXX_COMPILER="$CXX" \
				-DCMAKE_RC_COMPILER="$WINDRES" \
				-DCMAKE_FIND_ROOT_PATH=$prefix \
				-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
				-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
				-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
				\
				-DENABLE_PNG=1 -DENABLE_JPEG=1 -DENABLE_TIFF=1 \
				-DCMAKE_INSTALL_PREFIX=$prefix
			make
			make install
			;;

		glfw-*)
			make win32-msys CC="$CC" MKLIB="$AR" DLLTOOL="$DLLTOOL"
			cp lib/win32/glfw.dll $prefix/bin
			cp lib/win32/libglfwdll.a $prefix/lib
			cp lib/win32/libglfw.a $prefix/lib
			;;

		gmp-*)
			# -Werror-implicit-function-declaration breaks configure
			export CFLAGS="-O2"

			# Note: gmp refuses to build dll/static versions in one
			# go because the gmp headers are different between both.
			# (it seems to be "only" the #define __GMP_LIBGMP_DLL)
			# Thus we build static but don't "make install" it,
			# to avoid overwriting headers/*.pc/*.la files from
			# the DLL install.

			# Observed problem: When cross-compiling from Linux to
			# MinGW with CC set, gmp's libtool does
			#    gcc ... -o .libs/libgmp-10.dll -Xlinker --out-implib -Xlinker .libs/libgmp-10.dll
			# i.e. output DLL and import library are given the same name,
			# and one will probably overwrite the other. Besides that,
			# libgmp.lib as symlink to libgmp-10.dll is generated.
			# Instead there should be just a .dll and the .dll.a
			# import lib.
			#
			# This seems to happen due to the library_names_spec
			# variable in the generated libtool file. It is set
			# by configure in code coming from aclocal.m4:
			#
			#  case $GCC,$cc_basename in
			#  yes,*)
			#    # gcc
			#    ...
			#    library_names_spec='$libname.dll.a'
			#    ...
			#    ;;
			#
			#  *,cl*)
			#    # Native MSVC
			#    ...
			#    library_names_spec='${libname}.dll.lib'
			#    ...
			#    ;;
			#
			#  *)
			#    # Assume MSVC wrapper
			#    ...
			#    library_names_spec='${libname}`echo ${release} | $SED -e 's/[[.]]/-/g'`${versuffix}${shared_ext} $libname.lib'
			#    ...
			#    ;;
			#  esac
			#
			# configure sets GCC to yes when using GNU CC, but later
			# it does GCC=$GXX, but GXX isn't set, so GCC ends up
			# empty instead of yes, causing the "MSVC wrapper" part
			# from the above case block to be used, instead of the
			# "gcc" part. This is wrong when cross-compiling for
			# MinGW though.
			#
			# This is related to CC being set, and to
			# cross-compiling. gmp's configure has special code that
			# checks for this situation and behaves differently
			# depending on whether CC was set. Not setting CC fixes
			# the issue. Another (hackish) work-around seems to be
			# to set GXX=yes manually.

			mkdir -p build-dll
			cd build-dll
				GXX=yes \
				../configure --host=$triplet --prefix=$prefix \
					--enable-shared --disable-static
				make
				make install
			cd ..

			mkdir -p build-static
			cd build-static
				GXX=yes \
				../configure --host=$triplet --prefix=$prefix \
					--disable-shared --enable-static
				make
				cp .libs/libgmp.a $prefix/lib
			cd ..
			;;

		gnutls-*)
			./configure $confargs --disable-nls
			make
			make install
			;;

		grx-*)
			cd contrib/grx249

			make -f makefile.w32 libs \
				HAVE_LIBTIFF=y \
				HAVE_LIBJPEG=y \
				HAVE_LIBPNG=y \
				NEED_ZLIB=y \
				HAVE_UNIX_TOOLS=y \
				EP= \
				prefix="$prefix" \
				CCOPT="$CPPFLAGS $CFLAGS -fno-strict-aliasing -Wall" \
				LDOPT="$LDFLAGS -s" \
				CROSS_PLATFORM="$crosstoolprefix"

			cp lib/win32/libgrx20.a $prefix/lib

			cd ../..
			;;

		jasper-*)
			# This only builds the static lib
			# (TODO: even with --disable-static --enable-shared,
			# only a static lib is produced, what's wrong?)
			./configure --host=$triplet --prefix=$prefix
			make
			make install

			# but we can create a DLL manually
			mkdir build-dll
			cd build-dll
			$AR x $prefix/lib/libjasper.a
			$CC -shared -o libjasper-1.dll \
				-Wl,--out-implib,libjasper.dll.a \
				*.o \
				-L$prefix/lib -ljpeg
			cp *.dll $prefix/bin
			cp *.a $prefix/lib

			# Fix the libjasper.la to allow DevIL to compile properly against
			# the libjasper-1.dll/libjasper.dll.a
			sed	-e "s|dlname=''|dlname='../bin/libjasper-1.dll'|g" \
				-e "s|library_names=''|library_names='libjasper.dll.a'|g" \
				$prefix/lib/libjasper.la > $prefix/lib/libjasper.la.tmp
			mv $prefix/lib/libjasper.la.tmp $prefix/lib/libjasper.la

			cd ..
			;;

		libcaca-*)
			./configure $confargs \
				--disable-csharp --disable-java \
				--disable-cxx \
				--disable-python --disable-ruby \
				--disable-doc
			make
			make install
			;;

		libidn-*)
			./configure $confargs \
				--disable-nls \
				--disable-cxx \
				--disable-doc \
				--disable-crywrap \
				--without-p11-kit \
				--without-tpm
			make
			make install
			;;

		libjit-*)
			./auto_gen.sh
			./configure $confargs
			make
			make install
			;;

		libmediainfo-*)
			to do
			cd Project/GNU/Library
			./autogen
			./configure $confargs \
				--with-libtinyxml2 \
				--with-libcurl \
				--with-libmms
			make
			make install
			cd ../../..
			;;

		libmng-*-static)
			$CC $CPPFLAGS $CFLAGS \
				-DMNG_SUPPORT_READ -DMNG_SUPPORT_DISPLAY -DMNG_SUPPORT_WRITE \
				-DMNG_ACCESS_CHUNKS -DMNG_STORE_CHUNKS \
				*.c -c
			$AR rcs libmng.a *.o
			cp libmng.a $prefix/lib
			cp libmng.h libmng_conf.h libmng_types.h $prefix/include
			;;

		libmng-*-dll)
			# Note: When built with MNG_BUILD_DLL, libmng.h switches to __stdcall,
			# so any users (i.e. DevIL) have to #define MNG_USE_DLL to match that,
			# at least as long as libmng.dll.a exists, because the linker will prefer
			# that over the static libmng.a lib (which uses cdecl and thus is incompatible).
			$CC -shared -Wall $CPPFLAGS $CFLAGS \
				-DMNG_BUILD_DLL \
				-DMNG_SUPPORT_READ -DMNG_SUPPORT_DISPLAY -DMNG_SUPPORT_WRITE \
				-DMNG_ACCESS_CHUNKS -DMNG_STORE_CHUNKS \
				*.c -o libmng.dll -Wl,--out-implib,libmng.dll.a \
				-L$prefix/lib -ljpeg -lz
			cp libmng.dll.a $prefix/lib
			cp libmng.dll $prefix/bin
			;;

		libxslt-*)
			./configure $confargs \
				--without-plugins \
				--without-debug \
				--without-debugger \
				--without-python \
				--without-crypto \
				--with-libxml-prefix=$prefix \
				--with-libxml-include-prefix=$prefix/include \
				--with-libxml-libs-prefix=$prefix/lib
			make
			make install
			;;

		libzen-*)
			to do
			cd Project/GNU/Library
			./autogen
			./configure $confargs
			make
			make install
			cd ../../..
			;;

		lua-*)
			make mingw install INSTALL_TOP=$prefix \
				CC="$CC" AR="$AR rcu" RANLIB="$RANLIB"
			cp src/lua52.dll $prefix/bin
			;;

		mxml-*)
			# Use the config.h from the vcnet/ directory,
			# it's the same as what's needed for MinGW except for
			# the inline keyword redefinition
			sed -e 's/#define inline _inline//g' vcnet/config.h > config.h

			mxmlsrcs="../mxml-attr.c   ../mxml-entity.c ../mxml-file.c \
			          ../mxml-get.c    ../mxml-index.c  ../mxml-node.c \
			          ../mxml-search.c ../mxml-set.c    ../mxml-private.c \
			          ../mxml-string.c"

			mkdir -p build-static
			cd build-static
			$CC $CPPFLAGS $CFLAGS -Wall -c $mxmlsrcs
			$AR rcs libmxml.a *.o
			cp libmxml.a $prefix/lib
			cd ..

			mkdir -p build-dll
			cd build-dll
			$CC $CPPFLAGS $CFLAGS $LDFLAGS -DMXML1_EXPORTS $mxmlsrcs \
				-shared -o mxml.dll -Wl,--out-implib,libmxml.dll.a
			cp mxml.dll $prefix/bin
			cp libmxml.dll.a $prefix/lib
			cd ..
			;;

		nettle-*)
			./configure $confargs --disable-openssl --disable-documentation
			make
			make install
			;;

		openal-soft-*)
			mkdir -p build-dll
			cd build-dll
			# -G "MSYS Makefiles"
			cmake .. \
				-DCMAKE_SYSTEM_NAME="Windows" \
				-DCMAKE_C_COMPILER="$CC" \
				-DCMAKE_CXX_COMPILER="$CXX" \
				-DCMAKE_RC_COMPILER="$WINDRES" \
				-DCMAKE_FIND_ROOT_PATH=$prefix \
				-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
				-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
				-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
				\
				-DCMAKE_INSTALL_PREFIX=$prefix
			make
			make install
			cd ..

			mkdir -p build-static
			cd build-static
			# -G "MSYS Makefiles"
			cmake .. \
				-DCMAKE_SYSTEM_NAME="Windows" \
				-DCMAKE_C_COMPILER="$CC" \
				-DCMAKE_CXX_COMPILER="$CXX" \
				-DCMAKE_RC_COMPILER="$WINDRES" \
				-DCMAKE_FIND_ROOT_PATH=$prefix \
				-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
				-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
				-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
				\
				-DCMAKE_INSTALL_PREFIX=$prefix \
				-DLIBTYPE=STATIC
			make
			make install
			cd ..
			;;

		pcre-*)
			# Setting CC_FOR_BUILD to avoid pcre's config.guess
			# picking up CC and failing to detect the build system
			CC_FOR_BUILD="gcc" \
			./configure $confargs \
				--enable-pcre16 --enable-pcre32 \
				--disable-cpp \
				--enable-utf --enable-unicode-properties \
				--enable-newline-is-crlf
			make
			make install
			;;

		PDCurses-*)
			cd win32

			mkdir build-static
			cd build-static
			make -f ../gccwin32.mak libs PDCURSES_SRCDIR=../.. WIDE=Y \
				CC="$CC" LINK="$CC" LIBEXE="$AR"
			cp pdcurses.a $prefix/lib/libpdcurses.a
			cp panel.a $prefix/lib/libpanel.a
			cd ..

			mkdir build-dll
			cd build-dll
			make -f ../gccwin32.mak libs PDCURSES_SRCDIR=../.. WIDE=Y DLL=Y \
				CC="$CC" LINK="$CC" LIBEXE="$CC"' $(DEFFILE)'
			cp pdcurses.dll $prefix/bin
			cp pdcurses.a $prefix/lib/libpdcurses.dll.a
			cp panel.a $prefix/lib/libpanel.dll.a
			cd ..

			cd ..
			;;

		pdflib-*)
			cd src
			./configure $confargs \
				--disable-php \
				--without-java --without-perl --without-py \
				--without-tcl \
				--with-tifflib --with-zlib --with-pnglib
			make pdflib CPPFLAGS="$CPPFLAGS" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"
			make install prefix=$prefix
			cd ..
			;;

		postgresql-*)
			# PostgreSQL hard-codes the prefix path, but we don't
			# want that at all, so use --prefix=/ for now and hope
			# for the best
			# -Werror-implicit-function-declaration breaks configure
			export CFLAGS="-O2 -L$prefix/lib"
			./configure --host=$triplet \
				--prefix=$prefix \
				--enable-shared --enable-static
			make
			make install DESTDIR=$prefix
			;;

		QuickLZ-*)
			$CC -Wall $CPPFLAGS $CFLAGS -c quicklz.c
			$AR rcs libquicklz.a quicklz.o
			cp libquicklz.a $prefix/lib
			;;

		sqlite-*)
			$CC $CPPFLAGS $CFLAGS -c sqlite3.c
			$AR rcs libsqlite3.a sqlite3.o
			$CC -shared $CPPFLAGS $CFLAGS $LDFLAGS sqlite3.c -o sqlite3.dll -Wl,--out-implib,libsqlite3.dll.a
			cp *.h $prefix/include
			cp *.dll $prefix/bin
			cp *.a $prefix/lib
			;;

		TinyPTC-Windows-*)
			make CFLAGS="-I. $CPPFLAGS $CFLAGS -I../../../src/rtlib -I../../../src/rtlib/win32 -I../../../src/gfxlib2" \
				AR="$AR" CC="$CC"
			cp *.a $prefix/lib
			;;

		tinyxml2-*)
			to do
			cmake . -G "MSYS Makefiles" \
				-DCMAKE_INSTALL_PREFIX=$prefix \
				-DBUILD_STATIC_LIBS=ON
			make
			make install
			;;

		tre-*)
			./configure $confargs --disable-agrep --disable-nls
			make
			make install
			;;

		xz-*)
			./configure $confargs \
				--disable-xz --disable-xzdec --disable-lzmadec \
				--disable-lzmainfo --disable-lzma-links \
				--disable-scripts --disable-nls
			make
			make install
			;;

		zlib-*)
			make -f win32/Makefile.gcc all install \
				SHARED_MODE=1 \
				BINARY_PATH=$prefix/bin \
				INCLUDE_PATH=$prefix/include \
				LIBRARY_PATH=$prefix/lib \
				PREFIX="$crosstoolprefix"
			;;

		*)
			./configure $confargs
			make
			make install
			;;
		esac

		unset CPPFLAGS
		unset CFLAGS
		unset CXXFLAGS
		unset LDFLAGS

		cd ..

		touch $name/build-done
	fi
}

my_license()
{
	local name="$1"

	cd "$name"

	case "$name" in
	aspell-*)       cp COPYING                      $licensedir/aspell.txt;;
	big_int-*)      cp $name/libbig_int/LICENSE     $licensedir/big_int.txt;;
	bzip2-*)        cp LICENSE                      $licensedir/bzip2.txt;;
	c-ares-*)       head -n16 ares_library_init.c > $licensedir/c-ares.txt;;
	cgi-util-*)     cp COPYING.txt                  $licensedir/cgi-util.txt;;
	cryptlib-*)     cp COPYING                      $licensedir/cryptlib.txt;;
	CUnit-*)        cp COPYING                      $licensedir/CUnit.txt;;
	curl-*)         cp COPYING                      $licensedir/curl.txt;;
	DevIL-*)        cp COPYING                      $licensedir/DevIL.txt;;
	disphelper-*)   cp readme.htm                   $licensedir/disphelper.html;;
	expat-*)        cp COPYING                      $licensedir/expat.txt;;
	flac-*)         cp COPYING.Xiph                 $licensedir/flac.txt;;
	freeglut-*)     cp COPYING                      $licensedir/freeglut.txt;;
	FreeImage-*)    cp license-fi.txt               $licensedir/FreeImage.txt;;
	freetype-*)     cp docs/LICENSE.TXT             $licensedir/freetype.txt;;
	gd-*)           cp COPYING                      $licensedir/GD.txt;;
	gdsl-*)         cp COPYING                      $licensedir/gdsl.txt;;
	giflib-*)       cp COPYING                      $licensedir/giflib.txt;;
	glfw-*)         cp COPYING.txt                  $licensedir/glfw.txt;;
	gmp-*)          cp COPYING.LIB                  $licensedir/gmp.txt;;
	gnutls-*)       cp COPYING.LESSER               $licensedir/gnutls.txt
	                cp COPYING                      $licensedir/gnutls-openssl.txt;;
	grx-*)          cp contrib/grx249/copying.grx   $licensedir/grx.txt;;
	gsl-*)          cp COPYING                      $licensedir/gsl.txt;;
	jasper-*)       cp LICENSE                      $licensedir/jasper.txt;;
	jpeg-*)         cp README                       $licensedir/jpeglib.txt;;
	lcms-*)         cp COPYING                      $licensedir/lcms.txt;;
	lcms2-*)        cp COPYING                      $licensedir/lcms2.txt;;
	libffi-*)       cp LICENSE                      $licensedir/libffi.txt;;
	libidn-*)       cp COPYING                      $licensedir/libidn.txt;;
	libmetalink-*)  cp COPYING                      $licensedir/libmetalink.txt;;
	libmng-*)       cp LICENSE                      $licensedir/libmng.txt;;
	libogg-*)       cp COPYING                      $licensedir/libogg.txt;;
	liboggz-*)      cp COPYING                      $licensedir/liboggz.txt;;
	libpng-*)       cp LICENSE                      $licensedir/libpng.txt;;
	libtasn1-*)     cp COPYING.LIB                  $licensedir/libtasn1.txt;;
	libtheora-*)    cp COPYING                      $licensedir/libtheora.txt;;
	libvorbis-*)    cp COPYING                      $licensedir/libvorbis.txt;;
	libwebp-*)      cp COPYING                      $licensedir/libwebp.txt;;
	libxml2-*)      cp COPYING                      $licensedir/libxml2.txt;;
	libxslt-*)      cp COPYING                      $licensedir/libxslt.txt;;
	libzip-*)       cp LICENSE                      $licensedir/libzip.txt;;
	lua-*)          cp doc/readme.html              $licensedir/Lua.html;;
	lzo-*)          cp COPYING                      $licensedir/LZO.txt;;
	mxml-*)         cp COPYING                      $licensedir/mxml.txt;;
	nettle-*)       cp COPYING.LIB                  $licensedir/nettle.txt;;
	openal-soft-*)  cp COPYING                      $licensedir/openal-soft.txt;;
	pcre-*)         cp LICENCE                      $licensedir/PCRE.txt;;
	PDCurses-*)     cp README                       $licensedir/PDCurses.txt;;
	pdflib-*)       cp src/readme.txt               $licensedir/pdflib.txt;;
	QuickLZ-*)      head -n8 quicklz.c            > $licensedir/QuickLZ.txt;;
	SDL-*)          cp COPYING                      $licensedir/SDL.txt;;
	SDL_image-*)    cp COPYING                      $licensedir/SDL_image.txt;;
	SDL_net-*)      cp COPYING                      $licensedir/SDL_net.txt;;
	SDL_ttf-*)      cp COPYING                      $licensedir/SDL_ttf.txt;;
	sqlite-*)       head -n10 sqlite3.h | tail -n9 > $licensedir/sqlite3.txt;;
	tiff-*)         cp COPYRIGHT                    $licensedir/tiff.txt;;
	tre-*)          cp LICENSE                      $licensedir/TRE.txt;;
	xz-*)           cp COPYING                      $licensedir/xz.txt;;
	zlib-*)         cp README                       $licensedir/zlib.txt;;
	esac

	cd ..
}

my_work()
{
	local name="$1"
	local tarball="$2"
	local url="$3"

	my_fetch "$tarball" "$url"
	my_extract "$name" "$tarball"
	my_patch "$name"
	my_build "$name"
	my_license "$name"
}

export PATH=$prefix/bin:$PATH

my_work TinyPTC-Windows-0.8 TinyPTC-Windows-0.8.zip "http://sourceforge.net/projects/tinyptc/files/Windows%20Version/TinyPTC%20Windows%200.8/TinyPTC-Windows-0.8.zip/download"

my_work libffi-3.0.12    libffi-3.0.12.tar.gz     "ftp://sourceware.org/pub/libffi/libffi-3.0.12.tar.gz"
#my_work libjit-749e162d71eb295ff1e195cd4fd78f345c325773  libjit-749e162d71eb295ff1e195cd4fd78f345c325773.tar.gz  "http://git.savannah.gnu.org/cgit/libjit.git/snapshot/libjit-749e162d71eb295ff1e195cd4fd78f345c325773.tar.gz"

# compression
my_work zlib-1.2.7     zlib-1.2.7.tar.bz2     "http://prdownloads.sourceforge.net/libpng/zlib-1.2.7.tar.bz2?download"
my_work libzip-0.11    libzip-0.11.tar.xz     "http://www.nih.at/libzip/libzip-0.11.tar.xz"
my_work xz-5.0.4       xz-5.0.4.tar.xz        "http://tukaani.org/xz/xz-5.0.4.tar.xz"
my_work bzip2-1.0.6    bzip2-1.0.6.tar.gz     "http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz"
my_work lzo-2.06       lzo-2.06.tar.gz        "http://www.oberhumer.com/opensource/lzo/download/lzo-2.06.tar.gz"

# QuickLZ apparently doesn't offer a tarball download, only the quicklz.c/h files,
# so create a tarball out of those manually:
if [ ! -f src/QuickLZ-1.5.0.tar.gz ]; then
	wget "http://www.quicklz.com/quicklz.h" -O quicklz.h
	wget "http://www.quicklz.com/quicklz.c" -O quicklz.c
	tar -czf src/QuickLZ-1.5.0.tar.gz --transform 's,^,QuickLZ-1.5.0/,g' quicklz.c quicklz.h
	rm quicklz.c quicklz.h
fi
my_work QuickLZ-1.5.0 QuickLZ-1.5.0.tar.gz unused

# xml, regex, math, util
#my_work tinyxml2-master tinyxml2-master.zip      "--no-check-certificate https://github.com/leethomason/tinyxml2/archive/master.zip"
my_work mxml-2.7        mxml-2.7.tar.gz          "http://www.msweet.org/files/project3/mxml-2.7.tar.gz"
my_work libxml2-2.9.0   libxml2-2.9.0.tar.gz     "ftp://xmlsoft.org/libxml2/libxml2-2.9.0.tar.gz"
my_work libxslt-1.1.28  libxslt-1.1.28.tar.gz    "ftp://xmlsoft.org/libxml2/libxslt-1.1.28.tar.gz"
my_work expat-2.1.0     expat-2.1.0.tar.gz       "http://sourceforge.net/projects/expat/files/expat/2.1.0/expat-2.1.0.tar.gz/download"
my_work pcre-8.32       pcre-8.32.tar.bz2        "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.32.tar.bz2"
my_work tre-0.8.0       tre-0.8.0.tar.bz2        "http://laurikari.net/tre/tre-0.8.0.tar.bz2"
my_work gdsl-1.6        gdsl-1.6.tar.gz          "http://download.gna.org/gdsl/gdsl-1.6.tar.gz"
my_work gmp-5.1.1       gmp-5.1.1.tar.xz         "ftp://ftp.gmplib.org/pub/gmp/gmp-5.1.1.tar.xz"
my_work gsl-1.15        gsl-1.15.tar.gz          "ftp://ftp.gnu.org/gnu/gsl/gsl-1.15.tar.gz"
my_work CUnit-2.1-2     CUnit-2.1-2-src.tar.bz2  "http://downloads.sourceforge.net/cunit/CUnit-2.1-2-src.tar.bz2?download"
my_work aspell-0.60.6.1 aspell-0.60.6.1.tar.gz   "ftp://ftp.gnu.org/gnu/aspell/aspell-0.60.6.1.tar.gz"
my_work cryptlib-3.4.2  cl342.zip                "ftp://ftp.franken.de/pub/crypt/cryptlib/cl342.zip"
my_work big_int-1.0.7   big_int-1.0.7.tgz        "http://pecl.php.net/get/big_int-1.0.7.tgz"
my_work disphelper-0.81 disphelper_081.zip       "http://sourceforge.net/projects/disphelper/files/DispHelper/0.81/disphelper_081.zip/download"

# GL
my_work freeglut-2.8.0   freeglut-2.8.0.tar.gz    "http://sourceforge.net/projects/freeglut/files/freeglut/2.8.0/freeglut-2.8.0.tar.gz/download"
my_work glfw-2.7.7       glfw-2.7.7.tar.bz2       "http://sourceforge.net/projects/glfw/files/glfw/2.7.7/glfw-2.7.7.tar.bz2/download"

# console
my_work PDCurses-3.4     pdcurs34.zip           "http://sourceforge.net/projects/pdcurses/files/pdcurses/3.4/pdcurs34.zip/download"
#my_work libcaca-0.99.beta18 libcaca-0.99.beta18.tar.gz "http://caca.zoy.org/files/libcaca/libcaca-0.99.beta18.tar.gz"

# curl
my_work c-ares-1.9.1       c-ares-1.9.1.tar.gz        "http://c-ares.haxx.se/download/c-ares-1.9.1.tar.gz"
my_work libidn-1.26        libidn-1.26.tar.gz         "http://ftp.gnu.org/gnu/libidn/libidn-1.26.tar.gz"
my_work nettle-2.6         nettle-2.6.tar.gz          "http://www.lysator.liu.se/~nisse/archive/nettle-2.6.tar.gz"
my_work libtasn1-3.2       libtasn1-3.2.tar.gz        "http://ftp.gnu.org/gnu/libtasn1/libtasn1-3.2.tar.gz"
my_work gnutls-3.1.9       gnutls-3.1.9.1.tar.xz      "ftp://ftp.gnutls.org/gcrypt/gnutls/v3.1/gnutls-3.1.9.1.tar.xz"
my_work libmetalink-0.1.2  libmetalink-0.1.2.tar.bz2  "--no-check-certificate https://launchpad.net/libmetalink/trunk/packagingfix/+download/libmetalink-0.1.2.tar.bz2"
my_work curl-7.29.0        curl-7.29.0.tar.bz2        "http://curl.haxx.se/download/curl-7.29.0.tar.bz2"

# font
my_work freetype-2.4.11     freetype-2.4.11.tar.bz2  "http://sourceforge.net/projects/freetype/files/freetype2/2.4.11/freetype-2.4.11.tar.bz2/download"
#my_work fontconfig-2.10.91  fontconfig-2.10.91.tar.bz2 "http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.10.91.tar.bz2"

# images
my_work libpng-1.5.14  libpng-1.5.14.tar.xz  "http://prdownloads.sourceforge.net/libpng/libpng-1.5.14.tar.xz?download"
#my_work giflib-5.0.4   giflib-5.0.4.tar.bz2  "http://sourceforge.net/projects/giflib/files/giflib-5.x/giflib-5.0.4.tar.bz2/download"
my_work giflib-4.2.1   giflib-4.2.1.tar.bz2  "http://sourceforge.net/projects/giflib/files/giflib-4.x/giflib-4.2.1.tar.bz2/download"
my_work jpeg-9         jpegsrc.v9.tar.gz     "http://www.ijg.org/files/jpegsrc.v9.tar.gz"
my_work tiff-4.0.3     tiff-4.0.3.tar.gz     "ftp://ftp.remotesensing.org/pub/libtiff/tiff-4.0.3.tar.gz"
my_work lcms-1.19      lcms-1.19.tar.gz      "http://sourceforge.net/projects/lcms/files/lcms/1.19/lcms-1.19.tar.gz/download"
my_work lcms2-2.4      lcms2-2.4.tar.gz      "http://sourceforge.net/projects/lcms/files/lcms/2.4/lcms2-2.4.tar.gz/download"
my_work libmng-1.0.10-static libmng-1.0.10.tar.bz2 "http://sourceforge.net/projects/libmng/files/libmng-devel/1.0.10/libmng-1.0.10.tar.bz2/download"
my_work libmng-1.0.10-dll    libmng-1.0.10.tar.bz2 "http://sourceforge.net/projects/libmng/files/libmng-devel/1.0.10/libmng-1.0.10.tar.bz2/download"
my_work jasper-1.900.1 jasper-1.900.1.zip    "http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip"
my_work DevIL-1.7.8-static DevIL-1.7.8.tar.gz    "http://downloads.sourceforge.net/openil/DevIL-1.7.8.tar.gz"
my_work DevIL-1.7.8-dll    DevIL-1.7.8.tar.gz    "http://downloads.sourceforge.net/openil/DevIL-1.7.8.tar.gz"
my_work FreeImage-3.15.4-static  FreeImage3154.zip  "http://sourceforge.net/projects/freeimage/files/Source%20Distribution/3.15.4/FreeImage3154.zip/download"
my_work FreeImage-3.15.4-dll     FreeImage3154.zip  "http://sourceforge.net/projects/freeimage/files/Source%20Distribution/3.15.4/FreeImage3154.zip/download"
my_work gd-73cab5d8af96  gd-73cab5d8af96.zip  "--no-check-certificate https://bitbucket.org/libgd/gd-libgd/get/73cab5d8af96.zip"
#my_work pixman-0.28.2  pixman-0.28.2.tar.gz  "http://cairographics.org/releases/pixman-0.28.2.tar.gz"
#my_work cairo-1.12.14  cairo-1.12.14.tar.xz  "http://cairographics.org/releases/cairo-1.12.14.tar.xz"

my_work grx-2.4.9      grx249s.zip           "http://grx.gnu.de/download/grx249s.zip"
my_work libwebp-0.3.0  libwebp-0.3.0.tar.gz  "--no-check-certificate https://webp.googlecode.com/files/libwebp-0.3.0.tar.gz"
my_work pdflib-4.0.2   pdflib-4.0.2-src.zip  "http://sourceforge.net/projects/gnuwin32/files/pdflib-lite/4.0.2/pdflib-4.0.2-src.zip/download"

#my_work glib-2.34.3    glib-2.34.3.tar.xz    "http://ftp.gnome.org/pub/gnome/sources/glib/2.34/glib-2.34.3.tar.xz"

# physics
#my_work Chipmunk-4.1.0  Chipmunk-4.1.0.tgz    "http://chipmunk-physics.net/release/Chipmunk-4.x/Chipmunk-4.1.0.tgz"
##my_work Chipmunk-6.1.4  Chipmunk-6.1.4.tgz    "http://chipmunk-physics.net/release/Chipmunk-6.x/Chipmunk-6.1.4.tgz"
#my_work ode-0.12        ode-0.12.tar.bz2      "http://sourceforge.net/projects/opende/files/ODE/0.12/ode-0.12.tar.bz2/download"

my_work SDL-1.2.15        SDL-1.2.15.tar.gz        "http://www.libsdl.org/release/SDL-1.2.15.tar.gz"
my_work SDL_image-1.2.12  SDL_image-1.2.12.tar.gz  "http://www.libsdl.org/projects/SDL_image/release/SDL_image-1.2.12.tar.gz"
my_work SDL_net-1.2.8     SDL_net-1.2.8.tar.gz     "http://www.libsdl.org/projects/SDL_net/release/SDL_net-1.2.8.tar.gz"
#my_work SDL_mixer-1.2.12  SDL_mixer-1.2.12.tar.gz  "http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-1.2.12.tar.gz"
my_work SDL_ttf-2.0.11    SDL_ttf-2.0.11.tar.gz    "http://www.libsdl.org/projects/SDL_ttf/release/SDL_ttf-2.0.11.tar.gz"

# audio
my_work libogg-1.3.0        libogg-1.3.0.tar.xz         "http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.xz"
my_work liboggz-1.1.1       liboggz-1.1.1.tar.gz        "http://downloads.xiph.org/releases/liboggz/liboggz-1.1.1.tar.gz"
my_work libvorbis-1.3.3     libvorbis-1.3.3.tar.xz      "http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.xz"
my_work libtheora-1.1.1     libtheora-1.1.1.tar.bz2     "http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2"
my_work flac-1.2.1          flac-1.2.1.tar.gz           "http://sourceforge.net/projects/flac/files/flac-src/flac-1.2.1-src/flac-1.2.1.tar.gz/download"
#my_work ffmpeg-1.2          ffmpeg-1.2.tar.bz2          "http://ffmpeg.org/releases/ffmpeg-1.2.tar.bz2"

#my_work libsndfile-1.0.25   libsndfile-1.0.25.tar.gz    "http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.25.tar.gz"
#my_work PortAudio-v19-20111121 pa_stable_v19_20111121.tgz "http://www.portaudio.com/archives/pa_stable_v19_20111121.tgz"
my_work openal-soft-1.15.1  openal-soft-1.15.1.tar.bz2  "http://kcat.strangesoft.net/openal-releases/openal-soft-1.15.1.tar.bz2"
#my_work mpg123-1.15.3       mpg123-1.15.3.tar.bz2       "http://sourceforge.net/projects/mpg123/files/mpg123/1.15.3/mpg123-1.15.3.tar.bz2/download"
#my_work libmms-0.6.2        libmms-0.6.2.tar.gz         "http://sourceforge.net/projects/libmms/files/libmms/0.6.2/libmms-0.6.2.tar.gz/download"
#my_work libzen-0.4.28       libzen_0.4.28.tar.bz2       "http://mediaarea.net/download/source/libzen/0.4.28/libzen_0.4.28.tar.bz2"
#my_work libmediainfo-0.7.62 libmediainfo_0.7.62.tar.bz2 "http://mediaarea.net/download/source/libmediainfo/0.7.62/libmediainfo_0.7.62.tar.bz2"
#my_work vlc-2.0.5           vlc-2.0.5.tar.xz            "ftp://ftp.videolan.org/pub/videolan/vlc/2.0.5/vlc-2.0.5.tar.xz"

# database
#my_work gdbm-1.10           gdbm-1.10.tar.gz            "ftp://ftp.gnu.org/gnu/gdbm/gdbm-1.10.tar.gz"
#my_work mysql-5.6.10        mysql-5.6.10.tar.gz         "http://www.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.10.tar.gz/from/http://cdn.mysql.com/"
#my_work postgresql-9.2.4    postgresql-9.2.4.tar.bz2    "http://ftp.postgresql.org/pub/source/v9.2.4/postgresql-9.2.4.tar.bz2"
my_work sqlite-3071601      sqlite-amalgamation-3071601.zip    "http://sqlite.org/2013/sqlite-amalgamation-3071601.zip"

my_work lua-5.2.2           lua-5.2.2.tar.gz            "http://www.lua.org/ftp/lua-5.2.2.tar.gz"
#my_work SpiderMonkey-17.0.0 mozjs17.0.0.tar.gz          "http://ftp.mozilla.org/pub/mozilla.org/js/mozjs17.0.0.tar.gz"
#my_work json-c-0.9          json-c-0.9.tar.gz           "http://oss.metaparadigm.com/json-c/json-c-0.9.tar.gz"
my_work cgi-util-2.2.1      cgi-util-2.2.1.tar.gz       "ftp://ftp.tuxpaint.org/unix/www/cgi-util/cgi-util-2.2.1.tar.gz"
#my_work fcgi-current        fcgi.tar.gz                 "http://www.fastcgi.com/dist/fcgi.tar.gz"
#my_work zeromq-3.2.2        zeromq-3.2.2.tar.gz         "http://download.zeromq.org/zeromq-3.2.2.tar.gz"

# Copy in the libraries
cp $prefix/bin/*.dll fbc/bin/win32
cp $prefix/lib/*.a   fbc/lib/win32

################################################################################
# Build a set of binutils for cross-compiling from win32 to linux

build_binutils()
{
	srcdir="$1"
	builddir="$2"
	confflags="$3"

	# build
	if [ ! -d "$builddir" ]; then
		my_report "building $binutilsname"

		mkdir "$builddir"
		cd "$builddir"

		CFLAGS="-O2" \
		CXXFLAGS="-O2" \
		"../$srcdir/configure" $confflags --prefix=/usr \
			--disable-shared --enable-static \
			--disable-nls --disable-werror

		make
		cd ..
	fi
}

binutilsname=binutils-2.23.2
binutilstarball=$binutilsname.tar.bz2
binutilswin32=$binutilsname-build-win32
binutilslinux=$binutilsname-build-linux

my_fetch  $binutilstarball  "http://ftp.gnu.org/gnu/binutils/$binutilstarball"
my_extract  $binutilsname  $binutilstarball

build_binutils $binutilsname $binutilswin32 "--host=$triplet --target=$triplet"
cp $binutilswin32/binutils/ar.exe      fbc/bin/win32/ar.exe
cp $binutilswin32/binutils/dlltool.exe fbc/bin/win32/dlltool.exe
cp $binutilswin32/gas/as-new.exe       fbc/bin/win32/as.exe
cp $binutilswin32/gprof/gprof.exe      fbc/bin/win32/gprof.exe
cp $binutilswin32/ld/ld-new.exe        fbc/bin/win32/ld.exe

build_binutils $binutilsname $binutilslinux "--host=$triplet --target=i486-pc-linux-gnu"
cp $binutilslinux/binutils/ar.exe fbc/bin/linux/ar.exe
cp $binutilslinux/gas/as-new.exe  fbc/bin/linux/as.exe
cp $binutilslinux/ld/ld-new.exe   fbc/bin/linux/ld.exe

################################################################################
# Build win32 gdb

gdbname=gdb-7.5.1
gdbtarball=$gdbname.tar.bz2
gdbwin32=$gdbname-build

my_fetch  $gdbtarball  "http://ftp.gnu.org/gnu/gdb/$gdbtarball"
my_extract  $gdbname  $gdbtarball

# build
if [ ! -d "$gdbwin32" ]; then
	my_report "building $gdbname"

	mkdir "$gdbwin32"
	cd "$gdbwin32"

	CPPFLAGS="-I$prefix/include" \
	CFLAGS="-O2 -I$prefix/include" \
	CXXFLAGS="-O2 -I$prefix/include" \
	LDFLAGS="-static-libgcc -static -L$prefix/lib" \
	"../$gdbname/configure" --host=i686-w64-mingw32 --target=i686-w64-mingw32 \
		--prefix=/usr \
		--disable-shared --enable-static \
		--disable-nls

	make

	cp gdb/gdb.exe ../fbc/bin/win32

	cd ..
fi

################################################################################

$STRIP -g fbc/bin/linux/* fbc/bin/win32/* fbc/lib/win32/*

my_report "checking libs for hard-coded paths"
for f in fbc/bin/linux/* fbc/bin/win32/* fbc/lib/win32/*; do
	text=`$STRINGS $f | grep $toplevel || echo`
	if [ -n "$text" ]; then
		echo "*** $f: ***"
		echo "$text"
	fi
done
