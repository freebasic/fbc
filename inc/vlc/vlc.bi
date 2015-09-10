'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    vlc.h: global header for libvlc
''   ****************************************************************************
''    Copyright (C) 1998-2008 VLC authors and VideoLAN
''    $Id: 8f39094bd4b15c99288cecd001f76fcc10565daa $
''
''    Authors: Vincent Seguin <seguin@via.ecp.fr>
''             Samuel Hocevar <sam@zoy.org>
''             Gildas Bazin <gbazin@netcourrier.com>
''             Derk-Jan Hartman <hartman at videolan dot org>
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

#inclib "vlc"

#include once "vlc/libvlc_structures.bi"
#include once "vlc/libvlc.bi"
#include once "vlc/libvlc_media.bi"
#include once "vlc/libvlc_media_player.bi"
#include once "vlc/libvlc_media_list.bi"
#include once "vlc/libvlc_media_list_player.bi"
#include once "vlc/libvlc_media_library.bi"
#include once "vlc/libvlc_media_discoverer.bi"
#include once "vlc/libvlc_events.bi"
#include once "vlc/libvlc_vlm.bi"
#include once "vlc/deprecated.bi"

const VLC_VLC_H = 1
