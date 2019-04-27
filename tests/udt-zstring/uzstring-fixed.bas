#include "fbcunit.bi"
#include once "uzstring-fixed.bi"

'' reference implementation of fixed length UDT wstring

''
constructor UZSTRING_FIXED()
	_data = ""
end constructor

''
constructor UZSTRING_FIXED( byval s as const zstring const ptr )
	_data = *s
end constructor

''
constructor UZSTRING_FIXED( byval s as const wstring const ptr )
	_data = str( *s )
end constructor

''
operator UZSTRING_FIXED.Cast() byref as const zstring
	operator = *cast(zstring ptr, @_data)
end operator

const function UZSTRING_FIXED.length() as integer
	function = len( _data )
end function

''
operator Len( byref s as const UZSTRING_FIXED ) as integer
	return s.Length()
end operator
