#
# make file to build FBC tests
#
# needed: GNU make, GAS, LD and FBC itself
#
# set TARGET to dos, win32 or linux -- if not defined, it will 
# be the same as HOST, if the later could be guessed
#

##################################################################

ifndef FBC
FBC=../fbc
endif

ifndef FBCFLAGS
FBCFLAGS=-e -ex -g
endif

ifdef FIXIT
FBCFLAGS+= -d FIXIT=1
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

ifeq ($(TARGET),dos)
    EXEEXT := .exe
endif


TESTS=file/text_in$(EXEEXT) dim/submod$(EXEEXT) dim/cmmn_01$(EXEEXT)

all: $(TESTS) run_tests

clean:
	rm -f $(shell find . -iname "*~" -or -iname "*.bak" -or -iname "*.exe" -or -iname "*.o" -or -iname "*.a") $(TESTS)

run_tests:
	file/text_in
	dim/submod
	dim/cmmn_01

file/text_in$(EXEEXT): file/text_in.o
	$(FBC) $(FBCFLAGS) -x $@ $^

dim/submod$(EXEEXT): dim/submod_a.o dim/submod_b.o
	$(FBC) $(FBCFLAGS) -x $@ $^

dim/cmmn_01$(EXEEXT): dim/cmmn_01.o
	$(FBC) $(FBCFLAGS) -x $@ $^

dim/submod_a.bas: dim/submod_c.bi
dim/submod_b.bas: dim/submod_c.bi

%.o: %.bas
	$(FBC) $(FBCFLAGS) -c -o $@ $^
