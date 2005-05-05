#
# make file to build FB's GFX Library
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
CFLAGS := -O2 -ffast-math -Wall -I .
AFLAGS := -x assembler-with-cpp

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

libpath = ../../lib/$(TARGET)

lib = $(libpath)/libfbgfx.a

ifndef OSDEPPATH
	CHECKTARGET_MSG := $(error error: TARGET not supported)  
else
	CHECKTARGET_MSG :=
endif

##################################################################

objects := $(patsubst %.c,obj/$(OSDEPPATH)/%.o,$(wildcard *.c))
objects += $(patsubst %.s,obj/$(OSDEPPATH)/%.o,$(wildcard *.s))
osdepobjs := $(patsubst $(OSDEPPATH)/%.c,obj/$(OSDEPPATH)/%.o,$(wildcard $(OSDEPPATH)/*.c))
osdepobjs += $(patsubst $(OSDEPPATH)/%.s,obj/$(OSDEPPATH)/%.o,$(wildcard $(OSDEPPATH)/*.s))
headers := $(wildcard *.h)
headers += $(wildcard $(OSDEPPATH)/*.h)

##################################################################

all : checkhost checktarget $(objects) $(osdepobjs) $(lib)

obj/$(OSDEPPATH)/%.o : %.c $(headers)
	$(CC) -c $(CFLAGS) $< -o $@

obj/$(OSDEPPATH)/%.o : %.s $(headers)
	$(CC) -c $(AFLAGS) $< -o $@

obj/$(OSDEPPATH)/%.o : $(OSDEPPATH)/%.c $(headers)
	$(CC) -c $(CFLAGS) $< -o $@

obj/$(OSDEPPATH)/%.o : $(OSDEPPATH)/%.s $(headers)
	$(CC) -c $(AFLAGS) $< -o $@


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
