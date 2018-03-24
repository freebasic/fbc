#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_array )

	'' object array, ctor only
	TEST_GROUP( ctoronly )
		dim shared as integer ctors

		type UDT
			i as integer
			declare constructor( )
		end type

		constructor UDT( )
			ctors += 1
		end constructor

		TEST( default )
			CU_ASSERT( ctors = 0 )
			dim x(1) as UDT
			CU_ASSERT( ctors = 2 )
		END_TEST
	END_TEST_GROUP

	'' object array, dtor only
	TEST_GROUP( dtoronly )
		dim shared as integer dtors

		type UDT
			i as integer
			declare destructor( )
		end type

		destructor UDT( )
			dtors += 1
		end destructor

		TEST( default )
			CU_ASSERT( dtors = 0 )
			scope
				dim x(1) as UDT
				CU_ASSERT( dtors = 0 )
			end scope
			CU_ASSERT( dtors = 2 )
		END_TEST
	END_TEST_GROUP

	'' object array, defctor without params
	TEST_GROUP( defctorNoParams )
		dim shared as integer ctors, dtors

		type UDT
			i as integer
			declare constructor( )
			declare destructor( )
		end type

		constructor UDT( )
			ctors += 1
		end constructor

		destructor UDT( )
			dtors += 1
		end destructor

		TEST( default )
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( dtors = 0 )
			scope
				dim as UDT u(0 to 1)
				CU_ASSERT( ctors = 2 )
				CU_ASSERT( dtors = 0 )
			end scope
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( dtors = 2 )
		END_TEST
	END_TEST_GROUP

	'' object array, defctor with params
	TEST_GROUP( defctorWithParams )
		dim shared as integer ctors, dtors

		type UDT
			dim as integer i
			declare constructor( byval i as integer = 0 )
			declare destructor( )
		end type

		constructor UDT( byval i as integer = 0 )
			ctors += 1
		end constructor

		destructor UDT( )
			dtors += 1
		end destructor

		TEST( default )
			CU_ASSERT( ctors = 0 )
			CU_ASSERT( dtors = 0 )
			scope
				dim as UDT u(0 to 1)
				CU_ASSERT( ctors = 2 )
				CU_ASSERT( dtors = 0 )
			end scope
			CU_ASSERT( ctors = 2 )
			CU_ASSERT( dtors = 2 )
		END_TEST
	END_TEST_GROUP

END_SUITE
