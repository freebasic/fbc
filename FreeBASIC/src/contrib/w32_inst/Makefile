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

all: start_shell.exe makescript.exe FreeBASIC.nsi FreeBASIC_src.nsi

clean:
	rm -f obj/*.o *.exe $(shell find . -name "*~") FreeBASIC.nsi

FreeBASIC.nsi: template.nsi replace.conf
	makescript

FreeBASIC_src.nsi: tmpl_src.nsi replace.conf repl_src.conf
	makescript repl_src.conf

start_shell.exe: start_shell.bas
	$(FBC) $(FBCFLAGS) -x $@ $^

makescript.exe: makescript.bas
	$(FBC) $(FBCFLAGS) -x $@ $^
