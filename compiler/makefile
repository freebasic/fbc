#
# make file to build FBC
# needs GNU make and FBC itself
# set OS env var to DOS to build for DOS
#

PLATFORM =

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
    PLATFORM = DOS
endif

ifneq ($(WINSYSDIR),)
    PLATFORM = WIN32
else
    PLATFORM = LINUX
endif

ifeq ($(PLATFORM),WIN32)
    EXE := .exe
    LDFLAGS := -T ../../bin/i386pe.x -s -subsystem console -e fb_fbc_entry --stack 2097152,2097152
    LDLIBS := -L../../lib -( -lcrtdll -lfb -lkernel32 -luser32 -)
    BC := ..\..\fbc.exe
    BCFLAGS := -e -c -d TARGET_WIN32
    LD := ..\..\bin\ld.exe
endif

ifeq ($(PLATFORM),LINUX)
    EXE :=
    LDFLAGS := -dynamic-linker /lib/ld-linux.so.2 -s -e fb_fbc_entry
    LDLIBS := -L../../lib -\( -lc -lm -lfb-nocurses -\)
    BC := ../../fbc
    BCFLAGS := -e -c -d TARGET_LINUX
    LD := ld
endif

ifeq ($(PLATFORM),DOS)
    EXE :=
    LDFLAGS := -T ../../bin/i386go32.x -s
    LDLIBS := -L../../lib -( -lcrt -lfb -)
    BC := ..\..\fbc.exe
    BCFLAGS := -e -c -d TARGET_DOS
    LD := ..\..\bin\ld.exe
endif


main	:= fbc.bas

exepath = ../..
TARGET = $(exepath)/$(subst .bas,_new$(EXE),$(main))

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
ifeq ($(PLATFORM),WIN32)
	del $(subst /,\,$(TARGET))
	del $(subst /,\,$(objects))
else
    ifeq ($(PLATFORM),DOS)
	del $(subst /,\,$(TARGET))
	del $(subst /,\,$(objects))
    else
	rm -f $(TARGET)
	rm -f $(objects)
    endif
endif
