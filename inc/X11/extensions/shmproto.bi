'' FreeBASIC binding for xextproto-7.3.0
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

#include once "X11/extensions/shm.bi"

'' The following symbols have been renamed:
''     typedef xShmCompletionEvent => xShmCompletionEvent_

#define _SHMPROTO_H_
const X_ShmQueryVersion = 0
const X_ShmAttach = 1
const X_ShmDetach = 2
const X_ShmPutImage = 3
const X_ShmGetImage = 4
const X_ShmCreatePixmap = 5
const X_ShmAttachFd = 6
const X_ShmCreateSegment = 7

type _ShmQueryVersion
	reqType as CARD8
	shmReqType as CARD8
	length as CARD16
end type

type xShmQueryVersionReq as _ShmQueryVersion
const sz_xShmQueryVersionReq = 4

type xShmQueryVersionReply
	as UBYTE type
	sharedPixmaps as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD16
	minorVersion as CARD16
	uid as CARD16
	gid as CARD16
	pixmapFormat as CARD8
	pad0 as CARD8
	pad1 as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
end type

const sz_xShmQueryVersionReply = 32

type _ShmAttach
	reqType as CARD8
	shmReqType as CARD8
	length as CARD16
	shmseg as CARD32
	shmid as CARD32
	readOnly as XBOOL
	pad0 as UBYTE
	pad1 as CARD16
end type

type xShmAttachReq as _ShmAttach
const sz_xShmAttachReq = 16

type _ShmDetach
	reqType as CARD8
	shmReqType as CARD8
	length as CARD16
	shmseg as CARD32
end type

type xShmDetachReq as _ShmDetach
const sz_xShmDetachReq = 8

type _ShmPutImage
	reqType as CARD8
	shmReqType as CARD8
	length as CARD16
	drawable as CARD32
	gc as CARD32
	totalWidth as CARD16
	totalHeight as CARD16
	srcX as CARD16
	srcY as CARD16
	srcWidth as CARD16
	srcHeight as CARD16
	dstX as INT16
	dstY as INT16
	depth as CARD8
	format as CARD8
	sendEvent as CARD8
	bpad as CARD8
	shmseg as CARD32
	offset as CARD32
end type

type xShmPutImageReq as _ShmPutImage
const sz_xShmPutImageReq = 40

type _ShmGetImage
	reqType as CARD8
	shmReqType as CARD8
	length as CARD16
	drawable as CARD32
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	planeMask as CARD32
	format as CARD8
	pad0 as CARD8
	pad1 as CARD8
	pad2 as CARD8
	shmseg as CARD32
	offset as CARD32
end type

type xShmGetImageReq as _ShmGetImage
const sz_xShmGetImageReq = 32

type _ShmGetImageReply
	as UBYTE type
	depth as CARD8
	sequenceNumber as CARD16
	length as CARD32
	visual as CARD32
	size as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
end type

type xShmGetImageReply as _ShmGetImageReply
const sz_xShmGetImageReply = 32

type _ShmCreatePixmap
	reqType as CARD8
	shmReqType as CARD8
	length as CARD16
	pid as CARD32
	drawable as CARD32
	width as CARD16
	height as CARD16
	depth as CARD8
	pad0 as CARD8
	pad1 as CARD8
	pad2 as CARD8
	shmseg as CARD32
	offset as CARD32
end type

type xShmCreatePixmapReq as _ShmCreatePixmap
const sz_xShmCreatePixmapReq = 28

type _ShmCompletion
	as UBYTE type
	bpad0 as UBYTE
	sequenceNumber as CARD16
	drawable as CARD32
	minorEvent as CARD16
	majorEvent as UBYTE
	bpad1 as UBYTE
	shmseg as CARD32
	offset as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
end type

type xShmCompletionEvent_ as _ShmCompletion
const sz_xShmCompletionEvent = 32

type _ShmAttachFd
	reqType as CARD8
	shmReqType as CARD8
	length as CARD16
	shmseg as CARD32
	readOnly as XBOOL
	pad0 as UBYTE
	pad1 as CARD16
end type

type xShmAttachFdReq as _ShmAttachFd
const sz_xShmAttachFdReq = 12

type _ShmCreateSegment
	reqType as CARD8
	shmReqType as CARD8
	length as CARD16
	shmseg as CARD32
	size as CARD32
	readOnly as XBOOL
	pad0 as UBYTE
	pad1 as CARD16
end type

type xShmCreateSegmentReq as _ShmCreateSegment
const sz_xShmCreateSegmentReq = 16

type xShmCreateSegmentReply
	as CARD8 type
	nfd as CARD8
	sequenceNumber as CARD16
	length as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
	pad7 as CARD32
end type

const sz_xShmCreateSegmentReply = 32
