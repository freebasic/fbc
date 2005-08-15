#
# make file to build FBC
#
# needed: GNU make, GAS, LD and FBC itself
#
# set TARGET to dos, win32 or linux -- if not defined, it will
# be the same as HOST, if the later could be guessed
#

##################################################################

HOST :=
ifeq ($(OS),Windows_NT)
    HOST := win32
else
    ifdef WINDIR
        ifeq ($(OSTYPE),cygwin)
            HOST := cygwin
        else
            HOST := win32
        endif
    else
        ifdef windir
            HOST := win32
        else
            ifdef HOME
                HOST := linux
            else
            	ifeq ($(OS),DOS)
                    HOST := dos
                endif
            endif
        endif
    endif
endif

ifdef DJGPP
    TARGET := dos
endif

ifndef TARGET
	ifndef HOST
		CHECKHOST_MSG := $(error Error: TARGET not defined and HOST couldn't be guessed)
	else
		CHECKHOST_MSG :=
	endif
	TARGET := $(HOST)
endif


##################################################################

OSDEPPATH :=
FBCMPFLAGS := -e -c -arch 486
FBLNKFLAGS := -v

ifdef DEBUG
    FBCMPFLAGS += -g -r
    FBLNKFLAGS += -g
endif
ifdef PROFILE
    FBCMPFLAGS += -profile
endif

ifndef LDLIBS_EXT
    LDLIBS_EXT :=
endif

ifeq ($(HOST),win32)
    FBC := ../../fbc.exe
endif

ifeq ($(HOST),linux)
    FBC := fbc
endif

ifeq ($(HOST),dos)
    FBC := ../../fbc.exe
endif


ifeq ($(TARGET),dos)
    OSDEPPATH := dos
    EXE := .exe
    FBLNKFLAGS += -d TARGET_DOS
    FBCMPFLAGS += -d TARGET_DOS
    osdepsrcs := fbc_dos.bas
endif

ifeq ($(TARGET),linux)
    OSDEPPATH := linux
    EXE :=
    FBLNKFLAGS += -d TARGET_LINUX
    FBCMPFLAGS += -d TARGET_LINUX
    osdepsrcs := fbc_linux.bas
endif

ifeq ($(TARGET),win32)
    OSDEPPATH := win32
    EXE := .exe
    FBLNKFLAGS += -d TARGET_WIN32 -t 2048 -l winspool
    FBCMPFLAGS += -d TARGET_WIN32
    FBCMPFLAGS += -d CROSSCOMP_DOS -d CROSSCOMP_XBOX -d CROSSCOMP_LINUX -d CROSSCOMP_CYGWIN
    osdepsrcs := fbc_win32.bas fbc_dos.bas fbc_linux.bas fbc_xbox.bas fbc_cyg.bas
endif

ifeq ($(TARGET),cygwin)
    OSDEPPATH := win32
    OSOBJPATH := cygwin
    EXE := .exe
    FBLNKFLAGS += -d TARGET_CYGWIN
    FBCMPFLAGS += -d TARGET_CYGWIN
    osdepsrcs := fbc_cyg.bas
endif

ifeq ($(TARGET),xbox)
    OSDEPPATH := xbox
    EXE := .exe
    FBLNKFLAGS += -d TARGET_XBOX
    FBCMPFLAGS += -d TARGET_XBOX
    osdepsrcs := fbc_xbox.bas
endif

ifneq ($(HOST),$(TARGET))
    FBCMPFLAGS += -target $(TARGET)
    FBLNKFLAGS += -target $(TARGET)
endif

ifndef OSOBJPATH
    OSOBJPATH = $(OSDEPPATH)
endif

ifndef OSDEPPATH
    CHECKTARGET_MSG := $(error Error: TARGET not supported)
else
    CHECKTARGET_MSG :=
endif

ifdef FBCMPFLAGS_EXT
    FBCMPFLAGS += $(FBCMPFLAGS_EXT)
endif

##################################################################

main	:= fbc.bas

exepath = ../..
compiler = $(exepath)/$(subst .bas,_new$(EXE),$(main))

sources := $(main) ast.bas edbg_stab.bas emit.bas emit_x86.bas fb.bas
sources += flist.bas hash.bas hlp.bas ir.bas lex.bas lexpp.bas list.bas
sources += parser1.bas parser2.bas parser3.bas parser4.bas parser5.bas parser6.bas parser7.bas
sources += reg.bas rtl.bas symb.bas
sources += $(osdepsrcs)

objpath = obj/$(OSOBJPATH)

objects := $(patsubst %.bas,$(objpath)/%.o,$(sources))
headers := $(wildcard inc/*.bi)


FBCMPFLAGS += -m $(subst .bas,,$(main))

##################################################################

all : checkhost checktarget checkdirs $(compiler)

$(objpath)/%.o : %.bas $(headers)
	$(FBC) $(FBCMPFLAGS) $< -o $@

$(compiler) : $(objects)
	$(FBC) $(FBLNKFLAGS) $(objects) -x $@ $(LDLIBS_EXT)

$(objpath) :
	mkdir -p $(objpath)

.PHONY: checktarget
checktarget : ; $(CHECKTARGET_MSG)

.PHONY: checkhost
checkhost : ; $(CHECKHOST_MSG)

.PHONY: checkdirs
checkdirs : $(objpath)


.PHONY : clean
clean :
	rm -f $(objects)
	rm -f $(compiler)
