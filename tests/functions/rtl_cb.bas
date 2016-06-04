# include "fbcu.bi"

namespace fbc_tests.compound.rtl_cb

    sub test cdecl( )
		var p = @sleep
	end sub
	
	sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.functions.rtl_cb")
		fbcu.add_test("take sleep's address", @test)
	
	end sub
	
end namespace
