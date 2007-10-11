# include "fbcu.bi"

namespace fbc_tests.string_.val_
	
	sub test cdecl ()
	
		Dim As String x = "&haxxxxf"
	 	CU_ASSERT( Val(x) = 10 )
	
		Dim As String y = "&o179"
	 	CU_ASSERT( Val(y) = 15 )
	
		Dim As String z = "&b10114"
	 	CU_ASSERT( Val(z) = 11 )
	
	end sub		
	
	sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.string.val_")
		fbcu.add_test("test", @test)
	
	end sub
	
end namespace
