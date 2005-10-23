include ../common.mk

VPATH = $(TESTNAME)

TESTFILE := $(TESTNAME)$(EXEEXT)

SRCLIST := submod_a.bas submod_b.bas

### targets

$(TESTFILE): $(SRCLIST)
	$(FBC) $(FBLNKFLAGS) -x $@ $^

.PHONY : build
build : $(TESTFILE)

.PHONY : clean
clean : 
	rm -f $(TESTFILE) $(patsubst %.bas,$(TESTNAME)/%.o,$(SRCLIST))
