OS := $(shell uname)
ifeq ($(OS),Linux)
	EXEEXT :=
else
	EXEEXT := .exe
endif

FBC := fbc
FBDOC := fbdoc$(EXEEXT)

FBFLAGS += -exx -g -i ../libfbdoc
ifdef HAVE_MYSQL
    FBFLAGS += -d HAVE_MYSQL -l mysql
endif
FBFLAGS += -p ../libfbdoc -l fbdoc -l curl -l pcre

ifeq ($(EXEEXT),.exe)
  FBFLAGS += -l ws2_32
endif

$(FBDOC): fbdoc.bas ../libfbdoc/libfbdoc.a
	$(FBC) $(FBFLAGS) $< -x $@

../libfbdoc/libfbdoc.a:
	cd ../libfbdoc && make

.PHONY: clean
clean:
	-rm -f $(FBDOC)
