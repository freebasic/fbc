''
''
'' wtypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_wtypes_bi__
#define __win_wtypes_bi__

#include once "win/rpc.bi"
#include once "win/rpcndr.bi"

#define IID_NULL GUID_NULL
#define CLSID_NULL GUID_NULL
#define CBPCLIPDATA(d) (d.cbSize-sizeof(d.ulClipFmt))
#define DECIMAL_NEG cubyte(&h80)
#define DECIMAL_SETZERO(d) d.Lo64=0 : d.Hi32=0 : d.signscale=0
#define ROTFLAGS_REGISTRATIONKEEPSALIVE	&h01
#define ROTFLAGS_ALLOWANYCLIENT		&h02

#ifndef BLOB
type BLOB
	cbSize as ULONG
	pBlobData as UBYTE ptr
end type

type PBLOB as BLOB ptr
type LPBLOB as BLOB ptr
#endif

enum DVASPECT
	DVASPECT_CONTENT = 1
	DVASPECT_THUMBNAIL = 2
	DVASPECT_ICON = 4
	DVASPECT_DOCPRINT = 8
end enum

enum DVASPECT2
	DVASPECT_OPAQUE = 16
	DVASPECT_TRANSPARENT = 32
end enum

enum STATFLAG
	STATFLAG_DEFAULT = 0
	STATFLAG_NONAME = 1
end enum

enum MEMCTX
	MEMCTX_LOCAL = 0
	MEMCTX_TASK
	MEMCTX_SHARED
	MEMCTX_MACSYSTEM
	MEMCTX_UNKNOWN = -1
	MEMCTX_SAME = -2
end enum

enum MSHCTX
	MSHCTX_LOCAL = 0
	MSHCTX_NOSHAREDMEM
	MSHCTX_DIFFERENTMACHINE
	MSHCTX_INPROC
end enum

enum CLSCTX
	CLSCTX_INPROC_SERVER = 1
	CLSCTX_INPROC_HANDLER = 2
	CLSCTX_LOCAL_SERVER = 4
	CLSCTX_INPROC_SERVER16 = 8
	CLSCTX_REMOTE_SERVER = 16
end enum

enum MSHLFLAGS
	MSHLFLAGS_NORMAL
	MSHLFLAGS_TABLESTRONG
	MSHLFLAGS_TABLEWEAK
end enum

type FLAGGED_WORD_BLOB
	fFlags as uinteger
	clSize as uinteger
	asData(0 to 1-1) as ushort
end type

#ifndef OLE2ANSI
type OLECHAR as WCHAR
type LPOLESTR as LPWSTR
type LPCOLESTR as LPCWSTR
#define OLESTR(s) wstr(s)
#else
type OLECHAR as byte
type LPOLESTR as LPSTR
type LPCOLESTR as LPCSTR
#define OLESTR(s) s
#endif

type VARTYPE as ushort
type VARIANT_BOOL as short
type _VARIANT_BOOL as VARIANT_BOOL
#define VARIANT_TRUE cshort(&hffff)
#define VARIANT_FALSE cshort(0)

type BSTR as OLECHAR ptr
type wireBSTR as FLAGGED_WORD_BLOB ptr
type LPBSTR as BSTR ptr
type SCODE as LONG
type HCONTEXT as any ptr

union CY
	type
		Lo as uinteger
		Hi as integer
	end type
	int64 as LONGLONG
end union

type DATE_ as double

type BSTRBLOB
	cbSize as ULONG
	pData as PBYTE
end type

type LPBSTRBLOB as BSTRBLOB ptr

type CLIPDATA
	cbSize as ULONG
	ulClipFmt as integer
	pClipData as PBYTE
end type

enum STGC
	STGC_DEFAULT
	STGC_OVERWRITE
	STGC_ONLYIFCURRENT
	STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE
end enum

enum STGMOVE
	STGMOVE_MOVE
	STGMOVE_COPY
	STGMOVE_SHALLOWCOPY
end enum

enum VARENUM
	VT_EMPTY
	VT_NULL
	VT_I2
	VT_I4
	VT_R4
	VT_R8
	VT_CY
	VT_DATE
	VT_BSTR
	VT_DISPATCH
	VT_ERROR
	VT_BOOL
	VT_VARIANT
	VT_UNKNOWN
	VT_DECIMAL
	VT_I1 = 16
	VT_UI1
	VT_UI2
	VT_UI4
	VT_I8
	VT_UI8
	VT_INT
	VT_UINT
	VT_VOID
	VT_HRESULT
	VT_PTR
	VT_SAFEARRAY
	VT_CARRAY
	VT_USERDEFINED
	VT_LPSTR
	VT_LPWSTR
	VT_RECORD = 36
	VT_INT_PTR = 37
	VT_UINT_PTR = 38
	VT_FILETIME = 64
	VT_BLOB
	VT_STREAM
	VT_STORAGE
	VT_STREAMED_OBJECT
	VT_STORED_OBJECT
	VT_BLOB_OBJECT
	VT_CF
	VT_CLSID
	VT_BSTR_BLOB = &hfff
	VT_VECTOR = &h1000
	VT_ARRAY = &h2000
	VT_BYREF = &h4000
	VT_RESERVED = &h8000
	VT_ILLEGAL = &hffff
	VT_ILLEGALMASKED = &hfff
	VT_TYPEMASK = &hfff
end enum

type BYTE_SIZEDARR
	clSize as uinteger
	pData as byte ptr
end type

type SHORT_SIZEDARR
	clSize as uinteger
	pData as ushort ptr
end type

type WORD_SIZEDARR as SHORT_SIZEDARR

type LONG_SIZEDARR
	clSize as uinteger
	pData as uinteger ptr
end type

type DWORD_SIZEDARR as LONG_SIZEDARR

type HYPER_SIZEDARR
	clSize as uinteger
	pData as longint ptr
end type

type DECIMAL
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

type HMETAFILEPICT as any ptr

#endif
