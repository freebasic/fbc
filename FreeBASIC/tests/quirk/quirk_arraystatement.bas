#include "fbcu.bi"

namespace fbc_tests.functions.bydesc_arrayfield

	Type testing_type

		meep(1) As Integer

	End Type

	sub quirk_arraystatement_inWith( )

		Dim test As testing_type
		With test

			.meep( 0 ) = 69
			.meep( 1 ) = 420

			erase .meep

			CU_ASSERT( .meep( 0 ) = 0 )
			CU_ASSERT( .meep( 1 ) = 0 )

		End With

	end sub

	sub quirk_arrayfunction_inWith( )

		Dim test As testing_type
		With test

			CU_ASSERT( lbound( .meep ) = 0 )
			CU_ASSERT( ubound( .meep ) = 1 )

		End With

	end sub

	sub ctor () constructor

		fbcu.add_suite("fbc_tests.quirk.quirk_arraystatement")
		fbcu.add_test("quirk array statement in WITH", @quirk_arraystatement_inWith)
		fbcu.add_test("quirk array function in WITH", @quirk_arrayfunction_inWith)

	end sub

end namespace
