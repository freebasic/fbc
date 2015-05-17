'' FreeBASIC binding for libXmu-1.1.2
''
'' based on the C header files:
''
''   Copyright 1988, 1998  The Open Group
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

#include once "X11/Xfuncproto.bi"
#include once "X11/Intrinsic.bi"
#include once "X11/Xmu/Atoms.bi"
#include once "X11/Xmu/CharSet.bi"
#include once "X11/Xmu/Converters.bi"
#include once "X11/Xmu/Drawing.bi"
#include once "X11/Xmu/Error.bi"
#include once "X11/Xmu/StdSel.bi"

extern "C"

#define _XMU_H_

type _XmuSegment
	x1 as long
	x2 as long
	next as _XmuSegment ptr
end type

type XmuSegment as _XmuSegment

type _XmuScanline
	y as long
	segment as XmuSegment ptr
	next as _XmuScanline ptr
end type

type XmuScanline as _XmuScanline

type _XmuArea
	scanline as XmuScanline ptr
end type

type XmuArea as _XmuArea
#define XmuCreateArea() XmuNewArea(0, 0, 0, 0)
#define XmuAreaOr(dst, src) XmuAreaOrXor((dst), (src), True)
#define XmuAreaXor(dst, src) XmuAreaOrXor((dst), (src), False)
#macro XmuDestroyArea(a)
	scope
		XmuDestroyScanlineList((a)->scanline)
		XtFree(cptr(any ptr, (a)))
	end scope
#endmacro
#macro FreeArea(a)
	scope
		XmuDestroyScanlineList((a)->scanline)
		a->scanline = cptr(Scanline ptr, 0)
	end scope
#endmacro
#define XmuValidSegment(s) ((s)->x1 < (s)->x2)
#define XmuSegmentEqu(s1, s2) (((s1)->x1 = (s2)->x1) andalso ((s1)->x2 = (s2)->x2))
#define XmuDestroySegment(s) XtFree(cptr(zstring ptr, (s)))
#macro XmuDestroyScanline(s)
	scope
		XmuDestroySegmentList((s)->segment)
		XtFree(cptr(any ptr, (s)))
	end scope
#endmacro

declare function XmuNewArea(byval as long, byval as long, byval as long, byval as long) as XmuArea ptr
declare function XmuAreaDup(byval as XmuArea ptr) as XmuArea ptr
declare function XmuAreaCopy(byval as XmuArea ptr, byval as XmuArea ptr) as XmuArea ptr
declare function XmuAreaNot(byval as XmuArea ptr, byval as long, byval as long, byval as long, byval as long) as XmuArea ptr
declare function XmuAreaOrXor(byval as XmuArea ptr, byval as XmuArea ptr, byval as long) as XmuArea ptr
declare function XmuAreaAnd(byval as XmuArea ptr, byval as XmuArea ptr) as XmuArea ptr
declare function XmuValidArea(byval as XmuArea ptr) as long
declare function XmuValidScanline(byval as XmuScanline ptr) as long
declare function XmuScanlineEqu(byval as XmuScanline ptr, byval as XmuScanline ptr) as long
declare function XmuNewSegment(byval as long, byval as long) as XmuSegment ptr
declare sub XmuDestroySegmentList(byval as XmuSegment ptr)
declare function XmuScanlineCopy(byval as XmuScanline ptr, byval as XmuScanline ptr) as XmuScanline ptr
declare function XmuAppendSegment(byval as XmuSegment ptr, byval as XmuSegment ptr) as long
declare function XmuOptimizeScanline(byval as XmuScanline ptr) as XmuScanline ptr
declare function XmuScanlineNot(byval scanline as XmuScanline ptr, byval as long, byval as long) as XmuScanline ptr
declare function XmuScanlineOr(byval as XmuScanline ptr, byval as XmuScanline ptr) as XmuScanline ptr
declare function XmuScanlineAnd(byval as XmuScanline ptr, byval as XmuScanline ptr) as XmuScanline ptr
declare function XmuScanlineXor(byval as XmuScanline ptr, byval as XmuScanline ptr) as XmuScanline ptr
declare function XmuNewScanline(byval as long, byval as long, byval as long) as XmuScanline ptr
declare sub XmuDestroyScanlineList(byval as XmuScanline ptr)
declare function XmuOptimizeArea(byval area as XmuArea ptr) as XmuArea ptr
declare function XmuScanlineOrSegment(byval as XmuScanline ptr, byval as XmuSegment ptr) as XmuScanline ptr
declare function XmuScanlineAndSegment(byval as XmuScanline ptr, byval as XmuSegment ptr) as XmuScanline ptr
declare function XmuScanlineXorSegment(byval as XmuScanline ptr, byval as XmuSegment ptr) as XmuScanline ptr
declare function XmuSnprintf(byval str as zstring ptr, byval size as long, byval fmt as const zstring ptr, ...) as long

end extern
