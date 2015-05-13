# This compiles the driver and regenerates the inline.h header.

# To compile build helper tools:
FBC := fbc

# To compile the driver:
CC := gcc
DLLTOOL := dlltool
WINDRES := windres

MAKEDRIVER := ./makedriver.exe

../fbportio_inline.h: fbportio.sys $(MAKEDRIVER)
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
	rm -f ../fbportio_inline.h $(MAKEDRIVER) \
		fbportio.sys fbportio-rc.o libntoskrnl-missing.a
