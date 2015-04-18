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

#include once "X11/extensions/mitmiscconst.bi"

#define _MITMISCPROTO_H_
const X_MITSetBugMode = 0
const X_MITGetBugMode = 1

type _SetBugMode
	reqType as CARD8
	mitReqType as CARD8
	length as CARD16
	onOff as XBOOL
	pad0 as UBYTE
	pad1 as CARD16
end type

type xMITSetBugModeReq as _SetBugMode
const sz_xMITSetBugModeReq = 8

type _GetBugMode
	reqType as CARD8
	mitReqType as CARD8
	length as CARD16
end type

type xMITGetBugModeReq as _GetBugMode
const sz_xMITGetBugModeReq = 4

type xMITGetBugModeReply
	as UBYTE type
	onOff as XBOOL
	sequenceNumber as CARD16
	length as CARD32
	pad0 as CARD32
	pad1 as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
end type

const sz_xMITGetBugModeReply = 32
