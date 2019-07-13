#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

type UZSTRING_HAS_ID extends UZSTRING_FIXED_MUTABLE
	public:
		id as integer
		declare constructor()
		declare constructor( byval rhs as const wstring const ptr )
		declare constructor( byval rhs as const zstring const ptr )

		declare operator cast() byref as zstring
end type

constructor UZSTRING_HAS_ID()
end constructor

constructor UZSTRING_HAS_ID( byval s as const wstring const ptr )
	base( s )
end constructor

constructor UZSTRING_HAS_ID( byval s as const zstring const ptr )
	base( s )
end constructor

operator UZSTRING_HAS_ID.Cast() byref as zstring
	operator = *cast(zstring ptr, @_data)	
end operator

#define ustring UZSTRING_HAS_ID

SUITE( fbc_tests.udt_zstring_.swap_ )

	#macro check( literal1, literal2 )
		scope
			dim t1 as zstring * 50 = literal1
			dim t2 as zstring * 50 = literal2

			dim u1 as ustring = literal1
			u1.id = 1
			dim u2 as ustring = literal2
			u2.id = 2

			'' initial condition check
			scope
				dim r1 as zstring * 50 = u1
				dim r2 as zstring * 50 = u2
				CU_ASSERT( u1.id = 1 )
				CU_ASSERT( u2.id = 2 )
				CU_ASSERT_ZSTRING_EQUAL( r1, t1 )
				CU_ASSERT_ZSTRING_EQUAL( r2, t2 )
			end scope

			'' swap string only
			scope
				swap str( u1 ), str( u2 )

				dim r1 as zstring * 50 = u1
				dim r2 as zstring * 50 = u2

				CU_ASSERT( u1.id = 1 )
				CU_ASSERT( u2.id = 2 )
				CU_ASSERT_ZSTRING_EQUAL( r1, t2 )
				CU_ASSERT_ZSTRING_EQUAL( r2, t1 )
			end scope

			'' swap string only
			scope
				swap str( u1 ), u2

				dim r1 as zstring * 50 = u1
				dim r2 as zstring * 50 = u2

				CU_ASSERT( u1.id = 1 )
				CU_ASSERT( u2.id = 2 )
				CU_ASSERT_ZSTRING_EQUAL( r1, t1 )
				CU_ASSERT_ZSTRING_EQUAL( r2, t2 )
			end scope

			'' swap string only
			scope
				swap u1, str( u2 )

				dim r1 as zstring * 50 = u1
				dim r2 as zstring * 50 = u2

				CU_ASSERT( u1.id = 1 )
				CU_ASSERT( u2.id = 2 )
				CU_ASSERT_ZSTRING_EQUAL( r1, t2 )
				CU_ASSERT_ZSTRING_EQUAL( r2, t1 )
			end scope

			'' swap complete UDT
			scope
				swap u1, u2

				dim r1 as zstring * 50 = u1
				dim r2 as zstring * 50 = u2

				CU_ASSERT( u1.id = 2 )
				CU_ASSERT( u2.id = 1 )
				CU_ASSERT_ZSTRING_EQUAL( r1, t1 )
				CU_ASSERT_ZSTRING_EQUAL( r2, t2 )
			end scope
		end scope
	#endmacro

	TEST( default )
		check( "", "" )

		check( "", "a" )
		check( "a", "a" )
		check( "a", "abcdefghi" )

	END_TEST 

END_SUITE
