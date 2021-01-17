#ifndef __FBHELP_CONTROLS_HELPBOX_BI__
#define __FBHELP_CONTROLS_HELPBOX_BI__

''  fbhelp - FreeBASIC help viewer
''  Copyright (C) 2006-2021 Jeffery R. Marshall (coder[at]execulink.com)

''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.


	const HELPBOX_STYLE_RAW   = 0
	const HELPBOX_STYLE_TEXT  = 1
	const HELPBOX_STYLE_HELP  = 2

	const HELPBOX_MAX_WIDTH   = 1024

	type helplink_t
		row as integer
		col as integer
		text as zstring ptr
		length as integer
		url as zstring ptr
		url_size as integer
		anchor as zstring ptr
		anchor_size as integer
	end type

	type helpbox_t
		ctl as control_t	'' must be first
		pagename as string
		pagetitle as string
		row as integer
		col as integer
		topindex as integer
		leftindex as integer
		style as integer
		buffer as textbuffer_t
		isFile as integer
		vscroll as scrollbar_t ptr
	end type

	declare sub HelpBox_Draw _
		( _
			byval ctl as helpbox_t ptr _
		)

	declare sub HelpBox_Update _
		( _
				byval ctl as helpbox_t ptr _
		)

	declare function HelpBox_KeyInput _
		( _
			byval ctl as helpbox_t ptr, _
			byval key as zstring ptr _
		) as integer

	declare sub HelpBox_SetPosition _
		( _
			byval ctl as helpbox_t ptr, _
			byval col as integer, _
			byval row as integer _
		)

	declare sub HelpBox_SetScrollIndex _
		( _
			byval ctl as helpbox_t ptr, _
			byval leftindex as integer, _
			byval topindex as integer _
		)

	declare function HelpBox_GenerateLinkIndex _
		( _
			byval ctl as helpbox_t ptr _
		) as integer

	declare function HelpBox_GetUrlFromPosition _
		( _
			byval ctl as helpbox_t ptr, _
			byval row as integer, _
			byval col as integer _
		) as string

	declare function HelpBox_SetNextUrlPosition _
		( _
			byval ctl as helpbox_t ptr, _
			byval char as integer, _
			byval target as zstring ptr _
		) as integer

	declare function HelpBox_SetPrevUrlPosition _
		( _
			byval ctl as helpbox_t ptr, _
			byval char as integer _
		) as integer

	declare sub HelpBox_SavePageProps ( byval ctl as helpbox_t ptr )
	declare function HelpBox_NavigateBack ( byval ctl as helpbox_t ptr ) as integer
	declare sub HelpBox_NavigateForward ( byval ctl as helpbox_t ptr )
	declare sub HelpBox_NavigateToPage _
		( _
			byval ctl as helpbox_t ptr, _
			byval pagename as zstring ptr, _
			byval isFile as integer _
		)

	declare sub HelpBox_NavigateLink ( byval ctl as helpbox_t ptr )
	declare sub HelpBox_NavigateNextLink( byval ctl as helpbox_t ptr, byval char as integer )
	declare sub HelpBox_NavigatePrevLink( byval ctl as helpbox_t ptr, byval char as integer )

	declare sub HelpBox_ClearHistory( byval ctl as helpbox_t ptr )

	declare function HelpBox_Default_Handler _
		( _
			byval ctl_in as control_t ptr, _
			byval msg as message_t ptr _
		) as integer

#endif
