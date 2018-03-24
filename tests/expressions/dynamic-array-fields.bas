# include "fbcunit.bi"

SUITE( fbc_tests.expressions.dynamic_array_fields )

	const EPSILON_SNG as single = 1.1929093e-7

	TEST_GROUP( arrayAccess )
		type UDT1
			array(any) as integer
		end type

		type UDT2
			array(any, any) as integer
		end type

		'' simple array access
		TEST( simpleArrayAccess )
			dim x as UDT1

			redim x.array(0 to 9)

			for i as integer = 0 to 9
				x.array(i) = i
			next

			for i as integer = 0 to 9
				CU_ASSERT( x.array(i) = i )
			next

			var p = @x.array(0)
			for i as integer = 0 to 9
				CU_ASSERT( p[i] = i )
			next
		END_TEST

		'' array access with diff
		TEST( arrayAccessDiff )
			dim x as UDT1

			redim x.array(10 to 19)

			for i as integer = 10 to 19
				x.array(i) = i
			next

			for i as integer = 10 to 19
				CU_ASSERT( x.array(i) = i )
			next

			var p = @x.array(10)
			for i as integer = 0 to 9
				CU_ASSERT( p[i] = i + 10 )
			next
		END_TEST

		'' multi-dimensional array access
		TEST( multipleDimensions )
			dim x as UDT2

			redim x.array(0 to 4, 0 to 1)

			var counter = 0
			for i as integer = 0 to 4
				for j as integer = 0 to 1
					x.array(i, j) = counter
					counter += 1
				next
			next

			counter = 0
			for i as integer = 0 to 4
				for j as integer = 0 to 1
					CU_ASSERT( x.array(i, j) = counter )
					counter += 1
				next
			next

			var p = @x.array(0, 0)
			for i as integer = 0 to (5 * 2)-1
				CU_ASSERT( p[i] = i )
			next
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( compileTimeDtype )
		'' Array accesses should produce the proper dtype at compile-time

		type UDT
			array1(any) as integer
			array2(any) as string
			array3(any) as single
		end type

		'' compile time dtype
		TEST( default )
			dim x as UDT
			#assert typeof( x.array1(0) ) = typeof( integer )
			#assert typeof( x.array2(0) ) = typeof( string )
			#assert typeof( x.array3(0) ) = typeof( single )

			redim x.array1(0 to 0)
			redim x.array2(0 to 0)
			redim x.array3(0 to 0)

			var i = x.array1(0)
			var s = x.array2(0)
			var f = x.array3(0)
			#assert typeof( i ) = typeof( integer )
			#assert typeof( s ) = typeof( string )
			#assert typeof( f ) = typeof( single )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( complexDtypes )
		'' Testing float/string/UDT elements, not just integers

		dim shared as integer ctorudt_ctors, dtorudt_dtors, _
			ctordtorudt_ctors, ctordtorudt_dtors

		type CtorUdt
			i as integer
			declare constructor( )
		end type

		constructor CtorUdt( )
			ctorudt_ctors += 1
		end constructor

		type DtorUdt
			i as integer
			declare destructor( )
		end type

		destructor DtorUdt( )
			dtorudt_dtors += 1
		end destructor

		type CtorDtorUdt
			i as integer
			declare constructor( )
			declare destructor( )
		end type

		constructor CtorDtorUdt( )
			ctordtorudt_ctors += 1
		end constructor

		destructor CtorDtorUdt( )
			ctordtorudt_dtors += 1
		end destructor

		type TestUdt
			array1(any) as string
			array2(any) as single
			array3(any) as CtorUdt
			array4(any) as DtorUdt
			array5(any) as CtorDtorUdt
		end type

		'' complex dtypes
		TEST( default )
			scope
				dim x as TestUdt

				CU_ASSERT( ctorudt_ctors = 0 )
				CU_ASSERT( dtorudt_dtors = 0 )
				CU_ASSERT( ctordtorudt_ctors = 0 )
				CU_ASSERT( ctordtorudt_dtors = 0 )

				redim x.array1(0 to 1)
				redim x.array2(0 to 1)

				CU_ASSERT( ctorudt_ctors = 0 )
				CU_ASSERT( dtorudt_dtors = 0 )
				CU_ASSERT( ctordtorudt_ctors = 0 )
				CU_ASSERT( ctordtorudt_dtors = 0 )

				redim x.array3(0 to 1)

				CU_ASSERT( ctorudt_ctors = 2 )
				CU_ASSERT( dtorudt_dtors = 0 )
				CU_ASSERT( ctordtorudt_ctors = 0 )
				CU_ASSERT( ctordtorudt_dtors = 0 )

				redim x.array4(0 to 1)

				CU_ASSERT( ctorudt_ctors = 2 )
				CU_ASSERT( dtorudt_dtors = 0 )
				CU_ASSERT( ctordtorudt_ctors = 0 )
				CU_ASSERT( ctordtorudt_dtors = 0 )

				redim x.array5(0 to 1)

				CU_ASSERT( ctorudt_ctors = 2 )
				CU_ASSERT( dtorudt_dtors = 0 )
				CU_ASSERT( ctordtorudt_ctors = 2 )
				CU_ASSERT( ctordtorudt_dtors = 0 )

				x.array1(0) = "aaaaaaaa"
				x.array1(1) = "bb"
				x.array2(0) = 1.5f
				x.array2(1) = 20.8f
				x.array3(0).i = 1
				x.array3(1).i = 2
				x.array4(0).i = 3
				x.array4(1).i = 4
				x.array5(0).i = 5
				x.array5(1).i = 6

				CU_ASSERT( x.array1(0) = "aaaaaaaa" )
				CU_ASSERT( x.array1(1) = "bb" )
				CU_ASSERT( abs( x.array2(0) - 1.5f ) < EPSILON_SNG )
				CU_ASSERT( abs( x.array2(1) - 20.8f ) < EPSILON_SNG )
				CU_ASSERT( x.array3(0).i = 1 )
				CU_ASSERT( x.array3(1).i = 2 )
				CU_ASSERT( x.array4(0).i = 3 )
				CU_ASSERT( x.array4(1).i = 4 )
				CU_ASSERT( x.array5(0).i = 5 )
				CU_ASSERT( x.array5(1).i = 6 )
			end scope

			CU_ASSERT( ctorudt_ctors = 2 )
			CU_ASSERT( dtorudt_dtors = 2 )
			CU_ASSERT( ctordtorudt_ctors = 2 )
			CU_ASSERT( ctordtorudt_dtors = 2 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( passingBydesc )
		'' Testing whether dynamic array fields can be passed BYDESC nicely,
		'' and even be REDIM'ed through the BYDESC param.
		type UDT
			array(any) as integer
		end type

		function getLbound( array() as integer ) as integer
			function = lbound( array )
		end function

		function getUbound( array() as integer ) as integer
			function = ubound( array )
		end function

		function sumArray( array() as integer ) as integer
			var sum = 0
			for i as integer = lbound( array ) to ubound( array )
				CU_ASSERT( array(i) = i )
				sum += array(i)
			next
			function = sum
		end function

		sub resize( array() as integer )
			redim array(100 to 200)
		end sub

		'' BYDESC
		TEST( default )
			dim x as UDT

			CU_ASSERT( getLbound( x.array() ) = 0 )
			CU_ASSERT( getUbound( x.array() ) = -1 )

			redim x.array(10 to 20)
			CU_ASSERT( getLbound( x.array() ) = 10 )
			CU_ASSERT( getUbound( x.array() ) = 20 )

			var sum = 0
			for i as integer = lbound( x.array ) to ubound( x.array )
				x.array(i) = i
				sum += i
			next

			CU_ASSERT( sumArray( x.array() ) = sum )

			CU_ASSERT( getLbound( x.array() ) = 10 )
			CU_ASSERT( getUbound( x.array() ) = 20 )
			resize( x.array() )
			CU_ASSERT( getLbound( x.array() ) = 100 )
			CU_ASSERT( getUbound( x.array() ) = 200 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( sidefxRemoval )
		'' The compiler must properly handle side effects in the UDT variable
		'' expression (matters because the varexpr is re-used in multiple places
		'' to read out fields from the descriptor, especially with -exx) or one
		'' of the index expressions (matters especially with -exx).

		type UDT
			array(any) as integer
		end type

		dim shared globalx as UDT
		dim shared as integer f1calls, fudtcalls

		function f1( ) as integer
			f1calls += 1
			function = 1
		end function

		function fudt( ) byref as UDT
			fudtcalls += 1
			function = globalx
		end function

		'' side-effect removal
		TEST( default )
			dim x as UDT
			redim x.array(0 to 9)

			for i as integer = 0 to 9
				x.array(i) = i * 123
			next

			CU_ASSERT( f1calls = 0 )
			CU_ASSERT( x.array(f1( )) = 1 * 123 )
			CU_ASSERT( f1calls = 1 )
			CU_ASSERT( x.array(f1( ) + 3) = 4 * 123 )
			CU_ASSERT( f1calls = 2 )

			redim globalx.array(0 to 0)
			CU_ASSERT( fudtcalls = 0 )
			CU_ASSERT( fudt( ).array(0) = 0 )
			CU_ASSERT( fudtcalls = 1 )
		END_TEST
	END_TEST_GROUP

END_SUITE
