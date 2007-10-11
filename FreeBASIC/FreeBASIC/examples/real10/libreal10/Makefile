##########################

LIBNAME := real10
LIBDEST := ../

SRCS := core.bas op-let.bas op-ctor.bas
SRCS += op-acos.bas op-acosh.bas op-add.bas op-asin.bas op-asinh.bas op-atan.bas op-atanh.bas
SRCS += op-cast.bas op-cos.bas op-cosh.bas op-div.bas op-eq.bas op-exp.bas op-exp10.bas op-ge.bas
SRCS += op-gt.bas op-le.bas op-log.bas op-log10.bas op-lt.bas op-mul.bas op-ne.bas op-pow.bas
SRCS += op-sin.bas op-sinh.bas op-sqrt.bas op-sub.bas op-tan.bas op-tanh.bas

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