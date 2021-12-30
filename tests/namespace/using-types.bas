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

#define N  using_types_N
#define P0 using_types_P0
#define P1 using_types_P1
#define P2 using_types_P2
#define P3 using_types_P3

type T
	__ as integer
end type

namespace N
	type T
		__ as integer
	end type
end namespace

namespace P0
	sub proc()
		checkType( T, ..T )
	end sub
end namespace

namespace P1
	type T
		__ as integer
	end type
	sub proc()
		checkType( T, P1.T )
	end sub
end namespace

namespace P2
	using N
	type T
		__ as integer
	end type
	sub proc()
		checkType( T, P2.T )
	end sub
end namespace

namespace P3
	type T
		__ as integer
	end type
	using N
	sub proc()
		checkType( T, P3.T )
	end sub
end namespace

namespace P4
	using N
	sub proc()
		checkType( T, ..T )
	end sub
end namespace

private sub module_proc()
	using P4
	checkType( T, ..T )
end sub

SUITE( fbc_tests.namespace_.using_types )

	TEST( default )
		P0.proc()
		P1.proc()
		P2.proc()
		P3.proc()
		P4.proc()
		module_proc()

	END_TEST

END_SUITE
