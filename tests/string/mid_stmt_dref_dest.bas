# include once "fbcu.bi"
namespace fbc_tests.string_.mid_stmt_deref_destination
    
    
    sub deref_as_mid_destination cdecl ( )
    	dim as string f = " "
    	dim as string ptr g = @f
		if mid(*g, 1, 1) = " " then
			mid(*g, 1, 1) = "\"
		end if
		CU_ASSERT( *g = "\" )
	end sub
	
	sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.string_.mid_stmt_deref_destination")
		fbcu.add_test("deref_as_mid_destination", @deref_as_mid_destination)
	
	end sub

end namespace
