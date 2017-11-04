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

#define _MSWSOCK_
const SO_CONNDATA = &h7000
const SO_CONNOPT = &h7001
const SO_DISCDATA = &h7002
const SO_DISCOPT = &h7003
const SO_CONNDATALEN = &h7004
const SO_CONNOPTLEN = &h7005
const SO_DISCDATALEN = &h7006
const SO_DISCOPTLEN = &h7007
const SO_OPENTYPE = &h7008
const SO_SYNCHRONOUS_ALERT = &h10
const SO_SYNCHRONOUS_NONALERT = &h20
const SO_MAXDG = &h7009
const SO_MAXPATHDG = &h700A
const SO_UPDATE_ACCEPT_CONTEXT = &h700B
const SO_CONNECT_TIME = &h700C
const SO_UPDATE_CONNECT_CONTEXT = &h7010
const TCP_BSDURGENT = &h7000
#define SIO_UDP_CONNRESET _WSAIOW(IOC_VENDOR, 12)

#if (_WIN32_WINNT = &h0501) or (_WIN32_WINNT = &h0502)
	#define SIO_SOCKET_CLOSE_NOTIFY _WSAIOW(IOC_VENDOR, 13)
#elseif _WIN32_WINNT >= &h0600
	#define SIO_BSP_HANDLE _WSAIOR(IOC_WS2, 27)
	#define SIO_BSP_HANDLE_SELECT _WSAIOR(IOC_WS2, 28)
	#define SIO_BSP_HANDLE_POLL _WSAIOR(IOC_WS2, 29)
	#define SIO_EXT_SELECT _WSAIORW(IOC_WS2, 30)
	#define SIO_EXT_POLL _WSAIORW(IOC_WS2, 31)
	#define SIO_EXT_SENDMSG _WSAIORW(IOC_WS2, 32)
	#define SIO_BASE_HANDLE _WSAIOR(IOC_WS2, 34)
#endif

declare function WSARecvEx(byval s as SOCKET, byval buf as zstring ptr, byval len as long, byval flags as long ptr) as long
const TF_DISCONNECT = &h01
const TF_REUSE_SOCKET = &h02
const TF_WRITE_BEHIND = &h04
const TF_USE_DEFAULT_WORKER = &h00
const TF_USE_SYSTEM_THREAD = &h10
const TF_USE_KERNEL_APC = &h20
#define __MINGW_TRANSMIT_FILE_H

type _TRANSMIT_FILE_BUFFERS
	Head as LPVOID
	HeadLength as DWORD
	Tail as LPVOID
	TailLength as DWORD
end type

type TRANSMIT_FILE_BUFFERS as _TRANSMIT_FILE_BUFFERS
type PTRANSMIT_FILE_BUFFERS as _TRANSMIT_FILE_BUFFERS ptr
type LPTRANSMIT_FILE_BUFFERS as _TRANSMIT_FILE_BUFFERS ptr

declare function TransmitFile(byval hSocket as SOCKET, byval hFile as HANDLE, byval nNumberOfBytesToWrite as DWORD, byval nNumberOfBytesPerSend as DWORD, byval lpOverlapped as LPOVERLAPPED, byval lpTransmitBuffers as LPTRANSMIT_FILE_BUFFERS, byval dwReserved as DWORD) as WINBOOL
declare function AcceptEx(byval sListenSocket as SOCKET, byval sAcceptSocket as SOCKET, byval lpOutputBuffer as PVOID, byval dwReceiveDataLength as DWORD, byval dwLocalAddressLength as DWORD, byval dwRemoteAddressLength as DWORD, byval lpdwBytesReceived as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
declare sub GetAcceptExSockaddrs(byval lpOutputBuffer as PVOID, byval dwReceiveDataLength as DWORD, byval dwLocalAddressLength as DWORD, byval dwRemoteAddressLength as DWORD, byval LocalSockaddr as SOCKADDR ptr ptr, byval LocalSockaddrLength as LPINT, byval RemoteSockaddr as SOCKADDR ptr ptr, byval RemoteSockaddrLength as LPINT)
type LPFN_TRANSMITFILE as function(byval hSocket as SOCKET, byval hFile as HANDLE, byval nNumberOfBytesToWrite as DWORD, byval nNumberOfBytesPerSend as DWORD, byval lpOverlapped as LPOVERLAPPED, byval lpTransmitBuffers as LPTRANSMIT_FILE_BUFFERS, byval dwReserved as DWORD) as WINBOOL
#define WSAID_TRANSMITFILE (&hb5367df0, &hcbac, &h11cf, (&h95, &hca, &h00, &h80, &h5f, &h48, &ha1, &h92))
type LPFN_ACCEPTEX as function(byval sListenSocket as SOCKET, byval sAcceptSocket as SOCKET, byval lpOutputBuffer as PVOID, byval dwReceiveDataLength as DWORD, byval dwLocalAddressLength as DWORD, byval dwRemoteAddressLength as DWORD, byval lpdwBytesReceived as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
#define WSAID_ACCEPTEX (&hb5367df1, &hcbac, &h11cf, (&h95, &hca, &h00, &h80, &h5f, &h48, &ha1, &h92))
type LPFN_GETACCEPTEXSOCKADDRS as sub(byval lpOutputBuffer as PVOID, byval dwReceiveDataLength as DWORD, byval dwLocalAddressLength as DWORD, byval dwRemoteAddressLength as DWORD, byval LocalSockaddr as SOCKADDR ptr ptr, byval LocalSockaddrLength as LPINT, byval RemoteSockaddr as SOCKADDR ptr ptr, byval RemoteSockaddrLength as LPINT)
#define WSAID_GETACCEPTEXSOCKADDRS (&hb5367df2, &hcbac, &h11cf, (&h95, &hca, &h00, &h80, &h5f, &h48, &ha1, &h92))

type _TRANSMIT_PACKETS_ELEMENT
	dwElFlags as ULONG
	cLength as ULONG

	union
		type
			nFileOffset as LARGE_INTEGER
			hFile as HANDLE
		end type

		pBuffer as PVOID
	end union
end type

type TRANSMIT_PACKETS_ELEMENT as _TRANSMIT_PACKETS_ELEMENT
type PTRANSMIT_PACKETS_ELEMENT as _TRANSMIT_PACKETS_ELEMENT ptr
type LPTRANSMIT_PACKETS_ELEMENT as _TRANSMIT_PACKETS_ELEMENT ptr

const TP_ELEMENT_MEMORY = 1
const TP_ELEMENT_FILE = 2
const TP_ELEMENT_EOP = 4
#define TP_DISCONNECT TF_DISCONNECT
#define TP_REUSE_SOCKET TF_REUSE_SOCKET
const TP_USE_DEFAULT_WORKER = TF_USE_DEFAULT_WORKER
const TP_USE_SYSTEM_THREAD = TF_USE_SYSTEM_THREAD
const TP_USE_KERNEL_APC = TF_USE_KERNEL_APC
type LPFN_TRANSMITPACKETS as function(byval hSocket as SOCKET, byval lpPacketArray as LPTRANSMIT_PACKETS_ELEMENT, byval nElementCount as DWORD, byval nSendSize as DWORD, byval lpOverlapped as LPOVERLAPPED, byval dwFlags as DWORD) as WINBOOL
#define WSAID_TRANSMITPACKETS (&hd9689da0, &h1f90, &h11d3, (&h99, &h71, &h00, &hc0, &h4f, &h68, &hc8, &h76))
type LPFN_CONNECTEX as function(byval s as SOCKET, byval name as const SOCKADDR ptr, byval namelen as long, byval lpSendBuffer as PVOID, byval dwSendDataLength as DWORD, byval lpdwBytesSent as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as WINBOOL
#define WSAID_CONNECTEX (&h25a207b9, &hddf3, &h4660, (&h8e, &he9, &h76, &he5, &h8c, &h74, &h06, &h3e))
type LPFN_DISCONNECTEX as function(byval s as SOCKET, byval lpOverlapped as LPOVERLAPPED, byval dwFlags as DWORD, byval dwReserved as DWORD) as WINBOOL
#define WSAID_DISCONNECTEX (&h7fda2e11, &h8630, &h436f, (&ha0, &h31, &hf5, &h36, &ha6, &hee, &hc1, &h57))
#define DE_REUSE_SOCKET TF_REUSE_SOCKET
#define NLA_NAMESPACE_GUID (&h6642243a, &h3ba8, &h4aa6, (&hba, &ha5, &h2e, &hb, &hd7, &h1f, &hdd, &h83))
#define NLA_SERVICE_CLASS_GUID (&h37e515, &hb5c9, &h4a43, (&hba, &hda, &h8b, &h48, &ha8, &h7a, &hd2, &h39))
const NLA_ALLUSERS_NETWORK = &h00000001
const NLA_FRIENDLY_NAME = &h00000002

type _NLA_BLOB_DATA_TYPE as long
enum
	NLA_RAW_DATA = 0
	NLA_INTERFACE = 1
	NLA_802_1X_LOCATION = 2
	NLA_CONNECTIVITY = 3
	NLA_ICS = 4
end enum

type NLA_BLOB_DATA_TYPE as _NLA_BLOB_DATA_TYPE
type PNLA_BLOB_DATA_TYPE as _NLA_BLOB_DATA_TYPE ptr

type _NLA_CONNECTIVITY_TYPE as long
enum
	NLA_NETWORK_AD_HOC = 0
	NLA_NETWORK_MANAGED = 1
	NLA_NETWORK_UNMANAGED = 2
	NLA_NETWORK_UNKNOWN = 3
end enum

type NLA_CONNECTIVITY_TYPE as _NLA_CONNECTIVITY_TYPE
type PNLA_CONNECTIVITY_TYPE as _NLA_CONNECTIVITY_TYPE ptr

type _NLA_INTERNET as long
enum
	NLA_INTERNET_UNKNOWN = 0
	NLA_INTERNET_NO = 1
	NLA_INTERNET_YES = 2
end enum

type NLA_INTERNET as _NLA_INTERNET
type PNLA_INTERNET as _NLA_INTERNET ptr

type _NLA_BLOB_header
	as NLA_BLOB_DATA_TYPE type
	dwSize as DWORD
	nextOffset as DWORD
end type

type _NLA_BLOB_data_interfaceData
	dwType as DWORD
	dwSpeed as DWORD
	adapterName as zstring * 1
end type

type _NLA_BLOB_data_locationData
	information as zstring * 1
end type

type _NLA_BLOB_data_connectivity
	as NLA_CONNECTIVITY_TYPE type
	internet as NLA_INTERNET
end type

type _NLA_BLOB_data_ICS_remote
	speed as DWORD
	as DWORD type
	state as DWORD
	machineName as wstring * 256
	sharedAdapterName as wstring * 256
end type

type _NLA_BLOB_data_ICS
	remote as _NLA_BLOB_data_ICS_remote
end type

union _NLA_BLOB_data
	rawData as zstring * 1
	interfaceData as _NLA_BLOB_data_interfaceData
	locationData as _NLA_BLOB_data_locationData
	connectivity as _NLA_BLOB_data_connectivity
	ICS as _NLA_BLOB_data_ICS
end union

type _NLA_BLOB
	header as _NLA_BLOB_header
	data as _NLA_BLOB_data
end type

type NLA_BLOB as _NLA_BLOB
type PNLA_BLOB as _NLA_BLOB ptr
type LPNLA_BLOB as _NLA_BLOB ptr

type _WSACMSGHDR
	cmsg_len as SIZE_T_
	cmsg_level as INT_
	cmsg_type as INT_
end type

type WSACMSGHDR as _WSACMSGHDR
type PWSACMSGHDR as _WSACMSGHDR ptr
type LPWSACMSGHDR as _WSACMSGHDR ptr

#define WSA_CMSGHDR_ALIGN(length) ((((length) + MAX_NATURAL_ALIGNMENT) - 1) and (not (MAX_NATURAL_ALIGNMENT - 1)))
#define WSA_CMSGDATA_ALIGN(length) ((((length) + MAX_NATURAL_ALIGNMENT) - 1) and (not (MAX_NATURAL_ALIGNMENT - 1)))
#define WSA_CMSG_FIRSTHDR(msg) iif((msg)->Control.len >= sizeof(WSACMSGHDR), cast(LPWSACMSGHDR, (msg)->Control.buf), cast(LPWSACMSGHDR, NULL))
#define WSA_CMSG_NXTHDR(msg, cmsg) iif((cmsg) = 0, WSA_CMSG_FIRSTHDR(msg), iif(((cptr(u_char ptr, (cmsg)) + WSA_CMSGHDR_ALIGN((cmsg)->cmsg_len)) + sizeof(WSACMSGHDR)) > (cptr(u_char ptr, (msg)->Control.buf) + (msg)->Control.len), cast(LPWSACMSGHDR, NULL), cast(LPWSACMSGHDR, cptr(u_char ptr, (cmsg)) + WSA_CMSGHDR_ALIGN((cmsg)->cmsg_len))))
#define WSA_CMSG_DATA(cmsg) (cptr(u_char ptr, (cmsg)) + WSA_CMSGDATA_ALIGN(sizeof(WSACMSGHDR)))
#define WSA_CMSG_SPACE(length) WSA_CMSGDATA_ALIGN(sizeof(WSACMSGHDR) + WSA_CMSGHDR_ALIGN(length))
#define WSA_CMSG_LEN(length) (WSA_CMSGDATA_ALIGN(sizeof(WSACMSGHDR)) + length)
const MSG_TRUNC = &h0100
const MSG_CTRUNC = &h0200
const MSG_BCAST = &h0400
const MSG_MCAST = &h0800
type LPFN_WSARECVMSG as function(byval s as SOCKET, byval lpMsg as LPWSAMSG, byval lpdwNumberOfBytesRecvd as LPDWORD, byval lpOverlapped as LPWSAOVERLAPPED, byval lpCompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as INT_
#define WSAID_WSARECVMSG (&hf689d7c8, &h6f1f, &h436b, (&h8a, &h53, &he5, &h4f, &he3, &h51, &hc3, &h22))

#if _WIN32_WINNT >= &h0600
	type WSAPOLLDATA
		result as long
		fds as ULONG
		timeout as INT_
		fdArray(0 to 0) as WSAPOLLFD
	end type

	type LPWSAPOLLDATA as WSAPOLLDATA ptr
	type LPFN_WSAPOLL as function(byval fdarray as LPWSAPOLLFD, byval nfds as ULONG, byval timeout as INT_) as INT_
	#define WSAID_WSAPOLL (&h18C76F85, &hDC66, &h4964, (&h97, &h2E, &h23, &hC2, &h72, &h38, &h31, &h2B))

	type WSASENDMSG
		lpMsg as LPWSAMSG
		dwFlags as DWORD
		lpNumberOfBytesSent as LPDWORD
		lpOverlapped as LPWSAOVERLAPPED
		lpCompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE
	end type

	type LPWSASENDMSG as WSASENDMSG ptr
	type LPFN_WSASENDMSG as function(byval s as SOCKET, byval lpMsg as LPWSAMSG, byval dwFlags as DWORD, byval lpNumberOfBytesSent as LPDWORD, byval lpOverlapped as LPWSAOVERLAPPED, byval lpCompletionRoutine as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as INT_
	#define WSAID_WSASENDMSG (&ha441e712, &h754f, &h43ca, (&h84, &ha7, &h0d, &hee, &h44, &hcf, &h60, &h6d))
#endif

end extern
