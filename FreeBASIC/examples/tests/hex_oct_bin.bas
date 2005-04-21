
	dim b as byte
	dim s as short
	dim i as integer
	dim l as longint

	b = 2 ^ 7
	s = 2 ^ 15
	i = 2 ^ 31
	l = 2LL ^ 63
	
	print "hex:"
	print hex$( b )
	print hex$( s )
	print hex$( i )
	print hex$( l )	

	print "oct:"
	print oct$( b )
	print oct$( s )
	print oct$( i )
	print oct$( l )	

	print "bin:"
	print bin$( b )
	print bin$( s )
	print bin$( i )
	print bin$( l )	
		