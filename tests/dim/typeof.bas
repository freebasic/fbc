#include "fbcu.bi"

namespace fbc_tests.dim_.typeof_

	sub test_it cdecl( )
	    
		var foo = cast(integer, 0)
		
		dim bar as typeof(foo)
		dim baz as typeof(foo) ptr = @bar
		
		*baz = &Hbaddf00d
		
		CU_ASSERT( bar = &Hbaddf00d )

	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.dim.typeof")
		fbcu.add_test("typeof() with dim", @test_it)
	
	end sub

end namespace
