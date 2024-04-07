#!/usr/bin/make -f
#
# makes the documentation maintenance tools
#
# define's that can override build options
#
#   'HAVE_ASPELL=1' to indicate that spell check library is available
#   'FBC=d:/path/fbc to' to override path to execute fbc compiler 
#
# exported options
#
#   'HAVE_MYSQL=1' to indicate that mysql library is available
#   'USE_PCRE_STATIC=1' to indicate we should link with static version of libpcre
#

OS := $(shell uname)
ifeq ($(OS),Linux)
    EXEEXT :=
else
    EXEEXT := .exe
endif

ifndef MAKE
    MAKE := make
else
    export MAKE
endif

# when we build in sub directories, make sure we pass on the options
MAKEOPTS :=
ifdef HAVE_MYSQL
    MAKEOPTS += HAVE_MYSQL=1
endif 
ifdef USE_PCRE_STATIC
    MAKEOPTS += USE_PCRE_STATIC=1
endif 

# if we have to build libfbdoc, make sure we export options
export HAVE_MYSQL
export USE_PCRE_STATIC

FBC := fbc

LIBFUNCS_SRC := \
    cmd_opts.bas \
    funcs.bas \
    funcsdir.bas \
    fmtcode.bas \
    buffer.bas

LIBFUNCS := libfuncs.a

APPS := \
    getindex$(EXEEXT) \
    getpage$(EXEEXT) \
    putpage$(EXEEXT) \
    chkdocs$(EXEEXT) \
    replace$(EXEEXT) \
    rebuild$(EXEEXT) \
    mkprntoc$(EXEEXT) \
    mkerrlst$(EXEEXT) \
    delextra$(EXEEXT) \
    mkimglst$(EXEEXT) \
    getimage$(EXEEXT) \
    samps$(EXEEXT) \
    pretty$(EXEEXT) \
    insert$(EXEEXT)

ifdef HAVE_ASPELL
    APPS += spellit$(EXEEXT)
    APPS += spell$(EXEEXT)
endif

SAMPS_SRCS := \
    samps.bas \
    samps_wiki.bas \
    samps_file.bas \
    samps_logfile.bas

TEMP_FILES := \
    results.txt \
    PageIndex.txt \
    RecentChanges.txt \
    CacheIndex.txt \
    linklist.csv \
    samplist.log \
    fixlist.txt \
    timer.log \
    DocPages.txt \
    mkerrtxt$(EXEEXT) \
    mkerrtxt.bas \
    imagelist.txt \
    imagepages.txt \
    delete.html

HEADERS := $(wildcard *.bi)
DEPS = ../libfbdoc/libfbdoc.a $(HEADERS)

FBCFLAGS += -exx -g -i ../libfbdoc
FBLFLAGS += -exx -g -p ../libfbdoc -l fbdoc

ifdef HAVE_MYSQL
    FBCFLAGS += -d HAVE_MYSQL
    FBLFLAGS += -l mysql
endif

ifeq ($(EXEEXT),.exe)
  FBLFLAGS += -l ws2_32
endif

.PHONY: all
all: $(APPS) ../libfbdoc/libfbdoc.a

getindex$(EXEEXT): getindex.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

getpage$(EXEEXT): getpage.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

putpage$(EXEEXT): putpage.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

chkdocs$(EXEEXT): chkdocs.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

replace$(EXEEXT): replace.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

rebuild$(EXEEXT): rebuild.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

mkprntoc$(EXEEXT): mkprntoc.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

mkerrlst$(EXEEXT): mkerrlst.bas
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

delextra$(EXEEXT): delextra.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

mkimglst$(EXEEXT): mkimglst.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

getimage$(EXEEXT): getimage.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

spellit$(EXEEXT): spellit.bas spellcheck.bas
	$(FBC) $(FBCFLAGS) spellit.bas spellcheck.bas $(FBLFLAGS) -x $@

spell$(EXEEXT): spell.bas spellcheck.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) spell.bas spellcheck.bas $(FBLFLAGS) -x $@

samps$(EXEEXT): $(SAMPS_SRCS) $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $(SAMPS_SRCS) $(FBLFLAGS) -x $@

pretty$(EXEEXT): pretty.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

insert$(EXEEXT): insert.bas $(LIBFUNCS) $(DEPS)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

$(LIBFUNCS): $(LIBFUNCS_SRC) $(HEADERS)
	$(FBC) -lib -x $@ $(LIBFUNCS_SRC) $(FBCFLAGS)

../libfbdoc/libfbdoc.a:
	cd ../libfbdoc && $(MAKE) FBC="$(FBC)" $(MAKEOPTS)

.PHONY: clean
clean:
	-rm -f $(APPS)
	-rm -f $(LIBFUNCS)
	-rm -f $(TEMP_FILES)
