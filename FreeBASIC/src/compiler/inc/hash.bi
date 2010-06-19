#ifndef __HASH_BI__
#define __HASH_BI__

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

const HASH_INITENTRYNODES	= 1000
const HASH_INITITEMNODES	= HASH_INITENTRYNODES*8

type HASHITEM
	name		as zstring ptr			'' shared
	data		as any ptr				'' user data
	prev		as HASHITEM ptr
	next		as HASHITEM ptr
end type

type HASHLIST
	head		as HASHITEM ptr
	tail		as HASHITEM ptr
end type

type THASH
	list		as HASHLIST ptr
	nodes		as integer
	delstr		as integer
end type

declare sub hashInit _
	( _
		byval initnodes as integer = HASH_INITITEMNODES _
	)

declare sub hashEnd	 _
	( _
	)

declare sub hashNew _
	( _
		byval hash as THASH ptr, _
		byval nodes as integer, _
		byval delstr as integer = FALSE _
	)

declare sub hashFree _
	( _
		byval hash as THASH ptr _
	)

declare function hashHash _
	( _
		byval symbol as zstring ptr _
	) as uinteger

declare function hashLookup _
	( _
		byval hash as THASH ptr, _
		byval symbol as zstring ptr _
	) as any ptr

declare function hashLookupEx _
	( _
		byval hash as THASH ptr, _
		byval symbol as zstring ptr, _
		byval index as uinteger _
	) as any ptr

declare function hashAdd _
	( _
		byval hash as THASH ptr, _
		byval symbol as zstring ptr, _
		byval userdata as any ptr, _
		byval index as uinteger _
	) as HASHITEM ptr

declare sub hashDel _
	( _
		byval hash as THASH ptr, _
		byval item as HASHITEM ptr, _
		byval index as uinteger _
	)

#endif '' __HASH_BI__
