#ifndef __LIST_BI__
#define __LIST_BI__

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

#ifndef FALSE
const FALSE = 0
const TRUE  = -1
#endif


type TLISTNODE
	prev	as TLISTNODE ptr
	next	as TLISTNODE ptr
end type

type TLISTTB
	next	as TLISTTB ptr
	nodetb	as any ptr
	nodes	as integer
end type

type TLIST
	tbhead	as TLISTTB ptr
	tbtail	as TLISTTB ptr
	nodes 	as integer
	nodelen	as integer
	fhead	as TLISTNODE ptr					'' free list
	head	as any ptr							'' used list
	tail	as any ptr							'' /
	clear	as integer							'' clear nodes?
end type

declare function listNew		( byval list as TLIST ptr, _
								  byval nodes as integer, _
								  byval nodelen as integer, _
								  byval doclear as integer = TRUE, _
								  byval relink as integer = TRUE ) as integer

declare function listFree		( byval list as TLIST ptr ) as integer

declare function listNewNode	( byval list as TLIST ptr ) as any ptr

declare sub 	 listDelNode	( byval list as TLIST ptr, _
								  byval node as any ptr )

declare function listAllocTB	( byval list as TLIST ptr, _
					  			  byval nodes as integer, _
					  			  byval relink as integer = TRUE ) as integer

declare function listGetHead	( byval list as TLIST ptr ) as any ptr

declare function listGetTail	( byval list as TLIST ptr ) as any ptr

declare function listGetPrev	( byval node as any ptr ) as any ptr

declare function listGetNext	( byval node as any ptr ) as any ptr

#endif '' __LIST_BI__
