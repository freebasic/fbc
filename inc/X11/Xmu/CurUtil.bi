'' FreeBASIC binding for libXmu-1.1.2

#pragma once

#include once "X11/Xfuncproto.bi"

extern "C"

#define _XMU_CURUTIL_H_
declare function XmuCursorNameToIndex(byval name as const zstring ptr) as long

end extern
