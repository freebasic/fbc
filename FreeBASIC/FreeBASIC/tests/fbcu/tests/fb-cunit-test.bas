# include once "fbcu.bi"



namespace fbcu.fbcu_test

	function init cdecl () as integer
		return 0
	end function

	function cleanup cdecl () as integer
		return 0
	end function

	sub test1 cdecl ()
		CU_ASSERT(-1)
	end sub

	sub test2 cdecl ()
		CU_ASSERT(-1)
	end sub

	sub test3 cdecl ()
		CU_ASSERT(-1)
	end sub

end namespace

namespace fbcu.fbcu_test

	private sub ctor () constructor
	
		add_suite("fbcu-test", @init, @cleanup)
		add_test("test1", @test1)
		add_test("test2", @test2)
		add_test("test3", @test3)

	end sub

end namespace
