':: ctor_byref : constructor calls when passed byref
 
# include "fbcu.bi"
 
namespace fbc_tests.structs.ctor_byref
 
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
function proc (byref x as UDT) as UDT
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
 
':: tests
private _
sub test_local cdecl
 
	/' def ctor, copy ctor, op let '/
	reset_count()
 
	':: default construction
	dim x as UDT
	test_count(1, 0, 0)
 
	':: copy construction from byref proc return
	dim y as UDT = proc(x)
	test_count(1, 2, 0)
 
	':: assignment from byref proc return
	x = proc(y)
	test_count(1, 3, 1)
 
end sub
 
'::
private _
sub test_static_local cdecl
 
	/' def ctor, copy ctor, op let '/
	reset_count()
 
	':: default construction
	static x as UDT
	test_count(1, 0, 0)
 
	':: copy construction from byref proc return
	static y as UDT = proc(x)
	test_count(1, 2, 0)
 
	':: assignment from byref proc return
	x = proc(y)
	test_count(1, 3, 1)
 
end sub
 
private _
sub ctor () constructor
 
	fbcu.add_suite("fbc_tests.structs.ctor_byref")
	fbcu.add_test("test_local", @test_local)
	fbcu.add_test("test_static_local", @test_static_local)
 
end sub
 
end namespace