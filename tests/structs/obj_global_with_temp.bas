# include "fbcu.bi"

namespace fbc_tests.structs.obj_global_with_temp

type UDT
	s as string
	declare constructor (byref as string)
end type
 
constructor UDT (byref s as string)
	this.s = s
end constructor
 
	'' temp strings will be created (because it's a byref param and a 
	'' zstring arg is being passed), and moved to GLOBAL_I()
	dim shared g_array(0) as UDT = { UDT( "string1" ) }
	
	'' ditto
	static shared gs_array(0) as UDT = { UDT( "string2" ) }
 
sub test1 cdecl

	CU_ASSERT_EQUAL( g_array(0).s, "string1" )
	CU_ASSERT_EQUAL( gs_array(0).s, "string2" )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.obj_global_with_temp")
	fbcu.add_test( "1", @test1)

end sub
	
end namespace	