#include once "fbcunit.bi"

#macro check( arg1, arg2 )
	#if( typeof(arg1) = typeof(arg2) )
		CU_PASS()
	#else
		CU_FAIL()
	#endif
#endmacro

#define toStr( arg ) #arg
#define typeof2Str( arg ) toStr( typeof(arg) )

type T
	__ as integer
end type

namespace using_types_N
	type T
		__ as integer
	end type
end namespace

namespace using_types_P0
	sub proc()
		check( T, ..T )
	end sub
end namespace

namespace using_types_P1
	type T
		__ as integer
	end type
	sub proc()
		check( T, USING_TYPES_P1.T )
	end sub
end namespace

namespace using_types_P2
	using using_types_N
	type T
		__ as integer
	end type
	sub proc()
		check( T, USING_TYPES_P2.T )
	end sub
end namespace

namespace using_types_P3
	type T
		__ as integer
	end type
	using using_types_N
	sub proc()
		check( T, USING_TYPES_P3.T )
	end sub
end namespace

namespace using_types_P4
	using using_types_N
	sub proc()
		check( T, USING_TYPES_N.T )
	end sub
end namespace

private sub module_proc()
	using using_types_P4
	check( T, ..T )
end sub

SUITE( fbc_tests.namespace_.using_types )

	TEST( default )
		using_types_P0.proc()
		using_types_P1.proc()
		using_types_P2.proc()
		using_types_P3.proc()
		using_types_P4.proc()
		module_proc()

	END_TEST

END_SUITE
