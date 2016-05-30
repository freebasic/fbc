# include "fbcu.bi"

namespace fbc_tests.const_.nonconst_to_const
	
	sub foo( byref bas as const string )
	end sub
	
	sub test cdecl( )
		dim as string bar
		foo( bar )
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.const.nonconst_to_const")
		fbcu.add_test("offset", @test)
	
	end sub
	
end namespace