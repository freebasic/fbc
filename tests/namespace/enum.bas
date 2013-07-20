# include "fbcu.bi"

const TEST_VAL1 = 1234
const TEST_VAL2 = 5678

namespace fbc_tests.ns.enum_
	enum bar
    	one = TEST_VAL1
        two = TEST_VAL2
	end enum 

	namespace inner
		private sub test_3 cdecl
			dim as fbc_tests.ns.enum_.bar b = fbc_tests.ns.enum_.one
			CU_ASSERT( b = TEST_VAL1 )
			CU_ASSERT( fbc_tests.ns.enum_.two = TEST_VAL2 )
		end sub

		private sub test_4 cdecl
			dim as bar b = one
			CU_ASSERT( b = TEST_VAL1 )
			CU_ASSERT( two = TEST_VAL2 )
		end sub
	end namespace
end namespace 

private sub test_1 cdecl
	dim as fbc_tests.ns.enum_.bar b = fbc_tests.ns.enum_.one
	CU_ASSERT( b = TEST_VAL1 )
	CU_ASSERT( fbc_tests.ns.enum_.two = TEST_VAL2 )
end sub

private sub test_2 cdecl
	using fbc_tests.ns.enum_
	dim as bar b = one
	CU_ASSERT( b = TEST_VAL1 )
	CU_ASSERT( two = TEST_VAL2 )
end sub

const GlobalConst1 = 111
const GlobalConst2 = 222
const GlobalConst3 = 333
const GlobalConst4 = 444

enum Enum1
	Enum1Const1 = 1
	GlobalConst1
end enum

enum Enum2 explicit
	Enum2Const1 = 1
	GlobalConst2
end enum

'' Testing enums inside extern blocks (used to have different behaviour)
extern "c++"
	enum Enum3
		Enum3Const1 = 1
		GlobalConst3
	end enum

	enum Enum4 explicit
		Enum4Const1 = 1
		GlobalConst4
	end enum
end extern
dim shared myenum1 as Enum1
dim shared myenum2 as Enum2
dim shared myenum3 as Enum3 '' just to test that the enum id can be used outside the extern
dim shared myenum4 as Enum4

private sub test5 cdecl( )
	CU_ASSERT( Enum1Const1 = 1 )
	CU_ASSERT( GlobalConst1 = 111 )
	CU_ASSERT( Enum1.Enum1Const1 = 1 )
	CU_ASSERT( Enum1.GlobalConst1 = 2 )

	CU_ASSERT( GlobalConst2 = 222 )
	CU_ASSERT( Enum2.Enum2Const1 = 1 )
	CU_ASSERT( Enum2.GlobalConst2 = 2 )

	CU_ASSERT( Enum3Const1 = 1 )
	CU_ASSERT( GlobalConst3 = 333 )
	CU_ASSERT( Enum3.Enum3Const1 = 1 )
	CU_ASSERT( Enum3.GlobalConst3 = 2 )

	CU_ASSERT( GlobalConst4 = 444 )
	CU_ASSERT( Enum4.Enum4Const1 = 1 )
	CU_ASSERT( Enum4.GlobalConst4 = 2 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/namespace/enum" )
	fbcu.add_test("test 1", @test_1)
	fbcu.add_test("test 2", @test_2)
	fbcu.add_test("test 3", @fbc_tests.ns.enum_.inner.test_3)
	using fbc_tests.ns.enum_
	fbcu.add_test("test 4", @inner.test_4)
	fbcu.add_test( "5", @test5 )
end sub
