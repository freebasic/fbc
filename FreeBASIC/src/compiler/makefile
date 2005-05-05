#
# make file to build FBC
#
# needed: GNU make, GAS, LD and FBC itself
#
# set TARGET to dos, win32 or linux -- if not defined, it will 
# be the same as HOST, if the later could be guessed
#

##################################################################

HOST :=
ifeq ($(OS),DOS)
	HOST := dos
else
	ifeq ($(OS),Windows_NT)
   		HOST := win32
	else
   		ifdef WINDIR
   			HOST := win32
		else
       		ifdef windir
       			HOST := win32
       		endif
   		endif
	endif
endif

ifndef TARGET
	ifndef HOST
		CHECKHOST_MSG := $(error error: TARGET not defined and HOST couldn't be guessed)
	else
		CHECKHOST_MSG :=
	endif
	TARGET := $(HOST)
endif


##################################################################

OSDEPPATH :=
BCFLAGS := -e -c -arch 486

ifeq ($(HOST),win32)
    BC := ../../fbc.exe
endif

ifeq ($(HOST),linux)
    BC := fbc
endif

ifeq ($(HOST),dos)
    BC := ../../fbc.exe
endif


ifeq ($(TARGET),win32)
    EXE := .exe
    BCFLAGS := $(BCFLAGS) -d TARGET_WIN32
    OSDEPPATH := win32
    LDFLAGS := -T ../../bin/win32/i386pe.x -s -subsystem console -e fb_fbc_entry --stack 2097152,2097152
    LDLIBS := -L../../lib/win32 -\( -lmsvcrt -lfb -lkernel32 -\)
    LD := ../../bin/win32/ld.exe
    AS := ../../bin/win32/as.exe
endif

ifeq ($(TARGET),linux)
    EXE :=
    BCFLAGS := $(BCFLAGS) -d TARGET_LINUX
    OSDEPPATH := linux
    LDLIBS := -L../../lib/linux -\( -lc -lm -lfb -\)
	ifeq ($(HOST),win32)
    	LDFLAGS := -T ../../bin/linux/elf_i386.x -s -e fb_fbc_entry
    	LD := ../../bin/linux/ld.exe
    	AS := ../../bin/linux/as.exe
	else
    	LDFLAGS := -dynamic-linker /lib/ld-linux.so.2 -s -e fb_fbc_entry
    	LD := ld
    	AS := as
	endif
endif

ifeq ($(TARGET),dos)
    EXE := .exe
    BCFLAGS := $(BCFLAGS) -d TARGET_DOS
    OSDEPPATH := dos
    LDFLAGS := -T ../../bin/dos/i386go32.x -s ../../lib/dos/crt0.o
    LDLIBS := -L../../lib/dos -( -lfb -lc -)
    LD := ../../bin/dos/ld.exe
    AS := ../../bin/dos/as.exe
endif

ifneq ($(TARGET),$(HOST))
 	BCFLAGS += -target $(TARGET)
endif

ifndef OSDEPPATH
	CHECKTARGET_MSG := $(error error: TARGET not supported)  
else
	CHECKTARGET_MSG :=
endif

##################################################################

main	:= fbc.bas

exepath = ../..
compiler = $(exepath)/$(subst .bas,_new$(EXE),$(main))

sources := $(wildcard *.bas)

objects := $(patsubst %.bas,obj/$(OSDEPPATH)/%.o,$(main) $(filter-out $(main),$(sources)))
osdepobjs := $(patsubst $(OSDEPPATH)/%.bas,obj/$(OSDEPPATH)/%.o,$(wildcard $(OSDEPPATH)/*.bas))
osdepobjs += $(patsubst $(OSDEPPATH)/%.s,obj/$(OSDEPPATH)/%.o,$(wildcard $(OSDEPPATH)/*.s))
headers := $(wildcard inc/*.bi)

##################################################################

all : checkhost checktarget $(compiler)

obj/$(OSDEPPATH)/%.o : %.bas $(headers)
	$(BC) $(BCFLAGS) $< -o $@

obj/$(OSDEPPATH)/%.o : $(OSDEPPATH)/%.bas $(headers)
	$(BC) $(BCFLAGS) $< -o $@

obj/$(OSDEPPATH)/%.o : %.s $(headers)
	$(AS) $< -o $@

obj/$(OSDEPPATH)/%.o : $(OSDEPPATH)/%.s $(headers)
	$(AS) $< -o $@

$(compiler) : $(objects) $(osdepobjs)
	$(LD) $(LDFLAGS) $(objects) $(osdepobjs) -o $@ $(LDLIBS)


.PHONY: checktarget
checktarget : ; $(CHECKTARGET_MSG)

.PHONY: checkhost
checkhost : ; $(CHECKHOST_MSG)


.PHONY : clean
clean :
	rm -f $(objects)
	rm -f $(osdepobjs)
	rm -f $(compiler)
