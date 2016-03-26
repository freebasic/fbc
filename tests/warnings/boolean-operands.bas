dim as integer i1, i2, i3
dim as boolean b1, b2, b3

#assert(typeof(true) = typeof(boolean))
#assert(typeof(false) = typeof(boolean))

#macro booleanCapableBopsNoWarnings(result, l, r)
	result = (l) =       (r)
	result = (l) <>      (r)
	result = (l) and     (r)
	result = (l) or      (r)
	result = (l) xor     (r)
	result = (l) eqv     (r)
	result = (l) imp     (r)
	result = (l) andalso (r)
	result = (l) orelse  (r)
#endmacro

#macro booleanCapableBops1WarningEach(result, l, r)
	#print "1 warning:"
	result = (l) =       (r)
	#print "1 warning:"
	result = (l) <>      (r)
	#print "1 warning:"
	result = (l) and     (r)
	#print "1 warning:"
	result = (l) or      (r)
	#print "1 warning:"
	result = (l) xor     (r)
	#print "1 warning:"
	result = (l) eqv     (r)
	#print "1 warning:"
	result = (l) imp     (r)
	#print "1 warning:"
	result = (l) andalso (r)
	#print "1 warning:"
	result = (l) orelse  (r)
#endmacro

'' No need to test BOPs that don't make sense for booleans:
'' >= <= < > + - * \ /
'' because astNewBOP() disallows those with booleans.

#print "boolean-capable relational/logic BOPs:"

#print "no mixing - no warnings:"
booleanCapableBopsNoWarnings(b3, b1, b2)
booleanCapableBopsNoWarnings(i3, i1, i2)
booleanCapableBopsNoWarnings(b3, b1, true)
booleanCapableBopsNoWarnings(b3, b1, false)
booleanCapableBopsNoWarnings(b3, true, b2)
booleanCapableBopsNoWarnings(b3, false, b2)

#print "mixing - 1 warning each:"
booleanCapableBops1WarningEach(b3, b1, i1)
booleanCapableBops1WarningEach(b3, i1, b1)

#print "mixing integers and true/false in boolean-capable BOPs - no warnings:"
booleanCapableBopsNoWarnings(i3, i1, true)
booleanCapableBopsNoWarnings(i3, i1, false)
booleanCapableBopsNoWarnings(i3, true, i2)
booleanCapableBopsNoWarnings(i3, false, i2)

#print "mixing booleans and 0/-1 literals in boolean-capable BOPs - no warnings:"
booleanCapableBopsNoWarnings(b3, b1, -1)
booleanCapableBopsNoWarnings(b3, b1, 0)
booleanCapableBopsNoWarnings(b3, -1, b2)
booleanCapableBopsNoWarnings(b3, 0, b2)

#print "mixing booleans and relational BOPs in boolean-capable BOPs - no warnings:"
booleanCapableBopsNoWarnings(b3, b1, i1 =  i2)
booleanCapableBopsNoWarnings(b3, b1, i1 <> i2)
booleanCapableBopsNoWarnings(b3, b1, i1 <  i2)
booleanCapableBopsNoWarnings(b3, b1, i1 <= i2)
booleanCapableBopsNoWarnings(b3, b1, i1 >  i2)
booleanCapableBopsNoWarnings(b3, b1, i1 >= i2)
booleanCapableBopsNoWarnings(b3, i1 =  i2, b2)
booleanCapableBopsNoWarnings(b3, i1 <> i2, b2)
booleanCapableBopsNoWarnings(b3, i1 <  i2, b2)
booleanCapableBopsNoWarnings(b3, i1 <= i2, b2)
booleanCapableBopsNoWarnings(b3, i1 >  i2, b2)
booleanCapableBopsNoWarnings(b3, i1 >= i2, b2)
