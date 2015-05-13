#pragma once

#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/cup.bi"

extern "C"

#define _XCUP_H_
declare function XcupQueryVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XcupGetReservedColormapEntries(byval as Display ptr, byval as long, byval as XColor ptr ptr, byval as long ptr) as long
declare function XcupStoreColors(byval as Display ptr, byval as Colormap, byval as XColor ptr, byval as long) as long

end extern
