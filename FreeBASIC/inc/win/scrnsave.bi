''
''
'' scrnsave -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_scrnsave_bi__
#define __win_scrnsave_bi__

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
#define IDS_DESCRIPTION 1
#define ID_APP 100
#define WS_GT (&h20000 or &h10000)
#define SCRM_VERIFYPW 32768
#define MAXFILELEN 13
#define TITLEBARNAMELEN 40
#define APPNAMEBUFFERLEN 40
#define BUFFLEN 255

declare function ScreenSaverConfigureDialog alias "ScreenSaverConfigureDialog" (byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as BOOL
declare function RegisterDialogClasses alias "RegisterDialogClasses" (byval as HANDLE) as BOOL
declare function ScreenSaverProc alias "ScreenSaverProc" (byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as LONG
declare function DefScreenSaverProc alias "DefScreenSaverProc" (byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as LONG
declare sub ScreenSaverChangePassword alias "ScreenSaverChangePassword" (byval as HWND)

extern hMainInstance alias "hMainInstance" as HINSTANCE
extern hMainWindow alias "hMainWindow" as HWND
extern fChildPreview alias "fChildPreview" as BOOL
extern szName alias "szName" as zstring ptr
extern szAppName alias "szAppName" as zstring ptr 
extern szIniFile alias "szIniFile" as zstring ptr 
extern szScreenSaver alias "szScreenSaver" as zstring ptr
extern szHelpFile alias "szHelpFile" as zstring ptr
extern szNoHelpMemory alias "szNoHelpMemory" as zstring ptr
extern MyHelpMessage alias "MyHelpMessage" as UINT

#endif
