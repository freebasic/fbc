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

''
private sub test_1 cdecl
	dim as fbc_tests.ns.enum_.bar b = fbc_tests.ns.enum_.one
	
	CU_ASSERT( b = TEST_VAL1 )
	CU_ASSERT( fbc_tests.ns.enum_.two = TEST_VAL2 )

end sub

''
private sub test_2 cdecl
	using fbc_tests.ns.enum_

	dim as bar b = one
	
	CU_ASSERT( b = TEST_VAL1 )
	CU_ASSERT( two = TEST_VAL2 )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.namespace.enum")

	fbcu.add_test("test 1", @test_1)

	fbcu.add_test("test 2", @test_2)

	fbcu.add_test("test 3", @fbc_tests.ns.enum_.inner.test_3)

	using fbc_tests.ns.enum_
	fbcu.add_test("test 4", @inner.test_4)

end sub

	