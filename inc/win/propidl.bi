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
#include once "wtypes.bi"
#include once "objidl.bi"
#include once "oaidl.bi"
#include once "winapifamily.bi"

extern "Windows"

#define __propidl_h__
#define __IPropertyStorage_FWD_DEFINED__
#define __IPropertySetStorage_FWD_DEFINED__
#define __IEnumSTATPROPSTG_FWD_DEFINED__
#define __IEnumSTATPROPSETSTG_FWD_DEFINED__

type tagVersionedStream
	guidVersion as GUID
	pStream as IStream ptr
end type

type VERSIONEDSTREAM as tagVersionedStream
type LPVERSIONEDSTREAM as tagVersionedStream ptr
const PROPSETFLAG_DEFAULT = 0
const PROPSETFLAG_NONSIMPLE = 1
const PROPSETFLAG_ANSI = 2
const PROPSETFLAG_UNBUFFERED = 4
const PROPSETFLAG_CASE_SENSITIVE = 8
const PROPSET_BEHAVIOR_CASE_SENSITIVE = 1
type PROPVARIANT as tagPROPVARIANT

type tagCAC
	cElems as ULONG
	pElems as CHAR ptr
end type

type CAC as tagCAC

type tagCAUB
	cElems as ULONG
	pElems as UCHAR ptr
end type

type CAUB as tagCAUB

type tagCAI
	cElems as ULONG
	pElems as SHORT ptr
end type

type CAI as tagCAI

type tagCAUI
	cElems as ULONG
	pElems as USHORT ptr
end type

type CAUI as tagCAUI

type tagCAL
	cElems as ULONG
	pElems as LONG ptr
end type

type CAL as tagCAL

type tagCAUL
	cElems as ULONG
	pElems as ULONG ptr
end type

type CAUL as tagCAUL

type tagCAFLT
	cElems as ULONG
	pElems as FLOAT ptr
end type

type CAFLT as tagCAFLT

type tagCADBL
	cElems as ULONG
	pElems as DOUBLE ptr
end type

type CADBL as tagCADBL

type tagCACY
	cElems as ULONG
	pElems as CY ptr
end type

type CACY as tagCACY

type tagCADATE
	cElems as ULONG
	pElems as DATE_ ptr
end type

type CADATE as tagCADATE

type tagCABSTR
	cElems as ULONG
	pElems as BSTR ptr
end type

type CABSTR as tagCABSTR

type tagCABSTRBLOB
	cElems as ULONG
	pElems as BSTRBLOB ptr
end type

type CABSTRBLOB as tagCABSTRBLOB

type tagCABOOL
	cElems as ULONG
	pElems as VARIANT_BOOL ptr
end type

type CABOOL as tagCABOOL

type tagCASCODE
	cElems as ULONG
	pElems as SCODE ptr
end type

type CASCODE as tagCASCODE

type tagCAPROPVARIANT
	cElems as ULONG
	pElems as PROPVARIANT ptr
end type

type CAPROPVARIANT as tagCAPROPVARIANT

type tagCAH
	cElems as ULONG
	pElems as LARGE_INTEGER ptr
end type

type CAH as tagCAH

type tagCAUH
	cElems as ULONG
	pElems as ULARGE_INTEGER ptr
end type

type CAUH as tagCAUH

type tagCALPSTR
	cElems as ULONG
	pElems as LPSTR ptr
end type

type CALPSTR as tagCALPSTR

type tagCALPWSTR
	cElems as ULONG
	pElems as LPWSTR ptr
end type

type CALPWSTR as tagCALPWSTR

type tagCAFILETIME
	cElems as ULONG
	pElems as FILETIME ptr
end type

type CAFILETIME as tagCAFILETIME

type tagCACLIPDATA
	cElems as ULONG
	pElems as CLIPDATA ptr
end type

type CACLIPDATA as tagCACLIPDATA

type tagCACLSID
	cElems as ULONG
	pElems as CLSID ptr
end type

type CACLSID as tagCACLSID
type PROPVAR_PAD1 as WORD
type PROPVAR_PAD2 as WORD
type PROPVAR_PAD3 as WORD
#define tag_inner_PROPVARIANT

type tagPROPVARIANT
	union
		type
			vt as VARTYPE
			wReserved1 as PROPVAR_PAD1
			wReserved2 as PROPVAR_PAD2
			wReserved3 as PROPVAR_PAD3

			union
				cVal as CHAR
				bVal as UCHAR
				iVal as SHORT
				uiVal as USHORT
				lVal as LONG
				ulVal as ULONG
				intVal as INT_
				uintVal as UINT
				hVal as LARGE_INTEGER
				uhVal as ULARGE_INTEGER
				fltVal as FLOAT
				dblVal as DOUBLE
				boolVal as VARIANT_BOOL
				scode as SCODE
				cyVal as CY
				date as DATE_
				filetime as FILETIME
				puuid as CLSID ptr
				pclipdata as CLIPDATA ptr
				bstrVal as BSTR
				bstrblobVal as BSTRBLOB
				blob as BLOB
				pszVal as LPSTR
				pwszVal as LPWSTR
				punkVal as IUnknown ptr
				pdispVal as IDispatch ptr
				pStream as IStream ptr
				pStorage as IStorage ptr
				pVersionedStream as LPVERSIONEDSTREAM
				parray as LPSAFEARRAY
				cac as CAC
				caub as CAUB
				cai as CAI
				caui as CAUI
				cal as CAL
				caul as CAUL
				cah as CAH
				cauh as CAUH
				caflt as CAFLT
				cadbl as CADBL
				cabool as CABOOL
				cascode as CASCODE
				cacy as CACY
				cadate as CADATE
				cafiletime as CAFILETIME
				cauuid as CACLSID
				caclipdata as CACLIPDATA
				cabstr as CABSTR
				cabstrblob as CABSTRBLOB
				calpstr as CALPSTR
				calpwstr as CALPWSTR
				capropvar as CAPROPVARIANT
				pcVal as CHAR ptr
				pbVal as UCHAR ptr
				piVal as SHORT ptr
				puiVal as USHORT ptr
				plVal as LONG ptr
				pulVal as ULONG ptr
				pintVal as INT_ ptr
				puintVal as UINT ptr
				pfltVal as FLOAT ptr
				pdblVal as DOUBLE ptr
				pboolVal as VARIANT_BOOL ptr
				pdecVal as DECIMAL ptr
				pscode as SCODE ptr
				pcyVal as CY ptr
				pdate as DATE_ ptr
				pbstrVal as BSTR ptr
				ppunkVal as IUnknown ptr ptr
				ppdispVal as IDispatch ptr ptr
				pparray as LPSAFEARRAY ptr
				pvarVal as PROPVARIANT ptr
			end union
		end type

		decVal as DECIMAL
	end union
end type

type LPPROPVARIANT as tagPROPVARIANT ptr
#define _REFPROPVARIANT_DEFINED
type REFPROPVARIANT as const PROPVARIANT const ptr
const PID_DICTIONARY = &h0
const PID_CODEPAGE = &h1
const PID_FIRST_USABLE = &h2
const PID_FIRST_NAME_DEFAULT = &hfff
const PID_LOCALE = &h80000000
const PID_MODIFY_TIME = &h80000001
const PID_SECURITY = &h80000002
const PID_BEHAVIOR = &h80000003
const PID_ILLEGAL = &hffffffff
const PID_MIN_READONLY = &h80000000
const PID_MAX_READONLY = &hbfffffff
const PIDDI_THUMBNAIL = &h2
const PIDSI_TITLE = &h2
const PIDSI_SUBJECT = &h3
const PIDSI_AUTHOR = &h4
const PIDSI_KEYWORDS = &h5
const PIDSI_COMMENTS = &h6
const PIDSI_TEMPLATE = &h7
const PIDSI_LASTAUTHOR = &h8
const PIDSI_REVNUMBER = &h9
const PIDSI_EDITTIME = &ha
const PIDSI_LASTPRINTED = &hb
const PIDSI_CREATE_DTM = &hc
const PIDSI_LASTSAVE_DTM = &hd
const PIDSI_PAGECOUNT = &he
const PIDSI_WORDCOUNT = &hf
const PIDSI_CHARCOUNT = &h10
const PIDSI_THUMBNAIL = &h11
const PIDSI_APPNAME = &h12
const PIDSI_DOC_SECURITY = &h13
const PIDDSI_CATEGORY = &h00000002
const PIDDSI_PRESFORMAT = &h00000003
const PIDDSI_BYTECOUNT = &h00000004
const PIDDSI_LINECOUNT = &h00000005
const PIDDSI_PARCOUNT = &h00000006
const PIDDSI_SLIDECOUNT = &h00000007
const PIDDSI_NOTECOUNT = &h00000008
const PIDDSI_HIDDENCOUNT = &h00000009
const PIDDSI_MMCLIPCOUNT = &h0000000A
const PIDDSI_SCALE = &h0000000B
const PIDDSI_HEADINGPAIR = &h0000000C
const PIDDSI_DOCPARTS = &h0000000D
const PIDDSI_MANAGER = &h0000000E
const PIDDSI_COMPANY = &h0000000F
const PIDDSI_LINKSDIRTY = &h00000010
const PIDMSI_EDITOR = &h2
const PIDMSI_SUPPLIER = &h3
const PIDMSI_SOURCE = &h4
const PIDMSI_SEQUENCE_NO = &h5
const PIDMSI_PROJECT = &h6
const PIDMSI_STATUS = &h7
const PIDMSI_OWNER = &h8
const PIDMSI_RATING = &h9
const PIDMSI_PRODUCTION = &ha
const PIDMSI_COPYRIGHT = &hb

type PIDMSI_STATUS_VALUE as long
enum
	PIDMSI_STATUS_NORMAL = 0
	PIDMSI_STATUS_NEW = 1
	PIDMSI_STATUS_PRELIM = 2
	PIDMSI_STATUS_DRAFT = 3
	PIDMSI_STATUS_INPROGRESS = 4
	PIDMSI_STATUS_EDIT = 5
	PIDMSI_STATUS_REVIEW = 6
	PIDMSI_STATUS_PROOF = 7
	PIDMSI_STATUS_FINAL = 8
	PIDMSI_STATUS_OTHER = &h7fff
end enum

const PRSPEC_INVALID = &hffffffff
const PRSPEC_LPWSTR = 0
const PRSPEC_PROPID = 1

type tagPROPSPEC
	ulKind as ULONG

	union
		propid as PROPID
		lpwstr as LPOLESTR
	end union
end type

type PROPSPEC as tagPROPSPEC

type tagSTATPROPSTG
	lpwstrName as LPOLESTR
	propid as PROPID
	vt as VARTYPE
end type

type STATPROPSTG as tagSTATPROPSTG
#define PROPSETHDR_OSVER_KIND(dwOSVer) HIWORD((dwOSVer))
#define PROPSETHDR_OSVER_MAJOR(dwOSVer) LOBYTE(LOWORD((dwOSVer)))
#define PROPSETHDR_OSVER_MINOR(dwOSVer) HIBYTE(LOWORD((dwOSVer)))
const PROPSETHDR_OSVERSION_UNKNOWN = &hffffffff

type tagSTATPROPSETSTG
	fmtid as FMTID
	clsid as CLSID
	grfFlags as DWORD
	mtime as FILETIME
	ctime as FILETIME
	atime as FILETIME
	dwOSVersion as DWORD
end type

type STATPROPSETSTG as tagSTATPROPSETSTG
#define __IPropertyStorage_INTERFACE_DEFINED__
extern IID_IPropertyStorage as const GUID
type IPropertyStorage as IPropertyStorage_
type IEnumSTATPROPSTG as IEnumSTATPROPSTG_

type IPropertyStorageVtbl
	QueryInterface as function(byval This as IPropertyStorage ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertyStorage ptr) as ULONG
	Release as function(byval This as IPropertyStorage ptr) as ULONG
	ReadMultiple as function(byval This as IPropertyStorage ptr, byval cpspec as ULONG, byval rgpspec as const PROPSPEC ptr, byval rgpropvar as PROPVARIANT ptr) as HRESULT
	WriteMultiple as function(byval This as IPropertyStorage ptr, byval cpspec as ULONG, byval rgpspec as const PROPSPEC ptr, byval rgpropvar as const PROPVARIANT ptr, byval propidNameFirst as PROPID) as HRESULT
	DeleteMultiple as function(byval This as IPropertyStorage ptr, byval cpspec as ULONG, byval rgpspec as const PROPSPEC ptr) as HRESULT
	ReadPropertyNames as function(byval This as IPropertyStorage ptr, byval cpropid as ULONG, byval rgpropid as const PROPID ptr, byval rglpwstrName as LPOLESTR ptr) as HRESULT
	WritePropertyNames as function(byval This as IPropertyStorage ptr, byval cpropid as ULONG, byval rgpropid as const PROPID ptr, byval rglpwstrName as const LPOLESTR ptr) as HRESULT
	DeletePropertyNames as function(byval This as IPropertyStorage ptr, byval cpropid as ULONG, byval rgpropid as const PROPID ptr) as HRESULT
	Commit as function(byval This as IPropertyStorage ptr, byval grfCommitFlags as DWORD) as HRESULT
	Revert as function(byval This as IPropertyStorage ptr) as HRESULT
	as function(byval This as IPropertyStorage ptr, byval ppenum as IEnumSTATPROPSTG ptr ptr) as HRESULT Enum
	SetTimes as function(byval This as IPropertyStorage ptr, byval pctime as const FILETIME ptr, byval patime as const FILETIME ptr, byval pmtime as const FILETIME ptr) as HRESULT
	SetClass as function(byval This as IPropertyStorage ptr, byval clsid as const IID const ptr) as HRESULT
	Stat as function(byval This as IPropertyStorage ptr, byval pstatpsstg as STATPROPSETSTG ptr) as HRESULT
end type

type IPropertyStorage_
	lpVtbl as IPropertyStorageVtbl ptr
end type

#define IPropertyStorage_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertyStorage_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertyStorage_Release(This) (This)->lpVtbl->Release(This)
#define IPropertyStorage_ReadMultiple(This, cpspec, rgpspec, rgpropvar) (This)->lpVtbl->ReadMultiple(This, cpspec, rgpspec, rgpropvar)
#define IPropertyStorage_WriteMultiple(This, cpspec, rgpspec, rgpropvar, propidNameFirst) (This)->lpVtbl->WriteMultiple(This, cpspec, rgpspec, rgpropvar, propidNameFirst)
#define IPropertyStorage_DeleteMultiple(This, cpspec, rgpspec) (This)->lpVtbl->DeleteMultiple(This, cpspec, rgpspec)
#define IPropertyStorage_ReadPropertyNames(This, cpropid, rgpropid, rglpwstrName) (This)->lpVtbl->ReadPropertyNames(This, cpropid, rgpropid, rglpwstrName)
#define IPropertyStorage_WritePropertyNames(This, cpropid, rgpropid, rglpwstrName) (This)->lpVtbl->WritePropertyNames(This, cpropid, rgpropid, rglpwstrName)
#define IPropertyStorage_DeletePropertyNames(This, cpropid, rgpropid) (This)->lpVtbl->DeletePropertyNames(This, cpropid, rgpropid)
#define IPropertyStorage_Commit(This, grfCommitFlags) (This)->lpVtbl->Commit(This, grfCommitFlags)
#define IPropertyStorage_Revert(This) (This)->lpVtbl->Revert(This)
#define IPropertyStorage_Enum(This, ppenum) (This)->lpVtbl->Enum(This, ppenum)
#define IPropertyStorage_SetTimes(This, pctime, patime, pmtime) (This)->lpVtbl->SetTimes(This, pctime, patime, pmtime)
#define IPropertyStorage_SetClass(This, clsid) (This)->lpVtbl->SetClass(This, clsid)
#define IPropertyStorage_Stat(This, pstatpsstg) (This)->lpVtbl->Stat(This, pstatpsstg)

declare function IPropertyStorage_ReadMultiple_Proxy(byval This as IPropertyStorage ptr, byval cpspec as ULONG, byval rgpspec as const PROPSPEC ptr, byval rgpropvar as PROPVARIANT ptr) as HRESULT
declare sub IPropertyStorage_ReadMultiple_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStorage_WriteMultiple_Proxy(byval This as IPropertyStorage ptr, byval cpspec as ULONG, byval rgpspec as const PROPSPEC ptr, byval rgpropvar as const PROPVARIANT ptr, byval propidNameFirst as PROPID) as HRESULT
declare sub IPropertyStorage_WriteMultiple_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStorage_DeleteMultiple_Proxy(byval This as IPropertyStorage ptr, byval cpspec as ULONG, byval rgpspec as const PROPSPEC ptr) as HRESULT
declare sub IPropertyStorage_DeleteMultiple_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStorage_ReadPropertyNames_Proxy(byval This as IPropertyStorage ptr, byval cpropid as ULONG, byval rgpropid as const PROPID ptr, byval rglpwstrName as LPOLESTR ptr) as HRESULT
declare sub IPropertyStorage_ReadPropertyNames_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStorage_WritePropertyNames_Proxy(byval This as IPropertyStorage ptr, byval cpropid as ULONG, byval rgpropid as const PROPID ptr, byval rglpwstrName as const LPOLESTR ptr) as HRESULT
declare sub IPropertyStorage_WritePropertyNames_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStorage_DeletePropertyNames_Proxy(byval This as IPropertyStorage ptr, byval cpropid as ULONG, byval rgpropid as const PROPID ptr) as HRESULT
declare sub IPropertyStorage_DeletePropertyNames_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStorage_Commit_Proxy(byval This as IPropertyStorage ptr, byval grfCommitFlags as DWORD) as HRESULT
declare sub IPropertyStorage_Commit_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStorage_Revert_Proxy(byval This as IPropertyStorage ptr) as HRESULT
declare sub IPropertyStorage_Revert_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStorage_Enum_Proxy(byval This as IPropertyStorage ptr, byval ppenum as IEnumSTATPROPSTG ptr ptr) as HRESULT
declare sub IPropertyStorage_Enum_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStorage_SetTimes_Proxy(byval This as IPropertyStorage ptr, byval pctime as const FILETIME ptr, byval patime as const FILETIME ptr, byval pmtime as const FILETIME ptr) as HRESULT
declare sub IPropertyStorage_SetTimes_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStorage_SetClass_Proxy(byval This as IPropertyStorage ptr, byval clsid as const IID const ptr) as HRESULT
declare sub IPropertyStorage_SetClass_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertyStorage_Stat_Proxy(byval This as IPropertyStorage ptr, byval pstatpsstg as STATPROPSETSTG ptr) as HRESULT
declare sub IPropertyStorage_Stat_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IPropertySetStorage_INTERFACE_DEFINED__
type IPropertySetStorage as IPropertySetStorage_
type LPPROPERTYSETSTORAGE as IPropertySetStorage ptr
extern IID_IPropertySetStorage as const GUID
type IEnumSTATPROPSETSTG as IEnumSTATPROPSETSTG_

type IPropertySetStorageVtbl
	QueryInterface as function(byval This as IPropertySetStorage ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertySetStorage ptr) as ULONG
	Release as function(byval This as IPropertySetStorage ptr) as ULONG
	Create as function(byval This as IPropertySetStorage ptr, byval rfmtid as const IID const ptr, byval pclsid as const CLSID ptr, byval grfFlags as DWORD, byval grfMode as DWORD, byval ppprstg as IPropertyStorage ptr ptr) as HRESULT
	Open as function(byval This as IPropertySetStorage ptr, byval rfmtid as const IID const ptr, byval grfMode as DWORD, byval ppprstg as IPropertyStorage ptr ptr) as HRESULT
	Delete_ as function(byval This as IPropertySetStorage ptr, byval rfmtid as const IID const ptr) as HRESULT
	as function(byval This as IPropertySetStorage ptr, byval ppenum as IEnumSTATPROPSETSTG ptr ptr) as HRESULT Enum
end type

type IPropertySetStorage_
	lpVtbl as IPropertySetStorageVtbl ptr
end type

#define IPropertySetStorage_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IPropertySetStorage_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPropertySetStorage_Release(This) (This)->lpVtbl->Release(This)
#define IPropertySetStorage_Create(This, rfmtid, pclsid, grfFlags, grfMode, ppprstg) (This)->lpVtbl->Create(This, rfmtid, pclsid, grfFlags, grfMode, ppprstg)
#define IPropertySetStorage_Open(This, rfmtid, grfMode, ppprstg) (This)->lpVtbl->Open(This, rfmtid, grfMode, ppprstg)
#define IPropertySetStorage_Delete(This, rfmtid) (This)->lpVtbl->Delete_(This, rfmtid)
#define IPropertySetStorage_Enum(This, ppenum) (This)->lpVtbl->Enum(This, ppenum)

declare function IPropertySetStorage_Create_Proxy(byval This as IPropertySetStorage ptr, byval rfmtid as const IID const ptr, byval pclsid as const CLSID ptr, byval grfFlags as DWORD, byval grfMode as DWORD, byval ppprstg as IPropertyStorage ptr ptr) as HRESULT
declare sub IPropertySetStorage_Create_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertySetStorage_Open_Proxy(byval This as IPropertySetStorage ptr, byval rfmtid as const IID const ptr, byval grfMode as DWORD, byval ppprstg as IPropertyStorage ptr ptr) as HRESULT
declare sub IPropertySetStorage_Open_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertySetStorage_Delete_Proxy(byval This as IPropertySetStorage ptr, byval rfmtid as const IID const ptr) as HRESULT
declare sub IPropertySetStorage_Delete_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IPropertySetStorage_Enum_Proxy(byval This as IPropertySetStorage ptr, byval ppenum as IEnumSTATPROPSETSTG ptr ptr) as HRESULT
declare sub IPropertySetStorage_Enum_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IEnumSTATPROPSTG_INTERFACE_DEFINED__
type LPENUMSTATPROPSTG as IEnumSTATPROPSTG ptr
extern IID_IEnumSTATPROPSTG as const GUID

type IEnumSTATPROPSTGVtbl
	QueryInterface as function(byval This as IEnumSTATPROPSTG ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumSTATPROPSTG ptr) as ULONG
	Release as function(byval This as IEnumSTATPROPSTG ptr) as ULONG
	Next as function(byval This as IEnumSTATPROPSTG ptr, byval celt as ULONG, byval rgelt as STATPROPSTG ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumSTATPROPSTG ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumSTATPROPSTG ptr) as HRESULT
	Clone as function(byval This as IEnumSTATPROPSTG ptr, byval ppenum as IEnumSTATPROPSTG ptr ptr) as HRESULT
end type

type IEnumSTATPROPSTG_
	lpVtbl as IEnumSTATPROPSTGVtbl ptr
end type

#define IEnumSTATPROPSTG_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumSTATPROPSTG_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumSTATPROPSTG_Release(This) (This)->lpVtbl->Release(This)
#define IEnumSTATPROPSTG_Next(This, celt, rgelt, pceltFetched) (This)->lpVtbl->Next(This, celt, rgelt, pceltFetched)
#define IEnumSTATPROPSTG_Skip(This, celt) (This)->lpVtbl->Skip(This, celt)
#define IEnumSTATPROPSTG_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumSTATPROPSTG_Clone(This, ppenum) (This)->lpVtbl->Clone(This, ppenum)

declare function IEnumSTATPROPSTG_RemoteNext_Proxy(byval This as IEnumSTATPROPSTG ptr, byval celt as ULONG, byval rgelt as STATPROPSTG ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumSTATPROPSTG_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumSTATPROPSTG_Skip_Proxy(byval This as IEnumSTATPROPSTG ptr, byval celt as ULONG) as HRESULT
declare sub IEnumSTATPROPSTG_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumSTATPROPSTG_Reset_Proxy(byval This as IEnumSTATPROPSTG ptr) as HRESULT
declare sub IEnumSTATPROPSTG_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumSTATPROPSTG_Clone_Proxy(byval This as IEnumSTATPROPSTG ptr, byval ppenum as IEnumSTATPROPSTG ptr ptr) as HRESULT
declare sub IEnumSTATPROPSTG_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumSTATPROPSTG_Next_Proxy(byval This as IEnumSTATPROPSTG ptr, byval celt as ULONG, byval rgelt as STATPROPSTG ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare function IEnumSTATPROPSTG_Next_Stub(byval This as IEnumSTATPROPSTG ptr, byval celt as ULONG, byval rgelt as STATPROPSTG ptr, byval pceltFetched as ULONG ptr) as HRESULT
#define __IEnumSTATPROPSETSTG_INTERFACE_DEFINED__
type LPENUMSTATPROPSETSTG as IEnumSTATPROPSETSTG ptr
extern IID_IEnumSTATPROPSETSTG as const GUID

type IEnumSTATPROPSETSTGVtbl
	QueryInterface as function(byval This as IEnumSTATPROPSETSTG ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumSTATPROPSETSTG ptr) as ULONG
	Release as function(byval This as IEnumSTATPROPSETSTG ptr) as ULONG
	Next as function(byval This as IEnumSTATPROPSETSTG ptr, byval celt as ULONG, byval rgelt as STATPROPSETSTG ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumSTATPROPSETSTG ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumSTATPROPSETSTG ptr) as HRESULT
	Clone as function(byval This as IEnumSTATPROPSETSTG ptr, byval ppenum as IEnumSTATPROPSETSTG ptr ptr) as HRESULT
end type

type IEnumSTATPROPSETSTG_
	lpVtbl as IEnumSTATPROPSETSTGVtbl ptr
end type

#define IEnumSTATPROPSETSTG_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumSTATPROPSETSTG_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumSTATPROPSETSTG_Release(This) (This)->lpVtbl->Release(This)
#define IEnumSTATPROPSETSTG_Next(This, celt, rgelt, pceltFetched) (This)->lpVtbl->Next(This, celt, rgelt, pceltFetched)
#define IEnumSTATPROPSETSTG_Skip(This, celt) (This)->lpVtbl->Skip(This, celt)
#define IEnumSTATPROPSETSTG_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumSTATPROPSETSTG_Clone(This, ppenum) (This)->lpVtbl->Clone(This, ppenum)

declare function IEnumSTATPROPSETSTG_RemoteNext_Proxy(byval This as IEnumSTATPROPSETSTG ptr, byval celt as ULONG, byval rgelt as STATPROPSETSTG ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare sub IEnumSTATPROPSETSTG_RemoteNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumSTATPROPSETSTG_Skip_Proxy(byval This as IEnumSTATPROPSETSTG ptr, byval celt as ULONG) as HRESULT
declare sub IEnumSTATPROPSETSTG_Skip_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumSTATPROPSETSTG_Reset_Proxy(byval This as IEnumSTATPROPSETSTG ptr) as HRESULT
declare sub IEnumSTATPROPSETSTG_Reset_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumSTATPROPSETSTG_Clone_Proxy(byval This as IEnumSTATPROPSETSTG ptr, byval ppenum as IEnumSTATPROPSETSTG ptr ptr) as HRESULT
declare sub IEnumSTATPROPSETSTG_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumSTATPROPSETSTG_Next_Proxy(byval This as IEnumSTATPROPSETSTG ptr, byval celt as ULONG, byval rgelt as STATPROPSETSTG ptr, byval pceltFetched as ULONG ptr) as HRESULT
declare function IEnumSTATPROPSETSTG_Next_Stub(byval This as IEnumSTATPROPSETSTG ptr, byval celt as ULONG, byval rgelt as STATPROPSETSTG ptr, byval pceltFetched as ULONG ptr) as HRESULT
type LPPROPERTYSTORAGE as IPropertyStorage ptr
declare function PropVariantCopy(byval pvarDest as PROPVARIANT ptr, byval pvarSrc as const PROPVARIANT ptr) as HRESULT
declare function PropVariantClear(byval pvar as PROPVARIANT ptr) as HRESULT
declare function FreePropVariantArray(byval cVariants as ULONG, byval rgvars as PROPVARIANT ptr) as HRESULT
#define _PROPVARIANTINIT_DEFINED_
#define PropVariantInit(pvar) memset((pvar), 0, sizeof(PROPVARIANT))
declare function StgCreatePropStg(byval pUnk as IUnknown ptr, byval fmtid as const IID const ptr, byval pclsid as const CLSID ptr, byval grfFlags as DWORD, byval dwReserved as DWORD, byval ppPropStg as IPropertyStorage ptr ptr) as HRESULT
declare function StgOpenPropStg(byval pUnk as IUnknown ptr, byval fmtid as const IID const ptr, byval grfFlags as DWORD, byval dwReserved as DWORD, byval ppPropStg as IPropertyStorage ptr ptr) as HRESULT
declare function StgCreatePropSetStg(byval pStorage as IStorage ptr, byval dwReserved as DWORD, byval ppPropSetStg as IPropertySetStorage ptr ptr) as HRESULT
const CCH_MAX_PROPSTG_NAME = 31
declare function FmtIdToPropStgName(byval pfmtid as const FMTID ptr, byval oszName as LPOLESTR) as HRESULT
declare function PropStgNameToFmtId(byval oszName as const LPOLESTR, byval pfmtid as FMTID ptr) as HRESULT
#define _SERIALIZEDPROPERTYVALUE_DEFINED_

type tagSERIALIZEDPROPERTYVALUE
	dwType as DWORD
	rgb_(0 to 0) as UBYTE
end type

type SERIALIZEDPROPERTYVALUE as tagSERIALIZEDPROPERTYVALUE
declare function StgConvertVariantToProperty(byval pvar as const PROPVARIANT ptr, byval CodePage as USHORT, byval pprop as SERIALIZEDPROPERTYVALUE ptr, byval pcb as ULONG ptr, byval pid as PROPID, byval fReserved as WINBOOLEAN, byval pcIndirect as ULONG ptr) as SERIALIZEDPROPERTYVALUE ptr

end extern

#include once "ole-common.bi"
