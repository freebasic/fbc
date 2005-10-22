#ifndef __FB_UNICODE_W32__
#define __FB_UNICODE_W32__

#include <wchar.h>
#include <wctype.h>

#define FB_WSTR_FROM_INT( buffer, num ) \
    _itow( num, buffer, 10 )

#define FB_WSTR_FROM_UINT( buffer, num ) \
    _ultow( (unsigned long) num, buffer, 10 )

#define FB_WSTR_FROM_UINT_OCT( buffer, num ) \
    _itow( num, buffer, 8 )

#define FB_WSTR_FROM_INT64( buffer, num ) \
    _i64tow( num, buffer, 10 )

#define FB_WSTR_FROM_UINT64( buffer, num ) \
    _ui64tow( num, buffer, 10 )

#define FB_WSTR_FROM_UINT64_OCT( buffer, num ) \
    _ui64tow( num, buffer, 8 )

#endif /* __FB_UNICODE_W32__ */
