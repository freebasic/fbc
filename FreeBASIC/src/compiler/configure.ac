# configure.ac for the FB Compiler		-*- Autoconf -*-
# Process this file with autoconf to generate a configuration script.

AC_INIT([fbc],[0.16],[http://sourceforge.net/projects/fbc])
AC_PREREQ([2.59])

AC_COPYRIGHT([Copyright (c) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br) and others])

AC_CONFIG_SRCDIR([inc/fb.bi])
AC_CONFIG_AUX_DIR([../config])

# Find target
AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_CANONICAL_TARGET

case "$target" in
	*-*-linux* )
		AC_DEFINE([TARGET_LINUX],1,[Linux build])
		FBC_TARGET=linux;;
	*-*-mingw* )
		AC_DEFINE([TARGET_WIN32],1,[Win32 build])
		FBC_TARGET=win32;;
	*-*-cygwin* )
		AC_DEFINE([TARGET_CYGWIN],1,[Cygwin build])
		FBC_TARGET=win32;;
	*-*-msdos* )
		AC_DEFINE([TARGET_DOS],1,[Djgpp build])
		FBC_TARGET=dos;;
	*)
		AC_MSG_ERROR([Unsupported target])
		;;
esac

AC_SUBST([FBC_TARGET])

case "$host" in
	*-*-linux* )
		AC_DEFINE([HOST_LINUX],1,[Linux build])
		FBC_HOST=linux;;
	*-*-mingw* )
		AC_DEFINE([HOST_WIN32],1,[Win32 build])
		FBC_HOST=win32;;
	*-*-cygwin* )
		AC_DEFINE([HOST_CYGWIN],1,[Cygwin build])
		FBC_HOST=win32;;
	*-*-msdos* )
		AC_DEFINE([HOST_DOS],1,[Djgpp build])
		FBC_HOST=dos;;
	*)
		AC_MSG_ERROR([Unsupported host])
		;;
esac

AC_SUBST([FBC_HOST])

case "$target_cpu" in
	i?86 | x86 )
		AC_DEFINE([TARGET_X86],1,[x86 build])
		;;
esac

# Checks for programs.
AC_PROG_MAKE_SET
AC_PROG_CC
AC_CHECK_PROGS([FBC], [fbc])

MISSING=`cd $ac_aux_dir && ${PWDCMD-pwd}`/missing
AC_CHECK_PROGS([ACLOCAL], [aclocal], [$MISSING aclocal])
AC_CHECK_PROGS([AUTOCONF], [autoconf], [$MISSING autoconf])

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_ARG_ENABLE([maintainer-mode],
[  --enable-maintainer-mode enable rules only needed by maintainers],,
[enable_maintainer_mode=no])

if test "$enable_maintainer_mode" = no; then
  MAINT='#n'
else
  MAINT=
fi
AC_SUBST([MAINT])

# Output
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
