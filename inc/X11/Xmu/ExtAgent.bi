#pragma once

#include once "X11/Intrinsic.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

declare sub XmuRegisterExternalAgent(byval w as Widget, byval data as XtPointer, byval event as XEvent ptr, byval cont as zstring ptr)

end extern
