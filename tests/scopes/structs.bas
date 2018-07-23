#include "fbcunit.bi"

SUITE( fbc_tests.scopes.structs )

	const TEST_VAL1 = 1234
	const TEST_VAL2 = 5678
	const TEST_VAL3 = &hdeadbeef
	const TEST_VAL4 = &hdeadc0de

	type foo
		bar as integer
	end type

	TEST( test1 )
		type baz
			f as foo
		end type

		type baz_alias as baz

		dim b as baz_alias = ( ( TEST_VAL3 ) )

		CU_ASSERT( b.f.bar = TEST_VAL3 )
	END_TEST

	TEST( test2 )
		type baz
			f as foo
		end type

		type baz_alias as baz

		dim b as baz_alias = ( ( TEST_VAL4 ) )

		CU_ASSERT( b.f.bar = TEST_VAL4 )
	END_TEST

	TEST( test3 )
		scope
			type baz
				f as foo
			end type

			type baz_alias as baz

			dim b as baz_alias = ( ( TEST_VAL1 ) )

			CU_ASSERT( b.f.bar = TEST_VAL1 )
		end scope

		scope
			type baz
				f as foo
			end type

			type baz_alias as baz

			dim b as baz_alias = ( ( TEST_VAL2 ) )

			CU_ASSERT( b.f.bar = TEST_VAL2 )
		end scope
	END_TEST

	TEST( test4 )
		'' -gen gcc test - this should compile fine
		type UDT1
			i as integer
		end type

		scope
			dim x as UDT1
			x.i = 123
			CU_ASSERT( x.i = 123 )
		end scope

		scope
			dim x as UDT1
			x.i = 456
			CU_ASSERT( x.i = 456 )
		end scope
	END_TEST

	TEST( test5 )
		'' -gen gcc test - this should compile fine
		scope
			type UDT2
				as integer a, b
			end type
			dim x as UDT2
			x.a = 1
			x.b = 2
			CU_ASSERT( x.a = 1 )
			CU_ASSERT( x.b = 2 )
			CU_ASSERT( sizeof( x ) = (sizeof( integer ) * 2) )
		end scope

		scope
			type UDT2
				as integer a, b, c, d
			end type
			dim x as UDT2
			x.a = 1
			x.b = 2
			x.c = 3
			x.d = 4
			CU_ASSERT( x.a = 1 )
			CU_ASSERT( x.b = 2 )
			CU_ASSERT( x.c = 3 )
			CU_ASSERT( x.d = 4 )
			CU_ASSERT( sizeof( x ) = (sizeof( integer ) * 4) )
		end scope
	END_TEST

END_SUITE
