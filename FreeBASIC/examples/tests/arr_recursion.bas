type mytype
	i	as integer
	array(0 to 2) as string
end type

'':::::
sub sub1( array() as string )

	for i = lbound( array ) to ubound( array )
		print array(i); " ";
	next i
	print

end sub

'':::::
sub sub2( array() as string )

	sub1 array()
	
end sub

'':::::
sub sub3( array() as mytype )

	sub2 array(0).array()
	
end sub


	dim array1(0 to 2) as string
	
	for i = lbound( array1 ) to ubound( array1 )
		array1(i) = chr$( 65 + i, 66 + i, 67 + i )
	next i

	print "-1-"
	sub2 array1()
	
	dim array2(0) as mytype
	
	for i = lbound( array2(0).array ) to ubound( array2(0).array )
		array2(0).array(i) = chr$( 65 + i, 66 + i, 67 + i )
	next i

	print "-2-"
	sub3 array2()
	
	print "-3-"
	sub2 array2(0).array()


	sleep