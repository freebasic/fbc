#ifndef __FBHELP_FILE_BI__
#define __FBHELP_FILE_BI__

'
'  fbhelp - FreeBASIC help viewer
'  Copyright (C) 2006-2017 Jeffery R. Marshall (coder[at]execulink.com)
'
'
'License:
'
'	This program is free software; you can redistribute it and/or modify
'	it under the terms of the GNU General Public License as published by
'	the Free Software Foundation; either version 2 of the License, or
'	(at your option) any later version.
'
'	This program is distributed in the hope that it will be useful,
'	but WITHOUT ANY WARRANTY; without even the implied warranty of
'	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'	GNU General Public License for more details.
'
'	You should have received a copy of the GNU General Public License
'	along with this program; if not, write to the Free Software
'	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.
'


	#include once "common.bi"

	declare sub HelpFile_Close ( )

	declare function HelpFile_Open _
		( _
			byval filename as zstring ptr _
		) as integer

	declare function HelpFile_SeekPage( byval pagename as zstring ptr ) as integer

	declare function HelpFile_Read _
		( _
			byval buf as ubyte ptr, _
			byval size as integer _
		) as integer

	declare function HelpFile_SaveTopicAsText _
		( _
			byval pagename as zstring ptr, _
			byval filename as zstring ptr _
		) as integer

#endif