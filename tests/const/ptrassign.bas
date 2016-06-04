# include "fbcu.bi"

namespace fbc_tests.const_.ptrassign
	
	sub test cdecl( )
		dim as const integer a = 0
		dim as const integer ptr b
		dim as const integer ptr ptr c 
		
		b = @a
		c = @b
		*c = @a
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.const.ptrassign")
		fbcu.add_test("assign const ptr", @test)
	
	end sub
	
end namespace
