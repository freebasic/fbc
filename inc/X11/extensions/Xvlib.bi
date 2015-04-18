'' FreeBASIC binding for libXv-1.0.10
''
'' based on the C header files:
''   *********************************************************
''   Copyright 1991 by Digital Equipment Corporation, Maynard, Massachusetts,
''   and the Massachusetts Institute of Technology, Cambridge, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the names of Digital or MIT not be
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

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/Xv.bi"
#include once "X11/extensions/XShm.bi"

extern "C"

#define XVLIB_H

type XvRational
	numerator as long
	denominator as long
end type

type XvAttribute
	flags as long
	min_value as long
	max_value as long
	name as zstring ptr
end type

type XvEncodingInfo
	encoding_id as XvEncodingID
	name as zstring ptr
	width as culong
	height as culong
	rate as XvRational
	num_encodings as culong
end type

type XvFormat
	depth as byte
	visual_id as culong
end type

type XvAdaptorInfo
	base_id as XvPortID
	num_ports as culong
	as byte type
	name as zstring ptr
	num_formats as culong
	formats as XvFormat ptr
	num_adaptors as culong
end type

type XvVideoNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	drawable as Drawable
	reason as culong
	port_id as XvPortID
	time as Time
end type

type XvPortNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	port_id as XvPortID
	time as Time
	attribute as XAtom
	value as clong
end type

union XvEvent
	as long type
	xvvideo as XvVideoNotifyEvent
	xvport as XvPortNotifyEvent
	pad(0 to 23) as clong
end union

type XvImageFormatValues
	id as long
	as long type
	byte_order as long
	guid as zstring * 16
	bits_per_pixel as long
	format as long
	num_planes as long
	depth as long
	red_mask as ulong
	green_mask as ulong
	blue_mask as ulong
	y_sample_bits as ulong
	u_sample_bits as ulong
	v_sample_bits as ulong
	horz_y_period as ulong
	horz_u_period as ulong
	horz_v_period as ulong
	vert_y_period as ulong
	vert_u_period as ulong
	vert_v_period as ulong
	component_order as zstring * 32
	scanline_order as long
end type

type XvImage
	id as long
	width as long
	height as long
	data_size as long
	num_planes as long
	pitches as long ptr
	offsets as long ptr
	data as zstring ptr
	obdata as XPointer
end type

declare function XvQueryExtension(byval as Display ptr, byval as ulong ptr, byval as ulong ptr, byval as ulong ptr, byval as ulong ptr, byval as ulong ptr) as long
declare function XvQueryAdaptors(byval as Display ptr, byval as Window, byval as ulong ptr, byval as XvAdaptorInfo ptr ptr) as long
declare function XvQueryEncodings(byval as Display ptr, byval as XvPortID, byval as ulong ptr, byval as XvEncodingInfo ptr ptr) as long
declare function XvPutVideo(byval as Display ptr, byval as XvPortID, byval as Drawable, byval as GC, byval as long, byval as long, byval as ulong, byval as ulong, byval as long, byval as long, byval as ulong, byval as ulong) as long
declare function XvPutStill(byval as Display ptr, byval as XvPortID, byval as Drawable, byval as GC, byval as long, byval as long, byval as ulong, byval as ulong, byval as long, byval as long, byval as ulong, byval as ulong) as long
declare function XvGetVideo(byval as Display ptr, byval as XvPortID, byval as Drawable, byval as GC, byval as long, byval as long, byval as ulong, byval as ulong, byval as long, byval as long, byval as ulong, byval as ulong) as long
declare function XvGetStill(byval as Display ptr, byval as XvPortID, byval as Drawable, byval as GC, byval as long, byval as long, byval as ulong, byval as ulong, byval as long, byval as long, byval as ulong, byval as ulong) as long
declare function XvStopVideo(byval as Display ptr, byval as XvPortID, byval as Drawable) as long
declare function XvGrabPort(byval as Display ptr, byval as XvPortID, byval as Time) as long
declare function XvUngrabPort(byval as Display ptr, byval as XvPortID, byval as Time) as long
declare function XvSelectVideoNotify(byval as Display ptr, byval as Drawable, byval as long) as long
declare function XvSelectPortNotify(byval as Display ptr, byval as XvPortID, byval as long) as long
declare function XvSetPortAttribute(byval as Display ptr, byval as XvPortID, byval as XAtom, byval as long) as long
declare function XvGetPortAttribute(byval as Display ptr, byval as XvPortID, byval as XAtom, byval as long ptr) as long
declare function XvQueryBestSize(byval as Display ptr, byval as XvPortID, byval as long, byval as ulong, byval as ulong, byval as ulong, byval as ulong, byval as ulong ptr, byval as ulong ptr) as long
declare function XvQueryPortAttributes(byval as Display ptr, byval as XvPortID, byval as long ptr) as XvAttribute ptr
declare sub XvFreeAdaptorInfo(byval as XvAdaptorInfo ptr)
declare sub XvFreeEncodingInfo(byval as XvEncodingInfo ptr)
declare function XvListImageFormats(byval display as Display ptr, byval port_id as XvPortID, byval count_return as long ptr) as XvImageFormatValues ptr
declare function XvCreateImage(byval display as Display ptr, byval port as XvPortID, byval id as long, byval data as zstring ptr, byval width as long, byval height as long) as XvImage ptr
declare function XvPutImage(byval display as Display ptr, byval id as XvPortID, byval d as Drawable, byval gc as GC, byval image as XvImage ptr, byval src_x as long, byval src_y as long, byval src_w as ulong, byval src_h as ulong, byval dest_x as long, byval dest_y as long, byval dest_w as ulong, byval dest_h as ulong) as long
declare function XvShmPutImage(byval display as Display ptr, byval id as XvPortID, byval d as Drawable, byval gc as GC, byval image as XvImage ptr, byval src_x as long, byval src_y as long, byval src_w as ulong, byval src_h as ulong, byval dest_x as long, byval dest_y as long, byval dest_w as ulong, byval dest_h as ulong, byval send_event as long) as long
declare function XvShmCreateImage(byval display as Display ptr, byval port as XvPortID, byval id as long, byval data as zstring ptr, byval width as long, byval height as long, byval shminfo as XShmSegmentInfo ptr) as XvImage ptr

end extern
