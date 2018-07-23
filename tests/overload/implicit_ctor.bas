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

SUITE( fbc_tests.overload_.implicit_ctor )
	
	type foo
		
		__ as integer
		
		declare constructor( )
		declare constructor( byval f as integer )
		declare constructor( byref cp as foo )
		
		declare operator cast( ) as integer
		
	end type
	
	constructor foo( )
	end constructor
	
	constructor foo( byval f as integer )
		__ = f
	end constructor
	
	constructor foo( byref cp as foo )
		this = cp
	end constructor
	
	operator foo.cast( ) as integer
		CU_ASSERT( 0 )
		return __
	end operator
	
	operator +( byref l as foo, byref r as foo ) as foo
		return type( l.__ + r.__ )
	end operator
	
	TEST( construction )
		
		dim as foo a = 66
		dim as foo b = a + 3
		
		CU_ASSERT( b.__ = 69 )
		
	END_TEST
	
END_SUITE
