''
''
'' XShm -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __XShm_bi__
#define __XShm_bi__

#define X_ShmQueryVersion 0
#define X_ShmAttach 1
#define X_ShmDetach 2
#define X_ShmPutImage 3
#define X_ShmGetImage 4
#define X_ShmCreatePixmap 5
#define ShmCompletion 0
#define ShmNumberEvents (0+1)
#define BadShmSeg 0
#define ShmNumberErrors (0+1)

type ShmSeg as uinteger

type XShmCompletionEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	drawable as Drawable
	major_code as integer
	minor_code as integer
	shmseg as ShmSeg
	offset as uinteger
end type

type XShmSegmentInfo
	shmseg as ShmSeg
	shmid as integer
	shmaddr as zstring ptr
	readOnly as Bool
end type

declare function XShmGetEventBase cdecl alias "XShmGetEventBase" (byval as Display ptr) as integer
declare function XShmQueryVersion cdecl alias "XShmQueryVersion" (byval as Display ptr, byval as integer ptr, byval as integer ptr, byval as Bool ptr) as Bool
declare function XShmPixmapFormat cdecl alias "XShmPixmapFormat" (byval as Display ptr) as integer
declare function XShmAttach cdecl alias "XShmAttach" (byval as Display ptr, byval as XShmSegmentInfo ptr) as Status
declare function XShmDetach cdecl alias "XShmDetach" (byval as Display ptr, byval as XShmSegmentInfo ptr) as Status
declare function XShmPutImage cdecl alias "XShmPutImage" (byval as Display ptr, byval as Drawable, byval as GC, byval as XImage ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as Bool) as Status
declare function XShmGetImage cdecl alias "XShmGetImage" (byval as Display ptr, byval as Drawable, byval as XImage ptr, byval as integer, byval as integer, byval as uinteger) as Status
declare function XShmCreateImage cdecl alias "XShmCreateImage" (byval as Display ptr, byval as Visual ptr, byval as uinteger, byval as integer, byval as zstring ptr, byval as XShmSegmentInfo ptr, byval as uinteger, byval as uinteger) as XImage ptr
declare function XShmCreatePixmap cdecl alias "XShmCreatePixmap" (byval as Display ptr, byval as Drawable, byval as zstring ptr, byval as XShmSegmentInfo ptr, byval as uinteger, byval as uinteger, byval as uinteger) as Pixmap

#endif
