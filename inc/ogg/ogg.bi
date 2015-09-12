'' FreeBASIC binding for libogg-1.3.2
''
'' based on the C header files:
''   Copyright (c) 2002, Xiph.org Foundation
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions
''   are met:
''
''   - Redistributions of source code must retain the above copyright
''   notice, this list of conditions and the following disclaimer.
''
''   - Redistributions in binary form must reproduce the above copyright
''   notice, this list of conditions and the following disclaimer in the
''   documentation and/or other materials provided with the distribution.
''
''   - Neither the name of the Xiph.org Foundation nor the names of its
''   contributors may be used to endorse or promote products derived from
''   this software without specific prior written permission.
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
''   ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''   A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION
''   OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
''   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
''   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
''   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
''   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
''   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "ogg"

#include once "crt/long.bi"
#include once "crt/stddef.bi"

extern "C"

#define _OGG_H
#define _ogg_malloc malloc
#define _ogg_calloc calloc
#define _ogg_realloc realloc
#define _ogg_free free
type ogg_int16_t as short

#if defined(__FB_WIN32__) or defined(__FB_UNIX__)
	type ogg_uint16_t as ushort
#endif

type ogg_int32_t as long
type ogg_uint32_t as ulong
type ogg_int64_t as longint

#ifdef __FB_WIN32__
	type ogg_uint64_t as ulongint
#endif

type ogg_iovec_t
	iov_base as any ptr
	iov_len as uinteger
end type

type oggpack_buffer
	endbyte as clong
	endbit as long
	buffer as ubyte ptr
	ptr as ubyte ptr
	storage as clong
end type

type ogg_page
	header as ubyte ptr
	header_len as clong
	body as ubyte ptr
	body_len as clong
end type

type ogg_stream_state
	body_data as ubyte ptr
	body_storage as clong
	body_fill as clong
	body_returned as clong
	lacing_vals as long ptr
	granule_vals as ogg_int64_t ptr
	lacing_storage as clong
	lacing_fill as clong
	lacing_packet as clong
	lacing_returned as clong
	header(0 to 281) as ubyte
	header_fill as long
	e_o_s as long
	b_o_s as long
	serialno as clong
	pageno as clong
	packetno as ogg_int64_t
	granulepos as ogg_int64_t
end type

type ogg_packet
	packet as ubyte ptr
	bytes as clong
	b_o_s as clong
	e_o_s as clong
	granulepos as ogg_int64_t
	packetno as ogg_int64_t
end type

type ogg_sync_state
	data as ubyte ptr
	storage as long
	fill as long
	returned as long
	unsynced as long
	headerbytes as long
	bodybytes as long
end type

declare sub oggpack_writeinit(byval b as oggpack_buffer ptr)
declare function oggpack_writecheck(byval b as oggpack_buffer ptr) as long
declare sub oggpack_writetrunc(byval b as oggpack_buffer ptr, byval bits as clong)
declare sub oggpack_writealign(byval b as oggpack_buffer ptr)
declare sub oggpack_writecopy(byval b as oggpack_buffer ptr, byval source as any ptr, byval bits as clong)
declare sub oggpack_reset(byval b as oggpack_buffer ptr)
declare sub oggpack_writeclear(byval b as oggpack_buffer ptr)
declare sub oggpack_readinit(byval b as oggpack_buffer ptr, byval buf as ubyte ptr, byval bytes as long)
declare sub oggpack_write(byval b as oggpack_buffer ptr, byval value as culong, byval bits as long)
declare function oggpack_look(byval b as oggpack_buffer ptr, byval bits as long) as clong
declare function oggpack_look1(byval b as oggpack_buffer ptr) as clong
declare sub oggpack_adv(byval b as oggpack_buffer ptr, byval bits as long)
declare sub oggpack_adv1(byval b as oggpack_buffer ptr)
declare function oggpack_read(byval b as oggpack_buffer ptr, byval bits as long) as clong
declare function oggpack_read1(byval b as oggpack_buffer ptr) as clong
declare function oggpack_bytes(byval b as oggpack_buffer ptr) as clong
declare function oggpack_bits(byval b as oggpack_buffer ptr) as clong
declare function oggpack_get_buffer(byval b as oggpack_buffer ptr) as ubyte ptr
declare sub oggpackB_writeinit(byval b as oggpack_buffer ptr)
declare function oggpackB_writecheck(byval b as oggpack_buffer ptr) as long
declare sub oggpackB_writetrunc(byval b as oggpack_buffer ptr, byval bits as clong)
declare sub oggpackB_writealign(byval b as oggpack_buffer ptr)
declare sub oggpackB_writecopy(byval b as oggpack_buffer ptr, byval source as any ptr, byval bits as clong)
declare sub oggpackB_reset(byval b as oggpack_buffer ptr)
declare sub oggpackB_writeclear(byval b as oggpack_buffer ptr)
declare sub oggpackB_readinit(byval b as oggpack_buffer ptr, byval buf as ubyte ptr, byval bytes as long)
declare sub oggpackB_write(byval b as oggpack_buffer ptr, byval value as culong, byval bits as long)
declare function oggpackB_look(byval b as oggpack_buffer ptr, byval bits as long) as clong
declare function oggpackB_look1(byval b as oggpack_buffer ptr) as clong
declare sub oggpackB_adv(byval b as oggpack_buffer ptr, byval bits as long)
declare sub oggpackB_adv1(byval b as oggpack_buffer ptr)
declare function oggpackB_read(byval b as oggpack_buffer ptr, byval bits as long) as clong
declare function oggpackB_read1(byval b as oggpack_buffer ptr) as clong
declare function oggpackB_bytes(byval b as oggpack_buffer ptr) as clong
declare function oggpackB_bits(byval b as oggpack_buffer ptr) as clong
declare function oggpackB_get_buffer(byval b as oggpack_buffer ptr) as ubyte ptr
declare function ogg_stream_packetin(byval os as ogg_stream_state ptr, byval op as ogg_packet ptr) as long
declare function ogg_stream_iovecin(byval os as ogg_stream_state ptr, byval iov as ogg_iovec_t ptr, byval count as long, byval e_o_s as clong, byval granulepos as ogg_int64_t) as long
declare function ogg_stream_pageout(byval os as ogg_stream_state ptr, byval og as ogg_page ptr) as long
declare function ogg_stream_pageout_fill(byval os as ogg_stream_state ptr, byval og as ogg_page ptr, byval nfill as long) as long
declare function ogg_stream_flush(byval os as ogg_stream_state ptr, byval og as ogg_page ptr) as long
declare function ogg_stream_flush_fill(byval os as ogg_stream_state ptr, byval og as ogg_page ptr, byval nfill as long) as long
declare function ogg_sync_init(byval oy as ogg_sync_state ptr) as long
declare function ogg_sync_clear(byval oy as ogg_sync_state ptr) as long
declare function ogg_sync_reset(byval oy as ogg_sync_state ptr) as long
declare function ogg_sync_destroy(byval oy as ogg_sync_state ptr) as long
declare function ogg_sync_check(byval oy as ogg_sync_state ptr) as long
declare function ogg_sync_buffer(byval oy as ogg_sync_state ptr, byval size as clong) as zstring ptr
declare function ogg_sync_wrote(byval oy as ogg_sync_state ptr, byval bytes as clong) as long
declare function ogg_sync_pageseek(byval oy as ogg_sync_state ptr, byval og as ogg_page ptr) as clong
declare function ogg_sync_pageout(byval oy as ogg_sync_state ptr, byval og as ogg_page ptr) as long
declare function ogg_stream_pagein(byval os as ogg_stream_state ptr, byval og as ogg_page ptr) as long
declare function ogg_stream_packetout(byval os as ogg_stream_state ptr, byval op as ogg_packet ptr) as long
declare function ogg_stream_packetpeek(byval os as ogg_stream_state ptr, byval op as ogg_packet ptr) as long
declare function ogg_stream_init(byval os as ogg_stream_state ptr, byval serialno as long) as long
declare function ogg_stream_clear(byval os as ogg_stream_state ptr) as long
declare function ogg_stream_reset(byval os as ogg_stream_state ptr) as long
declare function ogg_stream_reset_serialno(byval os as ogg_stream_state ptr, byval serialno as long) as long
declare function ogg_stream_destroy(byval os as ogg_stream_state ptr) as long
declare function ogg_stream_check(byval os as ogg_stream_state ptr) as long
declare function ogg_stream_eos(byval os as ogg_stream_state ptr) as long
declare sub ogg_page_checksum_set(byval og as ogg_page ptr)
declare function ogg_page_version(byval og as const ogg_page ptr) as long
declare function ogg_page_continued(byval og as const ogg_page ptr) as long
declare function ogg_page_bos(byval og as const ogg_page ptr) as long
declare function ogg_page_eos(byval og as const ogg_page ptr) as long
declare function ogg_page_granulepos(byval og as const ogg_page ptr) as ogg_int64_t
declare function ogg_page_serialno(byval og as const ogg_page ptr) as long
declare function ogg_page_pageno(byval og as const ogg_page ptr) as clong
declare function ogg_page_packets(byval og as const ogg_page ptr) as long
declare sub ogg_packet_clear(byval op as ogg_packet ptr)

end extern
