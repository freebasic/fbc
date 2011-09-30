# include "fbcu.bi"




namespace fbc_tests.compound.while_

sub test_continue cdecl ()

	dim as string s = ""
	dim as integer i = 0

	while i < 10
	    if i = 5 then
	         s = str(i)
	         i += 1
	         continue while
	    end if
	    i += 1
	wend

	CU_ASSERT_EQUAL( s, "5" )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.compound.while_")
	fbcu.add_test("test continue while", @test_continue)

end sub

end namespace
