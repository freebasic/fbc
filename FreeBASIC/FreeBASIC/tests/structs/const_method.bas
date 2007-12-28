# include "fbcu.bi"

namespace fbc_tests.structs.const_method
	
	type foo
		
		__ as integer
		
		declare const sub bar( )
		declare sub bar2( )
	
	end type
	
	sub foo.bar( )
	end sub
	sub foo.bar2( )
	end sub
	
	sub test cdecl( )
		dim as foo baz
		
		baz.bar( )
		baz.bar2( )
		
		dim as const foo baz2 = (3)
		
		baz2.bar( )
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("tests.structs.const_method")
		fbcu.add_test("const_method", @test)
	
	end sub
	
end namespace
