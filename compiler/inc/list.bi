#ifndef LIST_BI
#define LIST_BI

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

type TLISTNODE
	prv		as TLISTNODE ptr
	nxt		as TLISTNODE ptr
	'' ...
end type

type TLISTTB
	nxt		as TLISTTB ptr
	ptr		as any ptr
end type

type TLIST
	nodes 	as integer
	tblist	as TLISTTB ptr
	nodelen	as integer
	fhead	as TLISTNODE ptr
	head	as TLISTNODE ptr
	tail	as TLISTNODE ptr
end type

declare function listNew		( byval list as TLIST ptr, byval nodes as integer, byval nodelen as integer ) as integer
declare function listFree		( byval list as TLIST ptr ) as integer

declare function listNewNode	( byval list as TLIST ptr ) as TLISTNODE ptr
declare function listDelNode	( byval list as TLIST ptr, byval node as TLISTNODE ptr ) as integer

#endif '' LIST_BI
