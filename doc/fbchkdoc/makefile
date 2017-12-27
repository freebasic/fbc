OS := $(shell uname)
ifeq ($(OS),Linux)
	EXEEXT :=
else
	EXEEXT := .exe
endif

FBC := fbc

LIBFUNCS_SRC := \
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
    spellit$(EXEEXT) \
    spell$(EXEEXT) \
    samps$(EXEEXT) \
	pretty$(EXEEXT)

SAMPS_SRCS := \
    samps.bas \
    samps_wiki.bas \
    samps_file.bas \
    samps_logfile.bas

TEMP_FILES := \
    results.txt \
    PageIndex.txt \
    linklist.csv \
    samplist.log \
    fixlist.txt \
    timer.log \
    DocPages.txt \
    mkerrtxt$(EXEEXT) \
    mkerrtxt.bas \
    imagelist.txt \
    imagepages.txt

HEADERS := $(wildcard *.bi)
DEPS = ../libfbdoc/libfbdoc.a $(HEADERS)

FBCFLAGS += -exx -g -i ../libfbdoc
FBLFLAGS += -exx -g -p ../libfbdoc -l fbdoc

ifeq ($(EXEEXT),.exe)
  FBLFLAGS += -l ws2_32
endif

.PHONY: all
all: $(APPS) ../libfbdoc/libfbdoc.a

getindex$(EXEEXT): getindex.bas $(DEPS)
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

$(LIBFUNCS): $(LIBFUNCS_SRC) $(HEADERS)
	$(FBC) -lib -x $@ $(LIBFUNCS_SRC) $(FBCFLAGS)

../libfbdoc/libfbdoc.a:
	cd ../libfbdoc && make

.PHONY: clean
clean:
	-rm -f $(APPS)
	-rm -f $(LIBFUNCS)
	-rm -f $(TEMP_FILES)
