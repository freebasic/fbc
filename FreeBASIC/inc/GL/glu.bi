'  FileName: GLU.BI
'  Ported by: Richard Eric M. Lope BSN RN aka Relsoft
'  To be used by the FreeBASIC compiler
'  01/09/2005
'  send bug reports to vic_viperph@yahoo.com
'  most of the prototypes untested.

#ifndef glu_bi
#define glu_bi


'$inclib: "glu32"

#ifndef gl_bi
	'$include: "\gl\gl.bi"
#endif


'/*************************************************************/

'/* Extensions */
#define GLU_EXT_object_space_tess          1
#define GLU_EXT_nurbs_tessellator          1

'/* Boolean */
#define GLU_FALSE                          0
#define GLU_TRUE                           1

'/* Version */
#define GLU_VERSION_1_1                    1
#define GLU_VERSION_1_2                    1
#define GLU_VERSION_1_3                    1

'/* StringName */
#define GLU_VERSION                        100800
#define GLU_EXTENSIONS                     100801

'/* ErrorCode */
#define GLU_INVALID_ENUM                   100900
#define GLU_INVALID_VALUE                  100901
#define GLU_OUT_OF_MEMORY                  100902
#define GLU_INVALID_OPERATION              100904

'/* NurbsDisplay */
'/*      GLU_FILL */
#define GLU_OUTLINE_POLYGON                100240
#define GLU_OUTLINE_PATCH                  100241

'/* NurbsCallback */
#define GLU_NURBS_ERROR                    100103
#define GLU_ERROR                          100103
#define GLU_NURBS_BEGIN                    100164
#define GLU_NURBS_BEGIN_EXT                100164
#define GLU_NURBS_VERTEX                   100165
#define GLU_NURBS_VERTEX_EXT               100165
#define GLU_NURBS_NORMAL                   100166
#define GLU_NURBS_NORMAL_EXT               100166
#define GLU_NURBS_COLOR                    100167
#define GLU_NURBS_COLOR_EXT                100167
#define GLU_NURBS_TEXTURE_COORD            100168
#define GLU_NURBS_TEX_COORD_EXT            100168
#define GLU_NURBS_END                      100169
#define GLU_NURBS_END_EXT                  100169
#define GLU_NURBS_BEGIN_DATA               100170
#define GLU_NURBS_BEGIN_DATA_EXT           100170
#define GLU_NURBS_VERTEX_DATA              100171
#define GLU_NURBS_VERTEX_DATA_EXT          100171
#define GLU_NURBS_NORMAL_DATA              100172
#define GLU_NURBS_NORMAL_DATA_EXT          100172
#define GLU_NURBS_COLOR_DATA               100173
#define GLU_NURBS_COLOR_DATA_EXT           100173
#define GLU_NURBS_TEXTURE_COORD_DATA       100174
#define GLU_NURBS_TEX_COORD_DATA_EXT       100174
#define GLU_NURBS_END_DATA                 100175
#define GLU_NURBS_END_DATA_EXT             100175

'/* NurbsError */
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

'/* NurbsProperty */
#define GLU_AUTO_LOAD_MATRIX               100200
#define GLU_CULLING                        100201
#define GLU_SAMPLING_TOLERANCE             100203
#define GLU_DISPLAY_MODE                   100204
#define GLU_PARAMETRIC_TOLERANCE           100202
#define GLU_SAMPLING_METHOD                100205
#define GLU_U_STEP                         100206
#define GLU_V_STEP                         100207
#define GLU_NURBS_MODE                     100160
#define GLU_NURBS_MODE_EXT                 100160
#define GLU_NURBS_TESSELLATOR              100161
#define GLU_NURBS_TESSELLATOR_EXT          100161
#define GLU_NURBS_RENDERER                 100162
#define GLU_NURBS_RENDERER_EXT             100162

'/* NurbsSampling */
#define GLU_OBJECT_PARAMETRIC_ERROR        100208
#define GLU_OBJECT_PARAMETRIC_ERROR_EXT    100208
#define GLU_OBJECT_PATH_LENGTH             100209
#define GLU_OBJECT_PATH_LENGTH_EXT         100209
#define GLU_PATH_LENGTH                    100215
#define GLU_PARAMETRIC_ERROR               100216
#define GLU_DOMAIN_DISTANCE                100217

'/* NurbsTrim */
#define GLU_MAP1_TRIM_2                    100210
#define GLU_MAP1_TRIM_3                    100211

'/* QuadricDrawStyle */
#define GLU_POINT                          100010
#define GLU_LINE                           100011
#define GLU_FILL                           100012
#define GLU_SILHOUETTE                     100013

'/* QuadricCallback */
'/*      GLU_ERROR */

'/* QuadricNormal */
#define GLU_SMOOTH                         100000
#define GLU_FLAT                           100001
#define GLU_NONE                           100002

'/* QuadricOrientation */
#define GLU_OUTSIDE                        100020
#define GLU_INSIDE                         100021

'/* TessCallback */
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

'/* TessContour */
#define GLU_CW                             100120
#define GLU_CCW                            100121
#define GLU_INTERIOR                       100122
#define GLU_EXTERIOR                       100123
#define GLU_UNKNOWN                        100124

'/* TessProperty */
#define GLU_TESS_WINDING_RULE              100140
#define GLU_TESS_BOUNDARY_ONLY             100141
#define GLU_TESS_TOLERANCE                 100142

'/* TessError */
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

'/* TessWinding */
#define GLU_TESS_WINDING_ODD               100130
#define GLU_TESS_WINDING_NONZERO           100131
#define GLU_TESS_WINDING_POSITIVE          100132
#define GLU_TESS_WINDING_NEGATIVE          100133
#define GLU_TESS_WINDING_ABS_GEQ_TWO       100134

'/*************************************************************/


#define GLUnurbs       ANY
#define GLUquadric     ANY
#define GLUtesselator  ANY

#define GLUnurbsObj        GLUnurbs
#define GLUquadricObj      GLUquadric
#define GLUtesselatorObj   GLUtesselator
#define GLUtriangulatorObj GLUtesselator


#define GLU_TESS_MAX_COORD 1.0e150

'/* Internal convenience typedefs */

#define GLUfuncptr FUNCTION


DECLARE SUB  	  gluBeginCurve 		  ALIAS "gluBeginCurve" 	      (BYVAL nurb AS GLUnurbs PTR)
DECLARE SUB  	  gluBeginPolygon 		  ALIAS "gluBeginPolygon" 		  (BYVAL tess AS GLUtesselator PTR)
DECLARE SUB  	  gluBeginSurface 		  ALIAS "gluBeginSurface" 	      (BYVAL nurb AS GLUnurbs PTR)
DECLARE SUB  	  gluBeginTrim 			  ALIAS "gluBeginTrim" 			  (BYVAL nurb AS GLUnurbs PTR)
DECLARE FUNCTION  gluBuild1DMipmapLevels  ALIAS "gluBuild1DMipmapLevels"  (BYVAL target AS GLenum, BYVAL internalFormat AS GLint, BYVAL width AS GLsizei, BYVAL format AS GLenum, BYVAL xtype AS GLenum, BYVAL level AS GLint, BYVAL xbase AS GLint, BYVAL max AS GLint, BYVAL xdata AS ANY PTR) AS GLint
DECLARE FUNCTION  gluBuild1DMipmaps 	  ALIAS "gluBuild1DMipmaps" 	  (BYVAL target AS GLenum, BYVAL internalFormat AS GLint, BYVAL width AS GLsizei, BYVAL format AS GLenum, BYVAL xtype AS GLenum, BYVAL xdata AS ANY PTR) AS GLint
DECLARE FUNCTION  gluBuild2DMipmapLevels  ALIAS "gluBuild2DMipmapLevels"  (BYVAL target AS GLenum, BYVAL internalFormat AS GLint, BYVAL width AS GLsizei, BYVAL height AS GLsizei, BYVAL format AS GLenum, BYVAL xtype AS GLenum, BYVAL level AS GLint, BYVAL xbase AS GLint, BYVAL max AS GLint, BYVAL xdata AS ANY PTR) AS GLint
DECLARE FUNCTION  gluBuild2DMipmaps 	  ALIAS "gluBuild2DMipmaps" 	  (BYVAL target AS GLenum, BYVAL internalFormat AS GLint, BYVAL width AS GLsizei, BYVAL height AS GLsizei, BYVAL format AS GLenum, BYVAL xtype AS GLenum, BYVAL xdata AS ANY PTR) AS GLint
DECLARE FUNCTION  gluBuild3DMipmapLevels  ALIAS "gluBuild3DMipmapLevels"  (BYVAL target AS GLenum, BYVAL internalFormat AS GLint, BYVAL width AS GLsizei, BYVAL height AS GLsizei, BYVAL depth AS GLsizei, BYVAL format AS GLenum, BYVAL xtype AS GLenum, BYVAL level AS GLint, BYVAL xbase AS GLint, BYVAL max AS GLint, BYVAL xdata AS ANY PTR) AS GLint
DECLARE FUNCTION  gluBuild3DMipmaps 	  ALIAS "gluBuild3DMipmaps" 	  (BYVAL target AS GLenum, BYVAL internalFormat AS GLint, BYVAL width AS GLsizei, BYVAL height AS GLsizei, BYVAL depth AS GLsizei, BYVAL format AS GLenum, BYVAL xtype AS GLenum, BYVAL xdata AS ANY PTR) AS GLint
DECLARE FUNCTION  gluCheckExtension 	  ALIAS "gluCheckExtension" 	  (BYVAL extName AS GLubyte ptr, BYVAL extString AS GLubyte ptr) AS GLboolean
DECLARE SUB  	  gluCylinder 			  ALIAS "gluCylinder"             (BYVAL quad AS GLUquadric PTR, BYVAL xbase AS GLdouble, BYVAL top AS GLdouble, BYVAL height AS GLdouble, BYVAL slices AS GLint, BYVAL stacks AS GLint)
DECLARE SUB  	  gluDeleteNurbsRenderer  ALIAS "gluDeleteNurbsRenderer"  (BYVAL nurb AS GLUnurbs PTR)
DECLARE SUB  	  gluDeleteQuadric 		  ALIAS "gluDeleteQuadric" 		  (BYVAL quad AS GLUquadric PTR)
DECLARE SUB  	  gluDeleteTess 		  ALIAS "gluDeleteTess" 		  (BYVAL tess AS GLUtesselator PTR)
DECLARE SUB  	  gluDisk 				  ALIAS "gluDisk" 				  (BYVAL quad AS GLUquadric PTR , BYVAL inner AS GLdouble, BYVAL outer AS GLdouble, BYVAL slices AS GLint, BYVAL loops AS GLint)
DECLARE SUB  	  gluEndCurve 			  ALIAS "gluEndCurve" 			  (BYVAL nurb AS GLUnurbs PTR)
DECLARE SUB  	  gluEndPolygon 		  ALIAS "gluEndPolygon" 		  (BYVAL tess AS GLUtesselator PTR)
DECLARE SUB  	  gluEndSurface 		  ALIAS "gluEndSurface" 		  (BYVAL nurb AS GLUnurbs PTR)
DECLARE SUB  	  gluEndTrim 			  ALIAS "gluEndTrim" 			  (BYVAL nurb AS GLUnurbs PTR)
DECLARE FUNCTION  gluErrorString 		  ALIAS "gluErrorString" 		  (BYVAL xerror AS GLenum) AS GLubyte PTR
DECLARE SUB  	  gluGetNurbsProperty 	  ALIAS "gluGetNurbsProperty" 	  (BYVAL nurb AS GLUnurbs PTR, BYVAL property AS GLenum, BYVAL xdata AS GLfloat PTR)
DECLARE FUNCTION  gluGetString 			  ALIAS "gluGetString" 			  (BYVAL name AS GLenum) AS GLubyte PTR
DECLARE SUB  	  gluGetTessProperty 	  ALIAS "gluGetTessProperty" 	  (BYVAL tess AS GLUtesselator PTR,  BYVAL which AS GLenum, BYVAL xdata AS GLdouble PTR)
DECLARE SUB  	  gluLoadSamplingMatrices ALIAS "gluLoadSamplingMatrices" (BYVAL nurb AS GLUnurbs PTR, BYVAL model AS GLfloat PTR, BYVAL perspective AS GLfloat PTR, BYVAL xview AS GLint PTR)
DECLARE SUB  	  gluLookAt 			  ALIAS "gluLookAt" 			  (BYVAL eyeX AS GLdouble, BYVAL eyeY AS GLdouble, BYVAL eyeZ AS GLdouble, BYVAL centerX AS GLdouble, BYVAL centerY AS GLdouble, BYVAL centerZ AS GLdouble, BYVAL upX AS GLdouble, BYVAL upY AS GLdouble, BYVAL upZ AS GLdouble)
DECLARE FUNCTION  gluNewNurbsRenderer 	  ALIAS "gluNewNurbsRenderer" 	  () AS GLUnurbs PTR
DECLARE FUNCTION  gluNewQuadric 		  ALIAS "gluNewQuadric" 		  () AS GLUquadric PTR
DECLARE FUNCTION  gluNewTess 			  ALIAS "gluNewTess" 			  () AS GLUtesselator PTR
DECLARE SUB  	  gluNextContour 		  ALIAS "gluNextContour" 		  (BYVAL tess AS GLUtesselator PTR, BYVAL xtype AS GLenum)
DECLARE SUB   	  gluNurbsCallback 		  ALIAS "gluNurbsCallback" 		  (BYVAL nurb AS GLUnurbs PTR, BYVAL which AS GLenum, CallBackFunc AS GLUfuncptr)
DECLARE SUB  	  gluNurbsCallbackData 	  ALIAS "gluNurbsCallbackData" 	  (BYVAL nurb AS GLUnurbs PTR, BYVAL userData AS GLvoid PTR)
DECLARE SUB  	  gluNurbsCallbackDataEXT ALIAS "gluNurbsCallbackDataEXT" (BYVAL nurb AS GLUnurbs PTR, BYVAL userData AS GLvoid PTR)
DECLARE SUB  	  gluNurbsCurve 		  ALIAS "gluNurbsCurve" 		  (BYVAL nurb AS GLUnurbs PTR, BYVAL knotCount AS GLint, BYVAL knots AS GLfloat PTR, BYVAL stride AS GLint, BYVAL control AS GLfloat PTR, BYVAL order AS GLint, BYVAL xtype AS GLenum)
DECLARE SUB  	  gluNurbsProperty 		  ALIAS "gluNurbsProperty" 		  (BYVAL nurb AS GLUnurbs PTR, BYVAL property AS GLenum, BYVAL value AS GLfloat)
DECLARE SUB  	  gluNurbsSurface 		  ALIAS "gluNurbsSurface" 		  (BYVAL nurb AS GLUnurbs PTR, BYVAL sKnotCount AS GLint, BYVAL sKnots AS GLfloat PTR, BYVAL tKnotCount AS GLint, BYVAL tKnots AS GLfloat PTR, BYVAL sStride AS GLint, BYVAL tStride AS GLint, BYVAL control AS GLfloat PTR, BYVAL sOrder AS GLint, BYVAL tOrder AS GLint, BYVAL xtype AS GLenum)
DECLARE SUB  	  gluOrtho2D 			  ALIAS "gluOrtho2D" 			  (BYVAL left AS GLdouble, BYVAL right AS GLdouble, BYVAL bottom AS GLdouble, BYVAL top AS GLdouble)
DECLARE SUB  	  gluPartialDisk 		  ALIAS "gluPartialDisk" 		  (BYVAL quad AS GLUquadric PTR, BYVAL inner AS GLdouble, BYVAL outer AS GLdouble, BYVAL slices AS GLint, BYVAL loops AS GLint, BYVAL start AS GLdouble, BYVAL sweep AS GLdouble)
DECLARE SUB  	  gluPerspective 		  ALIAS "gluPerspective" 		  (BYVAL fovy AS GLdouble, BYVAL aspect AS GLdouble, BYVAL zNear AS GLdouble, BYVAL zFar AS GLdouble)
DECLARE SUB  	  gluPickMatrix 		  ALIAS "gluPickMatrix" 		  (BYVAL x AS GLdouble, BYVAL y AS GLdouble, BYVAL delX AS GLdouble, BYVAL delY AS GLdouble, BYVAL viewport AS GLint PTR)
DECLARE FUNCTION  gluProject 			  ALIAS "gluProject" 			  (BYVAL objX AS GLdouble, BYVAL objY AS GLdouble, BYVAL objZ AS GLdouble, BYVAL model AS GLdouble PTR, BYVAL proj AS GLdouble PTR, BYVAL xview AS GLint PTR, BYVAL winX AS GLdouble PTR, BYVAL winY AS GLdouble PTR, BYVAL winZ AS GLdouble PTR) AS GLint
DECLARE SUB  	  gluPwlCurve 			  ALIAS "gluPwlCurve" 			  (BYVAL nurb AS GLUnurbs PTR, BYVAL count AS GLint, BYVAL xdata AS GLfloat PTR, BYVAL stride AS GLint, BYVAL xtype AS GLenum)
DECLARE SUB   	  gluQuadricCallback 	  ALIAS "gluQuadricCallback" 	  (BYVAL quad AS GLUquadric PTR, which AS GLenum, CallBackFunc AS GLUfuncptr)
DECLARE SUB  	  gluQuadricDrawStyle 	  ALIAS "gluQuadricDrawStyle" 	  (BYVAL quad AS GLUquadric PTR, BYVAL draw AS GLenum)
DECLARE SUB  	  gluQuadricNormals 	  ALIAS "gluQuadricNormals" 	  (BYVAL quad AS GLUquadric PTR, BYVAL normal AS GLenum)
DECLARE SUB  	  gluQuadricOrientation   ALIAS "gluQuadricOrientation"   (BYVAL quad AS GLUquadric PTR, BYVAL orientation AS GLenum)
DECLARE SUB  	  gluQuadricTexture 	  ALIAS "gluQuadricTexture" 	  (BYVAL quad AS GLUquadric PTR, BYVAL texture AS GLboolean)
DECLARE FUNCTION  gluScaleImage 		  ALIAS "gluScaleImage" 		  (BYVAL format AS GLenum, BYVAL wIn AS GLsizei, BYVAL hIn AS GLsizei, BYVAL typeIn AS GLenum, BYVAL dataIn AS ANY PTR, BYVAL wOut AS GLsizei, BYVAL hOut AS GLsizei, BYVAL typeOut AS GLenum, BYVAL dataOut AS ANY PTR) AS GLint
DECLARE SUB  	  gluSphere 			  ALIAS "gluSphere" 			  (BYVAL quad AS GLUquadric PTR, BYVAL radius AS GLdouble, BYVAL slices AS GLint, BYVAL stacks as GLint)
DECLARE SUB  	  gluTessBeginContour 	  ALIAS "gluTessBeginContour" 	  (BYVAL tess AS GLUtesselator PTR)
DECLARE SUB  	  gluTessBeginPolygon 	  ALIAS "gluTessBeginPolygon" 	  (BYVAL tess AS GLUtesselator PTR, BYVAL xdata as GLvoid PTR)
DECLARE SUB   	  gluTessCallback 		  ALIAS "gluTessCallback" 		  (BYVAL tess AS GLUtesselator PTR , which AS GLenum, CallBackFunc AS GLUfuncptr)
DECLARE SUB  	  gluTessEndContour 	  ALIAS "gluTessEndContour" 	  (BYVAL tess AS GLUtesselator PTR)
DECLARE SUB  	  gluTessEndPolygon 	  ALIAS "gluTessEndPolygon" 	  (BYVAL tess AS GLUtesselator PTR)
DECLARE SUB  	  gluTessNormal 		  ALIAS "gluTessNormal" 		  (BYVAL tess AS GLUtesselator PTR, BYVAL valueX AS GLdouble, BYVAL valueY AS GLdouble, BYVAL valueZ AS GLdouble)
DECLARE SUB  	  gluTessProperty 		  ALIAS "gluTessProperty" 		  (BYVAL tess AS GLUtesselator PTR, BYVAL which AS GLenum, BYVAL xdata AS GLdouble)
DECLARE SUB  	  gluTessVertex 		  ALIAS "gluTessVertex" 		  (BYVAL tess AS GLUtesselator PTR, BYVAL location AS GLdouble PTR, BYVAL xdata AS GLvoid PTR)
DECLARE FUNCTION  gluUnProject 			  ALIAS "gluUnProject" 			  (BYVAL winX AS GLdouble, BYVAL winY AS GLdouble, BYVAL winZ AS GLdouble, BYVAL model AS GLdouble PTR, BYVAL proj AS GLdouble PTR, BYVAL xview AS GLint PTR, BYVAL objX AS GLdouble PTR, BYVAL objY AS GLdouble PTR, BYVAL objZ AS GLdouble PTR) as GLint
DECLARE FUNCTION  gluUnProject4 		  ALIAS "gluUnProject4" 		  (BYVAL winX AS GLdouble, BYVAL winY AS GLdouble, BYVAL winZ AS GLdouble, BYVAL clipW AS GLdouble, BYVAL model AS GLdouble PTR, BYVAL proj AS GLdouble PTR, BYVAL xview AS GLint PTR, BYVAL nearVal AS GLdouble, BYVAL farVal AS GLdouble, BYVAL objX AS GLdouble PTR, BYVAL objY AS GLdouble PTR, BYVAL objZ AS GLdouble PTR, BYVAL objW AS GLdouble PTR) as GLint

#endif ''glu_bi
