 

const TEST_VAL1 = 1234
const TEST_VAL2 = 5678

namespace foo
	enum bar
    	one = TEST_VAL1
        two = TEST_VAL2
	end enum 

	
	namespace inner
		sub test_1
			dim as foo.bar b = foo.one
	
			CU_ASSERT( b = TEST_VAL1 )
			CU_ASSERT( foo.two = TEST_VAL2 )
		end sub

		sub test_2
			dim as bar b = one
			
			CU_ASSERT( b = TEST_VAL1 )
			CU_ASSERT( two = TEST_VAL2 )
		end sub

	end namespace
end namespace 

''
sub test_1
	dim as foo.bar b = foo.one
	
	CU_ASSERT( b = TEST_VAL1 )
	CU_ASSERT( foo.two = TEST_VAL2 )

end sub

''
sub test_2
	using foo

	dim as bar b = one
	
	CU_ASSERT( b = TEST_VAL1 )
	CU_ASSERT( two = TEST_VAL2 )
	
end sub

	test_1
	test_2
	
	foo.inner.test_1

	using foo
	inner.test_2

	