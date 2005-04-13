'         ______   ___    ___
'        /\  _  \ /\_ \  /\_ \
'        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
'         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
'          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
'           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
'            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
'                                           /\____/
'                                           \_/__/
'
'      Streaming sound routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_STREAM_H
#define ALLEGRO_STREAM_H

#include "allegro/base.bi"

Type AUDIOSTREAM
	voice As Integer			' the voice we are playing on
	samp As SAMPLE Ptr			' the sample we are using
	length As Integer			' buffer length - name changed from 'len'
	bufcount As Integer			' number of buffers per sample half
	bufnum As Integer			' current refill buffer
	active As Integer			' which half is currently playing
	locked As UByte Ptr			' the locked buffer
End Type

declare function play_audio_stream cdecl alias "play_audio_stream" ( byval length as integer, byval bits as integer, byval stereo as integer, byval freq as integer, byval vol as integer, byval pan as integer ) as AUDIOSTREAM ptr
declare sub stop_audio_stream cdecl alias "stop_audio_stream" ( byval stream as AUDIOSTREAM ptr )
declare function get_audio_stream_buffer cdecl alias "get_audio_stream_buffer" ( byval stream as AUDIOSTREAM ptr ) as any ptr
declare sub free_audio_stream_buffer cdecl alias "get_audio_stream_buffer" ( byval stream as AUDIOSTREAM ptr )

#endif

