FB_VERSION := 0.22.0
INSTALLER_EXE := FreeBASIC-$(FB_VERSION)-win32.exe
MAKENSIS := makensis
FBC := fbc

INSTALLER_INPUT := open-console.exe fblogo.ico fblogo-header.bmp ../manifest/win32.lst

.SUFFIXES:

.PHONY: all
all: $(INSTALLER_EXE)

$(INSTALLER_EXE): installer.nsi $(INSTALLER_INPUT)
	$(MAKENSIS) -NOCD -V2 $<

# The installer script is put in the root FreeBASIC folder. makensis will cd there.
installer.nsi: makescript.exe ../manifest/win32.lst template.nsi
	$^ $@

makescript.exe: makescript.bas
	$(FBC) -g -exx -d FB_VERSION=$(FB_VERSION) -d INSTALLER_EXE=$(INSTALLER_EXE) $< -x $@

open-console.exe: open-console.bas
	$(FBC) -exx $< -x $@

.PHONY: clean
clean:
	-rm -f open-console.exe installer.nsi makescript.exe $(INSTALLER_EXE)
