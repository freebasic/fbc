'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "Windows"

#define _INC_SCRNSAVE
const IDS_DESCRIPTION = 1
const ID_APP = 100
const DLG_SCRNSAVECONFIGURE = 2003
const idsIsPassword = 1000
const idsIniFile = 1001
const idsScreenSaver = 1002
const idsPassword = 1003
const idsDifferentPW = 1004
const idsChangePW = 1005
const idsBadOldPW = 1006
const idsAppName = 1007
const idsNoHelpMemory = 1008
const idsHelpFile = 1009
const idsDefKeyword = 1010

#ifdef UNICODE
	declare function ScreenSaverProcW(byval hWnd as HWND, byval message as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
	declare function ScreenSaverProc alias "ScreenSaverProcW"(byval hWnd as HWND, byval message as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#else
	declare function ScreenSaverProc(byval hWnd as HWND, byval message as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function DefScreenSaverProc(byval hWnd as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function ScreenSaverConfigureDialog(byval hDlg as HWND, byval message as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
declare function RegisterDialogClasses(byval hInst as HANDLE) as WINBOOL

const WS_GT = WS_GROUP or WS_TABSTOP
const MAXFILELEN = 13
const TITLEBARNAMELEN = 40
const APPNAMEBUFFERLEN = 40
const BUFFLEN = 255

extern hMainInstance as HINSTANCE
extern hMainWindow as HWND
extern fChildPreview as WINBOOL

#ifdef UNICODE
	extern szName as wstring * 40
	extern szAppName as wstring * 40
	extern szIniFile as wstring * 13
	extern szScreenSaver as wstring * 22
	extern szHelpFile as wstring * 13
	extern szNoHelpMemory as wstring * 255
#else
	extern szName as zstring * 40
	extern szAppName as zstring * 40
	extern szIniFile as zstring * 13
	extern szScreenSaver as zstring * 22
	extern szHelpFile as zstring * 13
	extern szNoHelpMemory as zstring * 255
#endif

extern MyHelpMessage as UINT
const SCRM_VERIFYPW = WM_APP
declare sub ScreenSaverChangePassword(byval hParent as HWND)

end extern
