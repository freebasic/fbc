'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "comdlg32"

#include once "winapifamily.bi"
#include once "_mingw_unicode.bi"
#include once "prsht.bi"
#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "wtypesbase.bi"
#include once "unknwnbase.bi"
#include once "objidlbase.bi"

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
	declare function GetOpenFileName alias "GetOpenFileNameW"(byval as LPOPENFILENAMEW) as WINBOOL
#else
	declare function GetOpenFileName alias "GetOpenFileNameA"(byval as LPOPENFILENAMEA) as WINBOOL
#endif

declare function GetSaveFileNameA(byval as LPOPENFILENAMEA) as WINBOOL
declare function GetSaveFileNameW(byval as LPOPENFILENAMEW) as WINBOOL

#ifdef UNICODE
	declare function GetSaveFileName alias "GetSaveFileNameW"(byval as LPOPENFILENAMEW) as WINBOOL
#else
	declare function GetSaveFileName alias "GetSaveFileNameA"(byval as LPOPENFILENAMEA) as WINBOOL
#endif

declare function GetFileTitleA(byval as LPCSTR, byval as LPSTR, byval as WORD) as short
declare function GetFileTitleW(byval as LPCWSTR, byval as LPWSTR, byval as WORD) as short

#ifdef UNICODE
	declare function GetFileTitle alias "GetFileTitleW"(byval as LPCWSTR, byval as LPWSTR, byval as WORD) as short
#else
	declare function GetFileTitle alias "GetFileTitleA"(byval as LPCSTR, byval as LPSTR, byval as WORD) as short
#endif

const OFN_READONLY = &h1
const OFN_OVERWRITEPROMPT = &h2
const OFN_HIDEREADONLY = &h4
const OFN_NOCHANGEDIR = &h8
const OFN_SHOWHELP = &h10
const OFN_ENABLEHOOK = &h20
const OFN_ENABLETEMPLATE = &h40
const OFN_ENABLETEMPLATEHANDLE = &h80
const OFN_NOVALIDATE = &h100
const OFN_ALLOWMULTISELECT = &h200
const OFN_EXTENSIONDIFFERENT = &h400
const OFN_PATHMUSTEXIST = &h800
const OFN_FILEMUSTEXIST = &h1000
const OFN_CREATEPROMPT = &h2000
const OFN_SHAREAWARE = &h4000
const OFN_NOREADONLYRETURN = &h8000
const OFN_NOTESTFILECREATE = &h10000
const OFN_NONETWORKBUTTON = &h20000
const OFN_NOLONGNAMES = &h40000
const OFN_EXPLORER = &h80000
const OFN_NODEREFERENCELINKS = &h100000
const OFN_LONGNAMES = &h200000
const OFN_ENABLEINCLUDENOTIFY = &h400000
const OFN_ENABLESIZING = &h800000
const OFN_DONTADDTORECENT = &h2000000
const OFN_FORCESHOWHIDDEN = &h10000000
const OFN_EX_NOPLACESBAR = &h1
const OFN_SHAREFALLTHROUGH = 2
const OFN_SHARENOWARN = 1
const OFN_SHAREWARN = 0
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

const CDN_FIRST = culng(0u - 601u)
const CDN_LAST = culng(0u - 699u)
const CDN_INITDONE = CDN_FIRST
const CDN_SELCHANGE = culng(CDN_FIRST - 1)
const CDN_FOLDERCHANGE = culng(CDN_FIRST - 2)
const CDN_SHAREVIOLATION = culng(CDN_FIRST - 3)
const CDN_HELP = culng(CDN_FIRST - 4)
const CDN_FILEOK = culng(CDN_FIRST - 5)
const CDN_TYPECHANGE = culng(CDN_FIRST - 6)
const CDN_INCLUDEITEM = culng(CDN_FIRST - 7)
const CDM_FIRST = WM_USER + 100
const CDM_LAST = WM_USER + 200
const CDM_GETSPEC = CDM_FIRST
#define CommDlg_OpenSave_GetSpecA(_hdlg, _psz, _cbmax) clng(SNDMSG(_hdlg, CDM_GETSPEC, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPSTR, _psz))))
#define CommDlg_OpenSave_GetSpecW(_hdlg, _psz, _cbmax) clng(SNDMSG(_hdlg, CDM_GETSPEC, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPWSTR, _psz))))

#ifdef UNICODE
	#define CommDlg_OpenSave_GetSpec CommDlg_OpenSave_GetSpecW
#else
	#define CommDlg_OpenSave_GetSpec CommDlg_OpenSave_GetSpecA
#endif

const CDM_GETFILEPATH = CDM_FIRST + 1
#define CommDlg_OpenSave_GetFilePathA(_hdlg, _psz, _cbmax) clng(SNDMSG(_hdlg, CDM_GETFILEPATH, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPSTR, _psz))))
#define CommDlg_OpenSave_GetFilePathW(_hdlg, _psz, _cbmax) clng(SNDMSG(_hdlg, CDM_GETFILEPATH, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPWSTR, _psz))))

#ifdef UNICODE
	#define CommDlg_OpenSave_GetFilePath CommDlg_OpenSave_GetFilePathW
#else
	#define CommDlg_OpenSave_GetFilePath CommDlg_OpenSave_GetFilePathA
#endif

const CDM_GETFOLDERPATH = CDM_FIRST + 2
#define CommDlg_OpenSave_GetFolderPathA(_hdlg, _psz, _cbmax) clng(SNDMSG(_hdlg, CDM_GETFOLDERPATH, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPSTR, _psz))))
#define CommDlg_OpenSave_GetFolderPathW(_hdlg, _psz, _cbmax) clng(SNDMSG(_hdlg, CDM_GETFOLDERPATH, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPWSTR, _psz))))

#ifdef UNICODE
	#define CommDlg_OpenSave_GetFolderPath CommDlg_OpenSave_GetFolderPathW
#else
	#define CommDlg_OpenSave_GetFolderPath CommDlg_OpenSave_GetFolderPathA
#endif

const CDM_GETFOLDERIDLIST = CDM_FIRST + 3
#define CommDlg_OpenSave_GetFolderIDList(_hdlg, _pidl, _cbmax) clng(SNDMSG(_hdlg, CDM_GETFOLDERIDLIST, cast(WPARAM, _cbmax), cast(LPARAM, cast(LPVOID, _pidl))))
const CDM_SETCONTROLTEXT = CDM_FIRST + 4
#define CommDlg_OpenSave_SetControlText(_hdlg, _id, _text) SNDMSG(_hdlg, CDM_SETCONTROLTEXT, cast(WPARAM, _id), cast(LPARAM, cast(LPSTR, _text)))
const CDM_HIDECONTROL = CDM_FIRST + 5
#define CommDlg_OpenSave_HideControl(_hdlg, _id) SNDMSG(_hdlg, CDM_HIDECONTROL, cast(WPARAM, _id), 0)
const CDM_SETDEFEXT = CDM_FIRST + 6
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

const CC_RGBINIT = &h1
const CC_FULLOPEN = &h2
const CC_PREVENTFULLOPEN = &h4
const CC_SHOWHELP = &h8
const CC_ENABLEHOOK = &h10
const CC_ENABLETEMPLATE = &h20
const CC_ENABLETEMPLATEHANDLE = &h40
const CC_SOLIDCOLOR = &h80
const CC_ANYCOLOR = &h100
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

const FR_DOWN = &h1
const FR_WHOLEWORD = &h2
const FR_MATCHCASE = &h4
const FR_FINDNEXT = &h8
const FR_REPLACE = &h10
const FR_REPLACEALL = &h20
const FR_DIALOGTERM = &h40
const FR_SHOWHELP = &h80
const FR_ENABLEHOOK = &h100
const FR_ENABLETEMPLATE = &h200
const FR_NOUPDOWN = &h400
const FR_NOMATCHCASE = &h800
const FR_NOWHOLEWORD = &h1000
const FR_ENABLETEMPLATEHANDLE = &h2000
const FR_HIDEUPDOWN = &h4000
const FR_HIDEMATCHCASE = &h8000
const FR_HIDEWHOLEWORD = &h10000
const FR_RAW = &h20000
const FR_MATCHDIAC = &h20000000
const FR_MATCHKASHIDA = &h40000000
const FR_MATCHALEFHAMZA = &h80000000
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
	declare function ReplaceText alias "ReplaceTextW"(byval as LPFINDREPLACEW) as HWND
#else
	declare function ReplaceText alias "ReplaceTextA"(byval as LPFINDREPLACEA) as HWND
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

const CF_SCREENFONTS = &h1
const CF_PRINTERFONTS = &h2
const CF_BOTH = CF_SCREENFONTS or CF_PRINTERFONTS
const CF_SHOWHELP = &h4
const CF_ENABLEHOOK = &h8
const CF_ENABLETEMPLATE = &h10
const CF_ENABLETEMPLATEHANDLE = &h20
const CF_INITTOLOGFONTSTRUCT = &h40
const CF_USESTYLE = &h80
const CF_EFFECTS = &h100
const CF_APPLY = &h200
const CF_ANSIONLY = &h400
const CF_SCRIPTSONLY = CF_ANSIONLY
const CF_NOVECTORFONTS = &h800
const CF_NOOEMFONTS = CF_NOVECTORFONTS
const CF_NOSIMULATIONS = &h1000
const CF_LIMITSIZE = &h2000
const CF_FIXEDPITCHONLY = &h4000
const CF_WYSIWYG = &h8000
const CF_FORCEFONTEXIST = &h10000
const CF_SCALABLEONLY = &h20000
const CF_TTONLY = &h40000
const CF_NOFACESEL = &h80000
const CF_NOSTYLESEL = &h100000
const CF_NOSIZESEL = &h200000
const CF_SELECTSCRIPT = &h400000
const CF_NOSCRIPTSEL = &h800000
const CF_NOVERTFONTS = &h1000000

#if _WIN32_WINNT >= &h0601
	const CF_INACTIVEFONTS = &h02000000
#endif

const SIMULATED_FONTTYPE = &h8000
const PRINTER_FONTTYPE = &h4000
const SCREEN_FONTTYPE = &h2000
const BOLD_FONTTYPE = &h100
const ITALIC_FONTTYPE = &h200
const REGULAR_FONTTYPE = &h400
const PS_OPENTYPE_FONTTYPE = &h10000
const TT_OPENTYPE_FONTTYPE = &h20000
const TYPE1_FONTTYPE = &h40000

#if _WIN32_WINNT >= &h0601
	const SYMBOL_FONTTYPE = &h80000
#endif

const WM_CHOOSEFONT_GETLOGFONT = WM_USER + 1
const WM_CHOOSEFONT_SETLOGFONT = WM_USER + 101
const WM_CHOOSEFONT_SETFLAGS = WM_USER + 102
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

const CD_LBSELNOITEMS = -1
const CD_LBSELCHANGE = 0
const CD_LBSELSUB = 1
const CD_LBSELADD = 2
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

const PD_ALLPAGES = &h0
const PD_SELECTION = &h1
const PD_PAGENUMS = &h2
const PD_NOSELECTION = &h4
const PD_NOPAGENUMS = &h8
const PD_COLLATE = &h10
const PD_PRINTTOFILE = &h20
const PD_PRINTSETUP = &h40
const PD_NOWARNING = &h80
const PD_RETURNDC = &h100
const PD_RETURNIC = &h200
const PD_RETURNDEFAULT = &h400
const PD_SHOWHELP = &h800
const PD_ENABLEPRINTHOOK = &h1000
const PD_ENABLESETUPHOOK = &h2000
const PD_ENABLEPRINTTEMPLATE = &h4000
const PD_ENABLESETUPTEMPLATE = &h8000
const PD_ENABLEPRINTTEMPLATEHANDLE = &h10000
const PD_ENABLESETUPTEMPLATEHANDLE = &h20000
const PD_USEDEVMODECOPIES = &h40000
const PD_USEDEVMODECOPIESANDCOLLATE = &h40000
const PD_DISABLEPRINTTOFILE = &h80000
const PD_HIDEPRINTTOFILE = &h100000
const PD_NONETWORKBUTTON = &h200000
const PD_CURRENTPAGE = &h400000
const PD_NOCURRENTPAGE = &h800000
const PD_EXCLUSIONFLAGS = &h1000000
const PD_USELARGETEMPLATE = &h10000000
const PD_EXCL_COPIESANDCOLLATE = DM_COPIES or DM_COLLATE
const START_PAGE_GENERAL = &hffffffff
const PD_RESULT_CANCEL = 0
const PD_RESULT_PRINT = 1
const PD_RESULT_APPLY = 2

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
const DN_DEFAULTPRN = &h1
declare function CommDlgExtendedError() as DWORD
const WM_PSD_PAGESETUPDLG = WM_USER
const WM_PSD_FULLPAGERECT = WM_USER + 1
const WM_PSD_MINMARGINRECT = WM_USER + 2
const WM_PSD_MARGINRECT = WM_USER + 3
const WM_PSD_GREEKTEXTRECT = WM_USER + 4
const WM_PSD_ENVSTAMPRECT = WM_USER + 5
const WM_PSD_YAFULLPAGERECT = WM_USER + 6
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

const PSD_DEFAULTMINMARGINS = &h0
const PSD_INWININIINTLMEASURE = &h0
const PSD_MINMARGINS = &h1
const PSD_MARGINS = &h2
const PSD_INTHOUSANDTHSOFINCHES = &h4
const PSD_INHUNDREDTHSOFMILLIMETERS = &h8
const PSD_DISABLEMARGINS = &h10
const PSD_DISABLEPRINTER = &h20
const PSD_NOWARNING = &h80
const PSD_DISABLEORIENTATION = &h100
const PSD_RETURNDEFAULT = &h400
const PSD_DISABLEPAPER = &h200
const PSD_SHOWHELP = &h800
const PSD_ENABLEPAGESETUPHOOK = &h2000
const PSD_ENABLEPAGESETUPTEMPLATE = &h8000
const PSD_ENABLEPAGESETUPTEMPLATEHANDLE = &h20000
const PSD_ENABLEPAGEPAINTHOOK = &h40000
const PSD_DISABLEPAGEPAINTING = &h80000
const PSD_NONETWORKBUTTON = &h200000

end extern
