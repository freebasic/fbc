'' FreeBASIC binding for json-c-0.12-20140410
''
'' based on the C header files:
''   $Id: json_tokener.h,v 1.10 2006/07/25 03:24:50 mclark Exp $
''
''   Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
''   Michael Clark <michael@metaparadigm.com>
''
''   This library is free software; you can redistribute it and/or modify
''   it under the terms of the MIT license. See COPYING for details.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stddef.bi"
#include once "json_object.bi"

extern "C"

#define _json_tokener_h_

type json_tokener_error as long
enum
	json_tokener_success
	json_tokener_continue
	json_tokener_error_depth
	json_tokener_error_parse_eof
	json_tokener_error_parse_unexpected
	json_tokener_error_parse_null
	json_tokener_error_parse_boolean
	json_tokener_error_parse_number
	json_tokener_error_parse_array
	json_tokener_error_parse_object_key_name
	json_tokener_error_parse_object_key_sep
	json_tokener_error_parse_object_value_sep
	json_tokener_error_parse_string
	json_tokener_error_parse_comment
	json_tokener_error_size
end enum

type json_tokener_state as long
enum
	json_tokener_state_eatws
	json_tokener_state_start
	json_tokener_state_finish
	json_tokener_state_null
	json_tokener_state_comment_start
	json_tokener_state_comment
	json_tokener_state_comment_eol
	json_tokener_state_comment_end
	json_tokener_state_string
	json_tokener_state_string_escape
	json_tokener_state_escape_unicode
	json_tokener_state_boolean
	json_tokener_state_number
	json_tokener_state_array
	json_tokener_state_array_add
	json_tokener_state_array_sep
	json_tokener_state_object_field_start
	json_tokener_state_object_field
	json_tokener_state_object_field_end
	json_tokener_state_object_value
	json_tokener_state_object_value_add
	json_tokener_state_object_sep
	json_tokener_state_array_after_sep
	json_tokener_state_object_field_start_after_sep
	json_tokener_state_inf
end enum

type json_tokener_srec
	state as json_tokener_state
	saved_state as json_tokener_state
	obj as json_object ptr
	current as json_object ptr
	obj_field_name as zstring ptr
end type

const JSON_TOKENER_DEFAULT_DEPTH = 32

type json_tokener
	str as zstring ptr
	pb as printbuf ptr
	max_depth as long
	depth as long
	is_double as long
	st_pos as long
	char_offset as long
	err as json_tokener_error
	ucs_char as ulong
	quote_char as byte
	stack as json_tokener_srec ptr
	flags as long
end type

const JSON_TOKENER_STRICT = &h01
declare function json_tokener_error_desc(byval jerr as json_tokener_error) as const zstring ptr
declare function json_tokener_get_error(byval tok as json_tokener ptr) as json_tokener_error
declare function json_tokener_new() as json_tokener ptr
declare function json_tokener_new_ex(byval depth as long) as json_tokener ptr
declare sub json_tokener_free(byval tok as json_tokener ptr)
declare sub json_tokener_reset(byval tok as json_tokener ptr)
declare function json_tokener_parse(byval str as const zstring ptr) as json_object ptr
declare function json_tokener_parse_verbose(byval str as const zstring ptr, byval error as json_tokener_error ptr) as json_object ptr
declare sub json_tokener_set_flags(byval tok as json_tokener ptr, byval flags as long)
declare function json_tokener_parse_ex(byval tok as json_tokener ptr, byval str as const zstring ptr, byval len as long) as json_object ptr

end extern
