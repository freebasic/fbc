''
''
'' libvlc_media_player -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __libvlc_media_player_bi__
#define __libvlc_media_player_bi__

#define VLC_LIBVLC_MEDIA_PLAYER_H 1

type libvlc_media_player_t as any

type libvlc_track_description_t
	i_id as integer
	psz_name as zstring ptr
	p_next as libvlc_track_description_t ptr
end type

type libvlc_track_description_t as any

type libvlc_audio_output_t
	psz_name as zstring ptr
	psz_description as zstring ptr
	p_next as libvlc_audio_output_t ptr
end type

type libvlc_audio_output_t as any

type libvlc_rectangle_t
	top as integer
	left as integer
	bottom as integer
	right as integer
end type

type libvlc_rectangle_t as any

enum libvlc_video_marquee_option_t
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


declare sub libvlc_media_player_release cdecl alias "libvlc_media_player_release" (byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_media_player_retain cdecl alias "libvlc_media_player_retain" (byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_media_player_set_media cdecl alias "libvlc_media_player_set_media" (byval p_mi as libvlc_media_player_t ptr, byval p_md as libvlc_media_t ptr)
declare function libvlc_media_player_is_playing cdecl alias "libvlc_media_player_is_playing" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_media_player_play cdecl alias "libvlc_media_player_play" (byval p_mi as libvlc_media_player_t ptr) as integer
declare sub libvlc_media_player_pause cdecl alias "libvlc_media_player_pause" (byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_media_player_stop cdecl alias "libvlc_media_player_stop" (byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_media_player_set_nsobject cdecl alias "libvlc_media_player_set_nsobject" (byval p_mi as libvlc_media_player_t ptr, byval drawable as any ptr)
declare function libvlc_media_player_get_nsobject cdecl alias "libvlc_media_player_get_nsobject" (byval p_mi as libvlc_media_player_t ptr) as any ptr
declare sub libvlc_media_player_set_agl cdecl alias "libvlc_media_player_set_agl" (byval p_mi as libvlc_media_player_t ptr, byval drawable as uint32_t)
declare sub libvlc_media_player_set_xwindow cdecl alias "libvlc_media_player_set_xwindow" (byval p_mi as libvlc_media_player_t ptr, byval drawable as uint32_t)
declare sub libvlc_media_player_set_hwnd cdecl alias "libvlc_media_player_set_hwnd" (byval p_mi as libvlc_media_player_t ptr, byval drawable as any ptr)
declare function libvlc_media_player_get_hwnd cdecl alias "libvlc_media_player_get_hwnd" (byval p_mi as libvlc_media_player_t ptr) as any ptr
declare sub libvlc_media_player_set_time cdecl alias "libvlc_media_player_set_time" (byval p_mi as libvlc_media_player_t ptr, byval i_time as libvlc_time_t)
declare function libvlc_media_player_get_position cdecl alias "libvlc_media_player_get_position" (byval p_mi as libvlc_media_player_t ptr) as single
declare sub libvlc_media_player_set_position cdecl alias "libvlc_media_player_set_position" (byval p_mi as libvlc_media_player_t ptr, byval f_pos as single)
declare sub libvlc_media_player_set_chapter cdecl alias "libvlc_media_player_set_chapter" (byval p_mi as libvlc_media_player_t ptr, byval i_chapter as integer)
declare function libvlc_media_player_get_chapter cdecl alias "libvlc_media_player_get_chapter" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_media_player_get_chapter_count cdecl alias "libvlc_media_player_get_chapter_count" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_media_player_will_play cdecl alias "libvlc_media_player_will_play" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_media_player_get_chapter_count_for_title cdecl alias "libvlc_media_player_get_chapter_count_for_title" (byval p_mi as libvlc_media_player_t ptr, byval i_title as integer) as integer
declare sub libvlc_media_player_set_title cdecl alias "libvlc_media_player_set_title" (byval p_mi as libvlc_media_player_t ptr, byval i_title as integer)
declare function libvlc_media_player_get_title cdecl alias "libvlc_media_player_get_title" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_media_player_get_title_count cdecl alias "libvlc_media_player_get_title_count" (byval p_mi as libvlc_media_player_t ptr) as integer
declare sub libvlc_media_player_previous_chapter cdecl alias "libvlc_media_player_previous_chapter" (byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_media_player_next_chapter cdecl alias "libvlc_media_player_next_chapter" (byval p_mi as libvlc_media_player_t ptr)
declare function libvlc_media_player_get_rate cdecl alias "libvlc_media_player_get_rate" (byval p_mi as libvlc_media_player_t ptr) as single
declare function libvlc_media_player_set_rate cdecl alias "libvlc_media_player_set_rate" (byval p_mi as libvlc_media_player_t ptr, byval rate as single) as integer
declare function libvlc_media_player_get_fps cdecl alias "libvlc_media_player_get_fps" (byval p_mi as libvlc_media_player_t ptr) as single
declare function libvlc_media_player_has_vout cdecl alias "libvlc_media_player_has_vout" (byval p_mi as libvlc_media_player_t ptr) as uinteger
declare function libvlc_media_player_is_seekable cdecl alias "libvlc_media_player_is_seekable" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_media_player_can_pause cdecl alias "libvlc_media_player_can_pause" (byval p_mi as libvlc_media_player_t ptr) as integer
declare sub libvlc_media_player_next_frame cdecl alias "libvlc_media_player_next_frame" (byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_track_description_release cdecl alias "libvlc_track_description_release" (byval p_track_description as libvlc_track_description_t ptr)
declare sub libvlc_toggle_fullscreen cdecl alias "libvlc_toggle_fullscreen" (byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_set_fullscreen cdecl alias "libvlc_set_fullscreen" (byval p_mi as libvlc_media_player_t ptr, byval b_fullscreen as integer)
declare function libvlc_get_fullscreen cdecl alias "libvlc_get_fullscreen" (byval p_mi as libvlc_media_player_t ptr) as integer
declare sub libvlc_video_set_key_input cdecl alias "libvlc_video_set_key_input" (byval p_mi as libvlc_media_player_t ptr, byval on as uinteger)
declare sub libvlc_video_set_mouse_input cdecl alias "libvlc_video_set_mouse_input" (byval p_mi as libvlc_media_player_t ptr, byval on as uinteger)
declare function libvlc_video_get_size cdecl alias "libvlc_video_get_size" (byval p_mi as libvlc_media_player_t ptr, byval num as uinteger, byval px as uinteger ptr, byval py as uinteger ptr) as integer
declare function libvlc_video_get_height cdecl alias "libvlc_video_get_height" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_video_get_width cdecl alias "libvlc_video_get_width" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_video_get_cursor cdecl alias "libvlc_video_get_cursor" (byval p_mi as libvlc_media_player_t ptr, byval num as uinteger, byval px as integer ptr, byval py as integer ptr) as integer
declare function libvlc_video_get_scale cdecl alias "libvlc_video_get_scale" (byval p_mi as libvlc_media_player_t ptr) as single
declare sub libvlc_video_set_scale cdecl alias "libvlc_video_set_scale" (byval p_mi as libvlc_media_player_t ptr, byval f_factor as single)
declare function libvlc_video_get_aspect_ratio cdecl alias "libvlc_video_get_aspect_ratio" (byval p_mi as libvlc_media_player_t ptr) as zstring ptr
declare sub libvlc_video_set_aspect_ratio cdecl alias "libvlc_video_set_aspect_ratio" (byval p_mi as libvlc_media_player_t ptr, byval psz_aspect as zstring ptr)
declare function libvlc_video_get_spu cdecl alias "libvlc_video_get_spu" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_video_get_spu_count cdecl alias "libvlc_video_get_spu_count" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_video_set_spu cdecl alias "libvlc_video_set_spu" (byval p_mi as libvlc_media_player_t ptr, byval i_spu as uinteger) as integer
declare function libvlc_video_set_subtitle_file cdecl alias "libvlc_video_set_subtitle_file" (byval p_mi as libvlc_media_player_t ptr, byval psz_subtitle as zstring ptr) as integer
declare function libvlc_video_get_crop_geometry cdecl alias "libvlc_video_get_crop_geometry" (byval p_mi as libvlc_media_player_t ptr) as zstring ptr
declare sub libvlc_video_set_crop_geometry cdecl alias "libvlc_video_set_crop_geometry" (byval p_mi as libvlc_media_player_t ptr, byval psz_geometry as zstring ptr)
declare function libvlc_video_get_teletext cdecl alias "libvlc_video_get_teletext" (byval p_mi as libvlc_media_player_t ptr) as integer
declare sub libvlc_video_set_teletext cdecl alias "libvlc_video_set_teletext" (byval p_mi as libvlc_media_player_t ptr, byval i_page as integer)
declare sub libvlc_toggle_teletext cdecl alias "libvlc_toggle_teletext" (byval p_mi as libvlc_media_player_t ptr)
declare function libvlc_video_get_track_count cdecl alias "libvlc_video_get_track_count" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_video_get_track cdecl alias "libvlc_video_get_track" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_video_set_track cdecl alias "libvlc_video_set_track" (byval p_mi as libvlc_media_player_t ptr, byval i_track as integer) as integer
declare function libvlc_video_take_snapshot cdecl alias "libvlc_video_take_snapshot" (byval p_mi as libvlc_media_player_t ptr, byval num as uinteger, byval psz_filepath as zstring ptr, byval i_width as uinteger, byval i_height as uinteger) as integer
declare sub libvlc_video_set_deinterlace cdecl alias "libvlc_video_set_deinterlace" (byval p_mi as libvlc_media_player_t ptr, byval psz_mode as zstring ptr)
declare function libvlc_video_get_marquee_int cdecl alias "libvlc_video_get_marquee_int" (byval p_mi as libvlc_media_player_t ptr, byval option as uinteger) as integer
declare function libvlc_video_get_marquee_string cdecl alias "libvlc_video_get_marquee_string" (byval p_mi as libvlc_media_player_t ptr, byval option as uinteger) as zstring ptr
declare sub libvlc_video_set_marquee_int cdecl alias "libvlc_video_set_marquee_int" (byval p_mi as libvlc_media_player_t ptr, byval option as uinteger, byval i_val as integer)
declare sub libvlc_video_set_marquee_string cdecl alias "libvlc_video_set_marquee_string" (byval p_mi as libvlc_media_player_t ptr, byval option as uinteger, byval psz_text as zstring ptr)

enum libvlc_video_logo_option_t
	libvlc_logo_enable
	libvlc_logo_file
	libvlc_logo_x
	libvlc_logo_y
	libvlc_logo_delay
	libvlc_logo_repeat
	libvlc_logo_opacity
	libvlc_logo_position
end enum

declare function libvlc_video_get_logo_int cdecl alias "libvlc_video_get_logo_int" (byval p_mi as libvlc_media_player_t ptr, byval option as uinteger) as integer
declare sub libvlc_video_set_logo_int cdecl alias "libvlc_video_set_logo_int" (byval p_mi as libvlc_media_player_t ptr, byval option as uinteger, byval value as integer)
declare sub libvlc_video_set_logo_string cdecl alias "libvlc_video_set_logo_string" (byval p_mi as libvlc_media_player_t ptr, byval option as uinteger, byval psz_value as zstring ptr)

enum libvlc_audio_output_device_types_t
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


enum libvlc_audio_output_channel_t
	libvlc_AudioChannel_Error = -1
	libvlc_AudioChannel_Stereo = 1
	libvlc_AudioChannel_RStereo = 2
	libvlc_AudioChannel_Left = 3
	libvlc_AudioChannel_Right = 4
	libvlc_AudioChannel_Dolbys = 5
end enum


declare sub libvlc_audio_output_list_release cdecl alias "libvlc_audio_output_list_release" (byval p_list as libvlc_audio_output_t ptr)
declare function libvlc_audio_output_set cdecl alias "libvlc_audio_output_set" (byval p_mi as libvlc_media_player_t ptr, byval psz_name as zstring ptr) as integer
declare function libvlc_audio_output_device_count cdecl alias "libvlc_audio_output_device_count" (byval p_instance as libvlc_instance_t ptr, byval psz_audio_output as zstring ptr) as integer
declare function libvlc_audio_output_device_longname cdecl alias "libvlc_audio_output_device_longname" (byval p_instance as libvlc_instance_t ptr, byval psz_audio_output as zstring ptr, byval i_device as integer) as zstring ptr
declare function libvlc_audio_output_device_id cdecl alias "libvlc_audio_output_device_id" (byval p_instance as libvlc_instance_t ptr, byval psz_audio_output as zstring ptr, byval i_device as integer) as zstring ptr
declare sub libvlc_audio_output_device_set cdecl alias "libvlc_audio_output_device_set" (byval p_mi as libvlc_media_player_t ptr, byval psz_audio_output as zstring ptr, byval psz_device_id as zstring ptr)
declare function libvlc_audio_output_get_device_type cdecl alias "libvlc_audio_output_get_device_type" (byval p_mi as libvlc_media_player_t ptr) as integer
declare sub libvlc_audio_output_set_device_type cdecl alias "libvlc_audio_output_set_device_type" (byval p_mi as libvlc_media_player_t ptr, byval device_type as integer)
declare sub libvlc_audio_toggle_mute cdecl alias "libvlc_audio_toggle_mute" (byval p_mi as libvlc_media_player_t ptr)
declare function libvlc_audio_get_mute cdecl alias "libvlc_audio_get_mute" (byval p_mi as libvlc_media_player_t ptr) as integer
declare sub libvlc_audio_set_mute cdecl alias "libvlc_audio_set_mute" (byval p_mi as libvlc_media_player_t ptr, byval status as integer)
declare function libvlc_audio_get_volume cdecl alias "libvlc_audio_get_volume" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_audio_set_volume cdecl alias "libvlc_audio_set_volume" (byval p_mi as libvlc_media_player_t ptr, byval i_volume as integer) as integer
declare function libvlc_audio_get_track_count cdecl alias "libvlc_audio_get_track_count" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_audio_get_track cdecl alias "libvlc_audio_get_track" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_audio_set_track cdecl alias "libvlc_audio_set_track" (byval p_mi as libvlc_media_player_t ptr, byval i_track as integer) as integer
declare function libvlc_audio_get_channel cdecl alias "libvlc_audio_get_channel" (byval p_mi as libvlc_media_player_t ptr) as integer
declare function libvlc_audio_set_channel cdecl alias "libvlc_audio_set_channel" (byval p_mi as libvlc_media_player_t ptr, byval channel as integer) as integer

#endif
