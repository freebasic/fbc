''
''
'' SMlib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SMlib_bi__
#define __SMlib_bi__

type SmPointer as IcePointer
type SmcConn as _SmcConn ptr
type SmsConn as _SmsConn ptr

type SmPropValue
	length as integer
	value as SmPointer
end type

type SmProp
	name as zstring ptr
	type as zstring ptr
	num_vals as integer
	vals as SmPropValue ptr
end type

enum SmcCloseStatus
	SmcClosedNow
	SmcClosedASAP
	SmcConnectionInUse
end enum

type SmcSaveYourselfProc as sub cdecl(byval as SmcConn, byval as SmPointer, byval as integer, byval as Bool, byval as integer, byval as Bool)
type SmcSaveYourselfPhase2Proc as sub cdecl(byval as SmcConn, byval as SmPointer)
type SmcInteractProc as sub cdecl(byval as SmcConn, byval as SmPointer)
type SmcDieProc as sub cdecl(byval as SmcConn, byval as SmPointer)
type SmcShutdownCancelledProc as sub cdecl(byval as SmcConn, byval as SmPointer)
type SmcSaveCompleteProc as sub cdecl(byval as SmcConn, byval as SmPointer)
type SmcPropReplyProc as sub cdecl(byval as SmcConn, byval as SmPointer, byval as integer, byval as SmProp ptr ptr)

type SmcCallbacks
	shutdown_cancelled as SmcCallbacks__NESTED__shutdown_cancelled
	save_complete as SmcCallbacks__NESTED__save_complete
	die as SmcCallbacks__NESTED__die
	save_yourself as SmcCallbacks__NESTED__save_yourself
end type

type SmcCallbacks__NESTED__shutdown_cancelled
	callback as SmcShutdownCancelledProc
	client_data as SmPointer
end type

type SmcCallbacks__NESTED__save_complete
	callback as SmcSaveCompleteProc
	client_data as SmPointer
end type

type SmcCallbacks__NESTED__die
	callback as SmcDieProc
	client_data as SmPointer
end type

type SmcCallbacks__NESTED__save_yourself
	callback as SmcSaveYourselfProc
	client_data as SmPointer
end type

#define SmcSaveYourselfProcMask (1L shl 0)
#define SmcDieProcMask (1L shl 1)
#define SmcSaveCompleteProcMask (1L shl 2)
#define SmcShutdownCancelledProcMask (1L shl 3)

type SmsRegisterClientProc as function cdecl(byval as SmsConn, byval as SmPointer, byval as zstring ptr) as Status
type SmsInteractRequestProc as sub cdecl(byval as SmsConn, byval as SmPointer, byval as integer)
type SmsInteractDoneProc as sub cdecl(byval as SmsConn, byval as SmPointer, byval as Bool)
type SmsSaveYourselfRequestProc as sub cdecl(byval as SmsConn, byval as SmPointer, byval as integer, byval as Bool, byval as integer, byval as Bool, byval as Bool)
type SmsSaveYourselfPhase2RequestProc as sub cdecl(byval as SmsConn, byval as SmPointer)
type SmsSaveYourselfDoneProc as sub cdecl(byval as SmsConn, byval as SmPointer, byval as Bool)
type SmsCloseConnectionProc as sub cdecl(byval as SmsConn, byval as SmPointer, byval as integer, byval as byte ptr ptr)
type SmsSetPropertiesProc as sub cdecl(byval as SmsConn, byval as SmPointer, byval as integer, byval as SmProp ptr ptr)
type SmsDeletePropertiesProc as sub cdecl(byval as SmsConn, byval as SmPointer, byval as integer, byval as byte ptr ptr)
type SmsGetPropertiesProc as sub cdecl(byval as SmsConn, byval as SmPointer)

type SmsCallbacks
	get_properties as SmsCallbacks__NESTED__get_properties
	delete_properties as SmsCallbacks__NESTED__delete_properties
	set_properties as SmsCallbacks__NESTED__set_properties
	close_connection as SmsCallbacks__NESTED__close_connection
	save_yourself_done as SmsCallbacks__NESTED__save_yourself_done
	save_yourself_phase2_request as SmsCallbacks__NESTED__save_yourself_phase2_request
	save_yourself_request as SmsCallbacks__NESTED__save_yourself_request
	interact_done as SmsCallbacks__NESTED__interact_done
	interact_request as SmsCallbacks__NESTED__interact_request
	register_client as SmsCallbacks__NESTED__register_client
end type

type SmsCallbacks__NESTED__get_properties
	callback as SmsGetPropertiesProc
	manager_data as SmPointer
end type

type SmsCallbacks__NESTED__delete_properties
	callback as SmsDeletePropertiesProc
	manager_data as SmPointer
end type

type SmsCallbacks__NESTED__set_properties
	callback as SmsSetPropertiesProc
	manager_data as SmPointer
end type

type SmsCallbacks__NESTED__close_connection
	callback as SmsCloseConnectionProc
	manager_data as SmPointer
end type

type SmsCallbacks__NESTED__save_yourself_done
	callback as SmsSaveYourselfDoneProc
	manager_data as SmPointer
end type

type SmsCallbacks__NESTED__save_yourself_phase2_request
	callback as SmsSaveYourselfPhase2RequestProc
	manager_data as SmPointer
end type

type SmsCallbacks__NESTED__save_yourself_request
	callback as SmsSaveYourselfRequestProc
	manager_data as SmPointer
end type

type SmsCallbacks__NESTED__interact_done
	callback as SmsInteractDoneProc
	manager_data as SmPointer
end type

type SmsCallbacks__NESTED__interact_request
	callback as SmsInteractRequestProc
	manager_data as SmPointer
end type

type SmsCallbacks__NESTED__register_client
	callback as SmsRegisterClientProc
	manager_data as SmPointer
end type

#define SmsRegisterClientProcMask (1L shl 0)
#define SmsInteractRequestProcMask (1L shl 1)
#define SmsInteractDoneProcMask (1L shl 2)
#define SmsSaveYourselfRequestProcMask (1L shl 3)
#define SmsSaveYourselfP2RequestProcMask (1L shl 4)
#define SmsSaveYourselfDoneProcMask (1L shl 5)
#define SmsCloseConnectionProcMask (1L shl 6)
#define SmsSetPropertiesProcMask (1L shl 7)
#define SmsDeletePropertiesProcMask (1L shl 8)
#define SmsGetPropertiesProcMask (1L shl 9)

type SmsNewClientProc as function cdecl(byval as SmsConn, byval as SmPointer, byval as uinteger ptr, byval as SmsCallbacks ptr, byval as byte ptr ptr) as Status
type SmcErrorHandler as sub cdecl(byval as SmcConn, byval as Bool, byval as integer, byval as uinteger, byval as integer, byval as integer, byval as SmPointer)
type SmsErrorHandler as sub cdecl(byval as SmsConn, byval as Bool, byval as integer, byval as uinteger, byval as integer, byval as integer, byval as SmPointer)

declare function SmcCloseConnection cdecl alias "SmcCloseConnection" (byval as SmcConn, byval as integer, byval as byte ptr ptr) as SmcCloseStatus
declare sub SmcModifyCallbacks cdecl alias "SmcModifyCallbacks" (byval as SmcConn, byval as uinteger, byval as SmcCallbacks ptr)
declare sub SmcSetProperties cdecl alias "SmcSetProperties" (byval as SmcConn, byval as integer, byval as SmProp ptr ptr)
declare sub SmcDeleteProperties cdecl alias "SmcDeleteProperties" (byval as SmcConn, byval as integer, byval as byte ptr ptr)
declare function SmcGetProperties cdecl alias "SmcGetProperties" (byval as SmcConn, byval as SmcPropReplyProc, byval as SmPointer) as Status
declare function SmcInteractRequest cdecl alias "SmcInteractRequest" (byval as SmcConn, byval as integer, byval as SmcInteractProc, byval as SmPointer) as Status
declare sub SmcInteractDone cdecl alias "SmcInteractDone" (byval as SmcConn, byval as Bool)
declare sub SmcRequestSaveYourself cdecl alias "SmcRequestSaveYourself" (byval as SmcConn, byval as integer, byval as Bool, byval as integer, byval as Bool, byval as Bool)
declare function SmcRequestSaveYourselfPhase2 cdecl alias "SmcRequestSaveYourselfPhase2" (byval as SmcConn, byval as SmcSaveYourselfPhase2Proc, byval as SmPointer) as Status
declare sub SmcSaveYourselfDone cdecl alias "SmcSaveYourselfDone" (byval as SmcConn, byval as Bool)
declare function SmcProtocolVersion cdecl alias "SmcProtocolVersion" (byval as SmcConn) as integer
declare function SmcProtocolRevision cdecl alias "SmcProtocolRevision" (byval as SmcConn) as integer
declare function SmcVendor cdecl alias "SmcVendor" (byval as SmcConn) as zstring ptr
declare function SmcRelease cdecl alias "SmcRelease" (byval as SmcConn) as zstring ptr
declare function SmcClientID cdecl alias "SmcClientID" (byval as SmcConn) as zstring ptr
declare function SmcGetIceConnection cdecl alias "SmcGetIceConnection" (byval as SmcConn) as IceConn
declare function SmsInitialize cdecl alias "SmsInitialize" (byval as zstring ptr, byval as zstring ptr, byval as SmsNewClientProc, byval as SmPointer, byval as IceHostBasedAuthProc, byval as integer, byval as zstring ptr) as Status
declare function SmsClientHostName cdecl alias "SmsClientHostName" (byval as SmsConn) as zstring ptr
declare function SmsGenerateClientID cdecl alias "SmsGenerateClientID" (byval as SmsConn) as zstring ptr
declare function SmsRegisterClientReply cdecl alias "SmsRegisterClientReply" (byval as SmsConn, byval as zstring ptr) as Status
declare sub SmsSaveYourself cdecl alias "SmsSaveYourself" (byval as SmsConn, byval as integer, byval as Bool, byval as integer, byval as Bool)
declare sub SmsSaveYourselfPhase2 cdecl alias "SmsSaveYourselfPhase2" (byval as SmsConn)
declare sub SmsInteract cdecl alias "SmsInteract" (byval as SmsConn)
declare sub SmsDie cdecl alias "SmsDie" (byval as SmsConn)
declare sub SmsSaveComplete cdecl alias "SmsSaveComplete" (byval as SmsConn)
declare sub SmsShutdownCancelled cdecl alias "SmsShutdownCancelled" (byval as SmsConn)
declare sub SmsReturnProperties cdecl alias "SmsReturnProperties" (byval as SmsConn, byval as integer, byval as SmProp ptr ptr)
declare sub SmsCleanUp cdecl alias "SmsCleanUp" (byval as SmsConn)
declare function SmsProtocolVersion cdecl alias "SmsProtocolVersion" (byval as SmsConn) as integer
declare function SmsProtocolRevision cdecl alias "SmsProtocolRevision" (byval as SmsConn) as integer
declare function SmsClientID cdecl alias "SmsClientID" (byval as SmsConn) as zstring ptr
declare function SmsGetIceConnection cdecl alias "SmsGetIceConnection" (byval as SmsConn) as IceConn
declare function SmcSetErrorHandler cdecl alias "SmcSetErrorHandler" (byval as SmcErrorHandler) as SmcErrorHandler
declare function SmsSetErrorHandler cdecl alias "SmsSetErrorHandler" (byval as SmsErrorHandler) as SmsErrorHandler
declare sub SmFreeProperty cdecl alias "SmFreeProperty" (byval as SmProp ptr)
declare sub SmFreeReasons cdecl alias "SmFreeReasons" (byval as integer, byval as byte ptr ptr)

#endif
