'' FreeBASIC binding for libXmu-1.1.2
''
'' based on the C header files:
''
''   Copyright 1989, 1998  The Open Group
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
''   FreeBASIC development team

#pragma once

#include once "X11/Xmu/DisplayQue.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XMU_CVTCACHE_H_

type _XmuCvtCache_string_to_bitmap
	bitmapFilePath as zstring ptr ptr
end type

type _XmuCvtCache
	string_to_bitmap as _XmuCvtCache_string_to_bitmap
end type

type XmuCvtCache as _XmuCvtCache
declare function _XmuCCLookupDisplay(byval dpy as Display ptr) as XmuCvtCache ptr
declare sub _XmuStringToBitmapInitCache(byval c as XmuCvtCache ptr)
declare sub _XmuStringToBitmapFreeCache(byval c as XmuCvtCache ptr)

end extern
