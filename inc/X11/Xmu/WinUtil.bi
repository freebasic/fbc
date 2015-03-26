#pragma once

#include once "X11/Xutil.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XMU_WINDOWUTIL_H_
declare function XmuClientWindow(byval dpy as Display ptr, byval win as Window) as Window
declare function XmuUpdateMapHints(byval dpy as Display ptr, byval win as Window, byval hints as XSizeHints ptr) as long
declare function XmuScreenOfWindow(byval dpy as Display ptr, byval w as Window) as Screen ptr

end extern
