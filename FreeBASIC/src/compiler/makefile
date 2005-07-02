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
		else
		ifdef HOME
			HOST := linux
		endif
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
FBCFLAGS := -e -c -arch 486
ifdef DEBUG
FBCFLAGS += -g
endif

ifndef LDLIBS_EXT
LDLIBS_EXT :=
endif

ifeq ($(HOST),win32)
    FBC := ../../fbc.exe
endif

ifeq ($(HOST),linux)
    FBC := fbc
endif

ifeq ($(HOST),dos)
    FBC := ../../fbc.exe
endif


ifeq ($(TARGET),win32)
    OSDEPPATH := win32
    EXE := .exe
    FBCFLAGS += -d TARGET_WIN32
    LDFLAGS := -T ../../bin/win32/i386pe.x -subsystem console -e fb_fbc_entry --stack 2097152,2097152
    LDLIBS := -L../../lib/win32 -\( -lmsvcrt -lfb -lkernel32 $(LDLIBS_EXT) -\)
    LD := ../../bin/win32/ld.exe
    AS := ../../bin/win32/as.exe
endif

ifeq ($(TARGET),linux)
    OSDEPPATH := linux
    EXE :=
    FBCFLAGS += -d TARGET_LINUX
    LDLIBS := -L../../lib/linux -\( -lc -lm -lfb -lpthread $(LDLIBS_EXT) -\)
	ifeq ($(HOST),win32)
    	LDFLAGS := -T ../../bin/linux/elf_i386.x -e fb_fbc_entry
    	LD := ../../bin/linux/ld.exe
    	AS := ../../bin/linux/as.exe
	else
    	LDFLAGS := -dynamic-linker /lib/ld-linux.so.2 -e fb_fbc_entry
    	LD := ld
    	AS := as
	endif
endif

ifeq ($(TARGET),dos)
    OSDEPPATH := dos
    EXE := .exe
    FBCFLAGS += -d TARGET_DOS
    LDFLAGS := -T ../../bin/dos/i386go32.x ../../lib/dos/crt0.o
    LDLIBS := -L../../lib/dos -( -lfb -lc $(LDLIBS_EXT) -)
    LD := ../../bin/dos/ld.exe
    AS := ../../bin/dos/as.exe
endif

ifndef DEBUG
	LDFLAGS += -s
endif

ifeq ($(HOST),win32)
	FBCFLAGS += -target $(TARGET)
endif

ifndef OSDEPPATH
	CHECKTARGET_MSG := $(error error: TARGET not supported)  
else
	CHECKTARGET_MSG :=
endif

ifdef FBCFLAGS_EXT
FBCFLAGS += $(FBCFLAGS_EXT)
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
	$(FBC) $(FBCFLAGS) $< -o $@

obj/$(OSDEPPATH)/%.o : $(OSDEPPATH)/%.bas $(headers)
	$(FBC) $(FBCFLAGS) $< -o $@

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
