option explicit

	dim shared as string g_field1(1 to 3)
	dim shared as double g_field2(1 to 3), g_field3(1 to 3), g_field4(1 to 3), g_field5(1 to 3)

sub test_int
	dim as string field1(1 to 3)
	dim as integer field2(1 to 3), field3(1 to 3), field4(1 to 3), field5(1 to 3)
	dim as integer i

	open "input.csv" for input as #1 

	for i = 1 to 3 
   		input #1, field1(i), field2(i), field3(i), field4(i), field5(i)
   		assert( field1(i) = g_field1(i) )
   		assert( field2(i) = cint( g_field2(i) ) )
   		assert( field3(i) = cint( g_field3(i) ) )
   		assert( field4(i) = cint( g_field4(i) ) )
   		assert( field5(i) = cint( g_field5(i) ) )
	next 

	close #1
	
end sub

sub test_dbl
	dim as string field1(1 to 3)
	dim as double field2(1 to 3), field3(1 to 3), field4(1 to 3), field5(1 to 3)
	dim as integer i

	open "input.csv" for input as #1 

	for i = 1 to 3 
   		input #1, field1(i), field2(i), field3(i), field4(i), field5(i)
   		assert( field1(i) = g_field1(i) )
   		assert( field2(i) = g_field2(i) )
   		assert( field3(i) = g_field3(i) )
   		assert( field4(i) = g_field4(i) )
   		assert( field5(i) = g_field5(i) )
	next 

	close #1
	
end sub

sub load_data
	open "input.csv" for input as #1 
	dim as integer i

	for i = 1 to 3 
   		input #1, g_field1(i), g_field2(i), g_field3(i), g_field4(i), g_field5(i)
   	next
   	
   	close #1
end sub
   	
   	load_data
   	test_dbl
   	test_int
