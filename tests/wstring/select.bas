# include "fbcu.bi"




namespace fbc_tests.wstrings.select_

sub test_1 cdecl ()

	dim w as wstring * 10 => "abc"
		
	select case w
	case "1" to "10"
		CU_ASSERT( 0 )
	
	case "def"		
		CU_ASSERT( 0 )
	
	case "abc"
		CU_ASSERT( -1 )
		
	case else
		CU_ASSERT( 0 )	
	
	end select

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstrings.select_")
	fbcu.add_test("test_1", @test_1)

end sub

end namespace
