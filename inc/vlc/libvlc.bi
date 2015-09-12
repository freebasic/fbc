'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    libvlc.h:  libvlc external API
''   ****************************************************************************
''    Copyright (C) 1998-2009 VLC authors and VideoLAN
''    $Id: 0bc0b401a553d2758abddf6f545022a6c2644405 $
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

#include once "crt/stdio.bi"
#include once "crt/stdarg.bi"
#include once "vlc/libvlc_structures.bi"

'' The following symbols have been renamed:
''     constant LIBVLC_ERROR => LIBVLC_ERROR_

extern "C"

const VLC_LIBVLC_H = 1
declare function libvlc_errmsg() as const zstring ptr
declare sub libvlc_clearerr()
declare function libvlc_vprinterr(byval fmt as const zstring ptr, byval ap as va_list) as const zstring ptr
declare function libvlc_printerr(byval fmt as const zstring ptr, ...) as const zstring ptr
type libvlc_instance_t as libvlc_instance_t_
declare function libvlc_new(byval argc as long, byval argv as const zstring const ptr ptr) as libvlc_instance_t ptr
declare sub libvlc_release(byval p_instance as libvlc_instance_t ptr)
declare sub libvlc_retain(byval p_instance as libvlc_instance_t ptr)
declare function libvlc_add_intf(byval p_instance as libvlc_instance_t ptr, byval name as const zstring ptr) as long
declare sub libvlc_set_exit_handler(byval p_instance as libvlc_instance_t ptr, byval cb as sub(byval as any ptr), byval opaque as any ptr)
declare sub libvlc_wait(byval p_instance as libvlc_instance_t ptr)
declare sub libvlc_set_user_agent(byval p_instance as libvlc_instance_t ptr, byval name as const zstring ptr, byval http as const zstring ptr)
declare sub libvlc_set_app_id(byval p_instance as libvlc_instance_t ptr, byval id as const zstring ptr, byval version as const zstring ptr, byval icon as const zstring ptr)
declare function libvlc_get_version() as const zstring ptr
declare function libvlc_get_compiler() as const zstring ptr
declare function libvlc_get_changeset() as const zstring ptr
declare sub libvlc_free(byval ptr as any ptr)

type libvlc_event_type_t as long
type libvlc_event_t as libvlc_event_t_
type libvlc_callback_t as sub(byval as const libvlc_event_t ptr, byval as any ptr)
type libvlc_event_manager_t as libvlc_event_manager_t_

declare function libvlc_event_attach(byval p_event_manager as libvlc_event_manager_t ptr, byval i_event_type as libvlc_event_type_t, byval f_callback as libvlc_callback_t, byval user_data as any ptr) as long
declare sub libvlc_event_detach(byval p_event_manager as libvlc_event_manager_t ptr, byval i_event_type as libvlc_event_type_t, byval f_callback as libvlc_callback_t, byval p_user_data as any ptr)
declare function libvlc_event_type_name(byval event_type as libvlc_event_type_t) as const zstring ptr

type libvlc_log_level as long
enum
	LIBVLC_DEBUG = 0
	LIBVLC_NOTICE = 2
	LIBVLC_WARNING = 3
	LIBVLC_ERROR_ = 4
end enum

type libvlc_log_t as vlc_log_t
declare sub libvlc_log_get_context(byval ctx as const libvlc_log_t ptr, byval module as const zstring ptr ptr, byval file as const zstring ptr ptr, byval line as ulong ptr)
declare sub libvlc_log_get_object(byval ctx as const libvlc_log_t ptr, byval name as const zstring ptr ptr, byval header as const zstring ptr ptr, byval id as uinteger ptr)
type libvlc_log_cb as sub(byval data as any ptr, byval level as long, byval ctx as const libvlc_log_t ptr, byval fmt as const zstring ptr, byval args as va_list)
declare sub libvlc_log_unset(byval as libvlc_instance_t ptr)
declare sub libvlc_log_set(byval as libvlc_instance_t ptr, byval cb as libvlc_log_cb, byval data as any ptr)
declare sub libvlc_log_set_file(byval as libvlc_instance_t ptr, byval stream as FILE ptr)
declare function libvlc_get_log_verbosity(byval p_instance as const libvlc_instance_t ptr) as ulong
declare sub libvlc_set_log_verbosity(byval p_instance as libvlc_instance_t ptr, byval level as ulong)
declare function libvlc_log_open(byval p_instance as libvlc_instance_t ptr) as libvlc_log_t ptr
declare sub libvlc_log_close(byval p_log as libvlc_log_t ptr)
declare function libvlc_log_count(byval p_log as const libvlc_log_t ptr) as ulong
declare sub libvlc_log_clear(byval p_log as libvlc_log_t ptr)
type libvlc_log_iterator_t as libvlc_log_iterator_t_
declare function libvlc_log_get_iterator(byval p_log as const libvlc_log_t ptr) as libvlc_log_iterator_t ptr
declare sub libvlc_log_iterator_free(byval p_iter as libvlc_log_iterator_t ptr)
declare function libvlc_log_iterator_has_next(byval p_iter as const libvlc_log_iterator_t ptr) as long
declare function libvlc_log_iterator_next(byval p_iter as libvlc_log_iterator_t ptr, byval p_buf as libvlc_log_message_t ptr) as libvlc_log_message_t ptr

type libvlc_module_description_t
	psz_name as zstring ptr
	psz_shortname as zstring ptr
	psz_longname as zstring ptr
	psz_help as zstring ptr
	p_next as libvlc_module_description_t ptr
end type

declare sub libvlc_module_description_list_release(byval p_list as libvlc_module_description_t ptr)
declare function libvlc_audio_filter_list_get(byval p_instance as libvlc_instance_t ptr) as libvlc_module_description_t ptr
declare function libvlc_video_filter_list_get(byval p_instance as libvlc_instance_t ptr) as libvlc_module_description_t ptr
declare function libvlc_clock() as longint
#define libvlc_delay(pts) clngint((pts) - libvlc_clock())

end extern
