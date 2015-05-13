DLLTOOL := dlltool

libs := $(wildcard *.def)
libs := $(patsubst %.def,lib%.dll.a,$(libs))

all: $(libs)

# Some libraries need extra dlltool flags
libfmod.dll.a:         DTFLAGS := --add-stdcall-underscore
libjvm.dll.a:          DTFLAGS := --kill-at
libmySQL.dll.a:        DTFLAGS := --kill-at
libwx-c-0-9-0-2.dll.a: DTFLAGS := --add-stdcall-underscore

$(libs): lib%.dll.a: %.def
	$(DLLTOOL) -d $< -l $@ $(DTFLAGS)

clean:
	rm -f $(libs)
