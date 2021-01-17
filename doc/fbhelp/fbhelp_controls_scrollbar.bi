#ifndef __FBHELP_CONTROLS_SCROLLBAR_BI__
#define __FBHELP_CONTROLS_SCROLLBAR_BI__

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


	const SCROLLBAR_FLAG_VERTICAL = 1
	const SCROLLBAR_FLAG_HORIZONTAL = 2

	type scrollbar_t
		ctl as control_t '' must be first
		xValMin as integer
		xValMax as integer
		xVal as integer
		xPosMin as integer
		xPosMax as integer
		xPos as integer
		xScale as single
		linkedctl as control_t ptr
	end type

	declare sub ScrollBar_Draw _
		( _
			byval sb as ScrollBar_t ptr _
		)

	declare sub ScrollBar_SetLimits _
		( _
			byval sb as ScrollBar_t ptr, _
			byval xValMin as integer, _
			byval xValMax as integer _
		)

	declare sub ScrollBar_SetValue _
		( _
			byval sb as ScrollBar_t ptr, _
			byval xVal as integer _
		)

	declare sub ScrollBar_SetPosition _
		( _
			byval sb as ScrollBar_t ptr, _
			byval xPos as integer _
		)

	declare function ScrollBar_Default_Handler _
		( _
			byval ctl_in as control_t ptr, _
			byval msg as message_t ptr _
		) as integer

#endif
