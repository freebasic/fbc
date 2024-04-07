#ifndef __FBDOC_FIND_KEYWORDS_BI__
#define __FBDOC_FIND_KEYWORDS_BI__

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

	declare function fbdoc_FindKeyword _
		( _
			byval text as zstring ptr _
		) as string

	declare function fbdoc_loadkeywords _
		( _
			byval sFilename as zstring ptr _
		) as integer

	declare function FormatPageTitle _
		( _
			byref a as string _
		) as string

end namespace

#endif
