'' BYREF parameter CONSTness

dim p1 as sub( byref as integer                 )
dim p2 as sub( byref as const integer           )

dim p3 as sub( byref as integer ptr             )
dim p4 as sub( byref as integer const ptr       )

dim p5 as sub( byref as const integer ptr       )
dim p6 as sub( byref as const integer const ptr )

#print "6 warnings:"
p1 = p2
p2 = p1
p3 = p4
p4 = p3
p5 = p6
p6 = p5

#print "8 warnings:"
p3 = p5
p3 = p6
p4 = p5
p4 = p6
p5 = p3
p5 = p4
p6 = p3
p6 = p4
