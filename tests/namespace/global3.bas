#include "fbcunit.bi"

dim shared x as integer = 1

namespace module.ns.global3

	dim shared x as integer = 2

	sub s1()
		CU_ASSERT( x = 2 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

		dim x as integer = 3

		CU_ASSERT( x = 3 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

		scope
			CU_ASSERT( x = 3 )
			CU_ASSERT( module.ns.global3.x = 2 )
			CU_ASSERT( .x = 1 )
			CU_ASSERT( ..x = 1 )

			dim x as integer = 4

			CU_ASSERT( x = 4 )
			CU_ASSERT( module.ns.global3.x = 2 )
			CU_ASSERT( .x = 1 )
			CU_ASSERT( ..x = 1 )
		end scope

		CU_ASSERT( x = 3 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

	end sub

	sub s2()

		CU_ASSERT( x = 2 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

		scope

			CU_ASSERT( x = 2 )
			CU_ASSERT( module.ns.global3.x = 2 )
			CU_ASSERT( .x = 1 )
			CU_ASSERT( ..x = 1 )

			dim x as integer = 4

			CU_ASSERT( x = 4 )
			CU_ASSERT( module.ns.global3.x = 2 )
			CU_ASSERT( .x = 1 )
			CU_ASSERT( ..x = 1 )
		end scope

		CU_ASSERT( x = 2 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

	end sub

	sub s3()
		CU_ASSERT( x = 2 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

		dim x as integer = 3

		CU_ASSERT( x = 3 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

		scope
			CU_ASSERT( x = 3 )
			CU_ASSERT( module.ns.global3.x = 2 )
			CU_ASSERT( .x = 1 )
			CU_ASSERT( ..x = 1 )
		end scope

		CU_ASSERT( x = 3 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

	end sub

	sub s4()
		CU_ASSERT( x = 2 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

		scope
			CU_ASSERT( x = 2 )
			CU_ASSERT( module.ns.global3.x = 2 )
			CU_ASSERT( .x = 1 )
			CU_ASSERT( ..x = 1 )
		end scope

		CU_ASSERT( x = 2 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

	end sub

end namespace

private sub s1()
	CU_ASSERT( x = 1 )
	CU_ASSERT( module.ns.global3.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	dim x as integer = 3

	CU_ASSERT( x = 3 )
	CU_ASSERT( module.ns.global3.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	scope
		CU_ASSERT( x = 3 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

		dim x as integer = 4

		CU_ASSERT( x = 4 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )
	end scope

	CU_ASSERT( x = 3 )
	CU_ASSERT( module.ns.global3.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

end sub

private sub s2()

	CU_ASSERT( x = 1 )
	CU_ASSERT( module.ns.global3.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	scope

		CU_ASSERT( x = 1 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )

		dim x as integer = 4

		CU_ASSERT( x = 4 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )
	end scope

	CU_ASSERT( x = 1 )
	CU_ASSERT( module.ns.global3.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

end sub

private sub s3()
	CU_ASSERT( x = 1 )
	CU_ASSERT( module.ns.global3.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	dim x as integer = 3

	CU_ASSERT( x = 3 )
	CU_ASSERT( module.ns.global3.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	scope
		CU_ASSERT( x = 3 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )
	end scope

	CU_ASSERT( x = 3 )
	CU_ASSERT( module.ns.global3.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

end sub

private sub s4()
	CU_ASSERT( x = 1 )
	CU_ASSERT( module.ns.global3.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

	scope
		CU_ASSERT( x = 1 )
		CU_ASSERT( module.ns.global3.x = 2 )
		CU_ASSERT( .x = 1 )
		CU_ASSERT( ..x = 1 )
	end scope

	CU_ASSERT( x = 1 )
	CU_ASSERT( module.ns.global3.x = 2 )
	CU_ASSERT( .x = 1 )
	CU_ASSERT( ..x = 1 )

end sub

SUITE( fbc_tests.namespace_.global3 )
	TEST( test1 )
		module.ns.global3.s1()
		module.ns.global3.s2()
		module.ns.global3.s3()
		module.ns.global3.s4()
		s1()
		s2()
		s3()
		s4()
	END_TEST
END_SUITE
