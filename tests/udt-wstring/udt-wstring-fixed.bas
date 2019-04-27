#include "fbcunit.bi"
#include once "uwstring-fixed.bi"

#define ustring uwstring_fixed

'' test UWSTRING_FIXED, reference implementation

SUITE( fbc_tests.udt_wstring_.udt_wstring_fixed )

	TEST( initializer )

		'' default initializer
		scope
			dim w as wstring * 50
			dim u as ustring

			CU_ASSERT( len(w) = 0 )
			CU_ASSERT( len(u) = 0 )
			CU_ASSERT( w = "" )
			CU_ASSERT( u = "" )
			CU_ASSERT( w = u )
		end scope

		'' null initializer
		scope
			dim w as wstring * 50 = ""
			dim u as ustring = ""

			CU_ASSERT( len(w) = 0 )
			CU_ASSERT( len(u) = 0 )
		end scope

		'' initialize from STRING literal
		scope
			dim a as string = "abcdefghij"
			dim w as wstring * 50 = "abcdefghij"
			dim u as ustring = "abcdefghij"

			CU_ASSERT( len("abcdefghij") = 10 )
			CU_ASSERT( len(a) = 10 )
			CU_ASSERT( len(w) = len(a) )
			CU_ASSERT( len(u) = len(w) )
			CU_ASSERT( u = w )
			
		end scope

		'' initialize from WSTRING literal
		scope
			dim w as wstring * 50 = !"\u3041\u3043\u3045\u3047\u3049"
			dim u as ustring = !"\u3041\u3043\u3045\u3047\u3049"

			CU_ASSERT( len( !"\u3041\u3043\u3045\u3047\u3049" ) = 5)
			CU_ASSERT( len(w) = 5)
			CU_ASSERT( len(u) = len(w) )
		end scope

		'' initialize from STRING const
		scope
			const LIT_A = "abcdefghij"

			dim a as string = LIT_A
			dim w as wstring * 50 = LIT_A
			dim u as ustring = LIT_A

			CU_ASSERT( len(LIT_A) = 10 )
			CU_ASSERT( len(a) = len(LIT_A) )
			CU_ASSERT( len(w) = len(a) )
			CU_ASSERT( len(u) = len(w) )
			CU_ASSERT( u = w )
		end scope

		'' initialize from WSTRING const
		scope
			const LIT_W = !"\u3041\u3043\u3045\u3047\u3049"

			dim w as wstring * 50 = LIT_W
			dim u as ustring = LIT_W

			CU_ASSERT( len(LIT_W) = 5 )
			CU_ASSERT( len(w) = len(LIT_W) )
			CU_ASSERT( len(u) = len(w) )
			CU_ASSERT( u = w )
		end scope

		'' initialize from STRING variable
		scope
			dim a as string = "abcdefghij"
			dim w as wstring * 50 = a
			dim u as ustring = a

			CU_ASSERT( len(a) = 10 )
			CU_ASSERT( len(w) = len(a) )
			CU_ASSERT( len(u) = len(w) )
			CU_ASSERT( u = w )
		end scope

		'' initialize from WSTRING variable
		scope
			dim w0 as wstring * 20 = !"\u3041\u3043\u3045\u3047\u3049"
			dim w as wstring * 50 = w0
			dim u as ustring = w0

			CU_ASSERT( len(w0) = 5 )
			CU_ASSERT( len(w) = len(w0) )
			CU_ASSERT( len(u) = len(w) )
			CU_ASSERT( u = w )
		end scope

	END_TEST

END_SUITE
