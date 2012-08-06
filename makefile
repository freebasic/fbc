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
#          src/compiler/*.bas and possibly src/compiler/bfd-wrapper.c,
#          compiled into fbc-new[.exe]
#
#          Beware of the libbfd pitfall! By default, the compiler source code
#          uses the system's bfd.h header through bfd-wrapper.c, but it is
#          linked against whichever libbfd binary is seen by the host FB setup.
#          Please ensure the used libbfd binary matches the used headers!
#          See also the configuration options below.
#
#   2) the rtlib
#          all *.c and *.s files in src/rtlib/, src/rtlib/$(TARGET_OS),
#          and src/rtlib/$(TARGET_ARCH), compiled into libfb.a
#          src/rtlib/static/fbrt0.c compiled into fbrt0.o
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
#   FBC, CC, AR      fbc, gcc, ar programs (TARGET may be prefixed to CC/AR)
#   V=1              to see full command lines
#   ENABLE_STANDALONE=1    build source tree into self-contained FB installation
#   DISABLE_OBJINFO=1      use "-d DISABLE_OBJINFO" and don't compile in bfd-wrapper.c
#   ENABLE_FBBFD=217       use "-d ENABLE_FBBFD=$(ENABLE_FBBFD)" and don't compile in bfd-wrapper.c
#   ENABLE_PREFIX=1        use "-d ENABLE_PREFIX=$(prefix)"
#   ENABLE_SUFFIX=-0.24    append a string like "-0.24" to fbc/FB dir names,
#                          and use "-d ENABLE_SUFFIX=$(ENABLE_SUFFIX)" (non-standalone only)
#
# compiler source code configuration (FBCFLAGS):
#   -d ENABLE_STANDALONE     build for a self-contained installation
#   -d DISABLE_OBJINFO       do not use libbfd at all
#   -d ENABLE_FBBFD=217      use specific bfd.bi instead of bfd.h wrapper
#   -d ENABLE_TDMGCC         build for TDM-GCC instead of MinGW.org setup
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

ifndef TARGET_OS
  $(error couldn't identify TARGET_OS automatically)
endif
ifndef TARGET_ARCH
  $(error couldn't identify TARGET_ARCH automatically)
endif

ifeq ($(TARGET_OS),dos)
  FB_NAME := freebas
  FB_LDSCRIPT := i386go32.x
  DISABLE_MT := YesPlease
else
  FB_NAME := freebasic
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

newcompiler := src/compiler/obj
ifdef ENABLE_STANDALONE
  FBC_EXE     := fbc-new$(EXEEXT)
  newlibfb    := src/rtlib/$(TARGET_OS)-obj
  newlibfbmt  := src/rtlib/$(TARGET_OS)-objmt
  newlibfbgfx := src/gfxlib2/$(TARGET_OS)-obj
  libdir      := lib/$(TARGET_OS)
  PREFIX_FBC_EXE := $(prefix)/fbc$(EXEEXT)
  prefixinclude  := $(prefix)/inc
  prefixlib      := $(prefix)/lib/$(TARGET_OS)
else
  FBC_EXE     := bin/fbc$(ENABLE_SUFFIX)-new$(EXEEXT)
  newlibfb    := src/rtlib/$(TARGET_PREFIX)obj
  newlibfbmt  := src/rtlib/$(TARGET_PREFIX)objmt
  newlibfbgfx := src/gfxlib2/$(TARGET_PREFIX)obj
  libdir      := lib/$(TARGET_PREFIX)$(FB_NAME)$(ENABLE_SUFFIX)
  PREFIX_FBC_EXE := $(prefix)/bin/fbc$(ENABLE_SUFFIX)$(EXEEXT)
  prefixinclude  := $(prefix)/include/$(FB_NAME)
  prefixlib      := $(prefix)/lib/$(TARGET_PREFIX)$(FB_NAME)$(ENABLE_SUFFIX)
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
ifdef ENABLE_STANDALONE
  ALLFBCFLAGS += -d ENABLE_STANDALONE
endif
ifdef DISABLE_OBJINFO
  ALLFBCFLAGS += -d DISABLE_OBJINFO
endif
ifdef ENABLE_FBBFD
  ALLFBCFLAGS += -d ENABLE_FBBFD=$(ENABLE_FBBFD)
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
FBC_BI  := $(wildcard $(srcdir)/compiler/*.bi)
FBC_BAS := $(wildcard $(srcdir)/compiler/*.bas)
FBC_BAS := $(patsubst $(srcdir)/compiler/%.bas,$(newcompiler)/%.o,$(FBC_BAS))

ifndef DISABLE_OBJINFO
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
LIBFB_C := $(sort $(foreach i,$(RTLIB_DIRS),$(patsubst $(i)/%.c,$(newlibfb)/%.o,$(wildcard $(i)/*.c))))
LIBFB_S := $(sort $(foreach i,$(RTLIB_DIRS),$(patsubst $(i)/%.s,$(newlibfb)/%.o,$(wildcard $(i)/*.s))))

LIBFBMT_C := $(patsubst $(newlibfb)/%,$(newlibfbmt)/%,$(LIBFB_C))
LIBFBMT_S := $(patsubst $(newlibfb)/%,$(newlibfbmt)/%,$(LIBFB_S))

LIBFBGFX_H := $(sort $(foreach i,$(GFXLIB2_DIRS),$(wildcard $(i)/*.h)) $(LIBFB_H))
LIBFBGFX_C := $(sort $(foreach i,$(GFXLIB2_DIRS),$(patsubst $(i)/%.c,$(newlibfbgfx)/%.o,$(wildcard $(i)/*.c))))
LIBFBGFX_S := $(sort $(foreach i,$(GFXLIB2_DIRS),$(patsubst $(i)/%.s,$(newlibfbgfx)/%.o,$(wildcard $(i)/*.s))))

ifeq ($(TARGET_OS),xbox)
  ALLCFLAGS += -DHOST_XBOX

  # Some special treatment for xbox. TODO: Test me, update me!
  ALLCFLAGS += -DENABLE_XBOX -DDISABLE_CDROM
  ALLCFLAGS += -std=gnu99 -mno-cygwin -nostdlib -nostdinc
  ALLCFLAGS += -ffreestanding -fno-builtin -fno-exceptions
  ALLCFLAGS += -I$(OPENXDK)/i386-pc-xbox/include
  ALLCFLAGS += -I$(OPENXDK)/include
  ALLCFLAGS += -I$(OPENXDK)/include/SDL
endif

#
# Build rules
#

VPATH = $(srcdir)/compiler $(RTLIB_DIRS) $(GFXLIB2_DIRS)

# We don't want to use any of make's built-in suffixes/rules
.SUFFIXES:

ifndef V
  QUIET_FBC   = @echo "FBC $@";
  QUIET_LINK  = @echo "LINK $@";
  QUIET_CC    = @echo "CC $@";
  QUIET_CPPAS = @echo "CPPAS $@";
  QUIET_AR    = @echo "AR $@";
endif

.PHONY: all
all: compiler rtlib gfxlib2

src src/compiler src/rtlib src/gfxlib2 bin lib \
$(newcompiler) $(newlibfb) $(newlibfbmt) $(newlibfbgfx) $(libdir) \
$(prefix) $(prefix)/bin $(prefix)/inc $(prefix)/include $(prefix)/include/$(FB_NAME) $(prefix)/lib $(prefixlib):
	mkdir $@

.PHONY: compiler
compiler: src src/compiler
ifndef ENABLE_STANDALONE
compiler: bin
endif
compiler: $(newcompiler) $(FBC_EXE)

$(FBC_EXE): $(FBC_BAS) $(FBC_BFDWRAPPER)
	$(QUIET_LINK)$(FBC) $(ALLFBLFLAGS) -x $@ $(newcompiler)/*.o

$(FBC_BAS): $(newcompiler)/%.o: %.bas $(FBC_BI)
	$(QUIET_FBC)$(FBC) $(ALLFBCFLAGS) -c $< -o $@

$(newcompiler)/bfd-wrapper.o: bfd-wrapper.c
	$(QUIET_CC)$(CC) -Wall -O2 -c $< -o $@

.PHONY: rtlib
rtlib: lib $(libdir) src src/rtlib $(newlibfb)
rtlib: $(libdir)/$(FB_LDSCRIPT) $(libdir)/fbrt0.o $(libdir)/libfb.a
ifndef DISABLE_MT
rtlib: $(newlibfbmt) $(libdir)/libfbmt.a
endif

$(libdir)/fbextra.x: $(rootdir)lib/fbextra.x
	cp $< $@

$(libdir)/i386go32.x: $(rootdir)contrib/djgpp/i386go32.x
	cp $< $@

$(libdir)/fbrt0.o: $(srcdir)/rtlib/static/fbrt0.c $(LIBFB_H)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfb.a: $(LIBFB_C) $(LIBFB_S)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $(newlibfb)/*.o

$(LIBFB_C): $(newlibfb)/%.o: %.c $(LIBFB_H)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@

$(LIBFB_S): $(newlibfb)/%.o: %.s $(LIBFB_H)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp $(ALLCFLAGS) -c $< -o $@

$(libdir)/libfbmt.a: $(LIBFBMT_C) $(LIBFBMT_S)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $(newlibfbmt)/*.o

$(LIBFBMT_C): $(newlibfbmt)/%.o: %.c $(LIBFB_H)
	$(QUIET_CC)$(CC) -DENABLE_MT $(ALLCFLAGS) -c $< -o $@

$(LIBFBMT_S): $(newlibfbmt)/%.o: %.s $(LIBFB_H)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp -DENABLE_MT $(ALLCFLAGS) -c $< -o $@

.PHONY: gfxlib2
gfxlib2: lib $(libdir) src src/gfxlib2
gfxlib2: $(newlibfbgfx) $(libdir)/libfbgfx.a

$(libdir)/libfbgfx.a: $(LIBFBGFX_C) $(LIBFBGFX_S)
	$(QUIET_AR)rm -f $@; $(AR) rcs $@ $(newlibfbgfx)/*.o

$(LIBFBGFX_C): $(newlibfbgfx)/%.o: %.c $(LIBFBGFX_H)
	$(QUIET_CC)$(CC) $(ALLCFLAGS) -c $< -o $@

$(LIBFBGFX_S): $(newlibfbgfx)/%.o: %.s $(LIBFBGFX_H)
	$(QUIET_CPPAS)$(CC) -x assembler-with-cpp $(ALLCFLAGS) -c $< -o $@

.PHONY: install install-compiler install-includes install-rtlib install-gfxlib2
install:        install-compiler install-includes install-rtlib install-gfxlib2

ifdef ENABLE_STANDALONE
install-compiler:
else
install-compiler: $(prefix)/bin
endif
	$(INSTALL_PROGRAM) $(FBC_EXE) $(PREFIX_FBC_EXE)

ifdef ENABLE_STANDALONE
install-includes: $(prefixinclude)
else
install-includes: $(prefix)/include $(prefixinclude)
endif
	cp -r $(rootdir)inc/* $(prefixinclude)

install-rtlib: $(prefix)/lib $(prefixlib)
	$(INSTALL_FILE) $(libdir)/$(FB_LDSCRIPT) $(libdir)/fbrt0.o $(libdir)/libfb.a $(prefixlib)/
  ifndef DISABLE_MT
	$(INSTALL_FILE) $(libdir)/libfbmt.a $(prefixlib)/
  endif

install-gfxlib2: $(prefix)/lib $(prefixlib)
	$(INSTALL_FILE) $(libdir)/libfbgfx.a $(prefixlib)/

.PHONY: uninstall uninstall-compiler uninstall-includes uninstall-rtlib uninstall-gfxlib2
uninstall:        uninstall-compiler uninstall-includes uninstall-rtlib uninstall-gfxlib2
	-rmdir $(prefixlib)

uninstall-compiler:
	rm -f $(PREFIX_FBC_EXE)

uninstall-includes:
	rm -rf $(prefixinclude)

uninstall-rtlib:
	rm -f $(prefixlib)/$(FB_LDSCRIPT) $(prefixlib)/fbrt0.o $(prefixlib)/libfb.a
  ifndef DISABLE_MT
	rm -f $(prefixlib)/libfbmt.a
  endif

uninstall-gfxlib2:
	rm -f $(prefixlib)/libfbgfx.a

.PHONY: clean clean-compiler clean-rtlib clean-gfxlib2
clean:        clean-compiler clean-rtlib clean-gfxlib2

clean-compiler:
	rm -f $(FBC_EXE) $(newcompiler)/*.o

clean-rtlib:
	rm -f $(libdir)/$(FB_LDSCRIPT) $(libdir)/fbrt0.o $(libdir)/libfb.a $(newlibfb)/*.o
	-rmdir $(newlibfb)
  ifndef DISABLE_MT
	rm -f $(libdir)/libfbmt.a $(newlibfbmt)/*.o
	-rmdir $(newlibfbmt)
  endif

clean-gfxlib2:
	rm -f $(libdir)/libfbgfx.a $(newlibfbgfx)/*.o
	-rmdir $(newlibfbgfx)

.PHONY: help
help:
	@echo "Take a look at the top of this makefile!"
