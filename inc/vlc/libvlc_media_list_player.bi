''
''
'' libvlc_media_list_player -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __libvlc_media_list_player_bi__
#define __libvlc_media_list_player_bi__

#define LIBVLC_MEDIA_LIST_PLAYER_H 1

type libvlc_media_list_player_t as any

enum libvlc_playback_mode_t
	libvlc_playback_mode_default
	libvlc_playback_mode_loop
	libvlc_playback_mode_repeat
end enum


declare sub libvlc_media_list_player_release cdecl alias "libvlc_media_list_player_release" (byval p_mlp as libvlc_media_list_player_t ptr)
declare sub libvlc_media_list_player_set_media_player cdecl alias "libvlc_media_list_player_set_media_player" (byval p_mlp as libvlc_media_list_player_t ptr, byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_media_list_player_set_media_list cdecl alias "libvlc_media_list_player_set_media_list" (byval p_mlp as libvlc_media_list_player_t ptr, byval p_mlist as libvlc_media_list_t ptr)
declare sub libvlc_media_list_player_play cdecl alias "libvlc_media_list_player_play" (byval p_mlp as libvlc_media_list_player_t ptr)
declare sub libvlc_media_list_player_pause cdecl alias "libvlc_media_list_player_pause" (byval p_mlp as libvlc_media_list_player_t ptr)
declare function libvlc_media_list_player_is_playing cdecl alias "libvlc_media_list_player_is_playing" (byval p_mlp as libvlc_media_list_player_t ptr) as integer
declare function libvlc_media_list_player_play_item_at_index cdecl alias "libvlc_media_list_player_play_item_at_index" (byval p_mlp as libvlc_media_list_player_t ptr, byval i_index as integer) as integer
declare function libvlc_media_list_player_play_item cdecl alias "libvlc_media_list_player_play_item" (byval p_mlp as libvlc_media_list_player_t ptr, byval p_md as libvlc_media_t ptr) as integer
declare sub libvlc_media_list_player_stop cdecl alias "libvlc_media_list_player_stop" (byval p_mlp as libvlc_media_list_player_t ptr)
declare function libvlc_media_list_player_next cdecl alias "libvlc_media_list_player_next" (byval p_mlp as libvlc_media_list_player_t ptr) as integer
declare function libvlc_media_list_player_previous cdecl alias "libvlc_media_list_player_previous" (byval p_mlp as libvlc_media_list_player_t ptr) as integer
declare sub libvlc_media_list_player_set_playback_mode cdecl alias "libvlc_media_list_player_set_playback_mode" (byval p_mlp as libvlc_media_list_player_t ptr, byval e_mode as libvlc_playback_mode_t)

#endif
