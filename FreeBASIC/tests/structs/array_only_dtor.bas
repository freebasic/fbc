# include "fbcu.bi"

namespace fbc_tests.structs.array_only_dtor
	
	Type foo
		As Integer dummy
		Declare Destructor( )
	End Type
	
	Destructor foo()
	End Destructor
	
	sub test1 cdecl ( )
		Dim x(1) As foo
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.structs.array_only_dtor")
		fbcu.add_test("Make sure object arrays with destructor but no constructor won't crash", @test1)
	
	end sub
	
end namespace
