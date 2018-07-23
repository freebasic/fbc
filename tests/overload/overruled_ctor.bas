#include "fbcunit.bi"

/' 
 '
 ' FBC must forgo implicit construction of foo using:
 '
 ' 'enum    + integer'
 ' 'enum    + enum   '
 ' 'integer + enum   '
 '
 ' even when foo contains a constructor taking an integer or enum param
 '
 '/

SUITE( fbc_tests.overload_.overruled_ctor )
	
	enum thing explicit
		
		one
		two
		
	end enum
	
	type foo
		
		__ as integer
		
		declare constructor( byval f as integer )
		declare constructor( byval f as thing )
		
	end type
	
	constructor foo( byval f as integer )
		CU_ASSERT( 0 )
	end constructor
	
	constructor foo( byval f as thing )
		CU_ASSERT( 0 )
	end constructor
	
	operator +( byref l as foo, byref r as foo ) as foo
		CU_ASSERT( 0 )
		
		return type( 69 )
	end operator
	
	TEST( construction )
		
		dim as thing a_thing
		
		var res  = a_thing + 69
		var res2 = a_thing + a_thing
		var res3 = 69      + a_thing
		
	END_TEST
	
END_SUITE
