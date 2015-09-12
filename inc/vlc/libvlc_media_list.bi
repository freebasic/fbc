'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    libvlc_media_list.h:  libvlc_media_list API
''   ****************************************************************************
''    Copyright (C) 1998-2008 VLC authors and VideoLAN
''    $Id: 015824bf54e656cc67838452c7e99a00a452af6e $
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

const LIBVLC_MEDIA_LIST_H = 1
declare function libvlc_media_list_new(byval p_instance as libvlc_instance_t ptr) as libvlc_media_list_t ptr
declare sub libvlc_media_list_release(byval p_ml as libvlc_media_list_t ptr)
declare sub libvlc_media_list_retain(byval p_ml as libvlc_media_list_t ptr)
declare function libvlc_media_list_add_file_content(byval p_ml as libvlc_media_list_t ptr, byval psz_uri as const zstring ptr) as long
declare sub libvlc_media_list_set_media(byval p_ml as libvlc_media_list_t ptr, byval p_md as libvlc_media_t ptr)
declare function libvlc_media_list_media(byval p_ml as libvlc_media_list_t ptr) as libvlc_media_t ptr
declare function libvlc_media_list_add_media(byval p_ml as libvlc_media_list_t ptr, byval p_md as libvlc_media_t ptr) as long
declare function libvlc_media_list_insert_media(byval p_ml as libvlc_media_list_t ptr, byval p_md as libvlc_media_t ptr, byval i_pos as long) as long
declare function libvlc_media_list_remove_index(byval p_ml as libvlc_media_list_t ptr, byval i_pos as long) as long
declare function libvlc_media_list_count(byval p_ml as libvlc_media_list_t ptr) as long
declare function libvlc_media_list_item_at_index(byval p_ml as libvlc_media_list_t ptr, byval i_pos as long) as libvlc_media_t ptr
declare function libvlc_media_list_index_of_item(byval p_ml as libvlc_media_list_t ptr, byval p_md as libvlc_media_t ptr) as long
declare function libvlc_media_list_is_readonly(byval p_ml as libvlc_media_list_t ptr) as long
declare sub libvlc_media_list_lock(byval p_ml as libvlc_media_list_t ptr)
declare sub libvlc_media_list_unlock(byval p_ml as libvlc_media_list_t ptr)
declare function libvlc_media_list_event_manager(byval p_ml as libvlc_media_list_t ptr) as libvlc_event_manager_t ptr

end extern
