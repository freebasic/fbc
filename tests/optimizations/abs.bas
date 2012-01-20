# include "fbcu.bi"

namespace fbc_tests.numbers.abs_

sub test cdecl()
	'' Not all these tests are useful to test abs(), but they also help
	'' testing -gen gcc's number literal emitting.

	scope
		dim as single float0 =   0.0f
		dim as single float1 =   1.0f
		dim as single float2 = - 1.0f
		dim as single float4 =   3.141592f
		dim as single float5 =   1.0e+10f
		dim as single float6 =   1.0e-10f

		CU_ASSERT( abs(float0) = 0.0f )
		CU_ASSERT( abs(float1) = 1.0f )
		CU_ASSERT( abs(float2) = 1.0f )
		CU_ASSERT( abs(float4) = 3.141592f )
		CU_ASSERT( abs(float5) = 1.0e+10f )
		CU_ASSERT( abs(float6) = 1.0e-10f )
	end scope

	scope
		dim as double double0 =   0.0
		dim as double double1 =   1.0
		dim as double double2 = - 1.0
		dim as double double4 =   3.14159265
		dim as double double5 =   1.0e+10
		dim as double double6 =   1.0e-10

		CU_ASSERT( abs(double0) = 0.0 )
		CU_ASSERT( abs(double1) = 1.0 )
		CU_ASSERT( abs(double2) = 1.0 )
		CU_ASSERT( abs(double4) = 3.14159265 )
		CU_ASSERT( abs(double5) = 1.0e+10 )
		CU_ASSERT( abs(double6) = 1.0e-10 )
	end scope

	scope
		dim as integer int0 =   0
		dim as integer int1 =   1
		dim as integer int2 = - 1
		dim as integer int3 =   2147483647
		dim as integer int4 = - 2147483648u

		CU_ASSERT( abs(int0) =   0 )
		CU_ASSERT( abs(int1) =   1 )
		CU_ASSERT( abs(int2) =   1 )
		CU_ASSERT( abs(int3) =   2147483647 )
		CU_ASSERT( abs(int4) = - 2147483648u ) '' overflows back to same number
		CU_ASSERT( abs(clngint(int4)) = 2147483648ll ) '' this one should work though
	end scope

	scope
		dim as longint longint0 =   0ll
		dim as longint longint1 =   1ll
		dim as longint longint2 = - 1ll
		dim as longint longint3 =   9223372036854775807ll
		dim as longint longint4 = - 9223372036854775808ull
		dim as longint longint5 = - 2147483648ll

		CU_ASSERT( abs(longint0) =   0ll )
		CU_ASSERT( abs(longint1) =   1ll )
		CU_ASSERT( abs(longint2) =   1ll )
		CU_ASSERT( abs(longint3) =   9223372036854775807ll )
		CU_ASSERT( abs(longint4) = - 9223372036854775808ull ) '' overflows back to same number
		CU_ASSERT( abs(longint5) =   2147483648ll ) '' -gen gcc regression test
	end scope

end sub

sub ctor() constructor
	fbcu.add_suite("fbc_tests.numbers.abs")
	fbcu.add_test("abs() tests", @test)
end sub

end namespace
