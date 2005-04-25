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

const HASH.INITENTRYNODES	= 1000
const HASH.INITITEMNODES	= HASH.INITENTRYNODES*8

type HASHITEM
	prv			as HASHITEM ptr			'' linked-list nodes
	nxt			as HASHITEM ptr			'' /

	name		as string				'' dynamic string
	idx			as any ptr
	l			as HASHITEM ptr			'' left node
	r			as HASHITEM ptr			'' right node
end type

type HASHLIST
	head		as HASHITEM ptr
	tail		as HASHITEM ptr
end type

type THASH
	list		as HASHLIST ptr
	nodes		as integer
end type

declare sub 		hashInit		( )

declare sub 		hashNew			( byval hash as THASH ptr, _
								  	  byval nodes as integer )

declare sub 		hashFree		( byval hash as THASH ptr )

declare function 	hashHash		( byval symbol as string ) as uinteger

declare function 	hashLookup		( byval hash as THASH ptr, _
									  byval symbol as string ) as any ptr

declare function 	hashLookupEx	( byval hash as THASH ptr, _
									  byval symbol as string, _
									  byval index as uinteger ) as any ptr

declare function	hashAdd			( byval hash as THASH ptr, _
									  byval symbol as string, _
									  byval idx as any ptr, _
									  index as uinteger ) as HASHITEM ptr

declare sub 		hashDel			( byval hash as THASH ptr, _
									  byval item as HASHITEM ptr, _
									  byval index as uinteger )

declare sub 		hashDump		( byval hash as THASH ptr )

#endif '' HASH_BI
