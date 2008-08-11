# configure.ac for the FB Compiler		-*- Autoconf -*-
# Process this file with autoconf to generate a configuration script.

AC_INIT([fbc],[0.20.0],[http://sourceforge.net/projects/fbc])
AC_PREREQ([2.59])

AC_COPYRIGHT([Copyright (C) 2004-2008 The FreeBASIC development team])

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
	*-*-xbox* )
		AC_DEFINE([TARGET_XBOX],1,[Xbox build])
		FBC_TARGET=xbox;;
	*-*-freebsd* )
		AC_DEFINE([TARGET_FREEBSD],1,[FreeBSD build])
		FBC_TARGET=freebsd;;
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
	*-*-freebsd* )
		AC_DEFINE([HOST_FREEBSD],1,[FreeBSD build])
		FBC_HOST=freebsd;;
	*)
		AC_MSG_ERROR([Unsupported host])
		;;
esac

AC_SUBST([FBC_HOST])

case "$target_cpu" in
	i?86 | x86 )
		AC_DEFINE([TARGET_X86],1,[x86 target])
		FBC_TARGET_CPU=x86
		;;
	x86_64 | amd64 )
		AC_DEFINE([TARGET_X86_64],1,[x86-64 target])
		FBC_TARGET_CPU=x86_64
		;;
esac

AC_SUBST([FBC_TARGET_CPU])

case "$host_cpu" in
	i?86 | x86 )
		AC_DEFINE([HOST_X86],1,[x86 host])
		FBC_HOST_CPU=x86
		;;
	x86_64 | amd64 )
		AC_DEFINE([HOST_X86_64],1,[x86-64 host])
		FBC_HOST_CPU=x86_64
		;;
esac

AC_SUBST([FBC_HOST_CPU])

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

AC_C_BIGENDIAN(
 [FBC_HOST_ENDIAN=big],
 [FBC_HOST_ENDIAN=little]
)
AC_SUBST([FBC_HOST_ENDIAN])

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

# Optionally disable OBJINFO support, (bfd and iberty).  This was added to
# allow building and debugging fbc with a broader range of binutils and
# gdb versions.  Compatability with BFD really depends on matching versions
# of BFD between binutils and gdb plus fbc's bfd.bi header file -- which is
# not always possible.
AC_ARG_ENABLE(objinfo,
[  --disable-objinfo        disable direct reading/writing of obj/lib files],
 [if test "$enableval" != "no"; then
    FBC_OBJINFO=objinfo
 else
    FBC_OBJINFO=
 fi],
 FBC_OBJINFO=objinfo
)
AC_SUBST([FBC_OBJINFO])


# Optionally enable STANDALONE feature.  This allows fbc to be run
# as a standalone compiler within the developement tree.
AC_ARG_ENABLE(standalone,
[  --enable-standalone        build a standalone compiler],
 [if test "$enableval" != "no"; then
    FBC_STANDALONE=yes
 else
    FBC_STANDALONE=
 fi],
 FBC_STANDALONE=no
)
AC_SUBST([FBC_STANDALONE])


#
# Cross-compile targets
#
# If the default target is also specified with --enable-crosscomp-(target),
# it will be silently ignored.
#

AC_ARG_ENABLE(crosscomp-all,
 [  --enable-crosscomp-all       enable all -target options],
 [if test "$FBC_TARGET" != "cygwin"; then
    FBC_CROSSCOMP_CYGWIN=yes
  fi]
 [if test "$FBC_TARGET" != "dos"; then
    FBC_CROSSCOMP_DOS=yes
  fi]
 [if test "$FBC_TARGET" != "freebsd"; then
    FBC_CROSSCOMP_FREEBSD=yes
  fi]
 [if test "$FBC_TARGET" != "linux"; then
    FBC_CROSSCOMP_LINUX=yes
  fi]
 [if test "$FBC_TARGET" != "win32"; then
    FBC_CROSSCOMP_WIN32=yes
  fi]
 [if test "$FBC_TARGET" != "xbox"; then
    FBC_CROSSCOMP_XBOX=yes
  fi]
)


AC_ARG_ENABLE(crosscomp-cygwin,
 [  --enable-crosscomp-cygwin    enable -target cygwin],
 [if test "$FBC_TARGET" != "cygwin"; then
    FBC_CROSSCOMP_CYGWIN=yes
  fi]
)
AC_SUBST([FBC_CROSSCOMP_CYGWIN])

AC_ARG_ENABLE(crosscomp-dos,
 [  --enable-crosscomp-dos       enable -target dos],
 [if test "$FBC_TARGET" != "dos"; then
    FBC_CROSSCOMP_DOS=yes
  fi]
)
AC_SUBST([FBC_CROSSCOMP_DOS])

AC_ARG_ENABLE(crosscomp-freebsd,
 [  --enable-crosscomp-freebsd   enable -target freebsd],
 [if test "$FBC_TARGET" != "freebsd"; then
    FBC_CROSSCOMP_FREEBSD=yes
  fi]
)
AC_SUBST([FBC_CROSSCOMP_FREEBSD])

AC_ARG_ENABLE(crosscomp-linux,
 [  --enable-crosscomp-linux     enable -target linux],
 [if test "$FBC_TARGET" != "linux"; then
    FBC_CROSSCOMP_LINUX=yes
  fi]
)
AC_SUBST([FBC_CROSSCOMP_LINUX])

AC_ARG_ENABLE(crosscomp-win32,
 [  --enable-crosscomp-win32     enable -target win32],
 [if test "$FBC_TARGET" != "win32"; then
    FBC_CROSSCOMP_WIN32=yes
  fi]
)
AC_SUBST([FBC_CROSSCOMP_WIN32])

AC_ARG_ENABLE(crosscomp-xbox,
 [  --enable-crosscomp-xbox      enable -target xbox],
 [if test "$FBC_TARGET" != "xbox"; then
    FBC_CROSSCOMP_XBOX=yes
  fi]
)
AC_SUBST([FBC_CROSSCOMP_XBOX])


# Output
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
