#
# make file to build FBC tests
#
# needed: GNU make, GAS, LD and FBC itself
#
# set TARGET to dos, win32 or linux -- if not defined, it will
# be the same as HOST, if the later could be guessed
#

##################################################################



FBC := ../fbc
FBCMPFLAGS := -exx -g

ifdef FIXME
	FBCMPFLAGS+= -d FIXME=1
endif

HOST :=
ifeq ($(OS),DOS)
	HOST := dos
else
	ifeq ($(OS),Windows_NT)
   		HOST := win32
	else
   		ifdef WINDIR
   			HOST := win32
		else
       		ifdef windir
       			HOST := win32
		else
		ifdef HOME
			HOST := linux
		endif
       		endif
   		endif
	endif
endif

ifndef TARGET
	ifndef HOST
		CHECKHOST_MSG := $(error error: TARGET not defined and HOST couldn't be guessed)
	else
		CHECKHOST_MSG :=
	endif
	TARGET := $(HOST)
endif

ifeq ($(TARGET),win32)
    EXEEXT := .exe
endif

ifeq ($(TARGET),linux)
    EXEEXT :=
endif

ifeq ($(TARGET),cygwin)
    EXEEXT := .exe
endif

ifeq ($(TARGET),dos)
    EXEEXT := .exe
endif

DIRLIST := console data datetime dim file numbers overload string

EXELIST := $(patsubst %.bas,%$(EXEEXT),$(foreach i,$(DIRLIST),$(wildcard $(i)/*.bas)))

RUNLIST := $(foreach i,$(EXELIST),echo [$(subst %$(EXEEXT),,$(i))] && $(i) &&) cd .

VPATH = $(DIRLIST)

all: run_tests

.PHONY : run_tests
run_tests: $(EXELIST)
	$(RUNLIST)

%$(EXEEXT): %.bas
	$(FBC) $(FBCMPFLAGS) -x $@ $^

.PHONY : clean
clean:
	rm -f $(EXELIST) $(patsubst %$(EXEEXT),%.o,$(EXELIST))


