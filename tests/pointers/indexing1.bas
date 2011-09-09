# include "fbcu.bi"



namespace fbc_tests.pointers.indexing1

sub test cdecl ()

	dim i as integer, dp as integer pointer
	dim array(0 to 4) as integer 

	for i = 0 to 4 
  		array(i) = i 
	next 

	dp = @array(0)

	for i = 0 to 4 
  		CU_ASSERT_EQUAL( dp[i], i )
	next 

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.indexing1")
	fbcu.add_test("test", @test)

end sub

end namespace
