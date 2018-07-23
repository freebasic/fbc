#include "fbcunit.bi"

SUITE( fbc_tests.overload_.op_ctor_coercion_udt )

	enum TEST_TYPE
		TEST_TYPE_BAR = 1
	end enum

	const TEST_VAL_DOUBLE as double = 12
		
	type bar
		as byte pad
		declare constructor()
		declare constructor(byref rhs as bar)
		declare destructor()
	end type

	constructor bar
	end constructor

	constructor bar(byref rhs as bar)
	end constructor

	destructor bar()
	end destructor
		
	type foo_byval
		as TEST_TYPE _type = any
		declare constructor( )
		declare constructor( byval v as bar )
	end type

	constructor foo_byval( )
		_type = 0
	end constructor

	type foo_byref
		as TEST_TYPE _type = any
		declare constructor( )
		declare constructor( byref v as bar )
	end type

	constructor foo_byref( )
		_type = 0
	end constructor

		dim shared as bar TEST_VAL_BAR

	#macro gen_test( tp, mode )
		constructor foo_##mode( mode v as tp )
			_type = TEST_TYPE_##tp
		end constructor

		sub tp##__##mode##_ref( byref f as foo_##mode )
			CU_ASSERT_EQUAL( f._type, TEST_TYPE_##tp )
		end sub
		
		sub tp##__##mode##_val( byval f as foo_##mode )
			CU_ASSERT_EQUAL( f._type, TEST_TYPE_##tp )
		end sub

		TEST( tp##__##mode##_test )
			dim f as foo_##mode
			
			tp##__##mode##_ref( TEST_VAL_##tp )
			tp##__##mode##_val( TEST_VAL_##tp )
			
		END_TEST
	#endmacro

	gen_test( bar, byval )
	gen_test( bar, byref )

END_SUITE
