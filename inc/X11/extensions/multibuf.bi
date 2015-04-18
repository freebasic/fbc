'' FreeBASIC binding for libXext-1.3.3
''
'' based on the C header files:
''    *
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
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/multibufconst.bi"

extern "C"

#define _MULTIBUF_H_
#macro MbufGetReq(name, req, info)
	scope
		GetReq(name, req)
		req->reqType = info->codes->major_opcode
		req->mbufReqType = X_##name
	end scope
#endmacro
type Multibuffer as XID

type XmbufClobberNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	buffer as Multibuffer
	state as long
end type

type XmbufUpdateNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	buffer as Multibuffer
end type

type XmbufWindowAttributes
	displayed_index as long
	update_action as long
	update_hint as long
	window_mode as long
	nbuffers as long
	buffers as Multibuffer ptr
end type

type XmbufSetWindowAttributes
	update_hint as long
end type

type XmbufBufferAttributes
	window as Window
	event_mask as culong
	buffer_index as long
	side as long
end type

type XmbufSetBufferAttributes
	event_mask as culong
end type

type XmbufBufferInfo
	visualid as VisualID
	max_buffers as long
	depth as long
end type

declare function XmbufQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XmbufGetVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XmbufCreateBuffers(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long, byval as Multibuffer ptr) as long
declare sub XmbufDestroyBuffers(byval as Display ptr, byval as Window)
declare sub XmbufDisplayBuffers(byval as Display ptr, byval as long, byval as Multibuffer ptr, byval as long, byval as long)
declare function XmbufGetWindowAttributes(byval as Display ptr, byval as Window, byval as XmbufWindowAttributes ptr) as long
declare sub XmbufChangeWindowAttributes(byval as Display ptr, byval as Window, byval as culong, byval as XmbufSetWindowAttributes ptr)
declare function XmbufGetBufferAttributes(byval as Display ptr, byval as Multibuffer, byval as XmbufBufferAttributes ptr) as long
declare sub XmbufChangeBufferAttributes(byval as Display ptr, byval as Multibuffer, byval as culong, byval as XmbufSetBufferAttributes ptr)
declare function XmbufGetScreenInfo(byval as Display ptr, byval as Drawable, byval as long ptr, byval as XmbufBufferInfo ptr ptr, byval as long ptr, byval as XmbufBufferInfo ptr ptr) as long
declare function XmbufCreateStereoWindow(byval as Display ptr, byval as Window, byval as long, byval as long, byval as ulong, byval as ulong, byval as ulong, byval as long, byval as ulong, byval as Visual ptr, byval as culong, byval as XSetWindowAttributes ptr, byval as Multibuffer ptr, byval as Multibuffer ptr) as Window
declare sub XmbufClearBufferArea(byval as Display ptr, byval as Multibuffer, byval as long, byval as long, byval as ulong, byval as ulong, byval as long)

end extern
