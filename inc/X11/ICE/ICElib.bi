'' FreeBASIC binding for libICE-1.0.9
''
'' based on the C header files:
''   ****************************************************************************
''
''
''   Copyright 1993, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''
''   Author: Ralph Mor, X Consortium
''   *****************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/ICE/ICE.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _ICELIB_H_
type IcePointer as any ptr

type IcePoAuthStatus as long
enum
	IcePoAuthHaveReply
	IcePoAuthRejected
	IcePoAuthFailed
	IcePoAuthDoneCleanup
end enum

type IcePaAuthStatus as long
enum
	IcePaAuthContinue
	IcePaAuthAccepted
	IcePaAuthRejected
	IcePaAuthFailed
end enum

type IceConnectStatus as long
enum
	IceConnectPending
	IceConnectAccepted
	IceConnectRejected
	IceConnectIOError
end enum

type IceProtocolSetupStatus as long
enum
	IceProtocolSetupSuccess
	IceProtocolSetupFailure
	IceProtocolSetupIOError
	IceProtocolAlreadyActive
end enum

type IceAcceptStatus as long
enum
	IceAcceptSuccess
	IceAcceptFailure
	IceAcceptBadMalloc
end enum

type IceCloseStatus as long
enum
	IceClosedNow
	IceClosedASAP
	IceConnectionInUse
	IceStartedShutdownNegotiation
end enum

type IceProcessMessagesStatus as long
enum
	IceProcessMessagesSuccess
	IceProcessMessagesIOError
	IceProcessMessagesConnectionClosed
end enum

type IceReplyWaitInfo
	sequence_of_request as culong
	major_opcode_of_request as long
	minor_opcode_of_request as long
	reply as IcePointer
end type

type IceConn as _IceConn ptr
type IceListenObj as _IceListenObj ptr
type IceWatchProc as sub(byval as IceConn, byval as IcePointer, byval as long, byval as IcePointer ptr)
type IcePoProcessMsgProc as sub(byval as IceConn, byval as IcePointer, byval as long, byval as culong, byval as long, byval as IceReplyWaitInfo ptr, byval as long ptr)
type IcePaProcessMsgProc as sub(byval as IceConn, byval as IcePointer, byval as long, byval as culong, byval as long)

type IcePoVersionRec
	major_version as long
	minor_version as long
	process_msg_proc as IcePoProcessMsgProc
end type

type IcePaVersionRec
	major_version as long
	minor_version as long
	process_msg_proc as IcePaProcessMsgProc
end type

type IcePoAuthProc as function(byval as IceConn, byval as IcePointer ptr, byval as long, byval as long, byval as long, byval as IcePointer, byval as long ptr, byval as IcePointer ptr, byval as zstring ptr ptr) as IcePoAuthStatus
type IcePaAuthProc as function(byval as IceConn, byval as IcePointer ptr, byval as long, byval as long, byval as IcePointer, byval as long ptr, byval as IcePointer ptr, byval as zstring ptr ptr) as IcePaAuthStatus
type IceHostBasedAuthProc as function(byval as zstring ptr) as long
type IceProtocolSetupProc as function(byval as IceConn, byval as long, byval as long, byval as zstring ptr, byval as zstring ptr, byval as IcePointer ptr, byval as zstring ptr ptr) as long
type IceProtocolActivateProc as sub(byval as IceConn, byval as IcePointer)
type IceIOErrorProc as sub(byval as IceConn)
type IcePingReplyProc as sub(byval as IceConn, byval as IcePointer)
type IceErrorHandler as sub(byval as IceConn, byval as long, byval as long, byval as culong, byval as long, byval as long, byval as IcePointer)
type IceIOErrorHandler as sub(byval as IceConn)

declare function IceRegisterForProtocolSetup(byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as long, byval as IcePoVersionRec ptr, byval as long, byval as const zstring ptr ptr, byval as IcePoAuthProc ptr, byval as IceIOErrorProc) as long
declare function IceRegisterForProtocolReply(byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as long, byval as IcePaVersionRec ptr, byval as long, byval as const zstring ptr ptr, byval as IcePaAuthProc ptr, byval as IceHostBasedAuthProc, byval as IceProtocolSetupProc, byval as IceProtocolActivateProc, byval as IceIOErrorProc) as long
declare function IceOpenConnection(byval as zstring ptr, byval as IcePointer, byval as long, byval as long, byval as long, byval as zstring ptr) as IceConn
declare function IceGetConnectionContext(byval as IceConn) as IcePointer
declare function IceListenForConnections(byval as long ptr, byval as IceListenObj ptr ptr, byval as long, byval as zstring ptr) as long
declare function IceListenForWellKnownConnections(byval as zstring ptr, byval as long ptr, byval as IceListenObj ptr ptr, byval as long, byval as zstring ptr) as long
declare function IceGetListenConnectionNumber(byval as IceListenObj) as long
declare function IceGetListenConnectionString(byval as IceListenObj) as zstring ptr
declare function IceComposeNetworkIdList(byval as long, byval as IceListenObj ptr) as zstring ptr
declare sub IceFreeListenObjs(byval as long, byval as IceListenObj ptr)
declare sub IceSetHostBasedAuthProc(byval as IceListenObj, byval as IceHostBasedAuthProc)
declare function IceAcceptConnection(byval as IceListenObj, byval as IceAcceptStatus ptr) as IceConn
declare sub IceSetShutdownNegotiation(byval as IceConn, byval as long)
declare function IceCheckShutdownNegotiation(byval as IceConn) as long
declare function IceCloseConnection(byval as IceConn) as IceCloseStatus
declare function IceAddConnectionWatch(byval as IceWatchProc, byval as IcePointer) as long
declare sub IceRemoveConnectionWatch(byval as IceWatchProc, byval as IcePointer)
declare function IceProtocolSetup(byval as IceConn, byval as long, byval as IcePointer, byval as long, byval as long ptr, byval as long ptr, byval as zstring ptr ptr, byval as zstring ptr ptr, byval as long, byval as zstring ptr) as IceProtocolSetupStatus
declare function IceProtocolShutdown(byval as IceConn, byval as long) as long
declare function IceProcessMessages(byval as IceConn, byval as IceReplyWaitInfo ptr, byval as long ptr) as IceProcessMessagesStatus
declare function IcePing(byval as IceConn, byval as IcePingReplyProc, byval as IcePointer) as long
declare function IceAllocScratch(byval as IceConn, byval as culong) as zstring ptr
declare function IceFlush(byval as IceConn) as long
declare function IceGetOutBufSize(byval as IceConn) as long
declare function IceGetInBufSize(byval as IceConn) as long
declare function IceConnectionStatus(byval as IceConn) as IceConnectStatus
declare function IceVendor(byval as IceConn) as zstring ptr
declare function IceRelease(byval as IceConn) as zstring ptr
declare function IceProtocolVersion(byval as IceConn) as long
declare function IceProtocolRevision(byval as IceConn) as long
declare function IceConnectionNumber(byval as IceConn) as long
declare function IceConnectionString(byval as IceConn) as zstring ptr
declare function IceLastSentSequenceNumber(byval as IceConn) as culong
declare function IceLastReceivedSequenceNumber(byval as IceConn) as culong
declare function IceSwapping(byval as IceConn) as long
declare function IceSetErrorHandler(byval as IceErrorHandler) as IceErrorHandler
declare function IceSetIOErrorHandler(byval as IceIOErrorHandler) as IceIOErrorHandler
declare function IceGetPeerName(byval as IceConn) as zstring ptr
declare function IceInitThreads() as long
declare sub IceAppLockConn(byval as IceConn)
declare sub IceAppUnlockConn(byval as IceConn)

end extern
