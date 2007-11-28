''
''
'' ogg -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ogg_bi__
#define __ogg_bi__

#inclib "ogg"

type ogg_int16_t as short
type ogg_uint16_t as ushort
type ogg_int32_t as integer
type ogg_uint32_t as uinteger
type ogg_int64_t as longint

type oggpack_buffer
	endbyte as integer
	endbit as integer
	buffer as ubyte ptr
	ptr as ubyte ptr
	storage as integer
end type

type ogg_page
	header as ubyte ptr
	header_len as integer
	body as ubyte ptr
	body_len as integer
end type

type ogg_stream_state
	body_data as ubyte ptr
	body_storage as integer
	body_fill as integer
	body_returned as integer
	lacing_vals as integer ptr
	granule_vals as ogg_int64_t ptr
	lacing_storage as integer
	lacing_fill as integer
	lacing_packet as integer
	lacing_returned as integer
	header(0 to 282-1) as ubyte
	header_fill as integer
	e_o_s as integer
	b_o_s as integer
	serialno as integer
	pageno as integer
	packetno as ogg_int64_t
	granulepos as ogg_int64_t
end type

type ogg_packet
	packet as ubyte ptr
	bytes as integer
	b_o_s as integer
	e_o_s as integer
	granulepos as ogg_int64_t
	packetno as ogg_int64_t
end type

type ogg_sync_state
	data as ubyte ptr
	storage as integer
	fill as integer
	returned as integer
	unsynced as integer
	headerbytes as integer
	bodybytes as integer
end type

declare sub oggpack_writeinit cdecl alias "oggpack_writeinit" (byval b as oggpack_buffer ptr)
declare sub oggpack_writetrunc cdecl alias "oggpack_writetrunc" (byval b as oggpack_buffer ptr, byval bits as integer)
declare sub oggpack_writealign cdecl alias "oggpack_writealign" (byval b as oggpack_buffer ptr)
declare sub oggpack_writecopy cdecl alias "oggpack_writecopy" (byval b as oggpack_buffer ptr, byval source as any ptr, byval bits as integer)
declare sub oggpack_reset cdecl alias "oggpack_reset" (byval b as oggpack_buffer ptr)
declare sub oggpack_writeclear cdecl alias "oggpack_writeclear" (byval b as oggpack_buffer ptr)
declare sub oggpack_readinit cdecl alias "oggpack_readinit" (byval b as oggpack_buffer ptr, byval buf as ubyte ptr, byval bytes as integer)
declare sub oggpack_write cdecl alias "oggpack_write" (byval b as oggpack_buffer ptr, byval value as uinteger, byval bits as integer)
declare function oggpack_look cdecl alias "oggpack_look" (byval b as oggpack_buffer ptr, byval bits as integer) as integer
declare function oggpack_look1 cdecl alias "oggpack_look1" (byval b as oggpack_buffer ptr) as integer
declare sub oggpack_adv cdecl alias "oggpack_adv" (byval b as oggpack_buffer ptr, byval bits as integer)
declare sub oggpack_adv1 cdecl alias "oggpack_adv1" (byval b as oggpack_buffer ptr)
declare function oggpack_read cdecl alias "oggpack_read" (byval b as oggpack_buffer ptr, byval bits as integer) as integer
declare function oggpack_read1 cdecl alias "oggpack_read1" (byval b as oggpack_buffer ptr) as integer
declare function oggpack_bytes cdecl alias "oggpack_bytes" (byval b as oggpack_buffer ptr) as integer
declare function oggpack_bits cdecl alias "oggpack_bits" (byval b as oggpack_buffer ptr) as integer
declare function oggpack_get_buffer cdecl alias "oggpack_get_buffer" (byval b as oggpack_buffer ptr) as ubyte ptr
declare sub oggpackB_writeinit cdecl alias "oggpackB_writeinit" (byval b as oggpack_buffer ptr)
declare sub oggpackB_writetrunc cdecl alias "oggpackB_writetrunc" (byval b as oggpack_buffer ptr, byval bits as integer)
declare sub oggpackB_writealign cdecl alias "oggpackB_writealign" (byval b as oggpack_buffer ptr)
declare sub oggpackB_writecopy cdecl alias "oggpackB_writecopy" (byval b as oggpack_buffer ptr, byval source as any ptr, byval bits as integer)
declare sub oggpackB_reset cdecl alias "oggpackB_reset" (byval b as oggpack_buffer ptr)
declare sub oggpackB_writeclear cdecl alias "oggpackB_writeclear" (byval b as oggpack_buffer ptr)
declare sub oggpackB_readinit cdecl alias "oggpackB_readinit" (byval b as oggpack_buffer ptr, byval buf as ubyte ptr, byval bytes as integer)
declare sub oggpackB_write cdecl alias "oggpackB_write" (byval b as oggpack_buffer ptr, byval value as uinteger, byval bits as integer)
declare function oggpackB_look cdecl alias "oggpackB_look" (byval b as oggpack_buffer ptr, byval bits as integer) as integer
declare function oggpackB_look1 cdecl alias "oggpackB_look1" (byval b as oggpack_buffer ptr) as integer
declare sub oggpackB_adv cdecl alias "oggpackB_adv" (byval b as oggpack_buffer ptr, byval bits as integer)
declare sub oggpackB_adv1 cdecl alias "oggpackB_adv1" (byval b as oggpack_buffer ptr)
declare function oggpackB_read cdecl alias "oggpackB_read" (byval b as oggpack_buffer ptr, byval bits as integer) as integer
declare function oggpackB_read1 cdecl alias "oggpackB_read1" (byval b as oggpack_buffer ptr) as integer
declare function oggpackB_bytes cdecl alias "oggpackB_bytes" (byval b as oggpack_buffer ptr) as integer
declare function oggpackB_bits cdecl alias "oggpackB_bits" (byval b as oggpack_buffer ptr) as integer
declare function oggpackB_get_buffer cdecl alias "oggpackB_get_buffer" (byval b as oggpack_buffer ptr) as ubyte ptr
declare function ogg_stream_packetin cdecl alias "ogg_stream_packetin" (byval os as ogg_stream_state ptr, byval op as ogg_packet ptr) as integer
declare function ogg_stream_pageout cdecl alias "ogg_stream_pageout" (byval os as ogg_stream_state ptr, byval og as ogg_page ptr) as integer
declare function ogg_stream_flush cdecl alias "ogg_stream_flush" (byval os as ogg_stream_state ptr, byval og as ogg_page ptr) as integer
declare function ogg_sync_init cdecl alias "ogg_sync_init" (byval oy as ogg_sync_state ptr) as integer
declare function ogg_sync_clear cdecl alias "ogg_sync_clear" (byval oy as ogg_sync_state ptr) as integer
declare function ogg_sync_reset cdecl alias "ogg_sync_reset" (byval oy as ogg_sync_state ptr) as integer
declare function ogg_sync_destroy cdecl alias "ogg_sync_destroy" (byval oy as ogg_sync_state ptr) as integer
declare function ogg_sync_buffer cdecl alias "ogg_sync_buffer" (byval oy as ogg_sync_state ptr, byval size as integer) as zstring ptr
declare function ogg_sync_wrote cdecl alias "ogg_sync_wrote" (byval oy as ogg_sync_state ptr, byval bytes as integer) as integer
declare function ogg_sync_pageseek cdecl alias "ogg_sync_pageseek" (byval oy as ogg_sync_state ptr, byval og as ogg_page ptr) as integer
declare function ogg_sync_pageout cdecl alias "ogg_sync_pageout" (byval oy as ogg_sync_state ptr, byval og as ogg_page ptr) as integer
declare function ogg_stream_pagein cdecl alias "ogg_stream_pagein" (byval os as ogg_stream_state ptr, byval og as ogg_page ptr) as integer
declare function ogg_stream_packetout cdecl alias "ogg_stream_packetout" (byval os as ogg_stream_state ptr, byval op as ogg_packet ptr) as integer
declare function ogg_stream_packetpeek cdecl alias "ogg_stream_packetpeek" (byval os as ogg_stream_state ptr, byval op as ogg_packet ptr) as integer
declare function ogg_stream_init cdecl alias "ogg_stream_init" (byval os as ogg_stream_state ptr, byval serialno as integer) as integer
declare function ogg_stream_clear cdecl alias "ogg_stream_clear" (byval os as ogg_stream_state ptr) as integer
declare function ogg_stream_reset cdecl alias "ogg_stream_reset" (byval os as ogg_stream_state ptr) as integer
declare function ogg_stream_reset_serialno cdecl alias "ogg_stream_reset_serialno" (byval os as ogg_stream_state ptr, byval serialno as integer) as integer
declare function ogg_stream_destroy cdecl alias "ogg_stream_destroy" (byval os as ogg_stream_state ptr) as integer
declare function ogg_stream_eos cdecl alias "ogg_stream_eos" (byval os as ogg_stream_state ptr) as integer
declare sub ogg_page_checksum_set cdecl alias "ogg_page_checksum_set" (byval og as ogg_page ptr)
declare function ogg_page_version cdecl alias "ogg_page_version" (byval og as ogg_page ptr) as integer
declare function ogg_page_continued cdecl alias "ogg_page_continued" (byval og as ogg_page ptr) as integer
declare function ogg_page_bos cdecl alias "ogg_page_bos" (byval og as ogg_page ptr) as integer
declare function ogg_page_eos cdecl alias "ogg_page_eos" (byval og as ogg_page ptr) as integer
declare function ogg_page_granulepos cdecl alias "ogg_page_granulepos" (byval og as ogg_page ptr) as ogg_int64_t
declare function ogg_page_serialno cdecl alias "ogg_page_serialno" (byval og as ogg_page ptr) as integer
declare function ogg_page_pageno cdecl alias "ogg_page_pageno" (byval og as ogg_page ptr) as integer
declare function ogg_page_packets cdecl alias "ogg_page_packets" (byval og as ogg_page ptr) as integer
declare sub ogg_packet_clear cdecl alias "ogg_packet_clear" (byval op as ogg_packet ptr)

#endif
