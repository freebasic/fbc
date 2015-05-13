' TEST_MODE : COMPILE_AND_RUN_OK

#lang "qb"

#define ASSERT(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

sub test( pass as integer ) static
	if( pass = 1 ) then
		'' This dynamic array should become STATIC due to STATICLOCALS,
		'' and it should be unscoped
		redim array(1 to 2) as integer
	end if

	'' This should reference the STATIC array REDIM'ed above
	assert( lbound( array ) = 1 )
	assert( ubound( array ) = 2 )
end sub

test( 1 )  '' 1st call to allocate the STATIC dynamic array
test( 2 )  '' 2nd call to use the now allocated STATIC dynamic array
