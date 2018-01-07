# cunit-tests.mk
# This file is part of the FreeBASIC test suite
#
# make file for building cunit compatible tests with fbcu
#

# ------------------------------------------------------------------------

include common.mk

ifeq ($(HOST),dos)
SHELL = /bin/sh
else
SHELL := $(SHELL)
endif

FIND := find
XARGS := xargs
GREP := grep
SED := sed
ECHO := echo
PRINTF := printf

ifndef FBC
FBC := fbc$(EXEEXT)
endif

DIRLIST_INC := dirlist.mk

include $(DIRLIST_INC)
DIRLIST := $(DIRLIST_FB)

ifeq ($(DIRLIST),)
$(error No directories specified in $(DIRLIST_INC))
endif

# ------------------------------------------------------------------------

CUNIT_TESTS_INC := cunit-tests.inc

SRCLIST :=
ifeq ($(MAKECMDGOALS),mostlyclean)
-include $(CUNIT_TESTS_INC)
else
include $(CUNIT_TESTS_INC)
endif
SRCLIST := $(sort $(SRCLIST))
SRCLIST := $(patsubst .bmk,.bas,$(SRCLIST))

# ------------------------------------------------------------------------

MAINBAS := fbc-tests
MAINEXE := fbc-tests$(TARGET_EXEEXT)

SRCLIST += ./$(MAINBAS).bas

FBCU_DIR := fbcunit
FBCU_INC := $(FBCU_DIR)/inc
FBCU_LIB := $(FBCU_DIR)/lib
FBCU_BIN := $(FBCU_LIB)/libfbcunit.a

FBCU_LIBS := -l fbcunit

ifeq ($(TARGET_OS),win32)
    FBCU_LIBS += -l user32
endif

FBC_CFLAGS := -c -w 3 -i $(FBCU_INC) -m $(MAINBAS)
ifneq ($(HOST),dos)
	FBC_CFLAGS += -mt
endif
ifdef DEBUG
	FBC_CFLAGS += -g
endif
ifdef EXTRAERR
	FBC_CFLAGS += -exx
endif
ifdef ARCH
	FBC_CFLAGS += -arch $(ARCH)
endif
ifneq ($(TARGET),)
	FBC_CFLAGS += -target $(TARGET)
endif
ifneq ($(FPU),)
	FBC_CFLAGS += -fpu $(FPU)
endif
ifneq ($(GEN),)
	FBC_CFLAGS += -gen $(GEN)
endif

FBC_LFLAGS := $(FBCU_LIBS) -p $(FBCU_LIB) -x $(MAINEXE)
ifdef DEBUG
	FBC_LFLAGS += -g
endif
ifdef ARCH
	FBC_LFLAGS += -arch $(ARCH)
endif
ifdef TARGET
	FBC_LFLAGS += -target $(TARGET)
endif

OBJLIST := $(SRCLIST:%.bas=%.o)

#
#: rules
#

%.o : %.bas
	$(FBC) $(FBC_CFLAGS) $^

#
#: targets
#

all : make_fbcu $(CUNIT_TESTS_INC) build_tests run_tests

.PHONY: make_fbcu $(FBCU_BIN)
make_fbcu : $(FBCU_BIN)
	cd $(FBCU_DIR) && make FPU=$(FPU) ARCH=$(ARCH) TARGET=$(TARGET)

# ------------------------------------------------------------------------
# Auto-generate the file CUNIT_TESTS_INC - needed by this makefile
# Find all *.bas files containing '# include [once] "fbcu.bi"'
# from all dirs listed in DIRLIST from DIRLIST_INC
#
#
$(CUNIT_TESTS_INC) : $(DIRLIST_INC)
	@$(PRINTF) "Generating $(CUNIT_TESTS_INC) : "
	@$(ECHO) "# This file automatically generated - DO NOT EDIT" > $(CUNIT_TESTS_INC)
	@$(ECHO) "#" >> $(CUNIT_TESTS_INC)
	@$(FIND) $(DIRLIST) -type f -name '*.bas' -or -name '*.bmk' \
| $(XARGS) $(GREP) -l -i -E '#[[:space:]]*include[[:space:]](once)*[[:space:]]*\"fbcu\.bi\"' \
| $(SED) -e 's/\(^.*\)/\SRCLIST \+\= \.\/\1/g' \
>> $(CUNIT_TESTS_INC)
	@$(FIND) $(DIRLIST) -type f -name '*.bas' -or -name '*.bmk' \
| $(XARGS) $(GREP) -l -i -E '[[:space:]]*.[[:space:]]*TEST_MODE[[:space:]]*\:[[:space:]]*CUNIT_COMPATIBLE' \
| $(SED) -e 's/\(^.*\)/\SRCLIST \+\= \.\/\1/g' \
>> $(CUNIT_TESTS_INC)
	@$(ECHO) "Done"

# ------------------------------------------------------------------------

.PHONY: build_tests
build_tests : $(OBJLIST) $(CUNIT_TESTS_INC)
	$(FBC) $(FBC_LFLAGS) $(OBJLIST)

.PHONY: run_tests
run_tests : build_tests
	./$(MAINEXE)

.PHONY: clean
clean : clean_main_exe clean_tests clean_fbcu clean_include

.PHONY: mostlyclean
mostlyclean : clean_main_exe clean_tests clean_fbcu

.PHONY: clean_main_exe
clean_main_exe :
	$(RM) $(MAINEXE)

.PHONY: clean_tests
clean_tests :
	@$(ECHO) Cleaning cunit-tests files ...
	@$(RM) $(OBJLIST)

.PHONY: clean_fbcu
clean_fbcu :
	cd $(FBCU_DIR) && make clean

.PHONY: clean_include
clean_include :
	$(RM) $(CUNIT_TESTS_INC)

