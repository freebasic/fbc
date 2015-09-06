'' FreeBASIC binding for json-c-0.12-20140410
''
'' based on the C header files:
''   $Id: arraylist.h,v 1.4 2006/01/26 02:16:28 mclark Exp $
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

extern "C"

#define _arraylist_h_
const ARRAY_LIST_DEFAULT_SIZE = 32

type array_list_
	array as any ptr ptr
	length as long
	size as long
	free_fn as sub(byval data as any ptr)
end type

declare function array_list_new(byval free_fn as sub(byval data as any ptr)) as array_list ptr
declare sub array_list_free(byval al as array_list ptr)
declare function array_list_get_idx(byval al as array_list ptr, byval i as long) as any ptr
declare function array_list_put_idx(byval al as array_list ptr, byval i as long, byval data as any ptr) as long
declare function array_list_add(byval al as array_list ptr, byval data as any ptr) as long
declare function array_list_length(byval al as array_list ptr) as long
declare sub array_list_sort(byval arr as array_list ptr, byval compar as function(byval as const any ptr, byval as const any ptr) as long)

end extern
