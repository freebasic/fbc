#include "fbcunit.bi"

SUITE( fbc_tests.string_.string_fixed )

	TEST( initializer )

		'' default initializer
		scope
			dim f as string * 50

			CU_ASSERT( len(f) = 50 )
			CU_ASSERT( sizeof(f) = 50 )
			CU_ASSERT( f = space(50) )
		end scope

		'' null initializer
		scope
			dim f as string * 50 = ""

			CU_ASSERT( len(f) = 50 )
			CU_ASSERT( sizeof(f) = 50 )
			CU_ASSERT( f = space(50) )
		end scope

		'' initialize from STRING literal
		scope
			dim a as string = "abcdefghij"
			dim f as string * 50 = "abcdefghij"

			CU_ASSERT( len("abcdefghij") = 10 )
			CU_ASSERT( len(a) = 10 )
			CU_ASSERT( len(f) = 50 )
			CU_ASSERT( a + space(50-len(a)) = f )

		end scope

		'' initialize from WSTRING literal
		scope
			dim z as zstring * 20 = !"\u0061\u0062\u0063\u0064\u0065"
			dim f as string * 50 = !"\u0061\u0062\u0063\u0064\u0065"

			CU_ASSERT( len( !"\u0061\u0062\u0063\u0064\u0065" ) = 5)
			CU_ASSERT( len(f) = 50 )
			CU_ASSERT( len(z) = 5 )
			CU_ASSERT( z + space(50-len(z)) = f )
		end scope

		'' initialize from STRING const
		scope
			const LIT_A = "abcdefghij"

			dim a as string = LIT_A
			dim f as string * 50 = LIT_A

			CU_ASSERT( len(LIT_A) = 10 )
			CU_ASSERT( len(a) = len(LIT_A) )
			CU_ASSERT( len(f) = 50 )
			CU_ASSERT( a + space(50-len(a)) = f )
		end scope

		'' initialize from WSTRING const
		scope
			const LIT_W = !"\u0061\u0062\u0063\u0064\u0065"

			dim f as string * 50 = LIT_W
			dim w as wstring * 20 = LIT_W

			CU_ASSERT( len(LIT_W) = 5 )
			CU_ASSERT( len(f) = 50 )
			CU_ASSERT( len(w) = len(LIT_W) )
			CU_ASSERT( w + wspace(50-len(w)) = f )
		end scope

		'' initialize from STRING variable
		scope
			dim a as string = "abcdefghij"
			dim f as string * 50 = a

			CU_ASSERT( len(a) = 10 )
			CU_ASSERT( len(f) = 50 )
			CU_ASSERT( a + space(50-len(a)) = f )
		end scope

		'' initialize from WSTRING variable
		scope
			dim w as wstring * 20 = !"\u0061\u0062\u0063\u0064\u0065"
			dim f as string * 50 = w

			CU_ASSERT( len(w) = 5 )
			CU_ASSERT( len(f) = 50 )
			CU_ASSERT( w + wspace(50-len(w)) = f )
		end scope

	END_TEST

END_SUITE
