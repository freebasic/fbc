#
# Makefile to create the NSIS installer script
#

FBC=../../../fbc
FBCFLAGS=-exx

ifndef MAKENSIS
MAKENSIS=$(wildcard $(PROGRAMFILES)/NSIS/makensis.exe)
ifeq ($(MAKENSIS),)
MAKENSIS=makensis
endif
endif

MANIFEST := ../../../manifest/win32.lst
MANIFEST_OPT := $(patsubst %,-manifest %,$(MANIFEST))

GEN_IMP_LIBS=../genimplibs/genimplibs.exe
BUILD_APPS=makescript.exe $(GEN_IMP_LIBS)
INST_APPS=start_shell.exe

OUTPUT=$(BUILD_APPS) $(INST_APPS) FreeBASIC.nsi

all: $(OUTPUT)

clean:
	rm -f obj/*.o *.exe $(shell find . -name "*~" -or -iname "*.bak") $(OUTPUT)

implibs: $(GEN_IMP_LIBS)
	$(GEN_IMP_LIBS) -f -a

FreeBASIC.nsi: template.nsi replace.conf $(BUILD_APPS) $(INST_APPS) $(MANIFEST)
	./makescript.exe $(MANIFEST_OPT)

start_shell.exe: start_shell.bas
	$(FBC) $(FBCFLAGS) -x $@ $^

makescript.exe: makescript.bas hash.bas
	$(FBC) $(FBCFLAGS) -x $@ $^

Setup.exe: FreeBASIC.nsi
	$(MAKENSIS) $^
