# include "fbcunit.bi"

SUITE( fbc_tests.const_.const_to_nonconst_ctordtor )

	dim shared as integer ctors, dtors

	type UDT
		i as integer
		declare constructor()
		declare destructor()
	end type

	constructor UDT()
		ctors += 1
	end constructor

	destructor UDT()
		dtors += 1
	end destructor

	TEST( ctordtor )
		ctors = 0
		dtors = 0
		scope
			dim x as const UDT = UDT()
		end scope
		CU_ASSERT( ctors = 1 )
		CU_ASSERT( dtors = 1 )

		ctors = 0
		dtors = 0
		scope
			var p = new const UDT[10]
			delete[] p
		end scope
		CU_ASSERT( ctors = 10 )
		CU_ASSERT( dtors = 10 )

		ctors = 0
		dtors = 0
		scope
			dim x as const UDT = UDT()
			dim y as UDT
			var a = 0
			y = iif( a, UDT(), x )
		end scope
		CU_ASSERT( ctors = 3 )
		CU_ASSERT( dtors = 3 )
	END_TEST

END_SUITE
