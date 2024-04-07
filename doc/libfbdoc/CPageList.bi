#ifndef __BI__
#define __BI__

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
#include once "CPage.bi"

namespace fb.fbdoc

	type CPageListCtx as CPageListCtx_

	type CPageList

		declare constructor _
			( _
			)

		declare destructor _
			( _
			)

		declare sub ClearList _
			( _
			)

		declare function Append _
			( _
				byval page as CPage ptr, _
				byval isref as integer = FALSE _
			) as CPage ptr

		declare function AddNewPage _
			( _
				byval pagename as zstring ptr, _
				byval title as zstring ptr, _
				byval level as integer = 0, _
				byval bForceAdd as integer = FALSE _
			) as CPage ptr

		declare function Find _
			( _
				byval pagename as zstring ptr _
			) as CPage ptr

		declare function NewEnum _
			( _
				byval _iter as any ptr ptr _
			) as CPage ptr

		declare function NextEnum _
			( _
				byval _iter as any ptr ptr _
			) as CPage ptr

		declare sub ResetEmitted _
			( _
			)

		declare sub ResetScanned _
			( _
			)

		declare sub Dump _
			( _
			)

		declare function Count _
			( _
			) as integer

		ctx as CPageListCtx ptr

	end type

end namespace

#endif
