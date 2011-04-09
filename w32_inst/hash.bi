#ifndef __HASH_BI__
#define __HASH_BI__

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
