FBC := fbc
CXX := g++

FBFLAGS :=
# tester.cxx uses std::optional, which needs C++17; Apple clang does not
# default to it, and this suite is where -dylib is exercised on Darwin.
CXXFLAGS := -O2 -g -std=c++17
LDFLAGS :=

ALLFBFLAGS := $(FBFLAGS)
ALLCXXFLAGS := $(CXXFLAGS) -Wall
ALLLDFLAGS := $(LDFLAGS)

TESTEE_SOURCES := $(sort $(wildcard testee-*.bas))
TESTEE_BINARIES := $(patsubst %.bas,%,$(TESTEE_SOURCES))

# Mach-O uses .dylib for shared libraries, ELF targets use .so
ifeq ($(shell uname -s),Darwin)
LIBEXT := .dylib
else
LIBEXT := .so
endif
LIBEXAMPLELIB := libexamplelib$(LIBEXT)

ALL_BINARIES := tester $(TESTEE_BINARIES) $(LIBEXAMPLELIB) examplebin

all: $(ALL_BINARIES)

tester: tester.cxx
	$(CXX) $(ALLCXXFLAGS) $< $(ALLLDFLAGS) -o $@

$(TESTEE_BINARIES): %: %.bas
	$(FBC) $(ALLFBFLAGS) $<

# #include dependency
testee-dylibload-dylibfree-examplelib: testee-dylibload-only-examplelib.bas

$(LIBEXAMPLELIB): examplelib.bas
	$(FBC) $(ALLFBFLAGS) $< -dylib

examplebin: examplebin.bas
	$(FBC) $(ALLFBFLAGS) $<

.PHONY: clean
clean:
	rm -f $(ALL_BINARIES)

.PHONY: tests
tests: all
	./tester
