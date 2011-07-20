FBC := fbc

MAKEDATA := makedata.exe

FILES := fnt08x08.fnt
FILES += fnt08x14.fnt
FILES += fnt08x16.fnt
FILES += pal002.pal
FILES += pal016.pal
FILES += pal064.pal
FILES += pal256.pal

data-inline.h: data.lst $(MAKEDATA) $(FILES)
	$(MAKEDATA) $< $@

$(MAKEDATA): makedata.bas
	$(FBC) -g -exx $< -l fbgfx -x $@
