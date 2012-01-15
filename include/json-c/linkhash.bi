/'
 * $Id: linkhash.h,v 1.6 2006/01/30 23:07:57 mclark Exp $
 *
 * Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
 * Michael Clark <michael@metaparadigm.com>
 *
 * This library is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See COPYING for details.
 *
 '/
 
#ifndef __linkhash_bi__
#define __linkhash_bi__

#define LH_PRIME &h9e370001UL

Extern "C"
type lh_entry_free_fn as Sub( ByVal As lh_entry Ptr )
type lh_hash_fn as Function( ByVal As Any Ptr ) As UInteger
type lh_equal_fn as Function( ByVal lhs As Any Ptr, ByVal rhs As Any Ptr ) As Integer

type lh_entry
	k as any ptr
	v as any ptr
	next as lh_entry ptr
	prev as lh_entry ptr
end type

type lh_table
	size as integer
	count as integer
	collisions as integer
	resizes as integer
	lookups as integer
	inserts as integer
	deletes as integer
	name as zstring ptr
	head as lh_entry ptr
	tail as lh_entry ptr
	table as lh_entry ptr
	free_fn as lh_entry_free_fn
	hash_fn as lh_hash_fn
	equal_fn as lh_equal_fn
end type

declare function lh_ptr_hash (byval k as any ptr) as uinteger
declare function lh_ptr_equal (byval k1 as any ptr, byval k2 as any ptr) as integer
declare function lh_char_hash (byval k as any ptr) as uinteger
declare function lh_char_equal (byval k1 as any ptr, byval k2 as any ptr) as integer
declare function lh_table_new (byval size as integer, byval name_ as zstring ptr, byval free_fn as lh_entry_free_fn, byval hash_fn as lh_hash_fn, byval equal_fn as lh_equal_fn) as lh_table ptr
declare function lh_kchar_table_new (byval size as integer, byval name_ as zstring ptr, byval free_fn as lh_entry_free_fn) as lh_table ptr
declare function lh_kptr_table_new (byval size as integer, byval name_ as zstring ptr, byval free_fn as lh_entry_free_fn) as lh_table ptr
declare sub lh_table_free (byval t as lh_table ptr)
declare function lh_table_insert (byval t as lh_table ptr, byval k as any ptr, byval v as any ptr) as integer
declare function lh_table_lookup_entry (byval t as lh_table ptr, byval k as any ptr) as lh_entry ptr
declare function lh_table_lookup (byval t as lh_table ptr, byval k as any ptr) as any ptr
declare function lh_table_delete_entry (byval t as lh_table ptr, byval e as lh_entry ptr) as integer
declare function lh_table_delete (byval t as lh_table ptr, byval k as any ptr) as integer
declare sub lh_abort (byval msg as zstring ptr, ...)
declare sub lh_table_resize (byval t as lh_table ptr, byval new_size as integer)

End Extern

#endif
