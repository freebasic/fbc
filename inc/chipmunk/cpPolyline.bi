'' FreeBASIC binding for Chipmunk-7.0.3
''
'' based on the C header files:
''   Copyright (c) 2007-2015 Scott Lembcke and Howling Moon Software
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is
''   furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
''   SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2021 FreeBASIC development team

#pragma once

extern "C"

type cpPolyline
	count as long
	capacity as long
	''verts(0 to ...) as cpVect
end type

declare sub cpPolylineFree(byval line as cpPolyline ptr)
declare function cpPolylineIsClosed(byval line as cpPolyline ptr) as cpBool
declare function cpPolylineSimplifyCurves(byval line as cpPolyline ptr, byval tol as cpFloat) as cpPolyline ptr
declare function cpPolylineSimplifyVertexes(byval line as cpPolyline ptr, byval tol as cpFloat) as cpPolyline ptr
declare function cpPolylineToConvexHull(byval line as cpPolyline ptr, byval tol as cpFloat) as cpPolyline ptr

type cpPolylineSet
	count as long
	capacity as long
	lines as cpPolyline ptr ptr
end type

declare function cpPolylineSetAlloc() as cpPolylineSet ptr
declare function cpPolylineSetInit(byval set as cpPolylineSet ptr) as cpPolylineSet ptr
declare function cpPolylineSetNew() as cpPolylineSet ptr
declare sub cpPolylineSetDestroy(byval set as cpPolylineSet ptr, byval freePolylines as cpBool)
declare sub cpPolylineSetFree(byval set as cpPolylineSet ptr, byval freePolylines as cpBool)
declare sub cpPolylineSetCollectSegment(byval v0 as cpVect, byval v1 as cpVect, byval lines as cpPolylineSet ptr)
declare function cpPolylineConvexDecomposition(byval line as cpPolyline ptr, byval tol as cpFloat) as cpPolylineSet ptr
declare function cpPolylineConvexDecomposition_BETA alias "cpPolylineConvexDecomposition"(byval line as cpPolyline ptr, byval tol as cpFloat) as cpPolylineSet ptr

end extern
