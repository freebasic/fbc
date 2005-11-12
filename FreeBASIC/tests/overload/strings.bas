
enum RESULT
   RESULT_ZSTRING
   RESULT_WSTRING
end enum

declare function proc overload( byval s as zstring ptr ) as RESULT

declare function proc ( byval s as wstring ptr ) as RESULT


function proc ( byval s as zstring ptr ) as RESULT
	function = RESULT_ZSTRING
end function

function proc ( byval s as wstring ptr ) as RESULT
	function = RESULT_WSTRING
end function

	dim as string s
	dim as string * 4 f
	dim as zstring * 4 z
	dim as wstring * 4 w
	dim as string ptr ps = @s
	dim as zstring ptr pz = @z
	dim as wstring ptr pw = @w
	
	assert( proc( s ) = RESULT_ZSTRING )
	assert( proc( f ) = RESULT_ZSTRING )
	assert( proc( z ) = RESULT_ZSTRING )
	assert( proc( w ) = RESULT_WSTRING )
	
	assert( proc( *ps ) = RESULT_ZSTRING )
	assert( proc( pz ) = RESULT_ZSTRING )
	assert( proc( pw ) = RESULT_WSTRING )
	assert( proc( *pz ) = RESULT_ZSTRING )
	assert( proc( *pw ) = RESULT_WSTRING )
	
	assert( proc( "abc" ) = RESULT_ZSTRING )
	assert( proc( wstr( "abc" ) ) = RESULT_WSTRING )

	end 0