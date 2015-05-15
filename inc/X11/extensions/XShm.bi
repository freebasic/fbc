'' FreeBASIC binding for libXext-1.3.3
''
'' based on the C header files:
''   **********************************************************
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
''   *******************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/shm.bi"

extern "C"

#define _XSHM_H_
type ShmSeg as culong

type XShmCompletionEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	drawable as Drawable
	major_code as long
	minor_code as long
	shmseg as ShmSeg
	offset as culong
end type

type XShmSegmentInfo
	shmseg as ShmSeg
	shmid as long
	shmaddr as zstring ptr
	readOnly as long
end type

declare function XShmQueryExtension(byval as Display ptr) as long
declare function XShmGetEventBase(byval as Display ptr) as long
declare function XShmQueryVersion(byval as Display ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function XShmPixmapFormat(byval as Display ptr) as long
declare function XShmAttach(byval as Display ptr, byval as XShmSegmentInfo ptr) as long
declare function XShmDetach(byval as Display ptr, byval as XShmSegmentInfo ptr) as long
declare function XShmPutImage(byval as Display ptr, byval as Drawable, byval as GC, byval as XImage ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong, byval as ulong, byval as long) as long
declare function XShmGetImage(byval as Display ptr, byval as Drawable, byval as XImage ptr, byval as long, byval as long, byval as culong) as long
declare function XShmCreateImage(byval as Display ptr, byval as Visual ptr, byval as ulong, byval as long, byval as zstring ptr, byval as XShmSegmentInfo ptr, byval as ulong, byval as ulong) as XImage ptr
declare function XShmCreatePixmap(byval as Display ptr, byval as Drawable, byval as zstring ptr, byval as XShmSegmentInfo ptr, byval as ulong, byval as ulong, byval as ulong) as Pixmap

end extern
