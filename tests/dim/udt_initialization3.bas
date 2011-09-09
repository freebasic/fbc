# include "fbcu.bi"

namespace fbc_tests.dim_.udt_initialization3
	
	type T
		declare constructor
		declare constructor (i as integer)
		declare operator let (byref x as T)
		
		as integer i, j, k, l, m
	end type
	
	constructor T
		i = 12345
	end constructor
	
	constructor T (i as integer)
		this.i = i
	end constructor
	
	operator T.let (byref x as T)
	end operator
	
	function f () as T
		return T(420)
	end function
	
	sub test1 cdecl( )
		dim x as T = f( )
		with x
			CU_ASSERT( ( .i = 420 ) )
			CU_ASSERT( ( .j = 0 ) )
			CU_ASSERT( ( .k = 0 ) )
			CU_ASSERT( ( .l = 0 ) )
			CU_ASSERT( ( .m = 0 ) )
		end with
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.dim.udt_initialization3")
		fbcu.add_test("test 1", @test1)
	
	end sub
	
end namespace
		