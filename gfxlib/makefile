#
# make file to build FB's GFX Library
# needs GNU make and GCC
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

CC := gcc
ifneq ($(WINSYSDIR),)
    CFLAGS := -Wall -O3 -march=i586 -mcpu=i686
    #-fssa -- GCC's manual states it's not stable enough??
else
    CFLAGS := -Wall -O3 -march=i586 -mcpu=i686
endif

libpath = ../../lib
lib = $(libpath)/libfbgfx.a

objects := $(patsubst %.c,obj/%.o,$(wildcard *.c))

obj/%.o : %.c
	$(CC) -c $(CFLAGS) $? -o $@

all : $(objects) $(lib) ../rtlib/fb.h

$(lib) : $(objects)
	$(AR) cr $(lib) $(objects)


.PHONY : clean
clean :
ifneq ($(WINSYSDIR),)
	del $(subst /,\,$(lib))
	del $(subst /,\,$(objects))
else
	rm -f $(lib)
	rm -f $(objects)
endif
