#include "fbcunit.bi"
#include once "uwstring-fixed.bi"

'' reference implementation of fixed length UDT wstring

'' -------------------
'' UWSTRING_FIXED_BASE
'' -------------------

''
constructor UWSTRING_FIXED_BASE()
	_data = ""
end constructor

''
constructor UWSTRING_FIXED_BASE( byval s as const wstring const ptr )
	_data = *s
end constructor

''
constructor UWSTRING_FIXED_BASE( byval s as const zstring const ptr )
	_data = wstr( *s )
end constructor

const function UWSTRING_FIXED_BASE.length() as integer
	function = len( _data )
end function

''
operator Len( byref s as const UWSTRING_FIXED_BASE ) as integer
	return s.Length()
end operator


'' --------------
'' UWSTRING_FIXED
'' --------------

''
constructor UWSTRING_FIXED()
end constructor

''
constructor UWSTRING_FIXED( byval s as const wstring const ptr )
	base( s )
end constructor

''
constructor UWSTRING_FIXED( byval s as const zstring const ptr )
	base( s )
end constructor

''
operator UWSTRING_FIXED.Cast() byref as const wstring
	operator = *cast(wstring ptr, @_data)	
end operator


'' ----------------------
'' UWSTRING_FIXED_MUTABLE
'' ----------------------

''
constructor UWSTRING_FIXED_MUTABLE()
end constructor

''
constructor UWSTRING_FIXED_MUTABLE( byval s as const wstring const ptr )
	base( s )
end constructor

''
constructor UWSTRING_FIXED_MUTABLE( byval s as const zstring const ptr )
	base( s )
end constructor

''
operator UWSTRING_FIXED_MUTABLE.Cast() byref as wstring
	operator = *cast(wstring ptr, @_data)	
end operator
