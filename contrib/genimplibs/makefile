FBC = fbc

EXE := genimplibs.exe

CFLAGS += -m genimplibs
CFLAGS += -g -exx
LFLAGS += -g -exx

BAS := $(wildcard *.bas)
OBJ := $(patsubst %.bas,obj/%.o,$(BAS))

$(EXE): $(OBJ)
	$(FBC) $(LFLAGS) $(OBJ) -x $(EXE)

obj/%.o: %.bas
	$(FBC) $(CFLAGS) -c $< -o $@

clean: 
	-rm -f $(OBJ) $(EXE)

.PHONY: clean
