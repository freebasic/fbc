#ifndef __CWIKICON_BI__
#define __CWIKICON_BI__

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

type CWikiCon as CWikiCon_


declare function 	CWikiCon_New				( _
												  byval url as zstring ptr, _
												  byval _this as CWikiCon ptr = NULL _
												) as CWikiCon ptr

declare sub 		CWikiCon_Delete				( _
												  byval _this as CWikiCon ptr, _
											  	  byval isstatic as integer = FALSE _
											  	)

declare function 	CWikiCon_Login 				( _
												  byval _this as CWikiCon ptr, _
												  byval username as zstring ptr, _
												  byval password as zstring ptr _
												) as integer

declare function 	CWikiCon_LoadPage			( _
												  byval _this as CWikiCon ptr, _
												  byval page as zstring ptr, _
												  byval israw as integer, _
												  byval getid as integer = TRUE, _
												  byref body as string _
												) as integer

declare function CWikiCon_StorePage _
	( _
		byval _this as CWikiCon ptr, _
		byval body as zstring ptr, _
		byval note as zstring ptr _
	) as integer

declare function CWikiCon_StoreNewPage _
	( _
		byval _this as CWikiCon ptr, _
		byval body as zstring ptr, _
		byval pagename as zstring ptr _
	) as integer

declare function CWikiCon_GetPageID _
	( _
		byval _this as CWikiCon ptr _
	) as integer

#endif
