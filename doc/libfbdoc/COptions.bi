#ifndef __COPTIONS_BI__
#define __COPTIONS_BI__

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


namespace fb.fbdoc

	type COption
		sKey as zstring ptr
		sValue as zstring ptr
	end type

	type COptionsCtx as COptionsCtx_

	type COptions

		declare constructor _
			( _
				byval sFileName as zstring ptr = NULL _
			)

		declare destructor _
			( _
			)

		declare sub Clear _
			( _
			)

		declare function ReadFromFile _
			( _
				byval sFileName as zstring ptr _
			) as integer

		declare function Set _
			( _
				byval sKey as zstring ptr, _
				byval sValue as zstring ptr _
			) as COption ptr

		declare function Get _
			( _
				byval sKey as zstring ptr, _
				byval sDefault as zstring ptr = NULL _
			) as string

		declare function NextEnum _
			( _
				byval _iter as any ptr ptr _
			) as COption ptr

		declare function NewEnum _
			( _
				byval _iter as any ptr ptr _
			) as COption ptr

		declare function Find _
			( _
				byval sKey as zstring ptr _
			) as COption ptr

		declare function ExpandString _
			( _
				byval sText as zstring ptr _
			) as string

		ctx as COptionsCtx ptr

	end type

end namespace

#endif