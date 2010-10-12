
DIRLIST := libraries/Allegro libraries/big_int libraries/CGUI libraries/cryptlib libraries/CUnit libraries/Curl 
DIRLIST += libraries/curses libraries/DB libraries/disphelper libraries/freetype libraries/GL libraries/GL/NeHe
DIRLIST += libraries/GSL libraries/Gtk libraries/Gtk/Tutorials libraries/IUP libraries/libxml libraries/Lua
DIRLIST += libraries/pdflib libraries/regex libraries/SDL libraries/sound libraries/wx-c
DIRLIST += libraries
DIRLIST += unicode namespace gfx classes misc misc/file
DIRLIST += Windows Windows/gui Windows/winsock 


###

FBC := fbc
FBCFLAGS := -ex -d PTC_WIN -noerrline

SRCLIST := $(wildcard *.bas)
SRCLIST += $(foreach i,$(DIRLIST),$(wildcard $(i)/*.bas))

EXELIST	:= $(patsubst %.bas,%.exe,$(SRCLIST))

%.exe: %.bas
	$(FBC) $(FBCFLAGS) -i $(<D) $<


all: $(EXELIST)

.PHONY : clean
clean:
	rm -f $(EXELIST)

