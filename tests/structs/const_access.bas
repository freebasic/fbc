#include "fbcunit.bi"

SUITE( fbc_tests.structs.const_access )

	type foo
		const const_i = 1
		const const_d = 2.5
		
		enum enum_1
			value_1 = 1234	
			value_2 = -5678
		end enum
		
		as integer pad
	end type

	TEST( test1 )
		dim f as foo ptr = new foo
		
		CU_ASSERT_EQUAL( f->const_i, 1 )
		CU_ASSERT_EQUAL( f->const_d, 2.5 )
		CU_ASSERT_EQUAL( f->value_1, 1234 )
		CU_ASSERT_EQUAL( f->value_2, -5678 )
		
		delete (f)
		
	END_TEST

	TEST( test2 )
		dim f as foo
		
		CU_ASSERT_EQUAL( f.const_i, 1 )
		CU_ASSERT_EQUAL( f.const_d, 2.5 )
		CU_ASSERT_EQUAL( f.value_1, 1234 )
		CU_ASSERT_EQUAL( f.value_2, -5678 )
		
	END_TEST

	TEST( test3 )
		dim f as foo ptr = new foo
		
		CU_ASSERT_EQUAL( f[0].const_i, 1 )
		CU_ASSERT_EQUAL( f[0].const_d, 2.5 )
		CU_ASSERT_EQUAL( f[0].value_1, 1234 )
		CU_ASSERT_EQUAL( f[0].value_2, -5678 )
		
		delete (f)
		
	END_TEST

	TEST( test4 )
		dim f as foo
		
		with f
			CU_ASSERT_EQUAL( .const_i, 1 )
			CU_ASSERT_EQUAL( .const_d, 2.5 )
			CU_ASSERT_EQUAL( .value_1, 1234 )
			CU_ASSERT_EQUAL( .value_2, -5678 )
		end with
		
	END_TEST

	function ret_foo () as foo
		return type<foo>( 0 )
	end function

	TEST( test5 )
		
		CU_ASSERT_EQUAL( ret_foo().const_i, 1 )
		CU_ASSERT_EQUAL( ret_foo().const_d, 2.5 )
		CU_ASSERT_EQUAL( ret_foo().value_1, 1234 )
		CU_ASSERT_EQUAL( ret_foo().value_2, -5678 )
		
	END_TEST

	function ret_pfoo () as foo ptr
		static as foo sf
		return @sf
	end function

	TEST( test6 )
		
		CU_ASSERT_EQUAL( ret_pfoo()->const_i, 1 )
		CU_ASSERT_EQUAL( ret_pfoo()->const_d, 2.5 )
		CU_ASSERT_EQUAL( ret_pfoo()->value_1, 1234 )
		CU_ASSERT_EQUAL( ret_pfoo()->value_2, -5678 )
		
	END_TEST

END_SUITE
