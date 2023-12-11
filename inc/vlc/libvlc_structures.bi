'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    libvlc_structures.h:  libvlc_* new external API structures
''   ****************************************************************************
''    Copyright (C) 1998-2008 VLC authors and VideoLAN
''    $Id $
''
''    Authors: Filippo Carone <littlejohn@videolan.org>
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
''   FreeBASIC development team

#pragma once

#include once "crt/stdint.bi"

const LIBVLC_STRUCTURES_H = 1
type libvlc_time_t as longint

type libvlc_log_message_t
	i_severity as long
	psz_type as const zstring ptr
	psz_name as const zstring ptr
	psz_header as const zstring ptr
	psz_message as const zstring ptr
end type
