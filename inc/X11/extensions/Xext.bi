'' FreeBASIC binding for libXext-1.3.3

#pragma once

#include once "X11/Xfuncproto.bi"

extern "C"

#define _XEXT_H_
type XextErrorHandler as function(byval as Display ptr, byval as const zstring ptr, byval as const zstring ptr) as long
declare function XSetExtensionErrorHandler(byval as XextErrorHandler) as XextErrorHandler
declare function XMissingExtension(byval as Display ptr, byval as const zstring ptr) as long
#define X_EXTENSION_UNKNOWN "unknown"
#define X_EXTENSION_MISSING "missing"

end extern
