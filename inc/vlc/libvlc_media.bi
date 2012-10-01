''
''
'' libvlc_media -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __libvlc_media_bi__
#define __libvlc_media_bi__

#define VLC_LIBVLC_MEDIA_H 1

type libvlc_media_t as any

enum libvlc_meta_t
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
end enum


enum libvlc_state_t
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

enum libvlc_track_type_t
	libvlc_track_unknown = -1
	libvlc_track_audio = 0
	libvlc_track_video = 1
	libvlc_track_text = 2
end enum


type libvlc_media_stats_t
	i_read_bytes as integer
	f_input_bitrate as single
	i_demux_read_bytes as integer
	f_demux_bitrate as single
	i_demux_corrupted as integer
	i_demux_discontinuity as integer
	i_decoded_video as integer
	i_decoded_audio as integer
	i_displayed_pictures as integer
	i_lost_pictures as integer
	i_played_abuffers as integer
	i_lost_abuffers as integer
	i_sent_packets as integer
	i_sent_bytes as integer
	f_send_bitrate as single
end type

type libvlc_media_stats_t as any

type libvlc_media_track_info_t
	i_codec as uint32_t
	i_id as integer
	i_type as libvlc_track_type_t
	i_profile as integer
	i_level as integer
	u as libvlc_media_track_info_t__NESTED__u
end type

type libvlc_media_track_info_t as any

union libvlc_media_track_info_t__NESTED__u
	video as libvlc_media_track_info_t__NESTED__u__NESTED__video
	audio as libvlc_media_track_info_t__NESTED__u__NESTED__audio
end union

type libvlc_media_track_info_t__NESTED__u__NESTED__video
	i_height as uinteger
	i_width as uinteger
end type

type libvlc_media_track_info_t__NESTED__u__NESTED__audio
	i_channels as uinteger
	i_rate as uinteger
end type

declare sub libvlc_media_add_option cdecl alias "libvlc_media_add_option" (byval p_md as libvlc_media_t ptr, byval ppsz_options as zstring ptr)
declare sub libvlc_media_add_option_flag cdecl alias "libvlc_media_add_option_flag" (byval p_md as libvlc_media_t ptr, byval ppsz_options as zstring ptr, byval i_flags as uinteger)
declare sub libvlc_media_retain cdecl alias "libvlc_media_retain" (byval p_md as libvlc_media_t ptr)
declare sub libvlc_media_release cdecl alias "libvlc_media_release" (byval p_md as libvlc_media_t ptr)
declare function libvlc_media_get_mrl cdecl alias "libvlc_media_get_mrl" (byval p_md as libvlc_media_t ptr) as zstring ptr
declare function libvlc_media_get_meta cdecl alias "libvlc_media_get_meta" (byval p_md as libvlc_media_t ptr, byval e_meta as libvlc_meta_t) as zstring ptr
declare sub libvlc_media_set_meta cdecl alias "libvlc_media_set_meta" (byval p_md as libvlc_media_t ptr, byval e_meta as libvlc_meta_t, byval psz_value as zstring ptr)
declare function libvlc_media_save_meta cdecl alias "libvlc_media_save_meta" (byval p_md as libvlc_media_t ptr) as integer
declare function libvlc_media_get_stats cdecl alias "libvlc_media_get_stats" (byval p_md as libvlc_media_t ptr, byval p_stats as libvlc_media_stats_t ptr) as integer
declare function libvlc_media_subitems cdecl alias "libvlc_media_subitems" (byval p_md as libvlc_media_t ptr) as libvlc_media_list_t ptr
declare sub libvlc_media_parse cdecl alias "libvlc_media_parse" (byval media as libvlc_media_t ptr)
declare sub libvlc_media_parse_async cdecl alias "libvlc_media_parse_async" (byval media as libvlc_media_t ptr)
declare function libvlc_media_is_parsed cdecl alias "libvlc_media_is_parsed" (byval p_md as libvlc_media_t ptr) as integer
declare sub libvlc_media_set_user_data cdecl alias "libvlc_media_set_user_data" (byval p_md as libvlc_media_t ptr, byval p_new_user_data as any ptr)
declare function libvlc_media_get_user_data cdecl alias "libvlc_media_get_user_data" (byval p_md as libvlc_media_t ptr) as any ptr
declare function libvlc_media_get_tracks_info cdecl alias "libvlc_media_get_tracks_info" (byval media as libvlc_media_t ptr, byval tracks as libvlc_media_track_info_t ptr ptr) as integer

#endif
