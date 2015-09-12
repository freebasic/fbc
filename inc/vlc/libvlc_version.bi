'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    libvlc_version.h
''   ****************************************************************************
''    Copyright (C) 2010 Rémi Denis-Courmont
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

const LIBVLC_VERSION_H = 1
const LIBVLC_VERSION_MAJOR = 2
const LIBVLC_VERSION_MINOR = 2
const LIBVLC_VERSION_REVISION = 1
const LIBVLC_VERSION_EXTRA = 0
#define LIBVLC_VERSION(maj, min, rev, extra) ((((maj shl 24) or (min shl 16)) or (rev shl 8)) or (extra))
#define LIBVLC_VERSION_INT LIBVLC_VERSION(LIBVLC_VERSION_MAJOR, LIBVLC_VERSION_MINOR, LIBVLC_VERSION_REVISION, LIBVLC_VERSION_EXTRA)
