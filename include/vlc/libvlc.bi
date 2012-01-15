/'*****************************************************************************
 * libvlc.h:  libvlc external API
 *****************************************************************************
 * Copyright (C) 1998-2009 the VideoLAN team
 * $Id: 5f3b52b14616e057024858eebba05a7ac6eb5729 $
 *
 * Authors: Clément Stenac <zorglub@videolan.org>
 *          Jean-Paul Saman <jpsaman@videolan.org>
 *          Pierre d'Herbemont <pdherbemont@videolan.org>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
 *****************************************************************************/

/**
 * \file
 * This file defines libvlc external API
 */

/**
 * \defgroup libvlc LibVLC
 * LibVLC is the external programming interface of the VLC media player.
 * It is used to embed VLC into other applications or frameworks.
 * @{
 *'/

#ifndef __libvlc_bi__
#define __libvlc_bi__

#define VLC_LIBVLC_H 1

#include once "vlc/libvlc_structures.bi"
#include once "crt/stdarg.bi"

extern "C"

declare function libvlc_errmsg () as zstring ptr
declare sub libvlc_clearerr ()
declare function libvlc_printerr (byval fmt as zstring ptr, ...) as zstring ptr
declare function libvlc_new (byval argc as integer, byval argv as byte ptr ptr) as libvlc_instance_t ptr
declare sub libvlc_release (byval p_instance as libvlc_instance_t ptr)
declare sub libvlc_retain (byval p_instance as libvlc_instance_t ptr)
declare function libvlc_add_intf (byval p_instance as libvlc_instance_t ptr, byval name as zstring ptr) as integer
declare sub libvlc_wait (byval p_instance as libvlc_instance_t ptr)
declare function libvlc_get_version () as zstring ptr
declare function libvlc_get_compiler () as zstring ptr
declare function libvlc_get_changeset () as zstring ptr

type libvlc_event_manager_t as any
type libvlc_event_type_t as integer
type libvlc_callback_t as sub (byval as libvlc_event_t ptr, byval as any ptr)

declare function libvlc_event_attach (byval p_event_manager as libvlc_event_manager_t ptr, byval i_event_type as libvlc_event_type_t, byval f_callback as libvlc_callback_t, byval user_data as any ptr) as integer
declare sub libvlc_event_detach (byval p_event_manager as libvlc_event_manager_t ptr, byval i_event_type as libvlc_event_type_t, byval f_callback as libvlc_callback_t, byval p_user_data as any ptr)
declare function libvlc_event_type_name (byval event_type as libvlc_event_type_t) as zstring ptr
declare function libvlc_get_log_verbosity (byval p_instance as libvlc_instance_t ptr) as uinteger
declare sub libvlc_set_log_verbosity (byval p_instance as libvlc_instance_t ptr, byval level as uinteger)
declare function libvlc_log_open (byval p_instance as libvlc_instance_t ptr) as libvlc_log_t ptr
declare sub libvlc_log_close (byval p_log as libvlc_log_t ptr)
declare function libvlc_log_count (byval p_log as libvlc_log_t ptr) as uinteger
declare sub libvlc_log_clear (byval p_log as libvlc_log_t ptr)
declare function libvlc_log_get_iterator (byval p_log as libvlc_log_t ptr) as libvlc_log_iterator_t ptr
declare sub libvlc_log_iterator_free (byval p_iter as libvlc_log_iterator_t ptr)
declare function libvlc_log_iterator_has_next (byval p_iter as libvlc_log_iterator_t ptr) as integer
declare function libvlc_log_iterator_next (byval p_iter as libvlc_log_iterator_t ptr, byval p_buffer as libvlc_log_message_t ptr) as libvlc_log_message_t ptr

end extern

#endif
