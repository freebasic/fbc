#if __FB_LANG__ = "fb"
namespace FB
#endif

#if __FB_LANG__ = "qb"
	const as __byte _
		MIN_VALUE_BYTE     = -128, _
		MAX_VALUE_BYTE     = 127

	const as __short _
		MIN_VALUE_SHORT    = -32768, _
		MAX_VALUE_SHORT    = 32767

	const as __ubyte _
		MIN_VALUE_UBYTE    = 0, _
		MAX_VALUE_UBYTE    = 255

	const as __ushort _
		MIN_VALUE_USHORT   = 0, _
		MAX_VALUE_USHORT   = 65535

	const as long _
		MIN_VALUE_LONG    = -2147483648, _
		MAX_VALUE_LONG    = 2147483647

	const as __ulong _
		MIN_VALUE_ULONG    = 0, _
		MAX_VALUE_ULONG    = 4294967295

	const as __longint _
		MIN_VALUE_LONGINT  = -9223372036854775808, _
		MAX_VALUE_LONGINT  = 9223372036854775807

	const as __ulongint _
		MIN_VALUE_ULONGINT = 0, _
		MAX_VALUE_ULONGINT = 18446744073709551615

	const as integer _
		MIN_VALUE_INTEGER  = MIN_VALUE_SHORT, _
		MAX_VALUE_INTEGER  = MAX_VALUE_SHORT

	const as __uinteger _
		MIN_VALUE_UINTEGER = MIN_VALUE_USHORT, _
		MAX_VALUE_UINTEGER = MAX_VALUE_USHORT

#else
	const as byte _
		MIN_VALUE_BYTE     = -128, _
		MAX_VALUE_BYTE     = 127

	const as ubyte _
		MIN_VALUE_UBYTE    = 0, _
		MAX_VALUE_UBYTE    = 255

	const as short _
		MIN_VALUE_SHORT    = -32768, _
		MAX_VALUE_SHORT    = 32767

	const as ushort _
		MIN_VALUE_USHORT   = 0, _
		MAX_VALUE_USHORT   = 65535

	const as long _
		MIN_VALUE_LONG    = -2147483648, _
		MAX_VALUE_LONG    = 2147483647

	const as ulong _
		MIN_VALUE_ULONG    = 0, _
		MAX_VALUE_ULONG    = 4294967295

	const as longint _
		MIN_VALUE_LONGINT = -9223372036854775808, _
		MAX_VALUE_LONGINT = 9223372036854775807

	const as ulongint _
		MIN_VALUE_ULONGINT = 0, _
		MAX_VALUE_ULONGINT = 18446744073709551615

	#if sizeof(integer) = sizeof(longint)
		const as integer _
			MIN_VALUE_INTEGER  = MIN_VALUE_LONGINT, _
			MAX_VALUE_INTEGER  = MAX_VALUE_LONGINT

		const as uinteger _
			MIN_VALUE_UINTEGER = MIN_VALUE_ULONGINT, _
			MAX_VALUE_UINTEGER = MAX_VALUE_ULONGINT

	#elseif sizeof(integer) = sizeof(short)
		const as integer _
			MIN_VALUE_INTEGER  = MIN_VALUE_SHORT, _
			MAX_VALUE_INTEGER  = MAX_VALUE_SHORT

		const as uinteger _
			MIN_VALUE_UINTEGER = MIN_VALUE_USHORT, _
			MAX_VALUE_UINTEGER = MAX_VALUE_USHORT

	#else
		const as integer _
			MIN_VALUE_INTEGER  = MIN_VALUE_LONG, _
			MAX_VALUE_INTEGER  = MAX_VALUE_LONG

		const as uinteger _
			MIN_VALUE_UINTEGER = MIN_VALUE_ULONG, _
			MAX_VALUE_UINTEGER = MAX_VALUE_ULONG

	#endif

#endif

	const as single _
		MIN_VALUE_SINGLE = -3.402823466e+38, _
		MAX_VALUE_SINGLE = 3.402823466e+38

	const as double _
		MIN_VALUE_DOUBLE = -1.7976931348623157E+308#, _
		MAX_VALUE_DOUBLE = 1.7976931348623157E+308#

#if __FB_LANG__ = "fb"
end namespace
#endif
