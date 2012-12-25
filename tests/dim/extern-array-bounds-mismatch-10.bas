' TEST_MODE : COMPILE_ONLY_FAIL

'' DIM has more dimensions than EXTERN
extern array(0 to 1) as integer
dim    array(0 to 1, 0 to 1) as integer
