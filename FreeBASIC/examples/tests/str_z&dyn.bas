

declare function zconcat1 ( byval s as string ) as zstring ptr
declare function zconcat2 ( byref s as string ) as zstring ptr

declare function sconcat1 ( byval s as string ) as string
declare function sconcat2 ( byref s as string ) as string
	
	dim z1 as zstring ptr
	dim z2 as zstring * 6
	dim f1 as string * 6
	dim d1 as string
	
	z1 = allocate( 6 )
	
	*z1 = "ABC"
	f1 = "DEF"
	d1 = "GHI"
	
	z2 = *z1
	
	print *zconcat1( z2 ); " ";
	print *zconcat2( *z1 )
	print *zconcat1( f1 ); " ";
	print *zconcat2( f1 )
	print *zconcat1( d1 ); " ";
	print *zconcat2( d1 )

	print "---"
	
	print sconcat1( z2 ); " ";
	print sconcat2( *z1 )
	print sconcat1( f1 ); " ";
	print sconcat2( f1 )
	print sconcat1( d1 ); " ";
	print sconcat2( d1 )
	
	print "---"
	
	print len( *z1 ), sizeof( *z1 )
	print len( z2 ), sizeof( z2 )
	print len( f1 ), sizeof( f1 )
	print len( d1 ), sizeof( d1 )
	
	print "---"
	
	*z1 = d1
	print *z1; " ";
	*z1 = f1
	print *z1; " ";
	*z1 = z2
	print *z1
	
	f1 = d1
	print f1; " ";
	f1 = z2
	print f1; " ";
	f1 = *z1
	print f1
	
	z2 = d1
	print z2; " ";
	z2 = *z1
	print z2; " ";
	z2 = f1
	print z2

	d1 = f1
	print d1; " ";
	d1 = *z1
	print d1; " ";
	d1 = z2
	print d1

	print "---"
	
	print z1[0]; " "; z2[0]; " "; f1[0]; " "; d1[0]
	
	print "---"
	
	for i = 0 to (sizeof( z2 )-1)-1
		z2[i] = 65 + i
	next i
	z2[sizeof( z2 )-1] = 0
	print z2
	
	if( z2 = 65 ) then
		print -1
	end if

	if( z2 = "ABCDE" ) then
		print -1
	end if
	
	z2 = "123"
	z2 += "45"
	print z2
	
	sleep
	
'':::
function zconcat1 ( byval s as string ) as zstring ptr
	static res as zstring * 50
	
	res = s + "123"
	
	return @res

end function

'':::
function zconcat2 ( byref s as string ) as zstring ptr
	static res as zstring * 50
	
	res = s + "123"
	
	return @res

end function

'':::
function sconcat1 ( byval bar as string ) as string
	
	return bar + "123"

end function

'':::
function sconcat2 ( byref bar as string ) as string
	
	return bar + "123"

end function