''
'' simple variable initializers test
''

type mytype
	as integer a, b
	as short c(0 to 2)
	as byte d
end type

declare sub testproc( byval a as integer, byval b as integer )
		
	'' module-level variables
	dim arraytype(10) as mytype => { ( 1, 2, { 3, 4, 5 }, 6 ), ( 1*2, 2*2, { 3*2, 4*2, 5*2 }, 6*2 ) }
	print "4 ="; arraytype(0).c(1)
	
	dim someint as integer => 3 + 2
	print "5 ="; someint
	
	dim somestr as string * 6 => "abc" + "def"
	print "abcdef = "; somestr
	

	randomize timer
	
	testproc( rnd * 5, rnd * 5 )
	
	sleep
	

'':::::
sub testproc( byval a as integer, byval b as integer )
	'' local variables
	dim typearray(0 to 1) as mytype => { ( a, 2, { 3, 4, 5 }, 6 ), ( b, 3, { 4, 5, 6 }, 7 ) }
	dim localvar as integer => a * b
	
	'' static variables
	static array2d(0 to 2, 0 to 3) as integer => { {1, 2, 3, 4}, {5, 6, 7, 8} }
	static zstrarray( 0 to 2, 0 to 2 ) as zstring * 10 => { { "abc", "def" }, { "ghi", "jkl" } }
	
	print "7 ="; typearray(1).d
	
	print "8 ="; array2d(1, 3)
	
	print "jkl = "; zstrarray(1, 1)
	
	print a; " *"; b; " ="; localvar
	
end sub
