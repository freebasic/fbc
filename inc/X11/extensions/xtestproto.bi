'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''
''   Copyright 1992, 1998  The Open Group
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
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/extensions/xtestconst.bi"

#define _XTESTPROTO_H_
const X_XTestGetVersion = 0
const X_XTestCompareCursor = 1
const X_XTestFakeInput = 2
const X_XTestGrabControl = 3

type xXTestGetVersionReq
	reqType as CARD8
	xtReqType as CARD8
	length as CARD16
	majorVersion as CARD8
	pad as CARD8
	minorVersion as CARD16
end type

const sz_xXTestGetVersionReq = 8

type xXTestGetVersionReply
	as UBYTE type
	majorVersion as CARD8
	sequenceNumber as CARD16
	length as CARD32
	minorVersion as CARD16
	pad0 as CARD16
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXTestGetVersionReply = 32

type xXTestCompareCursorReq
	reqType as CARD8
	xtReqType as CARD8
	length as CARD16
	window as CARD32
	cursor as CARD32
end type

const sz_xXTestCompareCursorReq = 12

type xXTestCompareCursorReply
	as UBYTE type
	same as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xXTestCompareCursorReply = 32

type xXTestFakeInputReq
	reqType as CARD8
	xtReqType as CARD8
	length as CARD16
	as UBYTE type
	detail as UBYTE
	pad0 as CARD16
	time as CARD32
	root as CARD32
	pad1 as CARD32
	pad2 as CARD32
	rootX as INT16
	rootY as INT16
	pad3 as CARD32
	pad4 as CARD16
	pad5 as CARD8
	deviceid as CARD8
end type

const sz_xXTestFakeInputReq = 36

type xXTestGrabControlReq
	reqType as CARD8
	xtReqType as CARD8
	length as CARD16
	impervious as XBOOL
	pad0 as CARD8
	pad1 as CARD8
	pad2 as CARD8
end type

const sz_xXTestGrabControlReq = 8
