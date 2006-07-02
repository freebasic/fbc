#ifndef __CPAGE_BI__
#define __CPAGE_BI__

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
#include once "list.bi"

type CPage as CPage_

type PageLinkItem
	as any ptr				ll_prev
	as any ptr				ll_next

	text as string
	url as string
	level as integer
end type

declare function CPage_New _
	( _
		byval pagename as zstring ptr, _
		byval pagetitle as zstring ptr = NULL, _
		byval linktitle as zstring ptr = NULL, _
		byval level as integer = 0, _
		byval _this as CPage ptr = NULL _
	) as CPage ptr

declare sub CPage_Delete _
	( _
		byval _this as CPage ptr, _
		byval isstatic as integer = FALSE _
	)

declare function CPage_GetName _
	( _
		byval _this as CPage ptr _
	) as string

declare function CPage_GetPageTitle _
	( _
		byval _this as CPage ptr _
	) as string

declare sub CPage_SetPageTitle _
	( _
		byval _this as CPage ptr, _
		byval title as zstring ptr _
	)

declare function CPage_GetLinkTitle _
	( _
		byval _this as CPage ptr _
	) as string

declare sub CPage_SetLinkTitle _
	( _
		byval _this as CPage ptr, _
		byval title as zstring ptr _
	)

declare function CPage_GetTitle _
	( _
		byval _this as CPage ptr _
	) as string

declare function CPage_GetFormattedTitle _
	( _
		byval _this as CPage ptr _
	) as string

declare function CPage_GetLevel _
	( _
		byval _this as CPage ptr _
	) as integer

declare function CPage_GetEmitted _
	( _
		byval _this as CPage ptr _
	) as integer

declare sub CPage_SetEmitted _
	( _
		byval _this as CPage ptr, _
		byval emitted as integer _
	)

declare function CPage_GetScanned _
	( _
		byval _this as CPage ptr _
	) as integer

declare sub CPage_SetScanned _
	( _
		byval _this as CPage ptr, _
		byval scanned as integer _
	)

declare sub CPage_AddPageLink _
	( _
		byval _this as CPage ptr, _
		byval spagetext as zstring ptr, _
		byval spagename as zstring ptr = NULL, _
		byval level as integer = 0 _
	)

declare sub CPage_FreePageLinks _
	( _
		byval _this as CPage ptr _
	)

declare function CPage_GetPageLinks _
 	( _
		byval _this as CPage ptr _
	) as TLIST ptr

#endif