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
#include once "X11/Xlib.bi"
#include once "X11/Xfuncproto.bi"
#include once "crt/stdio.bi"

extern "C"

#define _XMU_DRAWING_H_
declare sub XmuDrawRoundedRectangle(byval dpy as Display ptr, byval draw as Drawable, byval gc as GC, byval x as long, byval y as long, byval w as long, byval h as long, byval ew as long, byval eh as long)
declare sub XmuFillRoundedRectangle(byval dpy as Display ptr, byval draw as Drawable, byval gc as GC, byval x as long, byval y as long, byval w as long, byval h as long, byval ew as long, byval eh as long)
declare sub XmuDrawLogo(byval dpy as Display ptr, byval drawable as Drawable, byval gcFore as GC, byval gcBack as GC, byval x as long, byval y as long, byval width as ulong, byval height as ulong)
declare function XmuCreatePixmapFromBitmap(byval dpy as Display ptr, byval d as Drawable, byval bitmap as Pixmap, byval width as ulong, byval height as ulong, byval depth as ulong, byval fore as culong, byval back as culong) as Pixmap
declare function XmuCreateStippledPixmap(byval screen as Screen ptr, byval fore as Pixel, byval back as Pixel, byval depth as ulong) as Pixmap
declare sub XmuReleaseStippledPixmap(byval screen as Screen ptr, byval pixmap as Pixmap)
declare function XmuLocateBitmapFile(byval screen as Screen ptr, byval name as const zstring ptr, byval srcname_return as zstring ptr, byval srcnamelen as long, byval width_return as long ptr, byval height_return as long ptr, byval xhot_return as long ptr, byval yhot_return as long ptr) as Pixmap
declare function XmuLocatePixmapFile(byval screen as Screen ptr, byval name as const zstring ptr, byval fore as culong, byval back as culong, byval depth as ulong, byval srcname_return as zstring ptr, byval srcnamelen as long, byval width_return as long ptr, byval height_return as long ptr, byval xhot_return as long ptr, byval yhot_return as long ptr) as Pixmap
declare function XmuReadBitmapData(byval fstream as FILE ptr, byval width_return as ulong ptr, byval height_return as ulong ptr, byval datap_return as ubyte ptr ptr, byval xhot_return as long ptr, byval yhot_return as long ptr) as long
declare function XmuReadBitmapDataFromFile(byval filename as const zstring ptr, byval width_return as ulong ptr, byval height_return as ulong ptr, byval datap_return as ubyte ptr ptr, byval xhot_return as long ptr, byval yhot_return as long ptr) as long

end extern
