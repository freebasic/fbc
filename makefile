#!/usr/bin/make -f
#
# This is the main makefile that builds the compiler (fbc) and the runtime
# libraries (rtlib -> libfb[mt] and fbrt0.o, gfxlib2 -> libfbgfx).
# Try 'make help' for information on what you can configure.
#
# Rough overview of what this makefile does:
#  - #include config.mk
#  - Guess build system using uname
#  - Parse TARGET variable if needed
#  - Figure out the dir layout
#  - Set compilers and flags
#  - Select compiler/rtlib/gfxlib2 sources
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
# backslashes), not to mention the FB test suite or building other projects
# we need (e.g. binutils), which requires a Unixy shell anyways.
#

FBC := fbc
CFLAGS := -Wfatal-errors -O2
FBFLAGS := -maxerr 1

AR = $(TARGET_PREFIX)ar
CC = $(TARGET_PREFIX)gcc

-include config.mk

# The default build directory
ifndef new
  override new := new
endif

-include $(new)/config.mk

#
# Build system determination (guessed via uname unless given)
# This is almost only needed to set the default values for TARGET_OS and
# TARGET_ARCH, but as long as we have other things using BUILD_OS, this separate
# set of variables must exist.
#

uname := $(shell uname)
ifneq ($(findstring CYGWIN,$(uname)),)
  BUILD_OS := cygwin
endif
ifeq ($(uname),Darwin)
  BUILD_OS := darwin
endif
ifeq ($(uname),FreeBSD)
  BUILD_OS := freebsd
endif
ifeq ($(uname),Linux)
  BUILD_OS := linux
endif
ifneq ($(findstring MINGW,$(uname)),)
  BUILD_OS := win32
endif
ifeq ($(uname),MS-DOS)
  BUILD_OS := dos
endif
ifeq ($(uname),NetBSD)
  BUILD_OS := netbsd
endif
ifeq ($(uname),OpenBSD)
  BUILD_OS := openbsd
endif
ifndef BUILD_OS
  $(error Sorry, the OS could not be identified automatically. \
          Maybe this makefile should be fixed. 'uname' returned: '$(uname)')
endif

# Try to guess the BUILD_ARCH based on 'uname -m'
ifeq ($(BUILD_OS),dos)
  # For the DJGPP build however, just use i386, and don't bother calling
  # 'uname -m', which only returns 'pc' anyways.
  uname_m := i386
else
  uname_m := $(shell uname -m)
endif
ifeq ($(uname_m),i386)
  BUILD_ARCH = 386
endif
ifeq ($(uname_m),i486)
  BUILD_ARCH = 486
endif
ifeq ($(uname_m),i586)
  BUILD_ARCH = 586
endif
ifeq ($(uname_m),i686)
  BUILD_ARCH = 686
endif
ifeq ($(uname_m),x86_64)
  BUILD_ARCH = x86_64
endif
ifeq ($(uname_m),sparc)
  BUILD_ARCH = sparc
endif
ifeq ($(uname_m),sparc64)
  BUILD_ARCH = sparc64
endif
ifeq ($(uname_m),powerpc64)
  BUILD_ARCH = powerpc64
endif
ifndef BUILD_ARCH
  $(error Sorry, the CPU architecture could not be identified automatically. \
          Maybe this makefile should be fixed. \
          'uname -m' returned: '$(uname_m)')
endif

#
# Target system determination
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
    ifneq ($(filter msdos%,$(triplet_os)),)
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
    $(error Sorry, the OS part of TARGET='$(TARGET)' could not be identified. \
            Maybe this makefile should be fixed.)
  endif

  ifndef TARGET_ARCH
    $(error Sorry, the CPU part of TARGET='$(TARGET)' could not be identified. \
            Maybe this makefile should be fixed.)
  endif
else
  # No TARGET given, so default to the native system
  ifndef TARGET_OS
    TARGET_OS := $(BUILD_OS)
  endif
  ifndef TARGET_ARCH
    TARGET_ARCH := $(BUILD_ARCH)
  endif
endif

#
# Directory layout setup
#

ifndef prefix
  override prefix := /usr/local
endif

ifdef ENABLE_STANDALONE
  override newbin     := $(new)
  override newinclude := $(new)/include
  override newlib     := $(new)/$(TARGET_PREFIX)lib$(SUFFIX)
  override prefixbin     := $(prefix)
  override prefixinclude := $(prefix)/include
  override prefixlib     := $(prefix)/$(TARGET_PREFIX)lib$(SUFFIX)
else
  ifeq ($(TARGET_OS),dos)
    FB_NAME := freebas
  else
    FB_NAME := freebasic
  endif
  override newbin     := $(new)/bin
  override newinclude := $(new)/include/$(FB_NAME)
  override newlib     := $(new)/lib/$(TARGET_PREFIX)$(FB_NAME)$(SUFFIX)
  override prefixbin     := $(prefix)/bin
  override prefixinclude := $(prefix)/include/$(FB_NAME)
  override prefixlib     := $(prefix)/lib/$(TARGET_PREFIX)$(FB_NAME)$(SUFFIX)
endif

ifneq ($(filter cygwin dos win32,$(TARGET_OS)),)
  EXEEXT := .exe
endif
FBC_EXE := fbc$(SUFFIX)$(SUFFIX2)$(EXEEXT)

override newcompiler := $(new)/compiler
override newlibfb    := $(new)/libfb
override newlibfbmt  := $(new)/libfbmt
override newlibfbgfx := $(new)/libfbgfx

ifeq ($(TARGET_OS),dos)
  # For DOS the ldscript is always needed, to fix the c/dtors otder
  override FB_LDSCRIPT := i386go32.x
  # Don't build libfbmt for DOS, and also no OpenGL support in libfbgfx
  DISABLE_MT := YesPlease
  DISABLE_OPENGL := YesPlease
else
  ifndef DISABLE_OBJINFO
    # The extra ldscript snippet for dropping .fbctinf
    override FB_LDSCRIPT := fbextra.x
  endif
endif

#
# Compilers and flags
#

ifneq ($(filter cygwin dos win32,$(BUILD_OS)),)
  INSTALL_PROGRAM := cp
  INSTALL_FILE := cp
else
  # For copying fbc and the includes/libraries into $(prefix),
  # should be better than plain cp at replacing fbc while fbc is running.
  INSTALL_PROGRAM := install
  INSTALL_FILE := install -m 644
endif

ALLFBCFLAGS := -e -m fbc -w pedantic
ALLFBLFLAGS := -e -m fbc -w pedantic
ALLCFLAGS := -Wall

# If cross-compiling, use -target
ifdef TARGET
  ALLFBCFLAGS += -target $(TARGET)
  ALLFBLFLAGS += -target $(TARGET)
endif

ifneq ($(filter cygwin win32,$(TARGET_OS)),)
  # Increase compiler's available stack size, it uses lots of recursion
  ALLFBLFLAGS += -t 2048
endif

# Pass the configuration defines on to the compiler source code
ifdef ENABLE_FBBFD
  ALLFBCFLAGS += -d ENABLE_FBBFD=$(ENABLE_FBBFD)
endif
ifdef DISABLE_OBJINFO
  ALLFBCFLAGS += -d DISABLE_OBJINFO
endif
ifdef ENABLE_PREFIX
  ALLFBCFLAGS += -d 'ENABLE_PREFIX="$(prefix)"'
endif
ifdef ENABLE_STANDALONE
  ALLFBCFLAGS += -d ENABLE_STANDALONE
endif
ifdef SUFFIX
  ALLFBCFLAGS += -d 'ENABLE_SUFFIX="$(SUFFIX)"'
endif
ifdef ENABLE_TDMGCC
  ALLFBCFLAGS += -d ENABLE_TDMGCC
endif

# Same for rtlib/gfxlib2
ifdef DISABLE_OPENGL
  ALLCFLAGS += -DDISABLE_OPENGL
endif
ifdef DISABLE_X
  ALLCFLAGS += -DDISABLE_X
endif

ifdef FBCFLAGS
  ALLFBCFLAGS += $(FBCFLAGS)
endif

ifdef FBLFLAGS
  ALLFBLFLAGS += $(FBLFLAGS)
endif

ifdef FBFLAGS
  ALLFBCFLAGS += $(FBFLAGS)
  ALLFBLFLAGS += $(FBFLAGS)
endif

ifdef CFLAGS
  ALLCFLAGS += $(CFLAGS)
endif

#
# Compiler sources
#

FBC_BI := compiler/ast.bi
FBC_BI += compiler/ast-op.bi
FBC_BI += compiler/bfd-wrapper.bi
FBC_BI += compiler/common.bi
FBC_BI += compiler/dstr.bi
FBC_BI += compiler/emit.bi
FBC_BI += compiler/emitdbg.bi
FBC_BI += compiler/error.bi
FBC_BI += compiler/fb.bi
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
  ast-node-decl ast-node-field ast-node-idx ast-node-iif \
  ast-node-link ast-node-load ast-node-mem ast-node-misc \
  ast-node-proc ast-node-ptr ast-node-scope ast-node-stack ast-node-typeini \
  ast-node-uop ast-node-var ast-optimize ast-vectorize \
  dstr edbg_stab emit emit_SSE emit_x86 error fb fb-main \
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
  parser-quirk-thread parser-quirk-vafirst parser-statement parser-toplevel \
  pool pp pp-cond pp-define pp-pragma reg \
  rtl rtl-array rtl-console rtl-data rtl-error rtl-file rtl-gfx rtl-gosub \
  rtl-macro rtl-math rtl-mem rtl-oop rtl-print rtl-profile rtl-string \
  rtl-system rtl-system-thread \
  stack symb symb-bitfield symb-comp symb-const symb-data symb-define \
  symb-enum symb-keyword symb-label symb-mangling symb-namespace \
  symb-proc symb-scope symb-struct symb-typedef symb-var

FBC_BFDWRAPPER :=
ifndef DISABLE_OBJINFO
  FBC_BAS += fb-objinfo
  ifndef ENABLE_FBBFD
    FBC_BFDWRAPPER := $(newcompiler)/bfd-wrapper.o
  endif

  ALLFBLFLAGS += -l bfd -l iberty
  ifeq ($(TARGET_OS),cygwin)
    ALLFBLFLAGS += -l intl
  endif
  ifeq ($(TARGET_OS),dos)
    ALLFBLFLAGS += -l intl -l z
  endif
  ifeq ($(TARGET_OS),freebsd)
    ALLFBLFLAGS += -l intl
  endif
  ifeq ($(TARGET_OS),openbsd)
    ALLFBLFLAGS += -l intl
  endif
  ifeq ($(TARGET_OS),win32)
    ALLFBLFLAGS += -l intl -l user32
  endif
endif

FBC_BAS := $(patsubst %,$(newcompiler)/%.o,$(FBC_BAS))

#
# Header files
# (Any listed directory will be run through $(wildcard x/*.bi) as a shortcut)
#

ifneq ($(TARGET_OS),dos)
  headers += include/AL/
endif
  headers += include/allegro.bi
  headers += include/allegro/
  headers += include/allegro/inline/
  headers += include/allegro/internal/
  headers += include/allegro/platform/
  headers += include/aspell.bi
ifneq ($(TARGET_OS),dos)
  headers += include/atk/
  headers += include/bass.bi
  headers += include/bassmod.bi
endif
  headers += include/bfd.bi
  headers += include/bfd/
  headers += include/big_int/
  headers += include/bzlib.bi
  headers += include/caca.bi
ifneq ($(TARGET_OS),dos)
  headers += include/cairo/
endif
  headers += include/cgui.bi
  headers += include/chipmunk/
  headers += include/chipmunk/constraints/
  headers += include/crt.bi
  headers += include/crt/arpa/
  headers += include/crt/bits/
  headers += include/crt/ctype.bi
  headers += include/crt/dir.bi
ifeq ($(TARGET_OS),dos)
  headers += include/crt/dos/
endif
  headers += include/crt/errno.bi
  headers += include/crt/fcntl.bi
  headers += include/crt/io.bi
  headers += include/crt/limits.bi
ifneq ($(filter darwin freebsd linux netbsd openbsd solaris,$(TARGET_OS)),)
  headers += include/crt/linux/
endif
  headers += include/crt/locale.bi
  headers += include/crt/malloc.bi
  headers += include/crt/math.bi
ifneq ($(filter darwin freebsd linux netbsd openbsd solaris,$(TARGET_OS)),)
  headers += include/crt/netdb.bi
  headers += include/crt/netinet/in.bi
  headers += include/crt/netinet/linux/in.bi
endif
  headers += include/crt/process.bi
  headers += include/crt/setjmp.bi
  headers += include/crt/stdarg.bi
  headers += include/crt/stddef.bi
  headers += include/crt/stdint.bi
  headers += include/crt/stdio.bi
  headers += include/crt/stdlib.bi
  headers += include/crt/string.bi
ifeq ($(TARGET_OS),dos)
  headers += include/crt/sys/dos/
endif
ifneq ($(filter darwin freebsd linux netbsd openbsd solaris,$(TARGET_OS)),)
  headers += include/crt/sys/linux/
endif
  headers += include/crt/sys/select.bi
ifneq ($(TARGET_OS),dos)
  headers += include/crt/sys/socket.bi
endif
  headers += include/crt/sys/stat.bi
  headers += include/crt/sys/time.bi
  headers += include/crt/sys/types.bi
  headers += include/crt/sys/uio.bi
ifneq ($(filter cygwin win32,$(TARGET_OS)),)
  headers += include/crt/sys/win32/
endif
  headers += include/crt/time.bi
  headers += include/crt/unistd.bi
  headers += include/crt/wchar.bi
ifneq ($(filter cygwin win32,$(TARGET_OS)),)
  headers += include/crt/win32/
endif
  headers += include/cryptlib.bi
  headers += include/CUnit/
  headers += include/curl.bi
  headers += include/curses.bi
ifneq ($(filter darwin freebsd linux netbsd openbsd solaris,$(TARGET_OS)),)
  headers += include/curses/ncurses.bi
endif
ifneq ($(filter dos cygwin win32,$(TARGET_OS)),)
  headers += include/curses/pdcurses.bi
endif
  headers += include/datetime.bi
  headers += include/dir.bi
  headers += include/dislin.bi
ifneq ($(filter cygwin win32,$(TARGET_OS)),)
  headers += include/disphelper/
endif
ifeq ($(TARGET_OS),dos)
  headers += include/dos/
  headers += include/dos/inlines/
  headers += include/dos/sys/
endif
ifneq ($(TARGET_OS),dos)
  headers += include/expat.bi
  headers += include/fastcgi/
endif
  headers += include/fbgfx.bi
ifneq ($(TARGET_OS),dos)
  headers += include/ffi.bi
endif
  headers += include/file.bi
ifneq ($(TARGET_OS),dos)
  headers += include/flite/
  headers += include/fmod.bi
  headers += include/FreeImage.bi
  headers += include/freetype2/
  headers += include/freetype2/config/
  headers += include/gd/
endif
  headers += include/gdbm.bi
ifneq ($(TARGET_OS),dos)
  headers += include/gdk-pixbuf/
  headers += include/gdk/
endif
  headers += include/gdsl/
  headers += include/gettext-po.bi
  headers += include/gif_lib.bi
ifneq ($(TARGET_OS),dos)
  headers += include/gio/
  headers += include/GL/
  headers += include/glade/
  headers += include/glib-object.bi
  headers += include/glib.bi
  headers += include/gmodule.bi
  headers += include/gmp.bi
  headers += include/goocanvas.bi
endif
  headers += include/grx/
ifneq ($(TARGET_OS),dos)
  headers += include/gsl/
  headers += include/gtk/
  headers += include/gtkgl/
  headers += include/IL/
  headers += include/IUP/
  headers += include/japi.bi
  headers += include/jit.bi
  headers += include/jit/
  headers += include/jni.bi
endif
  headers += include/jpeglib.bi
  headers += include/jpgalleg.bi
  headers += include/libintl.bi
ifneq ($(TARGET_OS),dos)
  headers += include/libart_lgpl/
  headers += include/libxml/
  headers += include/libxslt/
  headers += include/Lua/
endif
  headers += include/lzma.bi
  headers += include/lzo/
ifneq ($(TARGET_OS),dos)
  headers += include/MediaInfo.bi
  headers += include/mpg123.bi
  headers += include/mxml.bi
  headers += include/mysql/
  headers += include/Newton.bi
  headers += include/ode/
  headers += include/ogg/ogg.bi
  headers += include/pango/
endif
  headers += include/pcre/
ifneq ($(TARGET_OS),dos)
  headers += include/pdflib.bi
endif
  headers += include/png.bi
ifneq ($(TARGET_OS),dos)
  headers += include/portaudio.bi
  headers += include/postgresql/
endif
  headers += include/quicklz.bi
  headers += include/regex.bi
ifneq ($(TARGET_OS),dos)
  headers += include/SDL/
endif
ifneq ($(TARGET_OS),dos)
  headers += include/sndfile.bi
  headers += include/spidermonkey/
endif
  headers += include/sqlite2.bi
  headers += include/sqlite3.bi
  headers += include/sqlite3ext.bi
  headers += include/string.bi
  headers += include/tinyptc.bi
  headers += include/utf_conv.bi
  headers += include/uuid.bi
  headers += include/vbcompat.bi
ifneq ($(TARGET_OS),dos)
  headers += include/vlc/
  headers += include/vorbis/
endif
ifneq ($(filter cygwin win32,$(TARGET_OS)),)
  headers += include/win/
  headers += include/win/ddk/
  headers += $(wildcard include/win/rc/*.h)
  headers += include/windows.bi
endif
ifneq ($(TARGET_OS),dos)
  headers += include/wx-c/
endif
ifeq ($(TARGET_OS),linux)
  headers += include/X11/
  headers += include/X11/extensions/
  headers += include/X11/ICE/
  headers += include/X11/SM/
  headers += include/X11/Xcursor/
  headers += include/X11/Xft/
  headers += include/X11/Xmu/
  headers += include/X11/Xtrans/
endif
  headers += include/zip.bi
  headers += include/zlib.bi
ifneq ($(TARGET_OS),dos)
  headers += include/zmq/
endif

# All *.bi files given directly
HEADER_FILES := $(filter %.bi,$(headers))
# Plus all *.bi files from listed directories
HEADER_FILES += $(foreach i,$(filter %/,$(headers)),$(wildcard $(i)*.bi))

HEADER_FILES := $(patsubst include/%,$(newinclude)/%,$(HEADER_FILES))
HEADER_DIRS := $(patsubst %/,%,$(sort $(dir $(HEADER_FILES))))

#
# rtlib sources
#

LIBFB_H += rtlib/con_print_raw_uni.h
LIBFB_H += rtlib/con_print_tty_uni.h
LIBFB_H += rtlib/fb.h
LIBFB_H += rtlib/fb_array.h
LIBFB_H += rtlib/fb_console.h
LIBFB_H += rtlib/fb_data.h
LIBFB_H += rtlib/fb_datetime.h
LIBFB_H += rtlib/fb_device.h
LIBFB_H += rtlib/fb_error.h
LIBFB_H += rtlib/fb_file.h
LIBFB_H += rtlib/fb_hook.h
LIBFB_H += rtlib/fb_math.h
LIBFB_H += rtlib/fb_print.h
LIBFB_H += rtlib/fb_printer.h
LIBFB_H := rtlib/fb_private_console.h
LIBFB_H += rtlib/fb_private_hdynload.h
LIBFB_H += rtlib/fb_private_intl.h
LIBFB_H += rtlib/fb_private_thread.h
LIBFB_H += rtlib/fb_serial.h
LIBFB_H += rtlib/fb_string.h
LIBFB_H += rtlib/fb_system.h
LIBFB_H += rtlib/fb_thread.h
LIBFB_H += rtlib/fb_unicode.h

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
  dev_lpt_write_wstr dev_pipe_close dev_pipe_open dev_scrn dev_scrn_close dev_scrn_eof dev_scrn_init \
  dev_scrn_read dev_scrn_readline dev_scrn_readline_wstr dev_scrn_read_wstr \
  dev_scrn_write dev_scrn_write_wstr dev_stdio_close \
  drv_file_copy \
  drv_intl_get \
  drv_intl_getdateformat \
  drv_intl_getmonthname \
  drv_intl_gettimeformat \
  drv_intl_getweekdayname \
  error error_getset error_ptrchk \
  file_attr file_close file_copy file_datetime file_encod file_eof \
  file_exists file_free file_getarray file_get file_getstr file_get_wstr \
  file_hconvpath \
  file_hlock \
  file_input_byte file_input_con file_input_file file_input_float \
  file_input_int file_input_longint file_input_short file_input_str \
  file_inputstr file_input_tok file_input_tok_wstr file_input_ubyte \
  file_input_uint file_input_ulongint file_input_ushort file_input_wstr \
  file_kill file_len file_lineinp file_lineinp_wstr file_loc file_lock \
  file_open file_opencom file_opencons file_openencod file_openerr \
  file_openlpt file_openpipe file_openscrn file_openshort file_print \
  file_print_wstr file_putarray file_putback file_putback_wstr file_put \
  file_putstr file_put_wstr file_reset file_resetex file_seek file_size file_tell \
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
  io_isredir \
  io_lpos io_lprint_byte io_lprint_fix io_lprint_fp io_lprint_int \
  io_lprint_longint io_lprint_short io_lprint_str io_lprintusg io_lprintvoid \
  io_lprint_wstr io_maxrow io_print_byte io_print io_print_fix io_print_fp io_print_int \
  io_print_longint io_printpad io_printpad_wstr io_print_short io_printusg \
  io_printvoid io_printvoid_wstr io_print_wstr io_readstr io_setpos io_spc io_view \
  io_viewhlp io_viewupdate io_widthdev io_widthfile io_writebyte io_writefloat io_writeint \
  io_writelongint io_writeshort io_writestr io_writevoid io_write_wstr \
  list listdyn \
  math_fix math_frac math_rnd math_sgn \
  mem_copyclear \
  oop_istypeof oop_object \
  qb_file_open qb_inkey qb_sleep qb_str_convto qb_str_convto_flt \
  qb_str_convto_lng \
  signals \
  str_asc str_assign str_base str_bin str_bin_lng str_chr str_comp \
  str_concatassign str_concat str_convfrom str_convfrom_int str_convfrom_lng \
  str_convfrom_rad str_convfrom_radlng str_convfrom_uint str_convfrom_ulng \
  str_convto str_convto_flt str_convto_lng str_core str_cvmk str_del str_fill \
  str_format str_ftoa str_hex str_hex_lng str_hskip str_instrany str_instr \
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
  sys_beep sys_cdir sys_chain sys_chdir sys_cmd sys_delay sys_environ sys_exec_core \
  sys_exepath sys_fmem sys_getcwd sys_getexename sys_getexepath sys_getshortpath \
  sys_mkdir sys_rmdir sys_run sys_shell \
  thread_call thread_ctx thread_mutex \
  time_core time_dateadd time_date time_datediff time_datepart time_dateserial \
  time_dateset time_datevalue time_decodeserdate time_decodesertime \
  time_isdate time_monthname time_now time_parsedate time_parsedatetime \
  time_parsetime time_setdate time_settime time_sleep time_sleepex \
  time_time time_timer time_timeserial time_timeset \
  time_timevalue time_week time_weekdayname \
  utf_convfrom_char utf_convfrom_wchar utf_convto_char utf_convto_wchar \
  utf_core \
  vfs_open

LIBFB_S :=

ifeq ($(TARGET_OS),cygwin)
  ALLCFLAGS += -DHOST_CYGWIN
endif

ifeq ($(TARGET_OS),darwin)
  ALLCFLAGS += -DHOST_DARWIN
  LIBFB_C += io_mouse_stub
endif

ifeq ($(TARGET_OS),dos)
  ALLCFLAGS += -DHOST_DOS

  LIBFB_H += rtlib/fb_dos.h
  LIBFB_C += \
    drv_intl_dos drv_intl_data_dos \
    farmemset_dos \
    file_dir_dos \
    init_dos \
    io_cls_dos io_color_dos io_getsize_dos io_inkey_dos io_input_dos \
    io_locate_dos io_mouse_dos io_multikey_dos io_pageset_dos \
    io_pcopy_dos io_printbuff_dos io_printbuff_wstr_dos io_printer_dos \
    io_scroll_dos io_serial_dos io_width_dos \
    sys_exec_dos \
    sys_isr_dos sys_ports_dos \
    thread_cond_stub thread_core_stub
  LIBFB_S += drv_isr
endif

ifeq ($(TARGET_OS),freebsd)
  ALLCFLAGS += -DHOST_FREEBSD

  LIBFB_C += \
    io_mouse_stub io_multikey_stub
endif

ifeq ($(TARGET_OS),linux)
  ALLCFLAGS += -DHOST_LINUX

  LIBFB_C += \
    io_mouse_linux io_multikey_linux io_serial_linux \
    sys_ports_linux
endif

ifeq ($(TARGET_OS),netbsd)
  ALLCFLAGS += -DHOST_NETBSD

  LIBFB_C += \
    io_mouse_stub io_multikey_stub
endif

ifeq ($(TARGET_OS),openbsd)
  ALLCFLAGS += -DHOST_OPENBSD

  LIBFB_C += \
    io_mouse_stub io_multikey_stub \
    swprintf_hack_openbsd
endif

ifeq ($(TARGET_OS),win32)
  ALLCFLAGS += -DHOST_MINGW
  # We prefer using non-oldnames functions, see also rtlib/fb_win32.h
  ALLCFLAGS += -DNO_OLDNAMES -D_NO_OLDNAMES
  # Include some less Windows headers
  ALLCFLAGS += -DWIN32_LEAN_AND_MEAN
endif

ifeq ($(TARGET_OS),solaris)
  ALLCFLAGS += -DHOST_SOLARIS
endif

ifeq ($(TARGET_OS),xbox)
  ALLCFLAGS += -DHOST_XBOX

  # Some special treatment for xbox. TODO: Test me, update me!
  ALLCFLAGS += -DENABLE_XBOX -DDISABLE_CDROM
  ALLCFLAGS += -std=gnu99 -mno-cygwin -nostdlib -nostdinc
  ALLCFLAGS += -ffreestanding -fno-builtin -fno-exceptions
  ALLCFLAGS += -I$(OPENXDK)/i386-pc-xbox/include
  ALLCFLAGS += -I$(OPENXDK)/include
  ALLCFLAGS += -I$(OPENXDK)/include/SDL

  LIBFB_H += rtlib/fb_xbox.h
  LIBFB_C += \
    file_dir_xbox \
    init_xbox \
    io_cls_stub io_color_stub io_getsize_stub io_inkey_stub \
    io_locate_stub io_mouse_stub io_multikey_stub \
    io_pageset_stub io_pcopy_stub io_printbuff_stub io_printbuff_wstr_stub \
    io_printer_stub io_scroll_stub io_serial_stub \
    io_width_stub \
    sys_dylib_stub sys_exec_xbox \
    thread_cond_stub thread_core_xbox
  LIBFB_S += alloca
endif

ifneq ($(filter darwin freebsd linux netbsd openbsd solaris,$(TARGET_OS)),)
  ALLCFLAGS += -DHOST_UNIX

  # This causes off_t/fopen/fseeko/... to be mapped to their 64bit versions
  ALLCFLAGS += -D_FILE_OFFSET_BITS=64

  LIBFB_H += rtlib/fb_unix.h
  LIBFB_C += \
    file_dir_unix \
    init_unix \
    hdynload \
    io_cls_unix io_color_unix io_getsize_unix io_inkey_unix io_input_unix \
    io_locate_unix io_pageset_stub io_pcopy_stub \
    io_printbuff_unix io_printbuff_wstr_unix io_printer_unix \
    io_scroll_unix io_width_unix io_xfocus_unix \
    sys_dylib_unix sys_exec_unix \
    thread_cond_unix thread_core_unix

  ifndef DISABLE_X
    LIBFB_H += rtlib/fb_private_scancodes_x11.h
    LIBFB_C += scancodes_x11
  endif
endif

ifneq ($(filter cygwin win32,$(TARGET_OS)),)
  ALLCFLAGS += -DHOST_WIN32
  LIBFB_H += rtlib/fb_win32.h
  LIBFB_H += rtlib/fbportio/fbportio.h
  LIBFB_H += rtlib/fbportio/inline.h
  LIBFB_C += \
    file_dir_win32 \
    init_win32 \
    hdynload \
    intl_conv_win32 intl_win32 \
    io_cls_win32 io_clsex_win32 io_color_win32 io_colorget_win32 \
    io_gethnd_win32 io_getsize_win32 io_getwindow_win32 io_getwindowex_win32 \
    io_getx_win32 io_getxy_win32 io_gety_win32 io_inkey_win32 io_input_win32 \
    io_locate_win32 io_locateex_win32 \
    io_mouse_win32 io_multikey_win32 io_pageset_win32 io_pcopy_win32 \
    io_printbuff_win32 io_printbuff_wstr_win32 io_printer_win32 \
    io_readxy_win32 io_screensize_win32 io_scroll_win32 \
    io_scrollex_win32 io_serial_win32 io_width_win32 \
    io_window_win32 \
    sys_dylib_win32 sys_exec_win32 \
    sys_ports_win32 \
    thread_cond_win32 thread_core_win32
  LIBFB_S += alloca
endif

ifneq ($(filter 386 486 586 686,$(TARGET_ARCH)),)
  ALLCFLAGS += -DHOST_X86
  LIBFB_H += rtlib/fb_arch_x86.h
  LIBFB_S += cpudetect_x86
endif
ifeq ($(TARGET_ARCH),x86_64)
  ALLCFLAGS += -DHOST_X86_64
  LIBFB_H += rtlib/fb_arch_any.h
  LIBFB_C += cpudetect_any
endif
ifeq ($(TARGET_ARCH),sparc)
  ALLCFLAGS += -DHOST_SPARC
  LIBFB_H += rtlib/fb_arch_any.h
  LIBFB_C += cpudetect_any
endif
ifeq ($(TARGET_ARCH),sparc64)
  ALLCFLAGS += -DHOST_SPARC64
  LIBFB_H += rtlib/fb_arch_any.h
  LIBFB_C += cpudetect_any
endif
ifeq ($(TARGET_ARCH),powerpc64)
  ALLCFLAGS += -DHOST_POWERPC64
  LIBFB_H += rtlib/fb_arch_any.h
  LIBFB_C += cpudetect_any
endif

LIBFB_C := $(patsubst %,$(newlibfb)/%.o,$(LIBFB_C))
LIBFB_S := $(patsubst %,$(newlibfb)/%.o,$(LIBFB_S))

ifndef DISABLE_MT
  LIBFBMT_C := $(patsubst $(newlibfb)/%,$(newlibfbmt)/%,$(LIBFB_C))
  LIBFBMT_S := $(patsubst $(newlibfb)/%,$(newlibfbmt)/%,$(LIBFB_S))
endif

#
# gfxlib sources
#

ifndef DISABLE_GFX
  LIBFBGFX_H := $(LIBFB_H)
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

.PHONY: all
all: compiler headers rtlib gfxlib2

$(sort $(new) $(newcompiler) $(newlibfb) $(newlibfbmt) $(newlibfbgfx) \
       $(newbin) $(new)/include $(newinclude) $(HEADER_DIRS) \
       $(new)/lib $(newlib) \
       $(prefix) $(prefixbin) \
       $(prefix)/include $(prefixinclude) $(prefix)/lib $(prefixlib) ):
	mkdir $@

.PHONY: compiler
compiler: $(new) $(newcompiler) $(newbin) $(newbin)/$(FBC_EXE)

$(newbin)/$(FBC_EXE): $(FBC_BAS) $(FBC_BFDWRAPPER)
	$(QUIET_LINK)$(FBC) $(ALLFBLFLAGS) -x $@ $^

$(FBC_BAS): $(newcompiler)/%.o: compiler/%.bas $(FBC_BI)
	$(QUIET_FBC)$(FBC) $(ALLFBCFLAGS) -c $< -o $@

$(FBC_BFDWRAPPER): $(newcompiler)/%.o: compiler/%.c
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@

.PHONY: headers
ifndef ENABLE_STANDALONE
headers: $(new)/include
endif
headers: $(newinclude)
headers: $(HEADER_DIRS) $(HEADER_FILES)
$(HEADER_FILES): $(newinclude)/%.bi: include/%.bi
	$(QUIET_CP) cp $< $@

.PHONY: rtlib
rtlib: $(new) $(newlibfb)
ifndef ENABLE_STANDALONE
rtlib: $(new)/lib
endif
rtlib: $(newlib)
ifdef FB_LDSCRIPT
rtlib: $(newlib)/$(FB_LDSCRIPT)
endif
rtlib: $(newlib)/fbrt0.o
rtlib: $(newlib)/libfb.a
ifndef DISABLE_MT
rtlib: $(newlibfbmt) $(newlib)/libfbmt.a
endif

$(newlib)/fbextra.x: rtlib/fbextra.x
	$(QUIET_CP)cp $< $@

$(newlib)/i386go32.x: contrib/djgpp/i386go32.x
	$(QUIET_CP)cp $< $@

$(newlib)/fbrt0.o: rtlib/fbrt0.c $(LIBFB_H)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@

$(newlib)/libfb.a: $(LIBFB_C) $(LIBFB_S)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^

$(LIBFB_C): $(newlibfb)/%.o: rtlib/%.c $(LIBFB_H)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@

$(LIBFB_S): $(newlibfb)/%.o: rtlib/%.s $(LIBFB_H)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp $(ALLCFLAGS) -c $< -o $@

$(newlib)/libfbmt.a: $(LIBFBMT_C) $(LIBFBMT_S)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^

$(LIBFBMT_C): $(newlibfbmt)/%.o: rtlib/%.c $(LIBFB_H)
	$(QUIET_CC)$(CC) -DENABLE_MT $(ALLCFLAGS) -c $< -o $@

$(LIBFBMT_S): $(newlibfbmt)/%.o: rtlib/%.s $(LIBFB_H)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp -DENABLE_MT $(ALLCFLAGS) -c $< -o $@

.PHONY: gfxlib2
gfxlib2:
ifndef DISABLE_GFX
gfxlib2: $(new) $(newlibfb)
ifndef ENABLE_STANDALONE
gfxlib2: $(new)/lib
endif
gfxlib2: $(newlib)
gfxlib2: $(newlibfbgfx) $(newlib)/libfbgfx.a
endif

$(newlib)/libfbgfx.a: $(LIBFBGFX_C) $(LIBFBGFX_S)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^

$(LIBFBGFX_C): $(newlibfbgfx)/%.o: gfxlib2/%.c $(LIBFBGFX_H)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@

$(LIBFBGFX_S): $(newlibfbgfx)/%.o: gfxlib2/%.s $(LIBFBGFX_H)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp $(ALLCFLAGS) -c $< -o $@

.PHONY: install install-compiler install-headers install-rtlib install-gfxlib2
install: install-compiler install-headers install-rtlib install-gfxlib2

install-compiler: $(prefixbin)
	$(INSTALL_PROGRAM) $(newbin)/$(FBC_EXE) $(prefixbin)/

ifdef ENABLE_STANDALONE
install-headers: $(prefixinclude)
	cp -r $(newinclude) $(prefixinclude)
else
install-headers:
	cp -r $(newinclude) $(prefix)/include
endif

install-rtlib: $(prefixlib)
  ifdef FB_LDSCRIPT
	$(INSTALL_FILE) $(newlib)/$(FB_LDSCRIPT) $(prefixlib)/
  endif
	$(INSTALL_FILE) $(newlib)/fbrt0.o $(newlib)/libfb.a $(prefixlib)/
  ifndef DISABLE_MT
	$(INSTALL_FILE) $(newlib)/libfbmt.a $(prefixlib)/
  endif

install-gfxlib2: $(prefixlib)
  ifndef DISABLE_GFX
	$(INSTALL_FILE) $(newlib)/libfbgfx.a $(prefixlib)/
  endif

.PHONY: uninstall uninstall-compiler uninstall-headers uninstall-rtlib uninstall-gfxlib2
uninstall: uninstall-compiler uninstall-headers uninstall-rtlib uninstall-gfxlib2
  # The non-standalone build uses freebasic subdirs, e.g. /usr/lib/freebasic,
  # that we should remove if empty.
  ifndef ENABLE_STANDALONE
	-rmdir $(prefixlib)
  endif

uninstall-compiler:
	rm -f $(prefixbin)/$(FBC_EXE)

uninstall-headers:
  ifdef ENABLE_STANDALONE
	rm -rf $(prefixinclude)/*
  else
	rm -rf $(prefixinclude)
  endif

uninstall-rtlib:
  ifdef FB_LDSCRIPT
	rm -f $(prefixlib)/$(FB_LDSCRIPT)
  endif
	rm -f $(prefixlib)/fbrt0.o $(prefixlib)/libfb.a
  ifndef DISABLE_MT
	rm -f $(prefixlib)/libfbmt.a
  endif

uninstall-gfxlib2:
  ifndef DISABLE_GFX
	rm -f $(prefixlib)/libfbgfx.a
  endif

.PHONY: clean clean-compiler clean-headers clean-rtlib clean-gfxlib2
clean: clean-compiler clean-headers clean-rtlib clean-gfxlib2
  ifndef ENABLE_STANDALONE
	-rmdir $(newbin)
  endif
	-rmdir $(newlib)
  ifndef ENABLE_STANDALONE
	-rmdir $(new)/lib
  endif
	-rmdir $(new)

clean-compiler:
	rm -f $(newbin)/$(FBC_EXE) $(newcompiler)/*.o
	-rmdir $(newcompiler)

clean-headers:
	rm -rf $(newinclude)
  ifndef ENABLE_STANDALONE
	-rmdir $(new)/include
  endif

clean-rtlib:
  ifdef FB_LDSCRIPT
	rm -f $(newlib)/$(FB_LDSCRIPT)
  endif
	rm -f $(newlib)/fbrt0.o $(newlib)/libfb.a $(newlibfb)/*.o
	-rmdir $(newlibfb)
  ifndef DISABLE_MT
	rm -f $(newlib)/libfbmt.a $(newlibfbmt)/*.o
	-rmdir $(newlibfbmt)
  endif

clean-gfxlib2:
  ifndef DISABLE_GFX
	rm -f $(newlib)/libfbgfx.a $(newlibfbgfx)/*.o
	-rmdir $(newlibfbgfx)
  endif

################################################################################
# 'make release'
#
# TODO:
#   - man page
#   - DJGPP/MinGW libs (FB's patched DJGPP libc: require user to copy into new/lib/, e.g. from prev FB release..)
#   - win32 import libs
#   - NSIS installer + start-shell.exe
#   - wget https://raw.github.com/atgreen/libffi/master/LICENSE
#     then move to doc/LICENSE.libffi
#   - install.sh script for Linux
#   - .tar.gz instead of .zip for Linux

ifdef ENABLE_STANDALONE
  DIST_TARGET := $(TARGET_OS)-standalone
else
  DIST_TARGET := $(TARGET_OS)
endif

DIST_MANIFEST := contrib/manifest/$(DIST_TARGET).lst

DIST_STUFF := bin/ doc/ include/ lib/
ifdef ENABLE_STANDALONE
  DIST_STUFF += $(FBC_EXE) examples/
endif

DIST_VERSION := 0.24.0
DIST_TITLE := FreeBASIC-$(DIST_VERSION)-$(DIST_TARGET)
DIST_ZIP := $(DIST_TITLE).zip

.PHONY: manifest
manifest:
	cd $(new) && find $(sort $(DIST_STUFF)) -type f | sort > ../$(DIST_MANIFEST)

$(new)/doc:
	mkdir $@

$(new)/examples:
	cp -r examples/ $(new)

# 1) zip everything into a temp.zip
# 2) mkdir FreeBASIC-X.XX.X-target
# 3) unzip everything into that new dir
# 4) rezip that dir
$(DIST_ZIP):
	cd $(new) && zip -@ -q temp.zip < ../$(DIST_MANIFEST)
	mkdir $(new)/$(DIST_TITLE)
	mv $(new)/temp.zip $(new)/$(DIST_TITLE)
	cd $(new)/$(DIST_TITLE) && unzip -q temp.zip
	rm $(new)/$(DIST_TITLE)/temp.zip
	rm -f $(new)/$@
	cd $(new) && zip -r -q $@ $(DIST_TITLE)
	rm -rf $(new)/$(DIST_TITLE)

.PHONY: release

# Build/copy in all files
release: all
release: $(new)/doc
ifdef ENABLE_STANDALONE
release: $(new)/examples
endif

# Create the manifest
release: manifest

# Packaging
release: $(DIST_ZIP)

################################################################################

.PHONY: help
help:
	@echo "Available commands, use them to..."
	@echo "  <none>|all                 build everything"
	@echo "  compiler|headers|rtlib|gfxlib2   (specific component only)"
	@echo "  clean[-component]          remove built files"
	@echo "  install[-component]        install into prefix"
	@echo "  uninstall[-component]      remove from prefix"
	@echo "  release                    build a release package"
	@echo "Variables, use them to..."
	@echo "  FB[C|L]FLAGS  add '-exx' or similar (affects the compiler only)"
	@echo "  CFLAGS   override the default '-O2' (affects the runtime only)"
	@echo "  new      use another build directory (default: 'new')"
	@echo "  prefix   install in a specific place (default: '/usr/local')"
	@echo "  TARGET   cross-compile compiler and runtime to run on TARGET"
	@echo "  SUFFIX   append a string (e.g. '-0.23') to fbc and FB directory names"
	@echo "  SUFFIX2  append a second string (e.g. '-test') only to the fbc executable"
	@echo "  FBC, CC, AR  use specific tools (system triplets may be prefixed to CC/AR)"
	@echo "  V        to get to see verbose command lines used by make"
	@echo "FreeBASIC configuration options, use them to..."
	@echo "  ENABLE_STANDALONE  use a simpler directory layout with fbc at toplevel"
	@echo "                     (for self-contained installations)"
	@echo "  ENABLE_PREFIX     hard-code the prefix into fbc (no longer relocatable)"
	@echo "  ENABLE_FBBFD=217  use the FB headers for this exact libbfd version,"
	@echo "                    instead of using the system's bfd.h through a C wrapper"
	@echo "  DISABLE_OBJINFO   Leave out fbc's objinfo feature and don't use libbfd at all"
	@echo "  ENABLE_TDMGCC     Build FB to work with TDM-GCC (affects win32 target only)"
	@echo "  DISABLE_MT        Don't build libfbmt (auto-defined for DOS runtime)"
	@echo "  DISABLE_GFX       Don't build libfbgfx (useful when cross-compiling,"
	@echo "                    or when the target system isn't yet supported by libfbgfx)"
	@echo "  DISABLE_OPENGL    Don't use OpenGL in libfbgfx (Unix/Windows versions)"
	@echo "  DISABLE_X         Don't use X in libfbgfx (Unix version)"
	@echo "This makefile #includes config.mk and new/config.mk, allowing you to use them"
	@echo "to set variables in a more permanent and even build-directory specific way."
