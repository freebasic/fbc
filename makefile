#!/usr/bin/make -f
#
# This is the FB makefile that builds the compiler (fbc) and the runtime
# libraries (rtlib -> libfb[mt] and fbrt0.o, gfxlib2 -> libfbgfx[mt]). It will
# also take care of moving the resulting binaries into the proper directory
# layout, allowing the new FB setup to be tested right away, without being
# installed elsewhere.
#
# Building the compiler requires a working FB installation, because it's written
# in FB itself. rtlib/gfxlib2 are written in C and some ASM and have several
# dependencies on external libraries depending on the target system.
# (for example: ncurses/libtinfo, gpm, Linux headers, X11, OpenGL, DirectX)
# More info: http://www.freebasic.net/wiki/wikka.php?wakka=DevBuild
#
# What will be built:
#
#   compiler:
#     src/compiler/*.bas -> fbc[.exe]
#
#   rtlib:
#     src/rtlib/static/fbrt0.c
#     -> fbrt0.o
#     -> fbrt0pic.o, -fPIC version (non-x86 Linux etc.)
#
#     all *.c and *.s files in
#     src/rtlib/
#     src/rtlib/$(TARGET_OS)
#     src/rtlib/$(TARGET_ARCH)
#     -> libfb.a
#     -> libfbmt.a, -DENABLE_MT (threadsafe) version (except for DOS)
#     -> libfbpic.a, -fPIC version (non-x86 Linux etc.)
#     -> libfbmtpic.a, threadsafe and -fPIC (non-x86 Linux etc.)
#
#     contrib/djgpp/libc/...
#     -> libc.a, fixed libc for DOS/DJGPP (see contrib/djgpp/ for more info)
#
#   gfxlib2:
#     all *.c and *.s files in
#     src/gfxlib2/
#     src/gfxlib2/$(TARGET_OS)
#     src/gfxlib2/$(TARGET_ARCH)
#     -> libfbgfx.a
#     -> libfbgfxmt.a, -DENABLE_MT (threadsafe) version (except for DOS)
#     -> libfbgfxpic.a, -fPIC version (non-x86 Linux etc.)
#     -> libfbgfxmtpic.a, threadsafe and -fPIC (non-x86 Linux etc.)
#
# commands:
#
#   <none>|all                 build everything
#   compiler|rtlib|gfxlib2     build specific component only
#   clean[-component]          remove built files
#   install[-component]        install into $(prefix)
#   uninstall[-component]      remove from $(prefix)
#
#   install-includes           (additional commands for just the FB includes,
#   uninstall-includes          which don't need to be built)
#
#   gitdist    Create source code packages using "git archive"
#   bindist    Create binary FB release packages from current built directory content
#   mingw-libs Standalone: Copy libraries from MinGW toolchain into lib/win32/ etc.
#
#   cunit-tests  (Convenience wrappers around tests/Makefile, running the tests
#   log-tests     using the newly built fbc)
#   warning-tests
#   clean-tests
#
# makefile configuration:
#   FB[C|L]FLAGS     to set -g -exx etc. for the compiler build and/or link
#   CFLAGS           same for the rtlib and gfxlib2 build
#   prefix           install/uninstall directory, default: /usr/local
#   TARGET           GNU triplet for cross-compiling
#   MULTILIB         "32", "64" or empty for cross-compiling using a gcc multilib toolchain
#   FBC, CC, AR      fbc, gcc, ar programs (TARGET may be prefixed to CC/AR)
#   V=1              to see full command lines
#   ENABLE_STANDALONE=1    build source tree into self-contained FB installation
#   ENABLE_PREFIX=1        use "-d ENABLE_PREFIX=$(prefix)"
#   ENABLE_SUFFIX=-0.24    append a string like "-0.24" to fbc/FB dir names,
#                          and use "-d ENABLE_SUFFIX=$(ENABLE_SUFFIX)" (non-standalone only)
#   FBPACKAGE     bindist: The package/archive file name without path or extension
#   FBPACKSUFFIX  bindist: Allows adding a custom suffix to the normal package name (and the toplevel dir in the archive)
#   FBMANIFEST    bindist: The manifest file name without path or extension
#   FBVERSION     bindist/gitdist: FB version number
#   DISABLE_DOCS  bindist: Don't package readme/changelog/manpage/examples
#
# compiler source code configuration (FBCFLAGS):
#   -d ENABLE_STANDALONE     build for a self-contained installation
#   -d ENABLE_SUFFIX=-0.24   assume FB's lib dir uses the given suffix (non-standalone only)
#   -d ENABLE_PREFIX=/some/path   hard-code specific $(prefix) into fbc
#
# rtlib/gfxlib2 source code configuration (CFLAGS):
#   -DDISABLE_X11    build without X11 headers (disables X11 gfx driver)
#   -DDISABLE_GPM    build without gpm.h (disables Linux GetMouse)
#   -DDISABLE_FFI    build without ffi.h (disables ThreadCall)
#   -DDISABLE_OPENGL build without OpenGL headers (disables OpenGL gfx drivers)
#   -DDISABLE_FBDEV  build without Linux framebuffer device headers (disables Linux fbdev gfx driver)
#
# makefile variables may either be set on the make command line,
# or (in a more permanent way) inside a 'config.mk' file.
#
# The makefile searches the sources based on its location, but builds into
# the current directory. It's possible to build in a separate directory by
# running the makefile via "make -f ../path/to/fbc/makefile" from the desired
# build directory.
#
# The makefile supports only one compiler build per build directory, but
# possibly multiple rtlib/gfxlib2 builds, each for a different target.
# This matches how FB works: one fbc per host, plus one rtlib/gfxlib2 per
# target. For example:
#    1) Build host FB setup
#        $ make
#    2) Add rtlib/gfxlib2 for some additional target
#        $ make rtlib gfxlib2 TARGET=i686-w64-mingw32
#
# In order to be compatible to older makes like DJGPP's GNU make 3.79.1, this
# makefile cannot use features added in more recent versions, for example:
#  - "else if"
#  - Order-only prerequisites
#  - $(or ...), $(and ...)
#  - $(eval ...)
#

FBC := fbc
CFLAGS := -Wfatal-errors -O2
# Avoid gcc exception handling bloat
CFLAGS += -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables
FBFLAGS := -maxerr 1
AR = $(TARGET_PREFIX)ar
CC = $(TARGET_PREFIX)gcc
prefix := /usr/local

# Determine the makefile's directory, this may be a relative path when
# building in a separate build directory via e.g. "make -f ../fbc/makefile".
# MAKEFILE_LIST did not exist in GNU make 3.79.1 (it was only added in 3.80),
# so DJGPP users have to set MAKEFILE_LIST or rootdir manually in order to build
# in a separate directory.
rootdir := $(dir $(MAKEFILE_LIST))

# Prune ./ prefix for beauty
ifeq ($(rootdir),./)
  rootdir :=
endif

srcdir := $(rootdir)src

include $(rootdir)version.mk
-include config.mk

#
# We need to know target OS/architecture names to select the proper
# rtlib/gfxlib2 source directories.
#
# If TARGET is given, we try to parse it to determine TARGET_OS/TARGET_ARCH.
# Otherwise we rely on "uname" and "uname -m".
#
ifdef TARGET
  # Parse TARGET
  triplet := $(subst -, ,$(TARGET))
  TARGET_PREFIX := $(TARGET)-

  ifndef TARGET_OS
    ifneq ($(filter cygwin%,$(triplet)),)
      TARGET_OS := cygwin
    endif
    ifneq ($(filter darwin%,$(triplet)),)
      TARGET_OS := darwin
    endif
    ifneq ($(filter djgpp%,$(triplet)),)
      TARGET_OS := dos
    endif
    ifneq ($(filter msdos%,$(triplet)),)
      TARGET_OS := dos
    endif
    ifneq ($(filter freebsd%,$(triplet)),)
      TARGET_OS := freebsd
    endif
    ifneq ($(filter linux%,$(triplet)),)
      TARGET_OS := linux
    endif
    ifneq ($(filter mingw%,$(triplet)),)
      TARGET_OS := win32
    endif
    ifneq ($(filter netbsd%,$(triplet)),)
      TARGET_OS := netbsd
    endif
    ifneq ($(filter openbsd%,$(triplet)),)
      TARGET_OS := openbsd
    endif
    ifneq ($(filter solaris%,$(triplet)),)
      TARGET_OS := solaris
    endif
    ifneq ($(filter xbox%,$(triplet)),)
      TARGET_OS := xbox
    endif
  endif

  ifndef TARGET_ARCH
    # arch = iif(has >= 2 words, first word, empty)
    # 'i686 pc linux gnu' -> 'i686'
    # 'mingw32'           -> ''
    TARGET_ARCH := $(if $(word 2,$(triplet)),$(firstword $(triplet)))
  endif
else
  # No TARGET given, so try to detect the native system with 'uname'
  ifndef TARGET_OS
    uname := $(shell uname)
    ifneq ($(findstring CYGWIN,$(uname)),)
      TARGET_OS := cygwin
    endif
    ifeq ($(uname),Darwin)
      TARGET_OS := darwin
    endif
    ifeq ($(uname),FreeBSD)
      TARGET_OS := freebsd
    endif
    ifeq ($(uname),Linux)
      TARGET_OS := linux
    endif
    ifneq ($(findstring MINGW,$(uname)),)
      TARGET_OS := win32
    endif
    ifeq ($(uname),MS-DOS)
      TARGET_OS := dos
    endif
    ifeq ($(uname),NetBSD)
      TARGET_OS := netbsd
    endif
    ifeq ($(uname),OpenBSD)
      TARGET_OS := openbsd
    endif
  endif

  ifndef TARGET_ARCH
    # For DJGPP, always use x86 (DJGPP's uname -m returns just "pc")
    ifeq ($(TARGET_OS),dos)
      TARGET_ARCH := x86
    else
      TARGET_ARCH = $(shell uname -m)
    endif
  endif
endif

ifndef TARGET_OS
  $(error couldn't identify TARGET_OS automatically)
endif
ifndef TARGET_ARCH
  $(error couldn't identify TARGET_ARCH automatically)
endif

# Normalize TARGET_ARCH to x86
ifneq ($(filter 386 486 586 686 i386 i486 i586 i686,$(TARGET_ARCH)),)
  TARGET_ARCH := x86
endif

# Normalize TARGET_ARCH to arm
ifneq ($(filter arm%,$(TARGET_ARCH)),)
  TARGET_ARCH := arm
endif

# Normalize TARGET_ARCH to x86_64 (e.g., FreeBSD's uname -m returns "amd64"
# instead of "x86_64" like Linux)
ifneq ($(filter amd64 x86-64,$(TARGET_ARCH)),)
  TARGET_ARCH := x86_64
endif

# Switch TARGET_ARCH depending on MULTILIB
ifeq ($(MULTILIB),32)
  ifeq ($(TARGET_ARCH),x86_64)
    TARGET_ARCH := x86
  endif
endif
ifeq ($(MULTILIB),64)
  ifeq ($(TARGET_ARCH),x86)
    TARGET_ARCH := x86_64
  endif
endif

ifeq ($(TARGET_OS),dos)
  FBNAME := freebas$(ENABLE_SUFFIX)
  FB_LDSCRIPT := i386go32.x
  DISABLE_MT := YesPlease
else
  FBNAME := freebasic$(ENABLE_SUFFIX)
  FB_LDSCRIPT := fbextra.x
endif

# ENABLE_PIC for non-x86 Linux etc. (for every system where we need separate
# -fPIC versions of FB libs besides the normal ones)
ifneq ($(filter freebsd linux netbsd openbsd solaris,$(TARGET_OS)),)
  ifneq ($(TARGET_ARCH),x86)
    ENABLE_PIC := YesPlease
  endif
endif

ifneq ($(filter cygwin dos win32,$(TARGET_OS)),)
  EXEEXT := .exe
  INSTALL_PROGRAM := cp
  INSTALL_FILE := cp
else
  INSTALL_PROGRAM := install
  INSTALL_FILE := install -m 644
endif

#
# Determine FB target name:
# dos, win32, win64, xbox, linux-x86, linux-x86_64, ...
#

# Some use a simple free-form name
ifeq ($(TARGET_OS),dos)
  FBTARGET := dos
endif
ifeq ($(TARGET_OS),xbox)
  FBTARGET := xbox
endif
ifeq ($(TARGET_OS),win32)
  ifeq ($(TARGET_ARCH),x86_64)
    FBTARGET := win64
  else
    FBTARGET := win32
  endif
endif

# The rest uses the <os>-<cpufamily> format
ifndef FBTARGET
  FBTARGET := $(TARGET_OS)-$(TARGET_ARCH)
endif

#
# Determine directory layout for .o files and final binaries.
#
libsubdir := $(FBTARGET)
ifdef ENABLE_STANDALONE
  FBC_EXE     := fbc$(EXEEXT)
  FBCNEW_EXE  := fbc-new$(EXEEXT)
  libdir         := lib/$(libsubdir)
  PREFIX_FBC_EXE := $(prefix)/fbc$(EXEEXT)
  prefixincdir   := $(prefix)/inc
  prefixlibdir   := $(prefix)/lib/$(libsubdir)
else
  ifdef TARGET
    libsubdir := $(TARGET)
  endif
  FBC_EXE     := bin/fbc$(ENABLE_SUFFIX)$(EXEEXT)
  FBCNEW_EXE  := bin/fbc$(ENABLE_SUFFIX)-new$(EXEEXT)
  libdir         := lib/$(FBNAME)/$(libsubdir)
  PREFIX_FBC_EXE := $(prefix)/bin/fbc$(ENABLE_SUFFIX)$(EXEEXT)
  prefixbindir   := $(prefix)/bin
  prefixincdir   := $(prefix)/include/$(FBNAME)
  prefixlibdir   := $(prefix)/lib/$(FBNAME)/$(libsubdir)
endif
fbcobjdir           := src/compiler/obj
libfbobjdir         := src/rtlib/obj/$(libsubdir)
libfbpicobjdir      := src/rtlib/obj/$(libsubdir)/pic
libfbmtobjdir       := src/rtlib/obj/$(libsubdir)/mt
libfbmtpicobjdir    := src/rtlib/obj/$(libsubdir)/mt/pic
libfbgfxobjdir      := src/gfxlib2/obj/$(libsubdir)
libfbgfxpicobjdir   := src/gfxlib2/obj/$(libsubdir)/pic
libfbgfxmtobjdir    := src/gfxlib2/obj/$(libsubdir)/mt
libfbgfxmtpicobjdir := src/gfxlib2/obj/$(libsubdir)/mt/pic
djgpplibcobjdir     := contrib/djgpp/libc/crt0/obj/$(libsubdir)

# If cross-compiling, use -target
ifdef TARGET
  ALLFBCFLAGS += -target $(TARGET)
  ALLFBLFLAGS += -target $(TARGET)
endif
ifdef MULTILIB
  ALLFBCFLAGS += -arch $(MULTILIB)
  ALLFBLFLAGS += -arch $(MULTILIB)
  ALLCFLAGS   += -m$(MULTILIB)
endif

ALLFBCFLAGS += -e -m fbc -w pedantic
ALLFBLFLAGS += -e -m fbc -w pedantic
ALLCFLAGS += -Wall -Wextra -Wno-unused-parameter -Werror-implicit-function-declaration

ifeq ($(TARGET_OS),xbox)
  ifeq ($(OPENXDK),)
    $(error Please set OPENXDK=<OpenXDK directory>)
  endif

  MINGWGCCLIBDIR := $(dir $(shell $(CC) -print-file-name=libgcc.a))

  ALLCFLAGS += -ffreestanding -nostdinc -fno-exceptions -march=i386 \
    -I$(OPENXDK)/i386-pc-xbox/include \
    -I$(OPENXDK)/include \
    -I$(MINGWGCCLIBDIR)/include

  # src/rtlib/fb_config.h cannot auto-detect this
  ALLCFLAGS += -DHOST_XBOX

  # Assume no libffi for now (does it work on Xbox?)
  ALLCFLAGS += -DDISABLE_FFI

  # -DENABLE_MT parts of rtlib XBox code aren't finished
  DISABLE_MT := YesPlease
endif

ifneq ($(filter cygwin win32,$(TARGET_OS)),)
  # Increase compiler's available stack size, it uses lots of recursion
  ALLFBLFLAGS += -t 2048
endif

# Pass the configuration defines on to the compiler source code
ifdef ENABLE_STANDALONE
  ALLFBCFLAGS += -d ENABLE_STANDALONE
endif
ifdef ENABLE_SUFFIX
  ALLFBCFLAGS += -d 'ENABLE_SUFFIX="$(ENABLE_SUFFIX)"'
endif
ifdef ENABLE_PREFIX
  ALLFBCFLAGS += -d 'ENABLE_PREFIX="$(prefix)"'
endif

ALLFBCFLAGS += $(FBCFLAGS) $(FBFLAGS)
ALLFBLFLAGS += $(FBLFLAGS) $(FBFLAGS)
ALLCFLAGS += $(CFLAGS)

# compiler headers and modules
FBC_BI  :=        $(wildcard $(srcdir)/compiler/*.bi)
FBC_BAS := $(sort $(wildcard $(srcdir)/compiler/*.bas))
FBC_BAS := $(patsubst $(srcdir)/compiler/%.bas,$(fbcobjdir)/%.o,$(FBC_BAS))

# rtlib/gfxlib2 headers and modules
RTLIB_DIRS := $(srcdir)/rtlib $(srcdir)/rtlib/$(TARGET_OS) $(srcdir)/rtlib/$(TARGET_ARCH)
ifeq ($(TARGET_OS),cygwin)
  RTLIB_DIRS += $(srcdir)/rtlib/win32
endif
ifneq ($(filter darwin freebsd linux netbsd openbsd solaris,$(TARGET_OS)),)
  RTLIB_DIRS += $(srcdir)/rtlib/unix
endif
GFXLIB2_DIRS := $(patsubst $(srcdir)/rtlib%,$(srcdir)/gfxlib2%,$(RTLIB_DIRS))

LIBFB_H := $(sort $(foreach i,$(RTLIB_DIRS),$(wildcard $(i)/*.h)))
LIBFB_C := $(sort $(foreach i,$(RTLIB_DIRS),$(patsubst $(i)/%.c,$(libfbobjdir)/%.o,$(wildcard $(i)/*.c))))
LIBFB_S := $(sort $(foreach i,$(RTLIB_DIRS),$(patsubst $(i)/%.s,$(libfbobjdir)/%.o,$(wildcard $(i)/*.s))))
LIBFBPIC_C   := $(patsubst $(libfbobjdir)/%,$(libfbpicobjdir)/%,$(LIBFB_C))
LIBFBMT_C    := $(patsubst $(libfbobjdir)/%,$(libfbmtobjdir)/%,$(LIBFB_C))
LIBFBMT_S    := $(patsubst $(libfbobjdir)/%,$(libfbmtobjdir)/%,$(LIBFB_S))
LIBFBMTPIC_C := $(patsubst $(libfbobjdir)/%,$(libfbmtpicobjdir)/%,$(LIBFB_C))

LIBFBGFX_H := $(sort $(foreach i,$(GFXLIB2_DIRS),$(wildcard $(i)/*.h)) $(LIBFB_H))
LIBFBGFX_C := $(sort $(foreach i,$(GFXLIB2_DIRS),$(patsubst $(i)/%.c,$(libfbgfxobjdir)/%.o,$(wildcard $(i)/*.c))))
LIBFBGFX_S := $(sort $(foreach i,$(GFXLIB2_DIRS),$(patsubst $(i)/%.s,$(libfbgfxobjdir)/%.o,$(wildcard $(i)/*.s))))
LIBFBGFXPIC_C   := $(patsubst $(libfbgfxobjdir)/%,$(libfbgfxpicobjdir)/%,$(LIBFBGFX_C))
LIBFBGFXMT_C    := $(patsubst $(libfbgfxobjdir)/%,$(libfbgfxmtobjdir)/%,$(LIBFBGFX_C))
LIBFBGFXMT_S    := $(patsubst $(libfbgfxobjdir)/%,$(libfbgfxmtobjdir)/%,$(LIBFBGFX_S))
LIBFBGFXMTPIC_C := $(patsubst $(libfbgfxobjdir)/%,$(libfbgfxmtpicobjdir)/%,$(LIBFBGFX_C))

RTL_OBJDIRS := $(libfbobjdir)
GFX_OBJDIRS := $(libfbgfxobjdir)
RTL_LIBS := $(libdir)/$(FB_LDSCRIPT) $(libdir)/fbrt0.o $(libdir)/libfb.a
GFX_LIBS := $(libdir)/libfbgfx.a
ifdef ENABLE_PIC
  RTL_OBJDIRS += $(libfbpicobjdir)
  GFX_OBJDIRS += $(libfbgfxpicobjdir)
  RTL_LIBS += $(libdir)/fbrt0pic.o $(libdir)/libfbpic.a
  GFX_LIBS += $(libdir)/libfbgfxpic.a
endif
ifndef DISABLE_MT
  RTL_OBJDIRS += $(libfbmtobjdir)
  GFX_OBJDIRS += $(libfbgfxmtobjdir)
  RTL_LIBS += $(libdir)/libfbmt.a
  GFX_LIBS += $(libdir)/libfbgfxmt.a
  ifdef ENABLE_PIC
    RTL_OBJDIRS += $(libfbmtpicobjdir)
    GFX_OBJDIRS += $(libfbgfxmtpicobjdir)
    RTL_LIBS += $(libdir)/libfbmtpic.a
    GFX_LIBS += $(libdir)/libfbgfxmtpic.a
  endif
endif
ifeq ($(TARGET_OS),dos)
  RTL_OBJDIRS += $(djgpplibcobjdir)
  RTL_LIBS += $(libdir)/libc.a
endif

#
# Build rules
#

VPATH = $(RTLIB_DIRS) $(GFXLIB2_DIRS)

# We don't want to use any of make's built-in suffixes/rules
.SUFFIXES:

ifndef V
  QUIET_FBC   = @echo "FBC $@";
  QUIET_LINK  = @echo "LINK $@";
  QUIET_CC    = @echo "CC $@";
  QUIET_CPPAS = @echo "CPPAS $@";
  QUIET_AR    = @echo "AR $@";
  QUIET       = @
endif

################################################################################

.PHONY: all
all: compiler rtlib gfxlib2

$(fbcobjdir) \
$(libfbobjdir) \
$(libfbpicobjdir) \
$(libfbmtobjdir) \
$(libfbmtpicobjdir) \
$(libfbgfxobjdir) \
$(libfbgfxpicobjdir) \
$(libfbgfxmtobjdir) \
$(libfbgfxmtpicobjdir) \
$(djgpplibcobjdir) \
bin $(libdir) $(prefixbindir) $(prefixincdir) $(prefixlibdir):
	mkdir -p $@

################################################################################

.PHONY: compiler
compiler: bin $(fbcobjdir) $(FBC_EXE)

$(FBC_EXE): $(FBC_BAS)
	$(QUIET_LINK)$(FBC) $(ALLFBLFLAGS) -x $(FBCNEW_EXE) $^
	$(QUIET)mv $(FBCNEW_EXE) $@

$(FBC_BAS): $(fbcobjdir)/%.o: $(srcdir)/compiler/%.bas $(FBC_BI)
	$(QUIET_FBC)$(FBC) $(ALLFBCFLAGS) -c $< -o $@

################################################################################

.PHONY: rtlib
rtlib: $(libdir) $(RTL_OBJDIRS) $(RTL_LIBS)

$(libdir)/fbextra.x: $(rootdir)lib/fbextra.x
	cp $< $@

$(libdir)/i386go32.x: $(rootdir)contrib/djgpp/i386go32.x
	cp $< $@

$(libdir)/fbrt0.o: $(srcdir)/rtlib/static/fbrt0.c $(LIBFB_H)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@

$(libdir)/fbrt0pic.o: $(srcdir)/rtlib/static/fbrt0.c $(LIBFB_H)
	$(QUIET_CC)$(CC) -fPIC $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfb.a: $(LIBFB_C) $(LIBFB_S)
ifeq ($(TARGET_OS),dos)
  # Avoid hitting the command line length limit (the libfb.a ar command line
  # is very long...)
	$(QUIET_AR)$(AR) rcs $@ $(libfbobjdir)/*.o
else
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
endif
$(LIBFB_C): $(libfbobjdir)/%.o: %.c $(LIBFB_H)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@
$(LIBFB_S): $(libfbobjdir)/%.o: %.s $(LIBFB_H)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbpic.a: $(LIBFBPIC_C)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBPIC_C): $(libfbpicobjdir)/%.o: %.c $(LIBFB_H)
	$(QUIET_CC)$(CC) -fPIC $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbmt.a: $(LIBFBMT_C) $(LIBFBMT_S)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBMT_C): $(libfbmtobjdir)/%.o: %.c $(LIBFB_H)
	$(QUIET_CC)$(CC) -DENABLE_MT $(ALLCFLAGS) -c $< -o $@
$(LIBFBMT_S): $(libfbmtobjdir)/%.o: %.s $(LIBFB_H)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp -DENABLE_MT $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbmtpic.a: $(LIBFBMTPIC_C)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBMTPIC_C): $(libfbmtpicobjdir)/%.o: %.c $(LIBFB_H)
	$(QUIET_CC)$(CC) -DENABLE_MT -fPIC $(ALLCFLAGS) -c $< -o $@

ifeq ($(TARGET_OS),dos)
djgpplibc := $(shell $(CC) -print-file-name=libc.a)
libcmaino := $(djgpplibcobjdir)/_main.o
$(libcmaino): $(rootdir)contrib/djgpp/libc/crt0/_main.c
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@
$(libdir)/libc.a: $(djgpplibc) $(libcmaino)
	cp $(djgpplibc) $@
	$(QUIET_AR)ar rs $@ $(libcmaino)
endif

################################################################################

.PHONY: gfxlib2
gfxlib2: $(libdir) $(GFX_OBJDIRS) $(GFX_LIBS)

$(libdir)/libfbgfx.a: $(LIBFBGFX_C) $(LIBFBGFX_S)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBGFX_C): $(libfbgfxobjdir)/%.o: %.c $(LIBFBGFX_H)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@
$(LIBFBGFX_S): $(libfbgfxobjdir)/%.o: %.s $(LIBFBGFX_H)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbgfxpic.a: $(LIBFBGFXPIC_C)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBGFXPIC_C): $(libfbgfxpicobjdir)/%.o: %.c $(LIBFBGFX_H)
	$(QUIET_CC)$(CC) -fPIC $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbgfxmt.a: $(LIBFBGFXMT_C) $(LIBFBGFXMT_S)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBGFXMT_C): $(libfbgfxmtobjdir)/%.o: %.c $(LIBFBGFX_H)
	$(QUIET_CC)$(CC) -DENABLE_MT $(ALLCFLAGS) -c $< -o $@
$(LIBFBGFXMT_S): $(libfbgfxmtobjdir)/%.o: %.s $(LIBFBGFX_H)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp -DENABLE_MT $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbgfxmtpic.a: $(LIBFBGFXMTPIC_C)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBGFXMTPIC_C): $(libfbgfxmtpicobjdir)/%.o: %.c $(LIBFBGFX_H)
	$(QUIET_CC)$(CC) -DENABLE_MT -fPIC $(ALLCFLAGS) -c $< -o $@

################################################################################

.PHONY: install install-compiler install-includes install-rtlib install-gfxlib2
install:        install-compiler install-includes install-rtlib install-gfxlib2

install-compiler: $(prefixbindir)
	$(INSTALL_PROGRAM) $(FBC_EXE) $(PREFIX_FBC_EXE)

install-includes: $(prefixincdir)
	cp -r $(rootdir)inc/* $(prefixincdir)

install-rtlib: $(prefixlibdir)
	$(INSTALL_FILE) $(RTL_LIBS) $(prefixlibdir)/

install-gfxlib2: $(prefix)/lib $(prefixlibdir)
	$(INSTALL_FILE) $(GFX_LIBS) $(prefixlibdir)/

################################################################################

.PHONY: uninstall uninstall-compiler uninstall-includes uninstall-rtlib uninstall-gfxlib2
uninstall:        uninstall-compiler uninstall-includes uninstall-rtlib uninstall-gfxlib2
	-rmdir $(prefixlibdir)

uninstall-compiler:
	rm -f $(PREFIX_FBC_EXE)

uninstall-includes:
	rm -rf $(prefixincdir)

uninstall-rtlib:
	rm -f $(patsubst $(libdir)/%,$(prefixlibdir)/%,$(RTL_LIBS))

uninstall-gfxlib2:
	rm -f $(patsubst $(libdir)/%,$(prefixlibdir)/%,$(GFX_LIBS))

################################################################################

.PHONY: clean clean-compiler clean-rtlib clean-gfxlib2
clean:        clean-compiler clean-rtlib clean-gfxlib2

clean-compiler:
	rm -rf $(FBC_EXE) $(fbcobjdir)
  ifndef ENABLE_STANDALONE
	-rmdir bin
  endif

clean-rtlib:
	rm -rf $(RTL_LIBS) $(RTL_OBJDIRS)

clean-gfxlib2:
	rm -rf $(GFX_LIBS) $(GFX_OBJDIRS)

################################################################################

.PHONY: help
help:
	@echo "Take a look at the top of this makefile!"

################################################################################

.PHONY: cunit-tests log-tests clean-tests

cunit-tests:
	cd tests && make cunit-tests FBC="`pwd`/../bin/fbc -i `pwd`/../inc"

log-tests:
	cd tests && make   log-tests FBC="`pwd`/../bin/fbc -i `pwd`/../inc"

warning-tests:
	cd tests/warnings && make FBC="`pwd`/../../bin/fbc"

clean-tests:
	cd tests && make clean


################################################################################

FBSOURCETITLE = FreeBASIC-$(FBVERSION)-source

.PHONY: gitdist
gitdist:
	# (using git archive --prefix ... to avoid tarbombs)
	# .tar.gz and .tar.xz, with LF line endings
	git -c core.autocrlf=false archive --format tar --prefix "$(FBSOURCETITLE)/" HEAD | tar xf -
	tar -czf "$(FBSOURCETITLE).tar.gz" "$(FBSOURCETITLE)"
	tar -cJf "$(FBSOURCETITLE).tar.xz" "$(FBSOURCETITLE)"
	rm -rf "$(FBSOURCETITLE)"

	# .zip with low word size/fast bytes setting (for DOS), and .7z, with CRLF line endings
	git -c core.autocrlf=true archive --format tar --prefix "$(FBSOURCETITLE)/" HEAD | tar xf -
	zip -q -r "$(FBSOURCETITLE).zip" "$(FBSOURCETITLE)"
	7z a      "$(FBSOURCETITLE).7z"  "$(FBSOURCETITLE)" > /dev/null
	rm -rf "$(FBSOURCETITLE)"

#
# Traditionally, the FB release package names depend on whether its a normal or
# standalone build and on the platform. The "FreeBASIC-x.xx.x-target" name
# format is traditionally used for the "default" builds for the respective
# platform.
#
# Linux/BSD standalone = FreeBASIC-x.xx.x-target-standalone
# Linux/BSD normal     = FreeBASIC-x.xx.x-target
# Windows/DOS standalone = FreeBASIC-x.xx.x-target
# Windows/DOS normal     = fbc-x.xx.x-target (MinGW/DJGPP-style packages)
#
ifndef FBPACKAGE
  ifneq ($(filter darwin freebsd linux netbsd openbsd solaris,$(TARGET_OS)),)
    ifdef ENABLE_STANDALONE
      FBPACKAGE := FreeBASIC-$(FBVERSION)-$(FBTARGET)-standalone
    else
      FBPACKAGE := FreeBASIC-$(FBVERSION)-$(FBTARGET)
    endif
  else
    ifdef ENABLE_STANDALONE
      FBPACKAGE := FreeBASIC-$(FBVERSION)-$(FBTARGET)
    else
      FBPACKAGE := fbc-$(FBVERSION)-$(FBTARGET)
    endif
  endif
endif

FBPACKAGE := $(FBPACKAGE)$(FBPACKSUFFIX)

ifndef FBMANIFEST
  FBMANIFEST := $(subst -$(FBVERSION),,$(FBPACKAGE))
endif

.PHONY: bindist
bindist:
	# Extra directory in which we'll put together the binary release package
	# (needed anyways to avoid tarbombs)
	mkdir $(FBPACKAGE)

	# Binaries from the build dir: fbc[.exe] or bin/fbc[.exe], bin/ and lib/
	# (we're expecting bin/ and lib/ to be filled with the proper external
	# binaries already in case of standalone setups)
	cp -R bin lib $(FBPACKAGE)
  ifdef ENABLE_STANDALONE
	cp $(FBC_EXE) $(FBPACKAGE)
  endif

	# Remove lib/win32/*.def stuff. We have it in the source tree (not in
	# build dir if separate though) but don't want to include it into the
	# binary release packages.
	cd $(FBPACKAGE) && rm -rf lib/win32/*.def lib/win32/makefile lib/fbextra.x
	rmdir $(FBPACKAGE)/lib/win32 || true

	# Includes: inc/, include/freebasic/ or include/freebas/
	cp -R $(rootdir)inc $(FBPACKAGE)
  ifeq ($(TARGET_OS),dos)
	rm -r $(FBPACKAGE)/inc/AL
	rm -r $(FBPACKAGE)/inc/atk
	rm -r $(FBPACKAGE)/inc/bass.bi
	rm -r $(FBPACKAGE)/inc/bassmod.bi
	rm -r $(FBPACKAGE)/inc/cairo
	rm -r $(FBPACKAGE)/inc/cd
	rm -r $(FBPACKAGE)/inc/chipmunk
	rm -r $(FBPACKAGE)/inc/crt/arpa
	rm -r $(FBPACKAGE)/inc/crt/bits
	rm -r $(FBPACKAGE)/inc/crt/linux
	rm -r $(FBPACKAGE)/inc/crt/netdb.bi
	rm -r $(FBPACKAGE)/inc/crt/netinet/in.bi
	rm -r $(FBPACKAGE)/inc/crt/netinet/linux/in.bi
	rm -r $(FBPACKAGE)/inc/crt/sys/linux
	rm -r $(FBPACKAGE)/inc/crt/sys/socket.bi
	rm -r $(FBPACKAGE)/inc/crt/sys/win32
	rm -r $(FBPACKAGE)/inc/crt/win32
	rm -r $(FBPACKAGE)/inc/curses/ncurses.bi
	rm -r $(FBPACKAGE)/inc/disphelper
	rm -r $(FBPACKAGE)/inc/fastcgi
	rm -r $(FBPACKAGE)/inc/flite
	rm -r $(FBPACKAGE)/inc/fmod.bi
	rm -r $(FBPACKAGE)/inc/FreeImage.bi
	rm -r $(FBPACKAGE)/inc/freetype2
	rm -r $(FBPACKAGE)/inc/gdk*
	rm -r $(FBPACKAGE)/inc/gio
	rm -r $(FBPACKAGE)/inc/GL
	rm -r $(FBPACKAGE)/inc/glade
	rm -r $(FBPACKAGE)/inc/glib*
	rm -r $(FBPACKAGE)/inc/gmodule.bi
	rm -r $(FBPACKAGE)/inc/goocanvas.bi
	rm -r $(FBPACKAGE)/inc/gtk*
	rm -r $(FBPACKAGE)/inc/im
	rm -r $(FBPACKAGE)/inc/IUP*
	rm -r $(FBPACKAGE)/inc/japi*
	rm -r $(FBPACKAGE)/inc/jni.bi
	rm -r $(FBPACKAGE)/inc/json*
	rm -r $(FBPACKAGE)/inc/libart_lgpl
	rm -r $(FBPACKAGE)/inc/MediaInfo*
	rm -r $(FBPACKAGE)/inc/modplug.bi
	rm -r $(FBPACKAGE)/inc/mpg123.bi
	rm -r $(FBPACKAGE)/inc/mysql
	rm -r $(FBPACKAGE)/inc/Newton.bi
	rm -r $(FBPACKAGE)/inc/ode
	rm -r $(FBPACKAGE)/inc/ogg
	rm -r $(FBPACKAGE)/inc/pango
	rm -r $(FBPACKAGE)/inc/pdflib.bi
	rm -r $(FBPACKAGE)/inc/portaudio.bi
	rm -r $(FBPACKAGE)/inc/postgresql
	rm -r $(FBPACKAGE)/inc/SDL
	rm -r $(FBPACKAGE)/inc/sndfile.bi
	rm -r $(FBPACKAGE)/inc/spidermonkey
	rm -r $(FBPACKAGE)/inc/uuid.bi
	rm -r $(FBPACKAGE)/inc/vlc
	rm -r $(FBPACKAGE)/inc/vorbis
	rm -r $(FBPACKAGE)/inc/win
	rm -r $(FBPACKAGE)/inc/windows.bi
	rm -r $(FBPACKAGE)/inc/wx-c
	rm -r $(FBPACKAGE)/inc/X11
	rm -r $(FBPACKAGE)/inc/xmp.bi
	rm -r $(FBPACKAGE)/inc/zmq
  endif
  ifeq ($(TARGET_ARCH),x86_64)
	# Exclude headers which don't support 64bit yet
	rm -r $(FBPACKAGE)/inc/AL
	rm -r $(FBPACKAGE)/inc/aspell.bi
	rm -r $(FBPACKAGE)/inc/atk
	rm -r $(FBPACKAGE)/inc/bass.bi
	rm -r $(FBPACKAGE)/inc/bassmod.bi
	rm -r $(FBPACKAGE)/inc/bfd
	rm -r $(FBPACKAGE)/inc/bfd.bi
	rm -r $(FBPACKAGE)/inc/big_int
	rm -r $(FBPACKAGE)/inc/bzlib.bi
	rm -r $(FBPACKAGE)/inc/caca0.bi
	rm -r $(FBPACKAGE)/inc/caca.bi
	rm -r $(FBPACKAGE)/inc/cairo
	rm -r $(FBPACKAGE)/inc/cd
	rm -r $(FBPACKAGE)/inc/cgi-util.bi
	rm -r $(FBPACKAGE)/inc/chipmunk
	rm -r $(FBPACKAGE)/inc/cryptlib.bi
	rm -r $(FBPACKAGE)/inc/dislin.bi
	rm -r $(FBPACKAGE)/inc/disphelper
	rm -r $(FBPACKAGE)/inc/dos
	rm -r $(FBPACKAGE)/inc/expat.bi
	rm -r $(FBPACKAGE)/inc/fastcgi
	rm -r $(FBPACKAGE)/inc/flite
	rm -r $(FBPACKAGE)/inc/FreeImage.bi
	rm -r $(FBPACKAGE)/inc/freetype2
	rm -r $(FBPACKAGE)/inc/gd.bi
	rm -r $(FBPACKAGE)/inc/gdbm.bi
	rm -r $(FBPACKAGE)/inc/gdk
	rm -r $(FBPACKAGE)/inc/gdk-pixbuf
	rm -r $(FBPACKAGE)/inc/gdsl
	rm -r $(FBPACKAGE)/inc/gettext-po.bi
	rm -r $(FBPACKAGE)/inc/gif_lib.bi
	rm -r $(FBPACKAGE)/inc/gio
	rm -r $(FBPACKAGE)/inc/GL
	rm -r $(FBPACKAGE)/inc/glade
	rm -r $(FBPACKAGE)/inc/glib.bi
	rm -r $(FBPACKAGE)/inc/glibconfig.bi
	rm -r $(FBPACKAGE)/inc/glib-object.bi
	rm -r $(FBPACKAGE)/inc/gmodule.bi
	rm -r $(FBPACKAGE)/inc/gmp.bi
	rm -r $(FBPACKAGE)/inc/goocanvas.bi
	rm -r $(FBPACKAGE)/inc/grx
	rm -r $(FBPACKAGE)/inc/gsl
	rm -r $(FBPACKAGE)/inc/gtk
	rm -r $(FBPACKAGE)/inc/gtkgl
	rm -r $(FBPACKAGE)/inc/IL
	rm -r $(FBPACKAGE)/inc/im
	rm -r $(FBPACKAGE)/inc/japi.bi
	rm -r $(FBPACKAGE)/inc/jni.bi
	rm -r $(FBPACKAGE)/inc/jpeglib.bi
	rm -r $(FBPACKAGE)/inc/jpgalleg.bi
	rm -r $(FBPACKAGE)/inc/json-c
	rm -r $(FBPACKAGE)/inc/libart_lgpl
	rm -r $(FBPACKAGE)/inc/libintl.bi
	rm -r $(FBPACKAGE)/inc/libxml
	rm -r $(FBPACKAGE)/inc/libxslt
	rm -r $(FBPACKAGE)/inc/lzma.bi
	rm -r $(FBPACKAGE)/inc/lzo
	rm -r $(FBPACKAGE)/inc/MediaInfo.bi
	rm -r $(FBPACKAGE)/inc/modplug.bi
	rm -r $(FBPACKAGE)/inc/mpg123.bi
	rm -r $(FBPACKAGE)/inc/mxml.bi
	rm -r $(FBPACKAGE)/inc/mysql
	rm -r $(FBPACKAGE)/inc/Newton.bi
	rm -r $(FBPACKAGE)/inc/ode
	rm -r $(FBPACKAGE)/inc/ogg
	rm -r $(FBPACKAGE)/inc/pango
	rm -r $(FBPACKAGE)/inc/pcre16.bi
	rm -r $(FBPACKAGE)/inc/pcre.bi
	rm -r $(FBPACKAGE)/inc/pcreposix.bi
	rm -r $(FBPACKAGE)/inc/pdflib.bi
	rm -r $(FBPACKAGE)/inc/portaudio.bi
	rm -r $(FBPACKAGE)/inc/postgresql
	rm -r $(FBPACKAGE)/inc/quicklz.bi
	rm -r $(FBPACKAGE)/inc/regex.bi
	rm -r $(FBPACKAGE)/inc/SDL
	rm -r $(FBPACKAGE)/inc/sndfile.bi
	rm -r $(FBPACKAGE)/inc/spidermonkey
	rm -r $(FBPACKAGE)/inc/sqlite2.bi
	rm -r $(FBPACKAGE)/inc/sqlite3.bi
	rm -r $(FBPACKAGE)/inc/sqlite3ext.bi
	rm -r $(FBPACKAGE)/inc/tinyptc.bi
	rm -r $(FBPACKAGE)/inc/uuid.bi
	rm -r $(FBPACKAGE)/inc/vlc
	rm -r $(FBPACKAGE)/inc/vorbis
	rm -r $(FBPACKAGE)/inc/win
	rm -r $(FBPACKAGE)/inc/windows.bi
	rm -r $(FBPACKAGE)/inc/wx-c
	rm -r $(FBPACKAGE)/inc/X11
	rm -r $(FBPACKAGE)/inc/xmp.bi
	rm -r $(FBPACKAGE)/inc/zmq
  endif
  ifndef ENABLE_STANDALONE
	mkdir -p $(FBPACKAGE)/include
    ifeq ($(TARGET_OS),dos)
	mv $(FBPACKAGE)/inc $(FBPACKAGE)/include/freebas
    else
	mv $(FBPACKAGE)/inc $(FBPACKAGE)/include/freebasic
    endif
  endif

  ifndef DISABLE_DOCS
	# Docs
	cp $(rootdir)changelog.txt $(rootdir)readme.txt $(FBPACKAGE)
	mkdir $(FBPACKAGE)/doc
	cp $(rootdir)doc/fbc.1 $(rootdir)doc/gpl.txt $(rootdir)doc/lgpl.txt $(FBPACKAGE)/doc
    ifneq ($(filter win32 win64,$(TARGET_OS)),)
      ifdef ENABLE_STANDALONE
	cp $(rootdir)doc/GoRC.txt $(rootdir)doc/libffi-license.txt $(FBPACKAGE)/doc
      endif
    endif

	# Examples
	cp -R $(rootdir)examples $(FBPACKAGE)
    ifeq ($(TARGET_OS),dos)
	rm -r $(FBPACKAGE)/examples/database/mysql_test.bas
	rm -r $(FBPACKAGE)/examples/database/postgresql_test.bas
	rm -r $(FBPACKAGE)/examples/dll
	rm -r $(FBPACKAGE)/examples/files/FreeImage
	rm -r $(FBPACKAGE)/examples/files/pdflib
	rm -r $(FBPACKAGE)/examples/graphics/cairo
	rm -r $(FBPACKAGE)/examples/graphics/FreeType
	rm -r $(FBPACKAGE)/examples/graphics/OpenGL
	rm -r $(FBPACKAGE)/examples/graphics/SDL
	rm -r $(FBPACKAGE)/examples/GUI/GTK+
	rm -r $(FBPACKAGE)/examples/GUI/IUP
	rm -r $(FBPACKAGE)/examples/GUI/win32
	rm -r $(FBPACKAGE)/examples/GUI/wx-c
	rm -r $(FBPACKAGE)/examples/manual/threads
	rm -r $(FBPACKAGE)/examples/math/cryptlib
	rm -r $(FBPACKAGE)/examples/math/Newton
	rm -r $(FBPACKAGE)/examples/math/ODE
	rm -r $(FBPACKAGE)/examples/misc/glib
	rm -r $(FBPACKAGE)/examples/network/http-get.bas
	rm -r $(FBPACKAGE)/examples/network/win32
	rm -r $(FBPACKAGE)/examples/other-languages/Java*
	rm -r $(FBPACKAGE)/examples/other-languages/VB
	rm -r $(FBPACKAGE)/examples/sound
	rm -r $(FBPACKAGE)/examples/threads
	rm -r $(FBPACKAGE)/examples/unicode
	rm -r $(FBPACKAGE)/examples/win32
    endif
  endif

	# install.sh for normal Linux/BSD setups
  ifndef ENABLE_STANDALONE
    ifneq ($(filter darwin freebsd linux netbsd openbsd solaris,$(TARGET_OS)),)
	cp $(rootdir)install.sh $(FBPACKAGE)
    endif
  endif

	# Regenerate the manifest in the source tree, based on the package directory content
	find $(FBPACKAGE) -type f | LC_ALL=C sort \
		| sed -e 's,^$(FBPACKAGE)/,,g' \
		> $(rootdir)contrib/manifest/$(FBMANIFEST).lst

	# Create the archive(s)
	# (overwriting existing ones, instead of adding to them)
  ifeq ($(TARGET_OS),dos)
	rm -f $(FBPACKAGE).zip
	zip -q -r $(FBPACKAGE).zip $(FBPACKAGE)
  else
  ifneq ($(filter win32 win64,$(TARGET_OS)),)
	rm -f $(FBPACKAGE).zip
	rm -f $(FBPACKAGE).7z
	zip -q -r $(FBPACKAGE).zip $(FBPACKAGE)
	7z a $(FBPACKAGE).7z  $(FBPACKAGE) > /dev/null
  else
	rm -f $(FBPACKAGE).tar.gz
	rm -f $(FBPACKAGE).tar.xz
	tar -czf $(FBPACKAGE).tar.gz $(FBPACKAGE)
	tar -cJf $(FBPACKAGE).tar.xz $(FBPACKAGE)
  endif
  endif

	# Clean up
	rm -rf $(FBPACKAGE)

ifdef ENABLE_STANDALONE
ifeq ($(TARGET_OS),win32)

mingwlibs += crtbegin.o
mingwlibs += crtend.o
mingwlibs += crt2.o
mingwlibs += dllcrt2.o
mingwlibs += gcrt2.o
mingwlibs += libgcc.a
mingwlibs += libmingw32.a
mingwlibs += libmingwex.a
mingwlibs += libmoldname.a
mingwlibs += libsupc++.a
mingwlibs += libstdc++.a
mingwlibs += libgmon.a

winapilibsignore += -e libdelayimp
winapilibsignore += -e libgcc
winapilibsignore += -e libgmon
winapilibsignore += -e libiconv
winapilibsignore += -e liblargeint
winapilibsignore += -e 'libm\.a$$'
winapilibsignore += -e libmangle
winapilibsignore += -e libmingw
winapilibsignore += -e libmoldname
winapilibsignore += -e libpseh
winapilibsignore += -e libpthread
winapilibsignore += -e libwinpthread
winapilibsignore += -e 'libz\.a$$'

.PHONY: mingw-libs
mingw-libs:
	# MinGW/CRT libs
	for i in $(mingwlibs); do \
		cp `$(CC) -print-file-name=$$i` $(libdir); \
	done

	# libgcc_eh.a too, if it exists (TDM-GCC doesn't have it)
	libgcc_eh=`$(CC) -print-file-name=libgcc_eh.a`; \
		if [ -f "$$libgcc_eh" ]; then \
			cp "$$libgcc_eh" $(libdir); \
		fi

	# Windows API libs
	#  * copy all lib*.a files from the directory of libkernel32.a
	#  * renaming lib*.a to lib*.dll.a - this isn't 100% correct, because
	#    all libs really are import libs, but it follows FB tradition.
	#  * Filtering out some libs which are included in MinGW toolchains
	#    sometimes, but we don't want (e.g. libpthread).
	dir=$$(dirname $$($(CC) -print-file-name=libkernel32.a)); \
		ls $$dir/lib*.a | grep -v $(winapilibsignore) | while read i; do \
			cp $$i $(libdir)/`basename $$i | sed -e 's/\.a$$/.dll.a/g'`; \
		done

endif
endif
