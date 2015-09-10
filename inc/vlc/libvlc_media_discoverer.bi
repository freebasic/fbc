'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    libvlc_media_discoverer.h:  libvlc external API
''   ****************************************************************************
''    Copyright (C) 1998-2009 VLC authors and VideoLAN
''    $Id: cf263b0536d9b19e725e039f12ef20eaa392fec3 $
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

const VLC_LIBVLC_MEDIA_DISCOVERER_H = 1
type libvlc_media_discoverer_t as libvlc_media_discoverer_t_
declare function libvlc_media_discoverer_new_from_name(byval p_inst as libvlc_instance_t ptr, byval psz_name as const zstring ptr) as libvlc_media_discoverer_t ptr
declare sub libvlc_media_discoverer_release(byval p_mdis as libvlc_media_discoverer_t ptr)
declare function libvlc_media_discoverer_localized_name(byval p_mdis as libvlc_media_discoverer_t ptr) as zstring ptr
declare function libvlc_media_discoverer_media_list(byval p_mdis as libvlc_media_discoverer_t ptr) as libvlc_media_list_t ptr
declare function libvlc_media_discoverer_event_manager(byval p_mdis as libvlc_media_discoverer_t ptr) as libvlc_event_manager_t ptr
declare function libvlc_media_discoverer_is_running(byval p_mdis as libvlc_media_discoverer_t ptr) as long

end extern
