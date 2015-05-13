#pragma once

#include once "X11/Xfuncproto.bi"
#include once "X11/Xdefs.bi"
#include once "X11/Xlib.bi"
#include once "X11/extensions/lbx.bi"

extern "C"

#define _XLBX_H_
declare function XLbxQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function XLbxQueryVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XLbxGetEventBase(byval dpy as Display ptr) as long

end extern
