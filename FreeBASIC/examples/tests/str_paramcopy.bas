'':::::
sub f5( byval s1 as string, s2 as string )

	s1 = ucase$( s1 )
	s2 = ucase$( s2 )
	
end sub

	dim s as string
	dim z as zstring * 3+1
	dim f as string *3
	s = "var"
	z = "zer"
	f = "fix"

	print "-1-"
	f5 s, z
	print s, z
	if( s <> "VAR" or z <> "zer" ) then
		print "should be lower and upper!"
	end if

	s = "abc"

	print "-2-"
	f5 z, f
	print z, f
	
	if( z <> "ZER" or f <> "FIX" ) then
		print "should be upper and upper!"
	end if
	
	sleep
	