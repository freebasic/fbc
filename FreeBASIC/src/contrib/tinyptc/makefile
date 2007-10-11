#
# make file to build FB's GFX Library
#
# needed: GNU make, GCC and AR
#
# set TARGET to dos, win32, linux, or xbox -- if not defined, it will 
# be the same as HOST, if the later could be guessed
#

NASM = nasm
##################################################################

HOST :=
ifdef DJGPP
    HOST := dos
else
    ifeq ($(OS),Windows_NT)
        ifeq ($(OSTYPE),cygwin)
            HOST := cygwin
        else
            HOST := win32
        endif
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
ifndef CC
    CC := gcc
endif
CFLAGS := -ffast-math -Wall -I .
AFLAGS := -x assembler-with-cpp
ifdef DEBUG
    CFLAGS += -g -O0
else
    CFLAGS += -O2
endif
NASMFLAGS :=
ifndef WINDOWED
    WINDOWED := 0
endif
ifeq ($(WINDOWED),1)
    ptc_win_ext :=-win
    CFLAGS += -DPTC_USE_WINDOW=1
else
    ptc_win_ext :=
endif

ifeq ($(TARGET),win32)
    OSDEPPATH := win32
    CFLAGS += -DTARGET_WIN32 -DTARGET_X86 -I ../../rtlib/obj/win32

    # !!! ASSUMES WIN32 RTLIB WAS ./configure'D AND DIRECTX HEADERS ARE IN MinGW's INCLUDE DIRECTORY
    CFLAGS += -I ../../rtlib
    
    AFLAGS += -DTARGET_WIN32
    NASMFLAGS += -f win32
endif
    
ifeq ($(TARGET),dos)
    OSDEPPATH := dos
    CFLAGS += -DTARGET_DOS -DTARGET_X86 -I ../../rtlib/obj/dos
    AFLAGS += -DTARGET_DOS
    NASMFLAGS += -f coff
endif
    
ifeq ($(TARGET),linux)
    OSDEPPATH := linux
    CFLAGS += -DTARGET_LINUX -DTARGET_X86 -I ../../rtlib/obj/linux
    AFLAGS += -DTARGET_LINUX
    NASMFLAGS += -f elf
endif

ifeq ($(TARGET),cygwin)
    OSDEPPATH := linux
    OSOBJPATH := cygwin
    CFLAGS += -DTARGET_CYGWIN -DTARGET_X86 -I ../../rtlib/obj/win32
    AFLAGS += -DTARGET_CYGWIN
    NASMFLAGS += -f win32
endif

ifeq ($(TARGET),xbox)
    OSDEPPATH := xbox
    CFLAGS += -DTARGET_XBOX -DTARGET_X86 -I ../../rtlib/obj/xbox
    SDLFLAGS := -DENABLE_XBOX -DDISABLE_CDROM
    CFLAGS += -std=gnu99 -ffreestanding -nostdlib -nostdinc -fno-builtin -fno-exceptions -mno-cygwin -march=i386 $(SDLFLAGS)
    CFLAGS += -I../../rtlib/xbox/inc -I../../rtlib/xbox/inc/SDL
    AFLAGS += -DTARGET_XBOX
    NASMFLAGS += -f win32
endif

ifndef DEBUG
    LDFLAGS += -s
endif

ifndef OSOBJPATH
    OSOBJPATH = $(OSDEPPATH)
endif

objpath = obj/$(OSOBJPATH)$(ptc_win_ext)

libpath = ../../../lib/$(TARGET)

ifndef libname
libname=tinyptc$(ptc_win_ext)
endif

lib = $(libpath)/lib$(libname).a

ifndef OSDEPPATH
    CHECKTARGET_MSG := $(error error: TARGET not supported)  
else
    CHECKTARGET_MSG :=
endif

##################################################################

objects := $(patsubst %.c,$(objpath)/%.o,$(wildcard *.c))
objects += $(patsubst %.s,$(objpath)/%.o,$(wildcard *.s))
objects += $(patsubst %.asm,$(objpath)/%.o,$(wildcard *.asm))
osdepobjs := $(patsubst $(OSDEPPATH)/%.c,$(objpath)/%.o,$(wildcard $(OSDEPPATH)/*.c))
osdepobjs += $(patsubst $(OSDEPPATH)/%.s,$(objpath)/%.o,$(wildcard $(OSDEPPATH)/*.s))
osdepobjs += $(patsubst $(OSDEPPATH)/%.asm,$(objpath)/%.o,$(wildcard $(OSDEPPATH)/*.asm))
headers := $(wildcard *.h)
headers += $(wildcard $(OSDEPPATH)/*.h)

##################################################################

all : checkhost checktarget checkdirs $(objects) $(osdepobjs) $(lib)

$(objpath)/%.o : %.c $(headers)
	$(CC) -c $(CFLAGS) $< -o $@

$(objpath)/%.o : %.s $(headers)
	$(CC) -c $(AFLAGS) $< -o $@

$(objpath)/%.o : %.asm $(headers)
	$(NASM) $(NASMFLAGS) -o $@ $<

$(objpath)/%.o : $(OSDEPPATH)/%.c $(headers)
	$(CC) -c $(CFLAGS) $< -o $@

$(objpath)/%.o : $(OSDEPPATH)/%.s $(headers)
	$(CC) -c $(AFLAGS) $< -o $@

$(objpath)/%.o : $(OSDEPPATH)/%.asm $(headers)
	$(NASM) $(NASMFLAGS) -o $@ $<

$(lib) : $(objects) $(osdepobjs)
	$(AR) cr $(lib) $(objects) $(osdepobjs)

$(libpath) :
	mkdir -p $(libpath)

$(objpath) :
	mkdir -p $(objpath)


.PHONY: checktarget
checktarget : ; $(CHECKTARGET_MSG)

.PHONY: checkhost
checkhost : ; $(CHECKHOST_MSG)

.PHONY: checkdirs
checkdirs : $(libpath) $(objpath)

.PHONY : clean
clean :
	rm -f $(lib)
	rm -f $(objects)
	rm -f $(osdepobjs)
