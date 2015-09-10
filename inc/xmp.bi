'' FreeBASIC binding for libxmp-4.3.9
''
'' based on the C header files:
''   This library is free software; you can redistribute it and/or modify it
''   under the terms of the GNU Lesser General Public License as published by
''   the Free Software Foundation; either version 2.1 of the License, or (at
''   your option) any later version. This library is distributed in the hope
''   that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
''   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
''   GNU Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "xmp"

#include once "crt/long.bi"

'' The following symbols have been renamed:
''     #define XMP_VERSION => XMP_VERSION_
''     constant XMP_VERCODE => XMP_VERCODE_
''     constant XMP_CHANNEL_MUTE => XMP_CHANNEL_MUTE_

extern "C"

#define XMP_H
#define XMP_VERSION_ "4.3.9"
const XMP_VERCODE_ = &h040309
const XMP_VER_MAJOR = 4
const XMP_VER_MINOR = 3
const XMP_VER_RELEASE = 9
const XMP_NAME_SIZE = 64
const XMP_KEY_OFF = &h81
const XMP_KEY_CUT = &h82
const XMP_KEY_FADE = &h83
const XMP_FORMAT_8BIT = 1 shl 0
const XMP_FORMAT_UNSIGNED = 1 shl 1
const XMP_FORMAT_MONO = 1 shl 2
const XMP_PLAYER_AMP = 0
const XMP_PLAYER_MIX = 1
const XMP_PLAYER_INTERP = 2
const XMP_PLAYER_DSP = 3
const XMP_PLAYER_FLAGS = 4
const XMP_PLAYER_CFLAGS = 5
const XMP_PLAYER_SMPCTL = 6
const XMP_PLAYER_VOLUME = 7
const XMP_PLAYER_STATE = 8
const XMP_PLAYER_SMIX_VOLUME = 9
const XMP_PLAYER_DEFPAN = 10
const XMP_INTERP_NEAREST = 0
const XMP_INTERP_LINEAR = 1
const XMP_INTERP_SPLINE = 2
const XMP_DSP_LOWPASS = 1 shl 0
const XMP_DSP_ALL = XMP_DSP_LOWPASS
const XMP_STATE_UNLOADED = 0
const XMP_STATE_LOADED = 1
const XMP_STATE_PLAYING = 2
const XMP_FLAGS_VBLANK = 1 shl 0
const XMP_FLAGS_FX9BUG = 1 shl 1
const XMP_FLAGS_FIXLOOP = 1 shl 2
const XMP_SMPCTL_SKIP = 1 shl 0
const XMP_MAX_KEYS = 121
const XMP_MAX_ENV_POINTS = 32
const XMP_MAX_MOD_LENGTH = 256
const XMP_MAX_CHANNELS = 64
const XMP_MAX_SRATE = 49170
const XMP_MIN_SRATE = 4000
const XMP_MIN_BPM = 20
const XMP_MAX_FRAMESIZE = ((5 * XMP_MAX_SRATE) * 2) / XMP_MIN_BPM
const XMP_END = 1
const XMP_ERROR_INTERNAL = 2
const XMP_ERROR_FORMAT = 3
const XMP_ERROR_LOAD = 4
const XMP_ERROR_DEPACK = 5
const XMP_ERROR_SYSTEM = 6
const XMP_ERROR_INVALID = 7
const XMP_ERROR_STATE = 8

type xmp_channel
	pan as long
	vol as long
	flg as long
end type

const XMP_CHANNEL_SYNTH = 1 shl 0
const XMP_CHANNEL_MUTE_ = 1 shl 1
const XMP_CHANNEL_SPLIT = 1 shl 2
const XMP_CHANNEL_SURROUND = 1 shl 4

type xmp_pattern
	rows as long
	index(0 to 0) as long
end type

type xmp_event
	note as ubyte
	ins as ubyte
	vol as ubyte
	fxt as ubyte
	fxp as ubyte
	f2t as ubyte
	f2p as ubyte
	_flag as ubyte
end type

type xmp_track
	rows as long
	event(0 to 0) as xmp_event
end type

type xmp_envelope
	flg as long
	npt as long
	scl as long
	sus as long
	sue as long
	lps as long
	lpe as long
	data(0 to (32 * 2) - 1) as short
end type

const XMP_ENVELOPE_ON = 1 shl 0
const XMP_ENVELOPE_SUS = 1 shl 1
const XMP_ENVELOPE_LOOP = 1 shl 2
const XMP_ENVELOPE_FLT = 1 shl 3
const XMP_ENVELOPE_SLOOP = 1 shl 4
const XMP_ENVELOPE_CARRY = 1 shl 5

type xmp_instrument_map
	ins as ubyte
	xpo as byte
end type

type xmp_subinstrument
	vol as long
	gvl as long
	pan as long
	xpo as long
	fin as long
	vwf as long
	vde as long
	vra as long
	vsw as long
	rvv as long
	sid as long
	nna as long
	dct as long
	dca as long
	ifc as long
	ifr as long
end type

type xmp_instrument
	name as zstring * 32
	vol as long
	nsm as long
	rls as long
	aei as xmp_envelope
	pei as xmp_envelope
	fei as xmp_envelope
	map(0 to 120) as xmp_instrument_map
	sub as xmp_subinstrument ptr
	extra as any ptr
end type

const XMP_INST_NNA_CUT = &h00
const XMP_INST_NNA_CONT = &h01
const XMP_INST_NNA_OFF = &h02
const XMP_INST_NNA_FADE = &h03
const XMP_INST_DCT_OFF = &h00
const XMP_INST_DCT_NOTE = &h01
const XMP_INST_DCT_SMP = &h02
const XMP_INST_DCT_INST = &h03
const XMP_INST_DCA_CUT = XMP_INST_NNA_CUT
const XMP_INST_DCA_OFF = XMP_INST_NNA_OFF
const XMP_INST_DCA_FADE = XMP_INST_NNA_FADE

type xmp_sample
	name as zstring * 32
	len as long
	lps as long
	lpe as long
	flg as long
	data as ubyte ptr
end type

const XMP_SAMPLE_16BIT = 1 shl 0
const XMP_SAMPLE_LOOP = 1 shl 1
const XMP_SAMPLE_LOOP_BIDIR = 1 shl 2
const XMP_SAMPLE_LOOP_REVERSE = 1 shl 3
const XMP_SAMPLE_LOOP_FULL = 1 shl 4
const XMP_SAMPLE_SYNTH = 1 shl 15

type xmp_sequence
	entry_point as long
	duration as long
end type

type xmp_module
	name as zstring * 64
	as zstring * 64 type
	pat as long
	trk as long
	chn as long
	ins as long
	smp as long
	spd as long
	bpm as long
	len as long
	rst as long
	gvl as long
	xxp as xmp_pattern ptr ptr
	xxt as xmp_track ptr ptr
	xxi as xmp_instrument ptr
	xxs as xmp_sample ptr
	xxc(0 to 63) as xmp_channel
	xxo(0 to 255) as ubyte
end type

type xmp_test_info
	name as zstring * 64
	as zstring * 64 type
end type

const XMP_PERIOD_BASE = 6847

type xmp_module_info
	md5(0 to 15) as ubyte
	vol_base as long
	mod_ as xmp_module ptr
	comment as zstring ptr
	num_sequences as long
	seq_data as xmp_sequence ptr
end type

type xmp_channel_info
	period as ulong
	position as ulong
	pitchbend as short
	note as ubyte
	instrument as ubyte
	sample as ubyte
	volume as ubyte
	pan as ubyte
	reserved as ubyte
	event as xmp_event
end type

type xmp_frame_info
	pos as long
	pattern as long
	row as long
	num_rows as long
	frame as long
	speed as long
	bpm as long
	time as long
	total_time as long
	frame_time as long
	buffer as any ptr
	buffer_size as long
	total_size as long
	volume as long
	loop_count as long
	virt_channels as long
	virt_used as long
	sequence as long
	channel_info(0 to 63) as xmp_channel_info
end type

type xmp_context as zstring ptr

#if defined(__FB_WIN32__) and (not defined(BUILDING_STATIC))
	extern import xmp_version as const zstring ptr
	extern import xmp_vercode as const ulong
#else
	extern xmp_version as const zstring ptr
	extern xmp_vercode as const ulong
#endif

declare function xmp_create_context() as xmp_context
declare sub xmp_free_context(byval as xmp_context)
declare function xmp_test_module(byval as zstring ptr, byval as xmp_test_info ptr) as long
declare function xmp_load_module(byval as xmp_context, byval as zstring ptr) as long
declare sub xmp_scan_module(byval as xmp_context)
declare sub xmp_release_module(byval as xmp_context)
declare function xmp_start_player(byval as xmp_context, byval as long, byval as long) as long
declare function xmp_play_frame(byval as xmp_context) as long
declare function xmp_play_buffer(byval as xmp_context, byval as any ptr, byval as long, byval as long) as long
declare sub xmp_get_frame_info(byval as xmp_context, byval as xmp_frame_info ptr)
declare sub xmp_end_player(byval as xmp_context)
declare sub xmp_inject_event(byval as xmp_context, byval as long, byval as xmp_event ptr)
declare sub xmp_get_module_info(byval as xmp_context, byval as xmp_module_info ptr)
declare function xmp_get_format_list() as zstring ptr ptr
declare function xmp_next_position(byval as xmp_context) as long
declare function xmp_prev_position(byval as xmp_context) as long
declare function xmp_set_position(byval as xmp_context, byval as long) as long
declare sub xmp_stop_module(byval as xmp_context)
declare sub xmp_restart_module(byval as xmp_context)
declare function xmp_seek_time(byval as xmp_context, byval as long) as long
declare function xmp_channel_mute(byval as xmp_context, byval as long, byval as long) as long
declare function xmp_channel_vol(byval as xmp_context, byval as long, byval as long) as long
declare function xmp_set_player(byval as xmp_context, byval as long, byval as long) as long
declare function xmp_get_player(byval as xmp_context, byval as long) as long
declare function xmp_set_instrument_path(byval as xmp_context, byval as zstring ptr) as long
declare function xmp_load_module_from_memory(byval as xmp_context, byval as any ptr, byval as clong) as long
declare function xmp_load_module_from_file(byval as xmp_context, byval as any ptr, byval as clong) as long
declare function xmp_start_smix(byval as xmp_context, byval as long, byval as long) as long
declare sub xmp_end_smix(byval as xmp_context)
declare function xmp_smix_play_instrument(byval as xmp_context, byval as long, byval as long, byval as long, byval as long) as long
declare function xmp_smix_play_sample(byval as xmp_context, byval as long, byval as long, byval as long, byval as long) as long
declare function xmp_smix_channel_pan(byval as xmp_context, byval as long, byval as long) as long
declare function xmp_smix_load_sample(byval as xmp_context, byval as long, byval as zstring ptr) as long
declare function xmp_smix_release_sample(byval as xmp_context, byval as long) as long

end extern
