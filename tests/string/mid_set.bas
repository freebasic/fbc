#include "fbcunit.bi"

SUITE( fbc_tests.string_.mid_set )

	sub test_midset(byref s as const string, byref t as const string, byval n as integer, byval l as integer)

		dim as string s1, s2
		s1 = s: mid(s1, n, l) = t

		s2 = s
		for i as integer = 1 to l
			if i > len(t) orelse n > len(s2) then exit for

			mid(s2, n, 1) = mid(t, i, 1)

			n += 1
		next

		CU_ASSERT_EQUAL(s1, s2)

	end sub

	TEST( midSetTest )

		dim h as string = "123"
		dim test1 as string * 3
		dim i as integer, l as integer
		dim s as string = "abcdefg", t as string = "12345"

		for i = 1 to 42
			for l = 0 to 42
				test_midset(s, t, i, l)
			next
		next

		for i = 1 to 260
		  mid(test1,1) = h
		  CU_ASSERT_NOT_EQUAL( 0, len(str(i)) )
		next

	END_TEST

	private sub hTestDestExprByrefParam( byref s as string )
		mid( s, 1 ) = "0"
	end sub

	TEST( destinationExpression )
		scope
			dim as string s = "abcdef"
			mid( s, 1 ) = "0"
			CU_ASSERT( s = "0bcdef" )
		end scope

		scope
			dim as string s = "abcdef"
			mid( *@s, 1 ) = "0"
			CU_ASSERT( s = "0bcdef" )
		end scope

		scope
			dim as string s = "abcdef"
			mid( *strptr( s ), 1 ) = "0"
			CU_ASSERT( s = "0bcdef" )
		end scope

		scope
			dim as string s = "abcdef"
			mid( *sadd( s ), 1 ) = "0"
			CU_ASSERT( s = "0bcdef" )
		end scope

		scope
			dim as string s = "abcdef"
			dim as string ptr ps = @s
			mid( *ps, 1 ) = "0"
			CU_ASSERT( s = "0bcdef" )
		end scope

		scope
			dim as string s = "abcdef"
			hTestDestExprByrefParam( s )
			CU_ASSERT( s = "0bcdef" )
		end scope

		scope
			dim as string s(0 to 1) = { "abcdef", "ghijkl" }
			mid( s(0), 1 ) = "0"
			CU_ASSERT( s(0) = "0bcdef" )
		end scope

		scope
			dim as string s(0 to 1) = { "abcdef", "ghijkl" }
			mid( s(1), 1 ) = "0"
			CU_ASSERT( s(1) = "0hijkl" )
		end scope

		scope
			dim as string s(0 to 1) = { "abcdef", "ghijkl" }
			dim as integer i = 0
			mid( s(i), 1 ) = "0"
			CU_ASSERT( s(0) = "0bcdef" )
		end scope

		scope
			dim z as zstring * 32 => "abcdef"
			mid( z, 1 ) = "0"
			CU_ASSERT( z = "0bcdef" )
		end scope

		scope
			dim z as zstring * 32 => "abcdef"
			mid( *@z, 1 ) = "0"
			CU_ASSERT( z = "0bcdef" )
		end scope

		scope
			dim z as zstring * 32 => "abcdef"
			dim pz as zstring ptr = @z
			mid( *pz, 1 ) = "0"
			CU_ASSERT( z = "0bcdef" )
		end scope

		scope
			dim as zstring * 32 z(0 to 1) = { "abcdef", "ghijkl" }
			mid( z(0), 1 ) = "0"
			CU_ASSERT( z(0) = "0bcdef" )
		end scope

		scope
			dim as zstring * 32 z(0 to 1) = { "abcdef", "ghijkl" }
			mid( z(1), 1 ) = "0"
			CU_ASSERT( z(1) = "0hijkl" )
		end scope

		scope
			dim as zstring * 32 z(0 to 1) = { "abcdef", "ghijkl" }
			dim as integer i = 0
			mid( z(i), 1 ) = "0"
			CU_ASSERT( z(0) = "0bcdef" )
		end scope
	END_TEST

END_SUITE
