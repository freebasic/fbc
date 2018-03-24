# bmk-make.mk
# This file is part of the FreeBASIC test suite
#
# make file for building mutiple-module tests
# and testing run-time assertions
#
# expected usage
# make -f bmk-make.mk [clean] { BMK=? | FILE=? } TEST_MODE=?
#   clean
#       clean files
#   BMK=/path/filename.bmk
#       make file for multi-module test (a make include file)
#   FILE=/path.filename.bas
#       single module filename to test
#   TEST_MODE:
#       COMPILE_AND_RUN_OK
#       COMPILE_AND_RUN_FAIL
#       MULTI_MODULE_OK
#       MULTI_MODULE_FAIL
#

include common.mk

ifeq ($(HOST),dos)
SHELL = /bin/sh
else
SHELL := $(SHELL)
endif
ECHO := echo

CC := gcc
ifndef FBC
FBC := fbc$(EXEEXT)
endif

ifeq ($(TEST_MODE),COMPILE_AND_RUN_OK)
RUN_TEST := run_test_ok
else
ifeq ($(TEST_MODE),COMPILE_AND_RUN_FAIL)
RUN_TEST := run_test_fail
else
ifeq ($(TEST_MODE),MULTI_MODULE_OK)
RUN_TEST := run_test_ok
else
ifeq ($(TEST_MODE),MULTI_MODULE_FAIL)
RUN_TEST := run_test_fail
else
$(error TEST_MODE $(TEST_MODE) not supported)
endif
endif
endif
endif

FBC_CFLAGS :=
FBC_LFLAGS :=

ifneq ($(FB_LANG),)
FBC_CFLAGS += -lang $(FB_LANG)
endif

ifneq ($(ARCH),)
FBC_CFLAGS += -arch $(ARCH)
FBC_LFLAGS += -arch $(ARCH)
endif

ifneq ($(TARGET),)
FBC_CFLAGS += -target $(TARGET)
FBC_LFLAGS += -target $(TARGET)
endif

ifneq ($(FPU),)
FBC_CFLAGS += -fpu $(FPU)
endif

ifneq ($(GEN),)
FBC_CFLAGS += -gen $(GEN)
endif

TARGET_ARCH := $(shell $(FBC) $(FBC_CFLAGS) -print target | cut -d - -f 2)
ifeq ($(TARGET_ARCH),x86)
	CFLAGS := -m32
endif
ifeq ($(TARGET_ARCH),x86_64)
	CFLAGS := -m64
endif

ifeq ($(ENABLE_CHECK_BUGS),1)
	FBC_CFLAGS += -d ENABLE_CHECK_BUGS=$(ENABLE_CHECK_BUGS)
endif
ifeq ($(ENABLE_CONSOLE_OUTPUT),1)
	FBC_CFLAGS += -d ENABLE_CONSOLE_OUTPUT=$(ENABLE_CONSOLE_OUTPUT)
endif

# The default target has to appear before "include $(BMK)", which might
# define other targets.
all : $(RUN_TEST)

MAINX :=
SRCSX :=
EXTRA_OBJSX :=

ifneq ($(BMK),)

SRCDIR := $(dir $(BMK))
include $(BMK)
MAINX := $(addprefix $(SRCDIR),$(MAIN))
SRCSX := $(MAINX) $(addprefix $(SRCDIR),$(SRCS))
EXTRA_OBJSX := $(addprefix $(SRCDIR),$(EXTRA_OBJS))

else

SRCDIR :=
MAINX := $(FILE)
SRCSX := $(FILE)

endif

MAIN_MODULE := $(basename $(MAINX))
APP := $(MAIN_MODULE)$(TARGET_EXEEXT)

ifeq ($(MAIN_MODULE),)
$(error main module not specified)
endif

FBC_CFLAGS += -g -w 0 
FBC_LFLAGS += -g

OBJS := $(addsuffix .o,$(basename $(SRCSX)))

$(OBJS) : %.o : %.bas
	$(FBC) $(FBC_CFLAGS) -m $(MAIN_MODULE) -c $< -o $@

$(APP) : $(OBJS) $(EXTRA_OBJSX)
	$(FBC) $(FBC_LFLAGS) $(OBJS) $(EXTRA_OBJSX) -x $(APP)

run_test_ok : $(APP)
	@if $(APP) ; then true ; else false ; fi

run_test_fail : $(APP)
	@if $(APP) ; then false ; else true ; fi

.PHONY : clean
clean:
	@$(ECHO) Cleaning $(SRCDIR)$(MAIN_MODULE) files ...
	@$(RM) $(OBJS) $(EXTRA_OBJSX) $(APP)
