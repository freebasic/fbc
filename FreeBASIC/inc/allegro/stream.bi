''
''
'' allegro\stream -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_stream_bi__
#define __allegro_stream_bi__

#include once "allegro/base.bi"

type AUDIOSTREAM
	voice as integer
	samp as SAMPLE ptr
	len as integer
	bufcount as integer
	bufnum as integer
	active as integer
	locked as any ptr
end type

declare function play_audio_stream cdecl alias "play_audio_stream" (byval len as integer, byval bits as integer, byval stereo as integer, byval freq as integer, byval vol as integer, byval pan as integer) as AUDIOSTREAM ptr
declare sub stop_audio_stream cdecl alias "stop_audio_stream" (byval stream as AUDIOSTREAM ptr)
declare function get_audio_stream_buffer cdecl alias "get_audio_stream_buffer" (byval stream as AUDIOSTREAM ptr) as any ptr
declare sub free_audio_stream_buffer cdecl alias "free_audio_stream_buffer" (byval stream as AUDIOSTREAM ptr)

#endif
