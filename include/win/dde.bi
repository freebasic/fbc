''
''
'' dde -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dde_bi__
#define __win_dde_bi__

#define WM_DDE_FIRST &h03E0
#define WM_DDE_INITIATE (&h03E0)
#define WM_DDE_TERMINATE (&h03E0+1)
#define WM_DDE_ADVISE (&h03E0+2)
#define WM_DDE_UNADVISE (&h03E0+3)
#define WM_DDE_ACK (&h03E0+4)
#define WM_DDE_DATA (&h03E0+5)
#define WM_DDE_REQUEST (&h03E0+6)
#define WM_DDE_POKE (&h03E0+7)
#define WM_DDE_EXECUTE (&h03E0+8)
#define WM_DDE_LAST (&h03E0+8)

type DDEACK
	bAppReturnCode:8 as ushort
	reserved:6 as ushort
	fBusy:1 as ushort
	fAck:1 as ushort
end type

type DDEADVISE
	reserved:14 as ushort
	fDeferUpd:1 as ushort
	fAckReq:1 as ushort
	cfFormat as short
end type

type DDEDATA
	unused:12 as ushort
	fResponse:1 as ushort
	fRelease:1 as ushort
	reserved:1 as ushort
	fAckReq:1 as ushort
	cfFormat as short
	Value(0 to 1-1) as UBYTE
end type

type DDEPOKE
	unused:13 as ushort
	fRelease:1 as ushort
	fReserved:2 as ushort
	cfFormat as short
	Value(0 to 1-1) as UBYTE
end type

type DDELN
	unused:13 as ushort
	fRelease:1 as ushort
	fDeferUpd:1 as ushort
	fAckReq:1 as ushort
	cfFormat as short
end type

type DDEUP
	unused:12 as ushort
	fAck:1 as ushort
	fRelease:1 as ushort
	fReserved:1 as ushort
	fAckReq:1 as ushort
	cfFormat as short
	rgb_(0 to 1-1) as UBYTE
end type

declare function DdeSetQualityOfService alias "DdeSetQualityOfService" (byval as HWND, byval as SECURITY_QUALITY_OF_SERVICE ptr, byval as PSECURITY_QUALITY_OF_SERVICE) as BOOL
declare function ImpersonateDdeClientWindow alias "ImpersonateDdeClientWindow" (byval as HWND, byval as HWND) as BOOL
declare function PackDDElParam alias "PackDDElParam" (byval as UINT, byval as UINT_PTR, byval as UINT_PTR) as LPARAM
declare function UnpackDDElParam alias "UnpackDDElParam" (byval as UINT, byval as LPARAM, byval as PUINT_PTR, byval as PUINT_PTR) as BOOL
declare function FreeDDElParam alias "FreeDDElParam" (byval as UINT, byval as LPARAM) as BOOL
declare function ReuseDDElParam alias "ReuseDDElParam" (byval as LPARAM, byval as UINT, byval as UINT, byval as UINT_PTR, byval as UINT_PTR) as LPARAM

#endif
