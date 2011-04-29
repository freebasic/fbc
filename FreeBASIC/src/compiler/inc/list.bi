#ifndef __LIST_BI__
#define __LIST_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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

enum LIST_FLAGS
	LIST_FLAGS_NONE				= &h00000000

	LIST_FLAGS_CLEARNODES		= &h00000001
	LIST_FLAGS_LINKFREENODES	= &h00000002
	LIST_FLAGS_LINKUSEDNODES	= &h00000004

	LIST_FLAGS_CLEAR			= LIST_FLAGS_CLEARNODES or LIST_FLAGS_LINKFREENODES or LIST_FLAGS_LINKUSEDNODES
	LIST_FLAGS_NOCLEAR			= LIST_FLAGS_LINKFREENODES or LIST_FLAGS_LINKUSEDNODES
	LIST_FLAGS_ALL 				= &hFFFFFFFF
end enum

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
	flags	as LIST_FLAGS
end type

declare function listNew _
	( _
		byval list as TLIST ptr, _
		byval nodes as integer, _
		byval nodelen as integer, _
		byval flags as LIST_FLAGS = LIST_FLAGS_ALL _
	) as integer

declare function listFree _
	( _
		byval list as TLIST ptr _
	) as integer

declare function listNewNode _
	( _
		byval list as TLIST ptr _
	) as any ptr

declare sub listDelNode _
	( _
		byval list as TLIST ptr, _
		byval node as any ptr _
	)

declare function listAllocTB _
	( _
		byval list as TLIST ptr, _
		byval nodes as integer _
	) as integer

declare function listGetHead _
	( _
		byval list as TLIST ptr _
	) as any ptr

declare function listGetTail _
	( _
		byval list as TLIST ptr _
	) as any ptr

declare function listGetPrev _
	( _
		byval node as any ptr _
	) as any ptr

declare function listGetNext _
	( _
		byval node as any ptr _
	) as any ptr

#endif '' __LIST_BI__
