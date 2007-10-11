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

GEN_IMP_LIBS=../../../lib/win32/def/genimplibs.exe
BUILD_APPS=makescript.exe $(GEN_IMP_LIBS)
INST_APPS=start_shell.exe

OUTPUT=$(BUILD_APPS) $(INST_APPS) FreeBASIC.nsi FreeBASIC_src.nsi

all: $(OUTPUT)

clean:
	rm -f obj/*.o *.exe $(shell find . -name "*~" -or -iname "*.bak") $(OUTPUT)

implibs: $(GEN_IMP_LIBS)
	$(GEN_IMP_LIBS) -f -a

FreeBASIC.nsi: template.nsi replace.conf $(BUILD_APPS) $(INST_APPS) 
	./makescript.exe

FreeBASIC_src.nsi: template.nsi replace.conf repl_src.conf $(BUILD_APPS) $(INST_APPS) 
	./makescript.exe repl_src.conf

start_shell.exe: start_shell.bas
	$(FBC) $(FBCFLAGS) -x $@ $^

makescript.exe: makescript.bas
	$(FBC) $(FBCFLAGS) -x $@ $^

Setup.exe: FreeBASIC.nsi
	$(MAKENSIS) $^

SetupSource.exe: FreeBASIC_src.nsi
	$(MAKENSIS) $^

../../../lib/win32/def/genimplibs.exe: ../../../lib/win32/def/genimplibs.bas
	$(FBC) $(FBCFLAGS) -x $@ $^
