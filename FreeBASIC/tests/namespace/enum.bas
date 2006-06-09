option explicit 

const TEST_VAL1 = 1234
const TEST_VAL2 = 5678

namespace foo
	const zzz = 1
	enum bar
    	one = TEST_VAL1
        two = TEST_VAL2
	end enum 
end namespace 

sub test_1
	dim as foo.bar b = foo.bar.one
	
	assert( b = TEST_VAL1 )
	assert( foo.bar.two = TEST_VAL2 )

end sub

sub test_2
	using foo

	dim as bar b = bar.one
	
	assert( b = TEST_VAL1 )
	assert( bar.two = TEST_VAL2 )
	
end sub

	test_1
	test_2
