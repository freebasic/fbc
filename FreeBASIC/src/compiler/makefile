#
# make file to build FBC
# needs GNU make and FBC itself
# set OS env var to DOS to build for DOS
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
    osdeppath := win32
else
    osdeppath := linux
endif

ifeq ($(OS),DOS)
    WINSYSDIR =
    osdeppath := dos
endif

BCFLAGS := -e -c -arch 486

ifeq ($(osdeppath),win32)
    EXE := .exe
    LDFLAGS := -T ../../bin/win32/i386pe.x -s -subsystem console -e fb_fbc_entry --stack 2097152,2097152
    LDLIBS := -L../../lib/win32 -\( -lmsvcrt -lfb -lkernel32 -\)
    BC := ../../fbc.exe
    BCFLAGS := $(BCFLAGS) -d TARGET_WIN32
    LD := ../../bin/win32/ld.exe
endif

ifeq ($(osdeppath),linux)
    EXE :=
    LDFLAGS := -dynamic-linker /lib/ld-linux.so.2 -s -e fb_fbc_entry
    LDLIBS := -L../../lib -\( -lc -lm -lfb -\)
    BC := ../../fbc
    BCFLAGS := $(BCFLAGS) -d TARGET_LINUX
    LD := ld
endif

ifeq ($(osdeppath),dos)
    EXE := .exe
    LDFLAGS := -T ../../bin/dos/i386go32.x -s ../../lib/dos/crt0.o obj/dos/fbcentry.o
    LDLIBS := -L../../lib/dos -( -lfb -lc -)
    BC := ..\..\fbc.exe
    BCFLAGS := $(BCFLAGS) -d TARGET_DOS -nostdcall
    LD := ..\..\bin\dos\ld.exe
endif

main	:= fbc.bas

exepath = ../..
TARGET = $(exepath)/$(subst .bas,_new$(EXE),$(main))

sources := $(wildcard *.bas)
objects := $(patsubst %.bas,obj/$(osdeppath)/%.o,$(main) $(filter-out $(main),$(sources)))
headers := $(wildcard inc/*.bi)

obj/$(osdeppath)/%.o : %.bas $(headers)
	$(BC) $(BCFLAGS) $< -o $@

all : $(TARGET)

$(TARGET) : $(objects)
	$(LD) $(LDFLAGS) $(objects) -o $@ $(LDLIBS)


.PHONY : clean
clean :
ifeq ($(osdeppath),win32)
	del $(subst /,\,$(objects))
	del $(subst /,\,$(TARGET))
else
ifeq ($(OS),DOS)
	del $(subst /,\,$(objects))
	del $(subst /,\,$(TARGET))
else
	rm -f $(objects)
	rm -f $(TARGET)
endif
endif
