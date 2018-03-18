#include "fbcunit.bi"

SUITE( fbc_tests.structs.bitfield_init )

	type foo
		z:2 as integer
		a:4 as integer
		b:5 as integer
		c:6 as integer
		d:7 as integer
		e:8 as integer
	end type

	'' type initializers with bitfields
	TEST( typeiniWithBitfields )
		dim as foo bar = (1, 2, 3, 4)

		with bar
			CU_ASSERT( .z = 1 )
			CU_ASSERT( .a = 2 )
			CU_ASSERT( .b = 3 )
			CU_ASSERT( .c = 4 )
			CU_ASSERT( .d = 0 )
			CU_ASSERT( .e = 0 )
		end with
	END_TEST
	
	'' clearing of padding bits
	TEST( paddingBitsAreCleared )
		type T
			as long f1 : 1
			as long f2 : 1
			as long f3 : 1
			as long f4 : 1
			as long f5 : 28
			as long f6 : 1
			as long f7 : 1
			as long f8 : 1
			as long f9 : 1
		end type

		CU_ASSERT( sizeof( T ) = 8 )

		scope
			dim as ulong trash_the_stack_a_little1 = &hFFFFFFFFu
			dim as ulong trash_the_stack_a_little2 = &hFFFFFFFFu
			CU_ASSERT( trash_the_stack_a_little1 = &hFFFFFFFFu )
			CU_ASSERT( trash_the_stack_a_little2 = &hFFFFFFFFu )
		end scope

		scope
			dim as T x = ( 0, 1, 0, 1, &b111, 0, 1, 0, 1 )

			''  4 bits = 0101
			'' 28 bits = 1110 0000 0000 0000 0000 0000 0000
			''  4 bits = 0101
			'' 28 tail padding bits = should be all zero
			CU_ASSERT( x.f1 = 0 )
			CU_ASSERT( x.f2 = 1 )
			CU_ASSERT( x.f3 = 0 )
			CU_ASSERT( x.f4 = 1 )
			CU_ASSERT( x.f5 = &b111 )
			CU_ASSERT( x.f6 = 0 )
			CU_ASSERT( x.f7 = 1 )
			CU_ASSERT( x.f8 = 0 )
			CU_ASSERT( x.f9 = 1 )

			dim as ulong ptr p = cptr( ulong ptr, @x )
			CU_ASSERT( p[0] = &b00000000000000000000000001111010u )
			CU_ASSERT( p[1] = &b00000000000000000000000000001010u )
		end scope

		scope
			dim as ulong i(0 to 1) = { &hFFFFFFFFu, &hFFFFFFFFu }
			CU_ASSERT( i(0) = &hFFFFFFFFu )
			CU_ASSERT( i(1) = &hFFFFFFFFu )

			dim as T ptr x = cptr( T ptr, @i(0) )
			*x = type<T>( 0, 1, 0, 1, &b111, 0, 1, 0, 1 )

			'' ditto
			CU_ASSERT( x->f1 = 0 )
			CU_ASSERT( x->f2 = 1 )
			CU_ASSERT( x->f3 = 0 )
			CU_ASSERT( x->f4 = 1 )
			CU_ASSERT( x->f5 = &b111 )
			CU_ASSERT( x->f6 = 0 )
			CU_ASSERT( x->f7 = 1 )
			CU_ASSERT( x->f8 = 0 )
			CU_ASSERT( x->f9 = 1 )

			CU_ASSERT( i(0) = &b00000000000000000000000001111010u )
			CU_ASSERT( i(1) = &b00000000000000000000000000001010u )
		end scope
	END_TEST

END_SUITE
