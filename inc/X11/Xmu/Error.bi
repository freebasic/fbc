#pragma once

#include once "crt/stdio.bi"
#include once "X11/Xlib.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XMU_ERROR_H_
declare function XmuPrintDefaultErrorMessage(byval dpy as Display ptr, byval event as XErrorEvent ptr, byval fp as FILE ptr) as long
declare function XmuSimpleErrorHandler(byval dpy as Display ptr, byval errorp as XErrorEvent ptr) as long

end extern
