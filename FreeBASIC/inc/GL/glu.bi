''
''
'' glu -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __glu_bi__
#define __glu_bi__

#ifdef __FB_WIN32__
# inclib "glu32"
#elseif defined(__FB_LINUX__)
# inclib "GLU"
#elseif defined(__FB_DOS__)
# inclib "glu"
#endif

#include once "GL/gl.bi"

#define GLU_EXT_object_space_tess 1
#define GLU_EXT_nurbs_tessellator 1
#define GLU_FALSE 0
#define GLU_TRUE 1
#define GLU_VERSION_1_1 1
#define GLU_VERSION_1_2 1
#define GLU_VERSION_1_3 1
#define GLU_VERSION 100800
#define GLU_EXTENSIONS 100801
#define GLU_INVALID_ENUM 100900
#define GLU_INVALID_VALUE 100901
#define GLU_OUT_OF_MEMORY 100902
#define GLU_INVALID_OPERATION 100904
#define GLU_OUTLINE_POLYGON 100240
#define GLU_OUTLINE_PATCH 100241
#define GLU_NURBS_ERROR 100103
#define GLU_ERROR 100103
#define GLU_NURBS_BEGIN 100164
#define GLU_NURBS_BEGIN_EXT 100164
#define GLU_NURBS_VERTEX 100165
#define GLU_NURBS_VERTEX_EXT 100165
#define GLU_NURBS_NORMAL 100166
#define GLU_NURBS_NORMAL_EXT 100166
#define GLU_NURBS_COLOR 100167
#define GLU_NURBS_COLOR_EXT 100167
#define GLU_NURBS_TEXTURE_COORD 100168
#define GLU_NURBS_TEX_COORD_EXT 100168
#define GLU_NURBS_END 100169
#define GLU_NURBS_END_EXT 100169
#define GLU_NURBS_BEGIN_DATA 100170
#define GLU_NURBS_BEGIN_DATA_EXT 100170
#define GLU_NURBS_VERTEX_DATA 100171
#define GLU_NURBS_VERTEX_DATA_EXT 100171
#define GLU_NURBS_NORMAL_DATA 100172
#define GLU_NURBS_NORMAL_DATA_EXT 100172
#define GLU_NURBS_COLOR_DATA 100173
#define GLU_NURBS_COLOR_DATA_EXT 100173
#define GLU_NURBS_TEXTURE_COORD_DATA 100174
#define GLU_NURBS_TEX_COORD_DATA_EXT 100174
#define GLU_NURBS_END_DATA 100175
#define GLU_NURBS_END_DATA_EXT 100175
#define GLU_NURBS_ERROR1 100251
#define GLU_NURBS_ERROR2 100252
#define GLU_NURBS_ERROR3 100253
#define GLU_NURBS_ERROR4 100254
#define GLU_NURBS_ERROR5 100255
#define GLU_NURBS_ERROR6 100256
#define GLU_NURBS_ERROR7 100257
#define GLU_NURBS_ERROR8 100258
#define GLU_NURBS_ERROR9 100259
#define GLU_NURBS_ERROR10 100260
#define GLU_NURBS_ERROR11 100261
#define GLU_NURBS_ERROR12 100262
#define GLU_NURBS_ERROR13 100263
#define GLU_NURBS_ERROR14 100264
#define GLU_NURBS_ERROR15 100265
#define GLU_NURBS_ERROR16 100266
#define GLU_NURBS_ERROR17 100267
#define GLU_NURBS_ERROR18 100268
#define GLU_NURBS_ERROR19 100269
#define GLU_NURBS_ERROR20 100270
#define GLU_NURBS_ERROR21 100271
#define GLU_NURBS_ERROR22 100272
#define GLU_NURBS_ERROR23 100273
#define GLU_NURBS_ERROR24 100274
#define GLU_NURBS_ERROR25 100275
#define GLU_NURBS_ERROR26 100276
#define GLU_NURBS_ERROR27 100277
#define GLU_NURBS_ERROR28 100278
#define GLU_NURBS_ERROR29 100279
#define GLU_NURBS_ERROR30 100280
#define GLU_NURBS_ERROR31 100281
#define GLU_NURBS_ERROR32 100282
#define GLU_NURBS_ERROR33 100283
#define GLU_NURBS_ERROR34 100284
#define GLU_NURBS_ERROR35 100285
#define GLU_NURBS_ERROR36 100286
#define GLU_NURBS_ERROR37 100287
#define GLU_AUTO_LOAD_MATRIX 100200
#define GLU_CULLING 100201
#define GLU_SAMPLING_TOLERANCE 100203
#define GLU_DISPLAY_MODE 100204
#define GLU_PARAMETRIC_TOLERANCE 100202
#define GLU_SAMPLING_METHOD 100205
#define GLU_U_STEP 100206
#define GLU_V_STEP 100207
#define GLU_NURBS_MODE 100160
#define GLU_NURBS_MODE_EXT 100160
#define GLU_NURBS_TESSELLATOR 100161
#define GLU_NURBS_TESSELLATOR_EXT 100161
#define GLU_NURBS_RENDERER 100162
#define GLU_NURBS_RENDERER_EXT 100162
#define GLU_OBJECT_PARAMETRIC_ERROR 100208
#define GLU_OBJECT_PARAMETRIC_ERROR_EXT 100208
#define GLU_OBJECT_PATH_LENGTH 100209
#define GLU_OBJECT_PATH_LENGTH_EXT 100209
#define GLU_PATH_LENGTH 100215
#define GLU_PARAMETRIC_ERROR 100216
#define GLU_DOMAIN_DISTANCE 100217
#define GLU_MAP1_TRIM_2 100210
#define GLU_MAP1_TRIM_3 100211
#define GLU_POINT 100010
#define GLU_LINE 100011
#define GLU_FILL 100012
#define GLU_SILHOUETTE 100013
#define GLU_SMOOTH 100000
#define GLU_FLAT 100001
#define GLU_NONE 100002
#define GLU_OUTSIDE 100020
#define GLU_INSIDE 100021
#define GLU_TESS_BEGIN 100100
#define GLU_BEGIN 100100
#define GLU_TESS_VERTEX 100101
#define GLU_VERTEX 100101
#define GLU_TESS_END 100102
#define GLU_END 100102
#define GLU_TESS_ERROR 100103
#define GLU_TESS_EDGE_FLAG 100104
#define GLU_EDGE_FLAG 100104
#define GLU_TESS_COMBINE 100105
#define GLU_TESS_BEGIN_DATA 100106
#define GLU_TESS_VERTEX_DATA 100107
#define GLU_TESS_END_DATA 100108
#define GLU_TESS_ERROR_DATA 100109
#define GLU_TESS_EDGE_FLAG_DATA 100110
#define GLU_TESS_COMBINE_DATA 100111
#define GLU_CW 100120
#define GLU_CCW 100121
#define GLU_INTERIOR 100122
#define GLU_EXTERIOR 100123
#define GLU_UNKNOWN 100124
#define GLU_TESS_WINDING_RULE 100140
#define GLU_TESS_BOUNDARY_ONLY 100141
#define GLU_TESS_TOLERANCE 100142
#define GLU_TESS_ERROR1 100151
#define GLU_TESS_ERROR2 100152
#define GLU_TESS_ERROR3 100153
#define GLU_TESS_ERROR4 100154
#define GLU_TESS_ERROR5 100155
#define GLU_TESS_ERROR6 100156
#define GLU_TESS_ERROR7 100157
#define GLU_TESS_ERROR8 100158
#define GLU_TESS_MISSING_BEGIN_POLYGON 100151
#define GLU_TESS_MISSING_BEGIN_CONTOUR 100152
#define GLU_TESS_MISSING_END_POLYGON 100153
#define GLU_TESS_MISSING_END_CONTOUR 100154
#define GLU_TESS_COORD_TOO_LARGE 100155
#define GLU_TESS_NEED_COMBINE_CALLBACK 100156
#define GLU_TESS_WINDING_ODD 100130
#define GLU_TESS_WINDING_NONZERO 100131
#define GLU_TESS_WINDING_POSITIVE 100132
#define GLU_TESS_WINDING_NEGATIVE 100133
#define GLU_TESS_WINDING_ABS_GEQ_TWO 100134

type GLUnurbs as any
type GLUquadric as any
type GLUtesselator as any
type GLUnurbsObj as GLUnurbs
type GLUquadricObj as GLUquadric
type GLUtesselatorObj as GLUtesselator
type GLUtriangulatorObj as GLUtesselator

#define GLU_TESS_MAX_COORD 1.0e150

type _GLUfuncptr as any ptr

declare sub gluBeginCurve alias "gluBeginCurve" (byval nurb as GLUnurbs ptr)
declare sub gluBeginPolygon alias "gluBeginPolygon" (byval tess as GLUtesselator ptr)
declare sub gluBeginSurface alias "gluBeginSurface" (byval nurb as GLUnurbs ptr)
declare sub gluBeginTrim alias "gluBeginTrim" (byval nurb as GLUnurbs ptr)
declare function gluBuild1DMipmapLevels alias "gluBuild1DMipmapLevels" (byval target as GLenum, byval internalFormat as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval level as GLint, byval base as GLint, byval max as GLint, byval data as any ptr) as GLint
declare function gluBuild1DMipmaps alias "gluBuild1DMipmaps" (byval target as GLenum, byval internalFormat as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval data as any ptr) as GLint
declare function gluBuild2DMipmapLevels alias "gluBuild2DMipmapLevels" (byval target as GLenum, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval level as GLint, byval base as GLint, byval max as GLint, byval data as any ptr) as GLint
declare function gluBuild2DMipmaps alias "gluBuild2DMipmaps" (byval target as GLenum, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval data as any ptr) as GLint
declare function gluBuild3DMipmapLevels alias "gluBuild3DMipmapLevels" (byval target as GLenum, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval level as GLint, byval base as GLint, byval max as GLint, byval data as any ptr) as GLint
declare function gluBuild3DMipmaps alias "gluBuild3DMipmaps" (byval target as GLenum, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval data as any ptr) as GLint
declare function gluCheckExtension alias "gluCheckExtension" (byval extName as GLubyte ptr, byval extString as GLubyte ptr) as GLboolean
declare sub gluCylinder alias "gluCylinder" (byval quad as GLUquadric ptr, byval base as GLdouble, byval top as GLdouble, byval height as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub gluDeleteNurbsRenderer alias "gluDeleteNurbsRenderer" (byval nurb as GLUnurbs ptr)
declare sub gluDeleteQuadric alias "gluDeleteQuadric" (byval quad as GLUquadric ptr)
declare sub gluDeleteTess alias "gluDeleteTess" (byval tess as GLUtesselator ptr)
declare sub gluDisk alias "gluDisk" (byval quad as GLUquadric ptr, byval inner as GLdouble, byval outer as GLdouble, byval slices as GLint, byval loops as GLint)
declare sub gluEndCurve alias "gluEndCurve" (byval nurb as GLUnurbs ptr)
declare sub gluEndPolygon alias "gluEndPolygon" (byval tess as GLUtesselator ptr)
declare sub gluEndSurface alias "gluEndSurface" (byval nurb as GLUnurbs ptr)
declare sub gluEndTrim alias "gluEndTrim" (byval nurb as GLUnurbs ptr)
declare function gluErrorString alias "gluErrorString" (byval error as GLenum) as GLubyte ptr
declare sub gluGetNurbsProperty alias "gluGetNurbsProperty" (byval nurb as GLUnurbs ptr, byval property as GLenum, byval data as GLfloat ptr)
declare function gluGetString alias "gluGetString" (byval name as GLenum) as GLubyte ptr
declare sub gluGetTessProperty alias "gluGetTessProperty" (byval tess as GLUtesselator ptr, byval which as GLenum, byval data as GLdouble ptr)
declare sub gluLoadSamplingMatrices alias "gluLoadSamplingMatrices" (byval nurb as GLUnurbs ptr, byval model as GLfloat ptr, byval perspective as GLfloat ptr, byval view as GLint ptr)
declare sub gluLookAt alias "gluLookAt" (byval eyeX as GLdouble, byval eyeY as GLdouble, byval eyeZ as GLdouble, byval centerX as GLdouble, byval centerY as GLdouble, byval centerZ as GLdouble, byval upX as GLdouble, byval upY as GLdouble, byval upZ as GLdouble)
declare function gluNewNurbsRenderer alias "gluNewNurbsRenderer" () as GLUnurbs ptr
declare function gluNewQuadric alias "gluNewQuadric" () as GLUquadric ptr
declare function gluNewTess alias "gluNewTess" () as GLUtesselator ptr
declare sub gluNextContour alias "gluNextContour" (byval tess as GLUtesselator ptr, byval type as GLenum)
declare sub gluNurbsCallback alias "gluNurbsCallback" (byval nurb as GLUnurbs ptr, byval which as GLenum, byval CallBackFunc as _GLUfuncptr)
declare sub gluNurbsCallbackData alias "gluNurbsCallbackData" (byval nurb as GLUnurbs ptr, byval userData as GLvoid ptr)
declare sub gluNurbsCallbackDataEXT alias "gluNurbsCallbackDataEXT" (byval nurb as GLUnurbs ptr, byval userData as GLvoid ptr)
declare sub gluNurbsCurve alias "gluNurbsCurve" (byval nurb as GLUnurbs ptr, byval knotCount as GLint, byval knots as GLfloat ptr, byval stride as GLint, byval control as GLfloat ptr, byval order as GLint, byval type as GLenum)
declare sub gluNurbsProperty alias "gluNurbsProperty" (byval nurb as GLUnurbs ptr, byval property as GLenum, byval value as GLfloat)
declare sub gluNurbsSurface alias "gluNurbsSurface" (byval nurb as GLUnurbs ptr, byval sKnotCount as GLint, byval sKnots as GLfloat ptr, byval tKnotCount as GLint, byval tKnots as GLfloat ptr, byval sStride as GLint, byval tStride as GLint, byval control as GLfloat ptr, byval sOrder as GLint, byval tOrder as GLint, byval type as GLenum)
declare sub gluOrtho2D alias "gluOrtho2D" (byval left as GLdouble, byval right as GLdouble, byval bottom as GLdouble, byval top as GLdouble)
declare sub gluPartialDisk alias "gluPartialDisk" (byval quad as GLUquadric ptr, byval inner as GLdouble, byval outer as GLdouble, byval slices as GLint, byval loops as GLint, byval start as GLdouble, byval sweep as GLdouble)
declare sub gluPerspective alias "gluPerspective" (byval fovy as GLdouble, byval aspect as GLdouble, byval zNear as GLdouble, byval zFar as GLdouble)
declare sub gluPickMatrix alias "gluPickMatrix" (byval x as GLdouble, byval y as GLdouble, byval delX as GLdouble, byval delY as GLdouble, byval viewport as GLint ptr)
declare function gluProject alias "gluProject" (byval objX as GLdouble, byval objY as GLdouble, byval objZ as GLdouble, byval model as GLdouble ptr, byval proj as GLdouble ptr, byval view as GLint ptr, byval winX as GLdouble ptr, byval winY as GLdouble ptr, byval winZ as GLdouble ptr) as GLint
declare sub gluPwlCurve alias "gluPwlCurve" (byval nurb as GLUnurbs ptr, byval count as GLint, byval data as GLfloat ptr, byval stride as GLint, byval type as GLenum)
declare sub gluQuadricCallback alias "gluQuadricCallback" (byval quad as GLUquadric ptr, byval which as GLenum, byval CallBackFunc as _GLUfuncptr)
declare sub gluQuadricDrawStyle alias "gluQuadricDrawStyle" (byval quad as GLUquadric ptr, byval draw as GLenum)
declare sub gluQuadricNormals alias "gluQuadricNormals" (byval quad as GLUquadric ptr, byval normal as GLenum)
declare sub gluQuadricOrientation alias "gluQuadricOrientation" (byval quad as GLUquadric ptr, byval orientation as GLenum)
declare sub gluQuadricTexture alias "gluQuadricTexture" (byval quad as GLUquadric ptr, byval texture as GLboolean)
declare function gluScaleImage alias "gluScaleImage" (byval format as GLenum, byval wIn as GLsizei, byval hIn as GLsizei, byval typeIn as GLenum, byval dataIn as any ptr, byval wOut as GLsizei, byval hOut as GLsizei, byval typeOut as GLenum, byval dataOut as GLvoid ptr) as GLint
declare sub gluSphere alias "gluSphere" (byval quad as GLUquadric ptr, byval radius as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub gluTessBeginContour alias "gluTessBeginContour" (byval tess as GLUtesselator ptr)
declare sub gluTessBeginPolygon alias "gluTessBeginPolygon" (byval tess as GLUtesselator ptr, byval data as GLvoid ptr)
declare sub gluTessCallback alias "gluTessCallback" (byval tess as GLUtesselator ptr, byval which as GLenum, byval CallBackFunc as _GLUfuncptr)
declare sub gluTessEndContour alias "gluTessEndContour" (byval tess as GLUtesselator ptr)
declare sub gluTessEndPolygon alias "gluTessEndPolygon" (byval tess as GLUtesselator ptr)
declare sub gluTessNormal alias "gluTessNormal" (byval tess as GLUtesselator ptr, byval valueX as GLdouble, byval valueY as GLdouble, byval valueZ as GLdouble)
declare sub gluTessProperty alias "gluTessProperty" (byval tess as GLUtesselator ptr, byval which as GLenum, byval data as GLdouble)
declare sub gluTessVertex alias "gluTessVertex" (byval tess as GLUtesselator ptr, byval location as GLdouble ptr, byval data as GLvoid ptr)
declare function gluUnProject alias "gluUnProject" (byval winX as GLdouble, byval winY as GLdouble, byval winZ as GLdouble, byval model as GLdouble ptr, byval proj as GLdouble ptr, byval view as GLint ptr, byval objX as GLdouble ptr, byval objY as GLdouble ptr, byval objZ as GLdouble ptr) as GLint
declare function gluUnProject4 alias "gluUnProject4" (byval winX as GLdouble, byval winY as GLdouble, byval winZ as GLdouble, byval clipW as GLdouble, byval model as GLdouble ptr, byval proj as GLdouble ptr, byval view as GLint ptr, byval nearVal as GLdouble, byval farVal as GLdouble, byval objX as GLdouble ptr, byval objY as GLdouble ptr, byval objZ as GLdouble ptr, byval objW as GLdouble ptr) as GLint

#endif
