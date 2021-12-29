' TEST_MODE : COMPILE_ONLY_OK

'' syntax check

#pragma push( lookup108 )
#pragma push( lookup108, FALSE )
#pragma push( lookup108, TRUE )
#pragma pop( lookup108 )
#pragma pop( lookup108 )
#pragma pop( lookup108 )
#pragma lookup108
#pragma lookup108 = FALSE
#pragma lookup108 = TRUE
