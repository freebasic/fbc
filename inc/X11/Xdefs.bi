'' FreeBASIC binding for xproto-7.0.27

#pragma once

#include once "crt/long.bi"

'' The following symbols have been renamed:
''     typedef pointer => pointer_

extern "C"

#define _XDEFS_H
#define _XTYPEDEF_POINTER
type pointer_ as any ptr
type ClientPtr as _Client ptr
#define _XTYPEDEF_CLIENTPTR
#define _XTYPEDEF_FONTPTR
type FontPtr as _Font ptr
type FSID as culong
type AccContext as FSID
type OSTimePtr as timeval ptr ptr
type BlockHandlerProcPtr as sub(byval as any ptr, byval as OSTimePtr, byval as any ptr)

end extern
