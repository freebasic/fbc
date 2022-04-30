#ifndef __FBDOC_LANG_BI__
#define __FBDOC_LANG_BI__

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


#include once "fbdoc_defs.bi"

namespace fb.fbdoc
	
	type Lang

		dummy as byte

		declare static function Initialized _
			( _
			) as integer

		declare static function LoadOptions _
			( _
				byval sFileName as zstring ptr, _
				byval bNoReset as integer = FALSE _
			) as integer

		declare static function GetOption _
			( _
				byval sKey as zstring ptr, _
				byval sDefault as zstring ptr = NULL _
			) as string

		declare static sub SetOption _
			( _
				byval sKey as zstring ptr, _
				byval sValue as zstring ptr _
			)

		declare static function ExpandString _
			( _
				byval sText as zstring  ptr _
			) as string

	end type

end namespace

#endif
