#include "fbcunit.bi"
#include once "uzstring-fixed.bi"

#define ustring uzstring_fixed

'' test UZSTRING_FIXED, reference implementation

SUITE( fbc_tests.udt_zstring_.udt_zstring_fixed )

	TEST( initializer )

		'' default initializer
		scope
			dim z as zstring * 50
			dim u as ustring

			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( len(u) = 0 )
			CU_ASSERT( z = "" )
			CU_ASSERT( u = "" )
			CU_ASSERT( z = u )
		end scope

		'' null initializer
		scope
			dim z as zstring * 50 = ""
			dim u as ustring = ""

			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( len(u) = 0 )
		end scope

		'' initialize from STRING literal
		scope
			dim a as string = "abcdefghij"
			dim z as zstring * 50 = "abcdefghij"
			dim u as ustring = "abcdefghij"

			CU_ASSERT( len("abcdefghij") = 10 )
			CU_ASSERT( len(a) = 10 )
			CU_ASSERT( len(z) = len(a) )
			CU_ASSERT( len(u) = len(z) )
			CU_ASSERT( u = z )
			
		end scope

		'' initialize from WSTRING literal
		scope
			dim z as zstring * 50 = !"\u0061\u0062\u0063\u0064\u0065"
			dim u as ustring = !"\u0061\u0062\u0063\u0064\u0065"

			CU_ASSERT( len( !"\u0061\u0062\u0063\u0064\u0065" ) = 5)
			CU_ASSERT( len(z) = 5)
			CU_ASSERT( len(u) = len(z) )
		end scope

		'' initialize from STRING const
		scope
			const LIT_A = "abcdefghij"

			dim a as string = LIT_A
			dim z as zstring * 50 = LIT_A
			dim u as ustring = LIT_A

			CU_ASSERT( len(LIT_A) = 10 )
			CU_ASSERT( len(a) = len(LIT_A) )
			CU_ASSERT( len(z) = len(a) )
			CU_ASSERT( len(u) = len(z) )
			CU_ASSERT( u = z )
		end scope

		'' initialize from WSTRING const
		scope
			const LIT_W = !"\u0061\u0062\u0063\u0064\u0065"

			dim z as zstring * 50 = LIT_W
			dim u as ustring = LIT_W

			CU_ASSERT( len(LIT_W) = 5 )
			CU_ASSERT( len(z) = len(LIT_W) )
			CU_ASSERT( len(u) = len(z) )
			CU_ASSERT( u = z )
		end scope

		'' initialize from STRING variable
		scope
			dim a as string = "abcdefghij"
			dim z as zstring * 50 = a
			dim u as ustring = a

			CU_ASSERT( len(a) = 10 )
			CU_ASSERT( len(z) = len(a) )
			CU_ASSERT( len(u) = len(z) )
			CU_ASSERT( u = z )
		end scope

		'' initialize from WSTRING variable
		scope
			dim w as wstring * 20 = !"\u0061\u0062\u0063\u0064\u0065"
			dim z as zstring * 50 = w
			dim u as ustring = w

			CU_ASSERT( len(z) = 5 )
			CU_ASSERT( len(u) = len(z) )
			CU_ASSERT( u = z )
		end scope

	END_TEST

END_SUITE
