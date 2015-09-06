'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1988, 1994, 1998  The Open Group
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
''   Copyright 1987, 1988 by Digital Equipment Corporation, Maynard, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name of Digital not be
''   used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
''   ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
''   DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
''   ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
''   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "Xtos.bi"
#include once "IntrinsicP.bi"
#include once "X11/Xos.bi"
#include once "Object.bi"
#include once "RectObj.bi"
#include once "ObjectP.bi"
#include once "RectObjP.bi"
#include once "ConvertI.bi"
#include once "TranslateI.bi"
#include once "X11/Xfuncs.bi"

extern "C"

#define _XtintrinsicI_h

#ifdef __FB_WIN32__
	#define _WILLWINSOCK_
#endif

const RectObjClassFlag = &h02
const WidgetClassFlag = &h04
const CompositeClassFlag = &h08
const ConstraintClassFlag = &h10
const ShellClassFlag = &h20
const WMShellClassFlag = &h40
const TopLevelClassFlag = &h80
#undef XtDisplayOfObject
#define XtDisplayOfObject(object) iif(XtIsWidget(object), (object)->core.screen->display, iif(_XtIsHookObject(object), cast(HookObject, (object))->hooks.screen->display, _XtWindowedAncestor(object)->core.screen->display))
#undef XtScreenOfObject
#define XtScreenOfObject(object) iif(XtIsWidget(object), (object)->core.screen, iif(_XtIsHookObject(object), cast(HookObject, (object))->hooks.screen, _XtWindowedAncestor(object)->core.screen))
#undef XtWindowOfObject
#define XtWindowOfObject(object) iif(XtIsWidget(object), (object), _XtWindowedAncestor(object))->core.window
#undef XtIsManaged
#define XtIsManaged(object) iif(XtIsRectObj(object), (object)->core.managed, False)
#undef XtIsSensitive
#define XtIsSensitive(object) iif(XtIsRectObj(object), -((object)->core.sensitive andalso (object)->core.ancestor_sensitive), False)
#define _XBCOPYFUNC _XtBcopy
#macro XtMemmove(dst, src, size)
	if cptr(any ptr, dst) <> cptr(any ptr, src) then
		memcpy((dst), (src), clng(size))
	end if
#endmacro
#define XtBZero(dst, size) bzero(cptr(zstring ptr, (dst)), clng(size))
#define XtMemcmp(b1, b2, size) memcmp(cptr(zstring ptr, (b1)), cptr(zstring ptr, (b2)), clng(size))
#define XtStackAlloc(size, stack_cache_array) iif((size) <= sizeof(stack_cache_array), cast(XtPointer, (stack_cache_array)), XtMalloc(culng(size)))
#macro XtStackFree(pointer, stack_cache_array)
	if (pointer) <> cast(XtPointer, (stack_cache_array)) then
		XtFree(pointer)
	end if
#endmacro
#define XFILESEARCHPATHDEFAULT "/usr/lib/X11/%L/%T/%N%S:/usr/lib/X11/%l/%T/%N%S:/usr/lib/X11/%T/%N%S"
#define XTERROR_PREFIX ""
#define XTWARNING_PREFIX ""
#define ERRORDB "/usr/lib/X11/XtErrorDB"
extern XtCXtToolkitError as String_

declare sub _XtAllocError(byval as String_)
declare sub _XtCompileResourceList(byval as XtResourceList, byval as Cardinal)
declare function _XtMakeGeometryRequest(byval as Widget, byval as XtWidgetGeometry ptr, byval as XtWidgetGeometry ptr, byval as XBoolean ptr) as XtGeometryResult
declare function _XtIsHookObject(byval as Widget) as XBoolean
declare sub _XtAddShellToHookObj(byval as Widget)
declare sub _XtGClistFree(byval dpy as Display ptr, byval pd as XtPerDisplay)
#define CALLGEOTAT(f)
declare function __XtMalloc(byval as ulong) as zstring ptr
declare function __XtCalloc(byval as ulong, byval as ulong) as zstring ptr

end extern
