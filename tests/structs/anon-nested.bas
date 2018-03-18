#include "fbcunit.bi"

SUITE( fbc_tests.structs.anon_nested )

	type parent
		as short a, b
	end type

	type test_pair
		as parent t1, t2
	end type

	const test_1 = 1234, test_2 = 5678, test_3 = 9012, test_4 = 3456

	function istrue_ref( byref p1 as test_pair, byref p2 as test_pair ) as integer
		function = (p1.t1.a = p2.t2.b) and (p1.t1.b = p2.t2.a) and (p1.t2.a = p2.t1.b) and (p1.t2.b = p2.t1.a)
	end function

	function istrue_val( byval p1 as test_pair, byval p2 as test_pair ) as integer
		function = (p1.t1.a = p2.t2.b) and (p1.t1.b = p2.t2.a) and (p1.t2.a = p2.t1.b) and (p1.t2.b = p2.t1.a)
	end function

	function istrue_ptr( byval p1 as test_pair ptr, byval p2 as test_pair ptr ) as integer
		function = (p1->t1.a = p2->t2.b) and (p1->t1.b = p2->t2.a) and (p1->t2.a = p2->t1.b) and (p1->t2.b = p2->t1.a)
	end function

	TEST( passByReference )
	  dim as integer istrue
  
	  istrue = istrue_ref( type<test_pair>( type<parent>( test_1, test_2 ), type<parent>( test_3, test_4 ) ), _ 
                  		   type<test_pair>( type<parent>( test_4, test_3 ), type<parent>( test_2, test_1 ) ) )   
  
	  CU_ASSERT( istrue )
	END_TEST

	TEST( passByValue )
	  dim as integer istrue
  
	  istrue = istrue_val( type<test_pair>( type<parent>( test_1, test_2 ), type<parent>( test_3, test_4 ) ), _ 
                  		   type<test_pair>( type<parent>( test_4, test_3 ), type<parent>( test_2, test_1 ) ) )  
  
	  CU_ASSERT( istrue )
	END_TEST

	TEST( passByAddress )
	  dim as integer istrue
  
	  istrue = istrue_ptr( @type<test_pair>( type<parent>( test_1, test_2 ), type<parent>( test_3, test_4 ) ), _ 
                  		   @type<test_pair>( type<parent>( test_4, test_3 ), type<parent>( test_2, test_1 ) ) )
  
	  CU_ASSERT( istrue )
	END_TEST

END_SUITE
