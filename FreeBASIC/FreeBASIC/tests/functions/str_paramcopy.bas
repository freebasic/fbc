# include "fbcu.bi"




namespace fbc_tests.functions.str_paramcopy

'':::::
sub nocopyback( byval s as string )

	s = ucase( s )
	
end sub

'':::::
sub copyback( byref s as string )

	s = ucase( s )
	
end sub

sub test_1 cdecl ()

	dim s as string
	dim z as zstring * 3+1
	dim f as string * 3
	
	s = "var"
	nocopyback( s )
	CU_ASSERT( s = "VAR" )

	s = "var"
	copyback( s )
	CU_ASSERT( s = "VAR" )
	
	z = "zer"
	copyback( z )
	CU_ASSERT( z = "zer" )
	
	z = "zer"
	nocopyback( z )
	CU_ASSERT( z = "ZER" )

	f = "fix"
	nocopyback( f )
	CU_ASSERT( f = "FIX" )

	f = "fix"
	copyback( f )
	CU_ASSERT( f = "FIX" )
	
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.functions.str_paramcopy")
	fbcu.add_test("test_1", @test_1)

end sub

end namespace
