##########################

SRCS := variant-ctor.bas variant-dtor.bas variant-assign.bas variant-cast.bas
SRCS += variant-add.bas variant-add-inv.bas variant-add-self.bas variant-sub.bas variant-sub-inv.bas variant-sub-self.bas
SRCS += variant-mul.bas variant-mul-inv.bas variant-mul-self.bas variant-div.bas variant-div-inv.bas variant-div-self.bas
SRCS += variant-idiv.bas variant-idiv-inv.bas variant-idiv-self.bas variant-mod.bas variant-mod-inv.bas variant-mod-self.bas 
SRCS += variant-shl.bas variant-shl-self.bas variant-shr.bas variant-shr-self.bas
SRCS += variant-and.bas variant-and-inv.bas variant-and-self.bas variant-or.bas variant-or-inv.bas variant-or-self.bas 
SRCS += variant-xor.bas variant-xor-inv.bas variant-xor-self.bas variant-imp.bas variant-imp-inv.bas variant-imp-self.bas
SRCS += variant-eqv.bas variant-eqv-inv.bas variant-eqv-self.bas variant-pow.bas variant-pow-inv.bas variant-pow-self.bas
SRCS += variant-eq.bas variant-eq-inv.bas variant-ne.bas variant-ne-inv.bas variant-lt.bas variant-lt-inv.bas 
SRCS += variant-gt.bas variant-gt-inv.bas variant-le.bas variant-le-inv.bas variant-ge.bas variant-ge-inv.bas
SRCS += variant-neg.bas variant-not.bas 
OBJS := $(patsubst %.bas,obj/%.o,$(SRCS))

##########################

FBC := fbc
FBCFLAGS := -d VARIANT_ISBUILDING -i ../

ifdef DEBUG
FBCFLAGS += -g
endif

LIBRARY := ../libvariant.a

.SUFFIXES:
.SUFFIXES: .bas

obj/%.o : %.bas 
	$(FBC) $(FBCFLAGS) -c $< -o $@

##########################

all: $(LIBRARY)

$(LIBRARY): $(OBJS)
	$(FBC) $(FBCFLAGS) -lib -x $@ $(OBJS)


.PHONY : clean
clean:
	-rm -f $(OBJS) $(LIBRARY)
