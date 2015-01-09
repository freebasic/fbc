type FWDREF1 as FWDREF1_
type FWDREF2 as FWDREF2_

dim a as FWDREF1 ptr
dim b as FWDREF2 ptr

#print "2 warnings:"
a = b
b = a
