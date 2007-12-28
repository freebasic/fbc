' TEST_MODE : COMPILE_AND_RUN_OK


Type testing_type

	meep(1) As Integer

End Type

sub quirk_arraystatement_inWith cdecl( )

	Dim test As testing_type
	With test

		.meep( 0 ) = 69
		.meep( 1 ) = 420

		erase .meep

		ASSERT( .meep( 0 ) = 0 )
		ASSERT( .meep( 1 ) = 0 )

	End With

end sub

sub quirk_arrayfunction_inWith cdecl( )

	Dim test As testing_type
	With test

		ASSERT( lbound( .meep ) = 0 )
		ASSERT( ubound( .meep ) = 1 )

	End With

end sub
