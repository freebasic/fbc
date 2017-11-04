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

#inclib "shell32"

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "wtypesbase.bi"
#include once "wincrypt.bi"
#include once "winapifamily.bi"
#include once "_mingw_unicode.bi"
#include once "ole2.bi"
#include once "shlguid.bi"
#include once "shtypes.bi"
#include once "shobjidl.bi"
#include once "shellapi.bi"
#include once "mshtmlc.bi"

extern "Windows"

#define _SHLOBJ_H_
const CSIDL_FLAG_CREATE = &h8000
const CSIDL_PERSONAL = &h0005
const CSIDL_MYPICTURES = &h0027
const CSIDL_APPDATA = &h001a
const CSIDL_MYMUSIC = &h000d
const CSIDL_MYVIDEO = &h000e

type SHGFP_TYPE as long
enum
	SHGFP_TYPE_CURRENT = 0
	SHGFP_TYPE_DEFAULT = 1
end enum

declare function SHGetFolderPathW(byval hwnd as HWND, byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszPath as LPWSTR) as HRESULT
declare function SHGetMalloc(byval ppMalloc as IMalloc ptr ptr) as HRESULT
declare function SHAlloc(byval cb as SIZE_T_) as any ptr
declare sub SHFree(byval pv as any ptr)

const GIL_OPENICON = &h1
const GIL_FORSHELL = &h2
const GIL_ASYNC = &h20
const GIL_DEFAULTICON = &h40
const GIL_FORSHORTCUT = &h80
const GIL_CHECKSHIELD = &h200
const GIL_SIMULATEDOC = &h1
const GIL_PERINSTANCE = &h2
const GIL_PERCLASS = &h4
const GIL_NOTFILENAME = &h8
const GIL_DONTCACHE = &h10
const GIL_SHIELD = &h200
const GIL_FORCENOSHIELD = &h400
type IExtractIconAVtbl as IExtractIconAVtbl_

type IExtractIconA field = 1
	lpVtbl as IExtractIconAVtbl ptr
end type

type IExtractIconAVtbl_ field = 1
	QueryInterface as function(byval This as IExtractIconA ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IExtractIconA ptr) as ULONG
	Release as function(byval This as IExtractIconA ptr) as ULONG
	GetIconLocation as function(byval This as IExtractIconA ptr, byval uFlags as UINT, byval pszIconFile as PSTR, byval cchMax as UINT, byval piIndex as long ptr, byval pwFlags as UINT ptr) as HRESULT
	Extract as function(byval This as IExtractIconA ptr, byval pszFile as PCSTR, byval nIconIndex as UINT, byval phiconLarge as HICON ptr, byval phiconSmall as HICON ptr, byval nIconSize as UINT) as HRESULT
end type

type LPEXTRACTICONA as IExtractIconA ptr
type IExtractIconWVtbl as IExtractIconWVtbl_

type IExtractIconW field = 1
	lpVtbl as IExtractIconWVtbl ptr
end type

type IExtractIconWVtbl_ field = 1
	QueryInterface as function(byval This as IExtractIconW ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IExtractIconW ptr) as ULONG
	Release as function(byval This as IExtractIconW ptr) as ULONG
	GetIconLocation as function(byval This as IExtractIconW ptr, byval uFlags as UINT, byval pszIconFile as PWSTR, byval cchMax as UINT, byval piIndex as long ptr, byval pwFlags as UINT ptr) as HRESULT
	Extract as function(byval This as IExtractIconW ptr, byval pszFile as PCWSTR, byval nIconIndex as UINT, byval phiconLarge as HICON ptr, byval phiconSmall as HICON ptr, byval nIconSize as UINT) as HRESULT
end type

type LPEXTRACTICONW as IExtractIconW ptr

#ifdef UNICODE
	type IExtractIcon as IExtractIconW
	type IExtractIconVtbl as IExtractIconWVtbl
	type LPEXTRACTICON as LPEXTRACTICONW
#else
	type IExtractIcon as IExtractIconA
	type IExtractIconVtbl as IExtractIconAVtbl
	type LPEXTRACTICON as LPEXTRACTICONA
#endif

type IShellIconOverlayIdentifierVtbl as IShellIconOverlayIdentifierVtbl_

type IShellIconOverlayIdentifier field = 1
	lpVtbl as IShellIconOverlayIdentifierVtbl ptr
end type

type IShellIconOverlayIdentifierVtbl_ field = 1
	QueryInterface as function(byval This as IShellIconOverlayIdentifier ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellIconOverlayIdentifier ptr) as ULONG
	Release as function(byval This as IShellIconOverlayIdentifier ptr) as ULONG
	IsMemberOf as function(byval This as IShellIconOverlayIdentifier ptr, byval pwszPath as PCWSTR, byval dwAttrib as DWORD) as HRESULT
	GetOverlayInfo as function(byval This as IShellIconOverlayIdentifier ptr, byval pwszIconFile as PWSTR, byval cchMax as long, byval pIndex as long ptr, byval pdwFlags as DWORD ptr) as HRESULT
	GetPriority as function(byval This as IShellIconOverlayIdentifier ptr, byval pIPriority as long ptr) as HRESULT
end type

const ISIOI_ICONFILE = &h1
const ISIOI_ICONINDEX = &h2
type IShellIconOverlayManagerVtbl as IShellIconOverlayManagerVtbl_

type IShellIconOverlayManager field = 1
	lpVtbl as IShellIconOverlayManagerVtbl ptr
end type

type IShellIconOverlayManagerVtbl_ field = 1
	QueryInterface as function(byval This as IShellIconOverlayManager ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellIconOverlayManager ptr) as ULONG
	Release as function(byval This as IShellIconOverlayManager ptr) as ULONG
	GetFileOverlayInfo as function(byval This as IShellIconOverlayManager ptr, byval pwszPath as PCWSTR, byval dwAttrib as DWORD, byval pIndex as long ptr, byval dwflags as DWORD) as HRESULT
	GetReservedOverlayInfo as function(byval This as IShellIconOverlayManager ptr, byval pwszPath as PCWSTR, byval dwAttrib as DWORD, byval pIndex as long ptr, byval dwflags as DWORD, byval iReservedID as long) as HRESULT
	RefreshOverlayImages as function(byval This as IShellIconOverlayManager ptr, byval dwFlags as DWORD) as HRESULT
	LoadNonloadedOverlayIdentifiers as function(byval This as IShellIconOverlayManager ptr) as HRESULT
	OverlayIndexFromImageIndex as function(byval This as IShellIconOverlayManager ptr, byval iImage as long, byval piIndex as long ptr, byval fAdd as WINBOOL) as HRESULT
end type

const SIOM_OVERLAYINDEX = 1
const SIOM_ICONINDEX = 2
const SIOM_RESERVED_SHARED = 0
const SIOM_RESERVED_LINK = 1
const SIOM_RESERVED_SLOWFILE = 2
const SIOM_RESERVED_DEFAULT = 3
type IShellIconOverlayVtbl as IShellIconOverlayVtbl_

type IShellIconOverlay field = 1
	lpVtbl as IShellIconOverlayVtbl ptr
end type

type IShellIconOverlayVtbl_ field = 1
	QueryInterface as function(byval This as IShellIconOverlay ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellIconOverlay ptr) as ULONG
	Release as function(byval This as IShellIconOverlay ptr) as ULONG
	GetOverlayIndex as function(byval This as IShellIconOverlay ptr, byval pidl as LPCITEMIDLIST, byval pIndex as long ptr) as HRESULT
	GetOverlayIconIndex as function(byval This as IShellIconOverlay ptr, byval pidl as LPCITEMIDLIST, byval pIconIndex as long ptr) as HRESULT
end type

const OI_DEFAULT = &h0
const OI_ASYNC = &hffffeeee
const IDO_SHGIOI_SHARE = &h0fffffff
const IDO_SHGIOI_LINK = &h0ffffffe
const IDO_SHGIOI_SLOWFILE = &h0fffffffd
const IDO_SHGIOI_DEFAULT = &h0fffffffc
declare function SHGetIconOverlayIndexA(byval pszIconPath as LPCSTR, byval iIconIndex as long) as long
declare function SHGetIconOverlayIndexW(byval pszIconPath as LPCWSTR, byval iIconIndex as long) as long

#ifdef UNICODE
	declare function SHGetIconOverlayIndex alias "SHGetIconOverlayIndexW"(byval pszIconPath as LPCWSTR, byval iIconIndex as long) as long
#else
	declare function SHGetIconOverlayIndex alias "SHGetIconOverlayIndexA"(byval pszIconPath as LPCSTR, byval iIconIndex as long) as long
#endif

type SHELL_LINK_DATA_FLAGS as long
enum
	SLDF_DEFAULT = &h00000000
	SLDF_HAS_ID_LIST = &h00000001
	SLDF_HAS_LINK_INFO = &h00000002
	SLDF_HAS_NAME = &h00000004
	SLDF_HAS_RELPATH = &h00000008
	SLDF_HAS_WORKINGDIR = &h00000010
	SLDF_HAS_ARGS = &h00000020
	SLDF_HAS_ICONLOCATION = &h00000040
	SLDF_UNICODE = &h00000080
	SLDF_FORCE_NO_LINKINFO = &h00000100
	SLDF_HAS_EXP_SZ = &h00000200
	SLDF_RUN_IN_SEPARATE = &h00000400

	#if _WIN32_WINNT <= &h0502
		SLDF_HAS_LOGO3ID = &h00000800
	#endif

	SLDF_HAS_DARWINID = &h00001000
	SLDF_RUNAS_USER = &h00002000
	SLDF_HAS_EXP_ICON_SZ = &h00004000
	SLDF_NO_PIDL_ALIAS = &h00008000
	SLDF_FORCE_UNCNAME = &h00010000
	SLDF_RUN_WITH_SHIMLAYER = &h00020000

	#if _WIN32_WINNT >= &h0600
		SLDF_FORCE_NO_LINKTRACK = &h00040000
		SLDF_ENABLE_TARGET_METADATA = &h00080000
		SLDF_DISABLE_LINK_PATH_TRACKING = &h00100000
		SLDF_DISABLE_KNOWNFOLDER_RELATIVE_TRACKING = &h00200000
	#endif

	#if _WIN32_WINNT = &h0600
		SLDF_VALID = &h003ff7ff
	#elseif _WIN32_WINNT >= &h0601
		SLDF_NO_KF_ALIAS = &h00400000
		SLDF_ALLOW_LINK_TO_LINK = &h00800000
		SLDF_UNALIAS_ON_SAVE = &h01000000
		SLDF_PREFER_ENVIRONMENT_PATH = &h02000000
		SLDF_KEEP_LOCAL_IDLIST_FOR_UNC_TARGET = &h04000000
	#endif

	#if _WIN32_WINNT = &h0601
		SLDF_VALID = &h07fff7ff
	#elseif _WIN32_WINNT = &h0602
		SLDF_PERSIST_VOLUME_ID_RELATIVE = &h08000000
		SLDF_VALID = &h0ffff7ff
	#endif

	SLDF_RESERVED = clng(&h80000000)
end enum

type tagDATABLOCKHEADER field = 1
	cbSize as DWORD
	dwSignature as DWORD
end type

type DATABLOCK_HEADER as tagDATABLOCKHEADER
type LPDATABLOCK_HEADER as tagDATABLOCKHEADER ptr
type LPDBLIST as tagDATABLOCKHEADER ptr

type NT_CONSOLE_PROPS field = 1
	union
		type field = 1
			cbSize as DWORD
			dwSignature as DWORD
		end type
	end union

	wFillAttribute as WORD
	wPopupFillAttribute as WORD
	dwScreenBufferSize as COORD
	dwWindowSize as COORD
	dwWindowOrigin as COORD
	nFont as DWORD
	nInputBufferSize as DWORD
	dwFontSize as COORD
	uFontFamily as UINT
	uFontWeight as UINT
	FaceName as wstring * 32
	uCursorSize as UINT
	bFullScreen as WINBOOL
	bQuickEdit as WINBOOL
	bInsertMode as WINBOOL
	bAutoPosition as WINBOOL
	uHistoryBufferSize as UINT
	uNumberOfHistoryBuffers as UINT
	bHistoryNoDup as WINBOOL
	ColorTable(0 to 15) as COLORREF
end type

type LPNT_CONSOLE_PROPS as NT_CONSOLE_PROPS ptr
const NT_CONSOLE_PROPS_SIG = &ha0000002

type NT_FE_CONSOLE_PROPS field = 1
	union
		type field = 1
			cbSize as DWORD
			dwSignature as DWORD
		end type
	end union

	uCodePage as UINT
end type

type LPNT_FE_CONSOLE_PROPS as NT_FE_CONSOLE_PROPS ptr
const NT_FE_CONSOLE_PROPS_SIG = &ha0000004

type EXP_DARWIN_LINK field = 1
	union
		type field = 1
			cbSize as DWORD
			dwSignature as DWORD
		end type
	end union

	szDarwinID as zstring * 260
	szwDarwinID as wstring * 260
end type

type LPEXP_DARWIN_LINK as EXP_DARWIN_LINK ptr
const EXP_DARWIN_ID_SIG = &ha0000006
const EXP_SPECIAL_FOLDER_SIG = &ha0000005

type EXP_SPECIAL_FOLDER field = 1
	cbSize as DWORD
	dwSignature as DWORD
	idSpecialFolder as DWORD
	cbOffset as DWORD
end type

type LPEXP_SPECIAL_FOLDER as EXP_SPECIAL_FOLDER ptr

type EXP_SZ_LINK field = 1
	cbSize as DWORD
	dwSignature as DWORD
	szTarget as zstring * 260
	swzTarget as wstring * 260
end type

type LPEXP_SZ_LINK as EXP_SZ_LINK ptr
const EXP_SZ_LINK_SIG = &ha0000001
const EXP_SZ_ICON_SIG = &ha0000007

#if _WIN32_WINNT >= &h0600
	type EXP_PROPERTYSTORAGE field = 1
		cbSize as DWORD
		dwSignature as DWORD
		abPropertyStorage(0 to 0) as UBYTE
	end type

	const EXP_PROPERTYSTORAGE_SIG = &ha0000009
#endif

type IShellExecuteHookAVtbl as IShellExecuteHookAVtbl_

type IShellExecuteHookA field = 1
	lpVtbl as IShellExecuteHookAVtbl ptr
end type

type IShellExecuteHookAVtbl_ field = 1
	QueryInterface as function(byval This as IShellExecuteHookA ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellExecuteHookA ptr) as ULONG
	Release as function(byval This as IShellExecuteHookA ptr) as ULONG
	Execute as function(byval This as IShellExecuteHookA ptr, byval pei as LPSHELLEXECUTEINFOA) as HRESULT
end type

type IShellExecuteHookWVtbl as IShellExecuteHookWVtbl_

type IShellExecuteHookW field = 1
	lpVtbl as IShellExecuteHookWVtbl ptr
end type

type IShellExecuteHookWVtbl_ field = 1
	QueryInterface as function(byval This as IShellExecuteHookW ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellExecuteHookW ptr) as ULONG
	Release as function(byval This as IShellExecuteHookW ptr) as ULONG
	Execute as function(byval This as IShellExecuteHookW ptr, byval pei as LPSHELLEXECUTEINFOW) as HRESULT
end type

#ifdef UNICODE
	type IShellExecuteHook as IShellExecuteHookW
	type IShellExecuteHookVtbl as IShellExecuteHookWVtbl
#else
	type IShellExecuteHook as IShellExecuteHookA
	type IShellExecuteHookVtbl as IShellExecuteHookAVtbl
#endif

type IURLSearchHookVtbl as IURLSearchHookVtbl_

type IURLSearchHook field = 1
	lpVtbl as IURLSearchHookVtbl ptr
end type

type IURLSearchHookVtbl_ field = 1
	QueryInterface as function(byval This as IURLSearchHook ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IURLSearchHook ptr) as ULONG
	Release as function(byval This as IURLSearchHook ptr) as ULONG
	Translate as function(byval This as IURLSearchHook ptr, byval pwszSearchURL as PWSTR, byval cchBufferSize as DWORD) as HRESULT
end type

type ISearchContextVtbl as ISearchContextVtbl_

type ISearchContext field = 1
	lpVtbl as ISearchContextVtbl ptr
end type

type ISearchContextVtbl_ field = 1
	QueryInterface as function(byval This as ISearchContext ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISearchContext ptr) as ULONG
	Release as function(byval This as ISearchContext ptr) as ULONG
	GetSearchUrl as function(byval This as ISearchContext ptr, byval pbstrSearchUrl as BSTR ptr) as HRESULT
	GetSearchText as function(byval This as ISearchContext ptr, byval pbstrSearchText as BSTR ptr) as HRESULT
	GetSearchStyle as function(byval This as ISearchContext ptr, byval pdwSearchStyle as DWORD ptr) as HRESULT
end type

type IURLSearchHook2Vtbl as IURLSearchHook2Vtbl_

type IURLSearchHook2 field = 1
	lpVtbl as IURLSearchHook2Vtbl ptr
end type

type IURLSearchHook2Vtbl_ field = 1
	QueryInterface as function(byval This as IURLSearchHook2 ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IURLSearchHook2 ptr) as ULONG
	Release as function(byval This as IURLSearchHook2 ptr) as ULONG
	Translate as function(byval This as IURLSearchHook2 ptr, byval pwszSearchURL as PWSTR, byval cchBufferSize as DWORD) as HRESULT
	TranslateWithSearchContext as function(byval This as IURLSearchHook2 ptr, byval pwszSearchURL as PWSTR, byval cchBufferSize as DWORD, byval pSearchContext as ISearchContext ptr) as HRESULT
end type

type INewShortcutHookAVtbl as INewShortcutHookAVtbl_

type INewShortcutHookA field = 1
	lpVtbl as INewShortcutHookAVtbl ptr
end type

type INewShortcutHookAVtbl_ field = 1
	QueryInterface as function(byval This as INewShortcutHookA ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as INewShortcutHookA ptr) as ULONG
	Release as function(byval This as INewShortcutHookA ptr) as ULONG
	SetReferent as function(byval This as INewShortcutHookA ptr, byval pcszReferent as PCSTR, byval hwnd as HWND) as HRESULT
	GetReferent as function(byval This as INewShortcutHookA ptr, byval pszReferent as PSTR, byval cchReferent as long) as HRESULT
	SetFolder as function(byval This as INewShortcutHookA ptr, byval pcszFolder as PCSTR) as HRESULT
	GetFolder as function(byval This as INewShortcutHookA ptr, byval pszFolder as PSTR, byval cchFolder as long) as HRESULT
	GetName as function(byval This as INewShortcutHookA ptr, byval pszName as PSTR, byval cchName as long) as HRESULT
	GetExtension as function(byval This as INewShortcutHookA ptr, byval pszExtension as PSTR, byval cchExtension as long) as HRESULT
end type

type INewShortcutHookWVtbl as INewShortcutHookWVtbl_

type INewShortcutHookW field = 1
	lpVtbl as INewShortcutHookWVtbl ptr
end type

type INewShortcutHookWVtbl_ field = 1
	QueryInterface as function(byval This as INewShortcutHookW ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as INewShortcutHookW ptr) as ULONG
	Release as function(byval This as INewShortcutHookW ptr) as ULONG
	SetReferent as function(byval This as INewShortcutHookW ptr, byval pcszReferent as PCWSTR, byval hwnd as HWND) as HRESULT
	GetReferent as function(byval This as INewShortcutHookW ptr, byval pszReferent as PWSTR, byval cchReferent as long) as HRESULT
	SetFolder as function(byval This as INewShortcutHookW ptr, byval pcszFolder as PCWSTR) as HRESULT
	GetFolder as function(byval This as INewShortcutHookW ptr, byval pszFolder as PWSTR, byval cchFolder as long) as HRESULT
	GetName as function(byval This as INewShortcutHookW ptr, byval pszName as PWSTR, byval cchName as long) as HRESULT
	GetExtension as function(byval This as INewShortcutHookW ptr, byval pszExtension as PWSTR, byval cchExtension as long) as HRESULT
end type

#ifdef UNICODE
	type INewShortcutHook as INewShortcutHookW
	type INewShortcutHookVtbl as INewShortcutHookWVtbl
#else
	type INewShortcutHook as INewShortcutHookA
	type INewShortcutHookVtbl as INewShortcutHookAVtbl
#endif

type ICopyHookAVtbl as ICopyHookAVtbl_

type ICopyHookA field = 1
	lpVtbl as ICopyHookAVtbl ptr
end type

type ICopyHookAVtbl_ field = 1
	QueryInterface as function(byval This as ICopyHookA ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICopyHookA ptr) as ULONG
	Release as function(byval This as ICopyHookA ptr) as ULONG
	CopyCallback as function(byval This as ICopyHookA ptr, byval hwnd as HWND, byval wFunc as UINT, byval wFlags as UINT, byval pszSrcFile as PCSTR, byval dwSrcAttribs as DWORD, byval pszDestFile as PCSTR, byval dwDestAttribs as DWORD) as UINT
end type

type LPCOPYHOOKA as ICopyHookA ptr
type ICopyHookWVtbl as ICopyHookWVtbl_

type ICopyHookW field = 1
	lpVtbl as ICopyHookWVtbl ptr
end type

type ICopyHookWVtbl_ field = 1
	QueryInterface as function(byval This as ICopyHookW ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICopyHookW ptr) as ULONG
	Release as function(byval This as ICopyHookW ptr) as ULONG
	CopyCallback as function(byval This as ICopyHookW ptr, byval hwnd as HWND, byval wFunc as UINT, byval wFlags as UINT, byval pszSrcFile as PCWSTR, byval dwSrcAttribs as DWORD, byval pszDestFile as PCWSTR, byval dwDestAttribs as DWORD) as UINT
end type

type LPCOPYHOOKW as ICopyHookW ptr

#ifdef UNICODE
	type ICopyHook as ICopyHookW
	type ICopyHookVtbl as ICopyHookWVtbl
	type LPCOPYHOOK as LPCOPYHOOKW
#else
	type ICopyHook as ICopyHookA
	type ICopyHookVtbl as ICopyHookAVtbl
	type LPCOPYHOOK as LPCOPYHOOKA
#endif

#if _WIN32_WINNT = &h0400
	type IFileViewerSiteVtbl as IFileViewerSiteVtbl_

	type IFileViewerSite field = 1
		lpVtbl as IFileViewerSiteVtbl ptr
	end type

	type IFileViewerSiteVtbl_ field = 1
		QueryInterface as function(byval This as IFileViewerSite ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileViewerSite ptr) as ULONG
		Release as function(byval This as IFileViewerSite ptr) as ULONG
		SetPinnedWindow as function(byval This as IFileViewerSite ptr, byval hwnd as HWND) as HRESULT
		GetPinnedWindow as function(byval This as IFileViewerSite ptr, byval phwnd as HWND ptr) as HRESULT
	end type

	type LPFILEVIEWERSITE as IFileViewerSite ptr

	type FVSHOWINFO
		cbSize as DWORD
		hwndOwner as HWND
		iShow as long
		dwFlags as DWORD
		rect as RECT
		punkRel as IUnknown ptr
		strNewFile as wstring * 260
	end type

	type LPFVSHOWINFO as FVSHOWINFO ptr
	const FVSIF_RECT = &h00000001
	const FVSIF_PINNED = &h00000002
	const FVSIF_NEWFAILED = &h08000000
	const FVSIF_NEWFILE = &h80000000
	const FVSIF_CANVIEWIT = &h40000000
	type IFileViewerAVtbl as IFileViewerAVtbl_

	type IFileViewerA field = 1
		lpVtbl as IFileViewerAVtbl ptr
	end type

	type IFileViewerAVtbl_ field = 1
		QueryInterface as function(byval This as IFileViewerA ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileViewerA ptr) as ULONG
		Release as function(byval This as IFileViewerA ptr) as ULONG
		ShowInitialize as function(byval This as IFileViewerA ptr, byval lpfsi as LPFILEVIEWERSITE) as HRESULT
		Show as function(byval This as IFileViewerA ptr, byval pvsi as LPFVSHOWINFO) as HRESULT
		PrintTo as function(byval This as IFileViewerA ptr, byval pszDriver as PSTR, byval fSuppressUI as WINBOOL) as HRESULT
	end type

	type LPFILEVIEWERA as IFileViewerA ptr
	type IFileViewerWVtbl as IFileViewerWVtbl_

	type IFileViewerW field = 1
		lpVtbl as IFileViewerWVtbl ptr
	end type

	type IFileViewerWVtbl_ field = 1
		QueryInterface as function(byval This as IFileViewerW ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		AddRef as function(byval This as IFileViewerW ptr) as ULONG
		Release as function(byval This as IFileViewerW ptr) as ULONG
		ShowInitialize as function(byval This as IFileViewerW ptr, byval lpfsi as LPFILEVIEWERSITE) as HRESULT
		Show as function(byval This as IFileViewerW ptr, byval pvsi as LPFVSHOWINFO) as HRESULT
		PrintTo as function(byval This as IFileViewerW ptr, byval pszDriver as PWSTR, byval fSuppressUI as WINBOOL) as HRESULT
	end type

	type LPFILEVIEWERW as IFileViewerW ptr
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0400)
	type IFileViewer as IFileViewerW
	type LPFILEVIEWER as LPFILEVIEWERW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0400)
	type IFileViewer as IFileViewerA
	type LPFILEVIEWER as LPFILEVIEWERA
#endif

const FCIDM_SHVIEWFIRST = &h0000
const FCIDM_SHVIEWLAST = &h7fff
const FCIDM_BROWSERFIRST = &ha000
const FCIDM_BROWSERLAST = &hbf00
const FCIDM_GLOBALFIRST = &h8000
const FCIDM_GLOBALLAST = &h9fff
const FCIDM_MENU_FILE = FCIDM_GLOBALFIRST + &h0000
const FCIDM_MENU_EDIT = FCIDM_GLOBALFIRST + &h0040
const FCIDM_MENU_VIEW = FCIDM_GLOBALFIRST + &h0080
const FCIDM_MENU_VIEW_SEP_OPTIONS = FCIDM_GLOBALFIRST + &h0081
const FCIDM_MENU_TOOLS = FCIDM_GLOBALFIRST + &h00c0
const FCIDM_MENU_TOOLS_SEP_GOTO = FCIDM_GLOBALFIRST + &h00c1
const FCIDM_MENU_HELP = FCIDM_GLOBALFIRST + &h0100
const FCIDM_MENU_FIND = FCIDM_GLOBALFIRST + &h0140
const FCIDM_MENU_EXPLORE = FCIDM_GLOBALFIRST + &h0150
const FCIDM_MENU_FAVORITES = FCIDM_GLOBALFIRST + &h0170
const FCIDM_TOOLBAR = FCIDM_BROWSERFIRST + 0
const FCIDM_STATUS = FCIDM_BROWSERFIRST + 1
const IDC_OFFLINE_HAND = 103

#if _WIN32_WINNT >= &h0600
	const IDC_PANTOOL_HAND_OPEN = 104
	const IDC_PANTOOL_HAND_CLOSED = 105
#endif

const PANE_NONE = cast(DWORD, -1)
const PANE_ZONE = 1
const PANE_OFFLINE = 2
const PANE_PRINTER = 3
const PANE_SSL = 4
const PANE_NAVIGATION = 5
const PANE_PROGRESS = 6

#if _WIN32_WINNT >= &h0501
	const PANE_PRIVACY = 7
#endif

declare function ILClone(byval pidl as LPCITEMIDLIST) as LPITEMIDLIST
declare function ILCloneFirst(byval pidl as LPCITEMIDLIST) as LPITEMIDLIST
declare function ILCombine(byval pidl1 as LPCITEMIDLIST, byval pidl2 as LPCITEMIDLIST) as LPITEMIDLIST
declare sub ILFree(byval pidl as LPITEMIDLIST)
declare function ILGetNext(byval pidl as LPCITEMIDLIST) as LPITEMIDLIST
declare function ILGetSize(byval pidl as LPCITEMIDLIST) as UINT
declare function ILFindChild(byval pidlParent as LPITEMIDLIST, byval pidlChild as LPCITEMIDLIST) as LPITEMIDLIST
declare function ILFindLastID(byval pidl as LPCITEMIDLIST) as LPITEMIDLIST
declare function ILRemoveLastID(byval pidl as LPITEMIDLIST) as WINBOOL
declare function ILIsEqual(byval pidl1 as LPCITEMIDLIST, byval pidl2 as LPCITEMIDLIST) as WINBOOL
declare function ILIsParent(byval pidl1 as LPCITEMIDLIST, byval pidl2 as LPCITEMIDLIST, byval fImmediate as WINBOOL) as WINBOOL
declare function ILSaveToStream(byval pstm as IStream ptr, byval pidl as LPCITEMIDLIST) as HRESULT
declare function ILLoadFromStream(byval pstm as IStream ptr, byval pidl as LPITEMIDLIST ptr) as HRESULT

#if _WIN32_WINNT >= &h0600
	declare function ILLoadFromStreamEx(byval pstm as IStream ptr, byval pidl as LPITEMIDLIST ptr) as HRESULT
#endif

declare function ILCreateFromPathA(byval pszPath as PCSTR) as LPITEMIDLIST
declare function ILCreateFromPathW(byval pszPath as PCWSTR) as LPITEMIDLIST

#ifdef UNICODE
	declare function ILCreateFromPath alias "ILCreateFromPathW"(byval pszPath as PCWSTR) as LPITEMIDLIST
#else
	declare function ILCreateFromPath alias "ILCreateFromPathA"(byval pszPath as PCSTR) as LPITEMIDLIST
#endif

declare function SHILCreateFromPath(byval pszPath as PCWSTR, byval ppidl as LPITEMIDLIST ptr, byval rgfInOut as DWORD ptr) as HRESULT
#define VOID_OFFSET(pv, cb) cptr(any ptr, cptr(UBYTE ptr, (pv)) + (cb))
declare function ILCloneFull alias "ILClone"(byval pidl as LPCITEMIDLIST) as LPITEMIDLIST
declare function ILCloneChild alias "ILCloneFirst"(byval pidl as LPCITEMIDLIST) as LPITEMIDLIST
#define ILSkip(P, C) cast(PUIDLIST_RELATIVE, VOID_OFFSET((P), (C)))
#define ILNext(P) ILSkip(P, (P)->mkid.cb)
#define ILIsAligned(P) ((cast(DWORD_PTR, (P)) and (sizeof(any ptr) - 1)) = 0)
#define ILIsEmpty(P) (((P) = 0) orelse ((P)->mkid.cb = 0))
#define ILIsChild(P) (ILIsEmpty(P) orelse ILIsEmpty(ILNext(P)))
declare function ILAppendID(byval pidl as LPITEMIDLIST, byval pmkid as LPCSHITEMID, byval fAppend as WINBOOL) as LPITEMIDLIST

#if _WIN32_WINNT >= &h0600
	type tagGPFIDL_FLAGS as long
	enum
		GPFIDL_DEFAULT = &h0
		GPFIDL_ALTNAME = &h1
		GPFIDL_UNCPRINTER = &h2
	end enum

	type GPFIDL_FLAGS as long
	declare function SHGetPathFromIDListEx(byval pidl as LPCITEMIDLIST, byval pszPath as PWSTR, byval cchPath as DWORD, byval uOpts as GPFIDL_FLAGS) as WINBOOL
#endif

declare function SHGetPathFromIDListA(byval pidl as LPCITEMIDLIST, byval pszPath as LPSTR) as WINBOOL
declare function SHGetPathFromIDListW(byval pidl as LPCITEMIDLIST, byval pszPath as LPWSTR) as WINBOOL
declare function SHCreateDirectory(byval hwnd as HWND, byval pszPath as PCWSTR) as long
declare function SHCreateDirectoryExA(byval hwnd as HWND, byval pszPath as LPCSTR, byval psa as const SECURITY_ATTRIBUTES ptr) as long
declare function SHCreateDirectoryExW(byval hwnd as HWND, byval pszPath as LPCWSTR, byval psa as const SECURITY_ATTRIBUTES ptr) as long

#ifdef UNICODE
	declare function SHGetPathFromIDList alias "SHGetPathFromIDListW"(byval pidl as LPCITEMIDLIST, byval pszPath as LPWSTR) as WINBOOL
	declare function SHCreateDirectoryEx alias "SHCreateDirectoryExW"(byval hwnd as HWND, byval pszPath as LPCWSTR, byval psa as const SECURITY_ATTRIBUTES ptr) as long
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function SHGetPathFromIDList alias "SHGetPathFromIDListA"(byval pidl as LPCITEMIDLIST, byval pszPath as LPSTR) as WINBOOL
	declare function SHCreateDirectoryEx alias "SHCreateDirectoryExA"(byval hwnd as HWND, byval pszPath as LPCSTR, byval psa as const SECURITY_ATTRIBUTES ptr) as long
#endif

#if _WIN32_WINNT >= &h0600
	const OFASI_EDIT = &h0001
	const OFASI_OPENDESKTOP = &h0002
#elseif (not defined(UNICODE)) and (_WIN32_WINNT <= &h0502)
	declare function SHGetPathFromIDList alias "SHGetPathFromIDListA"(byval pidl as LPCITEMIDLIST, byval pszPath as LPSTR) as WINBOOL
	declare function SHCreateDirectoryEx alias "SHCreateDirectoryExA"(byval hwnd as HWND, byval pszPath as LPCSTR, byval psa as const SECURITY_ATTRIBUTES ptr) as long
#endif

declare function SHOpenFolderAndSelectItems(byval pidlFolder as LPCITEMIDLIST, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval dwFlags as DWORD) as HRESULT
declare function SHCreateShellItem(byval pidlParent as LPCITEMIDLIST, byval psfParent as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval ppsi as IShellItem ptr ptr) as HRESULT
#define REGSTR_PATH_SPECIAL_FOLDERS REGSTR_PATH_EXPLORER __TEXT(!"\\Shell Folders")
const CSIDL_DESKTOP = &h0000
const CSIDL_INTERNET = &h0001
const CSIDL_PROGRAMS = &h0002
const CSIDL_CONTROLS = &h0003
const CSIDL_PRINTERS = &h0004
const CSIDL_FAVORITES = &h0006
const CSIDL_STARTUP = &h0007
const CSIDL_RECENT = &h0008
const CSIDL_SENDTO = &h0009
const CSIDL_BITBUCKET = &h000a
const CSIDL_STARTMENU = &h000b
const CSIDL_MYDOCUMENTS = CSIDL_PERSONAL
const CSIDL_DESKTOPDIRECTORY = &h0010
const CSIDL_DRIVES = &h0011
const CSIDL_NETWORK = &h0012
const CSIDL_NETHOOD = &h0013
const CSIDL_FONTS = &h0014
const CSIDL_TEMPLATES = &h0015
const CSIDL_COMMON_STARTMENU = &h0016
const CSIDL_COMMON_PROGRAMS = &h0017
const CSIDL_COMMON_STARTUP = &h0018
const CSIDL_COMMON_DESKTOPDIRECTORY = &h0019
const CSIDL_PRINTHOOD = &h001b
const CSIDL_LOCAL_APPDATA = &h001c
const CSIDL_ALTSTARTUP = &h001d
const CSIDL_COMMON_ALTSTARTUP = &h001e
const CSIDL_COMMON_FAVORITES = &h001f
const CSIDL_INTERNET_CACHE = &h0020
const CSIDL_COOKIES = &h0021
const CSIDL_HISTORY = &h0022
const CSIDL_COMMON_APPDATA = &h0023
const CSIDL_WINDOWS = &h0024
const CSIDL_SYSTEM = &h0025
const CSIDL_PROGRAM_FILES = &h0026
const CSIDL_PROFILE = &h0028
const CSIDL_SYSTEMX86 = &h0029
const CSIDL_PROGRAM_FILESX86 = &h002a
const CSIDL_PROGRAM_FILES_COMMON = &h002b
const CSIDL_PROGRAM_FILES_COMMONX86 = &h002c
const CSIDL_COMMON_TEMPLATES = &h002d
const CSIDL_COMMON_DOCUMENTS = &h002e
const CSIDL_COMMON_ADMINTOOLS = &h002f
const CSIDL_ADMINTOOLS = &h0030
const CSIDL_CONNECTIONS = &h0031
const CSIDL_COMMON_MUSIC = &h0035
const CSIDL_COMMON_PICTURES = &h0036
const CSIDL_COMMON_VIDEO = &h0037
const CSIDL_RESOURCES = &h0038
const CSIDL_RESOURCES_LOCALIZED = &h0039
const CSIDL_COMMON_OEM_LINKS = &h003a
const CSIDL_CDBURN_AREA = &h003b
const CSIDL_COMPUTERSNEARME = &h003d
const CSIDL_FLAG_DONT_VERIFY = &h4000
const CSIDL_FLAG_PFTI_TRACKTARGET = CSIDL_FLAG_DONT_VERIFY
const CSIDL_FLAG_DONT_UNEXPAND = &h2000
const CSIDL_FLAG_NO_ALIAS = &h1000
const CSIDL_FLAG_PER_USER_INIT = &h0800
const CSIDL_FLAG_MASK = &hff00

declare function SHGetSpecialFolderLocation(byval hwnd as HWND, byval csidl as long, byval ppidl as LPITEMIDLIST ptr) as HRESULT
declare function SHCloneSpecialIDList(byval hwnd as HWND, byval csidl as long, byval fCreate as WINBOOL) as LPITEMIDLIST
declare function SHGetSpecialFolderPathA(byval hwnd as HWND, byval pszPath as LPSTR, byval csidl as long, byval fCreate as WINBOOL) as WINBOOL
declare function SHGetSpecialFolderPathW(byval hwnd as HWND, byval pszPath as LPWSTR, byval csidl as long, byval fCreate as WINBOOL) as WINBOOL
declare sub SHFlushSFCache()
declare function SHGetFolderPathA(byval hwnd as HWND, byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszPath as LPSTR) as HRESULT
declare function SHGetFolderLocation(byval hwnd as HWND, byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval ppidl as LPITEMIDLIST ptr) as HRESULT
declare function SHSetFolderPathA(byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszPath as LPCSTR) as HRESULT
declare function SHSetFolderPathW(byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszPath as LPCWSTR) as HRESULT
declare function SHGetFolderPathAndSubDirA(byval hwnd as HWND, byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszSubDir as LPCSTR, byval pszPath as LPSTR) as HRESULT
declare function SHGetFolderPathAndSubDirW(byval hwnd as HWND, byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszSubDir as LPCWSTR, byval pszPath as LPWSTR) as HRESULT

#ifdef UNICODE
	declare function SHGetSpecialFolderPath alias "SHGetSpecialFolderPathW"(byval hwnd as HWND, byval pszPath as LPWSTR, byval csidl as long, byval fCreate as WINBOOL) as WINBOOL
	declare function SHGetFolderPath alias "SHGetFolderPathW"(byval hwnd as HWND, byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszPath as LPWSTR) as HRESULT
	declare function SHSetFolderPath alias "SHSetFolderPathW"(byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszPath as LPCWSTR) as HRESULT
	declare function SHGetFolderPathAndSubDir alias "SHGetFolderPathAndSubDirW"(byval hwnd as HWND, byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszSubDir as LPCWSTR, byval pszPath as LPWSTR) as HRESULT
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function SHGetSpecialFolderPath alias "SHGetSpecialFolderPathA"(byval hwnd as HWND, byval pszPath as LPSTR, byval csidl as long, byval fCreate as WINBOOL) as WINBOOL
	declare function SHGetFolderPath alias "SHGetFolderPathA"(byval hwnd as HWND, byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszPath as LPSTR) as HRESULT
	declare function SHSetFolderPath alias "SHSetFolderPathA"(byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszPath as LPCSTR) as HRESULT
	declare function SHGetFolderPathAndSubDir alias "SHGetFolderPathAndSubDirA"(byval hwnd as HWND, byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszSubDir as LPCSTR, byval pszPath as LPSTR) as HRESULT
#endif

#if _WIN32_WINNT >= &h0600
	type KNOWN_FOLDER_FLAG as long
	enum
		KF_FLAG_DEFAULT = &h00000000

		#if _WIN32_WINNT >= &h0601
			KF_FLAG_NO_APPCONTAINER_REDIRECTION = &h00010000
		#endif

		KF_FLAG_CREATE = &h00008000
		KF_FLAG_DONT_VERIFY = &h00004000
		KF_FLAG_DONT_UNEXPAND = &h00002000
		KF_FLAG_NO_ALIAS = &h00001000
		KF_FLAG_INIT = &h00000800
		KF_FLAG_DEFAULT_PATH = &h00000400
		KF_FLAG_NOT_PARENT_RELATIVE = &h00000200
		KF_FLAG_SIMPLE_IDLIST = &h00000100
		KF_FLAG_ALIAS_ONLY = &h80000000
	end enum

	declare function SHGetKnownFolderIDList(byval rfid as const KNOWNFOLDERID const ptr, byval dwFlags as DWORD, byval hToken as HANDLE, byval ppidl as LPITEMIDLIST ptr) as HRESULT
	declare function SHSetKnownFolderPath(byval rfid as const KNOWNFOLDERID const ptr, byval dwFlags as DWORD, byval hToken as HANDLE, byval pszPath as PCWSTR) as HRESULT
	declare function SHGetKnownFolderPath(byval rfid as const KNOWNFOLDERID const ptr, byval dwFlags as DWORD, byval hToken as HANDLE, byval ppszPath as PWSTR ptr) as HRESULT
#endif

#if _WIN32_WINNT >= &h0601
	declare function SHGetKnownFolderItem(byval rfid as const KNOWNFOLDERID const ptr, byval flags as KNOWN_FOLDER_FLAG, byval hToken as HANDLE, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
#elseif (not defined(UNICODE)) and (_WIN32_WINNT <= &h0502)
	declare function SHGetSpecialFolderPath alias "SHGetSpecialFolderPathA"(byval hwnd as HWND, byval pszPath as LPSTR, byval csidl as long, byval fCreate as WINBOOL) as WINBOOL
	declare function SHGetFolderPath alias "SHGetFolderPathA"(byval hwnd as HWND, byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszPath as LPSTR) as HRESULT
	declare function SHSetFolderPath alias "SHSetFolderPathA"(byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszPath as LPCSTR) as HRESULT
	declare function SHGetFolderPathAndSubDir alias "SHGetFolderPathAndSubDirA"(byval hwnd as HWND, byval csidl as long, byval hToken as HANDLE, byval dwFlags as DWORD, byval pszSubDir as LPCSTR, byval pszPath as LPSTR) as HRESULT
#endif

const FCS_READ = &h00000001
const FCS_FORCEWRITE = &h00000002
const FCS_WRITE = FCS_READ or FCS_FORCEWRITE
const FCS_FLAG_DRAGDROP = 2
const FCSM_VIEWID = &h00000001
const FCSM_WEBVIEWTEMPLATE = &h00000002
const FCSM_INFOTIP = &h00000004
const FCSM_CLSID = &h00000008
const FCSM_ICONFILE = &h00000010
const FCSM_LOGO = &h00000020
const FCSM_FLAGS = &h00000040

#if _WIN32_WINNT >= &h0600
	type SHFOLDERCUSTOMSETTINGS
		dwSize as DWORD
		dwMask as DWORD
		pvid as SHELLVIEWID ptr
		pszWebViewTemplate as LPWSTR
		cchWebViewTemplate as DWORD
		pszWebViewTemplateVersion as LPWSTR
		pszInfoTip as LPWSTR
		cchInfoTip as DWORD
		pclsid as CLSID ptr
		dwFlags as DWORD
		pszIconFile as LPWSTR
		cchIconFile as DWORD
		iIconIndex as long
		pszLogo as LPWSTR
		cchLogo as DWORD
	end type

	type LPSHFOLDERCUSTOMSETTINGS as SHFOLDERCUSTOMSETTINGS ptr
	declare function SHGetSetFolderCustomSettings(byval pfcs as LPSHFOLDERCUSTOMSETTINGS, byval pszPath as PCWSTR, byval dwReadWrite as DWORD) as HRESULT
#endif

type BFFCALLBACK as function(byval hwnd as HWND, byval uMsg as UINT, byval lParam as LPARAM, byval lpData as LPARAM) as long

type _browseinfoA
	hwndOwner as HWND
	pidlRoot as LPCITEMIDLIST
	pszDisplayName as LPSTR
	lpszTitle as LPCSTR
	ulFlags as UINT
	lpfn as BFFCALLBACK
	lParam as LPARAM
	iImage as long
end type

type BROWSEINFOA as _browseinfoA
type PBROWSEINFOA as _browseinfoA ptr
type LPBROWSEINFOA as _browseinfoA ptr

type _browseinfoW
	hwndOwner as HWND
	pidlRoot as LPCITEMIDLIST
	pszDisplayName as LPWSTR
	lpszTitle as LPCWSTR
	ulFlags as UINT
	lpfn as BFFCALLBACK
	lParam as LPARAM
	iImage as long
end type

type BROWSEINFOW as _browseinfoW
type PBROWSEINFOW as _browseinfoW ptr
type LPBROWSEINFOW as _browseinfoW ptr

#ifdef UNICODE
	type BROWSEINFO as BROWSEINFOW
	type PBROWSEINFO as PBROWSEINFOW
	type LPBROWSEINFO as LPBROWSEINFOW
#else
	type BROWSEINFO as BROWSEINFOA
	type PBROWSEINFO as PBROWSEINFOA
	type LPBROWSEINFO as LPBROWSEINFOA
#endif

const BIF_RETURNONLYFSDIRS = &h00000001
const BIF_DONTGOBELOWDOMAIN = &h00000002
const BIF_STATUSTEXT = &h00000004
const BIF_RETURNFSANCESTORS = &h00000008
const BIF_EDITBOX = &h00000010
const BIF_VALIDATE = &h00000020
const BIF_NEWDIALOGSTYLE = &h00000040
const BIF_USENEWUI = BIF_NEWDIALOGSTYLE or BIF_EDITBOX
const BIF_BROWSEINCLUDEURLS = &h00000080
const BIF_UAHINT = &h00000100
const BIF_NONEWFOLDERBUTTON = &h00000200
const BIF_NOTRANSLATETARGETS = &h00000400
const BIF_BROWSEFORCOMPUTER = &h00001000
const BIF_BROWSEFORPRINTER = &h00002000
const BIF_BROWSEINCLUDEFILES = &h00004000
const BIF_SHAREABLE = &h00008000
const BIF_BROWSEFILEJUNCTIONS = &h00010000
const BFFM_INITIALIZED = 1
const BFFM_SELCHANGED = 2
const BFFM_VALIDATEFAILEDA = 3
const BFFM_VALIDATEFAILEDW = 4
const BFFM_IUNKNOWN = 5
const BFFM_SETSTATUSTEXTA = WM_USER + 100
const BFFM_ENABLEOK = WM_USER + 101
const BFFM_SETSELECTIONA = WM_USER + 102
const BFFM_SETSELECTIONW = WM_USER + 103
const BFFM_SETSTATUSTEXTW = WM_USER + 104
const BFFM_SETOKTEXT = WM_USER + 105
const BFFM_SETEXPANDED = WM_USER + 106
declare function SHBrowseForFolderA(byval lpbi as LPBROWSEINFOA) as LPITEMIDLIST
declare function SHBrowseForFolderW(byval lpbi as LPBROWSEINFOW) as LPITEMIDLIST

#ifdef UNICODE
	declare function SHBrowseForFolder alias "SHBrowseForFolderW"(byval lpbi as LPBROWSEINFOW) as LPITEMIDLIST
	const BFFM_SETSTATUSTEXT = BFFM_SETSTATUSTEXTW
	const BFFM_SETSELECTION = BFFM_SETSELECTIONW
	const BFFM_VALIDATEFAILED = BFFM_VALIDATEFAILEDW
#else
	declare function SHBrowseForFolder alias "SHBrowseForFolderA"(byval lpbi as LPBROWSEINFOA) as LPITEMIDLIST
	const BFFM_SETSTATUSTEXT = BFFM_SETSTATUSTEXTA
	const BFFM_SETSELECTION = BFFM_SETSELECTIONA
	const BFFM_VALIDATEFAILED = BFFM_VALIDATEFAILEDA
#endif

declare function SHLoadInProc(byval rclsid as const IID const ptr) as HRESULT

enum
	ISHCUTCMDID_DOWNLOADICON = 0
	ISHCUTCMDID_INTSHORTCUTCREATE = 1

	#if _WIN32_WINNT >= &h0600
		ISHCUTCMDID_COMMITHISTORY = 2
		ISHCUTCMDID_SETUSERAWURL = 3
	#endif
end enum

const CMDID_INTSHORTCUTCREATE = ISHCUTCMDID_INTSHORTCUTCREATE
#define STR_PARSE_WITH_PROPERTIES wstr("ParseWithProperties")
#define STR_PARSE_PARTIAL_IDLIST wstr("ParseOriginalItem")
declare function SHGetDesktopFolder(byval ppshf as IShellFolder ptr ptr) as HRESULT
type IShellDetailsVtbl as IShellDetailsVtbl_

type IShellDetails field = 1
	lpVtbl as IShellDetailsVtbl ptr
end type

type IShellDetailsVtbl_ field = 1
	QueryInterface as function(byval This as IShellDetails ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellDetails ptr) as ULONG
	Release as function(byval This as IShellDetails ptr) as ULONG
	GetDetailsOf as function(byval This as IShellDetails ptr, byval pidl as LPCITEMIDLIST, byval iColumn as UINT, byval pDetails as SHELLDETAILS ptr) as HRESULT
	ColumnClick as function(byval This as IShellDetails ptr, byval iColumn as UINT) as HRESULT
end type

type IObjMgrVtbl as IObjMgrVtbl_

type IObjMgr field = 1
	lpVtbl as IObjMgrVtbl ptr
end type

type IObjMgrVtbl_ field = 1
	QueryInterface as function(byval This as IObjMgr ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IObjMgr ptr) as ULONG
	Release as function(byval This as IObjMgr ptr) as ULONG
	Append as function(byval This as IObjMgr ptr, byval punk as IUnknown ptr) as HRESULT
	Remove as function(byval This as IObjMgr ptr, byval punk as IUnknown ptr) as HRESULT
end type

type ICurrentWorkingDirectoryVtbl as ICurrentWorkingDirectoryVtbl_

type ICurrentWorkingDirectory field = 1
	lpVtbl as ICurrentWorkingDirectoryVtbl ptr
end type

type ICurrentWorkingDirectoryVtbl_ field = 1
	QueryInterface as function(byval This as ICurrentWorkingDirectory ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICurrentWorkingDirectory ptr) as ULONG
	Release as function(byval This as ICurrentWorkingDirectory ptr) as ULONG
	GetDirectory as function(byval This as ICurrentWorkingDirectory ptr, byval pwzPath as PWSTR, byval cchSize as DWORD) as HRESULT
	SetDirectory as function(byval This as ICurrentWorkingDirectory ptr, byval pwzPath as PCWSTR) as HRESULT
end type

type IACListVtbl as IACListVtbl_

type IACList field = 1
	lpVtbl as IACListVtbl ptr
end type

type IACListVtbl_ field = 1
	QueryInterface as function(byval This as IACList ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IACList ptr) as ULONG
	Release as function(byval This as IACList ptr) as ULONG
	Expand as function(byval This as IACList ptr, byval pszExpand as PCWSTR) as HRESULT
end type

type _tagAUTOCOMPLETELISTOPTIONS as long
enum
	ACLO_NONE = 0
	ACLO_CURRENTDIR = 1
	ACLO_MYCOMPUTER = 2
	ACLO_DESKTOP = 4
	ACLO_FAVORITES = 8
	ACLO_FILESYSONLY = 16

	#if _WIN32_WINNT >= &h0501
		ACLO_FILESYSDIRS = 32
	#endif

	#if _WIN32_WINNT >= &h0600
		ACLO_VIRTUALNAMESPACE = 64
	#endif
end enum

type AUTOCOMPLETELISTOPTIONS as _tagAUTOCOMPLETELISTOPTIONS
type IACList2Vtbl as IACList2Vtbl_

type IACList2 field = 1
	lpVtbl as IACList2Vtbl ptr
end type

type IACList2Vtbl_ field = 1
	QueryInterface as function(byval This as IACList2 ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IACList2 ptr) as ULONG
	Release as function(byval This as IACList2 ptr) as ULONG
	Expand as function(byval This as IACList2 ptr, byval pszExpand as PCWSTR) as HRESULT
	SetOptions as function(byval This as IACList2 ptr, byval dwFlag as DWORD) as HRESULT
	GetOptions as function(byval This as IACList2 ptr, byval pdwFlag as DWORD ptr) as HRESULT
end type

const PROGDLG_NORMAL = &h00000000
const PROGDLG_MODAL = &h00000001
const PROGDLG_AUTOTIME = &h00000002
const PROGDLG_NOTIME = &h00000004
const PROGDLG_NOMINIMIZE = &h00000008
const PROGDLG_NOPROGRESSBAR = &h00000010

#if _WIN32_WINNT >= &h0600
	const PROGDLG_MARQUEEPROGRESS = &h00000020
	const PROGDLG_NOCANCEL = &h00000040
#endif

const PDTIMER_RESET = &h00000001

#if _WIN32_WINNT >= &h0600
	const PDTIMER_PAUSE = &h00000002
	const PDTIMER_RESUME = &h00000003
#endif

type IProgressDialogVtbl as IProgressDialogVtbl_

type IProgressDialog field = 1
	lpVtbl as IProgressDialogVtbl ptr
end type

type IProgressDialogVtbl_ field = 1
	QueryInterface as function(byval This as IProgressDialog ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IProgressDialog ptr) as ULONG
	Release as function(byval This as IProgressDialog ptr) as ULONG
	StartProgressDialog as function(byval This as IProgressDialog ptr, byval hwndParent as HWND, byval punkEnableModless as IUnknown ptr, byval dwFlags as DWORD, byval pvResevered as LPCVOID) as HRESULT
	StopProgressDialog as function(byval This as IProgressDialog ptr) as HRESULT
	SetTitle as function(byval This as IProgressDialog ptr, byval pwzTitle as PCWSTR) as HRESULT
	SetAnimation as function(byval This as IProgressDialog ptr, byval hInstAnimation as HINSTANCE, byval idAnimation as UINT) as HRESULT
	HasUserCancelled as function(byval This as IProgressDialog ptr) as WINBOOL
	SetProgress as function(byval This as IProgressDialog ptr, byval dwCompleted as DWORD, byval dwTotal as DWORD) as HRESULT
	SetProgress64 as function(byval This as IProgressDialog ptr, byval ullCompleted as ULONGLONG, byval ullTotal as ULONGLONG) as HRESULT
	SetLine as function(byval This as IProgressDialog ptr, byval dwLineNum as DWORD, byval pwzString as PCWSTR, byval fCompactPath as WINBOOL, byval pvResevered as LPCVOID) as HRESULT
	SetCancelMsg as function(byval This as IProgressDialog ptr, byval pwzCancelMsg as PCWSTR, byval pvResevered as LPCVOID) as HRESULT
	Timer as function(byval This as IProgressDialog ptr, byval dwTimerAction as DWORD, byval pvResevered as LPCVOID) as HRESULT
end type

type IDockingWindowSiteVtbl as IDockingWindowSiteVtbl_

type IDockingWindowSite field = 1
	lpVtbl as IDockingWindowSiteVtbl ptr
end type

type IDockingWindowSiteVtbl_ field = 1
	QueryInterface as function(byval This as IDockingWindowSite ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDockingWindowSite ptr) as ULONG
	Release as function(byval This as IDockingWindowSite ptr) as ULONG
	GetWindow as function(byval This as IDockingWindowSite ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IDockingWindowSite ptr, byval fEnterMode as WINBOOL) as HRESULT
	GetBorderDW as function(byval This as IDockingWindowSite ptr, byval punkObj as IUnknown ptr, byval prcBorder as RECT ptr) as HRESULT
	RequestBorderSpaceDW as function(byval This as IDockingWindowSite ptr, byval punkObj as IUnknown ptr, byval pbw as LPCBORDERWIDTHS) as HRESULT
	SetBorderSpaceDW as function(byval This as IDockingWindowSite ptr, byval punkObj as IUnknown ptr, byval pbw as LPCBORDERWIDTHS) as HRESULT
end type

const DWFRF_NORMAL = &h0000
const DWFRF_DELETECONFIGDATA = &h0001
const DWFAF_HIDDEN = &h1
const DWFAF_GROUP1 = &h2
const DWFAF_GROUP2 = &h4
const DWFAF_AUTOHIDE = &h10
type IDockingWindowFrameVtbl as IDockingWindowFrameVtbl_

type IDockingWindowFrame field = 1
	lpVtbl as IDockingWindowFrameVtbl ptr
end type

type IDockingWindowFrameVtbl_ field = 1
	QueryInterface as function(byval This as IDockingWindowFrame ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDockingWindowFrame ptr) as ULONG
	Release as function(byval This as IDockingWindowFrame ptr) as ULONG
	GetWindow as function(byval This as IDockingWindowFrame ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IDockingWindowFrame ptr, byval fEnterMode as WINBOOL) as HRESULT
	AddToolbar as function(byval This as IDockingWindowFrame ptr, byval punkSrc as IUnknown ptr, byval pwszItem as PCWSTR, byval dwAddFlags as DWORD) as HRESULT
	RemoveToolbar as function(byval This as IDockingWindowFrame ptr, byval punkSrc as IUnknown ptr, byval dwRemoveFlags as DWORD) as HRESULT
	FindToolbar as function(byval This as IDockingWindowFrame ptr, byval pwszItem as PCWSTR, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
end type

type IThumbnailCaptureVtbl as IThumbnailCaptureVtbl_

type IThumbnailCapture field = 1
	lpVtbl as IThumbnailCaptureVtbl ptr
end type

type IThumbnailCaptureVtbl_ field = 1
	QueryInterface as function(byval This as IThumbnailCapture ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IThumbnailCapture ptr) as ULONG
	Release as function(byval This as IThumbnailCapture ptr) as ULONG
	CaptureThumbnail as function(byval This as IThumbnailCapture ptr, byval pMaxSize as const SIZE ptr, byval pHTMLDoc2 as IUnknown ptr, byval phbmThumbnail as HBITMAP ptr) as HRESULT
end type

type LPTHUMBNAILCAPTURE as IThumbnailCapture ptr

#if (_WIN32_WINNT = &h0501) or (_WIN32_WINNT = &h0502)
	type _EnumImageStoreDATAtag
		szPath as wstring * 260
		ftTimeStamp as FILETIME
	end type

	type ENUMSHELLIMAGESTOREDATA as _EnumImageStoreDATAtag
	type PENUMSHELLIMAGESTOREDATA as _EnumImageStoreDATAtag ptr
	type IEnumShellImageStoreVtbl as IEnumShellImageStoreVtbl_

	type IEnumShellImageStore field = 1
		lpVtbl as IEnumShellImageStoreVtbl ptr
	end type

	type IEnumShellImageStoreVtbl_ field = 1
		QueryInterface as function(byval This as IEnumShellImageStore ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		AddRef as function(byval This as IEnumShellImageStore ptr) as ULONG
		Release as function(byval This as IEnumShellImageStore ptr) as ULONG
		Reset as function(byval This as IEnumShellImageStore ptr) as HRESULT
		Next as function(byval This as IEnumShellImageStore ptr, byval celt as ULONG, byval prgElt as PENUMSHELLIMAGESTOREDATA ptr, byval pceltFetched as ULONG ptr) as HRESULT
		Skip as function(byval This as IEnumShellImageStore ptr, byval celt as ULONG) as HRESULT
		Clone as function(byval This as IEnumShellImageStore ptr, byval ppEnum as IEnumShellImageStore ptr ptr) as HRESULT
	end type

	type LPENUMSHELLIMAGESTORE as IEnumShellImageStore ptr
	const SHIMSTCAPFLAG_LOCKABLE = &h0001
	const SHIMSTCAPFLAG_PURGEABLE = &h0002
	type IShellImageStoreVtbl as IShellImageStoreVtbl_

	type IShellImageStore field = 1
		lpVtbl as IShellImageStoreVtbl ptr
	end type

	type IShellImageStoreVtbl_ field = 1
		QueryInterface as function(byval This as IShellImageStore ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		AddRef as function(byval This as IShellImageStore ptr) as ULONG
		Release as function(byval This as IShellImageStore ptr) as ULONG
		Open as function(byval This as IShellImageStore ptr, byval dwMode as DWORD, byval pdwLock as DWORD ptr) as HRESULT
		Create as function(byval This as IShellImageStore ptr, byval dwMode as DWORD, byval pdwLock as DWORD ptr) as HRESULT
		ReleaseLock as function(byval This as IShellImageStore ptr, byval pdwLock as const DWORD ptr) as HRESULT
		Close as function(byval This as IShellImageStore ptr, byval pdwLock as const DWORD ptr) as HRESULT
		Commit as function(byval This as IShellImageStore ptr, byval pdwLock as const DWORD ptr) as HRESULT
		IsLocked as function(byval This as IShellImageStore ptr) as HRESULT
		GetMode as function(byval This as IShellImageStore ptr, byval pdwMode as DWORD ptr) as HRESULT
		GetCapabilities as function(byval This as IShellImageStore ptr, byval pdwCapMask as DWORD ptr) as HRESULT
		AddEntry as function(byval This as IShellImageStore ptr, byval pszName as PCWSTR, byval pftTimeStamp as const FILETIME ptr, byval dwMode as DWORD, byval hImage as HBITMAP) as HRESULT
		GetEntry as function(byval This as IShellImageStore ptr, byval pszName as PCWSTR, byval dwMode as DWORD, byval phImage as HBITMAP ptr) as HRESULT
		DeleteEntry as function(byval This as IShellImageStore ptr, byval pszName as PCWSTR) as HRESULT
		IsEntryInStore as function(byval This as IShellImageStore ptr, byval pszName as PCWSTR, byval pftTimeStamp as FILETIME ptr) as HRESULT
		as function(byval This as IShellImageStore ptr, byval ppEnum as LPENUMSHELLIMAGESTORE ptr) as HRESULT Enum
	end type

	type LPSHELLIMAGESTORE as IShellImageStore ptr
#endif

const ISFB_MASK_STATE = &h00000001
const ISFB_MASK_BKCOLOR = &h00000002
const ISFB_MASK_VIEWMODE = &h00000004
const ISFB_MASK_SHELLFOLDER = &h00000008
const ISFB_MASK_IDLIST = &h00000010
const ISFB_MASK_COLORS = &h00000020
const ISFB_STATE_DEFAULT = &h00000000
const ISFB_STATE_DEBOSSED = &h00000001
const ISFB_STATE_ALLOWRENAME = &h00000002
const ISFB_STATE_NOSHOWTEXT = &h00000004
const ISFB_STATE_CHANNELBAR = &h00000010
const ISFB_STATE_QLINKSMODE = &h00000020
const ISFB_STATE_FULLOPEN = &h00000040
const ISFB_STATE_NONAMESORT = &h00000080
const ISFB_STATE_BTNMINSIZE = &h00000100
const ISFBVIEWMODE_SMALLICONS = &h0001
const ISFBVIEWMODE_LARGEICONS = &h0002

#if _WIN32_WINNT <= &h0502
	const ISFBVIEWMODE_LOGOS = &h0003
#endif

type BANDINFOSFB
	dwMask as DWORD
	dwStateMask as DWORD
	dwState as DWORD
	crBkgnd as COLORREF
	crBtnLt as COLORREF
	crBtnDk as COLORREF
	wViewMode as WORD
	wAlign as WORD
	psf as IShellFolder ptr
	pidl as LPITEMIDLIST
end type

type PBANDINFOSFB as BANDINFOSFB ptr
type IShellFolderBandVtbl as IShellFolderBandVtbl_

type IShellFolderBand field = 1
	lpVtbl as IShellFolderBandVtbl ptr
end type

type IShellFolderBandVtbl_ field = 1
	QueryInterface as function(byval This as IShellFolderBand ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellFolderBand ptr) as ULONG
	Release as function(byval This as IShellFolderBand ptr) as ULONG
	InitializeSFB as function(byval This as IShellFolderBand ptr, byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST) as HRESULT
	SetBandInfoSFB as function(byval This as IShellFolderBand ptr, byval pbi as PBANDINFOSFB) as HRESULT
	GetBandInfoSFB as function(byval This as IShellFolderBand ptr, byval pbi as PBANDINFOSFB) as HRESULT
end type

enum
	SFBID_PIDLCHANGED
end enum

type IDeskBarClientVtbl as IDeskBarClientVtbl_

type IDeskBarClient field = 1
	lpVtbl as IDeskBarClientVtbl ptr
end type

type IDeskBarClientVtbl_ field = 1
	QueryInterface as function(byval This as IDeskBarClient ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDeskBarClient ptr) as ULONG
	Release as function(byval This as IDeskBarClient ptr) as ULONG
	GetWindow as function(byval This as IDeskBarClient ptr, byval phwnd as HWND ptr) as HRESULT
	ContextSensitiveHelp as function(byval This as IDeskBarClient ptr, byval fEnterMode as WINBOOL) as HRESULT
	SetDeskBarSite as function(byval This as IDeskBarClient ptr, byval punkSite as IUnknown ptr) as HRESULT
	SetModeDBC as function(byval This as IDeskBarClient ptr, byval dwMode as DWORD) as HRESULT
	UIActivateDBC as function(byval This as IDeskBarClient ptr, byval dwState as DWORD) as HRESULT
	GetSize as function(byval This as IDeskBarClient ptr, byval dwWhich as DWORD, byval prc as LPRECT) as HRESULT
end type

const DBC_GS_IDEAL = 0
const DBC_GS_SIZEDOWN = 1
const DBC_HIDE = 0
const DBC_SHOW = 1
const DBC_SHOWOBSCURE = 2

enum
	DBCID_EMPTY = 0
	DBCID_ONDRAG = 1
	DBCID_CLSIDOFBAR = 2
	DBCID_RESIZE = 3
	DBCID_GETBAR = 4
end enum

const MAX_COLUMN_NAME_LEN = 80
const MAX_COLUMN_DESC_LEN = 128

type SHCOLUMNINFO field = 1
	scid as SHCOLUMNID
	vt as VARTYPE
	fmt as DWORD
	cChars as UINT
	csFlags as DWORD
	wszTitle as wstring * 80
	wszDescription as wstring * 128
end type

type LPSHCOLUMNINFO as SHCOLUMNINFO ptr
type LPCSHCOLUMNINFO as const SHCOLUMNINFO ptr

type SHCOLUMNINIT
	dwFlags as ULONG
	dwReserved as ULONG
	wszFolder as wstring * 260
end type

type LPSHCOLUMNINIT as SHCOLUMNINIT ptr
type LPCSHCOLUMNINIT as const SHCOLUMNINIT ptr
const SHCDF_UPDATEITEM = &h00000001

type SHCOLUMNDATA
	dwFlags as ULONG
	dwFileAttributes as DWORD
	dwReserved as ULONG
	pwszExt as wstring ptr
	wszFile as wstring * 260
end type

type LPSHCOLUMNDATA as SHCOLUMNDATA ptr
type LPCSHCOLUMNDATA as const SHCOLUMNDATA ptr
type IColumnProviderVtbl as IColumnProviderVtbl_

type IColumnProvider field = 1
	lpVtbl as IColumnProviderVtbl ptr
end type

type IColumnProviderVtbl_ field = 1
	QueryInterface as function(byval This as IColumnProvider ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IColumnProvider ptr) as ULONG
	Release as function(byval This as IColumnProvider ptr) as ULONG
	Initialize as function(byval This as IColumnProvider ptr, byval psci as LPCSHCOLUMNINIT) as HRESULT
	GetColumnInfo as function(byval This as IColumnProvider ptr, byval dwIndex as DWORD, byval psci as SHCOLUMNINFO ptr) as HRESULT
	GetItemData as function(byval This as IColumnProvider ptr, byval pscid as LPCSHCOLUMNID, byval pscd as LPCSHCOLUMNDATA, byval pvarData as VARIANT ptr) as HRESULT
end type

#define CFSTR_SHELLIDLIST __TEXT("Shell IDList Array")
#define CFSTR_SHELLIDLISTOFFSET __TEXT("Shell Object Offsets")
#define CFSTR_NETRESOURCES __TEXT("Net Resource")
#define CFSTR_FILEDESCRIPTORA __TEXT("FileGroupDescriptor")
#define CFSTR_FILEDESCRIPTORW __TEXT("FileGroupDescriptorW")
#define CFSTR_FILECONTENTS __TEXT("FileContents")
#define CFSTR_FILENAMEA __TEXT("FileName")
#define CFSTR_FILENAMEW __TEXT("FileNameW")
#define CFSTR_PRINTERGROUP __TEXT("PrinterFriendlyName")
#define CFSTR_FILENAMEMAPA __TEXT("FileNameMap")
#define CFSTR_FILENAMEMAPW __TEXT("FileNameMapW")
#define CFSTR_SHELLURL __TEXT("UniformResourceLocator")
#define CFSTR_INETURLA CFSTR_SHELLURL
#define CFSTR_INETURLW __TEXT("UniformResourceLocatorW")
#define CFSTR_PREFERREDDROPEFFECT __TEXT("Preferred DropEffect")
#define CFSTR_PERFORMEDDROPEFFECT __TEXT("Performed DropEffect")
#define CFSTR_PASTESUCCEEDED __TEXT("Paste Succeeded")
#define CFSTR_INDRAGLOOP __TEXT("InShellDragLoop")
#define CFSTR_MOUNTEDVOLUME __TEXT("MountedVolume")
#define CFSTR_PERSISTEDDATAOBJECT __TEXT("PersistedDataObject")
#define CFSTR_TARGETCLSID __TEXT("TargetCLSID")
#define CFSTR_LOGICALPERFORMEDDROPEFFECT __TEXT("Logical Performed DropEffect")
#define CFSTR_AUTOPLAY_SHELLIDLISTS __TEXT("Autoplay Enumerated IDList Array")
#define CFSTR_UNTRUSTEDDRAGDROP __TEXT("UntrustedDragDrop")
#define CFSTR_FILE_ATTRIBUTES_ARRAY __TEXT("File Attributes Array")
#define CFSTR_INVOKECOMMAND_DROPPARAM __TEXT("InvokeCommand DropParam")
#define CFSTR_SHELLDROPHANDLER __TEXT("DropHandlerCLSID")
#define CFSTR_DROPDESCRIPTION __TEXT("DropDescription")
#define CFSTR_ZONEIDENTIFIER __TEXT("ZoneIdentifier")

#ifdef UNICODE
	#define CFSTR_FILEDESCRIPTOR CFSTR_FILEDESCRIPTORW
	#define CFSTR_FILENAME CFSTR_FILENAMEW
	#define CFSTR_FILENAMEMAP CFSTR_FILENAMEMAPW
	#define CFSTR_INETURL CFSTR_INETURLW
#else
	#define CFSTR_FILEDESCRIPTOR CFSTR_FILEDESCRIPTORA
	#define CFSTR_FILENAME CFSTR_FILENAMEA
	#define CFSTR_FILENAMEMAP CFSTR_FILENAMEMAPA
	#define CFSTR_INETURL CFSTR_INETURLA
#endif

const DVASPECT_SHORTNAME = 2
const DVASPECT_COPY = 3
const DVASPECT_LINK = 4

type _NRESARRAY
	cItems as UINT
	nr(0 to 0) as NETRESOURCE
end type

type NRESARRAY as _NRESARRAY
type LPNRESARRAY as _NRESARRAY ptr

type _IDA field = 1
	cidl as UINT
	aoffset(0 to 0) as UINT
end type

type CIDA as _IDA
type LPIDA as _IDA ptr

type FD_FLAGS as long
enum
	FD_CLSID = &h1
	FD_SIZEPOINT = &h2
	FD_ATTRIBUTES = &h4
	FD_CREATETIME = &h8
	FD_ACCESSTIME = &h10
	FD_WRITESTIME = &h20
	FD_FILESIZE = &h40
	FD_PROGRESSUI = &h4000
	FD_LINKUI = &h8000

	#if _WIN32_WINNT >= &h0600
		FD_UNICODE = clng(&h80000000)
	#endif
end enum

type _FILEDESCRIPTORA field = 1
	dwFlags as DWORD
	clsid as CLSID
	sizel as SIZEL
	pointl as POINTL
	dwFileAttributes as DWORD
	ftCreationTime as FILETIME
	ftLastAccessTime as FILETIME
	ftLastWriteTime as FILETIME
	nFileSizeHigh as DWORD
	nFileSizeLow as DWORD
	cFileName as zstring * 260
end type

type FILEDESCRIPTORA as _FILEDESCRIPTORA
type LPFILEDESCRIPTORA as _FILEDESCRIPTORA ptr

type _FILEDESCRIPTORW field = 1
	dwFlags as DWORD
	clsid as CLSID
	sizel as SIZEL
	pointl as POINTL
	dwFileAttributes as DWORD
	ftCreationTime as FILETIME
	ftLastAccessTime as FILETIME
	ftLastWriteTime as FILETIME
	nFileSizeHigh as DWORD
	nFileSizeLow as DWORD
	cFileName as wstring * 260
end type

type FILEDESCRIPTORW as _FILEDESCRIPTORW
type LPFILEDESCRIPTORW as _FILEDESCRIPTORW ptr

#ifdef UNICODE
	type FILEDESCRIPTOR as FILEDESCRIPTORW
	type LPFILEDESCRIPTOR as LPFILEDESCRIPTORW
#else
	type FILEDESCRIPTOR as FILEDESCRIPTORA
	type LPFILEDESCRIPTOR as LPFILEDESCRIPTORA
#endif

type _FILEGROUPDESCRIPTORA field = 1
	cItems as UINT
	fgd(0 to 0) as FILEDESCRIPTORA
end type

type FILEGROUPDESCRIPTORA as _FILEGROUPDESCRIPTORA
type LPFILEGROUPDESCRIPTORA as _FILEGROUPDESCRIPTORA ptr

type _FILEGROUPDESCRIPTORW field = 1
	cItems as UINT
	fgd(0 to 0) as FILEDESCRIPTORW
end type

type FILEGROUPDESCRIPTORW as _FILEGROUPDESCRIPTORW
type LPFILEGROUPDESCRIPTORW as _FILEGROUPDESCRIPTORW ptr

#ifdef UNICODE
	type FILEGROUPDESCRIPTOR as FILEGROUPDESCRIPTORW
	type LPFILEGROUPDESCRIPTOR as LPFILEGROUPDESCRIPTORW
#else
	type FILEGROUPDESCRIPTOR as FILEGROUPDESCRIPTORA
	type LPFILEGROUPDESCRIPTOR as LPFILEGROUPDESCRIPTORA
#endif

type _DROPFILES field = 1
	pFiles as DWORD
	pt as POINT
	fNC as WINBOOL
	fWide as WINBOOL
end type

type DROPFILES as _DROPFILES
type LPDROPFILES as _DROPFILES ptr

#if _WIN32_WINNT >= &h0600
	type FILE_ATTRIBUTES_ARRAY field = 1
		cItems as UINT
		dwSumFileAttributes as DWORD
		dwProductFileAttributes as DWORD
		rgdwFileAttributes(0 to 0) as DWORD
	end type

	type DROPIMAGETYPE as long
	enum
		DROPIMAGE_INVALID = -1
		DROPIMAGE_NONE = 0
		DROPIMAGE_COPY = 1
		DROPIMAGE_MOVE = 2
		DROPIMAGE_LINK = 4
		DROPIMAGE_LABEL = 6
		DROPIMAGE_WARNING = 7
		DROPIMAGE_NOIMAGE = 8
	end enum

	type DROPDESCRIPTION field = 1
		as DROPIMAGETYPE type
		szMessage as wstring * 260
		szInsert as wstring * 260
	end type
#endif

type _SHChangeNotifyEntry field = 1
	pidl as LPCITEMIDLIST
	fRecursive as WINBOOL
end type

type SHChangeNotifyEntry as _SHChangeNotifyEntry
const SHCNRF_InterruptLevel = &h0001
const SHCNRF_ShellLevel = &h0002
const SHCNRF_RecursiveInterrupt = &h1000
const SHCNRF_NewDelivery = &h8000
const SHCNE_RENAMEITEM = &h00000001
const SHCNE_CREATE = &h00000002
const SHCNE_DELETE = &h00000004
const SHCNE_MKDIR = &h00000008
const SHCNE_RMDIR = &h00000010
const SHCNE_MEDIAINSERTED = &h00000020
const SHCNE_MEDIAREMOVED = &h00000040
const SHCNE_DRIVEREMOVED = &h00000080
const SHCNE_DRIVEADD = &h00000100
const SHCNE_NETSHARE = &h00000200
const SHCNE_NETUNSHARE = &h00000400
const SHCNE_ATTRIBUTES = &h00000800
const SHCNE_UPDATEDIR = &h00001000
const SHCNE_UPDATEITEM = &h00002000
const SHCNE_SERVERDISCONNECT = &h00004000
const SHCNE_UPDATEIMAGE = &h00008000
const SHCNE_DRIVEADDGUI = &h00010000
const SHCNE_RENAMEFOLDER = &h00020000
const SHCNE_FREESPACE = &h00040000
const SHCNE_EXTENDED_EVENT = &h04000000
const SHCNE_ASSOCCHANGED = &h08000000
const SHCNE_DISKEVENTS = &h0002381f
const SHCNE_GLOBALEVENTS = &h0c0581e0
const SHCNE_ALLEVENTS = &h7fffffff
const SHCNE_INTERRUPT = &h80000000
const SHCNEE_ORDERCHANGED = 2
const SHCNEE_MSI_CHANGE = 4
const SHCNEE_MSI_UNINSTALL = 5
const SHCNF_IDLIST = &h0000
const SHCNF_PATHA = &h0001
const SHCNF_PRINTERA = &h0002
const SHCNF_DWORD = &h0003
const SHCNF_PATHW = &h0005
const SHCNF_PRINTERW = &h0006
const SHCNF_TYPE = &h00ff
const SHCNF_FLUSH = &h1000
const SHCNF_FLUSHNOWAIT = &h3000
const SHCNF_NOTIFYRECURSIVE = &h10000

#ifdef UNICODE
	const SHCNF_PATH = SHCNF_PATHW
	const SHCNF_PRINTER = SHCNF_PRINTERW
#else
	const SHCNF_PATH = SHCNF_PATHA
	const SHCNF_PRINTER = SHCNF_PRINTERA
#endif

declare sub SHChangeNotify(byval wEventId as LONG, byval uFlags as UINT, byval dwItem1 as LPCVOID, byval dwItem2 as LPCVOID)
type IShellChangeNotifyVtbl as IShellChangeNotifyVtbl_

type IShellChangeNotify field = 1
	lpVtbl as IShellChangeNotifyVtbl ptr
end type

type IShellChangeNotifyVtbl_ field = 1
	QueryInterface as function(byval This as IShellChangeNotify ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellChangeNotify ptr) as ULONG
	Release as function(byval This as IShellChangeNotify ptr) as ULONG
	OnChange as function(byval This as IShellChangeNotify ptr, byval lEvent as LONG, byval pidl1 as LPCITEMIDLIST, byval pidl2 as LPCITEMIDLIST) as HRESULT
end type

type IQueryInfoVtbl as IQueryInfoVtbl_

type IQueryInfo field = 1
	lpVtbl as IQueryInfoVtbl ptr
end type

type IQueryInfoVtbl_ field = 1
	QueryInterface as function(byval This as IQueryInfo ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IQueryInfo ptr) as ULONG
	Release as function(byval This as IQueryInfo ptr) as ULONG
	GetInfoTip as function(byval This as IQueryInfo ptr, byval dwFlags as DWORD, byval ppwszTip as PWSTR ptr) as HRESULT
	GetInfoFlags as function(byval This as IQueryInfo ptr, byval pdwFlags as DWORD ptr) as HRESULT
end type

const QITIPF_DEFAULT = &h00000000
const QITIPF_USENAME = &h00000001
const QITIPF_LINKNOTARGET = &h00000002
const QITIPF_LINKUSETARGET = &h00000004
const QITIPF_USESLOWTIP = &h00000008

#if _WIN32_WINNT >= &h0600
	const QITIPF_SINGLELINE = &h00000010
#endif

const QIF_CACHED = &h00000001
const QIF_DONTEXPANDFOLDER = &h00000002

type SHARD as long
enum
	SHARD_PIDL = &h00000001
	SHARD_PATHA = &h00000002
	SHARD_PATHW = &h00000003

	#if _WIN32_WINNT >= &h0601
		SHARD_APPIDINFO = &h00000004
		SHARD_APPIDINFOIDLIST = &h00000005
		SHARD_LINK = &h00000006
		SHARD_APPIDINFOLINK = &h00000007
		SHARD_SHELLITEM = &h00000008
	#endif
end enum

#if _WIN32_WINNT >= &h0601
	type SHARDAPPIDINFO field = 1
		psi as IShellItem ptr
		pszAppID as PCWSTR
	end type

	type SHARDAPPIDINFOIDLIST field = 1
		pidl as LPCITEMIDLIST
		pszAppID as PCWSTR
	end type

	type SHARDAPPIDINFOLINK field = 1
		#if defined(UNICODE) and (_WIN32_WINNT >= &h0601)
			psl as IShellLinkW ptr
		#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0601)
			psl as IShellLinkA ptr
		#endif

		pszAppID as PCWSTR
	end type
#endif

#ifdef UNICODE
	const SHARD_PATH = SHARD_PATHW
#else
	const SHARD_PATH = SHARD_PATHA
#endif

declare sub SHAddToRecentDocs(byval uFlags as UINT, byval pv as LPCVOID)

type _SHChangeDWORDAsIDList field = 1
	cb as USHORT
	dwItem1 as DWORD
	dwItem2 as DWORD
	cbZero as USHORT
end type

type SHChangeDWORDAsIDList as _SHChangeDWORDAsIDList
type LPSHChangeDWORDAsIDList as _SHChangeDWORDAsIDList ptr

type _SHChangeUpdateImageIDList field = 1
	cb as USHORT
	iIconIndex as long
	iCurIndex as long
	uFlags as UINT
	dwProcessID as DWORD
	szName as wstring * 260
	cbZero as USHORT
end type

type SHChangeUpdateImageIDList as _SHChangeUpdateImageIDList
type LPSHChangeUpdateImageIDList as _SHChangeUpdateImageIDList ptr
declare function SHHandleUpdateImage(byval pidlExtra as LPCITEMIDLIST) as long

type _SHChangeProductKeyAsIDList field = 1
	cb as USHORT
	wszProductKey as wstring * 39
	cbZero as USHORT
end type

type SHChangeProductKeyAsIDList as _SHChangeProductKeyAsIDList
type LPSHChangeProductKeyAsIDList as _SHChangeProductKeyAsIDList ptr
declare sub SHUpdateImageA(byval pszHashItem as LPCSTR, byval iIndex as long, byval uFlags as UINT, byval iImageIndex as long)
declare sub SHUpdateImageW(byval pszHashItem as LPCWSTR, byval iIndex as long, byval uFlags as UINT, byval iImageIndex as long)

#ifdef UNICODE
	declare sub SHUpdateImage alias "SHUpdateImageW"(byval pszHashItem as LPCWSTR, byval iIndex as long, byval uFlags as UINT, byval iImageIndex as long)
#else
	declare sub SHUpdateImage alias "SHUpdateImageA"(byval pszHashItem as LPCSTR, byval iIndex as long, byval uFlags as UINT, byval iImageIndex as long)
#endif

declare function SHChangeNotifyRegister(byval hwnd as HWND, byval fSources as long, byval fEvents as LONG, byval wMsg as UINT, byval cEntries as long, byval pshcne as const SHChangeNotifyEntry ptr) as ULONG
declare function SHChangeNotifyDeregister(byval ulID as ULONG) as WINBOOL

type SCNRT_STATUS as long
enum
	SCNRT_ENABLE = 0
	SCNRT_DISABLE = 1
end enum

#if _WIN32_WINNT >= &h0600
	declare sub SHChangeNotifyRegisterThread(byval status as SCNRT_STATUS)
#endif

declare function SHChangeNotification_Lock(byval hChange as HANDLE, byval dwProcId as DWORD, byval pppidl as LPITEMIDLIST ptr ptr, byval plEvent as LONG ptr) as HANDLE
declare function SHChangeNotification_Unlock(byval hLock as HANDLE) as WINBOOL
declare function SHGetRealIDL(byval psf as IShellFolder ptr, byval pidlSimple as LPCITEMIDLIST, byval ppidlReal as LPITEMIDLIST ptr) as HRESULT
declare function SHGetInstanceExplorer(byval ppunk as IUnknown ptr ptr) as HRESULT

const SHGDFIL_FINDDATA = 1
const SHGDFIL_NETRESOURCE = 2
const SHGDFIL_DESCRIPTIONID = 3
const SHDID_ROOT_REGITEM = 1
const SHDID_FS_FILE = 2
const SHDID_FS_DIRECTORY = 3
const SHDID_FS_OTHER = 4
const SHDID_COMPUTER_DRIVE35 = 5
const SHDID_COMPUTER_DRIVE525 = 6
const SHDID_COMPUTER_REMOVABLE = 7
const SHDID_COMPUTER_FIXED = 8
const SHDID_COMPUTER_NETDRIVE = 9
const SHDID_COMPUTER_CDROM = 10
const SHDID_COMPUTER_RAMDISK = 11
const SHDID_COMPUTER_OTHER = 12
const SHDID_NET_DOMAIN = 13
const SHDID_NET_SERVER = 14
const SHDID_NET_SHARE = 15
const SHDID_NET_RESTOFNET = 16
const SHDID_NET_OTHER = 17
const SHDID_COMPUTER_IMAGING = 18
const SHDID_COMPUTER_AUDIO = 19
const SHDID_COMPUTER_SHAREDDOCS = 20

#if _WIN32_WINNT >= &h0600
	const SHDID_MOBILE_DEVICE = 21
#endif

type _SHDESCRIPTIONID
	dwDescriptionId as DWORD
	clsid as CLSID
end type

type SHDESCRIPTIONID as _SHDESCRIPTIONID
type LPSHDESCRIPTIONID as _SHDESCRIPTIONID ptr
declare function SHGetDataFromIDListA(byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval nFormat as long, byval pv as any ptr, byval cb as long) as HRESULT
declare function SHGetDataFromIDListW(byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval nFormat as long, byval pv as any ptr, byval cb as long) as HRESULT

#ifdef UNICODE
	declare function SHGetDataFromIDList alias "SHGetDataFromIDListW"(byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval nFormat as long, byval pv as any ptr, byval cb as long) as HRESULT
#else
	declare function SHGetDataFromIDList alias "SHGetDataFromIDListA"(byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval nFormat as long, byval pv as any ptr, byval cb as long) as HRESULT
#endif

const PRF_VERIFYEXISTS = &h1
const PRF_TRYPROGRAMEXTENSIONS = &h2 or PRF_VERIFYEXISTS
const PRF_FIRSTDIRDEF = &h4
const PRF_DONTFINDLNK = &h8
const PRF_REQUIREABSOLUTE = &h10

declare function RestartDialog(byval hwnd as HWND, byval pszPrompt as PCWSTR, byval dwReturn as DWORD) as long
declare function RestartDialogEx(byval hwnd as HWND, byval pszPrompt as PCWSTR, byval dwReturn as DWORD, byval dwReasonCode as DWORD) as long
declare function SHCoCreateInstance(byval pszCLSID as PCWSTR, byval pclsid as const CLSID ptr, byval pUnkOuter as IUnknown ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT

#if _WIN32_WINNT >= &h0600
	declare function SHCreateDataObject(byval pidlFolder as LPCITEMIDLIST, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval pdtInner as IDataObject ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
#endif

declare function CIDLData_CreateFromIDArray(byval pidlFolder as LPCITEMIDLIST, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval ppdtobj as IDataObject ptr ptr) as HRESULT
declare function SHCreateStdEnumFmtEtc(byval cfmt as UINT, byval afmt as const FORMATETC ptr, byval ppenumFormatEtc as IEnumFORMATETC ptr ptr) as HRESULT
declare function SHDoDragDrop(byval hwnd as HWND, byval pdata as IDataObject ptr, byval pdsrc as IDropSource ptr, byval dwEffect as DWORD, byval pdwEffect as DWORD ptr) as HRESULT
const NUM_POINTS = 3

type AUTO_SCROLL_DATA field = 1
	iNextSample as long
	dwLastScroll as DWORD
	bFull as WINBOOL
	pts(0 to 2) as POINT
	dwTimes(0 to 2) as DWORD
end type

declare function DAD_SetDragImage(byval him as HIMAGELIST, byval pptOffset as POINT ptr) as WINBOOL
declare function DAD_DragEnterEx(byval hwndTarget as HWND, byval ptStart as const POINT) as WINBOOL
declare function DAD_DragEnterEx2(byval hwndTarget as HWND, byval ptStart as const POINT, byval pdtObject as IDataObject ptr) as WINBOOL
declare function DAD_ShowDragImage(byval fShow as WINBOOL) as WINBOOL
declare function DAD_DragMove(byval pt as POINT) as WINBOOL
declare function DAD_DragLeave() as WINBOOL
declare function DAD_AutoScroll(byval hwnd as HWND, byval pad as AUTO_SCROLL_DATA ptr, byval pptNow as const POINT ptr) as WINBOOL

type CABINETSTATE field = 1
	cLength as WORD
	nVersion as WORD
	fFullPathTitle : 1 as WINBOOL
	fSaveLocalView : 1 as WINBOOL
	fNotShell : 1 as WINBOOL
	fSimpleDefault : 1 as WINBOOL
	fDontShowDescBar : 1 as WINBOOL
	fNewWindowMode : 1 as WINBOOL
	fShowCompColor : 1 as WINBOOL
	fDontPrettyNames : 1 as WINBOOL
	fAdminsCreateCommonGroups : 1 as WINBOOL
	fUnusedFlags : 7 as UINT
	fMenuEnumFilter as UINT
end type

type LPCABINETSTATE as CABINETSTATE ptr
const CABINETSTATE_VERSION = 2
declare function ReadCabinetState(byval pcs as CABINETSTATE ptr, byval cLength as long) as WINBOOL
declare function WriteCabinetState(byval pcs as CABINETSTATE ptr) as WINBOOL
declare function PathMakeUniqueName(byval pszUniqueName as PWSTR, byval cchMax as UINT, byval pszTemplate as PCWSTR, byval pszLongPlate as PCWSTR, byval pszDir as PCWSTR) as WINBOOL
declare sub PathQualify(byval psz as PWSTR)
declare function PathIsExe(byval pszPath as PCWSTR) as WINBOOL
declare function PathIsSlowA(byval pszFile as LPCSTR, byval dwAttr as DWORD) as WINBOOL
declare function PathIsSlowW(byval pszFile as LPCWSTR, byval dwAttr as DWORD) as WINBOOL

#ifdef UNICODE
	declare function PathIsSlow alias "PathIsSlowW"(byval pszFile as LPCWSTR, byval dwAttr as DWORD) as WINBOOL
#else
	declare function PathIsSlow alias "PathIsSlowA"(byval pszFile as LPCSTR, byval dwAttr as DWORD) as WINBOOL
#endif

const PCS_FATAL = &h80000000
const PCS_REPLACEDCHAR = &h00000001
const PCS_REMOVEDCHAR = &h00000002
const PCS_TRUNCATED = &h00000004
const PCS_PATHTOOLONG = &h00000008

declare function PathCleanupSpec(byval pszDir as PCWSTR, byval pszSpec as PWSTR) as long
declare function PathResolve(byval pszPath as PWSTR, byval dirs as PZPCWSTR, byval fFlags as UINT) as long
declare function GetFileNameFromBrowse(byval hwnd as HWND, byval pszFilePath as PWSTR, byval cchFilePath as UINT, byval pszWorkingDir as PCWSTR, byval pszDefExt as PCWSTR, byval pszFilters as PCWSTR, byval pszTitle as PCWSTR) as WINBOOL
declare function DriveType(byval iDrive as long) as long
declare function RealDriveType(byval iDrive as long, byval fOKToHitNet as WINBOOL) as long
declare function IsNetDrive(byval iDrive as long) as long

const MM_ADDSEPARATOR = &h00000001
const MM_SUBMENUSHAVEIDS = &h00000002
const MM_DONTREMOVESEPS = &h00000004
declare function Shell_MergeMenus(byval hmDst as HMENU, byval hmSrc as HMENU, byval uInsert as UINT, byval uIDAdjust as UINT, byval uIDAdjustMax as UINT, byval uFlags as ULONG) as UINT
declare function SHObjectProperties(byval hwnd as HWND, byval shopObjectType as DWORD, byval pszObjectName as PCWSTR, byval pszPropertyPage as PCWSTR) as WINBOOL
const SHOP_PRINTERNAME = &h00000001
const SHOP_FILEPATH = &h00000002
const SHOP_VOLUMEGUID = &h00000004
declare function SHFormatDrive(byval hwnd as HWND, byval drive as UINT, byval fmtID as UINT, byval options as UINT) as DWORD
const SHFMT_ID_DEFAULT = &hffff
const SHFMT_OPT_FULL = &h0001
const SHFMT_OPT_SYSONLY = &h0002
const SHFMT_ERROR = &hffffffff
const SHFMT_CANCEL = &hfffffffe
const SHFMT_NOFORMAT = &hfffffffd
#define HPSXA_DEFINED

type HPSXA__ field = 1
	unused as long
end type

type HPSXA as HPSXA__ ptr
declare function SHCreatePropSheetExtArray(byval hKey as HKEY, byval pszSubKey as PCWSTR, byval max_iface as UINT) as HPSXA
declare sub SHDestroyPropSheetExtArray(byval hpsxa as HPSXA)
declare function SHAddFromPropSheetExtArray(byval hpsxa as HPSXA, byval lpfnAddPage as LPFNADDPROPSHEETPAGE, byval lParam as LPARAM) as UINT
declare function SHReplaceFromPropSheetExtArray(byval hpsxa as HPSXA, byval uPageID as UINT, byval lpfnReplaceWith as LPFNADDPROPSHEETPAGE, byval lParam as LPARAM) as UINT

#if (_WIN32_WINNT = &h0501) or (_WIN32_WINNT = &h0502)
	type IDefViewFrameVtbl as IDefViewFrameVtbl_

	type IDefViewFrame field = 1
		lpVtbl as IDefViewFrameVtbl ptr
	end type

	type IDefViewFrameVtbl_ field = 1
		QueryInterface as function(byval This as IDefViewFrame ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
		AddRef as function(byval This as IDefViewFrame ptr) as ULONG
		Release as function(byval This as IDefViewFrame ptr) as ULONG
		GetWindowLV as function(byval This as IDefViewFrame ptr, byval phwnd as HWND ptr) as HRESULT
		ReleaseWindowLV as function(byval This as IDefViewFrame ptr) as HRESULT
		GetShellFolder as function(byval This as IDefViewFrame ptr, byval ppsf as IShellFolder ptr ptr) as HRESULT
	end type
#endif

type RESTRICTIONS as long
enum
	REST_NONE = &h00000000
	REST_NORUN = &h00000001
	REST_NOCLOSE = &h00000002
	REST_NOSAVESET = &h00000004
	REST_NOFILEMENU = &h00000008
	REST_NOSETFOLDERS = &h00000010
	REST_NOSETTASKBAR = &h00000020
	REST_NODESKTOP = &h00000040
	REST_NOFIND = &h00000080
	REST_NODRIVES = &h00000100
	REST_NODRIVEAUTORUN = &h00000200
	REST_NODRIVETYPEAUTORUN = &h00000400
	REST_NONETHOOD = &h00000800
	REST_STARTBANNER = &h00001000
	REST_RESTRICTRUN = &h00002000
	REST_NOPRINTERTABS = &h00004000
	REST_NOPRINTERDELETE = &h00008000
	REST_NOPRINTERADD = &h00010000
	REST_NOSTARTMENUSUBFOLDERS = &h00020000
	REST_MYDOCSONNET = &h00040000
	REST_NOEXITTODOS = &h00080000
	REST_ENFORCESHELLEXTSECURITY = &h00100000
	REST_LINKRESOLVEIGNORELINKINFO = &h00200000
	REST_NOCOMMONGROUPS = &h00400000
	REST_SEPARATEDESKTOPPROCESS = &h00800000
	REST_NOWEB = &h01000000
	REST_NOTRAYCONTEXTMENU = &h02000000
	REST_NOVIEWCONTEXTMENU = &h04000000
	REST_NONETCONNECTDISCONNECT = &h08000000
	REST_STARTMENULOGOFF = &h10000000
	REST_NOSETTINGSASSIST = &h20000000
	REST_NOINTERNETICON = &h40000001
	REST_NORECENTDOCSHISTORY = &h40000002
	REST_NORECENTDOCSMENU = &h40000003
	REST_NOACTIVEDESKTOP = &h40000004
	REST_NOACTIVEDESKTOPCHANGES = &h40000005
	REST_NOFAVORITESMENU = &h40000006
	REST_CLEARRECENTDOCSONEXIT = &h40000007
	REST_CLASSICSHELL = &h40000008
	REST_NOCUSTOMIZEWEBVIEW = &h40000009
	REST_NOHTMLWALLPAPER = &h40000010
	REST_NOCHANGINGWALLPAPER = &h40000011
	REST_NODESKCOMP = &h40000012
	REST_NOADDDESKCOMP = &h40000013
	REST_NODELDESKCOMP = &h40000014
	REST_NOCLOSEDESKCOMP = &h40000015
	REST_NOCLOSE_DRAGDROPBAND = &h40000016
	REST_NOMOVINGBAND = &h40000017
	REST_NOEDITDESKCOMP = &h40000018
	REST_NORESOLVESEARCH = &h40000019
	REST_NORESOLVETRACK = &h4000001a
	REST_FORCECOPYACLWITHFILE = &h4000001b

	#if _WIN32_WINNT <= &h0502
		REST_NOLOGO3CHANNELNOTIFY = &h4000001c
	#endif

	REST_NOFORGETSOFTWAREUPDATE = &h4000001d
	REST_NOSETACTIVEDESKTOP = &h4000001e
	REST_NOUPDATEWINDOWS = &h4000001f
	REST_NOCHANGESTARMENU = &h40000020
	REST_NOFOLDEROPTIONS = &h40000021
	REST_HASFINDCOMPUTERS = &h40000022
	REST_INTELLIMENUS = &h40000023
	REST_RUNDLGMEMCHECKBOX = &h40000024
	REST_ARP_ShowPostSetup = &h40000025
	REST_NOCSC = &h40000026
	REST_NOCONTROLPANEL = &h40000027
	REST_ENUMWORKGROUP = &h40000028
	REST_ARP_NOARP = &h40000029
	REST_ARP_NOREMOVEPAGE = &h4000002a
	REST_ARP_NOADDPAGE = &h4000002b
	REST_ARP_NOWINSETUPPAGE = &h4000002c
	REST_GREYMSIADS = &h4000002d
	REST_NOCHANGEMAPPEDDRIVELABEL = &h4000002e
	REST_NOCHANGEMAPPEDDRIVECOMMENT = &h4000002f
	REST_MaxRecentDocs = &h40000030
	REST_NONETWORKCONNECTIONS = &h40000031
	REST_FORCESTARTMENULOGOFF = &h40000032
	REST_NOWEBVIEW = &h40000033
	REST_NOCUSTOMIZETHISFOLDER = &h40000034
	REST_NOENCRYPTION = &h40000035
	REST_DONTSHOWSUPERHIDDEN = &h40000037
	REST_NOSHELLSEARCHBUTTON = &h40000038
	REST_NOHARDWARETAB = &h40000039
	REST_NORUNASINSTALLPROMPT = &h4000003a
	REST_PROMPTRUNASINSTALLNETPATH = &h4000003b
	REST_NOMANAGEMYCOMPUTERVERB = &h4000003c
	REST_DISALLOWRUN = &h4000003e
	REST_NOWELCOMESCREEN = &h4000003f
	REST_RESTRICTCPL = &h40000040
	REST_DISALLOWCPL = &h40000041
	REST_NOSMBALLOONTIP = &h40000042
	REST_NOSMHELP = &h40000043
	REST_NOWINKEYS = &h40000044
	REST_NOENCRYPTONMOVE = &h40000045
	REST_NOLOCALMACHINERUN = &h40000046
	REST_NOCURRENTUSERRUN = &h40000047
	REST_NOLOCALMACHINERUNONCE = &h40000048
	REST_NOCURRENTUSERRUNONCE = &h40000049
	REST_FORCEACTIVEDESKTOPON = &h4000004a
	REST_NOVIEWONDRIVE = &h4000004c
	REST_NONETCRAWL = &h4000004d
	REST_NOSHAREDDOCUMENTS = &h4000004e
	REST_NOSMMYDOCS = &h4000004f
	REST_NOSMMYPICS = &h40000050
	REST_ALLOWBITBUCKDRIVES = &h40000051
	REST_NONLEGACYSHELLMODE = &h40000052
	REST_NOCONTROLPANELBARRICADE = &h40000053
	REST_NOSTARTPAGE = &h40000054
	REST_NOAUTOTRAYNOTIFY = &h40000055
	REST_NOTASKGROUPING = &h40000056
	REST_NOCDBURNING = &h40000057
	REST_MYCOMPNOPROP = &h40000058
	REST_MYDOCSNOPROP = &h40000059
	REST_NOSTARTPANEL = &h4000005a
	REST_NODISPLAYAPPEARANCEPAGE = &h4000005b
	REST_NOTHEMESTAB = &h4000005c
	REST_NOVISUALSTYLECHOICE = &h4000005d
	REST_NOSIZECHOICE = &h4000005e
	REST_NOCOLORCHOICE = &h4000005f
	REST_SETVISUALSTYLE = &h40000060
	REST_STARTRUNNOHOMEPATH = &h40000061
	REST_NOUSERNAMEINSTARTPANEL = &h40000062
	REST_NOMYCOMPUTERICON = &h40000063
	REST_NOSMNETWORKPLACES = &h40000064
	REST_NOSMPINNEDLIST = &h40000065
	REST_NOSMMYMUSIC = &h40000066
	REST_NOSMEJECTPC = &h40000067
	REST_NOSMMOREPROGRAMS = &h40000068
	REST_NOSMMFUPROGRAMS = &h40000069
	REST_NOTRAYITEMSDISPLAY = &h4000006a
	REST_NOTOOLBARSONTASKBAR = &h4000006b
	REST_NOSMCONFIGUREPROGRAMS = &h4000006f
	REST_HIDECLOCK = &h40000070
	REST_NOLOWDISKSPACECHECKS = &h40000071
	REST_NOENTIRENETWORK = &h40000072
	REST_NODESKTOPCLEANUP = &h40000073
	REST_BITBUCKNUKEONDELETE = &h40000074
	REST_BITBUCKCONFIRMDELETE = &h40000075
	REST_BITBUCKNOPROP = &h40000076
	REST_NODISPBACKGROUND = &h40000077
	REST_NODISPSCREENSAVEPG = &h40000078
	REST_NODISPSETTINGSPG = &h40000079
	REST_NODISPSCREENSAVEPREVIEW = &h4000007a
	REST_NODISPLAYCPL = &h4000007b
	REST_HIDERUNASVERB = &h4000007c
	REST_NOTHUMBNAILCACHE = &h4000007d
	REST_NOSTRCMPLOGICAL = &h4000007e
	REST_NOPUBLISHWIZARD = &h4000007f
	REST_NOONLINEPRINTSWIZARD = &h40000080
	REST_NOWEBSERVICES = &h40000081
	REST_ALLOWUNHASHEDWEBVIEW = &h40000082
	REST_ALLOWLEGACYWEBVIEW = &h40000083
	REST_REVERTWEBVIEWSECURITY = &h40000084
	REST_INHERITCONSOLEHANDLES = &h40000086

	#if _WIN32_WINNT <= &h0502
		REST_SORTMAXITEMCOUNT = &h40000087
	#endif

	REST_NOREMOTERECURSIVEEVENTS = &h40000089
	REST_NOREMOTECHANGENOTIFY = &h40000091

	#if _WIN32_WINNT <= &h0502
		REST_NOSIMPLENETIDLIST = &h40000092
	#endif

	REST_NOENUMENTIRENETWORK = &h40000093

	#if _WIN32_WINNT <= &h0502
		REST_NODETAILSTHUMBNAILONNETWORK = &h40000094
	#endif

	REST_NOINTERNETOPENWITH = &h40000095
	REST_DONTRETRYBADNETNAME = &h4000009b
	REST_ALLOWFILECLSIDJUNCTIONS = &h4000009c
	REST_NOUPNPINSTALL = &h4000009d
	REST_ARP_DONTGROUPPATCHES = &h400000ac
	REST_ARP_NOCHOOSEPROGRAMSPAGE = &h400000ad
	REST_NODISCONNECT = &h41000001
	REST_NOSECURITY = &h41000002
	REST_NOFILEASSOCIATE = &h41000003
	REST_ALLOWCOMMENTTOGGLE = &h41000004

	#if _WIN32_WINNT <= &h0502
		REST_USEDESKTOPINICACHE = &h41000005
	#endif
end enum

declare function OpenRegStream(byval hkey as HKEY, byval pszSubkey as PCWSTR, byval pszValue as PCWSTR, byval grfMode as DWORD) as IStream ptr
declare function SHFindFiles(byval pidlFolder as LPCITEMIDLIST, byval pidlSaveFile as LPCITEMIDLIST) as WINBOOL
declare sub PathGetShortPath(byval pszLongPath as PWSTR)
declare function PathYetAnotherMakeUniqueName(byval pszUniqueName as PWSTR, byval pszPath as PCWSTR, byval pszShort as PCWSTR, byval pszFileSpec as PCWSTR) as WINBOOL
declare function Win32DeleteFile(byval pszPath as PCWSTR) as WINBOOL

#if _WIN32_WINNT <= &h0502
	const PPCF_ADDQUOTES = &h00000001
	const PPCF_ADDARGUMENTS = &h00000003
	const PPCF_NODIRECTORIES = &h00000010
	const PPCF_FORCEQUALIFY = &h00000040
	const PPCF_LONGESTPOSSIBLE = &h00000080
	declare function PathProcessCommand(byval pszSrc as PCWSTR, byval pszDest as PWSTR, byval cchDest as long, byval dwFlags as DWORD) as LONG
#endif

declare function SHRestricted(byval rest as RESTRICTIONS) as DWORD
declare function SignalFileOpen(byval pidl as LPCITEMIDLIST) as WINBOOL

#if _WIN32_WINNT <= &h0502
	declare function SHLoadOLE(byval lParam as LPARAM) as HRESULT
#else
	declare function AssocGetDetailsOfPropKey(byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval pkey as const PROPERTYKEY ptr, byval pv as VARIANT ptr, byval pfFoundPropKey as WINBOOL ptr) as HRESULT
#endif

declare function SHStartNetConnectionDialogA(byval hwnd as HWND, byval pszRemoteName as LPCSTR, byval dwType as DWORD) as HRESULT
declare function SHStartNetConnectionDialogW(byval hwnd as HWND, byval pszRemoteName as LPCWSTR, byval dwType as DWORD) as HRESULT
declare function SHDefExtractIconA(byval pszIconFile as LPCSTR, byval iIndex as long, byval uFlags as UINT, byval phiconLarge as HICON ptr, byval phiconSmall as HICON ptr, byval nIconSize as UINT) as HRESULT
declare function SHDefExtractIconW(byval pszIconFile as LPCWSTR, byval iIndex as long, byval uFlags as UINT, byval phiconLarge as HICON ptr, byval phiconSmall as HICON ptr, byval nIconSize as UINT) as HRESULT

#ifdef UNICODE
	declare function SHStartNetConnectionDialog alias "SHStartNetConnectionDialogW"(byval hwnd as HWND, byval pszRemoteName as LPCWSTR, byval dwType as DWORD) as HRESULT
	declare function SHDefExtractIcon alias "SHDefExtractIconW"(byval pszIconFile as LPCWSTR, byval iIndex as long, byval uFlags as UINT, byval phiconLarge as HICON ptr, byval phiconSmall as HICON ptr, byval nIconSize as UINT) as HRESULT
#else
	declare function SHStartNetConnectionDialog alias "SHStartNetConnectionDialogA"(byval hwnd as HWND, byval pszRemoteName as LPCSTR, byval dwType as DWORD) as HRESULT
	declare function SHDefExtractIcon alias "SHDefExtractIconA"(byval pszIconFile as LPCSTR, byval iIndex as long, byval uFlags as UINT, byval phiconLarge as HICON ptr, byval phiconSmall as HICON ptr, byval nIconSize as UINT) as HRESULT
#endif

type tagOPEN_AS_INFO_FLAGS as long
enum
	OAIF_ALLOW_REGISTRATION = &h1
	OAIF_REGISTER_EXT = &h2
	OAIF_EXEC = &h4
	OAIF_FORCE_REGISTRATION = &h8

	#if _WIN32_WINNT >= &h0600
		OAIF_HIDE_REGISTRATION = &h20
		OAIF_URL_PROTOCOL = &h40
	#endif

	#if _WIN32_WINNT = &h0602
		OAIF_FILE_IS_URI = &h80
	#endif
end enum

type OPEN_AS_INFO_FLAGS as long

type _openasinfo
	pcszFile as LPCWSTR
	pcszClass as LPCWSTR
	oaifInFlags as OPEN_AS_INFO_FLAGS
end type

type OPENASINFO as _openasinfo
type POPENASINFO as _openasinfo ptr

#if _WIN32_WINNT >= &h0600
	declare function SHOpenWithDialog(byval hwndParent as HWND, byval poainfo as const OPENASINFO ptr) as HRESULT
#endif

declare function Shell_GetImageLists(byval phiml as HIMAGELIST ptr, byval phimlSmall as HIMAGELIST ptr) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function Shell_GetCachedImageIndexA(byval pszIconPath as LPCSTR, byval iIconIndex as long, byval uIconFlags as UINT) as long
	declare function Shell_GetCachedImageIndexW(byval pszIconPath as LPCWSTR, byval iIconIndex as long, byval uIconFlags as UINT) as long
	#ifdef UNICODE
		declare function Shell_GetCachedImageIndex alias "Shell_GetCachedImageIndexW"(byval pszIconPath as LPCWSTR, byval iIconIndex as long, byval uIconFlags as UINT) as long
	#else
		declare function Shell_GetCachedImageIndex alias "Shell_GetCachedImageIndexA"(byval pszIconPath as LPCSTR, byval iIconIndex as long, byval uIconFlags as UINT) as long
	#endif
#else
	declare function Shell_GetCachedImageIndex(byval pwszIconPath as PCWSTR, byval iIconIndex as long, byval uIconFlags as UINT) as long
#endif

type IDocViewSiteVtbl as IDocViewSiteVtbl_

type IDocViewSite field = 1
	lpVtbl as IDocViewSiteVtbl ptr
end type

type IDocViewSiteVtbl_ field = 1
	QueryInterface as function(byval This as IDocViewSite ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDocViewSite ptr) as ULONG
	Release as function(byval This as IDocViewSite ptr) as ULONG
	OnSetTitle as function(byval This as IDocViewSite ptr, byval pvTitle as VARIANTARG ptr) as HRESULT
end type

const VALIDATEUNC_CONNECT = &h0001
const VALIDATEUNC_NOUI = &h0002
const VALIDATEUNC_PRINT = &h0004

#if _WIN32_WINNT <= &h0502
	const VALIDATEUNC_VALID = &h0007
#else
	const VALIDATEUNC_PERSIST = &h0008
	const VALIDATEUNC_VALID = &h000f
#endif

declare function SHValidateUNC(byval hwndOwner as HWND, byval pszFile as PWSTR, byval fConnect as UINT) as WINBOOL
const OPENPROPS_NONE = &h0000
const OPENPROPS_INHIBITPIF = &h8000
const GETPROPS_NONE = &h0000
const SETPROPS_NONE = &h0000
const CLOSEPROPS_NONE = &h0000
const CLOSEPROPS_DISCARD = &h0001
const PIFNAMESIZE = 30
const PIFSTARTLOCSIZE = 63
const PIFDEFPATHSIZE = 64
const PIFPARAMSSIZE = 64
const PIFSHPROGSIZE = 64
const PIFSHDATASIZE = 64
const PIFDEFFILESIZE = 80
const PIFMAXFILEPATH = 260

type PROPPRG field = 1
	flPrg as WORD
	flPrgInit as WORD
	achTitle as zstring * 30
	achCmdLine as zstring * (63 + 64) + 1
	achWorkDir as zstring * 64
	wHotKey as WORD
	achIconFile as zstring * 80
	wIconIndex as WORD
	dwEnhModeFlags as DWORD
	dwRealModeFlags as DWORD
	achOtherFile as zstring * 80
	achPIFFile as zstring * 260
end type

type PPROPPRG as PROPPRG ptr
type LPPROPPRG as PROPPRG ptr
type LPCPROPPRG as const PROPPRG ptr

declare function PifMgr_OpenProperties(byval pszApp as PCWSTR, byval pszPIF as PCWSTR, byval hInf as UINT, byval flOpt as UINT) as HANDLE
declare function PifMgr_GetProperties(byval hProps as HANDLE, byval pszGroup as PCSTR, byval lpProps as any ptr, byval cbProps as long, byval flOpt as UINT) as long
declare function PifMgr_SetProperties(byval hProps as HANDLE, byval pszGroup as PCSTR, byval lpProps as const any ptr, byval cbProps as long, byval flOpt as UINT) as long
declare function PifMgr_CloseProperties(byval hProps as HANDLE, byval flOpt as UINT) as HANDLE
declare sub SHSetInstanceExplorer(byval punk as IUnknown ptr)
declare function IsUserAnAdmin() as WINBOOL
type IInitializeObjectVtbl as IInitializeObjectVtbl_

type IInitializeObject field = 1
	lpVtbl as IInitializeObjectVtbl ptr
end type

type IInitializeObjectVtbl_ field = 1
	QueryInterface as function(byval This as IInitializeObject ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IInitializeObject ptr) as ULONG
	Release as function(byval This as IInitializeObject ptr) as ULONG
	Initialize as function(byval This as IInitializeObject ptr) as HRESULT
end type

enum
	BMICON_LARGE = 0
	BMICON_SMALL
end enum

type IBanneredBarVtbl as IBanneredBarVtbl_

type IBanneredBar field = 1
	lpVtbl as IBanneredBarVtbl ptr
end type

type IBanneredBarVtbl_ field = 1
	QueryInterface as function(byval This as IBanneredBar ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IBanneredBar ptr) as ULONG
	Release as function(byval This as IBanneredBar ptr) as ULONG
	SetIconSize as function(byval This as IBanneredBar ptr, byval iIcon as DWORD) as HRESULT
	GetIconSize as function(byval This as IBanneredBar ptr, byval piIcon as DWORD ptr) as HRESULT
	SetBitmap as function(byval This as IBanneredBar ptr, byval hBitmap as HBITMAP) as HRESULT
	GetBitmap as function(byval This as IBanneredBar ptr, byval phBitmap as HBITMAP ptr) as HRESULT
end type

declare function SHShellFolderView_Message(byval hwndMain as HWND, byval uMsg as UINT, byval lParam as LPARAM) as LRESULT
type IShellFolderViewCBVtbl as IShellFolderViewCBVtbl_

type IShellFolderViewCB field = 1
	lpVtbl as IShellFolderViewCBVtbl ptr
end type

type IShellFolderViewCBVtbl_ field = 1
	QueryInterface as function(byval This as IShellFolderViewCB ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellFolderViewCB ptr) as ULONG
	Release as function(byval This as IShellFolderViewCB ptr) as ULONG
	MessageSFVCB as function(byval This as IShellFolderViewCB ptr, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
end type

const QCMINFO_PLACE_BEFORE = 0
const QCMINFO_PLACE_AFTER = 1

type _QCMINFO_IDMAP_PLACEMENT
	id as UINT
	fFlags as UINT
end type

type QCMINFO_IDMAP_PLACEMENT as _QCMINFO_IDMAP_PLACEMENT

type _QCMINFO_IDMAP
	nMaxIds as UINT
	pIdList(0 to 0) as QCMINFO_IDMAP_PLACEMENT
end type

type QCMINFO_IDMAP as _QCMINFO_IDMAP

type _QCMINFO
	hmenu as HMENU
	indexMenu as UINT
	idCmdFirst as UINT
	idCmdLast as UINT
	pIdMap as const QCMINFO_IDMAP ptr
end type

type QCMINFO as _QCMINFO
type LPQCMINFO as QCMINFO ptr
const TBIF_APPEND = 0
const TBIF_PREPEND = 1
const TBIF_REPLACE = 2
const TBIF_DEFAULT = &h00000000
const TBIF_INTERNETBAR = &h00010000
const TBIF_STANDARDTOOLBAR = &h00020000
const TBIF_NOTOOLBAR = &h00030000

type _TBINFO
	cbuttons as UINT
	uFlags as UINT
end type

type TBINFO as _TBINFO
type LPTBINFO as TBINFO ptr

type _DETAILSINFO
	pidl as LPCITEMIDLIST
	fmt as long
	cxChar as long
	str as STRRET
	iImage as long
end type

type DETAILSINFO as _DETAILSINFO
type PDETAILSINFO as DETAILSINFO ptr

type _SFVM_PROPPAGE_DATA
	dwReserved as DWORD
	pfn as LPFNADDPROPSHEETPAGE
	lParam as LPARAM
end type

type SFVM_PROPPAGE_DATA as _SFVM_PROPPAGE_DATA

type _SFVM_HELPTOPIC_DATA
	wszHelpFile as wstring * 260
	wszHelpTopic as wstring * 260
end type

type SFVM_HELPTOPIC_DATA as _SFVM_HELPTOPIC_DATA
const SFVM_MERGEMENU = 1
const SFVM_INVOKECOMMAND = 2
const SFVM_GETHELPTEXT = 3
const SFVM_GETTOOLTIPTEXT = 4
const SFVM_GETBUTTONINFO = 5
const SFVM_GETBUTTONS = 6
const SFVM_INITMENUPOPUP = 7
const SFVM_FSNOTIFY = 14
const SFVM_WINDOWCREATED = 15
const SFVM_GETDETAILSOF = 23
const SFVM_COLUMNCLICK = 24
const SFVM_QUERYFSNOTIFY = 25
const SFVM_DEFITEMCOUNT = 26
const SFVM_DEFVIEWMODE = 27
const SFVM_UNMERGEMENU = 28
const SFVM_UPDATESTATUSBAR = 31
const SFVM_BACKGROUNDENUM = 32
const SFVM_DIDDRAGDROP = 36
const SFVM_SETISFV = 39
const SFVM_THISIDLIST = 41
const SFVM_ADDPROPERTYPAGES = 47
const SFVM_BACKGROUNDENUMDONE = 48
const SFVM_GETNOTIFY = 49
const SFVM_GETSORTDEFAULTS = 53
const SFVM_SIZE = 57
const SFVM_GETZONE = 58
const SFVM_GETPANE = 59
const SFVM_GETHELPTOPIC = 63
const SFVM_GETANIMATION = 68

type _ITEMSPACING
	cxSmall as long
	cySmall as long
	cxLarge as long
	cyLarge as long
end type

type ITEMSPACING as _ITEMSPACING
const SFVSOC_INVALIDATE_ALL = &h00000001
const SFVSOC_NOSCROLL = LVSICF_NOSCROLL
const SFVS_SELECT_NONE = &h0
const SFVS_SELECT_ALLITEMS = &h1
const SFVS_SELECT_INVERT = &h2
type IShellFolderViewVtbl as IShellFolderViewVtbl_

type IShellFolderView
	lpVtbl as IShellFolderViewVtbl ptr
end type

type IShellFolderViewVtbl_
	QueryInterface as function(byval This as IShellFolderView ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellFolderView ptr) as ULONG
	Release as function(byval This as IShellFolderView ptr) as ULONG
	Rearrange as function(byval This as IShellFolderView ptr, byval lParamSort as LPARAM) as HRESULT
	GetArrangeParam as function(byval This as IShellFolderView ptr, byval plParamSort as LPARAM ptr) as HRESULT
	ArrangeGrid as function(byval This as IShellFolderView ptr) as HRESULT
	AutoArrange as function(byval This as IShellFolderView ptr) as HRESULT
	GetAutoArrange as function(byval This as IShellFolderView ptr) as HRESULT
	AddObject as function(byval This as IShellFolderView ptr, byval pidl as LPITEMIDLIST, byval puItem as UINT ptr) as HRESULT
	GetObject as function(byval This as IShellFolderView ptr, byval ppidl as LPITEMIDLIST ptr, byval uItem as UINT) as HRESULT
	RemoveObject as function(byval This as IShellFolderView ptr, byval pidl as LPITEMIDLIST, byval puItem as UINT ptr) as HRESULT
	GetObjectCount as function(byval This as IShellFolderView ptr, byval puCount as UINT ptr) as HRESULT
	SetObjectCount as function(byval This as IShellFolderView ptr, byval uCount as UINT, byval dwFlags as UINT) as HRESULT
	UpdateObject as function(byval This as IShellFolderView ptr, byval pidlOld as LPITEMIDLIST, byval pidlNew as LPITEMIDLIST, byval puItem as UINT ptr) as HRESULT
	RefreshObject as function(byval This as IShellFolderView ptr, byval pidl as LPITEMIDLIST, byval puItem as UINT ptr) as HRESULT
	SetRedraw as function(byval This as IShellFolderView ptr, byval bRedraw as WINBOOL) as HRESULT
	GetSelectedCount as function(byval This as IShellFolderView ptr, byval puSelected as UINT ptr) as HRESULT
	GetSelectedObjects as function(byval This as IShellFolderView ptr, byval pppidl as LPCITEMIDLIST ptr ptr, byval puItems as UINT ptr) as HRESULT
	IsDropOnSource as function(byval This as IShellFolderView ptr, byval pDropTarget as IDropTarget ptr) as HRESULT
	GetDragPoint as function(byval This as IShellFolderView ptr, byval ppt as POINT ptr) as HRESULT
	GetDropPoint as function(byval This as IShellFolderView ptr, byval ppt as POINT ptr) as HRESULT
	MoveIcons as function(byval This as IShellFolderView ptr, byval pDataObject as IDataObject ptr) as HRESULT
	SetItemPos as function(byval This as IShellFolderView ptr, byval pidl as LPCITEMIDLIST, byval ppt as POINT ptr) as HRESULT
	IsBkDropTarget as function(byval This as IShellFolderView ptr, byval pDropTarget as IDropTarget ptr) as HRESULT
	SetClipboard as function(byval This as IShellFolderView ptr, byval bMove as WINBOOL) as HRESULT
	SetPoints as function(byval This as IShellFolderView ptr, byval pDataObject as IDataObject ptr) as HRESULT
	GetItemSpacing as function(byval This as IShellFolderView ptr, byval pSpacing as ITEMSPACING ptr) as HRESULT
	SetCallback as function(byval This as IShellFolderView ptr, byval pNewCB as IShellFolderViewCB ptr, byval ppOldCB as IShellFolderViewCB ptr ptr) as HRESULT
	Select as function(byval This as IShellFolderView ptr, byval dwFlags as UINT) as HRESULT
	QuerySupport as function(byval This as IShellFolderView ptr, byval pdwSupport as UINT ptr) as HRESULT
	SetAutomationObject as function(byval This as IShellFolderView ptr, byval pdisp as IDispatch ptr) as HRESULT
end type

type _SFV_CREATE
	cbSize as UINT
	pshf as IShellFolder ptr
	psvOuter as IShellView ptr
	psfvcb as IShellFolderViewCB ptr
end type

type SFV_CREATE as _SFV_CREATE
declare function SHCreateShellFolderView(byval pcsfv as const SFV_CREATE ptr, byval ppsv as IShellView ptr ptr) as HRESULT
type LPFNDFMCALLBACK as function(byval psf as IShellFolder ptr, byval hwnd as HWND, byval pdtobj as IDataObject ptr, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT
declare function CDefFolderMenu_Create2(byval pidlFolder as LPCITEMIDLIST, byval hwnd as HWND, byval cidl as UINT, byval apidl as LPCITEMIDLIST ptr, byval psf as IShellFolder ptr, byval pfn as LPFNDFMCALLBACK, byval nKeys as UINT, byval ahkeys as const HKEY ptr, byval ppcm as IContextMenu ptr ptr) as HRESULT

type DEFCONTEXTMENU
	hwnd as HWND
	pcmcb as IContextMenuCB ptr
	pidlFolder as LPCITEMIDLIST
	psf as IShellFolder ptr
	cidl as UINT
	apidl as LPCITEMIDLIST ptr
	punkAssociationInfo as IUnknown ptr
	cKeys as UINT
	aKeys as const HKEY ptr
end type

#if _WIN32_WINNT >= &h0600
	declare function SHCreateDefaultContextMenu(byval pdcm as const DEFCONTEXTMENU ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
#endif

declare function SHOpenPropSheetA(byval pszCaption as LPCSTR, byval ahkeys as HKEY ptr, byval ckeys as UINT, byval pclsidDefault as const CLSID ptr, byval pdtobj as IDataObject ptr, byval psb as IShellBrowser ptr, byval pStartPage as LPCSTR) as WINBOOL
declare function SHOpenPropSheetW(byval pszCaption as LPCWSTR, byval ahkeys as HKEY ptr, byval ckeys as UINT, byval pclsidDefault as const CLSID ptr, byval pdtobj as IDataObject ptr, byval psb as IShellBrowser ptr, byval pStartPage as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SHOpenPropSheet alias "SHOpenPropSheetW"(byval pszCaption as LPCWSTR, byval ahkeys as HKEY ptr, byval ckeys as UINT, byval pclsidDefault as const CLSID ptr, byval pdtobj as IDataObject ptr, byval psb as IShellBrowser ptr, byval pStartPage as LPCWSTR) as WINBOOL
#else
	declare function SHOpenPropSheet alias "SHOpenPropSheetA"(byval pszCaption as LPCSTR, byval ahkeys as HKEY ptr, byval ckeys as UINT, byval pclsidDefault as const CLSID ptr, byval pdtobj as IDataObject ptr, byval psb as IShellBrowser ptr, byval pStartPage as LPCSTR) as WINBOOL
#endif

type DFMICS
	cbSize as DWORD
	fMask as DWORD
	lParam as LPARAM
	idCmdFirst as UINT
	idDefMax as UINT
	pici as LPCMINVOKECOMMANDINFO

	#if _WIN32_WINNT >= &h0600
		punkSite as IUnknown ptr
	#endif
end type

type PDFMICS as DFMICS ptr
const DFM_MERGECONTEXTMENU = 1
const DFM_INVOKECOMMAND = 2
const DFM_GETHELPTEXT = 5
const DFM_WM_MEASUREITEM = 6
const DFM_WM_DRAWITEM = 7
const DFM_WM_INITMENUPOPUP = 8
const DFM_VALIDATECMD = 9
const DFM_MERGECONTEXTMENU_TOP = 10
const DFM_GETHELPTEXTW = 11
const DFM_INVOKECOMMANDEX = 12
const DFM_MAPCOMMANDNAME = 13
const DFM_GETDEFSTATICID = 14
const DFM_GETVERBW = 15
const DFM_GETVERBA = 16
const DFM_MERGECONTEXTMENU_BOTTOM = 17
const DFM_MODIFYQCMFLAGS = 18
const DFM_CMD_DELETE = cast(UINT, -1)
const DFM_CMD_MOVE = cast(UINT, -2)
const DFM_CMD_COPY = cast(UINT, -3)
const DFM_CMD_LINK = cast(UINT, -4)
const DFM_CMD_PROPERTIES = cast(UINT, -5)
const DFM_CMD_NEWFOLDER = cast(UINT, -6)
const DFM_CMD_PASTE = cast(UINT, -7)
const DFM_CMD_VIEWLIST = cast(UINT, -8)
const DFM_CMD_VIEWDETAILS = cast(UINT, -9)
const DFM_CMD_PASTELINK = cast(UINT, -10)
const DFM_CMD_PASTESPECIAL = cast(UINT, -11)
const DFM_CMD_MODALPROP = cast(UINT, -12)
const DFM_CMD_RENAME = cast(UINT, -13)
type LPFNVIEWCALLBACK as function(byval psvOuter as IShellView ptr, byval psf as IShellFolder ptr, byval hwndMain as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as HRESULT

type _CSFV
	cbSize as UINT
	pshf as IShellFolder ptr
	psvOuter as IShellView ptr
	pidl as LPCITEMIDLIST
	lEvents as LONG
	pfnCallback as LPFNVIEWCALLBACK
	fvm as FOLDERVIEWMODE
end type

type CSFV as _CSFV
type LPCSFV as _CSFV ptr
const SFVM_REARRANGE = &h00000001
const SFVM_ADDOBJECT = &h00000003
const SFVM_REMOVEOBJECT = &h00000006
const SFVM_UPDATEOBJECT = &h00000007
const SFVM_GETSELECTEDOBJECTS = &h00000009
const SFVM_SETITEMPOS = &h0000000e
const SFVM_SETCLIPBOARD = &h00000010
const SFVM_SETPOINTS = &h00000017
#define ShellFolderView_ReArrange(_hwnd, _lparam) cast(WINBOOL, SHShellFolderView_Message(_hwnd, SFVM_REARRANGE, _lparam))
#define ShellFolderView_AddObject(_hwnd, _pidl) cast(LPARAM, SHShellFolderView_Message(_hwnd, SFVM_ADDOBJECT, cast(LPARAM, (_pidl))))
#define ShellFolderView_RemoveObject(_hwnd, _pidl) cast(LPARAM, SHShellFolderView_Message(_hwnd, SFVM_REMOVEOBJECT, cast(LPARAM, (_pidl))))
#define ShellFolderView_UpdateObject(_hwnd, _ppidl) cast(LPARAM, SHShellFolderView_Message(_hwnd, SFVM_UPDATEOBJECT, cast(LPARAM, (_ppidl))))
#define ShellFolderView_GetSelectedObjects(_hwnd, ppidl) cast(LPARAM, SHShellFolderView_Message(_hwnd, SFVM_GETSELECTEDOBJECTS, cast(LPARAM, (ppidl))))
#macro ShellFolderView_SetItemPos(_hwnd, _pidl, _x, _y)
	scope
		dim _sip as SFV_SETITEMPOS = (_pidl, (_x, _y))
		SHShellFolderView_Message(_hwnd, SFVM_SETITEMPOS, cast(LPARAM, cast(LPSFV_SETITEMPOS, @_sip)))
	end scope
#endmacro
#define ShellFolderView_SetClipboard(_hwnd, _dwEffect) SHShellFolderView_Message(_hwnd, SFVM_SETCLIPBOARD, cast(LPARAM, cast(DWORD, (_dwEffect))))
#define ShellFolderView_SetPoints(_hwnd, _pdtobj) SHShellFolderView_Message(_hwnd, SFVM_SETPOINTS, cast(LPARAM, (_pdtobj)))

type _SFV_SETITEMPOS
	pidl as LPCITEMIDLIST
	pt as POINT
end type

type SFV_SETITEMPOS as _SFV_SETITEMPOS
type LPSFV_SETITEMPOS as SFV_SETITEMPOS ptr
type PCSFV_SETITEMPOS as const SFV_SETITEMPOS ptr
declare function SHFind_InitMenuPopup(byval hmenu as HMENU, byval hwndOwner as HWND, byval idCmdFirst as UINT, byval idCmdLast as UINT) as IContextMenu ptr
declare function SHCreateShellFolderViewEx(byval pcsfv as CSFV ptr, byval ppsv as IShellView ptr ptr) as HRESULT

const PID_IS_URL = 2
const PID_IS_NAME = 4
const PID_IS_WORKINGDIR = 5
const PID_IS_HOTKEY = 6
const PID_IS_SHOWCMD = 7
const PID_IS_ICONINDEX = 8
const PID_IS_ICONFILE = 9
const PID_IS_WHATSNEW = 10
const PID_IS_AUTHOR = 11
const PID_IS_DESCRIPTION = 12
const PID_IS_COMMENT = 13
const PID_IS_ROAMED = 15
const PID_INTSITE_WHATSNEW = 2
const PID_INTSITE_AUTHOR = 3
const PID_INTSITE_LASTVISIT = 4
const PID_INTSITE_LASTMOD = 5
const PID_INTSITE_VISITCOUNT = 6
const PID_INTSITE_DESCRIPTION = 7
const PID_INTSITE_COMMENT = 8
const PID_INTSITE_FLAGS = 9
const PID_INTSITE_CONTENTLEN = 10
const PID_INTSITE_CONTENTCODE = 11
const PID_INTSITE_RECURSE = 12
const PID_INTSITE_WATCH = 13
const PID_INTSITE_SUBSCRIPTION = 14
const PID_INTSITE_URL = 15
const PID_INTSITE_TITLE = 16
const PID_INTSITE_CODEPAGE = 18
const PID_INTSITE_TRACKING = 19
const PID_INTSITE_ICONINDEX = 20
const PID_INTSITE_ICONFILE = 21
const PID_INTSITE_ROAMED = 34
const PIDISF_RECENTLYCHANGED = &h00000001
const PIDISF_CACHEDSTICKY = &h00000002
const PIDISF_CACHEIMAGES = &h00000010
const PIDISF_FOLLOWALLLINKS = &h00000020
const PIDISM_GLOBAL = 0
const PIDISM_WATCH = 1
const PIDISM_DONTWATCH = 2
const PIDISR_UP_TO_DATE = 0
const PIDISR_NEEDS_ADD = 1
const PIDISR_NEEDS_UPDATE = 2
const PIDISR_NEEDS_DELETE = 3

type SHELLSTATEA field = 1
	fShowAllObjects : 1 as WINBOOL
	fShowExtensions : 1 as WINBOOL
	fNoConfirmRecycle : 1 as WINBOOL
	fShowSysFiles : 1 as WINBOOL
	fShowCompColor : 1 as WINBOOL
	fDoubleClickInWebView : 1 as WINBOOL
	fDesktopHTML : 1 as WINBOOL
	fWin95Classic : 1 as WINBOOL
	fDontPrettyPath : 1 as WINBOOL
	fShowAttribCol : 1 as WINBOOL
	fMapNetDrvBtn : 1 as WINBOOL
	fShowInfoTip : 1 as WINBOOL
	fHideIcons : 1 as WINBOOL
	fWebView : 1 as WINBOOL
	fFilter : 1 as WINBOOL
	fShowSuperHidden : 1 as WINBOOL
	fNoNetCrawling : 1 as WINBOOL
	dwWin95Unused as DWORD
	uWin95Unused as UINT
	lParamSort as LONG
	iSortDirection as long
	version as UINT
	uNotUsed as UINT
	fSepProcess : 1 as WINBOOL
	fStartPanelOn : 1 as WINBOOL
	fShowStartPage : 1 as WINBOOL
	fAutoCheckSelect : 1 as WINBOOL
	fIconsOnly : 1 as WINBOOL
	fShowTypeOverlay : 1 as WINBOOL
	fShowStatusBar : 1 as WINBOOL
	fSpareFlags : 9 as UINT
end type

type LPSHELLSTATEA as SHELLSTATEA ptr

type SHELLSTATEW field = 1
	fShowAllObjects : 1 as WINBOOL
	fShowExtensions : 1 as WINBOOL
	fNoConfirmRecycle : 1 as WINBOOL
	fShowSysFiles : 1 as WINBOOL
	fShowCompColor : 1 as WINBOOL
	fDoubleClickInWebView : 1 as WINBOOL
	fDesktopHTML : 1 as WINBOOL
	fWin95Classic : 1 as WINBOOL
	fDontPrettyPath : 1 as WINBOOL
	fShowAttribCol : 1 as WINBOOL
	fMapNetDrvBtn : 1 as WINBOOL
	fShowInfoTip : 1 as WINBOOL
	fHideIcons : 1 as WINBOOL
	fWebView : 1 as WINBOOL
	fFilter : 1 as WINBOOL
	fShowSuperHidden : 1 as WINBOOL
	fNoNetCrawling : 1 as WINBOOL
	dwWin95Unused as DWORD
	uWin95Unused as UINT
	lParamSort as LONG
	iSortDirection as long
	version as UINT
	uNotUsed as UINT
	fSepProcess : 1 as WINBOOL
	fStartPanelOn : 1 as WINBOOL
	fShowStartPage : 1 as WINBOOL
	fAutoCheckSelect : 1 as WINBOOL
	fIconsOnly : 1 as WINBOOL
	fShowTypeOverlay : 1 as WINBOOL
	fShowStatusBar : 1 as WINBOOL
	fSpareFlags : 9 as UINT
end type

type LPSHELLSTATEW as SHELLSTATEW ptr
const SHELLSTATEVERSION_IE4 = 9
const SHELLSTATEVERSION_WIN2K = 10

#ifdef UNICODE
	type SHELLSTATE as SHELLSTATEW
	type LPSHELLSTATE as LPSHELLSTATEW
#else
	type SHELLSTATE as SHELLSTATEA
	type LPSHELLSTATE as LPSHELLSTATEA
#endif

#define SHELLSTATE_SIZE_WIN95 FIELD_OFFSET(SHELLSTATE, lParamSort)
#define SHELLSTATE_SIZE_NT4 FIELD_OFFSET(SHELLSTATE, version)
#define SHELLSTATE_SIZE_IE4 FIELD_OFFSET(SHELLSTATE, uNotUsed)
#define SHELLSTATE_SIZE_WIN2K sizeof(SHELLSTATE)

#ifdef UNICODE
	declare sub SHGetSetSettings(byval lpss as LPSHELLSTATEW, byval dwMask as DWORD, byval bSet as WINBOOL)
#else
	declare sub SHGetSetSettings(byval lpss as LPSHELLSTATEA, byval dwMask as DWORD, byval bSet as WINBOOL)
#endif

type SHELLFLAGSTATE field = 1
	fShowAllObjects : 1 as WINBOOL
	fShowExtensions : 1 as WINBOOL
	fNoConfirmRecycle : 1 as WINBOOL
	fShowSysFiles : 1 as WINBOOL
	fShowCompColor : 1 as WINBOOL
	fDoubleClickInWebView : 1 as WINBOOL
	fDesktopHTML : 1 as WINBOOL
	fWin95Classic : 1 as WINBOOL
	fDontPrettyPath : 1 as WINBOOL
	fShowAttribCol : 1 as WINBOOL
	fMapNetDrvBtn : 1 as WINBOOL
	fShowInfoTip : 1 as WINBOOL
	fHideIcons : 1 as WINBOOL

	#if _WIN32_WINNT <= &h0502
		fRestFlags : 3 as UINT
	#else
		fAutoCheckSelect : 1 as WINBOOL
		fIconsOnly : 1 as WINBOOL
		fRestFlags : 1 as UINT
	#endif
end type

type LPSHELLFLAGSTATE as SHELLFLAGSTATE ptr
const SSF_SHOWALLOBJECTS = &h00000001
const SSF_SHOWEXTENSIONS = &h00000002
const SSF_HIDDENFILEEXTS = &h00000004
const SSF_SERVERADMINUI = &h00000004
const SSF_SHOWCOMPCOLOR = &h00000008
const SSF_SORTCOLUMNS = &h00000010
const SSF_SHOWSYSFILES = &h00000020
const SSF_DOUBLECLICKINWEBVIEW = &h00000080
const SSF_SHOWATTRIBCOL = &h00000100
const SSF_DESKTOPHTML = &h00000200
const SSF_WIN95CLASSIC = &h00000400
const SSF_DONTPRETTYPATH = &h00000800
const SSF_SHOWINFOTIP = &h00002000
const SSF_MAPNETDRVBUTTON = &h00001000
const SSF_NOCONFIRMRECYCLE = &h00008000
const SSF_HIDEICONS = &h00004000
const SSF_FILTER = &h00010000
const SSF_WEBVIEW = &h00020000
const SSF_SHOWSUPERHIDDEN = &h00040000
const SSF_SEPPROCESS = &h00080000
const SSF_NONETCRAWLING = &h00100000
const SSF_STARTPANELON = &h00200000
const SSF_SHOWSTARTPAGE = &h00400000

#if _WIN32_WINNT >= &h0600
	const SSF_AUTOCHECKSELECT = &h00800000
	const SSF_ICONSONLY = &h01000000
	const SSF_SHOWTYPEOVERLAY = &h02000000
#endif

#if _WIN32_WINNT = &h0602
	const SSF_SHOWSTATUSBAR = &h04000000
#endif

declare sub SHGetSettings(byval psfs as SHELLFLAGSTATE ptr, byval dwMask as DWORD)
declare function SHBindToParent(byval pidl as LPCITEMIDLIST, byval riid as const IID const ptr, byval ppv as any ptr ptr, byval ppidlLast as LPCITEMIDLIST ptr) as HRESULT

#if _WIN32_WINNT >= &h0600
	declare function SHBindToFolderIDListParent(byval psfRoot as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval riid as const IID const ptr, byval ppv as any ptr ptr, byval ppidlLast as LPCITEMIDLIST ptr) as HRESULT
	declare function SHBindToFolderIDListParentEx(byval psfRoot as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval ppbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr, byval ppidlLast as LPCITEMIDLIST ptr) as HRESULT
	declare function SHBindToObject(byval psf as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval pbc as IBindCtx ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
#endif

private function IDListContainerIsConsistent cdecl(byval p as LPCITEMIDLIST, byval sz as UINT) as WINBOOL
	dim c as UINT = sizeof(p->mkid.cb)
	while ((c <= sz) andalso (p->mkid.cb >= sizeof(p->mkid.cb))) andalso (p->mkid.cb <= (sz - c))
		c += p->mkid.cb
		p = cast(LPITEMIDLIST, cptr(any ptr, cptr(UBYTE ptr, p) + p->mkid.cb))
	wend
	return -((c <= sz) andalso (p->mkid.cb = 0))
end function

declare function SHParseDisplayName(byval pszName as PCWSTR, byval pbc as IBindCtx ptr, byval ppidl as LPITEMIDLIST ptr, byval sfgaoIn as SFGAOF, byval psfgaoOut as SFGAOF ptr) as HRESULT
const SHPPFW_NONE = &h00000000
const SHPPFW_DIRCREATE = &h00000001
const SHPPFW_DEFAULT = SHPPFW_DIRCREATE
const SHPPFW_ASKDIRCREATE = &h00000002
const SHPPFW_IGNOREFILENAME = &h00000004
const SHPPFW_NOWRITECHECK = &h00000008
const SHPPFW_MEDIACHECKONLY = &h00000010
declare function SHPathPrepareForWriteA(byval hwnd as HWND, byval punkEnableModless as IUnknown ptr, byval pszPath as LPCSTR, byval dwFlags as DWORD) as HRESULT
declare function SHPathPrepareForWriteW(byval hwnd as HWND, byval punkEnableModless as IUnknown ptr, byval pszPath as LPCWSTR, byval dwFlags as DWORD) as HRESULT

#ifdef UNICODE
	declare function SHPathPrepareForWrite alias "SHPathPrepareForWriteW"(byval hwnd as HWND, byval punkEnableModless as IUnknown ptr, byval pszPath as LPCWSTR, byval dwFlags as DWORD) as HRESULT
#else
	declare function SHPathPrepareForWrite alias "SHPathPrepareForWriteA"(byval hwnd as HWND, byval punkEnableModless as IUnknown ptr, byval pszPath as LPCSTR, byval dwFlags as DWORD) as HRESULT
#endif

type INamedPropertyBagVtbl as INamedPropertyBagVtbl_

type INamedPropertyBag field = 1
	lpVtbl as INamedPropertyBagVtbl ptr
end type

type INamedPropertyBagVtbl_ field = 1
	QueryInterface as function(byval This as INamedPropertyBag ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	AddRef as function(byval This as INamedPropertyBag ptr) as ULONG
	Release as function(byval This as INamedPropertyBag ptr) as ULONG
	ReadPropertyNPB as function(byval This as INamedPropertyBag ptr, byval pszBagname as PCWSTR, byval pszPropName as PCWSTR, byval pVar as PROPVARIANT ptr) as HRESULT
	WritePropertyNPB as function(byval This as INamedPropertyBag ptr, byval pszBagname as PCWSTR, byval pszPropName as PCWSTR, byval pVar as PROPVARIANT ptr) as HRESULT
	RemovePropertyNPB as function(byval This as INamedPropertyBag ptr, byval pszBagname as PCWSTR, byval pszPropName as PCWSTR) as HRESULT
end type

declare function SoftwareUpdateMessageBox(byval hWnd as HWND, byval pszDistUnit as PCWSTR, byval dwFlags as DWORD, byval psdi as LPSOFTDISTINFO) as DWORD
declare function SHPropStgCreate(byval psstg as IPropertySetStorage ptr, byval fmtid as const IID const ptr, byval pclsid as const CLSID ptr, byval grfFlags as DWORD, byval grfMode as DWORD, byval dwDisposition as DWORD, byval ppstg as IPropertyStorage ptr ptr, byval puCodePage as UINT ptr) as HRESULT
declare function SHPropStgReadMultiple(byval pps as IPropertyStorage ptr, byval uCodePage as UINT, byval cpspec as ULONG, byval rgpspec as const PROPSPEC ptr, byval rgvar as PROPVARIANT ptr) as HRESULT
declare function SHPropStgWriteMultiple(byval pps as IPropertyStorage ptr, byval puCodePage as UINT ptr, byval cpspec as ULONG, byval rgpspec as const PROPSPEC ptr, byval rgvar as PROPVARIANT ptr, byval propidNameFirst as PROPID) as HRESULT
declare function SHCreateFileExtractIconA(byval pszFile as LPCSTR, byval dwFileAttributes as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare function SHCreateFileExtractIconW(byval pszFile as LPCWSTR, byval dwFileAttributes as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT

#ifdef UNICODE
	declare function SHCreateFileExtractIcon alias "SHCreateFileExtractIconW"(byval pszFile as LPCWSTR, byval dwFileAttributes as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
#else
	declare function SHCreateFileExtractIcon alias "SHCreateFileExtractIconA"(byval pszFile as LPCSTR, byval dwFileAttributes as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
#endif

declare function SHLimitInputEdit(byval hwndEdit as HWND, byval psf as IShellFolder ptr) as HRESULT
declare function SHGetAttributesFromDataObject(byval pdo as IDataObject ptr, byval dwAttributeMask as DWORD, byval pdwAttributes as DWORD ptr, byval pcItems as UINT ptr) as HRESULT
declare function SHMultiFileProperties(byval pdtobj as IDataObject ptr, byval dwFlags as DWORD) as HRESULT
declare function SHMapPIDLToSystemImageListIndex(byval pshf as IShellFolder ptr, byval pidl as LPCITEMIDLIST, byval piIndexSel as long ptr) as long
declare function SHCLSIDFromString(byval psz as PCWSTR, byval pclsid as CLSID ptr) as HRESULT
declare function SHCreateQueryCancelAutoPlayMoniker(byval ppmoniker as IMoniker ptr ptr) as HRESULT
declare sub PerUserInit()
declare function SHRunControlPanel(byval lpcszCmdLine as PCWSTR, byval hwndMsgParent as HWND) as WINBOOL
declare function PickIconDlg(byval hwnd as HWND, byval pszIconPath as PWSTR, byval cchIconPath as UINT, byval piIconIndex as long ptr) as long

type tagAAMENUFILENAME
	cbTotal as SHORT
	rgbReserved(0 to 11) as UBYTE
	szFileName as wstring * 1
end type

type AASHELLMENUFILENAME as tagAAMENUFILENAME
type LPAASHELLMENUFILENAME as tagAAMENUFILENAME ptr

type tagAASHELLMENUITEM
	lpReserved1 as any ptr
	iReserved as long
	uiReserved as UINT
	lpName as LPAASHELLMENUFILENAME
	psz as LPWSTR
end type

type AASHELLMENUITEM as tagAASHELLMENUITEM
type LPAASHELLMENUITEM as tagAASHELLMENUITEM ptr

#if _WIN32_WINNT >= &h0601
	declare function StgMakeUniqueName(byval pstgParent as IStorage ptr, byval pszFileSpec as PCWSTR, byval grfMode as DWORD, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
#endif

#if _WIN32_WINNT >= &h0600
	type tagIESHORTCUTFLAGS as long
	enum
		IESHORTCUT_NEWBROWSER = &h01
		IESHORTCUT_OPENNEWTAB = &h02
		IESHORTCUT_FORCENAVIGATE = &h04
		IESHORTCUT_BACKGROUNDTAB = &h08
	end enum

	type IESHORTCUTFLAGS as tagIESHORTCUTFLAGS
#endif

#if _WIN32_WINNT >= &h0501
	declare function ImportPrivacySettings(byval pszFilename as PCWSTR, byval pfParsePrivacyPreferences as WINBOOL ptr, byval pfParsePerSiteRules as WINBOOL ptr) as WINBOOL
	declare function DoPrivacyDlg(byval hwndOwner as HWND, byval pszUrl as PCWSTR, byval pPrivacyEnum as IEnumPrivacyRecords ptr, byval fReportAllSites as WINBOOL) as HRESULT
#endif

end extern
