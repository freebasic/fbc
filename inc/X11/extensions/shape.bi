''
''
'' shape -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __shape_bi__
#define __shape_bi__

#define X_ShapeQueryVersion 0
#define X_ShapeRectangles 1
#define X_ShapeMask 2
#define X_ShapeCombine 3
#define X_ShapeOffset 4
#define X_ShapeQueryExtents 5
#define X_ShapeSelectInput 6
#define X_ShapeInputSelected 7
#define X_ShapeGetRectangles 8
#define ShapeSet 0
#define ShapeUnion 1
#define ShapeIntersect 2
#define ShapeSubtract 3
#define ShapeInvert 4
#define ShapeBounding 0
#define ShapeClip 1
#define ShapeInput 2
#define ShapeNotifyMask (1L shl 0)
#define ShapeNotify 0
#define ShapeNumberEvents (0+1)

type XShapeEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	kind as integer
	x as integer
	y as integer
	width as uinteger
	height as uinteger
	time as Time
	shaped as Bool
end type

declare function XShapeQueryVersion cdecl alias "XShapeQueryVersion" (byval as Display ptr, byval as integer ptr, byval as integer ptr) as Status
declare sub XShapeCombineRegion cdecl alias "XShapeCombineRegion" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as integer, byval as Region, byval as integer)
declare sub XShapeCombineRectangles cdecl alias "XShapeCombineRectangles" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as integer, byval as XRectangle ptr, byval as integer, byval as integer, byval as integer)
declare sub XShapeCombineMask cdecl alias "XShapeCombineMask" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as integer, byval as Pixmap, byval as integer)
declare sub XShapeCombineShape cdecl alias "XShapeCombineShape" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as integer, byval as Window, byval as integer, byval as integer)
declare sub XShapeOffsetShape cdecl alias "XShapeOffsetShape" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as integer)
declare function XShapeQueryExtents cdecl alias "XShapeQueryExtents" (byval as Display ptr, byval as Window, byval as Bool ptr, byval as integer ptr, byval as integer ptr, byval as uinteger ptr, byval as uinteger ptr, byval as Bool ptr, byval as integer ptr, byval as integer ptr, byval as uinteger ptr, byval as uinteger ptr) as Status
declare sub XShapeSelectInput cdecl alias "XShapeSelectInput" (byval as Display ptr, byval as Window, byval as uinteger)
declare function XShapeInputSelected cdecl alias "XShapeInputSelected" (byval as Display ptr, byval as Window) as uinteger
declare function XShapeGetRectangles cdecl alias "XShapeGetRectangles" (byval as Display ptr, byval as Window, byval as integer, byval as integer ptr, byval as integer ptr) as XRectangle ptr

#endif
