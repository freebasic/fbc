''
''
'' dplay8 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dplay8_bi__
#define __win_dplay8_bi__

#inclib "dxguid"

#include once "win/ole2.bi"
#include once "win/dpaddr.bi"

extern CLSID_DirectPlay8Client alias "CLSID_DirectPlay8Client" as GUID
extern CLSID_DirectPlay8Server alias "CLSID_DirectPlay8Server" as GUID
extern CLSID_DirectPlay8Peer alias "CLSID_DirectPlay8Peer" as GUID
extern CLSID_DirectPlay8ThreadPool alias "CLSID_DirectPlay8ThreadPool" as GUID
extern CLSID_DirectPlay8NATResolver alias "CLSID_DirectPlay8NATResolver" as GUID

type DP8REFIID as IID ptr

extern IID_IDirectPlay8Client alias "IID_IDirectPlay8Client" as GUID
extern IID_IDirectPlay8Server alias "IID_IDirectPlay8Server" as GUID
extern IID_IDirectPlay8Peer alias "IID_IDirectPlay8Peer" as GUID
extern IID_IDirectPlay8ThreadPool alias "IID_IDirectPlay8ThreadPool" as GUID
extern IID_IDirectPlay8NATResolver alias "IID_IDirectPlay8NATResolver" as GUID
extern CLSID_DP8SP_IPX alias "CLSID_DP8SP_IPX" as GUID
extern CLSID_DP8SP_MODEM alias "CLSID_DP8SP_MODEM" as GUID
extern CLSID_DP8SP_SERIAL alias "CLSID_DP8SP_SERIAL" as GUID
extern CLSID_DP8SP_TCPIP alias "CLSID_DP8SP_TCPIP" as GUID
extern CLSID_DP8SP_BLUETOOTH alias "CLSID_DP8SP_BLUETOOTH" as GUID

type PDIRECTPLAY8CLIENT as IDirectPlay8Client ptr
type PDIRECTPLAY8SERVER as IDirectPlay8Server ptr
type PDIRECTPLAY8PEER as IDirectPlay8Peer ptr
type PDIRECTPLAY8THREADPOOL as IDirectPlay8ThreadPool ptr
type PDIRECTPLAY8NATRESOLVER as IDirectPlay8NATResolver ptr
type PDNLOBBIEDAPPLICATION as IDirectPlay8LobbiedApplication ptr
type PFNDPNMESSAGEHANDLER as function(byval as PVOID, byval as DWORD, byval as PVOID) as HRESULT
type DPNID as DWORD
type PDPNID as DWORD ptr
type DPNHANDLE as DWORD
type PDPNHANDLE as DWORD ptr

#define DPN_MSGID_OFFSET &hFFFF0000
#define DPN_MSGID_ADD_PLAYER_TO_GROUP (&hFFFF0000 or &h0001)
#define DPN_MSGID_APPLICATION_DESC (&hFFFF0000 or &h0002)
#define DPN_MSGID_ASYNC_OP_COMPLETE (&hFFFF0000 or &h0003)
#define DPN_MSGID_CLIENT_INFO (&hFFFF0000 or &h0004)
#define DPN_MSGID_CONNECT_COMPLETE (&hFFFF0000 or &h0005)
#define DPN_MSGID_CREATE_GROUP (&hFFFF0000 or &h0006)
#define DPN_MSGID_CREATE_PLAYER (&hFFFF0000 or &h0007)
#define DPN_MSGID_DESTROY_GROUP (&hFFFF0000 or &h0008)
#define DPN_MSGID_DESTROY_PLAYER (&hFFFF0000 or &h0009)
#define DPN_MSGID_ENUM_HOSTS_QUERY (&hFFFF0000 or &h000a)
#define DPN_MSGID_ENUM_HOSTS_RESPONSE (&hFFFF0000 or &h00&b)
#define DPN_MSGID_GROUP_INFO (&hFFFF0000 or &h000c)
#define DPN_MSGID_HOST_MIGRATE (&hFFFF0000 or &h000d)
#define DPN_MSGID_INDICATE_CONNECT (&hFFFF0000 or &h000e)
#define DPN_MSGID_INDICATED_CONNECT_ABORTED (&hFFFF0000 or &h000f)
#define DPN_MSGID_PEER_INFO (&hFFFF0000 or &h0010)
#define DPN_MSGID_RECEIVE (&hFFFF0000 or &h0011)
#define DPN_MSGID_REMOVE_PLAYER_FROM_GROUP (&hFFFF0000 or &h0012)
#define DPN_MSGID_RETURN_BUFFER (&hFFFF0000 or &h0013)
#define DPN_MSGID_SEND_COMPLETE (&hFFFF0000 or &h0014)
#define DPN_MSGID_SERVER_INFO (&hFFFF0000 or &h0015)
#define DPN_MSGID_TERMINATE_SESSION (&hFFFF0000 or &h0016)
#define DPN_MSGID_CREATE_THREAD (&hFFFF0000 or &h0017)
#define DPN_MSGID_DESTROY_THREAD (&hFFFF0000 or &h0018)
#define DPN_MSGID_NAT_RESOLVER_QUERY (&hFFFF0000 or &h0101)
#define DPNID_ALL_PLAYERS_GROUP 0
#define DPNDESTROYGROUPREASON_NORMAL &h0001
#define DPNDESTROYGROUPREASON_AUTODESTRUCTED &h0002
#define DPNDESTROYGROUPREASON_SESSIONTERMINATED &h0003
#define DPNDESTROYPLAYERREASON_NORMAL &h0001
#define DPNDESTROYPLAYERREASON_CONNECTIONLOST &h0002
#define DPNDESTROYPLAYERREASON_SESSIONTERMINATED &h0003
#define DPNDESTROYPLAYERREASON_HOSTDESTROYEDPLAYER &h0004
#define DPN_MAX_APPDESC_RESERVEDDATA_SIZE 64
#define DPNOP_SYNC &h80000000
#define DPNADDPLAYERTOGROUP_SYNC &h80000000
#define DPNCANCEL_CONNECT &h00000001
#define DPNCANCEL_ENUM &h00000002
#define DPNCANCEL_SEND &h00000004
#define DPNCANCEL_ALL_OPERATIONS &h00008000
#define DPNCANCEL_PLAYER_SENDS &h80000000
#define DPNCANCEL_PLAYER_SENDS_PRIORITY_HIGH (&h80000000 or &h00010000)
#define DPNCANCEL_PLAYER_SENDS_PRIORITY_NORMAL (&h80000000 or &h00020000)
#define DPNCANCEL_PLAYER_SENDS_PRIORITY_LOW (&h80000000 or &h00040000)
#define DPNCLOSE_IMMEDIATE &h00000001
#define DPNCONNECT_SYNC &h80000000
#define DPNCONNECT_OKTOQUERYFORADDRESSING &h0001
#define DPNCREATEGROUP_SYNC &h80000000
#define DPNDESTROYGROUP_SYNC &h80000000
#define DPNENUM_PLAYERS &h0001
#define DPNENUM_GROUPS &h0010
#define DPNENUMHOSTS_SYNC &h80000000
#define DPNENUMHOSTS_OKTOQUERYFORADDRESSING &h0001
#define DPNENUMHOSTS_NOBROADCASTFALLBACK &h0002
#define DPNENUMSERVICEPROVIDERS_ALL &h0001
#define DPNGETLOCALHOSTADDRESSES_COMBINED &h0001
#define DPNGETSENDQUEUEINFO_PRIORITY_NORMAL &h0001
#define DPNGETSENDQUEUEINFO_PRIORITY_HIGH &h0002
#define DPNGETSENDQUEUEINFO_PRIORITY_LOW &h0004
#define DPNGROUP_AUTODESTRUCT &h0001
#define DPNHOST_OKTOQUERYFORADDRESSING &h0001
#define DPNINFO_NAME &h0001
#define DPNINFO_DATA &h0002
#define DPNINITIALIZE_DISABLEPARAMVAL &h0001
#define DPNINITIALIZE_HINT_LANSESSION &h0002
#define DPNINITIALIZE_DISABLELINKTUNING &h0004
#define DPNLOBBY_REGISTER &h0001
#define DPNLOBBY_UNREGISTER &h0002
#define DPNPLAYER_LOCAL &h0002
#define DPNPLAYER_HOST &h0004
#define DPNRECEIVE_GUARANTEED &h0001
#define DPNRECEIVE_COALESCED &h0002
#define DPNREMOVEPLAYERFROMGROUP_SYNC &h80000000
#define DPNSEND_SYNC &h80000000
#define DPNSEND_NOCOPY &h0001
#define DPNSEND_NOCOMPLETE &h0002
#define DPNSEND_COMPLETEONPROCESS &h0004
#define DPNSEND_GUARANTEED &h0008
#define DPNSEND_NONSEQUENTIAL &h0010
#define DPNSEND_NOLOOPBACK &h0020
#define DPNSEND_PRIORITY_LOW &h0040
#define DPNSEND_PRIORITY_HIGH &h0080
#define DPNSEND_COALESCE &h0100
#define DPNSENDCOMPLETE_GUARANTEED &h0001
#define DPNSENDCOMPLETE_COALESCED &h0002
#define DPNSESSION_CLIENT_SERVER &h0001
#define DPNSESSION_MIGRATE_HOST &h0004
#define DPNSESSION_NODPNSVR &h0040
#define DPNSESSION_REQUIREPASSWORD &h0080
#define DPNSESSION_NOENUMS &h0100
#define DPNSESSION_FAST_SIGNED &h0200
#define DPNSESSION_FULL_SIGNED &h0400
#define DPNSETCLIENTINFO_SYNC &h80000000
#define DPNSETGROUPINFO_SYNC &h80000000
#define DPNSETPEERINFO_SYNC &h80000000
#define DPNSETSERVERINFO_SYNC &h80000000
#define DPNSPCAPS_SUPPORTSDPNSVR &h0001
#define DPNSPCAPS_SUPPORTSDPNSRV &h0001
#define DPNSPCAPS_SUPPORTSBROADCAST &h0002
#define DPNSPCAPS_SUPPORTSALLADAPTERS &h0004
#define DPNSPCAPS_SUPPORTSTHREADPOOL &h0008
#define DPNSPCAPS_NETWORKSIMULATOR &h0010
#define DPNSPINFO_NETWORKSIMULATORDEVICE &h0001

type DPN_APPLICATION_DESC
	dwSize as DWORD
	dwFlags as DWORD
	guidInstance as GUID
	guidApplication as GUID
	dwMaxPlayers as DWORD
	dwCurrentPlayers as DWORD
	pwszSessionName as WCHAR ptr
	pwszPassword as WCHAR ptr
	pvReservedData as PVOID
	dwReservedDataSize as DWORD
	pvApplicationReservedData as PVOID
	dwApplicationReservedDataSize as DWORD
end type

type PDPN_APPLICATION_DESC as DPN_APPLICATION_DESC ptr

type BUFFERDESC
	dwBufferSize as DWORD
	pBufferData as UBYTE ptr
end type

type DPN_BUFFER_DESC as BUFFERDESC
type PDPN_BUFFER_DESC as BUFFERDESC ptr
type PBUFFERDESC as BUFFERDESC ptr

type DPN_CAPS
	dwSize as DWORD
	dwFlags as DWORD
	dwConnectTimeout as DWORD
	dwConnectRetries as DWORD
	dwTimeoutUntilKeepAlive as DWORD
end type

type PDPN_CAPS as DPN_CAPS ptr

type DPN_CAPS_EX
	dwSize as DWORD
	dwFlags as DWORD
	dwConnectTimeout as DWORD
	dwConnectRetries as DWORD
	dwTimeoutUntilKeepAlive as DWORD
	dwMaxRecvMsgSize as DWORD
	dwNumSendRetries as DWORD
	dwMaxSendRetryInterval as DWORD
	dwDropThresholdRate as DWORD
	dwThrottleRate as DWORD
	dwNumHardDisconnectSends as DWORD
	dwMaxHardDisconnectPeriod as DWORD
end type

type PDPN_CAPS_EX as DPN_CAPS_EX ptr

type DPN_CONNECTION_INFO
	dwSize as DWORD
	dwRoundTripLatencyMS as DWORD
	dwThroughputBPS as DWORD
	dwPeakThroughputBPS as DWORD
	dwBytesSentGuaranteed as DWORD
	dwPacketsSentGuaranteed as DWORD
	dwBytesSentNonGuaranteed as DWORD
	dwPacketsSentNonGuaranteed as DWORD
	dwBytesRetried as DWORD
	dwPacketsRetried as DWORD
	dwBytesDropped as DWORD
	dwPacketsDropped as DWORD
	dwMessagesTransmittedHighPriority as DWORD
	dwMessagesTimedOutHighPriority as DWORD
	dwMessagesTransmittedNormalPriority as DWORD
	dwMessagesTimedOutNormalPriority as DWORD
	dwMessagesTransmittedLowPriority as DWORD
	dwMessagesTimedOutLowPriority as DWORD
	dwBytesReceivedGuaranteed as DWORD
	dwPacketsReceivedGuaranteed as DWORD
	dwBytesReceivedNonGuaranteed as DWORD
	dwPacketsReceivedNonGuaranteed as DWORD
	dwMessagesReceived as DWORD
end type

type PDPN_CONNECTION_INFO as DPN_CONNECTION_INFO ptr

type DPN_GROUP_INFO
	dwSize as DWORD
	dwInfoFlags as DWORD
	pwszName as PWSTR
	pvData as PVOID
	dwDataSize as DWORD
	dwGroupFlags as DWORD
end type

type PDPN_GROUP_INFO as DPN_GROUP_INFO ptr

type DPN_PLAYER_INFO
	dwSize as DWORD
	dwInfoFlags as DWORD
	pwszName as PWSTR
	pvData as PVOID
	dwDataSize as DWORD
	dwPlayerFlags as DWORD
end type

type PDPN_PLAYER_INFO as DPN_PLAYER_INFO ptr

type DPN_SECURITY_CREDENTIALS as any
type PDPN_SECURITY_CREDENTIALS as DPN_SECURITY_CREDENTIALS ptr
type DPN_SECURITY_DESC as any
type PDPN_SECURITY_DESC as DPN_SECURITY_DESC ptr

type DPN_SERVICE_PROVIDER_INFO
	dwFlags as DWORD
	guid as GUID
	pwszName as WCHAR ptr
	pvReserved as PVOID
	dwReserved as DWORD
end type

type PDPN_SERVICE_PROVIDER_INFO as DPN_SERVICE_PROVIDER_INFO ptr

type DPN_SP_CAPS
	dwSize as DWORD
	dwFlags as DWORD
	dwNumThreads as DWORD
	dwDefaultEnumCount as DWORD
	dwDefaultEnumRetryInterval as DWORD
	dwDefaultEnumTimeout as DWORD
	dwMaxEnumPayloadSize as DWORD
	dwBuffersPerThread as DWORD
	dwSystemBufferSize as DWORD
end type

type PDPN_SP_CAPS as DPN_SP_CAPS ptr

type DPNMSG_ADD_PLAYER_TO_GROUP
	dwSize as DWORD
	dpnidGroup as DPNID
	pvGroupContext as PVOID
	dpnidPlayer as DPNID
	pvPlayerContext as PVOID
end type

type PDPNMSG_ADD_PLAYER_TO_GROUP as DPNMSG_ADD_PLAYER_TO_GROUP ptr

type DPNMSG_ASYNC_OP_COMPLETE
	dwSize as DWORD
	hAsyncOp as DPNHANDLE
	pvUserContext as PVOID
	hResultCode as HRESULT
end type

type PDPNMSG_ASYNC_OP_COMPLETE as DPNMSG_ASYNC_OP_COMPLETE ptr

type DPNMSG_CLIENT_INFO
	dwSize as DWORD
	dpnidClient as DPNID
	pvPlayerContext as PVOID
end type

type PDPNMSG_CLIENT_INFO as DPNMSG_CLIENT_INFO ptr

type DPNMSG_CONNECT_COMPLETE
	dwSize as DWORD
	hAsyncOp as DPNHANDLE
	pvUserContext as PVOID
	hResultCode as HRESULT
	pvApplicationReplyData as PVOID
	dwApplicationReplyDataSize as DWORD
	dpnidLocal as DPNID
end type

type PDPNMSG_CONNECT_COMPLETE as DPNMSG_CONNECT_COMPLETE ptr

type DPNMSG_CREATE_GROUP
	dwSize as DWORD
	dpnidGroup as DPNID
	dpnidOwner as DPNID
	pvGroupContext as PVOID
	pvOwnerContext as PVOID
end type

type PDPNMSG_CREATE_GROUP as DPNMSG_CREATE_GROUP ptr

type DPNMSG_CREATE_PLAYER
	dwSize as DWORD
	dpnidPlayer as DPNID
	pvPlayerContext as PVOID
end type

type PDPNMSG_CREATE_PLAYER as DPNMSG_CREATE_PLAYER ptr

type DPNMSG_DESTROY_GROUP
	dwSize as DWORD
	dpnidGroup as DPNID
	pvGroupContext as PVOID
	dwReason as DWORD
end type

type PDPNMSG_DESTROY_GROUP as DPNMSG_DESTROY_GROUP ptr

type DPNMSG_DESTROY_PLAYER
	dwSize as DWORD
	dpnidPlayer as DPNID
	pvPlayerContext as PVOID
	dwReason as DWORD
end type

type PDPNMSG_DESTROY_PLAYER as DPNMSG_DESTROY_PLAYER ptr

type DPNMSG_ENUM_HOSTS_QUERY
	dwSize as DWORD
	pAddressSender as IDirectPlay8Address ptr
	pAddressDevice as IDirectPlay8Address ptr
	pvReceivedData as PVOID
	dwReceivedDataSize as DWORD
	dwMaxResponseDataSize as DWORD
	pvResponseData as PVOID
	dwResponseDataSize as DWORD
	pvResponseContext as PVOID
end type

type PDPNMSG_ENUM_HOSTS_QUERY as DPNMSG_ENUM_HOSTS_QUERY ptr

type DPNMSG_ENUM_HOSTS_RESPONSE
	dwSize as DWORD
	pAddressSender as IDirectPlay8Address ptr
	pAddressDevice as IDirectPlay8Address ptr
	pApplicationDescription as DPN_APPLICATION_DESC ptr
	pvResponseData as PVOID
	dwResponseDataSize as DWORD
	pvUserContext as PVOID
	dwRoundTripLatencyMS as DWORD
end type

type PDPNMSG_ENUM_HOSTS_RESPONSE as DPNMSG_ENUM_HOSTS_RESPONSE ptr

type DPNMSG_GROUP_INFO
	dwSize as DWORD
	dpnidGroup as DPNID
	pvGroupContext as PVOID
end type

type PDPNMSG_GROUP_INFO as DPNMSG_GROUP_INFO ptr

type DPNMSG_HOST_MIGRATE
	dwSize as DWORD
	dpnidNewHost as DPNID
	pvPlayerContext as PVOID
end type

type PDPNMSG_HOST_MIGRATE as DPNMSG_HOST_MIGRATE ptr

type DPNMSG_INDICATE_CONNECT
	dwSize as DWORD
	pvUserConnectData as PVOID
	dwUserConnectDataSize as DWORD
	pvReplyData as PVOID
	dwReplyDataSize as DWORD
	pvReplyContext as PVOID
	pvPlayerContext as PVOID
	pAddressPlayer as IDirectPlay8Address ptr
	pAddressDevice as IDirectPlay8Address ptr
end type

type PDPNMSG_INDICATE_CONNECT as DPNMSG_INDICATE_CONNECT ptr

type DPNMSG_INDICATED_CONNECT_ABORTED
	dwSize as DWORD
	pvPlayerContext as PVOID
end type

type PDPNMSG_INDICATED_CONNECT_ABORTED as DPNMSG_INDICATED_CONNECT_ABORTED ptr

type DPNMSG_PEER_INFO
	dwSize as DWORD
	dpnidPeer as DPNID
	pvPlayerContext as PVOID
end type

type PDPNMSG_PEER_INFO as DPNMSG_PEER_INFO ptr

type DPNMSG_RECEIVE
	dwSize as DWORD
	dpnidSender as DPNID
	pvPlayerContext as PVOID
	pReceiveData as PBYTE
	dwReceiveDataSize as DWORD
	hBufferHandle as DPNHANDLE
	dwReceiveFlags as DWORD
end type

type PDPNMSG_RECEIVE as DPNMSG_RECEIVE ptr

type DPNMSG_REMOVE_PLAYER_FROM_GROUP
	dwSize as DWORD
	dpnidGroup as DPNID
	pvGroupContext as PVOID
	dpnidPlayer as DPNID
	pvPlayerContext as PVOID
end type

type PDPNMSG_REMOVE_PLAYER_FROM_GROUP as DPNMSG_REMOVE_PLAYER_FROM_GROUP ptr

type DPNMSG_RETURN_BUFFER
	dwSize as DWORD
	hResultCode as HRESULT
	pvBuffer as PVOID
	pvUserContext as PVOID
end type

type PDPNMSG_RETURN_BUFFER as DPNMSG_RETURN_BUFFER ptr

type DPNMSG_SEND_COMPLETE
	dwSize as DWORD
	hAsyncOp as DPNHANDLE
	pvUserContext as PVOID
	hResultCode as HRESULT
	dwSendTime as DWORD
	dwFirstFrameRTT as DWORD
	dwFirstFrameRetryCount as DWORD
	dwSendCompleteFlags as DWORD
	pBuffers as DPN_BUFFER_DESC ptr
	dwNumBuffers as DWORD
end type

type PDPNMSG_SEND_COMPLETE as DPNMSG_SEND_COMPLETE ptr

type DPNMSG_SERVER_INFO
	dwSize as DWORD
	dpnidServer as DPNID
	pvPlayerContext as PVOID
end type

type PDPNMSG_SERVER_INFO as DPNMSG_SERVER_INFO ptr

type DPNMSG_TERMINATE_SESSION
	dwSize as DWORD
	hResultCode as HRESULT
	pvTerminateData as PVOID
	dwTerminateDataSize as DWORD
end type

type PDPNMSG_TERMINATE_SESSION as DPNMSG_TERMINATE_SESSION ptr

type DPNMSG_CREATE_THREAD
	dwSize as DWORD
	dwFlags as DWORD
	dwProcessorNum as DWORD
	pvUserContext as PVOID
end type

type PDPNMSG_CREATE_THREAD as DPNMSG_CREATE_THREAD ptr

type DPNMSG_DESTROY_THREAD
	dwSize as DWORD
	dwProcessorNum as DWORD
	pvUserContext as PVOID
end type

type PDPNMSG_DESTROY_THREAD as DPNMSG_DESTROY_THREAD ptr

type DPNMSG_NAT_RESOLVER_QUERY
	dwSize as DWORD
	pAddressSender as IDirectPlay8Address ptr
	pAddressDevice as IDirectPlay8Address ptr
	pwszUserString as WCHAR ptr
end type

type PDPNMSG_NAT_RESOLVER_QUERY as DPNMSG_NAT_RESOLVER_QUERY ptr

type IDirectPlay8ClientVtbl_ as IDirectPlay8ClientVtbl

type IDirectPlay8Client
	lpVtbl as IDirectPlay8ClientVtbl_ ptr
end type

type IDirectPlay8ClientVtbl
	QueryInterface as function(byval as IDirectPlay8Client ptr, byval as DP8REFIID, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlay8Client ptr) as ULONG
	Release as function(byval as IDirectPlay8Client ptr) as ULONG
	Initialize as function(byval as IDirectPlay8Client ptr, byval as PVOID, byval as PFNDPNMESSAGEHANDLER, byval as DWORD) as HRESULT
	EnumServiceProviders as function(byval as IDirectPlay8Client ptr, byval as GUID ptr, byval as GUID ptr, byval as DPN_SERVICE_PROVIDER_INFO ptr, byval as PDWORD, byval as PDWORD, byval as DWORD) as HRESULT
	EnumHosts as function(byval as IDirectPlay8Client ptr, byval as PDPN_APPLICATION_DESC, byval as IDirectPlay8Address ptr, byval as IDirectPlay8Address ptr, byval as PVOID, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	CancelAsyncOperation as function(byval as IDirectPlay8Client ptr, byval as DPNHANDLE, byval as DWORD) as HRESULT
	Connect as function(byval as IDirectPlay8Client ptr, byval as DPN_APPLICATION_DESC ptr, byval as IDirectPlay8Address ptr, byval as IDirectPlay8Address ptr, byval as DPN_SECURITY_DESC ptr, byval as DPN_SECURITY_CREDENTIALS ptr, byval as any ptr, byval as DWORD, byval as any ptr, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	Send as function(byval as IDirectPlay8Client ptr, byval as DPN_BUFFER_DESC ptr, byval as DWORD, byval as DWORD, byval as any ptr, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	GetSendQueueInfo as function(byval as IDirectPlay8Client ptr, byval as DWORD ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	GetApplicationDesc as function(byval as IDirectPlay8Client ptr, byval as DPN_APPLICATION_DESC ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	SetClientInfo as function(byval as IDirectPlay8Client ptr, byval as DPN_PLAYER_INFO ptr, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	GetServerInfo as function(byval as IDirectPlay8Client ptr, byval as DPN_PLAYER_INFO ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	GetServerAddress as function(byval as IDirectPlay8Client ptr, byval as IDirectPlay8Address ptr ptr, byval as DWORD) as HRESULT
	Close as function(byval as IDirectPlay8Client ptr, byval as DWORD) as HRESULT
	ReturnBuffer as function(byval as IDirectPlay8Client ptr, byval as DPNHANDLE, byval as DWORD) as HRESULT
	GetCaps as function(byval as IDirectPlay8Client ptr, byval as DPN_CAPS ptr, byval as DWORD) as HRESULT
	SetCaps as function(byval as IDirectPlay8Client ptr, byval as DPN_CAPS ptr, byval as DWORD) as HRESULT
	SetSPCaps as function(byval as IDirectPlay8Client ptr, byval as GUID ptr, byval as DPN_SP_CAPS ptr, byval as DWORD) as HRESULT
	GetSPCaps as function(byval as IDirectPlay8Client ptr, byval as GUID ptr, byval as DPN_SP_CAPS ptr, byval as DWORD) as HRESULT
	GetConnectionInfo as function(byval as IDirectPlay8Client ptr, byval as DPN_CONNECTION_INFO ptr, byval as DWORD) as HRESULT
	RegisterLobby as function(byval as IDirectPlay8Client ptr, byval as DPNHANDLE, byval as PDNLOBBIEDAPPLICATION, byval as DWORD) as HRESULT
end type

type IDirectPlay8ServerVtbl_ as IDirectPlay8ServerVtbl

type IDirectPlay8Server
	lpVtbl as IDirectPlay8ServerVtbl_ ptr
end type

type IDirectPlay8ServerVtbl
	QueryInterface as function(byval as IDirectPlay8Server ptr, byval as DP8REFIID, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlay8Server ptr) as ULONG
	Release as function(byval as IDirectPlay8Server ptr) as ULONG
	Initialize as function(byval as IDirectPlay8Server ptr, byval as PVOID, byval as PFNDPNMESSAGEHANDLER, byval as DWORD) as HRESULT
	EnumServiceProviders as function(byval as IDirectPlay8Server ptr, byval as GUID ptr, byval as GUID ptr, byval as DPN_SERVICE_PROVIDER_INFO ptr, byval as PDWORD, byval as PDWORD, byval as DWORD) as HRESULT
	CancelAsyncOperation as function(byval as IDirectPlay8Server ptr, byval as DPNHANDLE, byval as DWORD) as HRESULT
	GetSendQueueInfo as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as DWORD ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	GetApplicationDesc as function(byval as IDirectPlay8Server ptr, byval as DPN_APPLICATION_DESC ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	SetServerInfo as function(byval as IDirectPlay8Server ptr, byval as DPN_PLAYER_INFO ptr, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	GetClientInfo as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as DPN_PLAYER_INFO ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	GetClientAddress as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as IDirectPlay8Address ptr ptr, byval as DWORD) as HRESULT
	GetLocalHostAddresses as function(byval as IDirectPlay8Server ptr, byval as IDirectPlay8Address ptr ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	SetApplicationDesc as function(byval as IDirectPlay8Server ptr, byval as DPN_APPLICATION_DESC ptr, byval as DWORD) as HRESULT
	Host as function(byval as IDirectPlay8Server ptr, byval as DPN_APPLICATION_DESC ptr, byval as IDirectPlay8Address ptr ptr, byval as DWORD, byval as DPN_SECURITY_DESC ptr, byval as DPN_SECURITY_CREDENTIALS ptr, byval as any ptr, byval as DWORD) as HRESULT
	SendTo as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as DPN_BUFFER_DESC ptr, byval as DWORD, byval as DWORD, byval as any ptr, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	CreateGroup as function(byval as IDirectPlay8Server ptr, byval as DPN_GROUP_INFO ptr, byval as any ptr, byval as any ptr, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	DestroyGroup as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	AddPlayerToGroup as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as DPNID, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	RemovePlayerFromGroup as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as DPNID, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	SetGroupInfo as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as DPN_GROUP_INFO ptr, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	GetGroupInfo as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as DPN_GROUP_INFO ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	EnumPlayersAndGroups as function(byval as IDirectPlay8Server ptr, byval as DPNID ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	EnumGroupMembers as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as DPNID ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	Close as function(byval as IDirectPlay8Server ptr, byval as DWORD) as HRESULT
	DestroyClient as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
	ReturnBuffer as function(byval as IDirectPlay8Server ptr, byval as DPNHANDLE, byval as DWORD) as HRESULT
	GetPlayerContext as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as PVOID ptr, byval as DWORD) as HRESULT
	GetGroupContext as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as PVOID ptr, byval as DWORD) as HRESULT
	GetCaps as function(byval as IDirectPlay8Server ptr, byval as DPN_CAPS ptr, byval as DWORD) as HRESULT
	SetCaps as function(byval as IDirectPlay8Server ptr, byval as DPN_CAPS ptr, byval as DWORD) as HRESULT
	SetSPCaps as function(byval as IDirectPlay8Server ptr, byval as GUID ptr, byval as DPN_SP_CAPS ptr, byval as DWORD) as HRESULT
	GetSPCaps as function(byval as IDirectPlay8Server ptr, byval as GUID ptr, byval as DPN_SP_CAPS ptr, byval as DWORD) as HRESULT
	GetConnectionInfo as function(byval as IDirectPlay8Server ptr, byval as DPNID, byval as DPN_CONNECTION_INFO ptr, byval as DWORD) as HRESULT
	RegisterLobby as function(byval as IDirectPlay8Server ptr, byval as DPNHANDLE, byval as PDNLOBBIEDAPPLICATION, byval as DWORD) as HRESULT
end type

type IDirectPlay8PeerVtbl_ as IDirectPlay8PeerVtbl

type IDirectPlay8Peer
	lpVtbl as IDirectPlay8PeerVtbl_ ptr
end type

type IDirectPlay8PeerVtbl
	QueryInterface as function(byval as IDirectPlay8Peer ptr, byval as DP8REFIID, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlay8Peer ptr) as ULONG
	Release as function(byval as IDirectPlay8Peer ptr) as ULONG
	Initialize as function(byval as IDirectPlay8Peer ptr, byval as PVOID, byval as PFNDPNMESSAGEHANDLER, byval as DWORD) as HRESULT
	EnumServiceProviders as function(byval as IDirectPlay8Peer ptr, byval as GUID ptr, byval as GUID ptr, byval as DPN_SERVICE_PROVIDER_INFO ptr, byval as DWORD ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	CancelAsyncOperation as function(byval as IDirectPlay8Peer ptr, byval as DPNHANDLE, byval as DWORD) as HRESULT
	Connect as function(byval as IDirectPlay8Peer ptr, byval as DPN_APPLICATION_DESC ptr, byval as IDirectPlay8Address ptr, byval as IDirectPlay8Address ptr, byval as DPN_SECURITY_DESC ptr, byval as DPN_SECURITY_CREDENTIALS ptr, byval as any ptr, byval as DWORD, byval as any ptr, byval as any ptr, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	SendTo as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as DPN_BUFFER_DESC ptr, byval as DWORD, byval as DWORD, byval as any ptr, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	GetSendQueueInfo as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as DWORD ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	Host as function(byval as IDirectPlay8Peer ptr, byval as DPN_APPLICATION_DESC ptr, byval as IDirectPlay8Address ptr ptr, byval as DWORD, byval as DPN_SECURITY_DESC ptr, byval as DPN_SECURITY_CREDENTIALS ptr, byval as any ptr, byval as DWORD) as HRESULT
	GetApplicationDesc as function(byval as IDirectPlay8Peer ptr, byval as DPN_APPLICATION_DESC ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	SetApplicationDesc as function(byval as IDirectPlay8Peer ptr, byval as DPN_APPLICATION_DESC ptr, byval as DWORD) as HRESULT
	CreateGroup as function(byval as IDirectPlay8Peer ptr, byval as DPN_GROUP_INFO ptr, byval as any ptr, byval as any ptr, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	DestroyGroup as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	AddPlayerToGroup as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as DPNID, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	RemovePlayerFromGroup as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as DPNID, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	SetGroupInfo as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as DPN_GROUP_INFO ptr, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	GetGroupInfo as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as DPN_GROUP_INFO ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	EnumPlayersAndGroups as function(byval as IDirectPlay8Peer ptr, byval as DPNID ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	EnumGroupMembers as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as DPNID ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	SetPeerInfo as function(byval as IDirectPlay8Peer ptr, byval as DPN_PLAYER_INFO ptr, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	GetPeerInfo as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as DPN_PLAYER_INFO ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	GetPeerAddress as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as IDirectPlay8Address ptr ptr, byval as DWORD) as HRESULT
	GetLocalHostAddresses as function(byval as IDirectPlay8Peer ptr, byval as IDirectPlay8Address ptr ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	Close as function(byval as IDirectPlay8Peer ptr, byval as DWORD) as HRESULT
	EnumHosts as function(byval as IDirectPlay8Peer ptr, byval as PDPN_APPLICATION_DESC, byval as IDirectPlay8Address ptr, byval as IDirectPlay8Address ptr, byval as PVOID, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as PVOID, byval as DPNHANDLE ptr, byval as DWORD) as HRESULT
	DestroyPeer as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
	ReturnBuffer as function(byval as IDirectPlay8Peer ptr, byval as DPNHANDLE, byval as DWORD) as HRESULT
	GetPlayerContext as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as PVOID ptr, byval as DWORD) as HRESULT
	GetGroupContext as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as PVOID ptr, byval as DWORD) as HRESULT
	GetCaps as function(byval as IDirectPlay8Peer ptr, byval as DPN_CAPS ptr, byval as DWORD) as HRESULT
	SetCaps as function(byval as IDirectPlay8Peer ptr, byval as DPN_CAPS ptr, byval as DWORD) as HRESULT
	SetSPCaps as function(byval as IDirectPlay8Peer ptr, byval as GUID ptr, byval as DPN_SP_CAPS ptr, byval as DWORD) as HRESULT
	GetSPCaps as function(byval as IDirectPlay8Peer ptr, byval as GUID ptr, byval as DPN_SP_CAPS ptr, byval as DWORD) as HRESULT
	GetConnectionInfo as function(byval as IDirectPlay8Peer ptr, byval as DPNID, byval as DPN_CONNECTION_INFO ptr, byval as DWORD) as HRESULT
	RegisterLobby as function(byval as IDirectPlay8Peer ptr, byval as DPNHANDLE, byval as PDNLOBBIEDAPPLICATION, byval as DWORD) as HRESULT
	TerminateSession as function(byval as IDirectPlay8Peer ptr, byval as any ptr, byval as DWORD, byval as DWORD) as HRESULT
end type

type IDirectPlay8ThreadPoolVtbl_ as IDirectPlay8ThreadPoolVtbl

type IDirectPlay8ThreadPool
	lpVtbl as IDirectPlay8ThreadPoolVtbl_ ptr
end type

type IDirectPlay8ThreadPoolVtbl
	QueryInterface as function(byval as IDirectPlay8ThreadPool ptr, byval as DP8REFIID, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlay8ThreadPool ptr) as ULONG
	Release as function(byval as IDirectPlay8ThreadPool ptr) as ULONG
	Initialize as function(byval as IDirectPlay8ThreadPool ptr, byval as PVOID, byval as PFNDPNMESSAGEHANDLER, byval as DWORD) as HRESULT
	Close as function(byval as IDirectPlay8ThreadPool ptr, byval as DWORD) as HRESULT
	GetThreadCount as function(byval as IDirectPlay8ThreadPool ptr, byval as DWORD, byval as DWORD ptr, byval as DWORD) as HRESULT
	SetThreadCount as function(byval as IDirectPlay8ThreadPool ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	DoWork as function(byval as IDirectPlay8ThreadPool ptr, byval as DWORD, byval as DWORD) as HRESULT
end type

type IDirectPlay8NATResolverVtbl_ as IDirectPlay8NATResolverVtbl

type IDirectPlay8NATResolver
	lpVtbl as IDirectPlay8NATResolverVtbl_ ptr
end type

type IDirectPlay8NATResolverVtbl
	QueryInterface as function(byval as IDirectPlay8NATResolver ptr, byval as DP8REFIID, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectPlay8NATResolver ptr) as ULONG
	Release as function(byval as IDirectPlay8NATResolver ptr) as ULONG
	Initialize as function(byval as IDirectPlay8NATResolver ptr, byval as PVOID, byval as PFNDPNMESSAGEHANDLER, byval as DWORD) as HRESULT
	Start as function(byval as IDirectPlay8NATResolver ptr, byval as IDirectPlay8Address ptr ptr, byval as DWORD, byval as DWORD) as HRESULT
	Close as function(byval as IDirectPlay8NATResolver ptr, byval as DWORD) as HRESULT
	EnumDevices as function(byval as IDirectPlay8NATResolver ptr, byval as DPN_SERVICE_PROVIDER_INFO ptr, byval as PDWORD, byval as PDWORD, byval as DWORD) as HRESULT
	GetAddresses as function(byval as IDirectPlay8NATResolver ptr, byval as IDirectPlay8Address ptr ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
end type

#define IDirectPlay8Client_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlay8Client_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8Client_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8Client_Initialize(p,a,b,c) (p)->lpVtbl->Initialize(p,a,b,c)
#define IDirectPlay8Client_EnumServiceProviders(p,a,b,c,d,e,f) (p)->lpVtbl->EnumServiceProviders(p,a,b,c,d,e,f)
#define IDirectPlay8Client_EnumHosts(p,a,b,c,d,e,f,g,h,i,j,k) (p)->lpVtbl->EnumHosts(p,a,b,c,d,e,f,g,h,i,j,k)
#define IDirectPlay8Client_CancelAsyncOperation(p,a,b) (p)->lpVtbl->CancelAsyncOperation(p,a,b)
#define IDirectPlay8Client_Connect(p,a,b,c,d,e,f,g,h,i,j) (p)->lpVtbl->Connect(p,a,b,c,d,e,f,g,h,i,j)
#define IDirectPlay8Client_Send(p,a,b,c,d,e,f) (p)->lpVtbl->Send(p,a,b,c,d,e,f)
#define IDirectPlay8Client_GetSendQueueInfo(p,a,b,c) (p)->lpVtbl->GetSendQueueInfo(p,a,b,c)
#define IDirectPlay8Client_GetApplicationDesc(p,a,b,c) (p)->lpVtbl->GetApplicationDesc(p,a,b,c)
#define IDirectPlay8Client_SetClientInfo(p,a,b,c,d) (p)->lpVtbl->SetClientInfo(p,a,b,c,d)
#define IDirectPlay8Client_GetServerInfo(p,a,b,c) (p)->lpVtbl->GetServerInfo(p,a,b,c)
#define IDirectPlay8Client_GetServerAddress(p,a,b) (p)->lpVtbl->GetServerAddress(p,a,b)
#define IDirectPlay8Client_Close(p,a) (p)->lpVtbl->Close(p,a)
#define IDirectPlay8Client_ReturnBuffer(p,a,b) (p)->lpVtbl->ReturnBuffer(p,a,b)
#define IDirectPlay8Client_GetCaps(p,a,b) (p)->lpVtbl->GetCaps(p,a,b)
#define IDirectPlay8Client_SetCaps(p,a,b) (p)->lpVtbl->SetCaps(p,a,b)
#define IDirectPlay8Client_SetSPCaps(p,a,b,c) (p)->lpVtbl->SetSPCaps(p,a,b,c)
#define IDirectPlay8Client_GetSPCaps(p,a,b,c) (p)->lpVtbl->GetSPCaps(p,a,b,c)
#define IDirectPlay8Client_GetConnectionInfo(p,a,b) (p)->lpVtbl->GetConnectionInfo(p,a,b)
#define IDirectPlay8Client_RegisterLobby(p,a,b,c) (p)->lpVtbl->RegisterLobby(p,a,b,c)

#define IDirectPlay8Server_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlay8Server_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8Server_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8Server_Initialize(p,a,b,c) (p)->lpVtbl->Initialize(p,a,b,c)
#define IDirectPlay8Server_EnumServiceProviders(p,a,b,c,d,e,f) (p)->lpVtbl->EnumServiceProviders(p,a,b,c,d,e,f)
#define IDirectPlay8Server_CancelAsyncOperation(p,a,b) (p)->lpVtbl->CancelAsyncOperation(p,a,b)
#define IDirectPlay8Server_GetSendQueueInfo(p,a,b,c,d) (p)->lpVtbl->GetSendQueueInfo(p,a,b,c,d)
#define IDirectPlay8Server_GetApplicationDesc(p,a,b,c) (p)->lpVtbl->GetApplicationDesc(p,a,b,c)
#define IDirectPlay8Server_SetServerInfo(p,a,b,c,d) (p)->lpVtbl->SetServerInfo(p,a,b,c,d)
#define IDirectPlay8Server_GetClientInfo(p,a,b,c,d) (p)->lpVtbl->GetClientInfo(p,a,b,c,d)
#define IDirectPlay8Server_GetClientAddress(p,a,b,c) (p)->lpVtbl->GetClientAddress(p,a,b,c)
#define IDirectPlay8Server_GetLocalHostAddresses(p,a,b,c) (p)->lpVtbl->GetLocalHostAddresses(p,a,b,c)
#define IDirectPlay8Server_SetApplicationDesc(p,a,b) (p)->lpVtbl->SetApplicationDesc(p,a,b)
#define IDirectPlay8Server_Host(p,a,b,c,d,e,f,g) (p)->lpVtbl->Host(p,a,b,c,d,e,f,g)
#define IDirectPlay8Server_SendTo(p,a,b,c,d,e,f,g) (p)->lpVtbl->SendTo(p,a,b,c,d,e,f,g)
#define IDirectPlay8Server_CreateGroup(p,a,b,c,d,e) (p)->lpVtbl->CreateGroup(p,a,b,c,d,e)
#define IDirectPlay8Server_DestroyGroup(p,a,b,c,d) (p)->lpVtbl->DestroyGroup(p,a,b,c,d)
#define IDirectPlay8Server_AddPlayerToGroup(p,a,b,c,d,e) (p)->lpVtbl->AddPlayerToGroup(p,a,b,c,d,e)
#define IDirectPlay8Server_RemovePlayerFromGroup(p,a,b,c,d,e) (p)->lpVtbl->RemovePlayerFromGroup(p,a,b,c,d,e)
#define IDirectPlay8Server_SetGroupInfo(p,a,b,c,d,e) (p)->lpVtbl->SetGroupInfo(p,a,b,c,d,e)
#define IDirectPlay8Server_GetGroupInfo(p,a,b,c,d) (p)->lpVtbl->GetGroupInfo(p,a,b,c,d)
#define IDirectPlay8Server_EnumPlayersAndGroups(p,a,b,c) (p)->lpVtbl->EnumPlayersAndGroups(p,a,b,c)
#define IDirectPlay8Server_EnumGroupMembers(p,a,b,c,d) (p)->lpVtbl->EnumGroupMembers(p,a,b,c,d)
#define IDirectPlay8Server_Close(p,a) (p)->lpVtbl->Close(p,a)
#define IDirectPlay8Server_DestroyClient(p,a,b,c,d) (p)->lpVtbl->DestroyClient(p,a,b,c,d)
#define IDirectPlay8Server_ReturnBuffer(p,a,b) (p)->lpVtbl->ReturnBuffer(p,a,b)
#define IDirectPlay8Server_GetPlayerContext(p,a,b,c) (p)->lpVtbl->GetPlayerContext(p,a,b,c)
#define IDirectPlay8Server_GetGroupContext(p,a,b,c) (p)->lpVtbl->GetGroupContext(p,a,b,c)
#define IDirectPlay8Server_GetCaps(p,a,b) (p)->lpVtbl->GetCaps(p,a,b)
#define IDirectPlay8Server_SetCaps(p,a,b) (p)->lpVtbl->SetCaps(p,a,b)
#define IDirectPlay8Server_SetSPCaps(p,a,b,c) (p)->lpVtbl->SetSPCaps(p,a,b,c)
#define IDirectPlay8Server_GetSPCaps(p,a,b,c) (p)->lpVtbl->GetSPCaps(p,a,b,c)
#define IDirectPlay8Server_GetConnectionInfo(p,a,b,c) (p)->lpVtbl->GetConnectionInfo(p,a,b,c)
#define IDirectPlay8Server_RegisterLobby(p,a,b,c) (p)->lpVtbl->RegisterLobby(p,a,b,c)

#define IDirectPlay8Peer_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlay8Peer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8Peer_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8Peer_Initialize(p,a,b,c) (p)->lpVtbl->Initialize(p,a,b,c)
#define IDirectPlay8Peer_EnumServiceProviders(p,a,b,c,d,e,f) (p)->lpVtbl->EnumServiceProviders(p,a,b,c,d,e,f)
#define IDirectPlay8Peer_CancelAsyncOperation(p,a,b) (p)->lpVtbl->CancelAsyncOperation(p,a,b)
#define IDirectPlay8Peer_Connect(p,a,b,c,d,e,f,g,h,i,j,k) (p)->lpVtbl->Connect(p,a,b,c,d,e,f,g,h,i,j,k)
#define IDirectPlay8Peer_SendTo(p,a,b,c,d,e,f,g) (p)->lpVtbl->SendTo(p,a,b,c,d,e,f,g)
#define IDirectPlay8Peer_GetSendQueueInfo(p,a,b,c,d) (p)->lpVtbl->GetSendQueueInfo(p,a,b,c,d)
#define IDirectPlay8Peer_Host(p,a,b,c,d,e,f,g) (p)->lpVtbl->Host(p,a,b,c,d,e,f,g)
#define IDirectPlay8Peer_GetApplicationDesc(p,a,b,c) (p)->lpVtbl->GetApplicationDesc(p,a,b,c)
#define IDirectPlay8Peer_SetApplicationDesc(p,a,b) (p)->lpVtbl->SetApplicationDesc(p,a,b)
#define IDirectPlay8Peer_CreateGroup(p,a,b,c,d,e) (p)->lpVtbl->CreateGroup(p,a,b,c,d,e)
#define IDirectPlay8Peer_DestroyGroup(p,a,b,c,d) (p)->lpVtbl->DestroyGroup(p,a,b,c,d)
#define IDirectPlay8Peer_AddPlayerToGroup(p,a,b,c,d,e) (p)->lpVtbl->AddPlayerToGroup(p,a,b,c,d,e)
#define IDirectPlay8Peer_RemovePlayerFromGroup(p,a,b,c,d,e) (p)->lpVtbl->RemovePlayerFromGroup(p,a,b,c,d,e)
#define IDirectPlay8Peer_SetGroupInfo(p,a,b,c,d,e) (p)->lpVtbl->SetGroupInfo(p,a,b,c,d,e)
#define IDirectPlay8Peer_GetGroupInfo(p,a,b,c,d) (p)->lpVtbl->GetGroupInfo(p,a,b,c,d)
#define IDirectPlay8Peer_EnumPlayersAndGroups(p,a,b,c) (p)->lpVtbl->EnumPlayersAndGroups(p,a,b,c)
#define IDirectPlay8Peer_EnumGroupMembers(p,a,b,c,d) (p)->lpVtbl->EnumGroupMembers(p,a,b,c,d)
#define IDirectPlay8Peer_SetPeerInfo(p,a,b,c,d) (p)->lpVtbl->SetPeerInfo(p,a,b,c,d)
#define IDirectPlay8Peer_GetPeerInfo(p,a,b,c,d) (p)->lpVtbl->GetPeerInfo(p,a,b,c,d)
#define IDirectPlay8Peer_GetPeerAddress(p,a,b,c) (p)->lpVtbl->GetPeerAddress(p,a,b,c)
#define IDirectPlay8Peer_GetLocalHostAddresses(p,a,b,c) (p)->lpVtbl->GetLocalHostAddresses(p,a,b,c)
#define IDirectPlay8Peer_Close(p,a) (p)->lpVtbl->Close(p,a)
#define IDirectPlay8Peer_EnumHosts(p,a,b,c,d,e,f,g,h,i,j,k) (p)->lpVtbl->EnumHosts(p,a,b,c,d,e,f,g,h,i,j,k)
#define IDirectPlay8Peer_DestroyPeer(p,a,b,c,d) (p)->lpVtbl->DestroyPeer(p,a,b,c,d)
#define IDirectPlay8Peer_ReturnBuffer(p,a,b) (p)->lpVtbl->ReturnBuffer(p,a,b)
#define IDirectPlay8Peer_GetPlayerContext(p,a,b,c) (p)->lpVtbl->GetPlayerContext(p,a,b,c)
#define IDirectPlay8Peer_GetGroupContext(p,a,b,c) (p)->lpVtbl->GetGroupContext(p,a,b,c)
#define IDirectPlay8Peer_GetCaps(p,a,b) (p)->lpVtbl->GetCaps(p,a,b)
#define IDirectPlay8Peer_SetCaps(p,a,b) (p)->lpVtbl->SetCaps(p,a,b)
#define IDirectPlay8Peer_SetSPCaps(p,a,b,c) (p)->lpVtbl->SetSPCaps(p,a,b,c)
#define IDirectPlay8Peer_GetSPCaps(p,a,b,c) (p)->lpVtbl->GetSPCaps(p,a,b,c)
#define IDirectPlay8Peer_GetConnectionInfo(p,a,b,c) (p)->lpVtbl->GetConnectionInfo(p,a,b,c)
#define IDirectPlay8Peer_RegisterLobby(p,a,b,c) (p)->lpVtbl->RegisterLobby(p,a,b,c)
#define IDirectPlay8Peer_TerminateSession(p,a,b,c) (p)->lpVtbl->TerminateSession(p,a,b,c)

#define IDirectPlay8ThreadPool_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlay8ThreadPool_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8ThreadPool_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8ThreadPool_Initialize(p,a,b,c) (p)->lpVtbl->Initialize(p,a,b,c)
#define IDirectPlay8ThreadPool_Close(p,a) (p)->lpVtbl->Close(p,a)
#define IDirectPlay8ThreadPool_GetThreadCount(p,a,b,c) (p)->lpVtbl->GetThreadCount(p,a,b,c)
#define IDirectPlay8ThreadPool_SetThreadCount(p,a,b,c) (p)->lpVtbl->SetThreadCount(p,a,b,c)
#define IDirectPlay8ThreadPool_DoWork(p,a,b) (p)->lpVtbl->DoWork(p,a,b)

#define IDirectPlay8NATResolver_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IDirectPlay8NATResolver_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8NATResolver_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8NATResolver_Initialize(p,a,b,c) (p)->lpVtbl->Initialize(p,a,b,c)
#define IDirectPlay8NATResolver_Start(p,a,b,c) (p)->lpVtbl->Start(p,a,b,c)
#define IDirectPlay8NATResolver_Close(p,a) (p)->lpVtbl->Close(p,a)
#define IDirectPlay8NATResolver_EnumDevices(p,a,b,c,d) (p)->lpVtbl->EnumDevices(p,a,b,c,d)
#define IDirectPlay8NATResolver_GetAddresses(p,a,b,c) (p)->lpVtbl->GetAddresses(p,a,b,c)

#define _DPN_FACILITY_CODE &h015
#define _DPNHRESULT_BASE &h8000
#define MAKE_DPNHRESULT( code ) MAKE_HRESULT( 1, _DPN_FACILITY_CODE, ( code + _DPNHRESULT_BASE ) )

#define DPN_OK S_OK

#define DPNSUCCESS_EQUAL MAKE_HRESULT( 0, _DPN_FACILITY_CODE, ( &h5 + _DPNHRESULT_BASE ) )
#define DPNSUCCESS_NOPLAYERSINGROUP MAKE_HRESULT( 0, _DPN_FACILITY_CODE, ( &h8 + _DPNHRESULT_BASE ) )
#define DPNSUCCESS_NOTEQUAL MAKE_HRESULT( 0, _DPN_FACILITY_CODE, (&h0A + _DPNHRESULT_BASE ) )
#define DPNSUCCESS_PENDING MAKE_HRESULT( 0, _DPN_FACILITY_CODE, (&h0e + _DPNHRESULT_BASE ) )

#define DPNERR_ABORTED MAKE_DPNHRESULT( &h30 )
#define DPNERR_ADDRESSING MAKE_DPNHRESULT( &h40 )
#define DPNERR_ALREADYCLOSING MAKE_DPNHRESULT( &h50 )
#define DPNERR_ALREADYCONNECTED MAKE_DPNHRESULT( &h60 )
#define DPNERR_ALREADYDISCONNECTING MAKE_DPNHRESULT( &h70 )
#define DPNERR_ALREADYINITIALIZED MAKE_DPNHRESULT( &h80 )
#define DPNERR_ALREADYREGISTERED MAKE_DPNHRESULT( &h90 )
#define DPNERR_BUFFERTOOSMALL MAKE_DPNHRESULT( &h100 )
#define DPNERR_CANNOTCANCEL MAKE_DPNHRESULT( &h110 )
#define DPNERR_CANTCREATEGROUP MAKE_DPNHRESULT( &h120 )
#define DPNERR_CANTCREATEPLAYER MAKE_DPNHRESULT( &h130 )
#define DPNERR_CANTLAUNCHAPPLICATION MAKE_DPNHRESULT( &h140 )
#define DPNERR_CONNECTING MAKE_DPNHRESULT( &h150 )
#define DPNERR_CONNECTIONLOST MAKE_DPNHRESULT( &h160 )
#define DPNERR_CONVERSION MAKE_DPNHRESULT( &h170 )
#define DPNERR_DATATOOLARGE MAKE_DPNHRESULT( &h175 )
#define DPNERR_DOESNOTEXIST MAKE_DPNHRESULT( &h180 )
#define DPNERR_DPNSVRNOTAVAILABLE MAKE_DPNHRESULT( &h185 )
#define DPNERR_DUPLICATECOMMAND MAKE_DPNHRESULT( &h190 )
#define DPNERR_ENDPOINTNOTRECEIVING MAKE_DPNHRESULT( &h200 )
#define DPNERR_ENUMQUERYTOOLARGE MAKE_DPNHRESULT( &h210 )
#define DPNERR_ENUMRESPONSETOOLARGE MAKE_DPNHRESULT( &h220 )
#define DPNERR_EXCEPTION MAKE_DPNHRESULT( &h230 )
#define DPNERR_GENERIC E_FAIL
#define DPNERR_GROUPNOTEMPTY MAKE_DPNHRESULT( &h240 )
#define DPNERR_HOSTING MAKE_DPNHRESULT( &h250 )
#define DPNERR_HOSTREJECTEDCONNECTION MAKE_DPNHRESULT( &h260 )
#define DPNERR_HOSTTERMINATEDSESSION MAKE_DPNHRESULT( &h270 )
#define DPNERR_INCOMPLETEADDRESS MAKE_DPNHRESULT( &h280 )
#define DPNERR_INVALIDADDRESSFORMAT MAKE_DPNHRESULT( &h290 )
#define DPNERR_INVALIDAPPLICATION MAKE_DPNHRESULT( &h300 )
#define DPNERR_INVALIDCOMMAND MAKE_DPNHRESULT( &h310 )
#define DPNERR_INVALIDDEVICEADDRESS MAKE_DPNHRESULT( &h320 )
#define DPNERR_INVALIDENDPOINT MAKE_DPNHRESULT( &h330 )
#define DPNERR_INVALIDFLAGS MAKE_DPNHRESULT( &h340 )
#define DPNERR_INVALIDGROUP MAKE_DPNHRESULT( &h350 )
#define DPNERR_INVALIDHANDLE MAKE_DPNHRESULT( &h360 )
#define DPNERR_INVALIDHOSTADDRESS MAKE_DPNHRESULT( &h370 )
#define DPNERR_INVALIDINSTANCE MAKE_DPNHRESULT( &h380 )
#define DPNERR_INVALIDINTERFACE MAKE_DPNHRESULT( &h390 )
#define DPNERR_INVALIDOBJECT MAKE_DPNHRESULT( &h400 )
#define DPNERR_INVALIDPARAM E_INVALIDARG
#define DPNERR_INVALIDPASSWORD MAKE_DPNHRESULT( &h410 )
#define DPNERR_INVALIDPLAYER MAKE_DPNHRESULT( &h420 )
#define DPNERR_INVALIDPOINTER E_POINTER
#define DPNERR_INVALIDPRIORITY MAKE_DPNHRESULT( &h430 )
#define DPNERR_INVALIDSTRING MAKE_DPNHRESULT( &h440 )
#define DPNERR_INVALIDURL MAKE_DPNHRESULT( &h450 )
#define DPNERR_INVALIDVERSION MAKE_DPNHRESULT( &h460 )
#define DPNERR_NOCAPS MAKE_DPNHRESULT( &h470 )
#define DPNERR_NOCONNECTION MAKE_DPNHRESULT( &h480 )
#define DPNERR_NOHOSTPLAYER MAKE_DPNHRESULT( &h490 )
#define DPNERR_NOINTERFACE E_NOINTERFACE
#define DPNERR_NOMOREADDRESSCOMPONENTS MAKE_DPNHRESULT( &h500 )
#define DPNERR_NORESPONSE MAKE_DPNHRESULT( &h510 )
#define DPNERR_NOTALLOWED MAKE_DPNHRESULT( &h520 )
#define DPNERR_NOTHOST MAKE_DPNHRESULT( &h530 )
#define DPNERR_NOTREADY MAKE_DPNHRESULT( &h540 )
#define DPNERR_NOTREGISTERED MAKE_DPNHRESULT( &h550 )
#define DPNERR_OUTOFMEMORY E_OUTOFMEMORY
#define DPNERR_PENDING DPNSUCCESS_PENDING
#define DPNERR_PLAYERALREADYINGROUP MAKE_DPNHRESULT( &h560 )
#define DPNERR_PLAYERLOST MAKE_DPNHRESULT( &h570 )
#define DPNERR_PLAYERNOTINGROUP MAKE_DPNHRESULT( &h580 )
#define DPNERR_PLAYERNOTREACHABLE MAKE_DPNHRESULT( &h590 )
#define DPNERR_SENDTOOLARGE MAKE_DPNHRESULT( &h600 )
#define DPNERR_SESSIONFULL MAKE_DPNHRESULT( &h610 )
#define DPNERR_TABLEFULL MAKE_DPNHRESULT( &h620 )
#define DPNERR_TIMEDOUT MAKE_DPNHRESULT( &h630 )
#define DPNERR_UNINITIALIZED MAKE_DPNHRESULT( &h640 )
#define DPNERR_UNSUPPORTED E_NOTIMPL
#define DPNERR_USERCANCEL MAKE_DPNHRESULT( &h650 )

#endif
