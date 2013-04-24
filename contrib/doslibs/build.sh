#!/bin/sh
set -e

toplevel="$PWD"
mkdir -p bin src prefix prefix/bin prefix/include prefix/lib
prefix=$toplevel/prefix

triplet=i586-pc-msdosdjgpp
export      AS="$triplet-as"
export      CC="$triplet-gcc"
export     CXX="$triplet-g++"
export      AR="$triplet-ar"
export  RANLIB="$triplet-ranlib"
export      LD="$triplet-ld"
export   STRIP="$triplet-strip"
export STRINGS="$triplet-strings"

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
		CUnit-*)
			patch -p0 < ../src/CUnit.patch
			autoreconf
			;;
		DevIL-*)
			patch -p0 < ../src/DevIL.patch
			;;
		expat-*)
			patch -p0 < ../src/expat.patch
			;;
		gd-73cab5d8af96)
			patch -p0 < ../src/gd-73cab5d8af96.patch
			autoreconf -fi
			;;
		giflib-*)
			patch -p0 < ../src/giflib.patch
			autoreconf
			;;
		jasper-*)
			patch -p0 < ../src/jasper.patch
			;;
		jpeg-*)
			patch -p0 < ../src/jpeglib.patch
			;;
		lcms-*)
			patch -p0 < ../src/lcms.patch
			;;
		libxml2-*)
			patch -p0 < ../src/libxml2.patch
			;;
		libzip-*)
			patch -p0 < ../src/libzip.patch
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
		export CFLAGS="-O2 -Wall -Werror-implicit-function-declaration"
		export LDFLAGS="-L$prefix/lib"

		case $name in
		aspell-*)
			# Aspell hard-codes the prefix path, but we don't
			# want that at all, so use --prefix=/ for now and hope
			# for the best
			./configure --host=$triplet \
				--prefix=/ \
				--enable-win32-relocatable \
				--disable-nls
			make
			make install DESTDIR=$prefix
			;;

		big_int-*)
			cd $name/libbig_int
			$CC $CPPFLAGS $CFLAGS -c -I include src/*.c src/low_level_funcs/*.c
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
			cp bzlib.h $prefix/include
			cp libbz2.a $prefix/lib
			;;

		DevIL-*)
			export LDFLAGS="-L$prefix/lib -lstdc++"
			./configure --host=$triplet --prefix=$prefix \
				--enable-ILU --enable-ILUT
			make
			make install
			;;

		gd-73cab5d8af96)
			./configure --host=$triplet --prefix=$prefix \
				--with-zlib=$prefix \
				--with-png=$prefix \
				--with-jpeg=$prefix \
				--with-tiff=$prefix \
				--without-freetype \
				--without-fontconfig \
				--without-xpm
			make
			make install DESTDIR=$sysroot
			;;

		gmp-*)
			# gmplib's configure breaks with -Werror-implicit-function-declaration
			export CFLAGS="-O2 -Wall"
			./configure --host=$triplet --prefix=$prefix
			make CFLAGS="-O2 -Wall -Werror-implicit-function-declaration"
			make install
			;;

		grx-*)
			cd contrib/grx249

			# grx DJGPP build breaks with -Werror-implicit-function-declaration
			export CFLAGS="-O2 -Wall"

			make -f makefile.dj2 libs \
				HAVE_LIBTIFF=y \
				HAVE_LIBJPEG=y \
				HAVE_LIBPNG=y \
				NEED_ZLIB=y \
				CROSS_PLATFORM=$triplet- \
				HAVE_UNIX_TOOLS=y \
				CCOPT="$CPPFLAGS $CFLAGS -fno-strict-aliasing -Wall" \
				LDOPT="$LDFLAGS -s"
			cp lib/dj2/libgrx20.a $prefix/lib

			cd ../..
			;;

		libmng-*)
			$CC $CPPFLAGS $CFLAGS \
				-DMNG_SUPPORT_READ -DMNG_SUPPORT_DISPLAY -DMNG_SUPPORT_WRITE \
				-DMNG_ACCESS_CHUNKS -DMNG_STORE_CHUNKS \
				*.c -c
			$AR rcs libmng.a *.o
			cp libmng.a $prefix/lib
			cp libmng.h libmng_conf.h libmng_types.h $prefix/include
			;;

		libxml2-*)
			./configure --host=$triplet --prefix=$prefix \
				--without-debug --without-ftp --without-http \
				--without-threads --without-python
			make
			make install
			;;

		libxslt-*)
			./configure --host=$triplet --prefix=$prefix \
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

		lua-*)
			make generic \
				CC="$CC" \
				AR="$AR rcs" \
				RANLIB="$RANLIB" \
				MYCFLAGS="$CPPFLAGS $CFLAGS" \
				MYLDFLAGS="$LDFLAGS"
			cp src/liblua.a $prefix/lib
			;;

		mxml-*)
			sed	-e 's/#define MXML_VERSION	""/#define MXML_VERSION "Mini-XML v2.7"/g' \
				-e 's/#undef HAVE_LONG_LONG/#define HAVE_LONG_LONG 1/g' \
				-e 's/#undef HAVE_SNPRINTF/#define HAVE_SNPRINTF 1/g' \
				-e 's/#undef HAVE_VSNPRINTF/#define HAVE_VSNPRINTF 1/g' \
				-e 's/#undef HAVE_STRDUP/#define HAVE_STRDUP 1/g' \
				-e 's///g' \
				-e 's///g' \
				config.h.in > config.h

			$CC $CPPFLAGS $CFLAGS -c \
				mxml-attr.c   mxml-entity.c mxml-file.c \
				mxml-get.c    mxml-index.c  mxml-node.c \
				mxml-search.c mxml-set.c    mxml-private.c \
				mxml-string.c
			$AR rcs libmxml.a \
				mxml-attr.o   mxml-entity.o mxml-file.o \
				mxml-get.o    mxml-index.o  mxml-node.o \
				mxml-search.o mxml-set.o    mxml-private.o \
				mxml-string.o
			cp libmxml.a $prefix/lib
			;;

		pcre-*)
			./configure --build=i686-pc-linux-gnu --host=$triplet --prefix=$prefix \
				--enable-pcre16 --enable-pcre32 \
				--disable-cpp \
				--enable-utf --enable-unicode-properties \
				--enable-newline-is-crlf
			make
			make install
			;;

		PDCurses-*)
			cd dos
			make -f gccdos.mak libs PDCURSES_SRCDIR=.. \
				CC="$CC" CFLAGS="$CFLAGS -I.." LINK="$CC" \
				LIBEXE="$AR" LIBFLAGS="rcs"
			cp pdcurses.a $prefix/lib/libpdcurses.a
			cd ..
			cp curses.h panel.h term.h $prefix/include
			;;

		QuickLZ-*)
			$CC $CPPFLAGS $CFLAGS -c quicklz.c
			$AR rcs libquicklz.a quicklz.o
			cp quicklz.h $prefix/include
			cp libquicklz.a $prefix/lib
			;;

		TinyPTC-DOS-*)
			rm -f *.o *.exe
			$CC $CPPFLAGS $CFLAGS -include stdlib.h -c tiny_dos.c
			nasm -f coff -o tiny_gfx.o tiny_gfx.asm
			$AR rcs libtinyptc.a tiny_dos.o tiny_gfx.o
			cp libtinyptc.a $prefix/lib
			;;

		tre-*)
			./configure --host=$triplet --prefix=$prefix \
				--disable-agrep --disable-nls
			make
			make install
			;;

		xz-*)
			./configure --host=$triplet --prefix=$prefix \
				--disable-xz --disable-xzdec --disable-lzmadec \
				--disable-lzmainfo --disable-lzma-links \
				--disable-scripts --disable-nls
			make
			make install
			;;

		zlib-*)
			$CC $CPPFLAGS $CFLAGS -include unistd.h -c \
				adler32.c crc32.c deflate.c infback.c \
				inffast.c inflate.c inftrees.c trees.c zutil.c \
				compress.c uncompr.c gzclose.c gzlib.c \
				gzread.c gzwrite.c
			$AR rcs libz.a \
				adler32.o crc32.o deflate.o infback.o \
				inffast.o inflate.o inftrees.o trees.o zutil.o \
				compress.o uncompr.o gzclose.o gzlib.o \
				gzread.o gzwrite.o
			cp libz.a $prefix/lib
			cp zlib.h zconf.h $prefix/include
			;;

		*)
			./configure --host=$triplet --prefix=$prefix
			make
			make install
			;;
		esac

		unset CPPFLAGS
		unset CFLAGS
		unset LDFLAGS

		touch build-done
		cd ..
	fi
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
}


my_work TinyPTC-DOS-0.1 TinyPTC-DOS-0.1.zip "http://sourceforge.net/projects/tinyptc/files/DOS%20Version/TinyPTC%20DOS%200.1/TinyPTC-DOS-0.1.zip/download"

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
#my_work cryptlib-3.4.2  cl342.zip                "ftp://ftp.franken.de/pub/crypt/cryptlib/cl342.zip"
my_work big_int-1.0.7   big_int-1.0.7.tgz        "http://pecl.php.net/get/big_int-1.0.7.tgz"

# console
my_work PDCurses-3.4     pdcurs34.zip           "http://sourceforge.net/projects/pdcurses/files/pdcurses/3.4/pdcurs34.zip/download"

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
#my_work FreeImage-3.15.4 FreeImage3154.zip   "http://sourceforge.net/projects/freeimage/files/Source%20Distribution/3.15.4/FreeImage3154.zip/download"
my_work gd-73cab5d8af96  gd-73cab5d8af96.zip  "--no-check-certificate https://bitbucket.org/libgd/gd-libgd/get/73cab5d8af96.zip"
my_work grx-2.4.9        grx249s.zip          "http://grx.gnu.de/download/grx249s.zip"

my_work lua-5.2.2  lua-5.2.2.tar.gz  "http://www.lua.org/ftp/lua-5.2.2.tar.gz"

################################################################################

# Copy in the libraries
mkdir -p fbc/lib/dos
cp $prefix/lib/*.a   fbc/lib/dos

$STRIP -g fbc/lib/dos/*

my_report "checking libs for hard-coded paths"
for f in fbc/lib/dos/*; do
	text=`$STRINGS $f | grep $toplevel || echo`
	if [ -n "$text" ]; then
		echo "*** $f: ***"
		echo "$text"
	fi
done
