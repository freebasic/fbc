
'':::::
sub f1( byval s1 as string, s2 as string )

	print s1; " "; s2

end sub

'':::::
sub f2( s1 as string, byval s2 as string )

	f1( s1, s2 )

end sub

'':::::
sub f3( byval s1 as string, s2 as string )

	f2( s1, s2 )

end sub

'':::::
sub f4( byval s1 as zstring ptr, byval s2 as string )

	f3( *s1, s2 )

end sub


	dim s as string
	dim z as zstring * 3+1
	s = "var"
	z = "zer"
		
	print "-1-"
	f3 s, z
	
	print "-2-"
	f2 z, s
	
	print "-3-"
	f4 strptr( s ), z
	
	sleep

