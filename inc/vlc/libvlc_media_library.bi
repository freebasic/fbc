'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    libvlc_media_library.h:  libvlc external API
''   ****************************************************************************
''    Copyright (C) 1998-2009 VLC authors and VideoLAN
''    $Id: fa7094a6a8aac42607490c9982d9f4d082c2794c $
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

const VLC_LIBVLC_MEDIA_LIBRARY_H = 1
type libvlc_media_library_t as libvlc_media_library_t_
declare function libvlc_media_library_new(byval p_instance as libvlc_instance_t ptr) as libvlc_media_library_t ptr
declare sub libvlc_media_library_release(byval p_mlib as libvlc_media_library_t ptr)
declare sub libvlc_media_library_retain(byval p_mlib as libvlc_media_library_t ptr)
declare function libvlc_media_library_load(byval p_mlib as libvlc_media_library_t ptr) as long
declare function libvlc_media_library_media_list(byval p_mlib as libvlc_media_library_t ptr) as libvlc_media_list_t ptr

end extern
