# This compiles the driver and regenerates the inline.h header.
# The driver is for Windows only, and since it doesn't need to be updated often,
# we have (not yet anyways) bothered implementing easier cross-compilation in
# here.
#
# Anyways, if you want to cross-compile can set these to whatever you wish to
# use:
#    CC, DLLTOOL, WINDRES
# Note that FBC needs to be the to-native compiler, it's used to build the
# makedriver tool that will generate the header from the compiler driver.

CC := gcc
DLLTOOL := dlltool
FBC := fbc
WINDRES := windres

MAKEDRIVER := ./makedriver.exe

inline.h: fbportio.sys $(MAKEDRIVER)
	$(MAKEDRIVER) $< $@

fbportio.sys: fbportio.c fbportio-rc.o libntoskrnl-missing.a
	$(CC) -Wall -nostartfiles -nodefaultlibs -nostdlib \
	-Wl,-shared \
	-Wl,--entry,_DriverEntry@8 \
	-Wl,--subsystem,native \
	-Wl,--image-base,0x10000 \
	-Wl,--strip-all \
	$^ -lntoskrnl -o $@

fbportio-rc.o: fbportio.rc
	$(WINDRES) $< $@

# Small import library to compensate for MinGW's ntoskrnl import library not
# containing PsLookupProcessByProcessId@8.
# TODO: Remove this, when the driver starts working with just MinGW's library.
libntoskrnl-missing.a: ntoskrnl-missing.def
	$(DLLTOOL) -d $< -l $@ --kill-at

$(MAKEDRIVER): makedriver.bas
	$(FBC) -g -exx $< -x $@

.PHONY: clean
clean:
	rm -f inline.h $(MAKEDRIVER) \
		fbportio.sys fbportio-rc.o libntoskrnl-missing.a
