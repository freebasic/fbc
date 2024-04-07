#include once "fbcunit.bi"

#macro checkType( arg1, arg2 )
	#if( typeof(arg1) = typeof(arg2) )
		CU_PASS()
	#else
		CU_FAIL()
	#endif
#endmacro

'' define namespace names to allow short names
'' in this source but avoid namespace collisions
'' in other sources

#define N1 ns_using2_N1
#define N2 ns_using2_N2

namespace N1
	type T
		__ as long = 1
	end type

	sub proc()
		checkType( T, N1.T )
	end sub
end namespace

namespace N2
	using N1

	dim as T foo

	sub proc()
		checkType( T, N2.T )
	end sub
end namespace

private sub module_proc()
	N1.proc()
	N2.proc()

	checkType( N1.T, N1.T )
	checkType( N2.T, N2.T )

	using N2

	checkType( T, N2.T )

	CU_ASSERT_EQUAL( foo.__, 1 )
end sub

SUITE( fbc_tests.namespace_.ns_using2 )
	TEST( default )
		module_proc()
	END_TEST
END_SUITE
