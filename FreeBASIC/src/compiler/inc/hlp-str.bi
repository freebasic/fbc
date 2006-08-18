#ifndef __HELP_STR_BI__
#define __HELP_STR_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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



declare sub 		ZstrAssign 				( _
												byval dst as zstring ptr ptr, _
												byval src as zstring ptr _
											)

declare sub 		ZstrAssignW 			( _
												byval dst as zstring ptr ptr, _
												byval src as wstring ptr _
											)

declare sub 		ZstrConcatAssign 		( _
												byval dst as zstring ptr ptr, _
												byval src as zstring ptr _
											)

declare sub 		ZstrConcatAssignW 		( _
												byval dst as zstring ptr ptr, _
												byval src as wstring ptr _
											)

declare sub 		WstrAssign 				( _
												byval dst as wstring ptr ptr, _
												byval src as wstring ptr _
											)

declare sub 		WstrAssignA 			( _
												byval dst as wstring ptr ptr, _
												byval src as zstring ptr _
											)

declare sub 		WstrConcatAssign 		( _
												byval dst as wstring ptr ptr, _
												byval src as wstring ptr _
											)

declare sub 		WstrConcatAssignW 		( _
												byval dst as wstring ptr ptr, _
												byval src as zstring ptr _
											)


declare function 	hReEscape				( _
												byval text as zstring ptr, _
												byref textlen as integer, _
												byref isunicode as integer _
											) as zstring ptr

declare function 	hReEscapeW				( _
												byval text as wstring ptr, _
												byref textlen as integer _
											) as wstring ptr

declare function 	hEscape					( _
												byval text as zstring ptr _
											) as zstring ptr

declare function 	hEscapeW				( _
												byval text as wstring ptr _
											) as zstring ptr

declare function 	hUnescape				( _
												byval text as zstring ptr _
											) as zstring ptr

declare function 	hUnescapeW				( _
												byval text as wstring ptr _
											) as wstring ptr

declare function 	hHasEscape				( _
												byval text as zstring ptr _
											) as integer

declare function 	hHasEscapeW				( _
												byval text as wstring ptr _
											) as integer

declare function	hReplace				( _
												byval text as zstring ptr, _
												byval oldtext as zstring ptr, _
												byval newtext as zstring ptr _
											) as string

declare function 	hReplaceW				( _
												byval orgtext as wstring ptr, _
												byval oldtext as wstring ptr, _
												byval newtext as wstring ptr _
											) as wstring ptr

declare function 	hGetWstrNull			( _
											) as zstring ptr


'':::::
#define ZstrAllocate(chars) allocate( chars + 1 )

#define ZstrFree(p) if( p <> NULL ) then : deallocate( p ) : end if

#define WstrAllocate(chars) allocate( (chars + 1) * len( wstring ) )

#define WstrFree(p) if( p <> NULL ) then : deallocate( p ) : end if

#endif ''__HELP_STR_BI__
