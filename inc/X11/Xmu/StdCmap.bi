'' FreeBASIC binding for libXmu-1.1.2
''
'' based on the C header files:
''
''   Copyright 1988, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XMU_STDCMAP_H_
declare function XmuAllStandardColormaps(byval dpy as Display ptr) as long
declare function XmuCreateColormap(byval dpy as Display ptr, byval colormap as XStandardColormap ptr) as long
declare sub XmuDeleteStandardColormap(byval dpy as Display ptr, byval screen as long, byval property as XAtom)
declare function XmuGetColormapAllocation(byval vinfo as XVisualInfo ptr, byval property as XAtom, byval red_max_return as culong ptr, byval green_max_return as culong ptr, byval blue_max_return as culong ptr) as long
declare function XmuLookupStandardColormap(byval dpy as Display ptr, byval screen as long, byval visualid as VisualID, byval depth as ulong, byval property as XAtom, byval replace as long, byval retain as long) as long
declare function XmuStandardColormap(byval dpy as Display ptr, byval screen as long, byval visualid as VisualID, byval depth as ulong, byval property as XAtom, byval cmap as Colormap, byval red_max as culong, byval green_max as culong, byval blue_max as culong) as XStandardColormap ptr
declare function XmuVisualStandardColormaps(byval dpy as Display ptr, byval screen as long, byval visualid as VisualID, byval depth as ulong, byval replace as long, byval retain as long) as long
declare function XmuDistinguishableColors(byval colors as XColor ptr, byval count as long) as long
declare function XmuDistinguishablePixels(byval dpy as Display ptr, byval cmap as Colormap, byval pixels as culong ptr, byval count as long) as long

end extern
