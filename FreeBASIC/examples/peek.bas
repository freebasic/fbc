
 	dim p as any ptr
 	
 	'' -----------
 	dim b as byte
 	b = 123
 	
 	p = @b
 	
 	print "byte ="; peek( p )

 	'' -----------
 	dim w as short
 	w = 1234
 	
 	p = @w
 	
 	print "short ="; peek( short, p )

 	'' -----------
 	dim i as integer
 	i = 12345
 	
 	p = @i
 	
 	print "integer ="; peek( integer, p )

 	'' -----------
 	dim f as single
 	f = 12345.6
 	
 	p = @f
 	
 	print "single ="; peek( single, p )

 	'' -----------
 	dim d as double
 	d = 123456.7
 	
 	p = @d
 	
 	print "double ="; peek( double, p )
 	
 	'' -----------
 	dim s as string
 	s = "abcde"
 	
 	p = @s
 	
 	print "string = "; peek( string, p )
 	
 	
 	sleep