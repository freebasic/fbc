'' FreeBASIC binding for libXxf86dga-1.1.4
''
'' based on the C header files:
''   Copyright (c) 1999  XFree86 Inc
''   Copyright (c) 1995  Jon Tombs
''   Copyright (c) 1995, 1996  The XFree86 Project, Inc
''
''   All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is fur-
''   nished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FIT-
''   NESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   XFREE86 PROJECT BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON-
''   NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of the XFree86 Project shall not
''   be used in advertising or otherwise to promote the sale, use or other deal-
''   ings in this Software without prior written authorization from the XFree86
''   Project.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

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
