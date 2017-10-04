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

#include once "winsock2.bi"

extern "Windows"

#define _WINSOCK2SPI_
const WSPDESCRIPTION_LEN = 255
const WSS_OPERATION_IN_PROGRESS = &h00000103

#ifdef __FB_64BIT__
	type WSPDATA
		wVersion as WORD
		wHighVersion as WORD
		szDescription as wstring * 255 + 1
	end type
#else
	type WSPDATA field = 4
		wVersion as WORD
		wHighVersion as WORD
		szDescription as wstring * 255 + 1
	end type
#endif

type LPWSPDATA as WSPDATA ptr

#ifdef __FB_64BIT__
	type _WSATHREADID
		ThreadHandle as HANDLE
		Reserved as DWORD_PTR
	end type
#else
	type _WSATHREADID field = 4
		ThreadHandle as HANDLE
		Reserved as DWORD_PTR
	end type
#endif

type WSATHREADID as _WSATHREADID
type LPWSATHREADID as _WSATHREADID ptr
#define WSPAPI WSAAPI
type LPBLOCKINGCALLBACK as function(byval dwContext as DWORD_PTR) as WINBOOL
type LPWSAUSERAPC as sub(byval dwContext as DWORD_PTR)
type LPWSPACCEPT as function(byval s as SOCKET, byval addr as SOCKADDR ptr, byval addrlen as LPINT, byval lpfnCondition as LPCONDITIONPROC, byval dwCallbackData as DWORD_PTR, byval lpErrno as LPINT) as SOCKET
type LPWSPADDRESSTOSTRING as function(byval lpsaAddress as LPSOCKADDR, byval dwAddressLength as DWORD, byval lpProtocolInfo as LPWSAPROTOCOL_INFOW, byval lpszAddressString as LPWSTR, byval lpdwAddressStringLength as LPDWORD, byval lpErrno as LPINT) as INT_
type LPWSPASYNCSELECT as function(byval s as SOCKET, byval hWnd as HWND, byval wMsg as ulong, byval lEvent as long, byval lpErrno as LPINT) as long
type LPWSPBIND as function(byval s as SOCKET, byval name as const SOCKADDR ptr, byval namelen as long, byval lpErrno as LPINT) as long
type LPWSPCANCELBLOCKINGCALL as function(byval lpErrno as LPINT) as long
type LPWSPCLEANUP as function(byval lpErrno as LPINT) as long
type LPWSPCLOSESOCKET as function(byval s as SOCKET, byval lpErrno as LPINT) as long
type LPWSPCONNECT as function(byval s as SOCKET, byval name as const SOCKADDR ptr, byval namelen as long, byval lpCallerData as LPWSABUF, byval lpCalleeData as LPWSABUF, byval lpSQOS as LPQOS, byval lpGQOS as LPQOS, byval lpErrno as LPINT) as long
type LPWSPDUPLICATESOCKET as function(byval s as SOCKET, byval dwProcessId as DWORD, byval lpProtocolInfo as LPWSAPROTOCOL_INFOW, byval lpErrno as LPINT) as long
type LPWSPENUMNETWORKEVENTS as function(byval s as SOCKET, byval hEventObject as HANDLE, byval lpNetworkEvents as LPWSANETWORKEVENTS, byval lpErrno as LPINT) as long
type LPWSPEVENTSELECT as function(byval s as SOCKET, byval hEventObject as HANDLE, byval lNetworkEvents as long, byval lpErrno as LPINT) as long
type LPWSPGETOVERLAPPEDRESULT as function(byval s as SOCKET, byval lpOverlapped as LPWSAOVERLAPPED, byval lpcbTransfer as LPDWORD, byval fWait as WINBOOL, byval lpdwFlags as LPDWORD, byval lpErrno as LPINT) as WINBOOL
type LPWSPGETPEERNAME as function(byval s as SOCKET, byval name as SOCKADDR ptr, byval namelen as LPINT, byval lpErrno as LPINT) as long
type LPWSPGETSOCKNAME as function(byval s as SOCKET, byval name as SOCKADDR ptr, byval namelen as LPINT, byval lpErrno as LPINT) as long
type LPWSPGETSOCKOPT as function(byval s as SOCKET, byval level as long, byval optname as long, byval optval as zstring ptr, byval optlen as LPINT, byval lpErrno as LPINT) as long
type LPWSPGETQOSBYNAME as function(byval s as SOCKET, byval lpQOSName as LPWSABUF, byval lpQOS as LPQOS, byval lpErrno as LPINT) as WINBOOL
type LPWSPIOCTL as function(byval s as SOCKET, byval dwIoControlCode as DWORD, byval lpvInBuffer as LPVOID, byval cbInBuffer as DWORD, byval lpvOutBuffer as LPVOID, byval cbOutBuffer as DWORD, byval lpcbBytesReturned as LPDWORD, byval lpOverlapped as LPWSAOVERLAPPED, byval lpCompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE, byval lpThreadId as LPWSATHREADID, byval lpErrno as LPINT) as long
type LPWSPJOINLEAF as function(byval s as SOCKET, byval name as const SOCKADDR ptr, byval namelen as long, byval lpCallerData as LPWSABUF, byval lpCalleeData as LPWSABUF, byval lpSQOS as LPQOS, byval lpGQOS as LPQOS, byval dwFlags as DWORD, byval lpErrno as LPINT) as SOCKET
type LPWSPLISTEN as function(byval s as SOCKET, byval backlog as long, byval lpErrno as LPINT) as long
type LPWSPRECV as function(byval s as SOCKET, byval lpBuffers as LPWSABUF, byval dwBufferCount as DWORD, byval lpNumberOfBytesRecvd as LPDWORD, byval lpFlags as LPDWORD, byval lpOverlapped as LPWSAOVERLAPPED, byval lpCompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE, byval lpThreadId as LPWSATHREADID, byval lpErrno as LPINT) as long
type LPWSPRECVDISCONNECT as function(byval s as SOCKET, byval lpInboundDisconnectData as LPWSABUF, byval lpErrno as LPINT) as long
type LPWSPRECVFROM as function(byval s as SOCKET, byval lpBuffers as LPWSABUF, byval dwBufferCount as DWORD, byval lpNumberOfBytesRecvd as LPDWORD, byval lpFlags as LPDWORD, byval lpFrom as SOCKADDR ptr, byval lpFromlen as LPINT, byval lpOverlapped as LPWSAOVERLAPPED, byval lpCompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE, byval lpThreadId as LPWSATHREADID, byval lpErrno as LPINT) as long
type LPWSPSELECT as function(byval nfds as long, byval readfds as FD_SET ptr, byval writefds as FD_SET ptr, byval exceptfds as FD_SET ptr, byval timeout as const PTIMEVAL, byval lpErrno as LPINT) as long
type LPWSPSEND as function(byval s as SOCKET, byval lpBuffers as LPWSABUF, byval dwBufferCount as DWORD, byval lpNumberOfBytesSent as LPDWORD, byval dwFlags as DWORD, byval lpOverlapped as LPWSAOVERLAPPED, byval lpCompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE, byval lpThreadId as LPWSATHREADID, byval lpErrno as LPINT) as long
type LPWSPSENDDISCONNECT as function(byval s as SOCKET, byval lpOutboundDisconnectData as LPWSABUF, byval lpErrno as LPINT) as long
type LPWSPSENDTO as function(byval s as SOCKET, byval lpBuffers as LPWSABUF, byval dwBufferCount as DWORD, byval lpNumberOfBytesSent as LPDWORD, byval dwFlags as DWORD, byval lpTo as const SOCKADDR ptr, byval iTolen as long, byval lpOverlapped as LPWSAOVERLAPPED, byval lpCompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE, byval lpThreadId as LPWSATHREADID, byval lpErrno as LPINT) as long
type LPWSPSETSOCKOPT as function(byval s as SOCKET, byval level as long, byval optname as long, byval optval as const zstring ptr, byval optlen as long, byval lpErrno as LPINT) as long
type LPWSPSHUTDOWN as function(byval s as SOCKET, byval how as long, byval lpErrno as LPINT) as long
type LPWSPSOCKET as function(byval af as long, byval type as long, byval protocol as long, byval lpProtocolInfo as LPWSAPROTOCOL_INFOW, byval g as GROUP, byval dwFlags as DWORD, byval lpErrno as LPINT) as SOCKET
type LPWSPSTRINGTOADDRESS as function(byval AddressString as LPWSTR, byval AddressFamily as INT_, byval lpProtocolInfo as LPWSAPROTOCOL_INFOW, byval lpAddress as LPSOCKADDR, byval lpAddressLength as LPINT, byval lpErrno as LPINT) as INT_

#ifdef __FB_64BIT__
	type _WSPPROC_TABLE
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
#else
	type _WSPPROC_TABLE field = 4
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
#endif

type WSPPROC_TABLE as _WSPPROC_TABLE
type LPWSPPROC_TABLE as _WSPPROC_TABLE ptr
type LPWPUCLOSEEVENT as function(byval hEvent as HANDLE, byval lpErrno as LPINT) as WINBOOL
type LPWPUCLOSESOCKETHANDLE as function(byval s as SOCKET, byval lpErrno as LPINT) as long
type LPWPUCREATEEVENT as function(byval lpErrno as LPINT) as HANDLE
type LPWPUCREATESOCKETHANDLE as function(byval dwCatalogEntryId as DWORD, byval dwContext as DWORD_PTR, byval lpErrno as LPINT) as SOCKET
type LPWPUFDISSET as function(byval s as SOCKET, byval fdset as FD_SET ptr) as long
type LPWPUGETPROVIDERPATH as function(byval lpProviderId as LPGUID, byval lpszProviderDllPath as wstring ptr, byval lpProviderDllPathLen as LPINT, byval lpErrno as LPINT) as long
type LPWPUMODIFYIFSHANDLE as function(byval dwCatalogEntryId as DWORD, byval ProposedHandle as SOCKET, byval lpErrno as LPINT) as SOCKET
type LPWPUPOSTMESSAGE as function(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
type LPWPUQUERYBLOCKINGCALLBACK as function(byval dwCatalogEntryId as DWORD, byval lplpfnCallback as LPBLOCKINGCALLBACK ptr, byval lpdwContext as PDWORD_PTR, byval lpErrno as LPINT) as long
type LPWPUQUERYSOCKETHANDLECONTEXT as function(byval s as SOCKET, byval lpContext as PDWORD_PTR, byval lpErrno as LPINT) as long
type LPWPUQUEUEAPC as function(byval lpThreadId as LPWSATHREADID, byval lpfnUserApc as LPWSAUSERAPC, byval dwContext as DWORD_PTR, byval lpErrno as LPINT) as long
type LPWPURESETEVENT as function(byval hEvent as HANDLE, byval lpErrno as LPINT) as WINBOOL
type LPWPUSETEVENT as function(byval hEvent as HANDLE, byval lpErrno as LPINT) as WINBOOL
type LPWPUOPENCURRENTTHREAD as function(byval lpThreadId as LPWSATHREADID, byval lpErrno as LPINT) as long
type LPWPUCLOSETHREAD as function(byval lpThreadId as LPWSATHREADID, byval lpErrno as LPINT) as long
type LPWPUCOMPLETEOVERLAPPEDREQUEST as function(byval s as SOCKET, byval lpOverlapped as LPWSAOVERLAPPED, byval dwError as DWORD, byval cbTransferred as DWORD, byval lpErrno as LPINT) as long

#ifdef __FB_64BIT__
	type _WSPUPCALLTABLE
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
#else
	type _WSPUPCALLTABLE field = 4
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
#endif

type WSPUPCALLTABLE as _WSPUPCALLTABLE
type LPWSPUPCALLTABLE as _WSPUPCALLTABLE ptr
type LPWSPSTARTUP as function(byval wVersionRequested as WORD, byval lpWSPData as LPWSPDATA, byval lpProtocolInfo as LPWSAPROTOCOL_INFOW, byval UpcallTable as WSPUPCALLTABLE, byval lpProcTable as LPWSPPROC_TABLE) as long
type LPWSCENUMPROTOCOLS as function(byval lpiProtocols as LPINT, byval lpProtocolBuffer as LPWSAPROTOCOL_INFOW, byval lpdwBufferLength as LPDWORD, byval lpErrno as LPINT) as long
type LPWSCDEINSTALLPROVIDER as function(byval lpProviderId as LPGUID, byval lpErrno as LPINT) as long
type LPWSCINSTALLPROVIDER as function(byval lpProviderId as LPGUID, byval lpszProviderDllPath as const wstring ptr, byval lpProtocolInfoList as const LPWSAPROTOCOL_INFOW, byval dwNumberOfEntries as DWORD, byval lpErrno as LPINT) as long
type LPWSCGETPROVIDERPATH as function(byval lpProviderId as LPGUID, byval lpszProviderDllPath as wstring ptr, byval lpProviderDllPathLen as LPINT, byval lpErrno as LPINT) as long
type LPWSCUPDATEPROVIDER as function(byval lpProviderId as LPGUID, byval lpszProviderDllPath as const wstring ptr, byval lpProtocolInfoList as const LPWSAPROTOCOL_INFOW, byval dwNumberOfEntries as DWORD, byval lpErrno as LPINT) as long
type LPWSCINSTALLQOSTEMPLATE as function(byval Guid as const LPGUID, byval QosName as LPWSABUF, byval Qos as LPQOS) as long
type LPWSCREMOVEQOSTEMPLATE as function(byval Guid as const LPGUID, byval QosName as LPWSABUF) as long

declare function WSPStartup(byval wVersionRequested as WORD, byval lpWSPData as LPWSPDATA, byval lpProtocolInfo as LPWSAPROTOCOL_INFOW, byval UpcallTable as WSPUPCALLTABLE, byval lpProcTable as LPWSPPROC_TABLE) as long
declare function WSCEnumProtocols(byval lpiProtocols as LPINT, byval lpProtocolBuffer as LPWSAPROTOCOL_INFOW, byval lpdwBufferLength as LPDWORD, byval lpErrno as LPINT) as long
declare function WSCDeinstallProvider(byval lpProviderId as LPGUID, byval lpErrno as LPINT) as long
declare function WSCInstallProvider(byval lpProviderId as LPGUID, byval lpszProviderDllPath as const wstring ptr, byval lpProtocolInfoList as const LPWSAPROTOCOL_INFOW, byval dwNumberOfEntries as DWORD, byval lpErrno as LPINT) as long
declare function WSCGetProviderPath(byval lpProviderId as LPGUID, byval lpszProviderDllPath as wstring ptr, byval lpProviderDllPathLen as LPINT, byval lpErrno as LPINT) as long
declare function WSCUpdateProvider(byval lpProviderId as LPGUID, byval lpszProviderDllPath as const wstring ptr, byval lpProtocolInfoList as const LPWSAPROTOCOL_INFOW, byval dwNumberOfEntries as DWORD, byval lpErrno as LPINT) as long
declare function WSCInstallQOSTemplate(byval Guid as const LPGUID, byval QosName as LPWSABUF, byval Qos as LPQOS) as long
declare function WSCRemoveQOSTemplate(byval Guid as const LPGUID, byval QosName as LPWSABUF) as long

#ifdef __FB_64BIT__
	declare function WSCEnumProtocols32(byval lpiProtocols as LPINT, byval lpProtocolBuffer as LPWSAPROTOCOL_INFOW, byval lpdwBufferLength as LPDWORD, byval lpErrno as LPINT) as long
	declare function WSCDeinstallProvider32(byval lpProviderId as LPGUID, byval lpErrno as LPINT) as long
	declare function WSCInstallProvider64_32(byval lpProviderId as LPGUID, byval lpszProviderDllPath as const wstring ptr, byval lpProtocolInfoList as const LPWSAPROTOCOL_INFOW, byval dwNumberOfEntries as DWORD, byval lpErrno as LPINT) as long
	declare function WSCGetProviderPath32(byval lpProviderId as LPGUID, byval lpszProviderDllPath as wstring ptr, byval lpProviderDllPathLen as LPINT, byval lpErrno as LPINT) as long
	declare function WSCUpdateProvider32(byval lpProviderId as LPGUID, byval lpszProviderDllPath as const wstring ptr, byval lpProtocolInfoList as const LPWSAPROTOCOL_INFOW, byval dwNumberOfEntries as DWORD, byval lpErrno as LPINT) as long
#endif

declare function WPUCloseEvent(byval hEvent as HANDLE, byval lpErrno as LPINT) as WINBOOL
declare function WPUCloseSocketHandle(byval s as SOCKET, byval lpErrno as LPINT) as long
declare function WPUCreateEvent(byval lpErrno as LPINT) as HANDLE
declare function WPUCreateSocketHandle(byval dwCatalogEntryId as DWORD, byval dwContext as DWORD_PTR, byval lpErrno as LPINT) as SOCKET
declare function WPUFDIsSet(byval s as SOCKET, byval fdset as FD_SET ptr) as long
declare function WPUGetProviderPath(byval lpProviderId as LPGUID, byval lpszProviderDllPath as wstring ptr, byval lpProviderDllPathLen as LPINT, byval lpErrno as LPINT) as long
declare function WPUModifyIFSHandle(byval dwCatalogEntryId as DWORD, byval ProposedHandle as SOCKET, byval lpErrno as LPINT) as SOCKET
declare function WPUPostMessage(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
declare function WPUQueryBlockingCallback(byval dwCatalogEntryId as DWORD, byval lplpfnCallback as LPBLOCKINGCALLBACK ptr, byval lpdwContext as PDWORD_PTR, byval lpErrno as LPINT) as long
declare function WPUQuerySocketHandleContext(byval s as SOCKET, byval lpContext as PDWORD_PTR, byval lpErrno as LPINT) as long
declare function WPUQueueApc(byval lpThreadId as LPWSATHREADID, byval lpfnUserApc as LPWSAUSERAPC, byval dwContext as DWORD_PTR, byval lpErrno as LPINT) as long
declare function WPUResetEvent(byval hEvent as HANDLE, byval lpErrno as LPINT) as WINBOOL
declare function WPUSetEvent(byval hEvent as HANDLE, byval lpErrno as LPINT) as WINBOOL
declare function WPUCompleteOverlappedRequest(byval s as SOCKET, byval lpOverlapped as LPWSAOVERLAPPED, byval dwError as DWORD, byval cbTransferred as DWORD, byval lpErrno as LPINT) as long
declare function WPUOpenCurrentThread(byval lpThreadId as LPWSATHREADID, byval lpErrno as LPINT) as long
declare function WPUCloseThread(byval lpThreadId as LPWSATHREADID, byval lpErrno as LPINT) as long
declare function WSCEnumNameSpaceProviders alias "WSAEnumNameSpaceProvidersW"(byval lpdwBufferLength as LPDWORD, byval lpnspBuffer as LPWSANAMESPACE_INFOW) as INT_
#define LPFN_WSCENUMNAMESPACEPROVIDERS LPFN_WSAENUMNAMESPACEPROVIDERSW

#ifdef __FB_64BIT__
	declare function WSCEnumNameSpaceProviders32(byval lpdwBufferLength as LPDWORD, byval lpnspBuffer as LPWSANAMESPACE_INFOW) as INT_
#endif

type LPWSCINSTALLNAMESPACE as function(byval lpszIdentifier as LPWSTR, byval lpszPathName as LPWSTR, byval dwNameSpace as DWORD, byval dwVersion as DWORD, byval lpProviderId as LPGUID) as INT_
type LPWSCUNINSTALLNAMESPACE as function(byval lpProviderId as LPGUID) as INT_
type LPWSCENABLENSPROVIDER as function(byval lpProviderId as LPGUID, byval fEnable as WINBOOL) as INT_

declare function WSCInstallNameSpace(byval lpszIdentifier as LPWSTR, byval lpszPathName as LPWSTR, byval dwNameSpace as DWORD, byval dwVersion as DWORD, byval lpProviderId as LPGUID) as INT_
declare function WSCUnInstallNameSpace(byval lpProviderId as LPGUID) as INT_
declare function WSCEnableNSProvider(byval lpProviderId as LPGUID, byval fEnable as WINBOOL) as INT_

#ifdef __FB_64BIT__
	declare function WSCInstallNameSpace32(byval lpszIdentifier as LPWSTR, byval lpszPathName as LPWSTR, byval dwNameSpace as DWORD, byval dwVersion as DWORD, byval lpProviderId as LPGUID) as INT_
	declare function WSCUnInstallNameSpace32(byval lpProviderId as LPGUID) as INT_
	declare function WSCEnableNSProvider32(byval lpProviderId as LPGUID, byval fEnable as WINBOOL) as INT_
#endif

type LPNSPCLEANUP as function(byval lpProviderId as LPGUID) as INT_
type LPNSPLOOKUPSERVICEBEGIN as function(byval lpProviderId as LPGUID, byval lpqsRestrictions as LPWSAQUERYSETW, byval lpServiceClassInfo as LPWSASERVICECLASSINFOW, byval dwControlFlags as DWORD, byval lphLookup as LPHANDLE) as INT_
type LPNSPLOOKUPSERVICENEXT as function(byval hLookup as HANDLE, byval dwControlFlags as DWORD, byval lpdwBufferLength as LPDWORD, byval lpqsResults as LPWSAQUERYSETW) as INT_
type LPNSPIOCTL as function(byval hLookup as HANDLE, byval dwControlCode as DWORD, byval lpvInBuffer as LPVOID, byval cbInBuffer as DWORD, byval lpvOutBuffer as LPVOID, byval cbOutBuffer as DWORD, byval lpcbBytesReturned as LPDWORD, byval lpCompletion as LPWSACOMPLETION, byval lpThreadId as LPWSATHREADID) as INT_
type LPNSPLOOKUPSERVICEEND as function(byval hLookup as HANDLE) as INT_
type LPNSPSETSERVICE as function(byval lpProviderId as LPGUID, byval lpServiceClassInfo as LPWSASERVICECLASSINFOW, byval lpqsRegInfo as LPWSAQUERYSETW, byval essOperation as WSAESETSERVICEOP, byval dwControlFlags as DWORD) as INT_
type LPNSPINSTALLSERVICECLASS as function(byval lpProviderId as LPGUID, byval lpServiceClassInfo as LPWSASERVICECLASSINFOW) as INT_
type LPNSPREMOVESERVICECLASS as function(byval lpProviderId as LPGUID, byval lpServiceClassId as LPGUID) as INT_
type LPNSPGETSERVICECLASSINFO as function(byval lpProviderId as LPGUID, byval lpdwBufSize as LPDWORD, byval lpServiceClassInfo as LPWSASERVICECLASSINFOW) as INT_

#ifdef __FB_64BIT__
	type _NSP_ROUTINE
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
		NSPIoctl as LPNSPIOCTL
	end type
#else
	type _NSP_ROUTINE field = 4
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
		NSPIoctl as LPNSPIOCTL
	end type
#endif

type NSP_ROUTINE as _NSP_ROUTINE
type LPNSP_ROUTINE as _NSP_ROUTINE ptr
type LPNSPSTARTUP as function(byval lpProviderId as LPGUID, byval lpnspRoutines as LPNSP_ROUTINE) as INT_
declare function NSPStartup(byval lpProviderId as LPGUID, byval lpnspRoutines as LPNSP_ROUTINE) as INT_

#if _WIN32_WINNT >= &h0600
	type LPNSPV2CLEANUP as function(byval lpProviderId as LPGUID, byval pvClientSessionArg as LPVOID) as long
	type LPNSPV2CLIENTSESSIONRUNDOWN as function(byval lpProviderId as LPGUID, byval pvClientSessionArg as LPVOID) as long
	type LPNSPV2LOOKUPSERVICEBEGIN as function(byval lpProviderId as LPGUID, byval lpqsRestrictions as LPWSAQUERYSET2W, byval dwControlFlags as DWORD, byval lpvClientSessionArg as LPVOID, byval lphLookup as LPHANDLE) as long
	type LPNSPV2LOOKUPSERVICEEND as function(byval hLookup as HANDLE) as long
	type LPNSPV2LOOKUPSERVICENEXTEX as function(byval hAsyncCall as HANDLE, byval hLookup as HANDLE, byval dwControlFlags as DWORD, byval lpdwBufferLength as LPDWORD, byval lpqsResults as LPWSAQUERYSET2W) as long
	type LPNSPV2SETSERVICEEX as function(byval hAsyncCall as HANDLE, byval lpProviderId as LPGUID, byval lpqsRegInfo as LPWSAQUERYSET2W, byval essOperation as WSAESETSERVICEOP, byval dwControlFlags as DWORD, byval lpvClientSessionArg as LPVOID) as long
	type LPNSPV2STARTUP as function(byval lpProviderId as LPGUID, byval ppvClientSessionArg as LPVOID ptr) as long
#endif

#if (not defined(__FB_64BIT__)) and (_WIN32_WINNT >= &h0600)
	type _NSPV2_ROUTINE field = 4
		cbSize as DWORD
		dwMajorVersion as DWORD
		dwMinorVersion as DWORD
		NSPv2Startup as LPNSPV2STARTUP
		NSPv2Cleanup as LPNSPV2CLEANUP
		NSPv2LookupServiceBegin as LPNSPV2LOOKUPSERVICEBEGIN
		NSPv2LookupServiceNextEx as LPNSPV2LOOKUPSERVICENEXTEX
		NSPv2LookupServiceEnd as LPNSPV2LOOKUPSERVICEEND
		NSPv2SetServiceEx as LPNSPV2SETSERVICEEX
		NSPv2ClientSessionRundown as LPNSPV2CLIENTSESSIONRUNDOWN
	end type
#elseif defined(__FB_64BIT__) and (_WIN32_WINNT >= &h0600)
	type _NSPV2_ROUTINE
		cbSize as DWORD
		dwMajorVersion as DWORD
		dwMinorVersion as DWORD
		NSPv2Startup as LPNSPV2STARTUP
		NSPv2Cleanup as LPNSPV2CLEANUP
		NSPv2LookupServiceBegin as LPNSPV2LOOKUPSERVICEBEGIN
		NSPv2LookupServiceNextEx as LPNSPV2LOOKUPSERVICENEXTEX
		NSPv2LookupServiceEnd as LPNSPV2LOOKUPSERVICEEND
		NSPv2SetServiceEx as LPNSPV2SETSERVICEEX
		NSPv2ClientSessionRundown as LPNSPV2CLIENTSESSIONRUNDOWN
	end type
#endif

#if _WIN32_WINNT >= &h0600
	type NSPV2_ROUTINE as _NSPV2_ROUTINE
	type PNSPV2_ROUTINE as _NSPV2_ROUTINE ptr
	type LPCNSPV2_ROUTINE as _NSPV2_ROUTINE ptr

	const LSP_SYSTEM = &h80000000
	const LSP_INSPECTOR = &h00000001
	const LSP_REDIRECTOR = &h00000002
	const LSP_PROXY = &h00000004
	const LSP_FIREWALL = &h00000008
	const LSP_INBOUND_MODIFY = &h00000010
	const LSP_OUTBOUND_MODIFY = &h00000020
	const LSP_CRYPTO_COMPRESS = &h00000040
	const LSP_LOCAL_CACHE = &h00000080

	type _WSC_PROVIDER_INFO_TYPE as long
	enum
		ProviderInfoLspCategories = 0
		ProviderInfoAudit
	end enum

	type WSC_PROVIDER_INFO_TYPE as _WSC_PROVIDER_INFO_TYPE
#endif

#if (not defined(__FB_64BIT__)) and (_WIN32_WINNT >= &h0600)
	type _WSC_PROVIDER_AUDIT_INFO field = 4
		RecordSize as DWORD
		Reserved as PVOID
	end type
#elseif defined(__FB_64BIT__) and (_WIN32_WINNT >= &h0600)
	type _WSC_PROVIDER_AUDIT_INFO
		RecordSize as DWORD
		Reserved as PVOID
	end type
#endif

#if _WIN32_WINNT >= &h0600
	type WSC_PROVIDER_AUDIT_INFO as _WSC_PROVIDER_AUDIT_INFO
	type PWSC_PROVIDER_AUDIT_INFO as _WSC_PROVIDER_AUDIT_INFO ptr
	declare function WSAAdvertiseProvider(byval puuidProviderId as const GUID ptr, byval pNSPv2Routine as const LPCNSPV2_ROUTINE ptr) as INT_
	declare function WSAProviderCompleteAsyncCall(byval hAsyncCall as HANDLE, byval iRetCode as INT_) as INT_
	declare function WSAUnadvertiseProvider(byval puuidProviderId as const GUID ptr) as INT_
	declare function WSCGetApplicationCategory(byval Path as LPCWSTR, byval PathLength as DWORD, byval Extra as LPCWSTR, byval ExtraLength as DWORD, byval pPermittedLspCategories as DWORD ptr, byval lpErrno as LPINT) as long
	declare function WSCGetProviderInfo(byval lpProviderId as LPGUID, byval InfoType as WSC_PROVIDER_INFO_TYPE, byval Info as PBYTE, byval InfoSize as uinteger ptr, byval Flags as DWORD, byval lpErrno as LPINT) as long
#endif

#if (not defined(__FB_64BIT__)) and (_WIN32_WINNT >= &h0600)
	declare function WSCInstallProviderAndChains(byval lpProviderId as const LPGUID, byval lpszProviderDllPath as const LPWSTR, byval lpszLspName as const LPWSTR, byval dwServiceFlags as DWORD, byval lpProtocolInfoList as const LPWSAPROTOCOL_INFO, byval dwNumberOfEntries as DWORD, byval lpdwCatalogEntryId as LPDWORD, byval lpErrno as LPINT) as long
#endif

#if _WIN32_WINNT >= &h0600
	declare function WSCSetApplicationCategory(byval Path as LPCWSTR, byval PathLength as DWORD, byval Extra as LPCWSTR, byval ExtraLength as DWORD, byval PermittedLspCategories as DWORD, byval pPrevPermLspCat as DWORD ptr, byval lpErrno as LPINT) as long
	declare function WSCSetProviderInfo(byval lpProviderId as LPGUID, byval InfoType as WSC_PROVIDER_INFO_TYPE, byval Info as PBYTE, byval InfoSize as uinteger, byval Flags as DWORD, byval lpErrno as LPINT) as long
	declare function WSCInstallNameSpaceEx(byval lpszIdentifier as LPWSTR, byval lpszPathName as LPWSTR, byval dwNameSpace as DWORD, byval dwVersion as DWORD, byval lpProviderId as LPGUID, byval lpProviderInfo as LPBLOB) as long
	declare function WSCEnumNameSpaceProvidersEx alias "WSAEnumNameSpaceProvidersExW"(byval lpdwBufferLength as LPDWORD, byval lpnspBuffer as LPWSANAMESPACE_INFOEXW) as INT_
	#define LPFN_WSCENUMNAMESPACEPROVIDERSEX LPFN_WSAENUMNAMESPACEPROVIDERSEXW
#endif

#if defined(__FB_64BIT__) and (_WIN32_WINNT >= &h0600)
	declare function WSCEnumNameSpaceProvidersEx32(byval lpdwBufferLength as LPDWORD, byval lpnspBuffer as LPWSANAMESPACE_INFOEXW) as INT_
	declare function WSCGetProviderInfo32(byval lpProviderId as LPGUID, byval InfoType as WSC_PROVIDER_INFO_TYPE, byval Info as PBYTE, byval InfoSize as uinteger ptr, byval Flags as DWORD, byval lpErrno as LPINT) as long
	declare function WSCInstallNameSpaceEx32(byval lpszIdentifier as LPWSTR, byval lpszPathName as LPWSTR, byval dwNameSpace as DWORD, byval dwVersion as DWORD, byval lpProviderId as LPGUID, byval lpProviderInfo as LPBLOB) as long
	declare function WSCInstallProviderAndChains64_32(byval lpProviderId as const LPGUID, byval lpszProviderDllPath as const LPWSTR, byval lpszProviderDllPath32 as const LPWSTR, byval lpszLspName as const LPWSTR, byval dwServiceFlags as DWORD, byval lpProtocolInfoList as const LPWSAPROTOCOL_INFO, byval dwNumberOfEntries as DWORD, byval lpdwCatalogEntryId as LPDWORD, byval lpErrno as LPINT) as long
	declare function WSCSetProviderInfo32(byval lpProviderId as LPGUID, byval InfoType as WSC_PROVIDER_INFO_TYPE, byval Info as PBYTE, byval InfoSize as uinteger, byval Flags as DWORD, byval lpErrno as LPINT) as long
#endif

end extern
