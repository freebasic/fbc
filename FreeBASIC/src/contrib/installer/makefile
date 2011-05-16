FB_VERSION := 0.23.0
ZIP_TITLE := FreeBASIC-$(FB_VERSION)-win32
ZIP_FILE := $(ZIP_TITLE).zip
INSTALLER_EXE := $(ZIP_TITLE).exe
MAKENSIS := makensis
FBC := fbc

MANIFEST := ../../../manifest/win32.lst

.SUFFIXES:

.PHONY: all
all: $(INSTALLER_EXE)

$(INSTALLER_EXE): installer.nsi $(ZIP_FILE) \
                    open-console.exe fblogo-header.bmp \
                    ../../../fblogo.ico $(MANIFEST)
	unzip -q -o $(ZIP_FILE)
	cp installer.nsi open-console.exe ../../../fblogo.ico $(ZIP_TITLE)
	$(MAKENSIS) -V2 $(ZIP_TITLE)/installer.nsi
	rm -r $(ZIP_TITLE)

# The installer script is put in the root FreeBASIC folder. makensis will cd there.
installer.nsi: makescript.exe $(MANIFEST) template.nsi
	$^ $@

makescript.exe: makescript.bas
	$(FBC) -g -exx -d FB_VERSION=$(FB_VERSION) $< -x $@

open-console.exe: open-console.bas
	$(FBC) -exx $< -x $@

.PHONY: clean
clean:
	-rm -f open-console.exe installer.nsi makescript.exe $(INSTALLER_EXE)
