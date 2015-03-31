' TEST_MODE : COMPILE_AND_RUN_OK

#lang "qb"

#define ASSERT(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

type UDT
	as integer a, b
end type

ASSERT( __offsetof( UDT, a ) = 0 )
ASSERT( __offsetof( UDT, b ) = 2 )

type BigUdt
	bigchunk(0 to 65536-1) as __ubyte  '' 2^16-1 bytes
	a as integer  '' has an offset that can't be represented with just 16 bit
	b as integer  '' ditto
end type

ASSERT( __offsetof( BigUdt, a ) = 65536 )
ASSERT( __offsetof( BigUdt, b ) = 65538 )
