'' FreeBASIC binding for libXext-1.3.3

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/shapeconst.bi"
#include once "X11/Xutil.bi"

extern "C"

#define _SHAPE_H_

type XShapeEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	kind as long
	x as long
	y as long
	width as ulong
	height as ulong
	time as Time
	shaped as long
end type

declare function XShapeQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XShapeQueryVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare sub XShapeCombineRegion(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long, byval as Region, byval as long)
declare sub XShapeCombineRectangles(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long, byval as XRectangle ptr, byval as long, byval as long, byval as long)
declare sub XShapeCombineMask(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long, byval as Pixmap, byval as long)
declare sub XShapeCombineShape(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long, byval as Window, byval as long, byval as long)
declare sub XShapeOffsetShape(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long)
declare function XShapeQueryExtents(byval as Display ptr, byval as Window, byval as long ptr, byval as long ptr, byval as long ptr, byval as ulong ptr, byval as ulong ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as ulong ptr, byval as ulong ptr) as long
declare sub XShapeSelectInput(byval as Display ptr, byval as Window, byval as culong)
declare function XShapeInputSelected(byval as Display ptr, byval as Window) as culong
declare function XShapeGetRectangles(byval as Display ptr, byval as Window, byval as long, byval as long ptr, byval as long ptr) as XRectangle ptr

end extern
