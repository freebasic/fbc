OS := $(shell uname)
ifeq ($(OS),Linux)
	EXEEXT :=
else
	EXEEXT := .exe
endif

FBC := fbc

LIBFBDOC_DIR := ../libfbdoc
LIBFBDOC := $(LIBFBDOC_DIR)/libfbdoc.a

FBDOC := fbdoc$(EXEEXT)

FBFLAGS += -exx -g -i $(LIBFBDOC_DIR)
ifdef HAVE_MYSQL
    FBFLAGS += -d HAVE_MYSQL -l mysql
endif
FBFLAGS += -p $(LIBFBDOC_DIR) -l fbdoc -l curl -l pcre

################################################################################

$(FBDOC): fbdoc.bas $(LIBFBDOC)
	$(FBC) $(FBFLAGS) $< -x $@

$(LIBFBDOC):
	cd $(LIBFBDOC_DIR) && make

clean:
	-rm -f $(FBDOC)

.PHONY: clean
