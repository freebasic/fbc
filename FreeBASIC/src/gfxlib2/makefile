#
# make file to build FB's GFX Library
#
# needed: GNU make, GCC and AR
#
# set TARGET to dos, win32, linux, or xbox -- if not defined, it will 
# be the same as HOST, if the later could be guessed
#

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

ifeq ($(TARGET),win32)
    OSDEPPATH := win32
    CFLAGS += -DTARGET_WIN32 -DTARGET_X86
    AFLAGS += -DTARGET_WIN32
endif
    
ifeq ($(TARGET),dos)
    OSDEPPATH := dos
    CFLAGS += -DTARGET_DOS -DTARGET_X86
    AFLAGS += -DTARGET_DOS
endif
    
ifeq ($(TARGET),linux)
    OSDEPPATH := linux
    CFLAGS += -DTARGET_LINUX -DTARGET_X86
    AFLAGS += -DTARGET_LINUX
endif

ifeq ($(TARGET),cygwin)
    OSDEPPATH := win32
    OSOBJPATH := cygwin
    CFLAGS += -DTARGET_CYGWIN -DTARGET_X86
    AFLAGS += -DTARGET_CYGWIN
endif

ifeq ($(TARGET),xbox)
    OSDEPPATH := xbox
    CFLAGS += -DTARGET_XBOX -DTARGET_X86
    SDLFLAGS := -DENABLE_XBOX -DDISABLE_CDROM
    CFLAGS += -std=gnu99 -ffreestanding -nostdlib -nostdinc -fno-builtin -fno-exceptions -mno-cygwin -march=i386 $(SDLFLAGS)
    CFLAGS += -I../rtlib/xbox/inc -I../rtlib/xbox/inc/SDL
    AFLAGS += -DTARGET_XBOX
endif

ifndef DEBUG
    LDFLAGS += -s
endif

ifndef OSOBJPATH
	OSOBJPATH = $(OSDEPPATH)
endif

objpath = obj/$(OSOBJPATH)

libpath = ../../lib/$(TARGET)

lib = $(libpath)/libfbgfx.a

ifndef OSDEPPATH
	CHECKTARGET_MSG := $(error error: TARGET not supported)  
else
	CHECKTARGET_MSG :=
endif

##################################################################

objects := $(patsubst %.c,$(objpath)/%.o,$(wildcard *.c) libfb_gfx_data.c)
objects += $(patsubst %.s,$(objpath)/%.o,$(wildcard *.s))
osdepobjs := $(patsubst $(OSDEPPATH)/%.c,$(objpath)/%.o,$(wildcard $(OSDEPPATH)/*.c))
osdepobjs += $(patsubst $(OSDEPPATH)/%.s,$(objpath)/%.o,$(wildcard $(OSDEPPATH)/*.s))
headers := $(wildcard *.h)
headers += $(wildcard $(OSDEPPATH)/*.h)
toolsobjs := $(patsubst tools/%.c,$(objpath)/%.o,$(wildcard tools/*.c))
tools     := $(patsubst $(objpath)/%.o,$(objpath)/%.exe,$(toolsobjs))
datafiles := $(wildcard data/*.fnt) $(wildcard data/*.pal)

##################################################################

all : checkhost checktarget checkdirs $(tools) $(objects) $(osdepobjs) $(lib)

$(objpath)/%.o : %.c $(headers)
	$(CC) -c $(CFLAGS) $< -o $@

$(objpath)/%.o : %.s $(headers)
	$(CC) -c $(AFLAGS) $< -o $@

$(objpath)/%.o : $(OSDEPPATH)/%.c $(headers)
	$(CC) -c $(CFLAGS) $< -o $@

$(objpath)/%.o : $(OSDEPPATH)/%.s $(headers)
	$(CC) -c $(AFLAGS) $< -o $@

$(lib) : $(objects) $(osdepobjs)
	$(AR) cr $(lib) $(objects) $(osdepobjs)

libfb_gfx_data.c: $(objpath)/mk_dat.exe data/data.lst $(datafiles)
	$(objpath)/mk_dat.exe -o $@

$(objpath)/mk_dat.exe: $(objpath)/mk_dat.o $(objpath)/libfb_gfx_lzw.o $(objpath)/libfb_gfx_vars.o

$(objpath)/%.exe: $(objpath)/%.o
	$(CC) $(CFLAGS) -o $@ $^

$(objpath)/%.o: tools/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

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
clean : clean_tools
	rm -f $(lib)
	rm -f $(objects)
	rm -f $(osdepobjs)
	rm -f data/data.dat libfb_gfx_data.c

.PHONY : clean_tools
clean_tools :
	rm -f tools/*.o $(tools) $(toolsobjs)
