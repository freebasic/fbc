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
#include once "X11/ICE/ICElib.bi"
#include once "X11/Xtrans/Xtrans.bi"

#define _ICECONN_H_

type _IceSavedReplyWait
	reply_wait as IceReplyWaitInfo ptr
	reply_ready as long
	next as _IceSavedReplyWait ptr
end type

type _IcePingWait
	ping_reply_proc as IcePingReplyProc
	client_data as IcePointer
	next as _IcePingWait ptr
end type

type _IcePoProtocol
	vendor as zstring ptr
	release as zstring ptr
	version_count as long
	version_recs as IcePoVersionRec ptr
	auth_count as long
	auth_names as zstring ptr ptr
	auth_procs as IcePoAuthProc ptr
	io_error_proc as IceIOErrorProc
end type

type _IcePaProtocol
	vendor as zstring ptr
	release as zstring ptr
	version_count as long
	version_recs as IcePaVersionRec ptr
	protocol_setup_proc as IceProtocolSetupProc
	protocol_activate_proc as IceProtocolActivateProc
	auth_count as long
	auth_names as zstring ptr ptr
	auth_procs as IcePaAuthProc ptr
	host_based_auth_proc as IceHostBasedAuthProc
	io_error_proc as IceIOErrorProc
end type

type _IceProtocol
	protocol_name as zstring ptr
	orig_client as _IcePoProtocol ptr
	accept_client as _IcePaProtocol ptr
end type

union _IceProcessMsgInfo_process_msg_proc
	accept_client as IcePaProcessMsgProc
	orig_client as IcePoProcessMsgProc
end union

type _IceProcessMsgInfo
	in_use as long
	my_opcode as long
	protocol as _IceProtocol ptr
	client_data as IcePointer
	accept_flag as long
	process_msg_proc as _IceProcessMsgInfo_process_msg_proc
end type

type _IceConnectToMeInfo
	his_version_index as long
	my_version_index as long
	his_vendor as zstring ptr
	his_release as zstring ptr
	my_auth_index as byte
	my_auth_state as IcePointer
	must_authenticate as long
end type

type _IceProtoSetupToMeInfo
	his_opcode as long
	my_opcode as long
	his_version_index as long
	my_version_index as long
	his_vendor as zstring ptr
	his_release as zstring ptr
	my_auth_index as byte
	my_auth_state as IcePointer
	must_authenticate as long
end type

type _IceConnectToYouInfo
	auth_active as long
	my_auth_index as byte
	my_auth_state as IcePointer
end type

type _IceProtoSetupToYouInfo
	my_opcode as long
	my_auth_count as long
	my_auth_indices as long ptr
	auth_active as long
	my_auth_index as byte
	my_auth_state as IcePointer
end type

type _IceConn
	io_ok : 1 as ulong
	swap : 1 as ulong
	waiting_for_byteorder : 1 as ulong
	skip_want_to_close : 1 as ulong
	want_to_close : 1 as ulong
	free_asap : 1 as ulong
	unused1 : 2 as ulong
	unused2 : 8 as ulong
	connection_status as IceConnectStatus
	my_ice_version_index as ubyte
	trans_conn as _XtransConnInfo ptr
	send_sequence as culong
	receive_sequence as culong
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
	scratch_size as culong
	dispatch_level as long
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
