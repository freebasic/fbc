#pragma once

#inclib "dxguid"

#include once "ole2.bi"
#include once "dpaddr.bi"

extern "Windows"

#define __WINE_DPLAY8_H
type PFNDPNMESSAGEHANDLER as function(byval as PVOID, byval as DWORD, byval as PVOID) as HRESULT
type DPNID as DWORD
type PDPNID as DWORD ptr
type DPNHANDLE as DWORD
type PDPNHANDLE as DWORD ptr

#define DPN_MSGID_OFFSET &hFFFF0000
#define DPN_MSGID_ADD_PLAYER_TO_GROUP (DPN_MSGID_OFFSET or &h0001)
#define DPN_MSGID_APPLICATION_DESC (DPN_MSGID_OFFSET or &h0002)
#define DPN_MSGID_ASYNC_OP_COMPLETE (DPN_MSGID_OFFSET or &h0003)
#define DPN_MSGID_CLIENT_INFO (DPN_MSGID_OFFSET or &h0004)
#define DPN_MSGID_CONNECT_COMPLETE (DPN_MSGID_OFFSET or &h0005)
#define DPN_MSGID_CREATE_GROUP (DPN_MSGID_OFFSET or &h0006)
#define DPN_MSGID_CREATE_PLAYER (DPN_MSGID_OFFSET or &h0007)
#define DPN_MSGID_DESTROY_GROUP (DPN_MSGID_OFFSET or &h0008)
#define DPN_MSGID_DESTROY_PLAYER (DPN_MSGID_OFFSET or &h0009)
#define DPN_MSGID_ENUM_HOSTS_QUERY (DPN_MSGID_OFFSET or &h000A)
#define DPN_MSGID_ENUM_HOSTS_RESPONSE (DPN_MSGID_OFFSET or &h000B)
#define DPN_MSGID_GROUP_INFO (DPN_MSGID_OFFSET or &h000C)
#define DPN_MSGID_HOST_MIGRATE (DPN_MSGID_OFFSET or &h000D)
#define DPN_MSGID_INDICATE_CONNECT (DPN_MSGID_OFFSET or &h000E)
#define DPN_MSGID_INDICATED_CONNECT_ABORTED (DPN_MSGID_OFFSET or &h000F)
#define DPN_MSGID_PEER_INFO (DPN_MSGID_OFFSET or &h0010)
#define DPN_MSGID_RECEIVE (DPN_MSGID_OFFSET or &h0011)
#define DPN_MSGID_REMOVE_PLAYER_FROM_GROUP (DPN_MSGID_OFFSET or &h0012)
#define DPN_MSGID_RETURN_BUFFER (DPN_MSGID_OFFSET or &h0013)
#define DPN_MSGID_SEND_COMPLETE (DPN_MSGID_OFFSET or &h0014)
#define DPN_MSGID_SERVER_INFO (DPN_MSGID_OFFSET or &h0015)
#define DPN_MSGID_TERMINATE_SESSION (DPN_MSGID_OFFSET or &h0016)
#define DPN_MSGID_CREATE_THREAD (DPN_MSGID_OFFSET or &h0017)
#define DPN_MSGID_DESTROY_THREAD (DPN_MSGID_OFFSET or &h0018)
#define DPN_MSGID_NAT_RESOLVER_QUERY (DPN_MSGID_OFFSET or &h0101)
#define _DPN_FACILITY_CODE &h015
#define _DPNHRESULT_BASE &h8000
#define MAKE_DPNHRESULT(code) MAKE_HRESULT(1, _DPN_FACILITY_CODE, code + _DPNHRESULT_BASE)
#define DPNSUCCESS_EQUAL MAKE_HRESULT(0, _DPN_FACILITY_CODE, &h05 + _DPNHRESULT_BASE)
#define DPNSUCCESS_NOTEQUAL MAKE_HRESULT(0, _DPN_FACILITY_CODE, &h0A + _DPNHRESULT_BASE)
#define DPNSUCCESS_PENDING MAKE_HRESULT(0, _DPN_FACILITY_CODE, &h0E + _DPNHRESULT_BASE)
#define DPN_OK S_OK
#define DPNERR_GENERIC E_FAIL
#define DPNERR_INVALIDPARAM E_INVALIDARG
#define DPNERR_UNSUPPORTED E_NOTIMPL
#define DPNERR_NOINTERFACE E_NOINTERFACE
#define DPNERR_OUTOFMEMORY E_OUTOFMEMORY
#define DPNERR_INVALIDPOINTER E_POINTER
#define DPNERR_PENDING DPNSUCCESS_PENDING
#define DPNERR_ABORTED MAKE_DPNHRESULT(&h030)
#define DPNERR_ADDRESSING MAKE_DPNHRESULT(&h040)
#define DPNERR_ALREADYCLOSING MAKE_DPNHRESULT(&h050)
#define DPNERR_ALREADYCONNECTED MAKE_DPNHRESULT(&h060)
#define DPNERR_ALREADYDISCONNECTING MAKE_DPNHRESULT(&h070)
#define DPNERR_ALREADYINITIALIZED MAKE_DPNHRESULT(&h080)
#define DPNERR_ALREADYREGISTERED MAKE_DPNHRESULT(&h090)
#define DPNERR_BUFFERTOOSMALL MAKE_DPNHRESULT(&h100)
#define DPNERR_CANNOTCANCEL MAKE_DPNHRESULT(&h110)
#define DPNERR_CANTCREATEGROUP MAKE_DPNHRESULT(&h120)
#define DPNERR_CANTCREATEPLAYER MAKE_DPNHRESULT(&h130)
#define DPNERR_CANTLAUNCHAPPLICATION MAKE_DPNHRESULT(&h140)
#define DPNERR_CONNECTING MAKE_DPNHRESULT(&h150)
#define DPNERR_CONNECTIONLOST MAKE_DPNHRESULT(&h160)
#define DPNERR_CONVERSION MAKE_DPNHRESULT(&h170)
#define DPNERR_DATATOOLARGE MAKE_DPNHRESULT(&h175)
#define DPNERR_DOESNOTEXIST MAKE_DPNHRESULT(&h180)
#define DPNERR_DPNSVRNOTAVAILABLE MAKE_DPNHRESULT(&h185)
#define DPNERR_DUPLICATECOMMAND MAKE_DPNHRESULT(&h190)
#define DPNERR_ENDPOINTNOTRECEIVING MAKE_DPNHRESULT(&h200)
#define DPNERR_ENUMQUERYTOOLARGE MAKE_DPNHRESULT(&h210)
#define DPNERR_ENUMRESPONSETOOLARGE MAKE_DPNHRESULT(&h220)
#define DPNERR_EXCEPTION MAKE_DPNHRESULT(&h230)
#define DPNERR_GROUPNOTEMPTY MAKE_DPNHRESULT(&h240)
#define DPNERR_HOSTING MAKE_DPNHRESULT(&h250)
#define DPNERR_HOSTREJECTEDCONNECTION MAKE_DPNHRESULT(&h260)
#define DPNERR_HOSTTERMINATEDSESSION MAKE_DPNHRESULT(&h270)
#define DPNERR_INCOMPLETEADDRESS MAKE_DPNHRESULT(&h280)
#define DPNERR_INVALIDADDRESSFORMAT MAKE_DPNHRESULT(&h290)
#define DPNERR_INVALIDAPPLICATION MAKE_DPNHRESULT(&h300)
#define DPNERR_INVALIDCOMMAND MAKE_DPNHRESULT(&h310)
#define DPNERR_INVALIDDEVICEADDRESS MAKE_DPNHRESULT(&h320)
#define DPNERR_INVALIDENDPOINT MAKE_DPNHRESULT(&h330)
#define DPNERR_INVALIDFLAGS MAKE_DPNHRESULT(&h340)
#define DPNERR_INVALIDGROUP MAKE_DPNHRESULT(&h350)
#define DPNERR_INVALIDHANDLE MAKE_DPNHRESULT(&h360)
#define DPNERR_INVALIDHOSTADDRESS MAKE_DPNHRESULT(&h370)
#define DPNERR_INVALIDINSTANCE MAKE_DPNHRESULT(&h380)
#define DPNERR_INVALIDINTERFACE MAKE_DPNHRESULT(&h390)
#define DPNERR_INVALIDOBJECT MAKE_DPNHRESULT(&h400)
#define DPNERR_INVALIDPASSWORD MAKE_DPNHRESULT(&h410)
#define DPNERR_INVALIDPLAYER MAKE_DPNHRESULT(&h420)
#define DPNERR_INVALIDPRIORITY MAKE_DPNHRESULT(&h430)
#define DPNERR_INVALIDSTRING MAKE_DPNHRESULT(&h440)
#define DPNERR_INVALIDURL MAKE_DPNHRESULT(&h450)
#define DPNERR_INVALIDVERSION MAKE_DPNHRESULT(&h460)
#define DPNERR_NOCAPS MAKE_DPNHRESULT(&h470)
#define DPNERR_NOCONNECTION MAKE_DPNHRESULT(&h480)
#define DPNERR_NOHOSTPLAYER MAKE_DPNHRESULT(&h490)
#define DPNERR_NOMOREADDRESSCOMPONENTS MAKE_DPNHRESULT(&h500)
#define DPNERR_NORESPONSE MAKE_DPNHRESULT(&h510)
#define DPNERR_NOTALLOWED MAKE_DPNHRESULT(&h520)
#define DPNERR_NOTHOST MAKE_DPNHRESULT(&h530)
#define DPNERR_NOTREADY MAKE_DPNHRESULT(&h540)
#define DPNERR_NOTREGISTERED MAKE_DPNHRESULT(&h550)
#define DPNERR_PLAYERALREADYINGROUP MAKE_DPNHRESULT(&h560)
#define DPNERR_PLAYERLOST MAKE_DPNHRESULT(&h570)
#define DPNERR_PLAYERNOTINGROUP MAKE_DPNHRESULT(&h580)
#define DPNERR_PLAYERNOTREACHABLE MAKE_DPNHRESULT(&h590)
#define DPNERR_SENDTOOLARGE MAKE_DPNHRESULT(&h600)
#define DPNERR_SESSIONFULL MAKE_DPNHRESULT(&h610)
#define DPNERR_TABLEFULL MAKE_DPNHRESULT(&h620)
#define DPNERR_TIMEDOUT MAKE_DPNHRESULT(&h630)
#define DPNERR_UNINITIALIZED MAKE_DPNHRESULT(&h640)
#define DPNERR_USERCANCEL MAKE_DPNHRESULT(&h650)
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
#define DPNADDPLAYERTOGROUP_SYNC DPNOP_SYNC
#define DPNCANCEL_CONNECT &h0001
#define DPNCANCEL_ENUM &h0002
#define DPNCANCEL_SEND &h0004
#define DPNCANCEL_ALL_OPERATIONS &h8000
#define DPNCANCEL_PLAYER_SENDS &h80000000
#define DPNCANCEL_PLAYER_SENDS_PRIORITY_HIGH (DPNCANCEL_PLAYER_SENDS or &h00010000)
#define DPNCANCEL_PLAYER_SENDS_PRIORITY_NORMAL (DPNCANCEL_PLAYER_SENDS or &h00020000)
#define DPNCANCEL_PLAYER_SENDS_PRIORITY_LOW (DPNCANCEL_PLAYER_SENDS or &h00040000)
#define DPNCLOSE_IMMEDIATE &h00000001
#define DPNCONNECT_SYNC DPNOP_SYNC
#define DPNCONNECT_OKTOQUERYFORADDRESSING &h0001
#define DPNCREATEGROUP_SYNC DPNOP_SYNC
#define DPNDESTROYGROUP_SYNC DPNOP_SYNC
#define DPNENUM_PLAYERS &h0001
#define DPNENUM_GROUPS &h0010
#define DPNENUMHOSTS_SYNC DPNOP_SYNC
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
#define DPNREMOVEPLAYERFROMGROUP_SYNC DPNOP_SYNC
#define DPNSEND_SYNC DPNOP_SYNC
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
#define DPNSETCLIENTINFO_SYNC DPNOP_SYNC
#define DPNSETGROUPINFO_SYNC DPNOP_SYNC
#define DPNSETPEERINFO_SYNC DPNOP_SYNC
#define DPNSETSERVERINFO_SYNC DPNOP_SYNC
#define DPNSPCAPS_SUPPORTSDPNSRV &h0001
#define DPNSPCAPS_SUPPORTSBROADCAST &h0002
#define DPNSPCAPS_SUPPORTSALLADAPTERS &h0004
#define DPNSPCAPS_SUPPORTSTHREADPOOL &h0008
#define DPNSPCAPS_NETWORKSIMULATOR &h0010
#define DPNSPINFO_NETWORKSIMULATORDEVICE &h0001

type _DPN_APPLICATION_DESC
	dwSize as DWORD
	dwFlags as DWORD
	guidInstance as GUID
	guidApplication as GUID
	dwMaxPlayers as DWORD
	dwCurrentPlayers as DWORD
	pwszSessionName as wstring ptr
	pwszPassword as wstring ptr
	pvReservedData as PVOID
	dwReservedDataSize as DWORD
	pvApplicationReservedData as PVOID
	dwApplicationReservedDataSize as DWORD
end type

type DPN_APPLICATION_DESC as _DPN_APPLICATION_DESC
type PDPN_APPLICATION_DESC as _DPN_APPLICATION_DESC ptr

type _BUFFERDESC
	dwBufferSize as DWORD
	pBufferData as UBYTE ptr
end type

type BUFFERDESC as _BUFFERDESC
type DPN_BUFFER_DESC as _BUFFERDESC
type PDPN_BUFFER_DESC as _BUFFERDESC ptr
type PBUFFERDESC as _BUFFERDESC ptr

type _DPN_CAPS
	dwSize as DWORD
	dwFlags as DWORD
	dwConnectTimeout as DWORD
	dwConnectRetries as DWORD
	dwTimeoutUntilKeepAlive as DWORD
end type

type DPN_CAPS as _DPN_CAPS
type PDPN_CAPS as _DPN_CAPS ptr

type _DPN_CAPS_EX
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

type DPN_CAPS_EX as _DPN_CAPS_EX
type PDPN_CAPS_EX as _DPN_CAPS_EX ptr

type _DPN_CONNECTION_INFO
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

type DPN_CONNECTION_INFO as _DPN_CONNECTION_INFO
type PDPN_CONNECTION_INFO as _DPN_CONNECTION_INFO ptr

type _DPN_GROUP_INFO
	dwSize as DWORD
	dwInfoFlags as DWORD
	pwszName as PWSTR
	pvData as PVOID
	dwDataSize as DWORD
	dwGroupFlags as DWORD
end type

type DPN_GROUP_INFO as _DPN_GROUP_INFO
type PDPN_GROUP_INFO as _DPN_GROUP_INFO ptr

type _DPN_PLAYER_INFO
	dwSize as DWORD
	dwInfoFlags as DWORD
	pwszName as PWSTR
	pvData as PVOID
	dwDataSize as DWORD
	dwPlayerFlags as DWORD
end type

type DPN_PLAYER_INFO as _DPN_PLAYER_INFO
type PDPN_PLAYER_INFO as _DPN_PLAYER_INFO ptr

type _DPN_SERVICE_PROVIDER_INFO
	dwFlags as DWORD
	guid as GUID
	pwszName as wstring ptr
	pvReserved as PVOID
	dwReserved as DWORD
end type

type DPN_SERVICE_PROVIDER_INFO as _DPN_SERVICE_PROVIDER_INFO
type PDPN_SERVICE_PROVIDER_INFO as _DPN_SERVICE_PROVIDER_INFO ptr

type _DPN_SP_CAPS
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

type DPN_SP_CAPS as _DPN_SP_CAPS
type PDPN_SP_CAPS as _DPN_SP_CAPS ptr
type DPN_SECURITY_CREDENTIALS as _DPN_SECURITY_CREDENTIALS
type PDPN_SECURITY_CREDENTIALS as _DPN_SECURITY_CREDENTIALS ptr
type DPN_SECURITY_DESC as _DPN_SECURITY_DESC
type PDPN_SECURITY_DESC as _DPN_SECURITY_DESC ptr

type _DPNMSG_ADD_PLAYER_TO_GROUP
	dwSize as DWORD
	dpnidGroup as DPNID
	pvGroupContext as PVOID
	dpnidPlayer as DPNID
	pvPlayerContext as PVOID
end type

type DPNMSG_ADD_PLAYER_TO_GROUP as _DPNMSG_ADD_PLAYER_TO_GROUP
type PDPNMSG_ADD_PLAYER_TO_GROUP as _DPNMSG_ADD_PLAYER_TO_GROUP ptr

type _DPNMSG_ASYNC_OP_COMPLETE
	dwSize as DWORD
	hAsyncOp as DPNHANDLE
	pvUserContext as PVOID
	hResultCode as HRESULT
end type

type DPNMSG_ASYNC_OP_COMPLETE as _DPNMSG_ASYNC_OP_COMPLETE
type PDPNMSG_ASYNC_OP_COMPLETE as _DPNMSG_ASYNC_OP_COMPLETE ptr

type _DPNMSG_CLIENT_INFO
	dwSize as DWORD
	dpnidClient as DPNID
	pvPlayerContext as PVOID
end type

type DPNMSG_CLIENT_INFO as _DPNMSG_CLIENT_INFO
type PDPNMSG_CLIENT_INFO as _DPNMSG_CLIENT_INFO ptr

type _DPNMSG_CONNECT_COMPLETE
	dwSize as DWORD
	hAsyncOp as DPNHANDLE
	pvUserContext as PVOID
	hResultCode as HRESULT
	pvApplicationReplyData as PVOID
	dwApplicationReplyDataSize as DWORD
	dpnidLocal as DPNID
end type

type DPNMSG_CONNECT_COMPLETE as _DPNMSG_CONNECT_COMPLETE
type PDPNMSG_CONNECT_COMPLETE as _DPNMSG_CONNECT_COMPLETE ptr

type _DPNMSG_CREATE_GROUP
	dwSize as DWORD
	dpnidGroup as DPNID
	dpnidOwner as DPNID
	pvGroupContext as PVOID
	pvOwnerContext as PVOID
end type

type DPNMSG_CREATE_GROUP as _DPNMSG_CREATE_GROUP
type PDPNMSG_CREATE_GROUP as _DPNMSG_CREATE_GROUP ptr

type _DPNMSG_CREATE_PLAYER
	dwSize as DWORD
	dpnidPlayer as DPNID
	pvPlayerContext as PVOID
end type

type DPNMSG_CREATE_PLAYER as _DPNMSG_CREATE_PLAYER
type PDPNMSG_CREATE_PLAYER as _DPNMSG_CREATE_PLAYER ptr

type _DPNMSG_DESTROY_GROUP
	dwSize as DWORD
	dpnidGroup as DPNID
	pvGroupContext as PVOID
	dwReason as DWORD
end type

type DPNMSG_DESTROY_GROUP as _DPNMSG_DESTROY_GROUP
type PDPNMSG_DESTROY_GROUP as _DPNMSG_DESTROY_GROUP ptr

type _DPNMSG_DESTROY_PLAYER
	dwSize as DWORD
	dpnidPlayer as DPNID
	pvPlayerContext as PVOID
	dwReason as DWORD
end type

type DPNMSG_DESTROY_PLAYER as _DPNMSG_DESTROY_PLAYER
type PDPNMSG_DESTROY_PLAYER as _DPNMSG_DESTROY_PLAYER ptr
type IDirectPlay8Address as IDirectPlay8Address_

type _DPNMSG_ENUM_HOSTS_QUERY
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

type DPNMSG_ENUM_HOSTS_QUERY as _DPNMSG_ENUM_HOSTS_QUERY
type PDPNMSG_ENUM_HOSTS_QUERY as _DPNMSG_ENUM_HOSTS_QUERY ptr

type _DPNMSG_ENUM_HOSTS_RESPONSE
	dwSize as DWORD
	pAddressSender as IDirectPlay8Address ptr
	pAddressDevice as IDirectPlay8Address ptr
	pApplicationDescription as const DPN_APPLICATION_DESC ptr
	pvResponseData as PVOID
	dwResponseDataSize as DWORD
	pvUserContext as PVOID
	dwRoundTripLatencyMS as DWORD
end type

type DPNMSG_ENUM_HOSTS_RESPONSE as _DPNMSG_ENUM_HOSTS_RESPONSE
type PDPNMSG_ENUM_HOSTS_RESPONSE as _DPNMSG_ENUM_HOSTS_RESPONSE ptr

type _DPNMSG_GROUP_INFO
	dwSize as DWORD
	dpnidGroup as DPNID
	pvGroupContext as PVOID
end type

type DPNMSG_GROUP_INFO as _DPNMSG_GROUP_INFO
type PDPNMSG_GROUP_INFO as _DPNMSG_GROUP_INFO ptr

type _DPNMSG_HOST_MIGRATE
	dwSize as DWORD
	dpnidNewHost as DPNID
	pvPlayerContext as PVOID
end type

type DPNMSG_HOST_MIGRATE as _DPNMSG_HOST_MIGRATE
type PDPNMSG_HOST_MIGRATE as _DPNMSG_HOST_MIGRATE ptr

type _DPNMSG_INDICATE_CONNECT
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

type DPNMSG_INDICATE_CONNECT as _DPNMSG_INDICATE_CONNECT
type PDPNMSG_INDICATE_CONNECT as _DPNMSG_INDICATE_CONNECT ptr

type _DPNMSG_INDICATED_CONNECT_ABORTED
	dwSize as DWORD
	pvPlayerContext as PVOID
end type

type DPNMSG_INDICATED_CONNECT_ABORTED as _DPNMSG_INDICATED_CONNECT_ABORTED
type PDPNMSG_INDICATED_CONNECT_ABORTED as _DPNMSG_INDICATED_CONNECT_ABORTED ptr

type _DPNMSG_PEER_INFO
	dwSize as DWORD
	dpnidPeer as DPNID
	pvPlayerContext as PVOID
end type

type DPNMSG_PEER_INFO as _DPNMSG_PEER_INFO
type PDPNMSG_PEER_INFO as _DPNMSG_PEER_INFO ptr

type _DPNMSG_RECEIVE
	dwSize as DWORD
	dpnidSender as DPNID
	pvPlayerContext as PVOID
	pReceiveData as PBYTE
	dwReceiveDataSize as DWORD
	hBufferHandle as DPNHANDLE
	dwReceiveFlags as DWORD
end type

type DPNMSG_RECEIVE as _DPNMSG_RECEIVE
type PDPNMSG_RECEIVE as _DPNMSG_RECEIVE ptr

type _DPNMSG_REMOVE_PLAYER_FROM_GROUP
	dwSize as DWORD
	dpnidGroup as DPNID
	pvGroupContext as PVOID
	dpnidPlayer as DPNID
	pvPlayerContext as PVOID
end type

type DPNMSG_REMOVE_PLAYER_FROM_GROUP as _DPNMSG_REMOVE_PLAYER_FROM_GROUP
type PDPNMSG_REMOVE_PLAYER_FROM_GROUP as _DPNMSG_REMOVE_PLAYER_FROM_GROUP ptr

type _DPNMSG_RETURN_BUFFER
	dwSize as DWORD
	hResultCode as HRESULT
	pvBuffer as PVOID
	pvUserContext as PVOID
end type

type DPNMSG_RETURN_BUFFER as _DPNMSG_RETURN_BUFFER
type PDPNMSG_RETURN_BUFFER as _DPNMSG_RETURN_BUFFER ptr

type _DPNMSG_SEND_COMPLETE
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

type DPNMSG_SEND_COMPLETE as _DPNMSG_SEND_COMPLETE
type PDPNMSG_SEND_COMPLETE as _DPNMSG_SEND_COMPLETE ptr

type _DPNMSG_SERVER_INFO
	dwSize as DWORD
	dpnidServer as DPNID
	pvPlayerContext as PVOID
end type

type DPNMSG_SERVER_INFO as _DPNMSG_SERVER_INFO
type PDPNMSG_SERVER_INFO as _DPNMSG_SERVER_INFO ptr

type _DPNMSG_TERMINATE_SESSION
	dwSize as DWORD
	hResultCode as HRESULT
	pvTerminateData as PVOID
	dwTerminateDataSize as DWORD
end type

type DPNMSG_TERMINATE_SESSION as _DPNMSG_TERMINATE_SESSION
type PDPNMSG_TERMINATE_SESSION as _DPNMSG_TERMINATE_SESSION ptr

type _DPNMSG_CREATE_THREAD
	dwSize as DWORD
	dwFlags as DWORD
	dwProcessorNum as DWORD
	pvUserContext as PVOID
end type

type DPNMSG_CREATE_THREAD as _DPNMSG_CREATE_THREAD
type PDPNMSG_CREATE_THREAD as _DPNMSG_CREATE_THREAD ptr

type _DPNMSG_DESTROY_THREAD
	dwSize as DWORD
	dwProcessorNum as DWORD
	pvUserContext as PVOID
end type

type DPNMSG_DESTROY_THREAD as _DPNMSG_DESTROY_THREAD
type PDPNMSG_DESTROY_THREAD as _DPNMSG_DESTROY_THREAD ptr

type _DPNMSG_NAT_RESOLVER_QUERY
	dwSize as DWORD
	pAddressSender as IDirectPlay8Address ptr
	pAddressDevice as IDirectPlay8Address ptr
	pwszUserString as wstring ptr
end type

type DPNMSG_NAT_RESOLVER_QUERY as _DPNMSG_NAT_RESOLVER_QUERY
type PDPNMSG_NAT_RESOLVER_QUERY as _DPNMSG_NAT_RESOLVER_QUERY ptr
extern CLSID_DirectPlay8Peer as const GUID
extern CLSID_DirectPlay8Client as const GUID
extern CLSID_DirectPlay8Server as const GUID
extern CLSID_DirectPlay8ThreadPool as const GUID
extern CLSID_DirectPlay8NATResolver as const GUID
extern IID_IDirectPlay8Peer as const GUID
type PDIRECTPLAY8PEER as IDirectPlay8Peer ptr
extern IID_IDirectPlay8Client as const GUID
type PDIRECTPLAY8CLIENT as IDirectPlay8Client ptr
extern IID_IDirectPlay8Server as const GUID
type PDIRECTPLAY8SERVER as IDirectPlay8Server ptr
extern IID_IDirectPlay8ThreadPool as const GUID
type PDIRECTPLAY8THREADPOOL as IDirectPlay8ThreadPool ptr
extern IID_IDirectPlay8NATResolver as const GUID
type PDIRECTPLAY8NATRESOLVER as IDirectPlay8NATResolver ptr
extern CLSID_DP8SP_IPX as const GUID
extern CLSID_DP8SP_TCPIP as const GUID
extern CLSID_DP8SP_SERIAL as const GUID
extern CLSID_DP8SP_MODEM as const GUID
extern CLSID_DP8SP_BLUETOOTH as const GUID

type IDirectPlay8LobbiedApplication as IDirectPlay8LobbiedApplication_
type PIDirectPlay8LobbiedApplication as IDirectPlay8LobbiedApplication ptr
type DNLOBBIEDAPPLICATION as IDirectPlay8LobbiedApplication
type IDirectPlay8ClientVtbl as IDirectPlay8ClientVtbl_

type IDirectPlay8Client
	lpVtbl as IDirectPlay8ClientVtbl ptr
end type

type IDirectPlay8ClientVtbl_
	QueryInterface as function(byval This as IDirectPlay8Client ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay8Client ptr) as ULONG
	Release as function(byval This as IDirectPlay8Client ptr) as ULONG
	Initialize as function(byval This as IDirectPlay8Client ptr, byval pvUserContext as const PVOID, byval pfn as const PFNDPNMESSAGEHANDLER, byval dwFlags as const DWORD) as HRESULT
	EnumServiceProviders as function(byval This as IDirectPlay8Client ptr, byval pguidServiceProvider as const GUID const ptr, byval pguidApplication as const GUID const ptr, byval pSPInfoBuffer as DPN_SERVICE_PROVIDER_INFO const ptr, byval pcbEnumData as const PDWORD, byval pcReturned as const PDWORD, byval dwFlags as const DWORD) as HRESULT
	EnumHosts as function(byval This as IDirectPlay8Client ptr, byval pApplicationDesc as const PDPN_APPLICATION_DESC, byval pAddrHost as IDirectPlay8Address const ptr, byval pDeviceInfo as IDirectPlay8Address const ptr, byval pUserEnumData as const PVOID, byval dwUserEnumDataSize as const DWORD, byval dwEnumCount as const DWORD, byval dwRetryInterval as const DWORD, byval dwTimeOut as const DWORD, byval pvUserContext as const PVOID, byval pAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	CancelAsyncOperation as function(byval This as IDirectPlay8Client ptr, byval hAsyncHandle as const DPNHANDLE, byval dwFlags as const DWORD) as HRESULT
	Connect as function(byval This as IDirectPlay8Client ptr, byval pdnAppDesc as const DPN_APPLICATION_DESC const ptr, byval pHostAddr as IDirectPlay8Address const ptr, byval pDeviceInfo as IDirectPlay8Address const ptr, byval pdnSecurity as const DPN_SECURITY_DESC const ptr, byval pdnCredentials as const DPN_SECURITY_CREDENTIALS const ptr, byval pvUserConnectData as const any const ptr, byval dwUserConnectDataSize as const DWORD, byval pvAsyncContext as any const ptr, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	Send as function(byval This as IDirectPlay8Client ptr, byval prgBufferDesc as const DPN_BUFFER_DESC const ptr, byval cBufferDesc as const DWORD, byval dwTimeOut as const DWORD, byval pvAsyncContext as any const ptr, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	GetSendQueueInfo as function(byval This as IDirectPlay8Client ptr, byval pdwNumMsgs as DWORD const ptr, byval pdwNumBytes as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	GetApplicationDesc as function(byval This as IDirectPlay8Client ptr, byval pAppDescBuffer as DPN_APPLICATION_DESC const ptr, byval pcbDataSize as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	SetClientInfo as function(byval This as IDirectPlay8Client ptr, byval pdpnPlayerInfo as const DPN_PLAYER_INFO const ptr, byval pvAsyncContext as const PVOID, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	GetServerInfo as function(byval This as IDirectPlay8Client ptr, byval pdpnPlayerInfo as DPN_PLAYER_INFO const ptr, byval pdwSize as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	GetServerAddress as function(byval This as IDirectPlay8Client ptr, byval pAddress as IDirectPlay8Address ptr const ptr, byval dwFlags as const DWORD) as HRESULT
	Close as function(byval This as IDirectPlay8Client ptr, byval dwFlags as const DWORD) as HRESULT
	ReturnBuffer as function(byval This as IDirectPlay8Client ptr, byval hBufferHandle as const DPNHANDLE, byval dwFlags as const DWORD) as HRESULT
	GetCaps as function(byval This as IDirectPlay8Client ptr, byval pdpCaps as DPN_CAPS const ptr, byval dwFlags as const DWORD) as HRESULT
	SetCaps as function(byval This as IDirectPlay8Client ptr, byval pdpCaps as const DPN_CAPS const ptr, byval dwFlags as const DWORD) as HRESULT
	SetSPCaps as function(byval This as IDirectPlay8Client ptr, byval pguidSP as const GUID const ptr, byval pdpspCaps as const DPN_SP_CAPS const ptr, byval dwFlags as const DWORD) as HRESULT
	GetSPCaps as function(byval This as IDirectPlay8Client ptr, byval pguidSP as const GUID const ptr, byval pdpspCaps as DPN_SP_CAPS const ptr, byval dwFlags as const DWORD) as HRESULT
	GetConnectionInfo as function(byval This as IDirectPlay8Client ptr, byval pdpConnectionInfo as DPN_CONNECTION_INFO const ptr, byval dwFlags as const DWORD) as HRESULT
	RegisterLobby as function(byval This as IDirectPlay8Client ptr, byval dpnHandle as const DPNHANDLE, byval pIDP8LobbiedApplication as IDirectPlay8LobbiedApplication const ptr, byval dwFlags as const DWORD) as HRESULT
end type

#define IDirectPlay8Client_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectPlay8Client_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8Client_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8Client_Initialize(p, a, b, c) (p)->lpVtbl->Initialize(p, a, b, c)
#define IDirectPlay8Client_EnumServiceProviders(p, a, b, c, d, e, f) (p)->lpVtbl->EnumServiceProviders(p, a, b, c, d, e, f)
#define IDirectPlay8Client_EnumHosts(p, a, b, c, d, e, f, g, h, i, j, k) (p)->lpVtbl->EnumHosts(p, a, b, c, d, e, f, g, h, i, j, k)
#define IDirectPlay8Client_CancelAsyncOperation(p, a, b) (p)->lpVtbl->CancelAsyncOperation(p, a, b)
#define IDirectPlay8Client_Connect(p, a, b, c, d, e, f, g, h, i, j) (p)->lpVtbl->Connect(p, a, b, c, d, e, f, g, h, i, j)
#define IDirectPlay8Client_Send(p, a, b, c, d, e, f) (p)->lpVtbl->Send(p, a, b, c, d, e, f)
#define IDirectPlay8Client_GetSendQueueInfo(p, a, b, c) (p)->lpVtbl->GetSendQueueInfo(p, a, b, c)
#define IDirectPlay8Client_GetApplicationDesc(p, a, b, c) (p)->lpVtbl->GetApplicationDesc(p, a, b, c)
#define IDirectPlay8Client_SetClientInfo(p, a, b, c, d) (p)->lpVtbl->SetClientInfo(p, a, b, c, d)
#define IDirectPlay8Client_GetServerInfo(p, a, b, c) (p)->lpVtbl->GetServerInfo(p, a, b, c)
#define IDirectPlay8Client_GetServerAddress(p, a, b) (p)->lpVtbl->GetServerAddress(p, a, b)
#define IDirectPlay8Client_Close(p, a) (p)->lpVtbl->Close(p, a)
#define IDirectPlay8Client_ReturnBuffer(p, a, b) (p)->lpVtbl->ReturnBuffer(p, a, b)
#define IDirectPlay8Client_GetCaps(p, a, b) (p)->lpVtbl->GetCaps(p, a, b)
#define IDirectPlay8Client_SetCaps(p, a, b) (p)->lpVtbl->SetCaps(p, a, b)
#define IDirectPlay8Client_SetSPCaps(p, a, b, c) (p)->lpVtbl->SetSPCaps(p, a, b, c)
#define IDirectPlay8Client_GetSPCaps(p, a, b, c) (p)->lpVtbl->GetSPCaps(p, a, b, c)
#define IDirectPlay8Client_GetConnectionInfo(p, a, b) (p)->lpVtbl->GetConnectionInfo(p, a, b)
#define IDirectPlay8Client_RegisterLobby(p, a, b, c) (p)->lpVtbl->RegisterLobby(p, a, b, c)
type IDirectPlay8ServerVtbl as IDirectPlay8ServerVtbl_

type IDirectPlay8Server
	lpVtbl as IDirectPlay8ServerVtbl ptr
end type

type IDirectPlay8ServerVtbl_
	QueryInterface as function(byval This as IDirectPlay8Server ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay8Server ptr) as ULONG
	Release as function(byval This as IDirectPlay8Server ptr) as ULONG
	Initialize as function(byval This as IDirectPlay8Server ptr, byval pvUserContext as const PVOID, byval pfn as const PFNDPNMESSAGEHANDLER, byval dwFlags as const DWORD) as HRESULT
	EnumServiceProviders as function(byval This as IDirectPlay8Server ptr, byval pguidServiceProvider as const GUID const ptr, byval pguidApplication as const GUID const ptr, byval pSPInfoBuffer as DPN_SERVICE_PROVIDER_INFO const ptr, byval pcbEnumData as const PDWORD, byval pcReturned as const PDWORD, byval dwFlags as const DWORD) as HRESULT
	CancelAsyncOperation as function(byval This as IDirectPlay8Server ptr, byval hAsyncHandle as const DPNHANDLE, byval dwFlags as const DWORD) as HRESULT
	GetSendQueueInfo as function(byval This as IDirectPlay8Server ptr, byval dpnid as const DPNID, byval pdwNumMsgs as DWORD const ptr, byval pdwNumBytes as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	GetApplicationDesc as function(byval This as IDirectPlay8Server ptr, byval pAppDescBuffer as DPN_APPLICATION_DESC const ptr, byval pcbDataSize as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	SetServerInfo as function(byval This as IDirectPlay8Server ptr, byval pdpnPlayerInfo as const DPN_PLAYER_INFO const ptr, byval pvAsyncContext as const PVOID, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	GetClientInfo as function(byval This as IDirectPlay8Server ptr, byval dpnid as const DPNID, byval pdpnPlayerInfo as DPN_PLAYER_INFO const ptr, byval pdwSize as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	GetClientAddress as function(byval This as IDirectPlay8Server ptr, byval dpnid as const DPNID, byval pAddress as IDirectPlay8Address ptr const ptr, byval dwFlags as const DWORD) as HRESULT
	GetLocalHostAddresses as function(byval This as IDirectPlay8Server ptr, byval prgpAddress as IDirectPlay8Address ptr const ptr, byval pcAddress as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	SetApplicationDesc as function(byval This as IDirectPlay8Server ptr, byval pad as const DPN_APPLICATION_DESC const ptr, byval dwFlags as const DWORD) as HRESULT
	Host as function(byval This as IDirectPlay8Server ptr, byval pdnAppDesc as const DPN_APPLICATION_DESC const ptr, byval prgpDeviceInfo as IDirectPlay8Address ptr const ptr, byval cDeviceInfo as const DWORD, byval pdnSecurity as const DPN_SECURITY_DESC const ptr, byval pdnCredentials as const DPN_SECURITY_CREDENTIALS const ptr, byval pvPlayerContext as any const ptr, byval dwFlags as const DWORD) as HRESULT
	SendTo as function(byval This as IDirectPlay8Server ptr, byval dpnid as const DPNID, byval prgBufferDesc as const DPN_BUFFER_DESC const ptr, byval cBufferDesc as const DWORD, byval dwTimeOut as const DWORD, byval pvAsyncContext as any const ptr, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	CreateGroup as function(byval This as IDirectPlay8Server ptr, byval pdpnGroupInfo as const DPN_GROUP_INFO const ptr, byval pvGroupContext as any const ptr, byval pvAsyncContext as any const ptr, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	DestroyGroup as function(byval This as IDirectPlay8Server ptr, byval idGroup as const DPNID, byval pvAsyncContext as const PVOID, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	AddPlayerToGroup as function(byval This as IDirectPlay8Server ptr, byval idGroup as const DPNID, byval idClient as const DPNID, byval pvAsyncContext as const PVOID, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	RemovePlayerFromGroup as function(byval This as IDirectPlay8Server ptr, byval idGroup as const DPNID, byval idClient as const DPNID, byval pvAsyncContext as const PVOID, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	SetGroupInfo as function(byval This as IDirectPlay8Server ptr, byval dpnid as const DPNID, byval pdpnGroupInfo as DPN_GROUP_INFO const ptr, byval pvAsyncContext as const PVOID, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	GetGroupInfo as function(byval This as IDirectPlay8Server ptr, byval dpnid as const DPNID, byval pdpnGroupInfo as DPN_GROUP_INFO const ptr, byval pdwSize as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	EnumPlayersAndGroups as function(byval This as IDirectPlay8Server ptr, byval prgdpnid as DPNID const ptr, byval pcdpnid as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	EnumGroupMembers as function(byval This as IDirectPlay8Server ptr, byval dpnid as const DPNID, byval prgdpnid as DPNID const ptr, byval pcdpnid as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	Close as function(byval This as IDirectPlay8Server ptr, byval dwFlags as const DWORD) as HRESULT
	DestroyClient as function(byval This as IDirectPlay8Server ptr, byval dpnidClient as const DPNID, byval pvDestroyData as const any const ptr, byval dwDestroyDataSize as const DWORD, byval dwFlags as const DWORD) as HRESULT
	ReturnBuffer as function(byval This as IDirectPlay8Server ptr, byval hBufferHandle as const DPNHANDLE, byval dwFlags as const DWORD) as HRESULT
	GetPlayerContext as function(byval This as IDirectPlay8Server ptr, byval dpnid as const DPNID, byval ppvPlayerContext as PVOID const ptr, byval dwFlags as const DWORD) as HRESULT
	GetGroupContext as function(byval This as IDirectPlay8Server ptr, byval dpnid as const DPNID, byval ppvGroupContext as PVOID const ptr, byval dwFlags as const DWORD) as HRESULT
	GetCaps as function(byval This as IDirectPlay8Server ptr, byval pdpCaps as DPN_CAPS const ptr, byval dwFlags as const DWORD) as HRESULT
	SetCaps as function(byval This as IDirectPlay8Server ptr, byval pdpCaps as const DPN_CAPS const ptr, byval dwFlags as const DWORD) as HRESULT
	SetSPCaps as function(byval This as IDirectPlay8Server ptr, byval pguidSP as const GUID const ptr, byval pdpspCaps as const DPN_SP_CAPS const ptr, byval dwFlags as const DWORD) as HRESULT
	GetSPCaps as function(byval This as IDirectPlay8Server ptr, byval pguidSP as const GUID const ptr, byval pdpspCaps as DPN_SP_CAPS const ptr, byval dwFlags as const DWORD) as HRESULT
	GetConnectionInfo as function(byval This as IDirectPlay8Server ptr, byval dpnid as const DPNID, byval pdpConnectionInfo as DPN_CONNECTION_INFO const ptr, byval dwFlags as const DWORD) as HRESULT
	RegisterLobby as function(byval This as IDirectPlay8Server ptr, byval dpnHandle as const DPNHANDLE, byval pIDP8LobbiedApplication as IDirectPlay8LobbiedApplication const ptr, byval dwFlags as const DWORD) as HRESULT
end type

#define IDirectPlay8Server_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectPlay8Server_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8Server_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8Server_Initialize(p, a, b, c) (p)->lpVtbl->Initialize(p, a, b, c)
#define IDirectPlay8Server_EnumServiceProviders(p, a, b, c, d, e, f) (p)->lpVtbl->EnumServiceProviders(p, a, b, c, d, e, f)
#define IDirectPlay8Server_CancelAsyncOperation(p, a, b) (p)->lpVtbl->CancelAsyncOperation(p, a, b)
#define IDirectPlay8Server_GetSendQueueInfo(p, a, b, c, d) (p)->lpVtbl->GetSendQueueInfo(p, a, b, c, d)
#define IDirectPlay8Server_GetApplicationDesc(p, a, b, c) (p)->lpVtbl->GetApplicationDesc(p, a, b, c)
#define IDirectPlay8Server_SetServerInfo(p, a, b, c, d) (p)->lpVtbl->SetServerInfo(p, a, b, c, d)
#define IDirectPlay8Server_GetClientInfo(p, a, b, c, d) (p)->lpVtbl->GetClientInfo(p, a, b, c, d)
#define IDirectPlay8Server_GetClientAddress(p, a, b, c) (p)->lpVtbl->GetClientAddress(p, a, b, c)
#define IDirectPlay8Server_GetLocalHostAddresses(p, a, b, c) (p)->lpVtbl->GetLocalHostAddresses(p, a, b, c)
#define IDirectPlay8Server_SetApplicationDesc(p, a, b) (p)->lpVtbl->SetApplicationDesc(p, a, b)
#define IDirectPlay8Server_Host(p, a, b, c, d, e, f, g) (p)->lpVtbl->Host(p, a, b, c, d, e, f, g)
#define IDirectPlay8Server_SendTo(p, a, b, c, d, e, f, g) (p)->lpVtbl->SendTo(p, a, b, c, d, e, f, g)
#define IDirectPlay8Server_CreateGroup(p, a, b, c, d, e) (p)->lpVtbl->CreateGroup(p, a, b, c, d, e)
#define IDirectPlay8Server_DestroyGroup(p, a, b, c, d) (p)->lpVtbl->DestroyGroup(p, a, b, c, d)
#define IDirectPlay8Server_AddPlayerToGroup(p, a, b, c, d, e) (p)->lpVtbl->AddPlayerToGroup(p, a, b, c, d, e)
#define IDirectPlay8Server_RemovePlayerFromGroup(p, a, b, c, d, e) (p)->lpVtbl->RemovePlayerFromGroup(p, a, b, c, d, e)
#define IDirectPlay8Server_SetGroupInfo(p, a, b, c, d, e) (p)->lpVtbl->SetGroupInfo(p, a, b, c, d, e)
#define IDirectPlay8Server_GetGroupInfo(p, a, b, c, d) (p)->lpVtbl->GetGroupInfo(p, a, b, c, d)
#define IDirectPlay8Server_EnumPlayersAndGroups(p, a, b, c) (p)->lpVtbl->EnumPlayersAndGroups(p, a, b, c)
#define IDirectPlay8Server_EnumGroupMembers(p, a, b, c, d) (p)->lpVtbl->EnumGroupMembers(p, a, b, c, d)
#define IDirectPlay8Server_Close(p, a) (p)->lpVtbl->Close(p, a)
#define IDirectPlay8Server_DestroyClient(p, a, b, c, d) (p)->lpVtbl->DestroyClient(p, a, b, c, d)
#define IDirectPlay8Server_ReturnBuffer(p, a, b) (p)->lpVtbl->ReturnBuffer(p, a, b)
#define IDirectPlay8Server_GetPlayerContext(p, a, b, c) (p)->lpVtbl->GetPlayerContext(p, a, b, c)
#define IDirectPlay8Server_GetGroupContext(p, a, b, c) (p)->lpVtbl->GetGroupContext(p, a, b, c)
#define IDirectPlay8Server_GetCaps(p, a, b) (p)->lpVtbl->GetCaps(p, a, b)
#define IDirectPlay8Server_SetCaps(p, a, b) (p)->lpVtbl->SetCaps(p, a, b)
#define IDirectPlay8Server_SetSPCaps(p, a, b, c) (p)->lpVtbl->SetSPCaps(p, a, b, c)
#define IDirectPlay8Server_GetSPCaps(p, a, b, c) (p)->lpVtbl->GetSPCaps(p, a, b, c)
#define IDirectPlay8Server_GetConnectionInfo(p, a, b, c) (p)->lpVtbl->GetConnectionInfo(p, a, b, c)
#define IDirectPlay8Server_RegisterLobby(p, a, b, c) (p)->lpVtbl->RegisterLobby(p, a, b, c)
type IDirectPlay8PeerVtbl as IDirectPlay8PeerVtbl_

type IDirectPlay8Peer
	lpVtbl as IDirectPlay8PeerVtbl ptr
end type

type IDirectPlay8PeerVtbl_
	QueryInterface as function(byval This as IDirectPlay8Peer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay8Peer ptr) as ULONG
	Release as function(byval This as IDirectPlay8Peer ptr) as ULONG
	Initialize as function(byval This as IDirectPlay8Peer ptr, byval pvUserContext as const PVOID, byval pfn as const PFNDPNMESSAGEHANDLER, byval dwFlags as const DWORD) as HRESULT
	EnumServiceProviders as function(byval This as IDirectPlay8Peer ptr, byval pguidServiceProvider as const GUID const ptr, byval pguidApplication as const GUID const ptr, byval pSPInfoBuffer as DPN_SERVICE_PROVIDER_INFO const ptr, byval pcbEnumData as DWORD const ptr, byval pcReturned as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	CancelAsyncOperation as function(byval This as IDirectPlay8Peer ptr, byval hAsyncHandle as const DPNHANDLE, byval dwFlags as const DWORD) as HRESULT
	Connect as function(byval This as IDirectPlay8Peer ptr, byval pdnAppDesc as const DPN_APPLICATION_DESC const ptr, byval pHostAddr as IDirectPlay8Address const ptr, byval pDeviceInfo as IDirectPlay8Address const ptr, byval pdnSecurity as const DPN_SECURITY_DESC const ptr, byval pdnCredentials as const DPN_SECURITY_CREDENTIALS const ptr, byval pvUserConnectData as const any const ptr, byval dwUserConnectDataSize as const DWORD, byval pvPlayerContext as any const ptr, byval pvAsyncContext as any const ptr, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	SendTo as function(byval This as IDirectPlay8Peer ptr, byval dpnid as const DPNID, byval prgBufferDesc as const DPN_BUFFER_DESC const ptr, byval cBufferDesc as const DWORD, byval dwTimeOut as const DWORD, byval pvAsyncContext as any const ptr, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	GetSendQueueInfo as function(byval This as IDirectPlay8Peer ptr, byval dpnid as const DPNID, byval pdwNumMsgs as DWORD const ptr, byval pdwNumBytes as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	Host as function(byval This as IDirectPlay8Peer ptr, byval pdnAppDesc as const DPN_APPLICATION_DESC const ptr, byval prgpDeviceInfo as IDirectPlay8Address ptr const ptr, byval cDeviceInfo as const DWORD, byval pdnSecurity as const DPN_SECURITY_DESC const ptr, byval pdnCredentials as const DPN_SECURITY_CREDENTIALS const ptr, byval pvPlayerContext as any const ptr, byval dwFlags as const DWORD) as HRESULT
	GetApplicationDesc as function(byval This as IDirectPlay8Peer ptr, byval pAppDescBuffer as DPN_APPLICATION_DESC const ptr, byval pcbDataSize as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	SetApplicationDesc as function(byval This as IDirectPlay8Peer ptr, byval pad as const DPN_APPLICATION_DESC const ptr, byval dwFlags as const DWORD) as HRESULT
	CreateGroup as function(byval This as IDirectPlay8Peer ptr, byval pdpnGroupInfo as const DPN_GROUP_INFO const ptr, byval pvGroupContext as any const ptr, byval pvAsyncContext as any const ptr, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	DestroyGroup as function(byval This as IDirectPlay8Peer ptr, byval idGroup as const DPNID, byval pvAsyncContext as const PVOID, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	AddPlayerToGroup as function(byval This as IDirectPlay8Peer ptr, byval idGroup as const DPNID, byval idClient as const DPNID, byval pvAsyncContext as const PVOID, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	RemovePlayerFromGroup as function(byval This as IDirectPlay8Peer ptr, byval idGroup as const DPNID, byval idClient as const DPNID, byval pvAsyncContext as const PVOID, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	SetGroupInfo as function(byval This as IDirectPlay8Peer ptr, byval dpnid as const DPNID, byval pdpnGroupInfo as DPN_GROUP_INFO const ptr, byval pvAsyncContext as const PVOID, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	GetGroupInfo as function(byval This as IDirectPlay8Peer ptr, byval dpnid as const DPNID, byval pdpnGroupInfo as DPN_GROUP_INFO const ptr, byval pdwSize as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	EnumPlayersAndGroups as function(byval This as IDirectPlay8Peer ptr, byval prgdpnid as DPNID const ptr, byval pcdpnid as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	EnumGroupMembers as function(byval This as IDirectPlay8Peer ptr, byval dpnid as const DPNID, byval prgdpnid as DPNID const ptr, byval pcdpnid as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	SetPeerInfo as function(byval This as IDirectPlay8Peer ptr, byval pdpnPlayerInfo as const DPN_PLAYER_INFO const ptr, byval pvAsyncContext as const PVOID, byval phAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	GetPeerInfo as function(byval This as IDirectPlay8Peer ptr, byval dpnid as const DPNID, byval pdpnPlayerInfo as DPN_PLAYER_INFO const ptr, byval pdwSize as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	GetPeerAddress as function(byval This as IDirectPlay8Peer ptr, byval dpnid as const DPNID, byval pAddress as IDirectPlay8Address ptr const ptr, byval dwFlags as const DWORD) as HRESULT
	GetLocalHostAddresses as function(byval This as IDirectPlay8Peer ptr, byval prgpAddress as IDirectPlay8Address ptr const ptr, byval pcAddress as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	Close as function(byval This as IDirectPlay8Peer ptr, byval dwFlags as const DWORD) as HRESULT
	EnumHosts as function(byval This as IDirectPlay8Peer ptr, byval pApplicationDesc as const PDPN_APPLICATION_DESC, byval pAddrHost as IDirectPlay8Address const ptr, byval pDeviceInfo as IDirectPlay8Address const ptr, byval pUserEnumData as const PVOID, byval dwUserEnumDataSize as const DWORD, byval dwEnumCount as const DWORD, byval dwRetryInterval as const DWORD, byval dwTimeOut as const DWORD, byval pvUserContext as const PVOID, byval pAsyncHandle as DPNHANDLE const ptr, byval dwFlags as const DWORD) as HRESULT
	DestroyPeer as function(byval This as IDirectPlay8Peer ptr, byval dpnidClient as const DPNID, byval pvDestroyData as const any const ptr, byval dwDestroyDataSize as const DWORD, byval dwFlags as const DWORD) as HRESULT
	ReturnBuffer as function(byval This as IDirectPlay8Peer ptr, byval hBufferHandle as const DPNHANDLE, byval dwFlags as const DWORD) as HRESULT
	GetPlayerContext as function(byval This as IDirectPlay8Peer ptr, byval dpnid as const DPNID, byval ppvPlayerContext as PVOID const ptr, byval dwFlags as const DWORD) as HRESULT
	GetGroupContext as function(byval This as IDirectPlay8Peer ptr, byval dpnid as const DPNID, byval ppvGroupContext as PVOID const ptr, byval dwFlags as const DWORD) as HRESULT
	GetCaps as function(byval This as IDirectPlay8Peer ptr, byval pdpCaps as DPN_CAPS const ptr, byval dwFlags as const DWORD) as HRESULT
	SetCaps as function(byval This as IDirectPlay8Peer ptr, byval pdpCaps as const DPN_CAPS const ptr, byval dwFlags as const DWORD) as HRESULT
	SetSPCaps as function(byval This as IDirectPlay8Peer ptr, byval pguidSP as const GUID const ptr, byval pdpspCaps as const DPN_SP_CAPS const ptr, byval dwFlags as const DWORD) as HRESULT
	GetSPCaps as function(byval This as IDirectPlay8Peer ptr, byval pguidSP as const GUID const ptr, byval pdpspCaps as DPN_SP_CAPS const ptr, byval dwFlags as const DWORD) as HRESULT
	GetConnectionInfo as function(byval This as IDirectPlay8Peer ptr, byval dpnid as const DPNID, byval pdpConnectionInfo as DPN_CONNECTION_INFO const ptr, byval dwFlags as const DWORD) as HRESULT
	RegisterLobby as function(byval This as IDirectPlay8Peer ptr, byval dpnHandle as const DPNHANDLE, byval pIDP8LobbiedApplication as IDirectPlay8LobbiedApplication const ptr, byval dwFlags as const DWORD) as HRESULT
	TerminateSession as function(byval This as IDirectPlay8Peer ptr, byval pvTerminateData as any const ptr, byval dwTerminateDataSize as const DWORD, byval dwFlags as const DWORD) as HRESULT
end type

#define IDirectPlay8Peer_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectPlay8Peer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8Peer_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8Peer_Initialize(p, a, b, c) (p)->lpVtbl->Initialize(p, a, b, c)
#define IDirectPlay8Peer_EnumServiceProviders(p, a, b, c, d, e, f) (p)->lpVtbl->EnumServiceProviders(p, a, b, c, d, e, f)
#define IDirectPlay8Peer_CancelAsyncOperation(p, a, b) (p)->lpVtbl->CancelAsyncOperation(p, a, b)
#define IDirectPlay8Peer_Connect(p, a, b, c, d, e, f, g, h, i, j, k) (p)->lpVtbl->Connect(p, a, b, c, d, e, f, g, h, i, j, k)
#define IDirectPlay8Peer_SendTo(p, a, b, c, d, e, f, g) (p)->lpVtbl->SendTo(p, a, b, c, d, e, f, g)
#define IDirectPlay8Peer_GetSendQueueInfo(p, a, b, c, d) (p)->lpVtbl->GetSendQueueInfo(p, a, b, c, d)
#define IDirectPlay8Peer_Host(p, a, b, c, d, e, f, g) (p)->lpVtbl->Host(p, a, b, c, d, e, f, g)
#define IDirectPlay8Peer_GetApplicationDesc(p, a, b, c) (p)->lpVtbl->GetApplicationDesc(p, a, b, c)
#define IDirectPlay8Peer_SetApplicationDesc(p, a, b) (p)->lpVtbl->SetApplicationDesc(p, a, b)
#define IDirectPlay8Peer_CreateGroup(p, a, b, c, d, e) (p)->lpVtbl->CreateGroup(p, a, b, c, d, e)
#define IDirectPlay8Peer_DestroyGroup(p, a, b, c, d) (p)->lpVtbl->DestroyGroup(p, a, b, c, d)
#define IDirectPlay8Peer_AddPlayerToGroup(p, a, b, c, d, e) (p)->lpVtbl->AddPlayerToGroup(p, a, b, c, d, e)
#define IDirectPlay8Peer_RemovePlayerFromGroup(p, a, b, c, d, e) (p)->lpVtbl->RemovePlayerFromGroup(p, a, b, c, d, e)
#define IDirectPlay8Peer_SetGroupInfo(p, a, b, c, d, e) (p)->lpVtbl->SetGroupInfo(p, a, b, c, d, e)
#define IDirectPlay8Peer_GetGroupInfo(p, a, b, c, d) (p)->lpVtbl->GetGroupInfo(p, a, b, c, d)
#define IDirectPlay8Peer_EnumPlayersAndGroups(p, a, b, c) (p)->lpVtbl->EnumPlayersAndGroups(p, a, b, c)
#define IDirectPlay8Peer_EnumGroupMembers(p, a, b, c, d) (p)->lpVtbl->EnumGroupMembers(p, a, b, c, d)
#define IDirectPlay8Peer_SetPeerInfo(p, a, b, c, d) (p)->lpVtbl->SetPeerInfo(p, a, b, c, d)
#define IDirectPlay8Peer_GetPeerInfo(p, a, b, c, d) (p)->lpVtbl->GetPeerInfo(p, a, b, c, d)
#define IDirectPlay8Peer_GetPeerAddress(p, a, b, c) (p)->lpVtbl->GetPeerAddress(p, a, b, c)
#define IDirectPlay8Peer_GetLocalHostAddresses(p, a, b, c) (p)->lpVtbl->GetLocalHostAddresses(p, a, b, c)
#define IDirectPlay8Peer_Close(p, a) (p)->lpVtbl->Close(p, a)
#define IDirectPlay8Peer_EnumHosts(p, a, b, c, d, e, f, g, h, i, j, k) (p)->lpVtbl->EnumHosts(p, a, b, c, d, e, f, g, h, i, j, k)
#define IDirectPlay8Peer_DestroyPeer(p, a, b, c, d) (p)->lpVtbl->DestroyPeer(p, a, b, c, d)
#define IDirectPlay8Peer_ReturnBuffer(p, a, b) (p)->lpVtbl->ReturnBuffer(p, a, b)
#define IDirectPlay8Peer_GetPlayerContext(p, a, b, c) (p)->lpVtbl->GetPlayerContext(p, a, b, c)
#define IDirectPlay8Peer_GetGroupContext(p, a, b, c) (p)->lpVtbl->GetGroupContext(p, a, b, c)
#define IDirectPlay8Peer_GetCaps(p, a, b) (p)->lpVtbl->GetCaps(p, a, b)
#define IDirectPlay8Peer_SetCaps(p, a, b) (p)->lpVtbl->SetCaps(p, a, b)
#define IDirectPlay8Peer_SetSPCaps(p, a, b, c) (p)->lpVtbl->SetSPCaps(p, a, b, c)
#define IDirectPlay8Peer_GetSPCaps(p, a, b, c) (p)->lpVtbl->GetSPCaps(p, a, b, c)
#define IDirectPlay8Peer_GetConnectionInfo(p, a, b, c) (p)->lpVtbl->GetConnectionInfo(p, a, b, c)
#define IDirectPlay8Peer_RegisterLobby(p, a, b, c) (p)->lpVtbl->RegisterLobby(p, a, b, c)
#define IDirectPlay8Peer_TerminateSession(p, a, b, c) (p)->lpVtbl->TerminateSession(p, a, b, c)
type IDirectPlay8ThreadPoolVtbl as IDirectPlay8ThreadPoolVtbl_

type IDirectPlay8ThreadPool
	lpVtbl as IDirectPlay8ThreadPoolVtbl ptr
end type

type IDirectPlay8ThreadPoolVtbl_
	QueryInterface as function(byval This as IDirectPlay8ThreadPool ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay8ThreadPool ptr) as ULONG
	Release as function(byval This as IDirectPlay8ThreadPool ptr) as ULONG
	Initialize as function(byval This as IDirectPlay8ThreadPool ptr, byval pvUserContext as const PVOID, byval pfn as const PFNDPNMESSAGEHANDLER, byval dwFlags as const DWORD) as HRESULT
	Close as function(byval This as IDirectPlay8ThreadPool ptr, byval dwFlags as const DWORD) as HRESULT
	GetThreadCount as function(byval This as IDirectPlay8ThreadPool ptr, byval dwProcessorNum as const DWORD, byval pdwNumThreads as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
	SetThreadCount as function(byval This as IDirectPlay8ThreadPool ptr, byval dwProcessorNum as const DWORD, byval dwNumThreads as const DWORD, byval dwFlags as const DWORD) as HRESULT
	DoWork as function(byval This as IDirectPlay8ThreadPool ptr, byval dwAllowedTimeSlice as const DWORD, byval dwFlags as const DWORD) as HRESULT
end type

#define IDirectPlay8ThreadPool_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectPlay8ThreadPool_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8ThreadPool_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8ThreadPool_Initialize(p, a, b, c) (p)->lpVtbl->Initialize(p, a, b, c)
#define IDirectPlay8ThreadPool_Close(p, a) (p)->lpVtbl->Close(p, a)
#define IDirectPlay8ThreadPool_GetThreadCount(p, a, b, c) (p)->lpVtbl->GetThreadCount(p, a, b, c)
#define IDirectPlay8ThreadPool_SetThreadCount(p, a, b, c) (p)->lpVtbl->SetThreadCount(p, a, b, c)
#define IDirectPlay8ThreadPool_DoWork(p, a, b) (p)->lpVtbl->DoWork(p, a, b)
type IDirectPlay8NATResolverVtbl as IDirectPlay8NATResolverVtbl_

type IDirectPlay8NATResolver
	lpVtbl as IDirectPlay8NATResolverVtbl ptr
end type

type IDirectPlay8NATResolverVtbl_
	QueryInterface as function(byval This as IDirectPlay8NATResolver ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectPlay8NATResolver ptr) as ULONG
	Release as function(byval This as IDirectPlay8NATResolver ptr) as ULONG
	Initialize as function(byval This as IDirectPlay8NATResolver ptr, byval pvUserContext as const PVOID, byval pfn as const PFNDPNMESSAGEHANDLER, byval dwFlags as const DWORD) as HRESULT
	Start as function(byval This as IDirectPlay8NATResolver ptr, byval ppDevices as IDirectPlay8Address ptr const ptr, byval dwNumDevices as const DWORD, byval dwFlags as const DWORD) as HRESULT
	Close as function(byval This as IDirectPlay8NATResolver ptr, byval dwFlags as const DWORD) as HRESULT
	EnumDevices as function(byval This as IDirectPlay8NATResolver ptr, byval pSPInfoBuffer as DPN_SERVICE_PROVIDER_INFO const ptr, byval pdwBufferSize as const PDWORD, byval pdwNumDevices as const PDWORD, byval dwFlags as const DWORD) as HRESULT
	GetAddresses as function(byval This as IDirectPlay8NATResolver ptr, byval ppAddresses as IDirectPlay8Address ptr const ptr, byval pdwNumAddresses as DWORD const ptr, byval dwFlags as const DWORD) as HRESULT
end type

#define IDirectPlay8NATResolver_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectPlay8NATResolver_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectPlay8NATResolver_Release(p) (p)->lpVtbl->Release(p)
#define IDirectPlay8NATResolver_Initialize(p, a, b, c) (p)->lpVtbl->Initialize(p, a, b, c)
#define IDirectPlay8NATResolver_Start(p, a, b, c) (p)->lpVtbl->Start(p, a, b, c)
#define IDirectPlay8NATResolver_Close(p, a) (p)->lpVtbl->Close(p, a)
#define IDirectPlay8NATResolver_EnumDevices(p, a, b, c, d) (p)->lpVtbl->EnumDevices(p, a, b, c, d)
#define IDirectPlay8NATResolver_GetAddresses(p, a, b, c) (p)->lpVtbl->GetAddresses(p, a, b, c)
declare function DirectPlay8Create(byval pcIID as const CLSID ptr, byval ppvInterface as LPVOID ptr, byval pUnknown as IUnknown ptr) as HRESULT

end extern
