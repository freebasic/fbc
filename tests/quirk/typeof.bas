#include "fbcu.bi"

namespace fbc_tests.quirk.typeof_

	type foobar
		x as integer
		y as integer
	end type

	operator +( l as foobar, r as foobar ) as foobar
		return type<foobar>( 69, 69 )
	end operator

	function ret_int() as integer
		return 69
	end function

	type anothertype
		__ as string
		declare property something() as string
		declare property something(s as string)
	end type
	property anothertype.something(s as string)
		__ = s
	end property
	property anothertype.something() as string
		return __
	end property
	type sometype
		__ as anothertype
	end type

	sub typeof_vars cdecl( )
		dim as sometype thingy
		dim as string bar(2)
		dim as const integer ptr ptr const ptr const ptr cp = 0
		dim as typeof(cp) dp = 0

		dim as string * 10 s10

		#if typeof(cp) <> typeof(dp)
			CU_ASSERT(0)
		#endif
		#if typeof(bar(0)) <> string
			CU_ASSERT(0)
		#endif
		#if typeof(bar) <> string
			CU_ASSERT(0)
		#endif
		#if typeof(thingy.__) <> anothertype
			CU_ASSERT(0)
		#endif
		#if typeof(thingy.__.__) <> string
			CU_ASSERT(0)
		#endif
		#if typeof(thingy.__.something) <> string
			CU_ASSERT(0)
		#endif
		#if typeof(ret_int()) <> integer
			CU_ASSERT(0)
		#endif

		#if typeof(s10) <> typeof(string * 10)
			CU_ASSERT(0)
		#endif

	end sub

	sub typeof_expressions cdecl( )
		dim as integer x
		dim as double y
		#if typeof( x + y ) <> double
			CU_ASSERT(0)
		#endif
		dim as foobar f, g
		#if typeof( f + g ) <> foobar
			CU_ASSERT(0)
		#endif
	
	end sub

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.quirk.typeof_")
		fbcu.add_test("typeof_vars", @typeof_vars)
		fbcu.add_test("typeof_expressions", @typeof_expressions)
	
	end sub

end namespace
