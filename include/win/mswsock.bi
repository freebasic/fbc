''
''
'' mswsock -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_mswsock_bi__
#define __win_mswsock_bi__

#define SO_CONNDATA &h7000
#define SO_CONNOPT &h7001
#define SO_DISCDATA &h7002
#define SO_DISCOPT &h7003
#define SO_CONNDATALEN &h7004
#define SO_CONNOPTLEN &h7005
#define SO_DISCDATALEN &h7006
#define SO_DISCOPTLEN &h7007
#define SO_OPENTYPE &h7008
#define SO_SYNCHRONOUS_ALERT &h10
#define SO_SYNCHRONOUS_NONALERT &h20
#define SO_MAXDG &h7009
#define SO_MAXPATHDG &h700A
#define SO_UPDATE_ACCEPT_CONTEXT &h700B
#define SO_CONNECT_TIME &h700C
#define TCP_BSDURGENT &h7000
#define TF_DISCONNECT 1
#define TF_REUSE_SOCKET 2
#define TF_WRITE_BEHIND 4
#define TF_USE_DEFAULT_WORKER 0
#define TF_USE_SYSTEM_THREAD 16
#define TF_USE_KERNEL_APC 32

type TRANSMIT_FILE_BUFFERS
	Head as PVOID
	HeadLength as DWORD
	Tail as PVOID
	TailLength as DWORD
end type

type PTRANSMIT_FILE_BUFFERS as TRANSMIT_FILE_BUFFERS ptr
type LPTRANSMIT_FILE_BUFFERS as TRANSMIT_FILE_BUFFERS ptr

declare function WSARecvEx alias "WSARecvEx" (byval as SOCKET, byval as zstring ptr, byval as integer, byval as integer ptr) as integer
declare function TransmitFile alias "TransmitFile" (byval as SOCKET, byval as HANDLE, byval as DWORD, byval as DWORD, byval as LPOVERLAPPED, byval as LPTRANSMIT_FILE_BUFFERS, byval as DWORD) as BOOL
declare function AcceptEx alias "AcceptEx" (byval as SOCKET, byval as SOCKET, byval as PVOID, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPDWORD, byval as LPOVERLAPPED) as BOOL
declare sub GetAcceptExSockaddrs alias "GetAcceptExSockaddrs" (byval as PVOID, byval as DWORD, byval as DWORD, byval as DWORD, byval as sockaddr ptr ptr, byval as LPINT, byval as sockaddr ptr ptr, byval as LPINT)

#ifdef __winsock2_bi__

#define TP_ELEMENT_FILE		1
#define TP_ELEMENT_MEMORY	2
#define TP_ELEMENT_EOP		4

type TRANSMIT_PACKETS_ELEMENT
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

type WSAMSG
	name as LPSOCKADDR
	namelen as INT_
	lpBuffers as LPWSABUF
	dwBufferCount as DWORD
	Control as WSABUF
	dwFlags as DWORD
end type

type PWSAMSG as WSAMSG ptr 
type LPWSAMSG as WSAMSG ptr

type WSACMSGHDR
	cmsg_len as UINT
	cmsg_level as INT_
 	cmsg_type as INT_
end type

declare function DisconnectEx alias "DisconnectEx" (byval as SOCKET, byval as LPOVERLAPPED, byval as DWORD, byval as DWORD) as BOOL
declare function WSARecvMsg alias "WSARecvMsg" (byval as SOCKET, byval as LPWSAMSG, byval as LPDWORD, byval as LPWSAOVERLAPPED, byval as LPWSAOVERLAPPED_COMPLETION_ROUTINE) as integer

#endif ''__winsock2_bi__

#endif
