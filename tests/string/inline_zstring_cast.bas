# include "fbcu.bi"

namespace fbc_tests.string_.inline_zstring_cast

const as string key = "This is a string that's exactly 63 characters long! Oh yeah!!!!"

private sub ztest cdecl( )
	'' 0 to (len( key ) + 1)-1 bytes, that's enough to hold the string plus the null terminator
	dim as ubyte foo(len( key ))
	*cast(zstring ptr, @foo(0)) = key
	CU_ASSERT( *cast(zstring ptr, @foo(0)) = key )
end sub

private sub wtest cdecl( )
	'' ditto, reserving room for 63+1 wchars
	dim as ubyte foo(0 to ((len( key ) + 1) * sizeof(wstring))-1)
	*cast(wstring ptr, @foo(0)) = key
	CU_ASSERT( *cast(wstring ptr, @foo(0)) = key )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.string.inline_zstring_cast" )
	fbcu.add_test( "inline zstring cast assignment", @ztest )
	fbcu.add_test( "inline wstring cast assignment", @wtest )
end sub

end namespace
