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

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "unknwn.bi"
#include once "wtypes.bi"

#define __shtypes_h__

type _SHITEMID field = 1
	cb as USHORT
	abID(0 to 0) as UBYTE
end type

type SHITEMID as _SHITEMID
type LPSHITEMID as SHITEMID ptr
type LPCSHITEMID as const SHITEMID ptr

type _ITEMIDLIST field = 1
	mkid as SHITEMID
end type

type ITEMIDLIST as _ITEMIDLIST
type ITEMIDLIST_RELATIVE as ITEMIDLIST
type ITEMID_CHILD as ITEMIDLIST
type ITEMIDLIST_ABSOLUTE as ITEMIDLIST
type wirePIDL as BYTE_BLOB ptr
type LPITEMIDLIST as ITEMIDLIST ptr
type LPCITEMIDLIST as const ITEMIDLIST ptr
type PIDLIST_ABSOLUTE as LPITEMIDLIST
type PCIDLIST_ABSOLUTE as LPCITEMIDLIST
type PCUIDLIST_ABSOLUTE as LPCITEMIDLIST
type PIDLIST_RELATIVE as LPITEMIDLIST
type PCIDLIST_RELATIVE as LPCITEMIDLIST
type PUIDLIST_RELATIVE as LPITEMIDLIST
type PCUIDLIST_RELATIVE as LPCITEMIDLIST
type PITEMID_CHILD as LPITEMIDLIST
type PCITEMID_CHILD as LPCITEMIDLIST
type PUITEMID_CHILD as LPITEMIDLIST
type PCUITEMID_CHILD as LPCITEMIDLIST
type PCUITEMID_CHILD_ARRAY as LPCITEMIDLIST ptr
type PCUIDLIST_RELATIVE_ARRAY as LPCITEMIDLIST ptr
type PCIDLIST_ABSOLUTE_ARRAY as LPCITEMIDLIST ptr
type PCUIDLIST_ABSOLUTE_ARRAY as LPCITEMIDLIST ptr

type tagSTRRET_TYPE as long
enum
	STRRET_WSTR = &h0
	STRRET_OFFSET = &h1
	STRRET_CSTR = &h2
end enum

type STRRET_TYPE as tagSTRRET_TYPE

type _STRRET
	uType as UINT

	union
		pOleStr as LPWSTR
		uOffset as UINT
		cStr as zstring * 260
	end union
end type

type STRRET as _STRRET
type LPSTRRET as STRRET ptr

type _SHELLDETAILS field = 1
	fmt as long
	cxChar as long
	str as STRRET
end type

type SHELLDETAILS as _SHELLDETAILS
type LPSHELLDETAILS as _SHELLDETAILS ptr

#if _WIN32_WINNT >= &h0600
	type tagPERCEIVED as long
	enum
		PERCEIVED_TYPE_FIRST = -3
		PERCEIVED_TYPE_CUSTOM = -3
		PERCEIVED_TYPE_UNSPECIFIED = -2
		PERCEIVED_TYPE_FOLDER = -1
		PERCEIVED_TYPE_UNKNOWN = 0
		PERCEIVED_TYPE_TEXT = 1
		PERCEIVED_TYPE_IMAGE = 2
		PERCEIVED_TYPE_AUDIO = 3
		PERCEIVED_TYPE_VIDEO = 4
		PERCEIVED_TYPE_COMPRESSED = 5
		PERCEIVED_TYPE_DOCUMENT = 6
		PERCEIVED_TYPE_SYSTEM = 7
		PERCEIVED_TYPE_APPLICATION = 8
		PERCEIVED_TYPE_GAMEMEDIA = 9
		PERCEIVED_TYPE_CONTACTS = 10
		PERCEIVED_TYPE_LAST = 10
	end enum

	type PERCEIVED as tagPERCEIVED
	const PERCEIVEDFLAG_UNDEFINED = &h0000
	const PERCEIVEDFLAG_SOFTCODED = &h0001
	const PERCEIVEDFLAG_HARDCODED = &h0002
	const PERCEIVEDFLAG_NATIVESUPPORT = &h0004
	const PERCEIVEDFLAG_GDIPLUS = &h0010
	const PERCEIVEDFLAG_WMSDK = &h0020
	const PERCEIVEDFLAG_ZIPFOLDER = &h0040
	type PERCEIVEDFLAG as DWORD
#endif

type _COMDLG_FILTERSPEC
	pszName as LPCWSTR
	pszSpec as LPCWSTR
end type

type COMDLG_FILTERSPEC as _COMDLG_FILTERSPEC
type KNOWNFOLDERID as GUID
type REFKNOWNFOLDERID as const KNOWNFOLDERID const ptr
type KF_REDIRECT_FLAGS as DWORD
type FOLDERTYPEID as GUID
type REFFOLDERTYPEID as const FOLDERTYPEID const ptr
type TASKOWNERID as GUID
type REFTASKOWNERID as const TASKOWNERID const ptr
type ELEMENTID as GUID
type REFELEMENTID as const ELEMENTID const ptr

type tagSHCOLSTATE as long
enum
	SHCOLSTATE_DEFAULT = &h0
	SHCOLSTATE_TYPE_STR = &h1
	SHCOLSTATE_TYPE_INT = &h2
	SHCOLSTATE_TYPE_DATE = &h3
	SHCOLSTATE_TYPEMASK = &hf
	SHCOLSTATE_ONBYDEFAULT = &h10
	SHCOLSTATE_SLOW = &h20
	SHCOLSTATE_EXTENDED = &h40
	SHCOLSTATE_SECONDARYUI = &h80
	SHCOLSTATE_HIDDEN = &h100
	SHCOLSTATE_PREFER_VARCMP = &h200
	SHCOLSTATE_PREFER_FMTCMP = &h400
	SHCOLSTATE_NOSORTBYFOLDERNESS = &h800
	SHCOLSTATE_VIEWONLY = &h10000
	SHCOLSTATE_BATCHREAD = &h20000
	SHCOLSTATE_NO_GROUPBY = &h40000
	SHCOLSTATE_FIXED_WIDTH = &h1000
	SHCOLSTATE_NODPISCALE = &h2000
	SHCOLSTATE_FIXED_RATIO = &h4000
	SHCOLSTATE_DISPLAYMASK = &hf000
end enum

type SHCOLSTATE as tagSHCOLSTATE
type SHCOLSTATEF as DWORD
type SHCOLUMNID as PROPERTYKEY
type LPCSHCOLUMNID as const SHCOLUMNID ptr

type DEVICE_SCALE_FACTOR as long
enum
	SCALE_100_PERCENT = 100
	SCALE_140_PERCENT = 140
	SCALE_180_PERCENT = 180
end enum
