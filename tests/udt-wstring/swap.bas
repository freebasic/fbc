#include "fbcunit.bi"
#include once "uwstring-fixed.bi"
#include once "chk-wstring.bi"

type UWSTRING_HAS_ID extends UWSTRING_FIXED_MUTABLE
	public:
		id as integer
		declare constructor()
		declare constructor( byval rhs as const wstring const ptr )
		declare constructor( byval rhs as const zstring const ptr )

		declare operator cast() byref as wstring
end type

constructor UWSTRING_HAS_ID()
end constructor

constructor UWSTRING_HAS_ID( byval s as const wstring const ptr )
	base( s )
end constructor

constructor UWSTRING_HAS_ID( byval s as const zstring const ptr )
	base( s )
end constructor

operator UWSTRING_HAS_ID.Cast() byref as wstring
	operator = *cast(wstring ptr, @_data)	
end operator

#define ustring UWSTRING_HAS_ID

SUITE( fbc_tests.udt_wstring_.swap_ )

	#macro check( literal1, literal2 )
		scope
			dim t1 as wstring * 50 = literal1
			dim t2 as wstring * 50 = literal2

			dim u1 as ustring = literal1
			u1.id = 1
			dim u2 as ustring = literal2
			u2.id = 2

			'' initial condition check
			scope
				dim r1 as wstring * 50 = u1
				dim r2 as wstring * 50 = u2
				CU_ASSERT( u1.id = 1 )
				CU_ASSERT( u2.id = 2 )
				CU_ASSERT_WSTRING_EQUAL( r1, t1 )
				CU_ASSERT_WSTRING_EQUAL( r2, t2 )
			end scope

			'' swap string only
			scope
				swap wstr( u1 ), wstr( u2 )

				dim r1 as wstring * 50 = u1
				dim r2 as wstring * 50 = u2

				CU_ASSERT( u1.id = 1 )
				CU_ASSERT( u2.id = 2 )
				CU_ASSERT_WSTRING_EQUAL( r1, t2 )
				CU_ASSERT_WSTRING_EQUAL( r2, t1 )
			end scope

			'' swap string only
			scope
				swap wstr( u1 ), u2

				dim r1 as wstring * 50 = u1
				dim r2 as wstring * 50 = u2

				CU_ASSERT( u1.id = 1 )
				CU_ASSERT( u2.id = 2 )
				CU_ASSERT_WSTRING_EQUAL( r1, t1 )
				CU_ASSERT_WSTRING_EQUAL( r2, t2 )
			end scope

			'' swap string only
			scope
				swap u1, wstr( u2 )

				dim r1 as wstring * 50 = u1
				dim r2 as wstring * 50 = u2

				CU_ASSERT( u1.id = 1 )
				CU_ASSERT( u2.id = 2 )
				CU_ASSERT_WSTRING_EQUAL( r1, t2 )
				CU_ASSERT_WSTRING_EQUAL( r2, t1 )
			end scope

			'' swap complete UDT
			scope
				swap u1, u2

				dim r1 as wstring * 50 = u1
				dim r2 as wstring * 50 = u2

				CU_ASSERT( u1.id = 2 )
				CU_ASSERT( u2.id = 1 )
				CU_ASSERT_WSTRING_EQUAL( r1, t1 )
				CU_ASSERT_WSTRING_EQUAL( r2, t2 )
			end scope
		end scope
	#endmacro

	TEST( default )
		check( "", "" )

		check( "", "a" )
		check( "a", "a" )
		check( "a", "abcdefghi" )

		check( "", !"\u3041\u3043\u3045\u3047\u3049" )
		check( "abc", !"\u3041\u3043\u3045\u3047\u3049" )
		check( !"\u3045", !"\u3041\u3043\u3047\u3049" )

	END_TEST 

END_SUITE
