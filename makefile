#!/usr/bin/make -f
#
# This is the FB makefile that builds the compiler (fbc) and the runtime
# libraries (rtlib -> libfb[mt] and fbrt0.o, gfxlib2 -> libfbgfx).
# There are several dependencies, especially for the rtlib and gfxlib2 code,
# which are listed in the "building FB" guide at:
#    http://www.freebasic.net/wiki/wikka.php?wakka=DevBuild
#
# Running "make" will try to build the following:
#
#   1) the compiler - this requires a working FB installation, because it's
#      written in FB itself.
#          src/compiler/*.bas,
#          compiled into fbc[.exe]
#
#   2) the rtlib
#          all *.c and *.s files in src/rtlib/, src/rtlib/$(TARGET_OS),
#          and src/rtlib/$(TARGET_ARCH), compiled into libfb.a
#          src/rtlib/static/fbrt0.c compiled into fbrt0.o
#
#          For DOS, the modified version of libc.a is created too,
#          see contrib/djgpp/ for more information.
#
#   3) the thread-safe rtlib (except for DOS)
#          like the normal rtlib, but with -DENABLE_MT, compiled into libfbmt.a
#
#   4) the gfxlib2
#          like the normal rtlib, just with the sources from src/gfxlib2/,
#          compiled into libfbgfx.a
#
# You can also build FB by doing all these steps manually.
#
# The makefile additionally takes care of moving the resulting binaries into
# the proper directory layout, allowing the new FB setup to be tested right
# away, without being installed elsewhere.
#
# commands:
#   <none>|all                 build everything
#   compiler|rtlib|gfxlib2     build specific component only
#   clean[-component]          remove built files
#   install[-component]        install into $(prefix)
#   uninstall[-component]      remove from $(prefix)
#   install-includes           (additional commands for just the FB includes,
#   uninstall-includes          which don't need to be built)
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
FBFLAGS := -maxerr 1
AR = $(TARGET_PREFIX)ar
CC = $(TARGET_PREFIX)gcc
prefix := /usr/local

# Determine the makefile's directory, this may be a relative path when
# building in a separate build directory via e.g. "make -f ../fbc/makefile".
rootdir := $(dir $(MAKEFILE_LIST))

# Prune ./ prefix for beauty
ifeq ($(rootdir),./)
  rootdir :=
endif

srcdir := $(rootdir)src

-include config.mk

ifdef TARGET
  # TARGET given, so parse it

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
    ifneq ($(filter i386 i486 i586 i686,$(triplet_arch)),)
      TARGET_ARCH := x86
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
    uname_m := $(shell uname -m)
    ifneq ($(filter i386 i486 i586 i686,$(uname_m)),)
      TARGET_ARCH = x86
    endif
    ifeq ($(uname_m),x86_64)
      TARGET_ARCH = x86_64
    endif
    ifeq ($(uname_m),sparc)
      TARGET_ARCH = sparc
    endif
    ifeq ($(uname_m),sparc64)
      TARGET_ARCH = sparc64
    endif
    ifeq ($(uname_m),powerpc64)
      TARGET_ARCH = powerpc64
    endif
  endif
endif

# For some targets we can choose good default archs
# (this also handles automatically setting TARGET_ARCH to x86 under DJGPP,
# whose uname -m returns just "pc")
ifndef TARGET_ARCH
  ifeq ($(TARGET_OS),dos)
    TARGET_ARCH := x86
  endif
  ifeq ($(TARGET_OS),win32)
    TARGET_ARCH := x86
  endif
endif

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

ifndef TARGET_OS
  $(error couldn't identify TARGET_OS automatically)
endif
ifndef TARGET_ARCH
  $(error couldn't identify TARGET_ARCH automatically)
endif

ifeq ($(TARGET_OS),dos)
  FBNAME := freebas$(ENABLE_SUFFIX)
  FB_LDSCRIPT := i386go32.x
  DISABLE_MT := YesPlease
else
  FBNAME := freebasic$(ENABLE_SUFFIX)
  FB_LDSCRIPT := fbextra.x
endif

ifneq ($(filter cygwin dos win32,$(TARGET_OS)),)
  EXEEXT := .exe
  INSTALL_PROGRAM := cp
  INSTALL_FILE := cp
else
  INSTALL_PROGRAM := install
  INSTALL_FILE := install -m 644
endif

libsubdir := $(TARGET_OS)
ifneq ($(TARGET_ARCH),x86)
  libsubdir := $(TARGET_ARCH)-$(TARGET_OS)
endif
fbcobjdir := src/compiler/obj
ifdef ENABLE_STANDALONE
  FBC_EXE     := fbc$(EXEEXT)
  FBCNEW_EXE  := fbc-new$(EXEEXT)
  libfbobjdir    := src/rtlib/obj/$(TARGET_OS)
  libfbmtobjdir  := src/rtlib/obj/mt/$(TARGET_OS)
  libfbgfxobjdir := src/gfxlib2/obj/$(TARGET_OS)
  libdir         := lib/$(TARGET_OS)
  PREFIX_FBC_EXE := $(prefix)/fbc$(EXEEXT)
  prefixincdir   := $(prefix)/inc
  prefixlibdir   := $(prefix)/lib/$(TARGET_OS)
else
  ifdef TARGET
    libsubdir := $(TARGET)
  endif
  bindir      := bin
  FBC_EXE     := bin/fbc$(ENABLE_SUFFIX)$(EXEEXT)
  FBCNEW_EXE  := bin/fbc$(ENABLE_SUFFIX)-new$(EXEEXT)
  libfbobjdir    := src/rtlib/obj/$(libsubdir)
  libfbmtobjdir  := src/rtlib/obj/mt/$(libsubdir)
  libfbgfxobjdir := src/gfxlib2/obj/$(libsubdir)
  libdir         := lib/$(FBNAME)/$(libsubdir)
  PREFIX_FBC_EXE := $(prefix)/bin/fbc$(ENABLE_SUFFIX)$(EXEEXT)
  prefixbindir   := $(prefix)/bin
  prefixincdir   := $(prefix)/include/$(FBNAME)
  prefixlibdir   := $(prefix)/lib/$(FBNAME)/$(libsubdir)
endif

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
ALLCFLAGS += -Wall -Werror-implicit-function-declaration

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
FBC_ASM := $(patsubst %.bas,%.asm,$(FBC_BAS))
FBC_C   := $(patsubst %.bas,%.c,$(FBC_BAS))
FBC_BAS := $(patsubst $(srcdir)/compiler/%.bas,$(fbcobjdir)/%.o,$(FBC_BAS))

# Determine rtlib/gfxlib2 arch-specific directory
# It depends on the target's arch, but also the multilib selection, if any
ifeq ($(TARGET_ARCH),x86_64)
  ifeq ($(FBMULTILIB),32)
    # Cross-compiling from 64bit to 32bit using -m32
    RTLIB_ARCHDIR := x86
  endif
endif
ifeq ($(TARGET_ARCH),x86)
  ifeq ($(FBMULTILIB),64)
    # Cross-compiling from 32bit to 64bit using -m64
    RTLIB_ARCHDIR := x86_64
  endif
endif
ifndef RTLIB_ARCHDIR
  RTLIB_ARCHDIR := $(TARGET_ARCH)
endif

# rtlib/gfxlib2 headers and modules
RTLIB_DIRS := $(srcdir)/rtlib $(srcdir)/rtlib/$(TARGET_OS) $(srcdir)/rtlib/$(RTLIB_ARCHDIR)
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

LIBFBMT_C := $(patsubst $(libfbobjdir)/%,$(libfbmtobjdir)/%,$(LIBFB_C))
LIBFBMT_S := $(patsubst $(libfbobjdir)/%,$(libfbmtobjdir)/%,$(LIBFB_S))

LIBFBGFX_H := $(sort $(foreach i,$(GFXLIB2_DIRS),$(wildcard $(i)/*.h)) $(LIBFB_H))
LIBFBGFX_C := $(sort $(foreach i,$(GFXLIB2_DIRS),$(patsubst $(i)/%.c,$(libfbgfxobjdir)/%.o,$(wildcard $(i)/*.c))))
LIBFBGFX_S := $(sort $(foreach i,$(GFXLIB2_DIRS),$(patsubst $(i)/%.s,$(libfbgfxobjdir)/%.o,$(wildcard $(i)/*.s))))

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

$(fbcobjdir) $(libfbobjdir) $(libfbmtobjdir) $(libfbgfxobjdir) \
$(bindir) $(libdir) $(prefixbindir) $(prefixincdir) $(prefixlibdir):
	mkdir -p $@

################################################################################

.PHONY: compiler
compiler: $(bindir) $(fbcobjdir) $(FBC_EXE)

$(FBC_EXE): $(FBC_BAS)
	$(QUIET_LINK)$(FBC) $(ALLFBLFLAGS) -x $(FBCNEW_EXE) $^
	$(QUIET)mv $(FBCNEW_EXE) $@

$(FBC_BAS): $(fbcobjdir)/%.o: $(srcdir)/compiler/%.bas $(FBC_BI)
	$(QUIET_FBC)$(FBC) $(ALLFBCFLAGS) -c $< -o $@

################################################################################

.PHONY: rtlib
rtlib: $(libdir) $(libfbobjdir)
rtlib: $(libdir)/$(FB_LDSCRIPT) $(libdir)/fbrt0.o $(libdir)/libfb.a
ifndef DISABLE_MT
rtlib: $(libfbmtobjdir) $(libdir)/libfbmt.a
endif
ifeq ($(TARGET_OS),dos)
rtlib: $(libdir)/libc.a
endif

$(libdir)/fbextra.x: $(rootdir)lib/fbextra.x
	cp $< $@

$(libdir)/i386go32.x: $(rootdir)contrib/djgpp/i386go32.x
	cp $< $@

$(libdir)/fbrt0.o: $(srcdir)/rtlib/static/fbrt0.c $(LIBFB_H)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@

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

$(libdir)/libfbmt.a: $(LIBFBMT_C) $(LIBFBMT_S)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^

$(LIBFBMT_C): $(libfbmtobjdir)/%.o: %.c $(LIBFB_H)
	$(QUIET_CC)$(CC) -DENABLE_MT $(ALLCFLAGS) -c $< -o $@

$(LIBFBMT_S): $(libfbmtobjdir)/%.o: %.s $(LIBFB_H)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp -DENABLE_MT $(ALLCFLAGS) -c $< -o $@

ifeq ($(TARGET_OS),dos)
djgpplibc := $(shell $(CC) -print-file-name=libc.a)
libcmaino := contrib/djgpp/libc/crt0/_main.o

$(libcmaino): %.o: %.c
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@

$(libdir)/libc.a: $(djgpplibc) $(libcmaino)
	cp $(djgpplibc) $@
	$(QUIET_AR)ar rs $@ $(libcmaino)
endif

################################################################################

.PHONY: gfxlib2
gfxlib2: $(libdir) $(libfbgfxobjdir) $(libdir)/libfbgfx.a

$(libdir)/libfbgfx.a: $(LIBFBGFX_C) $(LIBFBGFX_S)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $^

$(LIBFBGFX_C): $(libfbgfxobjdir)/%.o: %.c $(LIBFBGFX_H)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@

$(LIBFBGFX_S): $(libfbgfxobjdir)/%.o: %.s $(LIBFBGFX_H)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp $(ALLCFLAGS) -c $< -o $@

################################################################################

.PHONY: install install-compiler install-includes install-rtlib install-gfxlib2
install:        install-compiler install-includes install-rtlib install-gfxlib2

install-compiler: $(prefixbindir)
	$(INSTALL_PROGRAM) $(FBC_EXE) $(PREFIX_FBC_EXE)

install-includes: $(prefixincdir)
	cp -r $(rootdir)inc/* $(prefixincdir)

install-rtlib: $(prefixlibdir)
	$(INSTALL_FILE) $(libdir)/$(FB_LDSCRIPT) $(libdir)/fbrt0.o $(libdir)/libfb.a $(prefixlibdir)/
  ifndef DISABLE_MT
	$(INSTALL_FILE) $(libdir)/libfbmt.a $(prefixlibdir)/
  endif
  ifeq ($(TARGET_OS),dos)
	$(INSTALL_FILE) $(libdir)/libc.a $(prefixlibdir)/
  endif

install-gfxlib2: $(prefix)/lib $(prefixlibdir)
	$(INSTALL_FILE) $(libdir)/libfbgfx.a $(prefixlibdir)/

################################################################################

.PHONY: uninstall uninstall-compiler uninstall-includes uninstall-rtlib uninstall-gfxlib2
uninstall:        uninstall-compiler uninstall-includes uninstall-rtlib uninstall-gfxlib2
	-rmdir $(prefixlibdir)

uninstall-compiler:
	rm -f $(PREFIX_FBC_EXE)

uninstall-includes:
	rm -rf $(prefixincdir)

uninstall-rtlib:
	rm -f $(prefixlibdir)/$(FB_LDSCRIPT) $(prefixlibdir)/fbrt0.o $(prefixlibdir)/libfb.a
  ifndef DISABLE_MT
	rm -f $(prefixlibdir)/libfbmt.a
  endif
  ifeq ($(TARGET_OS),dos)
	rm -f $(libdir)/libc.a
  endif

uninstall-gfxlib2:
	rm -f $(prefixlibdir)/libfbgfx.a

################################################################################

.PHONY: clean clean-compiler clean-rtlib clean-gfxlib2
clean:        clean-compiler clean-rtlib clean-gfxlib2

clean-compiler:
	rm -f $(FBC_EXE) $(fbcobjdir)/*.o
  ifndef ENABLE_STANDALONE
	-rmdir $(bindir)
  endif

clean-rtlib:
	rm -f $(libdir)/$(FB_LDSCRIPT) $(libdir)/fbrt0.o $(libdir)/libfb.a $(libfbobjdir)/*.o
	-rmdir $(libfbobjdir)
  ifndef DISABLE_MT
	rm -f $(libdir)/libfbmt.a $(libfbmtobjdir)/*.o
	-rmdir $(libfbmtobjdir)
  endif
  ifeq ($(TARGET_OS),dos)
	rm -f $(libdir)/libc.a $(libcmaino)
  endif

clean-gfxlib2:
	rm -f $(libdir)/libfbgfx.a $(libfbgfxobjdir)/*.o
	-rmdir $(libfbgfxobjdir)

################################################################################

.PHONY: help
help:
	@echo "Take a look at the top of this makefile!"
