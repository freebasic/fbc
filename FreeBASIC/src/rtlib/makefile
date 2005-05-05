#
# make file to build FB's Run-Time Library
#
# needed: GNU make, GCC and AR
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
CC := gcc
CFLAGS := -O2 -ffast-math -Wall -Wno-format -I .

ifeq ($(TARGET),win32)
    OSDEPPATH := win32
    CFLAGS += -DTARGET_WIN32 -DTARGET_X86
endif
    
ifeq ($(TARGET),dos)
    OSDEPPATH := dos
	CFLAGS += -DTARGET_DOS -DTARGET_X86
endif
    
ifeq ($(TARGET),linux)
    OSDEPPATH := linux
	CFLAGS += -DTARGET_LINUX -DTARGET_X86
endif

libpath = ../../lib/$(TARGET)

ifdef MULTITHREADED
	CFLAGS += -DMULTITHREADED
	lib = $(libpath)/libfbmt.a
	objpath = obj/$(OSDEPPATH)/mt
else
	lib = $(libpath)/libfb.a
	objpath = obj/$(OSDEPPATH)
endif

ifndef OSDEPPATH
	CHECKTARGET_MSG := $(error error: TARGET not supported)  
else
	CHECKTARGET_MSG :=
endif

##################################################################

objects := $(patsubst %.c,$(objpath)/%.o,$(wildcard *.c))
osdepobjs := $(patsubst $(OSDEPPATH)/%.c,$(objpath)/%.o,$(wildcard $(OSDEPPATH)/*.c))
osdepobjs += $(patsubst $(OSDEPPATH)/%.s,$(objpath)/%.o,$(wildcard $(OSDEPPATH)/*.s))
headers := $(wildcard *.h)

##################################################################

all : checkhost checktarget $(objects) $(osdepobjs) $(lib)

$(objpath)/%.o : %.c $(headers)
	$(CC) -c $(CFLAGS) $< -o $@

$(objpath)/%.o : $(OSDEPPATH)/%.c $(headers)
	$(CC) -c $(CFLAGS) $< -o $@

$(objpath)/%.o : %.s $(headers)
	$(AS) $< -o $@

$(objpath)/%.o : $(OSDEPPATH)/%.s $(headers)
	$(AS) $< -o $@

$(lib) : $(objects) $(osdepobjs)
	$(AR) cr $(lib) $(objects) $(osdepobjs)


.PHONY: checktarget
checktarget : ; $(CHECKTARGET_MSG)

.PHONY: checkhost
checkhost : ; $(CHECKHOST_MSG)


.PHONY : clean
clean :
	rm -f $(lib)
	rm -f $(objects)
	rm -f $(osdepobjs)
