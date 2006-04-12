''
''
'' ddeml -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_ddeml_bi__
#define __win_ddeml_bi__

#define CP_WINANSI 1004
#define CP_WINUNICODE 1200
#define XTYPF_NOBLOCK 2
#define XTYPF_NODATA 4
#define XTYPF_ACKREQ 8
#define XCLASS_MASK &hFC00
#define XCLASS_BOOL &h1000
#define XCLASS_DATA &h2000
#define XCLASS_FLAGS &h4000
#define XCLASS_NOTIFICATION &h8000
#define XST_NULL 0
#define XST_INCOMPLETE 1
#define XST_CONNECTED 2
#define XST_INIT1 3
#define XST_INIT2 4
#define XST_REQSENT 5
#define XST_DATARCVD 6
#define XST_POKESENT 7
#define XST_POKEACKRCVD 8
#define XST_EXECSENT 9
#define XST_EXECACKRCVD 10
#define XST_ADVSENT 11
#define XST_UNADVSENT 12
#define XST_ADVACKRCVD 13
#define XST_UNADVACKRCVD 14
#define XST_ADVDATASENT 15
#define XST_ADVDATAACKRCVD 16
#define XTYP_ERROR (&h8000 or 2)
#define XTYP_ADVDATA (16 or &h4000)
#define XTYP_ADVREQ (32 or &h2000 or 2)
#define XTYP_ADVSTART (&h30 or &h1000)
#define XTYP_ADVSTOP (&h0040 or &h8000)
#define XTYP_EXECUTE (&h0050 or &h4000)
#define XTYP_CONNECT (&h0060 or &h1000 or 2)
#define XTYP_CONNECT_CONFIRM (&h0070 or &h8000 or 2)
#define XTYP_XACT_COMPLETE (&h0080 or &h8000)
#define XTYP_POKE (&h0090 or &h4000)
#define XTYP_REGISTER (&h00A0 or &h8000 or 2)
#define XTYP_REQUEST (&h00B0 or &h2000)
#define XTYP_DISCONNECT (&h00C0 or &h8000 or 2)
#define XTYP_UNREGISTER (&h00D0 or &h8000 or 2)
#define XTYP_WILDCONNECT (&h00E0 or &h2000 or 2)
#define XTYP_MASK &hF0
#define XTYP_SHIFT 4
#define TIMEOUT_ASYNC &hFFFFFFFF
#define QID_SYNC &hFFFFFFFF
#define ST_CONNECTED 1
#define ST_ADVISE 2
#define ST_ISLOCAL 4
#define ST_BLOCKED 8
#define ST_CLIENT 16
#define ST_TERMINATED 32
#define ST_INLIST 64
#define ST_BLOCKNEXT 128
#define ST_ISSELF 256
#define CADV_LATEACK &hFFFF
#define DMLERR_NO_ERROR 0
#define DMLERR_FIRST &h4000
#define DMLERR_ADVACKTIMEOUT &h4000
#define DMLERR_BUSY &h4001
#define DMLERR_DATAACKTIMEOUT &h4002
#define DMLERR_DLL_NOT_INITIALIZED &h4003
#define DMLERR_DLL_USAGE &h4004
#define DMLERR_EXECACKTIMEOUT &h4005
#define DMLERR_INVALIDPARAMETER &h4006
#define DMLERR_LOW_MEMORY &h4007
#define DMLERR_MEMORY_ERROR &h4008
#define DMLERR_NOTPROCESSED &h4009
#define DMLERR_NO_CONV_ESTABLISHED &h400a
#define DMLERR_POKEACKTIMEOUT &h40&b
#define DMLERR_POSTMSG_FAILED &h400c
#define DMLERR_REENTRANCY &h400d
#define DMLERR_SERVER_DIED &h400e
#define DMLERR_SYS_ERROR &h400f
#define DMLERR_UNADVACKTIMEOUT &h4010
#define DMLERR_UNFOUND_QUEUE_ID &h4011
#define DMLERR_LAST &h4011
#define DDE_FACK &h8000
#define DDE_FBUSY &h4000
#define DDE_FDEFERUPD &h4000
#define DDE_FACKREQ &h8000
#define DDE_FRELEASE &h2000
#define DDE_FREQUESTED &h1000
#define DDE_FAPPSTATUS &h00ff
#define DDE_FNOTPROCESSED 0
#define DDE_FACKRESERVED ( not (&h8000 or &h4000 or &h00ff))
#define DDE_FADVRESERVED ( not (&h8000 or &h4000))
#define DDE_FDATRESERVED ( not (&h8000 or &h2000 or &h1000))
#define DDE_FPOKRESERVED ( not &h2000)
#define MSGF_DDEMGR &h8001
#define CBR_BLOCK cptr(HDDEDATA, &hffffffff)
#define CBF_FAIL_SELFCONNECTIONS &h1000
#define CBF_FAIL_CONNECTIONS &h2000
#define CBF_FAIL_ADVISES &h4000
#define CBF_FAIL_EXECUTES &h8000
#define CBF_FAIL_POKES &h10000
#define CBF_FAIL_REQUESTS &h20000
#define CBF_FAIL_ALLSVRXACTIONS &h3f000
#define CBF_SKIP_CONNECT_CONFIRMS &h40000
#define CBF_SKIP_REGISTRATIONS &h80000
#define CBF_SKIP_UNREGISTRATIONS &h100000
#define CBF_SKIP_DISCONNECTS &h200000
#define CBF_SKIP_ALLNOTIFICATIONS &h3c0000
#define APPCMD_CLIENTONLY &h10L
#define APPCMD_FILTERINITS &h20L
#define APPCMD_MASK &hFF0L
#define APPCLASS_STANDARD 0
#define APPCLASS_MASK &hFL
#define EC_ENABLEALL 0
#define EC_ENABLEONE 128
#define EC_DISABLE 8
#define EC_QUERYWAITING 2
#define DNS_REGISTER 1
#define DNS_UNREGISTER 2
#define DNS_FILTERON 4
#define DNS_FILTEROFF 8
#define HDATA_APPOWNED 1
#define MAX_MONITORS 4
#define APPCLASS_MONITOR 1L
#define XTYP_MONITOR (&h8000 or 2 or &hF0)
#define MF_HSZ_INFO &h1000000
#define MF_SENDMSGS &h2000000
#define MF_POSTMSGS &h4000000
#define MF_CALLBACKS &h8000000
#define MF_ERRORS &h10000000
#define MF_LINKS &h20000000
#define MF_CONV &h40000000
#define MF_MASK &hFF000000
#define MH_CREATE 1
#define MH_KEEP 2
#define MH_DELETE 3
#define MH_CLEANUP 4

type HCONVLIST__
	i as integer
end type

type HCONVLIST as HCONVLIST__ ptr

type HCONV__
	i as integer
end type

type HCONV as HCONV__ ptr

type HSZ__
	i as integer
end type

type HSZ as HSZ__ ptr

type HDDEDATA__
	i as integer
end type

type HDDEDATA as HDDEDATA__ ptr
type PFNCALLBACK as function (byval as UINT, byval as UINT, byval as HCONV, byval as HSZ, byval as HSZ, byval as HDDEDATA, byval as DWORD, byval as DWORD) as HDDEDATA

type HSZPAIR
	hszSvc as HSZ
	hszTopic as HSZ
end type

type PHSZPAIR as HSZPAIR ptr

type CONVCONTEXT
	cb as UINT
	wFlags as UINT
	wCountryID as UINT
	iCodePage as integer
	dwLangID as DWORD
	dwSecurity as DWORD
	qos as SECURITY_QUALITY_OF_SERVICE
end type

type PCONVCONTEXT as CONVCONTEXT ptr

type CONVINFO
	cb as DWORD
	hUser as DWORD
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

type PCONVINFO as CONVINFO ptr

type DDEML_MSG_HOOK_DATA
	uiLo as UINT
	uiHi as UINT
	cbData as DWORD
	Data(0 to 8-1) as DWORD
end type

type MONHSZSTRUCT
	cb as UINT
	fsAction as BOOL
	dwTime as DWORD
	hsz as HSZ
	hTask as HANDLE
	str as zstring * 1
end type

type PMONHSZSTRUCT as MONHSZSTRUCT ptr

type MONLINKSTRUCT
	cb as UINT
	dwTime as DWORD
	hTask as HANDLE
	fEstablished as BOOL
	fNoData as BOOL
	hszSvc as HSZ
	hszTopic as HSZ
	hszItem as HSZ
	wFmt as UINT
	fServer as BOOL
	hConvServer as HCONV
	hConvClient as HCONV
end type

type PMONLINKSTRUCT as MONLINKSTRUCT ptr

type MONCONVSTRUCT
	cb as UINT
	fConnect as BOOL
	dwTime as DWORD
	hTask as HANDLE
	hszSvc as HSZ
	hszTopic as HSZ
	hConvClient as HCONV
	hConvServer as HCONV
end type

type PMONCONVSTRUCT as MONCONVSTRUCT ptr

type MONCBSTRUCT
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
	Data(0 to 8-1) as DWORD
end type

type PMONCBSTRUCT as MONCBSTRUCT ptr

type MONERRSTRUCT
	cb as UINT
	wLastError as UINT
	dwTime as DWORD
	hTask as HANDLE
end type

type PMONERRSTRUCT as MONERRSTRUCT ptr

type MONMSGSTRUCT
	cb as UINT
	hwndTo as HWND
	dwTime as DWORD
	hTask as HANDLE
	wMsg as UINT
	wParam as WPARAM
	lParam as LPARAM
	dmhd as DDEML_MSG_HOOK_DATA
end type

type PMONMSGSTRUCT as MONMSGSTRUCT ptr

declare function DdeAbandonTransaction alias "DdeAbandonTransaction" (byval as DWORD, byval as HCONV, byval as DWORD) as BOOL
declare function DdeAccessData alias "DdeAccessData" (byval as HDDEDATA, byval as PDWORD) as PBYTE
declare function DdeAddData alias "DdeAddData" (byval as HDDEDATA, byval as PBYTE, byval as DWORD, byval as DWORD) as HDDEDATA
declare function DdeClientTransaction alias "DdeClientTransaction" (byval as PBYTE, byval as DWORD, byval as HCONV, byval as HSZ, byval as UINT, byval as UINT, byval as DWORD, byval as PDWORD) as HDDEDATA
declare function DdeCmpStringHandles alias "DdeCmpStringHandles" (byval as HSZ, byval as HSZ) as integer
declare function DdeConnect alias "DdeConnect" (byval as DWORD, byval as HSZ, byval as HSZ, byval as PCONVCONTEXT) as HCONV
declare function DdeConnectList alias "DdeConnectList" (byval as DWORD, byval as HSZ, byval as HSZ, byval as HCONVLIST, byval as PCONVCONTEXT) as HCONVLIST
declare function DdeCreateDataHandle alias "DdeCreateDataHandle" (byval as DWORD, byval as PBYTE, byval as DWORD, byval as DWORD, byval as HSZ, byval as UINT, byval as UINT) as HDDEDATA
declare function DdeDisconnect alias "DdeDisconnect" (byval as HCONV) as BOOL
declare function DdeDisconnectList alias "DdeDisconnectList" (byval as HCONVLIST) as BOOL
declare function DdeEnableCallback alias "DdeEnableCallback" (byval as DWORD, byval as HCONV, byval as UINT) as BOOL
declare function DdeFreeDataHandle alias "DdeFreeDataHandle" (byval as HDDEDATA) as BOOL
declare function DdeFreeStringHandle alias "DdeFreeStringHandle" (byval as DWORD, byval as HSZ) as BOOL
declare function DdeGetData alias "DdeGetData" (byval as HDDEDATA, byval as PBYTE, byval as DWORD, byval as DWORD) as DWORD
declare function DdeGetLastError alias "DdeGetLastError" (byval as DWORD) as UINT
declare function DdeImpersonateClient alias "DdeImpersonateClient" (byval as HCONV) as BOOL
declare function DdeKeepStringHandle alias "DdeKeepStringHandle" (byval as DWORD, byval as HSZ) as BOOL
declare function DdeNameService alias "DdeNameService" (byval as DWORD, byval as HSZ, byval as HSZ, byval as UINT) as HDDEDATA
declare function DdePostAdvise alias "DdePostAdvise" (byval as DWORD, byval as HSZ, byval as HSZ) as BOOL
declare function DdeQueryConvInfo alias "DdeQueryConvInfo" (byval as HCONV, byval as DWORD, byval as PCONVINFO) as UINT
declare function DdeQueryNextServer alias "DdeQueryNextServer" (byval as HCONVLIST, byval as HCONV) as HCONV
declare function DdeReconnect alias "DdeReconnect" (byval as HCONV) as HCONV
declare function DdeSetUserHandle alias "DdeSetUserHandle" (byval as HCONV, byval as DWORD, byval as DWORD) as BOOL
declare function DdeUnaccessData alias "DdeUnaccessData" (byval as HDDEDATA) as BOOL
declare function DdeUninitialize alias "DdeUninitialize" (byval as DWORD) as BOOL

#ifdef UNICODE
declare function DdeCreateStringHandle alias "DdeCreateStringHandleW" (byval as DWORD, byval as LPWSTR, byval as integer) as HSZ
declare function DdeInitialize alias "DdeInitializeW" (byval as PDWORD, byval as PFNCALLBACK, byval as DWORD, byval as DWORD) as UINT
declare function DdeQueryString alias "DdeQueryStringW" (byval as DWORD, byval as HSZ, byval as LPWSTR, byval as DWORD, byval as integer) as DWORD

#else ''UNICODE
declare function DdeCreateStringHandle alias "DdeCreateStringHandleA" (byval as DWORD, byval as LPSTR, byval as integer) as HSZ
declare function DdeInitialize alias "DdeInitializeA" (byval as PDWORD, byval as PFNCALLBACK, byval as DWORD, byval as DWORD) as UINT
declare function DdeQueryString alias "DdeQueryStringA" (byval as DWORD, byval as HSZ, byval as LPSTR, byval as DWORD, byval as integer) as DWORD

#endif ''UNICODE

#define SZDDESYS_TOPIC "System"
#define SZDDESYS_ITEM_TOPICS "Topics"
#define SZDDESYS_ITEM_SYSITEMS "SysItems"
#define SZDDESYS_ITEM_RTNMSG "ReturnMessage"
#define SZDDESYS_ITEM_STATUS "Status"
#define SZDDESYS_ITEM_FORMATS "Formats"
#define SZDDESYS_ITEM_HELP "Help"
#define SZDDE_ITEM_ITEMLIST "TopicItemList"

#endif
