'' intrinsic runtime lib string functions (MID, LEFT, STR, VAL, HEX, ...)
''
'' chng: oct/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' function fb_StrInit( byref dst as any, byval dst_len as const integer, _
				byref src as const any, byval src_len as const integer, _
				byval fillrem as const long = 1 ) as string '/ _
		( _
			@FB_RTL_STRINIT, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 1 ) _
			} _
		), _
		/' function fb_WstrAssignToA_Init( byref dst as any, byval dst_len as const integer, _
				byval src as const wstring ptr, byval fillrem as const integer ) as string '/ _
		( _
			@FB_RTL_WSTRASSIGNAW_INIT, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrAssign( byref dst as any, byval dst_len as const integer, _
				byref src as const any, byval src_len as const integer, _
				byval fillrem as const long = 1 ) as string '/ _
		( _
			@FB_RTL_STRASSIGN, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 1 ) _
			} _
		), _
		/' function fb_WstrAssign( byval dst as wstring ptr, byval dst_len as const integer, _
				byval src as const wstring ptr) as wstring ptr '/ _
		( _
			@FB_RTL_WSTRASSIGN, NULL, _
			typeAddrOf( FB_DATATYPE_WCHAR ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_WstrAssignFromA( byval dst as wstring ptr, byval dst_len as const integer, _
				byref src as const any, byval src_len as const integer ) as wstring ptr '/ _
		( _
			@FB_RTL_WSTRASSIGNWA, NULL, _
			typeAddrOf( FB_DATATYPE_WCHAR ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_WstrAssignToA( byref dst as any, byval dst_len as const integer, _
				byval src as const wstring ptr, byval fillrem as const long ) as string '/ _
		( _
			@FB_RTL_WSTRASSIGNAW, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_StrDelete( byref str as const string ) '/ _
		( _
			@FB_RTL_STRDELETE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_hStrDelTemp( byref str as const string ) as long '/ _
		( _
			@FB_RTL_HSTRDELTEMP, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_WstrDelete( byval str as const wstring ptr ) '/ _
		( _
			@FB_RTL_WSTRDELETE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrConcat( byref dst as string, _
				byref str1 as const any, byval str1_size as const integer, _
				byref str2 as const any, byval str2_size as const integer ) as string '/ _
		( _
			@FB_RTL_STRCONCAT, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrConcatByref(
				byref str1 as const any, byval str1_size as const integer, _
				byref str2 as const any, byval str2_size as const integer, _
				byval fillrem as const long = 1 ) as string '/ _
		( _
			@FB_RTL_STRCONCATBYREF, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 1 ) _
			} _
		), _
		/' function fb_WstrConcat( byval str1 as const wstring ptr, byval str2 as const wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRCONCAT, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_WstrConcatWA( byval str1 as const wstring ptr, _
				byref str2 as const any, byval str2_size as const integer ) as wstring '/ _
		( _
			@FB_RTL_WSTRCONCATWA, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_WstrConcatAW( byref str1 as const any, byval str1_size as const integer, _
				byval str2 as const wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRCONCATAW, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrCompare( byref str1 as const any, byval str1_size as const integer, _
				byref str2 as const any, byval str2_size as const integer ) as long '/ _
		( _
			@FB_RTL_STRCOMPARE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_WstrCompare( byval str1 as const wstring ptr, byval str2 as const wstring ptr ) as long '/ _
		( _
			@FB_RTL_WSTRCOMPARE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrConcatAssign( byref dst as any, byval dst_size as const integer, _
				byref src as const any, byval src_len as const integer, _
				byval fillrem as const long = 1 ) as string '/ _
		( _
			@FB_RTL_STRCONCATASSIGN, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 1 ) _
			} _
		), _
		/' function fb_WstrConcatAssign( byval dst as wstring ptr, byval dst_chars as const integer, _
				byval src as const wstring ptr ) as wstring ptr '/ _
		( _
			@FB_RTL_WSTRCONCATASSIGN, NULL, _
			typeAddrOf( FB_DATATYPE_WCHAR ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrAllocTempResult( byref str as const string ) as string '/ _
		( _
			@FB_RTL_STRALLOCTMPRES, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_StrAllocTempDescF( byref str as const any, byval str_size as const integer ) as string '/ _
		( _
			@FB_RTL_STRALLOCTMPDESCF, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrAllocTempDescZ( byval str as const zstring ptr ) as string '/ _
		( _
			@FB_RTL_STRALLOCTMPDESCZ, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrAllocTempDescZEx( byval str as const zstring ptr, byval len as const integer ) as string '/ _
		( _
			@FB_RTL_STRALLOCTMPDESCZEX, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_WstrAlloc( byval chars as const integer ) as wstring ptr '/ _
		( _
			@FB_RTL_WSTRALLOC, NULL, _
			typeAddrOf( FB_DATATYPE_WCHAR ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_BoolToStr( byval num as const boolean ) as string '/ _
		( _
			@FB_RTL_BOOL2STR, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_BOOLEAN ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_IntToStr( byval num as const long ) as string '/ _
		( _
			@FB_RTL_INT2STR, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_IntToStrQB( byval num as const long ) as string '/ _
		( _
			@FB_RTL_INT2STR_QB, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_BoolToWstr( byval num as const boolean ) as wstring '/ _
		( _
			@FB_RTL_BOOL2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_BOOLEAN ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_IntToWstr( byval num as const long ) as wstring '/ _
		( _
			@FB_RTL_INT2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_UIntToStr( byval num as const ulong ) as string '/ _
		( _
			@FB_RTL_UINT2STR, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_UIntToStrQB( byval num as const ulong ) as string '/ _
		( _
			@FB_RTL_UINT2STR_QB, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_UIntToWstr( byval num as const ulong ) as wstring '/ _
		( _
			@FB_RTL_UINT2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_LongintToStr( byval num as const longint ) as string '/ _
		( _
			@FB_RTL_LONGINT2STR, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_LongintToStrQB( byval num as const longint ) as string '/ _
		( _
			@FB_RTL_LONGINT2STR_QB, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_LongintToWstr( byval num as const longint ) as wstring '/ _
		( _
			@FB_RTL_LONGINT2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ULongintToStr( byval num as const ulongint ) as string '/ _
		( _
			@FB_RTL_ULONGINT2STR, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ULongintToStrQB( byval num as const ulongint ) as string '/ _
		( _
			@FB_RTL_ULONGINT2STR_QB, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ULongintToWstr( byval num as const ulongint ) as wstring '/ _
		( _
			@FB_RTL_ULONGINT2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_FloatToStr( byval num as const single ) as string '/ _
		( _
			@FB_RTL_FLT2STR, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_FloatToStrQB( byval num as const single ) as string '/ _
		( _
			@FB_RTL_FLT2STR_QB, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_FloatToWstr( byval num as const single ) as wstring '/ _
		( _
			@FB_RTL_FLT2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_DoubleToStr( byval num as const double ) as string '/ _
		( _
			@FB_RTL_DBL2STR, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_DOUBLE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_DoubleToStrQB( byval num as const double ) as string '/ _
		( _
			@FB_RTL_DBL2STR_QB, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_DOUBLE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_DoubleToWstr( byval num as const double ) as wstring '/ _
		( _
			@FB_RTL_DBL2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_DOUBLE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_WstrToStr( byval str as const wstring ptr ) as string '/ _
		( _
			@FB_RTL_WSTR2STR, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrToWstr( byval str as const zstring ptr ) as wstring '/ _
		( _
			@FB_RTL_STR2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrMid( byref str as const string, byval start as const integer, _
				byval len as const integer ) as string '/ _
		( _
			@FB_RTL_STRMID, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_WstrMid( byval str as const wstring ptr, byval start as const integer, _
				byval len as const integer ) as wstring '/ _
		( _
			@FB_RTL_WSTRMID, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_StrAssignMid( byref dst as string, byval start as const integer, _
				byval len as const integer, byref src as const string ) '/ _
		( _
			@FB_RTL_STRASSIGNMID, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_WstrAssignMid ( byval dst as wstring ptr, byval dst_len as const integer, _
				byval start as const integer, byval len as const integer, _
				byval src as const wstring ptr ) '/ _
		( _
			@FB_RTL_WSTRASSIGNMID, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrFill1( byval cnt as const integer, byval char as const long ) as string '/ _
		( _
			@FB_RTL_STRFILL1, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_WstrFill1( byval chars as const integer, byval c as const long ) as wstring '/ _
		( _
			@FB_RTL_WSTRFILL1, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' fb_StrFill2( byval cnt as const integer, byref src as const string ) as string '/ _
		( _
			@FB_RTL_STRFILL2, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_WstrFill2( byval cnt as const integer, byval src as const wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRFILL2, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrLen( byref str as const any, byval str_size as const integer ) as integer '/ _
		( _
			@FB_RTL_STRLEN, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_WstrLen( byval str as const wstring ptr ) as integer '/ _
		( _
			@FB_RTL_WSTRLEN, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_StrLset( byref dst as string, byref src as const string ) '/ _
		( _
			@FB_RTL_STRLSET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_WstrLset( byval dst as wstring ptr, byval src as const wstring ptr ) '/ _
		( _
			@FB_RTL_WSTRLSET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_StrRset overload( byref dst as string, byref src as const string ) '/ _
		( _
			@FB_RTL_STRRSET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			2, _
			{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_WstrRset( byval dst as wstring ptr, byval src as const wstring ptr ) '/ _
		( _
			@FB_RTL_WSTRRSET, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ASC( byref str as const string, byval pos as const integer = 0 ) as ulong '/ _
		( _
			@FB_RTL_STRASC, NULL, _
			FB_DATATYPE_ULONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_WstrAsc( byval str as const wstring ptr, byval pos as const integer = 0 ) as ulong '/ _
		( _
			@FB_RTL_WSTRASC, NULL, _
			FB_DATATYPE_ULONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_CHR cdecl( byval args as const long, ... ) as string '/ _
		( _
			@FB_RTL_STRCHR, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_INVALID, FB_PARAMMODE_VARARG, FALSE ) _
			} _
		), _
		/' function fb_WstrChr cdecl( byval args as const long, ... ) as wstring '/ _
		( _
			@FB_RTL_WSTRCHR, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_INVALID, FB_PARAMMODE_VARARG, FALSE ) _
			} _
		), _
		/' function fb_StrInstr( byval start as const integer, byref src as const string, _
				byref patt as const string ) as integer '/ _
		( _
			@FB_RTL_STRINSTR, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_WstrInstr( byval start as const integer, byval src as const wstring ptr, _
				byval patt as const wstring ptr ) as integer '/ _
		( _
			@FB_RTL_WSTRINSTR, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrInstrAny( byval start as const integer, byref src as const string, _
				byref pattern as const string ) as integer '/ _
		( _
			@FB_RTL_STRINSTRANY, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_WstrInstrAny( byval start as const integer, byval src as const wstring ptr, _
				byval pattern as const wstring ptr ) as integer '/ _
		( _
			@FB_RTL_WSTRINSTRANY, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrInstrRev( byref src as const string, byref patt as const string, _
				byval start as const integer ) as integer '/ _
		( _
			@FB_RTL_STRINSTRREV, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_WstrInstrRev( byval src as const wstring ptr, byval patt as const wstring ptr, _
				byval start as const integer ) as integer '/ _
		( _
			@FB_RTL_WSTRINSTRREV, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrInstrRevAny( byref src as const string, byref patt as const string, _
				byval start as const integer ) as integer '/ _
		( _
			@FB_RTL_STRINSTRREVANY, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_WstrInstrRevAny( byval src as const wstring ptr, byval patt as const wstring ptr, _
				byval start as const integer ) as integer '/ _
		( _
			@FB_RTL_WSTRINSTRREVANY, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_TRIM( byref str as const string ) as string '/ _
		( _
			@FB_RTL_STRTRIM, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_WstrTrim( byval str as const wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRTRIM, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_TrimAny( byref str as const string, byref pattern as const string ) as string '/ _
		( _
			@FB_RTL_STRTRIMANY, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_WstrTrimAny( byval str as const wstring ptr, byval pattern as const wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRTRIMANY, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_TrimEx( byref str as const string, byref pattern as const string ) as string '/ _
		( _
			@FB_RTL_STRTRIMEX, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_WstrTrimEx( byval str as const wstring ptr, byval pattern as const wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRTRIMEX, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_RTRIM( byref str as const string ) as string '/ _
		( _
			@FB_RTL_STRRTRIM, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_WstrRTrim( byval str as const wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRRTRIM, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_RTrimAny( byref str as const string, byref pattern as const string ) as string '/ _
		( _
			@FB_RTL_STRRTRIMANY, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_WstrRTrimAny( byval str as const wstring ptr, byval pattern as const wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRRTRIMANY, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_RTrimEx( byref str as const string, byref pattern as const string ) as string '/ _
		( _
			@FB_RTL_STRRTRIMEX, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_WstrRTrimEx( byval str as const wstring ptr, byval pattern as const wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRRTRIMEX, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_LTRIM( byref str as const string ) as string '/ _
		( _
			@FB_RTL_STRLTRIM, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_WstrLTrim( byval str as const wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRLTRIM, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_LTrimAny( byref str as const string, byref pattern as const string ) as string '/ _
		( _
			@FB_RTL_STRLTRIMANY, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_WstrLTrimAny( byval str as const wstring ptr, byval pattern as const wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRLTRIMANY, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_LTrimEx( byref str as const string, byref pattern as const string ) as string '/ _
		( _
			@FB_RTL_STRLTRIMEX, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_WstrLTrimEx( byval str as const wstring ptr, byval pattern as const wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRLTRIMEX, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_StrSwap( byref str1 as any, byval size1 as const integer, byval fillrem1 as const long, _
				   byref str2 as any, byval size2 as const integer, byval fillrem2 as const long ) '/ _
		( _
			@FB_RTL_STRSWAP, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_WstrSwap( byval str1 as wstring ptr, byval size1 as const integer, _
				    byval str2 as wstring ptr, byval size2 as const integer ) '/ _
		( _
			@FB_RTL_WSTRSWAP, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function val overload( byref str as const string ) as double '/ _
		( _
			@FB_RTL_STR2DBL, @"fb_VAL", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function val overload( byref str as const wstring ) as double '/ _
		( _
			@FB_RTL_STR2DBL, @"fb_WstrVal", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function valbool overload( byref str as const string ) as boolean '/ _
		( _
			@FB_RTL_STR2BOOL, NULL, _
			FB_DATATYPE_BOOLEAN, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function valbool overload( byref str as const wstring ) as boolean '/ _
		( _
			@FB_RTL_STR2BOOL, @"fb_WstrValBool", _
			FB_DATATYPE_BOOLEAN, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function valint overload( byref str as const string ) as long '/ _
		( _
			@FB_RTL_STR2INT, @"fb_VALINT", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function valint overload( byref str as const wstring ) as long '/ _
		( _
			@FB_RTL_STR2INT, @"fb_WstrValInt", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function valuint overload( byref str as const string ) as ulong '/ _
		( _
			@FB_RTL_STR2UINT, @"fb_VALUINT", _
			FB_DATATYPE_ULONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function valuint overload( byref str as const wstring ) as ulong '/ _
		( _
			@FB_RTL_STR2UINT, @"fb_WstrValUInt", _
			FB_DATATYPE_ULONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function vallng overload( byref str as const string ) as longint '/ _
		( _
			@FB_RTL_STR2LNG, @"fb_VALLNG", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function vallng overload( byref str as const wstring ) as longint '/ _
		( _
			@FB_RTL_STR2LNG, @"fb_WstrValLng", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function valulng overload( byref str as const string ) as ulongint '/ _
		( _
			@FB_RTL_STR2ULNG, @"fb_VALULNG", _
			FB_DATATYPE_ULONGINT, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function valulng overload( byref str as const wstring ) as ulongint '/ _
		( _
			@FB_RTL_STR2ULNG, @"fb_WstrValULng", _
			FB_DATATYPE_ULONGINT, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function hex overload( byval number as const ubyte ) as string '/ _
		( _
			@"hex", @"fb_HEX_b", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function hex overload( byval number as const ushort ) as string '/ _
		( _
			@"hex", @"fb_HEX_s", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function hex overload( byval number as const ulong ) as string '/ _
		( _
			@"hex", @"fb_HEX_i", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function hex overload( byval number as const ulongint ) as string '/ _
		( _
			@"hex", @"fb_HEX_l", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function hex overload( byval number as const any ptr ) as string '/ _
		( _
			@"hex", @"fb_HEX_p", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ) _
			} _
		), _
		/' function hex overload( byval number as const ubyte, byval digits as const long ) as string '/ _
		( _
			@"hex", @"fb_HEXEx_b", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function hex overload( byval number as const ushort, byval digits as const long ) as string '/ _
		( _
			@"hex", @"fb_HEXEx_s", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function hex overload( byval number as const ulong, byval digits as const long ) as string '/ _
		( _
			@"hex", @"fb_HEXEx_i", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function hex overload( byval number as const ulongint, byval digits as const long ) as string '/ _
		( _
			@"hex", @"fb_HEXEx_l", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function hex overload( byval number as const any ptr, byval digits as const long ) as string '/ _
		( _
			@"hex", @"fb_HEXEx_p", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function whex overload( byval number as const ubyte ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHex_b", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function whex overload( byval number as const ushort ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHex_s", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function whex overload( byval number as const ulong ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHex_i", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function whex overload( byval number as const ulongint ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHex_l", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function whex overload( byval number as const any ptr ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHex_p", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ) _
			} _
		), _
		/' function whex overload( byval number as const ubyte, byval digits as const long ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHexEx_b", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function whex overload( byval number as const ushort, byval digits as const long ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHexEx_s", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function whex overload( byval number as const ulong, byval digits as const long ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHexEx_i", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function whex overload( byval number as const ulongint, byval digits as const long ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHexEx_l", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function whex overload( byval number as const any ptr, byval digits as const long ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHexEx_p", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function oct overload( byval number as const ubyte ) as string '/ _
		( _
			@"oct", @"fb_OCT_b", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function oct overload( byval number as const ushort ) as string '/ _
		( _
			@"oct", @"fb_OCT_s", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function oct overload( byval number as const ulong ) as string '/ _
		( _
			@"oct", @"fb_OCT_i", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function oct overload( byval number as const ulongint ) as string '/ _
		( _
			@"oct", @"fb_OCT_l", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function oct overload( byval number as const any ptr ) as string '/ _
		( _
			@"oct", @"fb_OCT_p", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ) _
			} _
		), _
		/' function oct overload( byval number as const ubyte, byval digits as const long ) as string '/ _
		( _
			@"oct", @"fb_OCTEx_b", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function oct overload( byval number as const ushort, byval digits as const long ) as string '/ _
		( _
			@"oct", @"fb_OCTEx_s", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function oct overload( byval number as const ulong, byval digits as const long ) as string '/ _
		( _
			@"oct", @"fb_OCTEx_i", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function oct overload( byval number as const ulongint, byval digits as const long ) as string '/ _
		( _
			@"oct", @"fb_OCTEx_l", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function oct overload( byval number as const any ptr, byval digits as const long ) as string '/ _
		( _
			@"oct", @"fb_OCTEx_p", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function woct overload( byval number as const ubyte ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOct_b", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function woct overload( byval number as const ushort ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOct_s", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function woct overload( byval number as const ulong ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOct_i", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function woct overload( byval number as const ulongint ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOct_l", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function woct overload( byval number as const any ptr ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOct_p", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ) _
			} _
		), _
		/' function woct overload( byval number as const ubyte, byval digits as const long ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOctEx_b", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function woct overload( byval number as const ushort, byval digits as const long ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOctEx_s", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function woct overload( byval number as const ulong, byval digits as const long ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOctEx_i", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function woct overload( byval number as const ulongint, byval digits as const long ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOctEx_l", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function woct overload( byval number as const any ptr, byval digits as const long ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOctEx_p", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function bin overload( byval number as const ubyte ) as string '/ _
		( _
			@"bin", @"fb_BIN_b", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function bin overload( byval number as const ushort ) as string '/ _
		( _
			@"bin", @"fb_BIN_s", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function bin overload( byval number as const ulong ) as string '/ _
		( _
			@"bin", @"fb_BIN_i", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function bin overload( byval number as const ulongint ) as string '/ _
		( _
			@"bin", @"fb_BIN_l", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function bin overload( byval number as const any ptr ) as string '/ _
		( _
			@"bin", @"fb_BIN_p", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ) _
			} _
		), _
		/' function bin overload( byval number as const ubyte, byval digits as const long ) as string '/ _
		( _
			@"bin", @"fb_BINEx_b", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function bin overload( byval number as const ushort, byval digits as const long ) as string '/ _
		( _
			@"bin", @"fb_BINEx_s", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function bin overload( byval number as const ulong, byval digits as const long ) as string '/ _
		( _
			@"bin", @"fb_BINEx_i", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function bin overload( byval number as const ulongint, byval digits as const long ) as string '/ _
		( _
			@"bin", @"fb_BINEx_l", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function bin overload( byval number as const any ptr, byval digits as const long ) as string '/ _
		( _
			@"bin", @"fb_BINEx_p", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function wbin overload( byval number as const ubyte ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBin_b", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function wbin overload( byval number as const ushort ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBin_s", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function wbin overload( byval number as const ulong ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBin_i", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function wbin overload( byval number as const ulongint ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBin_l", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function wbin overload( byval number as const any ptr ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBin_p", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ) _
			} _
		), _
		/' function wbin overload( byval number as const ubyte, byval digits as const long ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBinEx_b", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_UBYTE ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function wbin overload( byval number as const ushort, byval digits as const long ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBinEx_s", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_USHORT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function wbin overload( byval number as const ulong, byval digits as const long ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBinEx_i", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function wbin overload( byval number as const ulongint, byval digits as const long ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBinEx_l", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_ULONGINT ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function wbin overload( byval number as const any ptr, byval digits as const long ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBinEx_p", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_MKD( byval number as const double ) as string '/ _
		( _
			@FB_RTL_MKD, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_DOUBLE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_MKS( byval number as const single ) as string '/ _
		( _
			@FB_RTL_MKS, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_MKSHORT( byval number as const short ) as string '/ _
		( _
			@FB_RTL_MKSHORT, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_SHORT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_MKI( byval number as const integer ) as string '/ _
		( _
			@FB_RTL_MKI, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_MKL( byval number as const long ) as string '/ _
		( _
			@FB_RTL_MKL, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_MKLONGINT( byval number as const longint ) as string '/ _
		( _
			@FB_RTL_MKLONGINT, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function left overload( byref str as const string, byval chars as const integer ) as string '/ _
		( _
			@"left", @"fb_LEFT", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function left overload( byref str as const wstring, byval chars as const integer ) as wstring '/ _
		( _
			@"left", @"fb_WstrLeft", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_leftself overload( byref str as string, byval chars as const integer )'/ _
		( _
			@"fb_LeftSelf", @"fb_LEFTSELF", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function right overload( byref str as const string, byval chars as const integer ) as string '/ _
		( _
			@"right", @"fb_RIGHT", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function right overload( byref str as const wstring, byval chars as const integer ) as wstring '/ _
		( _
			@"right", @"fb_WstrRight", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function space( byval chars as const integer ) as string '/ _
		( _
			@"space", @"fb_SPACE", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function wspace( byval chars as const integer ) as wstring '/ _
		( _
			@"wspace", @"fb_WstrSpace", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_StrLcase2( byref src as const string, byval mode as const long = 0 ) as string '/ _
		( _
			@FB_RTL_STRLCASE2, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_WstrLcase2( byref str as const wstring, byval mode as const long = 0 ) as wstring '/ _
		( _
			@FB_RTL_WSTRLCASE2, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_StrUcase2( byref src as const string, byval mode as const long = 0 ) as string '/ _
		( _
			@FB_RTL_STRUCASE2, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_WstrUcase2( byref str as const wstring, byval mode as const long = 0 ) as wstring '/ _
		( _
			@FB_RTL_WSTRUCASE2, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_CVD( byref str as const string ) as double '/ _
		( _
			@FB_RTL_CVD, @"fb_CVD", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_CVS( byref str as const string ) as single '/ _
		( _
			@FB_RTL_CVS, @"fb_CVS", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_CVSHORT( byref str as const string ) as short '/ _
		( _
			@FB_RTL_CVSHORT, @"fb_CVSHORT", _
			FB_DATATYPE_SHORT, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_CVL( byref str as const string ) as long '/ _
		( _
			@FB_RTL_CVL, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_CVLONGINT( byref str as const string ) as longint '/ _
		( _
			@FB_RTL_CVLONGINT, @"fb_CVLONGINT", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_CVDFROMLONGINT( byval num as const longint ) as double '/ _
		( _
			@FB_RTL_CVDFROMLONGINT, @"fb_CVDFROMLONGINT", _
			FB_DATATYPE_DOUBLE, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONGINT ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_CVSFROML( byref num as const long ) as single '/ _
		( _
			@FB_RTL_CVSFROML, @"fb_CVSFROML", _
			FB_DATATYPE_SINGLE, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_CVLFROMS( byval num as const single ) as long '/ _
		( _
			@FB_RTL_CVLFROMS, @"fb_CVLFROMS", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_SINGLE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_CVLONGINTFROMD( byval num as const double ) as longint '/ _
		( _
			@FB_RTL_CVLONGINTFROMD, @"fb_CVLONGINTFROMD", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_DOUBLE ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' EOL '/ _
		( _
			NULL _
		) _
	 }

'':::::
sub rtlStringModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlStringModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlStrCompare _
	( _
		byval str1 as ASTNODE ptr, _
		byval sdtype1 as integer, _
		byval str2 as ASTNODE ptr, _
		byval sdtype2 as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as longint str1len = any, str2len = any

	function = NULL

	''
	proc = astNewCALL( PROCLOOKUP( STRCOMPARE ) )

	'' always calc len before pushing the param
	str1len = rtlCalcStrLen( str1, sdtype1 )
	str2len = rtlCalcStrLen( str2, sdtype2 )

	'' byref str1 as any
	if( astNewARG( proc, str1, sdtype1 ) = NULL ) then
		exit function
	end if

	'' byval str1_len as integer
	if( astNewARG( proc, astNewCONSTi( str1len ) ) = NULL ) then
		exit function
	end if

	'' byref str2 as any
	if( astNewARG( proc, str2, sdtype2 ) = NULL ) then
		exit function
	end if

	'' byval str2_len as integer
	if( astNewARG( proc, astNewCONSTi( str2len ) ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlWstrCompare _
	( _
		byval str1 as ASTNODE ptr, _
		byval str2 as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	''
	proc = astNewCALL( PROCLOOKUP( WSTRCOMPARE ) )

	'' byval str1 as wstring ptr
	if( astNewARG( proc, str1 ) = NULL ) then
		exit function
	end if

	'' byval str2 as wstring ptr
	if( astNewARG( proc, str2 ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlStrConcat _
	( _
		byval str1 as ASTNODE ptr, _
		byval sdtype1 as integer, _
		byval str2 as ASTNODE ptr, _
		byval sdtype2 as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as longint str1len = any, str2len = any
	dim as FBSYMBOL ptr tmp = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( STRCONCAT ) )

	'' byref dst as string (must be cleaned up due the rtlib assumptions about destine)
	tmp = symbAddTempVar( FB_DATATYPE_STRING )

	if( astNewARG( proc, _
		astNewLINK( astBuildTempVarClear( tmp ), _
			astNewVAR( tmp ), _
			AST_LINK_RETURN_RIGHT ) ) = NULL ) then
		exit function
	end if

	'' always calc len before pushing the param
	str1len = rtlCalcStrLen( str1, sdtype1 )
	str2len = rtlCalcStrLen( str2, sdtype2 )

	'' byref str1 as any
	if( astNewARG( proc, str1, sdtype1 ) = NULL ) then
		exit function
	end if

	'' byval str1_len as integer
	if( astNewARG( proc, astNewCONSTi( str1len ) ) = NULL ) then
		exit function
	end if

	'' byref str2 as any
	if( astNewARG( proc, str2, sdtype2 ) = NULL ) then
		exit function
	end if

	'' byval str2_len as integer
	if( astNewARG( proc, astNewCONSTi( str2len ) ) = NULL ) then
		exit function
	end if

	function = proc
end function

'':::::
function rtlWstrConcatWA _
	( _
		byval str1 as ASTNODE ptr, _
		byval str2 as ASTNODE ptr, _
		byval sdtype2 as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as longint str2len = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( WSTRCONCATWA ) )

	'' byval str1 as wstring ptr
	if( astNewARG( proc, str1 ) = NULL ) then
		exit function
	end if

	'' always calc len before pushing the param
	str2len = rtlCalcStrLen( str2, sdtype2 )

	'' byref str2 as any
	if( astNewARG( proc, str2, sdtype2 ) = NULL ) then
		exit function
	end if

	'' byval str2_len as integer
	if( astNewARG( proc, astNewCONSTi( str2len ) ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlWstrConcatAW _
	( _
		byval str1 as ASTNODE ptr, _
		byval sdtype1 as integer, _
		byval str2 as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as longint str1len = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( WSTRCONCATAW ) )

	'' always calc len before pushing the param
	str1len = rtlCalcStrLen( str1, sdtype1 )

	'' byref str1 as any
	if( astNewARG( proc, str1, sdtype1 ) = NULL ) then
		exit function
	end if

	'' byval str1_len as integer
	if( astNewARG( proc, astNewCONSTi( str1len ) ) = NULL ) then
		exit function
	end if

	'' byval str2 as wstring ptr
	if( astNewARG( proc, str2 ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlWstrConcat _
	( _
		byval str1 as ASTNODE ptr, _
		byval sdtype1 as integer, _
		byval str2 as ASTNODE ptr, _
		byval sdtype2 as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	'' both not wstrings?
	if( typeGetDtAndPtrOnly( sdtype1 ) <> typeGetDtAndPtrOnly( sdtype2 ) ) then
		'' left ?
		if( typeGet( sdtype1 ) = FB_DATATYPE_WCHAR ) then
			return rtlWstrConcatWA( str1, str2, sdtype2 )

		'' right..
		else
			return rtlWstrConcatAW( str1, sdtype1, str2 )
		end if
	end if

	'' both wstrings..
	proc = astNewCALL( PROCLOOKUP( WSTRCONCAT ) )

	'' byval str1 as wstring ptr
	if( astNewARG( proc, str1 ) = NULL ) then
		exit function
	end if

	'' byval str2 as wstring ptr
	if( astNewARG( proc, str2 ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlStrConcatAssign _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr, _
		byval isConcatByref as integer = FALSE _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as integer ddtype = any, sdtype = any
	dim as longint lgt = any

	function = NULL

	if( isConcatByref ) then
		proc = astNewCALL( PROCLOOKUP( STRCONCATBYREF ) )
	else
		proc = astNewCALL( PROCLOOKUP( STRCONCATASSIGN ) )
	end if

	ddtype = astGetDataType( dst )

	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( dst, ddtype )

	'' dst as any
	if( astNewARG( proc, dst, ddtype ) = NULL ) then
		exit function
	end if

	'' byval dstlen as integer
	if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
		exit function
	end if

	'' always calc len before pushing the param
	sdtype = astGetDataType( src )
	lgt = rtlCalcStrLen( src, sdtype )

	'' src as any
	if( astNewARG( proc, src, sdtype ) = NULL ) then
		exit function
	end if

	'' byval srclen as integer
	if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
		exit function
	end if

	'' byval fillrem as integer
	if( astNewARG( proc, astNewCONSTi( ddtype = FB_DATATYPE_FIXSTR ) ) = NULL ) then
		exit function
	end if

	''
	function = proc

end function

'':::::
function rtlWstrConcatAssign _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr _
	) as ASTNODE ptr static

	dim as ASTNODE ptr proc
	dim as longint lgt = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( WSTRCONCATASSIGN ) )

	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( dst, FB_DATATYPE_WCHAR )

	'' byval dst as wstring ptr
	if( astNewARG( proc, dst ) = NULL ) then
		exit function
	end if

	'' byval dstlen as integer
	if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
		exit function
	end if

	'' byval src as wstring ptr
	if( astNewARG( proc, src ) = NULL ) then
		exit function
	end if

	''
	function = proc

end function

'':::::
function rtlWstrAssignWA _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr, _
		byval sdtype as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as longint dstlen = any, srclen = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( WSTRASSIGNWA ) )

	'' always calc len before pushing the param
	dstlen = rtlCalcStrLen( dst, FB_DATATYPE_WCHAR )
	srclen = rtlCalcStrLen( src, sdtype )

	'' byval dst as wstring ptr
	if( astNewARG( proc, dst ) = NULL ) then
		exit function
	end if

	'' byval dstlen as integer
	if( astNewARG( proc, astNewCONSTi( dstlen ) ) = NULL ) then
		exit function
	end if

	'' byref src as any
	if( astNewARG( proc, src ) = NULL ) then
		exit function
	end if

	'' byval srclen as integer
	if( astNewARG( proc, astNewCONSTi( srclen ) ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlWstrAssignAW _
	( _
		byval dst as ASTNODE ptr, _
		byval ddtype as integer, _
		byval src as ASTNODE ptr, _
		byval is_ini as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as longint lgt = any

	function = NULL

	proc = astNewCALL( iif( is_ini, _
				PROCLOOKUP( WSTRASSIGNAW_INIT ), _
				PROCLOOKUP(  WSTRASSIGNAW ) ) )

	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( dst, ddtype )

	'' byref dst as any
	if( astNewARG( proc, dst ) = NULL ) then
		exit function
	end if

	'' byval dstlen as integer
	if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
		exit function
	end if

	'' byval src as wstring ptr
	if( astNewARG( proc, src ) = NULL ) then
		exit function
	end if

	'' byval fillrem as integer
	if( astNewARG( proc, astNewCONSTi( ddtype = FB_DATATYPE_FIXSTR ) ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlStrAssign _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr, _
		byval is_ini as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as integer ddtype = any, sdtype = any
	dim as longint lgt = any

	function = NULL

	ddtype = astGetDataType( dst )
	sdtype = astGetDataType( src )

	'' wstring source?
	if( sdtype = FB_DATATYPE_WCHAR ) then
		return rtlWstrAssignAW( dst, ddtype, src, is_ini )

	'' destine?
	elseif( ddtype = FB_DATATYPE_WCHAR ) then
		return rtlWstrAssignWA( dst, src, sdtype )
	end if

	'' both strings
	proc = astNewCALL( iif( is_ini, _
				PROCLOOKUP( STRINIT ), _
				PROCLOOKUP( STRASSIGN ) ) )

	'' always calc len before pushing the param

	lgt = rtlCalcStrLen( dst, ddtype )

	'' dst as any
	if( astNewARG( proc, dst, astGetDataType( dst ) ) = NULL ) then
		exit function
	end if

	'' byval dstlen as integer
	if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
		exit function
	end if

	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( src, sdtype )

	'' src as const any
	if( astNewARG( proc, src ) = NULL ) then
		exit function
	end if

	'' byval srclen as integer
	if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
		exit function
	end if

	'' byval fillrem as integer
	if( astNewARG( proc, astNewCONSTi( ddtype = FB_DATATYPE_FIXSTR ) ) = NULL ) then
		exit function
	end if

	'' always discard result, even though actual rtlib returns a ptr to destination
	'' it will never be used anywhere
	astSetType( proc, FB_DATATYPE_VOID, NULL )

	function = proc

end function

'':::::
function rtlWstrAssign _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr, _
		byval is_ini as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as integer ddtype = any, sdtype = any
	dim as longint lgt = any

	function = NULL

	ddtype = astGetDataType( dst )
	sdtype = astGetDataType( src )

	'' both not wstrings?
	if( ddtype <> sdtype ) then
		'' left ?
		if( ddtype = FB_DATATYPE_WCHAR ) then
			return rtlWstrAssignWA( dst, src, sdtype )
		'' right..
		else
			return rtlWstrAssignAW( dst, ddtype, src, is_ini )
		end if
	end if

	'' both wstrings..
	proc = astNewCALL( PROCLOOKUP( WSTRASSIGN ) )

	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( dst, ddtype )

	'' byval dst as wstring ptr
	if( astNewARG( proc, dst ) = NULL ) then
		exit function
	end if

	'' byval dstlen as integer
	if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
		exit function
	end if

	'' byval src as wstring ptr
	if( astNewARG( proc, src ) = NULL ) then
		exit function
	end if

	function = proc

end function

function rtlStrDelete( byval expr as ASTNODE ptr ) as ASTNODE ptr
	dim as FBSYMBOL ptr proc = any
	dim as ASTNODE ptr call_ = any
	dim as integer dtype = any

	function = NULL

	dtype = astGetDataType( expr )

	'' Handling WCHAR PTR because that's what we use for fake dynamic
	'' wstrings, and it's also the real type of functions returning dynamic
	'' wstrings. All wstring types should have been remapped to WCHAR PTR.
	assert( dtype <> FB_DATATYPE_WCHAR )
	if( dtype = typeAddrOf( FB_DATATYPE_WCHAR ) ) then
		proc = PROCLOOKUP( WSTRDELETE )
	else
		assert( dtype = FB_DATATYPE_STRING )
		if( astIsCALL( expr ) ) then
			'' Temporary string function result
			proc = PROCLOOKUP( HSTRDELTEMP )
		else
			'' Normal string variable
			proc = PROCLOOKUP( STRDELETE )
		end if
	end if

	call_ = astNewCALL( proc )

	'' byref str as string|wstring
	if( astNewARG( call_, expr, dtype ) = NULL ) then
		exit function
	end if

	function = call_
end function

'':::::
function rtlStrAllocTmpResult _
	( _
		byval strg as ASTNODE ptr _
	) as ASTNODE ptr static

	dim as ASTNODE ptr proc

	function = NULL

	''
	proc = astNewCALL( PROCLOOKUP( STRALLOCTMPRES ), NULL )

	'' src as string
	if( astNewARG( proc, strg, FB_DATATYPE_STRING ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlStrAllocTmpDesc _
	( _
		byval strexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as integer dtype = any
	dim as longint lgt = any
	dim as FBSYMBOL ptr litsym = any

	function = NULL

	''
	dtype = astGetDataType( strexpr )

	select case as const dtype
	case FB_DATATYPE_CHAR

		'' literal?
		litsym = astGetStrLitSymbol( strexpr )
		if( litsym = NULL ) then
			proc = astNewCALL( PROCLOOKUP( STRALLOCTMPDESCZ ) )
		else
			proc = astNewCALL( PROCLOOKUP( STRALLOCTMPDESCZEX ) )
		end if

		'' byval str as zstring ptr
		if( astNewARG( proc, strexpr ) = NULL ) then
			exit function
		end if

		'' length is known at compile-time
		if( litsym <> NULL ) then
			lgt = symbGetStrLen( litsym ) - 1   '' less the null-term

			'' byval len as integer
			if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
				exit function
			end if
		end if

	case FB_DATATYPE_FIXSTR
		proc = astNewCALL( PROCLOOKUP( STRALLOCTMPDESCF ) )

		'' always calc len before pushing the param
		lgt = rtlCalcStrLen( strexpr, dtype )

		'' str as any
		if( astNewARG( proc, strexpr ) = NULL ) then
			exit function
		end if

		'' byval strlen as integer
		if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
			exit function
		end if

	end select

	''
	function = proc

end function

'':::::
function rtlWstrAlloc _
	( _
		byval lenexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( WSTRALLOC ) )

	'' byval len as integer
	if( astNewARG( proc, lenexpr ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlWstrToA _
	( _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( WSTR2STR ) )

	'' byval str as wstring ptr
	if( astNewARG( proc, expr ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlAToWstr _
	( _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( STR2WSTR ) )

	'' byval str as zstring ptr
	if( astNewARG( proc, expr ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlToStr _
	( _
		byval expr as ASTNODE ptr, _
		byval pad as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any, litsym = any
	dim as integer dtype = any

	function = NULL

	dtype = astGetDatatype( expr )

	'' constant? evaluate
	if( astIsCONST( expr ) ) then
		dim s As String
		if( astGetDataType( expr ) = FB_DATATYPE_BOOLEAN ) then

		else
			if( pad ) then
				if( typeIsSigned( astGetDataType( expr ) ) ) then
					if astConstGetAsDouble( expr ) >= 0 then
						s = " "
					end if
				else
					s = " "
				end if
			end if
		end if
		s += astConstFlushToStr( expr )
		return astNewCONSTstr( s )
	end if

	'' wstring literal? convert from unicode at compile-time
	if( dtype = FB_DATATYPE_WCHAR ) then
		litsym = astGetStrLitSymbol( expr )
		if( litsym <> NULL ) then
			if( env.wchar_doconv ) then
				litsym = symbAllocStrConst( str( *symbGetVarLitTextW( litsym ) ), _
											symbGetWstrLen( litsym ) - 1 )

				return astNewVAR( litsym )
			end if
		end if
	end if

	astTryOvlStringCONV( expr )

	dtype = astGetDataType( expr )

	''
	select case as const astGetDataClass( expr )
	case FB_DATACLASS_INTEGER

		'' Convert pointer to uinteger
		if( typeIsPtr( dtype ) ) then
			expr = astNewCONV( FB_DATATYPE_UINT, NULL, expr )
			dtype = astGetDatatype( expr )
		end if

		select case( dtype )
		'' zstring? do nothing
		case FB_DATATYPE_CHAR
			return expr
		'' wstring? convert..
		case FB_DATATYPE_WCHAR
			return rtlWStrToA( expr )
		'' boolean?
		case FB_DATATYPE_BOOLEAN
			f = PROCLOOKUP( BOOL2STR )
		case else
			select case as const( typeGetSizeType( dtype ) )
			case FB_SIZETYPE_INT64
				f = iif( pad = FALSE, PROCLOOKUP( LONGINT2STR ), PROCLOOKUP( LONGINT2STR_QB ) )
			case FB_SIZETYPE_UINT64
				f = iif( pad = FALSE, PROCLOOKUP( ULONGINT2STR ), PROCLOOKUP( ULONGINT2STR_QB ) )
			case FB_SIZETYPE_UINT8, FB_SIZETYPE_UINT16, FB_SIZETYPE_UINT32
				f = iif( pad = FALSE, PROCLOOKUP( UINT2STR ), PROCLOOKUP( UINT2STR_QB ) )
			case else
				f = iif( pad = FALSE, PROCLOOKUP( INT2STR ), PROCLOOKUP( INT2STR_QB ) )
			end select
		end select

	case FB_DATACLASS_FPOINT
		if( astGetDataType( expr ) = FB_DATATYPE_SINGLE ) then
			f = iif( pad = FALSE, _
			         PROCLOOKUP( FLT2STR ), _
			         PROCLOOKUP( FLT2STR_QB ) )
		else
			f = iif( pad = FALSE, _
			         PROCLOOKUP( DBL2STR ), _
			         PROCLOOKUP( DBL2STR_QB ) )
		end if

	case FB_DATACLASS_STRING
		'' do nothing
		return expr

	'' UDT's, classes: try cast(string) op overloading
	case FB_DATACLASS_UDT
		return astNewCONV( FB_DATATYPE_STRING, NULL, expr )

	'' anything else, can't convert
	case else
		return NULL
	end select

	''
	proc = astNewCALL( f )

	''
	if( astNewARG( proc, expr ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlToWstr _
	( _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any, litsym = any
	dim as integer dtype

	function = NULL

	dtype = astGetDataType( expr )

	'' constant? evaluate
	if( astIsCONST( expr ) ) then
		return astNewCONSTwstr( astConstFlushToWstr( expr ) )
	end if

	'' string literal? convert to unicode at compile-time
	if( dtype = FB_DATATYPE_CHAR ) then
		litsym = astGetStrLitSymbol( expr )
		if( litsym <> NULL ) then
			if( env.wchar_doconv ) then
				litsym = symbAllocWstrConst( wstr( *symbGetVarLitText( litsym ) ), _
										     symbGetStrLen( litsym ) - 1 )
				return astNewVAR( litsym )
			end if
		end if
	end if

	astTryOvlStringCONV( expr )

	dtype = astGetDataType( expr )

	select case as const astGetDataClass( expr )
	case FB_DATACLASS_INTEGER
		'' Convert pointer to uinteger
		if( typeIsPtr( dtype ) ) then
			expr = astNewCONV( FB_DATATYPE_UINT, NULL, expr )
			dtype = astGetDatatype( expr )
		end if

		select case( dtype )
		'' wstring? do nothing
		case FB_DATATYPE_WCHAR
			return expr
		'' zstring? convert..
		case FB_DATATYPE_CHAR
			return rtlAToWstr( expr )
		'' boolean?
		case FB_DATATYPE_BOOLEAN
			f = PROCLOOKUP( BOOL2WSTR )
		case else
			select case as const( typeGetSizeType( dtype ) )
			case FB_SIZETYPE_INT64
				f = PROCLOOKUP( LONGINT2WSTR )
			case FB_SIZETYPE_UINT64
				f = PROCLOOKUP( ULONGINT2WSTR )
			case FB_SIZETYPE_UINT8, FB_SIZETYPE_UINT16, FB_SIZETYPE_UINT32
				f = PROCLOOKUP( UINT2WSTR )
			case else
				f = PROCLOOKUP( INT2WSTR )
			end select
		end select
	case FB_DATACLASS_FPOINT
		if( astGetDataType( expr ) = FB_DATATYPE_SINGLE ) then
			f = PROCLOOKUP( FLT2WSTR )
		else
			f = PROCLOOKUP( DBL2WSTR )
		end if

	case FB_DATACLASS_STRING
		'' convert
		return rtlAToWstr( expr )

	'' UDT's, classes: try cast(wstring ptr) op overloading
	case FB_DATACLASS_UDT
		return astNewCONV( typeAddrOf( FB_DATATYPE_WCHAR ), NULL, expr )

	'' anything else: can't convert
	case else
		return NULL
	end select

	''
	proc = astNewCALL( f )

	''
	if( astNewARG( proc, expr ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlStrToVal _
	( _
		byval expr as ASTNODE ptr, _
		byval to_dtype as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any, s = any
	dim as FB_CALL_ARG arg = any
	dim as FB_ERRMSG err_num = any

	function = NULL

	'' Convert pointer to uinteger
	if( typeIsPtr( to_dtype ) ) then
		expr = astNewCONV( FB_DATATYPE_UINT, NULL, expr )
	end if

	select case as const typeGet( to_dtype )
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		f = PROCLOOKUP( STR2DBL )

	case FB_DATATYPE_BOOLEAN
		f = PROCLOOKUP( STR2BOOL )

	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE, _
	     FB_DATATYPE_SHORT, FB_DATATYPE_USHORT, _
	     FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM, FB_DATATYPE_UINT, _
	     FB_DATATYPE_LONG, FB_DATATYPE_ULONG, FB_DATATYPE_POINTER, _
	     FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT

		select case as const( typeGetSizeType( to_dtype ) )
		case FB_SIZETYPE_INT64
			f = PROCLOOKUP( STR2LNG )
		case FB_SIZETYPE_UINT64
			f = PROCLOOKUP( STR2ULNG )
		case FB_SIZETYPE_INT8, FB_SIZETYPE_INT16, FB_SIZETYPE_INT32
			f = PROCLOOKUP( STR2INT )
		case FB_SIZETYPE_UINT8, FB_SIZETYPE_UINT16, FB_SIZETYPE_UINT32
			f = PROCLOOKUP( STR2UINT )
		end select

	'' UDT's, classes: try cast(to_dtype) op overloading
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		return astNewCONV( to_dtype, NULL, expr )

	case else
		'' anything else..
		exit function
	end select

	'' resolve zstring or wstring
	arg.expr = expr
	arg.mode = INVALID
	arg.next = NULL
	f = symbFindClosestOvlProc( f, 1, @arg, @err_num )
	if( f = NULL ) then
		exit function
	end if

	proc = astNewCALL( f )

	''
	if( astNewARG( proc, expr ) = NULL ) then
		exit function
	end if

	function = astNewCONV( to_dtype, NULL, proc )

end function

'':::::
function rtlStrMid _
	( _
		byval expr1 as ASTNODE ptr, _
		byval expr2 as ASTNODE ptr, _
		byval expr3 as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	astTryOvlStringCONV( expr1 )

	if( astGetDataType( expr1 ) <> FB_DATATYPE_WCHAR ) then
		proc = astNewCALL( PROCLOOKUP( STRMID ) )
	else
		proc = astNewCALL( PROCLOOKUP( WSTRMID ) )
	end if

	''
	if( astNewARG( proc, expr1 ) = NULL ) then
		exit function
	end if

	if( astNewARG( proc, expr2 ) = NULL ) then
		exit function
	end if

	if( astNewARG( proc, expr3 ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlStrAssignMid _
	( _
		byval expr1 as ASTNODE ptr, _
		byval expr2 as ASTNODE ptr, _
		byval expr3 as ASTNODE ptr, _
		byval expr4 as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as longint dst_len = any

	function = NULL

	astTryOvlStringCONV( expr1 )

	''
	if( astGetDataType( expr1 ) <> FB_DATATYPE_WCHAR ) then
		proc = astNewCALL( PROCLOOKUP( STRASSIGNMID ) )
		dst_len = -1
	else
		proc = astNewCALL( PROCLOOKUP( WSTRASSIGNMID ) )
		'' always calc len before pushing the param
		dst_len = rtlCalcStrLen( expr1, FB_DATATYPE_WCHAR )
	end if

	''
	if( astNewARG( proc, expr1 ) = NULL ) then
		exit function
	end if

	''
	if( dst_len <> -1 ) then
		if( astNewARG( proc, astNewCONSTi( dst_len ) ) = NULL ) then
			exit function
		end if
	end if

	if( astNewARG( proc, expr2 ) = NULL ) then
		exit function
	end if

	if( astNewARG( proc, expr3 ) = NULL ) then
		exit function
	end if

	if( astNewARG( proc, expr4 ) = NULL ) then
		exit function
	end if

	''
	astAdd( proc )

	function = proc

end function

'':::::
function rtlStrLRSet _
	( _
		byval dstexpr as ASTNODE ptr, _
		byval srcexpr as ASTNODE ptr, _
		byval is_rset as integer _
	) as integer

	dim as ASTNODE ptr proc = any

	function = FALSE

	''
	if( astGetDataType( dstexpr ) <> FB_DATATYPE_WCHAR ) then
		proc = astNewCALL( iif( is_rset, _
		                        PROCLOOKUP( STRRSET ), _
		                        PROCLOOKUP( STRLSET ) ) )
	else
		proc = astNewCALL( iif( is_rset, _
		                        PROCLOOKUP( WSTRRSET ), _
		                        PROCLOOKUP( WSTRLSET ) ) )
	end if

	'' dst as string
	if( astNewARG( proc, dstexpr ) = NULL ) then
		exit function
	end if

	'' src as string
	if( astNewARG( proc, srcexpr ) = NULL ) then
		exit function
	end if

	''
	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlStrFill _
	( _
		byval expr1 as ASTNODE ptr, _
		byval expr2 as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any

	function = NULL

	select case astGetDataType( expr2 )
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		f = PROCLOOKUP( STRFILL2 )
	case else
		f = PROCLOOKUP( STRFILL1 )
	end select

	proc = astNewCALL( f )

	''
	if( astNewARG( proc, expr1 ) = NULL ) then
		exit function
	end if

	if( astNewARG( proc, expr2 ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlWstrFill _
	( _
		byval expr1 as ASTNODE ptr, _
		byval expr2 as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any

	function = NULL

	if( astGetDataType( expr2 ) = FB_DATATYPE_WCHAR ) then
		f = PROCLOOKUP( WSTRFILL2 )
	else
		f = PROCLOOKUP( WSTRFILL1 )
	end if

	proc = astNewCALL( f )

	''
	if( astNewARG( proc, expr1 ) = NULL ) then
		exit function
	end if

	if( astNewARG( proc, expr2 ) = NULL ) then
		exit function
	end if

	function = proc

end function

function rtlStrLen( byval expr as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr proc = any
	dim as longint length = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( STRLEN ) )

	'' always calc len before pushing the param
	length = rtlCalcStrLen( expr, astGetDataType( expr ) )

	'' str as any
	if( astNewARG( proc, expr, FB_DATATYPE_STRING ) = NULL ) then
		exit function
	end if

	'' byval strlen as integer
	if( astNewARG( proc, astNewCONSTi( length ) ) = NULL ) then
		exit function
	end if

	function = proc
end function

function rtlWstrLen( byval expr as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr proc = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( WSTRLEN ) )

	'' byval str as wchar ptr
	if( astNewARG( proc, expr ) = NULL ) then
		exit function
	end if

	function = proc
end function

'':::::
function rtlStrAsc _
	( _
		byval expr as ASTNODE ptr, _
		byval posexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	astTryOvlStringCONV( expr )

	''
	if( astGetDataType( expr ) <> FB_DATATYPE_WCHAR ) then
		proc = astNewCALL( PROCLOOKUP( STRASC ) )
	else
		proc = astNewCALL( PROCLOOKUP( WSTRASC ) )
	end if

	'' src as string
	if( astNewARG( proc, expr ) = NULL ) then
		exit function
	end if

	'' byval pos as integer
	if( posexpr = NULL ) then
		posexpr = astNewCONSTi( 1 )
	end if

	if( astNewARG( proc, posexpr ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlStrChr _
	( _
		byval args as integer, _
		exprtb() as ASTNODE ptr, _
		byval is_wstr as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any, expr = any
	dim as integer dtype = any

	function = NULL

	if( is_wstr = FALSE ) then
		proc = astNewCALL( PROCLOOKUP( STRCHR ) )
	else
		proc = astNewCALL( PROCLOOKUP( WSTRCHR ) )
	end if

	'' byval args as integer
	if( astNewARG( proc, astNewCONSTi( args ) ) = NULL ) then
		exit function
	end if

	'' ...
	for i as integer = 0 to args-1
		expr = exprtb(i)
		dtype = astGetDatatype( expr )

		'' check if non-numeric
		if( astGetDataClass( expr ) >= FB_DATACLASS_STRING ) then
			errReportEx( FB_ERRMSG_PARAMTYPEMISMATCHAT, "at parameter: " + str( i+1 ) )
			exit function
		end if

		'' don't allow w|zstring's either..
		select case as const dtype
		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			errReportEx( FB_ERRMSG_PARAMTYPEMISMATCHAT, "at parameter: " + str( i+1 ) )
			exit function

		case FB_DATATYPE_INTEGER

		'' convert to int as chr() is a varargs function
		case else
			expr = astNewCONV( FB_DATATYPE_INTEGER, NULL, expr )
		end select

		if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
			exit function
		end if
	next

	function = proc

end function

'':::::
function rtlStrInstr _
	( _
		byval nd_start as ASTNODE ptr, _
		byval nd_text as ASTNODE ptr, _
		byval nd_pattern as ASTNODE ptr, _
		byval search_any as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any
	dim as integer dtype = any

	function = NULL

	astTryOvlStringCONV( nd_text )
	if( nd_pattern ) then
		astTryOvlStringCONV( nd_pattern )
	end if

	dtype = astGetDataType( nd_text )

	''
	if( search_any ) then
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRINSTRANY )
		else
			f = PROCLOOKUP( WSTRINSTRANY )
		end if
	else
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRINSTR )
		else
			f = PROCLOOKUP( WSTRINSTR )
		end if
	end if

	proc = astNewCALL( f )

	''
	if( astNewARG( proc, nd_start ) = NULL ) then
		exit function
	end if

	if( astNewARG( proc, nd_text ) = NULL ) then
		exit function
	end if

	if( astNewARG( proc, nd_pattern ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlStrInstrRev _
	( _
		byval nd_start as ASTNODE ptr, _
		byval nd_text as ASTNODE ptr, _
		byval nd_pattern as ASTNODE ptr, _
		byval search_any as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any
	dim as integer dtype = any

	function = NULL

	astTryOvlStringCONV( nd_text )
	if( nd_pattern ) then
		astTryOvlStringCONV( nd_pattern )
	end if

	dtype = astGetDataType( nd_text )

	''
	if( search_any ) then
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRINSTRREVANY )
		else
			f = PROCLOOKUP( WSTRINSTRREVANY )
		end if
	else
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRINSTRREV )
		else
			f = PROCLOOKUP( WSTRINSTRREV )
		end if
	end if

	proc = astNewCALL( f )

	if( astNewARG( proc, nd_text ) = NULL ) then
		exit function
	end if

	if( astNewARG( proc, nd_pattern ) = NULL ) then
		exit function
	end if

	''
	if( astNewARG( proc, nd_start ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlStrTrim _
	( _
		byval nd_text as ASTNODE ptr, _
		byval nd_pattern as ASTNODE ptr, _
		byval is_any as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any
	dim as integer dtype = any

	function = NULL

	astTryOvlStringCONV( nd_text )
	if( nd_pattern ) then
		astTryOvlStringCONV( nd_pattern )
	end if

	dtype = astGetDataType( nd_text )

	''
	if( is_any ) then
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRTRIMANY )
		else
			f = PROCLOOKUP( WSTRTRIMANY )
		end if
	elseif( nd_pattern <> NULL ) then
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRTRIMEX )
		else
			f = PROCLOOKUP( WSTRTRIMEX )
		end if
	else
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRTRIM )
		else
			f = PROCLOOKUP( WSTRTRIM )
		end if
	end if
	proc = astNewCALL( f )

	''
	if( astNewARG( proc, nd_text ) = NULL ) then
		exit function
	end if

	if( nd_pattern<>NULL or is_any ) then
		if( astNewARG( proc, nd_pattern ) = NULL ) then
			exit function
		end if
	end if

	function = proc

end function

'':::::
function rtlStrRTrim _
	( _
		byval nd_text as ASTNODE ptr, _
		byval nd_pattern as ASTNODE ptr, _
		byval is_any as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any
	dim as integer dtype = any

	function = NULL

	astTryOvlStringCONV( nd_text )
	if( nd_pattern ) then
		astTryOvlStringCONV( nd_pattern )
	end if

	dtype = astGetDataType( nd_text )

	''
	if( is_any ) then
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRRTRIMANY )
		else
			f = PROCLOOKUP( WSTRRTRIMANY )
		end if
	elseif( nd_pattern <> NULL ) then
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRRTRIMEX )
		else
			f = PROCLOOKUP( WSTRRTRIMEX )
		end if
	else
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRRTRIM )
		else
			f = PROCLOOKUP( WSTRRTRIM )
		end if
	end if
	proc = astNewCALL( f )

	''
	if( astNewARG( proc, nd_text ) = NULL ) then
		exit function
	end if

	if( nd_pattern<>NULL or is_any ) then
		if( astNewARG( proc, nd_pattern ) = NULL ) then
			exit function
		end if
	end if

	function = proc

end function

'':::::
function rtlStrLTrim _
	( _
		byval nd_text as ASTNODE ptr, _
		byval nd_pattern as ASTNODE ptr, _
		byval is_any as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any
	dim as integer dtype = any

	function = NULL

	astTryOvlStringCONV( nd_text )
	if( nd_pattern ) then
		astTryOvlStringCONV( nd_pattern )
	end if

	dtype = astGetDataType( nd_text )

	''
	if( is_any ) then
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRLTRIMANY )
		else
			f = PROCLOOKUP( WSTRLTRIMANY )
		end if
	elseif( nd_pattern <> NULL ) then
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRLTRIMEX )
		else
			f = PROCLOOKUP( WSTRLTRIMEX )
		end if
	else
		if( dtype <> FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( STRLTRIM )
		else
			f = PROCLOOKUP( WSTRLTRIM )
		end if
	end if
	proc = astNewCALL( f )

	''
	if( astNewARG( proc, nd_text ) = NULL ) then
		exit function
	end if

	if( nd_pattern<>NULL or is_any ) then
		if( astNewARG( proc, nd_pattern ) = NULL ) then
			exit function
		end if
	end if

	function = proc

end function

'' Takes the text from a string literal symbol and performs ASCII-only
'' Lcase/Ucase on it. The result is a new literal symbol holding the
'' lcased/ucased text.
private function hEvalAscCase _
	( _
		byval literal as FBSYMBOL ptr, _
		byval is_lcase as integer _
	) as FBSYMBOL ptr

	dim as wstring ptr w = any
	dim as zstring ptr z = any
	dim as integer reallength = any, internallength = any
	dim as integer char = any, chara = any, charz = any, chardiff = any

	function = NULL

	'' Convert to lower case?
	if( is_lcase ) then
		chara = asc( "A" )
		charz = asc( "Z" )
		chardiff = asc( "a" ) - asc( "A" )
	else
		chara = asc( "a" )
		charz = asc( "z" )
		chardiff = cint( asc( "A" ) ) - cint( asc( "a" ) )
	end if

	if( symbGetType( literal ) = FB_DATATYPE_WCHAR ) then
		w = symbGetVarLitTextW( literal )
		internallength = len( *w )
		w = hUnescapeW( w )
		reallength = symbGetWstrLen( literal ) - 1

		if( internallength <> reallength ) then
			exit function
		end if

		for i as integer = 0 to reallength - 1
			char = (*w)[i]
			if( (char >= chara) and (char <= charz) ) then
				char += chardiff
			end if
			(*w)[i] = char
		next

		function = symbAllocWstrConst( w, reallength )
	else
		z = symbGetVarLitText( literal )
		internallength = len( *z )
		z = hUnescape( z )
		reallength = symbGetStrLen( literal ) - 1

		'' Don't do it if it includes internal escape sequences,
		'' handling these here would be quite hard... (TODO)
		'' On one hand we should handle "A" disguised as !"\&h41" which
		'' internally is something involving FB_INTSCAPECHAR; on the
		'' other hand to do that we'd have to solve the internal escape
		'' sequences, do the lcase/ucase, and then re-create internal
		'' escape sequences where needed.
		if( internallength <> reallength ) then
			exit function
		end if

		for i as integer = 0 to reallength - 1
			char = (*z)[i]
			if( (char >= chara) and (char <= charz) ) then
				char += chardiff
			end if
			(*z)[i] = char
		next

		function = symbAllocStrConst( z, reallength )
	end if
end function

function rtlStrCase _
	( _
		byval expr as ASTNODE ptr, _
		byval mode as ASTNODE ptr, _
		byval is_lcase as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any, literal = any

	'' Evalute ASCII-only Lcase/Ucase at compile-time if possible.

	'' Mode given?
	if( mode ) then
		'' Constant string?
		literal = astGetStrLitSymbol( expr )
		if( literal ) then
			'' Constant mode?
			if( astIsCONST( mode ) ) then
				'' ASCII-only mode (1)?
				if( astConstGetAsInt64( mode ) = 1 ) then
					literal = hEvalAscCase( literal, is_lcase )
					if( literal ) then
						return astNewVAR( literal )
					end if
				end if
			end if
		end if
	end if

	astTryOvlStringCONV( expr )

	if( is_lcase ) then
		if( astGetDataType( expr ) = FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( WSTRLCASE2 )
		else
			f = PROCLOOKUP( STRLCASE2 )
		end if
	else
		if( astGetDataType( expr ) = FB_DATATYPE_WCHAR ) then
			f = PROCLOOKUP( WSTRUCASE2 )
		else
			f = PROCLOOKUP( STRUCASE2 )
		end if
	end if

	proc = astNewCALL( f )

	if( astNewARG( proc, expr ) = NULL ) then
		exit function
	end if

	'' mode can be NULL, in which case the param's default arg will be used
	if( astNewARG( proc, mode ) = NULL ) then
		exit function
	end if

	function = proc
end function

'':::::
function rtlStrSwap _
	( _
		byval str1 as ASTNODE ptr, _
		byval str2 as ASTNODE ptr _
	) as integer

	function = FALSE

	var proc = astNewCALL( PROCLOOKUP( STRSWAP ) )

	'' always calc len before pushing the param
	var dtype1 = astGetDataType( str1 )
	var length1 = rtlCalcStrLen( str1, dtype1 )

	'' always calc len before pushing the param
	var dtype2 = astGetDataType( str2 )
	var length2 = rtlCalcStrLen( str2, dtype2 )

	'' byref str1 as any
	if( astNewARG( proc, str1, FB_DATATYPE_STRING ) = NULL ) then
		exit function
	end if

	'' byval len1 as integer
	if( astNewARG( proc, astNewCONSTi( length1 ) ) = NULL ) then
		exit function
	end if

	'' byval fillrem1 as integer = 1
	if( astNewARG( proc, astNewCONSTi( (dtype1 = FB_DATATYPE_FIXSTR) ) ) = NULL ) then
		exit function
	end if

	'' byref str2 as any
	if( astNewARG( proc, str2, FB_DATATYPE_STRING ) = NULL ) then
		exit function
	end if

	'' byval len2 as integer
	if( astNewARG( proc, astNewCONSTi( length2 ) ) = NULL ) then
		exit function
	end if

	'' byval fillrem2 as integer = 1
	if( astNewARG( proc, astNewCONSTi( (dtype2 = FB_DATATYPE_FIXSTR) ) ) = NULL ) then
		exit function
	end if

	astAdd( proc )

	function = TRUE
end function

'':::::
function rtlWstrSwap _
	( _
		byval str1 as ASTNODE ptr, _
		byval str2 as ASTNODE ptr _
	) as integer

	function = FALSE

	var proc = astNewCALL( PROCLOOKUP( WSTRSWAP ) )

	'' always calc len before pushing the param
	var length = rtlCalcStrLen( str1, astGetDataType( str1 ) )

	'' byval str1 as wstring ptr
	if( astNewARG( proc, str1 ) = NULL ) then
		exit function
	end if

	'' byval len1 as integer
	if( astNewARG( proc, astNewCONSTi( length ) ) = NULL ) then
		exit function
	end if

	'' always calc len before pushing the param
	length = rtlCalcStrLen( str2, astGetDataType( str2 ) )

	'' byval str2 as wstring ptr
	if( astNewARG( proc, str2 ) = NULL ) then
		exit function
	end if

	'' byval len2 as integer
	if( astNewARG( proc, astNewCONSTi( length ) ) = NULL ) then
		exit function
	end if

	astAdd( proc )

	function = TRUE
end function
