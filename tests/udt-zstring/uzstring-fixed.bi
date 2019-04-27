#pragma once

'' reference implementation of fixed length UDT wstring

type UZSTRING_FIXED extends zstring

	private:
		_data as zstring * 256

	public:
		declare constructor()
		declare constructor( byval rhs as const zstring const ptr )
		declare constructor( byval rhs as const wstring const ptr )
		declare operator cast() byref as const zstring
		declare const function length() as integer

end type

declare operator Len( byref s as const UZSTRING_FIXED ) as integer
