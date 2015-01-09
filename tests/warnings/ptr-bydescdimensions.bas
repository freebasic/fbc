scope
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
end scope

sub bydesc0( array() as integer )
end sub

sub bydesc1( array(any) as integer )
end sub

sub bydesc2( array(any, any) as integer )
end sub

sub bydesc8( array(any, any, any, any, any, any, any, any) as integer )
end sub

'' both a & b should use the same procptr subtype
dim a0 as sub( array() as integer )
dim b0 as sub( array() as integer )
dim a1 as sub( array(any) as integer )
dim b1 as sub( array(any) as integer )
dim a2 as sub( array(any, any) as integer )
dim b2 as sub( array(any, any) as integer )
dim a8 as sub( array(any, any, any, any, any, any, any, any) as integer )
dim b8 as sub( array(any, any, any, any, any, any, any, any) as integer )

'' both c & d will use the same procptr subtype
dim as sub( array() as integer ) c0, d0
dim as sub( array(any) as integer ) c1, d1
dim as sub( array(any, any) as integer ) c2, d2
dim as sub( array(any, any, any, any, any, any, any, any) as integer ) c8, d8

#print "----------------------------------------------"

#print "no warning:"
a0 = b0
#print "1 warning:"
a0 = b1
#print "1 warning:"
a0 = b2
#print "1 warning:"
a0 = b8
#print "no warning:"
a0 = c0
#print "1 warning:"
a0 = c1
#print "1 warning:"
a0 = c2
#print "1 warning:"
a0 = c8
#print "no warning:"
a0 = d0
#print "1 warning:"
a0 = d1
#print "1 warning:"
a0 = d2
#print "1 warning:"
a0 = d8
#print "no warning:"
a0 = @bydesc0
#print "1 warning:"
a0 = @bydesc1
#print "1 warning:"
a0 = @bydesc2
#print "1 warning:"
a0 = @bydesc8

#print "----------------------------------------------"

#print "1 warning:"
a1 = b0
#print "no warning:"
a1 = b1
#print "1 warning:"
a1 = b2
#print "1 warning:"
a1 = b8
#print "1 warning:"
a1 = c0
#print "no warning:"
a1 = c1
#print "1 warning:"
a1 = c2
#print "1 warning:"
a1 = c8
#print "1 warning:"
a1 = d0
#print "no warning:"
a1 = d1
#print "1 warning:"
a1 = d2
#print "1 warning:"
a1 = d8
#print "1 warning:"
a1 = @bydesc0
#print "no warning:"
a1 = @bydesc1
#print "1 warning:"
a1 = @bydesc2
#print "1 warning:"
a1 = @bydesc8

#print "----------------------------------------------"

#print "1 warning:"
a2 = b0
#print "1 warning:"
a2 = b1
#print "no warning:"
a2 = b2
#print "1 warning:"
a2 = b8
#print "1 warning:"
a2 = c0
#print "1 warning:"
a2 = c1
#print "no warning:"
a2 = c2
#print "1 warning:"
a2 = c8
#print "1 warning:"
a2 = d0
#print "1 warning:"
a2 = d1
#print "no warning:"
a2 = d2
#print "1 warning:"
a2 = d8
#print "1 warning:"
a2 = @bydesc0
#print "1 warning:"
a2 = @bydesc1
#print "no warning:"
a2 = @bydesc2
#print "1 warning:"
a2 = @bydesc8

#print "----------------------------------------------"

#print "1 warning:"
a8 = b0
#print "1 warning:"
a8 = b1
#print "1 warning:"
a8 = b2
#print "no warning:"
a8 = b8
#print "1 warning:"
a8 = c0
#print "1 warning:"
a8 = c1
#print "1 warning:"
a8 = c2
#print "no warning:"
a8 = c8
#print "1 warning:"
a8 = d0
#print "1 warning:"
a8 = d1
#print "1 warning:"
a8 = d2
#print "no warning:"
a8 = d8
#print "1 warning:"
a8 = @bydesc0
#print "1 warning:"
a8 = @bydesc1
#print "1 warning:"
a8 = @bydesc2
#print "no warning:"
a8 = @bydesc8
