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
		if (r)->x1 < (idRect)->extents.x1 then (idRect)->extents.x1 = (r)->x1
		if (r)->y1 < (idRect)->extents.y1 then (idRect)->extents.y1 = (r)->y1
		if (r)->x2 > (idRect)->extents.x2 then (idRect)->extents.x2 = (r)->x2
		if (r)->y2 > (idRect)->extents.y2 then (idRect)->extents.y2 = (r)->y2
	end scope
#endmacro
#define CHECK_PREVIOUS(Reg, R, Rx1, Ry1, Rx2, Ry2) (((((((Reg)->numRects > 0) andalso ((R - 1)->y1 = (Ry1))) andalso ((R - 1)->y2 = (Ry2))) andalso ((R - 1)->x1 <= (Rx1))) andalso ((R - 1)->x2 >= (Rx2))) = 0)
#macro ADDRECT(reg, r, rx1, ry1, rx2, ry2)
	scope
		if ((rx1) < (rx2)) andalso ((ry1) < (ry2)) andalso CHECK_PREVIOUS((reg), (r), (rx1), (ry1), (rx2), (ry2)) then
			(r)->x1 = (rx1)
			(r)->y1 = (ry1)
			(r)->x2 = (rx2)
			(r)->y2 = (ry2)
			EXTENTS((r), (reg))
			(reg)->numRects += 1
			(r) += 1
		end if
	end scope
#endmacro
#macro ADDRECTNOX(reg, r, rx1, ry1, rx2, ry2)
	scope
		if (rx1 < rx2) andalso (ry1 < ry2) andalso CHECK_PREVIOUS((reg), (r), (rx1), (ry1), (rx2), (ry2)) then
			(r)->x1 = (rx1)
			(r)->y1 = (ry1)
			(r)->x2 = (rx2)
			(r)->y2 = (ry2)
			(reg)->numRects += 1
			(r) += 1
		end if
	end scope
#endmacro
#macro EMPTY_REGION(pReg)
	scope
		pReg->numRects = 0
	end scope
#endmacro
#define REGION_NOT_EMPTY(pReg) pReg->numRects
#define INBOX(r, x, y) (((((r).x2 > x) andalso ((r).x1 <= x)) andalso ((r).y2 > y)) andalso ((r).y1 <= y))
const NUMPTSTOBUFFER = 200

type _POINTBLOCK
	pts(0 to 199) as XPoint
	next as _POINTBLOCK ptr
end type

type POINTBLOCK as _POINTBLOCK
