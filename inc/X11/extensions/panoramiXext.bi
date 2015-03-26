#pragma once

#include once "X11/Xfuncproto.bi"

extern "C"

#define _panoramiXext_h

type XPanoramiXInfo
	window as Window
	screen as long
	State as long
	width as long
	height as long
	ScreenCount as long
	eventMask as XID
end type

declare function XPanoramiXQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XPanoramiXQueryVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XPanoramiXAllocInfo() as XPanoramiXInfo ptr
declare function XPanoramiXGetState(byval as Display ptr, byval as Drawable, byval as XPanoramiXInfo ptr) as long
declare function XPanoramiXGetScreenCount(byval as Display ptr, byval as Drawable, byval as XPanoramiXInfo ptr) as long
declare function XPanoramiXGetScreenSize(byval as Display ptr, byval as Drawable, byval as long, byval as XPanoramiXInfo ptr) as long

end extern
