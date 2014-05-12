'' also testing that array() and array(any * FB_MAXARRAYDIMS) are seen as different.
dim p1 as sub( array() as integer )
dim p2 as sub( array(any) as integer )
dim p3 as sub( array(any, any) as integer )
dim p4 as sub( array(any, any, any, any, any, any, any, any) as integer )

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
