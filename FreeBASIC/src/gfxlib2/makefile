#
# make file to build FB's alternative GFX Library
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
CFLAGS := -O3

ifneq ($(WINSYSDIR),)
    libpath := ../../lib/win32
else
    libpath := ../../lib/linux
endif
lib = $(libpath)/libfbgfx.a

objects := $(patsubst %.c,obj/%.o,$(wildcard *.c))
objects += $(patsubst %.s,obj/%.o,$(wildcard *.s))
          
obj/%.o : %.c
	$(CC) -c $(CFLAGS) $? -o $@

obj/%.o : %.s
	$(CC) -c -x assembler-with-cpp $? -o $@

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
     
