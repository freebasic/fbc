'' FreeBASIC binding for libXinerama-1.1.3

#pragma once

#include once "X11/Xlib.bi"

extern "C"

#define _Xinerama_h

type XineramaScreenInfo
	screen_number as long
	x_org as short
	y_org as short
	width as short
	height as short
end type

declare function XineramaQueryExtension(byval dpy as Display ptr, byval event_base as long ptr, byval error_base as long ptr) as long
declare function XineramaQueryVersion(byval dpy as Display ptr, byval major_versionp as long ptr, byval minor_versionp as long ptr) as long
declare function XineramaIsActive(byval dpy as Display ptr) as long
declare function XineramaQueryScreens(byval dpy as Display ptr, byval number as long ptr) as XineramaScreenInfo ptr

end extern
