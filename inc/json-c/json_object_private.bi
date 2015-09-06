'' FreeBASIC binding for json-c-0.12-20140410
''
'' based on the C header files:
''   $Id: json_object_private.h,v 1.4 2006/01/26 02:16:28 mclark Exp $
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

'' The following symbols have been renamed:
''     union data => json_object_data

extern "C"

#define _json_object_private_h_

type json_object_data_c_string
	str as zstring ptr
	len as long
end type

union json_object_data
	c_boolean as json_bool
	c_double as double
	c_int64 as longint
	c_object as lh_table ptr
	c_array as array_list ptr
	c_string as json_object_data_c_string
end union

type json_object_
	o_type as json_type
	_delete as sub(byval o as json_object ptr)
	_to_json_string as function(byval jso as json_object ptr, byval pb as printbuf ptr, byval level as long, byval flags as long) as long
	_ref_count as long
	_pb as printbuf ptr
	o as json_object_data
	_user_delete as sub(byval jso as json_object ptr, byval userdata as any ptr)
	_userdata as any ptr
end type

end extern
