'' FreeBASIC binding for libsndfile-1.0.25
''
'' based on the C header files:
''   * Copyright (C) 1999-2011Erik de Castro Lopo <erikd@mega-nerd.com>
''   *
''   * This program is free software; you can redistribute it and/or modify
''   * it under the terms of the GNU Lesser General Public License as published by
''   * the Free Software Foundation; either version 2.1 of the License, or
''   * (at your option) any later version.
''   *
''   * This program is distributed in the hope that it will be useful,
''   * but WITHOUT ANY WARRANTY; without even the implied warranty of
''   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''   * GNU Lesser General Public License for more details.
''   *
''   * You should have received a copy of the GNU Lesser General Public License
''   * along with this program; if not, write to the Free Software
''   * Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA 02111-1301, USA.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "sndfile"

#include once "crt/stdio.bi"
#include once "crt/sys/types.bi"

extern "C"

#define SNDFILE_H
#define SNDFILE_1

enum
	SF_FORMAT_WAV = &h010000
	SF_FORMAT_AIFF = &h020000
	SF_FORMAT_AU = &h030000
	SF_FORMAT_RAW = &h040000
	SF_FORMAT_PAF = &h050000
	SF_FORMAT_SVX = &h060000
	SF_FORMAT_NIST = &h070000
	SF_FORMAT_VOC = &h080000
	SF_FORMAT_IRCAM = &h0A0000
	SF_FORMAT_W64 = &h0B0000
	SF_FORMAT_MAT4 = &h0C0000
	SF_FORMAT_MAT5 = &h0D0000
	SF_FORMAT_PVF = &h0E0000
	SF_FORMAT_XI = &h0F0000
	SF_FORMAT_HTK = &h100000
	SF_FORMAT_SDS = &h110000
	SF_FORMAT_AVR = &h120000
	SF_FORMAT_WAVEX = &h130000
	SF_FORMAT_SD2 = &h160000
	SF_FORMAT_FLAC = &h170000
	SF_FORMAT_CAF = &h180000
	SF_FORMAT_WVE = &h190000
	SF_FORMAT_OGG = &h200000
	SF_FORMAT_MPC2K = &h210000
	SF_FORMAT_RF64 = &h220000
	SF_FORMAT_PCM_S8 = &h0001
	SF_FORMAT_PCM_16 = &h0002
	SF_FORMAT_PCM_24 = &h0003
	SF_FORMAT_PCM_32 = &h0004
	SF_FORMAT_PCM_U8 = &h0005
	SF_FORMAT_FLOAT = &h0006
	SF_FORMAT_DOUBLE = &h0007
	SF_FORMAT_ULAW = &h0010
	SF_FORMAT_ALAW = &h0011
	SF_FORMAT_IMA_ADPCM = &h0012
	SF_FORMAT_MS_ADPCM = &h0013
	SF_FORMAT_GSM610 = &h0020
	SF_FORMAT_VOX_ADPCM = &h0021
	SF_FORMAT_G721_32 = &h0030
	SF_FORMAT_G723_24 = &h0031
	SF_FORMAT_G723_40 = &h0032
	SF_FORMAT_DWVW_12 = &h0040
	SF_FORMAT_DWVW_16 = &h0041
	SF_FORMAT_DWVW_24 = &h0042
	SF_FORMAT_DWVW_N = &h0043
	SF_FORMAT_DPCM_8 = &h0050
	SF_FORMAT_DPCM_16 = &h0051
	SF_FORMAT_VORBIS = &h0060
	SF_ENDIAN_FILE = &h00000000
	SF_ENDIAN_LITTLE = &h10000000
	SF_ENDIAN_BIG = &h20000000
	SF_ENDIAN_CPU = &h30000000
	SF_FORMAT_SUBMASK = &h0000FFFF
	SF_FORMAT_TYPEMASK = &h0FFF0000
	SF_FORMAT_ENDMASK = &h30000000
end enum

enum
	SFC_GET_LIB_VERSION = &h1000
	SFC_GET_LOG_INFO = &h1001
	SFC_GET_CURRENT_SF_INFO = &h1002
	SFC_GET_NORM_DOUBLE = &h1010
	SFC_GET_NORM_FLOAT = &h1011
	SFC_SET_NORM_DOUBLE = &h1012
	SFC_SET_NORM_FLOAT = &h1013
	SFC_SET_SCALE_FLOAT_INT_READ = &h1014
	SFC_SET_SCALE_INT_FLOAT_WRITE = &h1015
	SFC_GET_SIMPLE_FORMAT_COUNT = &h1020
	SFC_GET_SIMPLE_FORMAT = &h1021
	SFC_GET_FORMAT_INFO = &h1028
	SFC_GET_FORMAT_MAJOR_COUNT = &h1030
	SFC_GET_FORMAT_MAJOR = &h1031
	SFC_GET_FORMAT_SUBTYPE_COUNT = &h1032
	SFC_GET_FORMAT_SUBTYPE = &h1033
	SFC_CALC_SIGNAL_MAX = &h1040
	SFC_CALC_NORM_SIGNAL_MAX = &h1041
	SFC_CALC_MAX_ALL_CHANNELS = &h1042
	SFC_CALC_NORM_MAX_ALL_CHANNELS = &h1043
	SFC_GET_SIGNAL_MAX = &h1044
	SFC_GET_MAX_ALL_CHANNELS = &h1045
	SFC_SET_ADD_PEAK_CHUNK = &h1050
	SFC_SET_ADD_HEADER_PAD_CHUNK = &h1051
	SFC_UPDATE_HEADER_NOW = &h1060
	SFC_SET_UPDATE_HEADER_AUTO = &h1061
	SFC_FILE_TRUNCATE = &h1080
	SFC_SET_RAW_START_OFFSET = &h1090
	SFC_SET_DITHER_ON_WRITE = &h10A0
	SFC_SET_DITHER_ON_READ = &h10A1
	SFC_GET_DITHER_INFO_COUNT = &h10A2
	SFC_GET_DITHER_INFO = &h10A3
	SFC_GET_EMBED_FILE_INFO = &h10B0
	SFC_SET_CLIPPING = &h10C0
	SFC_GET_CLIPPING = &h10C1
	SFC_GET_INSTRUMENT = &h10D0
	SFC_SET_INSTRUMENT = &h10D1
	SFC_GET_LOOP_INFO = &h10E0
	SFC_GET_BROADCAST_INFO = &h10F0
	SFC_SET_BROADCAST_INFO = &h10F1
	SFC_GET_CHANNEL_MAP_INFO = &h1100
	SFC_SET_CHANNEL_MAP_INFO = &h1101
	SFC_RAW_DATA_NEEDS_ENDSWAP = &h1110
	SFC_WAVEX_SET_AMBISONIC = &h1200
	SFC_WAVEX_GET_AMBISONIC = &h1201
	SFC_SET_VBR_ENCODING_QUALITY = &h1300
	SFC_TEST_IEEE_FLOAT_REPLACE = &h6001
	SFC_SET_ADD_DITHER_ON_WRITE = &h1070
	SFC_SET_ADD_DITHER_ON_READ = &h1071
end enum

enum
	SF_STR_TITLE = &h01
	SF_STR_COPYRIGHT = &h02
	SF_STR_SOFTWARE = &h03
	SF_STR_ARTIST = &h04
	SF_STR_COMMENT = &h05
	SF_STR_DATE = &h06
	SF_STR_ALBUM = &h07
	SF_STR_LICENSE = &h08
	SF_STR_TRACKNUMBER = &h09
	SF_STR_GENRE = &h10
end enum

const SF_STR_FIRST = SF_STR_TITLE
const SF_STR_LAST = SF_STR_GENRE

enum
	SF_FALSE = 0
	SF_TRUE = 1
	SFM_READ = &h10
	SFM_WRITE = &h20
	SFM_RDWR = &h30
	SF_AMBISONIC_NONE = &h40
	SF_AMBISONIC_B_FORMAT = &h41
end enum

enum
	SF_ERR_NO_ERROR = 0
	SF_ERR_UNRECOGNISED_FORMAT = 1
	SF_ERR_SYSTEM = 2
	SF_ERR_MALFORMED_FILE = 3
	SF_ERR_UNSUPPORTED_ENCODING = 4
end enum

enum
	SF_CHANNEL_MAP_INVALID = 0
	SF_CHANNEL_MAP_MONO = 1
	SF_CHANNEL_MAP_LEFT
	SF_CHANNEL_MAP_RIGHT
	SF_CHANNEL_MAP_CENTER
	SF_CHANNEL_MAP_FRONT_LEFT
	SF_CHANNEL_MAP_FRONT_RIGHT
	SF_CHANNEL_MAP_FRONT_CENTER
	SF_CHANNEL_MAP_REAR_CENTER
	SF_CHANNEL_MAP_REAR_LEFT
	SF_CHANNEL_MAP_REAR_RIGHT
	SF_CHANNEL_MAP_LFE
	SF_CHANNEL_MAP_FRONT_LEFT_OF_CENTER
	SF_CHANNEL_MAP_FRONT_RIGHT_OF_CENTER
	SF_CHANNEL_MAP_SIDE_LEFT
	SF_CHANNEL_MAP_SIDE_RIGHT
	SF_CHANNEL_MAP_TOP_CENTER
	SF_CHANNEL_MAP_TOP_FRONT_LEFT
	SF_CHANNEL_MAP_TOP_FRONT_RIGHT
	SF_CHANNEL_MAP_TOP_FRONT_CENTER
	SF_CHANNEL_MAP_TOP_REAR_LEFT
	SF_CHANNEL_MAP_TOP_REAR_RIGHT
	SF_CHANNEL_MAP_TOP_REAR_CENTER
	SF_CHANNEL_MAP_AMBISONIC_B_W
	SF_CHANNEL_MAP_AMBISONIC_B_X
	SF_CHANNEL_MAP_AMBISONIC_B_Y
	SF_CHANNEL_MAP_AMBISONIC_B_Z
	SF_CHANNEL_MAP_MAX
end enum

type SNDFILE as SNDFILE_tag
type sf_count_t as longint
const SF_COUNT_MAX = &h7FFFFFFFFFFFFFFFll

type SF_INFO
	frames as sf_count_t
	samplerate as long
	channels as long
	format as long
	sections as long
	seekable as long
end type

type SF_FORMAT_INFO
	format as long
	name as const zstring ptr
	extension as const zstring ptr
end type

enum
	SFD_DEFAULT_LEVEL = 0
	SFD_CUSTOM_LEVEL = &h40000000
	SFD_NO_DITHER = 500
	SFD_WHITE = 501
	SFD_TRIANGULAR_PDF = 502
end enum

type SF_DITHER_INFO
	as long type
	level as double
	name as const zstring ptr
end type

type SF_EMBED_FILE_INFO
	offset as sf_count_t
	length as sf_count_t
end type

enum
	SF_LOOP_NONE = 800
	SF_LOOP_FORWARD
	SF_LOOP_BACKWARD
	SF_LOOP_ALTERNATING
end enum

type SF_INSTRUMENT_loops
	mode as long
	start as ulong
	as ulong end
	count as ulong
end type

type SF_INSTRUMENT
	gain as long
	basenote as byte
	detune as byte
	velocity_lo as byte
	velocity_hi as byte
	key_lo as byte
	key_hi as byte
	loop_count as long
	loops(0 to 15) as SF_INSTRUMENT_loops
end type

type SF_LOOP_INFO
	time_sig_num as short
	time_sig_den as short
	loop_mode as long
	num_beats as long
	bpm as single
	root_key as long
	future(0 to 5) as long
end type

type SF_BROADCAST_INFO
	description as zstring * 256
	originator as zstring * 32
	originator_reference as zstring * 32
	origination_date as zstring * 10
	origination_time as zstring * 8
	time_reference_low as ulong
	time_reference_high as ulong
	version as short
	umid as zstring * 64
	reserved as zstring * 190
	coding_history_size as ulong
	coding_history as zstring * 256
end type

type sf_vio_get_filelen as function(byval user_data as any ptr) as sf_count_t
type sf_vio_seek as function(byval offset as sf_count_t, byval whence as long, byval user_data as any ptr) as sf_count_t
type sf_vio_read as function(byval ptr as any ptr, byval count as sf_count_t, byval user_data as any ptr) as sf_count_t
type sf_vio_write as function(byval ptr as const any ptr, byval count as sf_count_t, byval user_data as any ptr) as sf_count_t
type sf_vio_tell as function(byval user_data as any ptr) as sf_count_t

type SF_VIRTUAL_IO
	get_filelen as sf_vio_get_filelen
	seek as sf_vio_seek
	read as sf_vio_read
	write as sf_vio_write
	tell as sf_vio_tell
end type

declare function sf_open(byval path as const zstring ptr, byval mode as long, byval sfinfo as SF_INFO ptr) as SNDFILE ptr
declare function sf_open_fd(byval fd as long, byval mode as long, byval sfinfo as SF_INFO ptr, byval close_desc as long) as SNDFILE ptr
declare function sf_open_virtual(byval sfvirtual as SF_VIRTUAL_IO ptr, byval mode as long, byval sfinfo as SF_INFO ptr, byval user_data as any ptr) as SNDFILE ptr
declare function sf_error(byval sndfile as SNDFILE ptr) as long
declare function sf_strerror(byval sndfile as SNDFILE ptr) as const zstring ptr
declare function sf_error_number(byval errnum as long) as const zstring ptr
declare function sf_perror(byval sndfile as SNDFILE ptr) as long
declare function sf_error_str(byval sndfile as SNDFILE ptr, byval str as zstring ptr, byval len as uinteger) as long
declare function sf_command(byval sndfile as SNDFILE ptr, byval command as long, byval data as any ptr, byval datasize as long) as long
declare function sf_format_check(byval info as const SF_INFO ptr) as long
declare function sf_seek(byval sndfile as SNDFILE ptr, byval frames as sf_count_t, byval whence as long) as sf_count_t
declare function sf_set_string(byval sndfile as SNDFILE ptr, byval str_type as long, byval str as const zstring ptr) as long
declare function sf_get_string(byval sndfile as SNDFILE ptr, byval str_type as long) as const zstring ptr
declare function sf_version_string() as const zstring ptr
declare function sf_read_raw(byval sndfile as SNDFILE ptr, byval ptr as any ptr, byval bytes as sf_count_t) as sf_count_t
declare function sf_write_raw(byval sndfile as SNDFILE ptr, byval ptr as const any ptr, byval bytes as sf_count_t) as sf_count_t
declare function sf_readf_short(byval sndfile as SNDFILE ptr, byval ptr as short ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_writef_short(byval sndfile as SNDFILE ptr, byval ptr as const short ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_readf_int(byval sndfile as SNDFILE ptr, byval ptr as long ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_writef_int(byval sndfile as SNDFILE ptr, byval ptr as const long ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_readf_float(byval sndfile as SNDFILE ptr, byval ptr as single ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_writef_float(byval sndfile as SNDFILE ptr, byval ptr as const single ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_readf_double(byval sndfile as SNDFILE ptr, byval ptr as double ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_writef_double(byval sndfile as SNDFILE ptr, byval ptr as const double ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_read_short(byval sndfile as SNDFILE ptr, byval ptr as short ptr, byval items as sf_count_t) as sf_count_t
declare function sf_write_short(byval sndfile as SNDFILE ptr, byval ptr as const short ptr, byval items as sf_count_t) as sf_count_t
declare function sf_read_int(byval sndfile as SNDFILE ptr, byval ptr as long ptr, byval items as sf_count_t) as sf_count_t
declare function sf_write_int(byval sndfile as SNDFILE ptr, byval ptr as const long ptr, byval items as sf_count_t) as sf_count_t
declare function sf_read_float(byval sndfile as SNDFILE ptr, byval ptr as single ptr, byval items as sf_count_t) as sf_count_t
declare function sf_write_float(byval sndfile as SNDFILE ptr, byval ptr as const single ptr, byval items as sf_count_t) as sf_count_t
declare function sf_read_double(byval sndfile as SNDFILE ptr, byval ptr as double ptr, byval items as sf_count_t) as sf_count_t
declare function sf_write_double(byval sndfile as SNDFILE ptr, byval ptr as const double ptr, byval items as sf_count_t) as sf_count_t
declare function sf_close(byval sndfile as SNDFILE ptr) as long
declare sub sf_write_sync(byval sndfile as SNDFILE ptr)

end extern
