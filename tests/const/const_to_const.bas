# include "fbcu.bi"

namespace fbc_tests.const_.const_to_const
	
	sub foo( byref bas as const string )
	end sub
	
	sub test cdecl( )
		dim as const string bar = "hi"
		foo( bar )
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.const.const_to_const")
		fbcu.add_test("offset", @test)
	
	end sub
	
end namespace
