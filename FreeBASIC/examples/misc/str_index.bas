''
'' string indexing test
''

const teststr = "ABCDEFGHIJKLM"

type mytype
	a as integer
	s as string
	f as string * 16
	z as zstring * 16
end type	

declare sub somesub( byref s as string )
declare sub somesub2( s() as string )
declare sub somesub3( byref t as mytype )
declare sub somesub4( t() as mytype )
	
	dim as integer i = 5
	
	''---------
	dim s(10) as string

	s(i) = teststr
	print "asc('A') ="; s(i)[0];
	
	s(i)[0] = asc( "#" )
	print " "; s(i)
	
	''---------
	dim f(10) as string * 16

	f(i) = teststr
	print "asc('B') ="; f(i)[1];
	
	f(i)[1] = asc( "#" )
	print " "; f(i)

	''---------
	dim z(10) as zstring * 16

	z(i) = teststr
	print "asc('C') ="; z(i)[2];
	
	z(i)[2] = asc( "#" )
	print " "; z(i)
	
	''---------
	dim t(10) as mytype

	t(i).s = teststr
	print "asc('D') ="; t(i).s[3];
	
	t(i).s[3] = asc( "#" )
	print " "; t(i).s

	t(i).f = teststr
	print "asc('E') ="; t(i).f[4];
	
	t(i).f[4] = asc( "#" )
	print " "; t(i).f

	''---------
	t(i).z = teststr
	print "asc('F') ="; t(i).z[5];
	
	t(i).z[5] = asc( "#" )
	print " "; t(i).z

	t(i).z = teststr
	print "asc('G') ="; t(i).z[6];
	
	t(i).z[6] = asc( "#" )
	print " "; t(i).z
	
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
sub somesub( byref s as string )

	s = teststr
	print "asc('H') ="; s[7];
	
	s[7] = asc( "#" )
	print " "; s

end sub	

'':::::
sub somesub2( s() as string )

	dim as integer i = 4
	
	s(i) = teststr
	print "asc('I') ="; s(i)[8];
	
	s(i)[8] = asc( "#" )
	print " "; s(i)

end sub	

'':::::
sub somesub3( byref t as mytype )

	t.s = teststr
	print "asc('J') ="; t.s[9];
	
	t.s[9] = asc( "#" )
	print " "; t.s

	t.z = teststr
	print "asc('K') ="; t.z[10];
	
	t.z[10] = asc( "#" )
	print " "; t.z

end sub	

'':::::
sub somesub4( t() as mytype )

	dim as integer i = 2
	
	t(i).f = teststr
	print "asc('L') ="; t(i).f[11];
	
	t(i).f[11] = asc( "#" )
	print " "; t(i).f

	t(i).z = teststr
	print "asc('M') ="; t(i).z[12];
	
	t(i).z[12] = asc( "#" )
	print " "; t(i).z


end sub	
