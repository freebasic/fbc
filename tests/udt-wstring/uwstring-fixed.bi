#pragma once

'' reference implementation of fixed length UDT wstring

type UWSTRING_FIXED_BASE extends wstring

	protected:
		_data as wstring * 256

	public:
		declare constructor()
		declare constructor( byval rhs as const wstring const ptr )
		declare constructor( byval rhs as const zstring const ptr )
		declare const function length() as integer

end type

declare operator Len( byref s as const UWSTRING_FIXED_BASE ) as integer

type UWSTRING_FIXED extends UWSTRING_FIXED_BASE

	public:
		declare constructor()
		declare constructor( byval rhs as const wstring const ptr )
		declare constructor( byval rhs as const zstring const ptr )

		declare operator cast() byref as const wstring
end type

type UWSTRING_FIXED_MUTABLE extends UWSTRING_FIXED_BASE

	public:
		declare constructor()
		declare constructor( byval rhs as const wstring const ptr )
		declare constructor( byval rhs as const zstring const ptr )

		declare operator cast() byref as wstring
end type
