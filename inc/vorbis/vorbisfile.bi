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

#inclib "vorbisfile"

#include once "crt/long.bi"
#include once "crt/stdio.bi"
#include once "codec.bi"

extern "C"

#define _OV_FILE_H_

type ov_callbacks
	read_func as function(byval ptr as any ptr, byval size as uinteger, byval nmemb as uinteger, byval datasource as any ptr) as uinteger
	seek_func as function(byval datasource as any ptr, byval offset as ogg_int64_t, byval whence as long) as long
	close_func as function(byval datasource as any ptr) as long
	tell_func as function(byval datasource as any ptr) as clong
end type

const NOTOPEN = 0
const PARTOPEN = 1
const OPENED = 2
const STREAMSET = 3
const INITSET = 4

type OggVorbis_File
	datasource as any ptr
	seekable as long
	offset as ogg_int64_t
	as ogg_int64_t end
	oy as ogg_sync_state
	links as long
	offsets as ogg_int64_t ptr
	dataoffsets as ogg_int64_t ptr
	serialnos as clong ptr
	pcmlengths as ogg_int64_t ptr
	vi as vorbis_info ptr
	vc as vorbis_comment ptr
	pcm_offset as ogg_int64_t
	ready_state as long
	current_serialno as clong
	current_link as long
	bittrack as double
	samptrack as double
	os as ogg_stream_state
	vd as vorbis_dsp_state
	vb as vorbis_block
	callbacks as ov_callbacks
end type

declare function ov_clear(byval vf as OggVorbis_File ptr) as long
declare function ov_fopen(byval path as const zstring ptr, byval vf as OggVorbis_File ptr) as long
declare function ov_open(byval f as FILE ptr, byval vf as OggVorbis_File ptr, byval initial as const zstring ptr, byval ibytes as clong) as long
declare function ov_open_callbacks(byval datasource as any ptr, byval vf as OggVorbis_File ptr, byval initial as const zstring ptr, byval ibytes as clong, byval callbacks as ov_callbacks) as long
declare function ov_test(byval f as FILE ptr, byval vf as OggVorbis_File ptr, byval initial as const zstring ptr, byval ibytes as clong) as long
declare function ov_test_callbacks(byval datasource as any ptr, byval vf as OggVorbis_File ptr, byval initial as const zstring ptr, byval ibytes as clong, byval callbacks as ov_callbacks) as long
declare function ov_test_open(byval vf as OggVorbis_File ptr) as long
declare function ov_bitrate(byval vf as OggVorbis_File ptr, byval i as long) as clong
declare function ov_bitrate_instant(byval vf as OggVorbis_File ptr) as clong
declare function ov_streams(byval vf as OggVorbis_File ptr) as clong
declare function ov_seekable(byval vf as OggVorbis_File ptr) as clong
declare function ov_serialnumber(byval vf as OggVorbis_File ptr, byval i as long) as clong
declare function ov_raw_total(byval vf as OggVorbis_File ptr, byval i as long) as ogg_int64_t
declare function ov_pcm_total(byval vf as OggVorbis_File ptr, byval i as long) as ogg_int64_t
declare function ov_time_total(byval vf as OggVorbis_File ptr, byval i as long) as double
declare function ov_raw_seek(byval vf as OggVorbis_File ptr, byval pos as ogg_int64_t) as long
declare function ov_pcm_seek(byval vf as OggVorbis_File ptr, byval pos as ogg_int64_t) as long
declare function ov_pcm_seek_page(byval vf as OggVorbis_File ptr, byval pos as ogg_int64_t) as long
declare function ov_time_seek(byval vf as OggVorbis_File ptr, byval pos as double) as long
declare function ov_time_seek_page(byval vf as OggVorbis_File ptr, byval pos as double) as long
declare function ov_raw_seek_lap(byval vf as OggVorbis_File ptr, byval pos as ogg_int64_t) as long
declare function ov_pcm_seek_lap(byval vf as OggVorbis_File ptr, byval pos as ogg_int64_t) as long
declare function ov_pcm_seek_page_lap(byval vf as OggVorbis_File ptr, byval pos as ogg_int64_t) as long
declare function ov_time_seek_lap(byval vf as OggVorbis_File ptr, byval pos as double) as long
declare function ov_time_seek_page_lap(byval vf as OggVorbis_File ptr, byval pos as double) as long
declare function ov_raw_tell(byval vf as OggVorbis_File ptr) as ogg_int64_t
declare function ov_pcm_tell(byval vf as OggVorbis_File ptr) as ogg_int64_t
declare function ov_time_tell(byval vf as OggVorbis_File ptr) as double
declare function ov_info(byval vf as OggVorbis_File ptr, byval link as long) as vorbis_info ptr
declare function ov_comment(byval vf as OggVorbis_File ptr, byval link as long) as vorbis_comment ptr
declare function ov_read_float(byval vf as OggVorbis_File ptr, byval pcm_channels as single ptr ptr ptr, byval samples as long, byval bitstream as long ptr) as clong
declare function ov_read_filter(byval vf as OggVorbis_File ptr, byval buffer as zstring ptr, byval length as long, byval bigendianp as long, byval word as long, byval sgned as long, byval bitstream as long ptr, byval filter as sub(byval pcm as single ptr ptr, byval channels as clong, byval samples as clong, byval filter_param as any ptr), byval filter_param as any ptr) as clong
declare function ov_read(byval vf as OggVorbis_File ptr, byval buffer as zstring ptr, byval length as long, byval bigendianp as long, byval word as long, byval sgned as long, byval bitstream as long ptr) as clong
declare function ov_crosslap(byval vf1 as OggVorbis_File ptr, byval vf2 as OggVorbis_File ptr) as long
declare function ov_halfrate(byval vf as OggVorbis_File ptr, byval flag as long) as long
declare function ov_halfrate_p(byval vf as OggVorbis_File ptr) as long

end extern
