'' FreeBASIC binding for libXext-1.3.3

#pragma once

#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/mitmiscconst.bi"

extern "C"

#define _XMITMISC_H_
declare function XMITMiscQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XMITMiscSetBugMode(byval as Display ptr, byval as long) as long
declare function XMITMiscGetBugMode(byval as Display ptr) as long

end extern
