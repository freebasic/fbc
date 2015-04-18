'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''   Copyright © 2007-2008 Peter Hutterer
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
''   Authors: Peter Hutterer, University of South Australia, NICTA
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xproto.bi"
#include once "X11/X.bi"
#include once "X11/extensions/ge.bi"

#define _GEPROTO_H_
const X_GEGetExtensionVersion = 1

type xGEReq
	reqType as CARD8
	ReqType_ as CARD8
	length as CARD16
end type

type xGEQueryVersionReq
	reqType as CARD8
	ReqType_ as CARD8
	length as CARD16
	majorVersion as CARD16
	minorVersion as CARD16
end type

const sz_xGEQueryVersionReq = 8

type xGEQueryVersionReply
	repType as CARD8
	RepType_ as CARD8
	sequenceNumber as CARD16
	length as CARD32
	majorVersion as CARD16
	minorVersion as CARD16
	pad00 as CARD32
	pad01 as CARD32
	pad02 as CARD32
	pad03 as CARD32
	pad04 as CARD32
end type

const sz_xGEQueryVersionReply = 32
