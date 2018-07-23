#include "fbcunit.bi"

SUITE( fbc_tests.scopes.delaydtor )
	
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
	
	TEST( all )
		proc(T(420))
	END_TEST
	
END_SUITE
