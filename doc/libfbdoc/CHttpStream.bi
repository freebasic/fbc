#ifndef __CHTTPSTREAM_BI__
#define __CHTTPSTREAM_BI__

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


#ifndef NULL
#define NULL 0
#endif

namespace fb

	type CHttpStreamCtx as CHttpStreamCtx_

	type CHttpStream

		declare constructor  _
			( _
				byval http as CHttp ptr _
			)

		declare destructor _
			( _
			)
												  
		declare function Receive _
	 		( _
				byval url as zstring ptr, _
				byval doreset as integer = FALSE, _
				byval ca_file as zstring ptr = NULL _
			) as integer


		declare function Read _
			( _
			) as string

		declare function Send _
			( _
				byval url as zstring ptr, _
				byval data_ as any ptr, _
				byval bytes as integer, _
				byval doreset as integer = FALSE, _
				byval ca_file as zstring ptr = NULL _
			) as integer

		ctx as CHttpStreamCtx ptr
	
	end type

end namespace

#endif