#include "fbcunit.bi"

dim shared x as integer = 1

type T extends object
	static x as integer

	declare static sub s1()
	declare static sub s2()
	declare static sub s3()
	declare static sub s4()

end type

dim shared T.x as integer = 2

private sub T.s1()
	CU_ASSERT( x = 2 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	dim x as integer = 3

	CU_ASSERT( x = 3 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	scope
		CU_ASSERT( x = 3 )
		CU_ASSERT( T.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

		dim x as integer = 4

		CU_ASSERT( x = 4 )
		CU_ASSERT( T.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )
	end scope

	CU_ASSERT( x = 3 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

end sub

private sub T.s2()

	CU_ASSERT( x = 2 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	scope

		CU_ASSERT( x = 2 )
		CU_ASSERT( T.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

		dim x as integer = 4

		CU_ASSERT( x = 4 )
		CU_ASSERT( T.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )
	end scope

	CU_ASSERT( x = 2 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

end sub

private sub T.s3()
	CU_ASSERT( x = 2 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	dim x as integer = 3

	CU_ASSERT( x = 3 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	scope
		CU_ASSERT( x = 3 )
		CU_ASSERT( T.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )
	end scope

	CU_ASSERT( x = 3 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

end sub

private sub T.s4()
	CU_ASSERT( x = 2 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	scope
		CU_ASSERT( x = 2 )
		CU_ASSERT( T.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )
	end scope

	CU_ASSERT( x = 2 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

end sub

private sub s1()
	CU_ASSERT( x = 1 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	dim x as integer = 3

	CU_ASSERT( x = 3 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	scope
		CU_ASSERT( x = 3 )
		CU_ASSERT( T.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

		dim x as integer = 4

		CU_ASSERT( x = 4 )
		CU_ASSERT( T.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )
	end scope

	CU_ASSERT( x = 3 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

end sub

private sub s2()
	CU_ASSERT( x = 1 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	scope

		CU_ASSERT( x = 1 )
		CU_ASSERT( T.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

		dim x as integer = 4

		CU_ASSERT( x = 4 )
		CU_ASSERT( T.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )
	end scope

	CU_ASSERT( x = 1 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

end sub

private sub s3()
	CU_ASSERT( x = 1 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	dim x as integer = 3

	CU_ASSERT( x = 3 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	scope
		CU_ASSERT( x = 3 )
		CU_ASSERT( T.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )
	end scope

	CU_ASSERT( x = 3 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

end sub

private sub s4()
	CU_ASSERT( x = 1 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	scope
		CU_ASSERT( x = 1 )
		CU_ASSERT( T.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )
	end scope

	CU_ASSERT( x = 1 )
	CU_ASSERT( T.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

end sub

SUITE( fbc_tests.structs.global_static )
	TEST( test1 )
		T.s1()
		T.s2()
		T.s3()
		T.s4()
		s1()
		s2()
		s3()
		s4()
	END_TEST
END_SUITE
 
