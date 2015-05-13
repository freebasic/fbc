/'
 * $Id: bits.h,v 1.10 2006/01/30 23:07:57 mclark Exp $
 *
 * Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
 * Michael Clark <michael@metaparadigm.com>
 *
 * This library is free software; you can redistribute it and/or modify
 * it under the terms of the MIT license. See COPYING for details.
 *
 '/
#ifndef __bits_bi__
#define __bits_bi__

#ifndef json_min
#define json_min(a,b) (IIf((a) < (b), (a), (b)))
#endif

#ifndef json_max
#define json_max(a,b) (IIf((a) > (b), (a), (b)))
#endif

#define hexdigit(x) (IIf(((x) <= Asc("9")),(x) - Asc("0"), ((x) and 7) + 9))
#define error_ptr(error_) (Cast( Any Ptr, error_ ))
#define is_error(ptr_) (Cast(UInteger,ptr_) > Cast(UInteger,-4000L))

#endif
