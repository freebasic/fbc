' TEST_MODE : COMPILE_AND_RUN_OK

#define ASSERT(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

option dynamic

sub f( pass as integer )
	'' This should be a dynamic array due to OPTION DYNAMIC, and it should
	'' be STATIC (allocated on heap, not stack), such that it's preserved
	'' for later calls.
	static array(1 to 2) as integer

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

f( 1 )
f( 2 )
f( 3 )
