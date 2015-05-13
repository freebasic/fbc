/'*****************************************************************************
 * deprecated.h:  libvlc deprecated API
 *****************************************************************************
 * Copyright (C) 1998-2008 the VideoLAN team
 * $Id: 216b1caba458403370a2aad252bcd63a6f5ca33d $
 *
 * Authors: Clément Stenac <zorglub@videolan.org>
 *          Jean-Paul Saman <jpsaman@videolan.org>
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
 *****************************************************************************'/
 
#ifndef __deprecated_bi__
#define __deprecated_bi__

#define LIBVLC_DEPRECATED_H 1

extern "C"

/'*****************************************************************************
 * Playlist (Deprecated)
 *****************************************************************************/
/**
 * Start playing (if there is any item in the playlist).
 *
 * Additionnal playlist item options can be specified for addition to the
 * item before it is played.
 *
 * \param p_instance the playlist instance
 * \param i_id the item to play. If this is a negative number, the next
 *        item will be selected. Otherwise, the item with the given ID will be
 *        played
 * \param i_options the number of options to add to the item
 * \param ppsz_options the options to add to the item
 *'/
 
declare sub libvlc_playlist_play( p_instance as libvlc_instance_t ptr, _
                                              i_id as integer, i_options as integer, _
                                              ppsz_options as zstring ptr ptr)

end extern

#endif
