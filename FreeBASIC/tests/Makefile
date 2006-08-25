include common.mk

FBC := fbc

MAINEXE := fbc-tests$(EXEEXT)

FBCU_DIR := fbcu
FBCU_INC := $(FBCU_DIR)/include
FBCU_LIB := $(FBCU_DIR)/
FBCU_BIN := $(FBCU_DIR)/libfbcu.a

FBCU_LIBS := -l cunit -l fbcu

ifeq ($(TARGET),win32)
    FBCU_LIBS += -l user32
endif

FBC_CFLAGS := -c -w 0 -i $(FBCU_INC)
FBC_LFLAGS := $(FBCU_LIBS) -p $(FBCU_DIR) -x $(MAINEXE)

# dirs to be updated: [data] dim namespace

DIRLIST := comments compound console crt datetime dim expressions file functions interactive namespace
DIRLIST += numbers macros optimizations overload pointers scopes string structs swap threads wstring

SRCLIST := $(foreach dir, $(DIRLIST), $(wildcard $(dir)/*.bas))
MAKLIST := $(foreach dir, $(DIRLIST), $(wildcard $(dir)/*.mk))

OBJLIST := $(SRCLIST:%.bas=%.o)

#:
#: rules
#:

%.o : %.bas
	$(FBC) $(FBC_CFLAGS) $^

#:
#: targets
#:

all : make_fbcu build_tests run_tests

.PHONY: make_fbcu $(FBCU_BIN)
make_fbcu : $(FBCU_BIN)
	cd $(FBCU_DIR) && make 

.PHONY: build_tests
build_tests : $(OBJLIST)
	$(FBC) $(FBC_LFLAGS) $(OBJLIST)

.PHONY: run_tests
run_tests : build_tests
	./$(MAINEXE)

.PHONY: clean
clean : clean_main_exe clean_tests clean_fbcu

.PHONY: clean_main_exe
clean_main_exe :
	rm -f $(MAINEXE)

.PHONY: clean_tests
clean_tests :
	rm -f $(OBJLIST)

.PHONY: clean_fbcu
clean_fbcu :
	cd $(FBCU_DIR) && make clean
