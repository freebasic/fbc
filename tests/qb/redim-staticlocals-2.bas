' TEST_MODE : COMPILE_AND_RUN_OK

#lang "qb"

#define ASSERT(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

'' During the 1st pass, the array should be 1 to 2, then during the 2nd pass it's
'' REDIM'ed to 3 to 4, and that should be preserved to the 3rd pass because the
'' array should be STATIC due to STATICLOCALS.
sub test( pass as integer ) static
	redim array(1 to 2) as integer

	if( pass = 2 ) then
		redim array(3 to 4)
	end if

	if( pass = 1 ) then
		assert( lbound( array ) = 1 )
		assert( ubound( array ) = 2 )
	else
		assert( lbound( array ) = 3 )
		assert( ubound( array ) = 4 )
	end if
end sub

test( 1 )
test( 2 )
test( 3 )
