dim as integer i1, i2, i3
dim as boolean b1, b2, b3

'' No need to test BOPs that don't make sense for booleans:
'' >= <= < > + - * \ /
'' because astNewBOP() disallows those with booleans.

#print "boolean-capable relational/logic BOPs:"

#print "no mixing - no warnings:"

b3 = b1 =   b2
b3 = b1 <>  b2
b3 = b1 and b2
b3 = b1 or  b2
b3 = b1 xor b2
b3 = b1 eqv b2
b3 = b1 imp b2
b3 = b1 andalso b2
b3 = b1 orelse  b2

i3 = i1 =   i2
i3 = i1 <>  i2
i3 = i1 and i2
i3 = i1 or  i2
i3 = i1 xor i2
i3 = i1 eqv i2
i3 = i1 imp i2
i3 = i1 andalso i2
i3 = i1 orelse  i2

#print "mixing - 1 warning each:"

#print "1 warning:"
b3 = b1 =   i1
#print "1 warning:"
b3 = b1 <>  i1
#print "1 warning:"
b3 = b1 and i1
#print "1 warning:"
b3 = b1 or  i1
#print "1 warning:"
b3 = b1 xor i1
#print "1 warning:"
b3 = b1 eqv i1
#print "1 warning:"
b3 = b1 imp i1
#print "1 warning:"
b3 = b1 andalso i1
#print "1 warning:"
b3 = b1 orelse  i1

#print "1 warning:"
b3 = i1 =   b1
#print "1 warning:"
b3 = i1 <>  b1
#print "1 warning:"
b3 = i1 and b1
#print "1 warning:"
b3 = i1 or  b1
#print "1 warning:"
b3 = i1 xor b1
#print "1 warning:"
b3 = i1 eqv b1
#print "1 warning:"
b3 = i1 imp b1
#print "1 warning:"
b3 = i1 andalso b1
#print "1 warning:"
b3 = i1 orelse  b1
