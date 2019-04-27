#pragma once

'' reference implementation of fixed length UDT wstring

type UWSTRING_FIXED extends wstring

	private:
		_data as wstring * 256

	public:
		declare constructor()
		declare constructor( byval rhs as const wstring const ptr )
		declare constructor( byval rhs as const zstring const ptr )
		declare operator cast() byref as wstring
		declare const function length() as integer

end type

declare operator Len( byref s as const UWSTRING_FIXED ) as integer
