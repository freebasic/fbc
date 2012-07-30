''
''
'' cpPolyShape -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cpPolyShape_bi__
#define __cpPolyShape_bi__

type cpPolyShapeAxis
	n as cpVect
	d as cpFloat
end type

type cpPolyShape
	shape as cpShape
	numVerts as integer
	verts as cpVect ptr
	axes as cpPolyShapeAxis ptr
	tVerts as cpVect ptr
	tAxes as cpPolyShapeAxis ptr
end type


declare function cpPolyShapeAlloc cdecl alias "cpPolyShapeAlloc" () as cpPolyShape ptr
declare function cpPolyShapeInit cdecl alias "cpPolyShapeInit" (byval poly as cpPolyShape ptr, byval body as cpBody ptr, byval numVerts as integer, byval verts as cpVect ptr, byval offset as cpVect) as cpPolyShape ptr
declare function cpPolyShapeNew cdecl alias "cpPolyShapeNew" (byval body as cpBody ptr, byval numVerts as integer, byval verts as cpVect ptr, byval offset as cpVect) as cpShape ptr

#endif
