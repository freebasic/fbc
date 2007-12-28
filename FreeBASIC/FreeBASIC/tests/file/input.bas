# include "fbcu.bi"

namespace fbc_tests.file.inputTests



const filename = ".\file\input.csv"

	dim shared as string g_field1(1 to 3)
	dim shared as double g_field2(1 to 3), g_field3(1 to 3), g_field4(1 to 3), g_field5(1 to 3)

sub integerTest cdecl ()
	dim as string field1(1 to 3)
	dim as integer field2(1 to 3), field3(1 to 3), field4(1 to 3), field5(1 to 3)
	dim as integer i

	open filename for input as #1 

	for i = 1 to 3 
   		input #1, field1(i), field2(i), field3(i), field4(i), field5(i)
   		CU_ASSERT_EQUAL( field1(i), g_field1(i) )
   		CU_ASSERT_EQUAL( field2(i), cint( g_field2(i) ) )
   		CU_ASSERT_EQUAL( field3(i), cint( g_field3(i) ) )
   		CU_ASSERT_EQUAL( field4(i), cint( g_field4(i) ) )
   		CU_ASSERT_EQUAL( field5(i), cint( g_field5(i) ) )
	next 

	close #1
	
end sub

sub doubleTest cdecl ()
	dim as string field1(1 to 3)
	dim as double field2(1 to 3), field3(1 to 3), field4(1 to 3), field5(1 to 3)
	dim as integer i

	open filename for input as #1 

	for i = 1 to 3 
   		input #1, field1(i), field2(i), field3(i), field4(i), field5(i)
   		CU_ASSERT_EQUAL( field1(i), g_field1(i) )
   		CU_ASSERT_EQUAL( field2(i), g_field2(i) )
   		CU_ASSERT_EQUAL( field3(i), g_field3(i) )
   		CU_ASSERT_EQUAL( field4(i), g_field4(i) )
   		CU_ASSERT_EQUAL( field5(i), g_field5(i) )
	next 

	close #1
	
end sub

sub load_data
end sub
   	
'// TODO: error checking
private function init cdecl () as integer
	open filename for input as #1 
	dim as integer i

	for i = 1 to 3 
		input #1, g_field1(i), g_field2(i), g_field3(i), g_field4(i), g_field5(i)
	next

	close #1
	
	return 0
end function

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.file.input", @init)
	fbcu.add_test("integerTest", @integerTest)
	fbcu.add_test("doubleTest", @doubleTest)

end sub

end namespace
