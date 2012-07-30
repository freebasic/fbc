''
''
'' cst_audio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_audio_bi__
#define __cst_audio_bi__

#define CST_AUDIOBUFFSIZE 128
#define CST_AUDIO_DEFAULT_PORT 1746
#define CST_AUDIO_DEFAULT_SERVER "localhost"
#define CST_AUDIO_DEFAULT_ENCODING "short"

enum cst_audiofmt
	CST_AUDIO_LINEAR16 = 0
	CST_AUDIO_LINEAR8
	CST_AUDIO_MULAW
end enum


declare function audio_bps cdecl alias "audio_bps" (byval fmt as cst_audiofmt) as integer

type cst_audiodev_struct
	sps as integer
	real_sps as integer
	channels as integer
	real_channels as integer
	fmt as cst_audiofmt
	real_fmt as cst_audiofmt
	byteswap as integer
	rateconv as cst_rateconv ptr
	platform_data as any ptr
end type

type cst_audiodev as cst_audiodev_struct

declare function audio_open cdecl alias "audio_open" (byval sps as integer, byval channels as integer, byval fmt as cst_audiofmt) as cst_audiodev ptr
declare function audio_close cdecl alias "audio_close" (byval ad as cst_audiodev ptr) as integer
declare function audio_write cdecl alias "audio_write" (byval ad as cst_audiodev ptr, byval buff as any ptr, byval num_bytes as integer) as integer
declare function audio_flush cdecl alias "audio_flush" (byval ad as cst_audiodev ptr) as integer
declare function audio_drain cdecl alias "audio_drain" (byval ad as cst_audiodev ptr) as integer
declare function play_wave cdecl alias "play_wave" (byval w as cst_wave ptr) as integer
declare function play_wave_sync cdecl alias "play_wave_sync" (byval w as cst_wave ptr, byval rel as cst_relation ptr, byval call_back as function cdecl(byval as cst_item ptr) as integer) as integer
declare function play_wave_client cdecl alias "play_wave_client" (byval w as cst_wave ptr, byval servername as zstring ptr, byval port as integer, byval encoding as zstring ptr) as integer
declare function auserver cdecl alias "auserver" (byval port as integer) as integer
declare function play_wave_device cdecl alias "play_wave_device" (byval w as cst_wave ptr, byval ad as cst_audiodev ptr) as integer
declare function audio_open_file cdecl alias "audio_open_file" (byval sps as integer, byval channels as integer, byval fmt as cst_audiofmt, byval filename as zstring ptr) as cst_audiodev ptr
declare function audio_close_file cdecl alias "audio_close_file" (byval ad as cst_audiodev ptr) as integer
declare function audio_write_file cdecl alias "audio_write_file" (byval ad as cst_audiodev ptr, byval buff as any ptr, byval num_bytes as integer) as integer
declare function audio_drain_file cdecl alias "audio_drain_file" (byval ad as cst_audiodev ptr) as integer
declare function audio_flush_file cdecl alias "audio_flush_file" (byval ad as cst_audiodev ptr) as integer

#define CST_AUDIO_STREAM_STOP -1
#define CST_AUDIO_STREAM_CONT 0

type cst_audio_stream_callback as function cdecl(byval as cst_wave ptr, byval as integer, byval as integer, byval as integer, byval as any ptr) as integer

type cst_audio_streaming_info_struct
	min_buffsize as integer
	asc as cst_audio_stream_callback
	userdata as any ptr
end type

type cst_audio_streaming_info as cst_audio_streaming_info_struct

declare function new_audio_streaming_info cdecl alias "new_audio_streaming_info" () as cst_audio_streaming_info ptr
declare sub delete_audio_streaming_info cdecl alias "delete_audio_streaming_info" (byval asi as cst_audio_streaming_info ptr)

#endif
