':: ctor_byref : constructor calls when passed byval
 
#include "fbcunit.bi"
 
SUITE( fbc_tests.structs.ctor_byval )
 
	dim shared defCtorCount as uinteger = 0
	dim shared copyCtorCount as uinteger = 0
	dim shared opLetCount as uinteger = 0
 
	':: test TYPE
	type UDT
		declare constructor()
		declare constructor(byref as UDT)
		declare operator let (byref as UDT)
		x as integer
	end type
 
	constructor UDT ()
		defCtorCount += 1
	end constructor
 
	constructor UDT (byref x as UDT)
		copyCtorCount += 1
	end constructor
 
	operator UDT.let (byref x as UDT)
		opLetCount += 1
	end operator
 
	':: test procedure and helpers
	private _
	function proc (byval x as UDT) as UDT
		return x
	end function
 
	private _
	sub reset_count
		defCtorCount = 0
		copyCtorCount = 0
		opLetCount = 0
	end sub
 
	private _
	sub test_count (defCtor as integer, copyCtor as integer, opLet as integer)
 
		CU_ASSERT_EQUAL( defCtorCount, defCtor )
		CU_ASSERT_EQUAL( copyCtorCount, copyCtor )
		CU_ASSERT_EQUAL( opLetCount, opLet )
 
	end sub
 
	TEST( local )
 
		/' def ctor, copy ctor, op let '/
		reset_count()
 
		':: default construction
		dim x as UDT
		test_count(1, 0, 0)
 
		':: copy construction from byref proc return
		dim y as UDT = proc(x)
		test_count(1, 3, 0)
 
		':: assignment from byref proc return
		x = proc(y)
		test_count(1, 5, 1)
 
	END_TEST
 
	TEST( static_local )
 
		/' def ctor, copy ctor, op let '/
		reset_count()
 
		':: default construction
		static x as UDT
		test_count(1, 0, 0)
 
		':: copy construction from byref proc return
		static y as UDT = proc(x)
		test_count(1, 3, 0)
 
		':: assignment from byref proc return
		x = proc(y)
		test_count(1, 5, 1)
 
	END_TEST
 
END_SUITE
