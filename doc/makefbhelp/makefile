OS := $(shell uname)
ifeq ($(OS),Linux)
	EXEEXT :=
else
	EXEEXT := .exe
endif

FBC := fbc

MAKEFBHELP := makefbhelp$(EXEEXT)

################################################################################

$(MAKEFBHELP): makefbhelp.bas
	$(FBC) -exx -g $< -x $@

clean:
	-rm -f $(MAKEFBHELP)

.PHONY : clean
