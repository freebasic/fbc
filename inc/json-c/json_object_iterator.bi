'' FreeBASIC binding for json-c-0.12-20140410
''
'' based on the C header files:
''
''   ******************************************************************************
''    @file json_object_iterator.h
''
''    Copyright (c) 2009-2012 Hewlett-Packard Development Company, L.P.
''
''    This library is free software; you can redistribute it and/or modify
''    it under the terms of the MIT license. See COPYING for details.
''
''    @brief  json-c forces clients to use its private data
''            structures for JSON Object iteration.  This API
''            corrects that by abstracting the private json-c
''            details.
''
''    API attributes: <br>
''      * Thread-safe: NO<br>
''      * Reentrant: NO
''
''   ******************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stddef.bi"

extern "C"

#define JSON_OBJECT_ITERATOR_H

type json_object_iterator
	opaque_ as const any ptr
end type

declare function json_object_iter_init_default() as json_object_iterator
declare function json_object_iter_begin(byval obj as json_object ptr) as json_object_iterator
declare function json_object_iter_end(byval obj as const json_object ptr) as json_object_iterator
declare sub json_object_iter_next(byval iter as json_object_iterator ptr)
declare function json_object_iter_peek_name(byval iter as const json_object_iterator ptr) as const zstring ptr
declare function json_object_iter_peek_value(byval iter as const json_object_iterator ptr) as json_object ptr
declare function json_object_iter_equal(byval iter1 as const json_object_iterator ptr, byval iter2 as const json_object_iterator ptr) as json_bool

end extern
