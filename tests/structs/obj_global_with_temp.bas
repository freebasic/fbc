#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_global_with_temp )

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
 
	TEST( all )

		CU_ASSERT_EQUAL( g_array(0).s, "string1" )
		CU_ASSERT_EQUAL( gs_array(0).s, "string2" )
		
	END_TEST
	
END_SUITE
