'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    libvlc_media_list_player.h:  libvlc_media_list API
''   ****************************************************************************
''    Copyright (C) 1998-2008 VLC authors and VideoLAN
''    $Id: c95ad972c7dcf380ef62e60d821af726848dae48 $
''
''    Authors: Pierre d'Herbemont
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

const LIBVLC_MEDIA_LIST_PLAYER_H = 1

type libvlc_playback_mode_t as long
enum
	libvlc_playback_mode_default
	libvlc_playback_mode_loop
	libvlc_playback_mode_repeat
end enum

type libvlc_media_list_player_t as libvlc_media_list_player_t_
declare function libvlc_media_list_player_new(byval p_instance as libvlc_instance_t ptr) as libvlc_media_list_player_t ptr
declare sub libvlc_media_list_player_release(byval p_mlp as libvlc_media_list_player_t ptr)
declare sub libvlc_media_list_player_retain(byval p_mlp as libvlc_media_list_player_t ptr)
declare function libvlc_media_list_player_event_manager(byval p_mlp as libvlc_media_list_player_t ptr) as libvlc_event_manager_t ptr
declare sub libvlc_media_list_player_set_media_player(byval p_mlp as libvlc_media_list_player_t ptr, byval p_mi as libvlc_media_player_t ptr)
declare sub libvlc_media_list_player_set_media_list(byval p_mlp as libvlc_media_list_player_t ptr, byval p_mlist as libvlc_media_list_t ptr)
declare sub libvlc_media_list_player_play(byval p_mlp as libvlc_media_list_player_t ptr)
declare sub libvlc_media_list_player_pause(byval p_mlp as libvlc_media_list_player_t ptr)
declare function libvlc_media_list_player_is_playing(byval p_mlp as libvlc_media_list_player_t ptr) as long
declare function libvlc_media_list_player_get_state(byval p_mlp as libvlc_media_list_player_t ptr) as libvlc_state_t
declare function libvlc_media_list_player_play_item_at_index(byval p_mlp as libvlc_media_list_player_t ptr, byval i_index as long) as long
declare function libvlc_media_list_player_play_item(byval p_mlp as libvlc_media_list_player_t ptr, byval p_md as libvlc_media_t ptr) as long
declare sub libvlc_media_list_player_stop(byval p_mlp as libvlc_media_list_player_t ptr)
declare function libvlc_media_list_player_next(byval p_mlp as libvlc_media_list_player_t ptr) as long
declare function libvlc_media_list_player_previous(byval p_mlp as libvlc_media_list_player_t ptr) as long
declare sub libvlc_media_list_player_set_playback_mode(byval p_mlp as libvlc_media_list_player_t ptr, byval e_mode as libvlc_playback_mode_t)

end extern
