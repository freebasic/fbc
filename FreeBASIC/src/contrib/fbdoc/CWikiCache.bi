#ifndef __CWIKICACHE_BI__
#define __CWIKICACHE_BI__

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

type CWikiCache as CWikiCache_

enum CACHE_REFRESH_MODE
	CACHE_REFRESH_NONE
	CACHE_REFRESH_IFMISSING
	CACHE_REFRESH_ALL
end enum

declare function CWikiCache_New _
	( _
		byval localdir as zstring ptr, _
		byval bRefresh as integer = FALSE, _
		byval _this as CWikiCache ptr = NULL _
	) as CWikiCache ptr

declare sub CWikiCache_Delete _
	( _
		byval _this as CWikiCache ptr, _
		byval isstatic as integer = FALSE _
	)


declare function CWikiCache_LoadPage _
	( _
		byval _this as CWikiCache ptr, _
		byval sPage as zstring ptr, _
		sBody as string _
	) as integer

declare function CWikiCache_SavePage _
	( _
		byval _this as CWikiCache ptr, _
		byval sPage as zstring ptr, _
		byval sBody as zstring ptr _
	) as integer

declare function CWikiCache_GetRefreshMode _
	( _
		byval _this as CWikiCache ptr _
	) as integer

declare function CWikiCache_SetRefreshMode _
	( _
		byval _this as CWikiCache ptr, _
		byval RefreshMode as integer _
	) as integer

#endif