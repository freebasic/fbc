'' FreeBASIC binding for vlc-2.2.1
''
'' based on the C header files:
''   **************************************************************************
''    libvlc_events.h:  libvlc_events external API structure
''   ****************************************************************************
''    Copyright (C) 1998-2010 VLC authors and VideoLAN
''    $Id $
''
''    Authors: Filippo Carone <littlejohn@videolan.org>
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

const LIBVLC_EVENTS_H = 1

type libvlc_event_e as long
enum
	libvlc_MediaMetaChanged = 0
	libvlc_MediaSubItemAdded
	libvlc_MediaDurationChanged
	libvlc_MediaParsedChanged
	libvlc_MediaFreed
	libvlc_MediaStateChanged
	libvlc_MediaSubItemTreeAdded
	libvlc_MediaPlayerMediaChanged = &h100
	libvlc_MediaPlayerNothingSpecial
	libvlc_MediaPlayerOpening
	libvlc_MediaPlayerBuffering
	libvlc_MediaPlayerPlaying
	libvlc_MediaPlayerPaused
	libvlc_MediaPlayerStopped
	libvlc_MediaPlayerForward
	libvlc_MediaPlayerBackward
	libvlc_MediaPlayerEndReached
	libvlc_MediaPlayerEncounteredError
	libvlc_MediaPlayerTimeChanged
	libvlc_MediaPlayerPositionChanged
	libvlc_MediaPlayerSeekableChanged
	libvlc_MediaPlayerPausableChanged
	libvlc_MediaPlayerTitleChanged
	libvlc_MediaPlayerSnapshotTaken
	libvlc_MediaPlayerLengthChanged
	libvlc_MediaPlayerVout
	libvlc_MediaPlayerScrambledChanged
	libvlc_MediaListItemAdded = &h200
	libvlc_MediaListWillAddItem
	libvlc_MediaListItemDeleted
	libvlc_MediaListWillDeleteItem
	libvlc_MediaListViewItemAdded = &h300
	libvlc_MediaListViewWillAddItem
	libvlc_MediaListViewItemDeleted
	libvlc_MediaListViewWillDeleteItem
	libvlc_MediaListPlayerPlayed = &h400
	libvlc_MediaListPlayerNextItemSet
	libvlc_MediaListPlayerStopped
	libvlc_MediaDiscovererStarted = &h500
	libvlc_MediaDiscovererEnded
	libvlc_VlmMediaAdded = &h600
	libvlc_VlmMediaRemoved
	libvlc_VlmMediaChanged
	libvlc_VlmMediaInstanceStarted
	libvlc_VlmMediaInstanceStopped
	libvlc_VlmMediaInstanceStatusInit
	libvlc_VlmMediaInstanceStatusOpening
	libvlc_VlmMediaInstanceStatusPlaying
	libvlc_VlmMediaInstanceStatusPause
	libvlc_VlmMediaInstanceStatusEnd
	libvlc_VlmMediaInstanceStatusError
end enum

type libvlc_event_t_u_media_meta_changed
	meta_type as libvlc_meta_t
end type

type libvlc_event_t_u_media_subitem_added
	new_child as libvlc_media_t ptr
end type

type libvlc_event_t_u_media_duration_changed
	new_duration as longint
end type

type libvlc_event_t_u_media_parsed_changed
	new_status as long
end type

type libvlc_event_t_u_media_freed
	md as libvlc_media_t ptr
end type

type libvlc_event_t_u_media_state_changed
	new_state as libvlc_state_t
end type

type libvlc_event_t_u_media_subitemtree_added
	item as libvlc_media_t ptr
end type

type libvlc_event_t_u_media_player_buffering
	new_cache as single
end type

type libvlc_event_t_u_media_player_position_changed
	new_position as single
end type

type libvlc_event_t_u_media_player_time_changed
	new_time as libvlc_time_t
end type

type libvlc_event_t_u_media_player_title_changed
	new_title as long
end type

type libvlc_event_t_u_media_player_seekable_changed
	new_seekable as long
end type

type libvlc_event_t_u_media_player_pausable_changed
	new_pausable as long
end type

type libvlc_event_t_u_media_player_scrambled_changed
	new_scrambled as long
end type

type libvlc_event_t_u_media_player_vout
	new_count as long
end type

type libvlc_event_t_u_media_list_item_added
	item as libvlc_media_t ptr
	index as long
end type

type libvlc_event_t_u_media_list_will_add_item
	item as libvlc_media_t ptr
	index as long
end type

type libvlc_event_t_u_media_list_item_deleted
	item as libvlc_media_t ptr
	index as long
end type

type libvlc_event_t_u_media_list_will_delete_item
	item as libvlc_media_t ptr
	index as long
end type

type libvlc_event_t_u_media_list_player_next_item_set
	item as libvlc_media_t ptr
end type

type libvlc_event_t_u_media_player_snapshot_taken
	psz_filename as zstring ptr
end type

type libvlc_event_t_u_media_player_length_changed
	new_length as libvlc_time_t
end type

type libvlc_event_t_u_vlm_media_event
	psz_media_name as const zstring ptr
	psz_instance_name as const zstring ptr
end type

type libvlc_event_t_u_media_player_media_changed
	new_media as libvlc_media_t ptr
end type

union libvlc_event_t_u
	media_meta_changed as libvlc_event_t_u_media_meta_changed
	media_subitem_added as libvlc_event_t_u_media_subitem_added
	media_duration_changed as libvlc_event_t_u_media_duration_changed
	media_parsed_changed as libvlc_event_t_u_media_parsed_changed
	media_freed as libvlc_event_t_u_media_freed
	media_state_changed as libvlc_event_t_u_media_state_changed
	media_subitemtree_added as libvlc_event_t_u_media_subitemtree_added
	media_player_buffering as libvlc_event_t_u_media_player_buffering
	media_player_position_changed as libvlc_event_t_u_media_player_position_changed
	media_player_time_changed as libvlc_event_t_u_media_player_time_changed
	media_player_title_changed as libvlc_event_t_u_media_player_title_changed
	media_player_seekable_changed as libvlc_event_t_u_media_player_seekable_changed
	media_player_pausable_changed as libvlc_event_t_u_media_player_pausable_changed
	media_player_scrambled_changed as libvlc_event_t_u_media_player_scrambled_changed
	media_player_vout as libvlc_event_t_u_media_player_vout
	media_list_item_added as libvlc_event_t_u_media_list_item_added
	media_list_will_add_item as libvlc_event_t_u_media_list_will_add_item
	media_list_item_deleted as libvlc_event_t_u_media_list_item_deleted
	media_list_will_delete_item as libvlc_event_t_u_media_list_will_delete_item
	media_list_player_next_item_set as libvlc_event_t_u_media_list_player_next_item_set
	media_player_snapshot_taken as libvlc_event_t_u_media_player_snapshot_taken
	media_player_length_changed as libvlc_event_t_u_media_player_length_changed
	vlm_media_event as libvlc_event_t_u_vlm_media_event
	media_player_media_changed as libvlc_event_t_u_media_player_media_changed
end union

type libvlc_event_t_
	as long type
	p_obj as any ptr
	u as libvlc_event_t_u
end type
