' TEST_MODE : COMPILE_ONLY_FAIL

'' EXTERN is dynamic array, cannot DIM as static array
extern array() as integer
dim    array(0 to 1) as integer
