''
''
'' Xtransint -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xtransint_bi__
#define __Xtransint_bi__

#define XTRANSDEBUG 1

type _XtransConnInfo
	transptr as _Xtransport ptr
	index as integer
	priv as zstring ptr
	flags as integer
	fd as integer
	port as zstring ptr
	family as integer
	addr as zstring ptr
	addrlen as integer
	peeraddr as zstring ptr
	peeraddrlen as integer
end type

#define XTRANS_OPEN_COTS_CLIENT 1
#define XTRANS_OPEN_COTS_SERVER 2
#define XTRANS_OPEN_CLTS_CLIENT 3
#define XTRANS_OPEN_CLTS_SERVER 4

type _Xtransport
	TransName as zstring ptr
	flags as integer
	SetOption as function cdecl(byval as XtransConnInfo, byval as integer, byval as integer) as integer
	BytesReadable as function cdecl(byval as XtransConnInfo, byval as BytesReadable_t ptr) as integer
	Read as function cdecl(byval as XtransConnInfo, byval as zstring ptr, byval as integer) as integer
	Write as function cdecl(byval as XtransConnInfo, byval as zstring ptr, byval as integer) as integer
	Readv as function cdecl(byval as XtransConnInfo, byval as iovec ptr, byval as integer) as integer
	Writev as function cdecl(byval as XtransConnInfo, byval as iovec ptr, byval as integer) as integer
	Disconnect as function cdecl(byval as XtransConnInfo) as integer
	Close as function cdecl(byval as XtransConnInfo) as integer
	CloseForCloning as function cdecl(byval as XtransConnInfo) as integer
end type

type Xtransport as _Xtransport

type _Xtransport_table
	transport as Xtransport ptr
	transport_id as integer
end type

type Xtransport_table as _Xtransport_table

#define TRANS_ALIAS (1 shl 0)
#define TRANS_LOCAL (1 shl 1)
#define TRANS_DISABLED (1 shl 2)
#define TRANS_NOLISTEN (1 shl 3)
#define TRANS_NOUNLINK (1 shl 4)
#define TRANS_ABSTRACT (1 shl 5)
#define TRANS_NOXAUTH (1 shl 6)
#define TRANS_KEEPFLAGS ((1 shl 4) or (1 shl 5))

declare function is_numeric cdecl alias "is_numeric" (byval as zstring ptr) as integer

#endif
