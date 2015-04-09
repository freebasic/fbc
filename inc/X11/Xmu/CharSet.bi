'' FreeBASIC binding for libXmu-1.1.2

#pragma once

#include once "X11/Xfuncproto.bi"

extern "C"

#define _XMU_CHARSET_H_
declare sub XmuCopyISOLatin1Lowered(byval dst_return as zstring ptr, byval src as const zstring ptr)
declare sub XmuCopyISOLatin1Uppered(byval dst_return as zstring ptr, byval src as const zstring ptr)
declare function XmuCompareISOLatin1(byval first as const zstring ptr, byval second as const zstring ptr) as long
declare sub XmuNCopyISOLatin1Lowered(byval dst_return as zstring ptr, byval src as const zstring ptr, byval size as long)
declare sub XmuNCopyISOLatin1Uppered(byval dst_return as zstring ptr, byval src as const zstring ptr, byval size as long)

end extern
