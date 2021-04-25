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

#define CHIPMUNK_UNSAFE_H
declare sub cpCircleShapeSetRadius(byval shape as cpShape ptr, byval radius as cpFloat)
declare sub cpCircleShapeSetOffset(byval shape as cpShape ptr, byval offset as cpVect)
declare sub cpSegmentShapeSetEndpoints(byval shape as cpShape ptr, byval a as cpVect, byval b as cpVect)
declare sub cpSegmentShapeSetRadius(byval shape as cpShape ptr, byval radius as cpFloat)
declare sub cpPolyShapeSetVerts(byval shape as cpShape ptr, byval count as long, byval verts as cpVect ptr, byval transform as cpTransform)
declare sub cpPolyShapeSetVertsRaw(byval shape as cpShape ptr, byval count as long, byval verts as cpVect ptr)
declare sub cpPolyShapeSetRadius(byval shape as cpShape ptr, byval radius as cpFloat)

end extern
