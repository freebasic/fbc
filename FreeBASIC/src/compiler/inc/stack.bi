#ifndef __STACK_BI__
#define __STACK_BI__

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

type TSTACKNODE
	prev	as TSTACKNODE ptr
	next	as TSTACKNODE ptr
end type

type TSTACKTB
	next	as TSTACKTB ptr
	nodetb	as TSTACKNODE ptr
	nodes	as integer
end type

type TSTACK
	tbhead	as TSTACKTB ptr
	tbtail	as TSTACKTB ptr
	nodes 	as integer
	nodelen	as integer
	tos		as TSTACKNODE ptr					'' top-of-stack
	clear	as integer							'' clear nodes?
end type

declare function stackNew _
	( _
		byval stk as TSTACK ptr, _
		byval nodes as integer, _
		byval nodelen as integer, _
		byval doclear as integer = TRUE _
	) as integer

declare function stackFree _
	( _
		byval stk as TSTACK ptr _
	) as integer

declare function stackPush _
	( _
		byval stk as TSTACK ptr _
	) as any ptr

declare sub stackPop _
	( _
		byval stk as TSTACK ptr _
	)

declare function stackGetTOS _
	( _
		byval stk as TSTACK ptr _
	) as any ptr

#endif '' _STACK_BI__
