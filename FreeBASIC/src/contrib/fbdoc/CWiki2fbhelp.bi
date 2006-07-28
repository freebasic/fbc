#ifndef __CWiki2fbhelp_BI__
#define __CWiki2fbhelp_BI__

''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006 Jeffery R. Marshall (coder[at]execulink.com) and
''  the FreeBASIC development team.
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
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


#include once "common.bi"
#include once "CPage.bi"
#include once "CPagelist.bi"

type CWiki2fbhelp as CWiki2fbhelp_

declare function CWiki2fbhelp_New _
	( _
		byval urlbase as zstring ptr, _
		byval indentbase as integer, _
		byval outputdir as zstring ptr, _
		byval paglist as CPageList ptr, _
		byval toclist as CPageList ptr, _
		byval _this as CWiki2fbhelp ptr = NULL _
	) as CWiki2fbhelp ptr

declare sub CWiki2fbhelp_Delete _
	( _
		byval _this as CWiki2fbhelp ptr, _
		byval isstatic as integer = FALSE _
	)

declare function CWiki2fbhelp_EmitPages _
	( _
		byval _this as CWiki2fbhelp ptr _
	) as integer

declare function CWiki2fbhelp_EmitDefPage _
	( _
		byval _this as CWiki2fbhelp ptr, _
		byval page as CPage ptr, _
		byval sbody as zstring ptr _
	) as integer

declare function CWiki2fbhelp_Emit( _
		byval _this as CWiki2fbhelp ptr _
) as integer

#endif
