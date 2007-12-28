# include "fbcu.bi"

namespace fbc_tests.strings.redim_

#macro test_set()
	for i = lbound( array ) to ubound( array )
		array(i) = str( i )
	next
#endmacro

#macro test_chk()
	for i = lbound( array ) to ubound( array )
		CU_ASSERT_EQUAL( array(i), str( i ) )
	next
#endmacro

sub test cdecl	
	dim as integer i
	
	redim as string array(0 to 1)
	test_set()
	test_chk()
	
	redim array(0 to 2)
	test_set()
	test_chk()

	redim array(0 to 1)
	test_set()
	test_chk()

	redim array(0 to 3)
	test_set()
	test_chk()

end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-strings:redim")
	fbcu.add_test( "test", @test)

end sub
	
end namespace