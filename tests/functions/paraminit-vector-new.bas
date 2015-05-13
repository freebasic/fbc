' TEST_MODE : COMPILE_ONLY_OK

'' Regression test: new[] ctorlist loop labels were not cloned, causing
'' duplicate labels to be emitted. The bug didn't happen when the code was
'' inside a namespace, because of that this is not handled as a CUnit test.

type UDT
	i as integer
end type

type ClassUDT
	i as integer
	declare constructor( )
	declare constructor( byref as ClassUDT )
	declare destructor( )
end type

constructor ClassUDT( )
	i = 123
end constructor

constructor ClassUDT( byref rhs as ClassUDT )
	i = rhs.i
end constructor

destructor ClassUDT( )
end destructor

dim shared as integer calls

function sidefx( ) as integer
	calls += 1
	function = 4
end function

function f( byval p as ClassUDT ptr ) as UDT
	function = type( p[0].i )
	delete[] p
end function

sub tester( byref x as UDT = f( new ClassUDT[sidefx( )] ) )
	print x.i
end sub

sub foo( )
	tester( )
	tester( )
end sub

foo( )
tester( )
tester( )
