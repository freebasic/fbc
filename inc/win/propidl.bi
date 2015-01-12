#pragma once

'' The following symbols have been renamed:
''     inside struct IPropertySetStorageVtbl:
''         field Delete => Delete__
''     inside struct tagSERIALIZEDPROPERTYVALUE:
''         field rgb => rgb_

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "wtypes.bi"
#include once "objidl.bi"
#include once "oaidl.bi"
#include once "winapifamily.bi"

extern "Windows"

type IPropertyStorage as IPropertyStorage_
type IPropertySetStorage as IPropertySetStorage_
type IEnumSTATPROPSTG as IEnumSTATPROPSTG_
type IEnumSTATPROPSETSTG as IEnumSTATPROPSETSTG_

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

#define PROPSETFLAG_DEFAULT 0
#define PROPSETFLAG_NONSIMPLE 1
#define PROPSETFLAG_ANSI 2
#define PROPSETFLAG_UNBUFFERED 4
#define PROPSETFLAG_CASE_SENSITIVE 8
#define PROPSET_BEHAVIOR_CASE_SENSITIVE 1

type tagCAC
	cElems as ULONG
	pElems as zstring ptr
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
				cVal as byte
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
				pcVal as zstring ptr
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
#define PID_DICTIONARY &h0
#define PID_CODEPAGE &h1
#define PID_FIRST_USABLE &h2
#define PID_FIRST_NAME_DEFAULT &hfff
#define PID_LOCALE &h80000000
#define PID_MODIFY_TIME &h80000001
#define PID_SECURITY &h80000002
#define PID_BEHAVIOR &h80000003
#define PID_ILLEGAL &hffffffff
#define PID_MIN_READONLY &h80000000
#define PID_MAX_READONLY &hbfffffff
#define PIDDI_THUMBNAIL __MSABI_LONG(&h2)
#define PIDSI_TITLE __MSABI_LONG(&h2)
#define PIDSI_SUBJECT __MSABI_LONG(&h3)
#define PIDSI_AUTHOR __MSABI_LONG(&h4)
#define PIDSI_KEYWORDS __MSABI_LONG(&h5)
#define PIDSI_COMMENTS __MSABI_LONG(&h6)
#define PIDSI_TEMPLATE __MSABI_LONG(&h7)
#define PIDSI_LASTAUTHOR __MSABI_LONG(&h8)
#define PIDSI_REVNUMBER __MSABI_LONG(&h9)
#define PIDSI_EDITTIME __MSABI_LONG(&ha)
#define PIDSI_LASTPRINTED __MSABI_LONG(&hb)
#define PIDSI_CREATE_DTM __MSABI_LONG(&hc)
#define PIDSI_LASTSAVE_DTM __MSABI_LONG(&hd)
#define PIDSI_PAGECOUNT __MSABI_LONG(&he)
#define PIDSI_WORDCOUNT __MSABI_LONG(&hf)
#define PIDSI_CHARCOUNT __MSABI_LONG(&h10)
#define PIDSI_THUMBNAIL __MSABI_LONG(&h11)
#define PIDSI_APPNAME __MSABI_LONG(&h12)
#define PIDSI_DOC_SECURITY __MSABI_LONG(&h13)
#define PIDDSI_CATEGORY &h00000002
#define PIDDSI_PRESFORMAT &h00000003
#define PIDDSI_BYTECOUNT &h00000004
#define PIDDSI_LINECOUNT &h00000005
#define PIDDSI_PARCOUNT &h00000006
#define PIDDSI_SLIDECOUNT &h00000007
#define PIDDSI_NOTECOUNT &h00000008
#define PIDDSI_HIDDENCOUNT &h00000009
#define PIDDSI_MMCLIPCOUNT &h0000000A
#define PIDDSI_SCALE &h0000000B
#define PIDDSI_HEADINGPAIR &h0000000C
#define PIDDSI_DOCPARTS &h0000000D
#define PIDDSI_MANAGER &h0000000E
#define PIDDSI_COMPANY &h0000000F
#define PIDDSI_LINKSDIRTY &h00000010
#define PIDMSI_EDITOR __MSABI_LONG(&h2)
#define PIDMSI_SUPPLIER __MSABI_LONG(&h3)
#define PIDMSI_SOURCE __MSABI_LONG(&h4)
#define PIDMSI_SEQUENCE_NO __MSABI_LONG(&h5)
#define PIDMSI_PROJECT __MSABI_LONG(&h6)
#define PIDMSI_STATUS __MSABI_LONG(&h7)
#define PIDMSI_OWNER __MSABI_LONG(&h8)
#define PIDMSI_RATING __MSABI_LONG(&h9)
#define PIDMSI_PRODUCTION __MSABI_LONG(&ha)
#define PIDMSI_COPYRIGHT __MSABI_LONG(&hb)

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

#define PRSPEC_INVALID &hffffffff
#define PRSPEC_LPWSTR 0
#define PRSPEC_PROPID 1

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
#define PROPSETHDR_OSVERSION_UNKNOWN &hffffffff

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

type LPPROPERTYSETSTORAGE as IPropertySetStorage ptr

extern IID_IPropertySetStorage as const GUID

type IPropertySetStorageVtbl
	QueryInterface as function(byval This as IPropertySetStorage ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPropertySetStorage ptr) as ULONG
	Release as function(byval This as IPropertySetStorage ptr) as ULONG
	Create as function(byval This as IPropertySetStorage ptr, byval rfmtid as const IID const ptr, byval pclsid as const CLSID ptr, byval grfFlags as DWORD, byval grfMode as DWORD, byval ppprstg as IPropertyStorage ptr ptr) as HRESULT
	Open as function(byval This as IPropertySetStorage ptr, byval rfmtid as const IID const ptr, byval grfMode as DWORD, byval ppprstg as IPropertyStorage ptr ptr) as HRESULT
	Delete__ as function(byval This as IPropertySetStorage ptr, byval rfmtid as const IID const ptr) as HRESULT
	as function(byval This as IPropertySetStorage ptr, byval ppenum as IEnumSTATPROPSETSTG ptr ptr) as HRESULT Enum
end type

type IPropertySetStorage_
	lpVtbl as IPropertySetStorageVtbl ptr
end type

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

#define _PROPVARIANTINIT_DEFINED_
#define PropVariantInit(pvar) memset((pvar), 0, sizeof(PROPVARIANT))

declare function StgCreatePropStg(byval pUnk as IUnknown ptr, byval fmtid as const IID const ptr, byval pclsid as const CLSID ptr, byval grfFlags as DWORD, byval dwReserved as DWORD, byval ppPropStg as IPropertyStorage ptr ptr) as HRESULT
declare function StgOpenPropStg(byval pUnk as IUnknown ptr, byval fmtid as const IID const ptr, byval grfFlags as DWORD, byval dwReserved as DWORD, byval ppPropStg as IPropertyStorage ptr ptr) as HRESULT
declare function StgCreatePropSetStg(byval pStorage as IStorage ptr, byval dwReserved as DWORD, byval ppPropSetStg as IPropertySetStorage ptr ptr) as HRESULT

#define CCH_MAX_PROPSTG_NAME 31

declare function FmtIdToPropStgName(byval pfmtid as const FMTID ptr, byval oszName as LPOLESTR) as HRESULT
declare function PropStgNameToFmtId(byval oszName as const LPOLESTR, byval pfmtid as FMTID ptr) as HRESULT

#define _SERIALIZEDPROPERTYVALUE_DEFINED_

type tagSERIALIZEDPROPERTYVALUE
	dwType as DWORD
	rgb_(0 to 0) as UBYTE
end type

type SERIALIZEDPROPERTYVALUE as tagSERIALIZEDPROPERTYVALUE

declare function StgConvertVariantToProperty(byval pvar as const PROPVARIANT ptr, byval CodePage as USHORT, byval pprop as SERIALIZEDPROPERTYVALUE ptr, byval pcb as ULONG ptr, byval pid as PROPID, byval fReserved as BOOLEAN, byval pcIndirect as ULONG ptr) as SERIALIZEDPROPERTYVALUE ptr
declare function LPSAFEARRAY_UserSize(byval as ULONG ptr, byval as ULONG, byval as LPSAFEARRAY ptr) as ULONG
declare function LPSAFEARRAY_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPSAFEARRAY ptr) as ubyte ptr
declare function LPSAFEARRAY_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as LPSAFEARRAY ptr) as ubyte ptr
declare sub LPSAFEARRAY_UserFree(byval as ULONG ptr, byval as LPSAFEARRAY ptr)

end extern
