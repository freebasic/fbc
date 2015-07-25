'' intrinsic runtime lib file functions (OPEN, CLOSE, SEEK, GET, PUT, ... )
''
'' chng: oct/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "lex.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 67 ) = _
	{ _
		/' function fb_FileOpen _
			( _
				byref str as string, _
				byval mode as ulong, _
				byval access as ulong, _
				byval lock as ulong, _
				byval fnum as long, _
				byval len as long _
			) as long '/ _
		( _
			@FB_RTL_FILEOPEN, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileOpenEncod _
			( _
				byref str as string, _
				byval mode as ulong, _
				byval access as ulong, _
				byval lock as ulong, _
				byval fnum as long, _
				byval len as long, _
				byval encoding as zstring ptr _
			) as long '/ _
		( _
			@FB_RTL_FILEOPEN_ENCOD, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileOpenShort _
			( _
				byref str_file_mode as string, _
				byval fnum as long, _
				byref filename as string, _
				byval len as long, _
				byref str_access_mode as string, _
				byref str_lock_mode as string _
			) as long '/ _
		( _
			@FB_RTL_FILEOPEN_SHORT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_FileOpenCons _
			( _
				byref str_filename as string, _
				byval mode as ulong, _
				byval access as ulong, _
				byval lock as ulong, _
				byval fnum as long, _
				byval len as long, _
				byval encoding as zstring ptr _
			) as long '/ _
		( _
			@FB_RTL_FILEOPEN_CONS, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileOpenErr _
			( _
				byref str_filename as string, _
				byval mode as ulong, _
				byval access as ulong, _
				byval lock as ulong, _
				byval fnum as long, _
				byval len as long, _
				byval encoding as zstring ptr _
			) as long '/ _
		( _
			@FB_RTL_FILEOPEN_ERR, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileOpenPipe _
			( _
				byref str_filename as string, _
				byval mode as ulong, _
				byval access as ulong, _
				byval lock as ulong, _
				byval fnum as long, _
				byval len as long, _
				byval encoding as zstring ptr _
			) as long '/ _
		( _
			@FB_RTL_FILEOPEN_PIPE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileOpenScrn _
			( _
				byref str_filename as string, _
				byval mode as ulong, _
				byval access as ulong, _
				byval lock as ulong, _
				byval fnum as long, _
				byval len as long, _
				byval encoding as zstring ptr _
			) as long '/ _
		( _
			@FB_RTL_FILEOPEN_SCRN, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileOpenLpt _
			( _
				byref str_filename as string, _
				byval mode as ulong, _
				byval access as ulong, _
				byval lock as ulong, _
				byval fnum as long, _
				byval len as long, _
				byval encoding as zstring ptr _
			) as long '/ _
		( _
			@FB_RTL_FILEOPEN_LPT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileOpenCom _
			( _
				byref str_filename as string, _
				byval mode as ulong, _
				byval access as ulong, _
				byval lock as ulong, _
				byval fnum as long, _
				byval len as long, _
				byval encoding as zstring ptr _
			) as long '/ _
		( _
			@FB_RTL_FILEOPEN_COM, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileOpenQB _
			( _
				byref s as string, _
				byval mode as ulong, _
				byval access as ulong, _
				byval lock as ulong, _
				byval filenum as long, _
				byval len as long _
			) as long '/ _
		( _
			@FB_RTL_FILEOPEN_QB, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileClose( byval fnum as long ) as long '/ _
		( _
			@FB_RTL_FILECLOSE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileCloseAll( ) as long '/ _
		( _
			@FB_RTL_FILECLOSEALL, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' function fb_FilePut _
			( _
				byval fnum as long, _
				byval pos as long, _
				byref value as any, _
				byval valuelen as uinteger _
			) as long '/ _
		( _
			@FB_RTL_FILEPUT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FilePutLarge _
			( _
				byval fnum as long, _
				byval pos as longint, _
				byref value as any, _
				byval valuelen as uinteger _
			) as long '/ _
		( _
			@FB_RTL_FILEPUTLARGE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FilePutStr _
			( _
				byval fnum as long, _
				byval pos as long, _
				byref str as any, _
				byval str_len as integer _
			) as long '/ _
		( _
			@FB_RTL_FILEPUTSTR, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FilePutStrLarge _
			( _
				byval fnum as long, _
				byval pos as longint, _
				byref str as any, _
				byval str_len as integer _
			) as long '/ _
		( _
			@FB_RTL_FILEPUTSTRLARGE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FilePutArray _
			( _
				byval fnum as long, _
				byval pos as long, _
				array() as any _
			) as long '/ _
		( _
			@FB_RTL_FILEPUTARRAY, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ) _
	 		} _
		), _
		/' function fb_FilePutArrayLarge _
			( _
				byval fnum as long, _
				byval pos as longint, _
				array() as any _
			) as long '/ _
		( _
			@FB_RTL_FILEPUTARRAYLARGE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ) _
	 		} _
		), _
		/' function fb_FileGet _
			( _
				byval fnum as long, _
				byval pos as long, _
				byref value as any, _
				byval valuelen as uinteger _
			) as long '/ _
		( _
			@FB_RTL_FILEGET, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileGetLarge _
			( _
				byval fnum as long, _
				byval pos as longint, _
				byref value as any, _
				byval valuelen as uinteger _
			) as long '/ _
		( _
			@FB_RTL_FILEGETLARGE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileGetStr _
			( _
				byval fnum as long, _
				byval pos as long, _
				byref str as any, _
				byval str_len as integer _
			) as long '/ _
		( _
			@FB_RTL_FILEGETSTR, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileGetStrLarge _
			( _
				byval fnum as long, _
				byval pos as longint, _
				byref str as any, _
				byval str_len as integer _
			) as long '/ _
		( _
			@FB_RTL_FILEGETSTRLARGE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileGetArray _
			( _
				byval fnum as long, _
				byval pos as long, _
				array() as any _
			) as long '/ _
		( _
			@FB_RTL_FILEGETARRAY, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ) _
	 		} _
		), _
		/' function fb_FileGetArrayLarge _
			( _
				byval fnum as long, _
				byval pos as longint, _
				array() as any _
			) as long '/ _
		( _
			@FB_RTL_FILEGETARRAYLARGE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ) _
	 		} _
		), _
		/' function fb_FileGetIOB _
			( _
				byval fnum as long, _
				byval pos as long, _
				byref dst as any, _
				byval chars as uinteger, _
				byref bytesread as uinteger _
			) as long '/ _
		( _
			@FB_RTL_FILEGETIOB, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_UINT, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_FileGetLargeIOB _
			( _
				byval fnum as long, _
				byval pos as longint, _
				byref dst as any, _
				byval chars as uinteger, _
				byref bytesread as uinteger _
			) as long '/ _
		( _
			@FB_RTL_FILEGETLARGEIOB, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_UINT, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_FileGetStrIOB _
			( _
				byval fnum as long, _
				byval pos as long, _
				byref str as any, _
				byval str_len as integer, _
				byref bytesread as uinteger _
			) as long '/ _
		( _
			@FB_RTL_FILEGETSTRIOB, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_UINT, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_FileGetStrLargeIOB _
			( _
				byval fnum as long, _
				byval pos as longint, _
				byref str as any, _
				byval str_len as integer, _
				byref bytesread as uinteger _
			) as long '/ _
		( _
			@FB_RTL_FILEGETSTRLARGEIOB, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_UINT, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_FileGetArrayIOB _
			( _
				byval fnum as long, _
				byval pos as long, _
				array() as any, _
				byref bytesread as uinteger _
			) as long '/ _
		( _
			@FB_RTL_FILEGETARRAYIOB, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ), _
				( FB_DATATYPE_UINT, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_FileGetArrayLargeIOB _
			( _
				byval fnum as long, _
				byval pos as longint, _
				array() as any, _
				byref bytesread as uinteger _
			) as long '/ _
		( _
			@FB_RTL_FILEGETARRAYLARGEIOB, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE ), _
				( FB_DATATYPE_UINT, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' function fb_FileTell( byval fnum as long ) as longint '/ _
		( _
			@FB_RTL_FILETELL, NULL, _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileSeek( byval fnum as long, byval newpos as long ) as long '/ _
		( _
			@FB_RTL_FILESEEK, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileSeekLarge _
			( _
				byval fnum as long, _
				byval newpos as longint _
			) as long '/ _
		( _
			@FB_RTL_FILESEEKLARGE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileStrInput _
			( _
				byval bytes as integer, _
				byval fnum as long = 0 _
			) as string '/ _
		( _
			@FB_RTL_FILESTRINPUT, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_FileLineInput _
			( _
				byval fnum as long, _
				byref dst as any, _
				byval dst_len as integer, _
				byval fillrem as long = 1 _
			) as long '/ _
		( _
			@FB_RTL_FILELINEINPUT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 1 ) _
	 		} _
		), _
		/' function fb_FileLineInputWstr _
			( _
				byval fnum as long, _
				byval dst as wstring ptr, _
				byval max_chars as integer _
			) as long '/ _
		( _
			@FB_RTL_FILELINEINPUTWSTR, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_LineInput _
			( _
				byref text as string, _
				byref dst as any, _
				byval dst_len as integer, _
				byval fillrem as long, _
				byval addquestion as long, _
				byval addnewline as long = 1 _
			) as long '/ _
		( _
			@FB_RTL_CONSOLELINEINPUT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 1 ) _
	 		} _
		), _
		/' function fb_LineInputWstr _
			( _
				byval text as wstring ptr, _
				byval dst as wstring ptr, _
				byval max_chars as integer, _
				byval addquestion as long, _
				byval addnewline as long _
			) as long '/ _
		( _
			@FB_RTL_CONSOLELINEINPUTWSTR, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileInput( byval fnum as long ) as long '/ _
		( _
			@FB_RTL_FILEINPUT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_ConsoleInput _
			( _
				byref text as string, _
				byval addquestion as long, _
				byval addnewline as long _
			) as long '/ _
		( _
			@FB_RTL_CONSOLEINPUT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_InputBool( byref dst as boolean ) as long '/ _
		( _
			@FB_RTL_INPUTBOOL, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
	 		{ _
				( FB_DATATYPE_BOOLEAN, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_InputByte( byref dst as byte ) as long '/ _
		( _
			@FB_RTL_INPUTBYTE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_BYTE, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_InputUbyte( byref dst as ubyte ) as long '/ _
		( _
			@FB_RTL_INPUTUBYTE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_UBYTE, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_InputShort( byref dst as short ) as long '/ _
		( _
			@FB_RTL_INPUTSHORT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_SHORT, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_InputUshort( byref dst as ushort ) as long '/ _
		( _
			@FB_RTL_INPUTUSHORT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_USHORT, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_InputInt( byref dst as long ) as long '/ _
		( _
			@FB_RTL_INPUTINT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_InputUint( byref dst as ulong ) as long '/ _
		( _
			@FB_RTL_INPUTUINT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_InputLongint( byref dst as longint ) as long '/ _
		( _
			@FB_RTL_INPUTLONGINT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_InputUlongint( byref dst as ulongint ) as long '/ _
		( _
			@FB_RTL_INPUTULONGINT, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_InputSingle( byref dst as single ) as long '/ _
		( _
			@FB_RTL_INPUTSINGLE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_InputDouble( byref dst as double ) as long '/ _
		( _
			@FB_RTL_INPUTDOUBLE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' function fb_InputString _
			( _
				byref dst as any, _
				byval strlen as integer, _
				byval fillrem as long = 1 _
			) as long '/ _
		( _
			@FB_RTL_INPUTSTR, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 1 ) _
	 		} _
		), _
		/' function fb_InputWstr _
			( _
				byval str as wstring ptr, _
				byval length as integer _
			) as long '/ _
		( _
			@FB_RTL_INPUTWSTR, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileLock _
			( _
				byval fnum as long, _
				byval inipos as ulong, _
				byval endpos as ulong _
			) as long '/ _
		( _
			@FB_RTL_FILELOCK, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' function fb_FileLockLarge _
			( _
				byval fnum as long, _
				byval inipos as longint, _
				byval endpos as longint _
			) as long '/ _
		( _
			@FB_RTL_FILELOCKLARGE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' function fb_FileUnlock _
			( _
				byval fnum as long, _
				byval inipos as ulong, _
				byval endpos as ulong _
			) as long '/ _
		( _
			@FB_RTL_FILEUNLOCK, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' function fb_FileUnlockLarge _
			( _
				byval fnum as long, _
				byval inipos as longint, _
				byval endpos as longint _
			) as long '/ _
		( _
			@FB_RTL_FILEUNLOCKLARGE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
	 		} _
		), _
		/' function fb_rename alias "rename" cdecl _
			( _
				byval oldname as zstring ptr, _
				byval newname as zstring ptr _
			) as long '/ _
		( _
			@FB_RTL_FILERENAME, @"rename", _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
				( typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function fb_FileWstrInput _
			( _
				byval chars as integer, _
				byval fnum as long = 0 _
			) as wstring '/ _
		( _
			@FB_RTL_FILEWSTRINPUT, NULL, _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE ), _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function freefile( ) as long '/ _
		( _
			@"freefile", @"fb_FileFree", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' function eof( byval fnum as long ) as long '/ _
		( _
			@"eof", @"fb_FileEof", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function kill( byref str as string ) as long '/ _
		( _
			@"kill", @"fb_FileKill", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE ) _
	 		} _
		), _
		/' sub reset overload( ) '/ _
		( _
			@"reset", @"fb_FileReset", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			0 _
		), _
		/' sub reset overload( byval streamno as long ) '/ _
		( _
			@"reset", @"fb_FileResetEx", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function lof( byval fnum as long ) as longint '/ _
		( _
			@"lof", @"fb_FileSize", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function loc( byval fnum as long ) as longint '/ _
		( _
			@"loc", @"fb_FileLocation", _
			FB_DATATYPE_LONGINT, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
		), _
		/' function lpos( byval printer_index as long ) as long '/ _
		( _
			@"lpos", @"fb_LPos", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYVAL, FALSE ) _
	 		} _
	 	), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }

'':::::
sub rtlFileModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlFileModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlFileOpen _
	( _
		byval filename as ASTNODE ptr, _
		byval fmode as ASTNODE ptr, _
		byval faccess as ASTNODE ptr, _
		byval flock as ASTNODE ptr, _
		byval filenum as ASTNODE ptr, _
		byval flen as ASTNODE ptr, _
		byval fencoding as ASTNODE ptr, _
		byval isfunc as integer, _
        byval openkind as FBOPENKIND _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer doencoding = any

	function = NULL

	''
	doencoding = TRUE

	select case openkind
	case FB_FILE_TYPE_FILE
		if( fencoding = NULL ) then
			f = PROCLOOKUP( FILEOPEN )
			doencoding = FALSE
		else
			f = PROCLOOKUP( FILEOPEN_ENCOD )
		end if

    case FB_FILE_TYPE_CONS
		f = PROCLOOKUP( FILEOPEN_CONS )

    case FB_FILE_TYPE_ERR
		f = PROCLOOKUP( FILEOPEN_ERR )

    case FB_FILE_TYPE_PIPE
		f = PROCLOOKUP( FILEOPEN_PIPE )

    case FB_FILE_TYPE_SCRN
		f = PROCLOOKUP( FILEOPEN_SCRN )

    case FB_FILE_TYPE_LPT
		f = PROCLOOKUP( FILEOPEN_LPT )

    case FB_FILE_TYPE_COM
		f = PROCLOOKUP( FILEOPEN_COM )

    case else
		assert(openkind = FB_FILE_TYPE_QB)
		f = PROCLOOKUP( FILEOPEN_QB )
		doencoding = FALSE
		select case env.clopt.target
		case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			fbAddLib("gdi32")
			fbAddLib("winspool")
		end select
	end select

	proc = astNewCALL( f )

	'' filename as string
	if( astNewARG( proc, filename ) = NULL ) then
		exit function
	end if

	'' byval mode as integer
	if( astNewARG( proc, fmode ) = NULL ) then
		exit function
	end if

	'' byval access as integer
	if( astNewARG( proc, faccess ) = NULL ) then
		exit function
	end if

	'' byval lock as integer
	if( astNewARG( proc, flock ) = NULL ) then
		exit function
	end if

	'' byval filenum as integer
	if( astNewARG( proc, filenum ) = NULL ) then
		exit function
	end if

	'' byval len as integer
	if( astNewARG( proc, flen ) = NULL ) then
		exit function
	end if

	if( doencoding ) then
		'' byval encoding as zstring ptr
		if( fencoding = NULL ) then
			fencoding = astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_CHAR ) )
		end if
		if( astNewARG( proc, fencoding ) = NULL ) then
			exit function
		end if
	end if

	if( isfunc = FALSE ) then
		astAdd( rtlErrorCheck( proc ) )
	end if

	function = proc
end function

'':::::
function rtlFileOpenShort _
	( _
		byval filename as ASTNODE ptr, _
		byval fmode as ASTNODE ptr, _
		byval faccess as ASTNODE ptr, _
		byval flock as ASTNODE ptr, _
		byval filenum as ASTNODE ptr, _
		byval flen as ASTNODE ptr, _
		byval isfunc as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any

	function = NULL

	'' this is the short form of the OPEN command
	proc = astNewCALL( PROCLOOKUP( FILEOPEN_SHORT ) )

	'' mode as string
	if( astNewARG( proc, fmode ) = NULL ) then
		exit function
	end if

	'' byval filenum as integer
	if( astNewARG( proc, filenum ) = NULL ) then
		exit function
	end if

	'' filename as string
	if( astNewARG( proc, filename ) = NULL ) then
		exit function
	end if

	'' byval len as integer
	if( astNewARG( proc, flen ) = NULL ) then
		exit function
	end if

	'' faccess as string
	if( astNewARG( proc, faccess ) = NULL ) then
		exit function
	end if

	'' flock as string
	if( astNewARG( proc, flock ) = NULL ) then
		exit function
	end if

	if( isfunc = FALSE ) then
		astAdd( rtlErrorCheck( proc ) )
	end if

	function = proc
end function

'':::::
function rtlFileClose _
	( _
		byval filenum as ASTNODE ptr, _
		byval isfunc as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

	''
	if( filenum <> NULL ) then
		proc = astNewCALL( PROCLOOKUP( FILECLOSE ) )

		'' byval filenum as integer
		if( astNewARG( proc, filenum ) = NULL ) then
			exit function
		end if
	else
		proc = astNewCALL( PROCLOOKUP( FILECLOSEALL) )
	end if

	if( isfunc = FALSE ) then
		astAdd( rtlErrorCheck( proc ) )
	end if

	function = proc
end function

'':::::
function rtlFileSeek _
	( _
		byval filenum as ASTNODE ptr, _
		byval newpos as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer pos_dtype = any

	function = FALSE

    pos_dtype = astGetDataType( newpos )
	assert( typeGetClass( pos_dtype ) = FB_DATACLASS_INTEGER )
	if( typeGetSize( pos_dtype ) = 8 ) then
		f = PROCLOOKUP( FILESEEKLARGE )
	else
	    f = PROCLOOKUP( FILESEEK )
	end if

	proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval newpos as integer
    if( astNewARG( proc, newpos ) = NULL ) then
 		exit function
 	end if

	astAdd( rtlErrorCheck( proc ) )
	function = TRUE
end function

'':::::
function rtlFileTell _
	( _
		byval filenum as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

    function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( FILETELL ) )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    ''
    function = proc

end function

'':::::
function rtlFilePut _
	( _
		byval filenum as ASTNODE ptr, _
		byval offset as ASTNODE ptr, _
		byval src as ASTNODE ptr, _
		byval elements as ASTNODE ptr, _
		byval isfunc as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any, bytes = any
	dim as integer dtype = any, o_dtype = any, isstring = any, islarge = any
	dim as longint lgt = any
    dim as FBSYMBOL ptr f = any

    function = NULL

	''
	dtype    = astGetDataType( src )
	isstring = symbIsString( dtype )

	if( offset = NULL ) then
		offset = astNewCONSTi( 0 )
	end if
	o_dtype  = astGetDataType( offset )

	assert( typeGetClass( o_dtype ) = FB_DATACLASS_INTEGER )
	islarge = (typeGetSize( o_dtype ) = 8)

	if( isstring ) then
		if( islarge ) then
			f = PROCLOOKUP( FILEPUTSTRLARGE )
		else
			f = PROCLOOKUP( FILEPUTSTR )
		end if
	else
		if( islarge ) then
			f = PROCLOOKUP( FILEPUTLARGE )
		else
			f = PROCLOOKUP( FILEPUT )
		end if
	end if

    proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( astNewARG( proc, offset ) = NULL ) then
 		exit function
 	end if

    '' always calc len before pushing the param
    if( isstring ) then
    	lgt = rtlCalcStrLen( src, dtype )
    else
		lgt = rtlCalcExprLen( src )
    end if

	if( elements = NULL ) then
		bytes = astNewCONSTi( lgt )
	else
		bytes = astNewBOP( AST_OP_MUL, elements, astNewCONSTi( lgt ) )
	end if

    '' any pointer fields?
    if( astGetDataType( src ) = FB_DATATYPE_STRUCT ) then
    	if( symbGetUDTHasPtrField( astGetSubType( src ) ) ) then
			errReportParamWarn( proc->sym, 3, NULL, FB_WARNINGMSG_POINTERFIELDS )
    	end if
	'' warn if data is pointer
	elseif( typeIsPtr( astGetDataType( src ) ) ) then
		errReportParamWarn( proc->sym, 3, NULL, FB_WARNINGMSG_PASSINGPTR )
    end if

    '' value as any | s as string
    if( astNewARG( proc, src ) = NULL ) then
 		exit function
 	end if

    '' byval bytes as integer
   	if( astNewARG( proc, bytes ) = NULL ) then
		exit function
	end if

	if( isfunc = FALSE ) then
		astAdd( rtlErrorCheck( proc ) )
	end if

	function = proc
end function

'':::::
function rtlFilePutArray _
	( _
		byval filenum as ASTNODE ptr, _
		byval offset as ASTNODE ptr, _
		byval src as ASTNODE ptr, _
		byval isfunc as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
	dim as integer o_dtype = any

    function = NULL

	if( offset = NULL ) then
		offset = astNewCONSTi( 0 )
	end if
    o_dtype  = astGetDataType( offset )

	assert( typeGetClass( o_dtype ) = FB_DATACLASS_INTEGER )
	if( typeGetSize( o_dtype ) = 8 ) then
		f = PROCLOOKUP( FILEPUTARRAYLARGE )
	else
		f = PROCLOOKUP( FILEPUTARRAY )
	end if

	proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( astNewARG( proc, offset ) = NULL ) then
 		exit function
 	end if

    '' any pointer fields?
    if( astGetDataType( src ) = FB_DATATYPE_STRUCT ) then
    	if( symbGetUDTHasPtrField( astGetSubType( src ) ) ) then
			errReportParamWarn( proc->sym, 3, NULL, FB_WARNINGMSG_POINTERFIELDS )
    	end if
	'' warn if data is pointer
	elseif( typeIsPtr( astGetDataType( src ) ) ) then
		errReportParamWarn( proc->sym, 3, NULL, FB_WARNINGMSG_PASSINGPTR )
    end if

    '' array() as any
    if( astNewARG( proc, src ) = NULL ) then
    	exit function
    end if

	if( isfunc = FALSE ) then
		astAdd( rtlErrorCheck( proc ) )
	end if

	function = proc
end function

'':::::
function rtlFileGet _
	( _
		byval filenum as ASTNODE ptr, _
		byval offset as ASTNODE ptr, _
		byval dst as ASTNODE ptr, _
		byval elements as ASTNODE ptr, _
		byval iobytes as ASTNODE ptr, _
		byval isfunc as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any, bytes = any
	dim as integer dtype = any, o_dtype = any, isstring = any, islarge = any
	dim as longint lgt = any
    dim as FBSYMBOL ptr f = any

    function = NULL

	''
	dtype = astGetDataType( dst )
	isstring = symbIsString( dtype )

	if( offset = NULL ) then
		offset = astNewCONSTi( 0 )
	end if
   	o_dtype  = astGetDataType( offset )

	assert( typeGetClass( o_dtype ) = FB_DATACLASS_INTEGER )
	islarge = (typeGetSize( o_dtype ) = 8)

	if( iobytes ) then
		if( isstring ) then
			if( islarge ) then
				f = PROCLOOKUP( FILEGETSTRLARGEIOB )
			else
				f = PROCLOOKUP( FILEGETSTRIOB )
			end if
		else
			if( islarge ) then
				f = PROCLOOKUP( FILEGETLARGEIOB )
			else
				f = PROCLOOKUP( FILEGETIOB )
			end if
		end if
	else
		if( isstring ) then
			if( islarge ) then
				f = PROCLOOKUP( FILEGETSTRLARGE )
			else
				f = PROCLOOKUP( FILEGETSTR )
			end if
		else
			if( islarge ) then
				f = PROCLOOKUP( FILEGETLARGE )
			else
				f = PROCLOOKUP( FILEGET )
			end if
		end if
	end if

    proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( astNewARG( proc, offset ) = NULL ) then
 		exit function
 	end if

    '' always calc len before pushing the param
    if( isstring ) then
    	lgt = rtlCalcStrLen( dst, dtype )
    else
		lgt = rtlCalcExprLen( dst )
    end if

	if( elements = NULL ) then
		bytes = astNewCONSTi( lgt )
	else
		bytes = astNewBOP( AST_OP_MUL, elements, astNewCONSTi( lgt ) )
	end if

    '' any pointer fields?
    if( dtype = FB_DATATYPE_STRUCT ) then
    	if( symbGetUDTHasPtrField( astGetSubType( dst ) ) ) then
			errReportParamWarn( proc->sym, 3, NULL, FB_WARNINGMSG_POINTERFIELDS )
    	end if
	'' warn if data is pointer
	elseif( typeIsPtr( astGetDataType( dst ) ) ) then
		errReportParamWarn( proc->sym, 3, NULL, FB_WARNINGMSG_PASSINGPTR )
    end if
	
    '' value as any
    if( astNewARG( proc, dst ) = NULL ) then
 		exit function
 	end if

    '' byval bytes as integer
    if( astNewARG( proc, bytes ) = NULL ) then
 		exit function
 	end if

	'' byref iobytes as uinteger/ulongint
	if( iobytes ) then
		if( astNewARG( proc, iobytes ) = NULL ) then
 			exit function
 		end if
	end if

	if( isfunc = FALSE ) then
		astAdd( rtlErrorCheck( proc ) )
	end if

	function = proc
end function

'':::::
function rtlFileGetArray _
	( _
		byval filenum as ASTNODE ptr, _
		byval offset as ASTNODE ptr, _
		byval dst as ASTNODE ptr, _
		byval iobytes as ASTNODE ptr, _
		byval isfunc as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer o_dtype = any, islarge = any

	function = NULL

	if( offset = NULL ) then
		offset = astNewCONSTi( 0 )
	end if
	o_dtype  = astGetDataType( offset )

	assert( typeGetClass( o_dtype ) = FB_DATACLASS_INTEGER )
	islarge = (typeGetSize( o_dtype ) = 8)

	if( iobytes ) then
		if( islarge ) then
			f = PROCLOOKUP( FILEGETARRAYLARGEIOB )
		else
			f = PROCLOOKUP( FILEGETARRAYIOB )
		end if
	else
		if( islarge ) then
			f = PROCLOOKUP( FILEGETARRAYLARGE )
		else
			f = PROCLOOKUP( FILEGETARRAY )
		end if
	end if

	proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( astNewARG( proc, offset ) = NULL ) then
 		exit function
 	end if

    '' any pointer fields?
    if( astGetDataType( dst ) = FB_DATATYPE_STRUCT ) then
    	if( symbGetUDTHasPtrField( astGetSubType( dst ) ) ) then
			errReportParamWarn( proc->sym, 3, NULL, FB_WARNINGMSG_POINTERFIELDS )
    	end if
	'' warn if data is pointer
	elseif( typeIsPtr( astGetDataType( dst ) ) ) then
		errReportParamWarn( proc->sym, 3, NULL, FB_WARNINGMSG_PASSINGPTR )
    end if

    '' array() as any
    if( astNewARG( proc, dst ) = NULL ) then
    	exit function
    end if

	if( iobytes ) then
		'' byref iobytes as uinteger
		if( astNewARG( proc, iobytes ) = NULL ) then
			exit function
		end if
	end if

	if( isfunc = FALSE ) then
		astAdd( rtlErrorCheck( proc ) )
	end if

	function = proc
end function

function rtlFileStrInput _
	( _
		byval bytesexpr as ASTNODE ptr, _
		byval filenum as ASTNODE ptr, _
		byval tk as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

    function = NULL

	proc = astNewCALL( iif( tk = FB_TK_WINPUT, _
				PROCLOOKUP( FILEWSTRINPUT ), _
				PROCLOOKUP( FILESTRINPUT ) ) )

    '' byval bytes as integer
    if( astNewARG( proc, bytesexpr ) = NULL ) then
 		exit function
 	end if

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    function = proc
end function

'':::::
function rtlFileLineInput _
	( _
		byval isfile as integer, _
		byval expr as ASTNODE ptr, _
		byval dstexpr as ASTNODE ptr, _
		byval addquestion as integer, _
		byval addnewline as integer _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer args = any, dtype = any
	dim as longint lgt = any

	function = FALSE

	''
	if( isfile ) then
		f = PROCLOOKUP( FILELINEINPUT )
		args = 4
	else
		f = PROCLOOKUP( CONSOLELINEINPUT )
		args = 6
	end if

    proc = astNewCALL( f )

    '' "byval filenum as integer" or "text as string "
    if( (isfile = FALSE) and (expr = NULL) ) then
		expr = astNewVAR( symbAllocStrConst( "", 0 ) )
	end if

    if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

    '' always calc len before pushing the param
	dtype = astGetDataType( dstexpr )
	lgt = rtlCalcStrLen( dstexpr, dtype )

	'' dst as any
    if( astNewARG( proc, dstexpr ) = NULL ) then
 		exit function
 	end if

	'' byval dstlen as integer
	if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
		exit function
	end if

	'' byval fillrem as integer
	if( astNewARG( proc, astNewCONSTi( dtype = FB_DATATYPE_FIXSTR ) ) = NULL ) then
		exit function
	end if

	if( args = 6 ) then
		'' byval addquestion as integer
		if( astNewARG( proc, astNewCONSTi( addquestion ) ) = NULL ) then
			exit function
		end if

		'' byval addnewline as integer
		if( astNewARG( proc, astNewCONSTi( addnewline ) ) = NULL ) then
			exit function
		end if
	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileLineInputWstr _
	( _
		byval isfile as integer, _
		byval expr as ASTNODE ptr, _
		byval dstexpr as ASTNODE ptr, _
		byval addquestion as integer, _
		byval addnewline as integer _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer args = any, dtype = any
	dim as longint lgt = any

	function = FALSE

	''
	if( isfile ) then
		f = PROCLOOKUP( FILELINEINPUTWSTR )
		args = 3
	else
		f = PROCLOOKUP( CONSOLELINEINPUTWSTR )
		args = 5
	end if

    proc = astNewCALL( f )

    '' "byval filenum as integer" or "byval text as wstring ptr"
    if( (isfile = FALSE) and (expr = NULL) ) then
		expr = astNewVAR( symbAllocWStrConst( "", 0 ) )
	end if

    if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

    '' always calc len before pushing the param
	dtype = astGetDataType( dstexpr )
	lgt = rtlCalcStrLen( dstexpr, dtype )

	'' byval dst as wstring ptr
    if( astNewARG( proc, dstexpr ) = NULL ) then
 		exit function
 	end if

	'' byval max_chars as integer
	if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
		exit function
	end if

	if( args = 5 ) then
		'' byval addquestion as integer
		if( astNewARG( proc, astNewCONSTi( addquestion ) ) = NULL ) then
			exit function
		end if

		'' byval addnewline as integer
		if( astNewARG( proc, astNewCONSTi( addnewline ) ) = NULL ) then
			exit function
		end if
	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileInput _
	( _
		byval isfile as integer, _
		byval expr as ASTNODE ptr, _
		byval addquestion as integer, _
		byval addnewline as integer _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer args = any

	function = FALSE

	''
	if( isfile ) then
		f = PROCLOOKUP( FILEINPUT )
		args = 1
	else
		f = PROCLOOKUP( CONSOLEINPUT )
		args = 3
	end if

    proc = astNewCALL( f )

    '' "byval filenum as integer" or "text as string "
    if( (isfile = FALSE) and (expr = NULL) ) then
		expr = astNewVAR( symbAllocStrConst( "", 0 ) )
	end if

	if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

	if( args = 3 ) then
		'' byval addquestion as integer
		if( astNewARG( proc, astNewCONSTi( addquestion ) ) = NULL ) then
			exit function
		end if

		'' byval addnewline as integer
		if( astNewARG( proc, astNewCONSTi( addnewline ) ) = NULL ) then
			exit function
		end if
	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileInputGet _
	( _
		byval dstexpr as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer args = any, dtype = any
	dim as longint lgt = any

	function = FALSE

	''
	args = 1
	dtype = astGetDataType( dstexpr )

	select case as const typeGet( dtype )
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_STRING, FB_DATATYPE_CHAR
		f = PROCLOOKUP( INPUTSTR )
		args = 3

	case FB_DATATYPE_WCHAR
		f = PROCLOOKUP( INPUTWSTR )
		args = 2

	case FB_DATATYPE_BOOLEAN
		f = PROCLOOKUP( INPUTBOOL )

	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE, _
	     FB_DATATYPE_SHORT, FB_DATATYPE_USHORT, _
	     FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM, FB_DATATYPE_UINT, _
	     FB_DATATYPE_LONG, FB_DATATYPE_ULONG, FB_DATATYPE_POINTER, _
	     FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT

		select case as const( typeGetSizeType( dtype ) )
		case FB_SIZETYPE_INT8   : f = PROCLOOKUP( INPUTBYTE )
		case FB_SIZETYPE_UINT8  : f = PROCLOOKUP( INPUTUBYTE )
		case FB_SIZETYPE_INT16  : f = PROCLOOKUP( INPUTSHORT )
		case FB_SIZETYPE_UINT16 : f = PROCLOOKUP( INPUTUSHORT )
		case FB_SIZETYPE_INT32  : f = PROCLOOKUP( INPUTINT )
		case FB_SIZETYPE_UINT32 : f = PROCLOOKUP( INPUTUINT )
		case FB_SIZETYPE_INT64  : f = PROCLOOKUP( INPUTLONGINT )
		case FB_SIZETYPE_UINT64 : f = PROCLOOKUP( INPUTULONGINT )
		end select

	case FB_DATATYPE_SINGLE
		f = PROCLOOKUP( INPUTSINGLE )

	case FB_DATATYPE_DOUBLE
		f = PROCLOOKUP( INPUTDOUBLE )

	case else
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		exit function
	end select

    proc = astNewCALL( f )

    '' always calc len before pushing the param
    if( args > 1 ) then
		lgt = rtlCalcStrLen( dstexpr, dtype )
	end if

    '' byref dst as any | byval dst as wstring ptr
    if( astNewARG( proc, dstexpr ) = NULL ) then
 		exit function
 	end if

	if( args > 1 ) then
		'' byval dstlen as integer
		if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
			exit function
		end if

		if( args > 2 ) then
			'' byval fillrem as integer
			if( astNewARG( proc, astNewCONSTi( dtype = FB_DATATYPE_FIXSTR ) ) = NULL ) then
				exit function
			end if
		end if
	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileLock _
	( _
		byval islock as integer, _
		byval filenum as ASTNODE ptr, _
		byval iniexpr as ASTNODE ptr, _
		byval endexpr as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr f = any
    dim as integer islarge = any, i_dtype = any, e_dtype = any

	function = FALSE

	i_dtype = astGetDataType( iniexpr )
	e_dtype = astGetDataType( endexpr )

	assert( typeGetClass( i_dtype ) = FB_DATACLASS_INTEGER )
	assert( typeGetClass( e_dtype ) = FB_DATACLASS_INTEGER )
	islarge = (typeGetSize( i_dtype ) = 8) or (typeGetSize( e_dtype ) = 8)

	if( islock ) then
		if( islarge ) then
			f = PROCLOOKUP( FILELOCKLARGE )
		else
			f = PROCLOOKUP( FILELOCK )
		end if
	else
		if( islarge ) then
			f = PROCLOOKUP( FILEUNLOCKLARGE )
		else
			f = PROCLOOKUP( FILEUNLOCK )
		end if
	end if

    proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval inipos as integer
    if( astNewARG( proc, iniexpr ) = NULL ) then
 		exit function
 	end if

    '' byval endpos as integer
    if( astNewARG( proc, endexpr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileRename _
	( _
		byval filename_new as ASTNODE ptr, _
        byval filename_old as ASTNODE ptr, _
        byval isfunc as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

    proc = astNewCALL( PROCLOOKUP( FILERENAME ) )

	'' byval filename_old as zstring ptr
    if( astNewARG( proc, filename_old ) = NULL ) then
 		exit function
 	end if

	'' byval filename_new as zstring ptr
    if( astNewARG( proc, filename_new ) = NULL ) then
 		exit function
 	end if

	if( isfunc = FALSE ) then
		astAdd( rtlErrorCheck( proc ) )
	end if

	function = proc
end function

'':::::
function rtlWidthFile _
	( _
		byval fnum as ASTNODE ptr, _
		byval width_arg as ASTNODE ptr, _
        byval isfunc as integer _
    ) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( WIDTHFILE ) )

    '' byval fnum as integer
    if( astNewARG( proc, fnum ) = NULL ) then
    	exit function
    end if

    '' byval width_arg as integer
    if( astNewARG( proc, width_arg ) = NULL ) then
    	exit function
    end if

	if( isfunc = FALSE ) then
		astAdd( rtlErrorCheck( proc ) )
	end if

	function = proc
end function
