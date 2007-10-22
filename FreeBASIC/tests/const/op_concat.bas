# include "fbcu.bi"

namespace fbc_tests.const_.op_concat
	
	sub test cdecl( )
		
		dim as const string foo = "hello"
		dim as string bar
		
		for i as integer = 0 to 3
			bar = bar & foo
		next
		
		CU_ASSERT( bar = "hellohellohellohello" )
		
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("tests.const.op_concat")
		fbcu.add_test("& operator", @test)
	
	end sub
	
end namespace