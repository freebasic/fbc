#!/usr/bin/make -f

BAS := $(wildcard src/compiler/*.bas)
BI  := $(wildcard src/compiler/*.bi)
OBJ  := $(patsubst src/compiler/%.bas,src/compiler/obj/%.o,$(BAS))

ifeq ($(GEN),gas)
  ASMEXT := asm
else
  ifeq ($(GEN),gcc)
    ASMEXT := c
  else
    $(error please specify GEN=gas|gcc)
  endif
endif

ASM := $(patsubst %.bas,%.$(ASMEXT),$(BAS))


.SUFFIXES:
.PHONY: prepare build rtlib

prepare: src/compiler/fbc.bas $(ASM)

$(ASM): %.$(ASMEXT): %.bas $(BI)
	$(FBC) -gen $(GEN) -r -m fbc $<


build: src/compiler/fbc.bas bin/fbc-new

bin/fbc-new: rtlib $(OBJ) | bin
	ld -o $@ -dynamic-linker /lib/ld-linux.so.2 -m elf_i386 -s \
		-L lib/freebasic \
		-L "$(dir $(shell gcc -m32 -print-file-name=libgcc.a))" \
		"$(shell gcc -m32 -print-file-name=crt1.o)" \
		"$(shell gcc -m32 -print-file-name=crti.o)" \
		"$(shell gcc -m32 -print-file-name=crtbegin.o)" \
		lib/freebasic/fbrt0.o \
		$(OBJ) \
		"-(" -lfb -lgcc -lpthread -lc -lm -ldl -lncurses -lsupc++ -lgcc_eh "-)" \
		"$(shell gcc -m32 -print-file-name=crtend.o)" \
		"$(shell gcc -m32 -print-file-name=crtn.o)"

# Assuming we're running from the fbc toplevel directory, use the main makefile
# to build the rtlib/gfxlib2 libs
rtlib:
	make rtlib gfxlib2

ifeq ($(GEN),gas)
  $(OBJ): src/compiler/obj/%.o: src/compiler/%.asm | src/compiler/obj
	as --32 --strip-local-absolute $< -o $@
endif

ifeq ($(GEN),gcc)
  $(OBJ): src/compiler/obj/%.o: src/compiler/%.c | src/compiler/obj
	gcc -nostdlib -nostdinc -fno-strict-aliasing -frounding-math -fno-math-errno -c $< -o $@
endif

bin src/compiler/obj:
	mkdir $@

clean:
	make clean
	rm -f src/compiler/*.asm src/compiler/*.c
