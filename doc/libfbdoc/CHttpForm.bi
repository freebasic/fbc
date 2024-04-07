#ifndef __CHTTPFORM_BI__
#define __CHTTPFORM_BI__

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

	type CHttpFormCtx as CHttpFormCtx_

	type CHttpForm

		declare constructor _
			( _
			)

		declare destructor _
			( _
			)

		declare function Add _
			( _
				byval name_ as zstring ptr, _
				byval value as zstring ptr, _
				byval _type as zstring ptr = NULL _
			) as integer

		declare function Add _
			( _
				byval name_ as zstring ptr, _
				byval value as integer _
			) as integer

		declare function GetHandle _
 			( _
			) as any ptr

		ctx as CHttpFormCtx ptr

	end type

end namespace

#endif