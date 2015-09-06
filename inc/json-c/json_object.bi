'' FreeBASIC binding for json-c-0.12-20140410
''
'' based on the C header files:
''   $Id: json_object.h,v 1.12 2006/01/30 23:07:57 mclark Exp $
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

'' The following symbols have been renamed:
''     constant TRUE => CTRUE

extern "C"

#define _json_object_h_
const JSON_OBJECT_DEF_HASH_ENTRIES = 16
const JSON_C_TO_STRING_PLAIN = 0
const JSON_C_TO_STRING_SPACED = 1 shl 0
const JSON_C_TO_STRING_PRETTY = 1 shl 1
const JSON_C_TO_STRING_NOZERO = 1 shl 2
#ifndef FALSE
	const FALSE = 0
#endif
#ifndef CTRUE
	const CTRUE = 1
#endif
extern json_number_chars as const zstring ptr
extern json_hex_chars as const zstring ptr
type json_object as json_object_
type lh_entry as lh_entry_

type json_object_iter
	key as zstring ptr
	val as json_object ptr
	entry as lh_entry ptr
end type

type json_bool as long

type json_type as long
enum
	json_type_null
	json_type_boolean
	json_type_double
	json_type_int
	json_type_object
	json_type_array
	json_type_string
end enum

declare function json_object_get(byval obj as json_object ptr) as json_object ptr
declare function json_object_put(byval obj as json_object ptr) as long
declare function json_object_is_type(byval obj as json_object ptr, byval type as json_type) as long
declare function json_object_get_type(byval obj as json_object ptr) as json_type
declare function json_object_to_json_string(byval obj as json_object ptr) as const zstring ptr
declare function json_object_to_json_string_ext(byval obj as json_object ptr, byval flags as long) as const zstring ptr
type printbuf as printbuf_
declare sub json_object_set_serializer(byval jso as json_object ptr, byval to_string_func as function(byval jso as json_object ptr, byval pb as printbuf ptr, byval level as long, byval flags as long) as long, byval userdata as any ptr, byval user_delete as sub(byval jso as json_object ptr, byval userdata as any ptr))
declare sub json_object_free_userdata(byval jso as json_object ptr, byval userdata as any ptr)
declare function json_object_userdata_to_json_string(byval jso as json_object ptr, byval pb as printbuf ptr, byval level as long, byval flags as long) as long
declare function json_object_new_object() as json_object ptr
type lh_table as lh_table_
declare function json_object_get_object(byval obj as json_object ptr) as lh_table ptr
declare function json_object_object_length(byval obj as json_object ptr) as long
declare sub json_object_object_add(byval obj as json_object ptr, byval key as const zstring ptr, byval val as json_object ptr)
declare function json_object_object_get(byval obj as json_object ptr, byval key as const zstring ptr) as json_object ptr
declare function json_object_object_get_ex(byval obj as json_object ptr, byval key as const zstring ptr, byval value as json_object ptr ptr) as json_bool
declare sub json_object_object_del(byval obj as json_object ptr, byval key as const zstring ptr)
declare function json_object_new_array() as json_object ptr
type array_list as array_list_
declare function json_object_get_array(byval obj as json_object ptr) as array_list ptr
declare function json_object_array_length(byval obj as json_object ptr) as long
declare sub json_object_array_sort(byval jso as json_object ptr, byval sort_fn as function(byval as const any ptr, byval as const any ptr) as long)
declare function json_object_array_add(byval obj as json_object ptr, byval val as json_object ptr) as long
declare function json_object_array_put_idx(byval obj as json_object ptr, byval idx as long, byval val as json_object ptr) as long
declare function json_object_array_get_idx(byval obj as json_object ptr, byval idx as long) as json_object ptr
declare function json_object_new_boolean(byval b as json_bool) as json_object ptr
declare function json_object_get_boolean(byval obj as json_object ptr) as json_bool
declare function json_object_new_int(byval i as long) as json_object ptr
declare function json_object_new_int64(byval i as longint) as json_object ptr
declare function json_object_get_int(byval obj as json_object ptr) as long
declare function json_object_get_int64(byval obj as json_object ptr) as longint
declare function json_object_new_double(byval d as double) as json_object ptr
declare function json_object_new_double_s(byval d as double, byval ds as const zstring ptr) as json_object ptr
declare function json_object_get_double(byval obj as json_object ptr) as double
declare function json_object_new_string(byval s as const zstring ptr) as json_object ptr
declare function json_object_new_string_len(byval s as const zstring ptr, byval len as long) as json_object ptr
declare function json_object_get_string(byval obj as json_object ptr) as const zstring ptr
declare function json_object_get_string_len(byval obj as json_object ptr) as long

end extern
