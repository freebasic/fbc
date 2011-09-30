include ../common.mk

VPATH = $(TESTNAME)

TESTFILE := $(TESTNAME)$(EXEEXT)

SRCLIST := fbmod.bas

CPP_SRCLIST := cppmod.cpp

CPP_LIB := cpp
CPP_LIBFULL := lib$(CPP_LIB).a

ifeq ($(TARGET),linux)
LIBS := -l stdc++
else
LIBS :=
endif

### targets

$(TESTFILE): $(SRCLIST) $(CPP_LIBFULL)
	$(FBC) $(FBFLAGS) -x $@ $< -p $(TESTNAME) -l $(CPP_LIB) $(LIBS)

$(TESTNAME)/$(CPP_LIBFULL): $(CPP_SRCLIST)
	$(CC) -c -g $< -o $(patsubst %.cpp,%.o,$<)
	$(AR) cr $@ $(patsubst %.cpp,%.o,$<)

.PHONY : build
build : $(TESTFILE)

.PHONY : clean
clean : 
	rm -f $(TESTFILE) $(patsubst %.bas,$(TESTNAME)/%.o,$(SRCLIST))
	rm -f $(TESTNAME)/$(CPP_LIBFULL)
