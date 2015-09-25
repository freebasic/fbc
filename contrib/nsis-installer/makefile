include ../../version.mk

FBTITLE := FreeBASIC-$(FBVERSION)-win32
MAKENSIS := makensis

MANIFEST := ../manifest/FreeBASIC-win32.lst

.SUFFIXES:

$(FBTITLE).exe: makescript.bas template.nsi $(FBTITLE).zip $(MANIFEST) \
                  open-console.bas fblogo-header.bmp fblogo.ico
	rm -rf $(FBTITLE)
	unzip -q -o $(FBTITLE).zip
	$(FBTITLE)/fbc.exe -g -exx -d FBVERSION=$(FBVERSION) makescript.bas
	makescript.exe $(MANIFEST) template.nsi installer.nsi
	$(FBTITLE)/fbc.exe open-console.bas
	cp installer.nsi open-console.exe fblogo.ico $(FBTITLE)
	$(MAKENSIS) -V2 $(FBTITLE)/installer.nsi
	rm -r $(FBTITLE)

.PHONY: clean
clean:
	-rm -f open-console.exe installer.nsi makescript.exe $(FBTITLE).exe
