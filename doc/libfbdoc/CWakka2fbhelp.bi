#ifndef __CWAKKA2FBHELP_BI__
#define __CWAKKA2FBHELP_BI__

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
#include once "CWiki.bi"
#include once "CPage.bi"
#include once "CPageList.bi"

namespace fb.fbdoc

	type CWakka2fbhelpCtx as CWakka2fbhelpCtx_

	type CWakka2fbhelp

		declare constructor _
			( _
			)

		declare destructor _
			( _
			)

		declare sub setIndentBase _
			( _
				byval value as integer _
			)

		declare sub setTagDoGen _
			( _
				byval token_id as integer, _
				byval value as integer _
			)

		declare sub setIsflat _
			( _
				byval value as integer _
			)

		declare function gen _
			( _
				byval page as zstring ptr, _
				byval wiki as CWiki ptr _
			) as string

		ctx as CWakka2fbhelpCtx ptr

	end type

end namespace

#endif
