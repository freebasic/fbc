#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_global_with_temp3 )

	type UDT1
		declare constructor (array() as integer)
		array as integer ptr
	end type
 
	constructor UDT1 (array() as integer)
		dim as integer j, i
		
		this.array = allocate( ((ubound(array) - lbound(array)) + 1) * len( integer ) )
		
		j = 0
		for i = lbound(array) to ubound(array)
			this.array[j] = array(i)
			j += 1
		next
		
	end constructor
 
	'' just to pass an field array
	type tmp_udt
		pad as integer
		array(0 to 3) as integer
	end type	
		
		dim shared as tmp_udt tmp = (1234, {0, 1, 2, 3})
		
		'' passing a array field by descriptor will create a temp desc
		dim shared as UDT1 g_var = UDT1( tmp.array() )
		
	TEST( all )

		dim as integer i
		for i = 0 to 3
			CU_ASSERT_EQUAL( g_var.array[i], i )
		next
		
	END_TEST

END_SUITE
