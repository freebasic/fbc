' TEST_MODE : COMPILE_ONLY_FAIL

dim array(0 to 1, 1 to 2) as integer
dim i as integer

'' This cannot be evaluated as constant, even though we know all the l/ubounds,
'' because the dimension parameter is not a constant, and we don't know which
'' dimension it will query...
const N = lbound( array, i )
