#include "fbcunit.bi"

SUITE( fbc_tests.structs.ctor_assign_parenths )
	
	type Vector2D
		as single x,y
	end type
	
	Operator + ( byval lhs as Vector2D, byval rhs as Vector2D ) as Vector2D
		return type<Vector2D>( lhs.x + rhs.x, lhs.y + rhs.y )
	end Operator
	
	TEST( new_style )
		dim as vector2d v1,v2
		
		v1.x = 3
		v1.y = 4
		
		v2.x = 5
		v2.y = 6
		
		dim as vector2d v3 = (v1+v2)
		
		CU_ASSERT_EQUAL(v3.x, 8)
		CU_ASSERT_EQUAL(v3.y, 10)
	END_TEST
	
	TEST( old_style )
		dim as vector2d v = (10, 20)
		
		CU_ASSERT_EQUAL(v.x, 10)
		CU_ASSERT_EQUAL(v.y, 20)
	END_TEST
	
END_SUITE
