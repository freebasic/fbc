''
''
'' objidl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __objidl_bi__
#define __objidl_bi__

#include once "win/objfwd.bi"

type STATSTG
	pwcsName as LPOLESTR
	type as DWORD
	cbSize as ULARGE_INTEGER
	mtime as FILETIME
	ctime as FILETIME
	atime as FILETIME
	grfMode as DWORD
	grfLocksSupported as DWORD
	clsid as CLSID
	grfStateBits as DWORD
	reserved as DWORD
end type

enum STGTY
	STGTY_STORAGE = 1
	STGTY_STREAM
	STGTY_LOCKBYTES
	STGTY_PROPERTY
end enum

enum STREAM_SEEK
	STREAM_SEEK_SET
	STREAM_SEEK_CUR
	STREAM_SEEK_END
end enum

type INTERFACEINFO
	pUnk as LPUNKNOWN
	iid as IID
	wMethod as WORD
end type

type LPINTERFACEINFO as INTERFACEINFO ptr

enum CALLTYPE
	CALLTYPE_TOPLEVEL = 1
	CALLTYPE_NESTED
	CALLTYPE_ASYNC
	CALLTYPE_TOPLEVEL_CALLPENDING
	CALLTYPE_ASYNC_CALLPENDING
end enum

enum PENDINGTYPE
	PENDINGTYPE_TOPLEVEL = 1
	PENDINGTYPE_NESTED
end enum

enum PENDINGMSG
	PENDINGMSG_CANCELCALL = 0
	PENDINGMSG_WAITNOPROCESS
	PENDINGMSG_WAITDEFPROCESS
end enum

type SNB as OLECHAR ptr ptr

enum DATADIR
	DATADIR_GET = 1
	DATADIR_SET
end enum

type CLIPFORMAT as WORD
type LPCLIPFORMAT as WORD ptr

type DVTARGETDEVICE
	tdSize as DWORD
	tdDriverNameOffset as WORD
	tdDeviceNameOffset as WORD
	tdPortNameOffset as WORD
	tdExtDevmodeOffset as WORD
	tdData(0 to 1-1) as BYTE
end type

type FORMATETC
	cfFormat as CLIPFORMAT
	ptd as DVTARGETDEVICE ptr
	dwAspect as DWORD
	lindex as LONG
	tymed as DWORD
end type

type LPFORMATETC as FORMATETC ptr

type RemSTGMEDIUM
	tymed as DWORD
	dwHandleType as DWORD
	pData as ULONG
	pUnkForRelease as uinteger
	cbData as uinteger
	data(0 to 1-1) as BYTE
end type

type HLITEM
	uHLID as ULONG
	pwzFriendlyName as LPWSTR
end type

type STATDATA
	formatetc as FORMATETC
	grfAdvf as DWORD
	pAdvSink as LPADVISESINK
	dwConnection as DWORD
end type

type STATPROPSETSTG
	fmtid as FMTID
	clsid as CLSID
	grfFlags as DWORD
	mtime as FILETIME
	ctime as FILETIME
	atime as FILETIME
end type

enum EXTCONN
	EXTCONN_STRONG = 1
	EXTCONN_WEAK = 2
	EXTCONN_CALLABLE = 4
end enum

type MULTI_QI
	pIID as IID ptr
	pItf as IUnknown ptr
	hr as HRESULT
end type

type AUTH_IDENTITY
	User as USHORT ptr
	UserLength as ULONG
	Domain as USHORT ptr
	DomainLength as ULONG
	Password as USHORT ptr
	PasswordLength as ULONG
	Flags as ULONG
end type

type COAUTHINFO
	dwAuthnSvc as DWORD
	dwAuthzSvc as DWORD
	pwszServerPrincName as LPWSTR
	dwAuthnLevel as DWORD
	dwImpersonationLevel as DWORD
	pAuthIdentityData as AUTH_IDENTITY ptr
	dwCapabilities as DWORD
end type

type COSERVERINFO
	dwReserved1 as DWORD
	pwszName as LPWSTR
	pAuthInfo as COAUTHINFO ptr
	dwReserved2 as DWORD
end type

type BIND_OPTS
	cbStruct as DWORD
	grfFlags as DWORD
	grfMode as DWORD
	dwTickCountDeadline as DWORD
end type

type LPBIND_OPTS as BIND_OPTS ptr

type BIND_OPTS2
	cbStruct as DWORD
	grfFlags as DWORD
	grfMode as DWORD
	dwTickCountDeadline as DWORD
	dwTrackFlags as DWORD
	dwClassContext as DWORD
	locale as LCID
	pServerInfo as COSERVERINFO ptr
end type

type LPBIND_OPTS2 as BIND_OPTS2 ptr

enum BIND_FLAGS
	BIND_MAYBOTHERUSER = 1
	BIND_JUSTTESTEXISTENCE
end enum

type STGMEDIUM
	tymed as DWORD
	union
		hBitmap as HBITMAP
		hMetaFilePict as PVOID
		hEnhMetaFile as HENHMETAFILE
		hGlobal as HGLOBAL
		lpszFileName as LPWSTR
		pstm as LPSTREAM
		pstg as LPSTORAGE
	end union
	pUnkForRelease as LPUNKNOWN
end type

type LPSTGMEDIUM as STGMEDIUM ptr

enum LOCKTYPE
	LOCK_WRITE = 1
	LOCK_EXCLUSIVE = 2
	LOCK_ONLYONCE = 4
end enum

type RPCOLEDATAREP as uinteger

type RPCOLEMESSAGE
	reserved1 as PVOID
	dataRepresentation as RPCOLEDATAREP
	Buffer as PVOID
	cbBuffer as ULONG
	iMethod as ULONG
	reserved2(0 to 5-1) as PVOID
	rpcFlags as ULONG
end type

enum MKSYS
	MKSYS_NONE
	MKSYS_GENERICCOMPOSITE
	MKSYS_FILEMONIKER
	MKSYS_ANTIMONIKER
	MKSYS_ITEMMONIKER
	MKSYS_POINTERMONIKER
end enum

enum MKREDUCE
	MKRREDUCE_ALL
	MKRREDUCE_ONE = 196608
	MKRREDUCE_TOUSER = 131072
	MKRREDUCE_THROUGHUSER = 65536
end enum

type RemSNB
	ulCntStr as uinteger
	ulCntChar as uinteger
	rgString(0 to 1-1) as OLECHAR
end type

enum ADVF
	ADVF_NODATA = 1
	ADVF_PRIMEFIRST = 2
	ADVF_ONLYONCE = 4
	ADVF_DATAONSTOP = 64
	ADVFCACHE_NOHANDLER = 8
	ADVFCACHE_FORCEBUILTIN = 16
	ADVFCACHE_ONSAVE = 32
end enum

enum TYMED
	TYMED_HGLOBAL = 1
	TYMED_FILE = 2
	TYMED_ISTREAM = 4
	TYMED_ISTORAGE = 8
	TYMED_GDI = 16
	TYMED_MFPICT = 32
	TYMED_ENHMF = 64
	TYMED_NULL = 0
end enum

enum SERVERCALL
	SERVERCALL_ISHANDLED
	SERVERCALL_REJECTED
	SERVERCALL_RETRYLATER
end enum

type CAUB
	cElems as ULONG
	pElems as ubyte ptr
end type

type CAI
	cElems as ULONG
	pElems as short ptr
end type

type CAUI
	cElems as ULONG
	pElems as USHORT ptr
end type

type CAL
	cElems as ULONG
	pElems as integer ptr
end type

type CAUL
	cElems as ULONG
	pElems as ULONG ptr
end type

type CAFLT
	cElems as ULONG
	pElems as single ptr
end type

type CADBL
	cElems as ULONG
	pElems as double ptr
end type

type CACY
	cElems as ULONG
	pElems as CY ptr
end type

type CADATE
	cElems as ULONG
	pElems as DATE_ ptr
end type

type CABSTR
	cElems as ULONG
	pElems as BSTR ptr
end type

type CABSTRBLOB
	cElems as ULONG
	pElems as BSTRBLOB ptr
end type

type CABOOL
	cElems as ULONG
	pElems as VARIANT_BOOL ptr
end type

type CASCODE
	cElems as ULONG
	pElems as SCODE ptr
end type

type CAH
	cElems as ULONG
	pElems as LARGE_INTEGER ptr
end type

type CAUH
	cElems as ULONG
	pElems as ULARGE_INTEGER ptr
end type

type CALPSTR
	cElems as ULONG
	pElems as LPSTR ptr
end type

type CALPWSTR
	cElems as ULONG
	pElems as LPWSTR ptr
end type

type CAFILETIME
	cElems as ULONG
	pElems as FILETIME ptr
end type

type CACLIPDATA
	cElems as ULONG
	pElems as CLIPDATA ptr
end type

type CACLSID
	cElems as ULONG
	pElems as CLSID ptr
end type

type LPPROPVARIANT as PROPVARIANT ptr

type CAPROPVARIANT
	cElems as ULONG
	pElems as LPPROPVARIANT
end type

type PROPVARIANT
	vt as VARTYPE
	wReserved1 as WORD
	wReserved2 as WORD
	wReserved3 as WORD
	union
		cVal as CHAR
		bVal as UCHAR
		iVal as short
		uiVal as USHORT
		boolVal as VARIANT_BOOL
		lVal as integer
		ulVal as ULONG
		fltVal as single
		scode as SCODE
		hVal as LARGE_INTEGER
		uhVal as ULARGE_INTEGER
		dblVal as double
		cyVal as CY
		date as DATE_
		filetime as FILETIME
		puuid as CLSID ptr
		blob as BLOB
		pclipdata as CLIPDATA ptr
		pStream as LPSTREAM
		pStorage as LPSTORAGE
		bstrVal as BSTR
		bstrblobVal as BSTRBLOB
		pszVal as LPSTR
		pwszVal as LPWSTR
		caub as CAUB
		cai as CAI
		caui as CAUI
		cabool as CABOOL
		cal as CAL
		caul as CAUL
		caflt as CAFLT
		cascode as CASCODE
		cah as CAH
		cauh as CAUH
		cadbl as CADBL
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
	end union
end type

type PROPSPEC
	ulKind as ULONG
	union
		propid as PROPID
		lpwstr as LPOLESTR
	end union
end type

type STATPROPSTG
	lpwstrName as LPOLESTR
	propid as PROPID
	vt as VARTYPE
end type

enum PROPSETFLAG
	PROPSETFLAG_DEFAULT
	PROPSETFLAG_NONSIMPLE
	PROPSETFLAG_ANSI
	PROPSETFLAG_UNBUFFERED = 4
end enum

type STORAGELAYOUT
	LayoutType as DWORD
	pwcsElementName as OLECHAR ptr
	cOffset as LARGE_INTEGER
	cBytes as LARGE_INTEGER
end type

type SOLE_AUTHENTICATION_SERVICE
	dwAuthnSvc as DWORD
	dwAuthzSvc as DWORD
	pPrincipalName as OLECHAR ptr
	hr as HRESULT
end type

enum EOLE_AUTHENTICATION_CAPABILITIES
	EOAC_NONE = 0
	EOAC_MUTUAL_AUTH = &h1
	EOAC_STATIC_CLOAKING = &h20
	EOAC_DYNAMIC_CLOAKING = &h40
	EOAC_ANY_AUTHORITY = &h80
	EOAC_MAKE_FULLSIC = &h100
	EOAC_DEFAULT = &h800
	EOAC_SECURE_REFS = &h2
	EOAC_ACCESS_CONTROL = &h4
	EOAC_APPID = &h8
	EOAC_DYNAMIC = &h10
	EOAC_REQUIRE_FULLSIC = &h200
	EOAC_AUTO_IMPERSONATE = &h400
	EOAC_NO_CUSTOM_MARSHAL = &h2000
	EOAC_DISABLE_AAA = &h1000
end enum

type SOLE_AUTHENTICATION_INFO
	dwAuthnSvc as DWORD
	dwAuthzSvc as DWORD
	pAuthInfo as any ptr
end type

type SOLE_AUTHENTICATION_LIST
	cAuthInfo as DWORD
	aAuthInfo as SOLE_AUTHENTICATION_INFO ptr
end type

#inclib "uuid"

extern FMTID_SummaryInformation alias "FMTID_SummaryInformation" as FMTID
extern FMTID_DocSummaryInformation alias "FMTID_DocSummaryInformation" as FMTID
extern FMTID_UserDefinedProperties alias "FMTID_UserDefinedProperties" as FMTID

type IEnumFORMATETCVtbl_ as IEnumFORMATETCVtbl

type IEnumFORMATETC
	lpVtbl as IEnumFORMATETCVtbl_ ptr
end type

type IEnumFORMATETCVtbl
	QueryInterface as function (byval as IEnumFORMATETC ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IEnumFORMATETC ptr) as ULONG
	Release as function (byval as IEnumFORMATETC ptr) as ULONG
	Next as function (byval as IEnumFORMATETC ptr, byval as ULONG, byval as FORMATETC ptr, byval as ULONG ptr) as HRESULT
	Skip as function (byval as IEnumFORMATETC ptr, byval as ULONG) as HRESULT
	Reset as function (byval as IEnumFORMATETC ptr) as HRESULT
	Clone as function (byval as IEnumFORMATETC ptr, byval as IEnumFORMATETC ptr ptr) as HRESULT
end type

type IEnumHLITEMVtbl_ as IEnumHLITEMVtbl

type IEnumHLITEM
	lpVtbl as IEnumHLITEMVtbl_ ptr
end type

type IEnumHLITEMVtbl
	QueryInterface as function (byval as IEnumHLITEM ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IEnumHLITEM ptr) as ULONG
	Release as function (byval as IEnumHLITEM ptr) as ULONG
	Next as function (byval as IEnumHLITEM ptr, byval as ULONG, byval as HLITEM ptr, byval as ULONG ptr) as HRESULT
	Skip as function (byval as IEnumHLITEM ptr, byval as ULONG) as HRESULT
	Reset as function (byval as IEnumHLITEM ptr) as HRESULT
	Clone as function (byval as IEnumHLITEM ptr, byval as IEnumHLITEM ptr ptr) as HRESULT
end type

type IEnumSTATDATAVtbl_ as IEnumSTATDATAVtbl

type IEnumSTATDATA
	lpVtbl as IEnumSTATDATAVtbl_ ptr
end type

type IEnumSTATDATAVtbl
	QueryInterface as function (byval as IEnumSTATDATA ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IEnumSTATDATA ptr) as ULONG
	Release as function (byval as IEnumSTATDATA ptr) as ULONG
	Next as function (byval as IEnumSTATDATA ptr, byval as ULONG, byval as STATDATA ptr, byval as ULONG ptr) as HRESULT
	Skip as function (byval as IEnumSTATDATA ptr, byval as ULONG) as HRESULT
	Reset as function (byval as IEnumSTATDATA ptr) as HRESULT
	Clone as function (byval as IEnumSTATDATA ptr, byval as IEnumSTATDATA ptr ptr) as HRESULT
end type

type IEnumSTATPROPSETSTGVtbl_ as IEnumSTATPROPSETSTGVtbl

type IEnumSTATPROPSETSTG
	lpVtbl as IEnumSTATPROPSETSTGVtbl_ ptr
end type

type IEnumSTATPROPSETSTGVtbl
	QueryInterface as function (byval as IEnumSTATPROPSETSTG ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IEnumSTATPROPSETSTG ptr) as ULONG
	Release as function (byval as IEnumSTATPROPSETSTG ptr) as ULONG
	Next as function (byval as IEnumSTATPROPSETSTG ptr, byval as ULONG, byval as STATPROPSETSTG ptr, byval as ULONG ptr) as HRESULT
	Skip as function (byval as IEnumSTATPROPSETSTG ptr, byval as ULONG) as HRESULT
	Reset as function (byval as IEnumSTATPROPSETSTG ptr) as HRESULT
	Clone as function (byval as IEnumSTATPROPSETSTG ptr, byval as IEnumSTATPROPSETSTG ptr ptr) as HRESULT
end type

type IEnumSTATPROPSTGVtbl_ as IEnumSTATPROPSTGVtbl

type IEnumSTATPROPSTG
	lpVtbl as IEnumSTATPROPSTGVtbl_ ptr
end type

type IEnumSTATPROPSTGVtbl
	QueryInterface as function (byval as IEnumSTATPROPSTG ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IEnumSTATPROPSTG ptr) as ULONG
	Release as function (byval as IEnumSTATPROPSTG ptr) as ULONG
	Next as function (byval as IEnumSTATPROPSTG ptr, byval as ULONG, byval as STATPROPSTG ptr, byval as ULONG ptr) as HRESULT
	Skip as function (byval as IEnumSTATPROPSTG ptr, byval as ULONG) as HRESULT
	Reset as function (byval as IEnumSTATPROPSTG ptr) as HRESULT
	Clone as function (byval as IEnumSTATPROPSTG ptr, byval as IEnumSTATPROPSTG ptr ptr) as HRESULT
end type

type IEnumSTATSTGVtbl_ as IEnumSTATSTGVtbl

type IEnumSTATSTG
	lpVtbl as IEnumSTATSTGVtbl_ ptr
end type

type IEnumSTATSTGVtbl
	QueryInterface as function (byval as IEnumSTATSTG ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IEnumSTATSTG ptr) as ULONG
	Release as function (byval as IEnumSTATSTG ptr) as ULONG
	Next as function (byval as IEnumSTATSTG ptr, byval as ULONG, byval as STATSTG ptr, byval as ULONG ptr) as HRESULT
	Skip as function (byval as IEnumSTATSTG ptr, byval as ULONG) as HRESULT
	Reset as function (byval as IEnumSTATSTG ptr) as HRESULT
	Clone as function (byval as IEnumSTATSTG ptr, byval as IEnumSTATSTG ptr ptr) as HRESULT
end type

type IEnumStringVtbl_ as IEnumStringVtbl

type IEnumString
	lpVtbl as IEnumStringVtbl_ ptr
end type

type IEnumStringVtbl
	QueryInterface as function (byval as IEnumString ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IEnumString ptr) as ULONG
	Release as function (byval as IEnumString ptr) as ULONG
	Next as function (byval as IEnumString ptr, byval as ULONG, byval as LPOLESTR ptr, byval as ULONG ptr) as HRESULT
	Skip as function (byval as IEnumString ptr, byval as ULONG) as HRESULT
	Reset as function (byval as IEnumString ptr) as HRESULT
	Clone as function (byval as IEnumString ptr, byval as IEnumString ptr ptr) as HRESULT
end type

type IEnumMonikerVtbl_ as IEnumMonikerVtbl

type IEnumMoniker
	lpVtbl as IEnumMonikerVtbl_ ptr
end type

type IMoniker_ as IMoniker

type IEnumMonikerVtbl
	QueryInterface as function (byval as IEnumMoniker ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IEnumMoniker ptr) as ULONG
	Release as function (byval as IEnumMoniker ptr) as ULONG
	Next as function (byval as IEnumMoniker ptr, byval as ULONG, byval as IMoniker_ ptr ptr, byval as ULONG ptr) as HRESULT
	Skip as function (byval as IEnumMoniker ptr, byval as ULONG) as HRESULT
	Reset as function (byval as IEnumMoniker ptr) as HRESULT
	Clone as function (byval as IEnumMoniker ptr, byval as IEnumMoniker ptr ptr) as HRESULT
end type

type IEnumUnknownVtbl_ as IEnumUnknownVtbl

type IEnumUnknown
	lpVtbl as IEnumUnknownVtbl_ ptr
end type

type IEnumUnknownVtbl
	QueryInterface as function (byval as IEnumUnknown ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IEnumUnknown ptr) as ULONG
	Release as function (byval as IEnumUnknown ptr) as ULONG
	Next as function (byval as IEnumUnknown ptr, byval as ULONG, byval as IUnknown ptr ptr, byval as ULONG ptr) as HRESULT
	Skip as function (byval as IEnumUnknown ptr, byval as ULONG) as HRESULT
	Reset as function (byval as IEnumUnknown ptr) as HRESULT
	Clone as function (byval as IEnumUnknown ptr, byval as IEnumUnknown ptr ptr) as HRESULT
end type
extern IID_ISequentialStream alias "IID_ISequentialStream" as IID

type ISequentialStreamVtbl_ as ISequentialStreamVtbl

type ISequentialStream
	lpVtbl as ISequentialStreamVtbl_ ptr
end type

type ISequentialStreamVtbl
	QueryInterface as function (byval as ISequentialStream ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as ISequentialStream ptr) as ULONG
	Release as function (byval as ISequentialStream ptr) as ULONG
	Read as function (byval as ISequentialStream ptr, byval as any ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	Write as function (byval as ISequentialStream ptr, byval as any ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
end type
extern IID_IStream alias "IID_IStream" as IID

type IStreamVtbl_ as IStreamVtbl

type IStream
	lpVtbl as IStreamVtbl_ ptr
end type

type IStreamVtbl
	QueryInterface as function (byval as IStream ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IStream ptr) as ULONG
	Release as function (byval as IStream ptr) as ULONG
	Read as function (byval as IStream ptr, byval as any ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	Write as function (byval as IStream ptr, byval as any ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
	Seek as function (byval as IStream ptr, byval as LARGE_INTEGER, byval as DWORD, byval as ULARGE_INTEGER ptr) as HRESULT
	SetSize as function (byval as IStream ptr, byval as ULARGE_INTEGER) as HRESULT
	CopyTo as function (byval as IStream ptr, byval as IStream ptr, byval as ULARGE_INTEGER, byval as ULARGE_INTEGER ptr, byval as ULARGE_INTEGER ptr) as HRESULT
	Commit as function (byval as IStream ptr, byval as DWORD) as HRESULT
	Revert as function (byval as IStream ptr) as HRESULT
	LockRegion as function (byval as IStream ptr, byval as ULARGE_INTEGER, byval as ULARGE_INTEGER, byval as DWORD) as HRESULT
	UnlockRegion as function (byval as IStream ptr, byval as ULARGE_INTEGER, byval as ULARGE_INTEGER, byval as DWORD) as HRESULT
	Stat as function (byval as IStream ptr, byval as STATSTG ptr, byval as DWORD) as HRESULT
	Clone as function (byval as IStream ptr, byval as LPSTREAM ptr) as HRESULT
end type
extern IID_IMarshal alias "IID_IMarshal" as IID

type IMarshalVtbl_ as IMarshalVtbl

type IMarshal
	lpVtbl as IMarshalVtbl_ ptr
end type

type IMarshalVtbl
	QueryInterface as function (byval as IMarshal ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IMarshal ptr) as ULONG
	Release as function (byval as IMarshal ptr) as ULONG
	GetUnmarshalClass as function (byval as IMarshal ptr, byval as IID ptr, byval as DWORD, byval as PVOID, byval as DWORD, byval as CLSID ptr) as HRESULT
	GetMarshalSizeMax as function (byval as IMarshal ptr, byval as IID ptr, byval as DWORD, byval as PVOID, byval as DWORD, byval as PDWORD) as HRESULT
	MarshalInterface as function (byval as IMarshal ptr, byval as IID ptr, byval as DWORD, byval as DWORD) as HRESULT
	UnmarshalInterface as function (byval as IMarshal ptr, byval as IStream ptr, byval as any ptr ptr) as HRESULT
	ReleaseMarshalData as function (byval as IMarshal ptr, byval as IStream ptr) as HRESULT
	DisconnectObject as function (byval as IMarshal ptr, byval as DWORD) as HRESULT
end type
extern IID_IStdMarshalInfo alias "IID_IStdMarshalInfo" as IID

type IStdMarshalInfoVtbl_ as IStdMarshalInfoVtbl

type IStdMarshalInfo
	lpVtbl as IStdMarshalInfoVtbl_ ptr
end type

type IStdMarshalInfoVtbl
	QueryInterface as function (byval as IStdMarshalInfo ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IStdMarshalInfo ptr) as ULONG
	Release as function (byval as IStdMarshalInfo ptr) as ULONG
	GetClassForHandler as function (byval as IStdMarshalInfo ptr, byval as DWORD, byval as PVOID, byval as CLSID ptr) as HRESULT
end type
extern IID_IMalloc alias "IID_IMalloc" as IID

type IMallocVtbl_ as IMallocVtbl

type IMalloc
	lpVtbl as IMallocVtbl_ ptr
end type

type IMallocVtbl
	QueryInterface as function (byval as IMalloc ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IMalloc ptr) as ULONG
	Release as function (byval as IMalloc ptr) as ULONG
	Alloc as sub (byval as IMalloc ptr, byval as ULONG)
	Realloc as sub (byval as IMalloc ptr, byval as any ptr, byval as ULONG)
	Free as sub (byval as IMalloc ptr, byval as any ptr)
	GetSize as function (byval as IMalloc ptr, byval as any ptr) as ULONG
	DidAlloc as function (byval as IMalloc ptr, byval as any ptr) as integer
	HeapMinimize as sub (byval as IMalloc ptr)
end type
extern IID_IMallocSpy alias "IID_IMallocSpy" as IID

type IMallocSpyVtbl_ as IMallocSpyVtbl

type IMallocSpy
	lpVtbl as IMallocSpyVtbl_ ptr
end type

type IMallocSpyVtbl
	QueryInterface as function (byval as IMallocSpy ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IMallocSpy ptr) as ULONG
	Release as function (byval as IMallocSpy ptr) as ULONG
	PreAlloc as function (byval as IMallocSpy ptr, byval as ULONG) as ULONG
	PostAlloc as sub (byval as IMallocSpy ptr, byval as any ptr)
	PreFree as sub (byval as IMallocSpy ptr, byval as any ptr, byval as BOOL)
	PostFree as sub (byval as IMallocSpy ptr, byval as BOOL)
	PreRealloc as function (byval as IMallocSpy ptr, byval as any ptr, byval as ULONG, byval as any ptr) as ULONG
	PostRealloc as sub (byval as IMallocSpy ptr, byval as any ptr, byval as BOOL)
	PreGetSize as sub (byval as IMallocSpy ptr, byval as any ptr, byval as BOOL)
	PostGetSize as function (byval as IMallocSpy ptr, byval as ULONG, byval as BOOL) as ULONG
	PreDidAlloc as sub (byval as IMallocSpy ptr, byval as any ptr, byval as BOOL)
	PostDidAlloc as function (byval as IMallocSpy ptr, byval as any ptr, byval as BOOL, byval as integer) as integer
	PreHeapMinimize as sub (byval as IMallocSpy ptr)
	PostHeapMinimize as sub (byval as IMallocSpy ptr)
end type
extern IID_IMessageFilter alias "IID_IMessageFilter" as IID

type IMessageFilterVtbl_ as IMessageFilterVtbl

type IMessageFilter
	lpVtbl as IMessageFilterVtbl_ ptr
end type

type IMessageFilterVtbl
	QueryInterface as function (byval as IMessageFilter ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IMessageFilter ptr) as ULONG
	Release as function (byval as IMessageFilter ptr) as ULONG
	HandleInComingCall as function (byval as IMessageFilter ptr, byval as DWORD, byval as HTASK, byval as DWORD, byval as LPINTERFACEINFO) as DWORD
	RetryRejectedCall as function (byval as IMessageFilter ptr, byval as HTASK, byval as DWORD, byval as DWORD) as DWORD
	MessagePending as function (byval as IMessageFilter ptr, byval as HTASK, byval as DWORD, byval as DWORD) as DWORD
end type
extern IID_IPersist alias "IID_IPersist" as IID

type IPersistVtbl_ as IPersistVtbl

type IPersist
	lpVtbl as IPersistVtbl_ ptr
end type

type IPersistVtbl
	QueryInterface as function (byval as IPersist ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IPersist ptr) as ULONG
	Release as function (byval as IPersist ptr) as ULONG
	GetClassID as function (byval as IPersist ptr, byval as CLSID ptr) as HRESULT
end type
extern IID_IPersistStream alias "IID_IPersistStream" as IID

type IPersistStreamVtbl_ as IPersistStreamVtbl

type IPersistStream
	lpVtbl as IPersistStreamVtbl_ ptr
end type

type IPersistStreamVtbl
	QueryInterface as function (byval as IPersistStream ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IPersistStream ptr) as ULONG
	Release as function (byval as IPersistStream ptr) as ULONG
	GetClassID as function (byval as IPersistStream ptr, byval as LPCLSID) as HRESULT
	IsDirty as function (byval as IPersistStream ptr) as HRESULT
	Load as function (byval as IPersistStream ptr, byval as IStream ptr) as HRESULT
	Save as function (byval as IPersistStream ptr, byval as IStream ptr, byval as BOOL) as HRESULT
	GetSizeMax as function (byval as IPersistStream ptr, byval as PULARGE_INTEGER) as HRESULT
end type
extern IID_IRunningObjectTable alias "IID_IRunningObjectTable" as IID

type IRunningObjectTableVtbl_ as IRunningObjectTableVtbl

type IRunningObjectTable
	lpVtbl as IRunningObjectTableVtbl_ ptr
end type

type IRunningObjectTableVtbl
	QueryInterface as function (byval as IRunningObjectTable ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IRunningObjectTable ptr) as ULONG
	Release as function (byval as IRunningObjectTable ptr) as ULONG
	Register as function (byval as IRunningObjectTable ptr, byval as DWORD, byval as LPUNKNOWN, byval as LPMONIKER, byval as PDWORD) as HRESULT
	Revoke as function (byval as IRunningObjectTable ptr, byval as DWORD) as HRESULT
	IsRunning as function (byval as IRunningObjectTable ptr, byval as LPMONIKER) as HRESULT
	GetObjectA as function (byval as IRunningObjectTable ptr, byval as LPMONIKER, byval as LPUNKNOWN ptr) as HRESULT
	NoteChangeTime as function (byval as IRunningObjectTable ptr, byval as DWORD, byval as LPFILETIME) as HRESULT
	GetTimeOfLastChange as function (byval as IRunningObjectTable ptr, byval as LPMONIKER, byval as LPFILETIME) as HRESULT
	EnumRunning as function (byval as IRunningObjectTable ptr, byval as IEnumMoniker ptr ptr) as HRESULT
end type
extern IID_IBindCtx alias "IID_IBindCtx" as IID

type IBindCtxVtbl_ as IBindCtxVtbl

type IBindCtx
	lpVtbl as IBindCtxVtbl_ ptr
end type

type IBindCtxVtbl
	QueryInterface as function (byval as IBindCtx ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IBindCtx ptr) as ULONG
	Release as function (byval as IBindCtx ptr) as ULONG
	RegisterObjectBound as function (byval as IBindCtx ptr, byval as LPUNKNOWN) as HRESULT
	RevokeObjectBound as function (byval as IBindCtx ptr, byval as LPUNKNOWN) as HRESULT
	ReleaseBoundObjects as function (byval as IBindCtx ptr) as HRESULT
	SetBindOptions as function (byval as IBindCtx ptr, byval as LPBIND_OPTS) as HRESULT
	GetBindOptions as function (byval as IBindCtx ptr, byval as LPBIND_OPTS) as HRESULT
	GetRunningObjectTable as function (byval as IBindCtx ptr, byval as IRunningObjectTable ptr ptr) as HRESULT
	RegisterObjectParam as function (byval as IBindCtx ptr, byval as LPOLESTR, byval as IUnknown ptr) as HRESULT
	GetObjectParam as function (byval as IBindCtx ptr, byval as LPOLESTR, byval as IUnknown ptr ptr) as HRESULT
	EnumObjectParam as function (byval as IBindCtx ptr, byval as IEnumString ptr ptr) as HRESULT
	RevokeObjectParam as function (byval as IBindCtx ptr, byval as LPOLESTR) as HRESULT
end type
extern IID_IMoniker alias "IID_IMoniker" as IID

type IMonikerVtbl_ as IMonikerVtbl

type IMoniker
	lpVtbl as IMonikerVtbl_ ptr
end type

type IMonikerVtbl
	QueryInterface as function (byval as IMoniker ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IMoniker ptr) as ULONG
	Release as function (byval as IMoniker ptr) as ULONG
	GetClassID as function (byval as IMoniker ptr, byval as LPCLSID) as HRESULT
	IsDirty as function (byval as IMoniker ptr) as HRESULT
	Load as function (byval as IMoniker ptr, byval as IStream ptr) as HRESULT
	Save as function (byval as IMoniker ptr, byval as IStream ptr, byval as BOOL) as HRESULT
	GetSizeMax as function (byval as IMoniker ptr, byval as PULARGE_INTEGER) as HRESULT
	BindToObject as function (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	BindToStorage as function (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	Reduce as function (byval as IMoniker ptr, byval as IBindCtx ptr, byval as DWORD, byval as IMoniker ptr ptr, byval as IMoniker ptr ptr) as HRESULT
	ComposeWith as function (byval as IMoniker ptr, byval as IMoniker ptr, byval as BOOL, byval as IMoniker ptr ptr) as HRESULT
	Enum as function (byval as IMoniker ptr, byval as BOOL, byval as IEnumMoniker ptr ptr) as HRESULT
	IsEqual as function (byval as IMoniker ptr, byval as IMoniker ptr) as HRESULT
	Hash as function (byval as IMoniker ptr, byval as PDWORD) as HRESULT
	IsRunning as function (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as IMoniker ptr) as HRESULT
	GetTimeOfLastChange as function (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as LPFILETIME) as HRESULT
	Inverse as function (byval as IMoniker ptr, byval as IMoniker ptr ptr) as HRESULT
	CommonPrefixWith as function (byval as IMoniker ptr, byval as IMoniker ptr, byval as IMoniker ptr ptr) as HRESULT
	RelativePathTo as function (byval as IMoniker ptr, byval as IMoniker ptr, byval as IMoniker ptr ptr) as HRESULT
	GetDisplayName as function (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as LPOLESTR ptr) as HRESULT
	ParseDisplayName as function (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as LPOLESTR, byval as ULONG ptr, byval as IMoniker ptr ptr) as HRESULT
	IsSystemMoniker as function (byval as IMoniker ptr, byval as PDWORD) as HRESULT
end type
extern IID_IPersistStorage alias "IID_IPersistStorage" as IID

type IPersistStorageVtbl_ as IPersistStorageVtbl

type IPersistStorage
	lpVtbl as IPersistStorageVtbl_ ptr
end type

type IPersistStorageVtbl
	QueryInterface as function (byval as IPersistStorage ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IPersistStorage ptr) as ULONG
	Release as function (byval as IPersistStorage ptr) as ULONG
	GetClassID as function (byval as IPersistStorage ptr, byval as CLSID ptr) as HRESULT
	IsDirty as function (byval as IPersistStorage ptr) as HRESULT
	InitNew as function (byval as IPersistStorage ptr, byval as LPSTORAGE) as HRESULT
	Load as function (byval as IPersistStorage ptr, byval as LPSTORAGE) as HRESULT
	Save as function (byval as IPersistStorage ptr, byval as LPSTORAGE, byval as BOOL) as HRESULT
	SaveCompleted as function (byval as IPersistStorage ptr, byval as LPSTORAGE) as HRESULT
	HandsOffStorage as function (byval as IPersistStorage ptr) as HRESULT
end type
extern IID_IPersistFile alias "IID_IPersistFile" as IID

type IPersistFileVtbl_ as IPersistFileVtbl

type IPersistFile
	lpVtbl as IPersistFileVtbl_ ptr
end type

type IPersistFileVtbl
	QueryInterface as function (byval as IPersistFile ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IPersistFile ptr) as ULONG
	Release as function (byval as IPersistFile ptr) as ULONG
	GetClassID as function (byval as IPersistFile ptr, byval as CLSID ptr) as HRESULT
	IsDirty as function (byval as IPersistFile ptr) as HRESULT
	Load as function (byval as IPersistFile ptr, byval as LPCOLESTR, byval as DWORD) as HRESULT
	Save as function (byval as IPersistFile ptr, byval as LPCOLESTR, byval as BOOL) as HRESULT
	SaveCompleted as function (byval as IPersistFile ptr, byval as LPCOLESTR) as HRESULT
	GetCurFile as function (byval as IPersistFile ptr, byval as LPOLESTR ptr) as HRESULT
end type
extern IID_IAdviseSink alias "IID_IAdviseSink" as IID

type IAdviseSinkVtbl_ as IAdviseSinkVtbl 

type IAdviseSink
	lpVtbl as IAdviseSinkVtbl_ ptr
end type

type IAdviseSinkVtbl
	QueryInterface as function (byval as IAdviseSink ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IAdviseSink ptr) as ULONG
	Release as function (byval as IAdviseSink ptr) as ULONG
	OnDataChange as sub (byval as IAdviseSink ptr, byval as FORMATETC ptr, byval as STGMEDIUM ptr)
	OnViewChange as sub (byval as IAdviseSink ptr, byval as DWORD, byval as LONG)
	OnRename as sub (byval as IAdviseSink ptr, byval as IMoniker ptr)
	OnSave as sub (byval as IAdviseSink ptr)
	OnClose as sub (byval as IAdviseSink ptr)
end type
extern IID_IAdviseSink2 alias "IID_IAdviseSink2" as IID

type IAdviseSink2Vtbl_ as IAdviseSink2Vtbl

type IAdviseSink2
	lpVtbl as IAdviseSink2Vtbl_ ptr
end type

type IAdviseSink2Vtbl
	QueryInterface as function (byval as IAdviseSink2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IAdviseSink2 ptr) as ULONG
	Release as function (byval as IAdviseSink2 ptr) as ULONG
	OnDataChange as sub (byval as IAdviseSink2 ptr, byval as FORMATETC ptr, byval as STGMEDIUM ptr)
	OnViewChange as sub (byval as IAdviseSink2 ptr, byval as DWORD, byval as LONG)
	OnRename as sub (byval as IAdviseSink2 ptr, byval as IMoniker ptr)
	OnSave as sub (byval as IAdviseSink2 ptr)
	OnClose as sub (byval as IAdviseSink2 ptr)
	OnLinkSrcChange as sub (byval as IAdviseSink2 ptr, byval as IMoniker ptr)
end type
extern IID_IDataObject alias "IID_IDataObject" as IID

type IDataObjectVtbl_ as IDataObjectVtbl

type IDataObject
	lpVtbl as IDataObjectVtbl_ ptr
end type

type IDataObjectVtbl
	QueryInterface as function (byval as IDataObject ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IDataObject ptr) as ULONG
	Release as function (byval as IDataObject ptr) as ULONG
	GetData as function (byval as IDataObject ptr, byval as FORMATETC ptr, byval as STGMEDIUM ptr) as HRESULT
	GetDataHere as function (byval as IDataObject ptr, byval as FORMATETC ptr, byval as STGMEDIUM ptr) as HRESULT
	QueryGetData as function (byval as IDataObject ptr, byval as FORMATETC ptr) as HRESULT
	GetCanonicalFormatEtc as function (byval as IDataObject ptr, byval as FORMATETC ptr, byval as FORMATETC ptr) as HRESULT
	SetData as function (byval as IDataObject ptr, byval as FORMATETC ptr, byval as STGMEDIUM ptr, byval as BOOL) as HRESULT
	EnumFormatEtc as function (byval as IDataObject ptr, byval as DWORD, byval as IEnumFORMATETC ptr ptr) as HRESULT
	DAdvise as function (byval as IDataObject ptr, byval as FORMATETC ptr, byval as DWORD, byval as IAdviseSink ptr, byval as PDWORD) as HRESULT
	DUnadvise as function (byval as IDataObject ptr, byval as DWORD) as HRESULT
	EnumDAdvise as function (byval as IDataObject ptr, byval as IEnumSTATDATA ptr ptr) as HRESULT
end type
extern IID_IDataAdviseHolder alias "IID_IDataAdviseHolder" as IID

type IDataAdviseHolderVtbl_ as IDataAdviseHolderVtbl

type IDataAdviseHolder
	lpVtbl as IDataAdviseHolderVtbl_ ptr
end type

type IDataAdviseHolderVtbl
	QueryInterface as function (byval as IDataAdviseHolder ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IDataAdviseHolder ptr) as ULONG
	Release as function (byval as IDataAdviseHolder ptr) as ULONG
	Advise as function (byval as IDataAdviseHolder ptr, byval as IDataObject ptr, byval as FORMATETC ptr, byval as DWORD, byval as IAdviseSink ptr, byval as PDWORD) as HRESULT
	Unadvise as function (byval as IDataAdviseHolder ptr, byval as DWORD) as HRESULT
	EnumAdvise as function (byval as IDataAdviseHolder ptr, byval as IEnumSTATDATA ptr ptr) as HRESULT
	SendOnDataChange as function (byval as IDataAdviseHolder ptr, byval as IDataObject ptr, byval as DWORD, byval as DWORD) as HRESULT
end type
extern IID_IStorage alias "IID_IStorage" as IID

type IStorageVtbl_ as IStorageVtbl

type IStorage
	lpVtbl as IStorageVtbl_ ptr
end type

type IStorageVtbl
	QueryInterface as function (byval as IStorage ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IStorage ptr) as ULONG
	Release as function (byval as IStorage ptr) as ULONG
	CreateStream as function (byval as IStorage ptr, byval as LPCWSTR, byval as DWORD, byval as DWORD, byval as DWORD, byval as IStream ptr ptr) as HRESULT
	OpenStream as function (byval as IStorage ptr, byval as LPCWSTR, byval as PVOID, byval as DWORD, byval as DWORD, byval as IStream ptr ptr) as HRESULT
	CreateStorage as function (byval as IStorage ptr, byval as LPCWSTR, byval as DWORD, byval as DWORD, byval as DWORD, byval as IStorage ptr ptr) as HRESULT
	OpenStorage as function (byval as IStorage ptr, byval as LPCWSTR, byval as IStorage ptr, byval as DWORD, byval as SNB, byval as DWORD, byval as IStorage ptr ptr) as HRESULT
	CopyTo as function (byval as IStorage ptr, byval as DWORD, byval as IID ptr, byval as SNB, byval as IStorage ptr) as HRESULT
	MoveElementTo as function (byval as IStorage ptr, byval as LPCWSTR, byval as IStorage ptr, byval as LPCWSTR, byval as DWORD) as HRESULT
	Commit as function (byval as IStorage ptr, byval as DWORD) as HRESULT
	Revert as function (byval as IStorage ptr) as HRESULT
	EnumElements as function (byval as IStorage ptr, byval as DWORD, byval as PVOID, byval as DWORD, byval as IEnumSTATSTG ptr ptr) as HRESULT
	DestroyElement as function (byval as IStorage ptr, byval as LPCWSTR) as HRESULT
	RenameElement as function (byval as IStorage ptr, byval as LPCWSTR, byval as LPCWSTR) as HRESULT
	SetElementTimes as function (byval as IStorage ptr, byval as LPCWSTR, byval as FILETIME ptr, byval as FILETIME ptr, byval as FILETIME ptr) as HRESULT
	SetClass as function (byval as IStorage ptr, byval as CLSID ptr) as HRESULT
	SetStateBits as function (byval as IStorage ptr, byval as DWORD, byval as DWORD) as HRESULT
	Stat as function (byval as IStorage ptr, byval as STATSTG ptr, byval as DWORD) as HRESULT
end type
extern IID_IRootStorage alias "IID_IRootStorage" as IID

type IRootStorageVtbl_ as IRootStorageVtbl

type IRootStorage
	lpVtbl as IRootStorageVtbl_ ptr
end type

type IRootStorageVtbl
	QueryInterface as function (byval as IRootStorage ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IRootStorage ptr) as ULONG
	Release as function (byval as IRootStorage ptr) as ULONG
	SwitchToFile as function (byval as IRootStorage ptr, byval as LPOLESTR) as HRESULT
end type
extern IID_IRpcChannelBuffer alias "IID_IRpcChannelBuffer" as IID

type IRpcChannelBufferVtbl_ as IRpcChannelBufferVtbl

type IRpcChannelBuffer
	lpVtbl as IRpcChannelBufferVtbl_ ptr
end type

type IRpcChannelBufferVtbl
	QueryInterface as function (byval as IRpcChannelBuffer ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IRpcChannelBuffer ptr) as ULONG
	Release as function (byval as IRpcChannelBuffer ptr) as ULONG
	GetBuffer as function (byval as IRpcChannelBuffer ptr, byval as RPCOLEMESSAGE ptr, byval as IID ptr) as HRESULT
	SendReceive as function (byval as IRpcChannelBuffer ptr, byval as RPCOLEMESSAGE ptr, byval as PULONG) as HRESULT
	FreeBuffer as function (byval as IRpcChannelBuffer ptr, byval as RPCOLEMESSAGE ptr) as HRESULT
	GetDestCtx as function (byval as IRpcChannelBuffer ptr, byval as PDWORD, byval as PVOID ptr) as HRESULT
	IsConnected as function (byval as IRpcChannelBuffer ptr) as HRESULT
end type
extern IID_IRpcProxyBuffer alias "IID_IRpcProxyBuffer" as IID

type IRpcProxyBufferVtbl_ as IRpcProxyBufferVtbl

type IRpcProxyBuffer
	lpVtbl as IRpcProxyBufferVtbl_ ptr
end type

type IRpcProxyBufferVtbl
	QueryInterface as function (byval as IRpcProxyBuffer ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IRpcProxyBuffer ptr) as ULONG
	Release as function (byval as IRpcProxyBuffer ptr) as ULONG
	Connect as function (byval as IRpcProxyBuffer ptr, byval as IRpcChannelBuffer ptr) as HRESULT
	Disconnect as sub (byval as IRpcProxyBuffer ptr)
end type
extern IID_IRpcStubBuffer alias "IID_IRpcStubBuffer" as IID

type IRpcStubBufferVtbl_ as IRpcStubBufferVtbl

type IRpcStubBuffer
	lpVtbl as IRpcStubBufferVtbl_ ptr
end type

type IRpcStubBufferVtbl
	QueryInterface as function (byval as IRpcStubBuffer ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IRpcStubBuffer ptr) as ULONG
	Release as function (byval as IRpcStubBuffer ptr) as ULONG
	Connect as function (byval as IRpcStubBuffer ptr, byval as LPUNKNOWN) as HRESULT
	Disconnect as sub (byval as IRpcStubBuffer ptr)
	Invoke as function (byval as IRpcStubBuffer ptr, byval as RPCOLEMESSAGE ptr, byval as LPRPCSTUBBUFFER) as HRESULT
	IsIIDSupported as function (byval as IRpcStubBuffer ptr, byval as IID ptr) as LPRPCSTUBBUFFER
	CountRefs as function (byval as IRpcStubBuffer ptr) as ULONG
	DebugServerQueryInterface as function (byval as IRpcStubBuffer ptr, byval as PVOID ptr) as HRESULT
	DebugServerRelease as function (byval as IRpcStubBuffer ptr, byval as PVOID) as HRESULT
end type
extern IID_IPSFactoryBuffer alias "IID_IPSFactoryBuffer" as IID

type IPSFactoryBufferVtbl_ as IPSFactoryBufferVtbl

type IPSFactoryBuffer
	lpVtbl as IPSFactoryBufferVtbl_ ptr
end type

type IPSFactoryBufferVtbl
	QueryInterface as function (byval as IPSFactoryBuffer ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IPSFactoryBuffer ptr) as ULONG
	Release as function (byval as IPSFactoryBuffer ptr) as ULONG
	CreateProxy as function (byval as IPSFactoryBuffer ptr, byval as LPUNKNOWN, byval as IID ptr, byval as LPRPCPROXYBUFFER ptr, byval as PVOID ptr) as HRESULT
	CreateStub as function (byval as IPSFactoryBuffer ptr, byval as IID ptr, byval as LPUNKNOWN, byval as LPRPCSTUBBUFFER ptr) as HRESULT
end type
extern IID_ILockBytes alias "IID_ILockBytes" as IID

type ILockBytesVtbl_ as ILockBytesVtbl

type ILockBytes
	lpVtbl as ILockBytesVtbl_ ptr
end type

type ILockBytesVtbl
	QueryInterface as function (byval as ILockBytes ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as ILockBytes ptr) as ULONG
	Release as function (byval as ILockBytes ptr) as ULONG
	ReadAt as function (byval as ILockBytes ptr, byval as ULARGE_INTEGER, byval as PVOID, byval as ULONG, byval as ULONG ptr) as HRESULT
	WriteAt as function (byval as ILockBytes ptr, byval as ULARGE_INTEGER, byval as PCVOID, byval as ULONG, byval as ULONG ptr) as HRESULT
	Flush as function (byval as ILockBytes ptr) as HRESULT
	SetSize as function (byval as ILockBytes ptr, byval as ULARGE_INTEGER) as HRESULT
	LockRegion as function (byval as ILockBytes ptr, byval as ULARGE_INTEGER, byval as ULARGE_INTEGER, byval as DWORD) as HRESULT
	UnlockRegion as function (byval as ILockBytes ptr, byval as ULARGE_INTEGER, byval as ULARGE_INTEGER, byval as DWORD) as HRESULT
	Stat as function (byval as ILockBytes ptr, byval as STATSTG ptr, byval as DWORD) as HRESULT
end type
extern IID_IExternalConnection alias "IID_IExternalConnection" as IID

type IExternalConnectionVtbl_ as IExternalConnectionVtbl

type IExternalConnection
	lpVtbl as IExternalConnectionVtbl_ ptr
end type

type IExternalConnectionVtbl
	QueryInterface as function (byval as IExternalConnection ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IExternalConnection ptr) as ULONG
	Release as function (byval as IExternalConnection ptr) as ULONG
	AddConnection as function (byval as IExternalConnection ptr, byval as DWORD, byval as DWORD) as HRESULT
	ReleaseConnection as function (byval as IExternalConnection ptr, byval as DWORD, byval as DWORD, byval as BOOL) as HRESULT
end type
extern IID_IRunnableObject alias "IID_IRunnableObject" as IID

type IRunnableObjectVtbl_ as IRunnableObjectVtbl

type IRunnableObject
	lpVtbl as IRunnableObjectVtbl_ ptr
end type

type IRunnableObjectVtbl
	QueryInterface as function (byval as IRunnableObject ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IRunnableObject ptr) as ULONG
	Release as function (byval as IRunnableObject ptr) as ULONG
	GetRunningClass as function (byval as IRunnableObject ptr, byval as LPCLSID) as HRESULT
	Run as function (byval as IRunnableObject ptr, byval as LPBC) as HRESULT
	IsRunning as function (byval as IRunnableObject ptr) as BOOL
	LockRunning as function (byval as IRunnableObject ptr, byval as BOOL, byval as BOOL) as HRESULT
	SetContainedObject as function (byval as IRunnableObject ptr, byval as BOOL) as HRESULT
end type
extern IID_IROTData alias "IID_IROTData" as IID

type IROTDataVtbl_ as IROTDataVtbl

type IROTData
	lpVtbl as IROTDataVtbl_ ptr
end type

type IROTDataVtbl
	QueryInterface as function (byval as IROTData ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IROTData ptr) as ULONG
	Release as function (byval as IROTData ptr) as ULONG
	GetComparisonData as function (byval as IROTData ptr, byval as PVOID, byval as ULONG, byval as PULONG) as HRESULT
end type
extern IID_IChannelHook alias "IID_IChannelHook" as IID

type IChannelHookVtbl_ as IChannelHookVtbl

type IChannelHook
	lpVtbl as IChannelHookVtbl_ ptr
end type

type IChannelHookVtbl
	QueryInterface as function (byval as IChannelHook ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IChannelHook ptr) as ULONG
	Release as function (byval as IChannelHook ptr) as ULONG
	ClientGetSize as sub (byval as IChannelHook ptr, byval as GUID ptr, byval as IID ptr, byval as PULONG)
	ClientFillBuffer as sub (byval as IChannelHook ptr, byval as GUID ptr, byval as IID ptr, byval as PULONG, byval as PVOID)
	ClientNotify as sub (byval as IChannelHook ptr, byval as GUID ptr, byval as IID ptr, byval as ULONG, byval as PVOID, byval as DWORD, byval as HRESULT)
	ServerNotify as sub (byval as IChannelHook ptr, byval as GUID ptr, byval as IID ptr, byval as ULONG, byval as PVOID, byval as DWORD)
	ServerGetSize as sub (byval as IChannelHook ptr, byval as GUID ptr, byval as IID ptr, byval as HRESULT, byval as PULONG)
	ServerFillBuffer as sub (byval as IChannelHook ptr, byval as GUID ptr, byval as IID ptr, byval as PULONG, byval as PVOID, byval as HRESULT)
end type
extern IID_IPropertyStorage alias "IID_IPropertyStorage" as IID

type IPropertyStorageVtbl_ as IPropertyStorageVtbl

type IPropertyStorage
	lpVtbl as IPropertyStorageVtbl_ ptr
end type

type IPropertyStorageVtbl
	QueryInterface as function (byval as IPropertyStorage ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IPropertyStorage ptr) as ULONG
	Release as function (byval as IPropertyStorage ptr) as ULONG
	ReadMultiple as function (byval as IPropertyStorage ptr, byval as ULONG, byval as PROPSPEC ptr, byval as PROPVARIANT ptr) as HRESULT
	WriteMultiple as function (byval as IPropertyStorage ptr, byval as ULONG, byval as PROPSPEC ptr, byval as PROPVARIANT ptr, byval as PROPID) as HRESULT
	DeleteMultiple as function (byval as IPropertyStorage ptr, byval as ULONG, byval as PROPSPEC ptr) as HRESULT
	ReadPropertyNames as function (byval as IPropertyStorage ptr, byval as ULONG, byval as PROPID ptr, byval as LPWSTR ptr) as HRESULT
	WritePropertyNames as function (byval as IPropertyStorage ptr, byval as ULONG, byval as PROPID ptr, byval as LPWSTR ptr) as HRESULT
	DeletePropertyNames as function (byval as IPropertyStorage ptr, byval as ULONG, byval as PROPID ptr) as HRESULT
	SetClass as function (byval as IPropertyStorage ptr, byval as CLSID ptr) as HRESULT
	Commit as function (byval as IPropertyStorage ptr, byval as DWORD) as HRESULT
	Revert as function (byval as IPropertyStorage ptr) as HRESULT
	Enum as function (byval as IPropertyStorage ptr, byval as IEnumSTATPROPSTG ptr ptr) as HRESULT
	Stat as function (byval as IPropertyStorage ptr, byval as STATPROPSTG ptr) as HRESULT
	SetTimes as function (byval as IPropertyStorage ptr, byval as FILETIME ptr, byval as FILETIME ptr, byval as FILETIME ptr) as HRESULT
end type
extern IID_IPropertySetStorage alias "IID_IPropertySetStorage" as IID

type IPropertySetStorageVtbl_ as IPropertySetStorageVtbl

type IPropertySetStorage
	lpVtbl as IPropertySetStorageVtbl_ ptr
end type

type IPropertySetStorageVtbl
	QueryInterface as function (byval as IPropertySetStorage ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IPropertySetStorage ptr) as ULONG
	Release as function (byval as IPropertySetStorage ptr) as ULONG
	Create as function (byval as IPropertySetStorage ptr, byval as REFFMTID, byval as CLSID ptr, byval as DWORD, byval as DWORD, byval as LPPROPERTYSTORAGE ptr) as HRESULT
	Open as function (byval as IPropertySetStorage ptr, byval as REFFMTID, byval as DWORD, byval as LPPROPERTYSTORAGE ptr) as HRESULT
	Delete as function (byval as IPropertySetStorage ptr, byval as REFFMTID) as HRESULT
	Enum as function (byval as IPropertySetStorage ptr, byval as IEnumSTATPROPSETSTG ptr ptr) as HRESULT
end type
extern IID_IClientSecurity alias "IID_IClientSecurity" as IID

type IClientSecurityVtbl_ as IClientSecurityVtbl

type IClientSecurity
	lpVtbl as IClientSecurityVtbl_ ptr
end type

type IClientSecurityVtbl
	QueryInterface as function (byval as IClientSecurity ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IClientSecurity ptr) as ULONG
	Release as function (byval as IClientSecurity ptr) as ULONG
	QueryBlanket as function (byval as IClientSecurity ptr, byval as PVOID, byval as PDWORD, byval as PDWORD, byval as OLECHAR ptr ptr, byval as PDWORD, byval as PDWORD, byval as RPC_AUTH_IDENTITY_HANDLE ptr ptr, byval as PDWORD ptr) as HRESULT
	SetBlanket as function (byval as IClientSecurity ptr, byval as PVOID, byval as DWORD, byval as DWORD, byval as LPWSTR, byval as DWORD, byval as DWORD, byval as RPC_AUTH_IDENTITY_HANDLE ptr, byval as DWORD) as HRESULT
	CopyProxy as function (byval as IClientSecurity ptr, byval as LPUNKNOWN, byval as LPUNKNOWN ptr) as HRESULT
end type
extern IID_IServerSecurity alias "IID_IServerSecurity" as IID

type IServerSecurityVtbl_ as IServerSecurityVtbl

type IServerSecurity
	lpVtbl as IServerSecurityVtbl_ ptr
end type

type IServerSecurityVtbl
	QueryInterface as function (byval as IServerSecurity ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IServerSecurity ptr) as ULONG
	Release as function (byval as IServerSecurity ptr) as ULONG
	QueryBlanket as function (byval as IServerSecurity ptr, byval as PDWORD, byval as PDWORD, byval as OLECHAR ptr ptr, byval as PDWORD, byval as PDWORD, byval as RPC_AUTHZ_HANDLE ptr, byval as PDWORD ptr) as HRESULT
	ImpersonateClient as function (byval as IServerSecurity ptr) as HRESULT
	RevertToSelf as function (byval as IServerSecurity ptr) as HRESULT
	IsImpersonating as function (byval as IServerSecurity ptr) as HRESULT
end type
extern IID_IClassActivator alias "IID_IClassActivator" as IID

type IClassActivatorVtbl_ as IClassActivatorVtbl

type IClassActivator
	lpVtbl as IClassActivatorVtbl_ ptr
end type

type IClassActivatorVtbl
	QueryInterface as function (byval as IClassActivator ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IClassActivator ptr) as ULONG
	Release as function (byval as IClassActivator ptr) as ULONG
	GetClassObject as function (byval as IClassActivator ptr, byval as CLSID ptr, byval as DWORD, byval as LCID, byval as IID ptr, byval as PVOID ptr) as HRESULT
end type
extern IID_IFillLockBytes alias "IID_IFillLockBytes" as IID

type IFillLockBytesVtbl_ as IFillLockBytesVtbl

type IFillLockBytes
	lpVtbl as IFillLockBytesVtbl_ ptr
end type

type IFillLockBytesVtbl
	QueryInterface as function (byval as IFillLockBytes ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IFillLockBytes ptr) as ULONG
	Release as function (byval as IFillLockBytes ptr) as ULONG
	FillAppend as function (byval as IFillLockBytes ptr, byval as any ptr, byval as ULONG, byval as PULONG) as HRESULT
	FillAt as function (byval as IFillLockBytes ptr, byval as ULARGE_INTEGER, byval as any ptr, byval as ULONG, byval as PULONG) as HRESULT
	SetFillSize as function (byval as IFillLockBytes ptr, byval as ULARGE_INTEGER) as HRESULT
	Terminate as function (byval as IFillLockBytes ptr, byval as BOOL) as HRESULT
end type
extern IID_IProgressNotify alias "IID_IProgressNotify" as IID

type IProgressNotifyVtbl_ as IProgressNotifyVtbl

type IProgressNotify
	lpVtbl as IProgressNotifyVtbl_ ptr
end type

type IProgressNotifyVtbl
	QueryInterface as function (byval as IProgressNotify ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IProgressNotify ptr) as ULONG
	Release as function (byval as IProgressNotify ptr) as ULONG
	OnProgress as function (byval as IProgressNotify ptr, byval as DWORD, byval as DWORD, byval as BOOL, byval as BOOL) as HRESULT
end type
extern IID_ILayoutStorage alias "IID_ILayoutStorage" as IID

type ILayoutStorageVtbl_ as ILayoutStorageVtbl

type ILayoutStorage
	lpVtbl as ILayoutStorageVtbl_ ptr
end type

type ILayoutStorageVtbl
	QueryInterface as function (byval as ILayoutStorage ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as ILayoutStorage ptr) as ULONG
	Release as function (byval as ILayoutStorage ptr) as ULONG
	LayoutScript as function (byval as ILayoutStorage ptr, byval as STORAGELAYOUT ptr, byval as DWORD, byval as DWORD) as HRESULT
	BeginMonitor as function (byval as ILayoutStorage ptr) as HRESULT
	EndMonitor as function (byval as ILayoutStorage ptr) as HRESULT
	ReLayoutDocfile as function (byval as ILayoutStorage ptr, byval as OLECHAR ptr) as HRESULT
end type

extern IID_IGlobalInterfaceTable alias "IID_IGlobalInterfaceTable" as IID

type IGlobalInterfaceTableVtbl_ as IGlobalInterfaceTableVtbl

type IGlobalInterfaceTable
	lpVtbl as IGlobalInterfaceTableVtbl_ ptr
end type

type IGlobalInterfaceTableVtbl
	QueryInterface as function(byval as IGlobalInterfaceTable ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IGlobalInterfaceTable ptr) as ULONG
	Release as function(byval as IGlobalInterfaceTable ptr) as ULONG
	RegisterInterfaceInGlobal as function(byval as IGlobalInterfaceTable ptr, byval as IUnknown ptr, byval as IID ptr, byval as DWORD ptr) as HRESULT
	RevokeInterfaceFromGlobal as function(byval as IGlobalInterfaceTable ptr, byval as DWORD) as HRESULT
	GetInterfaceFromGlobal as function(byval as IGlobalInterfaceTable ptr, byval as DWORD, byval as IID ptr, byval as any ptr ptr) as HRESULT
end type

declare function IMarshal_GetUnmarshalClass_Proxy alias "IMarshal_GetUnmarshalClass_Proxy" (byval as IMarshal ptr, byval as IID ptr, byval as any ptr, byval as DWORD, byval as any ptr, byval as DWORD, byval as CLSID ptr) as HRESULT
declare sub IMarshal_GetUnmarshalClass_Stub alias "IMarshal_GetUnmarshalClass_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMarshal_GetMarshalSizeMax_Proxy alias "IMarshal_GetMarshalSizeMax_Proxy" (byval as IMarshal ptr, byval as IID ptr, byval as any ptr, byval as DWORD, byval as any ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
declare sub IMarshal_GetMarshalSizeMax_Stub alias "IMarshal_GetMarshalSizeMax_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMarshal_MarshalInterface_Proxy alias "IMarshal_MarshalInterface_Proxy" (byval as IMarshal ptr, byval as IStream ptr, byval as IID ptr, byval as any ptr, byval as DWORD, byval as any ptr, byval as DWORD) as HRESULT
declare sub IMarshal_MarshalInterface_Stub alias "IMarshal_MarshalInterface_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMarshal_UnmarshalInterface_Proxy alias "IMarshal_UnmarshalInterface_Proxy" (byval as IMarshal ptr, byval as IStream ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare sub IMarshal_UnmarshalInterface_Stub alias "IMarshal_UnmarshalInterface_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMarshal_ReleaseMarshalData_Proxy alias "IMarshal_ReleaseMarshalData_Proxy" (byval as IMarshal ptr, byval as IStream ptr) as HRESULT
declare sub IMarshal_ReleaseMarshalData_Stub alias "IMarshal_ReleaseMarshalData_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMarshal_DisconnectObject_Proxy alias "IMarshal_DisconnectObject_Proxy" (byval as IMarshal ptr, byval as DWORD) as HRESULT
declare sub IMarshal_DisconnectObject_Stub alias "IMarshal_DisconnectObject_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMalloc_Alloc_Proxy alias "IMalloc_Alloc_Proxy" (byval as IMalloc ptr, byval as ULONG) as any ptr
declare sub IMalloc_Alloc_Stub alias "IMalloc_Alloc_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMalloc_Realloc_Proxy alias "IMalloc_Realloc_Proxy" (byval as IMalloc ptr, byval as any ptr, byval as ULONG) as any ptr
declare sub IMalloc_Realloc_Stub alias "IMalloc_Realloc_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IMalloc_Free_Proxy alias "IMalloc_Free_Proxy" (byval as IMalloc ptr, byval as any ptr)
declare sub IMalloc_Free_Stub alias "IMalloc_Free_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMalloc_GetSize_Proxy alias "IMalloc_GetSize_Proxy" (byval as IMalloc ptr, byval as any ptr) as ULONG
declare sub IMalloc_GetSize_Stub alias "IMalloc_GetSize_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMalloc_DidAlloc_Proxy alias "IMalloc_DidAlloc_Proxy" (byval as IMalloc ptr, byval as any ptr) as integer
declare sub IMalloc_DidAlloc_Stub alias "IMalloc_DidAlloc_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IMalloc_HeapMinimize_Proxy alias "IMalloc_HeapMinimize_Proxy" (byval as IMalloc ptr)
declare sub IMalloc_HeapMinimize_Stub alias "IMalloc_HeapMinimize_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMallocSpy_PreAlloc_Proxy alias "IMallocSpy_PreAlloc_Proxy" (byval as IMallocSpy ptr, byval cbRequest as ULONG) as ULONG
declare sub IMallocSpy_PreAlloc_Stub alias "IMallocSpy_PreAlloc_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMallocSpy_PostAlloc_Proxy alias "IMallocSpy_PostAlloc_Proxy" (byval as IMallocSpy ptr, byval as any ptr) as any ptr
declare sub IMallocSpy_PostAlloc_Stub alias "IMallocSpy_PostAlloc_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMallocSpy_PreFree_Proxy alias "IMallocSpy_PreFree_Proxy" (byval as IMallocSpy ptr, byval as any ptr, byval as BOOL) as any ptr
declare sub IMallocSpy_PreFree_Stub alias "IMallocSpy_PreFree_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IMallocSpy_PostFree_Proxy alias "IMallocSpy_PostFree_Proxy" (byval as IMallocSpy ptr, byval as BOOL)
declare sub IMallocSpy_PostFree_Stub alias "IMallocSpy_PostFree_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMallocSpy_PreRealloc_Proxy alias "IMallocSpy_PreRealloc_Proxy" (byval as IMallocSpy ptr, byval as any ptr, byval as ULONG, byval as any ptr ptr, byval as BOOL) as ULONG
declare sub IMallocSpy_PreRealloc_Stub alias "IMallocSpy_PreRealloc_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMallocSpy_PostRealloc_Proxy alias "IMallocSpy_PostRealloc_Proxy" (byval as IMallocSpy ptr, byval as any ptr, byval as BOOL) as any ptr
declare sub IMallocSpy_PostRealloc_Stub alias "IMallocSpy_PostRealloc_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMallocSpy_PreGetSize_Proxy alias "IMallocSpy_PreGetSize_Proxy" (byval as IMallocSpy ptr, byval as any ptr, byval as BOOL) as any ptr
declare sub IMallocSpy_PreGetSize_Stub alias "IMallocSpy_PreGetSize_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMallocSpy_PostGetSize_Proxy alias "IMallocSpy_PostGetSize_Proxy" (byval as IMallocSpy ptr, byval as ULONG, byval as BOOL) as ULONG
declare sub IMallocSpy_PostGetSize_Stub alias "IMallocSpy_PostGetSize_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMallocSpy_PreDidAlloc_Proxy alias "IMallocSpy_PreDidAlloc_Proxy" (byval as IMallocSpy ptr, byval as any ptr, byval as BOOL) as any ptr
declare sub IMallocSpy_PreDidAlloc_Stub alias "IMallocSpy_PreDidAlloc_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMallocSpy_PostDidAlloc_Proxy alias "IMallocSpy_PostDidAlloc_Proxy" (byval as IMallocSpy ptr, byval as any ptr, byval as BOOL, byval as integer) as integer
declare sub IMallocSpy_PostDidAlloc_Stub alias "IMallocSpy_PostDidAlloc_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IMallocSpy_PreHeapMinimize_Proxy alias "IMallocSpy_PreHeapMinimize_Proxy" (byval as IMallocSpy ptr)
declare sub IMallocSpy_PreHeapMinimize_Stub alias "IMallocSpy_PreHeapMinimize_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IMallocSpy_PostHeapMinimize_Proxy alias "IMallocSpy_PostHeapMinimize_Proxy" (byval as IMallocSpy ptr)
declare sub IMallocSpy_PostHeapMinimize_Stub alias "IMallocSpy_PostHeapMinimize_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStdMarshalInfo_GetClassForHandler_Proxy alias "IStdMarshalInfo_GetClassForHandler_Proxy" (byval as IStdMarshalInfo ptr, byval as DWORD, byval as any ptr, byval as CLSID ptr) as HRESULT
declare sub IStdMarshalInfo_GetClassForHandler_Stub alias "IStdMarshalInfo_GetClassForHandler_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IExternalConnection_AddConnection_Proxy alias "IExternalConnection_AddConnection_Proxy" (byval as IExternalConnection ptr, byval as DWORD, byval as DWORD) as DWORD
declare sub IExternalConnection_AddConnection_Stub alias "IExternalConnection_AddConnection_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IExternalConnection_ReleaseConnection_Proxy alias "IExternalConnection_ReleaseConnection_Proxy" (byval as IExternalConnection ptr, byval as DWORD, byval as DWORD, byval as BOOL) as DWORD
declare sub IExternalConnection_ReleaseConnection_Stub alias "IExternalConnection_ReleaseConnection_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumUnknown_RemoteNext_Proxy alias "IEnumUnknown_RemoteNext_Proxy" (byval as IEnumUnknown ptr, byval as ULONG, byval as IUnknown ptr ptr, byval as ULONG ptr) as HRESULT
declare sub IEnumUnknown_RemoteNext_Stub alias "IEnumUnknown_RemoteNext_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumUnknown_Skip_Proxy alias "IEnumUnknown_Skip_Proxy" (byval as IEnumUnknown ptr, byval as ULONG) as HRESULT
declare sub IEnumUnknown_Skip_Stub alias "IEnumUnknown_Skip_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumUnknown_Reset_Proxy alias "IEnumUnknown_Reset_Proxy" (byval as IEnumUnknown ptr) as HRESULT
declare sub IEnumUnknown_Reset_Stub alias "IEnumUnknown_Reset_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumUnknown_Clone_Proxy alias "IEnumUnknown_Clone_Proxy" (byval as IEnumUnknown ptr, byval as IEnumUnknown ptr ptr) as HRESULT
declare sub IEnumUnknown_Clone_Stub alias "IEnumUnknown_Clone_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IBindCtx_RegisterObjectBound_Proxy alias "IBindCtx_RegisterObjectBound_Proxy" (byval as IBindCtx ptr, byval punk as IUnknown ptr) as HRESULT
declare sub IBindCtx_RegisterObjectBound_Stub alias "IBindCtx_RegisterObjectBound_Stub" (byval as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IBindCtx_RevokeObjectBound_Proxy alias "IBindCtx_RevokeObjectBound_Proxy" (byval as IBindCtx ptr, byval punk as IUnknown ptr) as HRESULT
declare sub IBindCtx_RevokeObjectBound_Stub alias "IBindCtx_RevokeObjectBound_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IBindCtx_ReleaseBoundObjects_Proxy alias "IBindCtx_ReleaseBoundObjects_Proxy" (byval as IBindCtx ptr) as HRESULT
declare sub IBindCtx_ReleaseBoundObjects_Stub alias "IBindCtx_ReleaseBoundObjects_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IBindCtx_SetBindOptions_Proxy alias "IBindCtx_SetBindOptions_Proxy" (byval as IBindCtx ptr, byval as BIND_OPTS ptr) as HRESULT
declare sub IBindCtx_SetBindOptions_Stub alias "IBindCtx_SetBindOptions_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IBindCtx_GetBindOptions_Proxy alias "IBindCtx_GetBindOptions_Proxy" (byval as IBindCtx ptr, byval pbindopts as BIND_OPTS ptr) as HRESULT
declare sub IBindCtx_GetBindOptions_Stub alias "IBindCtx_GetBindOptions_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IBindCtx_GetRunningObjectTable_Proxy alias "IBindCtx_GetRunningObjectTable_Proxy" (byval as IBindCtx ptr, byval as IRunningObjectTable ptr ptr) as HRESULT
declare sub IBindCtx_GetRunningObjectTable_Stub alias "IBindCtx_GetRunningObjectTable_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IBindCtx_RegisterObjectParam_Proxy alias "IBindCtx_RegisterObjectParam_Proxy" (byval as IBindCtx ptr, byval as LPCSTR, byval as IUnknown ptr) as HRESULT
declare sub IBindCtx_RegisterObjectParam_Stub alias "IBindCtx_RegisterObjectParam_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IBindCtx_GetObjectParam_Proxy alias "IBindCtx_GetObjectParam_Proxy" (byval as IBindCtx ptr, byval as LPCSTR, byval as IUnknown ptr ptr) as HRESULT
declare sub IBindCtx_GetObjectParam_Stub alias "IBindCtx_GetObjectParam_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IBindCtx_EnumObjectParam_Proxy alias "IBindCtx_EnumObjectParam_Proxy" (byval as IBindCtx ptr, byval as IEnumString ptr ptr) as HRESULT
declare sub IBindCtx_EnumObjectParam_Stub alias "IBindCtx_EnumObjectParam_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IBindCtx_RevokeObjectParam_Proxy alias "IBindCtx_RevokeObjectParam_Proxy" (byval as IBindCtx ptr, byval as LPCSTR) as HRESULT
declare sub IBindCtx_RevokeObjectParam_Stub alias "IBindCtx_RevokeObjectParam_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumMoniker_RemoteNext_Proxy alias "IEnumMoniker_RemoteNext_Proxy" (byval as IEnumMoniker ptr, byval as ULONG, byval as IMoniker ptr ptr, byval as ULONG ptr) as HRESULT
declare sub IEnumMoniker_RemoteNext_Stub alias "IEnumMoniker_RemoteNext_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumMoniker_Skip_Proxy alias "IEnumMoniker_Skip_Proxy" (byval as IEnumMoniker ptr, byval as ULONG) as HRESULT
declare sub IEnumMoniker_Skip_Stub alias "IEnumMoniker_Skip_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumMoniker_Reset_Proxy alias "IEnumMoniker_Reset_Proxy" (byval as IEnumMoniker ptr) as HRESULT
declare sub IEnumMoniker_Reset_Stub alias "IEnumMoniker_Reset_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumMoniker_Clone_Proxy alias "IEnumMoniker_Clone_Proxy" (byval as IEnumMoniker ptr, byval as IEnumMoniker ptr ptr) as HRESULT
declare sub IEnumMoniker_Clone_Stub alias "IEnumMoniker_Clone_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRunnableObject_GetRunningClass_Proxy alias "IRunnableObject_GetRunningClass_Proxy" (byval as IRunnableObject ptr, byval as LPCLSID) as HRESULT
declare sub IRunnableObject_GetRunningClass_Stub alias "IRunnableObject_GetRunningClass_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRunnableObject_Run_Proxy alias "IRunnableObject_Run_Proxy" (byval as IRunnableObject ptr, byval as LPBINDCTX) as HRESULT
declare sub IRunnableObject_Run_Stub alias "IRunnableObject_Run_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRunnableObject_IsRunning_Proxy alias "IRunnableObject_IsRunning_Proxy" (byval as IRunnableObject ptr) as BOOL
declare sub IRunnableObject_IsRunning_Stub alias "IRunnableObject_IsRunning_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRunnableObject_LockRunning_Proxy alias "IRunnableObject_LockRunning_Proxy" (byval as IRunnableObject ptr, byval as BOOL, byval as BOOL) as HRESULT
declare sub IRunnableObject_LockRunning_Stub alias "IRunnableObject_LockRunning_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRunnableObject_SetContainedObject_Proxy alias "IRunnableObject_SetContainedObject_Proxy" (byval as IRunnableObject ptr, byval as BOOL) as HRESULT
declare sub IRunnableObject_SetContainedObject_Stub alias "IRunnableObject_SetContainedObject_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRunningObjectTable_Register_Proxy alias "IRunningObjectTable_Register_Proxy" (byval as IRunningObjectTable ptr, byval as DWORD, byval as IUnknown ptr, byval as IMoniker ptr, byval as DWORD ptr) as HRESULT
declare sub IRunningObjectTable_Register_Stub alias "IRunningObjectTable_Register_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRunningObjectTable_Revoke_Proxy alias "IRunningObjectTable_Revoke_Proxy" (byval as IRunningObjectTable ptr, byval as DWORD) as HRESULT
declare sub IRunningObjectTable_Revoke_Stub alias "IRunningObjectTable_Revoke_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRunningObjectTable_IsRunning_Proxy alias "IRunningObjectTable_IsRunning_Proxy" (byval as IRunningObjectTable ptr, byval as IMoniker ptr) as HRESULT
declare sub IRunningObjectTable_IsRunning_Stub alias "IRunningObjectTable_IsRunning_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRunningObjectTable_GetObject_Proxy alias "IRunningObjectTable_GetObject_Proxy" (byval as IRunningObjectTable ptr, byval as IMoniker ptr, byval as IUnknown ptr ptr) as HRESULT
declare sub IRunningObjectTable_GetObject_Stub alias "IRunningObjectTable_GetObject_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRunningObjectTable_NoteChangeTime_Proxy alias "IRunningObjectTable_NoteChangeTime_Proxy" (byval as IRunningObjectTable ptr, byval as DWORD, byval as FILETIME ptr) as HRESULT
declare sub IRunningObjectTable_NoteChangeTime_Stub alias "IRunningObjectTable_NoteChangeTime_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRunningObjectTable_GetTimeOfLastChange_Proxy alias "IRunningObjectTable_GetTimeOfLastChange_Proxy" (byval as IRunningObjectTable ptr, byval as IMoniker ptr, byval as FILETIME ptr) as HRESULT
declare sub IRunningObjectTable_GetTimeOfLastChange_Stub alias "IRunningObjectTable_GetTimeOfLastChange_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRunningObjectTable_EnumRunning_Proxy alias "IRunningObjectTable_EnumRunning_Proxy" (byval as IRunningObjectTable ptr, byval as IEnumMoniker ptr ptr) as HRESULT
declare sub IRunningObjectTable_EnumRunning_Stub alias "IRunningObjectTable_EnumRunning_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersist_GetClassID_Proxy alias "IPersist_GetClassID_Proxy" (byval as IPersist ptr, byval as CLSID ptr) as HRESULT
declare sub IPersist_GetClassID_Stub alias "IPersist_GetClassID_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistStream_IsDirty_Proxy alias "IPersistStream_IsDirty_Proxy" (byval as IPersistStream ptr) as HRESULT
declare sub IPersistStream_IsDirty_Stub alias "IPersistStream_IsDirty_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistStream_Load_Proxy alias "IPersistStream_Load_Proxy" (byval as IPersistStream ptr, byval as IStream ptr) as HRESULT
declare sub IPersistStream_Load_Stub alias "IPersistStream_Load_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistStream_Save_Proxy alias "IPersistStream_Save_Proxy" (byval as IPersistStream ptr, byval as IStream ptr, byval as BOOL) as HRESULT
declare sub IPersistStream_Save_Stub alias "IPersistStream_Save_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistStream_GetSizeMax_Proxy alias "IPersistStream_GetSizeMax_Proxy" (byval as IPersistStream ptr, byval as ULARGE_INTEGER ptr) as HRESULT
declare sub IPersistStream_GetSizeMax_Stub alias "IPersistStream_GetSizeMax_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_RemoteBindToObject_Proxy alias "IMoniker_RemoteBindToObject_Proxy" (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as IID ptr, byval as IUnknown ptr ptr) as HRESULT
declare sub IMoniker_RemoteBindToObject_Stub alias "IMoniker_RemoteBindToObject_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_RemoteBindToStorage_Proxy alias "IMoniker_RemoteBindToStorage_Proxy" (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as IID ptr, byval as IUnknown ptr ptr) as HRESULT
declare sub IMoniker_RemoteBindToStorage_Stub alias "IMoniker_RemoteBindToStorage_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_Reduce_Proxy alias "IMoniker_Reduce_Proxy" (byval as IMoniker ptr, byval as IBindCtx ptr, byval as DWORD, byval as IMoniker ptr ptr, byval as IMoniker ptr ptr) as HRESULT
declare sub IMoniker_Reduce_Stub alias "IMoniker_Reduce_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_ComposeWith_Proxy alias "IMoniker_ComposeWith_Proxy" (byval as IMoniker ptr, byval as IMoniker ptr, byval as BOOL, byval as IMoniker ptr ptr) as HRESULT
declare sub IMoniker_ComposeWith_Stub alias "IMoniker_ComposeWith_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_Enum_Proxy alias "IMoniker_Enum_Proxy" (byval as IMoniker ptr, byval as BOOL, byval as IEnumMoniker ptr ptr) as HRESULT
declare sub IMoniker_Enum_Stub alias "IMoniker_Enum_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_IsEqual_Proxy alias "IMoniker_IsEqual_Proxy" (byval as IMoniker ptr, byval as IMoniker ptr) as HRESULT
declare sub IMoniker_IsEqual_Stub alias "IMoniker_IsEqual_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_Hash_Proxy alias "IMoniker_Hash_Proxy" (byval as IMoniker ptr, byval as DWORD ptr) as HRESULT
declare sub IMoniker_Hash_Stub alias "IMoniker_Hash_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_IsRunning_Proxy alias "IMoniker_IsRunning_Proxy" (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as IMoniker ptr) as HRESULT
declare sub IMoniker_IsRunning_Stub alias "IMoniker_IsRunning_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_GetTimeOfLastChange_Proxy alias "IMoniker_GetTimeOfLastChange_Proxy" (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as FILETIME ptr) as HRESULT
declare sub IMoniker_GetTimeOfLastChange_Stub alias "IMoniker_GetTimeOfLastChange_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_Inverse_Proxy alias "IMoniker_Inverse_Proxy" (byval as IMoniker ptr, byval as IMoniker ptr ptr) as HRESULT
declare sub IMoniker_Inverse_Stub alias "IMoniker_Inverse_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_CommonPrefixWith_Proxy alias "IMoniker_CommonPrefixWith_Proxy" (byval as IMoniker ptr, byval as IMoniker ptr, byval as IMoniker ptr ptr) as HRESULT
declare sub IMoniker_CommonPrefixWith_Stub alias "IMoniker_CommonPrefixWith_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_RelativePathTo_Proxy alias "IMoniker_RelativePathTo_Proxy" (byval as IMoniker ptr, byval as IMoniker ptr, byval as IMoniker ptr ptr) as HRESULT
declare sub IMoniker_RelativePathTo_Stub alias "IMoniker_RelativePathTo_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_GetDisplayName_Proxy alias "IMoniker_GetDisplayName_Proxy" (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as LPCSTR ptr) as HRESULT
declare sub IMoniker_GetDisplayName_Stub alias "IMoniker_GetDisplayName_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_ParseDisplayName_Proxy alias "IMoniker_ParseDisplayName_Proxy" (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as LPCSTR, byval as ULONG ptr, byval as IMoniker ptr ptr) as HRESULT
declare sub IMoniker_ParseDisplayName_Stub alias "IMoniker_ParseDisplayName_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMoniker_IsSystemMoniker_Proxy alias "IMoniker_IsSystemMoniker_Proxy" (byval as IMoniker ptr, byval as DWORD ptr) as HRESULT
declare sub IMoniker_IsSystemMoniker_Stub alias "IMoniker_IsSystemMoniker_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IROTData_GetComparisonData_Proxy alias "IROTData_GetComparisonData_Proxy" (byval as IROTData ptr, byval as BYTE ptr, byval cbMax as ULONG, byval as ULONG ptr) as HRESULT
declare sub IROTData_GetComparisonData_Stub alias "IROTData_GetComparisonData_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumString_RemoteNext_Proxy alias "IEnumString_RemoteNext_Proxy" (byval as IEnumString ptr, byval as ULONG, byval rgelt as LPCSTR ptr, byval as ULONG ptr) as HRESULT
declare sub IEnumString_RemoteNext_Stub alias "IEnumString_RemoteNext_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumString_Skip_Proxy alias "IEnumString_Skip_Proxy" (byval as IEnumString ptr, byval as ULONG) as HRESULT
declare sub IEnumString_Skip_Stub alias "IEnumString_Skip_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumString_Reset_Proxy alias "IEnumString_Reset_Proxy" (byval as IEnumString ptr) as HRESULT
declare sub IEnumString_Reset_Stub alias "IEnumString_Reset_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumString_Clone_Proxy alias "IEnumString_Clone_Proxy" (byval as IEnumString ptr, byval as IEnumString ptr ptr) as HRESULT
declare sub IEnumString_Clone_Stub alias "IEnumString_Clone_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStream_RemoteRead_Proxy alias "IStream_RemoteRead_Proxy" (byval as IStream ptr, byval as BYTE ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
declare sub IStream_RemoteRead_Stub alias "IStream_RemoteRead_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStream_RemoteWrite_Proxy alias "IStream_RemoteWrite_Proxy" (byval as IStream ptr, byval pv as BYTE ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
declare sub IStream_RemoteWrite_Stub alias "IStream_RemoteWrite_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStream_RemoteSeek_Proxy alias "IStream_RemoteSeek_Proxy" (byval as IStream ptr, byval as LARGE_INTEGER, byval as DWORD, byval as ULARGE_INTEGER ptr) as HRESULT
declare sub IStream_RemoteSeek_Stub alias "IStream_RemoteSeek_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStream_SetSize_Proxy alias "IStream_SetSize_Proxy" (byval as IStream ptr, byval as ULARGE_INTEGER) as HRESULT
declare sub IStream_SetSize_Stub alias "IStream_SetSize_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStream_RemoteCopyTo_Proxy alias "IStream_RemoteCopyTo_Proxy" (byval as IStream ptr, byval as IStream ptr, byval as ULARGE_INTEGER, byval as ULARGE_INTEGER ptr, byval as ULARGE_INTEGER ptr) as HRESULT
declare sub IStream_RemoteCopyTo_Stub alias "IStream_RemoteCopyTo_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStream_Commit_Proxy alias "IStream_Commit_Proxy" (byval as IStream ptr, byval as DWORD) as HRESULT
declare sub IStream_Commit_Stub alias "IStream_Commit_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStream_Revert_Proxy alias "IStream_Revert_Proxy" (byval as IStream ptr) as HRESULT
declare sub IStream_Revert_Stub alias "IStream_Revert_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStream_LockRegion_Proxy alias "IStream_LockRegion_Proxy" (byval as IStream ptr, byval as ULARGE_INTEGER, byval as ULARGE_INTEGER, byval as DWORD) as HRESULT
declare sub IStream_LockRegion_Stub alias "IStream_LockRegion_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStream_UnlockRegion_Proxy alias "IStream_UnlockRegion_Proxy" (byval as IStream ptr, byval as ULARGE_INTEGER, byval as ULARGE_INTEGER, byval as DWORD) as HRESULT
declare sub IStream_UnlockRegion_Stub alias "IStream_UnlockRegion_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStream_Stat_Proxy alias "IStream_Stat_Proxy" (byval as IStream ptr, byval as STATSTG ptr, byval as DWORD) as HRESULT
declare sub IStream_Stat_Stub alias "IStream_Stat_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStream_Clone_Proxy alias "IStream_Clone_Proxy" (byval as IStream ptr, byval as IStream ptr ptr) as HRESULT
declare sub IStream_Clone_Stub alias "IStream_Clone_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumSTATSTG_RemoteNext_Proxy alias "IEnumSTATSTG_RemoteNext_Proxy" (byval as IEnumSTATSTG ptr, byval as ULONG, byval as STATSTG ptr, byval as ULONG ptr) as HRESULT
declare sub IEnumSTATSTG_RemoteNext_Stub alias "IEnumSTATSTG_RemoteNext_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumSTATSTG_Skip_Proxy alias "IEnumSTATSTG_Skip_Proxy" (byval as IEnumSTATSTG ptr, byval celt as ULONG) as HRESULT
declare sub IEnumSTATSTG_Skip_Stub alias "IEnumSTATSTG_Skip_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumSTATSTG_Reset_Proxy alias "IEnumSTATSTG_Reset_Proxy" (byval as IEnumSTATSTG ptr) as HRESULT
declare sub IEnumSTATSTG_Reset_Stub alias "IEnumSTATSTG_Reset_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumSTATSTG_Clone_Proxy alias "IEnumSTATSTG_Clone_Proxy" (byval as IEnumSTATSTG ptr, byval as IEnumSTATSTG ptr ptr) as HRESULT
declare sub IEnumSTATSTG_Clone_Stub alias "IEnumSTATSTG_Clone_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_CreateStream_Proxy alias "IStorage_CreateStream_Proxy" (byval as IStorage ptr, byval as OLECHAR ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as IStream ptr ptr) as HRESULT
declare sub IStorage_CreateStream_Stub alias "IStorage_CreateStream_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_RemoteOpenStream_Proxy alias "IStorage_RemoteOpenStream_Proxy" (byval as IStorage ptr, byval as OLECHAR ptr, byval as uinteger, byval as BYTE ptr, byval as DWORD, byval as DWORD, byval as IStream ptr ptr) as HRESULT
declare sub IStorage_RemoteOpenStream_Stub alias "IStorage_RemoteOpenStream_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_CreateStorage_Proxy alias "IStorage_CreateStorage_Proxy" (byval as IStorage ptr, byval as OLECHAR ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as IStorage ptr ptr) as HRESULT
declare sub IStorage_CreateStorage_Stub alias "IStorage_CreateStorage_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_OpenStorage_Proxy alias "IStorage_OpenStorage_Proxy" (byval as IStorage ptr, byval as OLECHAR ptr, byval as IStorage ptr, byval as DWORD, byval as SNB, byval as DWORD, byval as IStorage ptr ptr) as HRESULT
declare sub IStorage_OpenStorage_Stub alias "IStorage_OpenStorage_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_CopyTo_Proxy alias "IStorage_CopyTo_Proxy" (byval as IStorage ptr, byval as DWORD, byval as IID ptr, byval as SNB, byval as IStorage ptr) as HRESULT
declare sub IStorage_CopyTo_Stub alias "IStorage_CopyTo_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_MoveElementTo_Proxy alias "IStorage_MoveElementTo_Proxy" (byval as IStorage ptr, byval as OLECHAR ptr, byval as IStorage ptr, byval as OLECHAR ptr, byval as DWORD) as HRESULT
declare sub IStorage_MoveElementTo_Stub alias "IStorage_MoveElementTo_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_Commit_Proxy alias "IStorage_Commit_Proxy" (byval as IStorage ptr, byval as DWORD) as HRESULT
declare sub IStorage_Commit_Stub alias "IStorage_Commit_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_Revert_Proxy alias "IStorage_Revert_Proxy" (byval as IStorage ptr) as HRESULT
declare sub IStorage_Revert_Stub alias "IStorage_Revert_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_RemoteEnumElements_Proxy alias "IStorage_RemoteEnumElements_Proxy" (byval as IStorage ptr, byval as DWORD, byval as uinteger, byval as BYTE ptr, byval as DWORD, byval as IEnumSTATSTG ptr ptr) as HRESULT
declare sub IStorage_RemoteEnumElements_Stub alias "IStorage_RemoteEnumElements_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_DestroyElement_Proxy alias "IStorage_DestroyElement_Proxy" (byval as IStorage ptr, byval as OLECHAR ptr) as HRESULT
declare sub IStorage_DestroyElement_Stub alias "IStorage_DestroyElement_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_RenameElement_Proxy alias "IStorage_RenameElement_Proxy" (byval as IStorage ptr, byval as OLECHAR ptr, byval as OLECHAR ptr) as HRESULT
declare sub IStorage_RenameElement_Stub alias "IStorage_RenameElement_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_SetElementTimes_Proxy alias "IStorage_SetElementTimes_Proxy" (byval as IStorage ptr, byval as OLECHAR ptr, byval as FILETIME ptr, byval as FILETIME ptr, byval as FILETIME ptr) as HRESULT
declare sub IStorage_SetElementTimes_Stub alias "IStorage_SetElementTimes_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_SetClass_Proxy alias "IStorage_SetClass_Proxy" (byval as IStorage ptr, byval as CLSID ptr) as HRESULT
declare sub IStorage_SetClass_Stub alias "IStorage_SetClass_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_SetStateBits_Proxy alias "IStorage_SetStateBits_Proxy" (byval as IStorage ptr, byval as DWORD, byval as DWORD) as HRESULT
declare sub IStorage_SetStateBits_Stub alias "IStorage_SetStateBits_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IStorage_Stat_Proxy alias "IStorage_Stat_Proxy" (byval as IStorage ptr, byval as STATSTG ptr, byval as DWORD) as HRESULT
declare sub IStorage_Stat_Stub alias "IStorage_Stat_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistFile_IsDirty_Proxy alias "IPersistFile_IsDirty_Proxy" (byval as IPersistFile ptr) as HRESULT
declare sub IPersistFile_IsDirty_Stub alias "IPersistFile_IsDirty_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistFile_Load_Proxy alias "IPersistFile_Load_Proxy" (byval as IPersistFile ptr, byval as LPCOLESTR, byval as DWORD) as HRESULT
declare sub IPersistFile_Load_Stub alias "IPersistFile_Load_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistFile_Save_Proxy alias "IPersistFile_Save_Proxy" (byval as IPersistFile ptr, byval pszFileName as LPCOLESTR, byval as BOOL) as HRESULT
declare sub IPersistFile_Save_Stub alias "IPersistFile_Save_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistFile_SaveCompleted_Proxy alias "IPersistFile_SaveCompleted_Proxy" (byval as IPersistFile ptr, byval as LPCOLESTR) as HRESULT
declare sub IPersistFile_SaveCompleted_Stub alias "IPersistFile_SaveCompleted_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistFile_GetCurFile_Proxy alias "IPersistFile_GetCurFile_Proxy" (byval as IPersistFile ptr, byval as LPCSTR ptr) as HRESULT
declare sub IPersistFile_GetCurFile_Stub alias "IPersistFile_GetCurFile_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistStorage_IsDirty_Proxy alias "IPersistStorage_IsDirty_Proxy" (byval as IPersistStorage ptr) as HRESULT
declare sub IPersistStorage_IsDirty_Stub alias "IPersistStorage_IsDirty_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistStorage_InitNew_Proxy alias "IPersistStorage_InitNew_Proxy" (byval as IPersistStorage ptr, byval as IStorage ptr) as HRESULT
declare sub IPersistStorage_InitNew_Stub alias "IPersistStorage_InitNew_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistStorage_Load_Proxy alias "IPersistStorage_Load_Proxy" (byval as IPersistStorage ptr, byval as IStorage ptr) as HRESULT
declare sub IPersistStorage_Load_Stub alias "IPersistStorage_Load_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistStorage_Save_Proxy alias "IPersistStorage_Save_Proxy" (byval as IPersistStorage ptr, byval as IStorage ptr, byval as BOOL) as HRESULT
declare sub IPersistStorage_Save_Stub alias "IPersistStorage_Save_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistStorage_SaveCompleted_Proxy alias "IPersistStorage_SaveCompleted_Proxy" (byval as IPersistStorage ptr, byval as IStorage ptr) as HRESULT
declare sub IPersistStorage_SaveCompleted_Stub alias "IPersistStorage_SaveCompleted_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPersistStorage_HandsOffStorage_Proxy alias "IPersistStorage_HandsOffStorage_Proxy" (byval as IPersistStorage ptr) as HRESULT
declare sub IPersistStorage_HandsOffStorage_Stub alias "IPersistStorage_HandsOffStorage_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function ILockBytes_RemoteReadAt_Proxy alias "ILockBytes_RemoteReadAt_Proxy" (byval as ILockBytes ptr, byval as ULARGE_INTEGER, byval as BYTE ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
declare sub ILockBytes_RemoteReadAt_Stub alias "ILockBytes_RemoteReadAt_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function ILockBytes_RemoteWriteAt_Proxy alias "ILockBytes_RemoteWriteAt_Proxy" (byval as ILockBytes ptr, byval as ULARGE_INTEGER, byval pv as BYTE ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
declare sub ILockBytes_RemoteWriteAt_Stub alias "ILockBytes_RemoteWriteAt_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function ILockBytes_Flush_Proxy alias "ILockBytes_Flush_Proxy" (byval as ILockBytes ptr) as HRESULT
declare sub ILockBytes_Flush_Stub alias "ILockBytes_Flush_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function ILockBytes_SetSize_Proxy alias "ILockBytes_SetSize_Proxy" (byval as ILockBytes ptr, byval as ULARGE_INTEGER) as HRESULT
declare sub ILockBytes_SetSize_Stub alias "ILockBytes_SetSize_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function ILockBytes_LockRegion_Proxy alias "ILockBytes_LockRegion_Proxy" (byval as ILockBytes ptr, byval as ULARGE_INTEGER, byval as ULARGE_INTEGER, byval as DWORD) as HRESULT
declare sub ILockBytes_LockRegion_Stub alias "ILockBytes_LockRegion_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function ILockBytes_UnlockRegion_Proxy alias "ILockBytes_UnlockRegion_Proxy" (byval as ILockBytes ptr, byval as ULARGE_INTEGER, byval as ULARGE_INTEGER, byval as DWORD) as HRESULT
declare sub ILockBytes_UnlockRegion_Stub alias "ILockBytes_UnlockRegion_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function ILockBytes_Stat_Proxy alias "ILockBytes_Stat_Proxy" (byval as ILockBytes ptr, byval as STATSTG ptr, byval as DWORD) as HRESULT
declare sub ILockBytes_Stat_Stub alias "ILockBytes_Stat_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumFORMATETC_RemoteNext_Proxy alias "IEnumFORMATETC_RemoteNext_Proxy" (byval as IEnumFORMATETC ptr, byval as ULONG, byval as FORMATETC ptr, byval as ULONG ptr) as HRESULT
declare sub IEnumFORMATETC_RemoteNext_Stub alias "IEnumFORMATETC_RemoteNext_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumFORMATETC_Skip_Proxy alias "IEnumFORMATETC_Skip_Proxy" (byval as IEnumFORMATETC ptr, byval as ULONG) as HRESULT
declare sub IEnumFORMATETC_Skip_Stub alias "IEnumFORMATETC_Skip_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumFORMATETC_Reset_Proxy alias "IEnumFORMATETC_Reset_Proxy" (byval as IEnumFORMATETC ptr) as HRESULT
declare sub IEnumFORMATETC_Reset_Stub alias "IEnumFORMATETC_Reset_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumFORMATETC_Clone_Proxy alias "IEnumFORMATETC_Clone_Proxy" (byval as IEnumFORMATETC ptr, byval as IEnumFORMATETC ptr ptr) as HRESULT
declare sub IEnumFORMATETC_Clone_Stub alias "IEnumFORMATETC_Clone_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumFORMATETC_Next_Proxy alias "IEnumFORMATETC_Next_Proxy" (byval as IEnumFORMATETC ptr, byval as ULONG, byval as FORMATETC ptr, byval as ULONG ptr) as HRESULT
declare function IEnumFORMATETC_Next_Stub alias "IEnumFORMATETC_Next_Stub" (byval as IEnumFORMATETC ptr, byval as ULONG, byval as FORMATETC ptr, byval as ULONG ptr) as HRESULT
declare function IEnumSTATDATA_RemoteNext_Proxy alias "IEnumSTATDATA_RemoteNext_Proxy" (byval as IEnumSTATDATA ptr, byval as ULONG, byval as STATDATA ptr, byval as ULONG ptr) as HRESULT
declare sub IEnumSTATDATA_RemoteNext_Stub alias "IEnumSTATDATA_RemoteNext_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumSTATDATA_Skip_Proxy alias "IEnumSTATDATA_Skip_Proxy" (byval as IEnumSTATDATA ptr, byval as ULONG) as HRESULT
declare sub IEnumSTATDATA_Skip_Stub alias "IEnumSTATDATA_Skip_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumSTATDATA_Reset_Proxy alias "IEnumSTATDATA_Reset_Proxy" (byval as IEnumSTATDATA ptr) as HRESULT
declare sub IEnumSTATDATA_Reset_Stub alias "IEnumSTATDATA_Reset_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumSTATDATA_Clone_Proxy alias "IEnumSTATDATA_Clone_Proxy" (byval as IEnumSTATDATA ptr, byval as IEnumSTATDATA ptr ptr) as HRESULT
declare sub IEnumSTATDATA_Clone_Stub alias "IEnumSTATDATA_Clone_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IEnumSTATDATA_Next_Proxy alias "IEnumSTATDATA_Next_Proxy" (byval as IEnumSTATDATA ptr, byval as ULONG, byval as STATDATA ptr, byval as ULONG ptr) as HRESULT
declare function IEnumSTATDATA_Next_Stub alias "IEnumSTATDATA_Next_Stub" (byval as IEnumSTATDATA ptr, byval as ULONG, byval as STATDATA ptr, byval as ULONG ptr) as HRESULT
declare function IRootStorage_SwitchToFile_Proxy alias "IRootStorage_SwitchToFile_Proxy" (byval as IRootStorage ptr, byval as LPCSTR) as HRESULT
declare sub IRootStorage_SwitchToFile_Stub alias "IRootStorage_SwitchToFile_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IAdviseSink_RemoteOnDataChange_Proxy alias "IAdviseSink_RemoteOnDataChange_Proxy" (byval as IAdviseSink ptr, byval as FORMATETC ptr, byval as RemSTGMEDIUM ptr)
declare sub IAdviseSink_RemoteOnDataChange_Stub alias "IAdviseSink_RemoteOnDataChange_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IAdviseSink_RemoteOnViewChange_Proxy alias "IAdviseSink_RemoteOnViewChange_Proxy" (byval as IAdviseSink ptr, byval as DWORD, byval as LONG)
declare sub IAdviseSink_RemoteOnViewChange_Stub alias "IAdviseSink_RemoteOnViewChange_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IAdviseSink_RemoteOnRename_Proxy alias "IAdviseSink_RemoteOnRename_Proxy" (byval as IAdviseSink ptr, byval as IMoniker ptr)
declare sub IAdviseSink_RemoteOnRename_Stub alias "IAdviseSink_RemoteOnRename_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IAdviseSink_RemoteOnSave_Proxy alias "IAdviseSink_RemoteOnSave_Proxy" (byval as IAdviseSink ptr)
declare sub IAdviseSink_RemoteOnSave_Stub alias "IAdviseSink_RemoteOnSave_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IAdviseSink_RemoteOnClose_Proxy alias "IAdviseSink_RemoteOnClose_Proxy" (byval as IAdviseSink ptr) as HRESULT
declare sub IAdviseSink_RemoteOnClose_Stub alias "IAdviseSink_RemoteOnClose_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IAdviseSink_OnDataChange_Proxy alias "IAdviseSink_OnDataChange_Proxy" (byval as IAdviseSink ptr, byval as FORMATETC ptr, byval as STGMEDIUM ptr)
declare sub IAdviseSink_OnDataChange_Stub alias "IAdviseSink_OnDataChange_Stub" (byval as IAdviseSink ptr, byval as FORMATETC ptr, byval as RemSTGMEDIUM ptr)
declare sub IAdviseSink_OnViewChange_Proxy alias "IAdviseSink_OnViewChange_Proxy" (byval as IAdviseSink ptr, byval as DWORD, byval as LONG)
declare sub IAdviseSink_OnViewChange_Stub alias "IAdviseSink_OnViewChange_Stub" (byval as IAdviseSink ptr, byval as DWORD, byval as LONG)
declare sub IAdviseSink_OnRename_Proxy alias "IAdviseSink_OnRename_Proxy" (byval as IAdviseSink ptr, byval as IMoniker ptr)
declare sub IAdviseSink_OnRename_Stub alias "IAdviseSink_OnRename_Stub" (byval as IAdviseSink ptr, byval as IMoniker ptr)
declare sub IAdviseSink_OnSave_Proxy alias "IAdviseSink_OnSave_Proxy" (byval as IAdviseSink ptr)
declare sub IAdviseSink_OnSave_Stub alias "IAdviseSink_OnSave_Stub" (byval as IAdviseSink ptr)
declare sub IAdviseSink_OnClose_Proxy alias "IAdviseSink_OnClose_Proxy" (byval as IAdviseSink ptr)
declare function IAdviseSink_OnClose_Stub alias "IAdviseSink_OnClose_Stub" (byval as IAdviseSink ptr) as HRESULT
declare sub IAdviseSink2_RemoteOnLinkSrcChange_Proxy alias "IAdviseSink2_RemoteOnLinkSrcChange_Proxy" (byval as IAdviseSink2 ptr, byval as IMoniker ptr)
declare sub IAdviseSink2_RemoteOnLinkSrcChange_Stub alias "IAdviseSink2_RemoteOnLinkSrcChange_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IAdviseSink2_OnLinkSrcChange_Proxy alias "IAdviseSink2_OnLinkSrcChange_Proxy" (byval as IAdviseSink2 ptr, byval as IMoniker ptr)
declare sub IAdviseSink2_OnLinkSrcChange_Stub alias "IAdviseSink2_OnLinkSrcChange_Stub" (byval as IAdviseSink2 ptr, byval as IMoniker ptr)
declare function IDataObject_RemoteGetData_Proxy alias "IDataObject_RemoteGetData_Proxy" (byval as IDataObject ptr, byval as FORMATETC ptr, byval as RemSTGMEDIUM ptr ptr) as HRESULT
declare sub IDataObject_RemoteGetData_Stub alias "IDataObject_RemoteGetData_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IDataObject_RemoteGetDataHere_Proxy alias "IDataObject_RemoteGetDataHere_Proxy" (byval as IDataObject ptr, byval as FORMATETC ptr, byval as RemSTGMEDIUM ptr ptr) as HRESULT
declare sub IDataObject_RemoteGetDataHere_Stub alias "IDataObject_RemoteGetDataHere_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IDataObject_QueryGetData_Proxy alias "IDataObject_QueryGetData_Proxy" (byval as IDataObject ptr, byval as FORMATETC ptr) as HRESULT
declare sub IDataObject_QueryGetData_Stub alias "IDataObject_QueryGetData_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IDataObject_GetCanonicalFormatEtc_Proxy alias "IDataObject_GetCanonicalFormatEtc_Proxy" (byval as IDataObject ptr, byval as FORMATETC ptr, byval as FORMATETC ptr) as HRESULT
declare sub IDataObject_GetCanonicalFormatEtc_Stub alias "IDataObject_GetCanonicalFormatEtc_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IDataObject_RemoteSetData_Proxy alias "IDataObject_RemoteSetData_Proxy" (byval as IDataObject ptr, byval as FORMATETC ptr, byval as RemSTGMEDIUM ptr, byval as BOOL) as HRESULT
declare sub IDataObject_RemoteSetData_Stub alias "IDataObject_RemoteSetData_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IDataObject_EnumFormatEtc_Proxy alias "IDataObject_EnumFormatEtc_Proxy" (byval as IDataObject ptr, byval as DWORD, byval as IEnumFORMATETC ptr ptr) as HRESULT
declare sub IDataObject_EnumFormatEtc_Stub alias "IDataObject_EnumFormatEtc_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IDataObject_DAdvise_Proxy alias "IDataObject_DAdvise_Proxy" (byval as IDataObject ptr, byval as FORMATETC ptr, byval as DWORD, byval as IAdviseSink ptr, byval as DWORD ptr) as HRESULT
declare sub IDataObject_DAdvise_Stub alias "IDataObject_DAdvise_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IDataObject_DUnadvise_Proxy alias "IDataObject_DUnadvise_Proxy" (byval as IDataObject ptr, byval as DWORD) as HRESULT
declare sub IDataObject_DUnadvise_Stub alias "IDataObject_DUnadvise_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IDataObject_EnumDAdvise_Proxy alias "IDataObject_EnumDAdvise_Proxy" (byval as IDataObject ptr, byval as IEnumSTATDATA ptr ptr) as HRESULT
declare sub IDataObject_EnumDAdvise_Stub alias "IDataObject_EnumDAdvise_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IDataObject_GetData_Proxy alias "IDataObject_GetData_Proxy" (byval as IDataObject ptr, byval as FORMATETC ptr, byval as STGMEDIUM ptr) as HRESULT
declare function IDataObject_GetData_Stub alias "IDataObject_GetData_Stub" (byval as IDataObject ptr, byval as FORMATETC ptr, byval as RemSTGMEDIUM ptr ptr) as HRESULT
declare function IDataObject_GetDataHere_Proxy alias "IDataObject_GetDataHere_Proxy" (byval as IDataObject ptr, byval as FORMATETC ptr, byval as STGMEDIUM ptr) as HRESULT
declare function IDataObject_GetDataHere_Stub alias "IDataObject_GetDataHere_Stub" (byval as IDataObject ptr, byval as FORMATETC ptr, byval as RemSTGMEDIUM ptr ptr) as HRESULT
declare function IDataObject_SetData_Proxy alias "IDataObject_SetData_Proxy" (byval as IDataObject ptr, byval as FORMATETC ptr, byval as STGMEDIUM ptr, byval as BOOL) as HRESULT
declare function IDataObject_SetData_Stub alias "IDataObject_SetData_Stub" (byval as IDataObject ptr, byval as FORMATETC ptr, byval as RemSTGMEDIUM ptr, byval as BOOL) as HRESULT
declare function IDataAdviseHolder_Advise_Proxy alias "IDataAdviseHolder_Advise_Proxy" (byval as IDataAdviseHolder ptr, byval as IDataObject ptr, byval as FORMATETC ptr, byval as DWORD, byval as IAdviseSink ptr, byval as DWORD ptr) as HRESULT
declare sub IDataAdviseHolder_Advise_Stub alias "IDataAdviseHolder_Advise_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IDataAdviseHolder_Unadvise_Proxy alias "IDataAdviseHolder_Unadvise_Proxy" (byval as IDataAdviseHolder ptr, byval as DWORD) as HRESULT
declare sub IDataAdviseHolder_Unadvise_Stub alias "IDataAdviseHolder_Unadvise_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IDataAdviseHolder_EnumAdvise_Proxy alias "IDataAdviseHolder_EnumAdvise_Proxy" (byval as IDataAdviseHolder ptr, byval as IEnumSTATDATA ptr ptr) as HRESULT
declare sub IDataAdviseHolder_EnumAdvise_Stub alias "IDataAdviseHolder_EnumAdvise_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IDataAdviseHolder_SendOnDataChange_Proxy alias "IDataAdviseHolder_SendOnDataChange_Proxy" (byval as IDataAdviseHolder ptr, byval as IDataObject ptr, byval as DWORD, byval as DWORD) as HRESULT
declare sub IDataAdviseHolder_SendOnDataChange_Stub alias "IDataAdviseHolder_SendOnDataChange_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMessageFilter_HandleInComingCall_Proxy alias "IMessageFilter_HandleInComingCall_Proxy" (byval as IMessageFilter ptr, byval as DWORD, byval as HTASK, byval as DWORD, byval as LPINTERFACEINFO) as DWORD
declare sub IMessageFilter_HandleInComingCall_Stub alias "IMessageFilter_HandleInComingCall_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMessageFilter_RetryRejectedCall_Proxy alias "IMessageFilter_RetryRejectedCall_Proxy" (byval as IMessageFilter ptr, byval as HTASK, byval as DWORD, byval as DWORD) as DWORD
declare sub IMessageFilter_RetryRejectedCall_Stub alias "IMessageFilter_RetryRejectedCall_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IMessageFilter_MessagePending_Proxy alias "IMessageFilter_MessagePending_Proxy" (byval as IMessageFilter ptr, byval as HTASK, byval as DWORD, byval as DWORD) as DWORD
declare sub IMessageFilter_MessagePending_Stub alias "IMessageFilter_MessagePending_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRpcChannelBuffer_GetBuffer_Proxy alias "IRpcChannelBuffer_GetBuffer_Proxy" (byval as IRpcChannelBuffer ptr, byval as RPCOLEMESSAGE ptr, byval as IID ptr) as HRESULT
declare sub IRpcChannelBuffer_GetBuffer_Stub alias "IRpcChannelBuffer_GetBuffer_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRpcChannelBuffer_SendReceive_Proxy alias "IRpcChannelBuffer_SendReceive_Proxy" (byval as IRpcChannelBuffer ptr, byval as RPCOLEMESSAGE ptr, byval as ULONG ptr) as HRESULT
declare sub IRpcChannelBuffer_SendReceive_Stub alias "IRpcChannelBuffer_SendReceive_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRpcChannelBuffer_FreeBuffer_Proxy alias "IRpcChannelBuffer_FreeBuffer_Proxy" (byval as IRpcChannelBuffer ptr, byval as RPCOLEMESSAGE ptr) as HRESULT
declare sub IRpcChannelBuffer_FreeBuffer_Stub alias "IRpcChannelBuffer_FreeBuffer_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRpcChannelBuffer_GetDestCtx_Proxy alias "IRpcChannelBuffer_GetDestCtx_Proxy" (byval as IRpcChannelBuffer ptr, byval as DWORD ptr, byval as any ptr ptr) as HRESULT
declare sub IRpcChannelBuffer_GetDestCtx_Stub alias "IRpcChannelBuffer_GetDestCtx_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRpcChannelBuffer_IsConnected_Proxy alias "IRpcChannelBuffer_IsConnected_Proxy" (byval as IRpcChannelBuffer ptr) as HRESULT
declare sub IRpcChannelBuffer_IsConnected_Stub alias "IRpcChannelBuffer_IsConnected_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRpcProxyBuffer_Connect_Proxy alias "IRpcProxyBuffer_Connect_Proxy" (byval as IRpcProxyBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr) as HRESULT
declare sub IRpcProxyBuffer_Connect_Stub alias "IRpcProxyBuffer_Connect_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IRpcProxyBuffer_Disconnect_Proxy alias "IRpcProxyBuffer_Disconnect_Proxy" (byval as IRpcProxyBuffer ptr)
declare sub IRpcProxyBuffer_Disconnect_Stub alias "IRpcProxyBuffer_Disconnect_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRpcStubBuffer_Connect_Proxy alias "IRpcStubBuffer_Connect_Proxy" (byval as IRpcStubBuffer ptr, byval as IUnknown ptr) as HRESULT
declare sub IRpcStubBuffer_Connect_Stub alias "IRpcStubBuffer_Connect_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IRpcStubBuffer_Disconnect_Proxy alias "IRpcStubBuffer_Disconnect_Proxy" (byval as IRpcStubBuffer ptr)
declare sub IRpcStubBuffer_Disconnect_Stub alias "IRpcStubBuffer_Disconnect_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRpcStubBuffer_Invoke_Proxy alias "IRpcStubBuffer_Invoke_Proxy" (byval as IRpcStubBuffer ptr, byval as RPCOLEMESSAGE ptr, byval as IRpcChannelBuffer ptr) as HRESULT
declare sub IRpcStubBuffer_Invoke_Stub alias "IRpcStubBuffer_Invoke_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRpcStubBuffer_IsIIDSupported_Proxy alias "IRpcStubBuffer_IsIIDSupported_Proxy" (byval as IRpcStubBuffer ptr, byval as IID ptr) as IRpcStubBuffer ptr
declare sub IRpcStubBuffer_IsIIDSupported_Stub alias "IRpcStubBuffer_IsIIDSupported_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRpcStubBuffer_CountRefs_Proxy alias "IRpcStubBuffer_CountRefs_Proxy" (byval as IRpcStubBuffer ptr) as ULONG
declare sub IRpcStubBuffer_CountRefs_Stub alias "IRpcStubBuffer_CountRefs_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IRpcStubBuffer_DebugServerQueryInterface_Proxy alias "IRpcStubBuffer_DebugServerQueryInterface_Proxy" (byval as IRpcStubBuffer ptr, byval as any ptr ptr) as HRESULT
declare sub IRpcStubBuffer_DebugServerQueryInterface_Stub alias "IRpcStubBuffer_DebugServerQueryInterface_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub IRpcStubBuffer_DebugServerRelease_Proxy alias "IRpcStubBuffer_DebugServerRelease_Proxy" (byval as IRpcStubBuffer ptr, byval as any ptr)
declare sub IRpcStubBuffer_DebugServerRelease_Stub alias "IRpcStubBuffer_DebugServerRelease_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPSFactoryBuffer_CreateProxy_Proxy alias "IPSFactoryBuffer_CreateProxy_Proxy" (byval as IPSFactoryBuffer ptr, byval as IUnknown ptr, byval as IID ptr, byval as IRpcProxyBuffer ptr ptr, byval as any ptr ptr) as HRESULT
declare sub IPSFactoryBuffer_CreateProxy_Stub alias "IPSFactoryBuffer_CreateProxy_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare function IPSFactoryBuffer_CreateStub_Proxy alias "IPSFactoryBuffer_CreateStub_Proxy" (byval as IPSFactoryBuffer ptr, byval as IID ptr, byval as IUnknown ptr, byval as IRpcStubBuffer ptr ptr) as HRESULT
declare sub IPSFactoryBuffer_CreateStub_Stub alias "IPSFactoryBuffer_CreateStub_Stub" (byval as IRpcStubBuffer ptr, byval as IRpcChannelBuffer ptr, byval as PRPC_MESSAGE, byval as PDWORD)
declare sub SNB_to_xmit alias "SNB_to_xmit" (byval as SNB ptr, byval as RemSNB ptr ptr)
declare sub SNB_from_xmit alias "SNB_from_xmit" (byval as RemSNB ptr, byval as SNB ptr)
declare sub SNB_free_inst alias "SNB_free_inst" (byval as SNB ptr)
declare sub SNB_free_xmit alias "SNB_free_xmit" (byval as RemSNB ptr)
declare function IEnumUnknown_Next_Proxy alias "IEnumUnknown_Next_Proxy" (byval as IEnumUnknown ptr, byval as ULONG, byval as IUnknown ptr ptr, byval as ULONG ptr) as HRESULT
declare function IEnumUnknown_Next_Stub alias "IEnumUnknown_Next_Stub" (byval as IEnumUnknown ptr, byval as ULONG, byval as IUnknown ptr ptr, byval as ULONG ptr) as HRESULT
declare function IEnumMoniker_Next_Proxy alias "IEnumMoniker_Next_Proxy" (byval as IEnumMoniker ptr, byval as ULONG, byval as IMoniker ptr ptr, byval as ULONG ptr) as HRESULT
declare function IEnumMoniker_Next_Stub alias "IEnumMoniker_Next_Stub" (byval as IEnumMoniker ptr, byval as ULONG, byval as IMoniker ptr ptr, byval as ULONG ptr) as HRESULT
declare function IMoniker_BindToObject_Proxy alias "IMoniker_BindToObject_Proxy" (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare function IMoniker_BindToObject_Stub alias "IMoniker_BindToObject_Stub" (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as IID ptr, byval as IUnknown ptr ptr) as HRESULT
declare function IMoniker_BindToStorage_Proxy alias "IMoniker_BindToStorage_Proxy" (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as IID ptr, byval as any ptr ptr) as HRESULT
declare function IMoniker_BindToStorage_Stub alias "IMoniker_BindToStorage_Stub" (byval as IMoniker ptr, byval as IBindCtx ptr, byval as IMoniker ptr, byval as IID ptr, byval as IUnknown ptr ptr) as HRESULT
declare function IEnumString_Next_Proxy alias "IEnumString_Next_Proxy" (byval as IEnumString ptr, byval as ULONG, byval as LPCSTR ptr, byval as ULONG ptr) as HRESULT
declare function IEnumString_Next_Stub alias "IEnumString_Next_Stub" (byval as IEnumString ptr, byval as ULONG, byval as LPCSTR ptr, byval as ULONG ptr) as HRESULT
declare function IStream_Read_Proxy alias "IStream_Read_Proxy" (byval as IStream ptr, byval as any ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
declare function IStream_Read_Stub alias "IStream_Read_Stub" (byval as IStream ptr, byval as BYTE ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
declare function IStream_Write_Proxy alias "IStream_Write_Proxy" (byval as IStream ptr, byval as any ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
declare function IStream_Write_Stub alias "IStream_Write_Stub" (byval as IStream ptr, byval as BYTE ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
declare function IStream_Seek_Proxy alias "IStream_Seek_Proxy" (byval as IStream ptr, byval as LARGE_INTEGER, byval as DWORD, byval as ULARGE_INTEGER ptr) as HRESULT
declare function IStream_Seek_Stub alias "IStream_Seek_Stub" (byval as IStream ptr, byval as LARGE_INTEGER, byval as DWORD, byval as ULARGE_INTEGER ptr) as HRESULT
declare function IStream_CopyTo_Proxy alias "IStream_CopyTo_Proxy" (byval as IStream ptr, byval as IStream ptr, byval as ULARGE_INTEGER, byval as ULARGE_INTEGER ptr, byval as ULARGE_INTEGER ptr) as HRESULT
declare function IStream_CopyTo_Stub alias "IStream_CopyTo_Stub" (byval as IStream ptr, byval as IStream ptr, byval as ULARGE_INTEGER, byval as ULARGE_INTEGER ptr, byval as ULARGE_INTEGER ptr) as HRESULT
declare function IEnumSTATSTG_Next_Proxy alias "IEnumSTATSTG_Next_Proxy" (byval as IEnumSTATSTG ptr, byval as ULONG, byval as STATSTG ptr, byval as ULONG ptr) as HRESULT
declare function IEnumSTATSTG_Next_Stub alias "IEnumSTATSTG_Next_Stub" (byval as IEnumSTATSTG ptr, byval as ULONG, byval as STATSTG ptr, byval as ULONG ptr) as HRESULT
declare function IStorage_OpenStream_Proxy alias "IStorage_OpenStream_Proxy" (byval as IStorage ptr, byval as OLECHAR ptr, byval as any ptr, byval as DWORD, byval as DWORD, byval as IStream ptr ptr) as HRESULT
declare function IStorage_OpenStream_Stub alias "IStorage_OpenStream_Stub" (byval as IStorage ptr, byval as OLECHAR ptr, byval as uinteger, byval as BYTE ptr, byval as DWORD, byval as DWORD, byval as IStream ptr ptr) as HRESULT
declare function IStorage_EnumElements_Proxy alias "IStorage_EnumElements_Proxy" (byval as IStorage ptr, byval as DWORD, byval as any ptr, byval as DWORD, byval as IEnumSTATSTG ptr ptr) as HRESULT
declare function IStorage_EnumElements_Stub alias "IStorage_EnumElements_Stub" (byval as IStorage ptr, byval as DWORD, byval as uinteger, byval as BYTE ptr, byval as DWORD, byval as IEnumSTATSTG ptr ptr) as HRESULT
declare function ILockBytes_ReadAt_Proxy alias "ILockBytes_ReadAt_Proxy" (byval as ILockBytes ptr, byval as ULARGE_INTEGER, byval as any ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
declare function ILockBytes_ReadAt_Stub alias "ILockBytes_ReadAt_Stub" (byval as ILockBytes ptr, byval as ULARGE_INTEGER, byval as BYTE ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
declare function ILockBytes_WriteAt_Proxy alias "ILockBytes_WriteAt_Proxy" (byval as ILockBytes ptr, byval as ULARGE_INTEGER, byval as any ptr, byval as ULONG, byval as ULONG ptr) as HRESULT
declare function ILockBytes_WriteAt_Stub alias "ILockBytes_WriteAt_Stub" (byval as ILockBytes ptr, byval as ULARGE_INTEGER, byval as BYTE ptr, byval as ULONG, byval as ULONG ptr) as HRESULT

#define IMarshal_QueryInterface(T,r,p) (T)->lpVtbl->QueryInterface(T,r,p)
#define IMarshal_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMarshal_Release(This) (This)->lpVtbl->Release(This)
#define IMarshal_GetUnmarshalClass(T,r,pv,dw,pvD,m,pC) (T)->lpVtbl->GetUnmarshalClass(T,r,pv,dw,pvD,m,pC)
#define IMarshal_GetMarshalSizeMax(T,r,pv,dw,pD,m,p) (T)->lpVtbl->GetMarshalSizeMax(T,r,pv,dw,pD,m,p)
#define IMarshal_MarshalInterface(T,p,r,pv,dw,pvD,m) (T)->lpVtbl->MarshalInterface(T,p,r,pv,dw,pv,m)
#define IMarshal_UnmarshalInterface(T,p,r,pp) (T)->lpVtbl->UnmarshalInterface(T,p,r,pp)
#define IMarshal_ReleaseMarshalData(T,p) (T)->lpVtbl->ReleaseMarshalData(T,p)
#define IMarshal_DisconnectObject(T,d) (T)->lpVtbl->DisconnectObject(T,d)
#define IMalloc_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMalloc_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMalloc_Release(This) (This)->lpVtbl->Release(This)
#define IMalloc_Alloc(This,cb) (This)->lpVtbl->Alloc(This,cb)
#define IMalloc_Realloc(This,pv,cb)	(This)->lpVtbl->Realloc(This,pv,cb)
#define IMalloc_Free(This,pv) (This)->lpVtbl->Free(This,pv)
#define IMalloc_GetSize(This,pv) (This)->lpVtbl->GetSize(This,pv)
#define IMalloc_DidAlloc(This,pv) (This)->lpVtbl->DidAlloc(This,pv)
#define IMalloc_HeapMinimize(This) (This)->lpVtbl->HeapMinimize(This)
#define IMallocSpy_QueryInterface(T,r,p) (T)->lpVtbl->QueryInterface(T,r,p)
#define IMallocSpy_AddRef(This)	(This)->lpVtbl->AddRef(This)
#define IMallocSpy_Release(This) (This)->lpVtbl->Release(This)
#define IMallocSpy_PreAlloc(T,c) (T)->lpVtbl->PreAlloc(T,c)
#define IMallocSpy_PostAlloc(This,p) (This)->lpVtbl->PostAlloc(This,p)
#define IMallocSpy_PreFree(This,p,f) (This)->lpVtbl->PreFree(This,p,f)
#define IMallocSpy_PostFree(This,fSpyed) (This)->lpVtbl->PostFree(This,fSpyed)
#define IMallocSpy_PreRealloc(T,p,c,pp,f) (T)->lpVtbl->PreRealloc(T,p,c,pp,f)
#define IMallocSpy_PostRealloc(T,p,f) (T)->lpVtbl->PostRealloc(T,p,f)
#define IMallocSpy_PreGetSize(This,p,f)	(This)->lpVtbl->PreGetSize(This,p,f)
#define IMallocSpy_PostGetSize(This,cbActual,fSpyed) (This)->lpVtbl->PostGetSize(This,cbActual,fSpyed)
#define IMallocSpy_PreDidAlloc(This,pRequest,fSpyed) (This)->lpVtbl->PreDidAlloc(This,pRequest,fSpyed)
#define IMallocSpy_PostDidAlloc(This,pRequest,fSpyed,fActual) (This)->lpVtbl->PostDidAlloc(This,pRequest,fSpyed,fActual)
#define IMallocSpy_PreHeapMinimize(T) (T)->lpVtbl->PreHeapMinimize(T)
#define IMallocSpy_PostHeapMinimize(T) (T)->lpVtbl->PostHeapMinimize(T)
#define IStdMarshalInfo_QueryInterface(T,r,p) (This)->lpVtbl->QueryInterface(T,r,p)
#define IStdMarshalInfo_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IStdMarshalInfo_Release(This) (This)->lpVtbl->Release(This)
#define IStdMarshalInfo_GetClassForHandler(This,D,p,C) (This)->lpVtbl->GetClassForHandler(This,D,p,C)
#define IExternalConnection_QueryInterface(This,riid,ppvObject)	(This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IExternalConnection_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IExternalConnection_Release(This) (This)->lpVtbl->Release(This)
#define IExternalConnection_AddConnection(T,e,r) (T)->lpVtbl->AddConnection(T,e,r)
#define IExternalConnection_ReleaseConnection(This,e,r,f) (This)->lpVtbl->ReleaseConnection(This,e,r,f)
#define IEnumUnknown_QueryInterface(T,r,p) (This)->lpVtbl->QueryInterface(T,r,p)
#define IEnumUnknown_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumUnknown_Release(This) (This)->lpVtbl->Release(This)
#define IEnumUnknown_Next(This,celt,rgelt,p) (This)->lpVtbl->Next(This,celt,rgelt,p)
#define IEnumUnknown_Skip(This,celt) (This)->lpVtbl->Skip(This,celt)
#define IEnumUnknown_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumUnknown_Clone(This,ppenum)	 (This)->lpVtbl->Clone(This,ppenum)
#define IBindCtx_QueryInterface(T,r,p) (T)->lpVtbl->QueryInterface(T,r,p)
#define IBindCtx_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IBindCtx_Release(This)	(This)->lpVtbl->Release(This)
#define IBindCtx_RegisterObjectBound(T,p) (T)->lpVtbl->RegisterObjectBound(T,p)
#define IBindCtx_RevokeObjectBound(T,p)	(T)->lpVtbl->RevokeObjectBound(T,p)
#define IBindCtx_ReleaseBoundObjects(T) (T)->lpVtbl->ReleaseBoundObjects(T)
#define IBindCtx_SetBindOptions(T,p) (T)->lpVtbl->SetBindOptions(T,p)
#define IBindCtx_GetBindOptions(This,pbindopts)	(This)->lpVtbl->GetBindOptions(This,pbindopts)
#define IBindCtx_GetRunningObjectTable(This,pprot) (This)->lpVtbl->GetRunningObjectTable(This,pprot)
#define IBindCtx_RegisterObjectParam(This,pszKey,punk) (This)->lpVtbl->RegisterObjectParam(This,pszKey,punk)
#define IBindCtx_GetObjectParam(This,pszKey,ppunk) (This)->lpVtbl->GetObjectParam(This,pszKey,ppunk)
#define IBindCtx_EnumObjectParam(This,ppenum) (This)->lpVtbl->EnumObjectParam(This,ppenum)
#define IBindCtx_RevokeObjectParam(This,pszKey)	(This)->lpVtbl->RevokeObjectParam(This,pszKey)
#define IEnumMoniker_QueryInterface(T,r,p) (T)->lpVtbl->QueryInterface(T,r,p)
#define IEnumMoniker_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumMoniker_Release(This) (This)->lpVtbl->Release(This)
#define IEnumMoniker_Next(This,celt,rgelt,pceltFetched)	(This)->lpVtbl->Next(This,celt,rgelt,pceltFetched)
#define IEnumMoniker_Skip(This,celt) (This)->lpVtbl->Skip(This,celt)
#define IEnumMoniker_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumMoniker_Clone(This,ppenum) (This)->lpVtbl->Clone(This,ppenum)
#define IRunnableObject_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IRunnableObject_AddRef(This)	(This)->lpVtbl->AddRef(This)
#define IRunnableObject_Release(This)	(This)->lpVtbl->Release(This)
#define IRunnableObject_GetRunningClass(This,lpClsid)	(This)->lpVtbl->GetRunningClass(This,lpClsid)
#define IRunnableObject_Run(This,pbc)	(This)->lpVtbl->Run(This,pbc)
#define IRunnableObject_IsRunning(This)	(This)->lpVtbl->IsRunning(This)
#define IRunnableObject_LockRunning(This,fLock,fLastUnlockCloses) (This)->lpVtbl->LockRunning(This,fLock,fLastUnlockCloses)
#define IRunnableObject_SetContainedObject(This,fContained) (This)->lpVtbl->SetContainedObject(This,fContained)
#define IRunningObjectTable_QueryInterface(This,riid,ppvObject)	(This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IRunningObjectTable_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRunningObjectTable_Release(This) (This)->lpVtbl->Release(This)
#define IRunningObjectTable_Register(This,grfFlags,punkObject,pmkObjectName,pdwRegister) (This)->lpVtbl->Register(This,grfFlags,punkObject,pmkObjectName,pdwRegister)
#define IRunningObjectTable_Revoke(This,dwRegister) (This)->lpVtbl->Revoke(This,dwRegister)
#define IRunningObjectTable_IsRunning(This,pmkObjectName) (This)->lpVtbl->IsRunning(This,pmkObjectName)
#define IRunningObjectTable_GetObject(This,pmkObjectName,ppunkObject) (This)->lpVtbl->GetObject(This,pmkObjectName,ppunkObject)
#define IRunningObjectTable_NoteChangeTime(This,dwRegister,pfiletime) (This)->lpVtbl->NoteChangeTime(This,dwRegister,pfiletime)
#define IRunningObjectTable_GetTimeOfLastChange(This,pmkObjectName,pfiletime) (This)->lpVtbl->GetTimeOfLastChange(This,pmkObjectName,pfiletime)
#define IRunningObjectTable_EnumRunning(This,ppenumMoniker) (This)->lpVtbl->EnumRunning(This,ppenumMoniker)
#define IPersist_QueryInterface(T,r,p) (T)->lpVtbl->QueryInterface(T,r,p)
#define IPersist_AddRef(This)	(This)->lpVtbl->AddRef(This)
#define IPersist_Release(This)	(This)->lpVtbl->Release(This)
#define IPersist_GetClassID(This,pClassID) (This)->lpVtbl->GetClassID(This,pClassID)
#define IPersistStream_QueryInterface(T,r,p) (T)->lpVtbl->QueryInterface(T,r,p)
#define IPersistStream_AddRef(This)	(This)->lpVtbl->AddRef(This)
#define IPersistStream_Release(This)	(This)->lpVtbl->Release(This)
#define IPersistStream_GetClassID(T,p) (T)->lpVtbl->GetClassID(T,p)
#define IPersistStream_IsDirty(This)	(This)->lpVtbl->IsDirty(This)
#define IPersistStream_Load(This,pStm)	(This)->lpVtbl->Load(This,pStm)
#define IPersistStream_Save(T,p,f) (T)->lpVtbl->Save(T,p,f)
#define IPersistStream_GetSizeMax(T,p) (T)->lpVtbl->GetSizeMax(T,p)
#define IMoniker_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMoniker_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMoniker_Release(This)	(This)->lpVtbl->Release(This)
#define IMoniker_GetClassID(This,pClassID) (This)->lpVtbl->GetClassID(This,pClassID)
#define IMoniker_IsDirty(This)	(This)->lpVtbl->IsDirty(This)
#define IMoniker_Load(This,pStm) (This)->lpVtbl->Load(This,pStm)
#define IMoniker_Save(This,pStm,fClearDirty) (This)->lpVtbl->Save(This,pStm,fClearDirty)
#define IMoniker_GetSizeMax(This,pcbSize) (This)->lpVtbl->GetSizeMax(This,pcbSize)
#define IMoniker_BindToObject(T,p,pm,r,pp) (T)->lpVtbl->BindToObject(T,p,pm,r,pp)
#define IMoniker_BindToStorage(This,pbc,pmkToLeft,riid,ppvObj) (This)->lpVtbl->BindToStorage(This,pbc,pmkToLeft,riid,ppvObj)
#define IMoniker_Reduce(This,pbc,dwReduceHowFar,ppmkToLeft,ppmkReduced)	(This)->lpVtbl->Reduce(This,pbc,dwReduceHowFar,ppmkToLeft,ppmkReduced)
#define IMoniker_ComposeWith(This,pmkRight,fOnlyIfNotGeneric,ppmkComposite) (This)->lpVtbl->ComposeWith(This,pmkRight,fOnlyIfNotGeneric,ppmkComposite)
#define IMoniker_Enum(T,f,pp) (T)->lpVtbl->Enum(T,f,pp)
#define IMoniker_IsEqual(This,p) (This)->lpVtbl->IsEqual(This,p)
#define IMoniker_Hash(This,pdwHash) (This)->lpVtbl->Hash(This,pdwHash)
#define IMoniker_IsRunning(T,pbc,Left_,N) (T)->lpVtbl->IsRunning(T,pbc,Left_,N)
#define IMoniker_GetTimeOfLastChange(This,pbc,pmkToLeft,pFileTime) (This)->lpVtbl->GetTimeOfLastChange(This,pbc,pmkToLeft,pFileTime)
#define IMoniker_Inverse(This,ppmk) (This)->lpVtbl->Inverse(This,ppmk)
#define IMoniker_CommonPrefixWith(This,pmkOther,ppmkPrefix) (This)->lpVtbl->CommonPrefixWith(This,pmkOther,ppmkPrefix)
#define IMoniker_RelativePathTo(This,pmkOther,ppmkRelPath) (This)->lpVtbl->RelativePathTo(This,pmkOther,ppmkRelPath)
#define IMoniker_GetDisplayName(This,pbc,pmkToLeft,ppszDisplayName) (This)->lpVtbl->GetDisplayName(This,pbc,pmkToLeft,ppszDisplayName)
#define IMoniker_ParseDisplayName(This,pbc,pmkToLeft,pszDisplayName,pchEaten,ppmkOut) (This)->lpVtbl->ParseDisplayName(This,pbc,pmkToLeft,pszDisplayName,pchEaten,ppmkOut)
#define IMoniker_IsSystemMoniker(This,pdwMksys)	(This)->lpVtbl->IsSystemMoniker(This,pdwMksys)
#define IROTData_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IROTData_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IROTData_Release(This) (This)->lpVtbl->Release(This)
#define IROTData_GetComparisonData(This,pbData,cbMax,pcbData) (This)->lpVtbl->GetComparisonData(This,pbData,cbMax,pcbData)
#define IEnumString_QueryInterface(This,riid,ppvObject)	(This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IEnumString_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumString_Release(This) (This)->lpVtbl->Release(This)
#define IEnumString_Next(This,celt,rgelt,pceltFetched) (This)->lpVtbl->Next(This,celt,rgelt,pceltFetched)
#define IEnumString_Skip(This,celt) (This)->lpVtbl->Skip(This,celt)
#define IEnumString_Reset(This)	(This)->lpVtbl->Reset(This)
#define IEnumString_Clone(This,ppenum) (This)->lpVtbl->Clone(This,ppenum)
#define IStream_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IStream_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IStream_Release(This) (This)->lpVtbl->Release(This)
#define IStream_Read(This,pv,cb,pcbRead) (This)->lpVtbl->Read(This,pv,cb,pcbRead)
#define IStream_Write(This,pv,cb,pcbWritten) (This)->lpVtbl->Write(This,pv,cb,pcbWritten)
#define IStream_Seek(This,dlibMove,dwOrigin,plibNewPosition) (This)->lpVtbl->Seek(This,dlibMove,dwOrigin,plibNewPosition)
#define IStream_SetSize(This,libNewSize) (This)->lpVtbl->SetSize(This,libNewSize)
#define IStream_CopyTo(This,pstm,cb,pcbRead,pcbWritten)	(This)->lpVtbl->CopyTo(This,pstm,cb,pcbRead,pcbWritten)
#define IStream_Commit(This,grfCommitFlags) (This)->lpVtbl->Commit(This,grfCommitFlags)
#define IStream_Revert(This) (This)->lpVtbl->Revert(This)
#define IStream_LockRegion(This,libOffset,cb,dwLockType) (This)->lpVtbl->LockRegion(This,libOffset,cb,dwLockType)
#define IStream_UnlockRegion(This,libOffset,cb,dwLockType) (This)->lpVtbl->UnlockRegion(This,libOffset,cb,dwLockType)
#define IStream_Stat(This,pstatstg,grfStatFlag)	(This)->lpVtbl->Stat(This,pstatstg,grfStatFlag)
#define IStream_Clone(This,ppstm) (This)->lpVtbl->Clone(This,ppstm)
#define IEnumSTATSTG_QueryInterface(T,r,p) (T)->lpVtbl->QueryInterface(T,r,p)
#define IEnumSTATSTG_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumSTATSTG_Release(This) (This)->lpVtbl->Release(This)
#define IEnumSTATSTG_Next(T,c,r,p) (T)->lpVtbl->Next(T,c,r,p)
#define IEnumSTATSTG_Skip(This,celt)	(This)->lpVtbl->Skip(This,celt)
#define IEnumSTATSTG_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumSTATSTG_Clone(This,ppenum)	 (This)->lpVtbl->Clone(This,ppenum)
#define IStorage_QueryInterface(T,r,p) (T)->lpVtbl->QueryInterface(T,r,p)
#define IStorage_AddRef(This)	 (This)->lpVtbl->AddRef(This)
#define IStorage_Release(This)	 (This)->lpVtbl->Release(This)
#define IStorage_CreateStream(T,p,g,r1,r2,pp) (T)->lpVtbl->CreateStream(T,p,g,r1,r2,pp)
#define IStorage_OpenStream(T,p,r1,g,r2,pp) (T)->lpVtbl->OpenStream(T,p,r1,g,r2,pp)
#define IStorage_CreateStorage(T,p,g,d,r2,pp) (This)->lpVtbl->CreateStorage(T,p,g,d,r2,pp)
#define IStorage_OpenStorage(This,pwcsName,pstgPriority,grfMode,snbExclude,reserved,ppstg) (This)->lpVtbl->OpenStorage(This,pwcsName,pstgPriority,grfMode,snbExclude,reserved,ppstg)
#define IStorage_CopyTo(This,ciidExclude,rgiidExclude,snbExclude,pstgDest) (This)->lpVtbl->CopyTo(This,ciidExclude,rgiidExclude,snbExclude,pstgDest)
#define IStorage_MoveElementTo(This,pwcsName,pstgDest,pwcsNewName,grfFlags) (This)->lpVtbl->MoveElementTo(This,pwcsName,pstgDest,pwcsNewName,grfFlags)
#define IStorage_Commit(This,g) (This)->lpVtbl->Commit(This,g)
#define IStorage_Revert(This) (This)->lpVtbl->Revert(This)
#define IStorage_EnumElements(This,reserved1,reserved2,reserved3,ppenum) (This)->lpVtbl->EnumElements(This,reserved1,reserved2,reserved3,ppenum)
#define IStorage_DestroyElement(This,pwcsName)	(This)->lpVtbl->DestroyElement(This,pwcsName)
#define IStorage_RenameElement(This,pwcsOldName,pwcsNewName) (This)->lpVtbl->RenameElement(This,pwcsOldName,pwcsNewName)
#define IStorage_SetElementTimes(This,pwcsName,pctime,patime,pmtime) (This)->lpVtbl->SetElementTimes(This,pwcsName,pctime,patime,pmtime)
#define IStorage_SetClass(This,clsid) (This)->lpVtbl->SetClass(This,clsid)
#define IStorage_SetStateBits(This,grfStateBits,grfMask) (This)->lpVtbl->SetStateBits(This,grfStateBits,grfMask)
#define IStorage_Stat(This,p,g) (This)->lpVtbl->Stat(This,p,g)
#define IPersistFile_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IPersistFile_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPersistFile_Release(This) (This)->lpVtbl->Release(This)
#define IPersistFile_GetClassID(This,pClassID)	(This)->lpVtbl->GetClassID(This,pClassID)
#define IPersistFile_IsDirty(This) (This)->lpVtbl->IsDirty(This)
#define IPersistFile_Load(This,pszFileName,dwMode) (This)->lpVtbl->Load(This,pszFileName,dwMode)
#define IPersistFile_Save(This,pszFileName,fRemember) (This)->lpVtbl->Save(This,pszFileName,fRemember)
#define IPersistFile_SaveCompleted(This,pszFileName) (This)->lpVtbl->SaveCompleted(This,pszFileName)
#define IPersistFile_GetCurFile(This,ppszFileName) (This)->lpVtbl->GetCurFile(This,ppszFileName)
#define IPersistStorage_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IPersistStorage_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IPersistStorage_Release(This) (This)->lpVtbl->Release(This)
#define IPersistStorage_GetClassID(This,pClassID) (This)->lpVtbl->GetClassID(This,pClassID)
#define IPersistStorage_IsDirty(This) (This)->lpVtbl->IsDirty(This)
#define IPersistStorage_InitNew(This,pStg) (This)->lpVtbl->InitNew(This,pStg)
#define IPersistStorage_Load(This,pStg)	(This)->lpVtbl->Load(This,pStg)
#define IPersistStorage_Save(This,pStgSave,fSameAsLoad)	(This)->lpVtbl->Save(This,pStgSave,fSameAsLoad)
#define IPersistStorage_SaveCompleted(This,pStgNew) (This)->lpVtbl->SaveCompleted(This,pStgNew)
#define IPersistStorage_HandsOffStorage(This) (This)->lpVtbl->HandsOffStorage(This)
#define ILockBytes_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define ILockBytes_AddRef(This)	(This)->lpVtbl->AddRef(This)
#define ILockBytes_Release(This) (This)->lpVtbl->Release(This)
#define ILockBytes_ReadAt(This,ulOffset,pv,cb,pcbRead) (This)->lpVtbl->ReadAt(This,ulOffset,pv,cb,pcbRead)
#define ILockBytes_WriteAt(This,ulOffset,pv,cb,pcbWritten) (This)->lpVtbl->WriteAt(This,ulOffset,pv,cb,pcbWritten)
#define ILockBytes_Flush(This) (This)->lpVtbl->Flush(This)
#define ILockBytes_SetSize(This,cb) (This)->lpVtbl->SetSize(This,cb)
#define ILockBytes_LockRegion(This,libOffset,cb,dwLockType) (This)->lpVtbl->LockRegion(This,libOffset,cb,dwLockType)
#define ILockBytes_UnlockRegion(This,libOffset,cb,dwLockType) (This)->lpVtbl->UnlockRegion(This,libOffset,cb,dwLockType)
#define ILockBytes_Stat(This,pstatstg,grfStatFlag) (This)->lpVtbl->Stat(This,pstatstg,grfStatFlag)
#define IEnumFORMATETC_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IEnumFORMATETC_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumFORMATETC_Release(This) (This)->lpVtbl->Release(This)
#define IEnumFORMATETC_Next(This,celt,rgelt,pceltFetched) (This)->lpVtbl->Next(This,celt,rgelt,pceltFetched)
#define IEnumFORMATETC_Skip(This,celt) (This)->lpVtbl->Skip(This,celt)
#define IEnumFORMATETC_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumFORMATETC_Clone(This,ppenum) (This)->lpVtbl->Clone(This,ppenum)
#define IEnumSTATDATA_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IEnumSTATDATA_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumSTATDATA_Release(This) (This)->lpVtbl->Release(This)
#define IEnumSTATDATA_Next(This,celt,rgelt,pceltFetched) (This)->lpVtbl->Next(This,celt,rgelt,pceltFetched)
#define IEnumSTATDATA_Skip(This,celt) (This)->lpVtbl->Skip(This,celt)
#define IEnumSTATDATA_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumSTATDATA_Clone(This,ppenum) (This)->lpVtbl->Clone(This,ppenum)
#define IRootStorage_QueryInterface(T,r,O) (T)->lpVtbl->QueryInterface(T,r,O)
#define IRootStorage_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRootStorage_Release(This)	 (This)->lpVtbl->Release(This)
#define IRootStorage_SwitchToFile(This,pszFile)	 (This)->lpVtbl->SwitchToFile(This,pszFile)
#define IAdviseSink_QueryInterface(This,riid,ppvObject)	(This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IAdviseSink_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAdviseSink_Release(This) (This)->lpVtbl->Release(This)
#define IAdviseSink_OnDataChange(This,pFormatetc,pStgmed) (This)->lpVtbl->OnDataChange(This,pFormatetc,pStgmed)
#define IAdviseSink_OnViewChange(This,dwAspect,lindex) (This)->lpVtbl->OnViewChange(This,dwAspect,lindex)
#define IAdviseSink_OnRename(This,pmk) (This)->lpVtbl->OnRename(This,pmk)
#define IAdviseSink_OnSave(This) (This)->lpVtbl->OnSave(This)
#define IAdviseSink_OnClose(This) (This)->lpVtbl->OnClose(This)
#define IAdviseSink2_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IAdviseSink2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAdviseSink2_Release(This) (This)->lpVtbl->Release(This)
#define IAdviseSink2_OnDataChange(This,pFormatetc,pStgmed) (This)->lpVtbl->OnDataChange(This,pFormatetc,pStgmed)
#define IAdviseSink2_OnViewChange(This,dwAspect,lindex)	(This)->lpVtbl->OnViewChange(This,dwAspect,lindex)
#define IAdviseSink2_OnRename(This,pmk)	(This)->lpVtbl->OnRename(This,pmk)
#define IAdviseSink2_OnSave(This) (This)->lpVtbl->OnSave(This)
#define IAdviseSink2_OnClose(This) (This)->lpVtbl->OnClose(This)
#define IAdviseSink2_OnLinkSrcChange(This,pmk) (This)->lpVtbl->OnLinkSrcChange(This,pmk)
#define IDataObject_QueryInterface(This,riid,ppvObject)	(This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IDataObject_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDataObject_Release(This) (This)->lpVtbl->Release(This)
#define IDataObject_GetData(This,pformatetcIn,pmedium) (This)->lpVtbl->GetData(This,pformatetcIn,pmedium)
#define IDataObject_GetDataHere(This,pformatetc,pmedium) (This)->lpVtbl->GetDataHere(This,pformatetc,pmedium)
#define IDataObject_QueryGetData(This,pformatetc) (This)->lpVtbl->QueryGetData(This,pformatetc)
#define IDataObject_GetCanonicalFormatEtc(This,pformatectIn,pformatetcOut) (This)->lpVtbl->GetCanonicalFormatEtc(This,pformatectIn,pformatetcOut)
#define IDataObject_SetData(This,pformatetc,pmedium,fRelease) (This)->lpVtbl->SetData(This,pformatetc,pmedium,fRelease)
#define IDataObject_EnumFormatEtc(This,dwDirection,ppenumFormatEtc) (This)->lpVtbl->EnumFormatEtc(This,dwDirection,ppenumFormatEtc)
#define IDataObject_DAdvise(This,pformatetc,advf,pAdvSink,pdwConnection) (This)->lpVtbl->DAdvise(This,pformatetc,advf,pAdvSink,pdwConnection)
#define IDataObject_DUnadvise(This,dwConnection) (This)->lpVtbl->DUnadvise(This,dwConnection)
#define IDataObject_EnumDAdvise(This,ppenumAdvise) (This)->lpVtbl->EnumDAdvise(This,ppenumAdvise)
#define IDataAdviseHolder_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IDataAdviseHolder_AddRef(This)	(This)->lpVtbl->AddRef(This)
#define IDataAdviseHolder_Release(This)	(This)->lpVtbl->Release(This)
#define IDataAdviseHolder_Advise(This,pDataObject,pFetc,advf,pAdvise,pdwConnection) (This)->lpVtbl->Advise(This,pDataObject,pFetc,advf,pAdvise,pdwConnection)
#define IDataAdviseHolder_Unadvise(This,dwConnection) (This)->lpVtbl->Unadvise(This,dwConnection)
#define IDataAdviseHolder_EnumAdvise(This,ppenumAdvise)	(This)->lpVtbl->EnumAdvise(This,ppenumAdvise)
#define IDataAdviseHolder_SendOnDataChange(This,pDataObject,dwReserved,advf) (This)->lpVtbl->SendOnDataChange(This,pDataObject,dwReserved,advf)
#define IMessageFilter_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMessageFilter_AddRef(This)	 (This)->lpVtbl->AddRef(This)
#define IMessageFilter_Release(This)	 (This)->lpVtbl->Release(This)
#define IMessageFilter_HandleInComingCall(T,d,h,dw,lp) (T)->lpVtbl->HandleInComingCall(T,d,h,dw,lp)
#define IMessageFilter_RetryRejectedCall(s,C,T,R) (s)->lpVtbl->RetryRejectedCall(s,C,T,R)
#define IMessageFilter_MessagePending(s,C,T,P) (s)->lpVtbl->MessagePending(This,C,T,P)
#define IRpcChannelBuffer_QueryInterface(T,r,p)	(T)->lpVtbl->QueryInterface(T,r,p)
#define IRpcChannelBuffer_AddRef(This)	(This)->lpVtbl->AddRef(This)
#define IRpcChannelBuffer_Release(This)	(This)->lpVtbl->Release(This)
#define IRpcChannelBuffer_GetBuffer(This,pMessage,riid)	(This)->lpVtbl->GetBuffer(This,pMessage,riid)
#define IRpcChannelBuffer_SendReceive(T,p,pS) (T)->lpVtbl->SendReceive(T,p,pS)
#define IRpcChannelBuffer_FreeBuffer(T,p) (T)->lpVtbl->FreeBuffer(T,p)
#define IRpcChannelBuffer_GetDestCtx(This,pdwDestContext,ppvDestContext) (This)->lpVtbl->GetDestCtx(This,pdwDestContext,ppvDestContext)
#define IRpcChannelBuffer_IsConnected(This) (This)->lpVtbl->IsConnected(This)
#define IRpcProxyBuffer_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IRpcProxyBuffer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRpcProxyBuffer_Release(This) (This)->lpVtbl->Release(This)
#define IRpcProxyBuffer_Connect(This,pRpcChannelBuffer)	(This)->lpVtbl->Connect(This,pRpcChannelBuffer)
#define IRpcProxyBuffer_Disconnect(This) (This)->lpVtbl->Disconnect(This)
#define IRpcStubBuffer_QueryInterface(T,r,pp) (T)->lpVtbl->QueryInterface(T,r,pp)
#define IRpcStubBuffer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRpcStubBuffer_Release(This)	(This)->lpVtbl->Release(This)
#define IRpcStubBuffer_Connect(This,p)	 (This)->lpVtbl->Connect(This,p)
#define IRpcStubBuffer_Disconnect(This)	 (This)->lpVtbl->Disconnect(This)
#define IRpcStubBuffer_Invoke(T,_prpcmsg,_p)	 (T)->lpVtbl->Invoke(This,_prpcmsg,_p)
#define IRpcStubBuffer_IsIIDSupported(T,d) (T)->lpVtbl->IsIIDSupported(T,d)
#define IRpcStubBuffer_CountRefs(This)	 (This)->lpVtbl->CountRefs(This)
#define IRpcStubBuffer_DebugServerQueryInterface(T,p) (T)->lpVtbl->DebugServerQueryInterface(T,p)
#define IRpcStubBuffer_DebugServerRelease(T,p) (T)->lpVtbl->DebugServerRelease(T,p)
#define IPSFactoryBuffer_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IPSFactoryBuffer_AddRef(This)	(This)->lpVtbl->AddRef(This)
#define IPSFactoryBuffer_Release(This)	(This)->lpVtbl->Release(This)
#define IPSFactoryBuffer_CreateProxy(T,U,r,P,p) (T)->lpVtbl->CreateProxy(T,U,r,P,p)
#define IPSFactoryBuffer_CreateStub(T,r,U,p) (T)->lpVtbl->CreateStub(T,r,U,p)
#define IGlobalInterfaceTable_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IGlobalInterfaceTable_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IGlobalInterfaceTable_Release(T) (T)->lpVtbl->Release(T)
#define IGlobalInterfaceTable_RegisterInterfaceInGlobal(T,a,b,c) (T)->lpVtbl->RegisterInterfaceInGlobal(T,a,b,c)
#define IGlobalInterfaceTable_RevokeInterfaceFromGlobal(T,a) (T)->lpVtbl->RevokeInterfaceFromGlobal(T,a)
#define IGlobalInterfaceTable_GetInterfaceFromGlobal(T,a,b,c) (T)->lpVtbl->GetInterfaceFromGlobal(T,a,b,c)

#endif
