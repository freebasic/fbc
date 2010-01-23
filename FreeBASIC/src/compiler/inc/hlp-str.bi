#ifndef __HELP_STR_BI__
#define __HELP_STR_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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


declare sub ZstrAssign _
	( _
		byval dst as zstring ptr ptr, _
		byval src as zstring ptr _
	)

declare sub ZstrAssignW _
	( _
		byval dst as zstring ptr ptr, _
		byval src as wstring ptr _
	)

declare sub ZstrConcatAssign _
	( _
		byval dst as zstring ptr ptr, _
		byval src as zstring ptr _
	)

declare sub ZstrConcatAssignW _
	( _
		byval dst as zstring ptr ptr, _
		byval src as wstring ptr _
	)

declare function ZstrDup _
	( _
		byval s as zstring ptr _
	) as zstring ptr

declare sub WstrAssign _
	( _
		byval dst as wstring ptr ptr, _
		byval src as wstring ptr _
	)

declare sub WstrAssignA _
	( _
		byval dst as wstring ptr ptr, _
		byval src as zstring ptr _
	)

declare sub WstrConcatAssign _
	( _
		byval dst as wstring ptr ptr, _
		byval src as wstring ptr _
	)

declare sub WstrConcatAssignW _
	( _
		byval dst as wstring ptr ptr, _
		byval src as zstring ptr _
	)

declare function WstrDup _
	( _
		byval s as wstring ptr _
	) as wstring ptr


declare function hReEscape _
	( _
		byval text as zstring ptr, _
		byref textlen as integer, _
		byref isunicode as integer _
	) as zstring ptr

declare function hReEscapeW _
	( _
		byval text as wstring ptr, _
		byref textlen as integer _
	) as wstring ptr

declare function hEscape _
	( _
		byval text as zstring ptr _
	) as zstring ptr

declare function hEscapeW _
	( _
		byval text as wstring ptr _
	) as zstring ptr

declare function hEscapeUCN _
	( _
		byval text as wstring ptr _
	) as zstring ptr

declare function hUnescape _
	( _
		byval text as zstring ptr _
	) as zstring ptr

declare function hUnescapeW _
	( _
		byval text as wstring ptr _
	) as wstring ptr

declare function hHasEscape _
	( _
		byval text as zstring ptr _
	) as integer

declare function hHasEscapeW _
	( _
		byval text as wstring ptr _
	) as integer

declare function hReplace _
	( _
		byval text as zstring ptr, _
		byval oldtext as zstring ptr, _
		byval newtext as zstring ptr _
	) as string

declare function hReplaceW _
	( _
		byval orgtext as wstring ptr, _
		byval oldtext as wstring ptr, _
		byval newtext as wstring ptr _
	) as wstring ptr

declare function hReplaceChar _
	( _
		byval orgtext as zstring ptr, _
		byval oldchar as integer, _
		byval newchar as integer _
	) as zstring ptr

declare function hGetWstrNull _
	( _
	) as zstring ptr


'':::::
#define ZstrAllocate(chars) allocate( chars + 1 )

#define ZstrFree(p) if( p <> NULL ) then : deallocate( p ) : end if

#define WstrAllocate(chars) allocate( (chars + 1) * len( wstring ) )

#define WstrFree(p) if( p <> NULL ) then : deallocate( p ) : end if

#endif ''__HELP_STR_BI__
