''
''
'' Xregion -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xregion_bi__
#define __Xregion_bi__

type Box
	x1 as short
	x2 as short
	y1 as short
	y2 as short
end type

type BOX as Box
type BoxRec as Box
type BoxPtr as Box ptr

type RECTANGLE
	x as short
	y as short
	width as short
	height as short
end type

type RectangleRec as RECTANGLE
type RectanglePtr as RECTANGLE ptr

#define TRUE 1
#define FALSE 0
#define MAXSHORT 32767
#define MINSHORT -32767

type _XRegion
	size as integer
	numRects as integer
	rects as BOX ptr
	extents as BOX
end type

type REGION as _XRegion

#define NUMPTSTOBUFFER 200

type _POINTBLOCK
	pts(0 to 200-1) as XPoint
	next as _POINTBLOCK ptr
end type

type POINTBLOCK as _POINTBLOCK

#endif
