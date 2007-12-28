''
''
'' log -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_log_bi__
#define __wxc_log_bi__

#include once "wx.bi"

declare function wxLog alias "wxLog_ctor" () as wxLog ptr
declare sub wxLog_dtor (byval self as wxLog ptr)
declare function wxLog_IsEnabled () as integer
declare function wxLog_EnableLogging (byval doit as integer) as integer
declare sub wxLog_OnLog (byval level as uinteger, byval szString as zstring ptr, byval t as integer)
declare sub wxLog_Flush (byval self as wxLog ptr)
declare function wxLog_HasPendingMessages (byval self as wxLog ptr) as integer
declare sub wxLog_FlushActive ()
declare function wxLog_GetActiveTarget () as wxLog ptr
declare function wxLog_SetActiveTargetTextCtrl (byval pLogger as wxTextCtrl ptr) as wxLog ptr
declare sub wxLog_DeleteActiveTarget ()
declare sub wxLog_Suspend ()
declare sub wxLog_Resume ()
declare sub wxLog_SetVerbose (byval bVerbose as integer)
declare sub wxLog_SetLogLevel (byval logLevel as wxLogLevel)
declare sub wxLog_DontCreateOnDemand ()
declare sub wxLog_SetTraceMask (byval ulMask as wxTraceMask)
declare sub wxLog_AddTraceMask (byval str as zstring ptr)
declare sub wxLog_RemoveTraceMask (byval str as zstring ptr)
declare sub wxLog_ClearTraceMasks ()
declare function wxLog_GetTraceMasks () as wxArrayString ptr
declare sub wxLog_SetTimestamp (byval ts as zstring ptr)
declare function wxLog_GetVerbose () as integer
declare function wxLog_GetTraceMask () as wxTraceMask
declare function wxLog_IsAllowedTraceMask (byval mask as zstring ptr) as integer
declare function wxLog_GetLogLevel () as wxLogLevel
declare function wxLog_GetTimestamp () as wxString ptr
declare sub wxLog_TimeStamp (byval str as zstring ptr)

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

declare sub wxLog_Log_Function (byval what as integer, byval szFormat as zstring ptr)

#endif
