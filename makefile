#!/usr/bin/make -f
#
# This is the main makefile that builds the compiler (fbc) and the runtime
# libraries (rtlib -> libfb[mt] and fbrt0.o, gfxlib2 -> libfbgfx).
# Try 'make help' for information on what you can configure.
#
# Requirements:
#  - (GNU?) make to run this makefile
#  - fbc (it compiles itself)
#  - binutils' libbfd development files (for the compiler, optional)
#  - Unixy shell environment
#
#  - DOS:
#    - DJGPP 2.04
#    - FB currently relies on a patched version of DJGPP's libc/crt0/_main.c,
#      see contrib/djgpp/, it has to be used instead of DJGPP's own for any
#      FB program that uses FB runtime functions from global ctors/dtors or
#      has global UDTs/objects.
#
#  - Linux (and also *BSD etc.):
#    - gcc & binutils
#    - X11 development files (for the graphics runtime, can be disabled)
#    - ncurses development files
#    - gpm (general purpose mouse) headers
#    - GL headers (typically from freeglut, can be disabled)
#
#  - Win32:
#    - MinGW & MSYS
#    - DirectX headers (for the graphics runtime)
#
# Cross-compilation and building a cross-compiler is supported similar to
# autoconf: through the HOST and TARGET variables that can be set to system
# triplets. For example, on Debian with i586-mingw32msvc-binutils and
# i586-mingw32msvc-gcc you can build a i586-mingw32msvc-fbc:
#    make TARGET=i586-mingw32msvc
# By default TARGET is the same as HOST, and HOST is the same as
# the build system, which is guessed mostly via uname. In case the triplet
# parsing or default system detection fails, please fix it and make it work!
#
# Alternatively (instead of using a system triplet) you can set HOST_OS,
# HOST_ARCH and/or TARGET_OS, TARGET_ARCH directly, which should allow
# building a cross-compiler without the target triplet name prefix.
# FB OS names:
#    dos cygwin darwin freebsd linux netbsd openbsd solaris win32 xbox
#    (where 'dos' should be 'djgpp', and 'win32' should be 'mingw')
# FB architecture names:
#    386 486 586 686 x86_64 sparc sparc64 powerpc64
# Note: In the runtime, the win32 parts are used for both mingw and cygwin,
# so there we have HOST_MINGW/CYGWIN and the HOST_WIN32 common to both.
# In the makefile/compiler win32 means just mingw though.
#
# FB directory layout ('target-' is the cross-compiler name prefix,
# '-suffix' is the optional name suffix that can be used to differentiate
# parallel fbc installations):
#    a) Default (for Unixy installations):
#          bin/target-fbc-suffix
#          include/target-freebasic-suffix/fbgfx.bi
#          lib/target-freebasic-suffix/libfb.a
#    b) Standalone (for self-contained DOS/Windows installations):
#          target-fbc-suffix.exe
#          target-include-suffix/fbgfx.bi
#          target-lib-suffix/libfb.a
#
# libbfd tips:
#    fbc uses libbfd to add and read out extra information to/from object files
#    and static libraries, for example a list of library names from '-l somelib'
#    command line options and #inclibs in FB source code, to allow users to
#    compile and link in separate steps without having to explicitly specify
#    all '-l somelib' options for the link step. 
#    It's an optional but convenient feature. (see DISABLE_OBJINFO)
#    Read more here: <http://www.freebasic.net/wiki/wikka.php?wakka=DevObjinfo>
#    For the releases made by the fbc project, fbc is linked against a static
#    libbfd 2.17,
#        a) to avoid dependencies on a shared libbfd, because many Linux
#           distributions have different versions of it, and
#        b) to avoid licensing related issues with fbc (GPLv2) and
#           statically-linked libbfd > 2.17 (GPLv3).
#
# XBox/OpenXDK-related tips (TODO: Not tested in a long time, needs updating!)
#  - Install OpenXDK as usual (preferably from SVN if there are no recent
#    releases). Apply contrib/openxdk/configure.in-mingw.patch if necessary.
#  - Replace $OPENXDK/bin/i386-pc-xbox-gcc with the one from
#    contrib/openxdk/i386-pc-xbox-gcc - this avoids having to rebuild gcc while
#    still getting the OpenXDK include and lib directories instead of the MinGW
#    ones so that configure will work correctly. Modify this script if needed to
#    run MinGW gcc (the current one should work in MSYS) or if OpenXDK is
#    installed somewhere else.
#  - !!!WRITEME!!! cp $MINGW/include/{x,y,z}.h $OPENXDK/i386-pc-xbox/include/
#  - Make sure $OPENXDK/bin is in $PATH
#      export PATH=$PATH:/usr/local/openxdk/bin
#  - Build for or enable the "i386-pc-xbox" target.
#
# Rough overview of what this makefile does:
#  - #include config.mk and new/config.mk,
#  - Guess the OS/arch types, or parse the HOST/TARGET triplets to find out
#  - Set HOST_FBC, TARGET_CC, prefix, EXEEXT, etc. based on that
#  - Figure out the directory layout (normal vs. standalone), same for
#    file names/locations of fbc/libfb etc., for both new/ and $prefix/
#    directories.
#  - Set FBCFLAGS, FBLFLAGS and ALLCFLAGS
#  - Select compiler/runtime sources based on host/target systems
#  - Perform build/install rules
#
# Note: In order to be compatible to older makes, namely DJGPP's
# GNU make 3.79.1, features added in more recent versions cannot be used.
# For example:
#  - "else if"
#  - Order-only prerequisites
#  - $(or ...), $(and ...)
#  - $(eval ...)
#
# A Unixy shell environment is required. It would be too hard and ugly to
# support multiple other shells (e.g. cmd.exe, COMMAND.COM) and work-around
# their limitations (recursive directory creation, command line length limits,
# missing commands, case-preservation in file names, different syntax for
# quoting and escaping, file name restrictions, forward slashes vs.
# backslashes). If FB had less build modes (standalone vs. normal directory
# layout) and would just consist of fbc and one libfreebasic this all would
# be easier. And then there's the problem of whether the test suite or fbdocs
# (and other things in the FB source) will work without a Unixy shell, not to
# mention building other projects such as binutils, for which a Unixy shell is
# needed anyways.
#

FBC := fbc
CC := gcc
CFLAGS := -O2
AR := ar

# For copying fbc and the includes/libraries into $(prefix),
# should be better than plain cp at replacing fbc while fbc is running.
INSTALL_PROGRAM := install
INSTALL_FILE := install -m 644

-include config.mk

# The default build directory
ifndef new
  override new := new
endif

-include $(new)/config.mk

#
# Host/target system determination
#

# os = iif(has >= 3 words, words 3..EOL, last word)
# 'i686 pc linux gnu' -> 'linux gnu'
# 'mingw32'           -> 'mingw32'
extract-os = $(if $(word 3,$(1)),$(wordlist 3,$(words $(1)),$(1)),$(lastword $(1)))

# arch = iif(has >= 2 words, first word, unknown)
# 'i686 pc linux gnu' -> 'i686'
# 'mingw32'           -> 'unknown'
extract-arch = $(if $(word 2,$(1)),$(firstword $(1)),unknown)

# In autoconf we used a shell case statement and checked for *-*-mingw*, but
# here we convert 'i686-pc-mingw32' to 'i686 pc mingw32' and then use make's
# word/text processing functions to take it apart.
extract-triplet-os = $(call extract-os,$(subst -, ,$(1)))
extract-triplet-arch = $(call extract-arch,$(subst -, ,$(1)))

ifdef HOST
  # Parse the HOST triplet
  HOST_PREFIX := $(HOST)-

  ifndef HOST_OS
    triplet_os := $(call extract-triplet-os,$(HOST))
    ifneq ($(filter cygwin%,$(triplet_os)),)
      HOST_OS := cygwin
    endif
    ifneq ($(filter darwin%,$(triplet_os)),)
      HOST_OS := darwin
    endif
    ifneq ($(filter djgpp%,$(triplet_os)),)
      HOST_OS := dos
    endif
    ifneq ($(filter freebsd%,$(triplet_os)),)
      HOST_OS := freebsd
    endif
    ifneq ($(filter linux%,$(triplet_os)),)
      HOST_OS := linux
    endif
    ifneq ($(filter mingw%,$(triplet_os)),)
      HOST_OS := win32
    endif
    ifneq ($(filter netbsd%,$(triplet_os)),)
      HOST_OS := netbsd
    endif
    ifneq ($(filter openbsd%,$(triplet_os)),)
      HOST_OS := openbsd
    endif
    ifneq ($(filter solaris%,$(triplet_os)),)
      HOST_OS := solaris
    endif
    ifneq ($(filter xbox%,$(triplet_os)),)
      HOST_OS := xbox
    endif
  endif

  ifndef HOST_ARCH
    triplet_arch := $(call extract-triplet-arch,$(HOST))
    ifeq ($(triplet_arch),i386)
      HOST_ARCH := 386
    endif
    ifeq ($(triplet_arch),i486)
      HOST_ARCH := 486
    endif
    ifeq ($(triplet_arch),i586)
      HOST_ARCH := 586
    endif
    ifeq ($(triplet_arch),i686)
      HOST_ARCH := 686
    endif
    ifeq ($(triplet_arch),x86_64)
      HOST_ARCH := x86_64
    endif
    ifeq ($(triplet_arch),sparc)
      HOST_ARCH := sparc
    endif
    ifeq ($(triplet_arch),sparc64)
      HOST_ARCH := sparc64
    endif
    ifeq ($(triplet_arch),powerpc64)
      HOST_ARCH := powerpc64
    endif
  endif

  # For some triplets we can choose good default archs, e.g. i486 for 'mingw32'
  ifndef HOST_ARCH
    ifeq ($(HOST_OS),dos)
      HOST_ARCH := 386
    endif
    ifeq ($(HOST_OS),win32)
      HOST_ARCH := 486
    endif
  endif

  ifndef HOST_OS
    $(error Sorry, the OS part of HOST='$(HOST)' could not be identified. \
            Maybe the makefile should be fixed.)
  endif

  ifndef HOST_ARCH
    $(error Sorry, the CPU arch part of HOST='$(HOST)' could not be \
            identified. Maybe the makefile should be fixed.)
  endif
else
  # No HOST given, so try to guess it via uname.
  ifndef HOST_OS
    uname := $(shell uname)
    ifneq ($(findstring CYGWIN,$(uname)),)
      HOST_OS := cygwin
    endif
    ifeq ($(uname),Darwin)
      HOST_OS := darwin
    endif
    ifeq ($(uname),FreeBSD)
      HOST_OS := freebsd
    endif
    ifeq ($(uname),Linux)
      HOST_OS := linux
    endif
    ifneq ($(findstring MINGW,$(uname)),)
      HOST_OS := win32
    endif
    ifeq ($(uname),MS-DOS)
      HOST_OS := dos
    endif
    ifeq ($(uname),NetBSD)
      HOST_OS := netbsd
    endif
    ifeq ($(uname),OpenBSD)
      HOST_OS := openbsd
    endif
    ifndef HOST_OS
      $(error Sorry, your OS could not be identified automatically. \
              Maybe the makefile should be fixed. 'uname' returned: '$(uname)')
    endif
  endif

  # For the DJGPP build, just use i386, and don't bother calling 'uname -m',
  # which only returns 'pc' anyways.
  ifndef HOST_ARCH
    ifeq ($(HOST_OS),dos)
      HOST_ARCH := 386
    endif
  endif

  # Otherwise try to guess the HOST_ARCH based on 'uname -m'
  ifndef HOST_ARCH
    uname_m := $(shell uname -m)
    ifeq ($(uname_m),i386)
      HOST_ARCH = 386
    endif
    ifeq ($(uname_m),i486)
      HOST_ARCH = 486
    endif
    ifeq ($(uname_m),i586)
      HOST_ARCH = 586
    endif
    ifeq ($(uname_m),i686)
      HOST_ARCH = 686
    endif
    ifeq ($(uname_m),x86_64)
      HOST_ARCH = x86_64
    endif
    ifeq ($(uname_m),sparc)
      HOST_ARCH = sparc
    endif
    ifeq ($(uname_m),sparc64)
      HOST_ARCH = sparc64
    endif
    ifeq ($(uname_m),powerpc64)
      HOST_ARCH = powerpc64
    endif
    ifndef HOST_ARCH
      $(error Sorry, your system's CPU arch could not be identified \
              automatically. Maybe the makefile should be fixed. \
              'uname -m' returned: '$(uname_m)')
    endif
  endif
endif

ifdef TARGET
  # TARGET given, so parse it
  TARGET_PREFIX := $(TARGET)-

  ifndef TARGET_OS
    triplet_os := $(call extract-triplet-os,$(TARGET))
    ifneq ($(filter cygwin%,$(triplet_os)),)
      TARGET_OS := cygwin
    endif
    ifneq ($(filter darwin%,$(triplet_os)),)
      TARGET_OS := darwin
    endif
    ifneq ($(filter djgpp%,$(triplet_os)),)
      TARGET_OS := dos
    endif
    ifneq ($(filter freebsd%,$(triplet_os)),)
      TARGET_OS := freebsd
    endif
    ifneq ($(filter linux%,$(triplet_os)),)
      TARGET_OS := linux
    endif
    ifneq ($(filter mingw%,$(triplet_os)),)
      TARGET_OS := win32
    endif
    ifneq ($(filter netbsd%,$(triplet_os)),)
      TARGET_OS := netbsd
    endif
    ifneq ($(filter openbsd%,$(triplet_os)),)
      TARGET_OS := openbsd
    endif
    ifneq ($(filter solaris%,$(triplet_os)),)
      TARGET_OS := solaris
    endif
    ifneq ($(filter xbox%,$(triplet_os)),)
      TARGET_OS := xbox
    endif
  endif

  ifndef TARGET_ARCH
    triplet_arch := $(call extract-triplet-arch,$(TARGET))
    ifeq ($(triplet_arch),i386)
      TARGET_ARCH := 386
    endif
    ifeq ($(triplet_arch),i486)
      TARGET_ARCH := 486
    endif
    ifeq ($(triplet_arch),i586)
      TARGET_ARCH := 586
    endif
    ifeq ($(triplet_arch),i686)
      TARGET_ARCH := 686
    endif
    ifeq ($(triplet_arch),x86_64)
      TARGET_ARCH := x86_64
    endif
    ifeq ($(triplet_arch),sparc)
      TARGET_ARCH := sparc
    endif
    ifeq ($(triplet_arch),sparc64)
      TARGET_ARCH := sparc64
    endif
    ifeq ($(triplet_arch),powerpc64)
      TARGET_ARCH := powerpc64
    endif
  endif

  # For some triplets we can choose good default archs, e.g. i486 for 'mingw32'
  ifndef TARGET_ARCH
    ifeq ($(TARGET_OS),dos)
      TARGET_ARCH := 386
    endif
    ifeq ($(TARGET_OS),win32)
      TARGET_ARCH := 486
    endif
  endif

  ifndef TARGET_OS
    $(error Sorry, the OS part of TARGET='$(TARGET)' could not be \
            identified. Maybe the makefile should be fixed.)
  endif

  ifndef TARGET_ARCH
    $(error Sorry, the CPU arch part of TARGET='$(TARGET)' could not be \
            identified. Maybe the makefile should be fixed.)
  endif
else
  # No TARGET given, so use the same values as for HOST
  ifdef HOST
    TARGET := $(HOST)
    TARGET_PREFIX := $(HOST_PREFIX)
  endif
  ifndef TARGET_OS
    TARGET_OS := $(HOST_OS)
  endif
  ifndef TARGET_ARCH
    TARGET_ARCH := $(HOST_ARCH)
  endif
endif

ifneq ($(filter cygwin dos win32,$(HOST_OS)),)
  EXEEXT := .exe
endif

#
# Directory layout setup
#

ifndef prefix
  override prefix := /usr/local
endif

ifdef ENABLE_STANDALONE
  newbin     := $(new)
  newinclude := $(new)/$(TARGET_PREFIX)include$(SUFFIX)
  newlib     := $(new)/$(TARGET_PREFIX)lib$(SUFFIX)
  prefixbin     := $(prefix)
  prefixinclude := $(prefix)/$(TARGET_PREFIX)include$(SUFFIX)
  prefixlib     := $(prefix)/$(TARGET_PREFIX)lib$(SUFFIX)
else
  ifeq ($(HOST_OS),dos)
    FB_NAME := freebas
  else
    FB_NAME := freebasic
  endif
  newbin     := $(new)/bin
  newinclude := $(new)/include/$(TARGET_PREFIX)$(FB_NAME)$(SUFFIX)
  newlib     := $(new)/lib/$(TARGET_PREFIX)$(FB_NAME)$(SUFFIX)
  prefixbin     := $(prefix)/bin
  prefixinclude := $(prefix)/include/$(TARGET_PREFIX)$(FB_NAME)$(SUFFIX)
  prefixlib     := $(prefix)/lib/$(TARGET_PREFIX)$(FB_NAME)$(SUFFIX)
endif

FBC_EXE := $(TARGET_PREFIX)fbc$(SUFFIX)$(SUFFIX2)$(EXEEXT)

newcompiler := $(new)/compiler
newlibfb    := $(new)/libfb
newlibfbmt  := $(new)/libfbmt
newlibfbgfx := $(new)/libfbgfx

# Unless objinfo is disabled, we use the fbextra.x supplemental ldscript to
# drop objinfo sections when linking. This lets the system/linker's default
# script still take effect, which is good e.g. to support extra library search
# paths specified in the ldscript (e.g. multi-arch directory layout on Debian).
# For DOS/DJGPP FB however we have modified ld's ldscript to fix the order of
# ctors/dtors, so that's a special case.
ifeq ($(TARGET_OS),dos)
  FB_LDSCRIPT := i386go32.x
else
  ifndef DISABLE_OBJINFO
    FB_LDSCRIPT := fbextra.x
  endif
endif

#
# Compilers and flags
#

ifndef HOST_FBC
  HOST_FBC := $(HOST_PREFIX)$(FBC)
endif
ifndef HOST_CC
  HOST_CC := $(HOST_PREFIX)$(CC)
endif
ifndef TARGET_AR
  TARGET_AR := $(TARGET_PREFIX)$(AR)
endif
ifndef TARGET_CC
  TARGET_CC := $(TARGET_PREFIX)$(CC)
endif

FBCFLAGS := -maxerr 1 -w pedantic -e -m fbc -include $(newcompiler)/config.bi $(FBFLAGS)
FBLFLAGS := -maxerr 1 -w pedantic $(FBFLAGS)
ALLCFLAGS := -Wfatal-errors $(CFLAGS) -Wall -include $(newlibfb)/config.h

ifneq ($(filter cygwin win32,$(HOST_OS)),)
  FBLFLAGS += -t 2048
endif

ifndef DISABLE_OBJINFO
  FBLFLAGS += -l bfd -l iberty
  ifeq ($(HOST_OS),cygwin)
    FBLFLAGS += -l intl
  endif
  ifeq ($(HOST_OS),dos)
    FBLFLAGS += -l intl -l z
  endif
  ifeq ($(HOST_OS),freebsd)
    FBLFLAGS += -l intl
  endif
  ifeq ($(HOST_OS),openbsd)
    FBLFLAGS += -l intl
  endif
  ifeq ($(HOST_OS),win32)
    FBLFLAGS += -l user32
  endif
endif

# Some special treatment for xbox. TODO: Test me, update me!
ifeq ($(TARGET_OS),xbox)
  ALLCFLAGS += -DENABLE_XBOX -DDISABLE_CDROM
  ALLCFLAGS += -std=gnu99 -mno-cygwin -nostdlib -nostdinc
  ALLCFLAGS += -ffreestanding -fno-builtin -fno-exceptions
  ALLCFLAGS += -I$(OPENXDK)/i386-pc-xbox/include
  ALLCFLAGS += -I$(OPENXDK)/include
  ALLCFLAGS += -I$(OPENXDK)/include/SDL
endif

#
# Sources
#

FBC_BI := $(newcompiler)/config.bi
FBC_BI += compiler/ast.bi
FBC_BI += compiler/ast-op.bi
FBC_BI += compiler/bfd-wrapper.bi
FBC_BI += compiler/clist.bi
FBC_BI += compiler/dstr.bi
FBC_BI += compiler/emit.bi
FBC_BI += compiler/emitdbg.bi
FBC_BI += compiler/error.bi
FBC_BI += compiler/fb.bi
FBC_BI += compiler/fbc.bi
FBC_BI += compiler/fbint.bi
FBC_BI += compiler/fb-obj.bi
FBC_BI += compiler/flist.bi
FBC_BI += compiler/hash.bi
FBC_BI += compiler/hlp.bi
FBC_BI += compiler/hlp-str.bi
FBC_BI += compiler/ir.bi
FBC_BI += compiler/lex.bi
FBC_BI += compiler/list.bi
FBC_BI += compiler/parser.bi
FBC_BI += compiler/pool.bi
FBC_BI += compiler/pp.bi
FBC_BI += compiler/reg.bi
FBC_BI += compiler/rtl.bi
FBC_BI += compiler/stabs.bi
FBC_BI += compiler/stack.bi
FBC_BI += compiler/symb.bi

FBC_BAS := \
  ast ast-gosub ast-helper ast-misc \
  ast-node-addr ast-node-arg ast-node-assign ast-node-bop ast-node-branch \
  ast-node-call ast-node-check ast-node-const ast-node-conv ast-node-data \
  ast-node-decl ast-node-enum ast-node-field ast-node-idx ast-node-iif \
  ast-node-link ast-node-load ast-node-mem ast-node-misc ast-node-namespace \
  ast-node-proc ast-node-ptr ast-node-scope ast-node-stack ast-node-typeini \
  ast-node-uop ast-node-var ast-optimize ast-vectorize \
  clist dstr edbg_stab emit emit_SSE emit_x86 error fb fb-main \
  fbc flist hash hlp hlp-str ir ir-hlc ir-tac lex lex-utf list \
  parser-assignment parser-comment parser-compound parser-compound-do \
  parser-compound-extern parser-compound-for parser-compound-if \
  parser-compound-namespace parser-compound-scope parser-compound-select \
  parser-compound-select-const parser-compound-while parser-compound-with \
  parser-decl parser-decl-const parser-decl-def parser-decl-enum \
  parser-decl-option parser-decl-proc parser-decl-proc-params \
  parser-decl-struct parser-decl-symb-init parser-decl-symbtype \
  parser-decl-typedef parser-decl-var parser-expr-atom parser-expr-binary \
  parser-expr-constant parser-expr-function parser-expr-unary \
  parser-expr-variable parser-identifier parser-inlineasm parser-label \
  parser-proc parser-proccall-args parser-proccall parser-quirk-array \
  parser-quirk parser-quirk-casting parser-quirk-console parser-quirk-data \
  parser-quirk-error parser-quirk-file parser-quirk-gfx \
  parser-quirk-goto-return parser-quirk-iif parser-quirk-math \
  parser-quirk-mem parser-quirk-on parser-quirk-peekpoke parser-quirk-string \
  parser-quirk-vafirst parser-statement parser-toplevel \
  pool pp pp-cond pp-define pp-pragma reg \
  rtl rtl-array rtl-console rtl-data rtl-error rtl-file rtl-gfx rtl-gosub \
  rtl-macro rtl-math rtl-mem rtl-print rtl-profile rtl-string rtl-system \
  stack symb symb-bitfield symb-comp symb-const symb-data symb-define \
  symb-enum symb-keyword symb-label symb-lib symb-mangling symb-namespace \
  symb-proc symb-scope symb-struct symb-typedef symb-var

ifndef DISABLE_OBJINFO
  FBC_BAS += fb-objinfo
endif

FBC_BAS := $(patsubst %,$(newcompiler)/%.o,$(FBC_BAS))

FBC_BFDWRAPPER :=
ifndef DISABLE_OBJINFO
  ifndef ENABLE_FBBFD
    FBC_BFDWRAPPER := $(newcompiler)/bfd-wrapper.o
  endif
endif

ifeq ($(TARGET_OS),dos)
  # Don't build libfbmt for DOS
  DISABLE_MT := YesPlease
  # And also no OpenGL support
  DISABLE_OPENGL := YesPlease
endif

# rtlib FB includes (gfxlib2's fbgfx.bi is handled separately)
NEW_FB_INCLUDES := \
  $(newinclude)/datetime.bi \
  $(newinclude)/dir.bi \
  $(newinclude)/file.bi \
  $(newinclude)/string.bi \
  $(newinclude)/utf_conv.bi \
  $(newinclude)/vbcompat.bi

LIBFB_H := $(newlibfb)/config.h
LIBFB_H += rtlib/fb.h
LIBFB_H += rtlib/fb_array.h
LIBFB_H += rtlib/fb_colors.h
LIBFB_H += rtlib/fb_config.h
LIBFB_H += rtlib/fb_con.h
LIBFB_H += rtlib/fb_console.h
LIBFB_H += rtlib/fb_data.h
LIBFB_H += rtlib/fb_datetime.h
LIBFB_H += rtlib/fb_device.h
LIBFB_H += rtlib/fb_error.h
LIBFB_H += rtlib/fb_file.h
LIBFB_H += rtlib/fb_hook.h
LIBFB_H += rtlib/fb_intern.h
LIBFB_H += rtlib/fb_math.h
LIBFB_H += rtlib/fb_port.h
LIBFB_H += rtlib/fb_printer.h
LIBFB_H += rtlib/fb_scancodes.h
LIBFB_H += rtlib/fb_serial.h
LIBFB_H += rtlib/fb_string.h
LIBFB_H += rtlib/fb_system.h
LIBFB_H += rtlib/fb_thread.h
LIBFB_H += rtlib/fb_unicode.h
LIBFB_H += rtlib/con_print_raw_uni.h
LIBFB_H += rtlib/con_print_tty_uni.h

LIBFB_C := \
  array_boundchk array_clear array_clear_obj array_core array_erase \
  array_erase_obj array_erasestr array_lbound array_redim array_redim_obj \
  array_redimpresv array_redimpresv_obj array_resetdesc array_setdesc \
  array_tmpdesc array_ubound \
  assert assert_wstr \
  con_lineinp con_lineinp_wstr con_locate con_pos con_print_raw \
  con_print_raw_wstr con_print_tty con_print_tty_wstr con_readline \
  data data_readbyte data_readdouble data_readint data_readlong \
  data_readshort data_readsingle data_readstr data_readubyte data_readuint \
  data_readulong data_readushort data_read_wstr data_rest \
  dev_com dev_com_test dev_cons_open dev_err_open dev_file_close \
  dev_file_encod_open dev_file_encod_read dev_file_encod_read_core \
  dev_file_encod_readline dev_file_encod_readline_wstr \
  dev_file_encod_read_wstr dev_file_encod_write dev_file_encod_write_wstr \
  dev_file_eof dev_file_flush dev_file_lock dev_file_open dev_file_read \
  dev_file_readline dev_file_readline_wstr dev_file_read_wstr dev_file_seek \
  dev_file_size dev_file_tell dev_file_unlock dev_file_write \
  dev_file_write_wstr dev_lpt dev_lpt_close dev_lpt_test dev_lpt_write \
  dev_lpt_write_wstr dev_scrn dev_scrn_close dev_scrn_eof dev_scrn_init \
  dev_scrn_read dev_scrn_readline dev_scrn_readline_wstr dev_scrn_read_wstr \
  dev_scrn_write dev_scrn_write_wstr dev_stdio_close \
  error error_getset error_ptrchk \
  exit \
  file_attr file_close file_copy file_datetime file_encod file_eof \
  file_exists file_free file_getarray file_get file_getstr file_get_wstr \
  file_input_byte file_input_con file_input_file file_input_float \
  file_input_int file_input_longint file_input_short file_input_str \
  file_inputstr file_input_tok file_input_tok_wstr file_input_ubyte \
  file_input_uint file_input_ulongint file_input_ushort file_input_wstr \
  file_kill file_len file_lineinp file_lineinp_wstr file_loc file_lock \
  file_open file_opencom file_opencons file_openencod file_openerr \
  file_openlpt file_openpipe file_openscrn file_openshort file_print \
  file_print_wstr file_putarray file_putback file_putback_wstr file_put \
  file_putstr file_put_wstr file_reset file_seek file_size file_tell \
  file_winputstr \
  gosub \
  hook_cls hook_color hook_getsize hook_getx hook_getxy hook_gety hook_inkey \
  hook_isredir hook_lineinp hook_lineinp_wstr hook_locate_ex hook_mouse \
  hook_multikey hook_pageset hook_pcopy hook_ports hook_printstr \
  hook_print_wstr hook_readstr hook_readxy hook_sleep hook_view_update \
  hook_width \
  init \
  intl_get intl_getdateformat intl_getmonthname intl_getset intl_gettimeformat \
  intl_getweekdayname \
  io_lpos io_lprint_byte io_lprint_fix io_lprint_fp io_lprint_int \
  io_lprint_longint io_lprint_short io_lprint_str io_lprintusg io_lprintvoid \
  io_lprint_wstr io_print_byte io_print io_print_fix io_print_fp io_print_int \
  io_print_longint io_printpad io_printpad_wstr io_print_short io_printusg \
  io_printvoid io_printvoid_wstr io_print_wstr io_setpos io_spc io_view \
  io_viewhlp io_widthdev io_widthfile io_writebyte io_writefloat io_writeint \
  io_writelongint io_writeshort io_writestr io_writevoid io_write_wstr \
  list listdyn \
  math_fix math_frac math_rnd math_sgn \
  mem_copyclear \
  qb_file_open qb_inkey qb_sleep qb_str_convto qb_str_convto_flt \
  qb_str_convto_lng \
  signals \
  str_asc str_assign str_base str_bin str_bin_lng str_chr str_comp \
  str_concatassign str_concat str_convfrom str_convfrom_int str_convfrom_lng \
  str_convfrom_rad str_convfrom_radlng str_convfrom_uint str_convfrom_ulng \
  str_convto str_convto_flt str_convto_lng str_core str_cvmk str_del str_fill \
  str_format str_ftoa str_hex str_hex_lng str_instrany str_instr \
  str_instrrevany str_instrrev str_lcase str_left str_len str_ltrimany \
  str_ltrim str_ltrimex str_midassign str_mid str_misc str_oct str_oct_lng \
  str_right str_rtrimany str_rtrim str_rtrimex str_set str_tempdescf \
  str_tempdescv str_tempdescz str_tempres str_trimany str_trim str_trimex \
  str_ucase \
  strw_alloc strw_asc strw_assign strw_bin strw_bin_lng strw_chr strw_comp \
  strw_concatassign strw_concat strw_convassign strw_convconcat strw_convfrom \
  strw_convfrom_int strw_convfrom_lng strw_convfrom_rad strw_convfrom_radlng \
  strw_convfrom_str strw_convfrom_uint strw_convfrom_ulng strw_convto \
  strw_convto_flt strw_convto_lng strw_convto_str strw_del strw_fill strw_ftoa \
  strw_hex strw_hex_lng strw_instrany strw_instr strw_instrrevany \
  strw_instrrev strw_lcase strw_left strw_len strw_ltrimany strw_ltrim \
  strw_ltrimex strw_midassign strw_mid strw_oct strw_oct_lng strw_right \
  strw_rtrimany strw_rtrim strw_rtrimex strw_set strw_space strw_trimany \
  strw_trim strw_trimex strw_ucase \
  swap_mem swap_str swap_wstr \
  sys_beep sys_cdir sys_chain sys_chdir sys_cmd sys_environ sys_exec_core \
  sys_exepath sys_mkdir sys_rmdir sys_run \
  thread_ctx \
  time_core time_dateadd time_date time_datediff time_datepart time_dateserial \
  time_dateset time_datevalue time_decodeserdate time_decodesertime \
  time_isdate time_monthname time_now time_parsedate time_parsedatetime \
  time_parsetime time_sleepex time_time time_timeserial time_timeset \
  time_timevalue time_week time_weekdayname \
  utf_convfrom_char utf_convfrom_wchar utf_convto_char utf_convto_wchar \
  utf_core \
  vfs_open

LIBFB_S :=

ifeq ($(TARGET_OS),dos)
  LIBFB_H += rtlib/fb_dos.h
  LIBFB_H += rtlib/fb_unicode_dos.h
  LIBFB_C += \
    dev_pipe_close_dos dev_pipe_open_dos \
    drv_file_copy_dos drv_intl_dos drv_intl_data_dos drv_intl_get_dos \
    drv_intl_getdateformat_dos drv_intl_getmonthname_dos \
    drv_intl_gettimeformat_dos drv_intl_getweekdayname_dos \
    farmemset_dos \
    file_dir_dos file_hconvpath_dos file_hlock_dos file_resetex_dos \
    hexit_dos \
    hinit_dos \
    hsignals_dos \
    io_cls_dos io_color_dos io_getsize_dos io_inkey_dos io_isredir_dos \
    io_locate_dos io_maxrow_dos io_mouse_dos io_multikey_dos io_pageset_dos \
    io_pcopy_dos io_printbuff_dos io_printbuff_wstr_dos io_printer_dos \
    io_readstr_dos io_scroll_dos io_serial_dos io_viewupdate_dos io_width_dos \
    sys_exec_dos sys_fmem_dos sys_getcwd_dos sys_getexename_dos \
    sys_getexepath_dos sys_getshortpath_dos sys_isr_dos sys_ports_dos \
    sys_shell_dos sys_sleep_dos \
    thread_cond_dos thread_core_dos thread_mutex_dos \
    time_setdate_dos time_settime_dos time_sleep_dos time_tmr_dos
  LIBFB_S += drv_isr
endif

ifeq ($(TARGET_OS),freebsd)
  LIBFB_C += \
    hexit_freebsd \
    hinit_freebsd \
    io_mouse_freebsd io_multikey_freebsd \
    sys_fmem_freebsd sys_getexename_freebsd sys_getexepath_freebsd
endif

ifeq ($(TARGET_OS),linux)
  LIBFB_H += rtlib/fb_linux.h
  LIBFB_C += \
    hexit_linux \
    hinit_linux \
    io_mouse_linux io_multikey_linux io_serial_linux \
    sys_fmem_linux sys_getexename_linux sys_getexepath_linux sys_ports_linux
endif

ifeq ($(TARGET_OS),netbsd)
  LIBFB_C += \
    hexit_netbsd \
    hinit_netbsd \
    io_mouse_netbsd io_multikey_netbsd \
    sys_fmem_netbsd sys_getexename_netbsd sys_getexepath_netbsd
endif

ifeq ($(TARGET_OS),openbsd)
  LIBFB_C += \
    hexit_openbsd \
    hinit_openbsd \
    io_mouse_openbsd io_multikey_openbsd \
    sys_fmem_openbsd sys_getexename_openbsd sys_getexepath_openbsd \
    swprintf_hack_openbsd
endif

ifeq ($(TARGET_OS),xbox)
  LIBFB_H += rtlib/fb_xbox.h
  LIBFB_C += \
    dev_pipe_close_xbox dev_pipe_open_xbox \
    drv_file_copy_xbox drv_intl_get_xbox drv_intl_getdateformat_xbox \
    drv_intl_getmonthname_xbox drv_intl_gettimeformat_xbox \
    drv_intl_getweekdayname_xbox \
    file_dir_xbox file_hconvpath_xbox file_hlock_xbox \
    hexit_xbox \
    hinit_xbox \
    io_cls_xbox io_color_xbox io_getsize_xbox io_inkey_xbox io_isredir_xbox \
    io_locate_xbox io_maxrow_xbox io_mouse_xbox io_multikey_xbox \
    io_pageset_xbox io_pcopy_xbox io_printbuff_xbox io_printbuff_wstr_xbox \
    io_printer_xbox io_readstr_xbox io_scroll_xbox io_serial_xbox \
    io_viewupdate_xbox io_width_xbox \
    sys_dylib_xbox sys_exec_xbox sys_fmem_xbox sys_getcwd_xbox \
    sys_getexename_xbox sys_getexepath_xbox sys_getshortpath_xbox \
    sys_shell_xbox sys_sleep_xbox \
    thread_cond_xbox thread_core_xbox thread_mutex_xbox \
    time_setdate_xbox time_settime_xbox time_sleep_xbox time_tmr_xbox
  LIBFB_S += alloca
endif

ifneq ($(filter darwin freebsd linux netbsd openbsd solaris,$(TARGET_OS)),)
  LIBFB_H += rtlib/fb_unix.h
  LIBFB_C += \
    dev_pipe_close_unix dev_pipe_open_unix \
    drv_file_copy_unix drv_intl_get_unix drv_intl_getdateformat_unix \
    drv_intl_getmonthname_unix drv_intl_gettimeformat_unix \
    drv_intl_getweekdayname_unix \
    file_dir_unix file_hconvpath_unix file_hlock_unix file_resetex_unix \
    hdynload_unix \
    hexit_unix \
    hinit_unix \
    hsignals_unix \
    io_cls_unix io_color_unix io_getsize_unix io_inkey_unix io_isredir_unix \
    io_locate_unix io_maxrow_unix io_pageset_unix io_pcopy_unix \
    io_printbuff_unix io_printbuff_wstr_unix io_printer_unix io_readstr_unix \
    io_scroll_unix io_viewupdate_unix io_width_unix io_xfocus_unix \
    scancodes_unix \
    sys_delay_unix sys_dylib_unix sys_exec_unix sys_getcwd_unix \
    sys_getshortpath_unix sys_shell_unix \
    thread_cond_unix thread_core_unix thread_mutex_unix \
    time_setdate_unix time_settime_unix time_sleep_unix time_tmr_unix
endif

ifneq ($(filter cygwin win32,$(TARGET_OS)),)
  LIBFB_H += rtlib/fb_unicode_win32.h
  LIBFB_H += rtlib/fb_win32.h
  LIBFB_H += rtlib/fbportio/fbportio.h
  LIBFB_H += rtlib/fbportio/inline.h
  LIBFB_C += \
    dev_pipe_close_win32 dev_pipe_open_win32 \
    drv_file_copy_win32 drv_intl_get_win32 drv_intl_getdateformat_win32 \
    drv_intl_getmonthname_win32 drv_intl_gettimeformat_win32 \
    drv_intl_getweekdayname_win32 \
    file_dir_win32 file_hconvpath_win32 file_hlock_win32 file_resetex_win32 \
    hdynload_win32 \
    hexit_win32 \
    hinit_win32 \
    hsignals_win32 \
    intl_conv_win32 intl_win32 \
    io_cls_win32 io_clsex_win32 io_color_win32 io_colorget_win32 \
    io_gethnd_win32 io_getsize_win32 io_getwindow_win32 io_getwindowex_win32 \
    io_getx_win32 io_getxy_win32 io_gety_win32 io_inkey_win32 io_input_win32 \
    io_isredir_win32 io_locate_win32 io_locateex_win32 io_maxrow_win32 \
    io_mouse_win32 io_multikey_win32 io_pageset_win32 io_pcopy_win32 \
    io_printbuff_win32 io_printbuff_wstr_win32 io_printer_win32 \
    io_readstr_win32 io_readxy_win32 io_screensize_win32 io_scroll_win32 \
    io_scrollex_win32 io_serial_win32 io_viewupdate_win32 io_width_win32 \
    io_window_win32 \
    sys_dylib_win32 sys_exec_win32 sys_fmem_win32 sys_getcwd_win32 \
    sys_getexename_win32 sys_getexepath_win32 sys_getshortpath_win32 \
    sys_ports_win32 sys_shell_win32 sys_sleep_win32 \
    thread_cond_win32 thread_core_win32 thread_mutex_win32 \
    time_setdate_win32 time_settime_win32 time_sleep_win32 time_tmr_win32
  LIBFB_S += alloca
endif

ifneq ($(filter 386 486 586 686,$(TARGET_ARCH)),)
  LIBFB_H += rtlib/fb_x86.h
  LIBFB_S += cpudetect_x86
endif

LIBFB_C := $(patsubst %,$(newlibfb)/%.o,$(LIBFB_C))
LIBFB_S := $(patsubst %,$(newlibfb)/%.o,$(LIBFB_S))

ifndef DISABLE_MT
  LIBFBMT_C := $(patsubst $(newlibfb)/%,$(newlibfbmt)/%,$(LIBFB_C))
  LIBFBMT_S := $(patsubst $(newlibfb)/%,$(newlibfbmt)/%,$(LIBFB_S))
endif

ifndef DISABLE_GFX
  LIBFBGFX_H := $(LIBFB_H)
  LIBFBGFX_H += gfxlib2/fb_gfx_data.h
  LIBFBGFX_H += gfxlib2/fb_gfx_gl.h
  LIBFBGFX_H += gfxlib2/fb_gfx.h
  LIBFBGFX_H += gfxlib2/fb_gfx_lzw.h
  LIBFBGFX_H += gfxlib2/gfxdata/inline.h

  LIBFBGFX_C += \
    access blitter bload box bsave circle cls color control core data draw \
    drawstring driver_null event get getmouse image image_convert image_info \
    inkey line lineinp lineinp_wstr lzw lzw_enc multikey page paint palette \
    paletteget pmap point print print_wstr pset put_add put_alpha put_and \
    put_blend put put_custom put_or put_preset put_pset put_trans put_xor \
    readstr readxy screen screeninfo screenlist setmouse sleep softcursor \
    stick vars vgaemu view vsync width window

  ifndef DISABLE_OPENGL
    LIBFBGFX_C += opengl
  endif

  LIBFBGFX_S :=

  ifeq ($(TARGET_OS),dos)
    LIBFBGFX_H += gfxlib2/fb_gfx_dos.h
    LIBFBGFX_H += gfxlib2/vesa.h
    LIBFBGFX_H += gfxlib2/vga.h
    LIBFBGFX_C += \
      dos driver_bios_dos driver_modex_dos driver_vesa_bnk_dos \
      driver_vesa_lin_dos driver_vga_dos joystick_dos vesa_core_dos
    LIBFBGFX_S += mouse_dos vesa_dos
  endif

  ifeq ($(TARGET_OS),freebsd)
    LIBFBGFX_C += freebsd joystick_freebsd
  endif

  ifeq ($(TARGET_OS),linux)
    LIBFBGFX_H += gfxlib2/fb_gfx_linux.h
    LIBFBGFX_C += driver_fbdev_linux joystick_linux linux
  endif

  ifeq ($(TARGET_OS),openbsd)
    LIBFBGFX_C += joystick_openbsd openbsd
  endif

  ifeq ($(TARGET_OS),xbox)
    LIBFBGFX_C += driver_xbox
  endif

  ifneq ($(filter darwin freebsd linux netbsd openbsd solaris,$(TARGET_OS)),)
    ifndef DISABLE_X
      LIBFBGFX_H += gfxlib2/fb_gfx_x11.h
      LIBFBGFX_C += driver_x11 x11 x11_icon_stub
      ifndef DISABLE_OPENGL
        LIBFBGFX_C += driver_opengl_x11
      endif
    endif
  endif

  ifneq ($(filter cygwin win32,$(TARGET_OS)),)
    LIBFBGFX_H += gfxlib2/fb_gfx_win32.h
    LIBFBGFX_C += driver_ddraw_win32 driver_gdi_win32 joystick_win32 win32
    ifndef DISABLE_OPENGL
      LIBFBGFX_C += driver_opengl_win32
    endif
  endif

  ifneq ($(filter 386 486 586 686,$(TARGET_ARCH)),)
    LIBFBGFX_H += gfxlib2/fb_gfx_mmx.h
    LIBFBGFX_S += \
      blitter_mmx mmx put_add_mmx put_alpha_mmx put_and_mmx put_blend_mmx \
      put_or_mmx put_preset_mmx put_pset_mmx put_trans_mmx put_xor_mmx
  endif
endif

LIBFBGFX_C := $(patsubst %,$(newlibfbgfx)/%.o,$(LIBFBGFX_C))
LIBFBGFX_S := $(patsubst %,$(newlibfbgfx)/%.o,$(LIBFBGFX_S))

#
# Build rules
#

# We don't want to use any of make's built-in suffixes/rules
.SUFFIXES:

ifndef V
  QUIET       = @
  QUIET_CP    = @echo "CP $@";
  QUIET_GEN   = @echo "GEN $@";
  QUIET_FBC   = @echo "FBC $@";
  QUIET_LINK  = @echo "LINK $@";
  QUIET_CC    = @echo "CC $@";
  QUIET_CPPAS = @echo "CPPAS $@";
  QUIET_AR    = @echo "AR $@";
endif

config-define = $(QUIET)echo '\#define $(1)' >> $@
config-ifdef = $(if $(1),$(call config-define,$(2)))
config-filter = $(call config-ifdef,$(filter $(2),$(1)),$(3))

.PHONY: all
all: compiler rtlib gfxlib2

$(new) $(newcompiler) $(newbin) $(newlibfb) $(newlibfbmt) $(newlibfbgfx) \
$(new)/include $(newinclude) $(new)/lib $(newlib) \
$(prefix) $(prefixbin) \
$(prefix)/include $(prefixinclude) $(prefix)/lib $(prefixlib):
	mkdir $@

.PHONY: compiler
compiler: $(new) $(newcompiler) $(newbin) $(new)/lib $(newlib)
compiler: $(newbin)/$(FBC_EXE)
ifdef FB_LDSCRIPT
compiler: $(newlib)/$(FB_LDSCRIPT)
endif

$(newlib)/fbextra.x: compiler/fbextra.x
	$(QUIET_CP)cp $< $@

$(newlib)/i386go32.x: contrib/djgpp/i386go32.x
	$(QUIET_CP)cp $< $@

$(newbin)/$(FBC_EXE): $(FBC_BAS) $(FBC_BFDWRAPPER)
	$(QUIET_LINK)$(HOST_FBC) $(FBLFLAGS) -x $@ $^

$(FBC_BAS): $(newcompiler)/%.o: compiler/%.bas $(FBC_BI)
	$(QUIET_FBC)$(HOST_FBC) $(FBCFLAGS) -c $< -o $@

$(newcompiler)/c-objinfo.o: compiler/c-objinfo.c
	$(QUIET_CC)$(HOST_CC) -Wfatal-errors -Wall -c $< -o $@

$(newcompiler)/config.bi: compiler/config.bi.in
	$(QUIET_GEN)cp $< $@
	$(call config-filter,$(TARGET_OS),cygwin,TARGET_CYGWIN)
	$(call config-filter,$(TARGET_OS),darwin,TARGET_DARWIN)
	$(call config-filter,$(TARGET_OS),dos,TARGET_DOS)
	$(call config-filter,$(TARGET_OS),freebsd,TARGET_FREEBSD)
	$(call config-filter,$(TARGET_OS),linux,TARGET_LINUX)
	$(call config-filter,$(TARGET_OS),netbsd,TARGET_NETBSD)
	$(call config-filter,$(TARGET_OS),openbsd,TARGET_OPENBSD)
	$(call config-filter,$(TARGET_OS),win32,TARGET_WIN32)
	$(call config-filter,$(TARGET_OS),xbox,TARGET_XBOX)
	$(call config-filter,$(TARGET_ARCH),386 486 586 686,TARGET_X86)
	$(call config-filter,$(TARGET_ARCH),x86_64,TARGET_X86_64)
	$(call config-ifdef,$(ENABLE_FBBFD),ENABLE_FBBFD $(ENABLE_FBBFD))
	$(call config-ifdef,$(DISABLE_OBJINFO),DISABLE_OBJINFO)
	$(call config-ifdef,$(ENABLE_PREFIX),ENABLE_PREFIX "$(prefix)")
	$(call config-ifdef,$(ENABLE_STANDALONE),ENABLE_STANDALONE)
	$(call config-define,FB_SUFFIX "$(SUFFIX)")

.PHONY: rtlib
rtlib: $(new) $(newlibfb) $(new)/include $(newinclude) $(new)/lib $(newlib)
rtlib: $(NEW_FB_INCLUDES)
rtlib: $(newlib)/fbrt0.o
rtlib: $(newlib)/libfb.a
ifndef DISABLE_MT
rtlib: $(newlibfbmt) $(newlib)/libfbmt.a
endif

# Copy the headers into new/ too; that's only done to allow the new compiler
# to be tested from the build directory.
$(NEW_FB_INCLUDES): $(newinclude)/%.bi: rtlib/%.bi
	$(QUIET_CP)cp $< $@

$(newlib)/fbrt0.o: rtlib/fbrt0.c $(LIBFB_H)
	$(QUIET_CC)$(TARGET_CC) $(ALLCFLAGS) -c $< -o $@

$(newlib)/libfb.a: $(LIBFB_C) $(LIBFB_S)
	$(QUIET_AR)$(TARGET_AR) rcs $@ $^

$(LIBFB_C): $(newlibfb)/%.o: rtlib/%.c $(LIBFB_H)
	$(QUIET_CC)$(TARGET_CC) $(ALLCFLAGS) -c $< -o $@

$(LIBFB_S): $(newlibfb)/%.o: rtlib/%.s $(LIBFB_H)
	$(QUIET_CPPAS)$(TARGET_CC) -x assembler-with-cpp $(ALLCFLAGS) -c $< -o $@

$(newlib)/libfbmt.a: $(LIBFBMT_C) $(LIBFBMT_S)
	$(QUIET_AR)$(TARGET_AR) rcs $@ $^

$(LIBFBMT_C): $(newlibfbmt)/%.o: rtlib/%.c $(LIBFB_H)
	$(QUIET_CC)$(TARGET_CC) -DENABLE_MT $(ALLCFLAGS) -c $< -o $@

$(LIBFBMT_S): $(newlibfbmt)/%.o: rtlib/%.s $(LIBFB_H)
	$(QUIET_CPPAS)$(TARGET_CC) -x assembler-with-cpp -DENABLE_MT $(ALLCFLAGS) -c $< -o $@

.PHONY: gfxlib2
gfxlib2:
ifndef DISABLE_GFX
gfxlib2: $(new) $(newlibfb) $(new)/include $(newinclude) $(new)/lib $(newlib)
gfxlib2: $(newinclude)/fbgfx.bi
gfxlib2: $(newlibfbgfx) $(newlib)/libfbgfx.a
endif

$(newinclude)/fbgfx.bi: gfxlib2/fbgfx.bi
	$(QUIET_CP)cp $< $@

$(newlib)/libfbgfx.a: $(LIBFBGFX_C) $(LIBFBGFX_S)
	$(QUIET_AR)$(TARGET_AR) rcs $@ $^

$(LIBFBGFX_C): $(newlibfbgfx)/%.o: gfxlib2/%.c $(LIBFBGFX_H)
	$(QUIET_CC)$(TARGET_CC) $(ALLCFLAGS) -c $< -o $@

$(LIBFBGFX_S): $(newlibfbgfx)/%.o: gfxlib2/%.s $(LIBFBGFX_H)
	$(QUIET_CPPAS)$(TARGET_CC) -x assembler-with-cpp $(ALLCFLAGS) -c $< -o $@

$(newlibfb)/config.h: rtlib/config.h.in
	$(QUIET_GEN)cp $< $@
	$(call config-filter,$(TARGET_OS),cygwin,HOST_CYGWIN)
	$(call config-filter,$(TARGET_OS),darwin,HOST_DARWIN)
	$(call config-filter,$(TARGET_OS),dos,HOST_DOS)
	$(call config-filter,$(TARGET_OS),freebsd,HOST_FREEBSD)
	$(call config-filter,$(TARGET_OS),linux,HOST_LINUX)
	$(call config-filter,$(TARGET_OS),netbsd,HOST_NETBSD)
	$(call config-filter,$(TARGET_OS),openbsd,HOST_OPENBSD)
	$(call config-filter,$(TARGET_OS),win32,HOST_MINGW)
	$(call config-filter,$(TARGET_OS),solaris,HOST_SOLARIS)
	$(call config-filter,$(TARGET_OS),xbox,HOST_XBOX)
	$(call config-filter,$(TARGET_OS),darwin freebsd linux netbsd openbsd solaris,HOST_UNIX)
	$(call config-filter,$(TARGET_OS),cygwin win32,HOST_WIN32)
	$(call config-filter,$(TARGET_ARCH),386 486 586 686,HOST_X86)
	$(call config-filter,$(TARGET_ARCH),x86_64,HOST_X86_64)
	$(call config-filter,$(TARGET_ARCH),sparc,HOST_SPARC)
	$(call config-filter,$(TARGET_ARCH),sparc64,HOST_SPARC64)
	$(call config-filter,$(TARGET_ARCH),powerpc64,HOST_POWERPC64)
	$(call config-ifdef,$(DISABLE_OPENGL),DISABLE_OPENGL)
	$(call config-ifdef,$(DISABLE_X),DISABLE_X)

.PHONY: install
install: install-compiler install-rtlib install-gfxlib2

.PHONY: install-compiler
install-compiler: $(prefixbin) $(prefixlib)
	$(INSTALL_PROGRAM) $(newbin)/$(FBC_EXE) $(prefixbin)/
  ifdef FB_LDSCRIPT
	$(INSTALL_FILE) $(newlib)/$(FB_LDSCRIPT) $(prefixlib)/
  endif

.PHONY: install-rtlib
install-rtlib: $(prefixinclude) $(prefixlib)
	$(INSTALL_FILE) $(NEW_FB_INCLUDES) $(prefixinclude)/
	$(INSTALL_FILE) $(newlib)/fbrt0.o $(newlib)/libfb.a $(prefixlib)/
  ifndef DISABLE_MT
	$(INSTALL_FILE) $(newlib)/libfbmt.a $(prefixlib)/
  endif

.PHONY: install-gfxlib2
install-gfxlib2: $(prefixinclude) $(prefixlib)
  ifndef DISABLE_GFX
	$(INSTALL_FILE) $(newinclude)/fbgfx.bi $(prefixinclude)/
	$(INSTALL_FILE) $(newlib)/libfbgfx.a $(prefixlib)/
  endif

.PHONY: uninstall uninstall-compiler uninstall-rtlib uninstall-gfxlib2
uninstall: uninstall-compiler uninstall-rtlib uninstall-gfxlib2
  # The non-standalone build uses freebasic subdirs, e.g. /usr/lib/freebasic,
  # that we should remove if empty.
  ifndef ENABLE_STANDALONE
	-rmdir $(prefixinclude)
	-rmdir $(prefixlib)
  endif

uninstall-compiler:
	rm -f $(prefixbin)/$(FBC_EXE)
  ifdef FB_LDSCRIPT
	rm -f $(prefixlib)/$(FB_LDSCRIPT)
  endif

uninstall-rtlib:
	rm -f $(patsubst $(newinclude)/%,$(prefixinclude)/%,$(NEW_FB_INCLUDES))
	rm -f $(prefixlib)/fbrt0.o $(prefixlib)/libfb.a
  ifndef DISABLE_MT
	rm -f $(prefixlib)/libfbmt.a
  endif

uninstall-gfxlib2:
  ifndef DISABLE_GFX
	rm -f $(prefixinclude)/fbgfx.bi $(prefixlib)/libfbgfx.a
  endif

.PHONY: clean clean-compiler clean-rtlib clean-gfxlib2
clean: clean-compiler clean-rtlib clean-gfxlib2
	-rmdir $(newbin)
	-rmdir $(newinclude)
  ifndef ENABLE_STANDALONE
	-rmdir $(new)/include
  endif
	-rmdir $(newlib)
  ifndef ENABLE_STANDALONE
	-rmdir $(new)/lib
  endif
	-rmdir $(new)

clean-compiler:
	rm -f $(newcompiler)/config.bi $(newbin)/$(FBC_EXE) $(newcompiler)/*.o
  ifdef FB_LDSCRIPT
	rm -f $(newlib)/$(FB_LDSCRIPT)
  endif
	-rmdir $(newcompiler)

clean-rtlib:
	rm -f $(NEW_FB_INCLUDES) $(newlib)/fbrt0.o $(newlibfb)/config.h $(newlib)/libfb.a $(newlibfb)/*.o
	-rmdir $(newlibfb)
  ifndef DISABLE_MT
	rm -f $(newlib)/libfbmt.a $(newlibfbmt)/*.o
	-rmdir $(newlibfbmt)
  endif

clean-gfxlib2:
  ifndef DISABLE_GFX
	rm -f $(newinclude)/fbgfx.bi $(newlib)/libfbgfx.a $(newlibfbgfx)/*.o
	-rmdir $(newlibfbgfx)
  endif

.PHONY: help
help:
	@echo "Available commands:"
	@echo "  <none>|all                 to build compiler and libraries."
	@echo "  compiler|rtlib|gfxlib2     (specific component only)"
	@echo "  clean[-<component>]        to remove built files."
	@echo "  install[-<component>]      to install into prefix."
	@echo "  uninstall[-<component>]    to remove from prefix."
	@echo "Variables:"
	@echo "  FBFLAGS, CFLAGS  Use these to disable optimizations or add debugging options"
	@echo "  new     The build directory ('new'); change this to differentiate multiple"
	@echo "          builds in one source tree."
	@echo "  prefix  The install directory ('.' on Windows/DOS; '/usr/local' elsewhere)"
	@echo "  HOST    A system triplet to cross-compile an fbc that will run on HOST."
	@echo "  TARGET  A system triplet to build a cross-fbc that produces for TARGET,"
	@echo "          and to cross-compile the runtime to run on TARGET."
	@echo "  SUFFIX  A string to append to the fbc program name and the lib/freebasic/"
	@echo "          directory, distinguishing this build from other installed versions."
	@echo "  SUFFIX2 A second string to append to the fbc program name. This one is not"
	@echo "          added to the freebasic/ sub-directories, allowing to install multiple"
	@echo "          fbcs that use the same runtime."
	@echo "  FBC     The 'fbc', 'gcc', 'ar' tools to use. Note: When cross-compiling,"
	@echo "  CC      these cannot contain paths, because the host/target triplets will"
	@echo "  AR      be prepended. However, you can always set those variables directly:"
	@echo "          HOST_FBC, HOST_CC, TARGET_AR, TARGET_CC"
	@echo "  V       For verbose command lines"
	@echo "FreeBASIC configuration options:"
	@echo "  ENABLE_STANDALONE Use a simpler directory layout that places fbc into the"
	@echo "                    toplevel directory, and always use the custom ldscripts."
	@echo "                    (intended for self-contained installations)"
	@echo "  ENABLE_PREFIX     Hard-code the prefix into the compiler, instead of"
	@echo "                    building a relocatable compiler."
	@echo "  ENABLE_FBBFD=217  Use the FB headers for this exact libbfd version,"
	@echo "                    instead of using the system's bfd.h via a C wrapper."
	@echo "  DISABLE_OBJINFO   Leave out fbc's objinfo feature and don't use libbfd at all"
	@echo "  DISABLE_MT        Don't build libfbmt (auto-defined for DOS runtime)"
	@echo "  DISABLE_GFX       Don't build libfbgfx (useful when cross-compiling,"
	@echo "                    or when the target system isn't yet supported by libfbgfx)"
	@echo "  DISABLE_OPENGL    Don't use OpenGL in libfbgfx (Unix/Windows versions)"
	@echo "  DISABLE_X         Don't use X in libfbgfx (Unix version)"
	@echo "This makefile #includes config.mk and new/config.mk, allowing you to use them"
	@echo "to set variables in a more permanent and even build-directory specific way."
