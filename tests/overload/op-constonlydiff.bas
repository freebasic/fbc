#include "fbcunit.bi"

SUITE( fbc_tests.overload_.op_constonlydiff )

	'' Operator overload resolution generally requires at least one exact matche to
	'' match a specific overload, however it should also treat inexact matches as
	'' exact matches if the difference is only in CONSTness (e.g. passing a
	'' non-CONST object to a BYREF AS CONST parameter).

	type UDT1
		x as single
	end type

	operator +(byval l as single, byref r as const UDT1) as UDT1 : operator = type(l + r.x) : end operator
	operator +(byref l as const UDT1, byval r as single) as UDT1 : operator = type(l.x + r) : end operator

	type UDT2
		x as double
	end type

	operator +(byval l as double, byref r as const UDT2) as UDT2 : operator = type(l + r.x) : end operator
	operator +(byref l as const UDT2, byval r as double) as UDT2 : operator = type(l.x + r) : end operator

	type UDT3
		x as single
	end type

	operator +(byval l as single, byref r as       UDT3) as UDT3 : operator = type(l + r.x) : end operator
	operator +(byval l as single, byref r as const UDT3) as UDT3 : operator = type(l + r.x) : end operator
	operator +(byref l as       UDT3, byval r as single) as UDT3 : operator = type(l.x + r) : end operator
	operator +(byref l as const UDT3, byval r as single) as UDT3 : operator = type(l.x + r) : end operator

	TEST( all )
		'' Calling + overloads, passing...
		'' - UDT to const UDT - should be allowed (not a full match, because it
		''   differs in CONSTness, but it differs in CONSTness only, so it
		''   should still be considered an exact match for the purposes of
		''   operator overload resolution)
		'' - double to single - inexact match, but the + overloads can still be
		''   called because the UDT arg/param matched. Only one exact match is
		''   required, not two.
		'' Both a+b and b+a must be tested. They should give consistent results.
		scope
			dim as UDT1 u, u2

			u.x = 1.0
			u2.x = 0.0
			u2 = 2.0 + u
			CU_ASSERT( u2.x = 3.0 )

			u.x = 1.0
			u2.x = 0.0
			u2 = u + 2.0
			CU_ASSERT( u2.x = 3.0 )
		end scope

		'' Same as above, except that we're passing double to double instead of
		'' double to single, i.e. here we have a full match involved
		scope
			dim as UDT2 u, u2

			u.x = 1.0
			u2.x = 0.0
			u2 = 2.0 + u
			CU_ASSERT( u2.x = 3.0 )

			u.x = 1.0
			u2.x = 0.0
			u2 = u + 2.0
			CU_ASSERT( u2.x = 3.0 )
		end scope

		'' Like with UDT1, but more overloads: BYREF with and without CONST...
		scope
			dim as UDT3 u, u2

			u.x = 1.0
			u2.x = 0.0
			u2 = 2.0 + u
			CU_ASSERT( u2.x = 3.0 )

			u.x = 1.0
			u2.x = 0.0
			u2 = u + 2.0
			CU_ASSERT( u2.x = 3.0 )
		end scope
	END_TEST

END_SUITE
