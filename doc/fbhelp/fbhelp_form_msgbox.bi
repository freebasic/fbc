#ifndef __FBHELP_FORM_MSGBOX_BI__
#define __FBHELP_FORM_MSGBOX_BI__

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


#if __FB_GCC__

	declare function MsgBox_show cdecl _
		( _
			byval text as zstring ptr, _
			byval title as zstring ptr, _
			byval count as integer, _
			byval btn1 as zstring ptr = NULL, _
			byval btn2 as zstring ptr = NULL, _
			byval btn3 as zstring ptr = NULL, _
			byval btn4 as zstring ptr = NULL _
		) as integer

#else

	declare function MsgBox_show cdecl _
		( _
			byval text as zstring ptr, _
			byval title as zstring ptr, _
			byval count as integer, _
			... _
		) as integer

#endif

#endif
