#
# make file to build FBC
# needs GNU make and FBC itself
#

main	:= fbc.bas

exepath = ../..
exe = $(exepath)/$(subst .bas,.exe,$(main))

BC := ..\..\fbc32.exe
BCFLAGS := -e -c

LD := ld.exe
LDFLAGS := -T ../../bin/i386pe.x -s -subsystem console -e fb_fbc_entry --stack 2097152,2097152
LDLIBS := -L../../lib -( -lcrtdll -lfb -lkernel32 -luser32 -)

sources := $(wildcard *.bas)
objects := $(patsubst %.bas,obj/%.o,$(main) $(filter-out $(main),$(sources)))
headers := $(wildcard inc/*.bi)

obj/%.o : %.bas
	$(BC) $(BCFLAGS) $? -o $@

all : $(exe)

$(exe) : $(objects)
	$(LD) $(LDFLAGS) $(objects) -o $@ $(LDLIBS)


.PHONY : clean
clean :
	del $(subst /,\,$(exe))
	del $(subst /,\,$(objects))
