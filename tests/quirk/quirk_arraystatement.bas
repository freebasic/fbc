#include "fbcunit.bi"

SUITE( fbc_tests.quirk.quirk_arraystatement )

	Type testing_type
		meep(1) As Integer
	End Type

	'' ERASE inside WITH
	TEST( eraseInsideWith )
		Dim test_udt As testing_type
		With test_udt
			.meep( 0 ) = 69
			.meep( 1 ) = 420

			erase .meep

			CU_ASSERT( .meep( 0 ) = 0 )
			CU_ASSERT( .meep( 1 ) = 0 )
		End With
	END_TEST

	'' L/UBOUND inside WITH
	TEST( boundInsideWith )
		Dim test_udt As testing_type
		With test_udt
			CU_ASSERT( lbound( .meep ) = 0 )
			CU_ASSERT( ubound( .meep ) = 1 )
		End With
	END_TEST

END_SUITE
