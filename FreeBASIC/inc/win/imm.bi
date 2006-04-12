''
''
'' imm -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_imm_bi__
#define __win_imm_bi__

#inclib "imm32"

#define WM_CONVERTREQUESTEX &h108
#define WM_IME_STARTCOMPOSITION &h10D
#define WM_IME_ENDCOMPOSITION &h10E
#define WM_IME_COMPOSITION &h10F
#define WM_IME_KEYLAST &h10F
#define WM_IME_SETCONTEXT &h281
#define WM_IME_NOTIFY &h282
#define WM_IME_CONTROL &h283
#define WM_IME_COMPOSITIONFULL &h284
#define WM_IME_SELECT &h285
#define WM_IME_CHAR &h286
#define WM_IME_KEYDOWN &h290
#define WM_IME_KEYUP &h291
#define IMC_GETCANDIDATEPOS 7
#define IMC_SETCANDIDATEPOS 8
#define IMC_GETCOMPOSITIONFONT 9
#define IMC_SETCOMPOSITIONFONT 10
#define IMC_GETCOMPOSITIONWINDOW 11
#define IMC_SETCOMPOSITIONWINDOW 12
#define IMC_GETSTATUSWINDOWPOS 15
#define IMC_SETSTATUSWINDOWPOS 16
#define IMC_CLOSESTATUSWINDOW &h21
#define IMC_OPENSTATUSWINDOW &h22
#define IMN_CLOSESTATUSWINDOW 1
#define IMN_OPENSTATUSWINDOW 2
#define IMN_CHANGECANDIDATE 3
#define IMN_CLOSECANDIDATE 4
#define IMN_OPENCANDIDATE 5
#define IMN_SETCONVERSIONMODE 6
#define IMN_SETSENTENCEMODE 7
#define IMN_SETOPENSTATUS 8
#define IMN_SETCANDIDATEPOS 9
#define IMN_SETCOMPOSITIONFONT 10
#define IMN_SETCOMPOSITIONWINDOW 11
#define IMN_SETSTATUSWINDOWPOS 12
#define IMN_GUIDELINE 13
#define IMN_PRIVATE 14
#define NI_OPENCANDIDATE 16
#define NI_CLOSECANDIDATE 17
#define NI_SELECTCANDIDATESTR 18
#define NI_CHANGECANDIDATELIST 19
#define NI_FINALIZECONVERSIONRESULT 20
#define NI_COMPOSITIONSTR 21
#define NI_SETCANDIDATE_PAGESTART 22
#define NI_SETCANDIDATE_PAGESIZE 23
#define NI_IMEMENUSELECTED 24
#define ISC_SHOWUICANDIDATEWINDOW 1
#define ISC_SHOWUICOMPOSITIONWINDOW &h80000000
#define ISC_SHOWUIGUIDELINE &h40000000
#define ISC_SHOWUIALLCANDIDATEWINDOW 15
#define ISC_SHOWUIALL &hC000000F
#define CPS_COMPLETE 1
#define CPS_CONVERT 2
#define CPS_REVERT 3
#define CPS_CANCEL 4
#define IME_CHOTKEY_IME_NONIME_TOGGLE 16
#define IME_CHOTKEY_SHAPE_TOGGLE 17
#define IME_CHOTKEY_SYMBOL_TOGGLE 18
#define IME_JHOTKEY_CLOSE_OPEN &h30
#define IME_KHOTKEY_SHAPE_TOGGLE &h50
#define IME_KHOTKEY_HANJACONVERT &h51
#define IME_KHOTKEY_ENGLISH &h52
#define IME_THOTKEY_IME_NONIME_TOGGLE &h70
#define IME_THOTKEY_SHAPE_TOGGLE &h71
#define IME_THOTKEY_SYMBOL_TOGGLE &h72
#define IME_HOTKEY_DSWITCH_FIRST 256
#define IME_HOTKEY_DSWITCH_LAST &h11F
#define IME_ITHOTKEY_RESEND_RESULTSTR 512
#define IME_ITHOTKEY_PREVIOUS_COMPOSITION 513
#define IME_ITHOTKEY_UISTYLE_TOGGLE 514
#define GCS_COMPREADSTR 1
#define GCS_COMPREADATTR 2
#define GCS_COMPREADCLAUSE 4
#define GCS_COMPSTR 8
#define GCS_COMPATTR 16
#define GCS_COMPCLAUSE 32
#define GCS_CURSORPOS 128
#define GCS_DELTASTART 256
#define GCS_RESULTREADSTR 512
#define GCS_RESULTREADCLAUSE 1024
#define GCS_RESULTSTR 2048
#define GCS_RESULTCLAUSE 4096
#define CS_INSERTCHAR &h2000
#define CS_NOMOVECARET &h4000
#define IMEVER_0310 &h3000A
#define IMEVER_0400 &h40000
#define IME_PROP_AT_CARET &h10000
#define IME_PROP_SPECIAL_UI &h20000
#define IME_PROP_CANDLIST_START_FROM_1 &h40000
#define IME_PROP_UNICODE &h80000
#define UI_CAP_2700 1
#define UI_CAP_ROT90 2
#define UI_CAP_ROTANY 4
#define SCS_CAP_COMPSTR 1
#define SCS_CAP_MAKEREAD 2
#define SELECT_CAP_CONVERSION 1
#define SELECT_CAP_SENTENCE 2
#define GGL_LEVEL 1
#define GGL_INDEX 2
#define GGL_STRING 3
#define GGL_PRIVATE 4
#define GL_LEVEL_NOGUIDELINE 0
#define GL_LEVEL_FATAL 1
#define GL_LEVEL_ERROR 2
#define GL_LEVEL_WARNING 3
#define GL_LEVEL_INFORMATION 4
#define GL_ID_UNKNOWN 0
#define GL_ID_NOMODULE 1
#define GL_ID_NODICTIONARY 16
#define GL_ID_CANNOTSAVE 17
#define GL_ID_NOCONVERT 32
#define GL_ID_TYPINGERROR 33
#define GL_ID_TOOMANYSTROKE 34
#define GL_ID_READINGCONFLICT 35
#define GL_ID_INPUTREADING 36
#define GL_ID_INPUTRADICAL 37
#define GL_ID_INPUTCODE 38
#define GL_ID_INPUTSYMBOL 39
#define GL_ID_CHOOSECANDIDATE 40
#define GL_ID_REVERSECONVERSION 41
#define GL_ID_PRIVATE_FIRST &h8000
#define GL_ID_PRIVATE_LAST &hFFFF
#define IGP_GETIMEVERSION cuint(-4)
#define IGP_PROPERTY 4
#define IGP_CONVERSION 8
#define IGP_SENTENCE 12
#define IGP_UI 16
#define IGP_SETCOMPSTR &h14
#define IGP_SELECT &h18
#define SCS_SETSTR (1 or 8)
#define SCS_CHANGEATTR (2 or 16)
#define SCS_CHANGECLAUSE (4 or 32)
#define ATTR_INPUT 0
#define ATTR_TARGET_CONVERTED 1
#define ATTR_CONVERTED 2
#define ATTR_TARGET_NOTCONVERTED 3
#define ATTR_INPUT_ERROR 4
#define ATTR_FIXEDCONVERTED 5
#define CFS_DEFAULT 0
#define CFS_RECT 1
#define CFS_POINT 2
#define CFS_SCREEN 4
#define CFS_FORCE_POSITION 32
#define CFS_CANDIDATEPOS 64
#define CFS_EXCLUDE 128
#define GCL_CONVERSION 1
#define GCL_REVERSECONVERSION 2
#define GCL_REVERSE_LENGTH 3
#define IME_CMODE_ALPHANUMERIC 0
#define IME_CMODE_NATIVE 1
#define IME_CMODE_CHINESE 1
#define IME_CMODE_HANGEUL 1
#define IME_CMODE_HANGUL 1
#define IME_CMODE_JAPANESE 1
#define IME_CMODE_KATAKANA 2
#define IME_CMODE_LANGUAGE 3
#define IME_CMODE_FULLSHAPE 8
#define IME_CMODE_ROMAN 16
#define IME_CMODE_CHARCODE 32
#define IME_CMODE_HANJACONVERT 64
#define IME_CMODE_SOFTKBD 128
#define IME_CMODE_NOCONVERSION 256
#define IME_CMODE_EUDC 512
#define IME_CMODE_SYMBOL 1024
#define IME_CMODE_FIXED 2048
#define IME_SMODE_NONE 0
#define IME_SMODE_PLAURALCLAUSE 1
#define IME_SMODE_SINGLECONVERT 2
#define IME_SMODE_AUTOMATIC 4
#define IME_SMODE_PHRASEPREDICT 8
#define IME_CAND_UNKNOWN 0
#define IME_CAND_READ 1
#define IME_CAND_CODE 2
#define IME_CAND_MEANING 3
#define IME_CAND_RADICAL 4
#define IME_CAND_STROKE 5
#define IMM_ERROR_NODATA (-1)
#define IMM_ERROR_GENERAL (-2)
#define IME_CONFIG_GENERAL 1
#define IME_CONFIG_REGISTERWORD 2
#define IME_CONFIG_SELECTDICTIONARY 3
#define IME_ESC_QUERY_SUPPORT 3
#define IME_ESC_RESERVED_FIRST 4
#define IME_ESC_RESERVED_LAST &h7FF
#define IME_ESC_PRIVATE_FIRST &h800
#define IME_ESC_PRIVATE_LAST &hFFF
#define IME_ESC_SEQUENCE_TO_INTERNAL &h1001
#define IME_ESC_GET_EUDC_DICTIONARY &h1003
#define IME_ESC_SET_EUDC_DICTIONARY &h1004
#define IME_ESC_MAX_KEY &h1005
#define IME_ESC_IME_NAME &h1006
#define IME_ESC_SYNC_HOTKEY &h1007
#define IME_ESC_HANJA_MODE &h1008
#define IME_ESC_AUTOMATA &h1009
#define IME_REGWORD_STYLE_EUDC 1
#define IME_REGWORD_STYLE_USER_FIRST &h80000000
#define IME_REGWORD_STYLE_USER_LAST &hFFFFFFFF
#define SOFTKEYBOARD_TYPE_T1 1
#define SOFTKEYBOARD_TYPE_C1 2
#define IMEMENUITEM_STRING_SIZE 80
#define MOD_ALT 1
#define MOD_CONTROL 2
#define MOD_SHIFT 4
#define MOD_WIN 8
#define MOD_IGNORE_ALL_MODIFIER 1024
#define MOD_ON_KEYUP 2048
#define MOD_RIGHT 16384
#define MOD_LEFT 32768
#define IACE_CHILDREN 1
#define IACE_DEFAULT 16
#define IACE_IGNORENOCONTEXT 32
#define IGIMIF_RIGHTMENU 1
#define IGIMII_CMODE 1
#define IGIMII_SMODE 2
#define IGIMII_CONFIGURE 4
#define IGIMII_TOOLS 8
#define IGIMII_HELP 16
#define IGIMII_OTHER 32
#define IGIMII_INPUTTOOLS 64
#define IMFT_RADIOCHECK 1
#define IMFT_SEPARATOR 2
#define IMFT_SUBMENU 4
#define IMFS_GRAYED 3
#define IMFS_DISABLED 3
#define IMFS_CHECKED 8
#define IMFS_HILITE 128
#define IMFS_ENABLED 0
#define IMFS_UNCHECKED 0
#define IMFS_UNHILITE 0
#define IMFS_DEFAULT 4096
#ifndef VK_PROCESSKEY
#define VK_PROCESSKEY &h0E5
#endif
#define STYLE_DESCRIPTION_SIZE 32

type HIMC as DWORD
type HIMCC as DWORD
type LPHKL as HKL ptr

type COMPOSITIONFORM
	dwStyle as DWORD
	ptCurrentPos as POINT
	rcArea as RECT
end type

type PCOMPOSITIONFORM as COMPOSITIONFORM ptr
type LPCOMPOSITIONFORM as COMPOSITIONFORM ptr

type CANDIDATEFORM
	dwIndex as DWORD
	dwStyle as DWORD
	ptCurrentPos as POINT
	rcArea as RECT
end type

type PCANDIDATEFORM as CANDIDATEFORM ptr
type LPCANDIDATEFORM as CANDIDATEFORM ptr

type CANDIDATELIST
	dwSize as DWORD
	dwStyle as DWORD
	dwCount as DWORD
	dwSelection as DWORD
	dwPageStart as DWORD
	dwPageSize as DWORD
	dwOffset(0 to 1-1) as DWORD
end type

type PCANDIDATELIST as CANDIDATELIST ptr
type LPCANDIDATELIST as CANDIDATELIST ptr

#ifndef UNICODE
type REGISTERWORDA
	lpReading as LPSTR
	lpWord as LPSTR
end type

type PREGISTERWORDA as REGISTERWORDA ptr
type LPREGISTERWORDA as REGISTERWORDA ptr

type STYLEBUFA
	dwStyle as DWORD
	szDescription as zstring * 32
end type

type PSTYLEBUFA as STYLEBUFA ptr
type LPSTYLEBUFA as STYLEBUFA ptr

type IMEMENUITEMINFOA
	cbSize as UINT
	fType as UINT
	fState as UINT
	wID as UINT
	hbmpChecked as HBITMAP
	hbmpUnchecked as HBITMAP
	dwItemData as DWORD
	szString as zstring * 80
	hbmpItem as HBITMAP
end type

type PIMEMENUITEMINFOA as IMEMENUITEMINFOA ptr
type LPIMEMENUITEMINFOA as IMEMENUITEMINFOA ptr

#else ''UNICODE
type REGISTERWORDW
	lpReading as LPWSTR
	lpWord as LPWSTR
end type

type PREGISTERWORDW as REGISTERWORDW ptr
type LPREGISTERWORDW as REGISTERWORDW ptr

type STYLEBUFW
	dwStyle as DWORD
	szDescription as wstring * 32
end type

type PSTYLEBUFW as STYLEBUFW ptr
type LPSTYLEBUFW as STYLEBUFW ptr

type IMEMENUITEMINFOW
	cbSize as UINT
	fType as UINT
	fState as UINT
	wID as UINT
	hbmpChecked as HBITMAP
	hbmpUnchecked as HBITMAP
	dwItemData as DWORD
	szString as wstring * 80
	hbmpItem as HBITMAP
end type

type PIMEMENUITEMINFOW as IMEMENUITEMINFOW ptr
type LPIMEMENUITEMINFOW as IMEMENUITEMINFOW ptr
#endif ''UNICODE

#ifdef UNICODE
type REGISTERWORDENUMPROCW as function (byval as LPCWSTR, byval as DWORD, byval as LPCWSTR, byval as LPVOID) as integer
#define REGISTERWORDENUMPROC REGISTERWORDENUMPROCW
type REGISTERWORD as REGISTERWORDW
type PREGISTERWORD as REGISTERWORDW ptr
type LPREGISTERWORD as REGISTERWORDW ptr
type STYLEBUF as STYLEBUFW
type PSTYLEBUF as STYLEBUFW ptr
type LPSTYLEBUF as STYLEBUFW ptr
type IMEMENUITEMINFO as IMEMENUITEMINFOW
type PIMEMENUITEMINFO as IMEMENUITEMINFOW ptr
type LPIMEMENUITEMINFO as IMEMENUITEMINFOW ptr

#else ''UNICODE
type REGISTERWORDENUMPROCA as function (byval as LPCSTR, byval as DWORD, byval as LPCSTR, byval as LPVOID) as integer
#define REGISTERWORDENUMPROC REGISTERWORDENUMPROCA
type REGISTERWORD as REGISTERWORDA
type PREGISTERWORD as REGISTERWORDA ptr
type LPREGISTERWORD as REGISTERWORDA ptr
type STYLEBUF as STYLEBUFA
type PSTYLEBUF as STYLEBUFA ptr
type LPSTYLEBUF as STYLEBUFA ptr
type IMEMENUITEMINFO as IMEMENUITEMINFOA
type PIMEMENUITEMINFO as IMEMENUITEMINFOA ptr
type LPIMEMENUITEMINFO as IMEMENUITEMINFOA ptr
#endif ''UNICODE

declare function ImmGetDefaultIMEWnd alias "ImmGetDefaultIMEWnd" (byval as HWND) as HWND
declare function ImmGetProperty alias "ImmGetProperty" (byval as HKL, byval as DWORD) as DWORD
declare function ImmIsIME alias "ImmIsIME" (byval as HKL) as BOOL
declare function ImmSimulateHotKey alias "ImmSimulateHotKey" (byval as HWND, byval as DWORD) as BOOL
declare function ImmCreateContext alias "ImmCreateContext" () as HIMC
declare function ImmDestroyContext alias "ImmDestroyContext" (byval as HIMC) as BOOL
declare function ImmGetContext alias "ImmGetContext" (byval as HWND) as HIMC
declare function ImmReleaseContext alias "ImmReleaseContext" (byval as HWND, byval as HIMC) as BOOL
declare function ImmAssociateContext alias "ImmAssociateContext" (byval as HWND, byval as HIMC) as HIMC
declare function ImmGetConversionStatus alias "ImmGetConversionStatus" (byval as HIMC, byval as LPDWORD, byval as PDWORD) as BOOL
declare function ImmSetConversionStatus alias "ImmSetConversionStatus" (byval as HIMC, byval as DWORD, byval as DWORD) as BOOL
declare function ImmGetOpenStatus alias "ImmGetOpenStatus" (byval as HIMC) as BOOL
declare function ImmSetOpenStatus alias "ImmSetOpenStatus" (byval as HIMC, byval as BOOL) as BOOL
declare function ImmNotifyIME alias "ImmNotifyIME" (byval as HIMC, byval as DWORD, byval as DWORD, byval as DWORD) as BOOL
declare function ImmGetStatusWindowPos alias "ImmGetStatusWindowPos" (byval as HIMC, byval as LPPOINT) as BOOL
declare function ImmSetStatusWindowPos alias "ImmSetStatusWindowPos" (byval as HIMC, byval as LPPOINT) as BOOL
declare function ImmGetCompositionWindow alias "ImmGetCompositionWindow" (byval as HIMC, byval as PCOMPOSITIONFORM) as BOOL
declare function ImmSetCompositionWindow alias "ImmSetCompositionWindow" (byval as HIMC, byval as PCOMPOSITIONFORM) as BOOL
declare function ImmGetCandidateWindow alias "ImmGetCandidateWindow" (byval as HIMC, byval as DWORD, byval as PCANDIDATEFORM) as BOOL
declare function ImmSetCandidateWindow alias "ImmSetCandidateWindow" (byval as HIMC, byval as PCANDIDATEFORM) as BOOL
declare function ImmGetVirtualKey alias "ImmGetVirtualKey" (byval as HWND) as UINT
declare function EnableEUDC alias "EnableEUDC" (byval as BOOL) as BOOL
declare function ImmDisableIME alias "ImmDisableIME" (byval as DWORD) as BOOL

#ifdef UNICODE
declare function ImmInstallIME alias "ImmInstallIMEW" (byval as LPCWSTR, byval as LPCWSTR) as HKL
declare function ImmGetDescription alias "ImmGetDescriptionW" (byval as HKL, byval as LPWSTR, byval as UINT) as UINT
declare function ImmGetIMEFileName alias "ImmGetIMEFileNameW" (byval as HKL, byval as LPWSTR, byval as UINT) as UINT
declare function ImmGetCompositionString alias "ImmGetCompositionStringW" (byval as HIMC, byval as DWORD, byval as PVOID, byval as DWORD) as LONG
declare function ImmSetCompositionString alias "ImmSetCompositionStringW" (byval as HIMC, byval as DWORD, byval as PCVOID, byval as DWORD, byval as PCVOID, byval as DWORD) as BOOL
declare function ImmGetCandidateListCount alias "ImmGetCandidateListCountW" (byval as HIMC, byval as PDWORD) as DWORD
declare function ImmGetCandidateList alias "ImmGetCandidateListW" (byval as HIMC, byval as DWORD, byval as PCANDIDATELIST, byval as DWORD) as DWORD
declare function ImmGetGuideLine alias "ImmGetGuideLineW" (byval as HIMC, byval as DWORD, byval as LPWSTR, byval as DWORD) as DWORD
declare function ImmGetCompositionFont alias "ImmGetCompositionFontW" (byval as HIMC, byval as LPLOGFONTW) as BOOL
declare function ImmSetCompositionFont alias "ImmSetCompositionFontW" (byval as HIMC, byval as LPLOGFONTW) as BOOL
declare function ImmConfigureIME alias "ImmConfigureIMEW" (byval as HKL, byval as HWND, byval as DWORD, byval as PVOID) as BOOL
declare function ImmEscape alias "ImmEscapeW" (byval as HKL, byval as HIMC, byval as UINT, byval as PVOID) as LRESULT
declare function ImmGetConversionList alias "ImmGetConversionListW" (byval as HKL, byval as HIMC, byval as LPCWSTR, byval as PCANDIDATELIST, byval as DWORD, byval as UINT) as DWORD
declare function ImmIsUIMessage alias "ImmIsUIMessageW" (byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as BOOL
declare function ImmRegisterWord alias "ImmRegisterWordW" (byval as HKL, byval as LPCWSTR, byval as DWORD, byval as LPCWSTR) as BOOL
declare function ImmUnregisterWord alias "ImmUnregisterWordW" (byval as HKL, byval as LPCWSTR, byval as DWORD, byval as LPCWSTR) as BOOL
declare function ImmGetRegisterWordStyle alias "ImmGetRegisterWordStyleW" (byval as HKL, byval as UINT, byval as PSTYLEBUFW) as UINT
declare function ImmEnumRegisterWord alias "ImmEnumRegisterWordW" (byval as HKL, byval as REGISTERWORDENUMPROCW, byval as LPCWSTR, byval as DWORD, byval as LPCWSTR, byval as PVOID) as UINT
declare function ImmGetImeMenuItems alias "ImmGetImeMenuItemsW" (byval as HIMC, byval as DWORD, byval as DWORD, byval as LPIMEMENUITEMINFOW, byval as LPIMEMENUITEMINFOW, byval as DWORD) as DWORD

#else ''UNICODE
declare function ImmInstallIME alias "ImmInstallIMEA" (byval as LPCSTR, byval as LPCSTR) as HKL
declare function ImmGetDescription alias "ImmGetDescriptionA" (byval as HKL, byval as LPSTR, byval as UINT) as UINT
declare function ImmGetIMEFileName alias "ImmGetIMEFileNameA" (byval as HKL, byval as LPSTR, byval as UINT) as UINT
declare function ImmGetCompositionString alias "ImmGetCompositionStringA" (byval as HIMC, byval as DWORD, byval as PVOID, byval as DWORD) as LONG
declare function ImmSetCompositionString alias "ImmSetCompositionStringA" (byval as HIMC, byval as DWORD, byval as PCVOID, byval as DWORD, byval as PCVOID, byval as DWORD) as BOOL
declare function ImmGetCandidateListCount alias "ImmGetCandidateListCountA" (byval as HIMC, byval as PDWORD) as DWORD
declare function ImmGetCandidateList alias "ImmGetCandidateListA" (byval as HIMC, byval as DWORD, byval as PCANDIDATELIST, byval as DWORD) as DWORD
declare function ImmGetGuideLine alias "ImmGetGuideLineA" (byval as HIMC, byval as DWORD, byval as LPSTR, byval as DWORD) as DWORD
declare function ImmGetCompositionFont alias "ImmGetCompositionFontA" (byval as HIMC, byval as LPLOGFONTA) as BOOL
declare function ImmSetCompositionFont alias "ImmSetCompositionFontA" (byval as HIMC, byval as LPLOGFONTA) as BOOL
declare function ImmConfigureIME alias "ImmConfigureIMEA" (byval as HKL, byval as HWND, byval as DWORD, byval as PVOID) as BOOL
declare function ImmEscape alias "ImmEscapeA" (byval as HKL, byval as HIMC, byval as UINT, byval as PVOID) as LRESULT
declare function ImmGetConversionList alias "ImmGetConversionListA" (byval as HKL, byval as HIMC, byval as LPCSTR, byval as PCANDIDATELIST, byval as DWORD, byval as UINT) as DWORD
declare function ImmIsUIMessage alias "ImmIsUIMessageA" (byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as BOOL
declare function ImmRegisterWord alias "ImmRegisterWordA" (byval as HKL, byval as LPCSTR, byval as DWORD, byval as LPCSTR) as BOOL
declare function ImmUnregisterWord alias "ImmUnregisterWordA" (byval as HKL, byval as LPCSTR, byval as DWORD, byval as LPCSTR) as BOOL
declare function ImmGetRegisterWordStyle alias "ImmGetRegisterWordStyleA" (byval as HKL, byval as UINT, byval as PSTYLEBUFA) as UINT
declare function ImmEnumRegisterWord alias "ImmEnumRegisterWordA" (byval as HKL, byval as REGISTERWORDENUMPROCA, byval as LPCSTR, byval as DWORD, byval as LPCSTR, byval as PVOID) as UINT
declare function ImmGetImeMenuItems alias "ImmGetImeMenuItemsA" (byval as HIMC, byval as DWORD, byval as DWORD, byval as LPIMEMENUITEMINFOA, byval as LPIMEMENUITEMINFOA, byval as DWORD) as DWORD

#endif ''UNICODE

#endif
