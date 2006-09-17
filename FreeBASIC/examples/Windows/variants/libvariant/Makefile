##########################

LIBNAME := variant
LIBDEST := ../

SRCS := variant-ctor.bas variant-dtor.bas variant-assign.bas variant-cast.bas
SRCS += variant-add.bas variant-add-self.bas variant-sub.bas variant-sub-self.bas
SRCS += variant-mul.bas variant-mul-self.bas variant-div.bas variant-div-self.bas
SRCS += variant-idiv.bas variant-idiv-self.bas variant-mod.bas variant-mod-self.bas 
SRCS += variant-shl.bas variant-shl-self.bas variant-shr.bas variant-shr-self.bas
SRCS += variant-and.bas variant-and-self.bas variant-or.bas variant-or-self.bas 
SRCS += variant-xor.bas variant-xor-self.bas variant-imp.bas variant-imp-self.bas
SRCS += variant-eqv.bas variant-eqv-self.bas variant-pow.bas variant-pow-self.bas
SRCS += variant-eq.bas variant-ne.bas variant-lt.bas variant-gt.bas
SRCS += variant-le.bas variant-ge.bas 
OBJS := $(patsubst %.bas,obj/%.o,$(SRCS))

##########################

FBC := fbc
FBCFLAGS := -i ../

ifdef DEBUG
FBCFLAGS += -g
endif

LIBRARY := $(LIBDEST)lib$(LIBNAME).a

.SUFFIXES:
.SUFFIXES: .bas

VPATH = .

obj/%.o : %.bas 
	$(FBC) $(FBCFLAGS) -c $< -o $@

##########################

all: $(LIBRARY)


$(LIBRARY): $(OBJS)
	$(FBC) $(FBCFLAGS) -lib -x $(LIBDEST)$(LIBNAME) $(OBJS)
	
	
.PHONY : clean
clean:
	-rm -f $(OBJS) $(LIBRARY)