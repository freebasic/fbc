' TEST_MODE : COMPILE_AND_RUN_OK

'' regression from fbc 1.08
'' https://sourceforge.net/p/fbc/bugs/985/

dim as integer n
dim as string s
dim as double i

dim shared udt_s_called as boolean = false

type udt
	dim as integer n
	declare sub test()
	declare sub s()
	static as integer i
end type
dim as integer udt.i

sub udt.test()
	n = 4
	s()
	i = 5
end sub

sub udt.s()
	udt_s_called = true
end sub

dim x as udt

n = 1
s = "2"
i = 3

x.test()

assert( n = 1 )
assert( s = "2" )
assert( i = 3 )

assert( x.n = 4 )
assert( udt_s_called = true )
assert( x.i = 5 )

