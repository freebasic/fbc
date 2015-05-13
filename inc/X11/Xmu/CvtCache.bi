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
