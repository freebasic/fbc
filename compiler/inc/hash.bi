#ifndef HASH_BI
#define HASH_BI

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

Const HASH.INITENTRYNODES%	= 1000
Const HASH.INITITEMNODES%	= HASH.INITENTRYNODES*8

type HASHITEM
	prv			as HASHITEM ptr			'' linked-list nodes
	nxt			as HASHITEM ptr			'' /

	nameidx		as integer
	idx			as any ptr
	l			as HASHITEM ptr			'' left node
	r			as HASHITEM ptr			'' right node
end type

Type HASHLIST
	head		as HASHITEM ptr
	tail		as HASHITEM ptr
End Type

type THASH
	list		as HASHLIST ptr
	nodes		as integer
end type

declare sub 		hashInit	( )
declare sub 		hashNew		( hash as THASH, byval nodes as integer )
declare sub 		hashFree	( hash as THASH )
declare function 	hashLookup	( hash as THASH, symbol as string ) as any ptr
declare sub 		hashAdd		( hash as THASH, symbol as string, byval idx as any ptr, byval nameidx as integer )
declare sub 		hashDel		( hash as THASH, symbol as string )

declare sub 		hashDump	( hash as THASH )

#endif '' HASH_BI
