#print "suspicious pointer assignment:"
const p as integer ptr = cptr(double ptr, 0)

#print "constant conversion overflow:"
const a as byte = &hFFFF
