' TEST_MODE : COMPILE_AND_RUN_OK

#lang "qb"

#define ASSERT(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

option dynamic

__extern array1() as integer
dim shared array1(1 to 2) as integer

ASSERT( lbound( array1 ) = 1 )
ASSERT( ubound( array1 ) = 2 )

redim array1(0 to 1)

ASSERT( lbound( array1 ) = 0 )
ASSERT( ubound( array1 ) = 1 )

__extern array2() as integer
__extern array2() as integer
