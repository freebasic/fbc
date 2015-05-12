''
''
'' ws2spi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_ws2spi_bi__
#define __win_ws2spi_bi__

#ifndef UNICODE
#error UNICODE only
#endif

#include once "win/winsock2.bi"

#define WSPDESCRIPTION_LEN 255

type WSPDATA
	wVersion as WORD
	wHighVersion as WORD
	szDescription as wstring * 255+1
end type

type LPWSPDATA as WSPDATA ptr

type WSATHREADID
	ThreadHandle as HANDLE
	Reserved as DWORD
end type

type LPWSATHREADID as WSATHREADID ptr
type LPBLOCKINGCALLBACK as function (byval as DWORD) as BOOL
type LPWSAUSERAPC as sub (byval as DWORD)

type LPWSPACCEPT as function (byval as SOCKET, byval as LPSOCKADDR, byval as LPINT, byval as LPCONDITIONPROC, byval as DWORD, byval as LPINT) as SOCKET
type LPWSPADDRESSTOSTRING as function (byval as LPSOCKADDR, byval as DWORD, byval as LPWSAPROTOCOL_INFOW, byval as LPWSTR, byval as LPDWORD, byval as LPINT) as INT_
type LPWSPASYNCSELECT as function (byval as SOCKET, byval as HWND, byval as UINT, byval as LONG, byval as LPINT) as INT_
type LPWSPBIND as function (byval as SOCKET, byval as LPSOCKADDR, byval as INT_, byval as LPINT) as INT_
type LPWSPCANCELBLOCKINGCALL as function (byval as LPINT) as INT_
type LPWSPCLEANUP as function (byval as LPINT) as INT_
type LPWSPCLOSESOCKET as function (byval as SOCKET, byval as LPINT) as INT_
type LPWSPCONNECT as function (byval as SOCKET, byval as LPSOCKADDR, byval as INT_, byval as LPWSABUF, byval as LPWSABUF, byval as LPQOS, byval as LPQOS, byval as LPINT) as INT_
type LPWSPDUPLICATESOCKET as function (byval as SOCKET, byval as DWORD, byval as LPWSAPROTOCOL_INFOW, byval as LPINT) as INT_
type LPWSPENUMNETWORKEVENTS as function (byval as SOCKET, byval as HANDLE, byval as LPWSANETWORKEVENTS, byval as LPINT) as INT_
type LPWSPEVENTSELECT as function (byval as SOCKET, byval as HANDLE, byval as LONG, byval as LPINT) as INT_
type LPWSPGETOVERLAPPEDRESULT as function (byval as SOCKET, byval as LPWSAOVERLAPPED, byval as LPDWORD, byval as BOOL, byval as LPDWORD, byval as LPINT) as BOOL
type LPWSPGETPEERNAME as function (byval as SOCKET, byval as LPSOCKADDR, byval as LPINT, byval as LPINT) as INT_
type LPWSPGETQOSBYNAME as function (byval as SOCKET, byval as LPWSABUF, byval as LPQOS, byval as LPINT) as BOOL
type LPWSPGETSOCKNAME as function (byval as SOCKET, byval as LPSOCKADDR, byval as LPINT, byval as LPINT) as INT_
type LPWSPGETSOCKOPT as function (byval as SOCKET, byval as INT_, byval as INT_, byval as CHAR ptr, byval as LPINT, byval as LPINT) as INT_
type LPWSPIOCTL as function (byval as SOCKET, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPDWORD, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE, byval as LPWSATHREADID, byval as LPINT) as INT_
type LPWSPJOINLEAF as function (byval as SOCKET, byval as LPSOCKADDR, byval as INT_, byval as LPWSABUF, byval as LPWSABUF, byval as LPQOS, byval as LPQOS, byval as DWORD, byval as LPINT) as SOCKET
type LPWSPLISTEN as function (byval as SOCKET, byval as INT_, byval as LPINT) as INT_
type LPWSPRECV as function (byval as SOCKET, byval as LPWSABUF, byval as DWORD, byval as LPDWORD, byval as LPDWORD, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE, byval as LPWSATHREADID, byval as LPINT) as INT_
type LPWSPRECVDISCONNECT as function (byval as SOCKET, byval as LPWSABUF, byval as LPINT) as INT_
type LPWSPRECVFROM as function (byval as SOCKET, byval as LPWSABUF, byval as DWORD, byval as LPDWORD, byval as LPDWORD, byval as LPSOCKADDR, byval as LPINT, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE, byval as LPWSATHREADID, byval as LPINT) as INT_
type LPWSPSELECT as function (byval as INT_, byval as LPFD_SET, byval as LPFD_SET, byval as LPFD_SET, byval as LPTIMEVAL, byval as LPINT) as INT_
type LPWSPSEND as function (byval as SOCKET, byval as LPWSABUF, byval as DWORD, byval as LPDWORD, byval as DWORD, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE, byval as LPWSATHREADID, byval as LPINT) as INT_
type LPWSPSENDDISCONNECT as function (byval as SOCKET, byval as LPWSABUF, byval as LPINT) as INT_
type LPWSPSENDTO as function (byval as SOCKET, byval as LPWSABUF, byval as DWORD, byval as LPDWORD, byval as DWORD, byval as LPSOCKADDR, byval as INT_, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE, byval as LPWSATHREADID, byval as LPINT) as INT_
type LPWSPSETSOCKOPT as function (byval as SOCKET, byval as INT_, byval as INT_, byval as CHAR ptr, byval as INT_, byval as LPINT) as INT_
type LPWSPSHUTDOWN as function (byval as SOCKET, byval as INT_, byval as LPINT) as INT_
type LPWSPSOCKET as function (byval as INT_, byval as INT_, byval as INT_, byval as LPWSAPROTOCOL_INFOW, byval as GROUP, byval as DWORD, byval as LPINT) as SOCKET
type LPWSPSTRINGTOADDRESS as function (byval as LPWSTR, byval as INT_, byval as LPWSAPROTOCOL_INFOW, byval as LPSOCKADDR, byval as LPINT, byval as LPINT) as INT_

type WSPPROC_TABLE
	lpWSPAccept as LPWSPACCEPT
	lpWSPAddressToString as LPWSPADDRESSTOSTRING
	lpWSPAsyncSelect as LPWSPASYNCSELECT
	lpWSPBind as LPWSPBIND
	lpWSPCancelBlockingCall as LPWSPCANCELBLOCKINGCALL
	lpWSPCleanup as LPWSPCLEANUP
	lpWSPCloseSocket as LPWSPCLOSESOCKET
	lpWSPConnect as LPWSPCONNECT
	lpWSPDuplicateSocket as LPWSPDUPLICATESOCKET
	lpWSPEnumNetworkEvents as LPWSPENUMNETWORKEVENTS
	lpWSPEventSelect as LPWSPEVENTSELECT
	lpWSPGetOverlappedResult as LPWSPGETOVERLAPPEDRESULT
	lpWSPGetPeerName as LPWSPGETPEERNAME
	lpWSPGetSockName as LPWSPGETSOCKNAME
	lpWSPGetSockOpt as LPWSPGETSOCKOPT
	lpWSPGetQOSByName as LPWSPGETQOSBYNAME
	lpWSPIoctl as LPWSPIOCTL
	lpWSPJoinLeaf as LPWSPJOINLEAF
	lpWSPListen as LPWSPLISTEN
	lpWSPRecv as LPWSPRECV
	lpWSPRecvDisconnect as LPWSPRECVDISCONNECT
	lpWSPRecvFrom as LPWSPRECVFROM
	lpWSPSelect as LPWSPSELECT
	lpWSPSend as LPWSPSEND
	lpWSPSendDisconnect as LPWSPSENDDISCONNECT
	lpWSPSendTo as LPWSPSENDTO
	lpWSPSetSockOpt as LPWSPSETSOCKOPT
	lpWSPShutdown as LPWSPSHUTDOWN
	lpWSPSocket as LPWSPSOCKET
	lpWSPStringToAddress as LPWSPSTRINGTOADDRESS
end type

type LPWSPPROC_TABLE as WSPPROC_TABLE ptr

type LPWPUCLOSEEVENT as function (byval as HANDLE, byval as LPINT) as BOOL
type LPWPUCLOSESOCKETHANDLE as function (byval as SOCKET, byval as LPINT) as INT_
type LPWPUCLOSETHREAD as function (byval as LPWSATHREADID, byval as LPINT) as INT_
type LPWPUCREATEEVENT as function (byval as LPINT) as HANDLE
type LPWPUCREATESOCKETHANDLE as function (byval as DWORD, byval as DWORD, byval as LPINT) as SOCKET
type LPWPUFDISSET as function (byval as SOCKET, byval as LPFD_SET) as SOCKET
type LPWPUGETPROVIDERPATH as function (byval as LPGUID, byval as LPWSTR, byval as LPINT, byval as LPINT) as INT_
type LPWPUMODIFYIFSHANDLE as function (byval as DWORD, byval as SOCKET, byval as LPINT) as SOCKET
type LPWPUOPENCURRENTTHREAD as function (byval as LPWSATHREADID, byval as LPINT) as INT_
type LPWPUPOSTMESSAGE as function (byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as BOOL
type LPWPUQUERYBLOCKINGCALLBACK as function (byval as DWORD, byval as LPBLOCKINGCALLBACK ptr, byval as LPDWORD, byval as LPINT) as INT_
type LPWPUQUERYSOCKETHANDLECONTEXT as function (byval as SOCKET, byval as LPDWORD, byval as LPINT) as INT_
type LPWPUQUEUEAPC as function (byval as LPWSATHREADID, byval as LPWSAUSERAPC, byval as DWORD, byval as LPINT) as INT_
type LPWPURESETEVENT as function (byval as HANDLE, byval as LPINT) as BOOL
type LPWPUSETEVENT as function (byval as HANDLE, byval as LPINT) as BOOL
type LPWPUCOMPLETEOVERLAPPEDREQUEST as function (byval as SOCKET, byval as LPWSAOVERLAPPED, byval as DWORD, byval as DWORD, byval as LPINT) as INT_

type WSPUPCALLTABLE
	lpWPUCloseEvent as LPWPUCLOSEEVENT
	lpWPUCloseSocketHandle as LPWPUCLOSESOCKETHANDLE
	lpWPUCreateEvent as LPWPUCREATEEVENT
	lpWPUCreateSocketHandle as LPWPUCREATESOCKETHANDLE
	lpWPUFDIsSet as LPWPUFDISSET
	lpWPUGetProviderPath as LPWPUGETPROVIDERPATH
	lpWPUModifyIFSHandle as LPWPUMODIFYIFSHANDLE
	lpWPUPostMessage as LPWPUPOSTMESSAGE
	lpWPUQueryBlockingCallback as LPWPUQUERYBLOCKINGCALLBACK
	lpWPUQuerySocketHandleContext as LPWPUQUERYSOCKETHANDLECONTEXT
	lpWPUQueueApc as LPWPUQUEUEAPC
	lpWPUResetEvent as LPWPURESETEVENT
	lpWPUSetEvent as LPWPUSETEVENT
	lpWPUOpenCurrentThread as LPWPUOPENCURRENTTHREAD
	lpWPUCloseThread as LPWPUCLOSETHREAD
end type

type LPWSPUPCALLTABLE as WSPUPCALLTABLE ptr

type LPWSPSTARTUP as function (byval as WORD, byval as LPWSPDATA, byval as LPWSAPROTOCOL_INFOW, byval as WSPUPCALLTABLE, byval as LPWSPPROC_TABLE) as INT_
type LPNSPCLEANUP as function (byval as LPGUID) as INT_
type LPNSPGETSERVICECLASSINFO as function (byval as LPGUID, byval as LPDWORD, byval as LPWSASERVICECLASSINFOW) as INT_
type LPNSPINSTALLSERVICECLASS as function (byval as LPGUID, byval as LPWSASERVICECLASSINFOW) as INT_
type LPNSPLOOKUPSERVICEBEGIN as function (byval as LPGUID, byval as LPWSAQUERYSETW, byval as LPWSASERVICECLASSINFOW, byval as DWORD, byval as LPHANDLE) as INT_
type LPNSPLOOKUPSERVICEEND as function (byval as HANDLE) as INT_
type LPNSPLOOKUPSERVICENEXT as function (byval as HANDLE, byval as DWORD, byval as LPDWORD, byval as LPWSAQUERYSET) as INT_
type LPNSPREMOVESERVICECLASS as function (byval as LPGUID, byval as LPGUID) as INT_
type LPNSPSETSERVICE as function (byval as LPGUID, byval as LPWSASERVICECLASSINFOW, byval as LPWSAQUERYSETW, byval as WSAESETSERVICEOP, byval as DWORD) as INT_

type NSP_ROUTINE
	cbSize as DWORD
	dwMajorVersion as DWORD
	dwMinorVersion as DWORD
	NSPCleanup as LPNSPCLEANUP
	NSPLookupServiceBegin as LPNSPLOOKUPSERVICEBEGIN
	NSPLookupServiceNext as LPNSPLOOKUPSERVICENEXT
	NSPLookupServiceEnd as LPNSPLOOKUPSERVICEEND
	NSPSetService as LPNSPSETSERVICE
	NSPInstallServiceClass as LPNSPINSTALLSERVICECLASS
	NSPRemoveServiceClass as LPNSPREMOVESERVICECLASS
	NSPGetServiceClassInfo as LPNSPGETSERVICECLASSINFO
end type

type PNSP_ROUTINE as NSP_ROUTINE ptr
type LPNSP_ROUTINE as NSP_ROUTINE ptr

declare function NSPStartup alias "NSPStartup" (byval as LPGUID, byval as LPNSP_ROUTINE) as INT_
declare function WPUCompleteOverlappedRequest alias "WPUCompleteOverlappedRequest" (byval as SOCKET, byval as LPWSAOVERLAPPED, byval as DWORD, byval as DWORD, byval as LPINT) as INT_
declare function WSPStartup alias "WSPStartup" (byval as WORD, byval as LPWSPDATA, byval as LPWSAPROTOCOL_INFOW, byval as WSPUPCALLTABLE, byval as LPWSPPROC_TABLE) as INT_
declare function WSCDeinstallProvider alias "WSCDeinstallProvider" (byval as LPGUID, byval as LPINT) as INT_
declare function WSCEnumProtocols alias "WSCEnumProtocols" (byval as LPINT, byval as LPWSAPROTOCOL_INFOW, byval as LPDWORD, byval as LPINT) as INT_
declare function WSCGetProviderPath alias "WSCGetProviderPath" (byval as LPGUID, byval as LPWSTR, byval as LPINT, byval as LPINT) as INT_
declare function WSCInstallProvider alias "WSCInstallProvider" (byval as LPGUID, byval as LPWSTR, byval as LPWSAPROTOCOL_INFOW, byval as DWORD, byval as LPINT) as INT_
declare function WSCEnableNSProvider alias "WSCEnableNSProvider" (byval as LPGUID, byval as BOOL) as INT_
declare function WSCInstallNameSpace alias "WSCInstallNameSpace" (byval as LPWSTR, byval as LPWSTR, byval as DWORD, byval as DWORD, byval as LPGUID) as INT_
declare function WSCUnInstallNameSpace alias "WSCUnInstallNameSpace" (byval as LPGUID) as INT_
declare function WSCWriteProviderOrder alias "WSCWriteProviderOrder" (byval as LPDWORD, byval as DWORD) as INT_

#endif
