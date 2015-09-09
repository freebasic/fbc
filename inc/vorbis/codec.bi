'' FreeBASIC binding for libvorbis-1.3.5
''
'' based on the C header files:
''   Copyright (c) 2002-2015 Xiph.org Foundation
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

#include once "crt/long.bi"
#include once "ogg/ogg.bi"

extern "C"

#define _vorbis_codec_h_

type vorbis_info
	version as long
	channels as long
	rate as clong
	bitrate_upper as clong
	bitrate_nominal as clong
	bitrate_lower as clong
	bitrate_window as clong
	codec_setup as any ptr
end type

type vorbis_dsp_state
	analysisp as long
	vi as vorbis_info ptr
	pcm as single ptr ptr
	pcmret as single ptr ptr
	pcm_storage as long
	pcm_current as long
	pcm_returned as long
	preextrapolate as long
	eofflag as long
	lW as clong
	W as clong
	nW as clong
	centerW as clong
	granulepos as ogg_int64_t
	sequence as ogg_int64_t
	glue_bits as ogg_int64_t
	time_bits as ogg_int64_t
	floor_bits as ogg_int64_t
	res_bits as ogg_int64_t
	backend_state as any ptr
end type

type alloc_chain as alloc_chain_

type vorbis_block
	pcm as single ptr ptr
	opb as oggpack_buffer
	lW as clong
	W as clong
	nW as clong
	pcmend as long
	mode as long
	eofflag as long
	granulepos as ogg_int64_t
	sequence as ogg_int64_t
	vd as vorbis_dsp_state ptr
	localstore as any ptr
	localtop as clong
	localalloc as clong
	totaluse as clong
	reap as alloc_chain ptr
	glue_bits as clong
	time_bits as clong
	floor_bits as clong
	res_bits as clong
	internal as any ptr
end type

type alloc_chain_
	ptr as any ptr
	next as alloc_chain ptr
end type

type vorbis_comment
	user_comments as zstring ptr ptr
	comment_lengths as long ptr
	comments as long
	vendor as zstring ptr
end type

declare sub vorbis_info_init(byval vi as vorbis_info ptr)
declare sub vorbis_info_clear(byval vi as vorbis_info ptr)
declare function vorbis_info_blocksize(byval vi as vorbis_info ptr, byval zo as long) as long
declare sub vorbis_comment_init(byval vc as vorbis_comment ptr)
declare sub vorbis_comment_add(byval vc as vorbis_comment ptr, byval comment as const zstring ptr)
declare sub vorbis_comment_add_tag(byval vc as vorbis_comment ptr, byval tag as const zstring ptr, byval contents as const zstring ptr)
declare function vorbis_comment_query(byval vc as vorbis_comment ptr, byval tag as const zstring ptr, byval count as long) as zstring ptr
declare function vorbis_comment_query_count(byval vc as vorbis_comment ptr, byval tag as const zstring ptr) as long
declare sub vorbis_comment_clear(byval vc as vorbis_comment ptr)
declare function vorbis_block_init(byval v as vorbis_dsp_state ptr, byval vb as vorbis_block ptr) as long
declare function vorbis_block_clear(byval vb as vorbis_block ptr) as long
declare sub vorbis_dsp_clear(byval v as vorbis_dsp_state ptr)
declare function vorbis_granule_time(byval v as vorbis_dsp_state ptr, byval granulepos as ogg_int64_t) as double
declare function vorbis_version_string() as const zstring ptr
declare function vorbis_analysis_init(byval v as vorbis_dsp_state ptr, byval vi as vorbis_info ptr) as long
declare function vorbis_commentheader_out(byval vc as vorbis_comment ptr, byval op as ogg_packet ptr) as long
declare function vorbis_analysis_headerout(byval v as vorbis_dsp_state ptr, byval vc as vorbis_comment ptr, byval op as ogg_packet ptr, byval op_comm as ogg_packet ptr, byval op_code as ogg_packet ptr) as long
declare function vorbis_analysis_buffer(byval v as vorbis_dsp_state ptr, byval vals as long) as single ptr ptr
declare function vorbis_analysis_wrote(byval v as vorbis_dsp_state ptr, byval vals as long) as long
declare function vorbis_analysis_blockout(byval v as vorbis_dsp_state ptr, byval vb as vorbis_block ptr) as long
declare function vorbis_analysis(byval vb as vorbis_block ptr, byval op as ogg_packet ptr) as long
declare function vorbis_bitrate_addblock(byval vb as vorbis_block ptr) as long
declare function vorbis_bitrate_flushpacket(byval vd as vorbis_dsp_state ptr, byval op as ogg_packet ptr) as long
declare function vorbis_synthesis_idheader(byval op as ogg_packet ptr) as long
declare function vorbis_synthesis_headerin(byval vi as vorbis_info ptr, byval vc as vorbis_comment ptr, byval op as ogg_packet ptr) as long
declare function vorbis_synthesis_init(byval v as vorbis_dsp_state ptr, byval vi as vorbis_info ptr) as long
declare function vorbis_synthesis_restart(byval v as vorbis_dsp_state ptr) as long
declare function vorbis_synthesis(byval vb as vorbis_block ptr, byval op as ogg_packet ptr) as long
declare function vorbis_synthesis_trackonly(byval vb as vorbis_block ptr, byval op as ogg_packet ptr) as long
declare function vorbis_synthesis_blockin(byval v as vorbis_dsp_state ptr, byval vb as vorbis_block ptr) as long
declare function vorbis_synthesis_pcmout(byval v as vorbis_dsp_state ptr, byval pcm as single ptr ptr ptr) as long
declare function vorbis_synthesis_lapout(byval v as vorbis_dsp_state ptr, byval pcm as single ptr ptr ptr) as long
declare function vorbis_synthesis_read(byval v as vorbis_dsp_state ptr, byval samples as long) as long
declare function vorbis_packet_blocksize(byval vi as vorbis_info ptr, byval op as ogg_packet ptr) as clong
declare function vorbis_synthesis_halfrate(byval v as vorbis_info ptr, byval flag as long) as long
declare function vorbis_synthesis_halfrate_p(byval v as vorbis_info ptr) as long

const OV_FALSE = -1
const OV_EOF = -2
const OV_HOLE = -3
const OV_EREAD = -128
const OV_EFAULT = -129
const OV_EIMPL = -130
const OV_EINVAL = -131
const OV_ENOTVORBIS = -132
const OV_EBADHEADER = -133
const OV_EVERSION = -134
const OV_ENOTAUDIO = -135
const OV_EBADPACKET = -136
const OV_EBADLINK = -137
const OV_ENOSEEK = -138

end extern
