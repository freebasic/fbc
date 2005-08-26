''
''
'' log -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __log_bi__
#define __log_bi__

#include once "wx-c/wx.bi"

declare function wxLog cdecl alias "wxLog_ctor" () as wxLog ptr
declare sub wxLog_dtor cdecl alias "wxLog_dtor" (byval self as wxLog ptr)
declare function wxLog_IsEnabled cdecl alias "wxLog_IsEnabled" () as integer
declare function wxLog_EnableLogging cdecl alias "wxLog_EnableLogging" (byval doit as integer) as integer
declare sub wxLog_OnLog cdecl alias "wxLog_OnLog" (byval level as uinteger, byval szString as zstring ptr, byval t as integer)
declare sub wxLog_Flush cdecl alias "wxLog_Flush" (byval self as wxLog ptr)
declare function wxLog_HasPendingMessages cdecl alias "wxLog_HasPendingMessages" (byval self as wxLog ptr) as integer
declare sub wxLog_FlushActive cdecl alias "wxLog_FlushActive" ()
declare function wxLog_GetActiveTarget cdecl alias "wxLog_GetActiveTarget" () as wxLog ptr
declare function wxLog_SetActiveTargetTextCtrl cdecl alias "wxLog_SetActiveTargetTextCtrl" (byval pLogger as wxTextCtrl ptr) as wxLog ptr
declare sub wxLog_DeleteActiveTarget cdecl alias "wxLog_DeleteActiveTarget" ()
declare sub wxLog_Suspend cdecl alias "wxLog_Suspend" ()
declare sub wxLog_Resume cdecl alias "wxLog_Resume" ()
declare sub wxLog_SetVerbose cdecl alias "wxLog_SetVerbose" (byval bVerbose as integer)
declare sub wxLog_SetLogLevel cdecl alias "wxLog_SetLogLevel" (byval logLevel as wxLogLevel)
declare sub wxLog_DontCreateOnDemand cdecl alias "wxLog_DontCreateOnDemand" ()
declare sub wxLog_SetTraceMask cdecl alias "wxLog_SetTraceMask" (byval ulMask as wxTraceMask)
declare sub wxLog_AddTraceMask cdecl alias "wxLog_AddTraceMask" (byval str as zstring ptr)
declare sub wxLog_RemoveTraceMask cdecl alias "wxLog_RemoveTraceMask" (byval str as zstring ptr)
declare sub wxLog_ClearTraceMasks cdecl alias "wxLog_ClearTraceMasks" ()
declare function wxLog_GetTraceMasks cdecl alias "wxLog_GetTraceMasks" () as wxArrayString ptr
declare sub wxLog_SetTimestamp cdecl alias "wxLog_SetTimestamp" (byval ts as zstring ptr)
declare function wxLog_GetVerbose cdecl alias "wxLog_GetVerbose" () as integer
declare function wxLog_GetTraceMask cdecl alias "wxLog_GetTraceMask" () as wxTraceMask
declare function wxLog_IsAllowedTraceMask cdecl alias "wxLog_IsAllowedTraceMask" (byval mask as zstring ptr) as integer
declare function wxLog_GetLogLevel cdecl alias "wxLog_GetLogLevel" () as wxLogLevel
declare function wxLog_GetTimestamp cdecl alias "wxLog_GetTimestamp" () as wxString ptr
declare sub wxLog_TimeStamp cdecl alias "wxLog_TimeStamp" (byval str as zstring ptr)

enum 
	xLOGMESSAGE
	xFATALERROR
	xERROR
	xWARNING
	xINFO
	xVERBOSE
	xSTATUS
	xSYSERROR
end enum

declare sub wxLog_Log_Function cdecl alias "wxLog_Log_Function" (byval what as integer, byval szFormat as zstring ptr)

#endif
