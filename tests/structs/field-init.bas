#include "fbcunit.bi"

SUITE( fbc_tests.structs.field_init )

	'' POD field init
	TEST_GROUP( pod )
		type A
			as integer i, j, k
		end type

		type B
			c as A = (1, 2, 3)
			d as A = (4, 5, 6)
		end type

		type Integers
			as integer a = 1, b = 2, c = 3
		end type

		TEST( default )
			dim x as B

			CU_ASSERT( x.c.i = 1 )
			CU_ASSERT( x.c.j = 2 )
			CU_ASSERT( x.c.k = 3 )

			CU_ASSERT( x.d.i = 4 )
			CU_ASSERT( x.d.j = 5 )
			CU_ASSERT( x.d.k = 6 )

			dim as Integers ints
			CU_ASSERT( ints.a = 1 )
			CU_ASSERT( ints.b = 2 )
			CU_ASSERT( ints.c = 3 )
		END_TEST
	END_TEST_GROUP

	'' Complex field init
	TEST_GROUP( complex )
		type A
			as string s = "123"
			declare constructor( )
			declare constructor( byref as string )
		end type

		constructor A( )
		end constructor

		constructor A( byref s as string )
			this.s = s
		end constructor

		type B
			as A a = A( "456" )
		end type

		TEST( default )
			dim as A a1
			CU_ASSERT( a1.s = "123" )

			dim as A a2 = A( "234" )
			CU_ASSERT( a2.s = "234" )

			dim as B b1
			CU_ASSERT( b1.a.s = "456" )
		END_TEST
	END_TEST_GROUP

	'' '= ANY' UDT field init
	TEST_GROUP( anyInit )
		dim shared as integer ctor_count

		type Nested
			as integer i
			declare constructor( )
		end type

		constructor Nested( )
			ctor_count += 1
		end constructor

		type Parent
			as Nested nested = any
			declare constructor( )
		end type

		constructor Parent( )
			CU_ASSERT( ctor_count = 0 )
			nested.constructor( )
			CU_ASSERT( ctor_count = 1 )
		end constructor

		'' Even the =Any initializer should cause an implicit ctor to be added,
		'' for consistency
		type A
			i as integer = any
		end type

		type B
			i as integer = any
			declare constructor( )
		end type

		constructor B( )
			i = 111
		end constructor

		TEST( default )
			CU_ASSERT( ctor_count = 0 )
			dim as Parent x
			CU_ASSERT( ctor_count = 1 )

			dim xa as A = A( )

			dim xb as B
			CU_ASSERT( xb.i = 111 )
		END_TEST
	END_TEST_GROUP

	'' arrays
	TEST_GROUP( arrays )
		'' ubyte
		const TEST_F1_0 = &h11
		const TEST_F1_1 = &h12
		const TEST_F1_2 = &h13

		'' ushort
		const TEST_F2_0 = &h2122
		const TEST_F2_1 = &h2324
		const TEST_F2_2 = &h2526

		'' uinteger
		const TEST_F3_0 = &h31323334
		const TEST_F3_1 = &h35363738

		'' uinteger
		const TEST_F4_1 = &h41424344
		const TEST_F4_2 = &h45464748

		'' string
		const TEST_F5_0 = "First"
		const TEST_F5_1 = "Second"

		type foo field = 1
			pad as integer = 1234
			f1(0 to 2) as ubyte = { TEST_F1_0, TEST_F1_1, TEST_F1_2 }
			f2(0 to 2) as ushort = { TEST_F2_0, TEST_F2_1, TEST_F2_2 }
			f3(0 to 1) as uinteger = { TEST_F3_0, TEST_F3_1 }
			f4(1 to 2) as uinteger = { TEST_F4_1, TEST_F4_2 }
			f5(0 to 1) as string = { TEST_F5_0, TEST_F5_1 }
		end type

		type bar field = 1
			f1 as ubyte
			f2 as ushort
			f3 as uinteger
		end type

		type baz field = 1
			pad as integer = 5678
			b1( 0 to 1 ) as bar = { _
				(TEST_F1_0, TEST_F2_0, TEST_F3_0), _
				(TEST_F1_1, TEST_F2_1, TEST_F3_1) _
			}
			b2( 0 to 1 ) as bar = { _
				(TEST_F1_1, TEST_F2_1, TEST_F3_1),_
				(TEST_F1_0, TEST_F2_0, TEST_F3_0) _
			}
		end type

		TEST( array1 )
			dim f as foo

			CU_ASSERT_EQUAL( f.pad, 1234 )

			'' ubyte
			CU_ASSERT_EQUAL( f.f1(0), TEST_F1_0 )
			CU_ASSERT_EQUAL( f.f1(1), TEST_F1_1 )
			CU_ASSERT_EQUAL( f.f1(2), TEST_F1_2 )

			'' ushort
			CU_ASSERT_EQUAL( f.f2(0), TEST_F2_0 )
			CU_ASSERT_EQUAL( f.f2(1), TEST_F2_1 )
			CU_ASSERT_EQUAL( f.f2(2), TEST_F2_2 )

			'' uinteger
			CU_ASSERT_EQUAL( f.f3(0), TEST_F3_0 )
			CU_ASSERT_EQUAL( f.f3(1), TEST_F3_1 )

			'' uinteger
			CU_ASSERT_EQUAL( f.f4(1), TEST_F4_1 )
			CU_ASSERT_EQUAL( f.f4(2), TEST_F4_2 )

			''string
			CU_ASSERT_EQUAL( f.f5(0), TEST_F5_0 )
			CU_ASSERT_EQUAL( f.f5(1), TEST_F5_1 )
		END_TEST

		TEST( array2 )
			dim f as baz

			CU_ASSERT_EQUAL( f.pad, 5678 )

			CU_ASSERT_EQUAL( f.b1(0).f1, TEST_F1_0 )
			CU_ASSERT_EQUAL( f.b1(0).f2, TEST_F2_0 )
			CU_ASSERT_EQUAL( f.b1(0).f3, TEST_F3_0 )

			CU_ASSERT_EQUAL( f.b1(1).f1, TEST_F1_1 )
			CU_ASSERT_EQUAL( f.b1(1).f2, TEST_F2_1 )
			CU_ASSERT_EQUAL( f.b1(1).f3, TEST_F3_1 )

			CU_ASSERT_EQUAL( f.b2(0).f1, TEST_F1_1 )
			CU_ASSERT_EQUAL( f.b2(0).f2, TEST_F2_1 )
			CU_ASSERT_EQUAL( f.b2(0).f3, TEST_F3_1 )

			CU_ASSERT_EQUAL( f.b2(1).f1, TEST_F1_0 )
			CU_ASSERT_EQUAL( f.b2(1).f2, TEST_F2_0 )
			CU_ASSERT_EQUAL( f.b2(1).f3, TEST_F3_0 )
		END_TEST
	END_TEST_GROUP

	'' Nested arrays
	TEST_GROUP( nestedArrays )
		'' ubyte
		const TEST_F1_0 = &h11
		const TEST_F1_1 = &h12
		const TEST_F1_2 = &h13

		'' ushort
		const TEST_F2_0 = &h2122
		const TEST_F2_1 = &h2324
		const TEST_F2_2 = &h2526

		'' uinteger
		const TEST_F3_0 = &h31323334
		const TEST_F3_1 = &h35363738

		type foo field = 1
			pad as integer
			f1(0 to 2) as ubyte 
			f2(0 to 2) as ushort 
			f3(0 to 1) as uinteger 
		end type

		type bar field = 1
			pad as integer
			f(0 to 1) as foo
		end type

		type foobar field = 1
			pad as integer = 1234
			b( 0 to 1 ) as bar = { _
				/' b(0) '/ _
				( _
					/' pad '/ _
					111, _
					{ _
						/' f(0) '/ _
						( 222, _
							{ TEST_F1_0, TEST_F1_1, TEST_F1_2 }, _
							{ TEST_F2_0, TEST_F2_1, TEST_F2_2 }, _
							{ TEST_F3_0, TEST_F3_1 } _
						), _
						/' f(1) '/ _
						( 333, _
							{ TEST_F1_0 + 1, TEST_F1_1 + 1, TEST_F1_2 + 1 }, _
							{ TEST_F2_0 + 1, TEST_F2_1 + 1, TEST_F2_2 + 1 }, _
							{ TEST_F3_0 + 1, TEST_F3_1 + 1 } _
						) _
					} _
				), _
				/' b(1) '/ _
				( _
					/' pad '/ _
					444, _
					{ _
						/' f(0) '/ _
						( 555, _
							{ TEST_F1_0 + 2, TEST_F1_1 + 2, TEST_F1_2 + 2 }, _
							{ TEST_F2_0 + 2, TEST_F2_1 + 2, TEST_F2_2 + 2 }, _
							{ TEST_F3_0 + 2, TEST_F3_1 + 2 } _
						), _
						/' f(1) '/ _
						( 666, _
							{ TEST_F1_0 + 3, TEST_F1_1 + 3, TEST_F1_2 + 3 }, _
							{ TEST_F2_0 + 3, TEST_F2_1 + 3, TEST_F2_2 + 3 }, _
							{ TEST_F3_0 + 3, TEST_F3_1 + 3 } _
						) _
					} _
				) _
			}
		end type

		TEST( default )
			dim f as foobar

			CU_ASSERT_EQUAL( f.pad            , 1234 )

			'' --- b(0)

			CU_ASSERT_EQUAL( f.b(0).pad       , 111 )

			'' --- b(0).f(0)
			CU_ASSERT_EQUAL( f.b(0).f(0).pad  , 222 )

			'' ubyte
			CU_ASSERT_EQUAL( f.b(0).f(0).f1(0), TEST_F1_0 )
			CU_ASSERT_EQUAL( f.b(0).f(0).f1(1), TEST_F1_1 )
			CU_ASSERT_EQUAL( f.b(0).f(0).f1(2), TEST_F1_2 )

			'' ushort
			CU_ASSERT_EQUAL( f.b(0).f(0).f2(0), TEST_F2_0 )
			CU_ASSERT_EQUAL( f.b(0).f(0).f2(1), TEST_F2_1 )
			CU_ASSERT_EQUAL( f.b(0).f(0).f2(2), TEST_F2_2 )

			'' uinteger
			CU_ASSERT_EQUAL( f.b(0).f(0).f3(0), TEST_F3_0 )
			CU_ASSERT_EQUAL( f.b(0).f(0).f3(1), TEST_F3_1 )

			'' --- b(0).f(1)
			CU_ASSERT_EQUAL( f.b(0).f(1).pad  , 333 )

			'' ubyte
			CU_ASSERT_EQUAL( f.b(0).f(1).f1(0), TEST_F1_0 + 1 )
			CU_ASSERT_EQUAL( f.b(0).f(1).f1(1), TEST_F1_1 + 1 )
			CU_ASSERT_EQUAL( f.b(0).f(1).f1(2), TEST_F1_2 + 1 )

			'' ushort
			CU_ASSERT_EQUAL( f.b(0).f(1).f2(0), TEST_F2_0 + 1 )
			CU_ASSERT_EQUAL( f.b(0).f(1).f2(1), TEST_F2_1 + 1 )
			CU_ASSERT_EQUAL( f.b(0).f(1).f2(2), TEST_F2_2 + 1 )

			'' uinteger
			CU_ASSERT_EQUAL( f.b(0).f(1).f3(0), TEST_F3_0 + 1 )
			CU_ASSERT_EQUAL( f.b(0).f(1).f3(1), TEST_F3_1 + 1 )

			'' --- b(1)

			CU_ASSERT_EQUAL( f.b(1).pad       , 444 )

			'' --- b(1).f(0)
			CU_ASSERT_EQUAL( f.b(1).f(0).pad  , 555 )

			'' ubyte
			CU_ASSERT_EQUAL( f.b(1).f(0).f1(0), TEST_F1_0 + 2 )
			CU_ASSERT_EQUAL( f.b(1).f(0).f1(1), TEST_F1_1 + 2 )
			CU_ASSERT_EQUAL( f.b(1).f(0).f1(2), TEST_F1_2 + 2 )

			'' ushort
			CU_ASSERT_EQUAL( f.b(1).f(0).f2(0), TEST_F2_0 + 2 )
			CU_ASSERT_EQUAL( f.b(1).f(0).f2(1), TEST_F2_1 + 2 )
			CU_ASSERT_EQUAL( f.b(1).f(0).f2(2), TEST_F2_2 + 2 )

			'' uinteger
			CU_ASSERT_EQUAL( f.b(1).f(0).f3(0), TEST_F3_0 + 2 )
			CU_ASSERT_EQUAL( f.b(1).f(0).f3(1), TEST_F3_1 + 2 )

			'' --- b(1).f(1)
			CU_ASSERT_EQUAL( f.b(1).f(1).pad  , 666 )

			'' ubyte
			CU_ASSERT_EQUAL( f.b(1).f(1).f1(0), TEST_F1_0 + 3 )
			CU_ASSERT_EQUAL( f.b(1).f(1).f1(1), TEST_F1_1 + 3 )
			CU_ASSERT_EQUAL( f.b(1).f(1).f1(2), TEST_F1_2 + 3 )

			'' ushort
			CU_ASSERT_EQUAL( f.b(1).f(1).f2(0), TEST_F2_0 + 3 )
			CU_ASSERT_EQUAL( f.b(1).f(1).f2(1), TEST_F2_1 + 3 )
			CU_ASSERT_EQUAL( f.b(1).f(1).f2(2), TEST_F2_2 + 3 )

			'' uinteger
			CU_ASSERT_EQUAL( f.b(1).f(1).f3(0), TEST_F3_0 + 3 )
			CU_ASSERT_EQUAL( f.b(1).f(1).f3(1), TEST_F3_1 + 3 )
		END_TEST
	END_TEST_GROUP

	'' String field init
	TEST_GROUP( strings )
		type A
			as string i = "123", j = "abcde", k = wstr( "fOoBaR" )
		end type

		type B
			c as A
		end type

		TEST( default )
			dim x as B
			CU_ASSERT( x.c.i = "123" )
			CU_ASSERT( x.c.j = "abcde" )
			CU_ASSERT( x.c.k = "fOoBaR" )
		END_TEST
	END_TEST_GROUP

END_SUITE
