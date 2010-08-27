OS := $(shell uname)
ifeq ($(OS),Linux)
	EXEEXT :=
else
	EXEEXT := .exe
endif

FBC = fbc
FBCFLAGS = -exx
EXE := tram2$(EXEEXT)

$(EXE): tram2.bas
	$(FBC) $(FBCFLAGS) $< -x $@

clean: 
	-rm -f $(EXE)

.PHONY: clean
