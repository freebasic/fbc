/'
 * $Id: json_util.h,v 1.4 2006/01/30 23:07:57 mclark Exp $
 *
 * Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
 * Michael Clark <michael@metaparadigm.com>
 *
 * This library is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See COPYING for details.
 *
 '/
 
#ifndef __json_util_bi__
#define __json_util_bi__

#define JSON_FILE_BUF_SIZE 4096

Extern "C"

declare function json_object_from_file (byval filename as zstring ptr) as json_object ptr
declare function json_object_to_file (byval filename as zstring ptr, byval obj as json_object ptr) as integer

End Extern

#endif
