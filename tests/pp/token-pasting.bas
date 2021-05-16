#include "fbcunit.bi"

#define tostr(a)   #a

SUITE( fbc_tests.pp.token_pasting )

	TEST( plain )

		#define join1(a,b) a##b
		#define join2(a,b) a ##b
		#define join3(a,b) a## b
		#define join4(a,b) a ## b
		#define join5(a,b) a  ##  b

		CU_ASSERT_EQUAL( tostr(join1(X,Y)), tostr(XY) )
		CU_ASSERT_EQUAL( tostr(join2(X,Y)), tostr(X Y) )
		CU_ASSERT_EQUAL( tostr(join3(X,Y)), tostr(X Y) )
		CU_ASSERT_EQUAL( tostr(join4(X,Y)), tostr(X  Y) )
		CU_ASSERT_EQUAL( tostr(join5(X,Y)), tostr(X  Y) )

	END_TEST

	TEST( under1 )

		#define join_01(a) a##_
		#define join_02(a) _##a
		#define join_03(a) a##__
		#define join_04(a) __##a

		CU_ASSERT_EQUAL( tostr(join_01(X)), tostr(X_) )
		CU_ASSERT_EQUAL( tostr(join_02(X)), tostr(_X) )
		CU_ASSERT_EQUAL( tostr(join_03(X)), tostr(X__) )
		CU_ASSERT_EQUAL( tostr(join_04(X)), tostr(__X) )

	END_TEST

	TEST( under_1 )

		#define join_01(_a) _a##_
		#define join_02(_a) _##_a
		#define join_03(_a) _a##__
		#define join_04(_a) __##_a

		CU_ASSERT_EQUAL( tostr(join_01(X)), tostr(X_) )
		CU_ASSERT_EQUAL( tostr(join_02(X)), tostr(_X) )
		CU_ASSERT_EQUAL( tostr(join_03(X)), tostr(X__) )
		CU_ASSERT_EQUAL( tostr(join_04(X)), tostr(__X) )

	END_TEST

	TEST( under1_ )

		#define join_01(a_) a_##_
		#define join_02(a_) _##a_
		#define join_03(a_) a_##__
		#define join_04(a_) __##a_

		CU_ASSERT_EQUAL( tostr(join_01(X)), tostr(X_) )
		CU_ASSERT_EQUAL( tostr(join_02(X)), tostr(_X) )
		CU_ASSERT_EQUAL( tostr(join_03(X)), tostr(X__) )
		CU_ASSERT_EQUAL( tostr(join_04(X)), tostr(__X) )

	END_TEST

	TEST( under_1_ )

		#define join_01(_a_) _a_##_
		#define join_02(_a_) _##_a_
		#define join_03(_a_) _a_##__
		#define join_04(_a_) __##_a_

		CU_ASSERT_EQUAL( tostr(join_01(X)), tostr(X_) )
		CU_ASSERT_EQUAL( tostr(join_02(X)), tostr(_X) )
		CU_ASSERT_EQUAL( tostr(join_03(X)), tostr(X__) )
		CU_ASSERT_EQUAL( tostr(join_04(X)), tostr(__X) )

	END_TEST

	TEST( under2 )

		#define join_01(a,b) a##_##b
		#define join_02(a,b) a ##_##b
		#define join_03(a,b) a## _##b
		#define join_04(a,b) a ## _##b
		#define join_05(a,b) a##_ ##b
		#define join_06(a,b) a##_##b
		#define join_07(a,b) a ##_##b
		#define join_08(a,b) a## _##b
		#define join_09(a,b) a ## _##b
		#define join_10(a,b) a##_ ##b

		CU_ASSERT_EQUAL( tostr(join_01(X,Y)), tostr(X_Y) )
		CU_ASSERT_EQUAL( tostr(join_02(X,Y)), tostr(X _Y) )
		CU_ASSERT_EQUAL( tostr(join_03(X,Y)), tostr(X _Y) )
		CU_ASSERT_EQUAL( tostr(join_04(X,Y)), tostr(X  _Y) )
		CU_ASSERT_EQUAL( tostr(join_05(X,Y)), tostr(X_ Y) )
		CU_ASSERT_EQUAL( tostr(join_06(X,Y)), tostr(X_Y) )
		CU_ASSERT_EQUAL( tostr(join_07(X,Y)), tostr(X _Y) )
		CU_ASSERT_EQUAL( tostr(join_08(X,Y)), tostr(X _Y) )
		CU_ASSERT_EQUAL( tostr(join_09(X,Y)), tostr(X  _Y) )
		CU_ASSERT_EQUAL( tostr(join_10(X,Y)), tostr(X_ Y) )

		'' Parser behaviour:
		'' - everything after a line continuation token '_' is ignored
		'' - the following expressions are poorly formed because the line
		''   continuation either continues to the following define
		''   or the following statment

		/'
		#define join_11(a,b) a ##_ ##b
		#define join_12(a,b) a## _ ##b
		#define join_13(a,b) a ## _ ##b
		#define join_14(a,b) a ##_ ##b
		#define join_15(a,b) a## _ ##b
		#define join_16(a,b) a ## _ ##b

		CU_ASSERT_EQUAL( tostr(join_11(X,Y)), tostr(X _ Y) )
		CU_ASSERT_EQUAL( tostr(join_12(X,Y)), tostr(X _ Y) )
		CU_ASSERT_EQUAL( tostr(join_13(X,Y)), tostr(X  _ Y) )
		CU_ASSERT_EQUAL( tostr(join_14(X,Y)), tostr(X _ Y) )
		CU_ASSERT_EQUAL( tostr(join_15(X,Y)), tostr(X _ Y) )
		CU_ASSERT_EQUAL( tostr(join_16(X,Y)), tostr(X  _ Y) )
		'/

	END_TEST

	''
	'' test case from commit: 91e58fe7da978e464f976dc3f94378fbf3d1fbb1
	''

	Type _MAP_ENTRY
		id As integer
		pA As integer
	End Type
	#macro BEGIN_ENTRIESMAP()
	Function _GetMapEntries() As _MAP_ENTRY Ptr
			Static As _MAP_ENTRY _entries(0 To ...) = { ##_ 
	#endmacro
	#macro END_ENTRIESMAP()
			(0, 0)}
			Return @_entries(0)
		End Function
	#endmacro
	#define _INTERFACE_ENTRY(x, y) (x, y), ##_

	#macro GENMAP()

	BEGIN_ENTRIESMAP()
	_INTERFACE_ENTRY(1, 2)
	_INTERFACE_ENTRY(3, 4)
	_INTERFACE_ENTRY(5, 6)
	END_ENTRIESMAP()

	#endmacro

	GENMAP()

	TEST( line_pasting )

		var p = _GetMapEntries()
		CU_ASSERT_EQUAL( p[0].id, 1 )
		CU_ASSERT_EQUAL( p[0].pA, 2 )
		CU_ASSERT_EQUAL( p[1].id, 3 )
		CU_ASSERT_EQUAL( p[1].pA, 4 )
		CU_ASSERT_EQUAL( p[2].id, 5 )
		CU_ASSERT_EQUAL( p[2].pA, 6 )

	END_TEST	

END_SUITE
