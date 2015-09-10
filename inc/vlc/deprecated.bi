'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    deprecated.h:  libvlc deprecated API
''   ****************************************************************************
''    Copyright (C) 1998-2008 VLC authors and VideoLAN
''    $Id: 7f55090fcd482489ceed9145ce2253e78fa6fd2a $
''
''    Authors: Clément Stenac <zorglub@videolan.org>
''             Jean-Paul Saman <jpsaman@videolan.org>
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

const LIBVLC_DEPRECATED_H = 1
declare sub libvlc_playlist_play(byval p_instance as libvlc_instance_t ptr, byval i_id as long, byval i_options as long, byval ppsz_options as zstring ptr ptr)

end extern
