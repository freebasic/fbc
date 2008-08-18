# configure.ac for the FB Gfx Library		-*- Autoconf -*-
# Process this file with autoconf to generate a configuration script.

AC_INIT([fbgfxlib],[0.20.1],[http://sourceforge.net/projects/fbc])
AC_PREREQ([2.59])

AC_COPYRIGHT([Copyright (C) 2005-2007 Angelo Mottola (a.mottola@libero.it)])

AC_CONFIG_SRCDIR([fb_gfx.h])
AC_CONFIG_AUX_DIR([../config])

# Find target
AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_CANONICAL_TARGET

case "$target" in
	*-*-linux* )
		AC_DEFINE([TARGET_LINUX],1,[Linux build])
		AC_DEFINE([TARGET_BASE_UNIX],1,[Unix base build])
		FBGFX_BASE=x11
		FBRT_TARGET_BASE=unix
		FBRT_TARGET=linux
		;;
	*-*-mingw* )
		AC_DEFINE([TARGET_WIN32],1,[Win32 build])
		FBGFX_BASE=
		FBRT_TARGET_BASE=
		FBRT_TARGET=win32
		;;
	*-*-cygwin* )
		AC_DEFINE([TARGET_CYGWIN],1,[Cygwin build])
		FBGFX_BASE=
		FBRT_TARGET_BASE=
		FBRT_TARGET=win32
		;;
	*-*-msdos* )
		AC_DEFINE([TARGET_DOS],1,[Djgpp build])
		FBGFX_BASE=
		FBRT_TARGET_BASE=
		FBRT_TARGET=dos
		;;
	*-*-xbox* )
		AC_DEFINE([TARGET_XBOX],1,[Xbox build])
		FBGFX_BASE=
		FBRT_TARGET_BASE=
		FBRT_TARGET=xbox
		;;
	*-*-freebsd* )
		AC_DEFINE([TARGET_FREEBSD],1,[FreeBSD build])
		AC_DEFINE([TARGET_BASE_UNIX],1,[Unix base build])
		FBGFX_BASE=x11
		FBRT_TARGET_BASE=unix
		FBRT_TARGET=freebsd
		;;
	*-*-solaris* )
		AC_DEFINE([TARGET_SOLARIS],1,[Solaris build])
		FBGFX_BASE=x11
		FBRT_TARGET_BASE=unix
		FBRT_TARGET=solaris
		;;
	*)
		AC_MSG_ERROR([Unsupported target])
		;;
esac

AC_SUBST([FBGFX_BASE])
AC_SUBST([FBRT_TARGET_BASE])
AC_SUBST([FBRT_TARGET])

case "$target_cpu" in
	i?86 | x86 )
		AC_DEFINE([TARGET_X86],1,[x86 build])
		FBRT_CPU=x86;;
	x86_64 )
		AC_DEFINE([TARGET_X86_64],1,[x86_64 build])
		FBRT_CPU=x86_64;;
	sparc64 )
		AC_DEFINE([TARGET_SPARC64],1,[Sparc64 build])
		FBRT_CPU=sparc64;;
	powerpc64 )
		AC_DEFINE([TARGET_POWERPC64],1,[Powerpc64 build])
		FBRT_CPU=powerpc64;;
	*)
		AC_MSG_ERROR([Unsupported CPU])
		;;
esac

AC_SUBST([FBRT_CPU])

# Checks for programs.
AC_PROG_MAKE_SET
AC_PROG_CC
AC_PROG_GCC_TRADITIONAL
AC_PROG_RANLIB

# Checks for libraries.

# Checks for header files.
if test "$FBGFX_BASE" = "x11"; then
    if test "x$with_x" != xno; then
        AC_PATH_X
        if test -z "$x_includes" || test "x$x_includes" = xNONE; then
             X_INCLUDES=""
        else
             X_INCLUDES="-I$x_includes"
        fi
        AC_SUBST([X_INCLUDES])
        if test "x$no_x" != "yes"; then
            AC_DEFINE([WITH_X],1,[Define to 1 if you want to use the X Window System])
        fi
    fi
fi

AC_HEADER_STDC
AC_CHECK_HEADERS([fcntl.h limits.h malloc.h stddef.h stdlib.h string.h sys/ioctl.h unistd.h])

# Check if opengl is disabled
AC_ARG_ENABLE([opengl],
[  --disable-opengl          disable opengl support],,
[enable_opengl=yes])

if test "$enable_opengl" = yes; then
  # Check for GL/gl.h only if the feature is enabled
  AC_CHECK_HEADERS([GL/gl.h],[FBRT_OPENGL=opengl],[FBRT_OPENGL=])
else
  FBRT_OPENGL=
fi
AC_SUBST([FBRT_OPENGL])

# Make sure off_t is 64-bit in *nix
AC_DEFINE([_FILE_OFFSET_BITS],64,[File offset bits])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_BIGENDIAN
AC_C_CONST
AC_TYPE_SIZE_T
AC_OBJEXT

# Checks for library functions.
AC_FUNC_ALLOCA
AC_PROG_GCC_TRADITIONAL
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_CHECK_FUNCS([atexit floor memset sqrt strcasecmp strdup strrchr snprintf])

AC_ARG_ENABLE([maintainer-mode],
[  --enable-maintainer-mode enable rules only needed by maintainers],,
[enable_maintainer_mode=no])

if test "$enable_maintainer_mode" = no; then
  MAINT='#'
else
  MAINT=
fi
AC_SUBST([MAINT])

# Output
AC_CONFIG_HEADERS([config.h:config.in], [echo timestamp > stamp-h1])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
