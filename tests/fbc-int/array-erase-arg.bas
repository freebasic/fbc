#include "fbcunit.bi"
#include "fbc-int/array.bi"

'' tests for array descriptor internals

SUITE( fbc_tests.fbc_int.array_erase_arg )

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

	#macro check_flags( ap, max_d, fixed_dim, fixed_len )
		if( ap ) then
			CU_ASSERT( (ap->flags and FBC.FBARRAY_FLAGS_DIMENSIONS) = max_d )
			CU_ASSERT( cbool(ap->flags and FBC.FBARRAY_FLAGS_FIXED_LEN) = fixed_len )
			CU_ASSERT( cbool(ap->flags and FBC.FBARRAY_FLAGS_FIXED_DIM) = fixed_dim )
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

	sub DoErase( a() as integer )
		erase a
	end sub

	TEST( static_fixed )
		'' static array will have descriptor because it is passed
		'' a procedure, in this case, FBC.ArrayDescriptorPtr()

		'' 1 - dimensional

		static a1(2 to 11) as integer
		dim ap1 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( a1() )
		check_array( ap1, @a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, true )
		check_dim( ap1, 0, 10, 2, 11 )

		DoErase( a1() )

		check_array( ap1, @a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, true )
		check_dim( ap1, 0, 10, 2, 11 )

		'' 2 - dimensional

		static a2(2 to 6, 3 to 12) as integer
		dim ap2 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( a2() )
		check_array( ap2, @a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, true )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

		DoErase( a2() )

		check_array( ap2, @a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, true )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

	END_TEST

	TEST( static_empty )
		'' static array will have descriptor because it is var-len

		'' unknown dimension

		static a0() as integer
		dim ap0 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( a0() )
		check_array( ap0, 0, 0, sizeof(integer), 0 )
		check_flags( ap0, FBC.FB_MAXDIMENSIONS, false, false )

		redim a0(2 to 11) as integer
		check_array( ap0, @a0(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap0, FBC.FB_MAXDIMENSIONS, false, false )
		check_dim( ap0, 0, 10, 2, 11 )

		'' number of dimensions retained after ERASE
		DoErase( a0() )

		check_array( ap0, 0, 0, sizeof(integer), 1 )
		check_flags( ap0, FBC.FB_MAXDIMENSIONS, false, false )

		'' 1 - dimensional

		static a1(any) as integer
		dim ap1 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( a1() )
		check_array( ap1, 0, 0, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 0, 0, 0 )

		redim a1(2 to 11) as integer
		check_array( ap1, @a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 10, 2, 11 )

		'' number of dimensions retained after ERASE
		DoErase( a1() )

		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 0, 0, 0 )

		'' 2 - dimensional

		static a2(any,any) as integer
		dim ap2 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( a2() )
		check_array( ap2, 0, 0, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )

		redim a2(2 to 6, 3 to 12) as integer
		check_array( ap2, @a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

		'' number of dimensions retained after ERASE
		DoErase( a2() )

		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )

	END_TEST

	TEST( local_fixed )

		'' 1 dimensional

		dim a1(2 to 11) as integer
		dim ap1 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( a1() )
		check_array( ap1, @a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, true )
		check_dim( ap1, 0, 10, 2, 11 )

		DoErase( a1() )
		check_array( ap1, @a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, true )
		check_dim( ap1, 0, 10, 2, 11 )

		'' 2 dimensional

		dim a2(2 to 6, 3 to 12) as integer
		dim ap2 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( a2() )
		check_array( ap2, @a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, true )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

		DoErase( a2() )
		check_array( ap2, @a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, true )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

	END_TEST

	TEST( local_empty )

		'' unknown dimension

		dim a0() as integer
		dim ap0 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( a0() )
		check_array( ap0, 0, 0, sizeof(integer), 0 )
		check_flags( ap0, FBC.FB_MAXDIMENSIONS, false, false )

		redim a0(2 to 11) as integer
		check_array( ap0, @a0(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap0, FBC.FB_MAXDIMENSIONS, false, false )
		check_dim( ap0, 0, 10, 2, 11 )

		'' number of dimensions retained after ERASE
		DoErase( a0() )
		check_array( ap0, 0, 0, sizeof(integer), 1 )
		check_flags( ap0, FBC.FB_MAXDIMENSIONS, false, false )

		' 1 dimensional

		dim a1(any) as integer
		dim ap1 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( a1() )
		check_array( ap1, 0, 0, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 0, 0, 0 )

		redim a1(2 to 11) as integer
		check_array( ap1, @a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 10, 2, 11 )

		DoErase( a1() )
		check_array( ap1, 0, 0, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 0, 0, 0 )

		' 2 dimensional

		dim a2(any,any) as integer
		dim ap2 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( a2() )
		check_array( ap2, 0, 0, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )

		redim a2(2 to 6, 3 to 12) as integer
		check_array( ap2, @a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

		DoErase( a2() )
		check_array( ap2, 0, 0, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )

	END_TEST

	type T_static_a0
		__ as integer
		static a0() as integer
	end type
	dim T_static_a0.a0() as integer

	TEST( UDT_static_a0 )

		dim x as T_static_a0

		dim ap0 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a0() )
		check_array( ap0, 0, 0, sizeof(integer), 0 )
		check_flags( ap0, FBC.FB_MAXDIMENSIONS, false, false )

		redim x.a0(2 to 11) as integer
		check_array( ap0, @x.a0(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap0, FBC.FB_MAXDIMENSIONS, false, false )
		check_dim( ap0, 0, 10, 2, 11 )

		'' number of dimensions retained after ERASE
		DoErase( x.a0() )
		check_array( ap0, 0, 0, sizeof(integer), 1 )
		check_flags( ap0, FBC.FB_MAXDIMENSIONS, false, false )

	END_TEST

	type T_static_a1
		__ as integer
		static a1(any) as integer
	end type
	dim T_static_a1.a1(any) as integer

	TEST( UDT_static_a1 )

		dim x as T_static_a1

		dim ap1 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a1() )
		check_array( ap1, 0, 0, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 0, 0, 0 )

		redim x.a1(2 to 11) as integer
		check_array( ap1, @x.a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 10, 2, 11 )

		DoErase( x.a1() )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 0, 0, 0 )

	END_TEST

	type T_static_a1f
		__ as integer
		static a1(2 to 11) as integer
	end type
	dim T_static_a1f.a1(2 to 11) as integer

	TEST( UDT_static_a1f )
		dim x as T_static_a1f

		dim ap1 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a1() )
		check_array( ap1, @x.a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, true )
		check_dim( ap1, 0, 10, 2, 11 )

		DoErase( x.a1() )
		check_array( ap1, @x.a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, true )
		check_dim( ap1, 0, 10, 2, 11 )

	END_TEST

	type T_static_a2
		__ as integer
		static a2(any,any) as integer
	end type
	static T_static_a2.a2(any,any) as integer

	TEST( UDT_static_a2 )

		dim x as T_static_a2

		dim ap2 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a2() )
		check_array( ap2, 0, 0, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )

		redim x.a2(2 to 6, 3 to 12) as integer
		check_array( ap2, @x.a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

		DoErase( x.a2() )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )

	END_TEST

	type T_static_a2f
		__ as integer
		static a2(2 to 6, 3 to 12) as integer
	end type
	static T_static_a2f.a2(2 to 6, 3 to 12) as integer

	TEST( UDT_static_a2f )

		dim x as T_static_a2f

		dim ap2 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a2() )
		check_array( ap2, @x.a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, true )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

		DoErase( x.a2() )
		check_array( ap2, @x.a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, true )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

	END_TEST

	type T_dim_a1
		dim a1(any) as integer
	end type

	TEST( UDT_dim_a1 )
		dim x as T_dim_a1

		dim ap1 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a1() )
		check_array( ap1, 0, 0, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 0, 0, 0 )

		redim x.a1(2 to 11) as integer
		check_array( ap1, @x.a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 10, 2, 11 )

		DoErase( x.a1() )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 0, 0, 0 )

	END_TEST

	type T_dim_a1f
		dim a1(2 to 11) as integer
	end type

	TEST( UDT_dim_a1f )
		dim x as T_dim_a1f

		dim ap1 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a1() )
		check_array( ap1, @x.a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, true )
		check_dim( ap1, 0, 10, 2, 11 )

		DoErase( x.a1() )
		check_array( ap1, @x.a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, true )
		check_dim( ap1, 0, 10, 2, 11 )

	END_TEST

	type T_dim_a2
		dim a2(any,any) as integer
	end type

	TEST( UDT_dim_a2 )
		dim x as T_dim_a2

		dim ap2 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a2() )
		check_array( ap2, 0, 0, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )

		redim x.a2(2 to 6, 3 to 12) as integer
		check_array( ap2, @x.a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

		DoErase( x.a2() )
		check_array( ap2, 0, 0, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )

	END_TEST

	type T_dim_a2f
		dim a2(2 to 6,3 to 12) as integer
	end type

	TEST( UDT_dim_a2f )
		dim x as T_dim_a2f

		dim ap2 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a2() )
		check_array( ap2, @x.a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, true )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

		DoErase( x.a2() )
		check_array( ap2, @x.a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, true )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

	END_TEST

	type T_redim_a1
		redim a1(any) as integer
	end type

	TEST( UDT_redim_a1 )
		dim x as T_redim_a1

		dim ap1 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a1() )
		check_array( ap1, 0, 0, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 0, 0, 0 )

		redim x.a1(2 to 11) as integer
		check_array( ap1, @x.a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 10, 2, 11 )

		DoErase( x.a1() )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 0, 0, 0 )

	END_TEST

	type T_redim_a1f
		redim a1(2 to 11) as integer
	end type

	TEST( UDT_redim_a1f )
		dim x as T_redim_a1f

		dim ap1 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a1() )
		check_array( ap1, @x.a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 10, 2, 11 )

		redim x.a1(2 to 11) as integer
		check_array( ap1, @x.a1(2), sizeof(integer) * 10, sizeof(integer), 1 )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 10, 2, 11 )

		DoErase( x.a1() )
		check_flags( ap1, 1, true, false )
		check_dim( ap1, 0, 0, 0, 0 )

	END_TEST

	type T_redim_a2
		redim a2(any,any) as integer
	end type

	TEST( UDT_redim_a2 )
		dim x as T_redim_a2

		dim ap2 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a2() )
		check_array( ap2, 0, 0, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )

		redim x.a2(2 to 6, 3 to 12) as integer
		check_array( ap2, @x.a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

		DoErase( x.a2() )
		check_array( ap2, 0, 0, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )

	END_TEST

	type T_redim_a2f
		redim a2(2 to 6,3 to 12) as integer
	end type

	TEST( UDT_redim_a2f )
		dim x as T_redim_a2f

		dim ap2 as FBC.FBARRAY ptr = FBC.ArrayDescriptorPtr( x.a2() )
		check_array( ap2, @x.a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

		redim x.a2(2 to 6, 3 to 12) as integer
		check_array( ap2, @x.a2(2,3), sizeof(integer) * 5 * 10, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 5, 2, 6 )
		check_dim( ap2, 1, 10, 3, 12 )

		DoErase( x.a2() )
		check_array( ap2, 0, 0, sizeof(integer), 2 )
		check_flags( ap2, 2, true, false )
		check_dim( ap2, 0, 0, 0, 0 )
		check_dim( ap2, 1, 0, 0, 0 )

	END_TEST

END_SUITE
