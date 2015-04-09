'' FreeBASIC binding for libXmu-1.1.2

#pragma once

#include once "X11/Xfuncproto.bi"

extern "C"

#define _SYSUTIL_H_
declare function XmuGetHostname(byval buf_return as zstring ptr, byval maxlen as long) as long

end extern
