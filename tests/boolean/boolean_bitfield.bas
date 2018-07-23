# include "fbcunit.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE (-1)

SUITE( fbc_tests.boolean_.boolean_bitfield )
	type T1
		union
			type
				as boolean b0:1
				as boolean b1:1
				as boolean b2:1
				as boolean b3:1
			end type
			type
				as byte xb0:1
				as byte xb1:1
				as byte xb2:1
				as byte xb3:1
			end type
			as ubyte x
		end union
	end type

	TEST( boolean_only )
		dim as T1 a

		for i as ubyte = 0 to 15

			a.x = i

			if( (i and 1) <> 0 ) then
				CU_ASSERT_EQUAL( a.xb0, 1 )
			else
				CU_ASSERT_EQUAL( a.xb0, 0 )
			end if

			if( (i and 2) <> 0 ) then
				CU_ASSERT_EQUAL( a.xb1, 1 )
			else
				CU_ASSERT_EQUAL( a.xb1, 0 )
			end if

			if( (i and 4) <> 0 ) then
				CU_ASSERT_EQUAL( a.xb2, 1 )
			else
				CU_ASSERT_EQUAL( a.xb2, 0 )
			end if

			if( (i and 8) <> 0 ) then
				CU_ASSERT_EQUAL( a.xb3, 1 )
			else
				CU_ASSERT_EQUAL( a.xb3, 0 )
			end if

			if( (i and 1) <> 0 ) then
				CU_ASSERT_EQUAL( a.b0, -1 )
			else
				CU_ASSERT_EQUAL( a.b0, 0 )
			end if

			if( (i and 2) <> 0 ) then
				CU_ASSERT_EQUAL( a.b1, -1 )
			else
				CU_ASSERT_EQUAL( a.b1, 0 )
			end if

			if( (i and 4) <> 0 ) then
				CU_ASSERT_EQUAL( a.b2, -1 )
			else
				CU_ASSERT_EQUAL( a.b2, 0 )
			end if

			if( (i and 8) <> 0 ) then
				CU_ASSERT_EQUAL( a.b3, -1 )
			else
				CU_ASSERT_EQUAL( a.b3, 0 )
			end if

		next

	END_TEST

	type UDT
		a : 1 as boolean
		b : 1 as boolean
		c : 1 as boolean
	end type

	TEST( assignment_unsigned_const )

		scope
			dim x as UDT
			x.a = 1u
			CU_ASSERT_EQUAL( x.a, -1 )
			CU_ASSERT_EQUAL( x.b, 0 )
			CU_ASSERT_EQUAL( x.c, 0 )
		end scope

		scope
			dim x as UDT
			x.b = 1u
			CU_ASSERT_EQUAL( x.a, 0 )
			CU_ASSERT_EQUAL( x.b, -1 )
			CU_ASSERT_EQUAL( x.c, 0 )
		end scope

		scope
			dim x as UDT
			x.c = 1u
			CU_ASSERT_EQUAL( x.a, 0 )
			CU_ASSERT_EQUAL( x.b, 0 )
			CU_ASSERT_EQUAL( x.c, -1 )
		end scope

	END_TEST

	TEST( assignment_unsigned_variable )

		dim value as uinteger = 1
		scope
			dim x as UDT
			x.a = value
			CU_ASSERT_EQUAL( x.a, -1 )
			CU_ASSERT_EQUAL( x.b, 0 )
			CU_ASSERT_EQUAL( x.c, 0 )
		end scope

		scope
			dim x as UDT
			x.b = value
			CU_ASSERT_EQUAL( x.a, 0 )
			CU_ASSERT_EQUAL( x.b, -1 )
			CU_ASSERT_EQUAL( x.c, 0 )
		end scope

		scope
			dim x as UDT
			x.c = value
			CU_ASSERT_EQUAL( x.a, 0 )
			CU_ASSERT_EQUAL( x.b, 0 )
			CU_ASSERT_EQUAL( x.c, -1 )
		end scope

	END_TEST

	TEST( assignment_signed_const )

		scope
			dim x as UDT
			x.a = 1
			CU_ASSERT_EQUAL( x.a, -1 )
			CU_ASSERT_EQUAL( x.b, 0 )
			CU_ASSERT_EQUAL( x.c, 0 )
		end scope

		scope
			dim x as UDT
			x.b = 1
			CU_ASSERT_EQUAL( x.a, 0 )
			CU_ASSERT_EQUAL( x.b, -1 )
			CU_ASSERT_EQUAL( x.c, 0 )
		end scope

		scope
			dim x as UDT
			x.c = 1
			CU_ASSERT_EQUAL( x.a, 0 )
			CU_ASSERT_EQUAL( x.b, 0 )
			CU_ASSERT_EQUAL( x.c, -1 )
		end scope

	END_TEST

	TEST( assignment_signed_variable )

		dim value as integer = 1
		scope
			dim x as UDT
			x.a = value
			CU_ASSERT_EQUAL( x.a, -1 )
			CU_ASSERT_EQUAL( x.b, 0 )
			CU_ASSERT_EQUAL( x.c, 0 )
		end scope

		scope
			dim x as UDT
			x.b = value
			CU_ASSERT_EQUAL( x.a, 0 )
			CU_ASSERT_EQUAL( x.b, -1 )
			CU_ASSERT_EQUAL( x.c, 0 )
		end scope

		scope
			dim x as UDT
			x.c = value
			CU_ASSERT_EQUAL( x.a, 0 )
			CU_ASSERT_EQUAL( x.b, 0 )
			CU_ASSERT_EQUAL( x.c, -1 )
		end scope

	END_TEST

END_SUITE
