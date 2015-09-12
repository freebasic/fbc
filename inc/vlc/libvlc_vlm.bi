'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    libvlc_vlm.h:  libvlc_* new external API
''   ****************************************************************************
''    Copyright (C) 1998-2008 VLC authors and VideoLAN
''    $Id: 26e5cbb5ee7968a21520af0b8f553a4a117d4f99 $
''
''    Authors: Clément Stenac <zorglub@videolan.org>
''             Jean-Paul Saman <jpsaman _at_ m2x _dot_ nl>
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

const LIBVLC_VLM_H = 1
declare sub libvlc_vlm_release(byval p_instance as libvlc_instance_t ptr)
declare function libvlc_vlm_add_broadcast(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval psz_input as const zstring ptr, byval psz_output as const zstring ptr, byval i_options as long, byval ppsz_options as const zstring const ptr ptr, byval b_enabled as long, byval b_loop as long) as long
declare function libvlc_vlm_add_vod(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval psz_input as const zstring ptr, byval i_options as long, byval ppsz_options as const zstring const ptr ptr, byval b_enabled as long, byval psz_mux as const zstring ptr) as long
declare function libvlc_vlm_del_media(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr) as long
declare function libvlc_vlm_set_enabled(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval b_enabled as long) as long
declare function libvlc_vlm_set_output(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval psz_output as const zstring ptr) as long
declare function libvlc_vlm_set_input(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval psz_input as const zstring ptr) as long
declare function libvlc_vlm_add_input(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval psz_input as const zstring ptr) as long
declare function libvlc_vlm_set_loop(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval b_loop as long) as long
declare function libvlc_vlm_set_mux(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval psz_mux as const zstring ptr) as long
declare function libvlc_vlm_change_media(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval psz_input as const zstring ptr, byval psz_output as const zstring ptr, byval i_options as long, byval ppsz_options as const zstring const ptr ptr, byval b_enabled as long, byval b_loop as long) as long
declare function libvlc_vlm_play_media(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr) as long
declare function libvlc_vlm_stop_media(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr) as long
declare function libvlc_vlm_pause_media(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr) as long
declare function libvlc_vlm_seek_media(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval f_percentage as single) as long
declare function libvlc_vlm_show_media(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr) as const zstring ptr
declare function libvlc_vlm_get_media_instance_position(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval i_instance as long) as single
declare function libvlc_vlm_get_media_instance_time(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval i_instance as long) as long
declare function libvlc_vlm_get_media_instance_length(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval i_instance as long) as long
declare function libvlc_vlm_get_media_instance_rate(byval p_instance as libvlc_instance_t ptr, byval psz_name as const zstring ptr, byval i_instance as long) as long
declare function libvlc_vlm_get_event_manager(byval p_instance as libvlc_instance_t ptr) as libvlc_event_manager_t ptr

end extern
