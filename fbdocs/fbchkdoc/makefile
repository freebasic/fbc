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

LIB_LIST := \
funcs.bas

LIB_NAME := libfuncs.a

APP_LIST := \
getindex$(EXEEXT) \
getpage$(EXEEXT) \
putpage$(EXEEXT) \
chkdocs$(EXEEXT) \
replace$(EXEEXT) \
rebuild$(EXEEXT) \
mkprntoc$(EXEEXT)

TEMP_FILES := \
results.txt \
PageIndex.txt \
linklist.csv \
samplist.log \
fixlist.txt \
timer.log \
DocPages.txt

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

$(LIB_NAME): $(LIB_LIST) $(HEADERS)
	$(FBC) -lib -x funcs $(LIB_LIST) $(FBCFLAGS)

##########################

.PHONY : clean
clean:
	-rm -f $(APP_LIST)
	-rm -f $(LIB_NAME)
	-rm -f $(TEMP_FILES)
