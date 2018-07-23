#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_global_with_temp2 )

	TEST_GROUP( test1 )
	
		type UDT1
			declare constructor (byref as string)
			s as string
		end type
		 
		constructor UDT1 (byref s as string)
			this.s = s
		end constructor
		
		type UDT2
			'' non-constant initializer + temps
			t(0 to 2) as udt1 = { UDT1( "string0" ), UDT1( "string1" ), UDT1( "string2" ) }
		end type
		
		dim shared g_array(0) as UDT2
			 
		TEST( default )
		
			dim as integer i
			
			for i = 0 to 2
				CU_ASSERT_EQUAL( g_array(0).t(i).s, "string" + str(i) )
			next
		END_TEST
		
	END_TEST_GROUP

	TEST_GROUP( test2 )
	
		type UDT1
			declare constructor (byref as string)
			s as string
		end type
		 
		constructor UDT1 (byref s as string)
			this.s = s
		end constructor

		type UDT2
			declare constructor (byref as double)
			d as double
		end type
		 
		constructor UDT2 (byref d as double)
			this.d = d
		end constructor
		
		type UDT3
			'' padding
			pad as integer = 1234
			
			'' non-constant initializer + temps
			t1(0 to 2) as udt1 = {UDT1( "string0" ), UDT1( "string1" ), UDT1( "string2" )}

			'' non-constant initializer (passed byref)
			t2(0 to 2) as udt2 = { UDT2(1.0 ), UDT2( 2.0 ), UDT2( 3.0 ) }
		end type
		
		dim shared g_array(0) as UDT3
			 
		TEST( default )
			dim as integer i
			
			for i = 0 to 2
				CU_ASSERT_EQUAL( g_array(0).t1(i).s, "string" + str(i) )
			next

			for i = 0 to 2
				CU_ASSERT_EQUAL( g_array(0).t2(i).d, 1 + i )
			next
			
			CU_ASSERT_EQUAL( g_array(0).pad, 1234 )
		END_TEST
		
	END_TEST_GROUP

END_SUITE
