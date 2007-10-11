# include "fbcu.bi"



namespace fbc_tests.pointers.indexing2

	dim shared dp as integer pointer pointer 
	dim shared array(0 to 4) as integer 

sub test cdecl ()

	*dp = @array(0) 
  
	dim i as integer
	for i = 0 to 4 
  		CU_ASSERT_EQUAL( *(*dp + i), i )
	next 

end sub

private function init cdecl () as integer

	dim i as integer
	for i = 0 to 4 
  		array(i) = i 
	next 

	dp = allocate( len(integer pointer pointer) ) 
	if (0 = dp) then return -1
	*dp = allocate( len(integer pointer) ) 
	if (0 = *dp) then return -1

	return 0

end function

private function cleanup cdecl () as integer

'	deallocate (*dp)
'	deallocate (dp)
	
	return 0

end function

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.indexing2", @init, @cleanup)
	fbcu.add_test("test", @test)

end sub

end namespace
