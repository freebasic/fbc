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
else
    ifeq ($(OS),DOS)
        osdeppath := dos
        CFLAGS := $(CFLAGS) -DTARGET_DOS
    else
        osdeppath := linux
        CFLAGS := $(CFLAGS) -DTARGET_LINUX
        ifdef COMPILER
            CFLAGS := $(CFLAGS) -DDISABLE_NCURSES
        endif
    endif
endif

libpath = ../../lib
lib = $(libpath)/libfb.a
ifeq ($(WINSYSDIR),)
    ifneq ($(OS),DOS)
        ifdef COMPILER
            lib := $(libpath)/libfb-nocurses.a
        endif
    endif
endif

objects := $(patsubst %.c,obj/%.o,$(wildcard *.c))
osdepobjs := $(patsubst $(osdeppath)/%.c,obj/%.o,$(wildcard $(osdeppath)/*.c))


obj/%.o : %.c
	$(CC) -c $(CFLAGS) $? -o $@

obj/%.o : $(osdeppath)/%.c
	$(CC) -c $(CFLAGS) $? -o $@


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
	rm -f $(lib)
	rm -f $(objects)
	rm -f $(osdepobjs)
endif
