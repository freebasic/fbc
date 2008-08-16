## makefile for fbchkdoc 
##
## this has only ever been used on win32 platform
## and needs to modified/tested for other platforms
##

ifndef FBDOCDIR
FBDOCDIR := ../fbdoc
endif

EXEEXT := .exe
FBC := fbc$(EXEEXT)

##########################

LIB_SRCS := \
funcs.bas \
funcsdir.bas \
fmtcode.bas \
buffer.bas

LIB_NAME := libfuncs.a

APP_LIST := \
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
samps$(EXEEXT)

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
DEP_LIST = $(FBDOCDIR)/libfbdoc.a $(HEADERS)

FBCFLAGS := -w pedantic -w next

ifdef DEBUG
FBCFLAGS += -g
endif

ifdef PROFILE
FBCFLAGS += -profile
endif

FBCFLAGS += -w 0 -i $(FBDOCDIR) -exx
FBLFLAGS := -p $(FBDOCDIR) -l fbdoc 

.SUFFIXES:
.SUFFIXES: .bas

VPATH = .

##########################

all: $(APP_LIST) $(FBDOCDIR)/libfbdoc.a

getindex$(EXEEXT): getindex.bas $(DEP_LIST)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

getpage$(EXEEXT): getpage.bas $(LIB_NAME) $(DEP_LIST)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

putpage$(EXEEXT): putpage.bas $(LIB_NAME) $(DEP_LIST)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

chkdocs$(EXEEXT): chkdocs.bas $(LIB_NAME) $(DEP_LIST)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

replace$(EXEEXT): replace.bas $(LIB_NAME) $(DEP_LIST)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

rebuild$(EXEEXT): rebuild.bas $(LIB_NAME) $(DEP_LIST)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

mkprntoc$(EXEEXT): mkprntoc.bas $(LIB_NAME) $(DEP_LIST)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

mkerrlst$(EXEEXT): mkerrlst.bas
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

delextra$(EXEEXT): delextra.bas $(LIB_NAME) $(DEP_LIST)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

mkimglst$(EXEEXT): mkimglst.bas $(LIB_NAME) $(DEP_LIST)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

getimage$(EXEEXT): getimage.bas $(LIB_NAME) $(DEP_LIST)
	$(FBC) $(FBCFLAGS) $< $(FBLFLAGS) -x $@

spellit$(EXEEXT): spellit.bas spellcheck.bas
	$(FBC) $(FBCFLAGS) spellit.bas spellcheck.bas $(FBLFLAGS) -x $@

spell$(EXEEXT): spell.bas spellcheck.bas $(LIB_NAME) $(DEP_LIST)
	$(FBC) $(FBCFLAGS) spell.bas spellcheck.bas $(FBLFLAGS) -x $@

samps$(EXEEXT): $(SAMPS_SRCS) $(LIB_NAME) $(DEP_LIST)
	$(FBC) $(FBCFLAGS) $(SAMPS_SRCS) $(FBLFLAGS) -x $@

$(LIB_NAME): $(LIB_SRCS) $(HEADERS)
	$(FBC) -lib -x funcs $(LIB_SRCS) $(FBCFLAGS)

##########################

.PHONY : clean
clean:
	-rm -f $(APP_LIST)
	-rm -f $(LIB_NAME)
	-rm -f $(TEMP_FILES)
