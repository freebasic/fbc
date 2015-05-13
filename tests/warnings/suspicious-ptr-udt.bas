type Pod1
	i as integer
end type

type Pod2
	i as integer
end type

type TheBase
	i as integer
end type

type Derived extends TheBase
	i1 as integer
end type

dim as Pod1 ptr ppod1a, ppod1b
dim as Pod2 ptr ppod2
dim as TheBase ptr pbase
dim as integer ptr pint

#print "no warning:"
ppod1a = ppod1b

#print "1 warning:"
ppod1a = pbase

#print "1 warning:"
ppod1a = ppod2

#print "1 warning:"
ppod1a = pint

#print "1 warning:"
pint = ppod2

#print "1 warning:"
pint = pbase

#print "1 warning:"
pbase = ppod2

#print "1 warning:"
pbase = pint
