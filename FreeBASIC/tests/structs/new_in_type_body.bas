# include "fbcu.bi"

namespace fbc_tests.structs.new_in_type_body
	
	type t
		declare constructor()
		declare destructor()
		as short ptr a = new short [8]
		as short ptr ptr b = new short ptr [8]
	end type
	
	constructor t ()
		cu_assert(a <> NULL)
		cu_assert(b <> NULL)
	end constructor
	
	destructor t
		delete[] a
		delete[] b
	end destructor
	
	sub test_allocation cdecl ()
		dim as t a, b, c, d, e, f
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.structs.new_in_type_body")
		fbcu.add_test("allocation test", @test_allocation)
	
	end sub
	
end namespace