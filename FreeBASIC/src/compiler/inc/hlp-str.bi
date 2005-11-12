#ifndef __HELP_STR_BI__
#define __HELP_STR_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


declare sub 		ZstrAssign 				( byval dst as zstring ptr ptr, _
				 							  byval src as zstring ptr )

declare sub 		ZstrAssignW 			( byval dst as zstring ptr ptr, _
				  							  byval src as wstring ptr )

declare sub 		ZstrConcatAssign 		( byval dst as zstring ptr ptr, _
					   						  byval src as zstring ptr )

declare sub 		ZstrConcatAssignW 		( byval dst as zstring ptr ptr, _
											  byval src as wstring ptr )

declare sub 		WstrAssign 				( byval dst as wstring ptr ptr, _
				 							  byval src as wstring ptr )

declare sub 		WstrAssignA 			( byval dst as wstring ptr ptr, _
				  							  byval src as zstring ptr )

declare sub 		WstrConcatAssign 		( byval dst as wstring ptr ptr, _
					   						  byval src as wstring ptr )

declare sub 		WstrConcatAssignW 		( byval dst as wstring ptr ptr, _
											  byval src as zstring ptr )


declare function 	hEscapeStr				( byval text as zstring ptr ) as zstring ptr

declare function 	hEscapeWstr				( byval text as wstring ptr ) as zstring ptr

declare function 	hUnescapeStr			( byval text as zstring ptr ) as zstring ptr

declare function 	hUnescapeWstr			( byval text as wstring ptr ) as wstring ptr

declare function 	hEscapeToChar			( byval text as zstring ptr ) as zstring ptr

declare function 	hEscapeToCharW			( byval text as wstring ptr ) as wstring ptr

declare function	hReplace				( byval text as zstring ptr, _
											  byval oldtext as zstring ptr, _
											  byval newtext as zstring ptr ) as string

declare function 	hReplaceW				( byval orgtext as wstring ptr, _
			 	    						  byval oldtext as wstring ptr, _
			  	    						  byval newtext as wstring ptr ) as wstring ptr

declare function 	hGetWstrNull			( ) as zstring ptr


'':::::
#define ZstrAllocate(chars) allocate( chars + 1 )

#define ZstrFree(p) deallocate( p )

#define WstrAllocate(chars) allocate( (chars + 1) * len( wstring ) )

#define WstrFree(p) deallocate( p )

'':::::
#define ZEROSTRDESC(s)	                                _
	cptr(integer ptr, @s)[0] = NULL 					:_
	cptr(integer ptr, @s)[1] = NULL						:_
	cptr(integer ptr, @s)[2] = NULL

#endif ''__HELP_STR_BI__
