OS := $(shell uname)
ifeq ($(OS),Linux)
	EXEEXT :=
else
	EXEEXT := .exe
endif

FBFLAGS := -exx -g
FBC := fbc

INC := $(wildcard *.bi)
OBJ := $(patsubst %.bas,%.o,$(wildcard *.bas))

libfbdoc.a: $(OBJ)
	$(FBC) -lib $^ -x $@

%.o: %.bas $(INC)
	$(FBC) $(FBFLAGS) -c $< -o $@

.PHONY: clean
clean:
	-rm -f $(OBJ) libfbdoc.a
