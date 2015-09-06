'' FreeBASIC binding for json-c-0.12-20140410
''
'' based on the C header files:
''   $Id: linkhash.h,v 1.6 2006/01/30 23:07:57 mclark Exp $
''
''   Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
''   Michael Clark <michael@metaparadigm.com>
''   Copyright (c) 2009 Hewlett-Packard Development Company, L.P.
''
''   This library is free software; you can redistribute it and/or modify
''   it under the terms of the MIT license. See COPYING for details.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "json_object.bi"

extern "C"

#define _linkhash_h_
const LH_PRIME = cast(culong, &h9e370001)
const LH_LOAD_FACTOR = 0.66
const LH_EMPTY = cptr(any ptr, -1)
const LH_FREED = cptr(any ptr, -2)

type lh_entry_
	k as any ptr
	v as const any ptr
	next as lh_entry ptr
	prev as lh_entry ptr
end type

type lh_table_
	size as long
	count as long
	collisions as long
	resizes as long
	lookups as long
	inserts as long
	deletes as long
	name as const zstring ptr
	head as lh_entry ptr
	tail as lh_entry ptr
	table as lh_entry ptr
	free_fn as sub(byval e as lh_entry ptr)
	hash_fn as function(byval k as const any ptr) as culong
	equal_fn as function(byval k1 as const any ptr, byval k2 as const any ptr) as long
end type

declare function lh_ptr_hash(byval k as const any ptr) as culong
declare function lh_ptr_equal(byval k1 as const any ptr, byval k2 as const any ptr) as long
declare function lh_char_hash(byval k as const any ptr) as culong
declare function lh_char_equal(byval k1 as const any ptr, byval k2 as const any ptr) as long
declare function lh_table_new(byval size as long, byval name as const zstring ptr, byval free_fn as sub(byval e as lh_entry ptr), byval hash_fn as function(byval k as const any ptr) as culong, byval equal_fn as function(byval k1 as const any ptr, byval k2 as const any ptr) as long) as lh_table ptr
declare function lh_kchar_table_new(byval size as long, byval name as const zstring ptr, byval free_fn as sub(byval e as lh_entry ptr)) as lh_table ptr
declare function lh_kptr_table_new(byval size as long, byval name as const zstring ptr, byval free_fn as sub(byval e as lh_entry ptr)) as lh_table ptr
declare sub lh_table_free(byval t as lh_table ptr)
declare function lh_table_insert(byval t as lh_table ptr, byval k as any ptr, byval v as const any ptr) as long
declare function lh_table_lookup_entry(byval t as lh_table ptr, byval k as const any ptr) as lh_entry ptr
declare function lh_table_lookup(byval t as lh_table ptr, byval k as const any ptr) as const any ptr
declare function lh_table_lookup_ex(byval t as lh_table ptr, byval k as const any ptr, byval v as any ptr ptr) as json_bool
declare function lh_table_delete_entry(byval t as lh_table ptr, byval e as lh_entry ptr) as long
declare function lh_table_delete(byval t as lh_table ptr, byval k as const any ptr) as long
declare function lh_table_length(byval t as lh_table ptr) as long
declare sub lh_abort(byval msg as const zstring ptr, ...)
declare sub lh_table_resize(byval t as lh_table ptr, byval new_size as long)

end extern
