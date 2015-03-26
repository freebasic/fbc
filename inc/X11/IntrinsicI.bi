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
#define XtBZero(dst, size) bzero(cptr(zstring ptr, (dst)), clng((size)))
#define XtMemcmp(b1, b2, size) memcmp(cptr(zstring ptr, (b1)), cptr(zstring ptr, (b2)), clng((size)))
#define XtStackAlloc(size, stack_cache_array) iif((size) <= sizeof((stack_cache_array)), cast(XtPointer, (stack_cache_array)), XtMalloc(culng((size))))
#macro XtStackFree(pointer, stack_cache_array)
	scope
		if (pointer) <> cptr(XtPointer, stack_cache_array) then
			XtFree(pointer)
		end if
	end scope
#endmacro
#define XFILESEARCHPATHDEFAULT "/usr/lib/X11/%L/%T/%N%S:/usr/lib/X11/%l/%T/%N%S:/usr/lib/X11/%T/%N%S"
#define XTERROR_PREFIX ""
#define XTWARNING_PREFIX ""
#define ERRORDB "/usr/lib/X11/XtErrorDB"
extern XtCXtToolkitError as String_

declare sub _XtAllocError(byval as String_)
declare sub _XtCompileResourceList(byval as XtResourceList, byval as Cardinal)
declare function _XtMakeGeometryRequest(byval as Widget, byval as XtWidgetGeometry ptr, byval as XtWidgetGeometry ptr, byval as zstring ptr) as XtGeometryResult
declare function _XtIsHookObject(byval as Widget) as byte
declare sub _XtAddShellToHookObj(byval as Widget)
declare sub _XtGClistFree(byval dpy as Display ptr, byval pd as XtPerDisplay)
#define CALLGEOTAT(f)
declare function __XtMalloc(byval as ulong) as zstring ptr
declare function __XtCalloc(byval as ulong, byval as ulong) as zstring ptr

end extern
