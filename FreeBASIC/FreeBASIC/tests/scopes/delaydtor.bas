# include "fbcu.bi"

namespace fbc_tests.scopes.delaydtors
	
	type X
		i as integer
	end type
	
	dim shared XX as X
	dim shared as integer cnt
	
	type T
		declare constructor (i as integer, byref impl as X = XX)
		declare destructor
		i as integer
	end type
	
	constructor T (i as integer, byref impl as X)
		cnt += 1
	end constructor
	
	destructor T
		cnt -= 1
	end destructor
	
	sub proc (byref x as T)
		CU_ASSERT( cnt = 1 )
	end sub
	
	sub test1 cdecl( )
		proc(T(420))
	end sub
	
	sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.scopes.delaydtors")
		fbcu.add_test("dtor delay", @test1)
	
	end sub
	
end namespace
	