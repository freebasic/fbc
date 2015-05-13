''
''
'' multibuf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __multibuf_bi__
#define __multibuf_bi__

#define MULTIBUFFER_PROTOCOL_NAME "Multi-Buffering"
#define MULTIBUFFER_MAJOR_VERSION 1
#define MULTIBUFFER_MINOR_VERSION 1
#define X_MbufGetBufferVersion 0
#define X_MbufCreateImageBuffers 1
#define X_MbufDestroyImageBuffers 2
#define X_MbufDisplayImageBuffers 3
#define X_MbufSetMBufferAttributes 4
#define X_MbufGetMBufferAttributes 5
#define X_MbufSetBufferAttributes 6
#define X_MbufGetBufferAttributes 7
#define X_MbufGetBufferInfo 8
#define X_MbufCreateStereoWindow 9
#define X_MbufClearImageBufferArea 10
#define MultibufferUpdateActionUndefined 0
#define MultibufferUpdateActionBackground 1
#define MultibufferUpdateActionUntouched 2
#define MultibufferUpdateActionCopied 3
#define MultibufferUpdateHintFrequent 0
#define MultibufferUpdateHintIntermittent 1
#define MultibufferUpdateHintStatic 2
#define MultibufferWindowUpdateHint (1L shl 0)
#define MultibufferBufferEventMask (1L shl 0)
#define MultibufferModeMono 0
#define MultibufferModeStereo 1
#define MultibufferSideMono 0
#define MultibufferSideLeft 1
#define MultibufferSideRight 2
#define MultibufferUnclobbered 0
#define MultibufferPartiallyClobbered 1
#define MultibufferFullyClobbered 2
#define MultibufferClobberNotifyMask &h02000000
#define MultibufferUpdateNotifyMask &h04000000
#define MultibufferClobberNotify 0
#define MultibufferUpdateNotify 1
#define MultibufferNumberEvents (1+1)
#define MultibufferBadBuffer 0
#define MultibufferNumberErrors (0+1)

type Multibuffer as XID

type XmbufClobberNotifyEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	buffer as Multibuffer
	state as integer
end type

type XmbufUpdateNotifyEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	buffer as Multibuffer
end type

type XmbufWindowAttributes
	displayed_index as integer
	update_action as integer
	update_hint as integer
	window_mode as integer
	nbuffers as integer
	buffers as Multibuffer ptr
end type

type XmbufSetWindowAttributes
	update_hint as integer
end type

type XmbufBufferAttributes
	window as Window
	event_mask as uinteger
	buffer_index as integer
	side as integer
end type

type XmbufSetBufferAttributes
	event_mask as uinteger
end type

type XmbufBufferInfo
	visualid as VisualID
	max_buffers as integer
	depth as integer
end type

declare function XmbufGetVersion cdecl alias "XmbufGetVersion" (byval as Display ptr, byval as integer ptr, byval as integer ptr) as Status
declare function XmbufCreateBuffers cdecl alias "XmbufCreateBuffers" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as integer, byval as Multibuffer ptr) as integer
declare sub XmbufDestroyBuffers cdecl alias "XmbufDestroyBuffers" (byval as Display ptr, byval as Window)
declare sub XmbufDisplayBuffers cdecl alias "XmbufDisplayBuffers" (byval as Display ptr, byval as integer, byval as Multibuffer ptr, byval as integer, byval as integer)
declare function XmbufGetWindowAttributes cdecl alias "XmbufGetWindowAttributes" (byval as Display ptr, byval as Window, byval as XmbufWindowAttributes ptr) as Status
declare sub XmbufChangeWindowAttributes cdecl alias "XmbufChangeWindowAttributes" (byval as Display ptr, byval as Window, byval as uinteger, byval as XmbufSetWindowAttributes ptr)
declare function XmbufGetBufferAttributes cdecl alias "XmbufGetBufferAttributes" (byval as Display ptr, byval as Multibuffer, byval as XmbufBufferAttributes ptr) as Status
declare sub XmbufChangeBufferAttributes cdecl alias "XmbufChangeBufferAttributes" (byval as Display ptr, byval as Multibuffer, byval as uinteger, byval as XmbufSetBufferAttributes ptr)
declare function XmbufGetScreenInfo cdecl alias "XmbufGetScreenInfo" (byval as Display ptr, byval as Drawable, byval as integer ptr, byval as XmbufBufferInfo ptr ptr, byval as integer ptr, byval as XmbufBufferInfo ptr ptr) as Status
declare function XmbufCreateStereoWindow cdecl alias "XmbufCreateStereoWindow" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as uinteger, byval as integer, byval as uinteger, byval as Visual ptr, byval as uinteger, byval as XSetWindowAttributes ptr, byval as Multibuffer ptr, byval as Multibuffer ptr) as Window
declare sub XmbufClearBufferArea cdecl alias "XmbufClearBufferArea" (byval as Display ptr, byval as Multibuffer, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as Bool)

#endif
