'' FreeBASIC binding for libXmu-1.1.2

#pragma once

#include once "X11/Xfuncproto.bi"

extern "C"

declare sub _XEditResCheckMessages(byval w as Widget, byval data as XtPointer, byval event as XEvent ptr, byval cont as zstring ptr)

end extern
