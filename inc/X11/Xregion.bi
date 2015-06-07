'' FreeBASIC binding for libX11-1.6.3
''
'' based on the C header files:
''   **********************************************************************
''
''   Copyright 1987, 1998  The Open Group
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
''   Copyright 1987 by Digital Equipment Corporation, Maynard, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name of Digital not be
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
''   ***********************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"

#define _X11_XREGION_H_

type BOX
	x1 as short
	x2 as short
	y1 as short
	y2 as short
end type

type BoxRec as BOX
type BoxPtr as BOX ptr

type RECTANGLE
	x as short
	y as short
	width as short
	height as short
end type

type RectangleRec as RECTANGLE
type RectanglePtr as RECTANGLE ptr

type _XRegion
	size as clong
	numRects as clong
	rects as BOX ptr
	extents as BOX
end type

#define EXTENTCHECK(r1, r2) (((((r1)->x2 > (r2)->x1) andalso ((r1)->x1 < (r2)->x2)) andalso ((r1)->y2 > (r2)->y1)) andalso ((r1)->y1 < (r2)->y2))
#macro EXTENTS(r, idRect)
	scope
		if (r)->x1 < (idRect)->extents.x1 then
			(idRect)->extents.x1 = (r)->x1
		end if
		if (r)->y1 < (idRect)->extents.y1 then
			(idRect)->extents.y1 = (r)->y1
		end if
		if (r)->x2 > (idRect)->extents.x2 then
			(idRect)->extents.x2 = (r)->x2
		end if
		if (r)->y2 > (idRect)->extents.y2 then
			(idRect)->extents.y2 = (r)->y2
		end if
	end scope
#endmacro
#macro MEMCHECK(reg, rect, firstrect)
	if (reg)->numRects >= ((reg)->size - 1) then
		dim tmpRect as BoxPtr = Xrealloc((firstrect), (2 * sizeof(BOX)) * (reg)->size)
		if tmpRect = NULL then
			return 0
		end if
		(firstrect) = tmpRect
		(reg)->size *= 2
		(rect) = @(firstrect)[(reg)->numRects]
	end if
#endmacro
#define CHECK_PREVIOUS(Reg, R, Rx1, Ry1, Rx2, Ry2) (((((((Reg)->numRects > 0) andalso ((R - 1)->y1 = (Ry1))) andalso ((R - 1)->y2 = (Ry2))) andalso ((R - 1)->x1 <= (Rx1))) andalso ((R - 1)->x2 >= (Rx2))) = 0)
#macro ADDRECT(reg, r, rx1, ry1, rx2, ry2)
	if (((rx1) < (rx2)) andalso ((ry1) < (ry2))) andalso CHECK_PREVIOUS((reg), (r), (rx1), (ry1), (rx2), (ry2)) then
		(r)->x1 = (rx1)
		(r)->y1 = (ry1)
		(r)->x2 = (rx2)
		(r)->y2 = (ry2)
		EXTENTS((r), (reg))
		(reg)->numRects += 1
		(r) += 1
	end if
#endmacro
#macro ADDRECTNOX(reg, r, rx1, ry1, rx2, ry2)
	if ((rx1 < rx2) andalso (ry1 < ry2)) andalso CHECK_PREVIOUS((reg), (r), (rx1), (ry1), (rx2), (ry2)) then
		(r)->x1 = (rx1)
		(r)->y1 = (ry1)
		(r)->x2 = (rx2)
		(r)->y2 = (ry2)
		(reg)->numRects += 1
		(r) += 1
	end if
#endmacro
#define EMPTY_REGION(pReg) scope : pReg->numRects = 0 : end scope
#define REGION_NOT_EMPTY(pReg) pReg->numRects
#define INBOX(r, x, y) (((((r).x2 > x) andalso ((r).x1 <= x)) andalso ((r).y2 > y)) andalso ((r).y1 <= y))
const NUMPTSTOBUFFER = 200

type _POINTBLOCK
	pts(0 to 199) as XPoint
	next as _POINTBLOCK ptr
end type

type POINTBLOCK as _POINTBLOCK
