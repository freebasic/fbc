##########################

ifeq (,$(findstring $(TARGET),dos linux win32))
$(error need TARGET=dos | linux | win32)
endif

MAIN := fbdoc

SRCS := $(MAIN).bas 
SRCS += fbdoc_misc.bas
SRCS += CFbCode.bas
SRCS += fbdoc_lang.bas
SRCS += fbdoc_loader.bas
SRCS += fbdoc_templates.bas
SRCS += fbdoc_keywords.bas
SRCS += COptions.bas
SRCS += CWakka2Html.bas
SRCS += CWiki2Chm.bas
SRCS += CHttp.bas 
SRCS += CHttpForm.bas 
SRCS += CHttpStream.bas
SRCS += CWikiCon.bas
SRCS += CWiki.bas
SRCS += CRegex.bas
SRCS += list.bas
SRCS += common.bas
SRCS += CWikiCache.bas
SRCS += CPage.bas
SRCS += CPageList.bas

ifndef objpath
objpath=obj/$(TARGET)
endif

OBJS := $(patsubst %.bas,$(objpath)/%.o,$(SRCS))

ifneq ($(LIBDIR),)
LIBS := -p $(LIBDIR)/$(TARGET)
else
LIBS :=
endif

ifeq ($(TARGET),win32)
LIBS += -l curl-3 -l pcre -l mysql
else
LIBS += -l curl -l pcre	-l mysql
endif

RCS  := 

##########################

ifndef FBC
	ifeq ($(TARGET),win32)
		FBC = fbc.exe
	else
		FBC = fbc
	endif
endif

FBCFLAGS :=

#ifdef DEBUG
FBCFLAGS += -exx -g
#endif

ifeq ($(TARGET),win32)
APP := $(MAIN).exe
else
APP := $(MAIN)
endif

.SUFFIXES:
.SUFFIXES: .bas

VPATH = .

$(objpath)/%.o : %.bas
	$(FBC) $(FBCFLAGS) -m $(MAIN) -c $< -o $@

##########################

all: $(APP)

$(APP): $(OBJS)
	$(FBC) $(FBCFLAGS) $(OBJS) $(LIBS) $(RCS) -x $(APP)

fbdoc.chm:
	hhc.exe html/fbdoc.hhp

.PHONY : clean
clean:
	-rm -f $(OBJS) $(APP)
