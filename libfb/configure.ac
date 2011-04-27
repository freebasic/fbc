##
# Run 'autoconf' in this directory to (re)generate the 'configure' script
# based on this file. Run 'autoheader' to (re)generate the corresponding
# 'config.h.in'.

AC_INIT()
AC_PREREQ([2.59])
AC_CONFIG_AUX_DIR([../config])
AC_CONFIG_SRCDIR([fb.h])

# Find out what host system to build libfb for. It should be the same as
# fbc's target. Besides cross-compiling, libfb needs this information to
# include system-specific code. It's passed down from configure to the
# makefile via AC_SUBST's, and into config.h via AC_DEFINE's.
# When implementing support for a new system in the source, the checks here
# will most likely need adjustment in order to build the library for the
# new system.
AC_CANONICAL_BUILD
AC_CANONICAL_HOST

case "$host_os" in
cygwin*)
    HOST_OS=cygwin
    HOST_OSFAMILY=windows
    HOST_GFXFAMILY=windows
    AC_DEFINE([HOST_CYGWIN], [1], [Cygwin host])
    AC_DEFINE([HOST_WINDOWS], [1], [Windows-like host])
    ;;
darwin*)
    HOST_OS=darwin
    HOST_OSFAMILY=unix
    HOST_GFXFAMILY=x11
    AC_DEFINE([HOST_DARWIN], [1], [Darwin host])
    AC_DEFINE([HOST_UNIX], [1], [Unix-like host])
    ;;
freebsd*)
    HOST_OS=freebsd
    HOST_OSFAMILY=unix
    HOST_GFXFAMILY=x11
    AC_DEFINE([HOST_FREEBSD], [1], [FreeBSD host])
    AC_DEFINE([HOST_UNIX], [1], [Unix-like host])
    ;;
linux*)
    HOST_OS=linux
    HOST_OSFAMILY=unix
    HOST_GFXFAMILY=x11
    AC_DEFINE([HOST_LINUX], [1], [Linux host])
    AC_DEFINE([HOST_UNIX], [1], [Unix-like host])
    ;;
mingw*)
    HOST_OS=mingw
    HOST_OSFAMILY=windows
    HOST_GFXFAMILY=windows
    AC_DEFINE([HOST_MINGW], [1], [MinGW host])
    AC_DEFINE([HOST_WINDOWS], [1], [Windows-like host])
    ;;
msdos*)
    HOST_OS=djgpp
    HOST_OSFAMILY=dos
    HOST_GFXFAMILY=dos
    AC_DEFINE([HOST_DJGPP], [1], [DJGPP host])
    AC_DEFINE([HOST_DOS], [1], [DOS-like host])
    ;;
netbsd*)
    HOST_OS=netbsd
    HOST_OSFAMILY=unix
    HOST_GFXFAMILY=x11
    AC_DEFINE([HOST_NETBSD], [1], [NetBSD host])
    AC_DEFINE([HOST_UNIX], [1], [Unix-like host])
    ;;
openbsd*)
    HOST_OS=openbsd
    HOST_OSFAMILY=unix
    HOST_GFXFAMILY=x11
    AC_DEFINE([HOST_OPENBSD], [1], [OpenBSD host])
    AC_DEFINE([HOST_UNIX], [1], [Unix-like host])
    ;;
solaris*)
    HOST_OS=solaris
    HOST_OSFAMILY=unix
    HOST_GFXFAMILY=x11
    AC_DEFINE([HOST_SOLARIS], [1], [Solaris host])
    AC_DEFINE([HOST_UNIX], [1], [Unix-like host])
    ;;
xbox*)
    HOST_OS=xbox
    HOST_OSFAMILY=xbox
    HOST_GFXFAMILY=xbox
    AC_DEFINE([HOST_XBOX], [1], [Xbox host])
    ;;
*)
    AC_MSG_ERROR([Unexpected host OS])
    ;;
esac

case "$host_cpu" in
i?86)
    HOST_CPUFAMILY=x86
    AC_DEFINE([HOST_X86], [1], [x86 host CPU])
    ;;
x86_64)
    HOST_CPUFAMILY=x86_64
    AC_DEFINE([HOST_X86_64], [1], [x86_64 host CPU])
    ;;
sparc)
    HOST_CPUFAMILY=sparc
    AC_DEFINE([HOST_SPARC], [1], [Sparc host CPU])
    ;;
sparc64)
    HOST_CPUFAMILY=sparc64
    AC_DEFINE([HOST_SPARC64], [1], [Sparc64 host CPU])
    ;;
powerpc64)
    HOST_CPUFAMILY=powerpc64
    AC_DEFINE([HOST_POWERPC64], [1], [PowerPC64 host CPU])
    ;;
*)
    AC_MSG_ERROR([Unexpected host CPU])
    ;;
esac

# Pass down to makefile
AC_SUBST([HOST_OS])
AC_SUBST([HOST_OSFAMILY])
AC_SUBST([HOST_CPUFAMILY])
AC_SUBST([HOST_GFXFAMILY])

# Custom configure options

# --disable-gfx
# Allows to build without the graphics functions, which is needed for systems
# where they aren't implemented yet.
AC_ARG_ENABLE(
    [gfx],
    [AS_HELP_STRING([--disable-gfx],
                    [Do not include graphics functions at all])],
    [ENABLE_GFX=$enableval],
    [ENABLE_GFX=yes]
)
AC_SUBST([ENABLE_GFX])

# --disable-opengl
# By default, the OpenGL graphics backend is enabled. When building for DOS,
# or when --disable-gfx was given, then we enforce --disable-opengl.
AC_ARG_ENABLE(
    [opengl],
    [AS_HELP_STRING([--disable-opengl],
                    [Do not include the OpenGL graphics backend])],
    [AS_IF([test "x$ENABLE_GFX" = "xno" || test "x$HOST_OSFAMILY" = "xdos"],
           [ENABLE_OPENGL=no],
           [ENABLE_OPENGL=$enableval])],
    [ENABLE_OPENGL=$ENABLE_GFX]
)
AC_SUBST([ENABLE_OPENGL])

AC_ARG_VAR([OPENXDK], [Location of the Open XBox Development Kit])

# Checks for programs

# C compiler (this also checks some other things, e.g. EXEEXT)
# Default CFLAGS are coming from here (usually '-g -O2')
AC_PROG_CC

# C preprocessor
AC_PROG_CPP

# ar (this also preserves AR)
AC_CHECK_TOOL([AR], [ar], [:])

# $build system specifics, the detection of which autoconf doesn't support...
# (Same problems as with CC_FOR_BUILD etc. in binutils/gcc)
# Luckily for fbc there is not much to detect anyways.
# Determine working values, unless the user already set the variables.
AC_ARG_VAR([BUILD_FBC], [FreeBASIC compiler used to compile tools for the build system])
AC_ARG_VAR([BUILD_EXEEXT], [Executable file extension on the build system])
if test "$build" != "$host"; then
    if test -z "$BUILD_FBC"; then
        # 'fbc' is the native-to-native compiler, just what we want.
        BUILD_FBC=${BUILD_FBC-"fbc"};
    fi
    case "$build_os" in
    cygwin* | mingw* | msdos* )
        BUILD_EXEEXT=${BUILD_EXEEXT-".exe"}
        ;;
    esac
else
    # Not cross-compiling, so just use the host variables.
    BUILD_FBC=${BUILD_FBC-"$FBC"}
    BUILD_EXEEXT=${BUILD_EXEEXT-"$EXEEXT"}
fi

# Checks for header files

AC_HEADER_DIRENT
AC_HEADER_STDC
AC_HEADER_SYS_WAIT
AC_HEADER_TIME

AC_CHECK_HEADERS([  \
    fcntl.h         \
    float.h         \
    malloc.h        \
    math.h          \
    stddef.h        \
    stdio.h         \
    stdlib.h        \
    string.h        \
    sys/file.h      \
    sys/io.h        \
    sys/ioctl.h     \
    sys/time.h      \
    termcap.h       \
    termios.h       \
    unistd.h        \
    wchar.h         \
    wctype.h        \
])

# Check for GL/gl.h only if the feature is enabled (see --disable-opengl)
if test "x$ENABLE_OPENGL" = "xyes"; then
    AC_CHECK_HEADERS([GL/gl.h], , AC_MSG_ERROR([OpenGL headers not found]))
fi

# Check for X, but only on Unix-like systems. This also adds the --with[out]-x
# ($with_x) option.
X_INCLUDES=""
WITH_X=no
if test "x$HOST_OSFAMILY" = "xunix" || test "x$HOST_GFXFAMILY" = "xx11"; then
    if test "x$with_x" != xno; then
        AC_PATH_X
        if test "x$x_includes" != "xNONE"; then
             X_INCLUDES="$x_includes"
        fi
        if test "x$no_x" != "xyes"; then
            WITH_X=yes
            AC_DEFINE([WITH_X],
                      [1],
                      [Define to 1 if you want to use the X Window System])
        fi
    fi
fi
AC_SUBST([X_INCLUDES])
AC_SUBST([WITH_X])

AC_CHECK_HEADERS([curses.h term.h],,,
[[#ifdef HAVE_CURSES_H
# include <curses.h>
#endif
]])

# Make sure off_t is 64-bit in *nix
AC_DEFINE([_FILE_OFFSET_BITS], [64], [File offset bits])

# Checks for types

AC_TYPE_OFF_T
AC_TYPE_PID_T
AC_TYPE_SIGNAL
AC_TYPE_SIZE_T

# Checks for structures

AC_STRUCT_TM

# Checks for some specific declarations

# PTHREAD_MUTEX_RECURSIVE
AC_CHECK_DECL(
    [PTHREAD_MUTEX_RECURSIVE],
    [AC_DEFINE([HAVE_PTHREAD_MUTEX_RECURSIVE],
               [1],
               [Define to 1 if you have PTHREAD_MUTEX_RECURSIVE])],
    ,
    [#include <pthread.h>]
)

# PTHREAD_MUTEX_RECURSIVE_NP
AC_CHECK_DECL(
    [PTHREAD_MUTEX_RECURSIVE_NP],
    [AC_DEFINE([HAVE_PTHREAD_MUTEX_RECURSIVE_NP],
               [1],
               [Define to 1 if you have PTHREAD_MUTEX_RECURSIVE_NP])],
    ,
    [#include <pthread.h>]
)

# Checks for compiler characteristics

AC_C_BIGENDIAN
AC_C_CONST
AC_C_VOLATILE

# Checks for library functions

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

AC_CHECK_FUNCS([    \
    atexit          \
    chdir           \
    floor           \
    fopen64         \
    freopen64       \
    fseeko64        \
    ftello64        \
    getcwd          \
    gettimeofday    \
    memchr          \
    memmove         \
    memset          \
    mkdir           \
    pclose          \
    popen           \
    pow             \
    putenv          \
    rint            \
    rmdir           \
    select          \
    snprintf        \
    stat64          \
    strcasecmp      \
    strchr          \
    strdup          \
    strncasecmp     \
    strrchr         \
    strstr          \
    strtod          \
    strtof          \
    strtoul         \
    strtoull        \
    wcstoll         \
    wcstoull        \
])

# Checks for system services

# Large file support. This also adds --disable-largefile, but we don't care
# about it.
AC_SYS_LARGEFILE

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([makefile])
AC_OUTPUT
