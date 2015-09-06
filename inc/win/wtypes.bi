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
#include once "wtypesbase.bi"

'' The following symbols have been renamed:
''     typedef DATE => DATE_

extern "C"

const __REQUIRED_RPCNDR_H_VERSION__ = 475
#define __wtypes_h__
#define __IWinTypes_INTERFACE_DEFINED__
extern IWinTypes_v0_1_c_ifspec as RPC_IF_HANDLE
extern IWinTypes_v0_1_s_ifspec as RPC_IF_HANDLE

type tagRemHGLOBAL
	fNullHGlobal as LONG
	cbData as ULONG
	data(0 to 0) as ubyte
end type

type RemHGLOBAL as tagRemHGLOBAL

type tagRemHMETAFILEPICT
	mm as LONG
	xExt as LONG
	yExt as LONG
	cbData as ULONG
	data(0 to 0) as ubyte
end type

type RemHMETAFILEPICT as tagRemHMETAFILEPICT

type tagRemHENHMETAFILE
	cbData as ULONG
	data(0 to 0) as ubyte
end type

type RemHENHMETAFILE as tagRemHENHMETAFILE

type tagRemHBITMAP
	cbData as ULONG
	data(0 to 0) as ubyte
end type

type RemHBITMAP as tagRemHBITMAP

type tagRemHPALETTE
	cbData as ULONG
	data(0 to 0) as ubyte
end type

type RemHPALETTE as tagRemHPALETTE

type tagRemBRUSH
	cbData as ULONG
	data(0 to 0) as ubyte
end type

type RemHBRUSH as tagRemBRUSH
#define _ROTFLAGS_DEFINED
const ROTFLAGS_REGISTRATIONKEEPSALIVE = &h1
const ROTFLAGS_ALLOWANYCLIENT = &h2
#define _ROT_COMPARE_MAX_DEFINED
const ROT_COMPARE_MAX = 2048

type tagDVASPECT as long
enum
	DVASPECT_CONTENT = 1
	DVASPECT_THUMBNAIL = 2
	DVASPECT_ICON = 4
	DVASPECT_DOCPRINT = 8
end enum

type DVASPECT as tagDVASPECT

type tagSTGC as long
enum
	STGC_DEFAULT = 0
	STGC_OVERWRITE = 1
	STGC_ONLYIFCURRENT = 2
	STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE = 4
	STGC_CONSOLIDATE = 8
end enum

type STGC as tagSTGC

type tagSTGMOVE as long
enum
	STGMOVE_MOVE = 0
	STGMOVE_COPY = 1
	STGMOVE_SHALLOWCOPY = 2
end enum

type STGMOVE as tagSTGMOVE

type tagSTATFLAG as long
enum
	STATFLAG_DEFAULT = 0
	STATFLAG_NONAME = 1
	STATFLAG_NOOPEN = 2
end enum

type STATFLAG as tagSTATFLAG
type HCONTEXT as any ptr
const WDT_INPROC_CALL = &h48746457
const WDT_REMOTE_CALL = &h52746457
const WDT_INPROC64_CALL = &h50746457

union _userCLIPFORMAT_u
	dwValue as DWORD
	pwszName as wstring ptr
end union

type _userCLIPFORMAT
	fContext as LONG
	u as _userCLIPFORMAT_u
end type

type userCLIPFORMAT as _userCLIPFORMAT
type wireCLIPFORMAT as userCLIPFORMAT ptr
type CLIPFORMAT as WORD

union _GDI_NONREMOTE_u
	hInproc as LONG
	hRemote as DWORD_BLOB ptr
end union

type _GDI_NONREMOTE
	fContext as LONG
	u as _GDI_NONREMOTE_u
end type

type GDI_NONREMOTE as _GDI_NONREMOTE

union _userHGLOBAL_u
	hInproc as LONG
	hRemote as FLAGGED_BYTE_BLOB ptr
	hInproc64 as INT64
end union

type _userHGLOBAL
	fContext as LONG
	u as _userHGLOBAL_u
end type

type userHGLOBAL as _userHGLOBAL
type wireHGLOBAL as userHGLOBAL ptr

union _userHMETAFILE_u
	hInproc as LONG
	hRemote as BYTE_BLOB ptr
	hInproc64 as INT64
end union

type _userHMETAFILE
	fContext as LONG
	u as _userHMETAFILE_u
end type

type userHMETAFILE as _userHMETAFILE

type _remoteMETAFILEPICT
	mm as LONG
	xExt as LONG
	yExt as LONG
	hMF as userHMETAFILE ptr
end type

type remoteMETAFILEPICT as _remoteMETAFILEPICT

union _userHMETAFILEPICT_u
	hInproc as LONG
	hRemote as remoteMETAFILEPICT ptr
	hInproc64 as INT64
end union

type _userHMETAFILEPICT
	fContext as LONG
	u as _userHMETAFILEPICT_u
end type

type userHMETAFILEPICT as _userHMETAFILEPICT

union _userHENHMETAFILE_u
	hInproc as LONG
	hRemote as BYTE_BLOB ptr
	hInproc64 as INT64
end union

type _userHENHMETAFILE
	fContext as LONG
	u as _userHENHMETAFILE_u
end type

type userHENHMETAFILE as _userHENHMETAFILE

type _userBITMAP
	bmType as LONG
	bmWidth as LONG
	bmHeight as LONG
	bmWidthBytes as LONG
	bmPlanes as WORD
	bmBitsPixel as WORD
	cbSize as ULONG
	pBuffer(0 to 0) as ubyte
end type

type userBITMAP as _userBITMAP

union _userHBITMAP_u
	hInproc as LONG
	hRemote as userBITMAP ptr
	hInproc64 as INT64
end union

type _userHBITMAP
	fContext as LONG
	u as _userHBITMAP_u
end type

type userHBITMAP as _userHBITMAP

union _userHPALETTE_u
	hInproc as LONG
	hRemote as LOGPALETTE ptr
	hInproc64 as INT64
end union

type _userHPALETTE
	fContext as LONG
	u as _userHPALETTE_u
end type

type userHPALETTE as _userHPALETTE

union _RemotableHandle_u
	hInproc as LONG
	hRemote as LONG
end union

type _RemotableHandle
	fContext as LONG
	u as _RemotableHandle_u
end type

type RemotableHandle as _RemotableHandle
type wireHWND as RemotableHandle ptr
type wireHMENU as RemotableHandle ptr
type wireHACCEL as RemotableHandle ptr
type wireHBRUSH as RemotableHandle ptr
type wireHFONT as RemotableHandle ptr
type wireHDC as RemotableHandle ptr
type wireHICON as RemotableHandle ptr
type wireHRGN as RemotableHandle ptr
type wireHMONITOR as RemotableHandle ptr
type wireHBITMAP as userHBITMAP ptr
type wireHPALETTE as userHPALETTE ptr
type wireHENHMETAFILE as userHENHMETAFILE ptr
type wireHMETAFILE as userHMETAFILE ptr
type wireHMETAFILEPICT as userHMETAFILEPICT ptr
type HMETAFILEPICT as any ptr
type DATE_ as double
#define _tagCY_DEFINED
#define _CY_DEFINED

union tagCY
	type
		Lo as ulong
		Hi as long
	end type

	int64 as LONGLONG
end union

type CY as tagCY
type LPCY as CY ptr

type tagDEC
	wReserved as USHORT

	union
		type
			scale as UBYTE
			sign as UBYTE
		end type

		signscale as USHORT
	end union

	Hi32 as ULONG

	union
		type
			Lo32 as ULONG
			Mid32 as ULONG
		end type

		Lo64 as ULONGLONG
	end union
end type

type DECIMAL as tagDEC
const DECIMAL_NEG = cast(UBYTE, &h80)
#macro DECIMAL_SETZERO(dec)
	scope
		(dec).Lo64 = 0
		(dec).Hi32 = 0
		(dec).signscale = 0
	end scope
#endmacro
type LPDECIMAL as DECIMAL ptr
type wireBSTR as FLAGGED_WORD_BLOB ptr
type BSTR as OLECHAR ptr
type LPBSTR as BSTR ptr
type VARIANT_BOOL as short
#define _tagBSTRBLOB_DEFINED

type tagBSTRBLOB
	cbSize as ULONG
	pData as UBYTE ptr
end type

type BSTRBLOB as tagBSTRBLOB
type LPBSTRBLOB as tagBSTRBLOB ptr
const VARIANT_TRUE = cast(VARIANT_BOOL, -1)
const VARIANT_FALSE = cast(VARIANT_BOOL, 0)

type tagCLIPDATA
	cbSize as ULONG
	ulClipFmt as LONG
	pClipData as UBYTE ptr
end type

type CLIPDATA as tagCLIPDATA
#define CBPCLIPDATA(clipdata) ((clipdata).cbSize - sizeof((clipdata).ulClipFmt))
type VARTYPE as ushort

type VARENUM as long
enum
	VT_EMPTY = 0
	VT_NULL = 1
	VT_I2 = 2
	VT_I4 = 3
	VT_R4 = 4
	VT_R8 = 5
	VT_CY = 6
	VT_DATE = 7
	VT_BSTR = 8
	VT_DISPATCH = 9
	VT_ERROR = 10
	VT_BOOL = 11
	VT_VARIANT = 12
	VT_UNKNOWN = 13
	VT_DECIMAL = 14
	VT_I1 = 16
	VT_UI1 = 17
	VT_UI2 = 18
	VT_UI4 = 19
	VT_I8 = 20
	VT_UI8 = 21
	VT_INT = 22
	VT_UINT = 23
	VT_VOID = 24
	VT_HRESULT = 25
	VT_PTR = 26
	VT_SAFEARRAY = 27
	VT_CARRAY = 28
	VT_USERDEFINED = 29
	VT_LPSTR = 30
	VT_LPWSTR = 31
	VT_RECORD = 36
	VT_INT_PTR = 37
	VT_UINT_PTR = 38
	VT_FILETIME = 64
	VT_BLOB = 65
	VT_STREAM = 66
	VT_STORAGE = 67
	VT_STREAMED_OBJECT = 68
	VT_STORED_OBJECT = 69
	VT_BLOB_OBJECT = 70
	VT_CF = 71
	VT_CLSID = 72
	VT_VERSIONED_STREAM = 73
	VT_BSTR_BLOB = &hfff
	VT_VECTOR = &h1000
	VT_ARRAY = &h2000
	VT_BYREF = &h4000
	VT_RESERVED = &h8000
	VT_ILLEGAL = &hffff
	VT_ILLEGALMASKED = &hfff
	VT_TYPEMASK = &hfff
end enum

type PROPID as ULONG
#define PROPERTYKEY_DEFINED

type _tagpropertykey
	fmtid as GUID
	pid as DWORD
end type

type PROPERTYKEY as _tagpropertykey

type tagCSPLATFORM
	dwPlatformId as DWORD
	dwVersionHi as DWORD
	dwVersionLo as DWORD
	dwProcessorArch as DWORD
end type

type CSPLATFORM as tagCSPLATFORM

type tagQUERYCONTEXT
	dwContext as DWORD
	Platform as CSPLATFORM
	Locale as LCID
	dwVersionHi as DWORD
	dwVersionLo as DWORD
end type

type QUERYCONTEXT as tagQUERYCONTEXT

type tagTYSPEC as long
enum
	TYSPEC_CLSID = 0
	TYSPEC_FILEEXT = 1
	TYSPEC_MIMETYPE = 2
	TYSPEC_FILENAME = 3
	TYSPEC_PROGID = 4
	TYSPEC_PACKAGENAME = 5
	TYSPEC_OBJECTID = 6
end enum

type TYSPEC as tagTYSPEC

type __WIDL_wtypes_generated_name_00000001_tagged_union_ByName
	pPackageName as LPOLESTR
	PolicyId as GUID
end type

type __WIDL_wtypes_generated_name_00000001_tagged_union_ByObjectId
	ObjectId as GUID
	PolicyId as GUID
end type

union __WIDL_wtypes_generated_name_00000001_tagged_union
	clsid as CLSID
	pFileExt as LPOLESTR
	pMimeType as LPOLESTR
	pProgId as LPOLESTR
	pFileName as LPOLESTR
	ByName as __WIDL_wtypes_generated_name_00000001_tagged_union_ByName
	ByObjectId as __WIDL_wtypes_generated_name_00000001_tagged_union_ByObjectId
end union

type __WIDL_wtypes_generated_name_00000001
	tyspec as DWORD
	tagged_union as __WIDL_wtypes_generated_name_00000001_tagged_union
end type

type uCLSSPEC as __WIDL_wtypes_generated_name_00000001

end extern
