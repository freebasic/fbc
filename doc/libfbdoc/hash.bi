#ifndef __HASH_BI__
#define __HASH_BI__

''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006-2022 The FreeBASIC development team.
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
''	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.


namespace fb

	type HASHNODE
		text as zstring ptr
		info as any ptr
	end type

	type HASH
		size as integer
		count as integer
		list as HASHNODE ptr

		declare constructor()
		declare constructor( byval size as integer )
		declare destructor()
		declare sub alloc( byval size as integer )
		declare sub realloc( byval size as integer )
		declare sub clear()
		declare sub free()
		declare static function gethash( byval s as zstring ptr ) as uinteger
		declare function find( byval s as zstring ptr ) as HASHNODE ptr
		declare function test( byval s as zstring ptr ) as integer
		declare function add( byval s as zstring ptr, byval info as any ptr = 0 ) as HASHNODE ptr
		declare sub grow( byval factor as single )
		declare function getinfo( byval s as zstring ptr ) as any ptr
		declare sub dump()

	end type


end namespace

#endif
