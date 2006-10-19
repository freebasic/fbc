''
''
'' GdiplusInit -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_GdiplusInit_bi__
#define __win_GdiplusInit_bi__

enum DebugEventLevel
	DebugEventLevelFatal
	DebugEventLevelWarning
end enum

type DebugEventProc as sub (byval as DebugEventLevel, byval as CHAR ptr)
type NotificationHookProc as function (byval as ULONG_PTR ptr) as Status
type NotificationUnhookProc as sub (byval as ULONG_PTR)

type GdiplusStartupInput
	GdiplusVersion as UINT32
	DebugEventCallback as DebugEventProc
	SuppressBackgroundThread as BOOL
	SuppressExternalCodecs as BOOL
end type

type GdiplusStartupOutput
	NotificationHook as NotificationHookProc
	NotificationUnhook as NotificationUnhookProc
end type
	
extern "windows"
	declare function GdiplusStartup (byval token as ULONG_PTR ptr, byval input as GdiplusStartupInput ptr, byval output as GdiplusStartupOutput ptr) as Status
	declare sub GdiplusShutdown (byval token as ULONG_PTR)
end extern

#endif
