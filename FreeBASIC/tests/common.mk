
FBC := fbc
ifeq ($(MAKELEVEL),0)
	FBC := ../$(FBC)
else
	FBC := ../../$(FBC)
endif

FBCMPFLAGS := -exx -g -c
FBLNKFLAGS := -l fbx

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
    FBLNKFLAGS += -l user32
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
