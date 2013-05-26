' TEST_MODE : COMPILE_ONLY_FAIL

dim array(0 to 1) as integer
dim i as integer

'' Same as in the first test case, plus here we cannot evaluate it at
'' compile-time either, even though the array only has 1 dimension,
'' because l/ubound have special return values for dimension=0 or other
'' out-of-bounds dimensions...
const N = lbound( array, i )
