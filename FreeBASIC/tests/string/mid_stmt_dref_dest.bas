# include once "fbcu.bi"
namespace fbc_tests.string_.mid_stmt_deref_destination
    
    
    sub deref_as_mid_destination cdecl ( byref s as string )
    	'' byref is an implicit deref
		if mid(s, 1, 1) = " " then
			mid(s, 1, 1) = "\"
		end if
		CU_ASSERT( s = "\" )
	end sub
	
	sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.string_.mid_stmt_deref_destination")
		fbcu.add_test("deref_as_mid_destination", @deref_as_mid_destination)
	
	end sub

end namespace
