'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    libvlc_media_player.h:  libvlc_media_player external API
''   ****************************************************************************
''    Copyright (C) 1998-2010 VLC authors and VideoLAN
''    $Id: 94bf7e8c4461896ff0d22b7c86ce6d3f9854eb17 $
''
''    Authors: Clément Stenac <zorglub@videolan.org>
''             Jean-Paul Saman <jpsaman@videolan.org>
''             Pierre d'Herbemont <pdherbemont@videolan.org>
''
''    This program is free software; you can redistribute it and/or modify it
''    under the terms of the GNU Lesser General Public License as published by
''    the Free Software Foundation; either version 2.1 of the License, or
''    (at your option) any later version.
''
''    This program is distributed in the hope that it will be useful,
''    but WITHOUT ANY WARRANTY; without even the implied warranty of
''    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
''    GNU Lesser General Public License for more details.
''
''    You should have received a copy of the GNU Lesser General Public License
''    along with this program; if not, write to the Free Software Foundation,
''    Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
''   ***************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "C"

const VLC_LIBVLC_MEDIA_PLAYER_H = 1

type libvlc_track_description_t
	i_id as long
	psz_name as zstring ptr
	p_next as libvlc_track_description_t ptr
end type

type libvlc_audio_output_t
	psz_name as zstring ptr
	psz_description as zstring ptr
	p_next as libvlc_audio_output_t ptr
end type

type libvlc_audio_output_device_t
	p_next as libvlc_audio_output_device_t ptr
	psz_device as zstring ptr
	psz_description as zstring ptr
end type

type libvlc_rectangle_t
	top as long
	left as long
	bottom as long
	right as long
end type

type libvlc_video_marquee_option_t as long
enum
	libvlc_marquee_Enable = 0
	libvlc_marquee_Text
	libvlc_marquee_Color
	libvlc_marquee_Opacity
	libvlc_marquee_Position
	libvlc_marquee_Refresh
	libvlc_marquee_Size
	libvlc_marquee_Timeout
	libvlc_marquee_X
	libvlc_marquee_Y
end enum

type libvlc_navigate_mode_t as long
enum
	libvlc_navigate_activate = 0
	libvlc_navigate_up
	libvlc_navigate_down
	libvlc_navigate_left
	libvlc_navigate_right
end enum

type libvlc_position_t as long
enum
	libvlc_position_disable = -1
	libvlc_position_center
	libvlc_position_left
	libvlc_position_right
	libvlc_position_top
	libvlc_position_top_left
	libvlc_position_top_right
	libvlc_position_bottom
	libvlc_position_bottom_left
	libvlc_position_bottom_right
end enum

type libvlc_media_player_t as libvlc_media_player_t_
declare function libvlc_media_player_new(byval p_libvlc_instance as libvlc_instance_t ptr) as libvlc_media_player_t ptr
declare function libvlc_media_player_new_from_media(byval p_md as libvlc_media_t ptr) as libvlc_media_player_t ptr
declare sub libvlc_media_player_release(byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_media_player_retain(byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_media_player_set_media(byval p_mi as libvlc_media_player_t ptr, byval p_md as libvlc_media_t ptr)
declare function libvlc_media_player_get_media(byval p_mi as libvlc_media_player_t ptr) as libvlc_media_t ptr
declare function libvlc_media_player_event_manager(byval p_mi as libvlc_media_player_t ptr) as libvlc_event_manager_t ptr
declare function libvlc_media_player_is_playing(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_media_player_play(byval p_mi as libvlc_media_player_t ptr) as long
declare sub libvlc_media_player_set_pause(byval mp as libvlc_media_player_t ptr, byval do_pause as long)
declare sub libvlc_media_player_pause(byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_media_player_stop(byval p_mi as libvlc_media_player_t ptr)

type libvlc_video_lock_cb as function(byval opaque as any ptr, byval planes as any ptr ptr) as any ptr
type libvlc_video_unlock_cb as sub(byval opaque as any ptr, byval picture as any ptr, byval planes as any const ptr ptr)
type libvlc_video_display_cb as sub(byval opaque as any ptr, byval picture as any ptr)
type libvlc_video_format_cb as function(byval opaque as any ptr ptr, byval chroma as zstring ptr, byval width as ulong ptr, byval height as ulong ptr, byval pitches as ulong ptr, byval lines as ulong ptr) as ulong
type libvlc_video_cleanup_cb as sub(byval opaque as any ptr)

declare sub libvlc_video_set_callbacks(byval mp as libvlc_media_player_t ptr, byval lock as libvlc_video_lock_cb, byval unlock as libvlc_video_unlock_cb, byval display as libvlc_video_display_cb, byval opaque as any ptr)
declare sub libvlc_video_set_format(byval mp as libvlc_media_player_t ptr, byval chroma as const zstring ptr, byval width as ulong, byval height as ulong, byval pitch as ulong)
declare sub libvlc_video_set_format_callbacks(byval mp as libvlc_media_player_t ptr, byval setup as libvlc_video_format_cb, byval cleanup as libvlc_video_cleanup_cb)
declare sub libvlc_media_player_set_nsobject(byval p_mi as libvlc_media_player_t ptr, byval drawable as any ptr)
declare function libvlc_media_player_get_nsobject(byval p_mi as libvlc_media_player_t ptr) as any ptr
declare sub libvlc_media_player_set_agl(byval p_mi as libvlc_media_player_t ptr, byval drawable as ulong)
declare function libvlc_media_player_get_agl(byval p_mi as libvlc_media_player_t ptr) as ulong
declare sub libvlc_media_player_set_xwindow(byval p_mi as libvlc_media_player_t ptr, byval drawable as ulong)
declare function libvlc_media_player_get_xwindow(byval p_mi as libvlc_media_player_t ptr) as ulong
declare sub libvlc_media_player_set_hwnd(byval p_mi as libvlc_media_player_t ptr, byval drawable as any ptr)
declare function libvlc_media_player_get_hwnd(byval p_mi as libvlc_media_player_t ptr) as any ptr

type libvlc_audio_play_cb as sub(byval data as any ptr, byval samples as const any ptr, byval count as ulong, byval pts as longint)
type libvlc_audio_pause_cb as sub(byval data as any ptr, byval pts as longint)
type libvlc_audio_resume_cb as sub(byval data as any ptr, byval pts as longint)
type libvlc_audio_flush_cb as sub(byval data as any ptr, byval pts as longint)
type libvlc_audio_drain_cb as sub(byval data as any ptr)
type libvlc_audio_set_volume_cb as sub(byval data as any ptr, byval volume as single, byval mute as byte)
declare sub libvlc_audio_set_callbacks(byval mp as libvlc_media_player_t ptr, byval play as libvlc_audio_play_cb, byval pause as libvlc_audio_pause_cb, byval resume as libvlc_audio_resume_cb, byval flush as libvlc_audio_flush_cb, byval drain as libvlc_audio_drain_cb, byval opaque as any ptr)
declare sub libvlc_audio_set_volume_callback(byval mp as libvlc_media_player_t ptr, byval set_volume as libvlc_audio_set_volume_cb)
type libvlc_audio_setup_cb as function(byval data as any ptr ptr, byval format as zstring ptr, byval rate as ulong ptr, byval channels as ulong ptr) as long
type libvlc_audio_cleanup_cb as sub(byval data as any ptr)

declare sub libvlc_audio_set_format_callbacks(byval mp as libvlc_media_player_t ptr, byval setup as libvlc_audio_setup_cb, byval cleanup as libvlc_audio_cleanup_cb)
declare sub libvlc_audio_set_format(byval mp as libvlc_media_player_t ptr, byval format as const zstring ptr, byval rate as ulong, byval channels as ulong)
declare function libvlc_media_player_get_length(byval p_mi as libvlc_media_player_t ptr) as libvlc_time_t
declare function libvlc_media_player_get_time(byval p_mi as libvlc_media_player_t ptr) as libvlc_time_t
declare sub libvlc_media_player_set_time(byval p_mi as libvlc_media_player_t ptr, byval i_time as libvlc_time_t)
declare function libvlc_media_player_get_position(byval p_mi as libvlc_media_player_t ptr) as single
declare sub libvlc_media_player_set_position(byval p_mi as libvlc_media_player_t ptr, byval f_pos as single)
declare sub libvlc_media_player_set_chapter(byval p_mi as libvlc_media_player_t ptr, byval i_chapter as long)
declare function libvlc_media_player_get_chapter(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_media_player_get_chapter_count(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_media_player_will_play(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_media_player_get_chapter_count_for_title(byval p_mi as libvlc_media_player_t ptr, byval i_title as long) as long
declare sub libvlc_media_player_set_title(byval p_mi as libvlc_media_player_t ptr, byval i_title as long)
declare function libvlc_media_player_get_title(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_media_player_get_title_count(byval p_mi as libvlc_media_player_t ptr) as long
declare sub libvlc_media_player_previous_chapter(byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_media_player_next_chapter(byval p_mi as libvlc_media_player_t ptr)
declare function libvlc_media_player_get_rate(byval p_mi as libvlc_media_player_t ptr) as single
declare function libvlc_media_player_set_rate(byval p_mi as libvlc_media_player_t ptr, byval rate as single) as long
declare function libvlc_media_player_get_state(byval p_mi as libvlc_media_player_t ptr) as libvlc_state_t
declare function libvlc_media_player_get_fps(byval p_mi as libvlc_media_player_t ptr) as single
declare function libvlc_media_player_has_vout(byval p_mi as libvlc_media_player_t ptr) as ulong
declare function libvlc_media_player_is_seekable(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_media_player_can_pause(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_media_player_program_scrambled(byval p_mi as libvlc_media_player_t ptr) as long
declare sub libvlc_media_player_next_frame(byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_media_player_navigate(byval p_mi as libvlc_media_player_t ptr, byval navigate as ulong)
declare sub libvlc_media_player_set_video_title_display(byval p_mi as libvlc_media_player_t ptr, byval position as libvlc_position_t, byval timeout as ulong)
declare sub libvlc_track_description_list_release(byval p_track_description as libvlc_track_description_t ptr)
declare sub libvlc_track_description_release(byval p_track_description as libvlc_track_description_t ptr)
declare sub libvlc_toggle_fullscreen(byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_set_fullscreen(byval p_mi as libvlc_media_player_t ptr, byval b_fullscreen as long)
declare function libvlc_get_fullscreen(byval p_mi as libvlc_media_player_t ptr) as long
declare sub libvlc_video_set_key_input(byval p_mi as libvlc_media_player_t ptr, byval on as ulong)
declare sub libvlc_video_set_mouse_input(byval p_mi as libvlc_media_player_t ptr, byval on as ulong)
declare function libvlc_video_get_size(byval p_mi as libvlc_media_player_t ptr, byval num as ulong, byval px as ulong ptr, byval py as ulong ptr) as long
declare function libvlc_video_get_height(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_video_get_width(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_video_get_cursor(byval p_mi as libvlc_media_player_t ptr, byval num as ulong, byval px as long ptr, byval py as long ptr) as long
declare function libvlc_video_get_scale(byval p_mi as libvlc_media_player_t ptr) as single
declare sub libvlc_video_set_scale(byval p_mi as libvlc_media_player_t ptr, byval f_factor as single)
declare function libvlc_video_get_aspect_ratio(byval p_mi as libvlc_media_player_t ptr) as zstring ptr
declare sub libvlc_video_set_aspect_ratio(byval p_mi as libvlc_media_player_t ptr, byval psz_aspect as const zstring ptr)
declare function libvlc_video_get_spu(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_video_get_spu_count(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_video_get_spu_description(byval p_mi as libvlc_media_player_t ptr) as libvlc_track_description_t ptr
declare function libvlc_video_set_spu(byval p_mi as libvlc_media_player_t ptr, byval i_spu as long) as long
declare function libvlc_video_set_subtitle_file(byval p_mi as libvlc_media_player_t ptr, byval psz_subtitle as const zstring ptr) as long
declare function libvlc_video_get_spu_delay(byval p_mi as libvlc_media_player_t ptr) as longint
declare function libvlc_video_set_spu_delay(byval p_mi as libvlc_media_player_t ptr, byval i_delay as longint) as long
declare function libvlc_video_get_title_description(byval p_mi as libvlc_media_player_t ptr) as libvlc_track_description_t ptr
declare function libvlc_video_get_chapter_description(byval p_mi as libvlc_media_player_t ptr, byval i_title as long) as libvlc_track_description_t ptr
declare function libvlc_video_get_crop_geometry(byval p_mi as libvlc_media_player_t ptr) as zstring ptr
declare sub libvlc_video_set_crop_geometry(byval p_mi as libvlc_media_player_t ptr, byval psz_geometry as const zstring ptr)
declare function libvlc_video_get_teletext(byval p_mi as libvlc_media_player_t ptr) as long
declare sub libvlc_video_set_teletext(byval p_mi as libvlc_media_player_t ptr, byval i_page as long)
declare sub libvlc_toggle_teletext(byval p_mi as libvlc_media_player_t ptr)
declare function libvlc_video_get_track_count(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_video_get_track_description(byval p_mi as libvlc_media_player_t ptr) as libvlc_track_description_t ptr
declare function libvlc_video_get_track(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_video_set_track(byval p_mi as libvlc_media_player_t ptr, byval i_track as long) as long
declare function libvlc_video_take_snapshot(byval p_mi as libvlc_media_player_t ptr, byval num as ulong, byval psz_filepath as const zstring ptr, byval i_width as ulong, byval i_height as ulong) as long
declare sub libvlc_video_set_deinterlace(byval p_mi as libvlc_media_player_t ptr, byval psz_mode as const zstring ptr)
declare function libvlc_video_get_marquee_int(byval p_mi as libvlc_media_player_t ptr, byval option as ulong) as long
declare function libvlc_video_get_marquee_string(byval p_mi as libvlc_media_player_t ptr, byval option as ulong) as zstring ptr
declare sub libvlc_video_set_marquee_int(byval p_mi as libvlc_media_player_t ptr, byval option as ulong, byval i_val as long)
declare sub libvlc_video_set_marquee_string(byval p_mi as libvlc_media_player_t ptr, byval option as ulong, byval psz_text as const zstring ptr)

type libvlc_video_logo_option_t as long
enum
	libvlc_logo_enable
	libvlc_logo_file
	libvlc_logo_x
	libvlc_logo_y
	libvlc_logo_delay
	libvlc_logo_repeat
	libvlc_logo_opacity
	libvlc_logo_position
end enum

declare function libvlc_video_get_logo_int(byval p_mi as libvlc_media_player_t ptr, byval option as ulong) as long
declare sub libvlc_video_set_logo_int(byval p_mi as libvlc_media_player_t ptr, byval option as ulong, byval value as long)
declare sub libvlc_video_set_logo_string(byval p_mi as libvlc_media_player_t ptr, byval option as ulong, byval psz_value as const zstring ptr)

type libvlc_video_adjust_option_t as long
enum
	libvlc_adjust_Enable = 0
	libvlc_adjust_Contrast
	libvlc_adjust_Brightness
	libvlc_adjust_Hue
	libvlc_adjust_Saturation
	libvlc_adjust_Gamma
end enum

declare function libvlc_video_get_adjust_int(byval p_mi as libvlc_media_player_t ptr, byval option as ulong) as long
declare sub libvlc_video_set_adjust_int(byval p_mi as libvlc_media_player_t ptr, byval option as ulong, byval value as long)
declare function libvlc_video_get_adjust_float(byval p_mi as libvlc_media_player_t ptr, byval option as ulong) as single
declare sub libvlc_video_set_adjust_float(byval p_mi as libvlc_media_player_t ptr, byval option as ulong, byval value as single)

type libvlc_audio_output_device_types_t as long
enum
	libvlc_AudioOutputDevice_Error = -1
	libvlc_AudioOutputDevice_Mono = 1
	libvlc_AudioOutputDevice_Stereo = 2
	libvlc_AudioOutputDevice_2F2R = 4
	libvlc_AudioOutputDevice_3F2R = 5
	libvlc_AudioOutputDevice_5_1 = 6
	libvlc_AudioOutputDevice_6_1 = 7
	libvlc_AudioOutputDevice_7_1 = 8
	libvlc_AudioOutputDevice_SPDIF = 10
end enum

type libvlc_audio_output_channel_t as long
enum
	libvlc_AudioChannel_Error = -1
	libvlc_AudioChannel_Stereo = 1
	libvlc_AudioChannel_RStereo = 2
	libvlc_AudioChannel_Left = 3
	libvlc_AudioChannel_Right = 4
	libvlc_AudioChannel_Dolbys = 5
end enum

declare function libvlc_audio_output_list_get(byval p_instance as libvlc_instance_t ptr) as libvlc_audio_output_t ptr
declare sub libvlc_audio_output_list_release(byval p_list as libvlc_audio_output_t ptr)
declare function libvlc_audio_output_set(byval p_mi as libvlc_media_player_t ptr, byval psz_name as const zstring ptr) as long
declare function libvlc_audio_output_device_count(byval as libvlc_instance_t ptr, byval as const zstring ptr) as long
declare function libvlc_audio_output_device_longname(byval as libvlc_instance_t ptr, byval as const zstring ptr, byval as long) as zstring ptr
declare function libvlc_audio_output_device_id(byval as libvlc_instance_t ptr, byval as const zstring ptr, byval as long) as zstring ptr
declare function libvlc_audio_output_device_enum(byval mp as libvlc_media_player_t ptr) as libvlc_audio_output_device_t ptr
declare function libvlc_audio_output_device_list_get(byval p_instance as libvlc_instance_t ptr, byval aout as const zstring ptr) as libvlc_audio_output_device_t ptr
declare sub libvlc_audio_output_device_list_release(byval p_list as libvlc_audio_output_device_t ptr)
declare sub libvlc_audio_output_device_set(byval mp as libvlc_media_player_t ptr, byval module as const zstring ptr, byval device_id as const zstring ptr)
declare function libvlc_audio_output_get_device_type(byval p_mi as libvlc_media_player_t ptr) as long
declare sub libvlc_audio_output_set_device_type(byval as libvlc_media_player_t ptr, byval as long)
declare sub libvlc_audio_toggle_mute(byval p_mi as libvlc_media_player_t ptr)
declare function libvlc_audio_get_mute(byval p_mi as libvlc_media_player_t ptr) as long
declare sub libvlc_audio_set_mute(byval p_mi as libvlc_media_player_t ptr, byval status as long)
declare function libvlc_audio_get_volume(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_audio_set_volume(byval p_mi as libvlc_media_player_t ptr, byval i_volume as long) as long
declare function libvlc_audio_get_track_count(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_audio_get_track_description(byval p_mi as libvlc_media_player_t ptr) as libvlc_track_description_t ptr
declare function libvlc_audio_get_track(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_audio_set_track(byval p_mi as libvlc_media_player_t ptr, byval i_track as long) as long
declare function libvlc_audio_get_channel(byval p_mi as libvlc_media_player_t ptr) as long
declare function libvlc_audio_set_channel(byval p_mi as libvlc_media_player_t ptr, byval channel as long) as long
declare function libvlc_audio_get_delay(byval p_mi as libvlc_media_player_t ptr) as longint
declare function libvlc_audio_set_delay(byval p_mi as libvlc_media_player_t ptr, byval i_delay as longint) as long
declare function libvlc_audio_equalizer_get_preset_count() as ulong
declare function libvlc_audio_equalizer_get_preset_name(byval u_index as ulong) as const zstring ptr
declare function libvlc_audio_equalizer_get_band_count() as ulong
declare function libvlc_audio_equalizer_get_band_frequency(byval u_index as ulong) as single
type libvlc_equalizer_t as libvlc_equalizer_t_
declare function libvlc_audio_equalizer_new() as libvlc_equalizer_t ptr
declare function libvlc_audio_equalizer_new_from_preset(byval u_index as ulong) as libvlc_equalizer_t ptr
declare sub libvlc_audio_equalizer_release(byval p_equalizer as libvlc_equalizer_t ptr)
declare function libvlc_audio_equalizer_set_preamp(byval p_equalizer as libvlc_equalizer_t ptr, byval f_preamp as single) as long
declare function libvlc_audio_equalizer_get_preamp(byval p_equalizer as libvlc_equalizer_t ptr) as single
declare function libvlc_audio_equalizer_set_amp_at_index(byval p_equalizer as libvlc_equalizer_t ptr, byval f_amp as single, byval u_band as ulong) as long
declare function libvlc_audio_equalizer_get_amp_at_index(byval p_equalizer as libvlc_equalizer_t ptr, byval u_band as ulong) as single
declare function libvlc_media_player_set_equalizer(byval p_mi as libvlc_media_player_t ptr, byval p_equalizer as libvlc_equalizer_t ptr) as long

end extern
