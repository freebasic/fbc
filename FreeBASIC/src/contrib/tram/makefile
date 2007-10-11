ifeq (,$(findstring $(TARGET),dos linux win32))
$(error need TARGET=dos | linux | win32)
endif

##########################

MAIN := tram

SRCS := $(MAIN).bas file.bas zstr.bas list.bas

objpath := obj

OBJS := $(patsubst %.bas,$(objpath)/%.o,$(SRCS))

LIBS :=

##########################
ifeq ($(OS),Linux)
	EXEEXT :=
else
	EXEEXT := .exe
endif
ifeq ($(TARGET),linux)
	GLOB_DEF := -d TARGET_LINUX
endif
ifeq ($(TARGET),dos)
	GLOB_DEF := -d TARGET_DOS
endif
ifeq ($(TARGET),win32)
	GLOB_DEF := -d TARGET_WIN32
endif

FBC := fbc

FBCFLAGS :=

ifdef DEBUG
	FBCFLAGS += -exx -g
endif

FBCFLAGS += -i ../../compiler

.SUFFIXES:
.SUFFIXES: .bas $(EXEEXT)

VPATH = .

APP = $(MAIN)$(EXEEXT)

$(objpath)/%.o : %.bas
	$(FBC) $(FBCFLAGS) -m $(MAIN) -c $< -o $@ $(GLOB_DEF)

##########################

all: $(APP)

$(APP): $(OBJS)
	$(FBC) $(FBCFLAGS) $(OBJS) $(LIBS) -x $(APP)

.PHONY : clean
clean:
	-rm -f $(OBJS) $(APP)
