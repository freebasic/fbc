'' FreeBASIC binding for json-c-0.12-20140410
''
'' based on the C header files:
''   $Id: json_util.h,v 1.4 2006/01/30 23:07:57 mclark Exp $
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

#include once "json_object.bi"

extern "C"

#define _json_util_h_
const JSON_FILE_BUF_SIZE = 4096
declare function json_object_from_file(byval filename as const zstring ptr) as json_object ptr
declare function json_object_to_file(byval filename as const zstring ptr, byval obj as json_object ptr) as long
declare function json_object_to_file_ext(byval filename as const zstring ptr, byval obj as json_object ptr, byval flags as long) as long
declare function json_parse_int64(byval buf as const zstring ptr, byval retval as longint ptr) as long
declare function json_parse_double(byval buf as const zstring ptr, byval retval as double ptr) as long
declare function json_type_to_name(byval o_type as json_type) as const zstring ptr

end extern
