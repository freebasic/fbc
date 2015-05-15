'' FreeBASIC binding for glu-9.0.0
''
'' based on the C header files:
''   SGI FREE SOFTWARE LICENSE B (Version 2.0, Sept. 18, 2008)
''   Copyright (C) 1991-2000 Silicon Graphics, Inc. All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice including the dates of first publication and
''   either this permission notice or a reference to
''   http://oss.sgi.com/projects/FreeB/
''   shall be included in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
''   SILICON GRAPHICS, INC. BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
''   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
''   OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
''   SOFTWARE.
''
''   Except as contained in this notice, the name of Silicon Graphics, Inc.
''   shall not be used in advertising or otherwise to promote the sale, use or
''   other dealings in this Software without prior written authorization from
''   Silicon Graphics, Inc.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef __FB_WIN32__
	#inclib "glu32"
#elseif defined(__FB_DOS__)
	#inclib "glu"
#else
	#inclib "GLU"
#endif

#include once "GL/mesa/gl.bi"

#ifdef __FB_WIN32__
	extern "Windows"
#else
	extern "C"
#endif

#define __glu_h__
const GLU_EXT_object_space_tess = 1
const GLU_EXT_nurbs_tessellator = 1
const GLU_FALSE = 0
const GLU_TRUE = 1
const GLU_VERSION_1_1 = 1
const GLU_VERSION_1_2 = 1
const GLU_VERSION_1_3 = 1
const GLU_VERSION = 100800
const GLU_EXTENSIONS = 100801
const GLU_INVALID_ENUM = 100900
const GLU_INVALID_VALUE = 100901
const GLU_OUT_OF_MEMORY = 100902
const GLU_INCOMPATIBLE_GL_VERSION = 100903
const GLU_INVALID_OPERATION = 100904
const GLU_OUTLINE_POLYGON = 100240
const GLU_OUTLINE_PATCH = 100241
const GLU_NURBS_ERROR = 100103
const GLU_ERROR = 100103
const GLU_NURBS_BEGIN = 100164
const GLU_NURBS_BEGIN_EXT = 100164
const GLU_NURBS_VERTEX = 100165
const GLU_NURBS_VERTEX_EXT = 100165
const GLU_NURBS_NORMAL = 100166
const GLU_NURBS_NORMAL_EXT = 100166
const GLU_NURBS_COLOR = 100167
const GLU_NURBS_COLOR_EXT = 100167
const GLU_NURBS_TEXTURE_COORD = 100168
const GLU_NURBS_TEX_COORD_EXT = 100168
const GLU_NURBS_END = 100169
const GLU_NURBS_END_EXT = 100169
const GLU_NURBS_BEGIN_DATA = 100170
const GLU_NURBS_BEGIN_DATA_EXT = 100170
const GLU_NURBS_VERTEX_DATA = 100171
const GLU_NURBS_VERTEX_DATA_EXT = 100171
const GLU_NURBS_NORMAL_DATA = 100172
const GLU_NURBS_NORMAL_DATA_EXT = 100172
const GLU_NURBS_COLOR_DATA = 100173
const GLU_NURBS_COLOR_DATA_EXT = 100173
const GLU_NURBS_TEXTURE_COORD_DATA = 100174
const GLU_NURBS_TEX_COORD_DATA_EXT = 100174
const GLU_NURBS_END_DATA = 100175
const GLU_NURBS_END_DATA_EXT = 100175
const GLU_NURBS_ERROR1 = 100251
const GLU_NURBS_ERROR2 = 100252
const GLU_NURBS_ERROR3 = 100253
const GLU_NURBS_ERROR4 = 100254
const GLU_NURBS_ERROR5 = 100255
const GLU_NURBS_ERROR6 = 100256
const GLU_NURBS_ERROR7 = 100257
const GLU_NURBS_ERROR8 = 100258
const GLU_NURBS_ERROR9 = 100259
const GLU_NURBS_ERROR10 = 100260
const GLU_NURBS_ERROR11 = 100261
const GLU_NURBS_ERROR12 = 100262
const GLU_NURBS_ERROR13 = 100263
const GLU_NURBS_ERROR14 = 100264
const GLU_NURBS_ERROR15 = 100265
const GLU_NURBS_ERROR16 = 100266
const GLU_NURBS_ERROR17 = 100267
const GLU_NURBS_ERROR18 = 100268
const GLU_NURBS_ERROR19 = 100269
const GLU_NURBS_ERROR20 = 100270
const GLU_NURBS_ERROR21 = 100271
const GLU_NURBS_ERROR22 = 100272
const GLU_NURBS_ERROR23 = 100273
const GLU_NURBS_ERROR24 = 100274
const GLU_NURBS_ERROR25 = 100275
const GLU_NURBS_ERROR26 = 100276
const GLU_NURBS_ERROR27 = 100277
const GLU_NURBS_ERROR28 = 100278
const GLU_NURBS_ERROR29 = 100279
const GLU_NURBS_ERROR30 = 100280
const GLU_NURBS_ERROR31 = 100281
const GLU_NURBS_ERROR32 = 100282
const GLU_NURBS_ERROR33 = 100283
const GLU_NURBS_ERROR34 = 100284
const GLU_NURBS_ERROR35 = 100285
const GLU_NURBS_ERROR36 = 100286
const GLU_NURBS_ERROR37 = 100287
const GLU_AUTO_LOAD_MATRIX = 100200
const GLU_CULLING = 100201
const GLU_SAMPLING_TOLERANCE = 100203
const GLU_DISPLAY_MODE = 100204
const GLU_PARAMETRIC_TOLERANCE = 100202
const GLU_SAMPLING_METHOD = 100205
const GLU_U_STEP = 100206
const GLU_V_STEP = 100207
const GLU_NURBS_MODE = 100160
const GLU_NURBS_MODE_EXT = 100160
const GLU_NURBS_TESSELLATOR = 100161
const GLU_NURBS_TESSELLATOR_EXT = 100161
const GLU_NURBS_RENDERER = 100162
const GLU_NURBS_RENDERER_EXT = 100162
const GLU_OBJECT_PARAMETRIC_ERROR = 100208
const GLU_OBJECT_PARAMETRIC_ERROR_EXT = 100208
const GLU_OBJECT_PATH_LENGTH = 100209
const GLU_OBJECT_PATH_LENGTH_EXT = 100209
const GLU_PATH_LENGTH = 100215
const GLU_PARAMETRIC_ERROR = 100216
const GLU_DOMAIN_DISTANCE = 100217
const GLU_MAP1_TRIM_2 = 100210
const GLU_MAP1_TRIM_3 = 100211
const GLU_POINT = 100010
const GLU_LINE = 100011
const GLU_FILL = 100012
const GLU_SILHOUETTE = 100013
const GLU_SMOOTH = 100000
const GLU_FLAT = 100001
const GLU_NONE = 100002
const GLU_OUTSIDE = 100020
const GLU_INSIDE = 100021
const GLU_TESS_BEGIN = 100100
const GLU_BEGIN = 100100
const GLU_TESS_VERTEX = 100101
const GLU_VERTEX = 100101
const GLU_TESS_END = 100102
const GLU_END = 100102
const GLU_TESS_ERROR = 100103
const GLU_TESS_EDGE_FLAG = 100104
const GLU_EDGE_FLAG = 100104
const GLU_TESS_COMBINE = 100105
const GLU_TESS_BEGIN_DATA = 100106
const GLU_TESS_VERTEX_DATA = 100107
const GLU_TESS_END_DATA = 100108
const GLU_TESS_ERROR_DATA = 100109
const GLU_TESS_EDGE_FLAG_DATA = 100110
const GLU_TESS_COMBINE_DATA = 100111
const GLU_CW = 100120
const GLU_CCW = 100121
const GLU_INTERIOR = 100122
const GLU_EXTERIOR = 100123
const GLU_UNKNOWN = 100124
const GLU_TESS_WINDING_RULE = 100140
const GLU_TESS_BOUNDARY_ONLY = 100141
const GLU_TESS_TOLERANCE = 100142
const GLU_TESS_ERROR1 = 100151
const GLU_TESS_ERROR2 = 100152
const GLU_TESS_ERROR3 = 100153
const GLU_TESS_ERROR4 = 100154
const GLU_TESS_ERROR5 = 100155
const GLU_TESS_ERROR6 = 100156
const GLU_TESS_ERROR7 = 100157
const GLU_TESS_ERROR8 = 100158
const GLU_TESS_MISSING_BEGIN_POLYGON = 100151
const GLU_TESS_MISSING_BEGIN_CONTOUR = 100152
const GLU_TESS_MISSING_END_POLYGON = 100153
const GLU_TESS_MISSING_END_CONTOUR = 100154
const GLU_TESS_COORD_TOO_LARGE = 100155
const GLU_TESS_NEED_COMBINE_CALLBACK = 100156
const GLU_TESS_WINDING_ODD = 100130
const GLU_TESS_WINDING_NONZERO = 100131
const GLU_TESS_WINDING_POSITIVE = 100132
const GLU_TESS_WINDING_NEGATIVE = 100133
const GLU_TESS_WINDING_ABS_GEQ_TWO = 100134

type GLUnurbs as GLUnurbs_
type GLUnurbsObj as GLUnurbs
type GLUquadric as GLUquadric_
type GLUquadricObj as GLUquadric
type GLUtesselator as GLUtesselator_
type GLUtesselatorObj as GLUtesselator
type GLUtriangulatorObj as GLUtesselator
const GLU_TESS_MAX_COORD = 1.0e150
type _GLUfuncptr as sub()

declare sub gluBeginCurve(byval nurb as GLUnurbs ptr)
declare sub gluBeginPolygon(byval tess as GLUtesselator ptr)
declare sub gluBeginSurface(byval nurb as GLUnurbs ptr)
declare sub gluBeginTrim(byval nurb as GLUnurbs ptr)
declare function gluBuild1DMipmapLevels(byval target as GLenum, byval internalFormat as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval level as GLint, byval base as GLint, byval max as GLint, byval data as const any ptr) as GLint
declare function gluBuild1DMipmaps(byval target as GLenum, byval internalFormat as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval data as const any ptr) as GLint
declare function gluBuild2DMipmapLevels(byval target as GLenum, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval level as GLint, byval base as GLint, byval max as GLint, byval data as const any ptr) as GLint
declare function gluBuild2DMipmaps(byval target as GLenum, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval data as const any ptr) as GLint
declare function gluBuild3DMipmapLevels(byval target as GLenum, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval level as GLint, byval base as GLint, byval max as GLint, byval data as const any ptr) as GLint
declare function gluBuild3DMipmaps(byval target as GLenum, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval data as const any ptr) as GLint
declare function gluCheckExtension(byval extName as const zstring ptr, byval extString as const zstring ptr) as GLboolean
declare sub gluCylinder(byval quad as GLUquadric ptr, byval base as GLdouble, byval top as GLdouble, byval height as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub gluDeleteNurbsRenderer(byval nurb as GLUnurbs ptr)
declare sub gluDeleteQuadric(byval quad as GLUquadric ptr)
declare sub gluDeleteTess(byval tess as GLUtesselator ptr)
declare sub gluDisk(byval quad as GLUquadric ptr, byval inner as GLdouble, byval outer as GLdouble, byval slices as GLint, byval loops as GLint)
declare sub gluEndCurve(byval nurb as GLUnurbs ptr)
declare sub gluEndPolygon(byval tess as GLUtesselator ptr)
declare sub gluEndSurface(byval nurb as GLUnurbs ptr)
declare sub gluEndTrim(byval nurb as GLUnurbs ptr)
declare function gluErrorString(byval error as GLenum) as const zstring ptr
declare sub gluGetNurbsProperty(byval nurb as GLUnurbs ptr, byval property as GLenum, byval data as GLfloat ptr)
declare function gluGetString(byval name as GLenum) as const zstring ptr
declare sub gluGetTessProperty(byval tess as GLUtesselator ptr, byval which as GLenum, byval data as GLdouble ptr)
declare sub gluLoadSamplingMatrices(byval nurb as GLUnurbs ptr, byval model as const GLfloat ptr, byval perspective as const GLfloat ptr, byval view as const GLint ptr)
declare sub gluLookAt(byval eyeX as GLdouble, byval eyeY as GLdouble, byval eyeZ as GLdouble, byval centerX as GLdouble, byval centerY as GLdouble, byval centerZ as GLdouble, byval upX as GLdouble, byval upY as GLdouble, byval upZ as GLdouble)
declare function gluNewNurbsRenderer() as GLUnurbs ptr
declare function gluNewQuadric() as GLUquadric ptr
declare function gluNewTess() as GLUtesselator ptr
declare sub gluNextContour(byval tess as GLUtesselator ptr, byval type as GLenum)
declare sub gluNurbsCallback(byval nurb as GLUnurbs ptr, byval which as GLenum, byval CallBackFunc as _GLUfuncptr)
declare sub gluNurbsCallbackData(byval nurb as GLUnurbs ptr, byval userData as GLvoid ptr)
declare sub gluNurbsCallbackDataEXT(byval nurb as GLUnurbs ptr, byval userData as GLvoid ptr)
declare sub gluNurbsCurve(byval nurb as GLUnurbs ptr, byval knotCount as GLint, byval knots as GLfloat ptr, byval stride as GLint, byval control as GLfloat ptr, byval order as GLint, byval type as GLenum)
declare sub gluNurbsProperty(byval nurb as GLUnurbs ptr, byval property as GLenum, byval value as GLfloat)
declare sub gluNurbsSurface(byval nurb as GLUnurbs ptr, byval sKnotCount as GLint, byval sKnots as GLfloat ptr, byval tKnotCount as GLint, byval tKnots as GLfloat ptr, byval sStride as GLint, byval tStride as GLint, byval control as GLfloat ptr, byval sOrder as GLint, byval tOrder as GLint, byval type as GLenum)
declare sub gluOrtho2D(byval left as GLdouble, byval right as GLdouble, byval bottom as GLdouble, byval top as GLdouble)
declare sub gluPartialDisk(byval quad as GLUquadric ptr, byval inner as GLdouble, byval outer as GLdouble, byval slices as GLint, byval loops as GLint, byval start as GLdouble, byval sweep as GLdouble)
declare sub gluPerspective(byval fovy as GLdouble, byval aspect as GLdouble, byval zNear as GLdouble, byval zFar as GLdouble)
declare sub gluPickMatrix(byval x as GLdouble, byval y as GLdouble, byval delX as GLdouble, byval delY as GLdouble, byval viewport as GLint ptr)
declare function gluProject(byval objX as GLdouble, byval objY as GLdouble, byval objZ as GLdouble, byval model as const GLdouble ptr, byval proj as const GLdouble ptr, byval view as const GLint ptr, byval winX as GLdouble ptr, byval winY as GLdouble ptr, byval winZ as GLdouble ptr) as GLint
declare sub gluPwlCurve(byval nurb as GLUnurbs ptr, byval count as GLint, byval data as GLfloat ptr, byval stride as GLint, byval type as GLenum)
declare sub gluQuadricCallback(byval quad as GLUquadric ptr, byval which as GLenum, byval CallBackFunc as _GLUfuncptr)
declare sub gluQuadricDrawStyle(byval quad as GLUquadric ptr, byval draw as GLenum)
declare sub gluQuadricNormals(byval quad as GLUquadric ptr, byval normal as GLenum)
declare sub gluQuadricOrientation(byval quad as GLUquadric ptr, byval orientation as GLenum)
declare sub gluQuadricTexture(byval quad as GLUquadric ptr, byval texture as GLboolean)
declare function gluScaleImage(byval format as GLenum, byval wIn as GLsizei, byval hIn as GLsizei, byval typeIn as GLenum, byval dataIn as const any ptr, byval wOut as GLsizei, byval hOut as GLsizei, byval typeOut as GLenum, byval dataOut as GLvoid ptr) as GLint
declare sub gluSphere(byval quad as GLUquadric ptr, byval radius as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub gluTessBeginContour(byval tess as GLUtesselator ptr)
declare sub gluTessBeginPolygon(byval tess as GLUtesselator ptr, byval data as GLvoid ptr)
declare sub gluTessCallback(byval tess as GLUtesselator ptr, byval which as GLenum, byval CallBackFunc as _GLUfuncptr)
declare sub gluTessEndContour(byval tess as GLUtesselator ptr)
declare sub gluTessEndPolygon(byval tess as GLUtesselator ptr)
declare sub gluTessNormal(byval tess as GLUtesselator ptr, byval valueX as GLdouble, byval valueY as GLdouble, byval valueZ as GLdouble)
declare sub gluTessProperty(byval tess as GLUtesselator ptr, byval which as GLenum, byval data as GLdouble)
declare sub gluTessVertex(byval tess as GLUtesselator ptr, byval location as GLdouble ptr, byval data as GLvoid ptr)
declare function gluUnProject(byval winX as GLdouble, byval winY as GLdouble, byval winZ as GLdouble, byval model as const GLdouble ptr, byval proj as const GLdouble ptr, byval view as const GLint ptr, byval objX as GLdouble ptr, byval objY as GLdouble ptr, byval objZ as GLdouble ptr) as GLint
declare function gluUnProject4(byval winX as GLdouble, byval winY as GLdouble, byval winZ as GLdouble, byval clipW as GLdouble, byval model as const GLdouble ptr, byval proj as const GLdouble ptr, byval view as const GLint ptr, byval nearVal as GLdouble, byval farVal as GLdouble, byval objX as GLdouble ptr, byval objY as GLdouble ptr, byval objZ as GLdouble ptr, byval objW as GLdouble ptr) as GLint

end extern
