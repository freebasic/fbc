/'
 * $Id: json_tokener.h,v 1.10 2006/07/25 03:24:50 mclark Exp $
 *
 * Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
 * Michael Clark <michael@metaparadigm.com>
 *
 * This library is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See COPYING for details.
 *
 '/
 
#ifndef __json_tokener_bi__
#define __json_tokener_bi__

enum json_tokener_error
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
end enum

enum json_tokener_state
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
end enum

type json_tokener_srec
	state as json_tokener_state
	saved_state as json_tokener_state
	obj as json_object ptr
	current as json_object ptr
	obj_field_name as zstring ptr
end type

#define JSON_TOKENER_MAX_DEPTH 32

type json_tokener
	str_ as zstring ptr
	pb as printbuf ptr
	depth as integer
	is_double as integer
	st_pos as integer
	char_offset as integer
	err_ as Any ptr
	ucs_char as uinteger
	quote_char as byte
	stack(0 to 32-1) as json_tokener_srec
end Type

Extern "C"

extern json_tokener_errors as Const ZString Ptr ptr

declare function json_tokener_new () as json_tokener ptr
declare sub json_tokener_free (byval tok as json_tokener ptr)
declare sub json_tokener_reset (byval tok as json_tokener ptr)
declare function json_tokener_parse (byval str_ as zstring ptr) as json_object ptr
declare function json_tokener_parse_ex (byval tok as json_tokener ptr, byval str_ as zstring ptr, byval _len as integer) as json_object ptr

End Extern

#endif
