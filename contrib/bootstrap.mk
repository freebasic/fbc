#!/usr/bin/make -f
#
# Helper script
# - to use the host fbc to pre-compile the src/compiler/*.bas sources
# - into intermediate .asm (fbc -gen gas) or .c (fbc -gen gcc) files
# - and making a package out of the resulting source tree
# - resulting in a "source package with precompiled .bas files"
# - from which we can later fully build FB, without needing a host fbc
# - by creating the new compiler binary from the pre-compiled .asm or .c files
#
# This is intended (only) to help bootstrapping fbc in Linux distro packaging
# systems which usually won't allow importing an fbc binary, thus making it
# necessary to pre-compile FB's .bas sources.
#
# 1. Pre-compiling the .bas sources into .asm or .c:
#    make -f contrib/bootstrap.mk prepare GEN=gas|gcc
#
# 2. Building the resulting FB source tree (without needing a host fbc):
#    make -f contrib/bootstrap.mk build GEN=gas|gcc
#
# build.mk has to do the assembling and linking steps manually, since no fbc is
# available to do it. Care must be taken to use roughly the same options that
# fbc itself would use.
#
# Important: The FB rtlib will be built first, to have an fbrt0.o and libfb.a
# to link the new compiler binary against. This means the fbc version used for
# the pre-compilation step must exactly match the bootstrap source tree, to
# ensure the pre-compiled .asm or .c files are ABI-compatible to the rtlib in
# the source tree.
#
# This is pretty much the opposite of what the normal FB makefile is doing,
# where the new compiler binary is safely built using the host fbc only.
#
# contrib/bootstrap/create-asm-tarball.sh is an example use case - it can be
# used to create an FB source package with pre-compiled .asm files, which in
# turn can be used as foundation for deb/rpm packaging.

FBC := fbc

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
