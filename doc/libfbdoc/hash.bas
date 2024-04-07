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


'' HASH - simple open addressed hash table.
''
'' chng: mar/2007 written [coderJeff]
''

#include once "hash.bi"

#define NULL 0
#define INVALID -1

namespace fb

	public sub HASH.clear( )
		dim i as integer
		for i = 0 to this.size - 1
			if( this.list[i].text ) then
				deallocate this.list[i].text
				this.list[i].text = NULL
				this.list[i].info = NULL
			end if
		next
		this.count = 0
	end sub

	public sub HASH.free( )
		this.clear()
		if this.list then
			deallocate( this.list )
		end if
		this.list = NULL
		this.size = 0
	end sub

	public sub HASH.alloc( byval size as integer )
		this.free()
		this.size = size
		this.list = callocate( size * sizeof( HASHNODE ))
	end sub

	public constructor HASH ()
		this.alloc( 16 )
	end constructor

	public constructor HASH ( byval size as integer )
		this.alloc( size )
	end constructor

	public destructor HASH ()
		this.free
	end destructor

	public sub HASH.realloc( byval size as integer )
		this.free()
		this.size = size
		this.list = callocate( size * sizeof( HASHNODE ))
	end sub

	public sub HASH.grow( byval factor as single )
		dim tmp as HASH, c as HASHNODE ptr

		tmp.alloc( this.size * factor )
		if( tmp.list ) then

			for i as integer = 0 to this.size - 1
				if( this.list[i].text ) then
					c = tmp.find( this.list[i].text )
					c->text = this.list[i].text
					c->info = this.list[i].info
					tmp.count += 1
				end if
			next

			deallocate this.list
			this.list = tmp.list
			this.size = tmp.size
			this.count = tmp.count

			tmp.count = 0
			tmp.size = 0
			tmp.list = NULL

		end if

	end sub

	public function HASH.gethash( byval s as zstring ptr ) as uinteger
		dim index as uinteger, i as integer

		'' This hash function was choosen because it appears to work
		'' acceptably with the names of the wiki pages when there
		'' is on average 50% or more empty entires.

		index = 0

		for i = 0 to len( *s )-1	
			index += s[i] + ( index shl 3 )
		next
		index shl= 1

		function = index
	end function

	public function HASH.find( byval s as zstring ptr ) as HASHNODE ptr
		dim index as integer, start as integer

		index = HASH.gethash( s ) mod this.size
		start = index

		while( this.list[index].text )

			if( *s = *this.list[index].text ) then
				exit while
			end if
			
			index += 1
			index mod= this.size

			if( index = start ) then
				return NULL
			end if

		wend

		function = @this.list[index]

	end function

	public function HASH.test( byval s as zstring ptr ) as integer
		dim ret as HASHNODE ptr
		function = FALSE
		ret = this.find( s )
		if( ret ) then
			if( ret->text ) then
				function = TRUE
			end if
		end if
	end function

	public function HASH.add( byval s as zstring ptr, byval info as any ptr ) as HASHNODE ptr
		dim c as HASHNODE ptr
		c = this.find( s )
		if( c ) then
			if( c->text = NULL ) then
				c->text = allocate( len(*s) + 1 )
				'' TODO : use memcpy or similiar
				for i as integer = 0 to len(*s)
					c->text[i] = s[i]
				next
				c->info = info
				this.count += 1
				if( this.count > (this.size shr 1) ) then
					this.grow(2)
					c = this.find( s )
				end if
			end if
			function = c
		else
			function = NULL
		end if
	end function

	function HASH.getinfo( byval s as zstring ptr ) as any ptr
		dim node as HASHNODE ptr
		function = 0
		node = this.find( s )
		if( node ) then
			function = node->info
		end if
	end function

	public sub HASH.dump()
		dim i as integer
		print "HASH.dump"
		print "  size = "; this.size
		print " count = "; this.count
		print
		for i = 0 to this.size - 1
			print str(i); " - ";
			if( this.list[i].text ) then
				print *this.list[i].text
			else
				print "(Null)"
			endif 
		next
		print
	end sub

end namespace
