#ifndef __FBHELP_CONTROLS_FRAME_BI__
#define __FBHELP_CONTROLS_FRAME_BI__

''  fbhelp - FreeBASIC help viewer
''  Copyright (C) 2006-2008 Jeffery R. Marshall (coder[at]execulink.com)

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
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


	type frame_t
		ctl as control_t '' must be first
		title as string
		status as string
	end type

	declare sub Frame_Draw _
		( _
			byval fra as frame_t ptr _
		)

	const FRAME_FLAG_NORMAL = 0
	const FRAME_FLAG_NOFILL = 1
	const FRAME_FLAG_CLOSEBUTTON  = 2

	declare function Frame_Default_Handler _
		( _
			byval ctl_in as control_t ptr, _
			byval msg as message_t ptr _
		) as integer

#endif
