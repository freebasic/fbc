/'
** License Applicability. Except to the extent portions of this file are
** made subject to an alternative license as permitted in the SGI Free
** Software License B, Version 1.1 (the "License"), the contents of this
** file are subject only to the provisions of the License. You may not use
** this file except in compliance with the License. You may obtain a copy
** of the License at Silicon Graphics, Inc., attn: Legal Services, 1600
** Amphitheatre Parkway, Mountain View, CA 94043-1351, or at:
**
** http://oss.sgi.com/projects/FreeB
**
** Note that, as provided in the License, the Software is distributed on an
** "AS IS" basis, with ALL EXPRESS AND IMPLIED WARRANTIES AND CONDITIONS
** DISCLAIMED, INCLUDING, WITHOUT LIMITATION, ANY IMPLIED WARRANTIES AND
** CONDITIONS OF MERCHANTABILITY, SATISFACTORY QUALITY, FITNESS FOR A
** PARTICULAR PURPOSE, AND NON-INFRINGEMENT.
**
** Original Code. The Original Code is: OpenGL Sample Implementation,
** Version 1.2.1, released January 26, 2000, developed by Silicon Graphics,
** Inc. The Original Code is Copyright (c) 1991-2000 Silicon Graphics, Inc.
** Copyright in any portions created by third parties is as indicated
** elsewhere herein. All Rights Reserved.
**
** Additional Notice Provisions: This software was created using the
** OpenGL(R) version 1.2.1 Sample Implementation published by SGI, but has
** not been independently verified as being compliant with the OpenGL(R)
** version 1.2.1 Specification.
'/

#Ifndef __glu_bi__
#define __glu_bi__

#Include Once "GL/gl.bi"

#If Defined(__FB_WIN32__) Or Defined(__FB_CYGWIN__)
Extern "Windows"
#ElseIf Defined(__FB_UNIX__)
Extern "C"
#Else
Extern "C"
#EndIf

#ifdef __FB_WIN32__
#Inclib "glu32"
#elseif defined(__FB_LINUX__)
#Inclib "GLU"
#elseif defined(__FB_DOS__)
#Inclib "glu"
#EndIf

/'***********************************************************'/

/' Boolean '/
#define GLU_FALSE                          0
#define GLU_TRUE                           1

/' Version '/
#define GLU_VERSION_1_1                    1
#define GLU_VERSION_1_2                    1

/' StringName '/
#define GLU_VERSION                        100800
#define GLU_EXTENSIONS                     100801

/' ErrorCode '/
#define GLU_INVALID_ENUM                   100900
#define GLU_INVALID_VALUE                  100901
#define GLU_OUT_OF_MEMORY                  100902
#define GLU_INVALID_OPERATION              100904

/' NurbsDisplay '/
/'      GLU_FILL '/
#define GLU_OUTLINE_POLYGON                100240
#define GLU_OUTLINE_PATCH                  100241

/' NurbsError '/
#define GLU_NURBS_ERROR1                   100251
#define GLU_NURBS_ERROR2                   100252
#define GLU_NURBS_ERROR3                   100253
#define GLU_NURBS_ERROR4                   100254
#define GLU_NURBS_ERROR5                   100255
#define GLU_NURBS_ERROR6                   100256
#define GLU_NURBS_ERROR7                   100257
#define GLU_NURBS_ERROR8                   100258
#define GLU_NURBS_ERROR9                   100259
#define GLU_NURBS_ERROR10                  100260
#define GLU_NURBS_ERROR11                  100261
#define GLU_NURBS_ERROR12                  100262
#define GLU_NURBS_ERROR13                  100263
#define GLU_NURBS_ERROR14                  100264
#define GLU_NURBS_ERROR15                  100265
#define GLU_NURBS_ERROR16                  100266
#define GLU_NURBS_ERROR17                  100267
#define GLU_NURBS_ERROR18                  100268
#define GLU_NURBS_ERROR19                  100269
#define GLU_NURBS_ERROR20                  100270
#define GLU_NURBS_ERROR21                  100271
#define GLU_NURBS_ERROR22                  100272
#define GLU_NURBS_ERROR23                  100273
#define GLU_NURBS_ERROR24                  100274
#define GLU_NURBS_ERROR25                  100275
#define GLU_NURBS_ERROR26                  100276
#define GLU_NURBS_ERROR27                  100277
#define GLU_NURBS_ERROR28                  100278
#define GLU_NURBS_ERROR29                  100279
#define GLU_NURBS_ERROR30                  100280
#define GLU_NURBS_ERROR31                  100281
#define GLU_NURBS_ERROR32                  100282
#define GLU_NURBS_ERROR33                  100283
#define GLU_NURBS_ERROR34                  100284
#define GLU_NURBS_ERROR35                  100285
#define GLU_NURBS_ERROR36                  100286
#define GLU_NURBS_ERROR37                  100287

/' NurbsProperty '/
#define GLU_AUTO_LOAD_MATRIX               100200
#define GLU_CULLING                        100201
#define GLU_SAMPLING_TOLERANCE             100203
#define GLU_DISPLAY_MODE                   100204
#define GLU_PARAMETRIC_TOLERANCE           100202
#define GLU_SAMPLING_METHOD                100205
#define GLU_U_STEP                         100206
#define GLU_V_STEP                         100207

/' NurbsSampling '/
#define GLU_PATH_LENGTH                    100215
#define GLU_PARAMETRIC_ERROR               100216
#define GLU_DOMAIN_DISTANCE                100217

/' NurbsTrim '/
#define GLU_MAP1_TRIM_2                    100210
#define GLU_MAP1_TRIM_3                    100211

/' QuadricDrawStyle '/
#define GLU_POINT                          100010
#define GLU_LINE                           100011
#define GLU_FILL                           100012
#define GLU_SILHOUETTE                     100013

/' QuadricCallback '/
#define GLU_ERROR                          100103

/' QuadricNormal '/
#define GLU_SMOOTH                         100000
#define GLU_FLAT                           100001
#define GLU_NONE                           100002

/' QuadricOrientation '/
#define GLU_OUTSIDE                        100020
#define GLU_INSIDE                         100021

/' TessCallback '/
#define GLU_TESS_BEGIN                     100100
#define GLU_BEGIN                          100100
#define GLU_TESS_VERTEX                    100101
#define GLU_VERTEX                         100101
#define GLU_TESS_END                       100102
#define GLU_END                            100102
#define GLU_TESS_ERROR                     100103
#define GLU_TESS_EDGE_FLAG                 100104
#define GLU_EDGE_FLAG                      100104
#define GLU_TESS_COMBINE                   100105
#define GLU_TESS_BEGIN_DATA                100106
#define GLU_TESS_VERTEX_DATA               100107
#define GLU_TESS_END_DATA                  100108
#define GLU_TESS_ERROR_DATA                100109
#define GLU_TESS_EDGE_FLAG_DATA            100110
#define GLU_TESS_COMBINE_DATA              100111

/' TessContour '/
#define GLU_CW                             100120
#define GLU_CCW                            100121
#define GLU_INTERIOR                       100122
#define GLU_EXTERIOR                       100123
#define GLU_UNKNOWN                        100124

/' TessProperty '/
#define GLU_TESS_WINDING_RULE              100140
#define GLU_TESS_BOUNDARY_ONLY             100141
#define GLU_TESS_TOLERANCE                 100142

/' TessError '/
#define GLU_TESS_ERROR1                    100151
#define GLU_TESS_ERROR2                    100152
#define GLU_TESS_ERROR3                    100153
#define GLU_TESS_ERROR4                    100154
#define GLU_TESS_ERROR5                    100155
#define GLU_TESS_ERROR6                    100156
#define GLU_TESS_ERROR7                    100157
#define GLU_TESS_ERROR8                    100158
#define GLU_TESS_MISSING_BEGIN_POLYGON     100151
#define GLU_TESS_MISSING_BEGIN_CONTOUR     100152
#define GLU_TESS_MISSING_END_POLYGON       100153
#define GLU_TESS_MISSING_END_CONTOUR       100154
#define GLU_TESS_COORD_TOO_LARGE           100155
#define GLU_TESS_NEED_COMBINE_CALLBACK     100156

/' TessWinding '/
#define GLU_TESS_WINDING_ODD               100130
#define GLU_TESS_WINDING_NONZERO           100131
#define GLU_TESS_WINDING_POSITIVE          100132
#define GLU_TESS_WINDING_NEGATIVE          100133
#define GLU_TESS_WINDING_ABS_GEQ_TWO       100134

/' Obsolete. For compatibility with previous Sun OpenGL versions '/
#define GLU_INCOMPATIBLE_GL_VERSION        100903


/'***********************************************************'/


Type As Any GLUnurbs
Type As Any GLUquadric
Type As Any GLUtesselator

Type As GLUnurbs GLUnurbsObj
Type As GLUquadric GLUquadricObj
Type As GLUtesselator GLUtesselatorObj
Type As GLUtesselator GLUtriangulatorObj

#define GLU_TESS_MAX_COORD 1.0e150

/' Internal convenience typedefs '/
Type As Any Ptr _GLUfuncptr

Declare Sub gluBeginCurve(ByVal nurb As GLUnurbs Ptr)
Declare Sub gluBeginPolygon(ByVal tess As GLUtesselator Ptr)
Declare Sub gluBeginSurface(ByVal nurb As GLUnurbs Ptr)
Declare Sub gluBeginTrim(ByVal nurb As GLUnurbs Ptr)
Declare Function gluBuild1DMipmaps(ByVal target As GLenum, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal Data As Any Ptr) As GLint
Declare Function gluBuild2DMipmaps(ByVal target As GLenum, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal Data As Any Ptr) As GLint
Declare Sub gluCylinder(ByVal quad As GLUquadric Ptr, ByVal base As GLdouble, ByVal top As GLdouble, ByVal height As GLdouble, ByVal slices As GLint, ByVal stacks As GLint)
Declare Sub gluDeleteNurbsRenderer(ByVal nurb As GLUnurbs Ptr)
Declare Sub gluDeleteQuadric(ByVal quad As GLUquadric Ptr)
Declare Sub gluDeleteTess(ByVal tess As GLUtesselator Ptr)
Declare Sub gluDisk(ByVal quad As GLUquadric Ptr, ByVal inner As GLdouble, ByVal outer As GLdouble, ByVal slices As GLint, ByVal loops As GLint)
Declare Sub gluEndCurve(ByVal nurb As GLUnurbs Ptr)
Declare Sub gluEndPolygon(ByVal tess As GLUtesselator Ptr)
Declare Sub gluEndSurface(ByVal nurb As GLUnurbs Ptr)
Declare Sub gluEndTrim(ByVal nurb As GLUnurbs Ptr)
Declare Function gluErrorString(ByVal Error As GLenum) As ZString Ptr
Declare Function gluErrorUnicodeStringEXT(ByVal Error As GLenum) As WString Ptr
Declare Sub gluGetNurbsProperty(ByVal nurb As GLUnurbs Ptr, ByVal Property As GLenum, ByVal Data As GLfloat Ptr)
Declare Function gluGetString(ByVal Name As GLenum) As ZString Ptr
Declare Sub gluGetTessProperty(ByVal tess As GLUtesselator Ptr, ByVal which As GLenum, ByVal Data As GLdouble Ptr)
Declare Sub gluLoadSamplingMatrices(ByVal nurb As GLUnurbs Ptr, ByVal model As GLfloat Ptr, ByVal perspective As GLfloat Ptr, ByVal View As GLint Ptr)
Declare Sub gluLookAt(ByVal eyeX As GLdouble, ByVal eyeY As GLdouble, ByVal eyeZ As GLdouble, ByVal centerX As GLdouble, ByVal centerY As GLdouble, ByVal centerZ As GLdouble, ByVal upX As GLdouble, ByVal upY As GLdouble, ByVal upZ As GLdouble)
Declare Function gluNewNurbsRenderer() As GLUnurbs Ptr
Declare Function gluNewQuadric() As GLUquadric Ptr
Declare Function gluNewTess() As GLUtesselator Ptr
Declare Sub gluNextContour(ByVal tess As GLUtesselator Ptr, ByVal Type As GLenum)
Declare Sub gluNurbsCallback(ByVal nurb As GLUnurbs Ptr, ByVal which As GLenum, ByVal CallBackFunc As _GLUfuncptr)
Declare Sub gluNurbsCurve(ByVal nurb As GLUnurbs Ptr, ByVal knotCount As GLint, ByVal knots As GLfloat Ptr, ByVal stride As GLint, ByVal control As GLfloat Ptr, ByVal order As GLint, ByVal Type As GLenum)
Declare Sub gluNurbsProperty(ByVal nurb As GLUnurbs Ptr, ByVal Property As GLenum, ByVal value As GLfloat)
Declare Sub gluNurbsSurface(ByVal nurb As GLUnurbs Ptr, ByVal sKnotCount As GLint, ByVal sKnots As GLfloat Ptr, ByVal tKnotCount As GLint, ByVal tKnots As GLfloat Ptr, ByVal sStride As GLint, ByVal tStride As GLint, ByVal control As GLfloat Ptr, ByVal sOrder As GLint, ByVal tOrder As GLint, ByVal Type As GLenum)
Declare Sub gluOrtho2D(ByVal Left As GLdouble, ByVal Right As GLdouble, ByVal bottom As GLdouble, ByVal top As GLdouble)
Declare Sub gluPartialDisk(ByVal quad As GLUquadric Ptr, ByVal inner As GLdouble, ByVal outer As GLdouble, ByVal slices As GLint, ByVal loops As GLint, ByVal start As GLdouble, ByVal sweep As GLdouble)
Declare Sub gluPerspective(ByVal fovy As GLdouble, ByVal aspect As GLdouble, ByVal zNear As GLdouble, ByVal zFar As GLdouble)
Declare Sub gluPickMatrix(ByVal x As GLdouble, ByVal y As GLdouble, ByVal delX As GLdouble, ByVal delY As GLdouble, ByVal viewport As GLint Ptr)
Declare Function gluProject(ByVal objX As GLdouble, ByVal objY As GLdouble, ByVal objZ As GLdouble, ByVal model As GLdouble Ptr, ByVal proj As GLdouble Ptr, ByVal View As GLint Ptr, ByVal winX As GLdouble Ptr, ByVal winY As GLdouble Ptr, ByVal winZ As GLdouble Ptr) As GLint
Declare Sub gluPwlCurve(ByVal nurb As GLUnurbs Ptr, ByVal count As GLint, ByVal Data As GLfloat Ptr, ByVal stride As GLint, ByVal Type As GLenum)
Declare Sub gluQuadricCallback(ByVal quad As GLUquadric Ptr, ByVal which As GLenum, ByVal CallBackFunc As _GLUfuncptr)
Declare Sub gluQuadricDrawStyle(ByVal quad As GLUquadric Ptr, ByVal Draw As GLenum)
Declare Sub gluQuadricNormals(ByVal quad As GLUquadric Ptr, ByVal normal As GLenum)
Declare Sub gluQuadricOrientation(ByVal quad As GLUquadric Ptr, ByVal orientation As GLenum)
Declare Sub gluQuadricTexture(ByVal quad As GLUquadric Ptr, ByVal texture As GLboolean)
Declare Function gluScaleImage(ByVal Format As GLenum, ByVal wIn As GLsizei, ByVal hIn As GLsizei, ByVal typeIn As GLenum, ByVal dataIn As Any Ptr, ByVal wOut As GLsizei, ByVal hOut As GLsizei, ByVal typeOut As GLenum, ByVal dataOut As GLvoid Ptr) As GLint
Declare Sub gluSphere(ByVal quad As GLUquadric Ptr, ByVal radius As GLdouble, ByVal slices As GLint, ByVal stacks As GLint)
Declare Sub gluTessBeginContour(ByVal tess As GLUtesselator Ptr)
Declare Sub gluTessBeginPolygon(ByVal tess As GLUtesselator Ptr, ByVal Data As GLvoid Ptr)
Declare Sub gluTessCallback(ByVal tess As GLUtesselator Ptr, ByVal which As GLenum, ByVal CallBackFunc As _GLUfuncptr)
Declare Sub gluTessEndContour(ByVal tess As GLUtesselator Ptr)
Declare Sub gluTessEndPolygon(ByVal tess As GLUtesselator Ptr)
Declare Sub gluTessNormal(ByVal tess As GLUtesselator Ptr, ByVal valueX As GLdouble, ByVal valueY As GLdouble, ByVal valueZ As GLdouble)
Declare Sub gluTessProperty(ByVal tess As GLUtesselator Ptr, ByVal which As GLenum, ByVal Data As GLdouble)
Declare Sub gluTessVertex(ByVal tess As GLUtesselator Ptr, ByVal location As GLdouble Ptr, ByVal Data As GLvoid Ptr)
Declare Function gluUnProject(ByVal winX As GLdouble, ByVal winY As GLdouble, ByVal winZ As GLdouble, ByVal model As GLdouble Ptr, ByVal proj As GLdouble Ptr, ByVal View As GLint Ptr, ByVal objX As GLdouble Ptr, ByVal objY As GLdouble Ptr, ByVal objZ As GLdouble Ptr) As GLint
Declare Function gluUnProject4(ByVal winX As GLdouble, ByVal winY As GLdouble, ByVal winZ As GLdouble, ByVal clipW As GLdouble, ByVal model As GLdouble Ptr, ByVal proj As GLdouble Ptr, ByVal View As GLint Ptr, ByVal nearVal As GLdouble, ByVal farVal As GLdouble, ByVal objX As GLdouble Ptr, ByVal objY As GLdouble Ptr, ByVal objZ As GLdouble Ptr, ByVal objW As GLdouble Ptr) As GLint

#Ifdef UNICODE
#define gluErrorStringWIN gluErrorUnicodeStringEXT
#Else
#define gluErrorStringWIN gluErrorString
#EndIf

End Extern

#EndIf /' __glu_bi__ '/
