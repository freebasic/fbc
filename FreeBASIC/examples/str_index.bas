
const teststr = "ABCDEFGH"

type mytype
	a as integer
	s as string
	f as string * 10
end type	

declare sub somesub( s as string )
declare sub somesub2( s() as string )
declare sub somesub3( t as mytype )
declare sub somesub4( t() as mytype )
	
	i = 5
	
	''---------
	dim s(10) as string

	s(i) = teststr
	print "asc('A') ="; s(i)[0]
	
	s(i)[0] = asc( "#" )
	print s(i)
	
	''---------
	dim f(10) as string * 10

	f(i) = teststr
	print "asc('B') ="; f(i)[1]
	
	f(i)[1] = asc( "#" )
	print f(i)
	
	''---------
	dim t(10) as mytype

	t(i).s = teststr
	print "asc('C') ="; t(i).s[2]
	
	t(i).s[2] = asc( "#" )
	print t(i).s

	t(i).f = teststr
	print "asc('D') ="; t(i).f[3]
	
	t(i).f[3] = asc( "#" )
	print t(i).f
	
	''---------

	somesub s(3)

	''---------

	somesub2 s()

	''---------

	somesub3 t(9)

	''---------

	somesub4 t()


	sleep
	
'':::::
sub somesub( s as string )

	s = teststr
	print "asc('E') ="; s[4]
	
	s[4] = asc( "#" )
	print s

end sub	

'':::::
sub somesub2( s() as string )

	i = 4
	
	s(i) = teststr
	print "asc('F') ="; s(i)[5]
	
	s(i)[5] = asc( "#" )
	print s(i)

end sub	

'':::::
sub somesub3( t as mytype )

	t.s = teststr
	print "asc('G') ="; t.s[6]
	
	t.s[6] = asc( "#" )
	print t.s

end sub	

'':::::
sub somesub4( t() as mytype )

	i = 2
	
	t(i).f = teststr
	print "asc('H') ="; t(i).f[7]
	
	t(i).f[7] = asc( "#" )
	print t(i).f

end sub	
