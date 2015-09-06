'' FreeBASIC binding for libXfixes-5.0.1
''
'' based on the C header files:
''   Copyright (c) 2006, Oracle and/or its affiliates. All rights reserved.
''   Copyright 2011 Red Hat, Inc.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice (including the next
''   paragraph) shall be included in all copies or substantial portions of the
''   Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
''   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/extensions/xfixeswire.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/Xlib.bi"

extern "C"

#define _XFIXES_H_
const XFIXES_REVISION = 1
const XFIXES_VERSION = ((XFIXES_MAJOR * 10000) + (XFIXES_MINOR * 100)) + XFIXES_REVISION

type XFixesSelectionNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	subtype as long
	owner as Window
	selection as XAtom
	timestamp as Time
	selection_timestamp as Time
end type

type XFixesCursorNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	subtype as long
	cursor_serial as culong
	timestamp as Time
	cursor_name as XAtom
end type

type XFixesCursorImage
	x as short
	y as short
	width as ushort
	height as ushort
	xhot as ushort
	yhot as ushort
	cursor_serial as culong
	pixels as culong ptr
	atom as XAtom
	name as const zstring ptr
end type

type XserverRegion as XID

type XFixesCursorImageAndName
	x as short
	y as short
	width as ushort
	height as ushort
	xhot as ushort
	yhot as ushort
	cursor_serial as culong
	pixels as culong ptr
	atom as XAtom
	name as const zstring ptr
end type

declare function XFixesQueryExtension(byval dpy as Display ptr, byval event_base_return as long ptr, byval error_base_return as long ptr) as long
declare function XFixesQueryVersion(byval dpy as Display ptr, byval major_version_return as long ptr, byval minor_version_return as long ptr) as long
declare function XFixesVersion() as long
declare sub XFixesChangeSaveSet(byval dpy as Display ptr, byval win as Window, byval mode as long, byval target as long, byval map as long)
declare sub XFixesSelectSelectionInput(byval dpy as Display ptr, byval win as Window, byval selection as XAtom, byval eventMask as culong)
declare sub XFixesSelectCursorInput(byval dpy as Display ptr, byval win as Window, byval eventMask as culong)
declare function XFixesGetCursorImage(byval dpy as Display ptr) as XFixesCursorImage ptr
declare function XFixesCreateRegion(byval dpy as Display ptr, byval rectangles as XRectangle ptr, byval nrectangles as long) as XserverRegion
declare function XFixesCreateRegionFromBitmap(byval dpy as Display ptr, byval bitmap as Pixmap) as XserverRegion
declare function XFixesCreateRegionFromWindow(byval dpy as Display ptr, byval window as Window, byval kind as long) as XserverRegion
declare function XFixesCreateRegionFromGC(byval dpy as Display ptr, byval gc as GC) as XserverRegion
declare function XFixesCreateRegionFromPicture(byval dpy as Display ptr, byval picture as XID) as XserverRegion
declare sub XFixesDestroyRegion(byval dpy as Display ptr, byval region as XserverRegion)
declare sub XFixesSetRegion(byval dpy as Display ptr, byval region as XserverRegion, byval rectangles as XRectangle ptr, byval nrectangles as long)
declare sub XFixesCopyRegion(byval dpy as Display ptr, byval dst as XserverRegion, byval src as XserverRegion)
declare sub XFixesUnionRegion(byval dpy as Display ptr, byval dst as XserverRegion, byval src1 as XserverRegion, byval src2 as XserverRegion)
declare sub XFixesIntersectRegion(byval dpy as Display ptr, byval dst as XserverRegion, byval src1 as XserverRegion, byval src2 as XserverRegion)
declare sub XFixesSubtractRegion(byval dpy as Display ptr, byval dst as XserverRegion, byval src1 as XserverRegion, byval src2 as XserverRegion)
declare sub XFixesInvertRegion(byval dpy as Display ptr, byval dst as XserverRegion, byval rect as XRectangle ptr, byval src as XserverRegion)
declare sub XFixesTranslateRegion(byval dpy as Display ptr, byval region as XserverRegion, byval dx as long, byval dy as long)
declare sub XFixesRegionExtents(byval dpy as Display ptr, byval dst as XserverRegion, byval src as XserverRegion)
declare function XFixesFetchRegion(byval dpy as Display ptr, byval region as XserverRegion, byval nrectanglesRet as long ptr) as XRectangle ptr
declare function XFixesFetchRegionAndBounds(byval dpy as Display ptr, byval region as XserverRegion, byval nrectanglesRet as long ptr, byval bounds as XRectangle ptr) as XRectangle ptr
declare sub XFixesSetGCClipRegion(byval dpy as Display ptr, byval gc as GC, byval clip_x_origin as long, byval clip_y_origin as long, byval region as XserverRegion)
declare sub XFixesSetWindowShapeRegion(byval dpy as Display ptr, byval win as Window, byval shape_kind as long, byval x_off as long, byval y_off as long, byval region as XserverRegion)
declare sub XFixesSetPictureClipRegion(byval dpy as Display ptr, byval picture as XID, byval clip_x_origin as long, byval clip_y_origin as long, byval region as XserverRegion)
declare sub XFixesSetCursorName(byval dpy as Display ptr, byval cursor as Cursor, byval name as const zstring ptr)
declare function XFixesGetCursorName(byval dpy as Display ptr, byval cursor as Cursor, byval atom as XAtom ptr) as const zstring ptr
declare sub XFixesChangeCursor(byval dpy as Display ptr, byval source as Cursor, byval destination as Cursor)
declare sub XFixesChangeCursorByName(byval dpy as Display ptr, byval source as Cursor, byval name as const zstring ptr)
declare sub XFixesExpandRegion(byval dpy as Display ptr, byval dst as XserverRegion, byval src as XserverRegion, byval left as ulong, byval right as ulong, byval top as ulong, byval bottom as ulong)
declare sub XFixesHideCursor(byval dpy as Display ptr, byval win as Window)
declare sub XFixesShowCursor(byval dpy as Display ptr, byval win as Window)
type PointerBarrier as XID
declare function XFixesCreatePointerBarrier(byval dpy as Display ptr, byval w as Window, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long, byval directions as long, byval num_devices as long, byval devices as long ptr) as PointerBarrier
declare sub XFixesDestroyPointerBarrier(byval dpy as Display ptr, byval b as PointerBarrier)

end extern
