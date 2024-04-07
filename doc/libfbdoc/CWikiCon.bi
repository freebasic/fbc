#ifndef __CWIKICON_BI__
#define __CWIKICON_BI__

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

	type CWikiCon extends object

		enum IndexFormat
			INDEX_FORMAT_LEGACY = 0 '' choose index format based on page name (old way)
			INDEX_FORMAT_INDEX = 1 '' plain text page names with revision numbers
			INDEX_FORMAT_LIST = 2  '' plain text page names
			INDEX_FORMAT_HTML = 3  '' extract from HTML (old way)
		end enum

		declare constructor()
		declare virtual destructor()

		declare virtual function LoadPage _
			( _
				byval pagename as zstring ptr, _
				byref body as string _
			) as boolean

		declare virtual function LoadIndex _
			( _
				byval pagename as zstring ptr, _
				byref body as string, _
				byval format as IndexFormat _
			) as boolean

		declare virtual function StorePage _
			( _
				byval body as zstring ptr, _
				byval note as zstring ptr _
			) as boolean

		declare virtual function StoreNewPage _
			( _
				byval body as zstring ptr, _
				byval pagename as zstring ptr _
			) as boolean

		declare virtual function GetPageID _
			( _
			) as integer

	end type

end namespace

#endif
