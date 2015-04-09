'' FreeBASIC binding for libXext-1.3.3

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
