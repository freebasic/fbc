' TEST_MODE : COMPILE_ONLY_FAIL

'' The DIM has an ellipsis and would come out as 0 to 2, which does not match
'' the EXTERN, so it must be an error.
extern array(0 to 1) as integer
dim array(0 to ...) as integer = { 1, 2, 3 }
