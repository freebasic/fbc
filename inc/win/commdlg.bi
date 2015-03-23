#pragma once

#inclib "comdlg32"

#include once "_mingw_unicode.bi"
#include once "prsht.bi"

extern "Windows"

#define _INC_COMMDLG
extern IID_IPrintDialogCallback as const GUID
extern IID_IPrintDialogServices as const GUID
type LPOFNHOOKPROC as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as UINT_PTR
#define CDSIZEOF_STRUCT(structname, member) (clng(cast(LPBYTE, @cptr(structname ptr, 0)->member) - cast(LPBYTE, cptr(structname ptr, 0))) + sizeof(cptr(structname ptr, 0)->member))

#ifdef __FB_64BIT__
	type tagOFN_NT4A
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HINSTANCE
		lpstrFilter as LPCSTR
		lpstrCustomFilter as LPSTR
		nMaxCustFilter as DWORD
		nFilterIndex as DWORD
		lpstrFile as LPSTR
		nMaxFile as DWORD
		lpstrFileTitle as LPSTR
		nMaxFileTitle as DWORD
		lpstrInitialDir as LPCSTR
		lpstrTitle as LPCSTR
		Flags as DWORD
		nFileOffset as WORD
		nFileExtension as WORD
		lpstrDefExt as LPCSTR
		lCustData as LPARAM
		lpfnHook as LPOFNHOOKPROC
		lpTemplateName as LPCSTR
	end type
#else
	type tagOFN_NT4A field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HINSTANCE
		lpstrFilter as LPCSTR
		lpstrCustomFilter as LPSTR
		nMaxCustFilter as DWORD
		nFilterIndex as DWORD
		lpstrFile as LPSTR
		nMaxFile as DWORD
		lpstrFileTitle as LPSTR
		nMaxFileTitle as DWORD
		lpstrInitialDir as LPCSTR
		lpstrTitle as LPCSTR
		Flags as DWORD
		nFileOffset as WORD
		nFileExtension as WORD
		lpstrDefExt as LPCSTR
		lCustData as LPARAM
		lpfnHook as LPOFNHOOKPROC
		lpTemplateName as LPCSTR
	end type
#endif

type OPENFILENAME_NT4A as tagOFN_NT4A
type LPOPENFILENAME_NT4A as tagOFN_NT4A ptr

#ifdef __FB_64BIT__
	type tagOFN_NT4W
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HINSTANCE
		lpstrFilter as LPCWSTR
		lpstrCustomFilter as LPWSTR
		nMaxCustFilter as DWORD
		nFilterIndex as DWORD
		lpstrFile as LPWSTR
		nMaxFile as DWORD
		lpstrFileTitle as LPWSTR
		nMaxFileTitle as DWORD
		lpstrInitialDir as LPCWSTR
		lpstrTitle as LPCWSTR
		Flags as DWORD
		nFileOffset as WORD
		nFileExtension as WORD
		lpstrDefExt as LPCWSTR
		lCustData as LPARAM
		lpfnHook as LPOFNHOOKPROC
		lpTemplateName as LPCWSTR
	end type
#else
	type tagOFN_NT4W field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HINSTANCE
		lpstrFilter as LPCWSTR
		lpstrCustomFilter as LPWSTR
		nMaxCustFilter as DWORD
		nFilterIndex as DWORD
		lpstrFile as LPWSTR
		nMaxFile as DWORD
		lpstrFileTitle as LPWSTR
		nMaxFileTitle as DWORD
		lpstrInitialDir as LPCWSTR
		lpstrTitle as LPCWSTR
		Flags as DWORD
		nFileOffset as WORD
		nFileExtension as WORD
		lpstrDefExt as LPCWSTR
		lCustData as LPARAM
		lpfnHook as LPOFNHOOKPROC
		lpTemplateName as LPCWSTR
	end type
#endif

type OPENFILENAME_NT4W as tagOFN_NT4W
type LPOPENFILENAME_NT4W as tagOFN_NT4W ptr

#ifdef UNICODE
	type OPENFILENAME_NT4 as OPENFILENAME_NT4W
	type LPOPENFILENAME_NT4 as LPOPENFILENAME_NT4W
#else
	type OPENFILENAME_NT4 as OPENFILENAME_NT4A
	type LPOPENFILENAME_NT4 as LPOPENFILENAME_NT4A
#endif

#ifdef __FB_64BIT__
	type tagOFNA
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HINSTANCE
		lpstrFilter as LPCSTR
		lpstrCustomFilter as LPSTR
		nMaxCustFilter as DWORD
		nFilterIndex as DWORD
		lpstrFile as LPSTR
		nMaxFile as DWORD
		lpstrFileTitle as LPSTR
		nMaxFileTitle as DWORD
		lpstrInitialDir as LPCSTR
		lpstrTitle as LPCSTR
		Flags as DWORD
		nFileOffset as WORD
		nFileExtension as WORD
		lpstrDefExt as LPCSTR
		lCustData as LPARAM
		lpfnHook as LPOFNHOOKPROC
		lpTemplateName as LPCSTR
		pvReserved as any ptr
		dwReserved as DWORD
		FlagsEx as DWORD
	end type
#else
	type tagOFNA field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HINSTANCE
		lpstrFilter as LPCSTR
		lpstrCustomFilter as LPSTR
		nMaxCustFilter as DWORD
		nFilterIndex as DWORD
		lpstrFile as LPSTR
		nMaxFile as DWORD
		lpstrFileTitle as LPSTR
		nMaxFileTitle as DWORD
		lpstrInitialDir as LPCSTR
		lpstrTitle as LPCSTR
		Flags as DWORD
		nFileOffset as WORD
		nFileExtension as WORD
		lpstrDefExt as LPCSTR
		lCustData as LPARAM
		lpfnHook as LPOFNHOOKPROC
		lpTemplateName as LPCSTR
		pvReserved as any ptr
		dwReserved as DWORD
		FlagsEx as DWORD
	end type
#endif

type OPENFILENAMEA as tagOFNA
type LPOPENFILENAMEA as tagOFNA ptr

#ifdef __FB_64BIT__
	type tagOFNW
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HINSTANCE
		lpstrFilter as LPCWSTR
		lpstrCustomFilter as LPWSTR
		nMaxCustFilter as DWORD
		nFilterIndex as DWORD
		lpstrFile as LPWSTR
		nMaxFile as DWORD
		lpstrFileTitle as LPWSTR
		nMaxFileTitle as DWORD
		lpstrInitialDir as LPCWSTR
		lpstrTitle as LPCWSTR
		Flags as DWORD
		nFileOffset as WORD
		nFileExtension as WORD
		lpstrDefExt as LPCWSTR
		lCustData as LPARAM
		lpfnHook as LPOFNHOOKPROC
		lpTemplateName as LPCWSTR
		pvReserved as any ptr
		dwReserved as DWORD
		FlagsEx as DWORD
	end type
#else
	type tagOFNW field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HINSTANCE
		lpstrFilter as LPCWSTR
		lpstrCustomFilter as LPWSTR
		nMaxCustFilter as DWORD
		nFilterIndex as DWORD
		lpstrFile as LPWSTR
		nMaxFile as DWORD
		lpstrFileTitle as LPWSTR
		nMaxFileTitle as DWORD
		lpstrInitialDir as LPCWSTR
		lpstrTitle as LPCWSTR
		Flags as DWORD
		nFileOffset as WORD
		nFileExtension as WORD
		lpstrDefExt as LPCWSTR
		lCustData as LPARAM
		lpfnHook as LPOFNHOOKPROC
		lpTemplateName as LPCWSTR
		pvReserved as any ptr
		dwReserved as DWORD
		FlagsEx as DWORD
	end type
#endif

type OPENFILENAMEW as tagOFNW
type LPOPENFILENAMEW as tagOFNW ptr

#ifdef UNICODE
	type OPENFILENAME as OPENFILENAMEW
	type LPOPENFILENAME as LPOPENFILENAMEW
#else
	type OPENFILENAME as OPENFILENAMEA
	type LPOPENFILENAME as LPOPENFILENAMEA
#endif

#define OPENFILENAME_SIZE_VERSION_400A CDSIZEOF_STRUCT(OPENFILENAMEA, lpTemplateName)
#define OPENFILENAME_SIZE_VERSION_400W CDSIZEOF_STRUCT(OPENFILENAMEW, lpTemplateName)

#ifdef UNICODE
	#define OPENFILENAME_SIZE_VERSION_400 OPENFILENAME_SIZE_VERSION_400W
#else
	#define OPENFILENAME_SIZE_VERSION_400 OPENFILENAME_SIZE_VERSION_400A
#endif

declare function GetOpenFileNameA(byval as LPOPENFILENAMEA) as WINBOOL
declare function GetOpenFileNameW(byval as LPOPENFILENAMEW) as WINBOOL

#ifdef UNICODE
	#define GetOpenFileName GetOpenFileNameW
#else
	#define GetOpenFileName GetOpenFileNameA
#endif

declare function GetSaveFileNameA(byval as LPOPENFILENAMEA) as WINBOOL
declare function GetSaveFileNameW(byval as LPOPENFILENAMEW) as WINBOOL

#ifdef UNICODE
	#define GetSaveFileName GetSaveFileNameW
#else
	#define GetSaveFileName GetSaveFileNameA
#endif

declare function GetFileTitleA(byval as LPCSTR, byval as LPSTR, byval as WORD) as short
declare function GetFileTitleW(byval as LPCWSTR, byval as LPWSTR, byval as WORD) as short

#ifdef UNICODE
	#define GetFileTitle GetFileTitleW
#else
	#define GetFileTitle GetFileTitleA
#endif

#define OFN_READONLY &h1
#define OFN_OVERWRITEPROMPT &h2
#define OFN_HIDEREADONLY &h4
#define OFN_NOCHANGEDIR &h8
#define OFN_SHOWHELP &h10
#define OFN_ENABLEHOOK &h20
#define OFN_ENABLETEMPLATE &h40
#define OFN_ENABLETEMPLATEHANDLE &h80
#define OFN_NOVALIDATE &h100
#define OFN_ALLOWMULTISELECT &h200
#define OFN_EXTENSIONDIFFERENT &h400
#define OFN_PATHMUSTEXIST &h800
#define OFN_FILEMUSTEXIST &h1000
#define OFN_CREATEPROMPT &h2000
#define OFN_SHAREAWARE &h4000
#define OFN_NOREADONLYRETURN &h8000
#define OFN_NOTESTFILECREATE &h10000
#define OFN_NONETWORKBUTTON &h20000
#define OFN_NOLONGNAMES &h40000
#define OFN_EXPLORER &h80000
#define OFN_NODEREFERENCELINKS &h100000
#define OFN_LONGNAMES &h200000
#define OFN_ENABLEINCLUDENOTIFY &h400000
#define OFN_ENABLESIZING &h800000
#define OFN_DONTADDTORECENT &h2000000
#define OFN_FORCESHOWHIDDEN &h10000000
#define OFN_EX_NOPLACESBAR &h1
#define OFN_SHAREFALLTHROUGH 2
#define OFN_SHARENOWARN 1
#define OFN_SHAREWARN 0
type LPCCHOOKPROC as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as UINT_PTR

#ifdef __FB_64BIT__
	type _OFNOTIFYA
		hdr as NMHDR
		lpOFN as LPOPENFILENAMEA
		pszFile as LPSTR
	end type
#else
	type _OFNOTIFYA field = 1
		hdr as NMHDR
		lpOFN as LPOPENFILENAMEA
		pszFile as LPSTR
	end type
#endif

type OFNOTIFYA as _OFNOTIFYA
type LPOFNOTIFYA as _OFNOTIFYA ptr

#ifdef __FB_64BIT__
	type _OFNOTIFYW
		hdr as NMHDR
		lpOFN as LPOPENFILENAMEW
		pszFile as LPWSTR
	end type
#else
	type _OFNOTIFYW field = 1
		hdr as NMHDR
		lpOFN as LPOPENFILENAMEW
		pszFile as LPWSTR
	end type
#endif

type OFNOTIFYW as _OFNOTIFYW
type LPOFNOTIFYW as _OFNOTIFYW ptr

#ifdef UNICODE
	type OFNOTIFY as OFNOTIFYW
	type LPOFNOTIFY as LPOFNOTIFYW
#else
	type OFNOTIFY as OFNOTIFYA
	type LPOFNOTIFY as LPOFNOTIFYA
#endif

#ifdef __FB_64BIT__
	type _OFNOTIFYEXA
		hdr as NMHDR
		lpOFN as LPOPENFILENAMEA
		psf as LPVOID
		pidl as LPVOID
	end type
#else
	type _OFNOTIFYEXA field = 1
		hdr as NMHDR
		lpOFN as LPOPENFILENAMEA
		psf as LPVOID
		pidl as LPVOID
	end type
#endif

type OFNOTIFYEXA as _OFNOTIFYEXA
type LPOFNOTIFYEXA as _OFNOTIFYEXA ptr

#ifdef __FB_64BIT__
	type _OFNOTIFYEXW
		hdr as NMHDR
		lpOFN as LPOPENFILENAMEW
		psf as LPVOID
		pidl as LPVOID
	end type
#else
	type _OFNOTIFYEXW field = 1
		hdr as NMHDR
		lpOFN as LPOPENFILENAMEW
		psf as LPVOID
		pidl as LPVOID
	end type
#endif

type OFNOTIFYEXW as _OFNOTIFYEXW
type LPOFNOTIFYEXW as _OFNOTIFYEXW ptr

#ifdef UNICODE
	type OFNOTIFYEX as OFNOTIFYEXW
	type LPOFNOTIFYEX as LPOFNOTIFYEXW
#else
	type OFNOTIFYEX as OFNOTIFYEXA
	type LPOFNOTIFYEX as LPOFNOTIFYEXA
#endif

#define CDN_FIRST culng(0u - 601u)
#define CDN_LAST culng(0u - 699u)
#define CDN_INITDONE CDN_FIRST
#define CDN_SELCHANGE culng(CDN_FIRST - 1)
#define CDN_FOLDERCHANGE culng(CDN_FIRST - 2)
#define CDN_SHAREVIOLATION culng(CDN_FIRST - 3)
#define CDN_HELP culng(CDN_FIRST - 4)
#define CDN_FILEOK culng(CDN_FIRST - 5)
#define CDN_TYPECHANGE culng(CDN_FIRST - 6)
#define CDN_INCLUDEITEM culng(CDN_FIRST - 7)
#define CDM_FIRST (WM_USER + 100)
#define CDM_LAST (WM_USER + 200)
#define CDM_GETSPEC CDM_FIRST
#define CommDlg_OpenSave_GetSpecA(_hdlg, _psz, _cbmax) clng(SNDMSG(_hdlg, CDM_GETSPEC, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPSTR, _psz))))
#define CommDlg_OpenSave_GetSpecW(_hdlg, _psz, _cbmax) clng(SNDMSG(_hdlg, CDM_GETSPEC, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPWSTR, _psz))))

#ifdef UNICODE
	#define CommDlg_OpenSave_GetSpec CommDlg_OpenSave_GetSpecW
#else
	#define CommDlg_OpenSave_GetSpec CommDlg_OpenSave_GetSpecA
#endif

#define CDM_GETFILEPATH (CDM_FIRST + 1)
#define CommDlg_OpenSave_GetFilePathA(_hdlg, _psz, _cbmax) clng(SNDMSG(_hdlg, CDM_GETFILEPATH, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPSTR, _psz))))
#define CommDlg_OpenSave_GetFilePathW(_hdlg, _psz, _cbmax) clng(SNDMSG(_hdlg, CDM_GETFILEPATH, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPWSTR, _psz))))

#ifdef UNICODE
	#define CommDlg_OpenSave_GetFilePath CommDlg_OpenSave_GetFilePathW
#else
	#define CommDlg_OpenSave_GetFilePath CommDlg_OpenSave_GetFilePathA
#endif

#define CDM_GETFOLDERPATH (CDM_FIRST + 2)
#define CommDlg_OpenSave_GetFolderPathA(_hdlg, _psz, _cbmax) clng(SNDMSG(_hdlg, CDM_GETFOLDERPATH, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPSTR, _psz))))
#define CommDlg_OpenSave_GetFolderPathW(_hdlg, _psz, _cbmax) clng(SNDMSG(_hdlg, CDM_GETFOLDERPATH, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPWSTR, _psz))))

#ifdef UNICODE
	#define CommDlg_OpenSave_GetFolderPath CommDlg_OpenSave_GetFolderPathW
#else
	#define CommDlg_OpenSave_GetFolderPath CommDlg_OpenSave_GetFolderPathA
#endif

#define CDM_GETFOLDERIDLIST (CDM_FIRST + 3)
#define CommDlg_OpenSave_GetFolderIDList(_hdlg, _pidl, _cbmax) clng(SNDMSG(_hdlg, CDM_GETFOLDERIDLIST, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPVOID, _pidl))))
#define CDM_SETCONTROLTEXT (CDM_FIRST + 4)
#define CommDlg_OpenSave_SetControlText(_hdlg, _id, _text) SNDMSG(_hdlg, CDM_SETCONTROLTEXT, cast(WPARAM, _id), cast(LPARAM, cast(LPSTR, _text)))
#define CDM_HIDECONTROL (CDM_FIRST + 5)
#define CommDlg_OpenSave_HideControl(_hdlg, _id) SNDMSG(_hdlg, CDM_HIDECONTROL, cast(WPARAM, _id), 0)
#define CDM_SETDEFEXT (CDM_FIRST + 6)
#define CommDlg_OpenSave_SetDefExt(_hdlg, _pszext) SNDMSG(_hdlg, CDM_SETDEFEXT, 0, cast(LPARAM, cast(LPSTR, _pszext)))

#ifdef __FB_64BIT__
	type tagCHOOSECOLORA
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HWND
		rgbResult as COLORREF
		lpCustColors as COLORREF ptr
		Flags as DWORD
		lCustData as LPARAM
		lpfnHook as LPCCHOOKPROC
		lpTemplateName as LPCSTR
	end type
#else
	type tagCHOOSECOLORA field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HWND
		rgbResult as COLORREF
		lpCustColors as COLORREF ptr
		Flags as DWORD
		lCustData as LPARAM
		lpfnHook as LPCCHOOKPROC
		lpTemplateName as LPCSTR
	end type
#endif

type CHOOSECOLORA as tagCHOOSECOLORA
type LPCHOOSECOLORA as tagCHOOSECOLORA ptr

#ifdef __FB_64BIT__
	type tagCHOOSECOLORW
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HWND
		rgbResult as COLORREF
		lpCustColors as COLORREF ptr
		Flags as DWORD
		lCustData as LPARAM
		lpfnHook as LPCCHOOKPROC
		lpTemplateName as LPCWSTR
	end type
#else
	type tagCHOOSECOLORW field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HWND
		rgbResult as COLORREF
		lpCustColors as COLORREF ptr
		Flags as DWORD
		lCustData as LPARAM
		lpfnHook as LPCCHOOKPROC
		lpTemplateName as LPCWSTR
	end type
#endif

type CHOOSECOLORW as tagCHOOSECOLORW
type LPCHOOSECOLORW as tagCHOOSECOLORW ptr

#ifdef UNICODE
	type CHOOSECOLOR as CHOOSECOLORW
	type LPCHOOSECOLOR as LPCHOOSECOLORW
#else
	type CHOOSECOLOR as CHOOSECOLORA
	type LPCHOOSECOLOR as LPCHOOSECOLORA
#endif

declare function ChooseColorA(byval as LPCHOOSECOLORA) as WINBOOL
declare function ChooseColorW(byval as LPCHOOSECOLORW) as WINBOOL

#ifdef UNICODE
	declare function ChooseColor alias "ChooseColorW"(byval as LPCHOOSECOLORW) as WINBOOL
#else
	declare function ChooseColor alias "ChooseColorA"(byval as LPCHOOSECOLORA) as WINBOOL
#endif

#define CC_RGBINIT &h1
#define CC_FULLOPEN &h2
#define CC_PREVENTFULLOPEN &h4
#define CC_SHOWHELP &h8
#define CC_ENABLEHOOK &h10
#define CC_ENABLETEMPLATE &h20
#define CC_ENABLETEMPLATEHANDLE &h40
#define CC_SOLIDCOLOR &h80
#define CC_ANYCOLOR &h100
type LPFRHOOKPROC as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as UINT_PTR

#ifdef __FB_64BIT__
	type tagFINDREPLACEA
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HINSTANCE
		Flags as DWORD
		lpstrFindWhat as LPSTR
		lpstrReplaceWith as LPSTR
		wFindWhatLen as WORD
		wReplaceWithLen as WORD
		lCustData as LPARAM
		lpfnHook as LPFRHOOKPROC
		lpTemplateName as LPCSTR
	end type
#else
	type tagFINDREPLACEA field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HINSTANCE
		Flags as DWORD
		lpstrFindWhat as LPSTR
		lpstrReplaceWith as LPSTR
		wFindWhatLen as WORD
		wReplaceWithLen as WORD
		lCustData as LPARAM
		lpfnHook as LPFRHOOKPROC
		lpTemplateName as LPCSTR
	end type
#endif

type FINDREPLACEA as tagFINDREPLACEA
type LPFINDREPLACEA as tagFINDREPLACEA ptr

#ifdef __FB_64BIT__
	type tagFINDREPLACEW
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HINSTANCE
		Flags as DWORD
		lpstrFindWhat as LPWSTR
		lpstrReplaceWith as LPWSTR
		wFindWhatLen as WORD
		wReplaceWithLen as WORD
		lCustData as LPARAM
		lpfnHook as LPFRHOOKPROC
		lpTemplateName as LPCWSTR
	end type
#else
	type tagFINDREPLACEW field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hInstance as HINSTANCE
		Flags as DWORD
		lpstrFindWhat as LPWSTR
		lpstrReplaceWith as LPWSTR
		wFindWhatLen as WORD
		wReplaceWithLen as WORD
		lCustData as LPARAM
		lpfnHook as LPFRHOOKPROC
		lpTemplateName as LPCWSTR
	end type
#endif

type FINDREPLACEW as tagFINDREPLACEW
type LPFINDREPLACEW as tagFINDREPLACEW ptr

#ifdef UNICODE
	type FINDREPLACE as FINDREPLACEW
	type LPFINDREPLACE as LPFINDREPLACEW
#else
	type FINDREPLACE as FINDREPLACEA
	type LPFINDREPLACE as LPFINDREPLACEA
#endif

#define FR_DOWN &h1
#define FR_WHOLEWORD &h2
#define FR_MATCHCASE &h4
#define FR_FINDNEXT &h8
#define FR_REPLACE &h10
#define FR_REPLACEALL &h20
#define FR_DIALOGTERM &h40
#define FR_SHOWHELP &h80
#define FR_ENABLEHOOK &h100
#define FR_ENABLETEMPLATE &h200
#define FR_NOUPDOWN &h400
#define FR_NOMATCHCASE &h800
#define FR_NOWHOLEWORD &h1000
#define FR_ENABLETEMPLATEHANDLE &h2000
#define FR_HIDEUPDOWN &h4000
#define FR_HIDEMATCHCASE &h8000
#define FR_HIDEWHOLEWORD &h10000
#define FR_RAW &h20000
declare function FindTextA(byval as LPFINDREPLACEA) as HWND
declare function FindTextW(byval as LPFINDREPLACEW) as HWND

#ifdef UNICODE
	declare function FindText alias "FindTextW"(byval as LPFINDREPLACEW) as HWND
#else
	declare function FindText alias "FindTextA"(byval as LPFINDREPLACEA) as HWND
#endif

declare function ReplaceTextA(byval as LPFINDREPLACEA) as HWND
declare function ReplaceTextW(byval as LPFINDREPLACEW) as HWND

#ifdef UNICODE
	#define ReplaceText ReplaceTextW
#else
	#define ReplaceText ReplaceTextA
#endif

type LPCFHOOKPROC as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as UINT_PTR

#ifdef __FB_64BIT__
	type tagCHOOSEFONTA
		lStructSize as DWORD
		hwndOwner as HWND
		hDC as HDC
		lpLogFont as LPLOGFONTA
		iPointSize as INT_
		Flags as DWORD
		rgbColors as COLORREF
		lCustData as LPARAM
		lpfnHook as LPCFHOOKPROC
		lpTemplateName as LPCSTR
		hInstance as HINSTANCE
		lpszStyle as LPSTR
		nFontType as WORD
		___MISSING_ALIGNMENT__ as WORD
		nSizeMin as INT_
		nSizeMax as INT_
	end type
#else
	type tagCHOOSEFONTA field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hDC as HDC
		lpLogFont as LPLOGFONTA
		iPointSize as INT_
		Flags as DWORD
		rgbColors as COLORREF
		lCustData as LPARAM
		lpfnHook as LPCFHOOKPROC
		lpTemplateName as LPCSTR
		hInstance as HINSTANCE
		lpszStyle as LPSTR
		nFontType as WORD
		___MISSING_ALIGNMENT__ as WORD
		nSizeMin as INT_
		nSizeMax as INT_
	end type
#endif

type CHOOSEFONTA as tagCHOOSEFONTA
type LPCHOOSEFONTA as tagCHOOSEFONTA ptr

#ifdef __FB_64BIT__
	type tagCHOOSEFONTW
		lStructSize as DWORD
		hwndOwner as HWND
		hDC as HDC
		lpLogFont as LPLOGFONTW
		iPointSize as INT_
		Flags as DWORD
		rgbColors as COLORREF
		lCustData as LPARAM
		lpfnHook as LPCFHOOKPROC
		lpTemplateName as LPCWSTR
		hInstance as HINSTANCE
		lpszStyle as LPWSTR
		nFontType as WORD
		___MISSING_ALIGNMENT__ as WORD
		nSizeMin as INT_
		nSizeMax as INT_
	end type
#else
	type tagCHOOSEFONTW field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hDC as HDC
		lpLogFont as LPLOGFONTW
		iPointSize as INT_
		Flags as DWORD
		rgbColors as COLORREF
		lCustData as LPARAM
		lpfnHook as LPCFHOOKPROC
		lpTemplateName as LPCWSTR
		hInstance as HINSTANCE
		lpszStyle as LPWSTR
		nFontType as WORD
		___MISSING_ALIGNMENT__ as WORD
		nSizeMin as INT_
		nSizeMax as INT_
	end type
#endif

type CHOOSEFONTW as tagCHOOSEFONTW
type LPCHOOSEFONTW as tagCHOOSEFONTW ptr

#ifdef UNICODE
	type CHOOSEFONT as CHOOSEFONTW
	type LPCHOOSEFONT as LPCHOOSEFONTW
#else
	type CHOOSEFONT as CHOOSEFONTA
	type LPCHOOSEFONT as LPCHOOSEFONTA
#endif

declare function ChooseFontA(byval as LPCHOOSEFONTA) as WINBOOL
declare function ChooseFontW(byval as LPCHOOSEFONTW) as WINBOOL

#ifdef UNICODE
	declare function ChooseFont alias "ChooseFontW"(byval as LPCHOOSEFONTW) as WINBOOL
#else
	declare function ChooseFont alias "ChooseFontA"(byval as LPCHOOSEFONTA) as WINBOOL
#endif

#define CF_SCREENFONTS &h1
#define CF_PRINTERFONTS &h2
#define CF_BOTH (CF_SCREENFONTS or CF_PRINTERFONTS)
#define CF_SHOWHELP __MSABI_LONG(&h4)
#define CF_ENABLEHOOK __MSABI_LONG(&h8)
#define CF_ENABLETEMPLATE __MSABI_LONG(&h10)
#define CF_ENABLETEMPLATEHANDLE __MSABI_LONG(&h20)
#define CF_INITTOLOGFONTSTRUCT __MSABI_LONG(&h40)
#define CF_USESTYLE __MSABI_LONG(&h80)
#define CF_EFFECTS __MSABI_LONG(&h100)
#define CF_APPLY __MSABI_LONG(&h200)
#define CF_ANSIONLY __MSABI_LONG(&h400)
#define CF_SCRIPTSONLY CF_ANSIONLY
#define CF_NOVECTORFONTS __MSABI_LONG(&h800)
#define CF_NOOEMFONTS CF_NOVECTORFONTS
#define CF_NOSIMULATIONS __MSABI_LONG(&h1000)
#define CF_LIMITSIZE __MSABI_LONG(&h2000)
#define CF_FIXEDPITCHONLY __MSABI_LONG(&h4000)
#define CF_WYSIWYG __MSABI_LONG(&h8000)
#define CF_FORCEFONTEXIST __MSABI_LONG(&h10000)
#define CF_SCALABLEONLY __MSABI_LONG(&h20000)
#define CF_TTONLY __MSABI_LONG(&h40000)
#define CF_NOFACESEL __MSABI_LONG(&h80000)
#define CF_NOSTYLESEL __MSABI_LONG(&h100000)
#define CF_NOSIZESEL __MSABI_LONG(&h200000)
#define CF_SELECTSCRIPT __MSABI_LONG(&h400000)
#define CF_NOSCRIPTSEL __MSABI_LONG(&h800000)
#define CF_NOVERTFONTS __MSABI_LONG(&h1000000)
#define SIMULATED_FONTTYPE &h8000
#define PRINTER_FONTTYPE &h4000
#define SCREEN_FONTTYPE &h2000
#define BOLD_FONTTYPE &h100
#define ITALIC_FONTTYPE &h200
#define REGULAR_FONTTYPE &h400
#define PS_OPENTYPE_FONTTYPE &h10000
#define TT_OPENTYPE_FONTTYPE &h20000
#define TYPE1_FONTTYPE &h40000
#define WM_CHOOSEFONT_GETLOGFONT (WM_USER + 1)
#define WM_CHOOSEFONT_SETLOGFONT (WM_USER + 101)
#define WM_CHOOSEFONT_SETFLAGS (WM_USER + 102)
#define LBSELCHSTRINGA "commdlg_LBSelChangedNotify"
#define SHAREVISTRINGA "commdlg_ShareViolation"
#define FILEOKSTRINGA "commdlg_FileNameOK"
#define COLOROKSTRINGA "commdlg_ColorOK"
#define SETRGBSTRINGA "commdlg_SetRGBColor"
#define HELPMSGSTRINGA "commdlg_help"
#define FINDMSGSTRINGA "commdlg_FindReplace"
#define LBSELCHSTRINGW wstr("commdlg_LBSelChangedNotify")
#define SHAREVISTRINGW wstr("commdlg_ShareViolation")
#define FILEOKSTRINGW wstr("commdlg_FileNameOK")
#define COLOROKSTRINGW wstr("commdlg_ColorOK")
#define SETRGBSTRINGW wstr("commdlg_SetRGBColor")
#define HELPMSGSTRINGW wstr("commdlg_help")
#define FINDMSGSTRINGW wstr("commdlg_FindReplace")

#ifdef UNICODE
	#define LBSELCHSTRING LBSELCHSTRINGW
	#define SHAREVISTRING SHAREVISTRINGW
	#define FILEOKSTRING FILEOKSTRINGW
	#define COLOROKSTRING COLOROKSTRINGW
	#define SETRGBSTRING SETRGBSTRINGW
	#define HELPMSGSTRING HELPMSGSTRINGW
	#define FINDMSGSTRING FINDMSGSTRINGW
#else
	#define LBSELCHSTRING LBSELCHSTRINGA
	#define SHAREVISTRING SHAREVISTRINGA
	#define FILEOKSTRING FILEOKSTRINGA
	#define COLOROKSTRING COLOROKSTRINGA
	#define SETRGBSTRING SETRGBSTRINGA
	#define HELPMSGSTRING HELPMSGSTRINGA
	#define FINDMSGSTRING FINDMSGSTRINGA
#endif

#define CD_LBSELNOITEMS (-1)
#define CD_LBSELCHANGE 0
#define CD_LBSELSUB 1
#define CD_LBSELADD 2
type LPPRINTHOOKPROC as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as UINT_PTR
type LPSETUPHOOKPROC as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as UINT_PTR

#ifdef __FB_64BIT__
	type tagPDA
		lStructSize as DWORD
		hwndOwner as HWND
		hDevMode as HGLOBAL
		hDevNames as HGLOBAL
		hDC as HDC
		Flags as DWORD
		nFromPage as WORD
		nToPage as WORD
		nMinPage as WORD
		nMaxPage as WORD
		nCopies as WORD
		hInstance as HINSTANCE
		lCustData as LPARAM
		lpfnPrintHook as LPPRINTHOOKPROC
		lpfnSetupHook as LPSETUPHOOKPROC
		lpPrintTemplateName as LPCSTR
		lpSetupTemplateName as LPCSTR
		hPrintTemplate as HGLOBAL
		hSetupTemplate as HGLOBAL
	end type
#else
	type tagPDA field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hDevMode as HGLOBAL
		hDevNames as HGLOBAL
		hDC as HDC
		Flags as DWORD
		nFromPage as WORD
		nToPage as WORD
		nMinPage as WORD
		nMaxPage as WORD
		nCopies as WORD
		hInstance as HINSTANCE
		lCustData as LPARAM
		lpfnPrintHook as LPPRINTHOOKPROC
		lpfnSetupHook as LPSETUPHOOKPROC
		lpPrintTemplateName as LPCSTR
		lpSetupTemplateName as LPCSTR
		hPrintTemplate as HGLOBAL
		hSetupTemplate as HGLOBAL
	end type
#endif

type PRINTDLGA as tagPDA
type LPPRINTDLGA as tagPDA ptr

#ifdef __FB_64BIT__
	type tagPDW
		lStructSize as DWORD
		hwndOwner as HWND
		hDevMode as HGLOBAL
		hDevNames as HGLOBAL
		hDC as HDC
		Flags as DWORD
		nFromPage as WORD
		nToPage as WORD
		nMinPage as WORD
		nMaxPage as WORD
		nCopies as WORD
		hInstance as HINSTANCE
		lCustData as LPARAM
		lpfnPrintHook as LPPRINTHOOKPROC
		lpfnSetupHook as LPSETUPHOOKPROC
		lpPrintTemplateName as LPCWSTR
		lpSetupTemplateName as LPCWSTR
		hPrintTemplate as HGLOBAL
		hSetupTemplate as HGLOBAL
	end type
#else
	type tagPDW field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hDevMode as HGLOBAL
		hDevNames as HGLOBAL
		hDC as HDC
		Flags as DWORD
		nFromPage as WORD
		nToPage as WORD
		nMinPage as WORD
		nMaxPage as WORD
		nCopies as WORD
		hInstance as HINSTANCE
		lCustData as LPARAM
		lpfnPrintHook as LPPRINTHOOKPROC
		lpfnSetupHook as LPSETUPHOOKPROC
		lpPrintTemplateName as LPCWSTR
		lpSetupTemplateName as LPCWSTR
		hPrintTemplate as HGLOBAL
		hSetupTemplate as HGLOBAL
	end type
#endif

type PRINTDLGW as tagPDW
type LPPRINTDLGW as tagPDW ptr

#ifdef UNICODE
	type PRINTDLG as PRINTDLGW
	type LPPRINTDLG as LPPRINTDLGW
#else
	type PRINTDLG as PRINTDLGA
	type LPPRINTDLG as LPPRINTDLGA
#endif

declare function PrintDlgA(byval as LPPRINTDLGA) as WINBOOL
declare function PrintDlgW(byval as LPPRINTDLGW) as WINBOOL

#ifdef UNICODE
	declare function PrintDlg alias "PrintDlgW"(byval as LPPRINTDLGW) as WINBOOL
#else
	declare function PrintDlg alias "PrintDlgA"(byval as LPPRINTDLGA) as WINBOOL
#endif

type IPrintDialogCallbackVtbl as IPrintDialogCallbackVtbl_

#ifdef __FB_64BIT__
	type IPrintDialogCallback
		lpVtbl as IPrintDialogCallbackVtbl ptr
	end type

	type IPrintDialogCallbackVtbl_
		QueryInterface as function(byval This as IPrintDialogCallback ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
		AddRef as function(byval This as IPrintDialogCallback ptr) as ULONG
		Release as function(byval This as IPrintDialogCallback ptr) as ULONG
		InitDone as function(byval This as IPrintDialogCallback ptr) as HRESULT
		SelectionChange as function(byval This as IPrintDialogCallback ptr) as HRESULT
		HandleMessage as function(byval This as IPrintDialogCallback ptr, byval hDlg as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval pResult as LRESULT ptr) as HRESULT
	end type
#else
	type IPrintDialogCallback field = 1
		lpVtbl as IPrintDialogCallbackVtbl ptr
	end type

	type IPrintDialogCallbackVtbl_ field = 1
		QueryInterface as function(byval This as IPrintDialogCallback ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
		AddRef as function(byval This as IPrintDialogCallback ptr) as ULONG
		Release as function(byval This as IPrintDialogCallback ptr) as ULONG
		InitDone as function(byval This as IPrintDialogCallback ptr) as HRESULT
		SelectionChange as function(byval This as IPrintDialogCallback ptr) as HRESULT
		HandleMessage as function(byval This as IPrintDialogCallback ptr, byval hDlg as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval pResult as LRESULT ptr) as HRESULT
	end type
#endif

type IPrintDialogServicesVtbl as IPrintDialogServicesVtbl_

#ifdef __FB_64BIT__
	type IPrintDialogServices
		lpVtbl as IPrintDialogServicesVtbl ptr
	end type

	type IPrintDialogServicesVtbl_
		QueryInterface as function(byval This as IPrintDialogServices ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
		AddRef as function(byval This as IPrintDialogServices ptr) as ULONG
		Release as function(byval This as IPrintDialogServices ptr) as ULONG
		GetCurrentDevMode as function(byval This as IPrintDialogServices ptr, byval pDevMode as LPDEVMODE, byval pcbSize as UINT ptr) as HRESULT
		GetCurrentPrinterName as function(byval This as IPrintDialogServices ptr, byval pPrinterName as LPTSTR, byval pcchSize as UINT ptr) as HRESULT
		GetCurrentPortName as function(byval This as IPrintDialogServices ptr, byval pPortName as LPTSTR, byval pcchSize as UINT ptr) as HRESULT
	end type

	type tagPRINTPAGERANGE
		nFromPage as DWORD
		nToPage as DWORD
	end type
#else
	type IPrintDialogServices field = 1
		lpVtbl as IPrintDialogServicesVtbl ptr
	end type

	type IPrintDialogServicesVtbl_ field = 1
		QueryInterface as function(byval This as IPrintDialogServices ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
		AddRef as function(byval This as IPrintDialogServices ptr) as ULONG
		Release as function(byval This as IPrintDialogServices ptr) as ULONG
		GetCurrentDevMode as function(byval This as IPrintDialogServices ptr, byval pDevMode as LPDEVMODE, byval pcbSize as UINT ptr) as HRESULT
		GetCurrentPrinterName as function(byval This as IPrintDialogServices ptr, byval pPrinterName as LPTSTR, byval pcchSize as UINT ptr) as HRESULT
		GetCurrentPortName as function(byval This as IPrintDialogServices ptr, byval pPortName as LPTSTR, byval pcchSize as UINT ptr) as HRESULT
	end type

	type tagPRINTPAGERANGE field = 1
		nFromPage as DWORD
		nToPage as DWORD
	end type
#endif

type PRINTPAGERANGE as tagPRINTPAGERANGE
type LPPRINTPAGERANGE as tagPRINTPAGERANGE ptr

#ifdef __FB_64BIT__
	type tagPDEXA
		lStructSize as DWORD
		hwndOwner as HWND
		hDevMode as HGLOBAL
		hDevNames as HGLOBAL
		hDC as HDC
		Flags as DWORD
		Flags2 as DWORD
		ExclusionFlags as DWORD
		nPageRanges as DWORD
		nMaxPageRanges as DWORD
		lpPageRanges as LPPRINTPAGERANGE
		nMinPage as DWORD
		nMaxPage as DWORD
		nCopies as DWORD
		hInstance as HINSTANCE
		lpPrintTemplateName as LPCSTR
		lpCallback as LPUNKNOWN
		nPropertyPages as DWORD
		lphPropertyPages as HPROPSHEETPAGE ptr
		nStartPage as DWORD
		dwResultAction as DWORD
	end type
#else
	type tagPDEXA field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hDevMode as HGLOBAL
		hDevNames as HGLOBAL
		hDC as HDC
		Flags as DWORD
		Flags2 as DWORD
		ExclusionFlags as DWORD
		nPageRanges as DWORD
		nMaxPageRanges as DWORD
		lpPageRanges as LPPRINTPAGERANGE
		nMinPage as DWORD
		nMaxPage as DWORD
		nCopies as DWORD
		hInstance as HINSTANCE
		lpPrintTemplateName as LPCSTR
		lpCallback as LPUNKNOWN
		nPropertyPages as DWORD
		lphPropertyPages as HPROPSHEETPAGE ptr
		nStartPage as DWORD
		dwResultAction as DWORD
	end type
#endif

type PRINTDLGEXA as tagPDEXA
type LPPRINTDLGEXA as tagPDEXA ptr

#ifdef __FB_64BIT__
	type tagPDEXW
		lStructSize as DWORD
		hwndOwner as HWND
		hDevMode as HGLOBAL
		hDevNames as HGLOBAL
		hDC as HDC
		Flags as DWORD
		Flags2 as DWORD
		ExclusionFlags as DWORD
		nPageRanges as DWORD
		nMaxPageRanges as DWORD
		lpPageRanges as LPPRINTPAGERANGE
		nMinPage as DWORD
		nMaxPage as DWORD
		nCopies as DWORD
		hInstance as HINSTANCE
		lpPrintTemplateName as LPCWSTR
		lpCallback as LPUNKNOWN
		nPropertyPages as DWORD
		lphPropertyPages as HPROPSHEETPAGE ptr
		nStartPage as DWORD
		dwResultAction as DWORD
	end type
#else
	type tagPDEXW field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hDevMode as HGLOBAL
		hDevNames as HGLOBAL
		hDC as HDC
		Flags as DWORD
		Flags2 as DWORD
		ExclusionFlags as DWORD
		nPageRanges as DWORD
		nMaxPageRanges as DWORD
		lpPageRanges as LPPRINTPAGERANGE
		nMinPage as DWORD
		nMaxPage as DWORD
		nCopies as DWORD
		hInstance as HINSTANCE
		lpPrintTemplateName as LPCWSTR
		lpCallback as LPUNKNOWN
		nPropertyPages as DWORD
		lphPropertyPages as HPROPSHEETPAGE ptr
		nStartPage as DWORD
		dwResultAction as DWORD
	end type
#endif

type PRINTDLGEXW as tagPDEXW
type LPPRINTDLGEXW as tagPDEXW ptr

#ifdef UNICODE
	type PRINTDLGEX as PRINTDLGEXW
	type LPPRINTDLGEX as LPPRINTDLGEXW
#else
	type PRINTDLGEX as PRINTDLGEXA
	type LPPRINTDLGEX as LPPRINTDLGEXA
#endif

declare function PrintDlgExA(byval as LPPRINTDLGEXA) as HRESULT
declare function PrintDlgExW(byval as LPPRINTDLGEXW) as HRESULT

#ifdef UNICODE
	declare function PrintDlgEx alias "PrintDlgExW"(byval as LPPRINTDLGEXW) as HRESULT
#else
	declare function PrintDlgEx alias "PrintDlgExA"(byval as LPPRINTDLGEXA) as HRESULT
#endif

#define PD_ALLPAGES &h0
#define PD_SELECTION &h1
#define PD_PAGENUMS &h2
#define PD_NOSELECTION &h4
#define PD_NOPAGENUMS &h8
#define PD_COLLATE &h10
#define PD_PRINTTOFILE &h20
#define PD_PRINTSETUP &h40
#define PD_NOWARNING &h80
#define PD_RETURNDC &h100
#define PD_RETURNIC &h200
#define PD_RETURNDEFAULT &h400
#define PD_SHOWHELP &h800
#define PD_ENABLEPRINTHOOK &h1000
#define PD_ENABLESETUPHOOK &h2000
#define PD_ENABLEPRINTTEMPLATE &h4000
#define PD_ENABLESETUPTEMPLATE &h8000
#define PD_ENABLEPRINTTEMPLATEHANDLE &h10000
#define PD_ENABLESETUPTEMPLATEHANDLE &h20000
#define PD_USEDEVMODECOPIES &h40000
#define PD_USEDEVMODECOPIESANDCOLLATE &h40000
#define PD_DISABLEPRINTTOFILE &h80000
#define PD_HIDEPRINTTOFILE &h100000
#define PD_NONETWORKBUTTON &h200000
#define PD_CURRENTPAGE &h400000
#define PD_NOCURRENTPAGE &h800000
#define PD_EXCLUSIONFLAGS &h1000000
#define PD_USELARGETEMPLATE &h10000000
#define PD_EXCL_COPIESANDCOLLATE (DM_COPIES or DM_COLLATE)
#define START_PAGE_GENERAL &hffffffff
#define PD_RESULT_CANCEL 0
#define PD_RESULT_PRINT 1
#define PD_RESULT_APPLY 2

#ifdef __FB_64BIT__
	type tagDEVNAMES
		wDriverOffset as WORD
		wDeviceOffset as WORD
		wOutputOffset as WORD
		wDefault as WORD
	end type
#else
	type tagDEVNAMES field = 1
		wDriverOffset as WORD
		wDeviceOffset as WORD
		wOutputOffset as WORD
		wDefault as WORD
	end type
#endif

type DEVNAMES as tagDEVNAMES
type LPDEVNAMES as tagDEVNAMES ptr
#define DN_DEFAULTPRN &h1
declare function CommDlgExtendedError() as DWORD
#define WM_PSD_PAGESETUPDLG WM_USER
#define WM_PSD_FULLPAGERECT (WM_USER + 1)
#define WM_PSD_MINMARGINRECT (WM_USER + 2)
#define WM_PSD_MARGINRECT (WM_USER + 3)
#define WM_PSD_GREEKTEXTRECT (WM_USER + 4)
#define WM_PSD_ENVSTAMPRECT (WM_USER + 5)
#define WM_PSD_YAFULLPAGERECT (WM_USER + 6)
type LPPAGEPAINTHOOK as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as UINT_PTR
type LPPAGESETUPHOOK as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as UINT_PTR

#ifdef __FB_64BIT__
	type tagPSDA
		lStructSize as DWORD
		hwndOwner as HWND
		hDevMode as HGLOBAL
		hDevNames as HGLOBAL
		Flags as DWORD
		ptPaperSize as POINT
		rtMinMargin as RECT
		rtMargin as RECT
		hInstance as HINSTANCE
		lCustData as LPARAM
		lpfnPageSetupHook as LPPAGESETUPHOOK
		lpfnPagePaintHook as LPPAGEPAINTHOOK
		lpPageSetupTemplateName as LPCSTR
		hPageSetupTemplate as HGLOBAL
	end type
#else
	type tagPSDA field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hDevMode as HGLOBAL
		hDevNames as HGLOBAL
		Flags as DWORD
		ptPaperSize as POINT
		rtMinMargin as RECT
		rtMargin as RECT
		hInstance as HINSTANCE
		lCustData as LPARAM
		lpfnPageSetupHook as LPPAGESETUPHOOK
		lpfnPagePaintHook as LPPAGEPAINTHOOK
		lpPageSetupTemplateName as LPCSTR
		hPageSetupTemplate as HGLOBAL
	end type
#endif

type PAGESETUPDLGA as tagPSDA
type LPPAGESETUPDLGA as tagPSDA ptr

#ifdef __FB_64BIT__
	type tagPSDW
		lStructSize as DWORD
		hwndOwner as HWND
		hDevMode as HGLOBAL
		hDevNames as HGLOBAL
		Flags as DWORD
		ptPaperSize as POINT
		rtMinMargin as RECT
		rtMargin as RECT
		hInstance as HINSTANCE
		lCustData as LPARAM
		lpfnPageSetupHook as LPPAGESETUPHOOK
		lpfnPagePaintHook as LPPAGEPAINTHOOK
		lpPageSetupTemplateName as LPCWSTR
		hPageSetupTemplate as HGLOBAL
	end type
#else
	type tagPSDW field = 1
		lStructSize as DWORD
		hwndOwner as HWND
		hDevMode as HGLOBAL
		hDevNames as HGLOBAL
		Flags as DWORD
		ptPaperSize as POINT
		rtMinMargin as RECT
		rtMargin as RECT
		hInstance as HINSTANCE
		lCustData as LPARAM
		lpfnPageSetupHook as LPPAGESETUPHOOK
		lpfnPagePaintHook as LPPAGEPAINTHOOK
		lpPageSetupTemplateName as LPCWSTR
		hPageSetupTemplate as HGLOBAL
	end type
#endif

type PAGESETUPDLGW as tagPSDW
type LPPAGESETUPDLGW as tagPSDW ptr

#ifdef UNICODE
	type PAGESETUPDLG as PAGESETUPDLGW
	type LPPAGESETUPDLG as LPPAGESETUPDLGW
#else
	type PAGESETUPDLG as PAGESETUPDLGA
	type LPPAGESETUPDLG as LPPAGESETUPDLGA
#endif

declare function PageSetupDlgA(byval as LPPAGESETUPDLGA) as WINBOOL
declare function PageSetupDlgW(byval as LPPAGESETUPDLGW) as WINBOOL

#ifdef UNICODE
	declare function PageSetupDlg alias "PageSetupDlgW"(byval as LPPAGESETUPDLGW) as WINBOOL
#else
	declare function PageSetupDlg alias "PageSetupDlgA"(byval as LPPAGESETUPDLGA) as WINBOOL
#endif

#define PSD_DEFAULTMINMARGINS &h0
#define PSD_INWININIINTLMEASURE &h0
#define PSD_MINMARGINS &h1
#define PSD_MARGINS &h2
#define PSD_INTHOUSANDTHSOFINCHES &h4
#define PSD_INHUNDREDTHSOFMILLIMETERS &h8
#define PSD_DISABLEMARGINS &h10
#define PSD_DISABLEPRINTER &h20
#define PSD_NOWARNING &h80
#define PSD_DISABLEORIENTATION &h100
#define PSD_RETURNDEFAULT &h400
#define PSD_DISABLEPAPER &h200
#define PSD_SHOWHELP &h800
#define PSD_ENABLEPAGESETUPHOOK &h2000
#define PSD_ENABLEPAGESETUPTEMPLATE &h8000
#define PSD_ENABLEPAGESETUPTEMPLATEHANDLE &h20000
#define PSD_ENABLEPAGEPAINTHOOK &h40000
#define PSD_DISABLEPAGEPAINTING &h80000
#define PSD_NONETWORKBUTTON &h200000

end extern
