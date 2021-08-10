#pragma once

#include once "crt/stddef.bi"

extern "C"

const _ICONV_H = 1
type iconv_t as any ptr
declare function iconv_open(byval __tocode as const zstring ptr, byval __fromcode as const zstring ptr) as iconv_t
declare function iconv(byval __cd as iconv_t, byval __inbuf as zstring ptr ptr, byval __inbytesleft as size_t ptr, byval __outbuf as zstring ptr ptr, byval __outbytesleft as size_t ptr) as size_t
declare function iconv_close(byval __cd as iconv_t) as long

end extern
