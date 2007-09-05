# include "fbcu.bi"

namespace fbc_tests.dim_.redim_param
	
	sub foo cdecl( b() as integer )
		redim b(-1)
	end sub

	private sub ctor () constructor
		fbcu.add_suite("fbc_tests.dim.redim_param")
		fbcu.add_test("ok_to_redim_array_params", @foo)
	end sub

end namespace
