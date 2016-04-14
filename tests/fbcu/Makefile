include ../common.mk

#:: the names

FBC := fbc$(EXEEXT)
FBCU_ := fbcu


#:: input/output directories

SOURCE_DIR := src
INCLUDE_DIR := include

SOURCE_FILES := $(wildcard $(SOURCE_DIR)/*.bas)
OBJECT_FILES := $(SOURCE_FILES:%.bas=%.o)
LIB_FILE := lib$(FBCU_).a

#:: compiler flags, with fbcu defines

FBC_CFLAGS := -c -w 0
FBC_CFLAGS += -i $(INCLUDE_DIR)
FBC_CFLAGS += -m $(FBCU_)
ifdef ARCH
	FBC_CFLAGS += -arch $(ARCH)
endif

	#: hack ...
	AUTO_OFILE := "fbc-tests"
		
	ifdef ofile
	  FBC_CFLAGS += -d FBCU_CONFIG_OFILE=$(ofile)
	else
	  FBC_CFLAGS += -d FBCU_CONFIG_OFILE=$(AUTO_OFILE)
	endif

	ifdef auto
		FBC_CFLAGS += -d FBCU_CONFIG_AUTO=1

		ifdef lfile
		  FBC_CFLAGS += -d FBCU_CONFIG_LFILE=-1
		endif
	
	else
		ifdef console
			FBC_CFLAGS += -d FBCU_CONFIG_CONSOLE=-1
		
		else
			ifdef basic
				FBC_CFLAGS += -d FBCU_CONFIG_BASIC=-1
				
				ifdef silent
					FBC_CFLAGS += -d FBCU_CONFIG_BRM_SILENT=-1
				else
					ifdef verbose
						FBC_CFLAGS += -d FBCU_CONFIG_BRM_VERBOSE=-1
					else
						FBC_CFLAGS += -d FBCU_CONFIG_BRM_NORMAL=-1
					endif
				endif
			else
				FBC_CFLAGS += -d FBCU_CONFIG_COMPILEONLY=-1
			endif
		endif
	endif

	#: cunit runtime error behavior
	
	ifdef fail
	  FBC_CFLAGS += -d FBCU_CONFIG_REB_FAIL=1

	else
		ifdef abort
		  FBC_CFLAGS += -d FBCU_CONFIG_REB_ABORT=1

		 else
		  FBC_CFLAGS += -d FBCU_CONFIG_REB_IGNORE=1

		endif
	endif

#:: linker flags

FBC_LFLAGS := -lib -x $(LIB_FILE)
ifdef ARCH
	FBC_LFLAGS += -arch $(ARCH)
endif

#:: rules

.SUFFIXES:
.SUFFIXES: .bas

vpath %.bas $(SOURCE_DIR)

all : $(LIB_FILE)

$(OBJECT_FILES) :
	$(FBC) $(FBC_CFLAGS) $(SOURCE_FILES)

$(LIB_FILE) : $(OBJECT_FILES)
	$(FBC) $(FBC_LFLAGS) $(OBJECT_FILES)

.PHONY : clean
clean :
	rm -f $(OBJECT_FILES)
	rm -f $(LIB_FILE)
