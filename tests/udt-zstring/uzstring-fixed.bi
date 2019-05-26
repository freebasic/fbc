#pragma once

'' reference implementation of fixed length UDT zstring

type UZSTRING_FIXED_BASE extends zstring

	protected:
		_data as zstring * 256

	public:
		declare constructor()
		declare constructor( byval rhs as const zstring const ptr )
		declare constructor( byval rhs as const wstring const ptr )
		declare const function length() as integer

end type

declare operator Len( byref s as const UZSTRING_FIXED_BASE ) as integer

type UZSTRING_FIXED extends UZSTRING_FIXED_BASE

	public:
		declare constructor()
		declare constructor( byval rhs as const wstring const ptr )
		declare constructor( byval rhs as const zstring const ptr )

		declare operator cast() byref as const zstring
end type

type UZSTRING_FIXED_MUTABLE extends UZSTRING_FIXED_BASE

	public:
		declare constructor()
		declare constructor( byval rhs as const wstring const ptr )
		declare constructor( byval rhs as const zstring const ptr )

		declare operator cast() byref as zstring
end type