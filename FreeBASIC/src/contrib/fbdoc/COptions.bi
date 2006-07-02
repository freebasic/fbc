#ifndef __COPTIONS_BI__
#define __COPTIONS_BI__

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


type COptions as COptions_

type COption
	sKey as zstring ptr
	sValue as zstring ptr
end type

declare function COptions_New _
	( _
		byval sFileName as zstring ptr = NULL, _
		byval _this as COptions ptr = NULL _
	) as COptions ptr

declare sub COptions_Delete _
	( _
		byval _this as COptions ptr, _
		byval isstatic as integer = FALSE _
	)

declare sub COptions_Clear _
	( _
		byval _this as COptions ptr _
	)

declare function COptions_ReadFromFile _
	( _
		byval _this as COptions ptr, _
		byval sFileName as zstring ptr _
	) as integer

declare function COptions_Set _
	( _
		byval _this as COptions ptr, _
		byval sKey as zstring ptr, _
		byval sValue as zstring ptr _
	) as COption ptr

declare function COptions_Get _
	( _
		byval _this as COptions ptr, _
		byval sKey as zstring ptr, _
		byval sDefault as zstring ptr = NULL _
	) as string

declare function COptions_NextEnum _
	( _
		byval _iter as any ptr ptr _
	) as COption ptr

declare function COptions_NewEnum _
	( _
		byval _this as COptions ptr, _
		byval _iter as any ptr ptr _
	) as COption ptr

declare function COptions_Find _
	( _
		byval _this as COptions ptr, _
		byval sKey as zstring ptr _
	) as COption ptr

declare function COptions_ExpandString _
	( _
		byval _this as COptions ptr, _
		byval sText as zstring ptr _
	) as string

#endif