#include "fbcunit.bi"

SUITE( fbc_tests.structs.anon_assign )

	type t
		a as short
		b as integer
		c(0 to 1) as single
		d as double
	end type

	TEST( test1 )
		dim as t udt = (1, 2, {3, 4}, 5 ) 
		
		CU_ASSERT_EQUAL( udt.a, 1 )
		CU_ASSERT_EQUAL( udt.b, 2 )
		CU_ASSERT_EQUAL( udt.c(0), 3 )
		CU_ASSERT_EQUAL( udt.c(1), 4 )
		CU_ASSERT_EQUAL( udt.d, 5 )
	END_TEST

	TEST( test2 )
		static as t udt = (1, 2, {3, 4}, 5 ) 
		
		CU_ASSERT_EQUAL( udt.a, 1 )
		CU_ASSERT_EQUAL( udt.b, 2 )
		CU_ASSERT_EQUAL( udt.c(0), 3 )
		CU_ASSERT_EQUAL( udt.c(1), 4 )
		CU_ASSERT_EQUAL( udt.d, 5 )
	END_TEST

	TEST( test3 )
		dim as t udt
		
		udt = type( -1, -2, {-3, -4}, -5 )

		CU_ASSERT_EQUAL( udt.a, -1 )
		CU_ASSERT_EQUAL( udt.b, -2 )
		CU_ASSERT_EQUAL( udt.c(0), -3 )
		CU_ASSERT_EQUAL( udt.c(1), -4 )
		CU_ASSERT_EQUAL( udt.d, -5 )	
	END_TEST

	TEST( test4 )
		static as t udt
		
		udt = type( -1, -2, {-3, -4}, -5 )

		CU_ASSERT_EQUAL( udt.a, -1 )
		CU_ASSERT_EQUAL( udt.b, -2 )
		CU_ASSERT_EQUAL( udt.c(0), -3 )
		CU_ASSERT_EQUAL( udt.c(1), -4 )
		CU_ASSERT_EQUAL( udt.d, -5 )	
	END_TEST

	'' ctorcall + CONST bits
	TEST_GROUP( ctorcallDespiteConstBits )
		dim shared as integer ctors

		type UDT
			i as integer
			declare constructor( )
		end type

		constructor UDT( )
			ctors += 1
		end constructor

		TEST( default )
			CU_ASSERT( ctors = 0 )
			dim x as UDT
			x.i = 123

			CU_ASSERT( ctors = 1 )

			'' This should be parsed as ctor call, not as UDT initializer,
			'' despite the CONST
			x = type<const UDT>( )

			CU_ASSERT( x.i = 0 )
			CU_ASSERT( ctors = 2 )
		END_TEST
	END_TEST_GROUP

	'' type() initializer for UDTs with ctor
	TEST_GROUP( anonCtorCallInit )
		type A
			i as integer
			declare constructor( )
		end type

		constructor A( )
			i = 123
		end constructor

		type B
			i as integer
			declare function f( byref x as A = type( ) ) as integer
		end type

		function B.f( byref x as A ) as integer
			function = x.i
		end function

		TEST( default )
			dim xa as A = type( )
			CU_ASSERT( xa.i = 123 )

			dim xb as B
			CU_ASSERT( xb.f( ) = 123 )
		END_TEST
	END_TEST_GROUP

END_SUITE
