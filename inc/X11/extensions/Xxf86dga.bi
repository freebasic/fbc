'' FreeBASIC binding for libXxf86dga-1.1.4

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/xf86dgaconst.bi"
#include once "X11/extensions/xf86dga1.bi"

extern "C"

#define _XF86DGA_H_

type XDGAButtonEvent
	as long type
	serial as culong
	display as Display ptr
	screen as long
	time as Time
	state as ulong
	button as ulong
end type

type XDGAKeyEvent
	as long type
	serial as culong
	display as Display ptr
	screen as long
	time as Time
	state as ulong
	keycode as ulong
end type

type XDGAMotionEvent
	as long type
	serial as culong
	display as Display ptr
	screen as long
	time as Time
	state as ulong
	dx as long
	dy as long
end type

union XDGAEvent
	as long type
	xbutton as XDGAButtonEvent
	xkey as XDGAKeyEvent
	xmotion as XDGAMotionEvent
	pad(0 to 23) as clong
end union

declare function XDGAQueryExtension(byval dpy as Display ptr, byval eventBase as long ptr, byval erroBase as long ptr) as long
declare function XDGAQueryVersion(byval dpy as Display ptr, byval majorVersion as long ptr, byval minorVersion as long ptr) as long
declare function XDGAQueryModes(byval dpy as Display ptr, byval screen as long, byval num as long ptr) as XDGAMode ptr
declare function XDGASetMode(byval dpy as Display ptr, byval screen as long, byval mode as long) as XDGADevice ptr
declare function XDGAOpenFramebuffer(byval dpy as Display ptr, byval screen as long) as long
declare sub XDGACloseFramebuffer(byval dpy as Display ptr, byval screen as long)
declare sub XDGASetViewport(byval dpy as Display ptr, byval screen as long, byval x as long, byval y as long, byval flags as long)
declare sub XDGAInstallColormap(byval dpy as Display ptr, byval screen as long, byval cmap as Colormap)
declare function XDGACreateColormap(byval dpy as Display ptr, byval screen as long, byval device as XDGADevice ptr, byval alloc as long) as Colormap
declare sub XDGASelectInput(byval dpy as Display ptr, byval screen as long, byval event_mask as clong)
declare sub XDGAFillRectangle(byval dpy as Display ptr, byval screen as long, byval x as long, byval y as long, byval width as ulong, byval height as ulong, byval color as culong)
declare sub XDGACopyArea(byval dpy as Display ptr, byval screen as long, byval srcx as long, byval srcy as long, byval width as ulong, byval height as ulong, byval dstx as long, byval dsty as long)
declare sub XDGACopyTransparentArea(byval dpy as Display ptr, byval screen as long, byval srcx as long, byval srcy as long, byval width as ulong, byval height as ulong, byval dstx as long, byval dsty as long, byval key as culong)
declare function XDGAGetViewportStatus(byval dpy as Display ptr, byval screen as long) as long
declare sub XDGASync(byval dpy as Display ptr, byval screen as long)
declare function XDGASetClientVersion(byval dpy as Display ptr) as long
declare sub XDGAChangePixmapMode(byval dpy as Display ptr, byval screen as long, byval x as long ptr, byval y as long ptr, byval mode as long)
declare sub XDGAKeyEventToXKeyEvent(byval dk as XDGAKeyEvent ptr, byval xk as XKeyEvent ptr)

end extern
