#!/bin/sh
#set -ex
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
	pwd

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
my_fetch  $muslcrosstarball  https://bitbucket.org/GregorR/musl-cross/get/$muslcrossrev.tar.bz2

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
		./build.sh
		unset CFLAGS
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
if [ ! -d $sysroot ]; then
	mkdir -p $sysroot/usr
	mv $toplevel/i486-linux-musl/i486-linux-musl/* $sysroot/usr
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
		Chipmunk*)
			patch -p0 < ../src/chipmunk.patch
			;;
		freeglut*)
			patch -p0 < ../src/freeglut.patch
			;;
		FreeImage*)
			patch -p0 < ../src/freeimage.patch
			;;
		gd-*)
			patch -p0 < ../src/gd.patch
			rm configure.in
			autoreconf
			;;
		gnutls*)
			patch -p0 < ../src/gnutls.patch
			;;
		libpciaccess*)
			patch -p0 < ../src/libpciaccess.patch
			;;
		libusb*)
			patch -p0 < ../src/libusb.patch
			;;
		libxml2*)
			patch -p0 < ../src/libxml2.patch
			;;
		Mesa*)
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

		export CFLAGS="-O2 -Werror-implicit-function-declaration"
		export CPPFLAGS=" -D_GNU_SOURCE"
		export CPP="$toplevel/i486-linux-musl/bin/i486-linux-musl-cpp"
		export  CC="$toplevel/i486-linux-musl/bin/i486-linux-musl-gcc"
		export CXX="$toplevel/i486-linux-musl/bin/i486-linux-musl-g++"
		export  AR="$toplevel/i486-linux-musl/bin/i486-linux-musl-ar"
		export  LD="$toplevel/i486-linux-musl/bin/i486-linux-musl-ld"
		export LDFLAGS="-static-libgcc -Wl,-Bstatic"

		case $name in
		util-macros*|*proto*|xtrans*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr
			make
			make install DESTDIR=$sysroot
			;;

		bzip2*)
			make libbz2.a CC="$CC" AR="$AR" CFLAGS="-O2 -D_FILE_OFFSET_BITS=64"
			cp bzlib.h $sysroot/usr/include
			cp libbz2.a $sysroot/usr/lib
			;;

		Chipmunk*)
			# Defining NDEBUG to disable some assert()'s in Chipmunk source code,
			# that would otherwise insert hard-coded source code file names into
			# the lib, that would be ugly and unnecessary.
			export CFLAGS="-DNDEBUG -O2 -Werror-implicit-function-declaration"
			cmake . \
				-DCMAKE_C_COMPILER="$CC" \
				-DCMAKE_CXX_COMPILER="$CXX" \
				-DCMAKE_INSTALL_PREFIX=/usr \
				-DCMAKE_FIND_ROOT_PATH=$sysroot/usr \
				-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
				-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY
			make VERBOSE=1 V=1
			make install DESTDIR=$sysroot
			;;

		curl*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-nls \
				--with-gnutls
			make
			make install DESTDIR=$sysroot
			;;

		e2fsprogs*)
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

		fontconfig*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-docs
			make
			make install DESTDIR=$sysroot
			;;

		freeglut*)
			LIBS="-lxcb -lXau -lXrandr -lXi" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
			make
			make install DESTDIR=$sysroot
			;;

		FreeImage*)
			unset CFLAGS
			make -f Makefile.gnu libfreeimage.a  CC="$CC" CXX="$CXX" AR="$AR"
			cp Source/FreeImage.h $sysroot/usr/include
			cp libfreeimage.a $sysroot/usr/lib
			;;

		gd-*)
			LIBPNG_CONFIG="$sysroot/bin/libpng-config" \
			LIBS="-lm -lbz2 -lexpat -lxcb -lXau" \
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				     --x-includes=$sysroot/usr/include \
				    --x-libraries=$sysroot/usr/lib \
				       --with-png=$sysroot/usr \
				  --with-freetype=$sysroot/usr \
				--with-fontconfig=$sysroot/usr \
				      --with-jpeg=$sysroot/usr \
				       --with-xpm=$sysroot/usr
			make
			make install DESTDIR=$sysroot
			;;

		gmp*)
			# gmplib's configure breaks with -Werror-implicit-function-declaration
			export CFLAGS="-Wl,-Bstatic -O2"
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static
				#--with-sysroot=$sysroot
			make CFLAGS="-Wl,-Bstatic -O2 -Werror-implicit-function-declaration"
			make install DESTDIR=$sysroot
			;;

		gnutls*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-nls
			make
			make install DESTDIR=$sysroot
			;;

		gpm*)
			# gpm header for FB rtlib build
			cp src/headers/gpm.h $sysroot/usr/include
			;;

		libidn*)
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

		libxslt*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--without-plugins \
				--without-debug \
				--without-debugger \
				--without-python \
				--without-crypto \
				--with-libxml-prefix=$sysroot/usr \
				--with-libxml-include-prefix=$sysroot/usr/include \
				--with-libxml-libs-prefix=$sysroot/usr/lib
			make
			make install DESTDIR=$sysroot
			;;

		Mesa*)
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

		ncurses*)
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

		nettle*)
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

		pcre*)
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

		tre*)
			./configure \
				--host=i486-pc-linux-gnu \
				--prefix=/usr \
				--disable-shared --enable-static \
				--disable-agrep \
				--disable-nls
			make
			make install DESTDIR=$sysroot
			;;

		xz*)
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

		zlib*)
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

		unset CFLAGS
		unset CPPFLAGS
		unset CPP
		unset CC
		unset CXX
		unset AR
		unset LD

		touch build-done
		cd ..

		# Fix paths in *.la files and also all the *-config scripts
		for f in `find sysroot -type f -name "*.la"` `find sysroot/usr/bin -type f -name "*-config"`; do
			cat $f | sed \
				-e "s:libdir='$toplevel/i486-linux-musl/i486-linux-musl/lib':libdir='$sysroot/usr/lib':g" \
				-e "s:libdir='/usr/lib':libdir='$sysroot/usr/lib':g" \
				-e "s:prefix=/usr:prefix=$sysroot/usr:g" \
				-e "s:prefix=\"/usr\":prefix=\"$sysroot/usr\":g" \
				-e "s:prefix='/usr':prefix='$sysroot/usr':g" \
				> $f.tmp

			# Overwrite original with temp file, preserve executable bit
			local setexec=`test -x $f && echo yes`
			mv $f.tmp $f
			if [ "x$setexec" = "xyes" ]; then
				chmod +x $f
			fi
		done
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
# It should produce "-I$sysroot/usr/include/foo" though, since we want libs
# to find their dependencies in our $sysroot/usr, not in the host system's
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
# searching in host system dirs and return the proper dirs in $sysroot/usr
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
export PATH="$toplevel/path:$PATH"

# Prevent pkg-config from looking in host system's dirs
export PKG_CONFIG_DIR=
export PKG_CONFIG_PATH=$sysroot/usr/lib/pkgconfig:$sysroot/usr/share/pkgconfig
export PKG_CONFIG_LIBDIR=$sysroot/usr/lib

# Let pkg-config prepend $sysroot to most returned paths
export PKG_CONFIG_SYSROOT_DIR=$sysroot

#my_work gettext-0.18.2        gettext-0.18.2.tar.gz        http://ftp.gnu.org/pub/gnu/gettext/gettext-0.18.2.tar.gz
#my_work libiconv-1.14         libiconv-1.14.tar.gz         http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
my_work e2fsprogs-1.42.7      e2fsprogs-1.42.7.tar.gz      http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.42.7.tar.gz
my_work libusb-1.0.9          libusb-1.0.9.tar.bz2         http://sourceforge.net/projects/libusb/files/libusb-1.0/libusb-1.0.9/libusb-1.0.9.tar.bz2

# X protocol headers and libs needed for the libX11 etc. builds
my_work util-macros-1.17      util-macros-1.17.tar.bz2     http://ftp.x.org/pub/individual/util/util-macros-1.17.tar.bz2
my_work xproto-7.0.23         xproto-7.0.23.tar.bz2        http://ftp.x.org/pub/individual/proto/xproto-7.0.23.tar.bz2
my_work xextproto-7.2.1       xextproto-7.2.1.tar.bz2      http://ftp.x.org/pub/individual/proto/xextproto-7.2.1.tar.bz2
my_work renderproto-0.11.1    renderproto-0.11.1.tar.bz2   http://ftp.x.org/pub/individual/proto/renderproto-0.11.1.tar.bz2
my_work randrproto-1.4.0      randrproto-1.4.0.tar.bz2     http://ftp.x.org/pub/individual/proto/randrproto-1.4.0.tar.bz2
my_work kbproto-1.0.6         kbproto-1.0.6.tar.bz2        http://ftp.x.org/pub/individual/proto/kbproto-1.0.6.tar.bz2
my_work inputproto-2.3        inputproto-2.3.tar.bz2       http://ftp.x.org/pub/individual/proto/inputproto-2.3.tar.bz2
my_work xtrans-1.2.7          xtrans-1.2.7.tar.bz2         http://ftp.x.org/pub/individual/lib/xtrans-1.2.7.tar.bz2
my_work xcb-proto-1.8         xcb-proto-1.8.tar.bz2        http://xcb.freedesktop.org/dist/xcb-proto-1.8.tar.bz2
my_work dri2proto             dri2proto-2.8.tar.bz2        http://xorg.freedesktop.org/releases/individual/proto/dri2proto-2.8.tar.bz2

# X11 libs, headers needed to build the rtlib, libs for FB programs
# (more or less in order of dependencies)
my_work libICE-1.0.8     libICE-1.0.8.tar.bz2     http://ftp.x.org/pub/individual/lib/libICE-1.0.8.tar.bz2
my_work libSM-1.2.1      libSM-1.2.1.tar.bz2      http://ftp.x.org/pub/individual/lib/libSM-1.2.1.tar.bz2
my_work libXau-1.0.7     libXau-1.0.7.tar.bz2     http://ftp.x.org/pub/individual/lib/libXau-1.0.7.tar.bz2
my_work libpthread-stubs-0.3  libpthread-stubs-0.3.tar.bz2  http://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.bz2
my_work libxcb-1.9       libxcb-1.9.tar.bz2       http://xcb.freedesktop.org/dist/libxcb-1.9.tar.bz2
my_work libX11-1.5.0     libX11-1.5.0.tar.bz2     http://ftp.x.org/pub/individual/lib/libX11-1.5.0.tar.bz2
my_work libXt-1.1.3      libXt-1.1.3.tar.bz2      http://ftp.x.org/pub/individual/lib/libXt-1.1.3.tar.bz2
my_work libXext-1.3.1    libXext-1.3.1.tar.bz2    http://ftp.x.org/pub/individual/lib/libXext-1.3.1.tar.bz2
my_work libXpm-3.5.10    libXpm-3.5.10.tar.bz2    http://ftp.x.org/pub/individual/lib/libXpm-3.5.10.tar.bz2
my_work libXrender-0.9.7 libXrender-0.9.7.tar.bz2 http://ftp.x.org/pub/individual/lib/libXrender-0.9.7.tar.bz2
my_work libXrandr-1.3.2  libXrandr-1.3.2.tar.bz2  http://ftp.x.org/pub/individual/lib/libXrandr-1.3.2.tar.bz2
my_work libXi-1.7        libXi-1.7.tar.bz2        http://ftp.x.org/pub/individual/lib/libXi-1.7.tar.bz2

# GL
my_work libpciaccess-0.13.1  libpciaccess-0.13.1.tar.gz  ftp://ftp.freedesktop.org/pub/xorg/individual/lib/libpciaccess-0.13.1.tar.bz2
#my_work libdrm-2.4.42    libdrm-2.4.42.tar.bz2    http://dri.freedesktop.org/libdrm/libdrm-2.4.42.tar.bz2
my_work Mesa-9.1         MesaLib-9.1.tar.bz2      ftp://ftp.freedesktop.org/pub/mesa/9.1/MesaLib-9.1.tar.bz2
my_work glu-9.0.0        glu-9.0.0.tar.bz2        ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.0.tar.bz2
my_work freeglut-2.8.0   freeglut-2.8.0.tar.gz    http://sourceforge.net/projects/freeglut/files/freeglut/2.8.0/freeglut-2.8.0.tar.gz/download

# libncurses/libtinfo, ditto
my_work ncurses-5.9      ncurses-5.9.tar.gz       http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz

# libffi, ditto
my_work libffi-3.0.12    libffi-3.0.12.tar.gz     ftp://sourceware.org/pub/libffi/libffi-3.0.12.tar.gz

# gpm, headers needed to build the rtlib
my_work gpm-1.20.7       gpm-1.20.7.tar.bz2       http://www.nico.schottelius.org/software/gpm/archives/gpm-1.20.7.tar.bz2

# libcunit for the FB test suite
my_work CUnit-2.1-2      CUnit-2.1-2-src.tar.bz2  http://downloads.sourceforge.net/cunit/CUnit-2.1-2-src.tar.bz2?download

# compression
my_work zlib-1.2.7     zlib-1.2.7.tar.bz2     http://prdownloads.sourceforge.net/libpng/zlib-1.2.7.tar.bz2?download
my_work libzip-0.10.1  libzip-0.10.1.tar.bz2  http://www.nih.at/libzip/libzip-0.10.1.tar.bz2
my_work xz-5.0.4       xz-5.0.4.tar.xz        http://tukaani.org/xz/xz-5.0.4.tar.xz
my_work bzip2-1.0.6    bzip2-1.0.6.tar.gz     http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz

# xml
my_work libxml2-2.9.0   libxml2-2.9.0.tar.gz   ftp://xmlsoft.org/libxml2/libxml2-2.9.0.tar.gz
my_work libxslt-1.1.28  libxslt-1.1.28.tar.gz  ftp://xmlsoft.org/libxml2/libxslt-1.1.28.tar.gz
my_work expat-2.1.0     expat-2.1.0.tar.gz     http://sourceforge.net/projects/expat/files/expat/2.1.0/expat-2.1.0.tar.gz/download

# regex
my_work pcre-8.32  pcre-8.32.tar.bz2  ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.32.tar.bz2
my_work tre-0.8.0  tre-0.8.0.tar.bz2  http://laurikari.net/tre/tre-0.8.0.tar.bz2

my_work gdsl-1.6           gdsl-1.6.tar.gz            http://download.gna.org/gdsl/gdsl-1.6.tar.gz
my_work gmp-5.1.1          gmp-5.1.1.tar.lz           ftp://ftp.gmplib.org/pub/gmp-5.1.1/gmp-5.1.1.tar.lz
my_work gsl-1.15           gsl-1.15.tar.gz            ftp://ftp.gnu.org/gnu/gsl/gsl-1.15.tar.gz

# curl
my_work c-ares-1.9.1       c-ares-1.9.1.tar.gz        http://c-ares.haxx.se/download/c-ares-1.9.1.tar.gz
my_work libidn-1.26        libidn-1.26.tar.gz         http://ftp.gnu.org/gnu/libidn/libidn-1.26.tar.gz
my_work nettle-2.6         nettle-2.6.tar.gz          http://www.lysator.liu.se/~nisse/archive/nettle-2.6.tar.gz
my_work libtasn1-3.2       libtasn1-3.2.tar.gz        http://ftp.gnu.org/gnu/libtasn1/libtasn1-3.2.tar.gz
my_work gnutls-3.1.9       gnutls-3.1.9.1.tar.xz      ftp://ftp.gnutls.org/gcrypt/gnutls/v3.1/gnutls-3.1.9.1.tar.xz
my_work libmetalink-0.1.2  libmetalink-0.1.2.tar.bz2  https://launchpad.net/libmetalink/trunk/packagingfix/+download/libmetalink-0.1.2.tar.bz2
my_work curl-7.29.0        curl-7.29.0.tar.bz2        http://curl.haxx.se/download/curl-7.29.0.tar.bz2

# font
my_work freetype-2.4.11     freetype-2.4.11.tar.bz2  http://sourceforge.net/projects/freetype/files/freetype2/2.4.11/freetype-2.4.11.tar.bz2/download
my_work fontconfig-2.10.91  fontconfig-2.10.91.tar.bz2 http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.10.91.tar.bz2

# images
my_work libpng-1.5.14  libpng-1.5.14.tar.xz  http://prdownloads.sourceforge.net/libpng/libpng-1.5.14.tar.xz?download
my_work giflib-5.0.4   giflib-5.0.4.tar.bz2  http://sourceforge.net/projects/giflib/files/giflib-5.x/giflib-5.0.4.tar.bz2/download
my_work jpeg-9         jpegsrc.v9.tar.gz     http://www.ijg.org/files/jpegsrc.v9.tar.gz
my_work FreeImage      FreeImage3154.zip     http://sourceforge.net/projects/freeimage/files/Source%20Distribution/3.15.4/FreeImage3154.zip/download
my_work gd-2.0.33      GD_2_0_33.tar.bz2     https://bitbucket.org/pierrejoye/gd-libgd/get/GD_2_0_33.tar.bz2

# physics
my_work Chipmunk-4.1.0  Chipmunk-4.1.0.tgz    http://chipmunk-physics.net/release/Chipmunk-4.x/Chipmunk-4.1.0.tgz
#my_work Chipmunk-6.1.4  Chipmunk-6.1.4.tgz    http://chipmunk-physics.net/release/Chipmunk-6.x/Chipmunk-6.1.4.tgz
my_work ode-0.12        ode-0.12.tar.bz2      http://sourceforge.net/projects/opende/files/ODE/0.12/ode-0.12.tar.bz2/download

################################################################################
# Build a set of binutils, statically linked against musl libc, using the
# i486-linux-musl toolchain, for the standalone FB setup

binutilsname=binutils-2.23.1
binutilstarball=$binutilsname.tar.bz2

my_fetch  $binutilstarball  http://ftp.gnu.org/gnu/binutils/$binutilstarball
my_extract  $binutilsname  $binutilstarball

# build
if [ ! -d $binutilsname-build ]; then
	my_report "building $binutilsname"

	mkdir $binutilsname-build
	cd $binutilsname-build

	CFLAGS="-Wl,-Bstatic -O2" \
	CPPFLAGS=" -D_GNU_SOURCE" \
	 CC="$toplevel/i486-linux-musl/bin/i486-linux-musl-gcc -static-libgcc" \
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
echo "AR := $toplevel/i486-linux-musl/bin/i486-linux-musl-ar"  >> config.mk
echo "CFLAGS := -O2 -D_GNU_SOURCE" >> config.mk
echo "CFLAGS += `pkg-config --cflags libffi`" >> config.mk
echo "CFLAGS += `$sysroot/usr/bin/ncurses5-config --cflags`" >> config.mk
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
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.2/*.o  musl-fbc/lib/linux
cp i486-linux-musl/lib/gcc/i486-linux-musl/4.7.2/*.a  musl-fbc/lib/linux
cp sysroot/usr/lib/*.o            musl-fbc/lib/linux
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
