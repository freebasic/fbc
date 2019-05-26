#include "fbcunit.bi"
#include once "uzstring-fixed.bi"

'' reference implementation of fixed length UDT zstring

'' -------------------
'' UZSTRING_FIXED_BASE
'' -------------------

''
constructor UZSTRING_FIXED_BASE()
	_data = ""
end constructor

''
constructor UZSTRING_FIXED_BASE( byval s as const zstring const ptr )
	_data = *s
end constructor

''
constructor UZSTRING_FIXED_BASE( byval s as const wstring const ptr )
	_data = str( *s )
end constructor

''
const function UZSTRING_FIXED_BASE.length() as integer
	function = len( _data )
end function

''
operator Len( byref s as const UZSTRING_FIXED_BASE ) as integer
	return s.Length()
end operator

'' --------------
'' UZSTRING_FIXED
'' --------------

''
constructor UZSTRING_FIXED()
end constructor

''
constructor UZSTRING_FIXED( byval s as const wstring const ptr )
	base( s )
end constructor

''
constructor UZSTRING_FIXED( byval s as const zstring const ptr )
	base( s )
end constructor

''
operator UZSTRING_FIXED.Cast() byref as const zstring
	operator = *cast(zstring ptr, @_data)
end operator


'' ----------------------
'' UZSTRING_FIXED_MUTABLE
'' ----------------------

''
constructor UZSTRING_FIXED_MUTABLE()
end constructor

''
constructor UZSTRING_FIXED_MUTABLE( byval s as const wstring const ptr )
	base( s )
end constructor

''
constructor UZSTRING_FIXED_MUTABLE( byval s as const zstring const ptr )
	base( s )
end constructor

''
operator UZSTRING_FIXED_MUTABLE.Cast() byref as zstring
	operator = *cast(zstring ptr, @_data)
end operator