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
#define CADV_LATEACK &hFFFF
#define ST_CONNECTED &h0001
#define ST_ADVISE &h0002
#define ST_ISLOCAL &h0004
#define ST_BLOCKED &h0008
#define ST_CLIENT &h0010
#define ST_TERMINATED &h0020
#define ST_INLIST &h0040
#define ST_BLOCKNEXT &h0080
#define ST_ISSELF &h0100
#define DDE_FACK &h8000
#define DDE_FBUSY &h4000
#define DDE_FDEFERUPD &h4000
#define DDE_FACKREQ &h8000
#define DDE_FRELEASE &h2000
#define DDE_FREQUESTED &h1000
#define DDE_FAPPSTATUS &h00ff
#define DDE_FNOTPROCESSED &h0000
#define DDE_FACKRESERVED (not ((DDE_FACK or DDE_FBUSY) or DDE_FAPPSTATUS))
#define DDE_FADVRESERVED (not (DDE_FACKREQ or DDE_FDEFERUPD))
#define DDE_FDATRESERVED (not ((DDE_FACKREQ or DDE_FRELEASE) or DDE_FREQUESTED))
#define DDE_FPOKRESERVED (not DDE_FRELEASE)
#define MSGF_DDEMGR &h8001
#define CP_WINANSI 1004
#define CP_WINUNICODE 1200
#define XTYPF_NOBLOCK &h0002
#define XTYPF_NODATA &h0004
#define XTYPF_ACKREQ &h0008
#define XCLASS_MASK &hFC00
#define XCLASS_BOOL &h1000
#define XCLASS_DATA &h2000
#define XCLASS_FLAGS &h4000
#define XCLASS_NOTIFICATION &h8000
#define XTYP_ERROR ((&h0000 or XCLASS_NOTIFICATION) or XTYPF_NOBLOCK)
#define XTYP_ADVDATA (&h0010 or XCLASS_FLAGS)
#define XTYP_ADVREQ ((&h0020 or XCLASS_DATA) or XTYPF_NOBLOCK)
#define XTYP_ADVSTART (&h0030 or XCLASS_BOOL)
#define XTYP_ADVSTOP (&h0040 or XCLASS_NOTIFICATION)
#define XTYP_EXECUTE (&h0050 or XCLASS_FLAGS)
#define XTYP_CONNECT ((&h0060 or XCLASS_BOOL) or XTYPF_NOBLOCK)
#define XTYP_CONNECT_CONFIRM ((&h0070 or XCLASS_NOTIFICATION) or XTYPF_NOBLOCK)
#define XTYP_XACT_COMPLETE (&h0080 or XCLASS_NOTIFICATION)
#define XTYP_POKE (&h0090 or XCLASS_FLAGS)
#define XTYP_REGISTER ((&h00A0 or XCLASS_NOTIFICATION) or XTYPF_NOBLOCK)
#define XTYP_REQUEST (&h00B0 or XCLASS_DATA)
#define XTYP_DISCONNECT ((&h00C0 or XCLASS_NOTIFICATION) or XTYPF_NOBLOCK)
#define XTYP_UNREGISTER ((&h00D0 or XCLASS_NOTIFICATION) or XTYPF_NOBLOCK)
#define XTYP_WILDCONNECT ((&h00E0 or XCLASS_DATA) or XTYPF_NOBLOCK)
#define XTYP_MASK &h00F0
#define XTYP_SHIFT 4
#define TIMEOUT_ASYNC &hFFFFFFFF
#define QID_SYNC &hFFFFFFFF

#ifdef UNICODE
	#define CP_WINNEUTRAL CP_WINUNICODE
#else
	#define CP_WINNEUTRAL CP_WINANSI
#endif

#define SZDDESYS_TOPIC __MINGW_STRING_AW("System")
#define SZDDESYS_ITEM_TOPICS __MINGW_STRING_AW("Topics")
#define SZDDESYS_ITEM_SYSITEMS __MINGW_STRING_AW("SysItems")
#define SZDDESYS_ITEM_RTNMSG __MINGW_STRING_AW("ReturnMessage")
#define SZDDESYS_ITEM_STATUS __MINGW_STRING_AW("Status")
#define SZDDESYS_ITEM_FORMATS __MINGW_STRING_AW("Formats")
#define SZDDESYS_ITEM_HELP __MINGW_STRING_AW("Help")
#define SZDDE_ITEM_ITEMLIST __MINGW_STRING_AW("TopicItemList")

#ifdef UNICODE
	#define DdeInitialize DdeInitializeW
#else
	#define DdeInitialize DdeInitializeA
#endif

type PFNCALLBACK as function(byval wType as UINT, byval wFmt as UINT, byval hConv as HCONV, byval hsz1 as HSZ, byval hsz2 as HSZ, byval hData as HDDEDATA, byval dwData1 as ULONG_PTR, byval dwData2 as ULONG_PTR) as HDDEDATA

#define CBR_BLOCK cast(HDDEDATA, -1)

declare function DdeInitializeA(byval pidInst as LPDWORD, byval pfnCallback as PFNCALLBACK, byval afCmd as DWORD, byval ulRes as DWORD) as UINT
declare function DdeInitializeW(byval pidInst as LPDWORD, byval pfnCallback as PFNCALLBACK, byval afCmd as DWORD, byval ulRes as DWORD) as UINT

#define CBF_FAIL_SELFCONNECTIONS &h00001000
#define CBF_FAIL_CONNECTIONS &h00002000
#define CBF_FAIL_ADVISES &h00004000
#define CBF_FAIL_EXECUTES &h00008000
#define CBF_FAIL_POKES &h00010000
#define CBF_FAIL_REQUESTS &h00020000
#define CBF_FAIL_ALLSVRXACTIONS &h0003f000
#define CBF_SKIP_CONNECT_CONFIRMS &h00040000
#define CBF_SKIP_REGISTRATIONS &h00080000
#define CBF_SKIP_UNREGISTRATIONS &h00100000
#define CBF_SKIP_DISCONNECTS &h00200000
#define CBF_SKIP_ALLNOTIFICATIONS &h003c0000
#define APPCMD_CLIENTONLY __MSABI_LONG(&h00000010)
#define APPCMD_FILTERINITS __MSABI_LONG(&h00000020)
#define APPCMD_MASK __MSABI_LONG(&h00000FF0)
#define APPCLASS_STANDARD __MSABI_LONG(&h00000000)
#define APPCLASS_MASK __MSABI_LONG(&h0000000F)

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

#define EC_ENABLEALL 0
#define EC_ENABLEONE ST_BLOCKNEXT
#define EC_DISABLE ST_BLOCKED
#define EC_QUERYWAITING 2
#define DNS_REGISTER &h0001
#define DNS_UNREGISTER &h0002
#define DNS_FILTERON &h0004
#define DNS_FILTEROFF &h0008

declare function DdeNameService(byval idInst as DWORD, byval hsz1 as HSZ, byval hsz2 as HSZ, byval afCmd as UINT) as HDDEDATA
declare function DdeClientTransaction(byval pData as LPBYTE, byval cbData as DWORD, byval hConv as HCONV, byval hszItem as HSZ, byval wFmt as UINT, byval wType as UINT, byval dwTimeout as DWORD, byval pdwResult as LPDWORD) as HDDEDATA
declare function DdeCreateDataHandle(byval idInst as DWORD, byval pSrc as LPBYTE, byval cb as DWORD, byval cbOff as DWORD, byval hszItem as HSZ, byval wFmt as UINT, byval afCmd as UINT) as HDDEDATA
declare function DdeAddData(byval hData as HDDEDATA, byval pSrc as LPBYTE, byval cb as DWORD, byval cbOff as DWORD) as HDDEDATA
declare function DdeGetData(byval hData as HDDEDATA, byval pDst as LPBYTE, byval cbMax as DWORD, byval cbOff as DWORD) as DWORD
declare function DdeAccessData(byval hData as HDDEDATA, byval pcbDataSize as LPDWORD) as LPBYTE
declare function DdeUnaccessData(byval hData as HDDEDATA) as WINBOOL
declare function DdeFreeDataHandle(byval hData as HDDEDATA) as WINBOOL

#define HDATA_APPOWNED &h0001

declare function DdeGetLastError(byval idInst as DWORD) as UINT

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
#define DMLERR_POKEACKTIMEOUT &h400b
#define DMLERR_POSTMSG_FAILED &h400c
#define DMLERR_REENTRANCY &h400d
#define DMLERR_SERVER_DIED &h400e
#define DMLERR_SYS_ERROR &h400f
#define DMLERR_UNADVACKTIMEOUT &h4010
#define DMLERR_UNFOUND_QUEUE_ID &h4011
#define DMLERR_LAST &h4011

declare function DdeCreateStringHandleA(byval idInst as DWORD, byval psz as LPCSTR, byval iCodePage as long) as HSZ
declare function DdeCreateStringHandleW(byval idInst as DWORD, byval psz as LPCWSTR, byval iCodePage as long) as HSZ
declare function DdeQueryStringA(byval idInst as DWORD, byval hsz as HSZ, byval psz as LPSTR, byval cchMax as DWORD, byval iCodePage as long) as DWORD
declare function DdeQueryStringW(byval idInst as DWORD, byval hsz as HSZ, byval psz as LPWSTR, byval cchMax as DWORD, byval iCodePage as long) as DWORD
declare function DdeFreeStringHandle(byval idInst as DWORD, byval hsz as HSZ) as WINBOOL
declare function DdeKeepStringHandle(byval idInst as DWORD, byval hsz as HSZ) as WINBOOL
declare function DdeCmpStringHandles(byval hsz1 as HSZ, byval hsz2 as HSZ) as long

#ifdef UNICODE
	#define DdeCreateStringHandle DdeCreateStringHandleW
	#define DdeQueryString DdeQueryStringW
#else
	#define DdeCreateStringHandle DdeCreateStringHandleA
	#define DdeQueryString DdeQueryStringA
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

#define MH_CREATE 1
#define MH_KEEP 2
#define MH_DELETE 3
#define MH_CLEANUP 4

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

#define MAX_MONITORS 4
#define APPCLASS_MONITOR __MSABI_LONG(&h00000001)
#define XTYP_MONITOR ((&h00F0 or XCLASS_NOTIFICATION) or XTYPF_NOBLOCK)
#define MF_HSZ_INFO &h01000000
#define MF_SENDMSGS &h02000000
#define MF_POSTMSGS &h04000000
#define MF_CALLBACKS &h08000000
#define MF_ERRORS &h10000000
#define MF_LINKS &h20000000
#define MF_CONV &h40000000
#define MF_MASK &hFF000000

end extern
