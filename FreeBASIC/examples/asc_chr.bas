''
'' asc and chr$ compile-time evaluation test
''

const B_CONST = asc( "ABC", 2 )

const ABC = chr$( 65, 66, 67 )

 	a = asc( ABC )
 	b = asc( ABC, 2 )
 	c = asc( ABC, 3 ) 
 	
 	print "asc(""ABC"") ="; a; b; c
 	
 	print "chr("; a; b; c;") = "; chr$( a, b, c )
 	
	''---------
	s$ = ABC
	
	for i = 1 to len( s$ )
		print asc( s$, i ); " ";
	next 	
	print
	
 	
 	sleep
