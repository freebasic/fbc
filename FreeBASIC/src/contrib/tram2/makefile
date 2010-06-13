FBC = fbc

OS := $(shell uname)
ifeq ($(OS),Linux)
	EXEEXT :=
else
	EXEEXT := .exe
endif

EXE := tram2$(EXEEXT)

CFLAGS += -m tram2 -include common.bi
CFLAGS += -g -exx
LFLAGS += -g -exx

INC := $(wildcard *.bi)
BAS := $(wildcard *.bas)
OBJ := $(patsubst %.bas,obj/%.o,$(BAS))

$(EXE): $(OBJ)
	$(FBC) $(LFLAGS) $(OBJ) -x $(EXE)

obj/%.o: %.bas $(INC)
	$(FBC) $(CFLAGS) -c $< -o $@

clean: 
	-rm -f $(OBJ) $(EXE)

.PHONY: clean
