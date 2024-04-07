#ifndef __FBDOC_LOADER_BI__
#define __FBDOC_LOADER_BI__

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

	declare function LoadPage _
		( _
			byval sPage as zstring ptr, _
			byval bNoReload as integer = FALSE, _
			byval bCacheFromWeb as integer = FALSE _
		) as string

	declare function SavePage _
		( _
			byval sPage as zstring ptr, _
			byval sBody as zstring ptr _
		) as integer

end namespace

#endif
