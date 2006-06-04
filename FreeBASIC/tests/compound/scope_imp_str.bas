option explicit

const TEST_STR1 = "foobar"
const TEST_STR2 = "1234"

sub test_1

	dim as zstring ptr str1 = @TEST_STR1
	dim as zstring ptr str2 = @TEST_STR2
	dim as string res
	
	'' implicit scope with a hidden var allocated
	if( 1 ) then
		res = *str1 + *str2
	end if
	
	assert( res = TEST_STR1 + TEST_STR2 )
	
end sub

sub test_2

	dim as string str1 = TEST_STR1
	dim as string str2 = TEST_STR2
	dim as string res
	
	'' implicit scope with no hidden var allocated
	if( 1 ) then
		res = str1 + str2
	end if
	
	assert( res = TEST_STR1 + TEST_STR2 )
	
end sub

	test_1
	test_2