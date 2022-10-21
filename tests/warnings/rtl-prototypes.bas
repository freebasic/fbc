#macro ID( text )
	#print text
#endmacro

#define fbcall
#define wchar wstring
#define wchar_ret wstring
#define bydesc ()

#print "---- rtlArray"

	ID( function fb_ArrayRedimEx )
	scope
		dim chk as function cdecl ( bydesc as any, byval as const uinteger, byval as const long, byval as const long, byval as const uinteger, ... ) as long
		chk = procptr( fb_ArrayRedimEx )
	end scope

	ID( function fb_ArrayRedimPresvEx )
	scope
		dim chk as function cdecl ( bydesc as any, byval as const uinteger, byval as const long, byval as const long, byval as const uinteger, ... ) as long
		chk = procptr( fb_ArrayRedimPresvEx )
	end scope

	ID( function fb_ArrayRedimObj )
	scope
		dim chk as function cdecl ( bydesc as any, byval as const uinteger, byval as any ptr, byval as any ptr, byval as const uinteger, ... ) as long
		chk = procptr( fb_ArrayRedimObj )
	end scope

	ID( function fb_ArrayRedimPresvObj )
	scope
		dim chk as function cdecl ( bydesc as any, byval as const uinteger, byval as any ptr, byval as any ptr, byval as const uinteger, ... ) as long
		chk = procptr( fb_ArrayRedimPresvObj )
	end scope

	ID( function fb_ArrayRedimTo )
	scope
		dim chk as function fbcall ( bydesc as any, bydesc as any, byval as const long, byval as any ptr, byval as any ptr ) as long
		chk = procptr( fb_ArrayRedimTo )
	end scope

	ID( sub fb_ArrayDestructObj )
	scope
		dim chk as sub fbcall ( bydesc as any, byval as any ptr )
		chk = procptr( fb_ArrayDestructObj )
	end scope

	ID( sub fb_ArrayDestructStr )
	scope
		dim chk as sub fbcall ( bydesc as any )
		chk = procptr( fb_ArrayDestructStr )
	end scope

	ID( function fb_ArrayClear )
	scope
		dim chk as function fbcall ( bydesc as any ) as long
		chk = procptr( fb_ArrayClear )
	end scope

	ID( function fb_ArrayClearObj )
	scope
		dim chk as function fbcall ( bydesc as any, byval as any ptr, byval as any ptr ) as long
		chk = procptr( fb_ArrayClearObj )
	end scope

	ID( function fb_ArrayErase )
	scope
		dim chk as function fbcall ( bydesc as any ) as long
		chk = procptr( fb_ArrayErase )
	end scope

	ID( function fb_ArrayEraseObj )
	scope
		dim chk as function fbcall ( bydesc as any, byval as any ptr, byval as any ptr ) as long
		chk = procptr( fb_ArrayEraseObj )
	end scope

	ID( sub fb_ArrayStrErase )
	scope
		dim chk as sub fbcall ( bydesc as any )
		chk = procptr( fb_ArrayStrErase )
	end scope

	ID( function fb_ArrayLBound )
	scope
		dim chk as function fbcall ( bydesc as const any, byval as const integer ) as integer
		chk = procptr( fb_ArrayLBound )
	end scope

	ID( function fb_ArrayUBound )
	scope
		dim chk as function fbcall ( bydesc as const any, byval as const integer ) as integer
		chk = procptr( fb_ArrayUBound )
	end scope

	ID( function fb_ArraySngBoundChk )
	scope
		dim chk as function fbcall ( byval as const uinteger, byval as const uinteger, byval as const long, byval as const zstring ptr ) as any ptr
		chk = procptr( fb_ArraySngBoundChk )
	end scope

	ID( function fb_ArrayBoundChk )
	scope
		dim chk as function fbcall ( byval as const integer, byval as const integer, byval as const integer, byval as const long, byval as const zstring ptr ) as any ptr
		chk = procptr( fb_ArrayBoundChk )
	end scope

#print "---- rtlConsole"

	ID( function fb_ConsoleView )
	scope
		dim chk as function fbcall ( byval as const long = 0, byval as const long = 0 ) as long
		chk = procptr( fb_ConsoleView )
	end scope

	ID( function fb_ReadXY )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, byval as const long = 0 ) as ulong
		chk = procptr( fb_ReadXY )
	end scope

	ID( function fb_Width )
	scope
		dim chk as function fbcall ( byval as const long = -1, byval as const long = -1 ) as long
		chk = procptr( fb_Width )
	end scope

	ID( function fb_WidthDev )
	scope
		dim chk as function fbcall ( byref as const string, byval as const long = -1 ) as long
		chk = procptr( fb_WidthDev )
	end scope

	ID( function fb_WidthFile )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long = -1 ) as long
		chk = procptr( fb_WidthFile )
	end scope

	ID( function locate alias "fb_Locate" )
	scope
		dim chk as function fbcall ( byval as const long = 0, byval as const long = 0, byval as const long = -1, byval as const long = 0, byval as const long = 0 ) as long
		chk = procptr( locate )
	end scope

	ID( function pos alias "fb_GetX" )
	scope
		dim chk as function fbcall ( ) as long
		chk = procptr( pos )
	end scope

	ID( function pos alias "fb_Pos" )
	scope
		dim chk as function fbcall ( byval as const long ) as long
		chk = procptr( pos )
	end scope

	ID( function csrlin alias "fb_GetY" )
	scope
		dim chk as function fbcall ( ) as long
		chk = procptr( csrlin )
	end scope

	ID( sub cls alias "fb_Cls" )
	scope
		dim chk as sub fbcall ( byval as const long = -65536 )
		chk = procptr( cls )
	end scope

	ID( function fb_Color )
	scope
		dim chk as function fbcall ( byval as const ulong, byval as const ulong, byval as const long ) as ulong
		chk = procptr( fb_Color )
	end scope

	ID( function inkey alias "fb_Inkey" )
	scope
		dim chk as function fbcall ( ) as string
		chk = procptr( inkey )
	end scope

#if __FB_LANG__ = "qb"
	ID( function inkey alias "fb_InkeyQB" )
	scope
		dim chk as function fbcall ( ) as string
		chk = procptr( inkey )
	end scope
#endif

	ID( function getkey alias "fb_Getkey" )
	scope
		dim chk as function fbcall ( ) as long
		chk = procptr( getkey )
	end scope

	ID( function pcopy alias "fb_PageCopy" )
	scope
		dim chk as function fbcall ( byval as const long = -1, byval as const long = -1 ) as long
		chk = procptr( pcopy )
	end scope

	ID( function fb_PageSet )
	scope
		dim chk as function fbcall ( byval as const long = -1, byval as const long = -1 ) as long
		chk = procptr( fb_PageSet )
	end scope

#print "---- rtlData"

	ID( sub fb_DataRestore )
	scope
		dim chk as sub fbcall ( byval as any ptr )
		chk = procptr( fb_DataRestore )
	end scope

	ID( sub fb_DataReadStr )
	scope
		dim chk as sub fbcall ( byref as any, byval as const integer, byval as const long = 1 )
		chk = procptr( fb_DataReadStr )
	end scope

	ID( sub fb_DataReadWstr )
	scope
		dim chk as sub fbcall ( byval as wchar ptr, byval as const integer )
		chk = procptr( fb_DataReadWstr )
	end scope

	ID( sub fb_DataReadBool )
	scope
		dim chk as sub fbcall ( byref as boolean )
		chk = procptr( fb_DataReadBool )
	end scope

	ID( sub fb_DataReadByte )
	scope
		dim chk as sub fbcall ( byref as byte )
		chk = procptr( fb_DataReadByte )
	end scope

	ID( sub fb_DataReadShort )
	scope
		dim chk as sub fbcall ( byref as short )
		chk = procptr( fb_DataReadShort )
	end scope

	ID( sub fb_DataReadInt )
	scope
		dim chk as sub fbcall ( byref as long )
		chk = procptr( fb_DataReadInt )
	end scope

	ID( sub fb_DataReadLongint )
	scope
		dim chk as sub fbcall ( byref as longint )
		chk = procptr( fb_DataReadLongint )
	end scope

	ID( sub fb_DataReadUByte )
	scope
		dim chk as sub fbcall ( byref as ubyte )
		chk = procptr( fb_DataReadUByte )
	end scope

	ID( sub fb_DataReadUShort )
	scope
		dim chk as sub fbcall ( byref as ushort )
		chk = procptr( fb_DataReadUShort )
	end scope

	ID( sub fb_DataReadUInt )
	scope
		dim chk as sub fbcall ( byref as ulong )
		chk = procptr( fb_DataReadUInt )
	end scope

	ID( sub fb_DataReadULongint )
	scope
		dim chk as sub fbcall ( byref as ulongint )
		chk = procptr( fb_DataReadULongint )
	end scope

	ID( sub fb_DataReadSingle )
	scope
		dim chk as sub fbcall ( byref as single )
		chk = procptr( fb_DataReadSingle )
	end scope

	ID( sub fb_DataReadDouble )
	scope
		dim chk as sub fbcall ( byref as double )
		chk = procptr( fb_DataReadDouble )
	end scope

#print "---- rtlError"

	ID( function fb_ErrorThrowAt )
	scope
		dim chk as function cdecl ( byval as const long, byval as const zstring ptr, byval as const any ptr, byval as const any ptr ) as any ptr
		chk = procptr( fb_ErrorThrowAt )
	end scope

	ID( function fb_ErrorThrowEx )
	scope
		dim chk as function cdecl ( byval as const long, byval as const long, byval as const zstring ptr, byval as const any ptr, byval as const any ptr ) as any ptr
		chk = procptr( fb_ErrorThrowEx )
	end scope

	ID( function fb_ErrorSetHandler )
	scope
		dim chk as function fbcall ( byval as any ptr ) as any ptr
		chk = procptr( fb_ErrorSetHandler )
	end scope

	ID( function fb_ErrorGetNum )
	scope
		dim chk as function fbcall ( ) as long
		chk = procptr( fb_ErrorGetNum )
	end scope

	ID( function fb_ErrorSetNum )
	scope
		dim chk as function fbcall ( byval as const long ) as long
		chk = procptr( fb_ErrorSetNum )
	end scope

	ID( function fb_ErrorResume )
	scope
		dim chk as function cdecl ( ) as any ptr
		chk = procptr( fb_ErrorResume )
	end scope

	ID( function fb_ErrorResumeNext )
	scope
		dim chk as function cdecl ( ) as any ptr
		chk = procptr( fb_ErrorResumeNext )
	end scope

	ID( function erl alias "fb_ErrorGetLineNum" )
	scope
		dim chk as function fbcall ( ) as long
		chk = procptr( erl )
	end scope

	ID( function erfn alias "fb_ErrorGetFuncName" )
	scope
		dim chk as function fbcall ( ) as zstring ptr
		chk = procptr( erfn )
	end scope

	ID( function ermn alias "fb_ErrorGetModName" )
	scope
		dim chk as function fbcall ( ) as zstring ptr
		chk = procptr( ermn )
	end scope

	ID( function fb_ErrorSetModName )
	scope
		dim chk as function fbcall ( byval as const zstring ptr ) as zstring ptr
		chk = procptr( fb_ErrorSetModName )
	end scope

	ID( function fb_ErrorSetFuncName )
	scope
		dim chk as function fbcall ( byval as const zstring ptr ) as zstring ptr
		chk = procptr( fb_ErrorSetFuncName )
	end scope

	ID( sub fb_Assert )
	scope
		dim chk as sub fbcall ( byval as const zstring ptr, byval as const integer, byval as const zstring ptr, byval as const zstring ptr )
		chk = procptr( fb_Assert )
	end scope

	ID( sub fb_Assert alias "fb_AssertW" )
	scope
		dim chk as sub fbcall ( byval as const zstring ptr, byval as const long, byval as const zstring ptr, byval as const wchar ptr )
		chk = procptr( fb_Assert )
	end scope

	ID( sub fb_AssertWarn )
	scope
		dim chk as sub fbcall ( byval as const zstring ptr, byval as const long, byval as const zstring ptr, byval as const zstring ptr )
		chk = procptr( fb_AssertWarn )
	end scope

	ID( sub fb_AssertWarn alias "fb_AssertWarnW" )
	scope
		dim chk as sub fbcall ( byval as const zstring ptr, byval as const long, byval as const zstring ptr, byval as const wchar ptr )
		chk = procptr( fb_AssertWarn )
	end scope

#print "---- rtlFile"

	ID( function fb_FileOpen )
	scope
		dim chk as function fbcall ( byref as const string, byval as const ulong, byval as const ulong, byval as const ulong, byval as const long, byval as const long ) as long
		chk = procptr( fb_FileOpen )
	end scope

	ID( function fb_FileOpenEncod )
	scope
		dim chk as function fbcall ( byref as const string, byval as const ulong, byval as const ulong, byval as const ulong, byval as const long, byval as const long, byval as const zstring ptr ) as long
		chk = procptr( fb_FileOpenEncod )
	end scope

	ID( function fb_FileOpenShort )
	scope
		dim chk as function fbcall ( byref as const string, byval as const long, byref as const string, byval as const long, byref as const string, byref as const string ) as long
		chk = procptr( fb_FileOpenShort )
	end scope

	ID( function fb_FileOpenCons )
	scope
		dim chk as function fbcall ( byref as const string, byval as const ulong, byval as const ulong, byval as const ulong, byval as const long, byval as const long, byval as const zstring ptr ) as long
		chk = procptr( fb_FileOpenCons )
	end scope

	ID( function fb_FileOpenErr )
	scope
		dim chk as function fbcall ( byref as const string, byval as const ulong, byval as const ulong, byval as const ulong, byval as const long, byval as const long, byval as const zstring ptr ) as long
		chk = procptr( fb_FileOpenErr )
	end scope

	ID( function fb_FileOpenPipe )
	scope
		dim chk as function fbcall ( byref as const string, byval as const ulong, byval as const ulong, byval as const ulong, byval as const long, byval as const long, byval as const zstring ptr ) as long
		chk = procptr( fb_FileOpenPipe )
	end scope

	ID( function fb_FileOpenScrn )
	scope
		dim chk as function fbcall ( byref as const string, byval as const ulong, byval as const ulong, byval as const ulong, byval as const long, byval as const long, byval as const zstring ptr ) as long
		chk = procptr( fb_FileOpenScrn )
	end scope

	ID( function fb_FileOpenLpt )
	scope
		dim chk as function fbcall ( byref as const string, byval as const ulong, byval as const ulong, byval as const ulong, byval as const long, byval as const long, byval as const zstring ptr ) as long
		chk = procptr( fb_FileOpenLpt )
	end scope

	ID( function fb_FileOpenCom )
	scope
		dim chk as function fbcall ( byref as const string, byval as const ulong, byval as const ulong, byval as const ulong, byval as const long, byval as const long, byval as const zstring ptr ) as long
		chk = procptr( fb_FileOpenCom )
	end scope

	ID( function fb_FileOpenQB )
	scope
		dim chk as function fbcall ( byref as const string, byval as const ulong, byval as const ulong, byval as const ulong, byval as const long, byval as const long ) as long
		chk = procptr( fb_FileOpenQB )
	end scope

	ID( function fb_FileClose )
	scope
		dim chk as function fbcall ( byval as const long ) as long
		chk = procptr( fb_FileClose )
	end scope

	ID( function fb_FileCloseAll )
	scope
		dim chk as function fbcall ( ) as long
		chk = procptr( fb_FileCloseAll )
	end scope

	ID( function fb_FilePut )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, byref as const any, byval as const uinteger ) as long
		chk = procptr( fb_FilePut )
	end scope

	ID( function fb_FilePutLarge )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, byref as const any, byval as const uinteger ) as long
		chk = procptr( fb_FilePutLarge )
	end scope

	ID( function fb_FilePutStr )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, byref as const any, byval as const integer ) as long
		chk = procptr( fb_FilePutStr )
	end scope

	ID( function fb_FilePutStrLarge )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, byref as const any, byval as const integer ) as long
		chk = procptr( fb_FilePutStrLarge )
	end scope

	ID( function fb_FilePutArray )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, bydesc as const any ) as long
		chk = procptr( fb_FilePutArray )
	end scope

	ID( function fb_FilePutArrayLarge )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, bydesc as const any ) as long
		chk = procptr( fb_FilePutArrayLarge )
	end scope

	ID( function fb_FileGet )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, byref as any, byval as const uinteger ) as long
		chk = procptr( fb_FileGet )
	end scope

	ID( function fb_FileGetLarge )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, byref as any, byval as const uinteger ) as long
		chk = procptr( fb_FileGetLarge )
	end scope

	ID( function fb_FileGetStr )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, byref as any, byval as const integer ) as long
		chk = procptr( fb_FileGetStr )
	end scope

	ID( function fb_FileGetWstr )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, byref as wchar, byval as const integer ) as long
		chk = procptr( fb_FileGetWstr )
	end scope

	ID( function fb_FileGetStrLarge )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, byref as any, byval as const integer ) as long
		chk = procptr( fb_FileGetStrLarge )
	end scope

	ID( function fb_FileGetWstrLarge )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, byref as wchar, byval as const integer ) as long
		chk = procptr( fb_FileGetWstrLarge )
	end scope

	ID( function fb_FileGetArray )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, bydesc as any ) as long
		chk = procptr( fb_FileGetArray )
	end scope

	ID( function fb_FileGetArrayLarge )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, bydesc as any ) as long
		chk = procptr( fb_FileGetArrayLarge )
	end scope

	ID( function fb_FileGetIOB )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, byref as any, byval as const uinteger, byref as uinteger ) as long
		chk = procptr( fb_FileGetIOB )
	end scope

	ID( function fb_FileGetLargeIOB )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, byref as any, byval as const uinteger, byref as uinteger ) as long
		chk = procptr( fb_FileGetLargeIOB )
	end scope

	ID( function fb_FileGetStrIOB )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, byref as any, byval as const integer, byref as uinteger ) as long
		chk = procptr( fb_FileGetStrIOB )
	end scope

	ID( function fb_FileGetWstrIOB )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, byref as wchar, byval as const integer, byref as uinteger ) as long
		chk = procptr( fb_FileGetWstrIOB )
	end scope

	ID( function fb_FileGetStrLargeIOB )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, byref as any, byval as const integer, byref as uinteger ) as long
		chk = procptr( fb_FileGetStrLargeIOB )
	end scope

	ID( function fb_FileGetWstrLargeIOB )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, byref as wchar, byval as const integer, byref as uinteger ) as long
		chk = procptr( fb_FileGetWstrLargeIOB )
	end scope

	ID( function fb_FileGetArrayIOB )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, bydesc as any, byref as uinteger ) as long
		chk = procptr( fb_FileGetArrayIOB )
	end scope

	ID( function fb_FileGetArrayLargeIOB )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, bydesc as any, byref as uinteger ) as long
		chk = procptr( fb_FileGetArrayLargeIOB )
	end scope

	ID( function fb_FileTell )
	scope
		dim chk as function fbcall ( byval as const long ) as longint
		chk = procptr( fb_FileTell )
	end scope

	ID( function fb_FileSeek )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long ) as long
		chk = procptr( fb_FileSeek )
	end scope

	ID( function fb_FileSeekLarge )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint ) as long
		chk = procptr( fb_FileSeekLarge )
	end scope

	ID( function fb_FileStrInput )
	scope
		dim chk as function fbcall ( byval as const integer, byval as const long = 0 ) as string
		chk = procptr( fb_FileStrInput )
	end scope

	ID( function fb_FileLineInput )
	scope
		dim chk as function fbcall ( byval as const long, byref as any, byval as const integer, byval as const long = 1 ) as long
		chk = procptr( fb_FileLineInput )
	end scope

	ID( function fb_FileLineInputWstr )
	scope
		dim chk as function fbcall ( byval as const long, byval as wchar ptr, byval as const integer ) as long
		chk = procptr( fb_FileLineInputWstr )
	end scope

	ID( function fb_LineInput )
	scope
		dim chk as function fbcall ( byref as const string, byref as any, byval as const integer, byval as const long, byval as const long, byval as const long = 1 ) as long
		chk = procptr( fb_LineInput )
	end scope

	ID( function fb_LineInputWstr )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as wchar ptr, byval as const integer, byval as const long, byval as const long ) as long
		chk = procptr( fb_LineInputWstr )
	end scope

	ID( function fb_FileInput )
	scope
		dim chk as function fbcall ( byval as const long ) as long
		chk = procptr( fb_FileInput )
	end scope

	ID( function fb_ConsoleInput )
	scope
		dim chk as function fbcall ( byref as const string, byval as const long, byval as const long ) as long
		chk = procptr( fb_ConsoleInput )
	end scope

	ID( function fb_InputBool )
	scope
		dim chk as function fbcall ( byref as boolean ) as long
		chk = procptr( fb_InputBool )
	end scope

	ID( function fb_InputByte )
	scope
		dim chk as function fbcall ( byref as byte ) as long
		chk = procptr( fb_InputByte )
	end scope

	ID( function fb_InputUbyte )
	scope
		dim chk as function fbcall ( byref as ubyte ) as long
		chk = procptr( fb_InputUbyte )
	end scope

	ID( function fb_InputShort )
	scope
		dim chk as function fbcall ( byref as short ) as long
		chk = procptr( fb_InputShort )
	end scope

	ID( function fb_InputUshort )
	scope
		dim chk as function fbcall ( byref as ushort ) as long
		chk = procptr( fb_InputUshort )
	end scope

	ID( function fb_InputInt )
	scope
		dim chk as function fbcall ( byref as long ) as long
		chk = procptr( fb_InputInt )
	end scope

	ID( function fb_InputUint )
	scope
		dim chk as function fbcall ( byref as ulong ) as long
		chk = procptr( fb_InputUint )
	end scope

	ID( function fb_InputLongint )
	scope
		dim chk as function fbcall ( byref as longint ) as long
		chk = procptr( fb_InputLongint )
	end scope

	ID( function fb_InputUlongint )
	scope
		dim chk as function fbcall ( byref as ulongint ) as long
		chk = procptr( fb_InputUlongint )
	end scope

	ID( function fb_InputSingle )
	scope
		dim chk as function fbcall ( byref as single ) as long
		chk = procptr( fb_InputSingle )
	end scope

	ID( function fb_InputDouble )
	scope
		dim chk as function fbcall ( byref as double ) as long
		chk = procptr( fb_InputDouble )
	end scope

	ID( function fb_InputString )
	scope
		dim chk as function fbcall ( byref as any, byval as const integer, byval as const long = 1 ) as long
		chk = procptr( fb_InputString )
	end scope

	ID( function fb_InputWstr )
	scope
		dim chk as function fbcall ( byval as wchar ptr, byval as const integer ) as long
		chk = procptr( fb_InputWstr )
	end scope

	ID( function fb_FileLock )
	scope
		dim chk as function fbcall ( byval as const long, byval as const ulong, byval as const ulong = 0 ) as long
		chk = procptr( fb_FileLock )
	end scope

	ID( function fb_FileLockLarge )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, byval as const longint = 0 ) as long
		chk = procptr( fb_FileLockLarge )
	end scope

	ID( function fb_FileUnlock )
	scope
		dim chk as function fbcall ( byval as const long, byval as const ulong, byval as const ulong = 0 ) as long
		chk = procptr( fb_FileUnlock )
	end scope

	ID( function fb_FileUnlockLarge )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, byval as const longint = 0 ) as long
		chk = procptr( fb_FileUnlockLarge )
	end scope

	ID( function fb_rename alias "rename" )
	scope
		dim chk as function cdecl ( byval as const zstring ptr, byval as const zstring ptr ) as long
		chk = procptr( fb_rename )
	end scope

	ID( function fb_FileWstrInput )
	scope
		dim chk as function fbcall ( byval as const integer, byval as const long = 0 ) as wchar_ret
		chk = procptr( fb_FileWstrInput )
	end scope

	ID( function freefile alias "fb_FileFree" )
	scope
		dim chk as function fbcall ( ) as long
		chk = procptr( freefile )
	end scope

	ID( function eof alias "fb_FileEof" )
	scope
		dim chk as function fbcall ( byval as const long ) as long
		chk = procptr( eof )
	end scope

	ID( function kill alias "fb_FileKill" )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( kill )
	end scope

	ID( sub reset alias "fb_FileReset" )
	scope
		dim chk as sub fbcall ( )
		chk = procptr( reset )
	end scope

	ID( sub reset alias "fb_FileResetEx" )
	scope
		dim chk as sub fbcall ( byval as const long )
		chk = procptr( reset )
	end scope

	ID( function lof alias "fb_FileSize" )
	scope
		dim chk as function fbcall ( byval as const long ) as longint
		chk = procptr( lof )
	end scope

	ID( function loc alias "fb_FileLocation" )
	scope
		dim chk as function fbcall ( byval as const long ) as longint
		chk = procptr( loc )
	end scope

	ID( function lpos alias "fb_LPos" )
	scope
		dim chk as function fbcall ( byval as const long ) as long
		chk = procptr( lpos )
	end scope

#print "---- rtlGfx"

	ID( sub fb_GfxPset )
	scope
		dim chk as sub fbcall ( byval as any ptr = 0, byval as const single, byval as const single, byval as const ulong, byval as const long, byval as const long )
		chk = procptr( fb_GfxPset )
	end scope

	ID( function fb_GfxPoint )
	scope
		dim chk as function fbcall ( byval as any ptr = 0, byval as const single, byval as const single ) as ulong
		chk = procptr( fb_GfxPoint )
	end scope

	ID( sub fb_GfxLine )
	scope
		dim chk as sub fbcall ( byval as any ptr = 0, byval as const single, byval as const single, byval as const single, byval as const single, byval as const ulong, byval as const long, byval as const ulong = 65535, byval as const long )
		chk = procptr( fb_GfxLine )
	end scope

	ID( sub fb_GfxEllipse )
	scope
		dim chk as sub fbcall ( byval as any ptr = 0, byval as const single, byval as const single, byval as const single, byval as const ulong, byval as const single, byval as const single, byval as const single, byval as const long, byval as const long )
		chk = procptr( fb_GfxEllipse )
	end scope

	ID( sub fb_GfxPaint )
	scope
		dim chk as sub fbcall ( byval as any ptr = 0, byval as const single, byval as const single, byval as const ulong, byval as const ulong, byref as const string, byval as const long, byval as const long )
		chk = procptr( fb_GfxPaint )
	end scope

	ID( sub fb_GfxDraw )
	scope
		dim chk as sub fbcall ( byval as any ptr = 0, byref as const string )
		chk = procptr( fb_GfxDraw )
	end scope

	ID( function fb_GfxDrawString )
	scope
		dim chk as function fbcall ( byval as any ptr = 0, byval as const single, byval as const single, byval as const long, byref as const string, byval as const ulong, byval as const any ptr = 0, byval as const long, byval as any ptr, byval as any ptr = 0, byval as any ptr ) as integer
		chk = procptr( fb_GfxDrawString )
	end scope

	ID( sub fb_GfxView )
	scope
		dim chk as sub fbcall ( byval as const long = -32768, byval as const long = -32768, byval as const long = -32768, byval as const long = -32768, byval as const ulong = 0, byval as const ulong = 0, byval as const long )
		chk = procptr( fb_GfxView )
	end scope

	ID( sub fb_GfxWindow )
	scope
		dim chk as sub fbcall ( byval as const single = 0, byval as const single = 0, byval as const single = 0, byval as const single = 0, byval as const long = 0 )
		chk = procptr( fb_GfxWindow )
	end scope

	ID( sub fb_GfxPalette )
	scope
		dim chk as sub fbcall ( byval as const long = -1, byval as const long = -1, byval as const long = -1, byval as const long = -1 )
		chk = procptr( fb_GfxPalette )
	end scope

	ID( sub fb_GfxPaletteUsing )
	scope
		dim chk as sub fbcall ( byval as const long ptr )
		chk = procptr( fb_GfxPaletteUsing )
	end scope

	ID( sub fb_GfxPaletteUsing64 )
	scope
		dim chk as sub fbcall ( byval as const longint ptr )
		chk = procptr( fb_GfxPaletteUsing64 )
	end scope

	ID( sub fb_GfxPaletteGet )
	scope
		dim chk as sub fbcall ( byval as const long = -1, byref as long, byref as long, byref as long )
		chk = procptr( fb_GfxPaletteGet )
	end scope

	ID( sub fb_GfxPaletteGet64 )
	scope
		dim chk as sub fbcall ( byval as const long = -1, byref as longint, byref as longint, byref as longint )
		chk = procptr( fb_GfxPaletteGet64 )
	end scope

	ID( sub fb_GfxPaletteGetUsing )
	scope
		dim chk as sub fbcall ( byval as long ptr )
		chk = procptr( fb_GfxPaletteGetUsing )
	end scope

	ID( sub fb_GfxPaletteGetUsing64 )
	scope
		dim chk as sub fbcall ( byval as longint ptr )
		chk = procptr( fb_GfxPaletteGetUsing64 )
	end scope

	ID( function fb_GfxPut )
	scope
		dim chk as function fbcall ( byval as any ptr = 0, byval as const single, byval as const single, byval as const any ptr, byval as const long = -65536, byval as const long = -65536, byval as const long = -65536, byval as const long = -65536, byval as const long, byval as const long, byval as any ptr, byval as const long = -1, byval as any ptr = 0, byval as any ptr = 0 ) as long
		chk = procptr( fb_GfxPut )
	end scope

	ID( function fb_GfxGet )
	scope
		dim chk as function fbcall ( byval as const any ptr = 0, byval as const single, byval as const single, byval as const single, byval as const single, byval as any ptr, byval as const long, bydesc as const any ) as long
		chk = procptr( fb_GfxGet )
	end scope

#if __FB_LANG__ <> "fb"
	ID( function fb_GfxGetQB )
	scope
		dim chk as function fbcall ( byval as const any ptr = 0, byval as const single, byval as const single, byval as const single, byval as const single, byval as any ptr, byval as const long, bydesc as any ) as long
		chk = procptr( fb_GfxGetQB )
	end scope
#endif

	ID( function fb_GfxScreen )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long = 8, byval as const long = 0, byval as const long = 0, byval as const long = 0 ) as long
		chk = procptr( fb_GfxScreen )
	end scope

	ID( function fb_GfxScreenQB )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long = -1, byval as const long = -1 ) as long
		chk = procptr( fb_GfxScreenQB )
	end scope

	ID( function screenres alias "fb_GfxScreenRes" )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, byval as const long = 8, byval as const long = 1, byval as const long = 0, byval as const long = 0 ) as long
		chk = procptr( screenres )
	end scope

	ID( function bload alias "fb_GfxBload" )
	scope
		dim chk as function fbcall ( byref as const string, byval as any ptr = 0, byval as any ptr = 0 ) as long
		chk = procptr( bload )
	end scope

#if __FB_LANG__ <> "fb"
	ID( function bload alias "fb_GfxBloadQB" )
	scope
		dim chk as function fbcall ( byref as const string, byval as any ptr = 0, byval as any ptr = 0 ) as long
		chk = procptr( bload )
	end scope
#endif

	ID( function bsave alias "fb_GfxBsave" )
	scope
		dim chk as function fbcall ( byref as const string, byval as const any ptr, byval as const ulong = 0, byval as const any ptr = 0 ) as long
		chk = procptr( bsave )
	end scope

	ID( function bsave alias "fb_GfxBsaveEx" )
	scope
		dim chk as function fbcall ( byref as const string, byval as const any ptr, byval as const ulong = 0, byval as const any ptr, byval as const long ) as long
		chk = procptr( bsave )
	end scope

	ID( function flip alias "fb_GfxFlip" )
	scope
		dim chk as function fbcall ( byval as const long = -1, byval as const long = -1 ) as long
		chk = procptr( flip )
	end scope

	ID( function screencopy alias "fb_GfxFlip" )
	scope
		dim chk as function fbcall ( byval as const long = -1, byval as const long = -1 ) as long
		chk = procptr( screencopy )
	end scope

	ID( function pointcoord alias "fb_GfxCursor" )
	scope
		dim chk as function fbcall ( byval as const long ) as single
		chk = procptr( pointcoord )
	end scope

	ID( function pmap alias "fb_GfxPMap" )
	scope
		dim chk as function fbcall ( byval as const single, byval as const long ) as single
		chk = procptr( pmap )
	end scope

	ID( function out alias "fb_Out" )
	scope
		dim chk as function fbcall ( byval as const ushort, byval as const ubyte ) as long
		chk = procptr( out )
	end scope

	ID( function inp alias "fb_In" )
	scope
		dim chk as function fbcall ( byval as const ushort ) as long
		chk = procptr( inp )
	end scope

	ID( function wait alias "fb_Wait" )
	scope
		dim chk as function fbcall ( byval as const ushort, byval as const long, byval as const long = 0 ) as long
		chk = procptr( wait )
	end scope

	ID( function screensync alias "fb_GfxWaitVSync" )
	scope
		dim chk as function fbcall ( ) as long
		chk = procptr( screensync )
	end scope

	ID( function screenset alias "fb_GfxPageSet" )
	scope
		dim chk as function cdecl ( byval as const long = -1, byval as const long = -1 ) as long
		chk = procptr( screenset )
	end scope

	ID( sub screenlock alias "fb_GfxLock" )
	scope
		dim chk as sub fbcall ( )
		chk = procptr( screenlock )
	end scope

	ID( sub screenunlock alias "fb_GfxUnlock" )
	scope
		dim chk as sub fbcall ( byval as const long = -1, byval as const long = -1 )
		chk = procptr( screenunlock )
	end scope

	ID( function screenptr alias "fb_GfxScreenPtr" )
	scope
		dim chk as function fbcall ( ) as any ptr
		chk = procptr( screenptr )
	end scope

	ID( sub windowtitle alias "fb_GfxSetWindowTitle" )
	scope
		dim chk as sub fbcall ( byref as const string )
		chk = procptr( windowtitle )
	end scope

	ID( function multikey alias "fb_Multikey" )
	scope
		dim chk as function fbcall ( byval as const long ) as long
		chk = procptr( multikey )
	end scope

	ID( function getmouse alias "fb_GetMouse" )
	scope
		dim chk as function fbcall ( byref as long, byref as long, byref as long = 0, byref as long = 0, byref as long = 0 ) as long
		chk = procptr( getmouse )
	end scope

	ID( function getmouse alias "fb_GetMouse64" )
	scope
		dim chk as function fbcall ( byref as longint, byref as longint, byref as longint = 0, byref as longint = 0, byref as longint = 0 ) as long
		chk = procptr( getmouse )
	end scope

	ID( function setmouse alias "fb_SetMouse" )
	scope
		dim chk as function fbcall ( byval as const long = -2147483648, byval as const long = -2147483648, byval as const long = -1, byval as const long = -1 ) as long
		chk = procptr( setmouse )
	end scope

	ID( function getjoystick alias "fb_GfxGetJoystick" )
	scope
		dim chk as function fbcall ( byval as const long, byref as integer = 0, byref as single = 0, byref as single = 0, byref as single = 0, byref as single = 0, byref as single = 0, byref as single = 0, byref as single = 0, byref as single = 0 ) as long
		chk = procptr( getjoystick )
	end scope

#if __FB_LANG__ = "qb"
	ID( function stick alias "fb_GfxStickQB" )
	scope
		dim chk as function fbcall ( byval as const long ) as long
		chk = procptr( stick )
	end scope
#endif

#if __FB_LANG__ = "qb"
	ID( function strig alias "fb_GfxStrigQB" )
	scope
		dim chk as function fbcall ( byval as const long ) as long
		chk = procptr( strig )
	end scope
#endif

	ID( sub screeninfo alias "fb_GfxScreenInfo32" )
	scope
		dim chk as sub fbcall ( byref as long = 0, byref as long = 0, byref as long = 0, byref as long = 0, byref as long = 0, byref as long = 0, byref as string = "" )
		chk = procptr( screeninfo )
	end scope

	ID( sub screeninfo alias "fb_GfxScreenInfo64" )
	scope
		dim chk as sub fbcall ( byref as longint, byref as longint, byref as longint = 0, byref as longint = 0, byref as longint = 0, byref as longint = 0, byref as string = "" )
		chk = procptr( screeninfo )
	end scope

	ID( function screenlist alias "fb_GfxScreenList" )
	scope
		dim chk as function fbcall ( byval as const long = 0 ) as long
		chk = procptr( screenlist )
	end scope

	ID( function fb_GfxImageCreate )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, byval as const ulong = 0, byval as const long = 0, byval as const long = 0 ) as any ptr
		chk = procptr( fb_GfxImageCreate )
	end scope

	ID( function fb_GfxImageCreateQB )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long, byval as const ulong = 0, byval as const long = 0, byval as const long = 0 ) as any ptr
		chk = procptr( fb_GfxImageCreateQB )
	end scope

	ID( sub imagedestroy alias "fb_GfxImageDestroy" )
	scope
		dim chk as sub fbcall ( byval as const any ptr )
		chk = procptr( imagedestroy )
	end scope

	ID( function imageinfo alias "fb_GfxImageInfo32" )
	scope
		dim chk as function fbcall ( byval as const any ptr, byref as long = 0, byref as long = 0, byref as long = 0, byref as long = 0, byref as any ptr = 0, byref as long = 0 ) as long
		chk = procptr( imageinfo )
	end scope

	ID( function imageinfo alias "fb_GfxImageInfo64" )
	scope
		dim chk as function fbcall ( byval as const any ptr, byref as longint, byref as longint, byref as longint = 0, byref as longint = 0, byref as any ptr = 0, byref as longint = 0 ) as long
		chk = procptr( imageinfo )
	end scope

	ID( sub imageconvertrow alias "fb_GfxImageConvertRow" )
	scope
		dim chk as sub fbcall ( byval as const any ptr, byval as const long, byval as any ptr, byval as const long, byval as const long, byval as const long = 1 )
		chk = procptr( imageconvertrow )
	end scope

	ID( function screenevent alias "fb_GfxEvent" )
	scope
		dim chk as function fbcall ( byval as any ptr = 0 ) as long
		chk = procptr( screenevent )
	end scope

	ID( sub screencontrol alias "fb_GfxControl_s" )
	scope
		dim chk as sub fbcall ( byval as const long, byref as string )
		chk = procptr( screencontrol )
	end scope

	ID( sub screencontrol alias "fb_GfxControl_i32" )
	scope
		dim chk as sub fbcall ( byval as const long, byref as long = -2147483648, byref as long = -2147483648, byref as long = -2147483648, byref as long = -2147483648 )
		chk = procptr( screencontrol )
	end scope

	ID( sub screencontrol alias "fb_GfxControl_i64" )
	scope
		dim chk as sub fbcall ( byval as const long, byref as longint, byref as longint = -2147483648, byref as longint = -2147483648, byref as longint = -2147483648 )
		chk = procptr( screencontrol )
	end scope

	ID( function screenglproc alias "fb_GfxGetGLProcAddress" )
	scope
		dim chk as function fbcall ( byval as const zstring ptr ) as any ptr
		chk = procptr( screenglproc )
	end scope

	ID( sub fb_hPutTrans )
	scope
		dim chk as sub cdecl ( byval as const ubyte ptr, byval as ubyte ptr, byval as const long, byval as const long, byval as const long, byval as const long, byval as const long, byval as any ptr, byval as any ptr )
		chk = procptr( fb_hPutTrans )
	end scope

	ID( sub fb_hPutPSet )
	scope
		dim chk as sub cdecl ( byval as const ubyte ptr, byval as ubyte ptr, byval as const long, byval as const long, byval as const long, byval as const long, byval as const long, byval as any ptr, byval as any ptr )
		chk = procptr( fb_hPutPSet )
	end scope

	ID( sub fb_hPutPReset )
	scope
		dim chk as sub cdecl ( byval as const ubyte ptr, byval as ubyte ptr, byval as const long, byval as const long, byval as const long, byval as const long, byval as const long, byval as any ptr, byval as any ptr )
		chk = procptr( fb_hPutPReset )
	end scope

	ID( sub fb_hPutAnd )
	scope
		dim chk as sub cdecl ( byval as const ubyte ptr, byval as ubyte ptr, byval as const long, byval as const long, byval as const long, byval as const long, byval as const long, byval as any ptr, byval as any ptr )
		chk = procptr( fb_hPutAnd )
	end scope

	ID( sub fb_hPutOr )
	scope
		dim chk as sub cdecl ( byval as const ubyte ptr, byval as ubyte ptr, byval as const long, byval as const long, byval as const long, byval as const long, byval as const long, byval as any ptr, byval as any ptr )
		chk = procptr( fb_hPutOr )
	end scope

	ID( sub fb_hPutXor )
	scope
		dim chk as sub cdecl ( byval as const ubyte ptr, byval as ubyte ptr, byval as const long, byval as const long, byval as const long, byval as const long, byval as const long, byval as any ptr, byval as any ptr )
		chk = procptr( fb_hPutXor )
	end scope

	ID( sub fb_hPutAlpha )
	scope
		dim chk as sub cdecl ( byval as const ubyte ptr, byval as ubyte ptr, byval as const long, byval as const long, byval as const long, byval as const long, byval as const long, byval as any ptr, byval as any ptr )
		chk = procptr( fb_hPutAlpha )
	end scope

	ID( sub fb_hPutBlend )
	scope
		dim chk as sub cdecl ( byval as const ubyte ptr, byval as ubyte ptr, byval as const long, byval as const long, byval as const long, byval as const long, byval as const long, byval as any ptr, byval as any ptr )
		chk = procptr( fb_hPutBlend )
	end scope

	ID( sub fb_hPutAdd )
	scope
		dim chk as sub cdecl ( byval as const ubyte ptr, byval as ubyte ptr, byval as const long, byval as const long, byval as const long, byval as const long, byval as const long, byval as any ptr, byval as any ptr )
		chk = procptr( fb_hPutAdd )
	end scope

	ID( sub fb_hPutCustom )
	scope
		dim chk as sub cdecl ( byval as const ubyte ptr, byval as ubyte ptr, byval as const long, byval as const long, byval as const long, byval as const long, byval as const long, byval as any ptr, byval as any ptr )
		chk = procptr( fb_hPutCustom )
	end scope

#print "---- rtlMath"

	ID( function fb___divdi3 alias "__divdi3" )
	scope
		dim chk as function cdecl ( byval as longint, byval as longint ) as longint
		chk = procptr( fb___divdi3 )
	end scope

	ID( function fb___udivdi3 alias "__udivdi3" )
	scope
		dim chk as function cdecl ( byval as ulongint, byval as ulongint ) as ulongint
		chk = procptr( fb___udivdi3 )
	end scope

	ID( function fb___moddi3 alias "__moddi3" )
	scope
		dim chk as function cdecl ( byval as longint, byval as longint ) as longint
		chk = procptr( fb___moddi3 )
	end scope

	ID( function fb___umoddi3 alias "__umoddi3" )
	scope
		dim chk as function cdecl ( byval as ulongint, byval as ulongint ) as ulongint
		chk = procptr( fb___umoddi3 )
	end scope

	ID( function fb___fixunsdfdi alias "__fixunsdfdi" )
	scope
		dim chk as function cdecl ( byval as double ) as ulongint
		chk = procptr( fb___fixunsdfdi )
	end scope

	ID( function fb_Pow alias "pow" )
	scope
		dim chk as function cdecl ( byval as double, byval as double ) as double
		chk = procptr( fb_Pow )
	end scope

	ID( sub randomize alias "fb_Randomize" )
	scope
		dim chk as sub fbcall ( byval as double = -1, byval as long = 0 )
		chk = procptr( randomize )
	end scope

	ID( function rnd alias "fb_Rnd" )
	scope
		dim chk as function fbcall ( byval as single = 1 ) as double
		chk = procptr( rnd )
	end scope

#if 0
	ID( function {asin} alias "asinf" )
	scope
		dim chk as function cdecl ( byval as single ) as single
		chk = procptr( {asin} )
	end scope
#endif

#if 0
	ID( function {asin} alias "asin" )
	scope
		dim chk as function cdecl ( byval as double ) as double
		chk = procptr( {asin} )
	end scope
#endif

#if 0
	ID( function {acos} alias "acosf" )
	scope
		dim chk as function cdecl ( byval as single ) as single
		chk = procptr( {acos} )
	end scope
#endif

#if 0
	ID( function {acos} alias "acos" )
	scope
		dim chk as function cdecl ( byval as double ) as double
		chk = procptr( {acos} )
	end scope
#endif

#if 0
	ID( function {tan} alias "tanf" )
	scope
		dim chk as function cdecl ( byval as single ) as single
		chk = procptr( {tan} )
	end scope
#endif

#if 0
	ID( function {tan} alias "tan" )
	scope
		dim chk as function cdecl ( byval as double ) as double
		chk = procptr( {tan} )
	end scope
#endif

#if 0
	ID( function {atan} alias "atanf" )
	scope
		dim chk as function cdecl ( byval as single ) as single
		chk = procptr( {atan} )
	end scope
#endif

#if 0
	ID( function {atan} alias "atan" )
	scope
		dim chk as function cdecl ( byval as double ) as double
		chk = procptr( {atan} )
	end scope
#endif

#if 0
	ID( function {abs} alias "abs" )
	scope
		dim chk as function cdecl ( byval as long ) as long
		chk = procptr( {abs} )
	end scope
#endif

#if 0
	ID( function {abs} alias "llabs" )
	scope
		dim chk as function cdecl ( byval as longint ) as longint
		chk = procptr( {abs} )
	end scope
#endif

#if 0
	ID( function {abs} alias "fabsf" )
	scope
		dim chk as function cdecl ( byval as single ) as single
		chk = procptr( {abs} )
	end scope
#endif

#if 0
	ID( function {abs} alias "fabs" )
	scope
		dim chk as function cdecl ( byval as double ) as double
		chk = procptr( {abs} )
	end scope
#endif

#if 0
	ID( function {sgn} alias "fb_SGNi" )
	scope
		dim chk as function fbcall ( byval as long ) as long
		chk = procptr( {sgn} )
	end scope
#endif

#if 0
	ID( function {sgn} alias "fb_SGNl" )
	scope
		dim chk as function fbcall ( byval as longint ) as long
		chk = procptr( {sgn} )
	end scope
#endif

#if 0
	ID( function {sgn} alias "fb_SGNSingle" )
	scope
		dim chk as function fbcall ( byval as single ) as long
		chk = procptr( {sgn} )
	end scope
#endif

#if 0
	ID( function {sgn} alias "fb_SGNDouble" )
	scope
		dim chk as function fbcall ( byval as double ) as long
		chk = procptr( {sgn} )
	end scope
#endif

#if 0
	ID( function {fix} alias "fb_FIXSingle" )
	scope
		dim chk as function fbcall ( byval as single ) as single
		chk = procptr( {fix} )
	end scope
#endif

#if 0
	ID( function {fix} alias "fb_FIXDouble" )
	scope
		dim chk as function fbcall ( byval as double ) as double
		chk = procptr( {fix} )
	end scope
#endif

#if 0
	ID( function {frac} alias "fb_FRACf" )
	scope
		dim chk as function fbcall ( byval as single ) as single
		chk = procptr( {frac} )
	end scope
#endif

#if 0
	ID( function {frac} alias "fb_FRACd" )
	scope
		dim chk as function fbcall ( byval as double ) as double
		chk = procptr( {frac} )
	end scope
#endif

#if 0
	ID( function {atan2} alias "atan2f" )
	scope
		dim chk as function cdecl ( byval as single, byval as single ) as single
		chk = procptr( {atan2} )
	end scope
#endif

#if 0
	ID( function {atan2} alias "atan2" )
	scope
		dim chk as function cdecl ( byval as double, byval as double ) as double
		chk = procptr( {atan2} )
	end scope
#endif

#print "---- rtlMem"

	ID( function fb_NullPtrChk )
	scope
		dim chk as function fbcall ( byval as const any ptr, byval as const long, byval as const zstring ptr ) as any ptr
		chk = procptr( fb_NullPtrChk )
	end scope

	ID( sub fb_MemSwap )
	scope
		dim chk as sub fbcall ( byref as any, byref as any, byval as const integer )
		chk = procptr( fb_MemSwap )
	end scope

	ID( sub fb_MemCopyClear )
	scope
		dim chk as sub fbcall ( byref as any, byval as const uinteger, byref as const any, byval as const uinteger )
		chk = procptr( fb_MemCopyClear )
	end scope

	ID( function fre alias "fb_GetMemAvail" )
	scope
		dim chk as function fbcall ( byval as const long = 0 ) as uinteger
		chk = procptr( fre )
	end scope

	ID( function allocate alias "malloc" )
	scope
		dim chk as function cdecl ( byval as const uinteger ) as any ptr
		chk = procptr( allocate )
	end scope

	ID( function callocate alias "calloc" )
	scope
		dim chk as function cdecl ( byval as const uinteger, byval as const uinteger = 1 ) as any ptr
		chk = procptr( callocate )
	end scope

	ID( function reallocate alias "realloc" )
	scope
		dim chk as function cdecl ( byval as const any ptr, byval as const uinteger ) as any ptr
		chk = procptr( reallocate )
	end scope

	ID( sub deallocate alias "free" )
	scope
		dim chk as sub cdecl ( byval as const any ptr )
		chk = procptr( deallocate )
	end scope

	ID( function clear alias "memset" )
	scope
		dim chk as function cdecl ( byref as any, byval as const long = 0, byval as const uinteger ) as any ptr
		chk = procptr( clear )
	end scope

	ID( function fb_MemMove alias "memmove" )
	scope
		dim chk as function cdecl ( byref as any, byref as const any, byval as const uinteger ) as any ptr
		chk = procptr( fb_MemMove )
	end scope

	ID( function fb_MemCopy alias "memcpy" )
	scope
		dim chk as function cdecl ( byref as any, byref as const any, byval as const uinteger ) as any ptr
		chk = procptr( fb_MemCopy )
	end scope

#print "---- rtlPrint"

	ID( sub fb_PrintVoid )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const long )
		chk = procptr( fb_PrintVoid )
	end scope

	ID( sub fb_PrintBool )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const boolean, byval as const long )
		chk = procptr( fb_PrintBool )
	end scope

	ID( sub fb_PrintByte )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const byte, byval as const long )
		chk = procptr( fb_PrintByte )
	end scope

	ID( sub fb_PrintUByte )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const ubyte, byval as const long )
		chk = procptr( fb_PrintUByte )
	end scope

	ID( sub fb_PrintShort )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const short, byval as const long )
		chk = procptr( fb_PrintShort )
	end scope

	ID( sub fb_PrintUShort )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const ushort, byval as const long )
		chk = procptr( fb_PrintUShort )
	end scope

	ID( sub fb_PrintInt )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const long, byval as const long )
		chk = procptr( fb_PrintInt )
	end scope

	ID( sub fb_PrintUInt )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const ulong, byval as const long )
		chk = procptr( fb_PrintUInt )
	end scope

	ID( sub fb_PrintLongint )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const longint, byval as const long )
		chk = procptr( fb_PrintLongint )
	end scope

	ID( sub fb_PrintULongint )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const ulongint, byval as const long )
		chk = procptr( fb_PrintULongint )
	end scope

	ID( sub fb_PrintSingle )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const single, byval as const long )
		chk = procptr( fb_PrintSingle )
	end scope

	ID( sub fb_PrintDouble )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const double, byval as const long )
		chk = procptr( fb_PrintDouble )
	end scope

	ID( sub fb_PrintString )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byref as const string, byval as const long )
		chk = procptr( fb_PrintString )
	end scope

	ID( sub fb_PrintWstr )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const wchar ptr, byval as const long )
		chk = procptr( fb_PrintWstr )
	end scope

	ID( sub fb_LPrintVoid )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const long )
		chk = procptr( fb_LPrintVoid )
	end scope

	ID( sub fb_LPrintBool )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const boolean, byval as const long )
		chk = procptr( fb_LPrintBool )
	end scope

	ID( sub fb_LPrintByte )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const byte, byval as const long )
		chk = procptr( fb_LPrintByte )
	end scope

	ID( sub fb_LPrintUByte )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const ubyte, byval as const long )
		chk = procptr( fb_LPrintUByte )
	end scope

	ID( sub fb_LPrintShort )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const short, byval as const long )
		chk = procptr( fb_LPrintShort )
	end scope

	ID( sub fb_LPrintUShort )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const ushort, byval as const long )
		chk = procptr( fb_LPrintUShort )
	end scope

	ID( sub fb_LPrintInt )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const long, byval as const long )
		chk = procptr( fb_LPrintInt )
	end scope

	ID( sub fb_LPrintUInt )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const ulong, byval as const long )
		chk = procptr( fb_LPrintUInt )
	end scope

	ID( sub fb_LPrintLongint )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const longint, byval as const long )
		chk = procptr( fb_LPrintLongint )
	end scope

	ID( sub fb_LPrintULongint )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const ulongint, byval as const long )
		chk = procptr( fb_LPrintULongint )
	end scope

	ID( sub fb_LPrintSingle )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const single, byval as const long )
		chk = procptr( fb_LPrintSingle )
	end scope

	ID( sub fb_LPrintDouble )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const double, byval as const long )
		chk = procptr( fb_LPrintDouble )
	end scope

	ID( sub fb_LPrintString )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byref as const string, byval as const long )
		chk = procptr( fb_LPrintString )
	end scope

	ID( sub fb_LPrintWstr )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const wchar ptr, byval as const long )
		chk = procptr( fb_LPrintWstr )
	end scope

	ID( sub fb_PrintSPC )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const integer )
		chk = procptr( fb_PrintSPC )
	end scope

	ID( sub fb_PrintTab )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const long )
		chk = procptr( fb_PrintTab )
	end scope

	ID( sub fb_WriteVoid )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const long )
		chk = procptr( fb_WriteVoid )
	end scope

	ID( sub fb_WriteBool )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const boolean, byval as const long )
		chk = procptr( fb_WriteBool )
	end scope

	ID( sub fb_WriteByte )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const byte, byval as const long )
		chk = procptr( fb_WriteByte )
	end scope

	ID( sub fb_WriteUByte )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const ubyte, byval as const long )
		chk = procptr( fb_WriteUByte )
	end scope

	ID( sub fb_WriteShort )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const short, byval as const long )
		chk = procptr( fb_WriteShort )
	end scope

	ID( sub fb_WriteUShort )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const ushort, byval as const long )
		chk = procptr( fb_WriteUShort )
	end scope

	ID( sub fb_WriteInt )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const long, byval as const long )
		chk = procptr( fb_WriteInt )
	end scope

	ID( sub fb_WriteUInt )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const ulong, byval as const long )
		chk = procptr( fb_WriteUInt )
	end scope

	ID( sub fb_WriteLongint )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const longint, byval as const long )
		chk = procptr( fb_WriteLongint )
	end scope

	ID( sub fb_WriteULongint )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const ulongint, byval as const long )
		chk = procptr( fb_WriteULongint )
	end scope

	ID( sub fb_WriteSingle )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const single, byval as const long )
		chk = procptr( fb_WriteSingle )
	end scope

	ID( sub fb_WriteDouble )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const double, byval as const long )
		chk = procptr( fb_WriteDouble )
	end scope

	ID( sub fb_WriteString )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byref as const string, byval as const long )
		chk = procptr( fb_WriteString )
	end scope

	ID( sub fb_WriteWstr )
	scope
		dim chk as sub fbcall ( byval as const long = 0, byval as const wchar ptr, byval as const long )
		chk = procptr( fb_WriteWstr )
	end scope

	ID( function fb_PrintUsingInit )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( fb_PrintUsingInit )
	end scope

	ID( function fb_PrintUsingStr )
	scope
		dim chk as function fbcall ( byval as const long, byref as const string, byval as const long ) as long
		chk = procptr( fb_PrintUsingStr )
	end scope

	ID( function fb_PrintUsingWstr )
	scope
		dim chk as function fbcall ( byval as const long, byval as const wchar ptr, byval as const long ) as long
		chk = procptr( fb_PrintUsingWstr )
	end scope

	ID( function fb_PrintUsingSingle )
	scope
		dim chk as function fbcall ( byval as const long, byval as const single, byval as const long ) as long
		chk = procptr( fb_PrintUsingSingle )
	end scope

	ID( function fb_PrintUsingDouble )
	scope
		dim chk as function fbcall ( byval as const long, byval as const double, byval as const long ) as long
		chk = procptr( fb_PrintUsingDouble )
	end scope

	ID( function fb_PrintUsingLongint )
	scope
		dim chk as function fbcall ( byval as const long, byval as const longint, byval as const long ) as long
		chk = procptr( fb_PrintUsingLongint )
	end scope

	ID( function fb_PrintUsingULongint )
	scope
		dim chk as function fbcall ( byval as const long, byval as const ulongint, byval as const long ) as long
		chk = procptr( fb_PrintUsingULongint )
	end scope

	ID( function fb_PrintUsingBoolean )
	scope
		dim chk as function fbcall ( byval as const long, byval as const boolean, byval as const long ) as long
		chk = procptr( fb_PrintUsingBoolean )
	end scope

	ID( function fb_PrintUsingEnd )
	scope
		dim chk as function fbcall ( byval as const long ) as long
		chk = procptr( fb_PrintUsingEnd )
	end scope

	ID( function fb_LPrintUsingInit )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( fb_LPrintUsingInit )
	end scope

#print "---- rtlProfile_64"

#if 0
	ID( sub fb_mcount alias "_mcount" )
	scope
		dim chk as sub cdecl ( )
		chk = procptr( fb_mcount )
	end scope
#endif

#print "---- rtlProfile_32"

#if 0
	ID( sub fb_mcount alias "mcount" )
	scope
		dim chk as sub cdecl ( )
		chk = procptr( fb_mcount )
	end scope
#endif

#print "---- rtlProfile_XX"

#if 0
	ID( sub fb__monstartup alias "_monstartup" )
	scope
		dim chk as sub cdecl ( )
		chk = procptr( fb__monstartup )
	end scope
#endif

#print "---- rtlString"

	ID( function fb_StrInit )
	scope
		dim chk as function fbcall ( byref as any, byval as const integer, byref as const any, byval as const integer, byval as const long = 1 ) as string
		chk = procptr( fb_StrInit )
	end scope

	ID( function fb_WstrAssignToA_Init )
	scope
		dim chk as function fbcall ( byref as any, byval as const integer, byval as const wchar ptr, byval as const integer ) as string
		chk = procptr( fb_WstrAssignToA_Init )
	end scope

	ID( function fb_StrAssign )
	scope
		dim chk as function fbcall ( byref as any, byval as const integer, byref as const any, byval as const integer, byval as const long = 1 ) as string
		chk = procptr( fb_StrAssign )
	end scope

	ID( function fb_WstrAssign )
	scope
		dim chk as function fbcall ( byval as wchar ptr, byval as const integer, byval as const wchar ptr ) as wchar ptr
		chk = procptr( fb_WstrAssign )
	end scope

	ID( function fb_WstrAssignFromA )
	scope
		dim chk as function fbcall ( byval as wchar ptr, byval as const integer, byref as const any, byval as const integer ) as wchar ptr
		chk = procptr( fb_WstrAssignFromA )
	end scope

	ID( function fb_WstrAssignToA )
	scope
		dim chk as function fbcall ( byref as any, byval as const integer, byval as const wchar ptr, byval as const long ) as string
		chk = procptr( fb_WstrAssignToA )
	end scope

	ID( sub fb_StrDelete )
	scope
		dim chk as sub fbcall ( byref as const string )
		chk = procptr( fb_StrDelete )
	end scope

	ID( function fb_hStrDelTemp )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( fb_hStrDelTemp )
	end scope

	ID( sub fb_WstrDelete )
	scope
		dim chk as sub fbcall ( byval as const wchar ptr )
		chk = procptr( fb_WstrDelete )
	end scope

	ID( function fb_StrConcat )
	scope
		dim chk as function fbcall ( byref as string, byref as const any, byval as const integer, byref as const any, byval as const integer ) as string
		chk = procptr( fb_StrConcat )
	end scope

	ID( function fb_StrConcatByref )
	scope
		dim chk as function fbcall ( byref as any, byval as const integer, byref as const any, byval as const integer, byval as const long = 1 ) as string
		chk = procptr( fb_StrConcatByref )
	end scope

	ID( function fb_WstrConcat )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as const wchar ptr ) as wchar_ret
		chk = procptr( fb_WstrConcat )
	end scope

	ID( function fb_WstrConcatWA )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byref as const any, byval as const integer ) as wchar_ret
		chk = procptr( fb_WstrConcatWA )
	end scope

	ID( function fb_WstrConcatAW )
	scope
		dim chk as function fbcall ( byref as const any, byval as const integer, byval as const wchar ptr ) as wchar_ret
		chk = procptr( fb_WstrConcatAW )
	end scope

	ID( function fb_StrCompare )
	scope
		dim chk as function fbcall ( byref as const any, byval as const integer, byref as const any, byval as const integer ) as long
		chk = procptr( fb_StrCompare )
	end scope

	ID( function fb_WstrCompare )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as const wchar ptr ) as long
		chk = procptr( fb_WstrCompare )
	end scope

	ID( function fb_StrConcatAssign )
	scope
		dim chk as function fbcall ( byref as any, byval as const integer, byref as const any, byval as const integer, byval as const long = 1 ) as string
		chk = procptr( fb_StrConcatAssign )
	end scope

	ID( function fb_WstrConcatAssign )
	scope
		dim chk as function fbcall ( byval as wchar ptr, byval as const integer, byval as const wchar ptr ) as wchar ptr
		chk = procptr( fb_WstrConcatAssign )
	end scope

	ID( function fb_StrAllocTempResult )
	scope
		dim chk as function fbcall ( byref as const string ) as string
		chk = procptr( fb_StrAllocTempResult )
	end scope

	ID( function fb_StrAllocTempDescF )
	scope
		dim chk as function fbcall ( byref as const any, byval as const integer ) as string
		chk = procptr( fb_StrAllocTempDescF )
	end scope

	ID( function fb_StrAllocTempDescZ )
	scope
		dim chk as function fbcall ( byval as const zstring ptr ) as string
		chk = procptr( fb_StrAllocTempDescZ )
	end scope

	ID( function fb_StrAllocTempDescZEx )
	scope
		dim chk as function fbcall ( byval as const zstring ptr, byval as const integer ) as string
		chk = procptr( fb_StrAllocTempDescZEx )
	end scope

	ID( function fb_WstrAlloc )
	scope
		dim chk as function fbcall ( byval as const integer ) as wchar ptr
		chk = procptr( fb_WstrAlloc )
	end scope

	ID( function fb_BoolToStr )
	scope
		dim chk as function fbcall ( byval as const boolean ) as string
		chk = procptr( fb_BoolToStr )
	end scope

	ID( function fb_IntToStr )
	scope
		dim chk as function fbcall ( byval as const long ) as string
		chk = procptr( fb_IntToStr )
	end scope

#if __FB_LANG__ = "qb"
	ID( function fb_IntToStrQB )
	scope
		dim chk as function fbcall ( byval as const long ) as string
		chk = procptr( fb_IntToStrQB )
	end scope
#endif

	ID( function fb_BoolToWstr )
	scope
		dim chk as function fbcall ( byval as const boolean ) as wchar_ret
		chk = procptr( fb_BoolToWstr )
	end scope

	ID( function fb_IntToWstr )
	scope
		dim chk as function fbcall ( byval as const long ) as wchar_ret
		chk = procptr( fb_IntToWstr )
	end scope

	ID( function fb_UIntToStr )
	scope
		dim chk as function fbcall ( byval as const ulong ) as string
		chk = procptr( fb_UIntToStr )
	end scope

#if __FB_LANG__ = "qb"
	ID( function fb_UIntToStrQB )
	scope
		dim chk as function fbcall ( byval as const ulong ) as string
		chk = procptr( fb_UIntToStrQB )
	end scope
#endif

	ID( function fb_UIntToWstr )
	scope
		dim chk as function fbcall ( byval as const ulong ) as wchar_ret
		chk = procptr( fb_UIntToWstr )
	end scope

	ID( function fb_LongintToStr )
	scope
		dim chk as function fbcall ( byval as const longint ) as string
		chk = procptr( fb_LongintToStr )
	end scope

#if __FB_LANG__ = "qb"
	ID( function fb_LongintToStrQB )
	scope
		dim chk as function fbcall ( byval as const longint ) as string
		chk = procptr( fb_LongintToStrQB )
	end scope
#endif

	ID( function fb_LongintToWstr )
	scope
		dim chk as function fbcall ( byval as const longint ) as wchar_ret
		chk = procptr( fb_LongintToWstr )
	end scope

	ID( function fb_ULongintToStr )
	scope
		dim chk as function fbcall ( byval as const ulongint ) as string
		chk = procptr( fb_ULongintToStr )
	end scope

#if __FB_LANG__ = "qb"
	ID( function fb_ULongintToStrQB )
	scope
		dim chk as function fbcall ( byval as const ulongint ) as string
		chk = procptr( fb_ULongintToStrQB )
	end scope
#endif

	ID( function fb_ULongintToWstr )
	scope
		dim chk as function fbcall ( byval as const ulongint ) as wchar_ret
		chk = procptr( fb_ULongintToWstr )
	end scope

	ID( function fb_FloatToStr )
	scope
		dim chk as function fbcall ( byval as const single ) as string
		chk = procptr( fb_FloatToStr )
	end scope

#if __FB_LANG__ = "qb"
	ID( function fb_FloatToStrQB )
	scope
		dim chk as function fbcall ( byval as const single ) as string
		chk = procptr( fb_FloatToStrQB )
	end scope
#endif

	ID( function fb_FloatToWstr )
	scope
		dim chk as function fbcall ( byval as const single ) as wchar_ret
		chk = procptr( fb_FloatToWstr )
	end scope

	ID( function fb_DoubleToStr )
	scope
		dim chk as function fbcall ( byval as const double ) as string
		chk = procptr( fb_DoubleToStr )
	end scope

#if __FB_LANG__ = "qb"
	ID( function fb_DoubleToStrQB )
	scope
		dim chk as function fbcall ( byval as const double ) as string
		chk = procptr( fb_DoubleToStrQB )
	end scope
#endif

	ID( function fb_DoubleToWstr )
	scope
		dim chk as function fbcall ( byval as const double ) as wchar_ret
		chk = procptr( fb_DoubleToWstr )
	end scope

	ID( function fb_WstrToStr )
	scope
		dim chk as function fbcall ( byval as const wchar ptr ) as string
		chk = procptr( fb_WstrToStr )
	end scope

	ID( function fb_StrToWstr )
	scope
		dim chk as function fbcall ( byval as const zstring ptr ) as wchar_ret
		chk = procptr( fb_StrToWstr )
	end scope

	ID( function fb_StrMid )
	scope
		dim chk as function fbcall ( byref as const string, byval as const integer, byval as const integer ) as string
		chk = procptr( fb_StrMid )
	end scope

	ID( function fb_WstrMid )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as const integer, byval as const integer ) as wchar_ret
		chk = procptr( fb_WstrMid )
	end scope

	ID( sub fb_StrAssignMid )
	scope
		dim chk as sub fbcall ( byref as string, byval as const integer, byval as const integer, byref as const string )
		chk = procptr( fb_StrAssignMid )
	end scope

	ID( sub fb_WstrAssignMid )
	scope
		dim chk as sub fbcall ( byval as wchar ptr, byval as const integer, byval as const integer, byval as const integer, byval as const wchar ptr )
		chk = procptr( fb_WstrAssignMid )
	end scope

	ID( function fb_StrFill1 )
	scope
		dim chk as function fbcall ( byval as const integer, byval as const long ) as string
		chk = procptr( fb_StrFill1 )
	end scope

	ID( function fb_WstrFill1 )
	scope
		dim chk as function fbcall ( byval as const integer, byval as const long ) as wchar_ret
		chk = procptr( fb_WstrFill1 )
	end scope

	ID( function fb_StrFill2 )
	scope
		dim chk as function fbcall ( byval as const integer, byref as const string ) as string
		chk = procptr( fb_StrFill2 )
	end scope

	ID( function fb_WstrFill2 )
	scope
		dim chk as function fbcall ( byval as const integer, byval as const wchar ptr ) as wchar_ret
		chk = procptr( fb_WstrFill2 )
	end scope

	ID( function fb_StrLen )
	scope
		dim chk as function fbcall ( byref as const any, byval as const integer ) as integer
		chk = procptr( fb_StrLen )
	end scope

	ID( function fb_WstrLen )
	scope
		dim chk as function fbcall ( byval as const wchar ptr ) as integer
		chk = procptr( fb_WstrLen )
	end scope

	ID( sub fb_StrLset )
	scope
		dim chk as sub fbcall ( byref as string, byref as const string )
		chk = procptr( fb_StrLset )
	end scope

	ID( sub fb_WstrLset )
	scope
		dim chk as sub fbcall ( byval as wchar ptr, byval as const wchar ptr )
		chk = procptr( fb_WstrLset )
	end scope

	ID( sub fb_StrRset )
	scope
		dim chk as sub fbcall ( byref as string, byref as const string )
		chk = procptr( fb_StrRset )
	end scope

	ID( sub fb_WstrRset )
	scope
		dim chk as sub fbcall ( byval as wchar ptr, byval as const wchar ptr )
		chk = procptr( fb_WstrRset )
	end scope

	ID( function fb_ASC )
	scope
		dim chk as function fbcall ( byref as const string, byval as const integer = 0 ) as ulong
		chk = procptr( fb_ASC )
	end scope

	ID( function fb_WstrAsc )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as const integer = 0 ) as ulong
		chk = procptr( fb_WstrAsc )
	end scope

	ID( function fb_CHR )
	scope
		dim chk as function cdecl ( byval as const long, ... ) as string
		chk = procptr( fb_CHR )
	end scope

	ID( function fb_WstrChr )
	scope
		dim chk as function cdecl ( byval as const long, ... ) as wchar_ret
		chk = procptr( fb_WstrChr )
	end scope

	ID( function fb_StrInstr )
	scope
		dim chk as function fbcall ( byval as const integer, byref as const string, byref as const string ) as integer
		chk = procptr( fb_StrInstr )
	end scope

	ID( function fb_WstrInstr )
	scope
		dim chk as function fbcall ( byval as const integer, byval as const wchar ptr, byval as const wchar ptr ) as integer
		chk = procptr( fb_WstrInstr )
	end scope

	ID( function fb_StrInstrAny )
	scope
		dim chk as function fbcall ( byval as const integer, byref as const string, byref as const string ) as integer
		chk = procptr( fb_StrInstrAny )
	end scope

	ID( function fb_WstrInstrAny )
	scope
		dim chk as function fbcall ( byval as const integer, byval as const wchar ptr, byval as const wchar ptr ) as integer
		chk = procptr( fb_WstrInstrAny )
	end scope

	ID( function fb_StrInstrRev )
	scope
		dim chk as function fbcall ( byref as const string, byref as const string, byval as const integer ) as integer
		chk = procptr( fb_StrInstrRev )
	end scope

	ID( function fb_WstrInstrRev )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as const wchar ptr, byval as const integer ) as integer
		chk = procptr( fb_WstrInstrRev )
	end scope

	ID( function fb_StrInstrRevAny )
	scope
		dim chk as function fbcall ( byref as const string, byref as const string, byval as const integer ) as integer
		chk = procptr( fb_StrInstrRevAny )
	end scope

	ID( function fb_WstrInstrRevAny )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as const wchar ptr, byval as const integer ) as integer
		chk = procptr( fb_WstrInstrRevAny )
	end scope

	ID( function fb_TRIM )
	scope
		dim chk as function fbcall ( byref as const string ) as string
		chk = procptr( fb_TRIM )
	end scope

	ID( function fb_WstrTrim )
	scope
		dim chk as function fbcall ( byval as const wchar ptr ) as wchar_ret
		chk = procptr( fb_WstrTrim )
	end scope

	ID( function fb_TrimAny )
	scope
		dim chk as function fbcall ( byref as const string, byref as const string ) as string
		chk = procptr( fb_TrimAny )
	end scope

	ID( function fb_WstrTrimAny )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as const wchar ptr ) as wchar_ret
		chk = procptr( fb_WstrTrimAny )
	end scope

	ID( function fb_TrimEx )
	scope
		dim chk as function fbcall ( byref as const string, byref as const string ) as string
		chk = procptr( fb_TrimEx )
	end scope

	ID( function fb_WstrTrimEx )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as const wchar ptr ) as wchar_ret
		chk = procptr( fb_WstrTrimEx )
	end scope

	ID( function fb_RTRIM )
	scope
		dim chk as function fbcall ( byref as const string ) as string
		chk = procptr( fb_RTRIM )
	end scope

	ID( function fb_WstrRTrim )
	scope
		dim chk as function fbcall ( byval as const wchar ptr ) as wchar_ret
		chk = procptr( fb_WstrRTrim )
	end scope

	ID( function fb_RTrimAny )
	scope
		dim chk as function fbcall ( byref as const string, byref as const string ) as string
		chk = procptr( fb_RTrimAny )
	end scope

	ID( function fb_WstrRTrimAny )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as const wchar ptr ) as wchar_ret
		chk = procptr( fb_WstrRTrimAny )
	end scope

	ID( function fb_RTrimEx )
	scope
		dim chk as function fbcall ( byref as const string, byref as const string ) as string
		chk = procptr( fb_RTrimEx )
	end scope

	ID( function fb_WstrRTrimEx )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as const wchar ptr ) as wchar_ret
		chk = procptr( fb_WstrRTrimEx )
	end scope

	ID( function fb_LTRIM )
	scope
		dim chk as function fbcall ( byref as const string ) as string
		chk = procptr( fb_LTRIM )
	end scope

	ID( function fb_WstrLTrim )
	scope
		dim chk as function fbcall ( byval as const wchar ptr ) as wchar_ret
		chk = procptr( fb_WstrLTrim )
	end scope

	ID( function fb_LTrimAny )
	scope
		dim chk as function fbcall ( byref as const string, byref as const string ) as string
		chk = procptr( fb_LTrimAny )
	end scope

	ID( function fb_WstrLTrimAny )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as const wchar ptr ) as wchar_ret
		chk = procptr( fb_WstrLTrimAny )
	end scope

	ID( function fb_LTrimEx )
	scope
		dim chk as function fbcall ( byref as const string, byref as const string ) as string
		chk = procptr( fb_LTrimEx )
	end scope

	ID( function fb_WstrLTrimEx )
	scope
		dim chk as function fbcall ( byval as const wchar ptr, byval as const wchar ptr ) as wchar_ret
		chk = procptr( fb_WstrLTrimEx )
	end scope

	ID( sub fb_StrSwap )
	scope
		dim chk as sub fbcall ( byref as any, byval as const integer, byval as const long, byref as any, byval as const integer, byval as const long )
		chk = procptr( fb_StrSwap )
	end scope

	ID( sub fb_WstrSwap )
	scope
		dim chk as sub fbcall ( byval as wchar ptr, byval as const integer, byval as wchar ptr, byval as const integer )
		chk = procptr( fb_WstrSwap )
	end scope

	ID( function val alias "fb_VAL" )
	scope
		dim chk as function fbcall ( byref as const string ) as double
		chk = procptr( val )
	end scope

	ID( function val alias "fb_WstrVal" )
	scope
		dim chk as function fbcall ( byref as const wchar ) as double
		chk = procptr( val )
	end scope

	ID( function fb_VALBOOL )
	scope
		dim chk as function fbcall ( byref as const string ) as boolean
		chk = procptr( fb_VALBOOL )
	end scope

	ID( function fb_VALBOOL alias "fb_WstrValBool" )
	scope
		dim chk as function fbcall ( byref as const wchar ) as boolean
		chk = procptr( fb_VALBOOL )
	end scope

	ID( function valint alias "fb_VALINT" )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( valint )
	end scope

	ID( function valint alias "fb_WstrValInt" )
	scope
		dim chk as function fbcall ( byref as const wchar ) as long
		chk = procptr( valint )
	end scope

	ID( function valuint alias "fb_VALUINT" )
	scope
		dim chk as function fbcall ( byref as const string ) as ulong
		chk = procptr( valuint )
	end scope

	ID( function valuint alias "fb_WstrValUInt" )
	scope
		dim chk as function fbcall ( byref as const wchar ) as ulong
		chk = procptr( valuint )
	end scope

	ID( function vallng alias "fb_VALLNG" )
	scope
		dim chk as function fbcall ( byref as const string ) as longint
		chk = procptr( vallng )
	end scope

	ID( function vallng alias "fb_WstrValLng" )
	scope
		dim chk as function fbcall ( byref as const wchar ) as longint
		chk = procptr( vallng )
	end scope

	ID( function valulng alias "fb_VALULNG" )
	scope
		dim chk as function fbcall ( byref as const string ) as ulongint
		chk = procptr( valulng )
	end scope

	ID( function valulng alias "fb_WstrValULng" )
	scope
		dim chk as function fbcall ( byref as const wchar ) as ulongint
		chk = procptr( valulng )
	end scope

	ID( function hex alias "fb_HEX_b" )
	scope
		dim chk as function fbcall ( byval as const ubyte ) as string
		chk = procptr( hex )
	end scope

	ID( function hex alias "fb_HEX_s" )
	scope
		dim chk as function fbcall ( byval as const ushort ) as string
		chk = procptr( hex )
	end scope

	ID( function hex alias "fb_HEX_i" )
	scope
		dim chk as function fbcall ( byval as const ulong ) as string
		chk = procptr( hex )
	end scope

	ID( function hex alias "fb_HEX_l" )
	scope
		dim chk as function fbcall ( byval as const ulongint ) as string
		chk = procptr( hex )
	end scope

	ID( function hex alias "fb_HEX_p" )
	scope
		dim chk as function fbcall ( byval as const any ptr ) as string
		chk = procptr( hex )
	end scope

	ID( function hex alias "fb_HEXEx_b" )
	scope
		dim chk as function fbcall ( byval as const ubyte, byval as const long ) as string
		chk = procptr( hex )
	end scope

	ID( function hex alias "fb_HEXEx_s" )
	scope
		dim chk as function fbcall ( byval as const ushort, byval as const long ) as string
		chk = procptr( hex )
	end scope

	ID( function hex alias "fb_HEXEx_i" )
	scope
		dim chk as function fbcall ( byval as const ulong, byval as const long ) as string
		chk = procptr( hex )
	end scope

	ID( function hex alias "fb_HEXEx_l" )
	scope
		dim chk as function fbcall ( byval as const ulongint, byval as const long ) as string
		chk = procptr( hex )
	end scope

	ID( function hex alias "fb_HEXEx_p" )
	scope
		dim chk as function fbcall ( byval as const any ptr, byval as const long ) as string
		chk = procptr( hex )
	end scope

	ID( function whex alias "fb_WstrHex_b" )
	scope
		dim chk as function fbcall ( byval as const ubyte ) as wchar_ret
		chk = procptr( whex )
	end scope

	ID( function whex alias "fb_WstrHex_s" )
	scope
		dim chk as function fbcall ( byval as const ushort ) as wchar_ret
		chk = procptr( whex )
	end scope

	ID( function whex alias "fb_WstrHex_i" )
	scope
		dim chk as function fbcall ( byval as const ulong ) as wchar_ret
		chk = procptr( whex )
	end scope

	ID( function whex alias "fb_WstrHex_l" )
	scope
		dim chk as function fbcall ( byval as const ulongint ) as wchar_ret
		chk = procptr( whex )
	end scope

	ID( function whex alias "fb_WstrHex_p" )
	scope
		dim chk as function fbcall ( byval as const any ptr ) as wchar_ret
		chk = procptr( whex )
	end scope

	ID( function whex alias "fb_WstrHexEx_b" )
	scope
		dim chk as function fbcall ( byval as const ubyte, byval as const long ) as wchar_ret
		chk = procptr( whex )
	end scope

	ID( function whex alias "fb_WstrHexEx_s" )
	scope
		dim chk as function fbcall ( byval as const ushort, byval as const long ) as wchar_ret
		chk = procptr( whex )
	end scope

	ID( function whex alias "fb_WstrHexEx_i" )
	scope
		dim chk as function fbcall ( byval as const ulong, byval as const long ) as wchar_ret
		chk = procptr( whex )
	end scope

	ID( function whex alias "fb_WstrHexEx_l" )
	scope
		dim chk as function fbcall ( byval as const ulongint, byval as const long ) as wchar_ret
		chk = procptr( whex )
	end scope

	ID( function whex alias "fb_WstrHexEx_p" )
	scope
		dim chk as function fbcall ( byval as const any ptr, byval as const long ) as wchar_ret
		chk = procptr( whex )
	end scope

	ID( function oct alias "fb_OCT_b" )
	scope
		dim chk as function fbcall ( byval as const ubyte ) as string
		chk = procptr( oct )
	end scope

	ID( function oct alias "fb_OCT_s" )
	scope
		dim chk as function fbcall ( byval as const ushort ) as string
		chk = procptr( oct )
	end scope

	ID( function oct alias "fb_OCT_i" )
	scope
		dim chk as function fbcall ( byval as const ulong ) as string
		chk = procptr( oct )
	end scope

	ID( function oct alias "fb_OCT_l" )
	scope
		dim chk as function fbcall ( byval as const ulongint ) as string
		chk = procptr( oct )
	end scope

	ID( function oct alias "fb_OCT_p" )
	scope
		dim chk as function fbcall ( byval as const any ptr ) as string
		chk = procptr( oct )
	end scope

	ID( function oct alias "fb_OCTEx_b" )
	scope
		dim chk as function fbcall ( byval as const ubyte, byval as const long ) as string
		chk = procptr( oct )
	end scope

	ID( function oct alias "fb_OCTEx_s" )
	scope
		dim chk as function fbcall ( byval as const ushort, byval as const long ) as string
		chk = procptr( oct )
	end scope

	ID( function oct alias "fb_OCTEx_i" )
	scope
		dim chk as function fbcall ( byval as const ulong, byval as const long ) as string
		chk = procptr( oct )
	end scope

	ID( function oct alias "fb_OCTEx_l" )
	scope
		dim chk as function fbcall ( byval as const ulongint, byval as const long ) as string
		chk = procptr( oct )
	end scope

	ID( function oct alias "fb_OCTEx_p" )
	scope
		dim chk as function fbcall ( byval as const any ptr, byval as const long ) as string
		chk = procptr( oct )
	end scope

	ID( function woct alias "fb_WstrOct_b" )
	scope
		dim chk as function fbcall ( byval as const ubyte ) as wchar_ret
		chk = procptr( woct )
	end scope

	ID( function woct alias "fb_WstrOct_s" )
	scope
		dim chk as function fbcall ( byval as const ushort ) as wchar_ret
		chk = procptr( woct )
	end scope

	ID( function woct alias "fb_WstrOct_i" )
	scope
		dim chk as function fbcall ( byval as const ulong ) as wchar_ret
		chk = procptr( woct )
	end scope

	ID( function woct alias "fb_WstrOct_l" )
	scope
		dim chk as function fbcall ( byval as const ulongint ) as wchar_ret
		chk = procptr( woct )
	end scope

	ID( function woct alias "fb_WstrOct_p" )
	scope
		dim chk as function fbcall ( byval as const any ptr ) as wchar_ret
		chk = procptr( woct )
	end scope

	ID( function woct alias "fb_WstrOctEx_b" )
	scope
		dim chk as function fbcall ( byval as const ubyte, byval as const long ) as wchar_ret
		chk = procptr( woct )
	end scope

	ID( function woct alias "fb_WstrOctEx_s" )
	scope
		dim chk as function fbcall ( byval as const ushort, byval as const long ) as wchar_ret
		chk = procptr( woct )
	end scope

	ID( function woct alias "fb_WstrOctEx_i" )
	scope
		dim chk as function fbcall ( byval as const ulong, byval as const long ) as wchar_ret
		chk = procptr( woct )
	end scope

	ID( function woct alias "fb_WstrOctEx_l" )
	scope
		dim chk as function fbcall ( byval as const ulongint, byval as const long ) as wchar_ret
		chk = procptr( woct )
	end scope

	ID( function woct alias "fb_WstrOctEx_p" )
	scope
		dim chk as function fbcall ( byval as const any ptr, byval as const long ) as wchar_ret
		chk = procptr( woct )
	end scope

	ID( function bin alias "fb_BIN_b" )
	scope
		dim chk as function fbcall ( byval as const ubyte ) as string
		chk = procptr( bin )
	end scope

	ID( function bin alias "fb_BIN_s" )
	scope
		dim chk as function fbcall ( byval as const ushort ) as string
		chk = procptr( bin )
	end scope

	ID( function bin alias "fb_BIN_i" )
	scope
		dim chk as function fbcall ( byval as const ulong ) as string
		chk = procptr( bin )
	end scope

	ID( function bin alias "fb_BIN_l" )
	scope
		dim chk as function fbcall ( byval as const ulongint ) as string
		chk = procptr( bin )
	end scope

	ID( function bin alias "fb_BIN_p" )
	scope
		dim chk as function fbcall ( byval as const any ptr ) as string
		chk = procptr( bin )
	end scope

	ID( function bin alias "fb_BINEx_b" )
	scope
		dim chk as function fbcall ( byval as const ubyte, byval as const long ) as string
		chk = procptr( bin )
	end scope

	ID( function bin alias "fb_BINEx_s" )
	scope
		dim chk as function fbcall ( byval as const ushort, byval as const long ) as string
		chk = procptr( bin )
	end scope

	ID( function bin alias "fb_BINEx_i" )
	scope
		dim chk as function fbcall ( byval as const ulong, byval as const long ) as string
		chk = procptr( bin )
	end scope

	ID( function bin alias "fb_BINEx_l" )
	scope
		dim chk as function fbcall ( byval as const ulongint, byval as const long ) as string
		chk = procptr( bin )
	end scope

	ID( function bin alias "fb_BINEx_p" )
	scope
		dim chk as function fbcall ( byval as const any ptr, byval as const long ) as string
		chk = procptr( bin )
	end scope

	ID( function wbin alias "fb_WstrBin_b" )
	scope
		dim chk as function fbcall ( byval as const ubyte ) as wchar_ret
		chk = procptr( wbin )
	end scope

	ID( function wbin alias "fb_WstrBin_s" )
	scope
		dim chk as function fbcall ( byval as const ushort ) as wchar_ret
		chk = procptr( wbin )
	end scope

	ID( function wbin alias "fb_WstrBin_i" )
	scope
		dim chk as function fbcall ( byval as const ulong ) as wchar_ret
		chk = procptr( wbin )
	end scope

	ID( function wbin alias "fb_WstrBin_l" )
	scope
		dim chk as function fbcall ( byval as const ulongint ) as wchar_ret
		chk = procptr( wbin )
	end scope

	ID( function wbin alias "fb_WstrBin_p" )
	scope
		dim chk as function fbcall ( byval as const any ptr ) as wchar_ret
		chk = procptr( wbin )
	end scope

	ID( function wbin alias "fb_WstrBinEx_b" )
	scope
		dim chk as function fbcall ( byval as const ubyte, byval as const long ) as wchar_ret
		chk = procptr( wbin )
	end scope

	ID( function wbin alias "fb_WstrBinEx_s" )
	scope
		dim chk as function fbcall ( byval as const ushort, byval as const long ) as wchar_ret
		chk = procptr( wbin )
	end scope

	ID( function wbin alias "fb_WstrBinEx_i" )
	scope
		dim chk as function fbcall ( byval as const ulong, byval as const long ) as wchar_ret
		chk = procptr( wbin )
	end scope

	ID( function wbin alias "fb_WstrBinEx_l" )
	scope
		dim chk as function fbcall ( byval as const ulongint, byval as const long ) as wchar_ret
		chk = procptr( wbin )
	end scope

	ID( function wbin alias "fb_WstrBinEx_p" )
	scope
		dim chk as function fbcall ( byval as const any ptr, byval as const long ) as wchar_ret
		chk = procptr( wbin )
	end scope

	ID( function fb_MKD )
	scope
		dim chk as function fbcall ( byval as const double ) as string
		chk = procptr( fb_MKD )
	end scope

	ID( function fb_MKS )
	scope
		dim chk as function fbcall ( byval as const single ) as string
		chk = procptr( fb_MKS )
	end scope

	ID( function fb_MKSHORT )
	scope
		dim chk as function fbcall ( byval as const short ) as string
		chk = procptr( fb_MKSHORT )
	end scope

	ID( function fb_MKI )
	scope
		dim chk as function fbcall ( byval as const integer ) as string
		chk = procptr( fb_MKI )
	end scope

	ID( function fb_MKL )
	scope
		dim chk as function fbcall ( byval as const long ) as string
		chk = procptr( fb_MKL )
	end scope

	ID( function fb_MKLONGINT )
	scope
		dim chk as function fbcall ( byval as const longint ) as string
		chk = procptr( fb_MKLONGINT )
	end scope

	ID( function left alias "fb_LEFT" )
	scope
		dim chk as function fbcall ( byref as const string, byval as const integer ) as string
		chk = procptr( left )
	end scope

	ID( function left alias "fb_WstrLeft" )
	scope
		dim chk as function fbcall ( byref as const wchar, byval as const integer ) as wchar_ret
		chk = procptr( left )
	end scope

	ID( sub fb_LeftSelf alias "fb_LEFTSELF" )
	scope
		dim chk as sub fbcall ( byref as const string, byval as const integer )
		chk = procptr( fb_LeftSelf )
	end scope

	ID( function right alias "fb_RIGHT" )
	scope
		dim chk as function fbcall ( byref as const string, byval as const integer ) as string
		chk = procptr( right )
	end scope

	ID( function right alias "fb_WstrRight" )
	scope
		dim chk as function fbcall ( byref as const wchar, byval as const integer ) as wchar_ret
		chk = procptr( right )
	end scope

	ID( function space alias "fb_SPACE" )
	scope
		dim chk as function fbcall ( byval as const integer ) as string
		chk = procptr( space )
	end scope

	ID( function wspace alias "fb_WstrSpace" )
	scope
		dim chk as function fbcall ( byval as const integer ) as wchar_ret
		chk = procptr( wspace )
	end scope

	ID( function fb_StrLcase2 )
	scope
		dim chk as function fbcall ( byref as const string, byval as const long = 0 ) as string
		chk = procptr( fb_StrLcase2 )
	end scope

	ID( function fb_WstrLcase2 )
	scope
		dim chk as function fbcall ( byref as const wchar, byval as const long = 0 ) as wchar_ret
		chk = procptr( fb_WstrLcase2 )
	end scope

	ID( function fb_StrUcase2 )
	scope
		dim chk as function fbcall ( byref as const string, byval as const long = 0 ) as string
		chk = procptr( fb_StrUcase2 )
	end scope

	ID( function fb_WstrUcase2 )
	scope
		dim chk as function fbcall ( byref as const wchar, byval as const long = 0 ) as wchar_ret
		chk = procptr( fb_WstrUcase2 )
	end scope

	ID( function fb_CVD alias "fb_CVD" )
	scope
		dim chk as function fbcall ( byref as const string ) as double
		chk = procptr( fb_CVD )
	end scope

	ID( function fb_CVS alias "fb_CVS" )
	scope
		dim chk as function fbcall ( byref as const string ) as single
		chk = procptr( fb_CVS )
	end scope

	ID( function fb_CVSHORT alias "fb_CVSHORT" )
	scope
		dim chk as function fbcall ( byref as const string ) as short
		chk = procptr( fb_CVSHORT )
	end scope

	ID( function fb_CVL )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( fb_CVL )
	end scope

	ID( function fb_CVLONGINT alias "fb_CVLONGINT" )
	scope
		dim chk as function fbcall ( byref as const string ) as longint
		chk = procptr( fb_CVLONGINT )
	end scope

	ID( function fb_CVDFROMLONGINT alias "fb_CVDFROMLONGINT" )
	scope
		dim chk as function fbcall ( byval as const longint ) as double
		chk = procptr( fb_CVDFROMLONGINT )
	end scope

	ID( function fb_CVSFROML alias "fb_CVSFROML" )
	scope
		dim chk as function fbcall ( byval as const long ) as single
		chk = procptr( fb_CVSFROML )
	end scope

	ID( function fb_CVLFROMS alias "fb_CVLFROMS" )
	scope
		dim chk as function fbcall ( byval as const single ) as long
		chk = procptr( fb_CVLFROMS )
	end scope

	ID( function fb_CVLONGINTFROMD alias "fb_CVLONGINTFROMD" )
	scope
		dim chk as function fbcall ( byval as const double ) as longint
		chk = procptr( fb_CVLONGINTFROMD )
	end scope

#print "---- rtlSystem"

#ifndef __FB_64BIT__
	ID( function fb_CpuDetect )
	scope
		dim chk as function cdecl ( ) as ulong
		chk = procptr( fb_CpuDetect )
	end scope
#endif

	ID( sub fb_Init )
	scope
		dim chk as sub fbcall ( byval as long, byval as zstring ptr ptr, byval as long )
		chk = procptr( fb_Init )
	end scope

	ID( sub fb_InitSignals )
	scope
		dim chk as sub fbcall ( )
		chk = procptr( fb_InitSignals )
	end scope

	ID( sub fb___main alias "__main" )
	scope
		dim chk as sub cdecl ( )
		chk = procptr( fb___main )
	end scope

	ID( sub fb_End )
	scope
		dim chk as sub fbcall ( byval as const long )
		chk = procptr( fb_End )
	end scope

	ID( function fb_atexit alias "atexit" )
	scope
		dim chk as function cdecl ( byval as any ptr ) as long
		chk = procptr( fb_atexit )
	end scope

	ID( function command alias "fb_Command" )
	scope
		dim chk as function fbcall ( byval as const long = -1 ) as string
		chk = procptr( command )
	end scope

	ID( function curdir alias "fb_CurDir" )
	scope
		dim chk as function fbcall ( ) as string
		chk = procptr( curdir )
	end scope

	ID( function exepath alias "fb_ExePath" )
	scope
		dim chk as function fbcall ( ) as string
		chk = procptr( exepath )
	end scope

	ID( function timer alias "fb_Timer" )
	scope
		dim chk as function fbcall ( ) as double
		chk = procptr( timer )
	end scope

	ID( function time alias "fb_Time" )
	scope
		dim chk as function fbcall ( ) as string
		chk = procptr( time )
	end scope

	ID( function date alias "fb_Date" )
	scope
		dim chk as function fbcall ( ) as string
		chk = procptr( date )
	end scope

	ID( function shell alias "fb_Shell" )
	scope
		dim chk as function fbcall ( byref as const string = "" ) as long
		chk = procptr( shell )
	end scope

	ID( sub system alias "fb_End" )
	scope
		dim chk as sub fbcall ( byval as const long = 0 )
		chk = procptr( system )
	end scope

	ID( sub stop alias "fb_End" )
	scope
		dim chk as sub fbcall ( byval as const long = 0 )
		chk = procptr( stop )
	end scope

	ID( function run alias "fb_Run" )
	scope
		dim chk as function fbcall ( byref as const string, byref as const string = "" ) as long
		chk = procptr( run )
	end scope

	ID( function chain alias "fb_Chain" )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( chain )
	end scope

	ID( function exec alias "fb_Exec" )
	scope
		dim chk as function fbcall ( byref as const string, byref as const string ) as long
		chk = procptr( exec )
	end scope

	ID( function environ alias "fb_GetEnviron" )
	scope
		dim chk as function fbcall ( byref as const string ) as string
		chk = procptr( environ )
	end scope

	ID( function setenviron alias "fb_SetEnviron" )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( setenviron )
	end scope

	ID( sub sleep alias "fb_Sleep" )
	scope
		dim chk as sub fbcall ( byval as const long = -1 )
		chk = procptr( sleep )
	end scope

#if __FB_LANG__ = "qb"
	ID( sub sleep alias "fb_SleepQB" )
	scope
		dim chk as sub fbcall ( byval as const long = -1 )
		chk = procptr( sleep )
	end scope
#endif

	ID( function sleep alias "fb_SleepEx" )
	scope
		dim chk as function fbcall ( byval as const long, byval as const long ) as long
		chk = procptr( sleep )
	end scope

	ID( function dir alias "fb_DirNext" )
	scope
		dim chk as function fbcall ( byval as long ptr = 0 ) as string
		chk = procptr( dir )
	end scope

	ID( function dir alias "fb_DirNext64" )
	scope
		dim chk as function fbcall ( byval as longint ptr ) as string
		chk = procptr( dir )
	end scope

	ID( function dir alias "fb_DirNext" )
	scope
		dim chk as function fbcall ( byref as long ) as string
		chk = procptr( dir )
	end scope

	ID( function dir alias "fb_DirNext64" )
	scope
		dim chk as function fbcall ( byref as longint ) as string
		chk = procptr( dir )
	end scope

	ID( function dir alias "fb_Dir" )
	scope
		dim chk as function fbcall ( byref as const string, byval as const long = 33, byval as long ptr = 0 ) as string
		chk = procptr( dir )
	end scope

	ID( function dir alias "fb_Dir64" )
	scope
		dim chk as function fbcall ( byref as const string, byval as const long = 33, byval as longint ptr ) as string
		chk = procptr( dir )
	end scope

	ID( function dir alias "fb_Dir" )
	scope
		dim chk as function fbcall ( byref as const string, byval as const long = 33, byref as long ) as string
		chk = procptr( dir )
	end scope

	ID( function dir alias "fb_Dir64" )
	scope
		dim chk as function fbcall ( byref as const string, byval as const long = 33, byref as longint ) as string
		chk = procptr( dir )
	end scope

	ID( function settime alias "fb_SetTime" )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( settime )
	end scope

	ID( function setdate alias "fb_SetDate" )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( setdate )
	end scope

	ID( function threadcreate alias "fb_ThreadCreate" )
	scope
		dim chk as function fbcall ( byval as sub (  byval as any ptr ), byval as any ptr = 0, byval as const integer = 0 ) as any ptr
		chk = procptr( threadcreate )
	end scope

	ID( sub threadwait alias "fb_ThreadWait" )
	scope
		dim chk as sub fbcall ( byval as any ptr )
		chk = procptr( threadwait )
	end scope

	ID( function fb_ThreadCall )
	scope
		dim chk as function cdecl ( byval as any ptr, byval as const long, byval as const integer, byval as const long, ... ) as any ptr
		chk = procptr( fb_ThreadCall )
	end scope

	ID( function mutexcreate alias "fb_MutexCreate" )
	scope
		dim chk as function fbcall ( ) as any ptr
		chk = procptr( mutexcreate )
	end scope

	ID( sub mutexdestroy alias "fb_MutexDestroy" )
	scope
		dim chk as sub fbcall ( byval as any ptr )
		chk = procptr( mutexdestroy )
	end scope

	ID( sub mutexlock alias "fb_MutexLock" )
	scope
		dim chk as sub fbcall ( byval as any ptr )
		chk = procptr( mutexlock )
	end scope

	ID( sub mutexunlock alias "fb_MutexUnlock" )
	scope
		dim chk as sub fbcall ( byval as any ptr )
		chk = procptr( mutexunlock )
	end scope

	ID( function condcreate alias "fb_CondCreate" )
	scope
		dim chk as function fbcall ( ) as any ptr
		chk = procptr( condcreate )
	end scope

	ID( sub conddestroy alias "fb_CondDestroy" )
	scope
		dim chk as sub fbcall ( byval as any ptr )
		chk = procptr( conddestroy )
	end scope

	ID( sub condsignal alias "fb_CondSignal" )
	scope
		dim chk as sub fbcall ( byval as any ptr )
		chk = procptr( condsignal )
	end scope

	ID( sub condbroadcast alias "fb_CondBroadcast" )
	scope
		dim chk as sub fbcall ( byval as any ptr )
		chk = procptr( condbroadcast )
	end scope

	ID( sub condwait alias "fb_CondWait" )
	scope
		dim chk as sub fbcall ( byval as any ptr, byval as any ptr )
		chk = procptr( condwait )
	end scope

	ID( function dylibload alias "fb_DylibLoad" )
	scope
		dim chk as function fbcall ( byref as const string ) as any ptr
		chk = procptr( dylibload )
	end scope

	ID( function dylibsymbol alias "fb_DylibSymbol" )
	scope
		dim chk as function fbcall ( byval as any ptr, byref as const string ) as any ptr
		chk = procptr( dylibsymbol )
	end scope

	ID( function dylibsymbol alias "fb_DylibSymbolByOrd" )
	scope
		dim chk as function fbcall ( byval as any ptr, byval as const short ) as any ptr
		chk = procptr( dylibsymbol )
	end scope

	ID( sub dylibfree alias "fb_DylibFree" )
	scope
		dim chk as sub fbcall ( byval as any ptr )
		chk = procptr( dylibfree )
	end scope

	ID( sub beep alias "fb_Beep" )
	scope
		dim chk as sub fbcall ( )
		chk = procptr( beep )
	end scope

	ID( function mkdir alias "fb_MkDir" )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( mkdir )
	end scope

	ID( function rmdir alias "fb_RmDir" )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( rmdir )
	end scope

	ID( function chdir alias "fb_ChDir" )
	scope
		dim chk as function fbcall ( byref as const string ) as long
		chk = procptr( chdir )
	end scope

#print "---- rtlGosub"

#if 0
	ID( function fb_GosubPush )
	scope
		dim chk as function fbcall ( byval as any ptr ptr ) as any ptr
		chk = procptr( fb_GosubPush )
	end scope
#endif

#if 0
	ID( function fb_GosubPop )
	scope
		dim chk as function fbcall ( byval as any ptr ptr ) as long
		chk = procptr( fb_GosubPop )
	end scope
#endif

#if 0
	ID( function fb_GosubReturn )
	scope
		dim chk as function fbcall ( byval as any ptr ptr ) as long
		chk = procptr( fb_GosubReturn )
	end scope
#endif

#if 0
	ID( sub fb_GosubExit )
	scope
		dim chk as sub fbcall ( byval as any ptr ptr )
		chk = procptr( fb_GosubExit )
	end scope
#endif

#print "---- rtlGosub_win32"

#if 0
	ID( function fb_SetJmp alias "_setjmp" )
	scope
		dim chk as function cdecl ( byval as any ptr ) as long
		chk = procptr( fb_SetJmp )
	end scope
#endif

#print "---- rtlGosub_other"

#if 0
	ID( function fb_SetJmp alias "_setjmp" )
	scope
		dim chk as function cdecl ( byval as any ptr, byval as any ptr ) as long
		chk = procptr( fb_SetJmp )
	end scope
#endif

#print "---- rtlOOP"

	ID( function fb_IsTypeOf )
	scope
		dim chk as function fbcall ( byref as any, byref as any ) as long
		chk = procptr( fb_IsTypeOf )
	end scope

