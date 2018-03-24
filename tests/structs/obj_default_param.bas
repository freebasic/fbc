#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_default_param )

	const TEST_VAL = &hdeadc0de

	type foo
		 value As integer = any
		 
		 '' default ctor
		 declare constructor( byval value as integer = TEST_VAL )
		 
		 declare destructor( )
	end type

	constructor foo( Byval value As Integer )
	  this.value = value
	End constructor

	destructor foo()
	  '' do nothing
	end destructor

	'' default param
	function func ( byref param as foo = foo ) as integer
		static as foo ptr lastparam = 0
		
		CU_ASSERT_NOT_EQUAL( lastparam, @param )
		
		lastparam = @param
		
		function = param.value
		
	end function

	TEST( all )
		'' call it twice, the same anon/temp shouldn't be reused
		CU_ASSERT_EQUAL( func, TEST_VAL )
		CU_ASSERT_EQUAL( func, TEST_VAL )
	END_TEST

END_SUITE
