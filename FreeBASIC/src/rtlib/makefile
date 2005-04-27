#
# make file to build FB's Run-Time Library
# needs GNU make and GCC
# set OS env var to DOS to build DOS rtlib
#

ifeq ($(OS),Windows_NT)
    WINSYSDIR = $(SYSTEMROOT)
    ifeq ($(WINSYSDIR),)
        WINSYSDIR = $(SystemRoot)
    endif
else
    WINSYSDIR = $(WINDIR)
    ifeq ($(WINSYSDIR),)
        WINSYSDIR = $(windir)
    endif
endif

ifeq ($(OS),DOS)
    WINSYSDIR =
endif

CC := gcc
CFLAGS := -O2 -ffast-math -Wall -Wno-format -I .
ifneq ($(WINSYSDIR),)
    CFLAGS := $(CFLAGS) -DTARGET_WIN32 -DTARGET_X86
    osdeppath := win32
	libpath = ../../lib/win32
else
    ifeq ($(OS),DOS)
        CFLAGS := $(CFLAGS) -DTARGET_DOS -DTARGET_X86
        osdeppath := dos
        libpath = ../../lib/dos
    else
        CFLAGS := $(CFLAGS) -DTARGET_LINUX -DTARGET_X86
        osdeppath := linux
        libpath = ../../lib
    endif
endif

ifneq ($(MULTITHREADED),)
	CFLAGS += -DMULTITHREADED
	lib = $(libpath)/libfbmt.a
	objpath = obj/$(osdeppath)/mt
else
	lib = $(libpath)/libfb.a
	objpath = obj/$(osdeppath)
endif

objects := $(patsubst %.c,$(objpath)/%.o,$(wildcard *.c))
osdepobjs := $(patsubst $(osdeppath)/%.c,$(objpath)/%.o,$(wildcard $(osdeppath)/*.c))
osdepobjs += $(patsubst $(osdeppath)/%.s,$(objpath)/%.o,$(wildcard $(osdeppath)/*.s))
headers := $(wildcard *.h)

$(objpath)/%.o : %.c $(headers)
	$(CC) -c $(CFLAGS) $< -o $@

$(objpath)/%.o : $(osdeppath)/%.c $(headers)
	$(CC) -c $(CFLAGS) $< -o $@

$(objpath)/%.o : %.s $(headers)
	$(AS) $< -o $@

$(objpath)/%.o : $(osdeppath)/%.s $(headers)
	$(AS) $< -o $@

all : $(objects) $(osdepobjs) $(lib)

$(lib) : $(objects) $(osdepobjs)
	$(AR) cr $(lib) $(objects) $(osdepobjs)


.PHONY : clean
clean :
	rm -f $(lib)
	rm -f $(objects)
	rm -f $(osdepobjs)
