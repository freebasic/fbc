'' FreeBASIC binding for allegro-5.0.11
''
'' based on the C header files:
''   Copyright (c) 2004-2011 the Allegro 5 Development Team
''
''   This software is provided 'as-is', without any express or implied
''   warranty. In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''       1. The origin of this software must not be misrepresented; you must not
''       claim that you wrote the original software. If you use this software
''       in a product, an acknowledgment in the product documentation would be
''       appreciated but is not required.
''
''       2. Altered source versions must be plainly marked as such, and must not be
''       misrepresented as being the original software.
''
''       3. This notice may not be removed or altered from any source
''       distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef __FB_UNIX__
	#inclib "allegro_audio"
#elseif defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#inclib "allegro_audio-5.0.10-static-md"
#else
	#inclib "allegro_audio-5.0.10-md"
#endif

#include once "allegro5/allegro.bi"

extern "C"

#define __al_included_allegro5_allegro_audio_h
const _KCM_STREAM_FEEDER_QUIT_EVENT_TYPE = 512
const ALLEGRO_EVENT_AUDIO_STREAM_FRAGMENT = 513
const ALLEGRO_EVENT_AUDIO_STREAM_FINISHED = 514

type ALLEGRO_AUDIO_DEPTH as long
enum
	ALLEGRO_AUDIO_DEPTH_INT8 = &h00
	ALLEGRO_AUDIO_DEPTH_INT16 = &h01
	ALLEGRO_AUDIO_DEPTH_INT24 = &h02
	ALLEGRO_AUDIO_DEPTH_FLOAT32 = &h03
	ALLEGRO_AUDIO_DEPTH_UNSIGNED = &h08
	ALLEGRO_AUDIO_DEPTH_UINT8 = ALLEGRO_AUDIO_DEPTH_INT8 or ALLEGRO_AUDIO_DEPTH_UNSIGNED
	ALLEGRO_AUDIO_DEPTH_UINT16 = ALLEGRO_AUDIO_DEPTH_INT16 or ALLEGRO_AUDIO_DEPTH_UNSIGNED
	ALLEGRO_AUDIO_DEPTH_UINT24 = ALLEGRO_AUDIO_DEPTH_INT24 or ALLEGRO_AUDIO_DEPTH_UNSIGNED
end enum

type ALLEGRO_CHANNEL_CONF as long
enum
	ALLEGRO_CHANNEL_CONF_1 = &h10
	ALLEGRO_CHANNEL_CONF_2 = &h20
	ALLEGRO_CHANNEL_CONF_3 = &h30
	ALLEGRO_CHANNEL_CONF_4 = &h40
	ALLEGRO_CHANNEL_CONF_5_1 = &h51
	ALLEGRO_CHANNEL_CONF_6_1 = &h61
	ALLEGRO_CHANNEL_CONF_7_1 = &h71
end enum

const ALLEGRO_MAX_CHANNELS = 8

type ALLEGRO_PLAYMODE as long
enum
	ALLEGRO_PLAYMODE_ONCE = &h100
	ALLEGRO_PLAYMODE_LOOP = &h101
	ALLEGRO_PLAYMODE_BIDIR = &h102
	_ALLEGRO_PLAYMODE_STREAM_ONCE = &h103
	_ALLEGRO_PLAYMODE_STREAM_ONEDIR = &h104
end enum

type ALLEGRO_MIXER_QUALITY as long
enum
	ALLEGRO_MIXER_QUALITY_POINT = &h110
	ALLEGRO_MIXER_QUALITY_LINEAR = &h111
	ALLEGRO_MIXER_QUALITY_CUBIC = &h112
end enum

const ALLEGRO_AUDIO_PAN_NONE = -1000.0f

type ALLEGRO_SAMPLE_ID
	_index as long
	_id as long
end type

type ALLEGRO_SAMPLE as ALLEGRO_SAMPLE_
declare function al_create_sample(byval buf as any ptr, byval samples as ulong, byval freq as ulong, byval depth as ALLEGRO_AUDIO_DEPTH, byval chan_conf as ALLEGRO_CHANNEL_CONF, byval free_buf as byte) as ALLEGRO_SAMPLE ptr
declare sub al_destroy_sample(byval spl as ALLEGRO_SAMPLE ptr)
type ALLEGRO_SAMPLE_INSTANCE as ALLEGRO_SAMPLE_INSTANCE_
declare function al_create_sample_instance(byval data as ALLEGRO_SAMPLE ptr) as ALLEGRO_SAMPLE_INSTANCE ptr
declare sub al_destroy_sample_instance(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr)
declare function al_get_sample_frequency(byval spl as const ALLEGRO_SAMPLE ptr) as ulong
declare function al_get_sample_length(byval spl as const ALLEGRO_SAMPLE ptr) as ulong
declare function al_get_sample_depth(byval spl as const ALLEGRO_SAMPLE ptr) as ALLEGRO_AUDIO_DEPTH
declare function al_get_sample_channels(byval spl as const ALLEGRO_SAMPLE ptr) as ALLEGRO_CHANNEL_CONF
declare function al_get_sample_data(byval spl as const ALLEGRO_SAMPLE ptr) as any ptr
declare function al_get_sample_instance_frequency(byval spl as const ALLEGRO_SAMPLE_INSTANCE ptr) as ulong
declare function al_get_sample_instance_length(byval spl as const ALLEGRO_SAMPLE_INSTANCE ptr) as ulong
declare function al_get_sample_instance_position(byval spl as const ALLEGRO_SAMPLE_INSTANCE ptr) as ulong
declare function al_get_sample_instance_speed(byval spl as const ALLEGRO_SAMPLE_INSTANCE ptr) as single
declare function al_get_sample_instance_gain(byval spl as const ALLEGRO_SAMPLE_INSTANCE ptr) as single
declare function al_get_sample_instance_pan(byval spl as const ALLEGRO_SAMPLE_INSTANCE ptr) as single
declare function al_get_sample_instance_time(byval spl as const ALLEGRO_SAMPLE_INSTANCE ptr) as single
declare function al_get_sample_instance_depth(byval spl as const ALLEGRO_SAMPLE_INSTANCE ptr) as ALLEGRO_AUDIO_DEPTH
declare function al_get_sample_instance_channels(byval spl as const ALLEGRO_SAMPLE_INSTANCE ptr) as ALLEGRO_CHANNEL_CONF
declare function al_get_sample_instance_playmode(byval spl as const ALLEGRO_SAMPLE_INSTANCE ptr) as ALLEGRO_PLAYMODE
declare function al_get_sample_instance_playing(byval spl as const ALLEGRO_SAMPLE_INSTANCE ptr) as byte
declare function al_get_sample_instance_attached(byval spl as const ALLEGRO_SAMPLE_INSTANCE ptr) as byte
declare function al_set_sample_instance_position(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr, byval val as ulong) as byte
declare function al_set_sample_instance_length(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr, byval val as ulong) as byte
declare function al_set_sample_instance_speed(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr, byval val as single) as byte
declare function al_set_sample_instance_gain(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr, byval val as single) as byte
declare function al_set_sample_instance_pan(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr, byval val as single) as byte
declare function al_set_sample_instance_playmode(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr, byval val as ALLEGRO_PLAYMODE) as byte
declare function al_set_sample_instance_playing(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr, byval val as byte) as byte
declare function al_detach_sample_instance(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr) as byte
declare function al_set_sample(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr, byval data as ALLEGRO_SAMPLE ptr) as byte
declare function al_get_sample(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr) as ALLEGRO_SAMPLE ptr
declare function al_play_sample_instance(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr) as byte
declare function al_stop_sample_instance(byval spl as ALLEGRO_SAMPLE_INSTANCE ptr) as byte
type ALLEGRO_AUDIO_STREAM as ALLEGRO_AUDIO_STREAM_
declare function al_create_audio_stream(byval buffer_count as uinteger, byval samples as ulong, byval freq as ulong, byval depth as ALLEGRO_AUDIO_DEPTH, byval chan_conf as ALLEGRO_CHANNEL_CONF) as ALLEGRO_AUDIO_STREAM ptr
declare sub al_destroy_audio_stream(byval stream as ALLEGRO_AUDIO_STREAM ptr)
declare sub al_drain_audio_stream(byval stream as ALLEGRO_AUDIO_STREAM ptr)
declare function al_get_audio_stream_frequency(byval stream as const ALLEGRO_AUDIO_STREAM ptr) as ulong
declare function al_get_audio_stream_length(byval stream as const ALLEGRO_AUDIO_STREAM ptr) as ulong
declare function al_get_audio_stream_fragments(byval stream as const ALLEGRO_AUDIO_STREAM ptr) as ulong
declare function al_get_available_audio_stream_fragments(byval stream as const ALLEGRO_AUDIO_STREAM ptr) as ulong
declare function al_get_audio_stream_speed(byval stream as const ALLEGRO_AUDIO_STREAM ptr) as single
declare function al_get_audio_stream_gain(byval stream as const ALLEGRO_AUDIO_STREAM ptr) as single
declare function al_get_audio_stream_pan(byval stream as const ALLEGRO_AUDIO_STREAM ptr) as single
declare function al_get_audio_stream_channels(byval stream as const ALLEGRO_AUDIO_STREAM ptr) as ALLEGRO_CHANNEL_CONF
declare function al_get_audio_stream_depth(byval stream as const ALLEGRO_AUDIO_STREAM ptr) as ALLEGRO_AUDIO_DEPTH
declare function al_get_audio_stream_playmode(byval stream as const ALLEGRO_AUDIO_STREAM ptr) as ALLEGRO_PLAYMODE
declare function al_get_audio_stream_playing(byval spl as const ALLEGRO_AUDIO_STREAM ptr) as byte
declare function al_get_audio_stream_attached(byval spl as const ALLEGRO_AUDIO_STREAM ptr) as byte
declare function al_get_audio_stream_fragment(byval stream as const ALLEGRO_AUDIO_STREAM ptr) as any ptr
declare function al_set_audio_stream_speed(byval stream as ALLEGRO_AUDIO_STREAM ptr, byval val as single) as byte
declare function al_set_audio_stream_gain(byval stream as ALLEGRO_AUDIO_STREAM ptr, byval val as single) as byte
declare function al_set_audio_stream_pan(byval stream as ALLEGRO_AUDIO_STREAM ptr, byval val as single) as byte
declare function al_set_audio_stream_playmode(byval stream as ALLEGRO_AUDIO_STREAM ptr, byval val as ALLEGRO_PLAYMODE) as byte
declare function al_set_audio_stream_playing(byval stream as ALLEGRO_AUDIO_STREAM ptr, byval val as byte) as byte
declare function al_detach_audio_stream(byval stream as ALLEGRO_AUDIO_STREAM ptr) as byte
declare function al_set_audio_stream_fragment(byval stream as ALLEGRO_AUDIO_STREAM ptr, byval val as any ptr) as byte
declare function al_rewind_audio_stream(byval stream as ALLEGRO_AUDIO_STREAM ptr) as byte
declare function al_seek_audio_stream_secs(byval stream as ALLEGRO_AUDIO_STREAM ptr, byval time as double) as byte
declare function al_get_audio_stream_position_secs(byval stream as ALLEGRO_AUDIO_STREAM ptr) as double
declare function al_get_audio_stream_length_secs(byval stream as ALLEGRO_AUDIO_STREAM ptr) as double
declare function al_set_audio_stream_loop_secs(byval stream as ALLEGRO_AUDIO_STREAM ptr, byval start as double, byval end as double) as byte
declare function al_get_audio_stream_event_source(byval stream as ALLEGRO_AUDIO_STREAM ptr) as ALLEGRO_EVENT_SOURCE ptr
type ALLEGRO_MIXER as ALLEGRO_MIXER_
declare function al_create_mixer(byval freq as ulong, byval depth as ALLEGRO_AUDIO_DEPTH, byval chan_conf as ALLEGRO_CHANNEL_CONF) as ALLEGRO_MIXER ptr
declare sub al_destroy_mixer(byval mixer as ALLEGRO_MIXER ptr)
declare function al_attach_sample_instance_to_mixer(byval stream as ALLEGRO_SAMPLE_INSTANCE ptr, byval mixer as ALLEGRO_MIXER ptr) as byte
declare function al_attach_audio_stream_to_mixer(byval stream as ALLEGRO_AUDIO_STREAM ptr, byval mixer as ALLEGRO_MIXER ptr) as byte
declare function al_attach_mixer_to_mixer(byval stream as ALLEGRO_MIXER ptr, byval mixer as ALLEGRO_MIXER ptr) as byte
declare function al_set_mixer_postprocess_callback(byval mixer as ALLEGRO_MIXER ptr, byval cb as sub(byval buf as any ptr, byval samples as ulong, byval data as any ptr), byval data as any ptr) as byte
declare function al_get_mixer_frequency(byval mixer as const ALLEGRO_MIXER ptr) as ulong
declare function al_get_mixer_channels(byval mixer as const ALLEGRO_MIXER ptr) as ALLEGRO_CHANNEL_CONF
declare function al_get_mixer_depth(byval mixer as const ALLEGRO_MIXER ptr) as ALLEGRO_AUDIO_DEPTH
declare function al_get_mixer_quality(byval mixer as const ALLEGRO_MIXER ptr) as ALLEGRO_MIXER_QUALITY
declare function al_get_mixer_gain(byval mixer as const ALLEGRO_MIXER ptr) as single
declare function al_get_mixer_playing(byval mixer as const ALLEGRO_MIXER ptr) as byte
declare function al_get_mixer_attached(byval mixer as const ALLEGRO_MIXER ptr) as byte
declare function al_set_mixer_frequency(byval mixer as ALLEGRO_MIXER ptr, byval val as ulong) as byte
declare function al_set_mixer_quality(byval mixer as ALLEGRO_MIXER ptr, byval val as ALLEGRO_MIXER_QUALITY) as byte
declare function al_set_mixer_gain(byval mixer as ALLEGRO_MIXER ptr, byval gain as single) as byte
declare function al_set_mixer_playing(byval mixer as ALLEGRO_MIXER ptr, byval val as byte) as byte
declare function al_detach_mixer(byval mixer as ALLEGRO_MIXER ptr) as byte
type ALLEGRO_VOICE as ALLEGRO_VOICE_
declare function al_create_voice(byval freq as ulong, byval depth as ALLEGRO_AUDIO_DEPTH, byval chan_conf as ALLEGRO_CHANNEL_CONF) as ALLEGRO_VOICE ptr
declare sub al_destroy_voice(byval voice as ALLEGRO_VOICE ptr)
declare function al_attach_sample_instance_to_voice(byval stream as ALLEGRO_SAMPLE_INSTANCE ptr, byval voice as ALLEGRO_VOICE ptr) as byte
declare function al_attach_audio_stream_to_voice(byval stream as ALLEGRO_AUDIO_STREAM ptr, byval voice as ALLEGRO_VOICE ptr) as byte
declare function al_attach_mixer_to_voice(byval mixer as ALLEGRO_MIXER ptr, byval voice as ALLEGRO_VOICE ptr) as byte
declare sub al_detach_voice(byval voice as ALLEGRO_VOICE ptr)
declare function al_get_voice_frequency(byval voice as const ALLEGRO_VOICE ptr) as ulong
declare function al_get_voice_position(byval voice as const ALLEGRO_VOICE ptr) as ulong
declare function al_get_voice_channels(byval voice as const ALLEGRO_VOICE ptr) as ALLEGRO_CHANNEL_CONF
declare function al_get_voice_depth(byval voice as const ALLEGRO_VOICE ptr) as ALLEGRO_AUDIO_DEPTH
declare function al_get_voice_playing(byval voice as const ALLEGRO_VOICE ptr) as byte
declare function al_set_voice_position(byval voice as ALLEGRO_VOICE ptr, byval val as ulong) as byte
declare function al_set_voice_playing(byval voice as ALLEGRO_VOICE ptr, byval val as byte) as byte
declare function al_install_audio() as byte
declare sub al_uninstall_audio()
declare function al_is_audio_installed() as byte
declare function al_get_allegro_audio_version() as ulong
declare function al_get_channel_count(byval conf as ALLEGRO_CHANNEL_CONF) as uinteger
declare function al_get_audio_depth_size(byval conf as ALLEGRO_AUDIO_DEPTH) as uinteger
declare function al_reserve_samples(byval reserve_samples as long) as byte
declare function al_get_default_mixer() as ALLEGRO_MIXER ptr
declare function al_set_default_mixer(byval mixer as ALLEGRO_MIXER ptr) as byte
declare function al_restore_default_mixer() as byte
declare function al_play_sample(byval data as ALLEGRO_SAMPLE ptr, byval gain as single, byval pan as single, byval speed as single, byval loop as ALLEGRO_PLAYMODE, byval ret_id as ALLEGRO_SAMPLE_ID ptr) as byte
declare sub al_stop_sample(byval spl_id as ALLEGRO_SAMPLE_ID ptr)
declare sub al_stop_samples()
declare function al_register_sample_loader(byval ext as const zstring ptr, byval loader as function(byval filename as const zstring ptr) as ALLEGRO_SAMPLE ptr) as byte
declare function al_register_sample_saver(byval ext as const zstring ptr, byval saver as function(byval filename as const zstring ptr, byval spl as ALLEGRO_SAMPLE ptr) as byte) as byte
declare function al_register_audio_stream_loader(byval ext as const zstring ptr, byval stream_loader as function(byval filename as const zstring ptr, byval buffer_count as uinteger, byval samples as ulong) as ALLEGRO_AUDIO_STREAM ptr) as byte
declare function al_register_sample_loader_f(byval ext as const zstring ptr, byval loader as function(byval fp as ALLEGRO_FILE ptr) as ALLEGRO_SAMPLE ptr) as byte
declare function al_register_sample_saver_f(byval ext as const zstring ptr, byval saver as function(byval fp as ALLEGRO_FILE ptr, byval spl as ALLEGRO_SAMPLE ptr) as byte) as byte
declare function al_register_audio_stream_loader_f(byval ext as const zstring ptr, byval stream_loader as function(byval fp as ALLEGRO_FILE ptr, byval buffer_count as uinteger, byval samples as ulong) as ALLEGRO_AUDIO_STREAM ptr) as byte
declare function al_load_sample(byval filename as const zstring ptr) as ALLEGRO_SAMPLE ptr
declare function al_save_sample(byval filename as const zstring ptr, byval spl as ALLEGRO_SAMPLE ptr) as byte
declare function al_load_audio_stream(byval filename as const zstring ptr, byval buffer_count as uinteger, byval samples as ulong) as ALLEGRO_AUDIO_STREAM ptr
declare function al_load_sample_f(byval fp as ALLEGRO_FILE ptr, byval ident as const zstring ptr) as ALLEGRO_SAMPLE ptr
declare function al_save_sample_f(byval fp as ALLEGRO_FILE ptr, byval ident as const zstring ptr, byval spl as ALLEGRO_SAMPLE ptr) as byte
declare function al_load_audio_stream_f(byval fp as ALLEGRO_FILE ptr, byval ident as const zstring ptr, byval buffer_count as uinteger, byval samples as ulong) as ALLEGRO_AUDIO_STREAM ptr

end extern
