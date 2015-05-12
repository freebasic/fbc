''
''
'' ICEconn -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ICEconn_bi__
#define __ICEconn_bi__

type _IceSavedReplyWait
	reply_wait as IceReplyWaitInfo ptr
	reply_ready as Bool
	next as _IceSavedReplyWait ptr
end type

type _IceSavedReplyWait as any

type _IcePingWait
	ping_reply_proc as IcePingReplyProc
	client_data as IcePointer
	next as _IcePingWait ptr
end type

type _IcePingWait as any

type _IcePoProtocol
	vendor as zstring ptr
	release as zstring ptr
	version_count as integer
	version_recs as IcePoVersionRec ptr
	auth_count as integer
	auth_names as byte ptr ptr
	auth_procs as IcePoAuthProc ptr
	io_error_proc as IceIOErrorProc
end type

type _IcePaProtocol
	vendor as zstring ptr
	release as zstring ptr
	version_count as integer
	version_recs as IcePaVersionRec ptr
	protocol_setup_proc as IceProtocolSetupProc
	protocol_activate_proc as IceProtocolActivateProc
	auth_count as integer
	auth_names as byte ptr ptr
	auth_procs as IcePaAuthProc ptr
	host_based_auth_proc as IceHostBasedAuthProc
	io_error_proc as IceIOErrorProc
end type

type _IceProtocol
	protocol_name as zstring ptr
	orig_client as _IcePoProtocol ptr
	accept_client as _IcePaProtocol ptr
end type

type _IceProcessMsgInfo
	in_use as Bool
	my_opcode as integer
	protocol as _IceProtocol ptr
	client_data as IcePointer
	accept_flag as Bool
	process_msg_proc as _IceProcessMsgInfo__NESTED__process_msg_proc
end type

union _IceProcessMsgInfo__NESTED__process_msg_proc
	accept_client as IcePaProcessMsgProc
	orig_client as IcePoProcessMsgProc
end union

type _IceConnectToMeInfo
	his_version_index as integer
	my_version_index as integer
	his_vendor as zstring ptr
	his_release as zstring ptr
	my_auth_index as byte
	my_auth_state as IcePointer
	must_authenticate as Bool
end type

type _IceProtoSetupToMeInfo
	his_opcode as integer
	my_opcode as integer
	his_version_index as integer
	my_version_index as integer
	his_vendor as zstring ptr
	his_release as zstring ptr
	my_auth_index as byte
	my_auth_state as IcePointer
	must_authenticate as Bool
end type

type _IceConnectToYouInfo
	auth_active as Bool
	my_auth_index as byte
	my_auth_state as IcePointer
end type

type _IceProtoSetupToYouInfo
	my_opcode as integer
	my_auth_count as integer
	my_auth_indices as integer ptr
	auth_active as Bool
	my_auth_index as byte
	my_auth_state as IcePointer
end type

type _IceConn
	io_ok:1 as uinteger
	swap:1 as uinteger
	waiting_for_byteorder:1 as uinteger
	skip_want_to_close:1 as uinteger
	want_to_close:1 as uinteger
	free_asap:1 as uinteger
	unused1:2 as uinteger
	unused2:8 as uinteger
	connection_status as IceConnectStatus
	my_ice_version_index as ubyte
	trans_conn as _XtransConnInfo ptr
	send_sequence as uinteger
	receive_sequence as uinteger
	connection_string as zstring ptr
	vendor as zstring ptr
	release as zstring ptr
	inbuf as zstring ptr
	inbufptr as zstring ptr
	inbufmax as zstring ptr
	outbuf as zstring ptr
	outbufptr as zstring ptr
	outbufmax as zstring ptr
	scratch as zstring ptr
	scratch_size as uinteger
	dispatch_level as integer
	context as IcePointer
	process_msg_info as _IceProcessMsgInfo ptr
	his_min_opcode as byte
	his_max_opcode as byte
	open_ref_count as ubyte
	proto_ref_count as ubyte
	listen_obj as IceListenObj
	saved_reply_waits as _IceSavedReplyWait ptr
	ping_waits as _IcePingWait ptr
	connect_to_you as _IceConnectToYouInfo ptr
	protosetup_to_you as _IceProtoSetupToYouInfo ptr
	connect_to_me as _IceConnectToMeInfo ptr
	protosetup_to_me as _IceProtoSetupToMeInfo ptr
end type

#endif
