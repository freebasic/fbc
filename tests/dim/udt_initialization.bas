# include "fbcu.bi"

namespace fbc_tests.dim_.udt_initialization
	
	type T
		declare constructor
		declare constructor (i as integer)
		declare operator let (byref x as T)
		
		as integer i, j, k, l, m
	end type
	
	constructor T
	end constructor
	
	constructor T (i as integer)
	end constructor
	
	operator T.let (byref x as T)
	end operator
	
	function f () as T
		return T(420)
	end function
	
	sub test1 cdecl( )
		dim x as T = f( )
		with x
			CU_ASSERT( (.i or .j or .k or .l or .m) = 0 )
		end with
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.dim.udt_initialization")
		fbcu.add_test("test 1", @test1)
	
	end sub
	
end namespace
		