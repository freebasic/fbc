
DIRLIST := compound console data datetime dim expressions file functions macros numbers 
DIRLIST += optimizations overload pointers string structs swap threads wstring

###

include common.mk

EXELIST := $(patsubst %.bas,%$(EXEEXT),$(foreach i,$(DIRLIST),$(wildcard $(i)/*.bas)))

MAKLIST := $(foreach i,$(DIRLIST),$(wildcard $(i)/*.mk))

RUNLIST := $(foreach i,$(EXELIST) $(patsubst %.mk,%$(EXEEXT),$(MAKLIST)),echo [$(i)] && $(i) &&) cd .

VPATH = $(DIRLIST)

### rules

%.o: %.bas
	$(FBC) $(FBCMPFLAGS) -x $@ $^ -m $(patsubst %.o,%,$@)

%$(EXEEXT): %.o
	$(FBC) $(FBLNKFLAGS) -x $@ $^

### targets

.PHONY : run_tests
run_tests: $(EXELIST) sub_make
	$(RUNLIST)

.PHONY : sub_make
sub_make: $(MAKLIST)
	cd $(<D) && make -f $(<F) build TESTNAME=$(subst .mk,,$(<F)) && cd ..

.PHONY : clean
clean: exe_clean sub_clean
	
.PHONY : exe_clean
exe_clean: 
	rm -f $(EXELIST) $(patsubst %$(EXEEXT),%.o,$(EXELIST))

.PHONY : sub_clean
sub_clean : $(MAKLIST)
	cd $(<D) && make -f $(<F) clean TESTNAME=$(subst .mk,,$(<F)) && cd ..
	
all: run_tests
