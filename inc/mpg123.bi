'' FreeBASIC binding for mpg123-1.22.4
''
'' based on the C header files:
''   libmpg123: MPEG Audio Decoder library (version 1.22.4)
''
''   copyright 1995-2010 by the mpg123 project - free software under the terms of the LGPL 2.1
''   see COPYING and AUTHORS files in distribution or http://mpg123.org
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "mpg123"

#include once "crt/long.bi"
#include once "crt/sys/types.bi"

'' The following symbols have been renamed:
''     constant MPG123_ID3 => MPG123_ID3_
''     constant MPG123_ICY => MPG123_ICY_

extern "C"

#define MPG123_LIB_H
const MPG123_API_VERSION = 41
type mpg123_handle as mpg123_handle_struct
declare function mpg123_init() as long
declare sub mpg123_exit()
declare function mpg123_new(byval decoder as const zstring ptr, byval error as long ptr) as mpg123_handle ptr
declare sub mpg123_delete(byval mh as mpg123_handle ptr)

type mpg123_parms as long
enum
	MPG123_VERBOSE = 0
	MPG123_FLAGS
	MPG123_ADD_FLAGS
	MPG123_FORCE_RATE
	MPG123_DOWN_SAMPLE
	MPG123_RVA
	MPG123_DOWNSPEED
	MPG123_UPSPEED
	MPG123_START_FRAME
	MPG123_DECODE_FRAMES
	MPG123_ICY_INTERVAL
	MPG123_OUTSCALE
	MPG123_TIMEOUT
	MPG123_REMOVE_FLAGS
	MPG123_RESYNC_LIMIT
	MPG123_INDEX_SIZE
	MPG123_PREFRAMES
	MPG123_FEEDPOOL
	MPG123_FEEDBUFFER
end enum

type mpg123_param_flags as long
enum
	MPG123_FORCE_MONO = &h7
	MPG123_MONO_LEFT = &h1
	MPG123_MONO_RIGHT = &h2
	MPG123_MONO_MIX = &h4
	MPG123_FORCE_STEREO = &h8
	MPG123_FORCE_8BIT = &h10
	MPG123_QUIET = &h20
	MPG123_GAPLESS = &h40
	MPG123_NO_RESYNC = &h80
	MPG123_SEEKBUFFER = &h100
	MPG123_FUZZY = &h200
	MPG123_FORCE_FLOAT = &h400
	MPG123_PLAIN_ID3TEXT = &h800
	MPG123_IGNORE_STREAMLENGTH = &h1000
	MPG123_SKIP_ID3V2 = &h2000
	MPG123_IGNORE_INFOFRAME = &h4000
	MPG123_AUTO_RESAMPLE = &h8000
	MPG123_PICTURE = &h10000
end enum

type mpg123_param_rva as long
enum
	MPG123_RVA_OFF = 0
	MPG123_RVA_MIX = 1
	MPG123_RVA_ALBUM = 2
	MPG123_RVA_MAX = MPG123_RVA_ALBUM
end enum

declare function mpg123_param(byval mh as mpg123_handle ptr, byval type as mpg123_parms, byval value as clong, byval fvalue as double) as long
declare function mpg123_getparam(byval mh as mpg123_handle ptr, byval type as mpg123_parms, byval val as clong ptr, byval fval as double ptr) as long

type mpg123_feature_set as long
enum
	MPG123_FEATURE_ABI_UTF8OPEN = 0
	MPG123_FEATURE_OUTPUT_8BIT
	MPG123_FEATURE_OUTPUT_16BIT
	MPG123_FEATURE_OUTPUT_32BIT
	MPG123_FEATURE_INDEX
	MPG123_FEATURE_PARSE_ID3V2
	MPG123_FEATURE_DECODE_LAYER1
	MPG123_FEATURE_DECODE_LAYER2
	MPG123_FEATURE_DECODE_LAYER3
	MPG123_FEATURE_DECODE_ACCURATE
	MPG123_FEATURE_DECODE_DOWNSAMPLE
	MPG123_FEATURE_DECODE_NTOM
	MPG123_FEATURE_PARSE_ICY
	MPG123_FEATURE_TIMEOUT_READ
end enum

declare function mpg123_feature(byval key as const mpg123_feature_set) as long

type mpg123_errors as long
enum
	MPG123_DONE = -12
	MPG123_NEW_FORMAT = -11
	MPG123_NEED_MORE = -10
	MPG123_ERR = -1
	MPG123_OK = 0
	MPG123_BAD_OUTFORMAT
	MPG123_BAD_CHANNEL
	MPG123_BAD_RATE
	MPG123_ERR_16TO8TABLE
	MPG123_BAD_PARAM
	MPG123_BAD_BUFFER
	MPG123_OUT_OF_MEM
	MPG123_NOT_INITIALIZED
	MPG123_BAD_DECODER
	MPG123_BAD_HANDLE
	MPG123_NO_BUFFERS
	MPG123_BAD_RVA
	MPG123_NO_GAPLESS
	MPG123_NO_SPACE
	MPG123_BAD_TYPES
	MPG123_BAD_BAND
	MPG123_ERR_NULL
	MPG123_ERR_READER
	MPG123_NO_SEEK_FROM_END
	MPG123_BAD_WHENCE
	MPG123_NO_TIMEOUT
	MPG123_BAD_FILE
	MPG123_NO_SEEK
	MPG123_NO_READER
	MPG123_BAD_PARS
	MPG123_BAD_INDEX_PAR
	MPG123_OUT_OF_SYNC
	MPG123_RESYNC_FAIL
	MPG123_NO_8BIT
	MPG123_BAD_ALIGN
	MPG123_NULL_BUFFER
	MPG123_NO_RELSEEK
	MPG123_NULL_POINTER
	MPG123_BAD_KEY
	MPG123_NO_INDEX
	MPG123_INDEX_FAIL
	MPG123_BAD_DECODER_SETUP
	MPG123_MISSING_FEATURE
	MPG123_BAD_VALUE
	MPG123_LSEEK_FAILED
	MPG123_BAD_CUSTOM_IO
	MPG123_LFS_OVERFLOW
	MPG123_INT_OVERFLOW
end enum

declare function mpg123_plain_strerror(byval errcode as long) as const zstring ptr
declare function mpg123_strerror(byval mh as mpg123_handle ptr) as const zstring ptr
declare function mpg123_errcode(byval mh as mpg123_handle ptr) as long
declare function mpg123_decoders() as const zstring ptr ptr
declare function mpg123_supported_decoders() as const zstring ptr ptr
declare function mpg123_decoder(byval mh as mpg123_handle ptr, byval decoder_name as const zstring ptr) as long
declare function mpg123_current_decoder(byval mh as mpg123_handle ptr) as const zstring ptr

type mpg123_enc_enum as long
enum
	MPG123_ENC_8 = &h00f
	MPG123_ENC_16 = &h040
	MPG123_ENC_24 = &h4000
	MPG123_ENC_32 = &h100
	MPG123_ENC_SIGNED = &h080
	MPG123_ENC_FLOAT = &he00
	MPG123_ENC_SIGNED_16 = (MPG123_ENC_16 or MPG123_ENC_SIGNED) or &h10
	MPG123_ENC_UNSIGNED_16 = MPG123_ENC_16 or &h20
	MPG123_ENC_UNSIGNED_8 = &h01
	MPG123_ENC_SIGNED_8 = MPG123_ENC_SIGNED or &h02
	MPG123_ENC_ULAW_8 = &h04
	MPG123_ENC_ALAW_8 = &h08
	MPG123_ENC_SIGNED_32 = (MPG123_ENC_32 or MPG123_ENC_SIGNED) or &h1000
	MPG123_ENC_UNSIGNED_32 = MPG123_ENC_32 or &h2000
	MPG123_ENC_SIGNED_24 = (MPG123_ENC_24 or MPG123_ENC_SIGNED) or &h1000
	MPG123_ENC_UNSIGNED_24 = MPG123_ENC_24 or &h2000
	MPG123_ENC_FLOAT_32 = &h200
	MPG123_ENC_FLOAT_64 = &h400
	MPG123_ENC_ANY = ((((((((((MPG123_ENC_SIGNED_16 or MPG123_ENC_UNSIGNED_16) or MPG123_ENC_UNSIGNED_8) or MPG123_ENC_SIGNED_8) or MPG123_ENC_ULAW_8) or MPG123_ENC_ALAW_8) or MPG123_ENC_SIGNED_32) or MPG123_ENC_UNSIGNED_32) or MPG123_ENC_SIGNED_24) or MPG123_ENC_UNSIGNED_24) or MPG123_ENC_FLOAT_32) or MPG123_ENC_FLOAT_64
end enum

type mpg123_channelcount as long
enum
	MPG123_MONO = 1
	MPG123_STEREO = 2
end enum

declare sub mpg123_rates(byval list as const clong ptr ptr, byval number as uinteger ptr)
declare sub mpg123_encodings(byval list as const long ptr ptr, byval number as uinteger ptr)
declare function mpg123_encsize(byval encoding as long) as long
declare function mpg123_format_none(byval mh as mpg123_handle ptr) as long
declare function mpg123_format_all(byval mh as mpg123_handle ptr) as long
declare function mpg123_format(byval mh as mpg123_handle ptr, byval rate as clong, byval channels as long, byval encodings as long) as long
declare function mpg123_format_support(byval mh as mpg123_handle ptr, byval rate as clong, byval encoding as long) as long
declare function mpg123_getformat(byval mh as mpg123_handle ptr, byval rate as clong ptr, byval channels as long ptr, byval encoding as long ptr) as long
declare function mpg123_open(byval mh as mpg123_handle ptr, byval path as const zstring ptr) as long
declare function mpg123_open_fd(byval mh as mpg123_handle ptr, byval fd as long) as long
declare function mpg123_open_handle(byval mh as mpg123_handle ptr, byval iohandle as any ptr) as long
declare function mpg123_open_feed(byval mh as mpg123_handle ptr) as long
declare function mpg123_close(byval mh as mpg123_handle ptr) as long
declare function mpg123_read(byval mh as mpg123_handle ptr, byval outmemory as ubyte ptr, byval outmemsize as uinteger, byval done as uinteger ptr) as long
declare function mpg123_feed(byval mh as mpg123_handle ptr, byval in as const ubyte ptr, byval size as uinteger) as long
declare function mpg123_decode(byval mh as mpg123_handle ptr, byval inmemory as const ubyte ptr, byval inmemsize as uinteger, byval outmemory as ubyte ptr, byval outmemsize as uinteger, byval done as uinteger ptr) as long
declare function mpg123_decode_frame(byval mh as mpg123_handle ptr, byval num as off_t ptr, byval audio as ubyte ptr ptr, byval bytes as uinteger ptr) as long
declare function mpg123_framebyframe_decode(byval mh as mpg123_handle ptr, byval num as off_t ptr, byval audio as ubyte ptr ptr, byval bytes as uinteger ptr) as long
declare function mpg123_framebyframe_next(byval mh as mpg123_handle ptr) as long
declare function mpg123_framedata(byval mh as mpg123_handle ptr, byval header as culong ptr, byval bodydata as ubyte ptr ptr, byval bodybytes as uinteger ptr) as long
declare function mpg123_framepos(byval mh as mpg123_handle ptr) as off_t
declare function mpg123_tell(byval mh as mpg123_handle ptr) as off_t
declare function mpg123_tellframe(byval mh as mpg123_handle ptr) as off_t
declare function mpg123_tell_stream(byval mh as mpg123_handle ptr) as off_t
declare function mpg123_seek(byval mh as mpg123_handle ptr, byval sampleoff as off_t, byval whence as long) as off_t
declare function mpg123_feedseek(byval mh as mpg123_handle ptr, byval sampleoff as off_t, byval whence as long, byval input_offset as off_t ptr) as off_t
declare function mpg123_seek_frame(byval mh as mpg123_handle ptr, byval frameoff as off_t, byval whence as long) as off_t
declare function mpg123_timeframe(byval mh as mpg123_handle ptr, byval sec as double) as off_t
declare function mpg123_index(byval mh as mpg123_handle ptr, byval offsets as off_t ptr ptr, byval step as off_t ptr, byval fill as uinteger ptr) as long
declare function mpg123_set_index(byval mh as mpg123_handle ptr, byval offsets as off_t ptr, byval step as off_t, byval fill as uinteger) as long
declare function mpg123_position(byval mh as mpg123_handle ptr, byval frame_offset as off_t, byval buffered_bytes as off_t, byval current_frame as off_t ptr, byval frames_left as off_t ptr, byval current_seconds as double ptr, byval seconds_left as double ptr) as long

type mpg123_channels as long
enum
	MPG123_LEFT = &h1
	MPG123_RIGHT = &h2
	MPG123_LR = &h3
end enum

declare function mpg123_eq(byval mh as mpg123_handle ptr, byval channel as mpg123_channels, byval band as long, byval val as double) as long
declare function mpg123_geteq(byval mh as mpg123_handle ptr, byval channel as mpg123_channels, byval band as long) as double
declare function mpg123_reset_eq(byval mh as mpg123_handle ptr) as long
declare function mpg123_volume(byval mh as mpg123_handle ptr, byval vol as double) as long
declare function mpg123_volume_change(byval mh as mpg123_handle ptr, byval change as double) as long
declare function mpg123_getvolume(byval mh as mpg123_handle ptr, byval base as double ptr, byval really as double ptr, byval rva_db as double ptr) as long

type mpg123_vbr as long
enum
	MPG123_CBR = 0
	MPG123_VBR
	MPG123_ABR
end enum

type mpg123_version as long
enum
	MPG123_1_0 = 0
	MPG123_2_0
	MPG123_2_5
end enum

type mpg123_mode as long
enum
	MPG123_M_STEREO = 0
	MPG123_M_JOINT
	MPG123_M_DUAL
	MPG123_M_MONO
end enum

type mpg123_flags as long
enum
	MPG123_CRC = &h1
	MPG123_COPYRIGHT = &h2
	MPG123_PRIVATE = &h4
	MPG123_ORIGINAL = &h8
end enum

type mpg123_frameinfo
	version as mpg123_version
	layer as long
	rate as clong
	mode as mpg123_mode
	mode_ext as long
	framesize as long
	flags as mpg123_flags
	emphasis as long
	bitrate as long
	abr_rate as long
	vbr as mpg123_vbr
end type

declare function mpg123_info(byval mh as mpg123_handle ptr, byval mi as mpg123_frameinfo ptr) as long
declare function mpg123_safe_buffer() as uinteger
declare function mpg123_scan(byval mh as mpg123_handle ptr) as long
declare function mpg123_length(byval mh as mpg123_handle ptr) as off_t
declare function mpg123_set_filesize(byval mh as mpg123_handle ptr, byval size as off_t) as long
declare function mpg123_tpf(byval mh as mpg123_handle ptr) as double
declare function mpg123_spf(byval mh as mpg123_handle ptr) as long
declare function mpg123_clip(byval mh as mpg123_handle ptr) as clong

type mpg123_state as long
enum
	MPG123_ACCURATE = 1
	MPG123_BUFFERFILL
	MPG123_FRANKENSTEIN
	MPG123_FRESH_DECODER
end enum

declare function mpg123_getstate(byval mh as mpg123_handle ptr, byval key as mpg123_state, byval val as clong ptr, byval fval as double ptr) as long

type mpg123_string
	p as zstring ptr
	size as uinteger
	fill as uinteger
end type

declare sub mpg123_init_string(byval sb as mpg123_string ptr)
declare sub mpg123_free_string(byval sb as mpg123_string ptr)
declare function mpg123_resize_string(byval sb as mpg123_string ptr, byval news as uinteger) as long
declare function mpg123_grow_string(byval sb as mpg123_string ptr, byval news as uinteger) as long
declare function mpg123_copy_string(byval from as mpg123_string ptr, byval to as mpg123_string ptr) as long
declare function mpg123_add_string(byval sb as mpg123_string ptr, byval stuff as const zstring ptr) as long
declare function mpg123_add_substring(byval sb as mpg123_string ptr, byval stuff as const zstring ptr, byval from as uinteger, byval count as uinteger) as long
declare function mpg123_set_string(byval sb as mpg123_string ptr, byval stuff as const zstring ptr) as long
declare function mpg123_set_substring(byval sb as mpg123_string ptr, byval stuff as const zstring ptr, byval from as uinteger, byval count as uinteger) as long
declare function mpg123_strlen(byval sb as mpg123_string ptr, byval utf8 as long) as uinteger
declare function mpg123_chomp_string(byval sb as mpg123_string ptr) as long

type mpg123_text_encoding as long
enum
	mpg123_text_unknown = 0
	mpg123_text_utf8 = 1
	mpg123_text_latin1 = 2
	mpg123_text_icy = 3
	mpg123_text_cp1252 = 4
	mpg123_text_utf16 = 5
	mpg123_text_utf16bom = 6
	mpg123_text_utf16be = 7
	mpg123_text_max = 7
end enum

type mpg123_id3_enc as long
enum
	mpg123_id3_latin1 = 0
	mpg123_id3_utf16bom = 1
	mpg123_id3_utf16be = 2
	mpg123_id3_utf8 = 3
	mpg123_id3_enc_max = 3
end enum

declare function mpg123_enc_from_id3(byval id3_enc_byte as ubyte) as mpg123_text_encoding
declare function mpg123_store_utf8(byval sb as mpg123_string ptr, byval enc as mpg123_text_encoding, byval source as const ubyte ptr, byval source_size as uinteger) as long

type mpg123_text
	lang as zstring * 3
	id as zstring * 4
	description as mpg123_string
	text as mpg123_string
end type

type mpg123_id3_pic_type as long
enum
	mpg123_id3_pic_other = 0
	mpg123_id3_pic_icon = 1
	mpg123_id3_pic_other_icon = 2
	mpg123_id3_pic_front_cover = 3
	mpg123_id3_pic_back_cover = 4
	mpg123_id3_pic_leaflet = 5
	mpg123_id3_pic_media = 6
	mpg123_id3_pic_lead = 7
	mpg123_id3_pic_artist = 8
	mpg123_id3_pic_conductor = 9
	mpg123_id3_pic_orchestra = 10
	mpg123_id3_pic_composer = 11
	mpg123_id3_pic_lyricist = 12
	mpg123_id3_pic_location = 13
	mpg123_id3_pic_recording = 14
	mpg123_id3_pic_performance = 15
	mpg123_id3_pic_video = 16
	mpg123_id3_pic_fish = 17
	mpg123_id3_pic_illustration = 18
	mpg123_id3_pic_artist_logo = 19
	mpg123_id3_pic_publisher_logo = 20
end enum

type mpg123_picture
	as byte type
	description as mpg123_string
	mime_type as mpg123_string
	size as uinteger
	data as ubyte ptr
end type

type mpg123_id3v2
	version as ubyte
	title as mpg123_string ptr
	artist as mpg123_string ptr
	album as mpg123_string ptr
	year as mpg123_string ptr
	genre as mpg123_string ptr
	comment as mpg123_string ptr
	comment_list as mpg123_text ptr
	comments as uinteger
	text as mpg123_text ptr
	texts as uinteger
	extra as mpg123_text ptr
	extras as uinteger
	picture as mpg123_picture ptr
	pictures as uinteger
end type

type mpg123_id3v1
	tag as zstring * 3
	title as zstring * 30
	artist as zstring * 30
	album as zstring * 30
	year as zstring * 4
	comment as zstring * 30
	genre as ubyte
end type

const MPG123_ID3_ = &h3
const MPG123_NEW_ID3 = &h1
const MPG123_ICY_ = &hc
const MPG123_NEW_ICY = &h4

declare function mpg123_meta_check(byval mh as mpg123_handle ptr) as long
declare sub mpg123_meta_free(byval mh as mpg123_handle ptr)
declare function mpg123_id3(byval mh as mpg123_handle ptr, byval v1 as mpg123_id3v1 ptr ptr, byval v2 as mpg123_id3v2 ptr ptr) as long
declare function mpg123_icy(byval mh as mpg123_handle ptr, byval icy_meta as zstring ptr ptr) as long
declare function mpg123_icy2utf8(byval icy_text as const zstring ptr) as zstring ptr
type mpg123_pars as mpg123_pars_struct
declare function mpg123_parnew(byval mp as mpg123_pars ptr, byval decoder as const zstring ptr, byval error as long ptr) as mpg123_handle ptr
declare function mpg123_new_pars(byval error as long ptr) as mpg123_pars ptr
declare sub mpg123_delete_pars(byval mp as mpg123_pars ptr)
declare function mpg123_fmt_none(byval mp as mpg123_pars ptr) as long
declare function mpg123_fmt_all(byval mp as mpg123_pars ptr) as long
declare function mpg123_fmt(byval mp as mpg123_pars ptr, byval rate as clong, byval channels as long, byval encodings as long) as long
declare function mpg123_fmt_support(byval mp as mpg123_pars ptr, byval rate as clong, byval encoding as long) as long
declare function mpg123_par(byval mp as mpg123_pars ptr, byval type as mpg123_parms, byval value as clong, byval fvalue as double) as long
declare function mpg123_getpar(byval mp as mpg123_pars ptr, byval type as mpg123_parms, byval val as clong ptr, byval fval as double ptr) as long
declare function mpg123_replace_buffer(byval mh as mpg123_handle ptr, byval data as ubyte ptr, byval size as uinteger) as long
declare function mpg123_outblock(byval mh as mpg123_handle ptr) as uinteger
declare function mpg123_replace_reader(byval mh as mpg123_handle ptr, byval r_read as function(byval as long, byval as any ptr, byval as uinteger) as integer, byval r_lseek as function(byval as long, byval as off_t, byval as long) as off_t) as long
declare function mpg123_replace_reader_handle(byval mh as mpg123_handle ptr, byval r_read as function(byval as any ptr, byval as any ptr, byval as uinteger) as integer, byval r_lseek as function(byval as any ptr, byval as off_t, byval as long) as off_t, byval cleanup as sub(byval as any ptr)) as long

end extern
