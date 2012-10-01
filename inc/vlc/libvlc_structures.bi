/'*****************************************************************************
 * libvlc.h:  libvlc_* new external API structures
 *****************************************************************************
 * Copyright (C) 1998-2008 the VideoLAN team
 * $Id $
 *
 * Authors: Filippo Carone <littlejohn@videolan.org>
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
 
#ifndef __libvlc_structures_bi__
#define __libvlc_structures_bi__

#define LIBVLC_STRUCTURES_H 1

'/** This structure is opaque. It represents a libvlc instance */
type libvlc_instance_t as any

type libvlc_time_t as longint

'/** This structure is opaque. It represents a libvlc log instance */
type libvlc_log_t as any

'/** This structure is opaque. It represents a libvlc log iterator */
type libvlc_log_iterator_t as any

type libvlc_log_message_t
	sizeof_msg as uinteger			'sizeof() of message structure, must be filled in by user
	i_severity as integer			'0=INFO, 1=ERR, 2=WARN, 3=DBG
	psz_type as zstring ptr			'module type
	psz_name as zstring ptr			'module name
	psz_header as zstring ptr		'optional header
	psz_message as zstring ptr		'message
end type

#endif
