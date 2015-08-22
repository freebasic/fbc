#ifndef __CWIKICON_BI__
#define __CWIKICON_BI__

''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006-2008 The FreeBASIC development team.
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

	type CWikiConCtx as CWikiConCtx_
		
	type CWikiCon

		declare constructor _
			( _
				byval url as zstring ptr = NULL _
			)

		declare destructor _
			( _
			)

		declare function Login _
			( _
				byval username as zstring ptr, _
				byval password as zstring ptr _
			) as integer


		declare function LoadPage _
			( _
				byval page as zstring ptr, _
				byval israw as integer, _
				byval getid as integer = TRUE, _
				byref body as string _
			) as integer

		declare function StorePage _
			( _
				byval body as zstring ptr, _
				byval note as zstring ptr _
			) as integer

		declare function StoreNewPage _
			( _
				byval body as zstring ptr, _
				byval pagename as zstring ptr _
			) as integer

		declare function GetPageID _
			( _
			) as integer

		ctx as CWikiConCtx ptr

	end type

end namespace

#endif
