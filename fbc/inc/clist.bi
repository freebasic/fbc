#ifndef __CLIST_BI__
#define __CLIST_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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

#include once "inc\list.bi"

type TCLIST
	list	as TLIST
	head	as TLISTNODE ptr
	tail	as TLISTNODE ptr
end type

declare function clistNew _
	( _
		byval clist as TCLIST ptr, _
		byval nodes as integer, _
		byval nodelen as integer, _
		byval flags as LIST_FLAGS = LIST_FLAGS_ALL _
	) as integer

declare function clistFree _
	( _
		byval clist as TCLIST ptr _
	) as integer

declare function clistNextNode _
	( _
		byval clist as TCLIST ptr, _
		byval do_circ as integer = TRUE _
	) as any ptr

#endif '' __LIST_BI__
