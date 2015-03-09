#pragma once

extern "Windows"

#define _INC_SCRNSAVE
#define IDS_DESCRIPTION 1
#define ID_APP 100
#define DLG_SCRNSAVECONFIGURE 2003
#define idsIsPassword 1000
#define idsIniFile 1001
#define idsScreenSaver 1002
#define idsPassword 1003
#define idsDifferentPW 1004
#define idsChangePW 1005
#define idsBadOldPW 1006
#define idsAppName 1007
#define idsNoHelpMemory 1008
#define idsHelpFile 1009
#define idsDefKeyword 1010

#ifdef UNICODE
	declare function ScreenSaverProcW(byval hWnd as HWND, byval message as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

	#define ScreenSaverProc ScreenSaverProcW
#else
	declare function ScreenSaverProc(byval hWnd as HWND, byval message as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function DefScreenSaverProc(byval hWnd as HWND, byval msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function ScreenSaverConfigureDialog(byval hDlg as HWND, byval message as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
declare function RegisterDialogClasses(byval hInst as HANDLE) as WINBOOL

#define WS_GT (WS_GROUP or WS_TABSTOP)
#define MAXFILELEN 13
#define TITLEBARNAMELEN 40
#define APPNAMEBUFFERLEN 40
#define BUFFLEN 255

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

#define SCRM_VERIFYPW WM_APP

declare sub ScreenSaverChangePassword(byval hParent as HWND)

end extern
