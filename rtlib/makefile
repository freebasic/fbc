#
# make file to build FB's Run-Time Library
# needs GNU make and GCC
#

CC := gcc
CFLAGS := -O3 
#-fssa -- GCC's manual states it's not stable enough??

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
	del $(subst /,\,$(lib))
	del $(subst /,\,$(objects))
     
