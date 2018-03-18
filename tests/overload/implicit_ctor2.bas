#include "fbcunit.bi"

/' 
 '
 ' If a UDT's binary operator is overloaded, and one side of the 
 ' expression exactly matches the corresponding parameter of
 ' the overloaded binary operator, then if necessary the other side of the
 ' expression must construct an object using the operator argument
 ' as an argument to the UDT's constructor.
 '
 '/

SUITE( fbc_tests.overload_.implicit_ctor2 )
	
	enum thing
		one
		two
	end enum
	
	type foo
		
		__ as integer
		
		declare constructor( )
		declare constructor( byval f as integer )
		
	end type
	
	constructor foo( )
	end constructor
	
	constructor foo( byval f as integer )
		__ = f
	end constructor
	
	operator +( byval a as thing, byref r as foo ) as foo
		return type( r.__ + a )
	end operator
	
	TEST( construction )
		
		dim as thing bar = one
		dim as foo a = one + 1
		
		CU_ASSERT( a.__ = two )
		
	END_TEST
	
END_SUITE
