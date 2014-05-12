'' (The varargs procptr needs cdecl and an initial parameter. So then
'' they all should have that, otherwise the test would trigger warnings
'' due to different calling conventions or parameter count.)
dim p1 as sub cdecl( byval as integer, byval as integer )
dim p2 as sub cdecl( byval as integer, byref as integer )
dim p3 as sub cdecl( byval as integer, (any) as integer )
dim p4 as sub cdecl( byval as integer, ...              )

#print "3 warnings:"
p1 = p2
p1 = p3
p1 = p4

#print "3 warnings:"
p2 = p1
p2 = p3
p2 = p4

#print "3 warnings:"
p3 = p1
p3 = p2
p3 = p4

#print "3 warnings:"
p4 = p1
p4 = p2
p4 = p3
