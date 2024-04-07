#ifndef __FBDOC_CACHE_BI__
#define __FBDOC_CACHE_BI__

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


#include once "CWikiCache.bi"

namespace fb.fbdoc

	declare function LocalCache_Create _
		( _
			byval sLocalDir as zstring ptr, _
			byval bRefresh as integer _
		) as integer

	declare sub LocalCache_Destroy( )

	declare function LocalCache_Get( ) as CWikiCache ptr

end namespace

#endif
