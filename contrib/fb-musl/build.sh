#!/bin/bash
set -e

toplevel="$PWD"
mkdir -p src

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
		if [ "$top" != "$name" ]; then
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

# Copy patches
cp `dirname "$0"`/*.patch src

muslcrossrev=74d6e78976bd
muslcrossname=GregorR-musl-cross-$muslcrossrev
muslcrosstarball=$muslcrossname.tar.bz2
my_fetch  $muslcrosstarball  "https://bitbucket.org/GregorR/musl-cross/get/$muslcrossrev.tar.bz2"

################################################################################
# Build an i486-linux-musl cross compiler toolchain with the help of the
# musl-cross scripts.

toolchainbackup="i486-linux-musl.tar.xz"
if [ -f "$toolchainbackup" ]; then
	if [ ! -d i486-linux-musl ]; then
		my_report "extracting toolchain backup"
		tar -xf "$toolchainbackup"
	fi
else
	my_extract  musl-cross  $muslcrosstarball

	# Relink musl-cross' tarballs dir to our src dir
	rm musl-cross/tarballs/empty
	rmdir musl-cross/tarballs
	ln -s ../src musl-cross/tarballs

	if [ ! -d i486-linux-musl ]; then
		my_report "building musl-cross toolchain"

		cd musl-cross
		echo "ARCH=i486" > config.sh
		echo "CC_BASE_PREFIX=$toplevel" >> config.sh
		echo "MUSL_CONFFLAGS=\"--disable-debug --disable-shared --enable-static\"" >> config.sh
		echo "GCC_BUILTIN_PREREQS=yes" >> config.sh
		echo "GCC_CONFFLAGS=--disable-shared" >> config.sh

		export CFLAGS="-O2"
		export CXXFLAGS="-O2"
		./build.sh
		unset CFLAGS
		unset CXXFLAGS
		cd ..

		# Since rebuilding the toolchain takes so long, create a backup,
		# so the tree can easily be restored to its original state,
		# after installing tons of other stuff into it...
		tar -cJf "$toolchainbackup" i486-linux-musl
	fi
fi

# Setup a sysroot with usr/ directory and copy in the toolchain's target libs
# and headers
# (TODO: gcc should be built with proper --with-sysroot)
sysroot=$toplevel/sysroot
prefix=$sysroot/usr
if [ ! -d $sysroot ]; then
	mkdir -p sysroot/usr
	mv $toplevel/i486-linux-musl/i486-linux-musl/* $prefix
	rmdir $toplevel/i486-linux-musl/i486-linux-musl
	ln -s ../sysroot/usr $toplevel/i486-linux-musl/i486-linux-musl
fi

################################################################################
# Build various libs used by FB rtlib/gfxlib2 (i.e. needed for FB programs),
# including headers needed just to compile the FB rtlib/gfxlib2

my_patch()
{
	local name="$1"

	# patch
	if [ ! -f $name/patch-done ]; then
		cd $name

		case $name in
		alsa-lib-*)
			patch -p1 < ../src/alsa-lib.patch
			;;
		Chipmunk-*)
			patch -p0 < ../src/chipmunk.patch
			;;
		cryptlib-*)
			find . -type f -print0 | xargs -0 dos2unix && true
			patch -p0 < ../src/cryptlib.patch
			;;
		DevIL-*)
			patch -p0 < ../src/DevIL.patch
			;;
		flac-*)
			patch -p0 < ../src/flac.patch
			;;
		freeglut-*)
			patch -p0 < ../src/freeglut.patch
			;;
		FreeImage-*)
			patch -p0 < ../src/freeimage.patch
			;;
		gd-2.0.33)
			patch -p0 < ../src/gd.patch
			rm configure.in
			autoreconf
			;;
		gd-73cab5d8af96)
			autoreconf -fi
			;;
		glib-*)
			patch -p1 < ../src/glib.patch
			;;
		grx-*-con)
			patch -p0 < ../src/grx-con.patch
			;;
		jasper-*)
			patch -p0 < ../src/jasper.patch
			;;
		jpeg-*)
			patch -p0 < ../src/jpeglib.patch
			;;
		libjit-*)
			patch -p0 < ../src/libjit.patch
			;;
		libmediainfo-*)
			find . -type f -print0 | xargs -0 dos2unix && true
			patch -p0 < ../src/libmediainfo.patch
			;;
		libpciaccess-*)
			patch -p0 < ../src/libpciaccess.patch
			;;
		libusb-*)
			patch -p0 < ../src/libusb.patch
			;;
		libxml2-*)
			patch -p0 < ../src/libxml2.patch
			;;
		libXxf86dga-*)
			patch -p0 < ../src/libXxf86dga.patch
			;;
		libzen-*)
			patch -p0 < ../src/libzen.patch
			;;
		Mesa-*)
			patch -p0 < ../src/mesa.patch
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

		export CPPFLAGS="-D_GNU_SOURCE"
		export CFLAGS="-O2 -Werror-implicit-function-declaration"
		export CXXFLAGS="-O2"
		export CPP="$toplevel/i486-linux-musl/bin/i486-linux-musl-cpp"
		export  CC="$toplevel/i486-linux-musl/bin/i486-linux-musl-gcc"
		export CXX="$toplevel/i486-linux-musl/bin/i486-linux-musl-g++"
		export  LD="$toplevel/i486-linux-musl/bin/i486-linux-musl-ld"
		##export LDFLAGS="-static-libgcc -Wl,-Bstatic"

		case $name in
		util-macros-*|xproto-*|xextproto-*|renderproto-*|\
		randrproto-*|kbproto-*|inputproto-*|xtrans-*|\
		xcb-proto-*|dri2proto-*|xtrans-*|\
		xf86dgaproto-*|xf86vidmodeproto-*|videoproto-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr
			make
			make install DESTDIR=$sysroot
			;;

		big_int-*)
			cd $name/libbig_int
			$CC $CPPFLAGS $CFLAGS -Wall -c -I include src/*.c src/low_level_funcs/*.c
			ar rcs libbig_int.a *.o
			cp libbig_int.a $prefix/lib
			mkdir -p $prefix/include/big_int
			cp include/*.h $prefix/include/big_int
			cd ../..
			;;

		bzip2-*)
			make libbz2.a CC="$CC" CFLAGS="-O2 -D_FILE_OFFSET_BITS=64"
			cp bzlib.h $prefix/include
			cp libbz2.a $prefix/lib
			;;

		cairo-*)
			LIBS="-lxcb -lXau" \
			xlib_xrender_LIBS="-lXrender -lX11 -lxcb -lXau" \
			FONTCONFIG_LIBS="-lfontconfig -lexpat -lfreetype -lbz2 -lz" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-gtk-doc-html
			make
			make install DESTDIR=$sysroot
			;;

		Chipmunk-*)
			# Defining NDEBUG to disable some assert()'s in Chipmunk source code,
			# that would otherwise insert hard-coded source code file names into
			# the lib, that would be ugly and unnecessary.
			export CFLAGS="-DNDEBUG -O2 -Werror-implicit-function-declaration"
			cmake . \
				-DCMAKE_C_COMPILER="$CC" \
				-DCMAKE_CXX_COMPILER="$CXX" \
				-DCMAKE_INSTALL_PREFIX=/usr \
				-DCMAKE_FIND_ROOT_PATH=$prefix \
				-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
				-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY
			make
			make install DESTDIR=$sysroot
			;;

		cryptlib-*)
			make CPP="$CPP" CC="$CC" CXX="$CXX" LD="$LD" \
				CFLAGS="-c -D__UNIX__ -DNDEBUG -I. -DNO_ADDRESS=NO_DATA -Werror-implicit-function-declaration"
			cp libcl.a $prefix/lib
			;;

		curl-*)
			LIBS="-ltasn1 -lhogweed -lnettle -lgmp" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-nls \
				--with-gnutls
			make
			make install DESTDIR=$sysroot
			;;

		DevIL-*)
			LIBS="-lxcb -lXau" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--enable-ILU --enable-ILUT
			make
			make install DESTDIR=$sysroot
			;;

		e2fsprogs-*)
			mkdir build
			cd build
			../configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-debugfs \
				--disable-imager \
				--disable-resizer \
				--disable-defrag \
				--disable-uuidd \
				--disable-fsck \
				--disable-e2initrd-helper \
				--disable-nls
			make
			make install-libs DESTDIR=$sysroot
			cd ..
			;;

		flac-*)
			# build only libFLAC
			make -f Makefile.lite libFLAC \
				CPP="$CPP -Werror-implicit-function-declaration" \
				CC="$CC -Werror-implicit-function-declaration" \
				CXX="$CXX -Werror-implicit-function-declaration" \
				LD="$LD" \
				CCC="$CXX -Werror-implicit-function-declaration" \
				OGG_INCLUDE_DIR=$prefix/include \
				OGG_LIB_DIR=$prefix/lib

			# libFLAC headers
			mkdir -p $prefix/include/FLAC
			cp include/FLAC/*.h $prefix/include/FLAC

			# libFLAC.a
			cp obj/release/lib/libFLAC.a $prefix/lib

			# flac.pc for pkg-config
			sed	-e 's|@prefix@|/usr|g' \
				-e 's|@exec_prefix@|${prefix}|g' \
				-e 's|@libdir@|${exec_prefix}/lib|g' \
				-e 's|@includedir@|${prefix}/include|g' \
				-e 's|@VERSION@|1.2.1|g' \
				src/libFLAC/flac.pc.in \
				> $prefix/lib/pkgconfig/flac.pc
			;;

		ffmpeg-*)
			./configure \
				--prefix=/usr \
				--cc=$CC --cxx=$CXX \
				--disable-programs --disable-doc 
			make
			;;

		fontconfig-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-docs
			make
			make install DESTDIR=$sysroot
			;;

		freeglut-*)
			LIBS="-lxcb -lXau -lXrandr -lXi" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			;;

		FreeImage-*)
			unset CFLAGS
			make -f Makefile.gnu libfreeimage.a  CC="$CC" CXX="$CXX"
			cp Source/FreeImage.h $prefix/include
			cp libfreeimage.a $prefix/lib
			;;

		gettext-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
				#--enable-relocatable
			make
			make install DESTDIR=$sysroot
			;;

		gd-2.0.33)
			LIBS="-lbz2 -lexpat -lxcb -lXau -lXdmcp -pthread -ldl -lm" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			;;

		gd-73cab5d8af96)
			LIBS="-llzma -lexpat -lbz2 -lz -lX11 -lxcb -lXau" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--with-zlib=$prefix \
				--with-png=$prefix \
				--with-freetype=$prefix \
				--with-fontconfig=$prefix \
				--with-jpeg=$prefix \
				--with-xpm=$prefix \
				--with-tiff=$prefix
			make
			make install DESTDIR=$sysroot

			#cmake . \
			#	-DENABLE_PNG=1 -DENABLE_JPEG=1 -DENABLE_TIFF=1 \
			#	-DENABLE_XPM=1 -DENABLE_FREETYPE=1 -DENABLE_WEBP=1 \
			#	-DCMAKE_C_COMPILER="$CC" \
			#	-DCMAKE_CXX_COMPILER="$CXX" \
			#	-DCMAKE_INSTALL_PREFIX=/usr \
			#	-DCMAKE_FIND_ROOT_PATH=$prefix \
			#	-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
			#	-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY
			#make
			#make install DESTDIR=$sysroot
			;;

		glfw-*)
			make x11 x11-install PREFIX=$prefix \
				CC="$CC" \
				CXX="$CXX" \
				LD="$LD" \
				LFLAGS="$LFLAGS"' $(LIB) -lGLU -lGL -lXrandr -lXrender -lX11 -lxcb -lXau -lXext -pthread -lm -lstdc++' \
				SO_LFLAGS='$(SOLIB) -lGLU -lGL -lXrandr -lXrender -lX11 -lxcb -lXau -lXext -pthread -lm -lstdc++'
			;;

		glib-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-modular-tests \
				--disable-gtk-doc-html \
				--with-pcre=system
			make
			make install DESTDIR=$sysroot
			;;

		gmp-*)
			# gmplib's configure breaks with -Werror-implicit-function-declaration
			export CFLAGS="-O2"
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make CFLAGS="-O2 -Werror-implicit-function-declaration"
			make install DESTDIR=$sysroot
			;;

		gnutls-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-nls
			make
			make install DESTDIR=$sysroot
			;;

		gpm-*)
			# gpm header for FB rtlib build
			cp src/headers/gpm.h $prefix/include
			;;

		grx-*-con)
			make -f makefile.lnx libs \
				HAVE_LIBJPEG=y \
				HAVE_LIBPNG=y \
				NEED_ZLIB=y \
				INCLUDE_BGI_SUPPORT=n \
				USE_DIRECT_MOUSE_DRIVER=y \
				USE_SVGALIB_DRIVER=n \
				USE_FRAMEBUFFER_DRIVER=y \
				SET_SUIDROOT=n \
				prefix="$sysroot" \
				CCOPT="$CPPFLAGS $CFLAGS -fno-strict-aliasing -Wall -DLFB_BY_NEAR_POINTER" \
				LDOPT="$LDFLAGS -s" \
				CC="$CC" \
				CXX="$CXX" \
				LD="$LD"
			cp lib/unix/libgrx20.a $prefix/lib
			;;

		grx-*-X)
			make -f makefile.x11 libs \
				HAVE_LIBJPEG=y \
				HAVE_LIBPNG=y \
				NEED_ZLIB=y \
				INCLUDE_BGI_SUPPORT=n \
				X11LIBS="-lX11 -lxcb -lXau" \
				prefix="$sysroot" \
				CCOPT="$CPPFLAGS $CFLAGS -fno-strict-aliasing -Wall" \
				LDOPT="$LDFLAGS -s" \
				CC="$CC" \
				CXX="$CXX" \
				LD="$LD"
			cp lib/unix/libgrx20X.a $prefix/lib
			;;

		jasper-*)
			LIBS="-lxcb -lXau" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			;;

		lcms-*|lcms2-*)
			LIBS="-llzma" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			;;

		libcaca-*)
			LIBS="-lGL -lstdc++ -lX11 -lxcb -lXau -lXi -lXrandr -lXrender -lX11 -lXext" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-csharp \
				--disable-java \
				--disable-cxx \
				--disable-python \
				--disable-ruby \
				--disable-doc
			make
			make install DESTDIR=$sysroot
			;;

		libelf-*)
			# libelf's configure doesn't work with -Werror-implicit-function-declaration
			CFLAGS="-O2" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--enable-compat
			make CFLAGS="$CFLAGS"
			make install instroot=$sysroot
			;;

		libiconv-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
				#--enable-relocatable
			make
			make install DESTDIR=$sysroot
			;;

		libidn-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-nls \
				--disable-cxx \
				--disable-doc \
				--disable-crywrap \
				--without-p11-kit \
				--without-tpm
			make
			make install DESTDIR=$sysroot
			;;

		libjit-*)
			./auto_gen.sh
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			;;

		libmediainfo-*)
			cd Project/GNU/Library
			./autogen
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--enable-staticlibs \
				--with-libtinyxml2 \
				--with-libcurl \
				--with-libmms
			make
			make install DESTDIR=$sysroot
			cd ../../..
			;;

		libmng-*)
			make -f makefiles/makefile.linux libmng.a \
				CC="$CC" \
				prefix=$prefix \
				ZLIBLIB=$prefix/lib \
				ZLIBINC=$prefix/include \
				JPEGLIB=$prefix/lib \
				JPEGINC=$prefix/include \
				LCMSLIB=$prefix/lib \
				LCMSINC=$prefix/include
			cp libmng.h libmng_conf.h libmng_types.h $prefix/include
			cp libmng.a $prefix/lib
			;;

		liboggz-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-oggtest
			make
			make install DESTDIR=$sysroot
			;;

		libtheora-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-oggtest \
				--disable-vorbistest \
				--disable-sdltest \
				--disable-examples
			make
			make install DESTDIR=$sysroot
			;;

		libwebp-*)
			#make -f makefile.unix CC="$CC" \
			#	DWEBP_LIBS='-lpng -lz' \
			#	CWEBP_LIBS='-lpng -ltiff -ljpeg -llzma -lz'

			LIBPNG_CONFIG="$prefix/bin/libpng-config --static" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			;;

		libxslt-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--without-plugins \
				--without-debug \
				--without-debugger \
				--without-python \
				--without-crypto \
				--with-libxml-prefix=$prefix \
				--with-libxml-include-prefix=$prefix/include \
				--with-libxml-libs-prefix=$prefix/lib
			make
			make install DESTDIR=$sysroot
			;;

		libzen-*)
			cd Project/GNU/Library
			./autogen
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			cd ../../..
			;;

		lua-*)
			make linux install INSTALL_TOP=$prefix \
				CC="$CC" \
				MYCFLAGS="$CPPFLAGS $CFLAGS" \
				MYLDFLAGS="$LDFLAGS" \
				MYLIBS="-ltinfo"
			;;

		Mesa-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-egl \
				--disable-dri \
				--enable-osmesa \
				--enable-xa \
				--disable-gbm \
				--disable-xvmc \
				--disable-vdpau \
				--enable-xlib-glx \
				--disable-gallium-gbm \
				--disable-shared-glapi \
				--disable-driglx-direct \
				--disable-gallium-llvm \
				--without-gallium-drivers
			make
			make install DESTDIR=$sysroot
			;;

		mxml-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--enable-threads
			make
			make install DSTROOT=$sysroot
			;;

		ncurses-*)
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
			make install DESTDIR=$sysroot
			;;

		nettle-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-openssl \
				--disable-documentation
			make
			make install DESTDIR=$sysroot
			;;

		ode-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-demos
			make
			make install DESTDIR=$sysroot
			;;

		openal-soft-*)
			# Add -DNDEBUG to disable some assert()s
			export CFLAGS="-DNDEBUG -O2 -Werror-implicit-function-declaration"
			cmake . \
				-DCMAKE_C_COMPILER="$CC" \
				-DCMAKE_CXX_COMPILER="$CXX" \
				-DCMAKE_INSTALL_PREFIX=/usr \
				-DCMAKE_FIND_ROOT_PATH=$prefix \
				-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
				-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
				-DLIBTYPE=STATIC
			make
			make install DESTDIR=$sysroot
			;;

		pcre-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--enable-pcre16 --enable-pcre32 \
				--disable-cpp \
				--enable-utf --enable-unicode-properties
			make
			make install DESTDIR=$sysroot
			;;

		pdflib-*)
			cd src
			autoconf
			LIBS="-ljpeg -llzma -lz" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-php \
				--without-java --without-perl --without-py \
				--without-tcl \
				--with-tifflib --with-zlib --with-pnglib
			make pdflib CPPFLAGS="$CPPFLAGS" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"
			make install prefix=$prefix
			cd ..
			;;

		QuickLZ-*)
			$CC -Wall $CFLAGS -c quicklz.c
			ar rcs libquicklz.a quicklz.o
			cp libquicklz.a $prefix/lib
			;;

		SDL-*)
			LIBS="-lxcb -lXau" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			;;

		SDL_image-*)
			LIBS="-llzma" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			;;

		SDL_ttf-*)
			LIBS="-lxcb -lXau -lXdmcp" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			;;

		tiff-*)
			LIBS="-lX11 -lxcb -lXau" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			;;

		TinyPTC-X11-*)
			touch .depend
			make CC="$CC" CPP="$CPP" LD="$CC" \
				CFLAGS="$CFLAGS -Wall -Wno-unknown-pragmas -Os" \
				INCLUDES="" \
				LIBS="-lX11 -lXext -lXxf86dga -lXxf86vm -lXv -lxcb -lXau"
			cp libtinyptc.a $prefix/lib
			;;

		tinyxml2-*)
			unset LDFLAGS
			cmake . \
				-DCMAKE_C_COMPILER="$CC" \
				-DCMAKE_CXX_COMPILER="$CXX" \
				-DCMAKE_INSTALL_PREFIX=/usr \
				-DCMAKE_FIND_ROOT_PATH=$prefix \
				-DBUILD_STATIC_LIBS=ON
			make
			make install DESTDIR=$sysroot
			;;

		tre-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-agrep \
				--disable-nls
			make
			make install DESTDIR=$sysroot
			;;

		xz-*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-xz --disable-xzdec --disable-lzmadec \
				--disable-lzmainfo --disable-lzma-links \
				--disable-scripts --disable-nls
			make
			make install DESTDIR=$sysroot
			;;

		zlib-*)
			./configure --static --prefix=/usr
			make
			make install DESTDIR=$sysroot
			;;

		*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			;;
		esac

		unset CPPFLAGS
		unset CFLAGS
		unset CXXFLAGS
		unset CPP
		unset CC
		unset CXX
		unset LD

		cd ..

		# Fix paths in *.la files and also all the *-config scripts
		for f in `find sysroot -type f -name "*.la"` \
		         `find sysroot/usr/bin -type f -name "*-config"`; do

			cat $f | sed \
				-e "s:$prefix:/usr:g" \
				-e "s:/usr:$prefix:g" \
				> $f.tmp

			# Overwrite original with temp file, preserve executable bit
			if [ -x "$f" ]; then
				setexec=yes
			else
				setexec=no
			fi
			mv $f.tmp $f
			if [ "$setexec" = "yes" ]; then
				chmod +x $f
			fi
		done

		# Copy the fixed *-config scripts into our PATH, plus any
		# *-config symlinks, so following builds can find them.
		configscripts=`find sysroot/usr/bin "(" -type f -o -type l ")" -a -name "*-config"`
		if [ -n "$configscripts" ]; then
			cp $configscripts path
		fi

		touch $name/build-done
	fi
}

my_work()
{
	local name="$1"
	local tarball="$2"
	local url="$3"

	my_fetch $tarball $url
	my_extract $name $tarball
	my_patch $name
	my_build $name
}

# We should build packages with --prefix=/usr, at least those that hard-code
# the prefix path (e.g. ncurses for accessing the terminfo database at runtime),
# but we want to install into $sysroot as if cross-compiling, instead of
# trashing the host system's /usr directory.
#
# On the other hand, many of the libs we build here try to "find" previously
# built libs, via pkg-config or custom foo-config scripts, e.g. by doing
# `pkg-config --cflags foo` which would return something like
# "-I/usr/include/foo", allowing foo's custom include dir to be found.
#
# It should produce "-I$prefix/include/foo" though, since we want libs
# to find their dependencies in our $prefix, not in the host system's
# /usr dir, because
#  a) we're building (even "cross-compiling") for musl libc, not the native
#     system which is typically glibc, thus most binaries will be incompatible
#     (e.g. glibc re-#defines printf() to __printf_chk(), musl libc doesn't
#      have that)
#  b) we may not build all possible dependencies, and instead want some features
#     of a lib to be disabled (e.g. libcurl; it can make use of many different
#     third-party libs, but we may not want to/be able to/be allowed to build
#     and distribute all of them)
#
# For pkg-config we can set some environment variables to prevent it from
# searching in host system dirs and return the proper dirs in $prefix
# despite the .pc files there containing only the /usr prefix (due to the
# packages being built with --prefix=/usr), this covers queries such as
# `pkg-config --cflags foo`.
#
# According to
#   http://www.flameeyes.eu/autotools-mythbuster/pkgconfig/cross-compiling.html
# queries such as `pkg-config --variable=bar foo` are not covered, and since
# we have some packages using that (e.g. libxcb's configure), we use a
# pkg-config wrapper script that inserts the $sysroot path for these cases.
#
# However, not all packages use pkg-config - some also rely on custom foo-config
# scripts to find/identify dependencies. For example, libxslt looks for
# libxml2's xml2-config script to find libxml2.
# These foo-config will also all use a /usr prefix, and since there's no generic
# environment variable to set to fix it, they should be updated individually.
# The same goes for *.la (libtool archives) files.
# (this fix up is done above in my_build(), at the end of each package's build)

# pkg-config wrapper script
mkdir -p path
echo '#!/bin/sh'                                      >  path/pkg-config
echo ''                                               >> path/pkg-config
echo 'variable=""'                                    >> path/pkg-config
echo ''                                               >> path/pkg-config
echo 'for arg in "$@"; do'                            >> path/pkg-config
echo '    case "$arg" in'                             >> path/pkg-config
echo '    --variable=*)'                              >> path/pkg-config
echo '        test -n "$variable" && echo "$0: multiple --variable options given" && exit 1' >> path/pkg-config
echo '        variable=`echo "$arg" | sed -e "s/--variable=//g"`' >> path/pkg-config
echo '        ;;'                                     >> path/pkg-config
echo '    esac'                                       >> path/pkg-config
echo 'done'                                           >> path/pkg-config
echo ''                                               >> path/pkg-config
echo "# Reset PATH to original without this script's parent dir in it" >> path/pkg-config
echo "export PATH=\"$PATH\""                          >> path/pkg-config
echo ''                                               >> path/pkg-config
echo "sysroot=\"$sysroot\""                           >> path/pkg-config
echo ''                                               >> path/pkg-config
echo 'if [ -n "$variable" ]; then'                    >> path/pkg-config
echo '    echo ${sysroot}`pkg-config $@ | sed -e "s,^$sysroot,,g"`' >> path/pkg-config
echo 'else'                                           >> path/pkg-config
echo '    pkg-config $@'                              >> path/pkg-config
echo 'fi'                                             >> path/pkg-config
chmod +x path/pkg-config

# Add the pkg-config wrapper to PATH, before the real pkg-config
export PATH="$toplevel/path:$toplevel/i486-linux-musl/bin:$PATH"

# Prevent pkg-config from looking in host system's dirs
export PKG_CONFIG_DIR=
export PKG_CONFIG_PATH=$prefix/lib/pkgconfig:$prefix/share/pkgconfig
export PKG_CONFIG_LIBDIR=$prefix/lib

# Let pkg-config prepend $sysroot to most returned paths
export PKG_CONFIG_SYSROOT_DIR=$sysroot

my_work e2fsprogs-1.42.7  e2fsprogs-1.42.7.tar.gz  "http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.42.7.tar.gz"
my_work libusb-1.0.9      libusb-1.0.9.tar.bz2     "http://sourceforge.net/projects/libusb/files/libusb-1.0/libusb-1.0.9/libusb-1.0.9.tar.bz2"
my_work libffi-3.0.12     libffi-3.0.12.tar.gz     "ftp://sourceware.org/pub/libffi/libffi-3.0.12.tar.gz"
my_work libjit-749e162d71eb295ff1e195cd4fd78f345c325773  libjit-749e162d71eb295ff1e195cd4fd78f345c325773.tar.gz  "http://git.savannah.gnu.org/cgit/libjit.git/snapshot/libjit-749e162d71eb295ff1e195cd4fd78f345c325773.tar.gz"
my_work libelf-0.8.13     libelf-0.8.13.tar.gz     "http://www.mr511.de/software/libelf-0.8.13.tar.gz"

# compression
my_work zlib-1.2.7     zlib-1.2.7.tar.bz2     "http://prdownloads.sourceforge.net/libpng/zlib-1.2.7.tar.bz2?download"
my_work libzip-0.10.1  libzip-0.10.1.tar.bz2  "http://www.nih.at/libzip/libzip-0.10.1.tar.bz2"
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
my_work tinyxml2-master tinyxml2-master.zip      "https://github.com/leethomason/tinyxml2/archive/master.zip"
my_work mxml-2.7        mxml-2.7.tar.gz          "http://ftp.easysw.com/pub/mxml/2.7/mxml-2.7.tar.gz"
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

# X protocol headers and libs needed for the libX11 etc. builds
my_work util-macros-1.17      util-macros-1.17.tar.bz2     "http://ftp.x.org/pub/individual/util/util-macros-1.17.tar.bz2"
my_work xproto-7.0.23         xproto-7.0.23.tar.bz2        "http://ftp.x.org/pub/individual/proto/xproto-7.0.23.tar.bz2"
my_work xextproto-7.2.1       xextproto-7.2.1.tar.bz2      "http://ftp.x.org/pub/individual/proto/xextproto-7.2.1.tar.bz2"
my_work renderproto-0.11.1    renderproto-0.11.1.tar.bz2   "http://ftp.x.org/pub/individual/proto/renderproto-0.11.1.tar.bz2"
my_work randrproto-1.4.0      randrproto-1.4.0.tar.bz2     "http://ftp.x.org/pub/individual/proto/randrproto-1.4.0.tar.bz2"
my_work kbproto-1.0.6         kbproto-1.0.6.tar.bz2        "http://ftp.x.org/pub/individual/proto/kbproto-1.0.6.tar.bz2"
my_work inputproto-2.3        inputproto-2.3.tar.bz2       "http://ftp.x.org/pub/individual/proto/inputproto-2.3.tar.bz2"
my_work xtrans-1.2.7          xtrans-1.2.7.tar.bz2         "http://ftp.x.org/pub/individual/lib/xtrans-1.2.7.tar.bz2"
my_work xcb-proto-1.8         xcb-proto-1.8.tar.bz2        "http://xcb.freedesktop.org/dist/xcb-proto-1.8.tar.bz2"
my_work dri2proto-2.8         dri2proto-2.8.tar.bz2        "http://xorg.freedesktop.org/releases/individual/proto/dri2proto-2.8.tar.bz2"
my_work xf86dgaproto-2.1      xf86dgaproto-2.1.tar.bz2     "http://ftp.x.org/pub/individual/proto/xf86dgaproto-2.1.tar.bz2"
my_work xf86vidmodeproto-2.3.1 xf86vidmodeproto-2.3.1.tar.bz2 "http://ftp.x.org/pub/individual/proto/xf86vidmodeproto-2.3.1.tar.bz2"
my_work videoproto-2.3.1      videoproto-2.3.1.tar.bz2     "http://ftp.x.org/pub/individual/proto/videoproto-2.3.1.tar.bz2"

# X11 libs, headers needed to build the rtlib, libs for FB programs
# (more or less in order of dependencies)
my_work libICE-1.0.8     libICE-1.0.8.tar.bz2     "http://ftp.x.org/pub/individual/lib/libICE-1.0.8.tar.bz2"
my_work libSM-1.2.1      libSM-1.2.1.tar.bz2      "http://ftp.x.org/pub/individual/lib/libSM-1.2.1.tar.bz2"
my_work libXau-1.0.7     libXau-1.0.7.tar.bz2     "http://ftp.x.org/pub/individual/lib/libXau-1.0.7.tar.bz2"
my_work libpthread-stubs-0.3  libpthread-stubs-0.3.tar.bz2  "http://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.bz2"
my_work libxcb-1.9       libxcb-1.9.tar.bz2       "http://xcb.freedesktop.org/dist/libxcb-1.9.tar.bz2"
my_work libX11-1.5.0     libX11-1.5.0.tar.bz2     "http://ftp.x.org/pub/individual/lib/libX11-1.5.0.tar.bz2"
my_work libXt-1.1.3      libXt-1.1.3.tar.bz2      "http://ftp.x.org/pub/individual/lib/libXt-1.1.3.tar.bz2"
my_work libXext-1.3.1    libXext-1.3.1.tar.bz2    "http://ftp.x.org/pub/individual/lib/libXext-1.3.1.tar.bz2"
my_work libXpm-3.5.10    libXpm-3.5.10.tar.bz2    "http://ftp.x.org/pub/individual/lib/libXpm-3.5.10.tar.bz2"
my_work libXrender-0.9.7 libXrender-0.9.7.tar.bz2 "http://ftp.x.org/pub/individual/lib/libXrender-0.9.7.tar.bz2"
my_work libXrandr-1.3.2  libXrandr-1.3.2.tar.bz2  "http://ftp.x.org/pub/individual/lib/libXrandr-1.3.2.tar.bz2"
my_work libXi-1.7        libXi-1.7.tar.bz2        "http://ftp.x.org/pub/individual/lib/libXi-1.7.tar.bz2"
my_work libXdmcp-1.1.1   libXdmcp-1.1.1.tar.bz2   "http://ftp.x.org/pub/individual/lib/libXdmcp-1.1.1.tar.bz2"
my_work libXxf86dga-1.1.3 libXxf86dga-1.1.3.tar.bz2 "http://ftp.x.org/pub/individual/lib/libXxf86dga-1.1.3.tar.bz2"
my_work libXxf86vm-1.1.2 libXxf86vm-1.1.2.tar.bz2 "http://ftp.x.org/pub/individual/lib/libXxf86vm-1.1.2.tar.bz2"
my_work libXv-1.0.7      libXv-1.0.7.tar.bz2      "http://ftp.x.org/pub/individual/lib/libXv-1.0.7.tar.bz2"

# GL
my_work libpciaccess-0.13.1  libpciaccess-0.13.1.tar.gz  "ftp://ftp.freedesktop.org/pub/xorg/individual/lib/libpciaccess-0.13.1.tar.bz2"
my_work Mesa-9.1         MesaLib-9.1.tar.bz2      "ftp://ftp.freedesktop.org/pub/mesa/9.1/MesaLib-9.1.tar.bz2"
my_work glu-9.0.0        glu-9.0.0.tar.bz2        "ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.0.tar.bz2"
my_work freeglut-2.8.0   freeglut-2.8.0.tar.gz    "http://sourceforge.net/projects/freeglut/files/freeglut/2.8.0/freeglut-2.8.0.tar.gz/download"
my_work glfw-2.7.7       glfw-2.7.7.tar.bz2       "http://sourceforge.net/projects/glfw/files/glfw/2.7.7/glfw-2.7.7.tar.bz2/download"

# console
my_work ncurses-5.9      ncurses-5.9.tar.gz       "http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz"
my_work gpm-1.20.7       gpm-1.20.7.tar.bz2       "http://www.nico.schottelius.org/software/gpm/archives/gpm-1.20.7.tar.bz2"
my_work libcaca-0.99.beta18 libcaca-0.99.beta18.tar.gz "http://caca.zoy.org/files/libcaca/libcaca-0.99.beta18.tar.gz"
my_work readline-6.2     readline-6.2.tar.gz      "ftp://ftp.gnu.org/gnu/readline/readline-6.2.tar.gz"

my_work TinyPTC-X11-0.7.3 TinyPTC-X11-0.7.3.tar.bz2 "http://sourceforge.net/projects/tinyptc/files/X11%20Version/0.7.3/TinyPTC-X11-0.7.3.tar.bz2/download"

# curl
my_work c-ares-1.9.1       c-ares-1.9.1.tar.gz        "http://c-ares.haxx.se/download/c-ares-1.9.1.tar.gz"
my_work libidn-1.26        libidn-1.26.tar.gz         "http://ftp.gnu.org/gnu/libidn/libidn-1.26.tar.gz"
my_work nettle-2.6         nettle-2.6.tar.gz          "http://www.lysator.liu.se/~nisse/archive/nettle-2.6.tar.gz"
my_work libtasn1-3.2       libtasn1-3.2.tar.gz        "http://ftp.gnu.org/gnu/libtasn1/libtasn1-3.2.tar.gz"
my_work gnutls-3.1.9       gnutls-3.1.9.1.tar.xz      "ftp://ftp.gnutls.org/gcrypt/gnutls/v3.1/gnutls-3.1.9.1.tar.xz"
my_work libmetalink-0.1.2  libmetalink-0.1.2.tar.bz2  "https://launchpad.net/libmetalink/trunk/packagingfix/+download/libmetalink-0.1.2.tar.bz2"
my_work curl-7.29.0        curl-7.29.0.tar.bz2        "http://curl.haxx.se/download/curl-7.29.0.tar.bz2"

# font
my_work freetype-2.4.11     freetype-2.4.11.tar.bz2  "http://sourceforge.net/projects/freetype/files/freetype2/2.4.11/freetype-2.4.11.tar.bz2/download"
my_work fontconfig-2.10.91  fontconfig-2.10.91.tar.bz2 "http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.10.91.tar.bz2"

# images
my_work libpng-1.5.14  libpng-1.5.14.tar.xz  "http://prdownloads.sourceforge.net/libpng/libpng-1.5.14.tar.xz?download"
my_work giflib-5.0.4   giflib-5.0.4.tar.bz2  "http://sourceforge.net/projects/giflib/files/giflib-5.x/giflib-5.0.4.tar.bz2/download"
my_work jpeg-9         jpegsrc.v9.tar.gz     "http://www.ijg.org/files/jpegsrc.v9.tar.gz"
my_work tiff-4.0.3     tiff-4.0.3.tar.gz     "ftp://ftp.remotesensing.org/pub/libtiff/tiff-4.0.3.tar.gz"
my_work lcms-1.19      lcms-1.19.tar.gz      "http://sourceforge.net/projects/lcms/files/lcms/1.19/lcms-1.19.tar.gz/download"
my_work lcms2-2.4      lcms2-2.4.tar.gz      "http://sourceforge.net/projects/lcms/files/lcms/2.4/lcms2-2.4.tar.gz/download"
my_work libmng-1.0.10  libmng-1.0.10.tar.bz2 "http://sourceforge.net/projects/libmng/files/libmng-devel/1.0.10/libmng-1.0.10.tar.bz2/download"
my_work jasper-1.900.1 jasper-1.900.1.zip    "http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip"
my_work DevIL-1.7.8    DevIL-1.7.8.tar.gz    "http://downloads.sourceforge.net/openil/DevIL-1.7.8.tar.gz"
my_work FreeImage-3.15.4  FreeImage3154.zip  "http://sourceforge.net/projects/freeimage/files/Source%20Distribution/3.15.4/FreeImage3154.zip/download"
my_work pixman-0.28.2  pixman-0.28.2.tar.gz  "http://cairographics.org/releases/pixman-0.28.2.tar.gz"
my_work cairo-1.12.14  cairo-1.12.14.tar.xz  "http://cairographics.org/releases/cairo-1.12.14.tar.xz"
my_work grx-2.4.9-con  grx249.tar.gz         "http://grx.gnu.de/download/grx249.tar.gz"
my_work grx-2.4.9-X    grx249.tar.gz         "http://grx.gnu.de/download/grx249.tar.gz"
my_work libwebp-0.3.0  libwebp-0.3.0.tar.gz  "https://webp.googlecode.com/files/libwebp-0.3.0.tar.gz"
my_work pdflib-4.0.2   pdflib-4.0.2-src.zip  "http://sourceforge.net/projects/gnuwin32/files/pdflib-lite/4.0.2/pdflib-4.0.2-src.zip/download"
#my_work gd-2.0.33      GD_2_0_33.tar.bz2     "https://bitbucket.org/pierrejoye/gd-libgd/get/GD_2_0_33.tar.bz2"
my_work gd-73cab5d8af96  gd-73cab5d8af96.zip  "https://bitbucket.org/libgd/gd-libgd/get/73cab5d8af96.zip"

my_work glib-2.34.3    glib-2.34.3.tar.xz    "http://ftp.gnome.org/pub/gnome/sources/glib/2.34/glib-2.34.3.tar.xz"

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
my_work alsa-lib-1.0.26     alsa-lib-1.0.26.tar.bz2     "ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.0.26.tar.bz2"
#my_work libogg-1.3.0        libogg-1.3.0.tar.xz         "http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.xz"
#my_work liboggz-1.1.1       liboggz-1.1.1.tar.gz        "http://downloads.xiph.org/releases/liboggz/liboggz-1.1.1.tar.gz"
#my_work libvorbis-1.3.3     libvorbis-1.3.3.tar.xz      "http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.xz"
#my_work libtheora-1.1.1     libtheora-1.1.1.tar.bz2     "http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2"
#my_work flac-1.2.1          flac-1.2.1.tar.gz           "http://sourceforge.net/projects/flac/files/flac-src/flac-1.2.1-src/flac-1.2.1.tar.gz/download"
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
my_work gdbm-1.10           gdbm-1.10.tar.gz            "ftp://ftp.gnu.org/gnu/gdbm/gdbm-1.10.tar.gz"
#my_work mysql-5.6.10        mysql-5.6.10.tar.gz         "http://www.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.10.tar.gz/from/http://cdn.mysql.com/"
#my_work postgresql-9.2.4    postgresql-9.2.4.tar.bz2    "http://ftp.postgresql.org/pub/source/v9.2.4/postgresql-9.2.4.tar.bz2"
#my_work sqlite-autoconf-3071601 sqlite-autoconf-3071601.tar.gz "http://sqlite.org/2013/sqlite-autoconf-3071601.tar.gz"

my_work lua-5.2.2           lua-5.2.2.tar.gz            "http://www.lua.org/ftp/lua-5.2.2.tar.gz"
#my_work SpiderMonkey-17.0.0 mozjs17.0.0.tar.gz          "http://ftp.mozilla.org/pub/mozilla.org/js/mozjs17.0.0.tar.gz"
#my_work json-c-0.9          json-c-0.9.tar.gz           "http://oss.metaparadigm.com/json-c/json-c-0.9.tar.gz"
#my_work cgi-util-2.2.1      cgi-util-2.2.1.tar.gz       "ftp://ftp.tuxpaint.org/unix/www/cgi-util/cgi-util-2.2.1.tar.gz"
#my_work fcgi-current        fcgi.tar.gz                 "http://www.fastcgi.com/dist/fcgi.tar.gz"
#my_work zeromq-3.2.2        zeromq-3.2.2.tar.gz         "http://download.zeromq.org/zeromq-3.2.2.tar.gz"

################################################################################
# Build a set of binutils, statically linked against musl libc, using the
# i486-linux-musl toolchain, for the standalone FB setup

binutilsname=binutils-2.23.2
binutilstarball=$binutilsname.tar.bz2

my_fetch  $binutilstarball  http://ftp.gnu.org/gnu/binutils/$binutilstarball
my_extract  $binutilsname  $binutilstarball

# build
if [ ! -d $binutilsname-build ]; then
	my_report "building $binutilsname"

	mkdir $binutilsname-build
	cd $binutilsname-build

	CPPFLAGS="-D_GNU_SOURCE" \
	CFLAGS="-O2" \
	CXXFLAGS="-O2" \
	LDFLAGS="-Wl,-Bstatic -static-libgcc"
	 CC="$toplevel/i486-linux-musl/bin/i486-linux-musl-gcc" \
	CXX="$toplevel/i486-linux-musl/bin/i486-linux-musl-g++" \
	 AR="$toplevel/i486-linux-musl/bin/i486-linux-musl-ar" \
	 LD="$toplevel/i486-linux-musl/bin/i486-linux-musl-ld" \
	../$binutilsname/configure \
		--host=i486-pc-linux-gnu --target=i486-pc-linux-gnu \
		--prefix=/usr \
		--disable-shared --enable-static \
		--disable-nls --disable-werror

	make
	cd ..
fi

################################################################################
# 1. Build an FB setup for native -> musl cross compilation, i.e. a native fbc
#    plus the libraries for cross-compilation to i486-linux-musl, all installed
#    into the $toplevel/i486-linux-musl tree
#
# The most important part are the rtlib and gfxlib2 binaries, but the compiler
# itself aswell; building it ensures that we get a native fbc whose ABI matches
# the rtlib/gfxlib2 binaries, so we don't need to make assumptions about the
# host fbc. (though as long as the version matches, the rtlib/gfxlib2 binaries
# can be copied into any FB setup)

my_report "building musl-fbc"

fbname=FreeBASIC-`date +%Y.%m.%d`-source
fbtarball=$fbname.tar.gz

# unpack
if [ ! -d musl-fbc ]; then
	tar -xf src/$fbtarball
	mv $fbname musl-fbc
fi

cd musl-fbc
echo "ENABLE_STANDALONE := 1" >  config.mk
echo "CC := $toplevel/i486-linux-musl/bin/i486-linux-musl-gcc" >> config.mk
echo "CFLAGS := -O2 -D_GNU_SOURCE" >> config.mk
echo "CFLAGS += `pkg-config --cflags libffi`" >> config.mk
echo "CFLAGS += `$prefix/bin/ncurses5-config --cflags`" >> config.mk
echo "CFLAGS += -DPTHREAD_MUTEX_RECURSIVE_NP=PTHREAD_MUTEX_RECURSIVE" >> config.mk
make
cd ..

my_report "copying binutils & libs into musl-fbc"

# Copy in the binutils
mkdir -p musl-fbc/bin/linux
cp $binutilsname-build/gas/as-new   musl-fbc/bin/linux/as
cp $binutilsname-build/binutils/ar  musl-fbc/bin/linux/ar
cp $binutilsname-build/ld/ld-new    musl-fbc/bin/linux/ld

# Copy in the libraries
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.2/crt{begin,end}.o  musl-fbc/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.2/*.a               musl-fbc/lib/linux
cp sysroot/usr/lib/crt{1,i,n}.o   musl-fbc/lib/linux
cp sysroot/usr/lib/*.a            musl-fbc/lib/linux

# Create empty libgcc_eh.a archive, to prevent ld error, because fbc currently
# does -lgcc_eh.
# TODO: gcc with --disable-shared doesn't have libgcc_eh, instead it includes
# everything in the libgcc.a already. Hence fbc shouldn't do -lgcc_eh in this
# case, just like with TDM-GCC. When fbc is fixed, this can be removed.
if [ ! -f musl-fbc/lib/linux/libgcc_eh.a ]; then
	ar rcs musl-fbc/lib/linux/libgcc_eh.a
fi

chmod 644 musl-fbc/lib/linux/*.o \
          musl-fbc/lib/linux/*.a

strip -g musl-fbc/bin/linux/*   \
         musl-fbc/lib/linux/*.o \
         musl-fbc/lib/linux/*.a

################################################################################
# 2. "Cross-compile" a standalone FB setup using the 1st one, to get a static
#    fbc binary; the i486-linux-musl libs can just be copied over

my_report "building fbc-static"

# unpack
if [ ! -d fbc-static ]; then
	tar -xf src/$fbtarball
	mv $fbname fbc-static
fi

cd fbc-static
echo "ENABLE_STANDALONE := 1" > config.mk
echo "FBC := $toplevel/musl-fbc/fbc-new -static -l tinfo" >> config.mk
make compiler
cd ..

my_report "copying binutils & libs into fbc-static"

# Copy over the libraries
mkdir -p fbc-static/bin/linux
cp musl-fbc/bin/linux/* fbc-static/bin/linux
mkdir -p fbc-static/lib/linux
cp musl-fbc/lib/linux/* fbc-static/lib/linux

################################################################################

my_report "checking libs for hard-coded paths"
for f in fbc-static/lib/linux/*; do
	text=`strings $f | grep $toplevel || echo`
	if [ -n "$text" ]; then
		echo "*** $f: ***"
		echo "$text"
	fi
done
