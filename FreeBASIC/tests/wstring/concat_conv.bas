option explicit

const TEST_1 = "abcd"
const TEST_2 = "EFGH"

	dim as wstring * 32 w = TEST_1
	dim as zstring * 32 z = TEST_2
	dim as wstring * 256 res
	
	res = w + z
	
	assert( res = wstr(TEST_1) + wstr(TEST_2) )
	
	res = z + w
	
	assert( res = wstr(TEST_2) + wstr(TEST_1) )
