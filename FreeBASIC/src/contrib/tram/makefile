ifeq (,$(findstring $(TARGET),dos linux win32))
$(error need TARGET=dos | linux | win32)
endif

##########################

MAIN := tram

SRCS := $(MAIN).bas file.bas zstr.bas list.bas

objpath := obj

OBJS := $(patsubst %.bas,$(objpath)/%.o,$(SRCS))

LIBS := -l fbx

##########################

ifeq ($(TARGET),linux)
	EXEEXT :=
else
	EXEEXT := .exe
endif

FBC := fbc

FBCFLAGS :=

ifdef DEBUG
	FBCFLAGS += -exx -g
endif

.SUFFIXES:
.SUFFIXES: .bas $(EXEEXT)

VPATH = .

APP = $(MAIN)$(EXEEXT)

$(objpath)/%.o : %.bas
	$(FBC) $(FBCFLAGS) -m $(MAIN) -c $< -o $@

##########################

all: $(APP)

$(APP): $(OBJS)
	$(FBC) $(FBCFLAGS) $(OBJS) $(LIBS) -x $(APP)

.PHONY : clean
clean:
	-rm -f $(OBJS) $(APP)
