#include "fbcu.bi"

namespace fbc_tests.pp.typeof_

	#macro clear_func(__type__)
		sub clear_thing overload ( byref t as __type__ )
			#if typeof(t) = string
				t = ""
			#else
				t = 0
			#endif
		end sub
	#endmacro
	
	clear_func(integer)
	clear_func(string)
	
	sub test_it cdecl( )
	
		dim as integer i = 69
		dim as string s = "R&E 2007"
		
		clear_thing(i)
		clear_thing(s)
		
		CU_ASSERT( i = 0 )
		CU_ASSERT( strptr(s) = NULL )
		
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.pp.typeof")
		fbcu.add_test("typeof() with PP", @test_it)
	
	end sub

end namespace
