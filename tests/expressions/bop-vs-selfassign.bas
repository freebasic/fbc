#include "fbcunit.bi"

SUITE( fbc_tests.expressions.bop_vs_selfassign )

	TEST( varAssign )
		dim i as integer, s as string

		i and= 1
		i or= 1
		i andalso= 1
		i orelse= 1
		i xor= 1
		i eqv= 1
		i imp= 1
		i shl= 1
		i shr= 1
		i mod= 1
		i += 1
		i -= 1
		i \= 1
		i *= 1
		i /= 1
		i ^= 1
		s &= 1
		CU_ASSERT( s = "1" )

		i and=> 1
		i or=> 1
		i andalso=> 1
		i orelse=> 1
		i xor=> 1
		i eqv=> 1
		i imp=> 1
		i shl=> 1
		i shr=> 1
		i mod=> 1
		i +=> 1
		i -=> 1
		i \=> 1
		i *=> 1
		i /=> 1
		i ^=> 1
		s &=> 1
		CU_ASSERT( s = "11" )
	END_TEST

	TEST( derefAssign )
		dim i as integer, s as string
		var pi = @i, ps = @s

		*pi and= 1
		*pi or= 1
		*pi andalso= 1
		*pi orelse= 1
		*pi xor= 1
		*pi eqv= 1
		*pi imp= 1
		*pi shl= 1
		*pi shr= 1
		*pi mod= 1
		*pi += 1
		*pi -= 1
		*pi \= 1
		*pi *= 1
		*pi /= 1
		*pi ^= 1
		*ps &= 1
		CU_ASSERT( s = "1" )

		*pi and=> 1
		*pi or=> 1
		*pi andalso=> 1
		*pi orelse=> 1
		*pi xor=> 1
		*pi eqv=> 1
		*pi imp=> 1
		*pi shl=> 1
		*pi shr=> 1
		*pi mod=> 1
		*pi +=> 1
		*pi -=> 1
		*pi \=> 1
		*pi *=> 1
		*pi /=> 1
		*pi ^=> 1
		*ps &=> 1
		CU_ASSERT( s = "11" )
	END_TEST

	TEST_GROUP( returnByrefAssignment )
		'' With functions with byref result, there is a parsing ambiguity:
		''    f (0) + = 1
		''
		'' should this be seen as:
		''    f( (0) + = 1 )    (which will cause an error because of the unexpected =)
		''
		'' or should it be seen as:
		''    (f(0)) += 1
		''
		'' Since only the latter makes sense, we prefer it, but this requires extra
		'' checks in the parser because self-assignments such as += are two tokens ('+' and '=')
		'' in FB, not just one '+=' as in C.

		function fi(byval x as integer) byref as integer
			static i as integer
			function = i
		end function

		function fs(byval x as integer) byref as string
			static s as string
			function = s
		end function

		TEST( default )
			fi(0) and= 1
			fi(0) or= 1
			fi(0) andalso= 1
			fi(0) orelse= 1
			fi(0) xor= 1
			fi(0) eqv= 1
			fi(0) imp= 1
			fi(0) shl= 1
			fi(0) shr= 1
			fi(0) mod= 1
			fi(0) += 1
			fi(0) -= 1
			fi(0) \= 1
			fi(0) *= 1
			fi(0) /= 1
			fi(0) ^= 1
			fs(0) &= 1
			CU_ASSERT( fs(0) = "1" )

			fi(0) and=> 1
			fi(0) or=> 1
			fi(0) andalso=> 1
			fi(0) orelse=> 1
			fi(0) xor=> 1
			fi(0) eqv=> 1
			fi(0) imp=> 1
			fi(0) shl=> 1
			fi(0) shr=> 1
			fi(0) mod=> 1
			fi(0) +=> 1
			fi(0) -=> 1
			fi(0) \=> 1
			fi(0) *=> 1
			fi(0) /=> 1
			fi(0) ^=> 1
			fs(0) &=> 1
			CU_ASSERT( fs(0) = "11" )
		END_TEST
	END_TEST_GROUP

END_SUITE
