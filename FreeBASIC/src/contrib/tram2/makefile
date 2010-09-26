OS := $(shell uname)
ifeq ($(OS),Linux)
	EXEEXT :=
else
	EXEEXT := .exe
endif

FBC = fbc
TRAM2 := tram2$(EXEEXT)

$(TRAM2): tram2.bas
	$(FBC) -exx $< -x $@

clean: 
	-rm -f $(TRAM2)

.PHONY: clean
