#pragma once

#include once "X11/Xfuncproto.bi"

extern "C"

#define _XtShellInternal_h
declare sub _XtShellGetCoordinates(byval widget as Widget, byval x as Position ptr, byval y as Position ptr)

end extern
