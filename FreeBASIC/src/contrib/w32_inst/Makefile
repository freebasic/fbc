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

MANIFEST := ../../../manifest/current/win32.lst
MANIFEST_OPT := $(patsubst %,-manifest %,$(MANIFEST))

MANIFEST_SRC := ../../../manifest/current/compiler_src.lst
MANIFEST_SRC += ../../../manifest/current/gfxlib2_src.lst
MANIFEST_SRC += ../../../manifest/current/rtlib_src.lst
MANIFEST_SRC += ../../../manifest/current/tests.lst

MANIFEST_OPT_SRC := $(patsubst %,-manifest %,$(MANIFEST_SRC))

GEN_IMP_LIBS=../../../lib/win32/def/genimplibs.exe
BUILD_APPS=makescript.exe $(GEN_IMP_LIBS)
INST_APPS=start_shell.exe

OUTPUT=$(BUILD_APPS) $(INST_APPS) FreeBASIC.nsi FreeBASIC_src.nsi

all: $(OUTPUT)

clean:
	rm -f obj/*.o *.exe $(shell find . -name "*~" -or -iname "*.bak") $(OUTPUT)

implibs: $(GEN_IMP_LIBS)
	$(GEN_IMP_LIBS) -f -a

FreeBASIC.nsi: template.nsi replace.conf $(BUILD_APPS) $(INST_APPS) $(MANIFEST)
	./makescript.exe $(MANIFEST_OPT)

FreeBASIC_src.nsi: template.nsi replace.conf repl_src.conf $(BUILD_APPS) $(INST_APPS) $(MANIFEST_SRC)
	./makescript.exe repl_src.conf $(MANIFEST_OPT_SRC)

start_shell.exe: start_shell.bas
	$(FBC) $(FBCFLAGS) -x $@ $^

makescript.exe: makescript.bas hash.bas
	$(FBC) $(FBCFLAGS) -x $@ $^

Setup.exe: FreeBASIC.nsi
	$(MAKENSIS) $^

SetupSource.exe: FreeBASIC_src.nsi
	$(MAKENSIS) $^

../../../lib/win32/def/genimplibs.exe: ../../../lib/win32/def/genimplibs.bas
	$(FBC) $(FBCFLAGS) -x $@ $^
