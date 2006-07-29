
DIRLIST := Allegro big_int CGUI cryptlib CUnit Curl curses CVS DB disphelper file
DIRLIST += freetype gfx GL GL/NeHe GSL Gtk Gtk/Tutorials IUP libxml Lua namespace
DIRLIST += pdflib regex SDL sound unicode Windows Windows/gui Windows/winsock wx-c

###

FBC := fbc
FBCFLAGS := -ex -d PTC_WIN

SRCLIST := $(wildcard *.bas)
SRCLIST += $(foreach i,$(DIRLIST),$(wildcard $(i)/*.bas))

EXELIST	:= $(patsubst %.bas,%.exe,$(SRCLIST))

%.exe: %.bas
	$(FBC) $(FBCFLAGS) -i $(<D) $<


all: $(EXELIST)

.PHONY : clean
clean:
	rm -f $(EXELIST)

