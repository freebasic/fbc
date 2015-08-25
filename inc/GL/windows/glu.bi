'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "glu32"

#include once "GL/windows/gl.bi"

extern "Windows"

#define __glu_h__

#ifdef UNICODE
	#define gluErrorStringWIN(errCode) cast(LPCSTR, gluErrorUnicodeStringEXT(errCode))
#else
	#define gluErrorStringWIN(errCode) cast(LPCWSTR, gluErrorString(errCode))
#endif

declare function gluErrorString(byval errCode as GLenum) as const zstring ptr
declare function gluErrorUnicodeStringEXT(byval errCode as GLenum) as const wstring ptr
declare function gluGetString(byval name as GLenum) as const zstring ptr
declare sub gluOrtho2D(byval left as GLdouble, byval right as GLdouble, byval bottom as GLdouble, byval top as GLdouble)
declare sub gluPerspective(byval fovy as GLdouble, byval aspect as GLdouble, byval zNear as GLdouble, byval zFar as GLdouble)
declare sub gluPickMatrix(byval x as GLdouble, byval y as GLdouble, byval width as GLdouble, byval height as GLdouble, byval viewport as GLint ptr)
declare sub gluLookAt(byval eyex as GLdouble, byval eyey as GLdouble, byval eyez as GLdouble, byval centerx as GLdouble, byval centery as GLdouble, byval centerz as GLdouble, byval upx as GLdouble, byval upy as GLdouble, byval upz as GLdouble)
declare function gluProject(byval objx as GLdouble, byval objy as GLdouble, byval objz as GLdouble, byval modelMatrix as const GLdouble ptr, byval projMatrix as const GLdouble ptr, byval viewport as const GLint ptr, byval winx as GLdouble ptr, byval winy as GLdouble ptr, byval winz as GLdouble ptr) as long
declare function gluUnProject(byval winx as GLdouble, byval winy as GLdouble, byval winz as GLdouble, byval modelMatrix as const GLdouble ptr, byval projMatrix as const GLdouble ptr, byval viewport as const GLint ptr, byval objx as GLdouble ptr, byval objy as GLdouble ptr, byval objz as GLdouble ptr) as long
declare function gluScaleImage(byval format as GLenum, byval widthin as GLint, byval heightin as GLint, byval typein as GLenum, byval datain as const any ptr, byval widthout as GLint, byval heightout as GLint, byval typeout as GLenum, byval dataout as any ptr) as long
declare function gluBuild1DMipmaps(byval target as GLenum, byval components as GLint, byval width as GLint, byval format as GLenum, byval type as GLenum, byval data as const any ptr) as long
declare function gluBuild2DMipmaps(byval target as GLenum, byval components as GLint, byval width as GLint, byval height as GLint, byval format as GLenum, byval type as GLenum, byval data as const any ptr) as long

type GLUnurbs as GLUnurbs_
type GLUnurbsObj as GLUnurbs
type GLUquadric as GLUquadric_
type GLUquadricObj as GLUquadric
type GLUtesselator as GLUtesselator_
type GLUtesselatorObj as GLUtesselator
type GLUtriangulatorObj as GLUtesselator

declare function gluNewQuadric() as GLUquadric ptr
declare sub gluDeleteQuadric(byval state as GLUquadric ptr)
declare sub gluQuadricNormals(byval quadObject as GLUquadric ptr, byval normals as GLenum)
declare sub gluQuadricTexture(byval quadObject as GLUquadric ptr, byval textureCoords as GLboolean)
declare sub gluQuadricOrientation(byval quadObject as GLUquadric ptr, byval orientation as GLenum)
declare sub gluQuadricDrawStyle(byval quadObject as GLUquadric ptr, byval drawStyle as GLenum)
declare sub gluCylinder(byval qobj as GLUquadric ptr, byval baseRadius as GLdouble, byval topRadius as GLdouble, byval height as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub gluDisk(byval qobj as GLUquadric ptr, byval innerRadius as GLdouble, byval outerRadius as GLdouble, byval slices as GLint, byval loops as GLint)
declare sub gluPartialDisk(byval qobj as GLUquadric ptr, byval innerRadius as GLdouble, byval outerRadius as GLdouble, byval slices as GLint, byval loops as GLint, byval startAngle as GLdouble, byval sweepAngle as GLdouble)
declare sub gluSphere(byval qobj as GLUquadric ptr, byval radius as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub gluQuadricCallback(byval qobj as GLUquadric ptr, byval which as GLenum, byval fn as sub())
declare function gluNewTess() as GLUtesselator ptr
declare sub gluDeleteTess(byval tess as GLUtesselator ptr)
declare sub gluTessBeginPolygon(byval tess as GLUtesselator ptr, byval polygon_data as any ptr)
declare sub gluTessBeginContour(byval tess as GLUtesselator ptr)
declare sub gluTessVertex(byval tess as GLUtesselator ptr, byval coords as GLdouble ptr, byval data as any ptr)
declare sub gluTessEndContour(byval tess as GLUtesselator ptr)
declare sub gluTessEndPolygon(byval tess as GLUtesselator ptr)
declare sub gluTessProperty(byval tess as GLUtesselator ptr, byval which as GLenum, byval value as GLdouble)
declare sub gluTessNormal(byval tess as GLUtesselator ptr, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
declare sub gluTessCallback(byval tess as GLUtesselator ptr, byval which as GLenum, byval fn as sub())
declare sub gluGetTessProperty(byval tess as GLUtesselator ptr, byval which as GLenum, byval value as GLdouble ptr)
declare function gluNewNurbsRenderer() as GLUnurbs ptr
declare sub gluDeleteNurbsRenderer(byval nobj as GLUnurbs ptr)
declare sub gluBeginSurface(byval nobj as GLUnurbs ptr)
declare sub gluBeginCurve(byval nobj as GLUnurbs ptr)
declare sub gluEndCurve(byval nobj as GLUnurbs ptr)
declare sub gluEndSurface(byval nobj as GLUnurbs ptr)
declare sub gluBeginTrim(byval nobj as GLUnurbs ptr)
declare sub gluEndTrim(byval nobj as GLUnurbs ptr)
declare sub gluPwlCurve(byval nobj as GLUnurbs ptr, byval count as GLint, byval array as GLfloat ptr, byval stride as GLint, byval type as GLenum)
declare sub gluNurbsCurve(byval nobj as GLUnurbs ptr, byval nknots as GLint, byval knot as GLfloat ptr, byval stride as GLint, byval ctlarray as GLfloat ptr, byval order as GLint, byval type as GLenum)
declare sub gluNurbsSurface(byval nobj as GLUnurbs ptr, byval sknot_count as GLint, byval sknot as single ptr, byval tknot_count as GLint, byval tknot as GLfloat ptr, byval s_stride as GLint, byval t_stride as GLint, byval ctlarray as GLfloat ptr, byval sorder as GLint, byval torder as GLint, byval type as GLenum)
declare sub gluLoadSamplingMatrices(byval nobj as GLUnurbs ptr, byval modelMatrix as const GLfloat ptr, byval projMatrix as const GLfloat ptr, byval viewport as const GLint ptr)
declare sub gluNurbsProperty(byval nobj as GLUnurbs ptr, byval property as GLenum, byval value as GLfloat)
declare sub gluGetNurbsProperty(byval nobj as GLUnurbs ptr, byval property as GLenum, byval value as GLfloat ptr)
declare sub gluNurbsCallback(byval nobj as GLUnurbs ptr, byval which as GLenum, byval fn as sub())

type GLUquadricErrorProc as sub(byval as GLenum)
type GLUtessBeginProc as sub(byval as GLenum)
type GLUtessEdgeFlagProc as sub(byval as GLboolean)
type GLUtessVertexProc as sub(byval as any ptr)
type GLUtessEndProc as sub()
type GLUtessErrorProc as sub(byval as GLenum)
type GLUtessCombineProc as sub(byval as GLdouble ptr, byval as any ptr ptr, byval as GLfloat ptr, byval as any ptr ptr)
type GLUtessBeginDataProc as sub(byval as GLenum, byval as any ptr)
type GLUtessEdgeFlagDataProc as sub(byval as GLboolean, byval as any ptr)
type GLUtessVertexDataProc as sub(byval as any ptr, byval as any ptr)
type GLUtessEndDataProc as sub(byval as any ptr)
type GLUtessErrorDataProc as sub(byval as GLenum, byval as any ptr)
type GLUtessCombineDataProc as sub(byval as GLdouble ptr, byval as any ptr ptr, byval as GLfloat ptr, byval as any ptr ptr, byval as any ptr)
type GLUnurbsErrorProc as sub(byval as GLenum)

const GLU_VERSION_1_1 = 1
const GLU_VERSION_1_2 = 1
const GLU_INVALID_ENUM = 100900
const GLU_INVALID_VALUE = 100901
const GLU_OUT_OF_MEMORY = 100902
const GLU_INCOMPATIBLE_GL_VERSION = 100903
const GLU_VERSION = 100800
const GLU_EXTENSIONS = 100801
const GLU_TRUE = GL_TRUE
const GLU_FALSE = GL_FALSE
const GLU_SMOOTH = 100000
const GLU_FLAT = 100001
const GLU_NONE = 100002
const GLU_POINT = 100010
const GLU_LINE = 100011
const GLU_FILL = 100012
const GLU_SILHOUETTE = 100013
const GLU_OUTSIDE = 100020
const GLU_INSIDE = 100021
const GLU_TESS_MAX_COORD = 1.0e150
const GLU_TESS_WINDING_RULE = 100140
const GLU_TESS_BOUNDARY_ONLY = 100141
const GLU_TESS_TOLERANCE = 100142
const GLU_TESS_WINDING_ODD = 100130
const GLU_TESS_WINDING_NONZERO = 100131
const GLU_TESS_WINDING_POSITIVE = 100132
const GLU_TESS_WINDING_NEGATIVE = 100133
const GLU_TESS_WINDING_ABS_GEQ_TWO = 100134
const GLU_TESS_BEGIN = 100100
const GLU_TESS_VERTEX = 100101
const GLU_TESS_END = 100102
const GLU_TESS_ERROR = 100103
const GLU_TESS_EDGE_FLAG = 100104
const GLU_TESS_COMBINE = 100105
const GLU_TESS_BEGIN_DATA = 100106
const GLU_TESS_VERTEX_DATA = 100107
const GLU_TESS_END_DATA = 100108
const GLU_TESS_ERROR_DATA = 100109
const GLU_TESS_EDGE_FLAG_DATA = 100110
const GLU_TESS_COMBINE_DATA = 100111
const GLU_TESS_ERROR1 = 100151
const GLU_TESS_ERROR2 = 100152
const GLU_TESS_ERROR3 = 100153
const GLU_TESS_ERROR4 = 100154
const GLU_TESS_ERROR5 = 100155
const GLU_TESS_ERROR6 = 100156
const GLU_TESS_ERROR7 = 100157
const GLU_TESS_ERROR8 = 100158
const GLU_TESS_MISSING_BEGIN_POLYGON = GLU_TESS_ERROR1
const GLU_TESS_MISSING_BEGIN_CONTOUR = GLU_TESS_ERROR2
const GLU_TESS_MISSING_END_POLYGON = GLU_TESS_ERROR3
const GLU_TESS_MISSING_END_CONTOUR = GLU_TESS_ERROR4
const GLU_TESS_COORD_TOO_LARGE = GLU_TESS_ERROR5
const GLU_TESS_NEED_COMBINE_CALLBACK = GLU_TESS_ERROR6
const GLU_AUTO_LOAD_MATRIX = 100200
const GLU_CULLING = 100201
const GLU_SAMPLING_TOLERANCE = 100203
const GLU_DISPLAY_MODE = 100204
const GLU_PARAMETRIC_TOLERANCE = 100202
const GLU_SAMPLING_METHOD = 100205
const GLU_U_STEP = 100206
const GLU_V_STEP = 100207
const GLU_PATH_LENGTH = 100215
const GLU_PARAMETRIC_ERROR = 100216
const GLU_DOMAIN_DISTANCE = 100217
const GLU_MAP1_TRIM_2 = 100210
const GLU_MAP1_TRIM_3 = 100211
const GLU_OUTLINE_POLYGON = 100240
const GLU_OUTLINE_PATCH = 100241
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

declare sub gluBeginPolygon(byval tess as GLUtesselator ptr)
declare sub gluNextContour(byval tess as GLUtesselator ptr, byval type as GLenum)
declare sub gluEndPolygon(byval tess as GLUtesselator ptr)

const GLU_CW = 100120
const GLU_CCW = 100121
const GLU_INTERIOR = 100122
const GLU_EXTERIOR = 100123
const GLU_UNKNOWN = 100124
const GLU_BEGIN = GLU_TESS_BEGIN
const GLU_VERTEX = GLU_TESS_VERTEX
const GLU_END = GLU_TESS_END
const GLU_ERROR = GLU_TESS_ERROR
const GLU_EDGE_FLAG = GLU_TESS_EDGE_FLAG

end extern
