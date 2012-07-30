''
''
'' ICElib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ICElib_bi__
#define __ICElib_bi__

#define True 1
#define False 0

type IcePointer as any ptr

enum IcePoAuthStatus
	IcePoAuthHaveReply
	IcePoAuthRejected
	IcePoAuthFailed
	IcePoAuthDoneCleanup
end enum


enum IcePaAuthStatus
	IcePaAuthContinue
	IcePaAuthAccepted
	IcePaAuthRejected
	IcePaAuthFailed
end enum


enum IceConnectStatus
	IceConnectPending
	IceConnectAccepted
	IceConnectRejected
	IceConnectIOError
end enum


enum IceProtocolSetupStatus
	IceProtocolSetupSuccess
	IceProtocolSetupFailure
	IceProtocolSetupIOError
	IceProtocolAlreadyActive
end enum


enum IceAcceptStatus
	IceAcceptSuccess
	IceAcceptFailure
	IceAcceptBadMalloc
end enum


enum IceCloseStatus
	IceClosedNow
	IceClosedASAP
	IceConnectionInUse
	IceStartedShutdownNegotiation
end enum


enum IceProcessMessagesStatus
	IceProcessMessagesSuccess
	IceProcessMessagesIOError
	IceProcessMessagesConnectionClosed
end enum


type IceReplyWaitInfo
	sequence_of_request as uinteger
	major_opcode_of_request as integer
	minor_opcode_of_request as integer
	reply as IcePointer
end type

type IceConn as _IceConn ptr
type IceListenObj as _IceListenObj ptr
type IceWatchProc as sub cdecl(byval as IceConn, byval as IcePointer, byval as integer, byval as IcePointer ptr)
type IcePoProcessMsgProc as sub cdecl(byval as IceConn, byval as IcePointer, byval as integer, byval as uinteger, byval as integer, byval as IceReplyWaitInfo ptr, byval as integer ptr)
type IcePaProcessMsgProc as sub cdecl(byval as IceConn, byval as IcePointer, byval as integer, byval as uinteger, byval as integer)

type IcePoVersionRec
	major_version as integer
	minor_version as integer
	process_msg_proc as IcePoProcessMsgProc
end type

type IcePaVersionRec
	major_version as integer
	minor_version as integer
	process_msg_proc as IcePaProcessMsgProc
end type

type IcePoAuthProc as function cdecl(byval as IceConn, byval as IcePointer ptr, byval as integer, byval as integer, byval as integer, byval as IcePointer, byval as integer ptr, byval as IcePointer ptr, byval as byte ptr ptr) as IcePoAuthStatus
type IcePaAuthProc as function cdecl(byval as IceConn, byval as IcePointer ptr, byval as integer, byval as integer, byval as IcePointer, byval as integer ptr, byval as IcePointer ptr, byval as byte ptr ptr) as IcePaAuthStatus
type IceHostBasedAuthProc as function cdecl(byval as zstring ptr) as integer
type IceProtocolSetupProc as function cdecl(byval as IceConn, byval as integer, byval as integer, byval as zstring ptr, byval as zstring ptr, byval as IcePointer ptr, byval as byte ptr ptr) as integer
type IceProtocolActivateProc as sub cdecl(byval as IceConn, byval as IcePointer)
type IceIOErrorProc as sub cdecl(byval as IceConn)
type IcePingReplyProc as sub cdecl(byval as IceConn, byval as IcePointer)
type IceErrorHandler as sub cdecl(byval as IceConn, byval as integer, byval as integer, byval as uinteger, byval as integer, byval as integer, byval as IcePointer)
type IceIOErrorHandler as sub cdecl(byval as IceConn)

declare function IceRegisterForProtocolReply cdecl alias "IceRegisterForProtocolReply" (byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as integer, byval as IcePaVersionRec ptr, byval as integer, byval as byte ptr ptr, byval as IcePaAuthProc ptr, byval as IceHostBasedAuthProc, byval as IceProtocolSetupProc, byval as IceProtocolActivateProc, byval as IceIOErrorProc) as integer
declare function IceOpenConnection cdecl alias "IceOpenConnection" (byval as zstring ptr, byval as IcePointer, byval as integer, byval as integer, byval as integer, byval as zstring ptr) as IceConn
declare function IceGetConnectionContext cdecl alias "IceGetConnectionContext" (byval as IceConn) as IcePointer
declare function IceListenForConnections cdecl alias "IceListenForConnections" (byval as integer ptr, byval as IceListenObj ptr ptr, byval as integer, byval as zstring ptr) as integer
declare function IceListenForWellKnownConnections cdecl alias "IceListenForWellKnownConnections" (byval as zstring ptr, byval as integer ptr, byval as IceListenObj ptr ptr, byval as integer, byval as zstring ptr) as integer
declare function IceGetListenConnectionNumber cdecl alias "IceGetListenConnectionNumber" (byval as IceListenObj) as integer
declare function IceGetListenConnectionString cdecl alias "IceGetListenConnectionString" (byval as IceListenObj) as zstring ptr
declare function IceComposeNetworkIdList cdecl alias "IceComposeNetworkIdList" (byval as integer, byval as IceListenObj ptr) as zstring ptr
declare sub IceFreeListenObjs cdecl alias "IceFreeListenObjs" (byval as integer, byval as IceListenObj ptr)
declare sub IceSetHostBasedAuthProc cdecl alias "IceSetHostBasedAuthProc" (byval as IceListenObj, byval as IceHostBasedAuthProc)
declare function IceAcceptConnection cdecl alias "IceAcceptConnection" (byval as IceListenObj, byval as IceAcceptStatus ptr) as IceConn
declare sub IceSetShutdownNegotiation cdecl alias "IceSetShutdownNegotiation" (byval as IceConn, byval as integer)
declare function IceCheckShutdownNegotiation cdecl alias "IceCheckShutdownNegotiation" (byval as IceConn) as integer
declare function IceCloseConnection cdecl alias "IceCloseConnection" (byval as IceConn) as IceCloseStatus
declare function IceAddConnectionWatch cdecl alias "IceAddConnectionWatch" (byval as IceWatchProc, byval as IcePointer) as integer
declare sub IceRemoveConnectionWatch cdecl alias "IceRemoveConnectionWatch" (byval as IceWatchProc, byval as IcePointer)
declare function IceProtocolSetup cdecl alias "IceProtocolSetup" (byval as IceConn, byval as integer, byval as IcePointer, byval as integer, byval as integer ptr, byval as integer ptr, byval as byte ptr ptr, byval as byte ptr ptr, byval as integer, byval as zstring ptr) as IceProtocolSetupStatus
declare function IceProtocolShutdown cdecl alias "IceProtocolShutdown" (byval as IceConn, byval as integer) as integer
declare function IceProcessMessages cdecl alias "IceProcessMessages" (byval as IceConn, byval as IceReplyWaitInfo ptr, byval as integer ptr) as IceProcessMessagesStatus
declare function IcePing cdecl alias "IcePing" (byval as IceConn, byval as IcePingReplyProc, byval as IcePointer) as integer
declare function IceAllocScratch cdecl alias "IceAllocScratch" (byval as IceConn, byval as uinteger) as zstring ptr
declare function IceFlush cdecl alias "IceFlush" (byval as IceConn) as integer
declare function IceGetOutBufSize cdecl alias "IceGetOutBufSize" (byval as IceConn) as integer
declare function IceGetInBufSize cdecl alias "IceGetInBufSize" (byval as IceConn) as integer
declare function IceConnectionStatus cdecl alias "IceConnectionStatus" (byval as IceConn) as IceConnectStatus
declare function IceVendor cdecl alias "IceVendor" (byval as IceConn) as zstring ptr
declare function IceRelease cdecl alias "IceRelease" (byval as IceConn) as zstring ptr
declare function IceProtocolVersion cdecl alias "IceProtocolVersion" (byval as IceConn) as integer
declare function IceProtocolRevision cdecl alias "IceProtocolRevision" (byval as IceConn) as integer
declare function IceConnectionNumber cdecl alias "IceConnectionNumber" (byval as IceConn) as integer
declare function IceConnectionString cdecl alias "IceConnectionString" (byval as IceConn) as zstring ptr
declare function IceLastSentSequenceNumber cdecl alias "IceLastSentSequenceNumber" (byval as IceConn) as uinteger
declare function IceLastReceivedSequenceNumber cdecl alias "IceLastReceivedSequenceNumber" (byval as IceConn) as uinteger
declare function IceSwapping cdecl alias "IceSwapping" (byval as IceConn) as integer
declare function IceSetErrorHandler cdecl alias "IceSetErrorHandler" (byval as IceErrorHandler) as IceErrorHandler
declare function IceSetIOErrorHandler cdecl alias "IceSetIOErrorHandler" (byval as IceIOErrorHandler) as IceIOErrorHandler
declare function IceGetPeerName cdecl alias "IceGetPeerName" (byval as IceConn) as zstring ptr
declare function IceInitThreads cdecl alias "IceInitThreads" () as integer
declare sub IceAppLockConn cdecl alias "IceAppLockConn" (byval as IceConn)
declare sub IceAppUnlockConn cdecl alias "IceAppUnlockConn" (byval as IceConn)

#endif
