'' A = forward-declared type
'' A_ = forward reference
type A as A_

'' typedef to forward-declared type (not to the forward reference)
type B as A

'' A and B should both refer to the same forward reference (A_)
dim p1 as A ptr
dim p2 as B ptr
#print "no warnings:"
p1 = p2
p2 = p1
