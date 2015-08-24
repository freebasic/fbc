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

extern "Windows"

#define NCB_INCLUDED
const NCBNAMSZ = 16
const MAX_LANA = 254

type _NCB
	ncb_command as UCHAR
	ncb_retcode as UCHAR
	ncb_lsn as UCHAR
	ncb_num as UCHAR
	ncb_buffer as PUCHAR
	ncb_length as WORD
	ncb_callname(0 to 15) as UCHAR
	ncb_name(0 to 15) as UCHAR
	ncb_rto as UCHAR
	ncb_sto as UCHAR
	ncb_post as sub(byval as _NCB ptr)
	ncb_lana_num as UCHAR
	ncb_cmd_cplt as UCHAR

	#ifdef __FB_64BIT__
		ncb_reserve(0 to 17) as UCHAR
	#else
		ncb_reserve(0 to 9) as UCHAR
	#endif

	ncb_event as HANDLE
end type

type NCB as _NCB
type PNCB as _NCB ptr

type _ADAPTER_STATUS
	adapter_address(0 to 5) as UCHAR
	rev_major as UCHAR
	reserved0 as UCHAR
	adapter_type as UCHAR
	rev_minor as UCHAR
	duration as WORD
	frmr_recv as WORD
	frmr_xmit as WORD
	iframe_recv_err as WORD
	xmit_aborts as WORD
	xmit_success as DWORD
	recv_success as DWORD
	iframe_xmit_err as WORD
	recv_buff_unavail as WORD
	t1_timeouts as WORD
	ti_timeouts as WORD
	reserved1 as DWORD
	free_ncbs as WORD
	max_cfg_ncbs as WORD
	max_ncbs as WORD
	xmit_buf_unavail as WORD
	max_dgram_size as WORD
	pending_sess as WORD
	max_cfg_sess as WORD
	max_sess as WORD
	max_sess_pkt_size as WORD
	name_count as WORD
end type

type ADAPTER_STATUS as _ADAPTER_STATUS
type PADAPTER_STATUS as _ADAPTER_STATUS ptr

type _NAME_BUFFER
	name as zstring * 16
	name_num as UCHAR
	name_flags as UCHAR
end type

type NAME_BUFFER as _NAME_BUFFER
type PNAME_BUFFER as _NAME_BUFFER ptr
const NAME_FLAGS_MASK = &h87
const GROUP_NAME = &h80
const UNIQUE_NAME = &h00
const REGISTERING = &h00
const REGISTERED = &h04
const DEREGISTERED = &h05
const DUPLICATE = &h06
const DUPLICATE_DEREG = &h07

type _SESSION_HEADER
	sess_name as UCHAR
	num_sess as UCHAR
	rcv_dg_outstanding as UCHAR
	rcv_any_outstanding as UCHAR
end type

type SESSION_HEADER as _SESSION_HEADER
type PSESSION_HEADER as _SESSION_HEADER ptr

type _SESSION_BUFFER
	lsn as UCHAR
	state as UCHAR
	local_name(0 to 15) as UCHAR
	remote_name(0 to 15) as UCHAR
	rcvs_outstanding as UCHAR
	sends_outstanding as UCHAR
end type

type SESSION_BUFFER as _SESSION_BUFFER
type PSESSION_BUFFER as _SESSION_BUFFER ptr
const LISTEN_OUTSTANDING = &h01
const CALL_PENDING = &h02
const SESSION_ESTABLISHED = &h03
const HANGUP_PENDING = &h04
const HANGUP_COMPLETE = &h05
const SESSION_ABORTED = &h06

type _LANA_ENUM
	length as UCHAR
	lana(0 to (254 + 1) - 1) as UCHAR
end type

type LANA_ENUM as _LANA_ENUM
type PLANA_ENUM as _LANA_ENUM ptr

type _FIND_NAME_HEADER
	node_count as WORD
	reserved as UCHAR
	unique_group as UCHAR
end type

type FIND_NAME_HEADER as _FIND_NAME_HEADER
type PFIND_NAME_HEADER as _FIND_NAME_HEADER ptr

type _FIND_NAME_BUFFER
	length as UCHAR
	access_control as UCHAR
	frame_control as UCHAR
	destination_addr(0 to 5) as UCHAR
	source_addr(0 to 5) as UCHAR
	routing_info(0 to 17) as UCHAR
end type

type FIND_NAME_BUFFER as _FIND_NAME_BUFFER
type PFIND_NAME_BUFFER as _FIND_NAME_BUFFER ptr

type _ACTION_HEADER
	transport_id as ULONG
	action_code as USHORT
	reserved as USHORT
end type

type ACTION_HEADER as _ACTION_HEADER
type PACTION_HEADER as _ACTION_HEADER ptr
#define ALL_TRANSPORTS !"M\0\0\0"
#define MS_NBF "MNBF"
const NCBCALL = &h10
const NCBLISTEN = &h11
const NCBHANGUP = &h12
const NCBSEND = &h14
const NCBRECV = &h15
const NCBRECVANY = &h16
const NCBCHAINSEND = &h17
const NCBDGSEND = &h20
const NCBDGRECV = &h21
const NCBDGSENDBC = &h22
const NCBDGRECVBC = &h23
const NCBADDNAME = &h30
const NCBDELNAME = &h31
const NCBRESET = &h32
const NCBASTAT = &h33
const NCBSSTAT = &h34
const NCBCANCEL = &h35
const NCBADDGRNAME = &h36
const NCBENUM = &h37
const NCBUNLINK = &h70
const NCBSENDNA = &h71
const NCBCHAINSENDNA = &h72
const NCBLANSTALERT = &h73
const NCBACTION = &h77
const NCBFINDNAME = &h78
const NCBTRACE = &h79
const ASYNCH = &h80
const NRC_GOODRET = &h00
const NRC_BUFLEN = &h01
const NRC_ILLCMD = &h03
const NRC_CMDTMO = &h05
const NRC_INCOMP = &h06
const NRC_BADDR = &h07
const NRC_SNUMOUT = &h08
const NRC_NORES = &h09
const NRC_SCLOSED = &h0a
const NRC_CMDCAN = &h0b
const NRC_DUPNAME = &h0d
const NRC_NAMTFUL = &h0e
const NRC_ACTSES = &h0f
const NRC_LOCTFUL = &h11
const NRC_REMTFUL = &h12
const NRC_ILLNN = &h13
const NRC_NOCALL = &h14
const NRC_NOWILD = &h15
const NRC_INUSE = &h16
const NRC_NAMERR = &h17
const NRC_SABORT = &h18
const NRC_NAMCONF = &h19
const NRC_IFBUSY = &h21
const NRC_TOOMANY = &h22
const NRC_BRIDGE = &h23
const NRC_CANOCCR = &h24
const NRC_CANCEL = &h26
const NRC_DUPENV = &h30
const NRC_ENVNOTDEF = &h34
const NRC_OSRESNOTAV = &h35
const NRC_MAXAPPS = &h36
const NRC_NOSAPS = &h37
const NRC_NORESOURCES = &h38
const NRC_INVADDRESS = &h39
const NRC_INVDDID = &h3B
const NRC_LOCKFAIL = &h3C
const NRC_OPENERR = &h3f
const NRC_SYSTEM = &h40
const NRC_PENDING = &hff
declare function Netbios(byval pncb as PNCB) as UCHAR

end extern
