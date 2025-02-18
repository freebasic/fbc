#!/usr/bin/make -f
#
# examples makefile - attempts to build all examples
#
# Several examples will not build if their libraries are not
# present.
#
# To make all examples:
#   $ make
# To make a subset, use the dirname in lower case
#   $ make unicode
#
# If fbc[.exe] is not in your path, pass it to make
#   $ make FBC=d:/path/to/fbc
#

OS := $(shell uname)
ifeq ($(OS),Linux)
    EXEEXT :=
    DLLEXT := .so
else
    EXEEXT := .exe
    DLLEXT := .dll
endif

FBC := fbc$(EXEEXT)
STOP_ON_ERROR := n



BASICS		:= $(subst .bas,,$(wildcard *.bas))
COMPRESSION	:= $(subst .bas,,$(wildcard compression/*.bas))
CONSOLE		:= $(subst .bas,,$(wildcard console/*.bas)) \
			$(subst .bas,,$(wildcard console/curses/*.bas)) \
			$(subst .bas,,$(wildcard console/caca/*.bas))
DATABASE	:= $(subst .bas,,$(wildcard database/*.bas))
DLL		:= dll/dylib dll/libmydll$(DLLEXT) dll/test
DOS		:= $(subst .bas,,$(wildcard DOS/*.bas))
FILES		:= $(subst .bas,,$(wildcard files/*.bas files/*/*.bas))
GRAPHICS	:= $(subst .bas,,$(wildcard graphics/*.bas graphics/*/*.bas))
GUI		:= $(subst .bas,,$(wildcard GUI/*/*.bas GUI/*/*/*.bas))
MANUAL		:= $(subst .bas,,$(wildcard manual/*.bas manual/*/*.bas))
MATH		:= $(subst .bas,,$(wildcard math/*.bas math/*/*.bas))
MISC		:= $(subst .bas,,$(wildcard misc/*/*.bas))
NETWORK		:= $(subst .bas,,$(wildcard network/*.bas network/*/*.bas \
			network/*/*/*.bas))
#OPTIMIZE	:= $(subst .bas,,$(wildcard OptimizePureAbstractTypes/*.bas))
#REGEX		:= $(subst .bas,,$(wildcard regex/*/*.bas))
SOUND		:= $(subst .bas,,$(wildcard sound/*/*.bas))
THREADS		:= $(subst .bas,,$(wildcard threads/*.bas)) \
			threads/timer-lib/libtimer$(DLLEXT) threads/timer-lib/test
UNICODE		:= $(subst .bas,,$(wildcard unicode/*.bas))
#WIN32 := $(subst .bas,,$(wildcard sound/*/*.bas))
XML		:= $(subst .bas,,$(wildcard xml/*.bas))


ALL_FILES := \
	$(BASICS) $(COMPRESSION) $(CONSOLE) $(DATABASE) \
	$(DLL) $(DOS) $(FILES) $(GRAPHICS) $(GUI) $(MANUAL) \
	$(MATH) $(MISC) $(NETWORK) $(OPTIMIZE) $(SOUND) \
	$(THREADS) $(UNICODE) $(XML)

all: $(ALL_FILES)

basics: $(BASICS)
compression: $(COMPRESSION)
console: $(CONSOLE)
database: $(DATABASE)
dll: $(DLL)
dos: $(DOS)
files: $(FILES)
graphics: $(GRAPHICS)
gui: $(GUI)
manual: $(MANUAL)
math: $(MATH)
misc: $(MISC)
#network: checklib.curl checklib.CHttp .WAIT $(NETWORK)
network: $(NETWORK)
optimize: $(OPTIMIZE)
sound: $(SOUND)
threads: $(THREADS)
unicode: $(UNICODE)
xml: $(XML)


checklib.%:
	@echo check library: "lib$*"
	@ldconfig -p | grep "lib$*.so" > /dev/null


dll/libmydll$(DLLEXT): dll/mydll.bas
	$(FBC) -dylib $<

dll/test: dll/test.bas dll/libmydll$(DLLEXT)
	$(FBC) -p dll dll/test.bas

ifeq ($(OS),Linux)
DOS/%: DOS/%.bas
	@echo "SKIP $@ on Linux"
else 
ifeq ($(OS),Windows_NT)
DOS/%: DOS/%.bas
	@echo "SKIP $@ on Windows"
else
DOS/%: DOS/%.bas
	$(FBC) $<
endif
endif

threads/timer-lib/libtimer$(DLLEXT): threads/timer-lib/timer.bas
	$(FBC) -dylib -mt $<

threads/timer-lib/test: threads/timer-lib/test.bas threads/timer-lib/libtimer$(DLLEXT)
	$(FBC) -p $(dir $@) -mt $<

%: %.bas
ifeq ($(STOP_ON_ERROR),n)
	@echo fbc -p $(dir $@) $<
	@$(FBC) -p $(dir $@) $< || \
		echo "Failed to compile '$<' - check for missing libraries"
else
	$(FBC) -p $(dir $@) $<
endif

clean:
	@echo CLEAN binary files
	@rm -fv $(ALL_FILES)
