#!/usr/bin/make -f
#
# top level makefile that will run other makefiles for documentation 
# and wiki tools
#   ./libfbdoc/makefile
#   ./fbdoc/makefile
#   ./fbhelp/makefile
#   ./fbchkdoc/makefile
#
# define's that can override build options
#
#   'HAVE_MYSQL=1' to indicate that mysql library is available
#   'HAVE_ASPELL=1' to indicate that spell check library is available
#   'USE_PCRE_STATIC=1' to indicate we should link with static version of libpcre
#   'FBC=d:/path/fbc to' to override path to execute fbc compiler 

OS := $(shell uname)
ifeq ($(OS),Linux)
    EXEEXT :=
else
    EXEEXT := .exe
endif

ifndef MAKE
    MAKE := make
endif

# when we build in sub directories, make sure we pass on the options
MAKEOPTS :=
ifdef HAVE_MYSQL
    MAKEOPTS += HAVE_MYSQL=1
endif 
ifdef HAVE_ASPELL
    MAKEOPTS += HAVE_ASPELL=1
endif 
ifdef USE_PCRE_STATIC
    MAKEOPTS += USE_PCRE_STATIC=1
endif 

FBC := fbc

FBDOC_MAKE := fbdoc/makefile
FBDOC_SRCS := $(wildcard fbdoc/*.bas)
FBDOC_HDRS := $(wildcard fbdoc/*.bi)
FBDOC_BINS := fbdoc/fbdoc$(EXEEXT)

LIBFBDOC_MAKE := libfbdoc/makefile
LIBFBDOC_SRCS := $(wildcard libfbdoc/*.bas)
LIBFBDOC_HDRS := $(wildcard libfbdoc/*.bi)
LIBFBDOC_BINS := libfbdoc/libfbdoc.a

FBCHKDOC_MAKE := fbchkdoc/makefile
FBCHKDOC_SRCS := $(wildcard fbchkdoc/*.bas) 
FBCHKDOC_HDRS := $(wildcard fbchkdoc/*.bi) 
FBCHKDOC_BINS := fbchkdoc/getindex$(EXEEXT)  
FBCHKDOC_BINS += fbchkdoc/getpage$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/putpage$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/chkdocs$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/replace$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/rebuild$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/mkprntoc$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/mkerrlst$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/delextra$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/mkimglst$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/getimage$(EXEEXT)

#ifdef HAVE_APSPELL
FBCHKDOC_BINS += fbchkdoc/spellit$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/spell$(EXEEXT)
#endif

FBCHKDOC_BINS += fbchkdoc/samps$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/pretty$(EXEEXT)

MAKEFBHELP_MAKE := makefbhelp/makefile
MAKEFBHELP_SRCS := $(wildcard makefbhelp/*.bas)
MAKEFBHELP_HDRS := $(wildcard makefbhelp/*.bi)
MAKEFBHELP_BINS := makefbhelp/makefbhelp$(EXEEXT) 

.PHONY: clean
all: $(FBDOC_BINS) $(FBCHKDOC_BINS) $(MAKEFBHELP_BINS)

$(FBDOC_BINS): $(FBDOC_SRCS) $(FBDOC_HDRS) $(FBDOC_MAKE) $(LIBFBDOC_BINS) 
	cd fbdoc && $(MAKE) FBC="$(FBC)" $(MAKEOPTS)

$(LIBFBDOC_BINS): $(LIBFBDOC_SRCS) $(LIBFBDOC_HDRS) $(LIBFBDOC_MAKE) 
	cd libfbdoc && $(MAKE) FBC="$(FBC)" $(MAKEOPTS)

$(FBCHKDOC_BINS): $(FBCHKDOC_SRCS) $(FBCHKDOC_HDRS) $(FBCHKDOC_MAKE) $(LIBFBDOC_BINS)
	cd fbchkdoc && make FBC="$(FBC)" $(MAKEOPTS)

$(MAKEFBHELP_BINS): $(MAKEFBHELP_SRCS) $(MAKEFBHELP_HDRS) $(MAKEFBHELP_MAKE)
	cd makefbhelp && $(MAKE) FBC="$(FBC)" $(MAKEOPTS)

.PHONY: clean
clean:
	cd fbdoc && $(MAKE) clean HAVE_ASPELL=1 HAVE_MYSQL=1
	cd fbchkdoc && $(MAKE) clean HAVE_ASPELL=1 HAVE_MYSQL=1
	cd makefbhelp && $(MAKE) clean HAVE_ASPELL=1 HAVE_MYSQL=1
	cd libfbdoc && $(MAKE) clean HAVE_ASPELL=1 HAVE_MYSQL=1
