FBC := fbc
CXX := g++

FBFLAGS :=
CXXFLAGS := -O2 -g
LDFLAGS :=

ALLFBFLAGS := $(FBFLAGS)
ALLCXXFLAGS := $(CXXFLAGS) -Wall
ALLLDFLAGS := $(LDFLAGS)

TESTEE_SOURCES := $(sort $(wildcard testee-*.bas))
TESTEE_BINARIES := $(patsubst %.bas,%,$(TESTEE_SOURCES))

ALL_BINARIES := tester $(TESTEE_BINARIES) libexamplelib.so examplebin

all: $(ALL_BINARIES)

tester: tester.cxx
	$(CXX) $(ALLCXXFLAGS) $< $(ALLLDFLAGS) -o $@

$(TESTEE_BINARIES): %: %.bas
	$(FBC) $(ALLFBFLAGS) $<

# #include dependency
testee-dylibload-dylibfree-examplelib: testee-dylibload-only-examplelib.bas

libexamplelib.so: examplelib.bas
	$(FBC) $(ALLFBFLAGS) $< -dylib

examplebin: examplebin.bas
	$(FBC) $(ALLFBFLAGS) $<

.PHONY: clean
clean:
	rm -f $(ALL_BINARIES)

.PHONY: tests
tests: all
	./tester
