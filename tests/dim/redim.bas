#include "fbcunit.bi"

SUITE( fbc_tests.dim_.redim_ )

	dim shared foo() as integer
	dim shared as integer globcnt

	Type T
		As Integer a, b, c, d
		Declare Constructor()
	End Type

	Constructor T()
		globcnt += 1
	End Constructor

	sub test1
		redim foo(1 to 2)
	end sub

	sub test2
		redim foo(3 to 4) as integer
	end sub

	sub test3
		redim foo(-1 to 1) as double
	end sub

	TEST( ctors )
		scope
			dim bar() as T ptr
			redim bar(1) as T ptr
			CU_ASSERT_EQUAL( globcnt, 0 )
		end scope

		scope
			dim bar () as T
			redim bar(0 to 1) as T
			CU_ASSERT_EQUAL( globcnt, 2 )
		end scope
	END_TEST

	TEST( bounds )
		test1
		CU_ASSERT_EQUAL( lbound(foo), 1 )
		CU_ASSERT_EQUAL( ubound(foo), 2 )
		
		test2
		CU_ASSERT_EQUAL( lbound(foo), 3 )
		CU_ASSERT_EQUAL( ubound(foo), 4 )
		
		test3
		CU_ASSERT_EQUAL( lbound(foo), 3 )
		CU_ASSERT_EQUAL( ubound(foo), 4 )
	END_TEST

	TEST_GROUP( typeless )
		dim shared globalarray() as string

		private function globalarrayLbound( ) as integer
			function = lbound( globalarray )
		end function

		private function globalarrayUbound( ) as integer
			function = ubound( globalarray )
		end function

		TEST( default )
			'' Typeless REDIM, should redim the global array, and not create
			'' a local var that shadows the global.
			redim globalarray(1 to 2)
			#assert typeof( globalarray ) = typeof( string )

			CU_ASSERT( lbound( globalarray ) = 1 )
			CU_ASSERT( ubound( globalarray ) = 2 )
			CU_ASSERT( globalarrayLbound( ) = 1 )
			CU_ASSERT( globalarrayUbound( ) = 2 )
		END_TEST
	END_TEST_GROUP

	'' Regression test for #3474348
	TEST_GROUP( commonRedimRedim )
		common array() as integer

		'' Common/Redim/Redim
		TEST( default )
			redim array(0 to 4) as integer
			CU_ASSERT( lbound( array ) = 0 )
			CU_ASSERT( ubound( array ) = 4 )

			redim array(0 to 9) as integer
			CU_ASSERT( lbound( array ) = 0 )
			CU_ASSERT( ubound( array ) = 9 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( commonDim )
		common array() as integer

		private function f( ) as integer
			CU_ASSERT( lbound( array ) = 0 )
			CU_ASSERT( ubound( array ) = 4 )
			function = ubound( array )
		end function

		'' Common/Dim
		TEST( default )
			'' Dim is allowed after Common -- as in QB.
			dim array(0 to 4) as integer

			CU_ASSERT( lbound( array ) = 0 )
			CU_ASSERT( ubound( array ) = 4 )

			CU_ASSERT( f( ) = 4 )
		END_TEST
	END_TEST_GROUP

	'' Regression test for #3510684: An array using a different mangling, which
	'' affects the array descriptor too -- should still work just the same.
	extern "C"
		dim shared global1() as integer
		dim shared global2(0 to 0) as integer
	end extern

	'' array + desc using non-default mangling
	TEST( externMangled )
		redim global1(0 to 0) as integer
		global1(0) = 123
		CU_ASSERT( global1(0) = 123 )

		global2(0) = 123
		CU_ASSERT( global2(0) = 123 )
	END_TEST

	TEST_GROUP( dtorOnlyElements )
		type DtorUdt
			i as integer
			declare destructor( )
		end type

		destructor DtorUdt( )
		end destructor

		'' Any number, just large enough to hopefully not be all zero when
		'' allocating this many DtorUdt's from heap
		const ARRAY_SIZE = 1024

		TEST( areClearedRedim )
			'' new array
			redim array(0 to ARRAY_SIZE-1) as DtorUdt
			for i as integer = lbound( array ) to ubound( array )
				CU_ASSERT( array(i).i = 0 )
			next

			'' increase size of existing array (at least remainder needs to be cleared)
			redim array(0 to (ARRAY_SIZE*2)-1) as DtorUdt
			for i as integer = lbound( array ) to ubound( array )
				CU_ASSERT( array(i).i = 0 )
			next
		END_TEST

		TEST( areClearedRedimPreserve )
			'' new array
			redim preserve array(0 to ARRAY_SIZE-1) as DtorUdt
			for i as integer = lbound( array ) to ubound( array )
				CU_ASSERT( array(i).i = 0 )
			next

			'' increase size of existing array (remainder needs to be cleared)
			redim preserve array(0 to (ARRAY_SIZE*2)-1) as DtorUdt
			for i as integer = lbound( array ) to ubound( array )
				CU_ASSERT( array(i).i = 0 )
			next
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( dynamicArrayVarAsExpression )
		'' Dynamic array variable given to REDIM in form of an expression,
		'' instead of just as plain identifier.

		dim shared global1() as integer

		TEST( default )
			CU_ASSERT( lbound( global1 ) = 0 ) : CU_ASSERT( ubound( global1 ) = -1 )

			redim (global1)(1 to 1)
			CU_ASSERT( lbound( global1 ) = 1 ) : CU_ASSERT( ubound( global1 ) = 1 )

			dim local1() as integer
			CU_ASSERT( lbound( local1 ) = 0 ) : CU_ASSERT( ubound( local1 ) = -1 )

			redim (local1)(1 to 1)
			CU_ASSERT( lbound( local1 ) = 1 ) : CU_ASSERT( ubound( local1 ) = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( staticMemberDynamicArrayAccess )
		'' REDIM'ing a dynamic array that is a static member in a UDT.

		type UDT
			i as integer

			static array() as integer

			declare sub f1( l as integer, u as integer )
			declare sub f2( l as integer, u as integer )
			declare sub f3( l as integer, u as integer )
			declare sub f4( l as integer, u as integer )
			declare static sub f5( l as integer, u as integer )
			declare static sub f6( l as integer, u as integer )
		end type

		dim UDT.array() as integer

		sub UDT.f1( l as integer, u as integer )
			'' static member accessed through implicit THIS
			redim (array)(l to u)
		end sub

		sub UDT.f2( l as integer, u as integer )
			'' static member accessed through implicit THIS
			redim array(l to u)
		end sub

		sub UDT.f3( l as integer, u as integer )
			'' static member accessed through explicit THIS
			redim (this.array)(l to u)
		end sub

		sub UDT.f4( l as integer, u as integer )
			redim this.array(l to u)
		end sub

		static sub UDT.f5( l as integer, u as integer )
			'' static member accessed through implicit namespace prefix
			redim (array)(l to u)
		end sub

		static sub UDT.f6( l as integer, u as integer )
			'' static member accessed through implicit namespace prefix
			redim array(l to u)
		end sub

		TEST( default )
			#macro expectbounds( l, u )
				CU_ASSERT( lbound( UDT.array ) = l )
				CU_ASSERT( ubound( UDT.array ) = u )
			#endmacro

			expectbounds( 0, -1 )

			'' static member accessed through namespace prefix
			redim UDT.array(1 to 1)
			expectbounds( 1, 1 )

			'' static member accessed through object/pointer
			dim x as UDT
			dim px as UDT ptr = @x
			expectbounds( 1, 1 )

			redim (x.array)(2 to 2)
			expectbounds( 2, 2 )

			redim x.array(1 to 1)
			expectbounds( 1, 1 )

			redim (px->array)(2 to 2)
			expectbounds( 2, 2 )

			redim px->array(1 to 1)
			expectbounds( 1, 1 )

			x.f1( 2, 2 )
			expectbounds( 2, 2 )

			x.f2( 1, 1 )
			expectbounds( 1, 1 )

			x.f3( 2, 2 )
			expectbounds( 2, 2 )

			x.f4( 1, 1 )
			expectbounds( 1, 1 )

			UDT.f5( 2, 2 )
			expectbounds( 2, 2 )

			UDT.f6( 1, 1 )
			expectbounds( 1, 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( dynamicArrayFieldsGlobal )
		type UDT
			array1(any) as integer
			array2(any) as integer
		end type

		dim shared globalx as UDT
		dim shared pglobalx as UDT ptr = @globalx

		TEST( default )
			#macro expectbounds( l1, u1, l2, u2 )
				CU_ASSERT( lbound( globalx.array1 ) = l1 ) : CU_ASSERT( ubound( globalx.array1 ) = u1 )
				CU_ASSERT( lbound( globalx.array2 ) = l2 ) : CU_ASSERT( ubound( globalx.array2 ) = u2 )
			#endmacro

			expectbounds( 0, -1, 0, -1 )

			redim (globalx.array1)(1 to 1)
			expectbounds( 1, 1, 0, -1 )

			redim (globalx.array2)(2 to 2)
			expectbounds( 1, 1, 2, 2 )

			redim globalx.array1(3 to 3)
			redim globalx.array2(4 to 4)
			expectbounds( 3, 3, 4, 4 )

			redim pglobalx->array1(1 to 1)
			redim pglobalx->array2(2 to 2)
			expectbounds( 1, 1, 2, 2 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( dynamicArrayFieldsLocal )
		type UDT
			array1(any) as integer
			array2(any) as integer
		end type

		TEST( default )
			dim x as UDT
			dim px as UDT ptr = @x

			#macro expectbounds( l1, u1, l2, u2 )
				CU_ASSERT( lbound( x.array1 ) = l1 ) : CU_ASSERT( ubound( x.array1 ) = u1 )
				CU_ASSERT( lbound( x.array2 ) = l2 ) : CU_ASSERT( ubound( x.array2 ) = u2 )
			#endmacro

			expectbounds( 0, -1, 0, -1 )

			redim (x.array1)(1 to 1)
			expectbounds( 1, 1, 0, -1 )

			redim (x.array2)(2 to 2)
			expectbounds( 1, 1, 2, 2 )

			redim x.array1(3 to 3)
			redim x.array2(4 to 4)
			expectbounds( 3, 3, 4, 4 )

			redim px->array1(1 to 1)
			redim px->array2(2 to 2)
			expectbounds( 1, 1, 2, 2 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( implicitThisExplicitType )
		'' REDIMs in methods should redim array fields, instead of making new
		'' local arrays

		type UDT
			array(any) as integer
			declare sub f1()
			declare sub f2()
		end type

		sub UDT.f1()
			redim array(1 to 1) as integer
		end sub

		sub UDT.f2()
			redim array(2 to 2)
		end sub

		TEST( default )
			dim x as UDT
			CU_ASSERT( lbound( x.array ) = 0 )
			CU_ASSERT( ubound( x.array ) = -1 )
			x.f1( )
			CU_ASSERT( lbound( x.array ) = 1 )
			CU_ASSERT( ubound( x.array ) = 1 )
			x.f2( )
			CU_ASSERT( lbound( x.array ) = 2 )
			CU_ASSERT( ubound( x.array ) = 2 )
		END_TEST
	END_TEST_GROUP

END_SUITE
