#
# make file to build FBC
# needs GNU make and FBC itself
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

ifneq ($(WINSYSDIR),)
    EXE := .exe
    LDFLAGS := -T ../../bin/i386pe.x -s -subsystem console -e fb_fbc_entry --stack 2097152,2097152
    LDLIBS := -L../../lib -( -lcrtdll -lfb -lkernel32 -luser32 -)
    BC := ..\..\fbc.exe
    BCFLAGS := -e -c -d TARGET_WIN32
else
    EXE :=
    LDFLAGS := -dynamic-linker /lib/ld-linux.so.2 -s -e fb_fbc_entry
    LDLIBS := -L../../lib -\( -lc -lm -lfb -\)
    BC := ../../fbc
    BCFLAGS := -e -c -d TARGET_LINUX
endif


main	:= fbc.bas

exepath = ../..
TARGET = $(exepath)/$(subst .bas,_new$(EXE),$(main))

LD := ld$(EXE)

sources := $(wildcard *.bas)
objects := $(patsubst %.bas,obj/%.o,$(main) $(filter-out $(main),$(sources)))
headers := $(wildcard inc/*.bi)

obj/%.o : %.bas
	$(BC) $(BCFLAGS) $? -o $@

all : $(TARGET)

$(TARGET) : $(objects)
	$(LD) $(LDFLAGS) $(objects) -o $@ $(LDLIBS)


.PHONY : clean
clean :
ifneq ($(WINSYSDIR),)
	del $(subst /,\,$(TARGET))
	del $(subst /,\,$(objects))
else
	rm -f $(TARGET)
	rm -f $(objects)
endif
