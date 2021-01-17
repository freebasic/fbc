#ifndef __FBHELP_CONTROLS_BUTTON_BI__
#define __FBHELP_CONTROLS_BUTTON_BI__

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


	type button_t
		ctl as control_t '' must be first
		text as string
	end type

	declare sub Button_Draw _
		( _
			byval ctl as button_t ptr _
		)

	declare sub Button_Update _
		( _
			byval ctl as button_t ptr _
		)

	declare function Button_Default_Handler _
		( _
			byval ctl_in as control_t ptr, _
			byval msg as message_t ptr _
		) as integer

	const BUTTON_FLAG_DOWN = 1

#endif
