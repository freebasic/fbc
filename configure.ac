##
# Run 'autoconf' in this directory to (re)generate the 'configure' script
# based on this file.

AC_INIT()
AC_PREREQ([2.59])
AC_CONFIG_AUX_DIR([config])
AC_CONFIG_SRCDIR([fbc/fbc.bas])

AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_CANONICAL_TARGET

# Provide *_noncanonical variables for build/host/target.
# $build_noncanonical will be either the same as $build_alias (if specified
# by the user via ./configure --build=foobar), or the same as $build (the
# canonical output of config.sub).
# This is useful in places where you always want to have a system name, and
# take into account the user's choice of name.
build_noncanonical=$build_alias
if test -z "$build_noncanonical"; then
    build_noncanonical=$build;
fi
host_noncanonical=$host_alias
if test -z "$host_noncanonical"; then
    host_noncanonical=$host;
fi
target_noncanonical=$target_alias
if test -z "$target_noncanonical"; then
    target_noncanonical=$target;
fi
AC_SUBST([build_noncanonical])
AC_SUBST([host_noncanonical])
AC_SUBST([target_noncanonical])

case "$host_cpu" in
i?86)
    HOST_CPUFAMILY=x86
    ;;
x86_64)
    HOST_CPUFAMILY=x86_64
    ;;
*)
    AC_MSG_ERROR([Unexpected host CPU])
    ;;
esac

case "$host_os" in
cygwin*)
    HOST_OS=cygwin
    HOST_OSFAMILY=windows
    ;;
freebsd*)
    HOST_OS=freebsd
    HOST_OSFAMILY=unix
    ;;
linux*)
    HOST_OS=linux
    HOST_OSFAMILY=unix
    ;;
mingw*)
    HOST_OS=mingw
    HOST_OSFAMILY=windows
    ;;
msdos*)
    HOST_OS=djgpp
    HOST_OSFAMILY=dos
    ;;
netbsd*)
    HOST_OS=netbsd
    HOST_OSFAMILY=unix
    ;;
openbsd*)
    HOST_OS=openbsd
    HOST_OSFAMILY=unix
    ;;
solaris*)
    HOST_OS=solaris
    HOST_OSFAMILY=unix
    ;;
xbox*)
    HOST_OS=xbox
    HOST_OSFAMILY=xbox
    ;;
*)
    AC_MSG_ERROR([Unexpected host OS])
    ;;
esac

AC_SUBST([HOST_CPUFAMILY])
AC_SUBST([HOST_OS])
AC_SUBST([HOST_OSFAMILY])

# --disable-objinfo
AC_ARG_ENABLE(
    [objinfo],
    [AS_HELP_STRING([--disable-objinfo],
                    [Disable the objinfo feature of fbc, so libbfd \
                     will not be needed.])],
    [ENABLE_OBJINFO=$enableval],
    [ENABLE_OBJINFO=yes]
)
AC_SUBST([ENABLE_OBJINFO])

# --enable-fbbfd=217
AC_ARG_ENABLE(
    [fbbfd],
    [AS_HELP_STRING([[--enable-fbbfd[=version]]],
                    [Build fbc using the FB bfd headers for the specified \
                     libbfd version, instead of using the bfd.h of the system. \
                     If the version is not explicitely specified, it will \
                     default to 217.])],
    [AS_IF([test "x$enableval" = "xyes"], [ENABLE_FBBFD=217],
           [ENABLE_FBBFD=$enableval])],
    [ENABLE_FBBFD=no]
)
AC_SUBST([ENABLE_FBBFD])

AC_PROG_CC
AC_PROG_CPP
AC_PROG_MKDIR_P
AC_PROG_MAKE_SET

# Check for FreeBASIC compiler and preserve the FBC variable.
# This also checks for i686-pc-linux-gnu-fbc and such when cross-compiling.
AC_CHECK_TOOL([FBC], [fbc], [:])

AC_CONFIG_FILES([
    makefile
    fbc/makefile
    fbc/config.bi
])

AC_OUTPUT
