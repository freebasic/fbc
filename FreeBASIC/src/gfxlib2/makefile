#
# make file to build FB's Gfx Library
# needs GNU make and GCC
# set OS env var to DOS to build DOS gfxlib
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
CFLAGS := -O2 -ffast-math -Wall -I .
AFLAGS := -x assembler-with-cpp
ifneq ($(WINSYSDIR),)
    CFLAGS := $(CFLAGS) -DTARGET_WIN32
    AFLAGS += -DTARGET_WIN32
    osdeppath := win32
	libpath = ../../lib/win32
else
    ifeq ($(OS),DOS)
        CFLAGS := $(CFLAGS) -DTARGET_DOS
        AFLAGS += -DTARGET_DOS
        osdeppath := dos
        libpath = ../../lib/dos
    else
        CFLAGS := $(CFLAGS) -DTARGET_LINUX
        AFLAGS += -DTARGET_LINUX
        osdeppath := linux
        libpath = ../../lib
    endif
endif

lib = $(libpath)/libfbgfx.a

objects := $(patsubst %.c,obj/$(osdeppath)/%.o,$(wildcard *.c))
objects += $(patsubst %.s,obj/$(osdeppath)/%.o,$(wildcard *.s))
osdepobjs := $(patsubst $(osdeppath)/%.c,obj/$(osdeppath)/%.o,$(wildcard $(osdeppath)/*.c))
osdepobjs := $(patsubst $(osdeppath)/%.s,obj/$(osdeppath)/%.o,$(wildcard $(osdeppath)/*.s))
headers := $(wildcard *.h)
headers += $(wildcard $(osdeppath)/*.h)

obj/$(osdeppath)/%.o : %.c $(headers)
	$(CC) -c $(CFLAGS) $< -o $@

obj/$(osdeppath)/%.o : %.s $(headers)
	$(CC) -c $(AFLAGS) $< -o $@

obj/$(osdeppath)/%.o : $(osdeppath)/%.c $(headers)
	$(CC) -c $(CFLAGS) $< -o $@

obj/$(osdeppath)/%.o : $(osdeppath)/%.s $(headers)
	$(CC) -c $(AFLAGS) $< -o $@


all : $(objects) $(osdepobjs) $(lib)

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
endif
