''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006-2022 The FreeBASIC development team.
''
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


'' fbdoc_trace - global state for tracing and debugging
''
'' chng: aug/2021 written [coderJeff]
''

#include once "fbdoc_defs.bi"
#include once "fbdoc_trace.bi"

'' application global to set/get trace flag
dim shared gtrace as boolean = false

namespace fb.fbdoc

	'':::::
	sub set_trace _
		( _
			byval value as boolean _
		)
		gtrace = value
	end sub

	'':::::
	function get_trace _
		( _
		) as boolean
		return gtrace
	end function

end namespace
 
