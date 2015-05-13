''
''
'' vorbisfile -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __vorbisfile_bi__
#define __vorbisfile_bi__

#inclib "vorbisfile"

#include once "../ogg/ogg.bi"
#include once "codec.bi"
#include once "crt.bi"

type ov_callbacks
	read_func as function cdecl(byval as any ptr, byval as size_t, byval as size_t, byval as any ptr) as size_t
	seek_func as function cdecl(byval as any ptr, byval as ogg_int64_t, byval as integer) as integer
	close_func as function cdecl(byval as any ptr) as integer
	tell_func as function cdecl(byval as any ptr) as integer
end type

declare function _ov_header_fseek_wrap cdecl alias "_ov_header_fseek_wrap" (byval f as FILE ptr, byval off as ogg_int64_t, byval whence as integer) as integer

#define NOTOPEN 0
#define PARTOPEN 1
#define OPENED 2
#define STREAMSET 3
#define INITSET 4

type OggVorbis_File
	datasource as any ptr
	seekable as integer
	offset as ogg_int64_t
	end as ogg_int64_t
	oy as ogg_sync_state
	links as integer
	offsets as ogg_int64_t ptr
	dataoffsets as ogg_int64_t ptr
	serialnos as integer ptr
	pcmlengths as ogg_int64_t ptr
	vi as vorbis_info ptr
	vc as vorbis_comment ptr
	pcm_offset as ogg_int64_t
	ready_state as integer
	current_serialno as integer
	current_link as integer
	bittrack as double
	samptrack as double
	os as ogg_stream_state
	vd as vorbis_dsp_state
	vb as vorbis_block
	callbacks as ov_callbacks
end type

declare function ov_clear cdecl alias "ov_clear" (byval vf as OggVorbis_File ptr) as integer
declare function ov_fopen cdecl alias "ov_fopen" (byval path as zstring ptr, byval vf as OggVorbis_File ptr) as integer
declare function ov_open cdecl alias "ov_open" (byval f as FILE ptr, byval vf as OggVorbis_File ptr, byval initial as zstring ptr, byval ibytes as integer) as integer
declare function ov_open_callbacks cdecl alias "ov_open_callbacks" (byval datasource as any ptr, byval vf as OggVorbis_File ptr, byval initial as zstring ptr, byval ibytes as integer, byval callbacks as ov_callbacks) as integer
declare function ov_test cdecl alias "ov_test" (byval f as FILE ptr, byval vf as OggVorbis_File ptr, byval initial as zstring ptr, byval ibytes as integer) as integer
declare function ov_test_callbacks cdecl alias "ov_test_callbacks" (byval datasource as any ptr, byval vf as OggVorbis_File ptr, byval initial as zstring ptr, byval ibytes as integer, byval callbacks as ov_callbacks) as integer
declare function ov_test_open cdecl alias "ov_test_open" (byval vf as OggVorbis_File ptr) as integer
declare function ov_bitrate cdecl alias "ov_bitrate" (byval vf as OggVorbis_File ptr, byval i as integer) as integer
declare function ov_bitrate_instant cdecl alias "ov_bitrate_instant" (byval vf as OggVorbis_File ptr) as integer
declare function ov_streams cdecl alias "ov_streams" (byval vf as OggVorbis_File ptr) as integer
declare function ov_seekable cdecl alias "ov_seekable" (byval vf as OggVorbis_File ptr) as integer
declare function ov_serialnumber cdecl alias "ov_serialnumber" (byval vf as OggVorbis_File ptr, byval i as integer) as integer
declare function ov_raw_total cdecl alias "ov_raw_total" (byval vf as OggVorbis_File ptr, byval i as integer) as ogg_int64_t
declare function ov_pcm_total cdecl alias "ov_pcm_total" (byval vf as OggVorbis_File ptr, byval i as integer) as ogg_int64_t
declare function ov_time_total cdecl alias "ov_time_total" (byval vf as OggVorbis_File ptr, byval i as integer) as double
declare function ov_raw_seek cdecl alias "ov_raw_seek" (byval vf as OggVorbis_File ptr, byval pos as ogg_int64_t) as integer
declare function ov_pcm_seek cdecl alias "ov_pcm_seek" (byval vf as OggVorbis_File ptr, byval pos as ogg_int64_t) as integer
declare function ov_pcm_seek_page cdecl alias "ov_pcm_seek_page" (byval vf as OggVorbis_File ptr, byval pos as ogg_int64_t) as integer
declare function ov_time_seek cdecl alias "ov_time_seek" (byval vf as OggVorbis_File ptr, byval pos as double) as integer
declare function ov_time_seek_page cdecl alias "ov_time_seek_page" (byval vf as OggVorbis_File ptr, byval pos as double) as integer
declare function ov_raw_seek_lap cdecl alias "ov_raw_seek_lap" (byval vf as OggVorbis_File ptr, byval pos as ogg_int64_t) as integer
declare function ov_pcm_seek_lap cdecl alias "ov_pcm_seek_lap" (byval vf as OggVorbis_File ptr, byval pos as ogg_int64_t) as integer
declare function ov_pcm_seek_page_lap cdecl alias "ov_pcm_seek_page_lap" (byval vf as OggVorbis_File ptr, byval pos as ogg_int64_t) as integer
declare function ov_time_seek_lap cdecl alias "ov_time_seek_lap" (byval vf as OggVorbis_File ptr, byval pos as double) as integer
declare function ov_time_seek_page_lap cdecl alias "ov_time_seek_page_lap" (byval vf as OggVorbis_File ptr, byval pos as double) as integer
declare function ov_raw_tell cdecl alias "ov_raw_tell" (byval vf as OggVorbis_File ptr) as ogg_int64_t
declare function ov_pcm_tell cdecl alias "ov_pcm_tell" (byval vf as OggVorbis_File ptr) as ogg_int64_t
declare function ov_time_tell cdecl alias "ov_time_tell" (byval vf as OggVorbis_File ptr) as double
declare function ov_info cdecl alias "ov_info" (byval vf as OggVorbis_File ptr, byval link as integer) as vorbis_info ptr
declare function ov_comment cdecl alias "ov_comment" (byval vf as OggVorbis_File ptr, byval link as integer) as vorbis_comment ptr
declare function ov_read_float cdecl alias "ov_read_float" (byval vf as OggVorbis_File ptr, byval pcm_channels as single ptr ptr ptr, byval samples as integer, byval bitstream as integer ptr) as integer
declare function ov_read cdecl alias "ov_read" (byval vf as OggVorbis_File ptr, byval buffer as zstring ptr, byval length as integer, byval bigendianp as integer, byval word as integer, byval sgned as integer, byval bitstream as integer ptr) as integer
declare function ov_crosslap cdecl alias "ov_crosslap" (byval vf1 as OggVorbis_File ptr, byval vf2 as OggVorbis_File ptr) as integer
declare function ov_halfrate cdecl alias "ov_halfrate" (byval vf as OggVorbis_File ptr, byval flag as integer) as integer
declare function ov_halfrate_p cdecl alias "ov_halfrate_p" (byval vf as OggVorbis_File ptr) as integer

#endif
