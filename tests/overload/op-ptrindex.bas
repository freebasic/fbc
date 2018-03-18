#include "fbcunit.bi"

SUITE( fbc_tests.overload_.op_ptrindex )

	TEST_GROUP( simple )
		type UDT
			array(0 to 3) as integer
			declare operator []( index as integer ) as integer
		end type

		operator UDT.[]( index as integer ) as integer
			operator = this.array(index)
		end operator

		TEST( default )
			dim x as UDT = ( { 111, 222, 333, 444 } )
			CU_ASSERT( x[0] = 111 )
			CU_ASSERT( x[1] = 222 )
			CU_ASSERT( x[2] = 333 )
			CU_ASSERT( x[3] = 444 )

			CU_ASSERT( (x)[0] = 111 )
			CU_ASSERT( (x)[1] = 222 )
			CU_ASSERT( (x)[2] = 333 )
			CU_ASSERT( (x)[3] = 444 )

			dim px as UDT ptr = @x
			CU_ASSERT( (*px)[0] = 111 )
			CU_ASSERT( (*px)[1] = 222 )
			CU_ASSERT( (*px)[2] = 333 )
			CU_ASSERT( (*px)[3] = 444 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( byrefResult )
		type UDT
			array(0 to 3) as integer
			declare operator []( index as integer ) byref as integer
		end type

		operator UDT.[]( index as integer ) byref as integer
			operator = this.array(index)
		end operator

		TEST( default )
			dim x as UDT = ( { 111, 222, 333, 444 } )

			CU_ASSERT( x[0] = 111 )
			x[0] = 123
			CU_ASSERT( x[0] = 123 )
			x[2] = 666
			CU_ASSERT( x[0] = 123 )
			CU_ASSERT( x[1] = 222 )
			CU_ASSERT( x[2] = 666 )
			CU_ASSERT( x[3] = 444 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( multipleOverloads )
		type UDT
			i as integer
			declare operator []( index as integer ) as integer
			declare operator []( index as string ) as integer
			declare operator []( index as double ) as integer
		end type

		operator UDT.[]( index as integer ) as integer
			operator = 1
		end operator

		operator UDT.[]( index as string ) as integer
			operator = 2
		end operator

		operator UDT.[]( index as double ) as integer
			operator = 3
		end operator

		TEST( default )
			dim x as UDT
			CU_ASSERT( x[0] = 1 )
			CU_ASSERT( x["abc"] = 2 )
			CU_ASSERT( x[1.5] = 3 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( stringResult )
		type UDT
			i as integer
			declare operator []( index as integer ) as string
		end type

		operator UDT.[]( index as integer ) as string
			operator = "abc"
		end operator

		TEST( default )
			dim x as UDT
			CU_ASSERT( x[0] = "abc" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( multiPtrIndexSyntax )
		type UDT
			i as integer
			declare operator [](byval i as integer) as integer ptr
		end type

		operator UDT.[](byval i as integer) as integer ptr
			this.i += i
			operator = @this.i
		end operator

		TEST( default )
			dim x as UDT
			x.i = 100
			CU_ASSERT( x[1] = @x.i )
			CU_ASSERT( x.i = 101 )
			CU_ASSERT( x[1][0] = 102 )
			CU_ASSERT( x.i = 102 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( ptrIndexFollowedByFieldSyntax )
		type UDT
			i as integer
			declare operator [](byval i as integer) byref as UDT
		end type

		operator UDT.[](byval i as integer) byref as UDT
			this.i += i
			operator = this
		end operator

		TEST( default )
			dim x as UDT
			x.i = 100
			CU_ASSERT( @x[1] = @x )
			CU_ASSERT( x.i = 101 )
			CU_ASSERT( x[1].i = 102 )
			CU_ASSERT( x.i = 102 )
		END_TEST
	END_TEST_GROUP

END_SUITE
