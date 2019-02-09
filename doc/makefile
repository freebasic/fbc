OS := $(shell uname)
ifeq ($(OS),Linux)
	EXEEXT :=
else
	EXEEXT := .exe
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
FBCHKDOC_BINS += fbchkdoc/spellit$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/spell$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/samps$(EXEEXT)
FBCHKDOC_BINS += fbchkdoc/pretty$(EXEEXT)

MAKEFBHELP_MAKE := makefbhelp/makefile
MAKEFBHELP_SRCS := $(wildcard makefbhelp/*.bas)
MAKEFBHELP_HDRS := $(wildcard makefbhelp/*.bi)
MAKEFBHELP_BINS := makefbhelp/makefbhelp$(EXEEXT) 

.PHONY: clean
all: $(FBDOC_BINS) $(FBCHKDOC_BINS) $(MAKEFBHELP_BINS)

$(FBDOC_BINS): $(FBDOC_SRCS) $(FBDOC_HDRS) $(FBDOC_MAKE) $(LIBFBDOC_BINS) 
	cd fbdoc && make FBC=$(FBC)

$(LIBFBDOC_BINS): $(LIBFBDOC_SRCS) $(LIBFBDOC_HDRS) $(LIBFBDOC_MAKE) 
	cd libfbdoc && make FBC=$(FBC)

$(FBCHKDOC_BINS): $(FBCHKDOC_SRCS) $(FBCHKDOC_HDRS) $(FBCHKDOC_MAKE) $(LIBFBDOC_BINS)
	cd fbchkdoc && make FBC=$(FBC)

$(MAKEFBHELP_BINS): $(MAKEFBHELP_SRCS) $(MAKEFBHELP_HDRS) $(MAKEFBHELP_MAKE)
	cd makefbhelp && make FBC=$(FBC)

.PHONY: clean
clean:
	cd fbdoc && make clean
	cd fbchkdoc && make clean
	cd makefbhelp && make clean
	cd libfbdoc && make clean
