# include once "fbcunit.bi"

SUITE( fbc_tests.expressions.selfbops )

	TEST_GROUP( bitfields )
		type UDT
			a : 1 as integer
			b : 4 as integer
		end type

		TEST( default )
			scope
				dim x as UDT
				CU_ASSERT( x.a = 0 )
				CU_ASSERT( x.b = 0 )

				x.a += 1
				CU_ASSERT( x.a = 1 )
				CU_ASSERT( x.b = 0 )

				x.b += 3
				CU_ASSERT( x.a = 1 )
				CU_ASSERT( x.b = 3 )

				x.a and= -1
				CU_ASSERT( x.a = 1 )
				CU_ASSERT( x.b = 3 )

				x.a and= 0
				CU_ASSERT( x.a = 0 )
				CU_ASSERT( x.b = 3 )

				x.b and= 1
				CU_ASSERT( x.a = 0 )
				CU_ASSERT( x.b = 1 )
			end scope

			scope
				dim x as UDT
				var px = @x
				CU_ASSERT( px->a = 0 )
				CU_ASSERT( px->b = 0 )

				px->a += 1
				CU_ASSERT( px->a = 1 )
				CU_ASSERT( px->b = 0 )

				px->b += 3
				CU_ASSERT( px->a = 1 )
				CU_ASSERT( px->b = 3 )

				px->a and= -1
				CU_ASSERT( px->a = 1 )
				CU_ASSERT( px->b = 3 )

				px->a and= 0
				CU_ASSERT( px->a = 0 )
				CU_ASSERT( px->b = 3 )

				px->b and= 1
				CU_ASSERT( px->a = 0 )
				CU_ASSERT( px->b = 1 )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( sidefxRemoval )
		dim shared as integer f1calls, f2calls
		dim shared as integer i

		function f1( ) as integer
			f1calls += 1
			function = 0
		end function

		function f2( ) byref as integer
			f2calls += 1
			function = i
		end function

		TEST( default )
			dim array(0 to 0) as integer
			CU_ASSERT( f1calls = 0 )
			CU_ASSERT( array(0) = 0 )
			array(f1( )) += 123
			CU_ASSERT( f1calls = 1 )
			CU_ASSERT( array(0) = 123 )

			CU_ASSERT( f2calls = 0 )
			CU_ASSERT( i = 0 )
			f2( ) += 456
			CU_ASSERT( f2calls = 1 )
			CU_ASSERT( i = 456 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( sidefxRemovalWithBitfields )
		type UDT
			a : 1 as integer
			b : 1 as integer
		end type

		dim shared as integer fcalls
		dim shared as UDT x

		function f( ) byref as UDT
			fcalls += 1
			function = x
		end function

		TEST( default )
			CU_ASSERT( fcalls = 0 )
			CU_ASSERT( x.a = 0 )
			CU_ASSERT( x.b = 0 )
			f( ).a += 1
			CU_ASSERT( fcalls = 1 )
			CU_ASSERT( x.a = 1 )
			CU_ASSERT( x.b = 0 )
			f( ).b += 1
			CU_ASSERT( fcalls = 2 )
			CU_ASSERT( x.a = 1 )
			CU_ASSERT( x.b = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( sidefxRemovalWithStringConcat )
		dim shared as integer fcalls
		dim shared as integer globali
		dim shared as string a, b

		function f( byval i as integer, byref s as string ) byref as integer
			if( i = 0 ) then
				CU_ASSERT( s = a + b )
			else
				CU_ASSERT( s = b + a )
			end if
			fcalls += 1
			function = globali
		end function

		TEST( default )
			a = "a"
			b = "b"

			CU_ASSERT( fcalls = 0 )
			CU_ASSERT( globali = 0 )
			f( 0, a + b ) += 5
			CU_ASSERT( fcalls = 1 )
			CU_ASSERT( globali = 5 )
			f( 1, b + a ) += 5
			CU_ASSERT( fcalls = 2 )
			CU_ASSERT( globali = 10 )
		END_TEST
	END_TEST_GROUP

END_SUITE
