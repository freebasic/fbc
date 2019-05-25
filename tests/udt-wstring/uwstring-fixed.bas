#include "fbcunit.bi"
#include once "uwstring-fixed.bi"

'' reference implementation of fixed length UDT wstring

''
constructor UWSTRING_FIXED()
	_data = ""
end constructor

''
constructor UWSTRING_FIXED( byval s as const wstring const ptr )
	_data = *s
end constructor

''
constructor UWSTRING_FIXED( byval s as const zstring const ptr )
	_data = wstr( *s )
end constructor

''
operator UWSTRING_FIXED.Cast() byref as const wstring
	operator = *cast(wstring ptr, @_data)	
end operator

const function UWSTRING_FIXED.length() as integer
	function = len( _data )
end function

''
operator Len( byref s as const UWSTRING_FIXED ) as integer
	return s.Length()
end operator
