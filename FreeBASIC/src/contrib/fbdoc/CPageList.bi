#ifndef __CPAGELIST_BI__
#define __CPAGELIST_BI__

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

type CPageList as CPageList_

declare function CPageList_New _
	( _
		byval _this as CPageList ptr = NULL _
	) as CPageList ptr

declare sub CPageList_Delete _
	( _
		byval _this as CPageList ptr, _
		byval isstatic as integer = FALSE _
	)

declare function CPageList_Append _
	( _
		byval _this as CPageList ptr, _
		byval page as CPage ptr, _
		byval isref as integer = FALSE _
	) as CPage ptr

declare function CPageList_AddNewPage _
	( _
		byval _this as CPageList ptr, _
		byval pagename as zstring ptr, _
		byval pagetitle as zstring ptr, _
		byval linktitle as zstring ptr, _
		byval level as integer = 0, _
		byval bForceAdd as integer = FALSE _
	) as CPage ptr

declare function CPageList_Find _
	( _
		byval _this as CPageList ptr, _
		byval pagename as zstring ptr _
	) as CPage ptr

declare function CPageList_NewEnum _
	( _
		byval _this as CPageList ptr, _
		byval _iter as any ptr ptr _
	) as CPage ptr

declare function CPageList_NextEnum _
	( _
		byval _iter as any ptr ptr _
	) as CPage ptr

declare sub CPageList_ResetEmitted _
	( _
		byval _this as CPageList ptr _
	)

declare sub CPageList_ResetScanned _
	( _
		byval _this as CPageList ptr _
	)

declare sub CPageList_Dump _
	( _
		byval _this as CPageList ptr _
	)

declare function CPageList_Count _
	( _
		byval _this as CPageList ptr _
	) as integer

#endif
