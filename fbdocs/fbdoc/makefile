##########################

ifeq (,$(findstring $(TARGET),linux win32))
$(error need TARGET=linux | win32)
endif

MAIN := fbdoc

SRCS := CWakka2texinfo.bas
SRCS += CWiki2texinfo.bas
SRCS += CWiki2txt.bas
SRCS += CWiki2fbhelp.bas
SRCS += CWakka2fbhelp.bas
SRCS += CFbCode.bas
SRCS += fbdoc_lang.bas
SRCS += fbdoc_cache.bas
SRCS += fbdoc_loader.bas
SRCS += fbdoc_loader_web.bas
SRCS += fbdoc_buildtoc.bas
SRCS += fbdoc_templates.bas
SRCS += fbdoc_keywords.bas
SRCS += fbdoc_string.bas
SRCS += fbdoc_misc.bas
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
SRCS += CWikiCache.bas
SRCS += CPage.bas
SRCS += CPageList.bas
SRCS += hash.bas
SRCS += printlog.bas

ifdef HAVE_MYSQL
SRCS += fbdoc_loader_sql.bas
endif

HDRS := $(wildcard *.bi)

ifndef objpath
objpath=obj/$(TARGET)
endif

OBJS := $(patsubst %.bas,$(objpath)/%.o,$(MAIN).bas)
LIB_OBJS := $(patsubst %.bas,$(objpath)/%.o,$(SRCS))

RCS  := 

##########################

AR := ar
RANLIB := ranlib
HHC := hhc.exe

ifndef FBC
	ifeq ($(TARGET),win32)
		FBC = fbc.exe
	else
		FBC = fbc
	endif
endif

FBCFLAGS += -w pedantic -w next

ifdef DEBUG
FBCFLAGS += -exx -g
endif

ifdef PROFILE
FBCFLAGS += -profile
endif

ifdef HAVE_MYSQL
FBCFLAGS += -d HAVE_MYSQL
endif

ifeq ($(TARGET),win32)
APP := $(MAIN).exe
APP2 := mkfbhelpfile.exe
else
APP := $(MAIN)
APP2 := mkfbhelpfile
endif

LIBNAME := lib$(MAIN).a

.SUFFIXES:
.SUFFIXES: .bas

VPATH = .

$(objpath)/%.o : %.bas $(HDRS)
	$(FBC) $(FBCFLAGS) -m $(MAIN) -c $< -o $@

##########################

all: $(APP) $(APP2) $(LIBNAME)

$(APP): $(OBJS) $(LIB_OBJS)
	$(FBC) $(FBCFLAGS) $(OBJS) $(LIB_OBJS) $(LIBS) $(RCS) -x $(APP)

$(APP2): mkfbhelpfile.bas
	$(FBC) $(FBCFLAGS) mkfbhelpfile.bas -x $(APP2)

$(LIBNAME): $(LIB_OBJS)
	$(AR) cr $(LIBNAME) $(LIB_OBJS)
	$(RANLIB) $(LIBNAME)

html/fbdoc.chm: $(APP)
	-$(HHC) html\\fbdoc.hhp

.PHONY : clean
clean:
	-rm -f $(LIB_OBJS) $(OBJS) $(APP)
	-rm -f $(objpath)/mkfbhelpfile.o $(APP2)
	-rm -f $(LIBNAME)
