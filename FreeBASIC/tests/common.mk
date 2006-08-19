
FBC := fbc
ifeq ($(MAKELEVEL),0)
	FBC := ../$(FBC)
else
	FBC := ../../$(FBC)
endif

FBFLAGS := -exx -g
ifdef FIXME
	FBFLAGS+= -d FIXME=1
endif

FBCMPFLAGS := $(FBFLAGS) -c
FBLNKFLAGS := 

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
    FBLNKFLAGS += -l user32
endif

ifeq ($(TARGET),linux)
    EXEEXT := .test
endif

ifeq ($(TARGET),cygwin)
    EXEEXT := .exe
endif

ifeq ($(TARGET),dos)
    EXEEXT := .exe
endif
