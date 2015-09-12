'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    libvlc_media.h:  libvlc external API
''   ****************************************************************************
''    Copyright (C) 1998-2009 VLC authors and VideoLAN
''    $Id: 948230a3f17569091b982038ec2c66b48e1a4398 $
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

const VLC_LIBVLC_MEDIA_H = 1

type libvlc_meta_t as long
enum
	libvlc_meta_Title
	libvlc_meta_Artist
	libvlc_meta_Genre
	libvlc_meta_Copyright
	libvlc_meta_Album
	libvlc_meta_TrackNumber
	libvlc_meta_Description
	libvlc_meta_Rating
	libvlc_meta_Date
	libvlc_meta_Setting
	libvlc_meta_URL
	libvlc_meta_Language
	libvlc_meta_NowPlaying
	libvlc_meta_Publisher
	libvlc_meta_EncodedBy
	libvlc_meta_ArtworkURL
	libvlc_meta_TrackID
	libvlc_meta_TrackTotal
	libvlc_meta_Director
	libvlc_meta_Season
	libvlc_meta_Episode
	libvlc_meta_ShowName
	libvlc_meta_Actors
end enum

type libvlc_state_t as long
enum
	libvlc_NothingSpecial = 0
	libvlc_Opening
	libvlc_Buffering
	libvlc_Playing
	libvlc_Paused
	libvlc_Stopped
	libvlc_Ended
	libvlc_Error
end enum

enum
	libvlc_media_option_trusted = &h2
	libvlc_media_option_unique = &h100
end enum

type libvlc_track_type_t as long
enum
	libvlc_track_unknown = -1
	libvlc_track_audio = 0
	libvlc_track_video = 1
	libvlc_track_text = 2
end enum

type libvlc_media_stats_t
	i_read_bytes as long
	f_input_bitrate as single
	i_demux_read_bytes as long
	f_demux_bitrate as single
	i_demux_corrupted as long
	i_demux_discontinuity as long
	i_decoded_video as long
	i_decoded_audio as long
	i_displayed_pictures as long
	i_lost_pictures as long
	i_played_abuffers as long
	i_lost_abuffers as long
	i_sent_packets as long
	i_sent_bytes as long
	f_send_bitrate as single
end type

type libvlc_media_track_info_t_u_audio
	i_channels as ulong
	i_rate as ulong
end type

type libvlc_media_track_info_t_u_video
	i_height as ulong
	i_width as ulong
end type

union libvlc_media_track_info_t_u
	audio as libvlc_media_track_info_t_u_audio
	video as libvlc_media_track_info_t_u_video
end union

type libvlc_media_track_info_t
	i_codec as ulong
	i_id as long
	i_type as libvlc_track_type_t
	i_profile as long
	i_level as long
	u as libvlc_media_track_info_t_u
end type

type libvlc_audio_track_t
	i_channels as ulong
	i_rate as ulong
end type

type libvlc_video_track_t
	i_height as ulong
	i_width as ulong
	i_sar_num as ulong
	i_sar_den as ulong
	i_frame_rate_num as ulong
	i_frame_rate_den as ulong
end type

type libvlc_subtitle_track_t
	psz_encoding as zstring ptr
end type

type libvlc_media_track_t
	i_codec as ulong
	i_original_fourcc as ulong
	i_id as long
	i_type as libvlc_track_type_t
	i_profile as long
	i_level as long

	union
		audio as libvlc_audio_track_t ptr
		video as libvlc_video_track_t ptr
		subtitle as libvlc_subtitle_track_t ptr
	end union

	i_bitrate as ulong
	psz_language as zstring ptr
	psz_description as zstring ptr
end type

type libvlc_media_t as libvlc_media_t_
declare function libvlc_media_new_location(byval p_instance as libvlc_instance_t ptr, byval psz_mrl as const zstring ptr) as libvlc_media_t ptr
declare function libvlc_media_new_path(byval p_instance as libvlc_instance_t ptr, byval path as const zstring ptr) as libvlc_media_t ptr
declare function libvlc_media_new_fd(byval p_instance as libvlc_instance_t ptr, byval fd as long) as libvlc_media_t ptr
declare function libvlc_media_new_as_node(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr) as libvlc_media_t ptr
declare sub libvlc_media_add_option(byval p_md as libvlc_media_t ptr, byval psz_options as const zstring ptr)
declare sub libvlc_media_add_option_flag(byval p_md as libvlc_media_t ptr, byval psz_options as const zstring ptr, byval i_flags as ulong)
declare sub libvlc_media_retain(byval p_md as libvlc_media_t ptr)
declare sub libvlc_media_release(byval p_md as libvlc_media_t ptr)
declare function libvlc_media_get_mrl(byval p_md as libvlc_media_t ptr) as zstring ptr
declare function libvlc_media_duplicate(byval p_md as libvlc_media_t ptr) as libvlc_media_t ptr
declare function libvlc_media_get_meta(byval p_md as libvlc_media_t ptr, byval e_meta as libvlc_meta_t) as zstring ptr
declare sub libvlc_media_set_meta(byval p_md as libvlc_media_t ptr, byval e_meta as libvlc_meta_t, byval psz_value as const zstring ptr)
declare function libvlc_media_save_meta(byval p_md as libvlc_media_t ptr) as long
declare function libvlc_media_get_state(byval p_md as libvlc_media_t ptr) as libvlc_state_t
declare function libvlc_media_get_stats(byval p_md as libvlc_media_t ptr, byval p_stats as libvlc_media_stats_t ptr) as long
type libvlc_media_list_t as libvlc_media_list_t_
declare function libvlc_media_subitems(byval p_md as libvlc_media_t ptr) as libvlc_media_list_t ptr
declare function libvlc_media_event_manager(byval p_md as libvlc_media_t ptr) as libvlc_event_manager_t ptr
declare function libvlc_media_get_duration(byval p_md as libvlc_media_t ptr) as libvlc_time_t
declare sub libvlc_media_parse(byval p_md as libvlc_media_t ptr)
declare sub libvlc_media_parse_async(byval p_md as libvlc_media_t ptr)
declare function libvlc_media_is_parsed(byval p_md as libvlc_media_t ptr) as long
declare sub libvlc_media_set_user_data(byval p_md as libvlc_media_t ptr, byval p_new_user_data as any ptr)
declare function libvlc_media_get_user_data(byval p_md as libvlc_media_t ptr) as any ptr
declare function libvlc_media_get_tracks_info(byval p_md as libvlc_media_t ptr, byval tracks as libvlc_media_track_info_t ptr ptr) as long
declare function libvlc_media_tracks_get(byval p_md as libvlc_media_t ptr, byval tracks as libvlc_media_track_t ptr ptr ptr) as ulong
declare sub libvlc_media_tracks_release(byval p_tracks as libvlc_media_track_t ptr ptr, byval i_count as ulong)

end extern
