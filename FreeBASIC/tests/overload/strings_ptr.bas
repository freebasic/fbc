	

enum RESULT
	RESULT_W
	RESULT_WW
	RESULT_WZ
	RESULT_Z
	RESULT_ZW
	RESULT_ZZ
end enum

declare function foo overload( byval bar as zstring ptr, byval baz as zstring ptr ) as RESULT
declare function foo overload( byval bar as zstring ptr, byval baz as wstring ptr ) as RESULT
declare function foo overload( byval bar as wstring ptr, byval baz as zstring ptr ) as RESULT
declare function foo overload( byval bar as wstring ptr, byval baz as wstring ptr ) as RESULT
declare function foo overload( byval bar as zstring ptr ) as RESULT
declare function foo overload( byval bar as wstring ptr ) as RESULT
sub test1
	assert( foo( "123", "123" ) = RESULT_ZZ )
	assert( foo( "123", wstr("123") ) = RESULT_ZW )
	assert( foo( wstr("123"), "123" ) = RESULT_WZ )
	assert( foo( wstr("123"), wstr("123") ) = RESULT_WW )
	assert( foo( wstr("123") ) = RESULT_W )
	assert( foo( "123" ) = RESULT_Z )
end sub	

sub test2
	dim as string s
	assert( foo( s, s ) = RESULT_ZZ )
	assert( foo( s, wstr(s) ) = RESULT_ZW )
	assert( foo( wstr(s), s ) = RESULT_WZ )
	assert( foo( wstr(s), wstr(s) ) = RESULT_WW )
	assert( foo( wstr(s) ) = RESULT_W )
	assert( foo( s ) = RESULT_Z )
end sub	

sub test3
	dim as string * 10 s
	assert( foo( s, s ) = RESULT_ZZ )
	assert( foo( s, wstr(s) ) = RESULT_ZW )
	assert( foo( wstr(s), s ) = RESULT_WZ )
	assert( foo( wstr(s), wstr(s) ) = RESULT_WW )
	assert( foo( wstr(s) ) = RESULT_W )
	assert( foo( s ) = RESULT_Z )
end sub	

sub test4
	dim as zstring * 10 s
	assert( foo( s, s ) = RESULT_ZZ )
	assert( foo( s, wstr(s) ) = RESULT_ZW )
	assert( foo( wstr(s), s ) = RESULT_WZ )
	assert( foo( wstr(s), wstr(s) ) = RESULT_WW )
	assert( foo( wstr(s) ) = RESULT_W )
	assert( foo( s ) = RESULT_Z )
end sub	

sub test5
	dim as zstring ptr s
	assert( foo( s, s ) = RESULT_ZZ )
	assert( foo( s, wstr(s) ) = RESULT_ZW )
	assert( foo( wstr(s), s ) = RESULT_WZ )
	assert( foo( wstr(s), wstr(s) ) = RESULT_WW )
	assert( foo( wstr(s) ) = RESULT_W )
	assert( foo( s ) = RESULT_Z )
end sub	

sub test6
	dim as wstring * 10 s
	assert( foo( s, s ) = RESULT_WW )
	assert( foo( s, str(s) ) = RESULT_WZ )
	assert( foo( str(s), s ) = RESULT_ZW )
	assert( foo( str(s), str(s) ) = RESULT_ZZ )
	assert( foo( str(s) ) = RESULT_Z )
	assert( foo( s ) = RESULT_W )
end sub	

sub test7
	dim as wstring ptr s
	assert( foo( s, s ) = RESULT_WW )
	assert( foo( s, str(s) ) = RESULT_WZ )
	assert( foo( str(s), s ) = RESULT_ZW )
	assert( foo( str(s), str(s) ) = RESULT_ZZ )
	assert( foo( str(s) ) = RESULT_Z )
	assert( foo( s ) = RESULT_W )
end sub	
	
function foo overload( byval bar as zstring ptr, byval baz as zstring ptr ) as RESULT
	function = RESULT_ZZ
end function

function foo overload( byval bar as zstring ptr, byval baz as wstring ptr ) as RESULT
	function = RESULT_ZW
end function

function foo overload( byval bar as wstring ptr, byval baz as zstring ptr ) as RESULT
	function = RESULT_WZ
end function
	
function foo overload( byval bar as wstring ptr, byval baz as wstring ptr ) as RESULT
	function = RESULT_WW
end function
	
function foo overload( byval bar as zstring ptr ) as RESULT
	function = RESULT_Z
end function

function foo overload( byval bar as wstring ptr ) as RESULT
	function = RESULT_W
end function
	
	test1
	test2
	test3
	test4
	test5
	test6
	test7