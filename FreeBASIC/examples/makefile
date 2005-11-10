
DIRLIST := Allegro big_int CGUI cryptlib curses CVS DB disphelper file
DIRLIST += freetype gfx GL GL/NeHe GSL Gtk IUP libxml Lua pdflib regex
DIRLIST += SDL sound tests unicode Windows Windows/gui wx-c

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
	
