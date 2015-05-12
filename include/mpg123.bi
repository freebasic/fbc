''
''
'' mpg123 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __mpg123_bi__
#define __mpg123_bi__

#inclib "mpg123"

type mpg123_handle as mpg123_handle_struct

declare function mpg123_init cdecl alias "mpg123_init" () as integer
declare sub mpg123_exit cdecl alias "mpg123_exit" ()
declare function mpg123_new cdecl alias "mpg123_new" (byval decoder as zstring ptr, byval error as integer ptr) as mpg123_handle ptr
declare sub mpg123_delete cdecl alias "mpg123_delete" (byval mh as mpg123_handle ptr)

enum mpg123_parms
	MPG123_VERBOSE
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
end enum

enum mpg123_param_flags
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
end enum

enum mpg123_param_rva
	MPG123_RVA_OFF = 0
	MPG123_RVA_MIX = 1
	MPG123_RVA_ALBUM = 2
	MPG123_RVA_MAX = MPG123_RVA_ALBUM
end enum

declare function mpg123_param cdecl alias "mpg123_param" (byval mh as mpg123_handle ptr, byval type as mpg123_parms, byval value as integer, byval fvalue as double) as integer
declare function mpg123_getparam cdecl alias "mpg123_getparam" (byval mh as mpg123_handle ptr, byval type as mpg123_parms, byval val as integer ptr, byval fval as double ptr) as integer

enum mpg123_errors
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
end enum

declare function mpg123_plain_strerror cdecl alias "mpg123_plain_strerror" (byval errcode as integer) as zstring ptr
declare function mpg123_strerror cdecl alias "mpg123_strerror" (byval mh as mpg123_handle ptr) as zstring ptr
declare function mpg123_errcode cdecl alias "mpg123_errcode" (byval mh as mpg123_handle ptr) as integer
declare function mpg123_decoders cdecl alias "mpg123_decoders" () as byte ptr ptr
declare function mpg123_supported_decoders cdecl alias "mpg123_supported_decoders" () as byte ptr ptr
declare function mpg123_decoder cdecl alias "mpg123_decoder" (byval mh as mpg123_handle ptr, byval decoder_name as zstring ptr) as integer
declare function mpg123_current_decoder cdecl alias "mpg123_current_decoder" (byval mh as mpg123_handle ptr) as zstring ptr

enum mpg123_enc_enum
	MPG123_ENC_8 = &h00f
	MPG123_ENC_16 = &h040
	MPG123_ENC_32 = &h100
	MPG123_ENC_SIGNED = &h080
	MPG123_ENC_FLOAT = &he00
	MPG123_ENC_SIGNED_16 = (MPG123_ENC_16 or MPG123_ENC_SIGNED or &h10)
	MPG123_ENC_UNSIGNED_16 = (MPG123_ENC_16 or &h20)
	MPG123_ENC_UNSIGNED_8 = &h01
	MPG123_ENC_SIGNED_8 = (MPG123_ENC_SIGNED or &h02)
	MPG123_ENC_ULAW_8 = &h04
	MPG123_ENC_ALAW_8 = &h08
	MPG123_ENC_SIGNED_32 = MPG123_ENC_32 or MPG123_ENC_SIGNED or &h1000
	MPG123_ENC_UNSIGNED_32 = MPG123_ENC_32 or &h2000
	MPG123_ENC_FLOAT_32 = &h200
	MPG123_ENC_FLOAT_64 = &h400
	MPG123_ENC_ANY = (MPG123_ENC_SIGNED_16 or MPG123_ENC_UNSIGNED_16 or MPG123_ENC_UNSIGNED_8 or MPG123_ENC_SIGNED_8 or MPG123_ENC_ULAW_8 or MPG123_ENC_ALAW_8 or MPG123_ENC_SIGNED_32 or MPG123_ENC_UNSIGNED_32 or MPG123_ENC_FLOAT_32 or MPG123_ENC_FLOAT_64)
end enum

enum mpg123_channelcount
	MPG123_MONO = 1
	MPG123_STEREO = 2
end enum

declare sub mpg123_rates cdecl alias "mpg123_rates" (byval list as integer ptr ptr, byval number as size_t ptr)
declare sub mpg123_encodings cdecl alias "mpg123_encodings" (byval list as integer ptr ptr, byval number as size_t ptr)
declare function mpg123_format_none cdecl alias "mpg123_format_none" (byval mh as mpg123_handle ptr) as integer
declare function mpg123_format_all cdecl alias "mpg123_format_all" (byval mh as mpg123_handle ptr) as integer
declare function mpg123_format cdecl alias "mpg123_format" (byval mh as mpg123_handle ptr, byval rate as integer, byval channels as integer, byval encodings as integer) as integer
declare function mpg123_format_support cdecl alias "mpg123_format_support" (byval mh as mpg123_handle ptr, byval rate as integer, byval encoding as integer) as integer
declare function mpg123_getformat cdecl alias "mpg123_getformat" (byval mh as mpg123_handle ptr, byval rate as integer ptr, byval channels as integer ptr, byval encoding as integer ptr) as integer
declare function mpg123_open_64 cdecl alias "mpg123_open_64" (byval mh as mpg123_handle ptr, byval path as zstring ptr) as integer
declare function mpg123_open_fd_64 cdecl alias "mpg123_open_fd_64" (byval mh as mpg123_handle ptr, byval fd as integer) as integer
declare function mpg123_open_feed cdecl alias "mpg123_open_feed" (byval mh as mpg123_handle ptr) as integer
declare function mpg123_close cdecl alias "mpg123_close" (byval mh as mpg123_handle ptr) as integer
declare function mpg123_read cdecl alias "mpg123_read" (byval mh as mpg123_handle ptr, byval outmemory as ubyte ptr, byval outmemsize as size_t, byval done as size_t ptr) as integer
declare function mpg123_feed cdecl alias "mpg123_feed" (byval mh as mpg123_handle ptr, byval in as ubyte ptr, byval size as size_t) as integer
declare function mpg123_decode cdecl alias "mpg123_decode" (byval mh as mpg123_handle ptr, byval inmemory as ubyte ptr, byval inmemsize as size_t, byval outmemory as ubyte ptr, byval outmemsize as size_t, byval done as size_t ptr) as integer
declare function mpg123_decode_frame_64 cdecl alias "mpg123_decode_frame_64" (byval mh as mpg123_handle ptr, byval num as off_t ptr, byval audio as ubyte ptr ptr, byval bytes as size_t ptr) as integer
declare function mpg123_tell_64 cdecl alias "mpg123_tell_64" (byval mh as mpg123_handle ptr) as off_t
declare function mpg123_tellframe_64 cdecl alias "mpg123_tellframe_64" (byval mh as mpg123_handle ptr) as off_t
declare function mpg123_tell_stream_64 cdecl alias "mpg123_tell_stream_64" (byval mh as mpg123_handle ptr) as off_t
declare function mpg123_seek_64 cdecl alias "mpg123_seek_64" (byval mh as mpg123_handle ptr, byval sampleoff as off_t, byval whence as integer) as off_t
declare function mpg123_feedseek_64 cdecl alias "mpg123_feedseek_64" (byval mh as mpg123_handle ptr, byval sampleoff as off_t, byval whence as integer, byval input_offset as off_t ptr) as off_t
declare function mpg123_seek_frame_64 cdecl alias "mpg123_seek_frame_64" (byval mh as mpg123_handle ptr, byval frameoff as off_t, byval whence as integer) as off_t
declare function mpg123_timeframe_64 cdecl alias "mpg123_timeframe_64" (byval mh as mpg123_handle ptr, byval sec as double) as off_t
declare function mpg123_index_64 cdecl alias "mpg123_index_64" (byval mh as mpg123_handle ptr, byval offsets as off_t ptr ptr, byval step as off_t ptr, byval fill as size_t ptr) as integer
declare function mpg123_position_64 cdecl alias "mpg123_position_64" (byval mh as mpg123_handle ptr, byval frame_offset as off_t, byval buffered_bytes as off_t, byval current_frame as off_t ptr, byval frames_left as off_t ptr, byval current_seconds as double ptr, byval seconds_left as double ptr) as integer

enum mpg123_channels
	MPG123_LEFT = &h1
	MPG123_RIGHT = &h2
	MPG123_LR = &h3
end enum

declare function mpg123_eq cdecl alias "mpg123_eq" (byval mh as mpg123_handle ptr, byval channel as mpg123_channels, byval band as integer, byval val as double) as integer
declare function mpg123_geteq cdecl alias "mpg123_geteq" (byval mh as mpg123_handle ptr, byval channel as mpg123_channels, byval band as integer) as double
declare function mpg123_reset_eq cdecl alias "mpg123_reset_eq" (byval mh as mpg123_handle ptr) as integer
declare function mpg123_volume cdecl alias "mpg123_volume" (byval mh as mpg123_handle ptr, byval vol as double) as integer
declare function mpg123_volume_change cdecl alias "mpg123_volume_change" (byval mh as mpg123_handle ptr, byval change as double) as integer
declare function mpg123_getvolume cdecl alias "mpg123_getvolume" (byval mh as mpg123_handle ptr, byval base as double ptr, byval really as double ptr, byval rva_db as double ptr) as integer

enum mpg123_vbr
	MPG123_CBR = 0
	MPG123_VBR
	MPG123_ABR
end enum

enum mpg123_version
	MPG123_1_0 = 0
	MPG123_2_0
	MPG123_2_5
end enum

enum mpg123_mode
	MPG123_M_STEREO = 0
	MPG123_M_JOINT
	MPG123_M_DUAL
	MPG123_M_MONO
end enum

enum mpg123_flags
	MPG123_CRC = &h1
	MPG123_COPYRIGHT = &h2
	MPG123_PRIVATE = &h4
	MPG123_ORIGINAL = &h8
end enum

type mpg123_frameinfo
	version as mpg123_version
	layer as integer
	rate as integer
	mode as mpg123_mode
	mode_ext as integer
	framesize as integer
	flags as mpg123_flags
	emphasis as integer
	bitrate as integer
	abr_rate as integer
	vbr as mpg123_vbr
end type

declare function mpg123_info cdecl alias "mpg123_info" (byval mh as mpg123_handle ptr, byval mi as mpg123_frameinfo ptr) as integer
declare function mpg123_safe_buffer cdecl alias "mpg123_safe_buffer" () as size_t
declare function mpg123_scan cdecl alias "mpg123_scan" (byval mh as mpg123_handle ptr) as integer
declare function mpg123_length_64 cdecl alias "mpg123_length_64" (byval mh as mpg123_handle ptr) as off_t
declare function mpg123_set_filesize_64 cdecl alias "mpg123_set_filesize_64" (byval mh as mpg123_handle ptr, byval size as off_t) as integer
declare function mpg123_tpf cdecl alias "mpg123_tpf" (byval mh as mpg123_handle ptr) as double
declare function mpg123_clip cdecl alias "mpg123_clip" (byval mh as mpg123_handle ptr) as integer

enum mpg123_state
	MPG123_ACCURATE = 1
end enum

declare function mpg123_getstate cdecl alias "mpg123_getstate" (byval mh as mpg123_handle ptr, byval key as mpg123_state, byval val as integer ptr, byval fval as double ptr) as integer

type mpg123_string
	p as zstring ptr
	size as size_t
	fill as size_t
end type

declare sub mpg123_init_string cdecl alias "mpg123_init_string" (byval sb as mpg123_string ptr)
declare sub mpg123_free_string cdecl alias "mpg123_free_string" (byval sb as mpg123_string ptr)
declare function mpg123_resize_string cdecl alias "mpg123_resize_string" (byval sb as mpg123_string ptr, byval news as size_t) as integer
declare function mpg123_grow_string cdecl alias "mpg123_grow_string" (byval sb as mpg123_string ptr, byval news as size_t) as integer
declare function mpg123_copy_string cdecl alias "mpg123_copy_string" (byval from as mpg123_string ptr, byval to as mpg123_string ptr) as integer
declare function mpg123_add_string cdecl alias "mpg123_add_string" (byval sb as mpg123_string ptr, byval stuff as zstring ptr) as integer
declare function mpg123_add_substring cdecl alias "mpg123_add_substring" (byval sb as mpg123_string ptr, byval stuff as zstring ptr, byval from as size_t, byval count as size_t) as integer
declare function mpg123_set_string cdecl alias "mpg123_set_string" (byval sb as mpg123_string ptr, byval stuff as zstring ptr) as integer
declare function mpg123_set_substring cdecl alias "mpg123_set_substring" (byval sb as mpg123_string ptr, byval stuff as zstring ptr, byval from as size_t, byval count as size_t) as integer

type mpg123_text
	lang as zstring * 3
	id as zstring * 4
	description as mpg123_string
	text as mpg123_string
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
	comments as size_t
	text as mpg123_text ptr
	texts as size_t
	extra as mpg123_text ptr
	extras as size_t
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

#define MPG123_ID3 &h3
#define MPG123_NEW_ID3 &h1
#define MPG123_ICY &hc
#define MPG123_NEW_ICY &h4

declare function mpg123_meta_check cdecl alias "mpg123_meta_check" (byval mh as mpg123_handle ptr) as integer
declare function mpg123_id3 cdecl alias "mpg123_id3" (byval mh as mpg123_handle ptr, byval v1 as mpg123_id3v1 ptr ptr, byval v2 as mpg123_id3v2 ptr ptr) as integer
declare function mpg123_icy cdecl alias "mpg123_icy" (byval mh as mpg123_handle ptr, byval icy_meta as byte ptr ptr) as integer
declare function mpg123_icy2utf8 cdecl alias "mpg123_icy2utf8" (byval icy_text as zstring ptr) as zstring ptr

type mpg123_pars as mpg123_pars_struct

declare function mpg123_parnew cdecl alias "mpg123_parnew" (byval mp as mpg123_pars ptr, byval decoder as zstring ptr, byval error as integer ptr) as mpg123_handle ptr
declare function mpg123_new_pars cdecl alias "mpg123_new_pars" (byval error as integer ptr) as mpg123_pars ptr
declare sub mpg123_delete_pars cdecl alias "mpg123_delete_pars" (byval mp as mpg123_pars ptr)
declare function mpg123_fmt_none cdecl alias "mpg123_fmt_none" (byval mp as mpg123_pars ptr) as integer
declare function mpg123_fmt_all cdecl alias "mpg123_fmt_all" (byval mp as mpg123_pars ptr) as integer
declare function mpg123_fmt cdecl alias "mpg123_fmt" (byval mh as mpg123_pars ptr, byval rate as integer, byval channels as integer, byval encodings as integer) as integer
declare function mpg123_fmt_support cdecl alias "mpg123_fmt_support" (byval mh as mpg123_pars ptr, byval rate as integer, byval encoding as integer) as integer
declare function mpg123_par cdecl alias "mpg123_par" (byval mp as mpg123_pars ptr, byval type as mpg123_parms, byval value as integer, byval fvalue as double) as integer
declare function mpg123_getpar cdecl alias "mpg123_getpar" (byval mp as mpg123_pars ptr, byval type as mpg123_parms, byval val as integer ptr, byval fval as double ptr) as integer
declare function mpg123_replace_buffer cdecl alias "mpg123_replace_buffer" (byval mh as mpg123_handle ptr, byval data as ubyte ptr, byval size as size_t) as integer
declare function mpg123_outblock cdecl alias "mpg123_outblock" (byval mh as mpg123_handle ptr) as size_t
declare function mpg123_replace_reader cdecl alias "mpg123_replace_reader" (byval mh as mpg123_handle ptr, byval r_read as function cdecl(byval as integer, byval as any ptr, byval as size_t) as ssize_t, byval r_lseek as function cdecl(byval as integer, byval as off_t, byval as integer) as off_t) as integer

#endif
