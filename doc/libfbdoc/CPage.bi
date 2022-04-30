#ifndef __CPAGE_BI__
#define __CPAGE_BI__

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
#include once "list.bi"

namespace fb.fbdoc

	type CPageCtx as CPageCtx_

	type PageLinkItem
		text as string
		url as string
		level as integer
		linkclass as integer
	end type

	type CPage

		declare constructor _
			( _
				byval pagename as zstring ptr, _
				byval pagetitle as zstring ptr = NULL, _
				byval level as integer = 0 _
			)

		declare destructor _
			( _
			)

		declare function GetName _
			( _
			) as string

		declare function GetPageTitle _
			( _
			) as string

		declare sub SetPageTitle _
			( _
				byval title as zstring ptr _
			)

		declare function GetTitle _
			( _
			) as string

		declare function GetFormattedTitle _
			( _
			) as string

		declare function GetLevel _
			( _
			) as integer

		declare function GetEmitted _
			( _
			) as integer

		declare sub SetEmitted _
			( _
				byval emitted as integer _
			)

		declare function GetScanned _
			( _
			) as integer

		declare sub SetScanned _
			( _
				byval scanned as integer _
			)

		declare sub AddPageLink _
			( _
				byval spagetext as zstring ptr, _
				byval spagename as zstring ptr = NULL, _
				byval level as integer = 0, _
				byval linkclass as integer = 0 _
			)

		declare sub FreePageLinks _
			( _
			)

		declare function GetPageLinks _
 			( _
			) as CList ptr

		ctx as CPageCtx ptr

	end type

end namespace

#endif