#!/usr/bin/make -f
#
# This runs fbc on all the .bas files in this directory,
# and captures fbc's output into corresponding .txt files.
# Those are included in the Git repo, so you can use Git to
# check for problems such as missing or duplicate warnings.
#

FBC := fbc

BAS := $(wildcard *.bas)
TXT := $(patsubst %.bas,%.txt,$(BAS))

ifndef V
  QUIET = @echo "TEST $<";
endif

.SUFFIXES:

.PHONY: all
all: $(TXT)

# run fbc -r,
# run fbc's output through a sed replace to strip out the filename.bas(linenumber) part,
# (because it would screw with the diff too much anytime the line numbers change
#  due to test cases being added etc.)
# redirect that into the .txt,
# delete the temp .asm file.
$(TXT): %.txt: %.bas force-rebuild
	$(QUIET)$(FBC) $< -r -m $* | sed -e 's/[0-9a-z\-]*\.bas([0-9]*) warning [0-9]*([0-9]*): /\t/g' > $@ && rm $*.asm

.PHONY: force-rebuild
force-rebuild:
