'' intrinsic runtime lib string functions (MID, LEFT, STR, VAL, HEX, ...)
''
'' chng: oct/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' fb_StrInit ( byref dst as any, byval dst_len as integer, _
		 				byref src as any, byval src_len as integer, _
		                byval fillrem as integer = 1 ) as string '/ _
		( _
			@FB_RTL_STRINIT, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 1 _
	 			) _
	 		} _
		), _
		/' fb_WstrAssignToA_Init ( byref dst as any, byval dst_len as integer, _
		 				           byval src as wstring ptr, byval fillrem as integer ) as string '/ _
		( _
			@FB_RTL_WSTRASSIGNAW_INIT, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrAssign ( byref dst as any, byval dst_len as integer, _
		 				  byref src as any, byval src_len as integer, _
		                  byval fillrem as integer = 1 ) as string '/ _
		( _
			@FB_RTL_STRASSIGN, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 1 _
	 			) _
	 		} _
		), _
		/' fb_WstrAssign ( byval dst as wstring ptr, byval dst_len as integer, _
		 				   byval src as wstring ptr) as wstring ptr '/ _
		( _
			@FB_RTL_WSTRASSIGN, NULL, _
			typeAddrOf( FB_DATATYPE_WCHAR ), FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrAssignFromA ( byval dst as wstring ptr, byval dst_len as integer, _
		 				        byref src as any, byval src_len as integer ) as wstring ptr '/ _
		( _
			@FB_RTL_WSTRASSIGNWA, NULL, _
			typeAddrOf( FB_DATATYPE_WCHAR ), FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrAssignToA ( byref dst as any, byval dst_len as integer, _
		 				      byval src as wstring ptr, byval fillrem as integer ) as string '/ _
		( _
			@FB_RTL_WSTRASSIGNAW, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrDelete ( byref str as string ) as void '/ _
		( _
			@FB_RTL_STRDELETE, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrDelete ( byval str as wstring ptr ) as void '/ _
		( _
			@FB_RTL_WSTRDELETE, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrConcat ( byref dst as string, _
						  byref str1 as any, byval str1len as integer, _
						  byref str2 as any, byval str2len as integer ) as string '/ _
		( _
			@FB_RTL_STRCONCAT, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrConcat ( byval str1 as wstring ptr, _
		 				   byval str2 as wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRCONCAT, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrConcatWA ( byval str1 as wstring ptr, _
		 				     byref str2 as any, _
									byval str2_len as integer ) as wstring '/ _
		( _
			@FB_RTL_WSTRCONCATWA, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrConcatAW ( byref str1 as any, _
									byval str1_len as integer, _
									byval str2 as wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRCONCATAW, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrCompare ( byref str1 as any, byval str1len as integer, _
						   byref str2 as any, byval str2len as integer ) as integer
		   returns: 0= equal; -1=str1 < str2; 1=str1 > str2 '/ _
		( _
			@FB_RTL_STRCOMPARE, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrCompare ( byval str1 as wstring ptr, _
						    byval str2 as wstring ptr ) as integer
		   returns: 0= equal; -1=str1 < str2; 1=str1 > str2 '/ _
		( _
			@FB_RTL_WSTRCOMPARE, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrConcatAssign ( byref dst as any, byval dst_len as integer, _
		 				        byref src as any, byval src_len as integer, _
							    byval fillrem as integer = 1 ) as string '/ _
		( _
			@FB_RTL_STRCONCATASSIGN, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 1 _
	 			) _
	 		} _
		), _
		/' fb_WstrConcatAssign ( byval dst as wstring ptr, byval dst_len as integer, _
		 				         byval src as wstring ptr) as wstring ptr '/ _
		( _
			@FB_RTL_WSTRCONCATASSIGN, NULL, _
			typeAddrOf( FB_DATATYPE_WCHAR ), FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrAllocTempResult ( byref str as string ) as string '/ _
		( _
			@FB_RTL_STRALLOCTMPRES, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_StrAllocTempDescV ( byref str as string ) as string '/ _
		( _
			@FB_RTL_STRALLOCTMPDESCV, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_StrAllocTempDescF ( byref str as any, byval strlen as integer ) as string '/ _
		( _
			@FB_RTL_STRALLOCTMPDESCF, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrAllocTempDescZ ( byval str as zstring ptr ) as string '/ _
		( _
			@FB_RTL_STRALLOCTMPDESCZ, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrAllocTempDescZEx ( byval str as zstring ptr, byval len as integer ) as string '/ _
		( _
			@FB_RTL_STRALLOCTMPDESCZEX, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrAlloc ( byval len as integer ) as wstring ptr '/ _
		( _
			@FB_RTL_WSTRALLOC, NULL, _
			typeAddrOf( FB_DATATYPE_WCHAR ), FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_IntToStr ( byval number as integer ) as string '/ _
		( _
			@FB_RTL_INT2STR, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_IntToStrQB ( byval number as integer ) as string '/ _
		( _
			@FB_RTL_INT2STR_QB, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_IntToWstr ( byval number as integer ) as wstring '/ _
		( _
			@FB_RTL_INT2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_UIntToStr ( byval number as uinteger ) as string '/ _
		( _
			@FB_RTL_UINT2STR, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_UIntToStrQB ( byval number as uinteger ) as string '/ _
		( _
			@FB_RTL_UINT2STR_QB, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_UIntToWstr ( byval number as uinteger ) as wstring '/ _
		( _
			@FB_RTL_UINT2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_LongintToStr ( byval number as longint ) as string '/ _
		( _
			@FB_RTL_LONGINT2STR, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_LongintToStrQB ( byval number as longint ) as string '/ _
		( _
			@FB_RTL_LONGINT2STR_QB, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_LongintToWstr ( byval number as longint ) as wstring '/ _
		( _
			@FB_RTL_LONGINT2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_ULongintToStr ( byval number as ulongint ) as string '/ _
		( _
			@FB_RTL_ULONGINT2STR, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_ULongintToStrQB ( byval number as ulongint ) as string '/ _
		( _
			@FB_RTL_ULONGINT2STR_QB, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_ULongintToWstr ( byval number as ulongint ) as wstring '/ _
		( _
			@FB_RTL_ULONGINT2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_FloatToStr ( byval number as single ) as string '/ _
		( _
			@FB_RTL_FLT2STR, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_FloatToStrQB ( byval number as single ) as string '/ _
		( _
			@FB_RTL_FLT2STR_QB, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_FloatToWstr ( byval number as single ) as wstring '/ _
		( _
			@FB_RTL_FLT2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_DoubleToStr ( byval number as double ) as string '/ _
		( _
			@FB_RTL_DBL2STR, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_DoubleToStrQB ( byval number as double ) as string '/ _
		( _
			@FB_RTL_DBL2STR_QB, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_QBONLY, _
			1, _
			{ _
				( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_DoubleToWstr ( byval number as double ) as wstring '/ _
		( _
			@FB_RTL_DBL2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrToStr ( byval str as wstring ptr ) as string '/ _
		( _
			@FB_RTL_WSTR2STR, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrToWstr ( byval str as zstring ptr ) as wstring '/ _
		( _
			@FB_RTL_STR2WSTR, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrMid ( byref str as string, byval start as integer, _
					   byval len as integer ) as string '/ _
		( _
			@FB_RTL_STRMID, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrMid ( byval dst as wstring ptr, byval start as integer, _
						byval len as integer ) as wstring '/ _
		( _
			@FB_RTL_WSTRMID, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrAssignMid ( byref dst as string, byval start as integer, _
									byval len as integer, byref src as string ) as void '/ _
		( _
			@FB_RTL_STRASSIGNMID, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrAssignMid ( byval dst as wstring ptr, byval dst_len as integer, _
							  byval start as integer, byval len as integer, _
							  byval src as wstring ptr ) as void '/ _
		( _
			@FB_RTL_WSTRASSIGNMID, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrFill1 ( byval cnt as integer, byval char as integer ) as string '/ _
		( _
			@FB_RTL_STRFILL1, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrFill1 ( byval cnt as integer, byval char as integer ) as wstring '/ _
		( _
			@FB_RTL_WSTRFILL1, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrFill2 ( byval cnt as integer, byref str as string ) as string '/ _
		( _
			@FB_RTL_STRFILL2, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrFill2 ( byval cnt as integer, byval str as wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRFILL2, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrLen ( byref str as any, byval strlen as integer ) as integer '/ _
		( _
			@FB_RTL_STRLEN, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrLen ( byval str as wstring ptr ) as integer '/ _
		( _
			@FB_RTL_WSTRLEN, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrLset ( byref dst as string, byref src as string ) as void '/ _
		( _
			@FB_RTL_STRLSET, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrLset ( byval dst as wstring ptr, byval src as wstring ptr ) as void '/ _
		( _
			@FB_RTL_WSTRLSET, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrRset overload ( byref dst as string, byref src as string ) as void '/ _
		( _
			@FB_RTL_STRRSET, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			2, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrRset ( byval dst as wstring ptr, byval src as wstring ptr ) as void '/ _
		( _
			@FB_RTL_WSTRRSET, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_ASC ( byref str as string, byval pos as integer = 0 ) as uinteger '/ _
		( _
			@FB_RTL_STRASC, NULL, _
			FB_DATATYPE_UINT, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' fb_WstrAsc ( byval str as wstring ptr, byval pos as integer = 0 ) as uinteger '/ _
		( _
			@FB_RTL_WSTRASC, NULL, _
			FB_DATATYPE_UINT, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' fb_CHR CDECL ( byval args as integer, ... ) as string '/ _
		( _
			@FB_RTL_STRCHR, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INVALID, FB_PARAMMODE_VARARG, FALSE _
				) _
			} _
 		), _
		/' fb_WstrChr CDECL ( byval args as integer, ... ) as wstring '/ _
		( _
			@FB_RTL_WSTRCHR, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INVALID, FB_PARAMMODE_VARARG, FALSE _
				) _
			} _
 		), _
		/' fb_StrInstr ( byval start as integer, byref srcstr as string, _
								byref pattern as string ) as integer '/ _
		( _
			@FB_RTL_STRINSTR, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrInstr ( byval start as integer, byval srcstr as wstring ptr, _
						  byval pattern as wstring ptr ) as integer '/ _
		( _
			@FB_RTL_WSTRINSTR, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrInstrAny ( byval start as integer, byref srcstr as string, _
							byref pattern as string ) as integer '/ _
		( _
			@FB_RTL_STRINSTRANY, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrInstrAny ( byval start as integer, byval srcstr as wstring ptr, _
									byval pattern as wstring ptr ) as integer '/ _
		( _
			@FB_RTL_WSTRINSTRANY, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrInstrRev ( byref srcstr as string, byref pattern as string, _
								byval start as integer ) as integer '/ _
		( _
			@FB_RTL_STRINSTRREV, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrInstrRev ( byval srcstr as wstring ptr, byval pattern as wstring ptr, _
								byval start as integer ) as integer '/ _
		( _
			@FB_RTL_WSTRINSTRREV, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrInstrRevAny ( byref srcstr as string, byref pattern as string, _
							byval start as integer ) as integer '/ _
		( _
			@FB_RTL_STRINSTRREVANY, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrInstrRevAny ( byval srcstr as wstring ptr, byval pattern as wstring ptr, _
									byval start as integer ) as integer '/ _
		( _
			@FB_RTL_WSTRINSTRREVANY, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_TRIM ( byref str as string ) as string '/ _
		( _
			@FB_RTL_STRTRIM, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrTrim ( byval str as wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRTRIM, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_TrimAny ( byref str as string, byref pattern as string ) as string '/ _
		( _
			@FB_RTL_STRTRIMANY, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrTrimAny ( byval str as wstring ptr, byval pattern as wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRTRIMANY, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_TrimEx ( byref str as string, byref pattern as string ) as string '/ _
		( _
			@FB_RTL_STRTRIMEX, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrTrimEx ( byval str as wstring ptr, byval pattern as wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRTRIMEX, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_RTRIM ( byref str as string ) as string '/ _
		( _
			@FB_RTL_STRRTRIM, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrRTrim ( byval str as wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRRTRIM, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_RTrimAny ( byref str as string, byref pattern as string ) as string '/ _
		( _
			@FB_RTL_STRRTRIMANY, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrRTrimAny ( byval str as wstring ptr, byval pattern as wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRRTRIMANY, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_RTrimEx ( byref str as string, byref pattern as string ) as string '/ _
		( _
			@FB_RTL_STRRTRIMEX, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrRTrimEx ( byval str as wstring ptr, byval pattern as wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRRTRIMEX, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_LTRIM ( byref str as string ) as string '/ _
		( _
			@FB_RTL_STRLTRIM, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrLTrim ( byval str as wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRLTRIM, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_LTrimAny ( byref str as string, byref pattern as string ) as string '/ _
		( _
			@FB_RTL_STRLTRIMANY, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrLTrimAny ( byval str as wstring ptr, byval pattern as wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRLTRIMANY, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_LTrimEx ( byref str as string, byref pattern as string ) as string '/ _
		( _
			@FB_RTL_STRLTRIMEX, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrLTrimEx ( byval str as wstring ptr, byval pattern as wstring ptr ) as wstring '/ _
		( _
			@FB_RTL_WSTRLTRIMEX, NULL, _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_StrSwap ( byref str1 as any, byval len1 as integer, byval fillrem1 as integer, _
		                byref str2 as any, byval len2 as integer, byval fillrem2 as integer ) as void '/ _
		( _
			@FB_RTL_STRSWAP, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
			{ _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_WstrSwap ( byval str1 as wstring ptr, byval len1 as integer, _
		                 byval str2 as wstring ptr, byval len2 as integer ) as void '/ _
		( _
			@FB_RTL_WSTRSWAP, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_VAL overload ( byref str as string ) as double '/ _
		( _
			@FB_RTL_STR2DBL, @"fb_VAL", _
			FB_DATATYPE_DOUBLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrVal ( byval str as wstring ptr ) as double '/ _
		( _
			@FB_RTL_STR2DBL, @"fb_WstrVal", _
			FB_DATATYPE_DOUBLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_VALINT overload ( byref str as string ) as integer '/ _
		( _
			@FB_RTL_STR2INT, @"fb_VALINT", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrValInt ( byval str as wstring ptr ) as integer '/ _
		( _
			@FB_RTL_STR2INT, @"fb_WstrValInt", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_VALUINT overload ( byref str as string ) as uinteger '/ _
		( _
			@FB_RTL_STR2UINT, @"fb_VALUINT", _
			FB_DATATYPE_UINT, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrValUInt ( byval str as wstring ptr ) as uinteger '/ _
		( _
			@FB_RTL_STR2UINT, @"fb_WstrValUInt", _
			FB_DATATYPE_UINT, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_VALLNG overload ( byref str as string ) as longint '/ _
		( _
			@FB_RTL_STR2LNG, @"fb_VALLNG", _
			FB_DATATYPE_LONGINT, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrValLng ( byval str as wstring ptr ) as longint '/ _
		( _
			@FB_RTL_STR2LNG, @"fb_WstrValLng", _
			FB_DATATYPE_LONGINT, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_VALULNG overload ( byref str as string ) as ulongint '/ _
		( _
			@FB_RTL_STR2ULNG, @"fb_VALULNG", _
			FB_DATATYPE_ULONGINT, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrValULng ( byval str as wstring ptr ) as ulongint '/ _
		( _
			@FB_RTL_STR2ULNG, @"fb_WstrValULng", _
			FB_DATATYPE_ULONGINT, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' hex( byval number as ubyte ) as string '/ _
		( _
			@"hex", @"fb_HEX_b", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' hex( byval number as ushort ) as string '/ _
		( _
			@"hex", @"fb_HEX_s", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' hex( byval number as uinteger ) as string '/ _
		( _
			@"hex", @"fb_HEX_i", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' hex( byval number as any ptr ) as string '/ _
		( _
			@"hex", @"fb_HEX_p", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' hex( byval number as uinteger, byval digits as integer ) as string '/ _
		( _
			@"hex", @"fb_HEXEx_i", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' hex( byval number as any ptr, byval digits as integer ) as string '/ _
		( _
			@"hex", @"fb_HEXEx_p", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' hex( byval number as ulongint ) as string '/ _
		( _
			@"hex", @"fb_HEX_l", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' hex( byval number as ulongint, byval digits as integer ) as string '/ _
		( _
			@"hex", @"fb_HEXEx_l", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' whex( byval number as ubyte ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHex_b", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' whex( byval number as ushort ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHex_s", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' whex( byval number as uinteger ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHex_i", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' whex( byval number as any ptr ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHex_p", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' whex( byval number as uinteger, byval digits as integer ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHexEx_i", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' whex( byval number as any ptr, byval digits as integer ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHexEx_p", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' whex( byval number as ulongint ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHex_l", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' whex( byval number as ulongint, byval digits as integer ) as wstring '/ _
		( _
			@"whex", @"fb_WstrHexEx_l", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' oct( byval number as ubyte ) as string '/ _
		( _
			@"oct", @"fb_OCT_b", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' oct( byval number as ubyte, byval digits as integer ) as string '/ _
		( _
			@"oct", @"fb_OCTEx_b", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( _
					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' oct( byval number as ushort ) as string '/ _
		( _
			@"oct", @"fb_OCT_s", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' oct( byval number as ushort, byval digits as integer ) as string '/ _
		( _
			@"oct", @"fb_OCTEx_s", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' oct( byval number as uinteger ) as string '/ _
		( _
			@"oct", @"fb_OCT_i", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' oct( byval number as any ptr ) as string '/ _
		( _
			@"oct", @"fb_OCT_p", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' oct( byval number as uinteger, byval digits as integer ) as string '/ _
		( _
			@"oct", @"fb_OCTEx_i", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' oct( byval number as any ptr, byval digits as integer ) as string '/ _
		( _
			@"oct", @"fb_OCTEx_p", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' oct( byval number as ulongint ) as string '/ _
		( _
			@"oct", @"fb_OCT_l", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' oct( byval number as ulongint, byval digits as integer ) as string '/ _
		( _
			@"oct", @"fb_OCTEx_l", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' woct( byval number as ubyte ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOct_b", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' woct( byval number as ubyte, byval digits as integer ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOctEx_b", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' woct( byval number as ushort ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOct_s", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' woct( byval number as ushort, byval digits as integer ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOctEx_s", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' woct( byval number as uinteger ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOct_i", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' woct( byval number as any ptr ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOct_p", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' woct( byval number as uinteger, byval digits as integer ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOctEx_i", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' woct( byval number as any ptr, byval digits as integer ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOctEx_p", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' woct( byval number as ulongint ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOct_l", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' woct( byval number as ulongint, byval digits as integer ) as wstring '/ _
		( _
			@"woct", @"fb_WstrOctEx_l", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' bin( byval number as ubyte ) as string '/ _
		( _
			@"bin", @"fb_BIN_b", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' bin( byval number as ushort ) as string '/ _
		( _
			@"bin", @"fb_BIN_s", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' bin( byval number as uinteger ) as string '/ _
		( _
			@"bin", @"fb_BIN_i", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' bin( byval number as any ptr ) as string '/ _
		( _
			@"bin", @"fb_BIN_p", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' bin( byval number as uinteger, byval digits as integer ) as string '/ _
		( _
			@"bin", @"fb_BINEx_i", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' bin( byval number as any ptr, byval digits as integer ) as string '/ _
		( _
			@"bin", @"fb_BINEx_p", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' bin( byval number as ulongint ) as string '/ _
		( _
			@"bin", @"fb_BIN_l", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' bin( byval number as ulongint, byval digits as integer ) as string '/ _
		( _
			@"bin", @"fb_BINEx_l", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' wbin( byval number as ubyte ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBin_b", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' wbin( byval number as ushort ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBin_s", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' wbin( byval number as uinteger ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBin_i", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' wbin( byval number as any ptr ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBin_p", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' wbin( byval number as uinteger, byval digits as integer ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBinEx_i", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' wbin( byval number as any ptr, byval digits as integer ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBinEx_p", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
 					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' wbin( byval number as ulongint ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBin_l", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' wbin( byval number as ulongint, byval digits as integer ) as wstring '/ _
		( _
			@"wbin", @"fb_WstrBinEx_l", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_MKD( byval number as double ) as string '/ _
		( _
			@FB_RTL_MKD, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_MKS( byval number as single ) as string '/ _
		( _
			@FB_RTL_MKS, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_MKSHORT( byval number as short ) as string '/ _
		( _
			@FB_RTL_MKSHORT, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_SHORT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_MKI( byval number as integer ) as string '/ _
		( _
			@FB_RTL_MKI, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_MKL( byval number as long ) as string '/ _
		( _
			@FB_RTL_MKL, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_MKLONGINT( byval number as longint ) as string '/ _
		( _
			@FB_RTL_MKLONGINT, NULL, _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_LEFT overload ( byref str as string, byval n as integer ) as string '/ _
		( _
			@"left", @"fb_LEFT", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrLeft ( byval str as wstring ptr, byval n as integer ) as wstring '/ _
		( _
			@"left", @"fb_WstrLeft", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_RIGHT overload ( byref str as string, byval n as integer ) as string '/ _
		( _
			@"right", @"fb_RIGHT", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			2, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrRight ( byval str as wstring ptr, byval n as integer ) as wstring '/ _
		( _
			@"right", @"fb_WstrRight", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				), _
				( _
 					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_SPACE overload ( byval n as integer ) as string '/ _
		( _
			@"space", @"fb_SPACE", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_WstrSpace ( byval n as integer ) as wstring '/ _
		( _
			@"wspace", @"fb_WstrSpace", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_LCASE overload ( byref str as string ) as string '/ _
		( _
			@"lcase", @"fb_LCASE", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_WstrLcase ( byval str as wstring ptr ) as wstring '/ _
		( _
			@"lcase", @"fb_WstrLcase", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
 		), _
		/' fb_UCASE overload ( byref str as string ) as string '/ _
		( _
			@"ucase", @"fb_UCASE", _
			FB_DATATYPE_STRING, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_STRSUFFIX, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
		), _
		/' fb_WstrUcase ( byval str as wstring ptr ) as wstring '/ _
		( _
			@"ucase", @"fb_WstrUcase", _
			FB_DATATYPE_WCHAR, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_CVD( byref str as string ) as double '/ _
		( _
			@FB_RTL_CVD, @"fb_CVD", _
			FB_DATATYPE_DOUBLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
		), _
		/' fb_CVS( byref str as string ) as single '/ _
		( _
			@FB_RTL_CVS, @"fb_CVS", _
			FB_DATATYPE_SINGLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
		), _
		/' fb_CVSHORT( byref str as string ) as short '/ _
		( _
			@FB_RTL_CVSHORT, @"fb_CVSHORT", _
			FB_DATATYPE_SHORT, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
		), _
		/' fb_CVI( byref str as string ) as integer '/ _
		( _
			@FB_RTL_CVI, @"fb_CVI", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
		/' fb_CVL( byref str as string ) as long '/ _
		( _
			@FB_RTL_CVL, NULL, _
			FB_DATATYPE_LONG, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
		), _
		/' fb_CVLONGINT( byref str as string ) as longint '/ _
		( _
			@FB_RTL_CVLONGINT, @"fb_CVLONGINT", _
			FB_DATATYPE_LONGINT, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
		/' fb_CVDFROMLONGINT( byval num as longint ) as double '/ _
		( _
			@FB_RTL_CVDFROMLONGINT, @"fb_CVDFROMLONGINT", _
			FB_DATATYPE_DOUBLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_CVSFROML( byref num as long ) as single '/ _
		( _
			@FB_RTL_CVSFROML, @"fb_CVSFROML", _
			FB_DATATYPE_SINGLE, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_CVLFROMS( byval num as single ) as long '/ _
		( _
			@FB_RTL_CVLFROMS, @"fb_CVLFROMS", _
			FB_DATATYPE_LONG, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' fb_CVLONGINTFROMD( byval num as double ) as longint '/ _
		( _
			@FB_RTL_CVLONGINTFROMD, @"fb_CVLONGINTFROMD", _
			FB_DATATYPE_LONGINT, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
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
    dim as integer str1len = any, str2len = any

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
    if( astNewARG( proc, _
    				 astNewCONSTi( str1len, FB_DATATYPE_INTEGER ), _
    				 FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' byref str2 as any
    if( astNewARG( proc, str2, sdtype2 ) = NULL ) then
    	exit function
    end if

    '' byval str2_len as integer
    if( astNewARG( proc, _
    				 astNewCONSTi( str2len, FB_DATATYPE_INTEGER ), _
    				 FB_DATATYPE_INTEGER ) = NULL ) then
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
    dim as integer str1len = any, str2len = any
    dim as FBSYMBOL ptr tmp = any

	function = NULL

    proc = astNewCALL( PROCLOOKUP( STRCONCAT ) )

    '' byref dst as string (must be cleaned up due the rtlib assumptions about destine)
    tmp = symbAddTempVar( FB_DATATYPE_STRING )

    if( astNewARG( proc, _
    			   astNewVAR( tmp, 0, FB_DATATYPE_STRING, NULL, TRUE ), _
    			   FB_DATATYPE_STRING ) = NULL ) then
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
    if( astNewARG( proc, _
    			   astNewCONSTi( str1len, FB_DATATYPE_INTEGER ), _
    			   FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' byref str2 as any
    if( astNewARG( proc, str2, sdtype2 ) = NULL ) then
    	exit function
    end if

    '' byval str2_len as integer
    if( astNewARG( proc, _
    			   astNewCONSTi( str2len, FB_DATATYPE_INTEGER ), _
    			   FB_DATATYPE_INTEGER ) = NULL ) then
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
    dim as integer str2len = any

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
    if( astNewARG( proc, _
    				 astNewCONSTi( str2len, FB_DATATYPE_INTEGER ), _
    				 FB_DATATYPE_INTEGER ) = NULL ) then
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
    dim as integer str1len = any

	function = NULL

    proc = astNewCALL( PROCLOOKUP( WSTRCONCATAW ) )

   	'' always calc len before pushing the param
   	str1len = rtlCalcStrLen( str1, sdtype1 )

    '' byref str1 as any
    if( astNewARG( proc, str1, sdtype1 ) = NULL ) then
    	exit function
    end if

    '' byval str1_len as integer
    if( astNewARG( proc, _
    				 astNewCONSTi( str1len, FB_DATATYPE_INTEGER ), _
    				 FB_DATATYPE_INTEGER ) = NULL ) then
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
		byval src as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as integer lgt = any, ddtype = any, sdtype = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( STRCONCATASSIGN ) )

   	ddtype = astGetDataType( dst )

	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( dst, ddtype )

	'' dst as any
	if( astNewARG( proc, dst, ddtype ) = NULL ) then
    	exit function
    end if

	'' byval dstlen as integer
	if( astNewARG( proc, _
					 astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
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
	if( astNewARG( proc, _
					 astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval fillrem as integer
	if( astNewARG( proc, _
					 astNewCONSTi( ddtype = FB_DATATYPE_FIXSTR, FB_DATATYPE_INTEGER ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
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
    dim as integer lgt

	function = NULL

	proc = astNewCALL( PROCLOOKUP( WSTRCONCATASSIGN ) )

	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( dst, FB_DATATYPE_WCHAR )

	'' byval dst as wstring ptr
	if( astNewARG( proc, dst ) = NULL ) then
    	exit function
    end if

	'' byval dstlen as integer
	if( astNewARG( proc, _
					 astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
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
    dim as integer dstlen = any, srclen = any

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
	if( astNewARG( proc, _
					 astNewCONSTi( dstlen, FB_DATATYPE_INTEGER ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' byref src as any
    if( astNewARG( proc, src ) = NULL ) then
    	exit function
    end if

	'' byval srclen as integer
	if( astNewARG( proc, _
					 astNewCONSTi( srclen, FB_DATATYPE_INTEGER ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
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
    dim as integer lgt = any

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
	if( astNewARG( proc, _
					 astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' byval src as wstring ptr
    if( astNewARG( proc, src ) = NULL ) then
    	exit function
    end if

	'' byval fillrem as integer
	if( astNewARG( proc, _
					 astNewCONSTi( ddtype = FB_DATATYPE_FIXSTR, FB_DATATYPE_INTEGER ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
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
    dim as integer lgt = any, ddtype = any, sdtype = any

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
	if( astNewARG( proc, _
					 astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

   	'' always calc len before pushing the param
	lgt = rtlCalcStrLen( src, sdtype )

	'' src as any
	if( astNewARG( proc, src, astGetDataType( src ) ) = NULL ) then
    	exit function
    end if

	'' byval srclen as integer
	if( astNewARG( proc, _
					 astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval fillrem as integer
	if( astNewARG( proc, _
					 astNewCONSTi( ddtype = FB_DATATYPE_FIXSTR, FB_DATATYPE_INTEGER ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	''
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
    dim as integer lgt = any, ddtype = any, sdtype = any

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
	if( astNewARG( proc, _
					 astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' byval src as wstring ptr
    if( astNewARG( proc, src ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlStrDelete _
	( _
		byval strg as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as integer dtype = any

	function = NULL

	''
    dtype = astGetDataType( strg )
    select case as const dtype
    '' it could be a wstring ptr too due the temporary
    '' wstrings that must be handled by AST
    case FB_DATATYPE_WCHAR, _
    	 typeAddrOf( FB_DATATYPE_WCHAR )
    	proc = astNewCALL( PROCLOOKUP( WSTRDELETE ) )
    case else
    	proc = astNewCALL( PROCLOOKUP( STRDELETE ) )
    	dtype = FB_DATATYPE_STRING
    end select

    '' str as ANY
    if( astNewARG( proc, strg, dtype ) = NULL ) then
    	exit function
    end if

    function = proc

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
function rtlStrAllocTmpDesc	_
	( _
		byval strexpr as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as integer lgt = any, dtype = any
    dim as FBSYMBOL ptr litsym = any

    function = NULL

	''
   	dtype = astGetDataType( strexpr )

	select case as const dtype
	case FB_DATATYPE_STRING
    	proc = astNewCALL( PROCLOOKUP( STRALLOCTMPDESCV ) )

    	'' str as string
    	if( astNewARG( proc, strexpr ) = NULL ) then
    		exit function
    	end if

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
    		lgt = symbGetStrLen( litsym ) - 1	'' less the null-term

            '' byval len as integer
    		if( astNewARG( proc, _
    						 astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), _
    						 FB_DATATYPE_INTEGER ) = NULL ) then
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
		if( astNewARG( proc, _
						 astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), _
						 FB_DATATYPE_INTEGER ) = NULL ) then
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
		if( pad ) then
			if( typeIsSigned( astGetDataType( expr ) ) ) then
				if astGetValueAsDouble( expr ) >= 0 then
					s = " "
				end if
			else
				s = " "
			end if
		end if
		s += astGetValueAsStr( expr )
		return astNewCONSTstr( s )
	end if

    '' wstring literal? convert from unicode at compile-time
    if( dtype = FB_DATATYPE_WCHAR ) then
    	litsym = astGetStrLitSymbol( expr )
    	if( litsym <> NULL ) then
			if( env.wchar_doconv ) then
				litsym = symbAllocStrConst( str( *symbGetVarLitTextW( litsym ) ), _
							   	   	   		symbGetWstrLen( litsym ) - 1 )

				return astNewVAR( litsym, 0, FB_DATATYPE_CHAR )
    		end if
    	end if
    end if

    ''
	select case as const astGetDataClass( expr )
	case FB_DATACLASS_INTEGER

		select case as const dtype
		case FB_DATATYPE_LONGINT
			f = iif( pad = FALSE, _
			         PROCLOOKUP( LONGINT2STR ), _
			         PROCLOOKUP( LONGINT2STR_QB ) )

		case FB_DATATYPE_ULONGINT
			f = iif( pad = FALSE, _
			         PROCLOOKUP( ULONGINT2STR ), _
			         PROCLOOKUP( ULONGINT2STR_QB ) )

		case FB_DATATYPE_LONG
			if( FB_LONGSIZE = FB_INTEGERSIZE ) then
				f = iif( pad = FALSE, _
				         PROCLOOKUP( INT2STR ), _
				         PROCLOOKUP( INT2STR_QB ) )
			else
				f = iif( pad = FALSE, _
				         PROCLOOKUP( LONGINT2STR ), _
				         PROCLOOKUP( LONGINT2STR_QB ) )
			end if

		case FB_DATATYPE_ULONG
			if( FB_LONGSIZE = FB_INTEGERSIZE ) then
				f = iif( pad = FALSE, _
				         PROCLOOKUP( UINT2STR ), _
				         PROCLOOKUP( UINT2STR_QB ) )
			else
				f = iif( pad = FALSE, _
				         PROCLOOKUP( ULONGINT2STR ), _
				         PROCLOOKUP( ULONGINT2STR_QB ) )
			end if

		case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
			f = iif( pad = FALSE, _
			         PROCLOOKUP( INT2STR ), _
			         PROCLOOKUP( INT2STR_QB ) )

		case FB_DATATYPE_UBYTE, FB_DATATYPE_USHORT, FB_DATATYPE_UINT
			f = iif( pad = FALSE, _
			         PROCLOOKUP( UINT2STR ), _
			         PROCLOOKUP( UINT2STR_QB ) )

		'' zstring? do nothing
		case FB_DATATYPE_CHAR
			return expr

		'' wstring? convert..
		case FB_DATATYPE_WCHAR
			return rtlWStrToA( expr )

		'' pointer..
		case else
			if( FB_LONGSIZE = FB_INTEGERSIZE ) then
				f = iif( pad = FALSE, _
				         PROCLOOKUP( UINT2STR ), _
				         PROCLOOKUP( UINT2STR_QB ) )
			else
				f = iif( pad = FALSE, _
				         PROCLOOKUP( ULONGINT2STR ), _
				         PROCLOOKUP( ULONGINT2STR_QB ) )
			end if

			expr = astNewCONV( FB_DATATYPE_ULONG, NULL, expr )
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
    	return astNewCONSTwstr( astGetValueAsWstr( expr ) )
    end if

    '' string literal? convert to unicode at compile-time
    if( dtype = FB_DATATYPE_CHAR ) then
    	litsym = astGetStrLitSymbol( expr )
    	if( litsym <> NULL ) then
			if( env.wchar_doconv ) then
				litsym = symbAllocWstrConst( wstr( *symbGetVarLitText( litsym ) ), _
							 			     symbGetStrLen( litsym ) - 1 )
    			return astNewVAR( litsym, 0, FB_DATATYPE_WCHAR )
    		end if
    	end if
    end if

    ''
	select case as const astGetDataClass( expr )
	case FB_DATACLASS_INTEGER

		select case as const dtype
		case FB_DATATYPE_LONGINT
			f = PROCLOOKUP( LONGINT2WSTR )

		case FB_DATATYPE_ULONGINT
			f = PROCLOOKUP( ULONGINT2WSTR )

		case FB_DATATYPE_LONG
			if( FB_LONGSIZE = FB_INTEGERSIZE ) then
				f = PROCLOOKUP( INT2WSTR )
			else
				f = PROCLOOKUP( LONGINT2WSTR )
			end if

		case FB_DATATYPE_ULONG
			if( FB_LONGSIZE = FB_INTEGERSIZE ) then
				f = PROCLOOKUP( UINT2WSTR )
			else
				f = PROCLOOKUP( ULONGINT2WSTR )
			end if

		case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
			f = PROCLOOKUP( INT2WSTR )

		case FB_DATATYPE_UBYTE, FB_DATATYPE_USHORT, FB_DATATYPE_UINT
			f = PROCLOOKUP( UINT2WSTR )

		'' wstring? do nothing
		case FB_DATATYPE_WCHAR
			return expr

		'' zstring? convert..
		case FB_DATATYPE_CHAR
			return rtlAToWstr( expr )

		'' pointer..
		case else
			if( FB_LONGSIZE = FB_INTEGERSIZE ) then
				f = PROCLOOKUP( UINT2WSTR )
			else
				f = PROCLOOKUP( ULONGINT2WSTR )
			end if

			expr = astNewCONV( FB_DATATYPE_ULONG, NULL, expr )
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

    ''
	select case as const typeGet( to_dtype )
	case FB_DATATYPE_LONGINT
		f = PROCLOOKUP( STR2LNG )

	case FB_DATATYPE_ULONGINT
		f = PROCLOOKUP( STR2ULNG )

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		f = PROCLOOKUP( STR2DBL )

	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = FB_INTEGERSIZE ) then
			f = PROCLOOKUP( STR2INT )
		else
			f = PROCLOOKUP( STR2LNG )
		end if

	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = FB_INTEGERSIZE ) then
			f = PROCLOOKUP( STR2UINT )
		else
			f = PROCLOOKUP( STR2ULNG )
		end if

	case FB_DATATYPE_BYTE, FB_DATATYPE_SHORT, FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
		f = PROCLOOKUP( STR2INT )

	case FB_DATATYPE_UBYTE, FB_DATATYPE_USHORT, FB_DATATYPE_UINT
		f = PROCLOOKUP( STR2UINT )

	'' UDT's, classes: try cast(to_dtype) op overloading
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		return astNewCONV( to_dtype, NULL, expr )

	case FB_DATATYPE_POINTER
		if( FB_LONGSIZE = FB_INTEGERSIZE ) then
			f = PROCLOOKUP( STR2INT )
		else
			f = PROCLOOKUP( STR2LNG )
		end if

		expr = astNewCONV( FB_DATATYPE_ULONG, NULL, expr )

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

	''
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
    dim as integer dst_len = any

    function = NULL

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
    	if( astNewARG( proc, _
    					 astNewCONSTi( dst_len, FB_DATATYPE_INTEGER ) ) = NULL ) then
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

'':::::
function rtlStrAsc _
	( _
		byval expr as ASTNODE ptr, _
		byval posexpr as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

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
    	posexpr = astNewCONSTi( 1, FB_DATATYPE_INTEGER )
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
    if( astNewARG( proc, astNewCONSTi( args, FB_DATATYPE_INTEGER ) ) = NULL ) then
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
