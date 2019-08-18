#include "fbcunit.bi"
#include "fbc-int/array.bi"

using FBC

'' tests for array descriptor internals

SUITE( fbc_tests.fbc_int.array )

	#macro check_array( ap, b, s, e, d )
		if( ap ) then
			CU_ASSERT( ap->base_ptr = b )
			CU_ASSERT( ap->size = s )
			CU_ASSERT( ap->element_len = e )
			CU_ASSERT( ap->dimensions = d )
		else
			CU_FAIL()
		end if
	#endmacro

	#macro check_dim( ap, d, e, l, u )
		if( ap ) then
			CU_ASSERT( ap->dimTb(d).elements = e )
			CU_ASSERT( ap->dimTb(d).lbound = l )
			CU_ASSERT( ap->dimTb(d).ubound = u )
		else
			CU_FAIL()
		end if
	#endmacro
	
	TEST( static_fixed )
		'' static array will have descriptor because it is passed
		'' a procedure, in this case, fb_ArrayGetDesc() 
	
		static a1(2 to 11) as integer
		dim ap1 as FBARRAY ptr = fb_ArrayGetDesc( a1() )
		check_array( ap1, @a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_dim( ap1, 0, 10, 2, 11 )
		
		static a2(2 to 6, 3 to 12) as integer
		dim ap2 as FBARRAY ptr = fb_ArrayGetDesc( a2() )
		check_array( ap2, @a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )
	END_TEST

   	TEST( static_empty )
   		'' static array will have descriptor because it is dynamic

		static a0() as integer
		dim ap0 as FBARRAY ptr = fb_ArrayGetDesc( a0() )
		check_array( ap0, 0, 0, sizeof(integer), 0 )
	
		static a1(any) as integer
		dim ap1 as FBARRAY ptr = fb_ArrayGetDesc( a1() )
		check_array( ap1, 0, 0, sizeof(integer), 1 )
		check_dim( ap1, 0, 0, 0, 0 )

		static a2(any,any) as integer
		dim ap2 as FBARRAY ptr = fb_ArrayGetDesc( a2() )
		check_array( ap2, 0, 0, sizeof(integer), 2 )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )
	END_TEST

	TEST( local_fixed )
		dim a1(2 to 11) as integer
		dim ap1 as FBARRAY ptr = fb_ArrayGetDesc( a1() )
		check_array( ap1, @a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_dim( ap1, 0, 10, 2, 11 )

		dim a2(2 to 6, 3 to 12) as integer
		dim ap2 as FBARRAY ptr = fb_ArrayGetDesc( a2() )
		check_array( ap2, @a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )
	END_TEST

	TEST( local_empty )
		dim a0() as integer
		dim ap0 as FBARRAY ptr = fb_ArrayGetDesc( a0() )
		check_array( ap0, 0, 0, sizeof(integer), 0 )
	
		dim a1(any) as integer
		dim ap1 as FBARRAY ptr = fb_ArrayGetDesc( a1() )
		check_array( ap1, 0, 0, sizeof(integer), 1 )
		check_dim( ap1, 0, 0, 0, 0 )

		dim a2(any,any) as integer
		dim ap2 as FBARRAY ptr = fb_ArrayGetDesc( a2() )
		check_array( ap2, 0, 0, sizeof(integer), 2 )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )
	END_TEST

END_SUITE
