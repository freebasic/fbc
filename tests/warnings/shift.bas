dim as integer i

#print "shl negative:"
print i shl -1

#print "shl 0:"
print i shl 0

#print "shl 1:"
print i shl 1

#print "shl 31:"
print i shl 31

#print "shl 32:"
print i shl 32

#print "shl 33:"
print i shl 33

#print "shl 123:"
print i shl 123

#print "shl huge longint value:"
print i shl &hFF00000000ull

#print "----------------------------"

#print "shr negative:"
print i shr -1

#print "shr 0:"
print i shr 0

#print "shr 1:"
print i shr 1

#print "shr 31:"
print i shr 31

#print "shr 32:"
print i shr 32

#print "shr 33:"
print i shr 33

#print "shr 123:"
print i shr 123

#print "shr huge longint value:"
print i shr &hFF00000000ull
