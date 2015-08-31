'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "_mingw_unicode.bi"

extern "Windows"

#define _INC_DDEMLH

type HCONVLIST__
	unused as long
end type

type HCONVLIST as HCONVLIST__ ptr

type HCONV__
	unused as long
end type

type HCONV as HCONV__ ptr

type HSZ__
	unused as long
end type

type HSZ as HSZ__ ptr

type HDDEDATA__
	unused as long
end type

type HDDEDATA as HDDEDATA__ ptr
#define EXPENTRY CALLBACK

type tagHSZPAIR
	hszSvc as HSZ
	hszTopic as HSZ
end type

type HSZPAIR as tagHSZPAIR
type PHSZPAIR as tagHSZPAIR ptr

type tagCONVCONTEXT
	cb as UINT
	wFlags as UINT
	wCountryID as UINT
	iCodePage as long
	dwLangID as DWORD
	dwSecurity as DWORD
	qos as SECURITY_QUALITY_OF_SERVICE
end type

type CONVCONTEXT as tagCONVCONTEXT
type PCONVCONTEXT as tagCONVCONTEXT ptr

type tagCONVINFO
	cb as DWORD
	hUser as DWORD_PTR
	hConvPartner as HCONV
	hszSvcPartner as HSZ
	hszServiceReq as HSZ
	hszTopic as HSZ
	hszItem as HSZ
	wFmt as UINT
	wType as UINT
	wStatus as UINT
	wConvst as UINT
	wLastError as UINT
	hConvList as HCONVLIST
	ConvCtxt as CONVCONTEXT
	hwnd as HWND
	hwndPartner as HWND
end type

type CONVINFO as tagCONVINFO
type PCONVINFO as tagCONVINFO ptr
const XST_NULL = 0
const XST_INCOMPLETE = 1
const XST_CONNECTED = 2
const XST_INIT1 = 3
const XST_INIT2 = 4
const XST_REQSENT = 5
const XST_DATARCVD = 6
const XST_POKESENT = 7
const XST_POKEACKRCVD = 8
const XST_EXECSENT = 9
const XST_EXECACKRCVD = 10
const XST_ADVSENT = 11
const XST_UNADVSENT = 12
const XST_ADVACKRCVD = 13
const XST_UNADVACKRCVD = 14
const XST_ADVDATASENT = 15
const XST_ADVDATAACKRCVD = 16
const CADV_LATEACK = &hFFFF
const ST_CONNECTED = &h0001
const ST_ADVISE = &h0002
const ST_ISLOCAL = &h0004
const ST_BLOCKED = &h0008
const ST_CLIENT = &h0010
const ST_TERMINATED = &h0020
const ST_INLIST = &h0040
const ST_BLOCKNEXT = &h0080
const ST_ISSELF = &h0100
const DDE_FACK = &h8000
const DDE_FBUSY = &h4000
const DDE_FDEFERUPD = &h4000
const DDE_FACKREQ = &h8000
const DDE_FRELEASE = &h2000
const DDE_FREQUESTED = &h1000
const DDE_FAPPSTATUS = &h00ff
const DDE_FNOTPROCESSED = &h0000
const DDE_FACKRESERVED = not ((DDE_FACK or DDE_FBUSY) or DDE_FAPPSTATUS)
const DDE_FADVRESERVED = not (DDE_FACKREQ or DDE_FDEFERUPD)
const DDE_FDATRESERVED = not ((DDE_FACKREQ or DDE_FRELEASE) or DDE_FREQUESTED)
const DDE_FPOKRESERVED = not DDE_FRELEASE
const MSGF_DDEMGR = &h8001
const CP_WINANSI = 1004
const CP_WINUNICODE = 1200
const XTYPF_NOBLOCK = &h0002
const XTYPF_NODATA = &h0004
const XTYPF_ACKREQ = &h0008
const XCLASS_MASK = &hFC00
const XCLASS_BOOL = &h1000
const XCLASS_DATA = &h2000
const XCLASS_FLAGS = &h4000
const XCLASS_NOTIFICATION = &h8000
const XTYP_ERROR = (&h0000 or XCLASS_NOTIFICATION) or XTYPF_NOBLOCK
const XTYP_ADVDATA = &h0010 or XCLASS_FLAGS
const XTYP_ADVREQ = (&h0020 or XCLASS_DATA) or XTYPF_NOBLOCK
const XTYP_ADVSTART = &h0030 or XCLASS_BOOL
const XTYP_ADVSTOP = &h0040 or XCLASS_NOTIFICATION
const XTYP_EXECUTE = &h0050 or XCLASS_FLAGS
const XTYP_CONNECT = (&h0060 or XCLASS_BOOL) or XTYPF_NOBLOCK
const XTYP_CONNECT_CONFIRM = (&h0070 or XCLASS_NOTIFICATION) or XTYPF_NOBLOCK
const XTYP_XACT_COMPLETE = &h0080 or XCLASS_NOTIFICATION
const XTYP_POKE = &h0090 or XCLASS_FLAGS
const XTYP_REGISTER = (&h00A0 or XCLASS_NOTIFICATION) or XTYPF_NOBLOCK
const XTYP_REQUEST = &h00B0 or XCLASS_DATA
const XTYP_DISCONNECT = (&h00C0 or XCLASS_NOTIFICATION) or XTYPF_NOBLOCK
const XTYP_UNREGISTER = (&h00D0 or XCLASS_NOTIFICATION) or XTYPF_NOBLOCK
const XTYP_WILDCONNECT = (&h00E0 or XCLASS_DATA) or XTYPF_NOBLOCK
const XTYP_MASK = &h00F0
const XTYP_SHIFT = 4
const TIMEOUT_ASYNC = &hFFFFFFFF
const QID_SYNC = &hFFFFFFFF

#ifdef UNICODE
	const CP_WINNEUTRAL = CP_WINUNICODE
#else
	const CP_WINNEUTRAL = CP_WINANSI
#endif

#define SZDDESYS_TOPIC __MINGW_STRING_AW("System")
#define SZDDESYS_ITEM_TOPICS __MINGW_STRING_AW("Topics")
#define SZDDESYS_ITEM_SYSITEMS __MINGW_STRING_AW("SysItems")
#define SZDDESYS_ITEM_RTNMSG __MINGW_STRING_AW("ReturnMessage")
#define SZDDESYS_ITEM_STATUS __MINGW_STRING_AW("Status")
#define SZDDESYS_ITEM_FORMATS __MINGW_STRING_AW("Formats")
#define SZDDESYS_ITEM_HELP __MINGW_STRING_AW("Help")
#define SZDDE_ITEM_ITEMLIST __MINGW_STRING_AW("TopicItemList")
type PFNCALLBACK as function(byval wType as UINT, byval wFmt as UINT, byval hConv as HCONV, byval hsz1 as HSZ, byval hsz2 as HSZ, byval hData as HDDEDATA, byval dwData1 as ULONG_PTR, byval dwData2 as ULONG_PTR) as HDDEDATA
const CBR_BLOCK = cast(HDDEDATA, -1)
declare function DdeInitializeA(byval pidInst as LPDWORD, byval pfnCallback as PFNCALLBACK, byval afCmd as DWORD, byval ulRes as DWORD) as UINT

#ifndef UNICODE
	declare function DdeInitialize alias "DdeInitializeA"(byval pidInst as LPDWORD, byval pfnCallback as PFNCALLBACK, byval afCmd as DWORD, byval ulRes as DWORD) as UINT
#endif

declare function DdeInitializeW(byval pidInst as LPDWORD, byval pfnCallback as PFNCALLBACK, byval afCmd as DWORD, byval ulRes as DWORD) as UINT

#ifdef UNICODE
	declare function DdeInitialize alias "DdeInitializeW"(byval pidInst as LPDWORD, byval pfnCallback as PFNCALLBACK, byval afCmd as DWORD, byval ulRes as DWORD) as UINT
#endif

const CBF_FAIL_SELFCONNECTIONS = &h00001000
const CBF_FAIL_CONNECTIONS = &h00002000
const CBF_FAIL_ADVISES = &h00004000
const CBF_FAIL_EXECUTES = &h00008000
const CBF_FAIL_POKES = &h00010000
const CBF_FAIL_REQUESTS = &h00020000
const CBF_FAIL_ALLSVRXACTIONS = &h0003f000
const CBF_SKIP_CONNECT_CONFIRMS = &h00040000
const CBF_SKIP_REGISTRATIONS = &h00080000
const CBF_SKIP_UNREGISTRATIONS = &h00100000
const CBF_SKIP_DISCONNECTS = &h00200000
const CBF_SKIP_ALLNOTIFICATIONS = &h003c0000
const APPCMD_CLIENTONLY = &h00000010
const APPCMD_FILTERINITS = &h00000020
const APPCMD_MASK = &h00000FF0
const APPCLASS_STANDARD = &h00000000
const APPCLASS_MASK = &h0000000F

declare function DdeUninitialize(byval idInst as DWORD) as WINBOOL
declare function DdeConnectList(byval idInst as DWORD, byval hszService as HSZ, byval hszTopic as HSZ, byval hConvList as HCONVLIST, byval pCC as PCONVCONTEXT) as HCONVLIST
declare function DdeQueryNextServer(byval hConvList as HCONVLIST, byval hConvPrev as HCONV) as HCONV
declare function DdeDisconnectList(byval hConvList as HCONVLIST) as WINBOOL
declare function DdeConnect(byval idInst as DWORD, byval hszService as HSZ, byval hszTopic as HSZ, byval pCC as PCONVCONTEXT) as HCONV
declare function DdeDisconnect(byval hConv as HCONV) as WINBOOL
declare function DdeReconnect(byval hConv as HCONV) as HCONV
declare function DdeQueryConvInfo(byval hConv as HCONV, byval idTransaction as DWORD, byval pConvInfo as PCONVINFO) as UINT
declare function DdeSetUserHandle(byval hConv as HCONV, byval id as DWORD, byval hUser as DWORD_PTR) as WINBOOL
declare function DdeAbandonTransaction(byval idInst as DWORD, byval hConv as HCONV, byval idTransaction as DWORD) as WINBOOL
declare function DdePostAdvise(byval idInst as DWORD, byval hszTopic as HSZ, byval hszItem as HSZ) as WINBOOL
declare function DdeEnableCallback(byval idInst as DWORD, byval hConv as HCONV, byval wCmd as UINT) as WINBOOL
declare function DdeImpersonateClient(byval hConv as HCONV) as WINBOOL

const EC_ENABLEALL = 0
const EC_ENABLEONE = ST_BLOCKNEXT
const EC_DISABLE = ST_BLOCKED
const EC_QUERYWAITING = 2
const DNS_REGISTER = &h0001
const DNS_UNREGISTER = &h0002
const DNS_FILTERON = &h0004
const DNS_FILTEROFF = &h0008

declare function DdeNameService(byval idInst as DWORD, byval hsz1 as HSZ, byval hsz2 as HSZ, byval afCmd as UINT) as HDDEDATA
declare function DdeClientTransaction(byval pData as LPBYTE, byval cbData as DWORD, byval hConv as HCONV, byval hszItem as HSZ, byval wFmt as UINT, byval wType as UINT, byval dwTimeout as DWORD, byval pdwResult as LPDWORD) as HDDEDATA
declare function DdeCreateDataHandle(byval idInst as DWORD, byval pSrc as LPBYTE, byval cb as DWORD, byval cbOff as DWORD, byval hszItem as HSZ, byval wFmt as UINT, byval afCmd as UINT) as HDDEDATA
declare function DdeAddData(byval hData as HDDEDATA, byval pSrc as LPBYTE, byval cb as DWORD, byval cbOff as DWORD) as HDDEDATA
declare function DdeGetData(byval hData as HDDEDATA, byval pDst as LPBYTE, byval cbMax as DWORD, byval cbOff as DWORD) as DWORD
declare function DdeAccessData(byval hData as HDDEDATA, byval pcbDataSize as LPDWORD) as LPBYTE
declare function DdeUnaccessData(byval hData as HDDEDATA) as WINBOOL
declare function DdeFreeDataHandle(byval hData as HDDEDATA) as WINBOOL
const HDATA_APPOWNED = &h0001
declare function DdeGetLastError(byval idInst as DWORD) as UINT

const DMLERR_NO_ERROR = 0
const DMLERR_FIRST = &h4000
const DMLERR_ADVACKTIMEOUT = &h4000
const DMLERR_BUSY = &h4001
const DMLERR_DATAACKTIMEOUT = &h4002
const DMLERR_DLL_NOT_INITIALIZED = &h4003
const DMLERR_DLL_USAGE = &h4004
const DMLERR_EXECACKTIMEOUT = &h4005
const DMLERR_INVALIDPARAMETER = &h4006
const DMLERR_LOW_MEMORY = &h4007
const DMLERR_MEMORY_ERROR = &h4008
const DMLERR_NOTPROCESSED = &h4009
const DMLERR_NO_CONV_ESTABLISHED = &h400a
const DMLERR_POKEACKTIMEOUT = &h400b
const DMLERR_POSTMSG_FAILED = &h400c
const DMLERR_REENTRANCY = &h400d
const DMLERR_SERVER_DIED = &h400e
const DMLERR_SYS_ERROR = &h400f
const DMLERR_UNADVACKTIMEOUT = &h4010
const DMLERR_UNFOUND_QUEUE_ID = &h4011
const DMLERR_LAST = &h4011

declare function DdeCreateStringHandleA(byval idInst as DWORD, byval psz as LPCSTR, byval iCodePage as long) as HSZ
declare function DdeCreateStringHandleW(byval idInst as DWORD, byval psz as LPCWSTR, byval iCodePage as long) as HSZ
declare function DdeQueryStringA(byval idInst as DWORD, byval hsz as HSZ, byval psz as LPSTR, byval cchMax as DWORD, byval iCodePage as long) as DWORD
declare function DdeQueryStringW(byval idInst as DWORD, byval hsz as HSZ, byval psz as LPWSTR, byval cchMax as DWORD, byval iCodePage as long) as DWORD
declare function DdeFreeStringHandle(byval idInst as DWORD, byval hsz as HSZ) as WINBOOL
declare function DdeKeepStringHandle(byval idInst as DWORD, byval hsz as HSZ) as WINBOOL
declare function DdeCmpStringHandles(byval hsz1 as HSZ, byval hsz2 as HSZ) as long

#ifdef UNICODE
	declare function DdeCreateStringHandle alias "DdeCreateStringHandleW"(byval idInst as DWORD, byval psz as LPCWSTR, byval iCodePage as long) as HSZ
	declare function DdeQueryString alias "DdeQueryStringW"(byval idInst as DWORD, byval hsz as HSZ, byval psz as LPWSTR, byval cchMax as DWORD, byval iCodePage as long) as DWORD
#else
	declare function DdeCreateStringHandle alias "DdeCreateStringHandleA"(byval idInst as DWORD, byval psz as LPCSTR, byval iCodePage as long) as HSZ
	declare function DdeQueryString alias "DdeQueryStringA"(byval idInst as DWORD, byval hsz as HSZ, byval psz as LPSTR, byval cchMax as DWORD, byval iCodePage as long) as DWORD
#endif

type tagDDEML_MSG_HOOK_DATA
	uiLo as UINT_PTR
	uiHi as UINT_PTR
	cbData as DWORD
	Data(0 to 7) as DWORD
end type

type DDEML_MSG_HOOK_DATA as tagDDEML_MSG_HOOK_DATA
type PDDEML_MSG_HOOK_DATA as tagDDEML_MSG_HOOK_DATA ptr

type tagMONMSGSTRUCT
	cb as UINT
	hwndTo as HWND
	dwTime as DWORD
	hTask as HANDLE
	wMsg as UINT
	wParam as WPARAM
	lParam as LPARAM
	dmhd as DDEML_MSG_HOOK_DATA
end type

type MONMSGSTRUCT as tagMONMSGSTRUCT
type PMONMSGSTRUCT as tagMONMSGSTRUCT ptr

type tagMONCBSTRUCT
	cb as UINT
	dwTime as DWORD
	hTask as HANDLE
	dwRet as DWORD
	wType as UINT
	wFmt as UINT
	hConv as HCONV
	hsz1 as HSZ
	hsz2 as HSZ
	hData as HDDEDATA
	dwData1 as ULONG_PTR
	dwData2 as ULONG_PTR
	cc as CONVCONTEXT
	cbData as DWORD
	Data(0 to 7) as DWORD
end type

type MONCBSTRUCT as tagMONCBSTRUCT
type PMONCBSTRUCT as tagMONCBSTRUCT ptr

type tagMONHSZSTRUCTA
	cb as UINT
	fsAction as WINBOOL
	dwTime as DWORD
	hsz as HSZ
	hTask as HANDLE
	str as zstring * 1
end type

type MONHSZSTRUCTA as tagMONHSZSTRUCTA
type PMONHSZSTRUCTA as tagMONHSZSTRUCTA ptr

type tagMONHSZSTRUCTW
	cb as UINT
	fsAction as WINBOOL
	dwTime as DWORD
	hsz as HSZ
	hTask as HANDLE
	str as wstring * 1
end type

type MONHSZSTRUCTW as tagMONHSZSTRUCTW
type PMONHSZSTRUCTW as tagMONHSZSTRUCTW ptr

#ifdef UNICODE
	type MONHSZSTRUCT as MONHSZSTRUCTW
	type PMONHSZSTRUCT as PMONHSZSTRUCTW
#else
	type MONHSZSTRUCT as MONHSZSTRUCTA
	type PMONHSZSTRUCT as PMONHSZSTRUCTA
#endif

const MH_CREATE = 1
const MH_KEEP = 2
const MH_DELETE = 3
const MH_CLEANUP = 4

type tagMONERRSTRUCT
	cb as UINT
	wLastError as UINT
	dwTime as DWORD
	hTask as HANDLE
end type

type MONERRSTRUCT as tagMONERRSTRUCT
type PMONERRSTRUCT as tagMONERRSTRUCT ptr

type tagMONLINKSTRUCT
	cb as UINT
	dwTime as DWORD
	hTask as HANDLE
	fEstablished as WINBOOL
	fNoData as WINBOOL
	hszSvc as HSZ
	hszTopic as HSZ
	hszItem as HSZ
	wFmt as UINT
	fServer as WINBOOL
	hConvServer as HCONV
	hConvClient as HCONV
end type

type MONLINKSTRUCT as tagMONLINKSTRUCT
type PMONLINKSTRUCT as tagMONLINKSTRUCT ptr

type tagMONCONVSTRUCT
	cb as UINT
	fConnect as WINBOOL
	dwTime as DWORD
	hTask as HANDLE
	hszSvc as HSZ
	hszTopic as HSZ
	hConvClient as HCONV
	hConvServer as HCONV
end type

type MONCONVSTRUCT as tagMONCONVSTRUCT
type PMONCONVSTRUCT as tagMONCONVSTRUCT ptr
const MAX_MONITORS = 4
const APPCLASS_MONITOR = &h00000001
const XTYP_MONITOR = (&h00F0 or XCLASS_NOTIFICATION) or XTYPF_NOBLOCK
const MF_HSZ_INFO = &h01000000
const MF_SENDMSGS = &h02000000
const MF_POSTMSGS = &h04000000
const MF_CALLBACKS = &h08000000
const MF_ERRORS = &h10000000
const MF_LINKS = &h20000000
const MF_CONV = &h40000000
const MF_MASK = &hFF000000

end extern
