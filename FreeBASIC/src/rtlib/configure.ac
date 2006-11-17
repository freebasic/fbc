# configure.ac for the FB Run-Time Library		-*- Autoconf -*-
# Process this file with autoconf to generate a configuration script.

AC_INIT([fbrtlib],[0.17],[http://sourceforge.net/projects/fbc])
AC_PREREQ([2.59])

AC_COPYRIGHT([Copyright (c) 2004-2007 The FreeBASIC development team])

AC_CONFIG_SRCDIR([fb.h])
AC_CONFIG_AUX_DIR([../config])

# Find target
AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_CANONICAL_TARGET

case "$target" in
	*-*-linux* )
		AC_DEFINE([TARGET_LINUX],1,[Linux build])
		FBRT_TARGET=linux;;
	*-*-mingw* )
		AC_DEFINE([TARGET_WIN32],1,[Win32 build])
		FBRT_TARGET=win32;;
	*-*-cygwin* )
		AC_DEFINE([TARGET_CYGWIN],1,[Cygwin build])
		FBRT_TARGET=win32;;
	*-*-msdos* )
		AC_DEFINE([TARGET_DOS],1,[Djgpp build])
		FBRT_TARGET=dos;;
	*-*-xbox* )
		AC_DEFINE([TARGET_XBOX],1,[Xbox build])
		FBRT_TARGET=xbox;;
	*)
		AC_MSG_ERROR([Unsupported target])
		;;
esac

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

MISSING=`cd $ac_aux_dir && ${PWDCMD-pwd}`/missing
AC_CHECK_PROGS([ACLOCAL], [aclocal], [$MISSING aclocal])
AC_CHECK_PROGS([AUTOCONF], [autoconf], [$MISSING autoconf])
AC_CHECK_PROGS([AUTOHEADER], [autoheader], [$MISSING autoheader])

# Checks for libraries.

# Checks for header files.
AC_PATH_X
AC_HEADER_DIRENT
AC_HEADER_STDC
AC_HEADER_SYS_WAIT
AC_CHECK_HEADERS([fcntl.h float.h malloc.h math.h stddef.h stdlib.h stdio.h string.h sys/file.h sys/io.h sys/ioctl.h sys/time.h termios.h unistd.h wchar.h wctype.h])

# Make sure off_t is 64-bit in *nix
AC_DEFINE([_FILE_OFFSET_BITS],64,[File offset bits])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_BIGENDIAN
AC_C_CONST
AC_C_VOLATILE
AC_HEADER_TIME
AC_OBJEXT
AC_STRUCT_TM
AC_SYS_LARGEFILE
AC_TYPE_OFF_T
AC_TYPE_PID_T
AC_TYPE_SIGNAL
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_ALLOCA
AC_FUNC_CLOSEDIR_VOID
AC_FUNC_FORK
AC_FUNC_FSEEKO
AC_FUNC_MALLOC
AC_FUNC_MEMCMP
AC_FUNC_REALLOC
AC_FUNC_SELECT_ARGTYPES
AC_FUNC_SETVBUF_REVERSED
AC_FUNC_STAT
AC_FUNC_STRTOD
AC_FUNC_VPRINTF
AC_CHECK_FUNCS([atexit chdir floor getcwd gettimeofday memchr memmove memset mkdir pow pclose popen putenv rint rmdir select strcasecmp strchr strdup strncasecmp strrchr strstr strtof strtod strtoul strtoull snprintf wcstoll wcstoull])
AC_CHECK_FUNCS([fopen64 fseeko64 ftello64 stat64 freopen64])

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
