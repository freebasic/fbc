''
''
'' nb30 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_nb30_bi__
#define __win_nb30_bi__

#define NCBNAMSZ 16
#define MAX_LANA 254
#define NAME_FLAGS_MASK &h87
#define GROUP_NAME &h80
#define UNIQUE_NAME &h00
#define REGISTERING &h00
#define REGISTERED &h04
#define DEREGISTERED &h05
#define DUPLICATE &h06
#define DUPLICATE_DEREG &h07
#define LISTEN_OUTSTANDING &h01
#define CALL_PENDING &h02
#define SESSION_ESTABLISHED &h03
#define HANGUP_PENDING &h04
#define HANGUP_COMPLETE &h05
#define SESSION_ABORTED &h06
#ifdef __FB_OPTION_ESCAPE__
#define ALL_TRANSPORTS "M\0\0\0"
#else
#define ALL_TRANSPORTS "M" + chr( 0, 0, 0 )
#endif
#define MS_NBF "MNBF"
#define NCBCALL &h10
#define NCBLISTEN &h11
#define NCBHANGUP &h12
#define NCBSEND &h14
#define NCBRECV &h15
#define NCBRECVANY &h16
#define NCBCHAINSEND &h17
#define NCBDGSEND &h20
#define NCBDGRECV &h21
#define NCBDGSENDBC &h22
#define NCBDGRECVBC &h23
#define NCBADDNAME &h30
#define NCBDELNAME &h31
#define NCBRESET &h32
#define NCBASTAT &h33
#define NCBSSTAT &h34
#define NCBCANCEL &h35
#define NCBADDGRNAME &h36
#define NCBENUM &h37
#define NCBUNLINK &h70
#define NCBSENDNA &h71
#define NCBCHAINSENDNA &h72
#define NCBLANSTALERT &h73
#define NCBACTION &h77
#define NCBFINDNAME &h78
#define NCBTRACE &h79
#define ASYNCH &h80
#define NRC_GOODRET &h00
#define NRC_BUFLEN &h01
#define NRC_ILLCMD &h03
#define NRC_CMDTMO &h05
#define NRC_INCOMP &h06
#define NRC_BADDR &h07
#define NRC_SNUMOUT &h08
#define NRC_NORES &h09
#define NRC_SCLOSED &h0a
#define NRC_CMDCAN &h&b
#define NRC_DUPNAME &h0d
#define NRC_NAMTFUL &h0e
#define NRC_ACTSES &h0f
#define NRC_LOCTFUL &h11
#define NRC_REMTFUL &h12
#define NRC_ILLNN &h13
#define NRC_NOCALL &h14
#define NRC_NOWILD &h15
#define NRC_INUSE &h16
#define NRC_NAMERR &h17
#define NRC_SABORT &h18
#define NRC_NAMCONF &h19
#define NRC_IFBUSY &h21
#define NRC_TOOMANY &h22
#define NRC_BRIDGE &h23
#define NRC_CANOCCR &h24
#define NRC_CANCEL &h26
#define NRC_DUPENV &h30
#define NRC_ENVNOTDEF &h34
#define NRC_OSRESNOTAV &h35
#define NRC_MAXAPPS &h36
#define NRC_NOSAPS &h37
#define NRC_NORESOURCES &h38
#define NRC_INVADDRESS &h39
#define NRC_INVDDID &h3B
#define NRC_LOCKFAIL &h3C
#define NRC_OPENERR &h3f
#define NRC_SYSTEM &h40
#define NRC_PENDING &hff

type ACTION_HEADER
	transport_id as ULONG
	action_code as USHORT
	reserved as USHORT
end type

type PACTION_HEADER as ACTION_HEADER ptr

type ADAPTER_STATUS
	adapter_address(0 to 6-1) as UCHAR
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

type PADAPTER_STATUS as ADAPTER_STATUS ptr

type FIND_NAME_BUFFER
	length as UCHAR
	access_control as UCHAR
	frame_control as UCHAR
	destination_addr(0 to 6-1) as UCHAR
	source_addr(0 to 6-1) as UCHAR
	routing_info(0 to 18-1) as UCHAR
end type

type PFIND_NAME_BUFFER as FIND_NAME_BUFFER ptr

type FIND_NAME_HEADER
	node_count as WORD
	reserved as UCHAR
	unique_group as UCHAR
end type

type PFIND_NAME_HEADER as FIND_NAME_HEADER ptr

type LANA_ENUM
	length as UCHAR
	lana(0 to 254+1-1) as UCHAR
end type

type PLANA_ENUM as LANA_ENUM ptr

type NAME_BUFFER
	name(0 to 16-1) as UCHAR
	name_num as UCHAR
	name_flags as UCHAR
end type

type PNAME_BUFFER as NAME_BUFFER ptr

type NCB
	ncb_command as UCHAR
	ncb_retcode as UCHAR
	ncb_lsn as UCHAR
	ncb_num as UCHAR
	ncb_buffer as PUCHAR
	ncb_length as WORD
	ncb_callname(0 to 16-1) as UCHAR
	ncb_name(0 to 16-1) as UCHAR
	ncb_rto as UCHAR
	ncb_sto as UCHAR
	ncb_post as sub (byval as NCB ptr)
	ncb_lana_num as UCHAR
	ncb_cmd_cplt as UCHAR
	ncb_reserve(0 to 10-1) as UCHAR
	ncb_event as HANDLE
end type

type PNCB as NCB ptr

type SESSION_BUFFER
	lsn as UCHAR
	state as UCHAR
	local_name(0 to 16-1) as UCHAR
	remote_name(0 to 16-1) as UCHAR
	rcvs_outstanding as UCHAR
	sends_outstanding as UCHAR
end type

type PSESSION_BUFFER as SESSION_BUFFER ptr

type SESSION_HEADER
	sess_name as UCHAR
	num_sess as UCHAR
	rcv_dg_outstanding as UCHAR
	rcv_any_outstanding as UCHAR
end type

type PSESSION_HEADER as SESSION_HEADER ptr

declare function Netbios alias "Netbios" (byval as PNCB) as UCHAR

#endif
