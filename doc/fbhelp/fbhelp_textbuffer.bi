#ifndef __FBHELP_TEXTBUFFER_BI__
#define __FBHELP_TEXTBUFFER_BI__

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


	#include once "common.bi"

	type textrow_t
		size as integer
		text as ubyte ptr
		usercount as integer
		userdata as any ptr
	end type

	type textbuffer_t
		size as integer
		rowcount as integer
		rowindex as textrow_t ptr
		text as ubyte ptr
	end type

	declare sub TextBuffer_Clear _
		( _
			byval txt as textbuffer_t ptr _
		)

	declare function TextBuffer_GenerateRowIndex _
		( _
			byval txt as textbuffer_t ptr, _
			byval wordwrap as integer, _
			byval escaped as integer _
		) as integer

	declare function TextBuffer_LoadTextFile _
		( _
			byval txt as textbuffer_t ptr, _
			byval filename as zstring ptr _
		) as integer

	declare function TextBuffer_Resize _
		( _
			byval txt as textbuffer_t ptr, _
			byval r as integer _
		) as integer

#endif


