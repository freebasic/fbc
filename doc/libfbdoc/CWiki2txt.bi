#ifndef __CWIKI2TXT_BI__
#define __CWIKI2TXT_BI__

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
#include once "CPageList.bi"

namespace fb.fbdoc

	type CWiki2txtCtx as CWiki2txtCtx_

	type CWiki2txt

		declare constructor _
			( _
				byval urlbase as zstring ptr, _
				byval indentbase as integer, _
				byval outputdir as zstring ptr, _
				byval paglist as CPageList ptr, _
				byval toclist as CPageList ptr _
			)

		declare destructor _
			( _
			)

		declare function EmitPages _
			( _
			) as integer

		declare function EmitDefPage _
			( _
				byval page as CPage ptr, _
				byval sbody as zstring ptr _
			) as integer

		declare function Emit _
			( _
			) as integer

		declare function LoadAndEmitTOC _
			( _
				byval sPageName as zstring ptr, _
				byval sOutputFile as zstring ptr _
			) as integer

		ctx as CWiki2txtCtx ptr

	end type

end namespace

#endif
