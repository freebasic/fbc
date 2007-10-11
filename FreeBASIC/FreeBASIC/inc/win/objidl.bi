''
''
'' objidl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_objidl_bi__
#define __win_objidl_bi__

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
	tdData(0 to 1-1) as UBYTE
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
	data(0 to 1-1) as UBYTE
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
	Enum_ as function (byval as IMoniker ptr, byval as BOOL, byval as IEnumMoniker ptr ptr) as HRESULT
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
	Enum_ as function (byval as IPropertyStorage ptr, byval as IEnumSTATPROPSTG ptr ptr) as HRESULT
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
	Del as function (byval as IPropertySetStorage ptr, byval as REFFMTID) as HRESULT
	Enum_ as function (byval as IPropertySetStorage ptr, byval as IEnumSTATPROPSETSTG ptr ptr) as HRESULT
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

declare sub SNB_to_xmit alias "SNB_to_xmit" (byval as SNB ptr, byval as RemSNB ptr ptr)
declare sub SNB_from_xmit alias "SNB_from_xmit" (byval as RemSNB ptr, byval as SNB ptr)
declare sub SNB_free_inst alias "SNB_free_inst" (byval as SNB ptr)
declare sub SNB_free_xmit alias "SNB_free_xmit" (byval as RemSNB ptr)

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
#define IPSFactoryBuffer_CreateProxy(T,U,r,PP,p) (T)->lpVtbl->CreateProxy(T,U,r,PP,p)
#define IPSFactoryBuffer_CreateStub(T,r,U,p) (T)->lpVtbl->CreateStub(T,r,U,p)
#define IGlobalInterfaceTable_QueryInterface(T,a,b) (T)->lpVtbl->QueryInterface(T,a,b)
#define IGlobalInterfaceTable_AddRef(T) (T)->lpVtbl->AddRef(T)
#define IGlobalInterfaceTable_Release(T) (T)->lpVtbl->Release(T)
#define IGlobalInterfaceTable_RegisterInterfaceInGlobal(T,a,b,c) (T)->lpVtbl->RegisterInterfaceInGlobal(T,a,b,c)
#define IGlobalInterfaceTable_RevokeInterfaceFromGlobal(T,a) (T)->lpVtbl->RevokeInterfaceFromGlobal(T,a)
#define IGlobalInterfaceTable_GetInterfaceFromGlobal(T,a,b,c) (T)->lpVtbl->GetInterfaceFromGlobal(T,a,b,c)

#endif
