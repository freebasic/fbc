#ifndef __CWIKICONSQL_BI__
#define __CWIKICONSQL_BI__

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
#include once "CWikiCon.bi"

namespace fb.fbdoc

	type CWikiConSqlCtx as CWikiConSqlCtx_

	type CWikiConSql extends CWikiCon

		declare static sub GlobalInit()
		declare static sub GlobalExit()

		declare constructor _
			( _
				byval db_host as zstring ptr, _
				byval db_user as zstring ptr, _
				byval db_pass as zstring ptr, _
				byval db_name as zstring ptr, _
				byval db_port as integer _			)
			)

		declare destructor _
			( _
			)

		declare function Connect _
			( _
			) as boolean

		declare sub Disconnect _
			( _
			)

		declare function LoadPage _
			( _
				byval page as zstring ptr, _
				byref body as string _
			) as boolean

		declare function LoadIndex _
			( _
				byval page as zstring ptr, _
				byref body as string, _
				byval format as CWikiCon.IndexFormat _
			) as boolean

		declare function StorePage _
			( _
				byval body as zstring ptr, _
				byval note as zstring ptr _
			) as boolean

		declare function StoreNewPage _
			( _
				byval body as zstring ptr, _
				byval pagename as zstring ptr _
			) as boolean

		declare function GetPageID _
			( _
			) as integer

		ctx as CWikiConSqlCtx ptr

	end type

end namespace

#endif
