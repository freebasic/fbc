OS := $(shell uname)
ifeq ($(OS),Linux)
	EXEEXT :=
else
	EXEEXT := .exe
endif

FBC := fbc
AR := ar

LIBFBDOC := libfbdoc.a

INC := $(wildcard *.bi)
SRC := $(wildcard *.bas)
OBJ := $(patsubst %.bas,obj/%.o,$(SRC))

FBCFLAGS += -exx -g

################################################################################

$(LIBFBDOC): $(OBJ)
	$(AR) rcs $@ $(OBJ)

obj/%.o: %.bas $(INC)
	$(FBC) $(FBCFLAGS) -c $< -o $@

clean:
	-rm -f $(OBJ) $(LIBFBDOC)

.PHONY: clean
