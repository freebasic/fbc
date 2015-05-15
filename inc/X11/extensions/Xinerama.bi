'' FreeBASIC binding for libXinerama-1.1.3
''
'' based on the C header files:
''
''   Copyright 2003  The Open Group
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
