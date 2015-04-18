'' FreeBASIC binding for libSM-1.2.2
''
'' based on the C header files:
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
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/SM/SM.bi"
#include once "X11/ICE/ICElib.bi"

extern "C"

#define _SMLIB_H_
type SmPointer as IcePointer
type SmcConn as _SmcConn ptr
type SmsConn as _SmsConn ptr

type SmPropValue
	length as long
	value as SmPointer
end type

type SmProp
	name as zstring ptr
	as zstring ptr type
	num_vals as long
	vals as SmPropValue ptr
end type

type SmcCloseStatus as long
enum
	SmcClosedNow
	SmcClosedASAP
	SmcConnectionInUse
end enum

type SmcSaveYourselfProc as sub(byval as SmcConn, byval as SmPointer, byval as long, byval as long, byval as long, byval as long)
type SmcSaveYourselfPhase2Proc as sub(byval as SmcConn, byval as SmPointer)
type SmcInteractProc as sub(byval as SmcConn, byval as SmPointer)
type SmcDieProc as sub(byval as SmcConn, byval as SmPointer)
type SmcShutdownCancelledProc as sub(byval as SmcConn, byval as SmPointer)
type SmcSaveCompleteProc as sub(byval as SmcConn, byval as SmPointer)
type SmcPropReplyProc as sub(byval as SmcConn, byval as SmPointer, byval as long, byval as SmProp ptr ptr)

type SmcCallbacks_save_yourself
	callback as SmcSaveYourselfProc
	client_data as SmPointer
end type

type SmcCallbacks_die
	callback as SmcDieProc
	client_data as SmPointer
end type

type SmcCallbacks_save_complete
	callback as SmcSaveCompleteProc
	client_data as SmPointer
end type

type SmcCallbacks_shutdown_cancelled
	callback as SmcShutdownCancelledProc
	client_data as SmPointer
end type

type SmcCallbacks
	save_yourself as SmcCallbacks_save_yourself
	die as SmcCallbacks_die
	save_complete as SmcCallbacks_save_complete
	shutdown_cancelled as SmcCallbacks_shutdown_cancelled
end type

const SmcSaveYourselfProcMask = cast(clong, 1) shl 0
const SmcDieProcMask = cast(clong, 1) shl 1
const SmcSaveCompleteProcMask = cast(clong, 1) shl 2
const SmcShutdownCancelledProcMask = cast(clong, 1) shl 3

type SmsRegisterClientProc as function(byval as SmsConn, byval as SmPointer, byval as zstring ptr) as long
type SmsInteractRequestProc as sub(byval as SmsConn, byval as SmPointer, byval as long)
type SmsInteractDoneProc as sub(byval as SmsConn, byval as SmPointer, byval as long)
type SmsSaveYourselfRequestProc as sub(byval as SmsConn, byval as SmPointer, byval as long, byval as long, byval as long, byval as long, byval as long)
type SmsSaveYourselfPhase2RequestProc as sub(byval as SmsConn, byval as SmPointer)
type SmsSaveYourselfDoneProc as sub(byval as SmsConn, byval as SmPointer, byval as long)
type SmsCloseConnectionProc as sub(byval as SmsConn, byval as SmPointer, byval as long, byval as zstring ptr ptr)
type SmsSetPropertiesProc as sub(byval as SmsConn, byval as SmPointer, byval as long, byval as SmProp ptr ptr)
type SmsDeletePropertiesProc as sub(byval as SmsConn, byval as SmPointer, byval as long, byval as zstring ptr ptr)
type SmsGetPropertiesProc as sub(byval as SmsConn, byval as SmPointer)

type SmsCallbacks_register_client
	callback as SmsRegisterClientProc
	manager_data as SmPointer
end type

type SmsCallbacks_interact_request
	callback as SmsInteractRequestProc
	manager_data as SmPointer
end type

type SmsCallbacks_interact_done
	callback as SmsInteractDoneProc
	manager_data as SmPointer
end type

type SmsCallbacks_save_yourself_request
	callback as SmsSaveYourselfRequestProc
	manager_data as SmPointer
end type

type SmsCallbacks_save_yourself_phase2_request
	callback as SmsSaveYourselfPhase2RequestProc
	manager_data as SmPointer
end type

type SmsCallbacks_save_yourself_done
	callback as SmsSaveYourselfDoneProc
	manager_data as SmPointer
end type

type SmsCallbacks_close_connection
	callback as SmsCloseConnectionProc
	manager_data as SmPointer
end type

type SmsCallbacks_set_properties
	callback as SmsSetPropertiesProc
	manager_data as SmPointer
end type

type SmsCallbacks_delete_properties
	callback as SmsDeletePropertiesProc
	manager_data as SmPointer
end type

type SmsCallbacks_get_properties
	callback as SmsGetPropertiesProc
	manager_data as SmPointer
end type

type SmsCallbacks
	register_client as SmsCallbacks_register_client
	interact_request as SmsCallbacks_interact_request
	interact_done as SmsCallbacks_interact_done
	save_yourself_request as SmsCallbacks_save_yourself_request
	save_yourself_phase2_request as SmsCallbacks_save_yourself_phase2_request
	save_yourself_done as SmsCallbacks_save_yourself_done
	close_connection as SmsCallbacks_close_connection
	set_properties as SmsCallbacks_set_properties
	delete_properties as SmsCallbacks_delete_properties
	get_properties as SmsCallbacks_get_properties
end type

const SmsRegisterClientProcMask = cast(clong, 1) shl 0
const SmsInteractRequestProcMask = cast(clong, 1) shl 1
const SmsInteractDoneProcMask = cast(clong, 1) shl 2
const SmsSaveYourselfRequestProcMask = cast(clong, 1) shl 3
const SmsSaveYourselfP2RequestProcMask = cast(clong, 1) shl 4
const SmsSaveYourselfDoneProcMask = cast(clong, 1) shl 5
const SmsCloseConnectionProcMask = cast(clong, 1) shl 6
const SmsSetPropertiesProcMask = cast(clong, 1) shl 7
const SmsDeletePropertiesProcMask = cast(clong, 1) shl 8
const SmsGetPropertiesProcMask = cast(clong, 1) shl 9

type SmsNewClientProc as function(byval as SmsConn, byval as SmPointer, byval as culong ptr, byval as SmsCallbacks ptr, byval as zstring ptr ptr) as long
type SmcErrorHandler as sub(byval as SmcConn, byval as long, byval as long, byval as culong, byval as long, byval as long, byval as SmPointer)
type SmsErrorHandler as sub(byval as SmsConn, byval as long, byval as long, byval as culong, byval as long, byval as long, byval as SmPointer)

declare function SmcOpenConnection(byval as zstring ptr, byval as SmPointer, byval as long, byval as long, byval as culong, byval as SmcCallbacks ptr, byval as const zstring ptr, byval as zstring ptr ptr, byval as long, byval as zstring ptr) as SmcConn
declare function SmcCloseConnection(byval as SmcConn, byval as long, byval as zstring ptr ptr) as SmcCloseStatus
declare sub SmcModifyCallbacks(byval as SmcConn, byval as culong, byval as SmcCallbacks ptr)
declare sub SmcSetProperties(byval as SmcConn, byval as long, byval as SmProp ptr ptr)
declare sub SmcDeleteProperties(byval as SmcConn, byval as long, byval as zstring ptr ptr)
declare function SmcGetProperties(byval as SmcConn, byval as SmcPropReplyProc, byval as SmPointer) as long
declare function SmcInteractRequest(byval as SmcConn, byval as long, byval as SmcInteractProc, byval as SmPointer) as long
declare sub SmcInteractDone(byval as SmcConn, byval as long)
declare sub SmcRequestSaveYourself(byval as SmcConn, byval as long, byval as long, byval as long, byval as long, byval as long)
declare function SmcRequestSaveYourselfPhase2(byval as SmcConn, byval as SmcSaveYourselfPhase2Proc, byval as SmPointer) as long
declare sub SmcSaveYourselfDone(byval as SmcConn, byval as long)
declare function SmcProtocolVersion(byval as SmcConn) as long
declare function SmcProtocolRevision(byval as SmcConn) as long
declare function SmcVendor(byval as SmcConn) as zstring ptr
declare function SmcRelease(byval as SmcConn) as zstring ptr
declare function SmcClientID(byval as SmcConn) as zstring ptr
declare function SmcGetIceConnection(byval as SmcConn) as IceConn
declare function SmsInitialize(byval as const zstring ptr, byval as const zstring ptr, byval as SmsNewClientProc, byval as SmPointer, byval as IceHostBasedAuthProc, byval as long, byval as zstring ptr) as long
declare function SmsClientHostName(byval as SmsConn) as zstring ptr
declare function SmsGenerateClientID(byval as SmsConn) as zstring ptr
declare function SmsRegisterClientReply(byval as SmsConn, byval as zstring ptr) as long
declare sub SmsSaveYourself(byval as SmsConn, byval as long, byval as long, byval as long, byval as long)
declare sub SmsSaveYourselfPhase2(byval as SmsConn)
declare sub SmsInteract(byval as SmsConn)
declare sub SmsDie(byval as SmsConn)
declare sub SmsSaveComplete(byval as SmsConn)
declare sub SmsShutdownCancelled(byval as SmsConn)
declare sub SmsReturnProperties(byval as SmsConn, byval as long, byval as SmProp ptr ptr)
declare sub SmsCleanUp(byval as SmsConn)
declare function SmsProtocolVersion(byval as SmsConn) as long
declare function SmsProtocolRevision(byval as SmsConn) as long
declare function SmsClientID(byval as SmsConn) as zstring ptr
declare function SmsGetIceConnection(byval as SmsConn) as IceConn
declare function SmcSetErrorHandler(byval as SmcErrorHandler) as SmcErrorHandler
declare function SmsSetErrorHandler(byval as SmsErrorHandler) as SmsErrorHandler
declare sub SmFreeProperty(byval as SmProp ptr)
declare sub SmFreeReasons(byval as long, byval as zstring ptr ptr)

end extern
