#include "fbcunit.bi"

SUITE( fbc_tests.overload_.bop_coercion )

	enum TEST_RES
		TEST_RES_MV_MV = 1
		TEST_RES_MV_V  = 2
		TEST_RES_V_MV  = 3
	end enum

	type VARIANT
		field as integer
	end type

	type MyVariant
		v as VARIANT = any
		declare constructor ( byval value as integer )
		
		'' this ctor shouldn't be used, as the operators has less "cost"
		declare constructor ( byref v as VARIANT )
		
		'' this op either
		declare operator cast ( ) as VARIANT
	end type
		
	constructor MyVariant ( byref v as VARIANT )
		this.v = v
	end constructor

	constructor MyVariant ( byval value as integer )
		this.v.field = value
	end constructor

	operator MyVariant.cast ( ) as VARIANT
		return type<VARIANT>( this.v.field )
	end operator

	'':::::
	operator - ( byref lhs as MyVariant, byref rhs as MyVariant ) as TEST_RES
		
		return TEST_RES_MV_MV

	end operator

	'':::::
	operator - ( byref lhs as MyVariant, byref rhs as VARIANT ) as TEST_RES
		
		return TEST_RES_MV_V

	end operator

	'':::::
	operator - ( byref lhs as VARIANT, byref rhs as MyVariant ) as TEST_RES
		
		return TEST_RES_V_MV

	end operator

	TEST( all )
		dim t1 as VARIANT
		dim t2 as MyVariant = t1
		
		CU_ASSERT_EQUAL( t2 - t1, TEST_RES_MV_V )
		
		CU_ASSERT_EQUAL( t1 - t2, TEST_RES_V_MV )
		
		CU_ASSERT_EQUAL( t2 - t2, TEST_RES_MV_MV )

	END_TEST
		
END_SUITE
