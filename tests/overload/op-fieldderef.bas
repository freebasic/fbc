#include "fbcunit.bi"

SUITE( fbc_tests.overload_.op_fieldderef )

	TEST_GROUP( simple )
		type UDT
			i as integer
		end type

		dim shared globali as integer = 123

		operator ->(byref l as UDT) as UDT
			l.i += 100
			operator = l
		end operator

		TEST( default )
			dim x as UDT
			x.i = 400
			CU_ASSERT( x->i = 500 )
			CU_ASSERT( (x)->i = 600 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( withSingleDeref )
		type UDT
			pi as integer ptr
		end type

		dim shared globali as integer = 123

		operator ->(byref l as UDT) as UDT
			operator = l
		end operator

		TEST( default )
			dim x as UDT
			x.pi = @globali
			CU_ASSERT( x->*pi = 123 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( withMultiDeref )
		type UDT
			pppi as integer ptr ptr ptr
		end type

		dim shared globali as integer = 123
		dim shared globalpi as integer ptr = @globali
		dim shared globalppi as integer ptr ptr = @globalpi

		operator ->(byref l as UDT) as UDT
			operator = l
		end operator

		TEST( default )
			dim x as UDT
			x.pppi = @globalppi
			CU_ASSERT( x->***pppi = 123 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( parenthesized )
		type T
			elem as integer
		end type

		operator ->(x as T) as T
			operator = x
		end operator

		TEST( default )
			dim as T x
			x.elem = 123
			CU_ASSERT( x->elem = 123 )
			CU_ASSERT( (@x)[0]->elem = 123 )
			CU_ASSERT( (x)->elem = 123 )
		END_TEST
	END_TEST_GROUP

END_SUITE
