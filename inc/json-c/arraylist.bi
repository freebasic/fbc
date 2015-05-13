/'
 * $Id: arraylist.h,v 1.4 2006/01/26 02:16:28 mclark Exp $
 *
 * Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
 * Michael Clark <michael@metaparadigm.com>
 *
 * This library is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See COPYING for details.
 *
 '/
 
#ifndef __arraylist_bi__
#define __arraylist_bi__

#define ARRAY_LIST_DEFAULT_SIZE 32

Extern "C"

type array_list_free_fn as Sub Cdecl( ByVal As Any Ptr )

type array_list
	array as any ptr ptr
	length as integer
	size as integer
	free_fn as array_list_free_fn
end type

declare function array_list_new (byval free_fn as array_list_free_fn) as array_list ptr
declare sub array_list_free (byval al as array_list ptr)
declare function array_list_get_idx (byval al as array_list ptr, byval i as integer) as any ptr
declare function array_list_put_idx (byval al as array_list ptr, byval i as integer, byval data_ as any ptr) as integer
declare function array_list_add (byval al as array_list ptr, byval data as any ptr) as integer
declare function array_list_length (byval al as array_list ptr) as integer

End Extern

#endif
