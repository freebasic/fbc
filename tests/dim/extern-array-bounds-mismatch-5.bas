' TEST_MODE : COMPILE_ONLY_FAIL

'' EXTERN is static array, cannot DIM as dynamic array
extern array(0 to 1) as integer
dim    array() as integer
