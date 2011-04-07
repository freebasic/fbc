''
'' peek for multiple data types test
''

 	dim p as any ptr
 	
 	'' -----------
 	dim b as byte
 	b = 123
 	
 	p = @b
 	
 	print "byte =", peek( p )

 	'' -----------
 	dim w as short
 	w = 1234
 	
 	p = @w
 	
 	print "short =", peek( short, p )

 	'' -----------
 	dim i as integer
 	i = 12345
 	
 	p = @i
 	
 	print "integer =", peek( integer, p )

 	'' -----------
 	dim l as longint
 	l = 123456
 	
 	p = @l
 	
 	print "longint =", peek( longint, p )

 	'' -----------
 	dim f as single
 	f = 123456.7
 	
 	p = @f
 	
 	print "single =", peek( single, p )

 	'' -----------
 	dim d as double
 	d = 1234567.8
 	
 	p = @d
 	
 	print "double =", peek( double, p )
 	
 	'' -----------
 	dim s as string
 	s = "abcdef"
 	
 	p = @s
 	
 	print "string =", peek( string, p )
 	
 	
 	sleep
