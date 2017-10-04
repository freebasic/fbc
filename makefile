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
#   bindist    Create binary FB release packages from current build directory content
#   mingw-libs Standalone: Copy libraries from MinGW toolchain into lib/win32/ etc.
#
#   cunit-tests  (Convenience wrappers around tests/Makefile, running the tests
#   log-tests     using the newly built fbc)
#   warning-tests
#   clean-tests
#
#   bootstrap-dist  Create source package with precompiled fbc sources
#   bootstrap       Build fbc from the precompiled sources (only if precompiled sources exist)
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
#   ENABLE_PREFIX=1        use "-d ENABLE_PREFIX=$(prefix)" to hard-code the prefix into fbc
#   ENABLE_SUFFIX=-0.24    append a string like "-0.24" to fbc/FB dir names,
#                          and use "-d ENABLE_SUFFIX=$(ENABLE_SUFFIX)" (non-standalone only)
#   ENABLE_LIB64=1         use prefix/lib64/ instead of prefix/lib/ for 64bit libs (non-standalone only)
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
#   -d ENABLE_LIB64          use prefix/lib64/ instead of prefix/lib/ for 64bit libs (non-standalone only)
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

FBC := fbc
CFLAGS := -Wfatal-errors -O2
# Avoid gcc exception handling bloat
CFLAGS += -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables
FBFLAGS := -maxerr 1
AS = $(TARGET_PREFIX)as
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
    else ifneq ($(filter darwin%,$(triplet)),)
      TARGET_OS := darwin
    else ifneq ($(filter djgpp%,$(triplet)),)
      TARGET_OS := dos
    else ifneq ($(filter msdos%,$(triplet)),)
      TARGET_OS := dos
    else ifneq ($(filter freebsd%,$(triplet)),)
      TARGET_OS := freebsd
    else ifneq ($(filter linux%,$(triplet)),)
      TARGET_OS := linux
    else ifneq ($(filter mingw%,$(triplet)),)
      TARGET_OS := win32
    else ifneq ($(filter netbsd%,$(triplet)),)
      TARGET_OS := netbsd
    else ifneq ($(filter openbsd%,$(triplet)),)
      TARGET_OS := openbsd
    else ifneq ($(filter solaris%,$(triplet)),)
      TARGET_OS := solaris
    else ifneq ($(filter xbox%,$(triplet)),)
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
    else ifeq ($(uname),Darwin)
      TARGET_OS := darwin
    else ifeq ($(uname),FreeBSD)
      TARGET_OS := freebsd
    else ifeq ($(uname),Linux)
      TARGET_OS := linux
    else ifneq ($(findstring MINGW,$(uname)),)
      TARGET_OS := win32
    else ifeq ($(uname),MS-DOS)
      TARGET_OS := dos
    else ifeq ($(uname),NetBSD)
      TARGET_OS := netbsd
    else ifeq ($(uname),OpenBSD)
      TARGET_OS := openbsd
    else ifeq ($(uname),SunOS)
      TARGET_OS := solaris
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
else ifeq ($(MULTILIB),64)
  ifeq ($(TARGET_ARCH),x86)
    TARGET_ARCH := x86_64
  endif
endif

ifeq ($(TARGET_OS),dos)
  FBNAME := freebas$(ENABLE_SUFFIX)
  FB_LDSCRIPT := i386go32.x
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
else ifeq ($(TARGET_OS),xbox)
  FBTARGET := xbox
else ifeq ($(TARGET_OS),win32)
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
  # Traditional standalone layout: fbc.exe at toplevel, libs in lib/<fbtarget>/,
  # includes in inc/
  FBC_EXE     := fbc$(EXEEXT)
  FBCNEW_EXE  := fbc-new$(EXEEXT)
  libdir         := lib/$(libsubdir)
  PREFIX_FBC_EXE := $(prefix)/fbc$(EXEEXT)
  prefixbindir   := $(prefix)
  prefixincdir   := $(prefix)/inc
  prefixlibdir   := $(prefix)/$(libdir)
else
  # With ENABLE_LIB64, put 64bit libs into
  #    lib64/freebasic/<fbtarget>/
  # instead of the default
  #    lib/freebasic/<fbtarget>/
  libdirname := lib
  ifdef ENABLE_LIB64
    ifneq ($(filter x86_64 aarch64,$(TARGET_ARCH)),)
      libdirname := lib64
    endif
  endif

  # Normal (non-standalone) setup: bin/fbc, include/freebasic/, lib[64]/freebasic/<fbtarget>/.
  FBC_EXE     := bin/fbc$(ENABLE_SUFFIX)$(EXEEXT)
  FBCNEW_EXE  := bin/fbc$(ENABLE_SUFFIX)-new$(EXEEXT)
  libdir         := $(libdirname)/$(FBNAME)/$(libsubdir)
  PREFIX_FBC_EXE := $(prefix)/bin/fbc$(ENABLE_SUFFIX)$(EXEEXT)
  prefixbindir   := $(prefix)/bin
  prefixincdir   := $(prefix)/include/$(FBNAME)
  prefixlibdir   := $(prefix)/$(libdir)
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

ifeq ($(TARGET_OS),netbsd)
  ALLCFLAGS += -I/usr/X11R7/include \
    -I/usr/pkg/include
endif

ifeq ($(TARGET_OS),darwin)
  ALLCFLAGS += -I/opt/X11/include -I/usr/include/ffi
  
  ifdef ENABLE_XQUARTZ
    ALLFBCFLAGS += -d ENABLE_XQUARTZ
  else
    ALLCFLAGS += -DDISABLE_X11
  endif
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
ifdef ENABLE_LIB64
  ALLFBCFLAGS += -d ENABLE_LIB64
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

RTL_LIBS := $(libdir)/$(FB_LDSCRIPT) $(libdir)/fbrt0.o $(libdir)/libfb.a
GFX_LIBS := $(libdir)/libfbgfx.a
ifdef ENABLE_PIC
  RTL_LIBS += $(libdir)/fbrt0pic.o $(libdir)/libfbpic.a
  GFX_LIBS += $(libdir)/libfbgfxpic.a
endif
ifndef DISABLE_MT
  RTL_LIBS += $(libdir)/libfbmt.a
  GFX_LIBS += $(libdir)/libfbgfxmt.a
  ifdef ENABLE_PIC
    RTL_LIBS += $(libdir)/libfbmtpic.a
    GFX_LIBS += $(libdir)/libfbgfxmtpic.a
  endif
endif
ifeq ($(TARGET_OS),dos)
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
  QUIET_AS    = @echo "AS $@";
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
bin $(libdir):
	mkdir -p $@

################################################################################

.PHONY: compiler
compiler: $(FBC_EXE)

$(FBC_EXE): $(FBC_BAS) | bin
	$(QUIET_LINK)$(FBC) $(ALLFBLFLAGS) -x $(FBCNEW_EXE) $^
	$(QUIET)mv $(FBCNEW_EXE) $@

$(FBC_BAS): $(fbcobjdir)/%.o: $(srcdir)/compiler/%.bas $(FBC_BI) | $(fbcobjdir)
	$(QUIET_FBC)$(FBC) $(ALLFBCFLAGS) -c $< -o $@

################################################################################

.PHONY: rtlib
rtlib: $(RTL_LIBS)

$(libdir)/fbextra.x: $(rootdir)lib/fbextra.x | $(libdir)
	cp $< $@

$(libdir)/i386go32.x: $(rootdir)contrib/djgpp/i386go32.x | $(libdir)
	cp $< $@

$(libdir)/fbrt0.o: $(srcdir)/rtlib/static/fbrt0.c $(LIBFB_H) | $(libdir)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@

$(libdir)/fbrt0pic.o: $(srcdir)/rtlib/static/fbrt0.c $(LIBFB_H) | $(libdir)
	$(QUIET_CC)$(CC) -fPIC $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfb.a: $(LIBFB_C) $(LIBFB_S) | $(libdir)
ifeq ($(TARGET_OS),dos)
  # Avoid hitting the command line length limit (the libfb.a ar command line
  # is very long...)
	$(QUIET_AR)$(AR) rcs $@ $(libfbobjdir)/*.o
else
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
endif
$(LIBFB_C): $(libfbobjdir)/%.o: %.c $(LIBFB_H) | $(libfbobjdir)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@
$(LIBFB_S): $(libfbobjdir)/%.o: %.s $(LIBFB_H) | $(libfbobjdir)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbpic.a: $(LIBFBPIC_C) | $(libdir)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBPIC_C): $(libfbpicobjdir)/%.o: %.c $(LIBFB_H) | $(libfbpicobjdir)
	$(QUIET_CC)$(CC) -fPIC $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbmt.a: $(LIBFBMT_C) $(LIBFBMT_S) | $(libdir)
ifeq ($(TARGET_OS),dos)
  # Avoid hitting the command line length limit (the libfb.a ar command line
  # is very long...)
	$(QUIET)rm -f $@
	$(AR) x $(DJDIR)/lib/libpthread.a
	$(AR) x $(DJDIR)/lib/libsocket.a
	mv -f *.o $(libfbmtobjdir)
	$(QUIET_AR)$(AR) rcs $@ $(libfbmtobjdir)/*.o
else
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
endif
$(LIBFBMT_C): $(libfbmtobjdir)/%.o: %.c $(LIBFB_H) | $(libfbmtobjdir)
	$(QUIET_CC)$(CC) -DENABLE_MT $(ALLCFLAGS) -c $< -o $@
$(LIBFBMT_S): $(libfbmtobjdir)/%.o: %.s $(LIBFB_H) | $(libfbmtobjdir)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp -DENABLE_MT $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbmtpic.a: $(LIBFBMTPIC_C) | $(libdir)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBMTPIC_C): $(libfbmtpicobjdir)/%.o: %.c $(LIBFB_H) | $(libfbmtpicobjdir)
	$(QUIET_CC)$(CC) -DENABLE_MT -fPIC $(ALLCFLAGS) -c $< -o $@

ifeq ($(TARGET_OS),dos)
djgpplibc := $(shell $(CC) -print-file-name=libc.a)
libcmaino := $(djgpplibcobjdir)/_main.o
$(libcmaino): $(rootdir)contrib/djgpp/libc/crt0/_main.c | $(djgpplibcobjdir)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@
$(libdir)/libc.a: $(djgpplibc) $(libcmaino) | $(libdir)
	cp $(djgpplibc) $@
	$(QUIET_AR)ar rs $@ $(libcmaino)
endif

################################################################################

.PHONY: gfxlib2
gfxlib2: $(GFX_LIBS)

$(libdir)/libfbgfx.a: $(LIBFBGFX_C) $(LIBFBGFX_S) | $(libdir)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBGFX_C): $(libfbgfxobjdir)/%.o: %.c $(LIBFBGFX_H) | $(libfbgfxobjdir)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@
$(LIBFBGFX_S): $(libfbgfxobjdir)/%.o: %.s $(LIBFBGFX_H) | $(libfbgfxobjdir)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbgfxpic.a: $(LIBFBGFXPIC_C) | $(libdir)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBGFXPIC_C): $(libfbgfxpicobjdir)/%.o: %.c $(LIBFBGFX_H) | $(libfbgfxpicobjdir)
	$(QUIET_CC)$(CC) -fPIC $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbgfxmt.a: $(LIBFBGFXMT_C) $(LIBFBGFXMT_S) | $(libdir)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBGFXMT_C): $(libfbgfxmtobjdir)/%.o: %.c $(LIBFBGFX_H) | $(libfbgfxmtobjdir)
	$(QUIET_CC)$(CC) -DENABLE_MT $(ALLCFLAGS) -c $< -o $@
$(LIBFBGFXMT_S): $(libfbgfxmtobjdir)/%.o: %.s $(LIBFBGFX_H) | $(libfbgfxmtobjdir)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp -DENABLE_MT $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbgfxmtpic.a: $(LIBFBGFXMTPIC_C) | $(libdir)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^
$(LIBFBGFXMTPIC_C): $(libfbgfxmtpicobjdir)/%.o: %.c $(LIBFBGFX_H) | $(libfbgfxmtpicobjdir)
	$(QUIET_CC)$(CC) -DENABLE_MT -fPIC $(ALLCFLAGS) -c $< -o $@

################################################################################

.PHONY: install install-compiler install-includes install-rtlib install-gfxlib2
install:        install-compiler install-includes install-rtlib install-gfxlib2

install-compiler: compiler
	mkdir -p $(DESTDIR)$(prefixbindir)
	$(INSTALL_PROGRAM) $(FBC_EXE) $(DESTDIR)$(PREFIX_FBC_EXE)

install-includes:
	mkdir -p $(DESTDIR)$(prefixincdir)
	cp -r $(rootdir)inc/* $(DESTDIR)$(prefixincdir)

install-rtlib: rtlib
	mkdir -p $(DESTDIR)$(prefixlibdir)
	$(INSTALL_FILE) $(RTL_LIBS) $(DESTDIR)$(prefixlibdir)

install-gfxlib2: gfxlib2
	mkdir -p $(DESTDIR)$(prefixlibdir)
	$(INSTALL_FILE) $(GFX_LIBS) $(DESTDIR)$(prefixlibdir)

################################################################################

.PHONY: uninstall uninstall-compiler uninstall-includes uninstall-rtlib uninstall-gfxlib2
uninstall:        uninstall-compiler uninstall-includes uninstall-rtlib uninstall-gfxlib2
	-rmdir $(DESTDIR)$(prefixlibdir)

uninstall-compiler:
	rm -f $(DESTDIR)$(PREFIX_FBC_EXE)

uninstall-includes:
	rm -rf $(DESTDIR)$(prefixincdir)

uninstall-rtlib:
	rm -f $(patsubst $(libdir)/%,$(DESTDIR)$(prefixlibdir)/%,$(RTL_LIBS))

uninstall-gfxlib2:
	rm -f $(patsubst $(libdir)/%,$(DESTDIR)$(prefixlibdir)/%,$(GFX_LIBS))

################################################################################

.PHONY: clean clean-compiler clean-rtlib clean-gfxlib2
clean:        clean-compiler clean-rtlib clean-gfxlib2

clean-compiler:
	rm -rf $(FBC_EXE) $(fbcobjdir)
  ifndef ENABLE_STANDALONE
	-rmdir bin
  endif

clean-rtlib:
	rm -rf $(RTL_LIBS) $(libfbobjdir)
  ifeq ($(TARGET_OS),dos)
	rm -rf $(djgpplibcobjdir)
  endif

clean-gfxlib2:
	rm -rf $(GFX_LIBS) $(libfbgfxobjdir)

################################################################################

.PHONY: help
help:
	@echo "Take a look at the top of this makefile!"

################################################################################

.PHONY: cunit-tests log-tests clean-tests

cunit-tests:
	cd tests && make cunit-tests FBC="`pwd`/../$(FBC_EXE) -i `pwd`/../inc"

log-tests:
	cd tests && make   log-tests FBC="`pwd`/../$(FBC_EXE) -i `pwd`/../inc"

warning-tests:
	cd tests/warnings && FBC="`pwd`/../../$(FBC_EXE)" ./test.sh

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

packbin := $(patsubst $(prefix)%,$(FBPACKAGE)%,$(prefixbindir))
packinc := $(patsubst $(prefix)%,$(FBPACKAGE)%,$(prefixincdir))
packlib := $(patsubst $(prefix)%,$(FBPACKAGE)%,$(prefixlibdir))

.PHONY: bindist
bindist:
	# Extra directory in which we'll put together the binary release package
	# (needed anyways to avoid tarbombs)
	mkdir -p $(packbin) $(packinc) $(packlib)

	# Copy fbc, binutils + gcc's libexec/.../cc1.exe (standalone), includes,
	# libs (including the non-FB ones for standalone)
	cp $(FBC_EXE) $(packbin)
	cp -r $(rootdir)inc/* $(packinc)
  ifdef ENABLE_STANDALONE
	mkdir -p $(FBPACKAGE)/bin/$(FBTARGET)
	cp bin/$(FBTARGET)/* $(FBPACKAGE)/bin/$(FBTARGET)
	cp lib/$(FBTARGET)/*.a lib/$(FBTARGET)/*.o lib/$(FBTARGET)/*.x $(packlib)
	if [ -d bin/libexec ]; then \
		cp -R bin/libexec $(FBPACKAGE)/bin; \
	fi
  else
	cp $(RTL_LIBS) $(GFX_LIBS) $(packlib)
  endif

  ifeq ($(TARGET_OS),dos)
	rm -r $(packinc)/AL
	rm -r $(packinc)/allegro5
	rm -r $(packinc)/atk
	rm -r $(packinc)/bass.bi
	rm -r $(packinc)/bassmod.bi
	rm -r $(packinc)/cairo
	rm -r $(packinc)/cd
	rm -r $(packinc)/chipmunk
	rm -r $(packinc)/crt/arpa
	rm -r $(packinc)/crt/bits
	rm -r $(packinc)/crt/iconv.bi
	rm -r $(packinc)/crt/linux
	rm -r $(packinc)/crt/netdb.bi
	rm -r $(packinc)/crt/netinet/in.bi
	rm -r $(packinc)/crt/netinet/linux/in.bi
	rm -r $(packinc)/crt/pthread.bi
	rm -r $(packinc)/crt/regex.bi
	rm -r $(packinc)/crt/sched.bi
	rm -r $(packinc)/crt/sys/linux
	rm -r $(packinc)/crt/sys/socket.bi
	rm -r $(packinc)/crt/sys/win32
	rm -r $(packinc)/crt/win32
	rm -r $(packinc)/curses/ncurses.bi
	rm -r $(packinc)/disphelper
	rm -r $(packinc)/fastcgi
	rm -r $(packinc)/ffi.bi
	rm -r $(packinc)/flite
	rm -r $(packinc)/fmod.bi
	rm -r $(packinc)/fontconfig
	rm -r $(packinc)/FreeImage.bi
	rm -r $(packinc)/freetype2
	rm -r $(packinc)/gdk*
	rm -r $(packinc)/gio
	rm -r $(packinc)/GL
	rm -r $(packinc)/GLFW
	rm -r $(packinc)/glade
	rm -r $(packinc)/glib*
	rm -r $(packinc)/gmodule.bi
	rm -r $(packinc)/goocanvas.bi
	rm -r $(packinc)/gtk*
	rm -r $(packinc)/im
	rm -r $(packinc)/IUP*
	rm -r $(packinc)/japi*
	rm -r $(packinc)/jni.bi
	rm -r $(packinc)/json*
	rm -r $(packinc)/libart_lgpl
	rm -r $(packinc)/MediaInfo*
	rm -r $(packinc)/modplug.bi
	rm -r $(packinc)/mpg123.bi
	rm -r $(packinc)/mysql
	rm -r $(packinc)/Newton.bi
	rm -r $(packinc)/ode
	rm -r $(packinc)/ogg
	rm -r $(packinc)/pango
	rm -r $(packinc)/pdflib.bi
	rm -r $(packinc)/portaudio.bi
	rm -r $(packinc)/postgresql
	rm -r $(packinc)/SDL
	rm -r $(packinc)/SDL2
	rm -r $(packinc)/sndfile.bi
	rm -r $(packinc)/spidermonkey
	rm -r $(packinc)/uuid.bi
	rm -r $(packinc)/vlc
	rm -r $(packinc)/vorbis
	rm -r $(packinc)/win
	rm -r $(packinc)/windows.bi
	rm -r $(packinc)/wx-c
	rm -r $(packinc)/X11
	rm -r $(packinc)/xcb
	rm -r $(packinc)/xmp.bi
	rm -r $(packinc)/zmq
  endif

  ifeq ($(TARGET_ARCH),x86_64)
	# Exclude headers which don't support 64bit yet
	rm -r $(packinc)/big_int
	rm -r $(packinc)/dislin.bi
	rm -r $(packinc)/gettext-po.bi
	rm -r $(packinc)/glade
	rm -r $(packinc)/goocanvas.bi
	rm -r $(packinc)/japi.bi
	rm -r $(packinc)/jni.bi
	rm -r $(packinc)/jpgalleg.bi
	rm -r $(packinc)/libart_lgpl
	rm -r $(packinc)/libintl.bi
	rm -r $(packinc)/mysql
	rm -r $(packinc)/pdflib.bi
	rm -r $(packinc)/quicklz.bi
	rm -r $(packinc)/spidermonkey
	rm -r $(packinc)/tinyptc.bi
	rm -r $(packinc)/win/ddk
	rm -r $(packinc)/win/rc
	rm -r $(packinc)/wx-c
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
	cp $(rootdir)contrib/unix-installer/install.sh $(FBPACKAGE)
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
	#    not all libs really are import libs, but it follows FB tradition.
	#  * Filtering out some libs which are included in MinGW toolchains
	#    sometimes, but we don't want (e.g. libpthread).
	dir=$$(dirname $$($(CC) -print-file-name=libkernel32.a)); \
		ls $$dir/lib*.a | grep -v $(winapilibsignore) | while read i; do \
			cp $$i $(libdir)/`basename $$i | sed -e 's/\.a$$/.dll.a/g'`; \
		done

endif
endif

#
# Precompile the compiler sources into .asm/.c files and put them into a
# bootstrap/ directory, then package the source tree including the bootstrap/
# sources. This package can then be distributed, and people can do
# "make bootstrap" to build an fbc from the precompiled sources.
#
# The precompiled sources should be compatible to the rtlib in the same source
# tree, so that it's safe to link the bootstrapped fbc against it. This way
# there's no need to worry about choosing the right rtlib when bootstrapping
# fbc -- it's just always possible to use the version from the same source tree.
#
FBBOOTSTRAPTITLE := $(FBSOURCETITLE)-bootstrap
.PHONY: bootstrap-dist
bootstrap-dist:
	# Precompile fbc sources for various targets
	rm -rf bootstrap
	mkdir -p bootstrap/dos
	mkdir -p bootstrap/linux-x86
	mkdir -p bootstrap/linux-x86_64
	mkdir -p bootstrap/win32
	mkdir -p bootstrap/win64
	./$(FBC_EXE) src/compiler/*.bas -m fbc -i inc -e -r -v -target dos          && mv src/compiler/*.asm bootstrap/dos
	./$(FBC_EXE) src/compiler/*.bas -m fbc -i inc -e -r -v -target linux-x86    && mv src/compiler/*.asm bootstrap/linux-x86
	./$(FBC_EXE) src/compiler/*.bas -m fbc -i inc -e -r -v -target linux-x86_64 && mv src/compiler/*.c   bootstrap/linux-x86_64
	./$(FBC_EXE) src/compiler/*.bas -m fbc -i inc -e -r -v -target win32        && mv src/compiler/*.asm bootstrap/win32
	./$(FBC_EXE) src/compiler/*.bas -m fbc -i inc -e -r -v -target win64        && mv src/compiler/*.c   bootstrap/win64

	# Ensure to have LFs regardless of host system (LFs will probably work
	# on DOS/Win32, but CRLFs could cause issues on Linux)
	dos2unix bootstrap/dos/*
	dos2unix bootstrap/linux-x86/*
	dos2unix bootstrap/linux-x86_64/*
	dos2unix bootstrap/win32/*
	dos2unix bootstrap/win64/*

	# Package FB sources (similar to our "gitdist" command), and add the bootstrap/ directory
	# Making a .tar.xz should be good enough for now.
	git -c core.autocrlf=false archive --format tar --prefix "$(FBBOOTSTRAPTITLE)/" HEAD | tar xf -
	mv bootstrap $(FBBOOTSTRAPTITLE)
	tar -cJf "$(FBBOOTSTRAPTITLE).tar.xz" "$(FBBOOTSTRAPTITLE)"
	rm -rf "$(FBBOOTSTRAPTITLE)"

#
# Build the fbc[.exe] binary from the precompiled sources in the bootstrap/
# directory.
#
BOOTSTRAP_FBC := bootstrap/fbc$(EXEEXT)
.PHONY: bootstrap
bootstrap: rtlib gfxlib2 $(BOOTSTRAP_FBC)
	mkdir -p bin
	cp $(BOOTSTRAP_FBC) $(FBC_EXE)

ifeq ($(TARGET_ARCH),x86)
  # x86: .asm => .o (using the same assembler options as fbc)
  BOOTSTRAP_OBJ = $(patsubst %.asm,%.o,$(sort $(wildcard bootstrap/$(FBTARGET)/*.asm)))
  $(BOOTSTRAP_OBJ): %.o: %.asm
	$(QUIET_AS)$(AS) --strip-local-absolute $< -o $@
else
  # x86_64 etc.: .c => .o (using the same gcc options as fbc -gen gcc)
  BOOTSTRAP_CFLAGS := -nostdinc
  BOOTSTRAP_CFLAGS += -Wall -Wno-unused-label -Wno-unused-function -Wno-unused-variable
  BOOTSTRAP_CFLAGS += -Wno-unused-but-set-variable -Wno-main
  BOOTSTRAP_CFLAGS += -fno-strict-aliasing -frounding-math -fwrapv
  BOOTSTRAP_CFLAGS += -Wfatal-errors
  BOOTSTRAP_OBJ := $(patsubst %.c,%.o,$(sort $(wildcard bootstrap/$(FBTARGET)/*.c)))
  $(BOOTSTRAP_OBJ): %.o: %.c
	$(QUIET_CC)$(CC) -c $(BOOTSTRAP_CFLAGS) $< -o $@
endif

# Use gcc to link fbc from the bootstrap .o's
# (assuming the rtlib was built already)
ifneq ($(filter darwin freebsd linux netbsd openbsd solaris,$(TARGET_OS)),)
  BOOTSTRAP_LIBS := -lncurses -lm -pthread
endif
$(BOOTSTRAP_FBC): $(BOOTSTRAP_OBJ)
	$(QUIET_LINK)$(CC) -o $@ $(libdir)/fbrt0.o bootstrap/$(FBTARGET)/*.o $(libdir)/libfb.a $(BOOTSTRAP_LIBS)

.PHONY: clean-bootstrap
clean-bootstrap:
	rm -f $(BOOTSTRAP_FBC) bootstrap/$(FBTARGET)/*.o
