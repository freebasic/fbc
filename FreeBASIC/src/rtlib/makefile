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
CFLAGS := -O3 -I ./
ifneq ($(WINSYSDIR),)
    CFLAGS := $(CFLAGS) -DTARGET_WIN32
    osdeppath := win32
	libpath = ../../lib/win32
else
    ifeq ($(OS),DOS)
        CFLAGS := $(CFLAGS) -DTARGET_DOS
        osdeppath := dos
        libpath = ../../lib/dos
    else
        CFLAGS := $(CFLAGS) -DTARGET_LINUX
        osdeppath := linux
        libpath = ../../lib
    endif
endif

lib = $(libpath)/libfb.a

objects := $(patsubst %.c,obj/$(osdeppath)/%.o,$(wildcard *.c))
osdepobjs := $(patsubst $(osdeppath)/%.c,obj/$(osdeppath)/%.o,$(wildcard $(osdeppath)/*.c))


obj/$(osdeppath)/%.o : %.c
	$(CC) -c $(CFLAGS) $? -o $@

obj/$(osdeppath)/%.o : $(osdeppath)/%.c
	$(CC) -c $(CFLAGS) $? -o $@

obj/$(osdeppath)/%.o : %.s
	$(AS) $? -o $@


all : $(objects) $(osdepobjs) $(lib) fb.h

$(lib) : $(objects) $(osdepobjs)
	$(AR) cr $(lib) $(objects) $(osdepobjs)


.PHONY : clean
clean :
ifneq ($(WINSYSDIR),)
	del $(subst /,\,$(lib))
	del $(subst /,\,$(objects))
	del $(subst /,\,$(osdepobjs))
else
ifeq ($(OS),DOS)
	del $(subst /,\,$(lib))
	del $(subst /,\,$(objects))
	del $(subst /,\,$(osdepobjs))
else
	rm -f $(lib)
	rm -f $(objects)
	rm -f $(osdepobjs)
endif
endif
