'' FreeBASIC binding for libXext-1.3.3
''
'' based on the C header files:
''   Copyright 1992 Network Computing Devices
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name of NCD. not be used in advertising or
''   publicity pertaining to distribution of the software without specific,
''   written prior permission.  NCD. makes no representations about the
''   suitability of this software for any purpose.  It is provided "as is"
''   without express or implied warranty.
''
''   NCD. DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
''   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL NCD.
''   BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
''   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
''   OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
''   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

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
