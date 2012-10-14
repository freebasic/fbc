DLLTOOL := dlltool

LIBS := $(wildcard *.def)
LIBS := $(patsubst %.def,lib%.dll.a,$(LIBS))

all: $(LIBS)

# Some libraries need extra dlltool flags
libFreeImage.dll.a:    DTFLAGS := --add-stdcall-underscore
libcrypt.dll.a:        DTFLAGS := --kill-at
libglut32.dll.a:       DTFLAGS := --kill-at
libglut.dll.a:         DTFLAGS := --kill-at
libfmod.dll.a:         DTFLAGS := --add-stdcall-underscore
libjvm.dll.a:          DTFLAGS := --kill-at
libmySQL.dll.a:        DTFLAGS := --kill-at
libwx-c-0-9-0-2.dll.a: DTFLAGS := --add-stdcall-underscore

$(LIBS): lib%.dll.a: %.def
	$(DLLTOOL) -d $< -l $@ $(DTFLAGS)

clean:
	rm -f $(LIBS)
