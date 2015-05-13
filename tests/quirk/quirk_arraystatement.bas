# include "fbcu.bi"

Type testing_type
	meep(1) As Integer
End Type

private sub quirk_arraystatement_inWith cdecl( )
	Dim test As testing_type
	With test
		.meep( 0 ) = 69
		.meep( 1 ) = 420

		erase .meep

		CU_ASSERT( .meep( 0 ) = 0 )
		CU_ASSERT( .meep( 1 ) = 0 )
	End With
end sub

private sub quirk_arrayfunction_inWith cdecl( )
	Dim test As testing_type
	With test
		CU_ASSERT( lbound( .meep ) = 0 )
		CU_ASSERT( ubound( .meep ) = 1 )
	End With
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/quirk/quirk_arraystatement" )
	fbcu.add_test( "ERASE inside WITH", @quirk_arraystatement_inWith )
	fbcu.add_test( "L/UBOUND inside WITH", @quirk_arrayfunction_inWith )
end sub
