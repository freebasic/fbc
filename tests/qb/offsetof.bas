' TEST_MODE : COMPILE_AND_RUN_OK

#lang "qb"

#define ASSERT(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

type UDT
	as integer a, b
end type

ASSERT( __offsetof( UDT, a ) = 0 )
ASSERT( __offsetof( UDT, b ) = 2 )
