#
# make file to build FB's Run-Time Library
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
    CFLAGS := -O3
    #-fssa -- GCC's manual states it's not stable enough??
else
    ifdef COMPILER
        CFLAGS := -O3 -DDISABLE_NCURSES
    else
        CFLAGS := -O3
    endif
endif

libpath = ../../lib
lib = $(libpath)/libfb.a

objects := $(patsubst %.c,obj/%.o,$(wildcard *.c))
          
obj/%.o : %.c
	$(CC) -c $(CFLAGS) $? -o $@

all : $(objects) $(lib) fb.h

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
