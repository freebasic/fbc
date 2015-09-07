'' FreeBASIC binding for json-c-0.12-20140410
''
'' based on the C header files:
''   $Id: bits.h,v 1.10 2006/01/30 23:07:57 mclark Exp $
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

#define _bits_h_
#define json_min(a, b) iif((a) < (b), (a), (b))
#define json_max(a, b) iif((a) > (b), (a), (b))
#define hexdigit(x) iif((x) <= asc("9"), (x) - asc("0"), ((x) and 7) + 9)
#define error_ptr(error) cptr(any ptr, error)
#define error_description(error) json_tokener_errors[error]
#define is_error(ptr) (ptr = NULL)
