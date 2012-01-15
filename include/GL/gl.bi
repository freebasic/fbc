/'
 * Mesa 3-D graphics library
 * Version:  4.0
 *
 * Copyright (C) 1999-2001  Brian Paul   All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * BRIAN PAUL BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 '/


/'***********************************************************************
 * 2002-Apr-22, José Fonseca:
 *   Removed non Win32 system-specific stuff
 *
 * 2002-Apr-17, Marcus Geelnard:
 *   For win32, OpenGL 1.2 & 1.3 definitions are not made in this file
 *   anymore, since under Windows those are regarded as extensions, and
 *   are better defined in glext.h (especially the function prototypes may
 *   conflict with extension function pointers). A few "cosmetical"
 *   changes were also made to this file.
 *
 * 2002-Apr-15, Marcus Geelnard:
 *   Modified this file to better fit a wider range of compilers, removed
 *   Mesa specific stuff, and removed extension definitions (this file now
 *   relies on GL/glext.h). Hopefully this file should now function as a
 *   generic OpenGL gl.h include file for most compilers and environments.
 *   Changed GLAPIENTRY to APIENTRY (to be consistent with GL/glext.h).
 *
 ***********************************************************************'/

#Ifndef __gl_bi__
#define __gl_bi__

#If Defined(__FB_WIN32__) Or Defined(__FB_CYGWIN__)
Extern "Windows"
#ElseIf Defined(__FB_UNIX__)
Extern "C"
#Else
Extern "C"
#EndIf

#If Defined(__FB_WIN32__)
#Inclib "opengl32"
#ElseIf Defined(__FB_LINUX__)
#Inclib "GL"
#ElseIf Defined(__FB_DOS__)
#Inclib "gl"
#EndIf


#define GL_VERSION_1_1   1

#Ifndef __FB_WIN32__
#define GL_VERSION_1_2   1
#define GL_VERSION_1_3   1
#define GL_ARB_imaging   1
#EndIf

/'
 *
 * Datatypes
 *
 '/
Type As UInteger GLenum
Type As UByte    GLboolean
Type As UInteger GLbitfield
Type As Any      GLvoid
Type As Byte     GLbyte     /' 1-byte signed '/
Type As Short    GLshort    /' 2-byte signed '/
Type As Integer  GLint      /' 4-byte signed '/
Type As UByte    GLubyte    /' 1-byte unsigned '/
Type As UShort   GLushort   /' 2-byte unsigned '/
Type As UInteger GLuint     /' 4-byte unsigned '/
Type As Integer  GLsizei    /' 4-byte signed '/
Type As Single   GLfloat    /' single precision float '/
Type As Single   GLclampf   /' single precision float in [0,1] '/
Type As Double   GLdouble   /' double precision float '/
Type As Double   GLclampd   /' double precision float in [0,1] '/



/'***********************************************************************
 *
 * Constants
 *
 ***********************************************************************'/

/' Boolean values '/
#define GL_FALSE                                &h0
#define GL_TRUE                                 &h1

/' Data types '/
#define GL_BYTE                                 &h1400
#define GL_UNSIGNED_BYTE                        &h1401
#define GL_SHORT                                &h1402
#define GL_UNSIGNED_SHORT                       &h1403
#define GL_INT                                  &h1404
#define GL_UNSIGNED_INT                         &h1405
#define GL_FLOAT                                &h1406
#define GL_DOUBLE                               &h140A
#define GL_2_BYTES                              &h1407
#define GL_3_BYTES                              &h1408
#define GL_4_BYTES                              &h1409

/' Primitives '/
#define GL_POINTS                               &h0000
#define GL_LINES                                &h0001
#define GL_LINE_LOOP                            &h0002
#define GL_LINE_STRIP                           &h0003
#define GL_TRIANGLES                            &h0004
#define GL_TRIANGLE_STRIP                       &h0005
#define GL_TRIANGLE_FAN                         &h0006
#define GL_QUADS                                &h0007
#define GL_QUAD_STRIP                           &h0008
#define GL_POLYGON                              &h0009

/' Vertex Arrays '/
#define GL_VERTEX_ARRAY                         &h8074
#define GL_NORMAL_ARRAY                         &h8075
#define GL_COLOR_ARRAY                          &h8076
#define GL_INDEX_ARRAY                          &h8077
#define GL_TEXTURE_COORD_ARRAY                  &h8078
#define GL_EDGE_FLAG_ARRAY                      &h8079
#define GL_VERTEX_ARRAY_SIZE                    &h807A
#define GL_VERTEX_ARRAY_TYPE                    &h807B
#define GL_VERTEX_ARRAY_STRIDE                  &h807C
#define GL_NORMAL_ARRAY_TYPE                    &h807E
#define GL_NORMAL_ARRAY_STRIDE                  &h807F
#define GL_COLOR_ARRAY_SIZE                     &h8081
#define GL_COLOR_ARRAY_TYPE                     &h8082
#define GL_COLOR_ARRAY_STRIDE                   &h8083
#define GL_INDEX_ARRAY_TYPE                     &h8085
#define GL_INDEX_ARRAY_STRIDE                   &h8086
#define GL_TEXTURE_COORD_ARRAY_SIZE             &h8088
#define GL_TEXTURE_COORD_ARRAY_TYPE             &h8089
#define GL_TEXTURE_COORD_ARRAY_STRIDE           &h808A
#define GL_EDGE_FLAG_ARRAY_STRIDE               &h808C
#define GL_VERTEX_ARRAY_POINTER                 &h808E
#define GL_NORMAL_ARRAY_POINTER                 &h808F
#define GL_COLOR_ARRAY_POINTER                  &h8090
#define GL_INDEX_ARRAY_POINTER                  &h8091
#define GL_TEXTURE_COORD_ARRAY_POINTER          &h8092
#define GL_EDGE_FLAG_ARRAY_POINTER              &h8093
#define GL_V2F                                  &h2A20
#define GL_V3F                                  &h2A21
#define GL_C4UB_V2F                             &h2A22
#define GL_C4UB_V3F                             &h2A23
#define GL_C3F_V3F                              &h2A24
#define GL_N3F_V3F                              &h2A25
#define GL_C4F_N3F_V3F                          &h2A26
#define GL_T2F_V3F                              &h2A27
#define GL_T4F_V4F                              &h2A28
#define GL_T2F_C4UB_V3F                         &h2A29
#define GL_T2F_C3F_V3F                          &h2A2A
#define GL_T2F_N3F_V3F                          &h2A2B
#define GL_T2F_C4F_N3F_V3F                      &h2A2C
#define GL_T4F_C4F_N3F_V4F                      &h2A2D

/' Matrix Mode '/
#define GL_MATRIX_MODE                          &h0BA0
#define GL_MODELVIEW                            &h1700
#define GL_PROJECTION                           &h1701
#define GL_TEXTURE                              &h1702

/' Points '/
#define GL_POINT_SMOOTH                         &h0B10
#define GL_POINT_SIZE                           &h0B11
#define GL_POINT_SIZE_GRANULARITY               &h0B13
#define GL_POINT_SIZE_RANGE                     &h0B12

/' Lines '/
#define GL_LINE_SMOOTH                          &h0B20
#define GL_LINE_STIPPLE                         &h0B24
#define GL_LINE_STIPPLE_PATTERN                 &h0B25
#define GL_LINE_STIPPLE_REPEAT                  &h0B26
#define GL_LINE_WIDTH                           &h0B21
#define GL_LINE_WIDTH_GRANULARITY               &h0B23
#define GL_LINE_WIDTH_RANGE                     &h0B22

/' Polygons '/
#define GL_POINT                                &h1B00
#define GL_LINE                                 &h1B01
#define GL_FILL                                 &h1B02
#define GL_CW                                   &h0900
#define GL_CCW                                  &h0901
#define GL_FRONT                                &h0404
#define GL_BACK                                 &h0405
#define GL_POLYGON_MODE                         &h0B40
#define GL_POLYGON_SMOOTH                       &h0B41
#define GL_POLYGON_STIPPLE                      &h0B42
#define GL_EDGE_FLAG                            &h0B43
#define GL_CULL_FACE                            &h0B44
#define GL_CULL_FACE_MODE                       &h0B45
#define GL_FRONT_FACE                           &h0B46
#define GL_POLYGON_OFFSET_FACTOR                &h8038
#define GL_POLYGON_OFFSET_UNITS                 &h2A00
#define GL_POLYGON_OFFSET_POINT                 &h2A01
#define GL_POLYGON_OFFSET_LINE                  &h2A02
#define GL_POLYGON_OFFSET_FILL                  &h8037

/' Display Lists '/
#define GL_COMPILE                              &h1300
#define GL_COMPILE_AND_EXECUTE                  &h1301
#define GL_LIST_BASE                            &h0B32
#define GL_LIST_INDEX                           &h0B33
#define GL_LIST_MODE                            &h0B30

/' Depth buffer '/
#define GL_NEVER                                &h0200
#define GL_LESS                                 &h0201
#define GL_EQUAL                                &h0202
#define GL_LEQUAL                               &h0203
#define GL_GREATER                              &h0204
#define GL_NOTEQUAL                             &h0205
#define GL_GEQUAL                               &h0206
#define GL_ALWAYS                               &h0207
#define GL_DEPTH_TEST                           &h0B71
#define GL_DEPTH_BITS                           &h0D56
#define GL_DEPTH_CLEAR_VALUE                    &h0B73
#define GL_DEPTH_FUNC                           &h0B74
#define GL_DEPTH_RANGE                          &h0B70
#define GL_DEPTH_WRITEMASK                      &h0B72
#define GL_DEPTH_COMPONENT                      &h1902

/' Lighting '/
#define GL_LIGHTING                             &h0B50
#define GL_LIGHT0                               &h4000
#define GL_LIGHT1                               &h4001
#define GL_LIGHT2                               &h4002
#define GL_LIGHT3                               &h4003
#define GL_LIGHT4                               &h4004
#define GL_LIGHT5                               &h4005
#define GL_LIGHT6                               &h4006
#define GL_LIGHT7                               &h4007
#define GL_SPOT_EXPONENT                        &h1205
#define GL_SPOT_CUTOFF                          &h1206
#define GL_CONSTANT_ATTENUATION                 &h1207
#define GL_LINEAR_ATTENUATION                   &h1208
#define GL_QUADRATIC_ATTENUATION                &h1209
#define GL_AMBIENT                              &h1200
#define GL_DIFFUSE                              &h1201
#define GL_SPECULAR                             &h1202
#define GL_SHININESS                            &h1601
#define GL_EMISSION                             &h1600
#define GL_POSITION                             &h1203
#define GL_SPOT_DIRECTION                       &h1204
#define GL_AMBIENT_AND_DIFFUSE                  &h1602
#define GL_COLOR_INDEXES                        &h1603
#define GL_LIGHT_MODEL_TWO_SIDE                 &h0B52
#define GL_LIGHT_MODEL_LOCAL_VIEWER             &h0B51
#define GL_LIGHT_MODEL_AMBIENT                  &h0B53
#define GL_FRONT_AND_BACK                       &h0408
#define GL_SHADE_MODEL                          &h0B54
#define GL_FLAT                                 &h1D00
#define GL_SMOOTH                               &h1D01
#define GL_COLOR_MATERIAL                       &h0B57
#define GL_COLOR_MATERIAL_FACE                  &h0B55
#define GL_COLOR_MATERIAL_PARAMETER             &h0B56
#define GL_NORMALIZE                            &h0BA1

/' User clipping planes '/
#define GL_CLIP_PLANE0                          &h3000
#define GL_CLIP_PLANE1                          &h3001
#define GL_CLIP_PLANE2                          &h3002
#define GL_CLIP_PLANE3                          &h3003
#define GL_CLIP_PLANE4                          &h3004
#define GL_CLIP_PLANE5                          &h3005

/' Accumulation buffer '/
#define GL_ACCUM_RED_BITS                       &h0D58
#define GL_ACCUM_GREEN_BITS                     &h0D59
#define GL_ACCUM_BLUE_BITS                      &h0D5A
#define GL_ACCUM_ALPHA_BITS                     &h0D5B
#define GL_ACCUM_CLEAR_VALUE                    &h0B80
#define GL_ACCUM                                &h0100
#define GL_ADD                                  &h0104
#define GL_LOAD                                 &h0101
#define GL_MULT                                 &h0103
#define GL_RETURN                               &h0102

/' Alpha testing '/
#define GL_ALPHA_TEST                           &h0BC0
#define GL_ALPHA_TEST_REF                       &h0BC2
#define GL_ALPHA_TEST_FUNC                      &h0BC1

/' Blending '/
#define GL_BLEND                                &h0BE2
#define GL_BLEND_SRC                            &h0BE1
#define GL_BLEND_DST                            &h0BE0
#define GL_ZERO                                 &h0
#define GL_ONE                                  &h1
#define GL_SRC_COLOR                            &h0300
#define GL_ONE_MINUS_SRC_COLOR                  &h0301
#define GL_SRC_ALPHA                            &h0302
#define GL_ONE_MINUS_SRC_ALPHA                  &h0303
#define GL_DST_ALPHA                            &h0304
#define GL_ONE_MINUS_DST_ALPHA                  &h0305
#define GL_DST_COLOR                            &h0306
#define GL_ONE_MINUS_DST_COLOR                  &h0307
#define GL_SRC_ALPHA_SATURATE                   &h0308
#define GL_CONSTANT_COLOR                       &h8001
#define GL_ONE_MINUS_CONSTANT_COLOR             &h8002
#define GL_CONSTANT_ALPHA                       &h8003
#define GL_ONE_MINUS_CONSTANT_ALPHA             &h8004

/' Render Mode '/
#define GL_FEEDBACK                             &h1C01
#define GL_RENDER                               &h1C00
#define GL_SELECT                               &h1C02

/' Feedback '/
#define GL_2D                                   &h0600
#define GL_3D                                   &h0601
#define GL_3D_COLOR                             &h0602
#define GL_3D_COLOR_TEXTURE                     &h0603
#define GL_4D_COLOR_TEXTURE                     &h0604
#define GL_POINT_TOKEN                          &h0701
#define GL_LINE_TOKEN                           &h0702
#define GL_LINE_RESET_TOKEN                     &h0707
#define GL_POLYGON_TOKEN                        &h0703
#define GL_BITMAP_TOKEN                         &h0704
#define GL_DRAW_PIXEL_TOKEN                     &h0705
#define GL_COPY_PIXEL_TOKEN                     &h0706
#define GL_PASS_THROUGH_TOKEN                   &h0700
#define GL_FEEDBACK_BUFFER_POINTER              &h0DF0
#define GL_FEEDBACK_BUFFER_SIZE                 &h0DF1
#define GL_FEEDBACK_BUFFER_TYPE                 &h0DF2

/' Selection '/
#define GL_SELECTION_BUFFER_POINTER             &h0DF3
#define GL_SELECTION_BUFFER_SIZE                &h0DF4

/' Fog '/
#define GL_FOG                                  &h0B60
#define GL_FOG_MODE                             &h0B65
#define GL_FOG_DENSITY                          &h0B62
#define GL_FOG_COLOR                            &h0B66
#define GL_FOG_INDEX                            &h0B61
#define GL_FOG_START                            &h0B63
#define GL_FOG_END                              &h0B64
#define GL_LINEAR                               &h2601
#define GL_EXP                                  &h0800
#define GL_EXP2                                 &h0801

/' Logic Ops '/
#define GL_LOGIC_OP                             &h0BF1
#define GL_INDEX_LOGIC_OP                       &h0BF1
#define GL_COLOR_LOGIC_OP                       &h0BF2
#define GL_LOGIC_OP_MODE                        &h0BF0
#define GL_CLEAR                                &h1500
#define GL_SET                                  &h150F
#define GL_COPY                                 &h1503
#define GL_COPY_INVERTED                        &h150C
#define GL_NOOP                                 &h1505
#define GL_INVERT                               &h150A
#define GL_AND                                  &h1501
#define GL_NAND                                 &h150E
#define GL_OR                                   &h1507
#define GL_NOR                                  &h1508
#define GL_XOR                                  &h1506
#define GL_EQUIV                                &h1509
#define GL_AND_REVERSE                          &h1502
#define GL_AND_INVERTED                         &h1504
#define GL_OR_REVERSE                           &h150B
#define GL_OR_INVERTED                          &h150D

/' Stencil '/
#define GL_STENCIL_TEST                         &h0B90
#define GL_STENCIL_WRITEMASK                    &h0B98
#define GL_STENCIL_BITS                         &h0D57
#define GL_STENCIL_FUNC                         &h0B92
#define GL_STENCIL_VALUE_MASK                   &h0B93
#define GL_STENCIL_REF                          &h0B97
#define GL_STENCIL_FAIL                         &h0B94
#define GL_STENCIL_PASS_DEPTH_PASS              &h0B96
#define GL_STENCIL_PASS_DEPTH_FAIL              &h0B95
#define GL_STENCIL_CLEAR_VALUE                  &h0B91
#define GL_STENCIL_INDEX                        &h1901
#define GL_KEEP                                 &h1E00
#define GL_REPLACE                              &h1E01
#define GL_INCR                                 &h1E02
#define GL_DECR                                 &h1E03

/' Buffers, Pixel Drawing/Reading '/
#define GL_NONE                                 &h0
#define GL_LEFT                                 &h0406
#define GL_RIGHT                                &h0407
/'GL_FRONT                                      &h0404 '/
/'GL_BACK                                       &h0405 '/
/'GL_FRONT_AND_BACK                             &h0408 '/
#define GL_FRONT_LEFT                           &h0400
#define GL_FRONT_RIGHT                          &h0401
#define GL_BACK_LEFT                            &h0402
#define GL_BACK_RIGHT                           &h0403
#define GL_AUX0                                 &h0409
#define GL_AUX1                                 &h040A
#define GL_AUX2                                 &h040B
#define GL_AUX3                                 &h040C
#define GL_COLOR_INDEX                          &h1900
#define GL_RED                                  &h1903
#define GL_GREEN                                &h1904
#define GL_BLUE                                 &h1905
#define GL_ALPHA                                &h1906
#define GL_LUMINANCE                            &h1909
#define GL_LUMINANCE_ALPHA                      &h190A
#define GL_ALPHA_BITS                           &h0D55
#define GL_RED_BITS                             &h0D52
#define GL_GREEN_BITS                           &h0D53
#define GL_BLUE_BITS                            &h0D54
#define GL_INDEX_BITS                           &h0D51
#define GL_SUBPIXEL_BITS                        &h0D50
#define GL_AUX_BUFFERS                          &h0C00
#define GL_READ_BUFFER                          &h0C02
#define GL_DRAW_BUFFER                          &h0C01
#define GL_DOUBLEBUFFER                         &h0C32
#define GL_STEREO                               &h0C33
#define GL_BITMAP                               &h1A00
#define GL_COLOR                                &h1800
#define GL_DEPTH                                &h1801
#define GL_STENCIL                              &h1802
#define GL_DITHER                               &h0BD0
#define GL_RGB                                  &h1907
#define GL_RGBA                                 &h1908

/' Implementation limits '/
#define GL_MAX_LIST_NESTING                     &h0B31
#define GL_MAX_ATTRIB_STACK_DEPTH               &h0D35
#define GL_MAX_MODELVIEW_STACK_DEPTH            &h0D36
#define GL_MAX_NAME_STACK_DEPTH                 &h0D37
#define GL_MAX_PROJECTION_STACK_DEPTH           &h0D38
#define GL_MAX_TEXTURE_STACK_DEPTH              &h0D39
#define GL_MAX_EVAL_ORDER                       &h0D30
#define GL_MAX_LIGHTS                           &h0D31
#define GL_MAX_CLIP_PLANES                      &h0D32
#define GL_MAX_TEXTURE_SIZE                     &h0D33
#define GL_MAX_PIXEL_MAP_TABLE                  &h0D34
#define GL_MAX_VIEWPORT_DIMS                    &h0D3A
#define GL_MAX_CLIENT_ATTRIB_STACK_DEPTH        &h0D3B

/' Gets '/
#define GL_ATTRIB_STACK_DEPTH                   &h0BB0
#define GL_CLIENT_ATTRIB_STACK_DEPTH            &h0BB1
#define GL_COLOR_CLEAR_VALUE                    &h0C22
#define GL_COLOR_WRITEMASK                      &h0C23
#define GL_CURRENT_INDEX                        &h0B01
#define GL_CURRENT_COLOR                        &h0B00
#define GL_CURRENT_NORMAL                       &h0B02
#define GL_CURRENT_RASTER_COLOR                 &h0B04
#define GL_CURRENT_RASTER_DISTANCE              &h0B09
#define GL_CURRENT_RASTER_INDEX                 &h0B05
#define GL_CURRENT_RASTER_POSITION              &h0B07
#define GL_CURRENT_RASTER_TEXTURE_COORDS        &h0B06
#define GL_CURRENT_RASTER_POSITION_VALID        &h0B08
#define GL_CURRENT_TEXTURE_COORDS               &h0B03
#define GL_INDEX_CLEAR_VALUE                    &h0C20
#define GL_INDEX_MODE                           &h0C30
#define GL_INDEX_WRITEMASK                      &h0C21
#define GL_MODELVIEW_MATRIX                     &h0BA6
#define GL_MODELVIEW_STACK_DEPTH                &h0BA3
#define GL_NAME_STACK_DEPTH                     &h0D70
#define GL_PROJECTION_MATRIX                    &h0BA7
#define GL_PROJECTION_STACK_DEPTH               &h0BA4
#define GL_RENDER_MODE                          &h0C40
#define GL_RGBA_MODE                            &h0C31
#define GL_TEXTURE_MATRIX                       &h0BA8
#define GL_TEXTURE_STACK_DEPTH                  &h0BA5
#define GL_VIEWPORT                             &h0BA2

/' Evaluators '/
#define GL_AUTO_NORMAL                          &h0D80
#define GL_MAP1_COLOR_4                         &h0D90
#define GL_MAP1_GRID_DOMAIN                     &h0DD0
#define GL_MAP1_GRID_SEGMENTS                   &h0DD1
#define GL_MAP1_INDEX                           &h0D91
#define GL_MAP1_NORMAL                          &h0D92
#define GL_MAP1_TEXTURE_COORD_1                 &h0D93
#define GL_MAP1_TEXTURE_COORD_2                 &h0D94
#define GL_MAP1_TEXTURE_COORD_3                 &h0D95
#define GL_MAP1_TEXTURE_COORD_4                 &h0D96
#define GL_MAP1_VERTEX_3                        &h0D97
#define GL_MAP1_VERTEX_4                        &h0D98
#define GL_MAP2_COLOR_4                         &h0DB0
#define GL_MAP2_GRID_DOMAIN                     &h0DD2
#define GL_MAP2_GRID_SEGMENTS                   &h0DD3
#define GL_MAP2_INDEX                           &h0DB1
#define GL_MAP2_NORMAL                          &h0DB2
#define GL_MAP2_TEXTURE_COORD_1                 &h0DB3
#define GL_MAP2_TEXTURE_COORD_2                 &h0DB4
#define GL_MAP2_TEXTURE_COORD_3                 &h0DB5
#define GL_MAP2_TEXTURE_COORD_4                 &h0DB6
#define GL_MAP2_VERTEX_3                        &h0DB7
#define GL_MAP2_VERTEX_4                        &h0DB8
#define GL_COEFF                                &h0A00
#define GL_DOMAIN                               &h0A02
#define GL_ORDER                                &h0A01

/' Hints '/
#define GL_FOG_HINT                             &h0C54
#define GL_LINE_SMOOTH_HINT                     &h0C52
#define GL_PERSPECTIVE_CORRECTION_HINT          &h0C50
#define GL_POINT_SMOOTH_HINT                    &h0C51
#define GL_POLYGON_SMOOTH_HINT                  &h0C53
#define GL_DONT_CARE                            &h1100
#define GL_FASTEST                              &h1101
#define GL_NICEST                               &h1102

/' Scissor box '/
#define GL_SCISSOR_TEST                         &h0C11
#define GL_SCISSOR_BOX                          &h0C10

/' Pixel Mode / Transfer '/
#define GL_MAP_COLOR                            &h0D10
#define GL_MAP_STENCIL                          &h0D11
#define GL_INDEX_SHIFT                          &h0D12
#define GL_INDEX_OFFSET                         &h0D13
#define GL_RED_SCALE                            &h0D14
#define GL_RED_BIAS                             &h0D15
#define GL_GREEN_SCALE                          &h0D18
#define GL_GREEN_BIAS                           &h0D19
#define GL_BLUE_SCALE                           &h0D1A
#define GL_BLUE_BIAS                            &h0D1B
#define GL_ALPHA_SCALE                          &h0D1C
#define GL_ALPHA_BIAS                           &h0D1D
#define GL_DEPTH_SCALE                          &h0D1E
#define GL_DEPTH_BIAS                           &h0D1F
#define GL_PIXEL_MAP_S_TO_S_SIZE                &h0CB1
#define GL_PIXEL_MAP_I_TO_I_SIZE                &h0CB0
#define GL_PIXEL_MAP_I_TO_R_SIZE                &h0CB2
#define GL_PIXEL_MAP_I_TO_G_SIZE                &h0CB3
#define GL_PIXEL_MAP_I_TO_B_SIZE                &h0CB4
#define GL_PIXEL_MAP_I_TO_A_SIZE                &h0CB5
#define GL_PIXEL_MAP_R_TO_R_SIZE                &h0CB6
#define GL_PIXEL_MAP_G_TO_G_SIZE                &h0CB7
#define GL_PIXEL_MAP_B_TO_B_SIZE                &h0CB8
#define GL_PIXEL_MAP_A_TO_A_SIZE                &h0CB9
#define GL_PIXEL_MAP_S_TO_S                     &h0C71
#define GL_PIXEL_MAP_I_TO_I                     &h0C70
#define GL_PIXEL_MAP_I_TO_R                     &h0C72
#define GL_PIXEL_MAP_I_TO_G                     &h0C73
#define GL_PIXEL_MAP_I_TO_B                     &h0C74
#define GL_PIXEL_MAP_I_TO_A                     &h0C75
#define GL_PIXEL_MAP_R_TO_R                     &h0C76
#define GL_PIXEL_MAP_G_TO_G                     &h0C77
#define GL_PIXEL_MAP_B_TO_B                     &h0C78
#define GL_PIXEL_MAP_A_TO_A                     &h0C79
#define GL_PACK_ALIGNMENT                       &h0D05
#define GL_PACK_LSB_FIRST                       &h0D01
#define GL_PACK_ROW_LENGTH                      &h0D02
#define GL_PACK_SKIP_PIXELS                     &h0D04
#define GL_PACK_SKIP_ROWS                       &h0D03
#define GL_PACK_SWAP_BYTES                      &h0D00
#define GL_UNPACK_ALIGNMENT                     &h0CF5
#define GL_UNPACK_LSB_FIRST                     &h0CF1
#define GL_UNPACK_ROW_LENGTH                    &h0CF2
#define GL_UNPACK_SKIP_PIXELS                   &h0CF4
#define GL_UNPACK_SKIP_ROWS                     &h0CF3
#define GL_UNPACK_SWAP_BYTES                    &h0CF0
#define GL_ZOOM_X                               &h0D16
#define GL_ZOOM_Y                               &h0D17

/' Texture mapping '/
#define GL_TEXTURE_ENV                          &h2300
#define GL_TEXTURE_ENV_MODE                     &h2200
#define GL_TEXTURE_1D                           &h0DE0
#define GL_TEXTURE_2D                           &h0DE1
#define GL_TEXTURE_WRAP_S                       &h2802
#define GL_TEXTURE_WRAP_T                       &h2803
#define GL_TEXTURE_MAG_FILTER                   &h2800
#define GL_TEXTURE_MIN_FILTER                   &h2801
#define GL_TEXTURE_ENV_COLOR                    &h2201
#define GL_TEXTURE_GEN_S                        &h0C60
#define GL_TEXTURE_GEN_T                        &h0C61
#define GL_TEXTURE_GEN_MODE                     &h2500
#define GL_TEXTURE_BORDER_COLOR                 &h1004
#define GL_TEXTURE_WIDTH                        &h1000
#define GL_TEXTURE_HEIGHT                       &h1001
#define GL_TEXTURE_BORDER                       &h1005
#define GL_TEXTURE_COMPONENTS                   &h1003
#define GL_TEXTURE_RED_SIZE                     &h805C
#define GL_TEXTURE_GREEN_SIZE                   &h805D
#define GL_TEXTURE_BLUE_SIZE                    &h805E
#define GL_TEXTURE_ALPHA_SIZE                   &h805F
#define GL_TEXTURE_LUMINANCE_SIZE               &h8060
#define GL_TEXTURE_INTENSITY_SIZE               &h8061
#define GL_NEAREST_MIPMAP_NEAREST               &h2700
#define GL_NEAREST_MIPMAP_LINEAR                &h2702
#define GL_LINEAR_MIPMAP_NEAREST                &h2701
#define GL_LINEAR_MIPMAP_LINEAR                 &h2703
#define GL_OBJECT_LINEAR                        &h2401
#define GL_OBJECT_PLANE                         &h2501
#define GL_EYE_LINEAR                           &h2400
#define GL_EYE_PLANE                            &h2502
#define GL_SPHERE_MAP                           &h2402
#define GL_DECAL                                &h2101
#define GL_MODULATE                             &h2100
#define GL_NEAREST                              &h2600
#define GL_REPEAT                               &h2901
#define GL_CLAMP                                &h2900
#define GL_S                                    &h2000
#define GL_T                                    &h2001
#define GL_R                                    &h2002
#define GL_Q                                    &h2003
#define GL_TEXTURE_GEN_R                        &h0C62
#define GL_TEXTURE_GEN_Q                        &h0C63

/' Utility '/
#define GL_VENDOR                               &h1F00
#define GL_RENDERER                             &h1F01
#define GL_VERSION                              &h1F02
#define GL_EXTENSIONS                           &h1F03

/' Errors '/
#define GL_NO_ERROR                             &h0
#define GL_INVALID_VALUE                        &h0501
#define GL_INVALID_ENUM                         &h0500
#define GL_INVALID_OPERATION                    &h0502
#define GL_STACK_OVERFLOW                       &h0503
#define GL_STACK_UNDERFLOW                      &h0504
#define GL_OUT_OF_MEMORY                        &h0505

/' glPush/PopAttrib bits '/
#define GL_CURRENT_BIT                          &h00000001
#define GL_POINT_BIT                            &h00000002
#define GL_LINE_BIT                             &h00000004
#define GL_POLYGON_BIT                          &h00000008
#define GL_POLYGON_STIPPLE_BIT                  &h00000010
#define GL_PIXEL_MODE_BIT                       &h00000020
#define GL_LIGHTING_BIT                         &h00000040
#define GL_FOG_BIT                              &h00000080
#define GL_DEPTH_BUFFER_BIT                     &h00000100
#define GL_ACCUM_BUFFER_BIT                     &h00000200
#define GL_STENCIL_BUFFER_BIT                   &h00000400
#define GL_VIEWPORT_BIT                         &h00000800
#define GL_TRANSFORM_BIT                        &h00001000
#define GL_ENABLE_BIT                           &h00002000
#define GL_COLOR_BUFFER_BIT                     &h00004000
#define GL_HINT_BIT                             &h00008000
#define GL_EVAL_BIT                             &h00010000
#define GL_LIST_BIT                             &h00020000
#define GL_TEXTURE_BIT                          &h00040000
#define GL_SCISSOR_BIT                          &h00080000
#define GL_ALL_ATTRIB_BITS                      &h000FFFFF


/' OpenGL 1.1 '/
#define GL_PROXY_TEXTURE_1D                     &h8063
#define GL_PROXY_TEXTURE_2D                     &h8064
#define GL_TEXTURE_PRIORITY                     &h8066
#define GL_TEXTURE_RESIDENT                     &h8067
#define GL_TEXTURE_BINDING_1D                   &h8068
#define GL_TEXTURE_BINDING_2D                   &h8069
#define GL_TEXTURE_INTERNAL_FORMAT              &h1003
#define GL_ALPHA4                               &h803B
#define GL_ALPHA8                               &h803C
#define GL_ALPHA12                              &h803D
#define GL_ALPHA16                              &h803E
#define GL_LUMINANCE4                           &h803F
#define GL_LUMINANCE8                           &h8040
#define GL_LUMINANCE12                          &h8041
#define GL_LUMINANCE16                          &h8042
#define GL_LUMINANCE4_ALPHA4                    &h8043
#define GL_LUMINANCE6_ALPHA2                    &h8044
#define GL_LUMINANCE8_ALPHA8                    &h8045
#define GL_LUMINANCE12_ALPHA4                   &h8046
#define GL_LUMINANCE12_ALPHA12                  &h8047
#define GL_LUMINANCE16_ALPHA16                  &h8048
#define GL_INTENSITY                            &h8049
#define GL_INTENSITY4                           &h804A
#define GL_INTENSITY8                           &h804B
#define GL_INTENSITY12                          &h804C
#define GL_INTENSITY16                          &h804D
#define GL_R3_G3_B2                             &h2A10
#define GL_RGB4                                 &h804F
#define GL_RGB5                                 &h8050
#define GL_RGB8                                 &h8051
#define GL_RGB10                                &h8052
#define GL_RGB12                                &h8053
#define GL_RGB16                                &h8054
#define GL_RGBA2                                &h8055
#define GL_RGBA4                                &h8056
#define GL_RGB5_A1                              &h8057
#define GL_RGBA8                                &h8058
#define GL_RGB10_A2                             &h8059
#define GL_RGBA12                               &h805A
#define GL_RGBA16                               &h805B
#define GL_CLIENT_PIXEL_STORE_BIT               &h00000001
#define GL_CLIENT_VERTEX_ARRAY_BIT              &h00000002
#define GL_ALL_CLIENT_ATTRIB_BITS               &hFFFFFFFF
#define GL_CLIENT_ALL_ATTRIB_BITS               &hFFFFFFFF


/' Under Windows, we do not define OpenGL 1.2 & 1.3 functionality, since
   it is treated as extensions (defined in glext.h) '/
#Ifndef __FB_WIN32__

/' OpenGL 1.2 '/
#define GL_RESCALE_NORMAL                       &h803A
#define GL_CLAMP_TO_EDGE                        &h812F
#define GL_MAX_ELEMENTS_VERTICES                &h80E8
#define GL_MAX_ELEMENTS_INDICES                 &h80E9
#define GL_BGR                                  &h80E0
#define GL_BGRA                                 &h80E1
#define GL_UNSIGNED_BYTE_3_3_2                  &h8032
#define GL_UNSIGNED_BYTE_2_3_3_REV              &h8362
#define GL_UNSIGNED_SHORT_5_6_5                 &h8363
#define GL_UNSIGNED_SHORT_5_6_5_REV             &h8364
#define GL_UNSIGNED_SHORT_4_4_4_4               &h8033
#define GL_UNSIGNED_SHORT_4_4_4_4_REV           &h8365
#define GL_UNSIGNED_SHORT_5_5_5_1               &h8034
#define GL_UNSIGNED_SHORT_1_5_5_5_REV           &h8366
#define GL_UNSIGNED_INT_8_8_8_8                 &h8035
#define GL_UNSIGNED_INT_8_8_8_8_REV             &h8367
#define GL_UNSIGNED_INT_10_10_10_2              &h8036
#define GL_UNSIGNED_INT_2_10_10_10_REV          &h8368
#define GL_LIGHT_MODEL_COLOR_CONTROL            &h81F8
#define GL_SINGLE_COLOR                         &h81F9
#define GL_SEPARATE_SPECULAR_COLOR              &h81FA
#define GL_TEXTURE_MIN_LOD                      &h813A
#define GL_TEXTURE_MAX_LOD                      &h813B
#define GL_TEXTURE_BASE_LEVEL                   &h813C
#define GL_TEXTURE_MAX_LEVEL                    &h813D
#define GL_SMOOTH_POINT_SIZE_RANGE              &h0B12
#define GL_SMOOTH_POINT_SIZE_GRANULARITY        &h0B13
#define GL_SMOOTH_LINE_WIDTH_RANGE              &h0B22
#define GL_SMOOTH_LINE_WIDTH_GRANULARITY        &h0B23
#define GL_ALIASED_POINT_SIZE_RANGE             &h846D
#define GL_ALIASED_LINE_WIDTH_RANGE             &h846E
#define GL_PACK_SKIP_IMAGES                     &h806B
#define GL_PACK_IMAGE_HEIGHT                    &h806C
#define GL_UNPACK_SKIP_IMAGES                   &h806D
#define GL_UNPACK_IMAGE_HEIGHT                  &h806E
#define GL_TEXTURE_3D                           &h806F
#define GL_PROXY_TEXTURE_3D                     &h8070
#define GL_TEXTURE_DEPTH                        &h8071
#define GL_TEXTURE_WRAP_R                       &h8072
#define GL_MAX_3D_TEXTURE_SIZE                  &h8073
#define GL_TEXTURE_BINDING_3D                   &h806A

/' OpenGL 1.2 imaging subset '/
/' GL_EXT_color_table '/
#define GL_COLOR_TABLE                          &h80D0
#define GL_POST_CONVOLUTION_COLOR_TABLE         &h80D1
#define GL_POST_COLOR_MATRIX_COLOR_TABLE        &h80D2
#define GL_PROXY_COLOR_TABLE                    &h80D3
#define GL_PROXY_POST_CONVOLUTION_COLOR_TABLE   &h80D4
#define GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE  &h80D5
#define GL_COLOR_TABLE_SCALE                    &h80D6
#define GL_COLOR_TABLE_BIAS                     &h80D7
#define GL_COLOR_TABLE_FORMAT                   &h80D8
#define GL_COLOR_TABLE_WIDTH                    &h80D9
#define GL_COLOR_TABLE_RED_SIZE                 &h80DA
#define GL_COLOR_TABLE_GREEN_SIZE               &h80DB
#define GL_COLOR_TABLE_BLUE_SIZE                &h80DC
#define GL_COLOR_TABLE_ALPHA_SIZE               &h80DD
#define GL_COLOR_TABLE_LUMINANCE_SIZE           &h80DE
#define GL_COLOR_TABLE_INTENSITY_SIZE           &h80DF
/' GL_EXT_convolution and GL_HP_convolution_border_modes '/
#define GL_CONVOLUTION_1D                       &h8010
#define GL_CONVOLUTION_2D                       &h8011
#define GL_SEPARABLE_2D                         &h8012
#define GL_CONVOLUTION_BORDER_MODE              &h8013
#define GL_CONVOLUTION_FILTER_SCALE             &h8014
#define GL_CONVOLUTION_FILTER_BIAS              &h8015
#define GL_REDUCE                               &h8016
#define GL_CONVOLUTION_FORMAT                   &h8017
#define GL_CONVOLUTION_WIDTH                    &h8018
#define GL_CONVOLUTION_HEIGHT                   &h8019
#define GL_MAX_CONVOLUTION_WIDTH                &h801A
#define GL_MAX_CONVOLUTION_HEIGHT               &h801B
#define GL_POST_CONVOLUTION_RED_SCALE           &h801C
#define GL_POST_CONVOLUTION_GREEN_SCALE         &h801D
#define GL_POST_CONVOLUTION_BLUE_SCALE          &h801E
#define GL_POST_CONVOLUTION_ALPHA_SCALE         &h801F
#define GL_POST_CONVOLUTION_RED_BIAS            &h8020
#define GL_POST_CONVOLUTION_GREEN_BIAS          &h8021
#define GL_POST_CONVOLUTION_BLUE_BIAS           &h8022
#define GL_POST_CONVOLUTION_ALPHA_BIAS          &h8023
#define GL_CONSTANT_BORDER                      &h8151
#define GL_REPLICATE_BORDER                     &h8153
#define GL_CONVOLUTION_BORDER_COLOR             &h8154
/' GL_SGI_color_matrix '/
#define GL_COLOR_MATRIX                         &h80B1
#define GL_COLOR_MATRIX_STACK_DEPTH             &h80B2
#define GL_MAX_COLOR_MATRIX_STACK_DEPTH         &h80B3
#define GL_POST_COLOR_MATRIX_RED_SCALE          &h80B4
#define GL_POST_COLOR_MATRIX_GREEN_SCALE        &h80B5
#define GL_POST_COLOR_MATRIX_BLUE_SCALE         &h80B6
#define GL_POST_COLOR_MATRIX_ALPHA_SCALE        &h80B7
#define GL_POST_COLOR_MATRIX_RED_BIAS           &h80B8
#define GL_POST_COLOR_MATRIX_GREEN_BIAS         &h80B9
#define GL_POST_COLOR_MATRIX_BLUE_BIAS          &h80BA
#define GL_POST_COLOR_MATRIX_ALPHA_BIAS         &h80BB
/' GL_EXT_histogram '/
#define GL_HISTOGRAM                            &h8024
#define GL_PROXY_HISTOGRAM                      &h8025
#define GL_HISTOGRAM_WIDTH                      &h8026
#define GL_HISTOGRAM_FORMAT                     &h8027
#define GL_HISTOGRAM_RED_SIZE                   &h8028
#define GL_HISTOGRAM_GREEN_SIZE                 &h8029
#define GL_HISTOGRAM_BLUE_SIZE                  &h802A
#define GL_HISTOGRAM_ALPHA_SIZE                 &h802B
#define GL_HISTOGRAM_LUMINANCE_SIZE             &h802C
#define GL_HISTOGRAM_SINK                       &h802D
#define GL_MINMAX                               &h802E
#define GL_MINMAX_FORMAT                        &h802F
#define GL_MINMAX_SINK                          &h8030
#define GL_TABLE_TOO_LARGE                      &h8031
/' GL_EXT_blend_color, GL_EXT_blend_minmax '/
#define GL_BLEND_EQUATION                       &h8009
#define GL_MIN                                  &h8007
#define GL_MAX                                  &h8008
#define GL_FUNC_ADD                             &h8006
#define GL_FUNC_SUBTRACT                        &h800A
#define GL_FUNC_REVERSE_SUBTRACT                &h800B
#define GL_BLEND_COLOR                          &h8005


/' OpenGL 1.3 '/
/' multitexture '/
#define GL_TEXTURE0                             &h84C0
#define GL_TEXTURE1                             &h84C1
#define GL_TEXTURE2                             &h84C2
#define GL_TEXTURE3                             &h84C3
#define GL_TEXTURE4                             &h84C4
#define GL_TEXTURE5                             &h84C5
#define GL_TEXTURE6                             &h84C6
#define GL_TEXTURE7                             &h84C7
#define GL_TEXTURE8                             &h84C8
#define GL_TEXTURE9                             &h84C9
#define GL_TEXTURE10                            &h84CA
#define GL_TEXTURE11                            &h84CB
#define GL_TEXTURE12                            &h84CC
#define GL_TEXTURE13                            &h84CD
#define GL_TEXTURE14                            &h84CE
#define GL_TEXTURE15                            &h84CF
#define GL_TEXTURE16                            &h84D0
#define GL_TEXTURE17                            &h84D1
#define GL_TEXTURE18                            &h84D2
#define GL_TEXTURE19                            &h84D3
#define GL_TEXTURE20                            &h84D4
#define GL_TEXTURE21                            &h84D5
#define GL_TEXTURE22                            &h84D6
#define GL_TEXTURE23                            &h84D7
#define GL_TEXTURE24                            &h84D8
#define GL_TEXTURE25                            &h84D9
#define GL_TEXTURE26                            &h84DA
#define GL_TEXTURE27                            &h84DB
#define GL_TEXTURE28                            &h84DC
#define GL_TEXTURE29                            &h84DD
#define GL_TEXTURE30                            &h84DE
#define GL_TEXTURE31                            &h84DF
#define GL_ACTIVE_TEXTURE                       &h84E0
#define GL_CLIENT_ACTIVE_TEXTURE                &h84E1
#define GL_MAX_TEXTURE_UNITS                    &h84E2
/' texture_cube_map '/
#define GL_NORMAL_MAP                           &h8511
#define GL_REFLECTION_MAP                       &h8512
#define GL_TEXTURE_CUBE_MAP                     &h8513
#define GL_TEXTURE_BINDING_CUBE_MAP             &h8514
#define GL_TEXTURE_CUBE_MAP_POSITIVE_X          &h8515
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_X          &h8516
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Y          &h8517
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Y          &h8518
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Z          &h8519
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Z          &h851A
#define GL_PROXY_TEXTURE_CUBE_MAP               &h851B
#define GL_MAX_CUBE_MAP_TEXTURE_SIZE            &h851C
/' texture_compression '/
#define GL_COMPRESSED_ALPHA                     &h84E9
#define GL_COMPRESSED_LUMINANCE                 &h84EA
#define GL_COMPRESSED_LUMINANCE_ALPHA           &h84EB
#define GL_COMPRESSED_INTENSITY                 &h84EC
#define GL_COMPRESSED_RGB                       &h84ED
#define GL_COMPRESSED_RGBA                      &h84EE
#define GL_TEXTURE_COMPRESSION_HINT             &h84EF
#define GL_TEXTURE_COMPRESSED_IMAGE_SIZE        &h86A0
#define GL_TEXTURE_COMPRESSED                   &h86A1
#define GL_NUM_COMPRESSED_TEXTURE_FORMATS       &h86A2
#define GL_COMPRESSED_TEXTURE_FORMATS           &h86A3
/' multisample '/
#define GL_MULTISAMPLE                          &h809D
#define GL_SAMPLE_ALPHA_TO_COVERAGE             &h809E
#define GL_SAMPLE_ALPHA_TO_ONE                  &h809F
#define GL_SAMPLE_COVERAGE                      &h80A0
#define GL_SAMPLE_BUFFERS                       &h80A8
#define GL_SAMPLES                              &h80A9
#define GL_SAMPLE_COVERAGE_VALUE                &h80AA
#define GL_SAMPLE_COVERAGE_INVERT               &h80AB
#define GL_MULTISAMPLE_BIT                      &h20000000
/' transpose_matrix '/
#define GL_TRANSPOSE_MODELVIEW_MATRIX           &h84E3
#define GL_TRANSPOSE_PROJECTION_MATRIX          &h84E4
#define GL_TRANSPOSE_TEXTURE_MATRIX             &h84E5
#define GL_TRANSPOSE_COLOR_MATRIX               &h84E6
/' texture_env_combine '/
#define GL_COMBINE                              &h8570
#define GL_COMBINE_RGB                          &h8571
#define GL_COMBINE_ALPHA                        &h8572
#define GL_SOURCE0_RGB                          &h8580
#define GL_SOURCE1_RGB                          &h8581
#define GL_SOURCE2_RGB                          &h8582
#define GL_SOURCE0_ALPHA                        &h8588
#define GL_SOURCE1_ALPHA                        &h8589
#define GL_SOURCE2_ALPHA                        &h858A
#define GL_OPERAND0_RGB                         &h8590
#define GL_OPERAND1_RGB                         &h8591
#define GL_OPERAND2_RGB                         &h8592
#define GL_OPERAND0_ALPHA                       &h8598
#define GL_OPERAND1_ALPHA                       &h8599
#define GL_OPERAND2_ALPHA                       &h859A
#define GL_RGB_SCALE                            &h8573
#define GL_ADD_SIGNED                           &h8574
#define GL_INTERPOLATE                          &h8575
#define GL_SUBTRACT                             &h84E7
#define GL_CONSTANT                             &h8576
#define GL_PRIMARY_COLOR                        &h8577
#define GL_PREVIOUS                             &h8578
/' texture_env_dot3 '/
#define GL_DOT3_RGB                             &h86AE
#define GL_DOT3_RGBA                            &h86AF
/' texture_border_clamp '/
#define GL_CLAMP_TO_BORDER                      &h812D

#EndIf /' __WIN32__ '/



/'***********************************************************************
 *
 * Function prototypes
 *
 ***********************************************************************'/

/' Miscellaneous '/
Declare Sub glClearIndex(ByVal c As GLfloat)
Declare Sub glClearColor(ByVal red As GLclampf, ByVal green As GLclampf, ByVal blue As GLclampf, ByVal Alpha As GLclampf)
Declare Sub glClear(ByVal mask As GLbitfield)
Declare Sub glIndexMask(ByVal mask As GLuint)
Declare Sub glColorMask(ByVal red As GLboolean, ByVal green As GLboolean, ByVal blue As GLboolean, ByVal Alpha As GLboolean)
Declare Sub glAlphaFunc(ByVal func As GLenum, ByVal ref As GLclampf)
Declare Sub glBlendFunc(ByVal sfactor As GLenum, ByVal dfactor As GLenum)
Declare Sub glLogicOp(ByVal opcode As GLenum)
Declare Sub glCullFace(ByVal mode As GLenum)
Declare Sub glFrontFace(ByVal mode As GLenum)
Declare Sub glPointSize(ByVal size As GLfloat)
Declare Sub glLineWidth(ByVal Width As GLfloat)
Declare Sub glLineStipple(ByVal factor As GLint, ByVal pattern As GLushort)
Declare Sub glPolygonMode(ByVal face As GLenum, ByVal mode As GLenum)
Declare Sub glPolygonOffset(ByVal factor As GLfloat, ByVal units As GLfloat)
Declare Sub glPolygonStipple(ByVal mask As GLubyte Ptr)
Declare Sub glGetPolygonStipple(ByVal mask As GLubyte Ptr)
Declare Sub glEdgeFlag(ByVal flag As GLboolean)
Declare Sub glEdgeFlagv(ByVal flag As GLboolean Ptr)
Declare Sub glScissor(ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glClipPlane(ByVal plane As GLenum, ByVal equation As GLdouble Ptr)
Declare Sub glGetClipPlane(ByVal plane As GLenum, ByVal equation As GLdouble Ptr)
Declare Sub glDrawBuffer(ByVal mode As GLenum)
Declare Sub glReadBuffer(ByVal mode As GLenum)
Declare Sub glEnable(ByVal cap As GLenum)
Declare Sub glDisable(ByVal cap As GLenum)
Declare Function glIsEnabled(ByVal cap As GLenum) As GLboolean
Declare Sub glEnableClientState(ByVal cap As GLenum)  /' 1.1 '/
Declare Sub glDisableClientState(ByVal cap As GLenum)  /' 1.1 '/
Declare Sub glGetBooleanv(ByVal pname As GLenum, ByVal params As GLboolean Ptr)
Declare Sub glGetDoublev(ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Declare Sub glGetFloatv(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetIntegerv(ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glPushAttrib(ByVal mask As GLbitfield)
Declare Sub glPopAttrib()
Declare Sub glPushClientAttrib(ByVal mask As GLbitfield)  /' 1.1 '/
Declare Sub glPopClientAttrib()  /' 1.1 '/
Declare Function glRenderMode(ByVal mode As GLenum) As GLint
Declare Function glGetError() As GLenum
Declare Function glGetString(ByVal Name As GLenum) As ZString Ptr
Declare Sub glFinish()
Declare Sub glFlush()
Declare Sub glHint(ByVal target As GLenum, ByVal mode As GLenum)

/' Depth Buffer '/
Declare Sub glClearDepth(ByVal depth As GLclampd)
Declare Sub glDepthFunc(ByVal func As GLenum)
Declare Sub glDepthMask(ByVal flag As GLboolean)
Declare Sub glDepthRange(ByVal near_val As GLclampd, ByVal far_val As GLclampd)

/' Accumulation Buffer '/
Declare Sub glClearAccum(ByVal red As GLfloat, ByVal green As GLfloat, ByVal blue As GLfloat, ByVal Alpha As GLfloat)
Declare Sub glAccum(ByVal op As GLenum, ByVal value As GLfloat)

/' Transformation '/
Declare Sub glMatrixMode(ByVal mode As GLenum)
Declare Sub glOrtho(ByVal Left As GLdouble, ByVal Right As GLdouble, ByVal bottom As GLdouble, ByVal top As GLdouble, ByVal near_val As GLdouble, ByVal far_val As GLdouble)
Declare Sub glFrustum(ByVal Left As GLdouble, ByVal Right As GLdouble, ByVal bottom As GLdouble, ByVal top As GLdouble, ByVal near_val As GLdouble, ByVal far_val As GLdouble)
Declare Sub glViewport(ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glPushMatrix()
Declare Sub glPopMatrix()
Declare Sub glLoadIdentity()
Declare Sub glLoadMatrixd(ByVal m As GLdouble Ptr)
Declare Sub glLoadMatrixf(ByVal m As GLfloat Ptr)
Declare Sub glMultMatrixd(ByVal m As GLdouble Ptr)
Declare Sub glMultMatrixf(ByVal m As GLfloat Ptr)
Declare Sub glRotated(ByVal angle As GLdouble, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glRotatef(ByVal angle As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glScaled(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glScalef(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glTranslated(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glTranslatef(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)

/' Display Lists '/
Declare Function glIsList(ByVal list As GLuint) As GLboolean
Declare Sub glDeleteLists(ByVal list As GLuint, ByVal range As GLsizei)
Declare Function glGenLists(ByVal range As GLsizei) As GLuint
Declare Sub glNewList(ByVal list As GLuint, ByVal mode As GLenum)
Declare Sub glEndList()
Declare Sub glCallList(ByVal list As GLuint)
Declare Sub glCallLists(ByVal n As GLsizei, ByVal Type As GLenum, ByVal lists As GLvoid Ptr)
Declare Sub glListBase(ByVal base As GLuint)

/' Drawing Functions '/
Declare Sub glBegin(ByVal mode As GLenum)
Declare Sub glEnd()
Declare Sub glVertex2d(ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glVertex2f(ByVal x As GLfloat, ByVal y As GLfloat)
Declare Sub glVertex2i(ByVal x As GLint, ByVal y As GLint)
Declare Sub glVertex2s(ByVal x As GLshort, ByVal y As GLshort)
Declare Sub glVertex3d(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glVertex3f(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glVertex3i(ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Declare Sub glVertex3s(ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Declare Sub glVertex4d(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glVertex4f(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glVertex4i(ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Declare Sub glVertex4s(ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort, ByVal w As GLshort)
Declare Sub glVertex2dv(ByVal v As GLdouble Ptr)
Declare Sub glVertex2fv(ByVal v As GLfloat Ptr)
Declare Sub glVertex2iv(ByVal v As GLint Ptr)
Declare Sub glVertex2sv(ByVal v As GLshort Ptr)
Declare Sub glVertex3dv(ByVal v As GLdouble Ptr)
Declare Sub glVertex3fv(ByVal v As GLfloat Ptr)
Declare Sub glVertex3iv(ByVal v As GLint Ptr)
Declare Sub glVertex3sv(ByVal v As GLshort Ptr)
Declare Sub glVertex4dv(ByVal v As GLdouble Ptr)
Declare Sub glVertex4fv(ByVal v As GLfloat Ptr)
Declare Sub glVertex4iv(ByVal v As GLint Ptr)
Declare Sub glVertex4sv(ByVal v As GLshort Ptr)
Declare Sub glNormal3b(ByVal nx As GLbyte, ByVal ny As GLbyte, ByVal nz As GLbyte)
Declare Sub glNormal3d(ByVal nx As GLdouble, ByVal ny As GLdouble, ByVal nz As GLdouble)
Declare Sub glNormal3f(ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat)
Declare Sub glNormal3i(ByVal nx As GLint, ByVal ny As GLint, ByVal nz As GLint)
Declare Sub glNormal3s(ByVal nx As GLshort, ByVal ny As GLshort, ByVal nz As GLshort)
Declare Sub glNormal3bv(ByVal v As GLbyte Ptr)
Declare Sub glNormal3dv(ByVal v As GLdouble Ptr)
Declare Sub glNormal3fv(ByVal v As GLfloat Ptr)
Declare Sub glNormal3iv(ByVal v As GLint Ptr)
Declare Sub glNormal3sv(ByVal v As GLshort Ptr)
Declare Sub glIndexd(ByVal c As GLdouble)
Declare Sub glIndexf(ByVal c As GLfloat)
Declare Sub glIndexi(ByVal c As GLint)
Declare Sub glIndexs(ByVal c As GLshort)
Declare Sub glIndexub(ByVal c As GLubyte)  /' 1.1 '/
Declare Sub glIndexdv(ByVal c As GLdouble Ptr)
Declare Sub glIndexfv(ByVal c As GLfloat Ptr)
Declare Sub glIndexiv(ByVal c As GLint Ptr)
Declare Sub glIndexsv(ByVal c As GLshort Ptr)
Declare Sub glIndexubv(ByVal c As GLubyte Ptr)  /' 1.1 '/
Declare Sub glColor3b(ByVal red As GLbyte, ByVal green As GLbyte, ByVal blue As GLbyte)
Declare Sub glColor3d(ByVal red As GLdouble, ByVal green As GLdouble, ByVal blue As GLdouble)
Declare Sub glColor3f(ByVal red As GLfloat, ByVal green As GLfloat, ByVal blue As GLfloat)
Declare Sub glColor3i(ByVal red As GLint, ByVal green As GLint, ByVal blue As GLint)
Declare Sub glColor3s(ByVal red As GLshort, ByVal green As GLshort, ByVal blue As GLshort)
Declare Sub glColor3ub(ByVal red As GLubyte, ByVal green As GLubyte, ByVal blue As GLubyte)
Declare Sub glColor3ui(ByVal red As GLuint, ByVal green As GLuint, ByVal blue As GLuint)
Declare Sub glColor3us(ByVal red As GLushort, ByVal green As GLushort, ByVal blue As GLushort)
Declare Sub glColor4b(ByVal red As GLbyte, ByVal green As GLbyte, ByVal blue As GLbyte, ByVal Alpha As GLbyte)
Declare Sub glColor4d(ByVal red As GLdouble, ByVal green As GLdouble, ByVal blue As GLdouble, ByVal Alpha As GLdouble)
Declare Sub glColor4f(ByVal red As GLfloat, ByVal green As GLfloat, ByVal blue As GLfloat, ByVal Alpha As GLfloat)
Declare Sub glColor4i(ByVal red As GLint, ByVal green As GLint, ByVal blue As GLint, ByVal Alpha As GLint)
Declare Sub glColor4s(ByVal red As GLshort, ByVal green As GLshort, ByVal blue As GLshort, ByVal Alpha As GLshort)
Declare Sub glColor4ub(ByVal red As GLubyte, ByVal green As GLubyte, ByVal blue As GLubyte, ByVal Alpha As GLubyte)
Declare Sub glColor4ui(ByVal red As GLuint, ByVal green As GLuint, ByVal blue As GLuint, ByVal Alpha As GLuint)
Declare Sub glColor4us(ByVal red As GLushort, ByVal green As GLushort, ByVal blue As GLushort, ByVal Alpha As GLushort)
Declare Sub glColor3bv(ByVal v As GLbyte Ptr)
Declare Sub glColor3dv(ByVal v As GLdouble Ptr)
Declare Sub glColor3fv(ByVal v As GLfloat Ptr)
Declare Sub glColor3iv(ByVal v As GLint Ptr)
Declare Sub glColor3sv(ByVal v As GLshort Ptr)
Declare Sub glColor3ubv(ByVal v As GLubyte Ptr)
Declare Sub glColor3uiv(ByVal v As GLuint Ptr)
Declare Sub glColor3usv(ByVal v As GLushort Ptr)
Declare Sub glColor4bv(ByVal v As GLbyte Ptr)
Declare Sub glColor4dv(ByVal v As GLdouble Ptr)
Declare Sub glColor4fv(ByVal v As GLfloat Ptr)
Declare Sub glColor4iv(ByVal v As GLint Ptr)
Declare Sub glColor4sv(ByVal v As GLshort Ptr)
Declare Sub glColor4ubv(ByVal v As GLubyte Ptr)
Declare Sub glColor4uiv(ByVal v As GLuint Ptr)
Declare Sub glColor4usv(ByVal v As GLushort Ptr)
Declare Sub glTexCoord1d(ByVal s As GLdouble)
Declare Sub glTexCoord1f(ByVal s As GLfloat)
Declare Sub glTexCoord1i(ByVal s As GLint)
Declare Sub glTexCoord1s(ByVal s As GLshort)
Declare Sub glTexCoord2d(ByVal s As GLdouble, ByVal t As GLdouble)
Declare Sub glTexCoord2f(ByVal s As GLfloat, ByVal t As GLfloat)
Declare Sub glTexCoord2i(ByVal s As GLint, ByVal t As GLint)
Declare Sub glTexCoord2s(ByVal s As GLshort, ByVal t As GLshort)
Declare Sub glTexCoord3d(ByVal s As GLdouble, ByVal t As GLdouble, ByVal r As GLdouble)
Declare Sub glTexCoord3f(ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat)
Declare Sub glTexCoord3i(ByVal s As GLint, ByVal t As GLint, ByVal r As GLint)
Declare Sub glTexCoord3s(ByVal s As GLshort, ByVal t As GLshort, ByVal r As GLshort)
Declare Sub glTexCoord4d(ByVal s As GLdouble, ByVal t As GLdouble, ByVal r As GLdouble, ByVal q As GLdouble)
Declare Sub glTexCoord4f(ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat, ByVal q As GLfloat)
Declare Sub glTexCoord4i(ByVal s As GLint, ByVal t As GLint, ByVal r As GLint, ByVal q As GLint)
Declare Sub glTexCoord4s(ByVal s As GLshort, ByVal t As GLshort, ByVal r As GLshort, ByVal q As GLshort)
Declare Sub glTexCoord1dv(ByVal v As GLdouble Ptr)
Declare Sub glTexCoord1fv(ByVal v As GLfloat Ptr)
Declare Sub glTexCoord1iv(ByVal v As GLint Ptr)
Declare Sub glTexCoord1sv(ByVal v As GLshort Ptr)
Declare Sub glTexCoord2dv(ByVal v As GLdouble Ptr)
Declare Sub glTexCoord2fv(ByVal v As GLfloat Ptr)
Declare Sub glTexCoord2iv(ByVal v As GLint Ptr)
Declare Sub glTexCoord2sv(ByVal v As GLshort Ptr)
Declare Sub glTexCoord3dv(ByVal v As GLdouble Ptr)
Declare Sub glTexCoord3fv(ByVal v As GLfloat Ptr)
Declare Sub glTexCoord3iv(ByVal v As GLint Ptr)
Declare Sub glTexCoord3sv(ByVal v As GLshort Ptr)
Declare Sub glTexCoord4dv(ByVal v As GLdouble Ptr)
Declare Sub glTexCoord4fv(ByVal v As GLfloat Ptr)
Declare Sub glTexCoord4iv(ByVal v As GLint Ptr)
Declare Sub glTexCoord4sv(ByVal v As GLshort Ptr)
Declare Sub glRasterPos2d(ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glRasterPos2f(ByVal x As GLfloat, ByVal y As GLfloat)
Declare Sub glRasterPos2i(ByVal x As GLint, ByVal y As GLint)
Declare Sub glRasterPos2s(ByVal x As GLshort, ByVal y As GLshort)
Declare Sub glRasterPos3d(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glRasterPos3f(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glRasterPos3i(ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Declare Sub glRasterPos3s(ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Declare Sub glRasterPos4d(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glRasterPos4f(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glRasterPos4i(ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Declare Sub glRasterPos4s(ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort, ByVal w As GLshort)
Declare Sub glRasterPos2dv(ByVal v As GLdouble Ptr)
Declare Sub glRasterPos2fv(ByVal v As GLfloat Ptr)
Declare Sub glRasterPos2iv(ByVal v As GLint Ptr)
Declare Sub glRasterPos2sv(ByVal v As GLshort Ptr)
Declare Sub glRasterPos3dv(ByVal v As GLdouble Ptr)
Declare Sub glRasterPos3fv(ByVal v As GLfloat Ptr)
Declare Sub glRasterPos3iv(ByVal v As GLint Ptr)
Declare Sub glRasterPos3sv(ByVal v As GLshort Ptr)
Declare Sub glRasterPos4dv(ByVal v As GLdouble Ptr)
Declare Sub glRasterPos4fv(ByVal v As GLfloat Ptr)
Declare Sub glRasterPos4iv(ByVal v As GLint Ptr)
Declare Sub glRasterPos4sv(ByVal v As GLshort Ptr)
Declare Sub glRectd(ByVal x1 As GLdouble, ByVal y1 As GLdouble, ByVal x2 As GLdouble, ByVal y2 As GLdouble)
Declare Sub glRectf(ByVal x1 As GLfloat, ByVal y1 As GLfloat, ByVal x2 As GLfloat, ByVal y2 As GLfloat)
Declare Sub glRecti(ByVal x1 As GLint, ByVal y1 As GLint, ByVal x2 As GLint, ByVal y2 As GLint)
Declare Sub glRects(ByVal x1 As GLshort, ByVal y1 As GLshort, ByVal x2 As GLshort, ByVal y2 As GLshort)
Declare Sub glRectdv(ByVal v1 As GLdouble Ptr, ByVal v2 As GLdouble Ptr)
Declare Sub glRectfv(ByVal v1 As GLfloat Ptr, ByVal v2 As GLfloat Ptr)
Declare Sub glRectiv(ByVal v1 As GLint Ptr, ByVal v2 As GLint Ptr)
Declare Sub glRectsv(ByVal v1 As GLshort Ptr, ByVal v2 As GLshort Ptr)

/' Lighting '/
Declare Sub glShadeModel(ByVal mode As GLenum)
Declare Sub glLightf(ByVal light As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glLighti(ByVal light As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glLightfv(ByVal light As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glLightiv(ByVal light As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetLightfv(ByVal light As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetLightiv(ByVal light As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glLightModelf(ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glLightModeli(ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glLightModelfv(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glLightModeliv(ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glMaterialf(ByVal face As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glMateriali(ByVal face As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glMaterialfv(ByVal face As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glMaterialiv(ByVal face As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetMaterialfv(ByVal face As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetMaterialiv(ByVal face As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glColorMaterial(ByVal face As GLenum, ByVal mode As GLenum)

/' Raster functions '/
Declare Sub glPixelZoom(ByVal xfactor As GLfloat, ByVal yfactor As GLfloat)
Declare Sub glPixelStoref(ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glPixelStorei(ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glPixelTransferf(ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glPixelTransferi(ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glPixelMapfv(ByVal map As GLenum, ByVal mapsize As GLint, ByVal values As GLfloat Ptr)
Declare Sub glPixelMapuiv(ByVal map As GLenum, ByVal mapsize As GLint, ByVal values As GLuint Ptr)
Declare Sub glPixelMapusv(ByVal map As GLenum, ByVal mapsize As GLint, ByVal values As GLushort Ptr)
Declare Sub glGetPixelMapfv(ByVal map As GLenum, ByVal values As GLfloat Ptr)
Declare Sub glGetPixelMapuiv(ByVal map As GLenum, ByVal values As GLuint Ptr)
Declare Sub glGetPixelMapusv(ByVal map As GLenum, ByVal values As GLushort Ptr)
Declare Sub glBitmap(ByVal Width As GLsizei, ByVal height As GLsizei, ByVal xorig As GLfloat, ByVal yorig As GLfloat, ByVal xmove As GLfloat, ByVal ymove As GLfloat, ByVal bitmap As GLubyte Ptr)
Declare Sub glReadPixels(ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glDrawPixels(ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glCopyPixels(ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Type As GLenum)

/' Stenciling '/
Declare Sub glStencilFunc(ByVal func As GLenum, ByVal ref As GLint, ByVal mask As GLuint)
Declare Sub glStencilMask(ByVal mask As GLuint)
Declare Sub glStencilOp(ByVal fail As GLenum, ByVal zfail As GLenum, ByVal zpass As GLenum)
Declare Sub glClearStencil(ByVal s As GLint)

/' Texture mapping '/
Declare Sub glTexGend(ByVal coord As GLenum, ByVal pname As GLenum, ByVal param As GLdouble)
Declare Sub glTexGenf(ByVal coord As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glTexGeni(ByVal coord As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glTexGendv(ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Declare Sub glTexGenfv(ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glTexGeniv(ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetTexGendv(ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Declare Sub glGetTexGenfv(ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetTexGeniv(ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glTexEnvf(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glTexEnvi(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glTexEnvfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glTexEnviv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetTexEnvfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetTexEnviv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glTexParameterf(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glTexParameteri(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glTexParameterfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glTexParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetTexParameterfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetTexParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetTexLevelParameterfv(ByVal target As GLenum, ByVal level As GLint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetTexLevelParameteriv(ByVal target As GLenum, ByVal level As GLint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glTexImage1D(ByVal target As GLenum, ByVal level As GLint, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glTexImage2D(ByVal target As GLenum, ByVal level As GLint, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glGetTexImage(ByVal target As GLenum, ByVal level As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)

/' Evaluators '/
Declare Sub glMap1d(ByVal target As GLenum, ByVal u1 As GLdouble, ByVal u2 As GLdouble, ByVal stride As GLint, ByVal order As GLint, ByVal points As GLdouble Ptr)
Declare Sub glMap1f(ByVal target As GLenum, ByVal u1 As GLfloat, ByVal u2 As GLfloat, ByVal stride As GLint, ByVal order As GLint, ByVal points As GLfloat Ptr)
Declare Sub glMap2d(ByVal target As GLenum, ByVal u1 As GLdouble, ByVal u2 As GLdouble, ByVal ustride As GLint, ByVal uorder As GLint, ByVal v1 As GLdouble, ByVal v2 As GLdouble, ByVal vstride As GLint, ByVal vorder As GLint, ByVal points As GLdouble Ptr)
Declare Sub glMap2f(ByVal target As GLenum, ByVal u1 As GLfloat, ByVal u2 As GLfloat, ByVal ustride As GLint, ByVal uorder As GLint, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal vstride As GLint, ByVal vorder As GLint, ByVal points As GLfloat Ptr)
Declare Sub glGetMapdv(ByVal target As GLenum, ByVal query As GLenum, ByVal v As GLdouble Ptr)
Declare Sub glGetMapfv(ByVal target As GLenum, ByVal query As GLenum, ByVal v As GLfloat Ptr)
Declare Sub glGetMapiv(ByVal target As GLenum, ByVal query As GLenum, ByVal v As GLint Ptr)
Declare Sub glEvalCoord1d(ByVal u As GLdouble)
Declare Sub glEvalCoord1f(ByVal u As GLfloat)
Declare Sub glEvalCoord1dv(ByVal u As GLdouble Ptr)
Declare Sub glEvalCoord1fv(ByVal u As GLfloat Ptr)
Declare Sub glEvalCoord2d(ByVal u As GLdouble, ByVal v As GLdouble)
Declare Sub glEvalCoord2f(ByVal u As GLfloat, ByVal v As GLfloat)
Declare Sub glEvalCoord2dv(ByVal u As GLdouble Ptr)
Declare Sub glEvalCoord2fv(ByVal u As GLfloat Ptr)
Declare Sub glMapGrid1d(ByVal un As GLint, ByVal u1 As GLdouble, ByVal u2 As GLdouble)
Declare Sub glMapGrid1f(ByVal un As GLint, ByVal u1 As GLfloat, ByVal u2 As GLfloat)
Declare Sub glMapGrid2d(ByVal un As GLint, ByVal u1 As GLdouble, ByVal u2 As GLdouble, ByVal vn As GLint, ByVal v1 As GLdouble, ByVal v2 As GLdouble)
Declare Sub glMapGrid2f(ByVal un As GLint, ByVal u1 As GLfloat, ByVal u2 As GLfloat, ByVal vn As GLint, ByVal v1 As GLfloat, ByVal v2 As GLfloat)
Declare Sub glEvalPoint1(ByVal i As GLint)
Declare Sub glEvalPoint2(ByVal i As GLint, ByVal j As GLint)
Declare Sub glEvalMesh1(ByVal mode As GLenum, ByVal i1 As GLint, ByVal i2 As GLint)
Declare Sub glEvalMesh2(ByVal mode As GLenum, ByVal i1 As GLint, ByVal i2 As GLint, ByVal j1 As GLint, ByVal j2 As GLint)

/' Fog '/
Declare Sub glFogf(ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glFogi(ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glFogfv(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glFogiv(ByVal pname As GLenum, ByVal params As GLint Ptr)

/' Selection and Feedback '/
Declare Sub glFeedbackBuffer(ByVal size As GLsizei, ByVal Type As GLenum, ByVal buffer As GLfloat Ptr)
Declare Sub glPassThrough(ByVal token As GLfloat)
Declare Sub glSelectBuffer(ByVal size As GLsizei, ByVal buffer As GLuint Ptr)
Declare Sub glInitNames()
Declare Sub glLoadName(ByVal Name As GLuint)
Declare Sub glPushName(ByVal Name As GLuint)
Declare Sub glPopName()


/' 1.1 functions '/
/' texture objects '/
Declare Sub glGenTextures(ByVal n As GLsizei, ByVal textures As GLuint Ptr)
Declare Sub glDeleteTextures(ByVal n As GLsizei, ByVal textures As GLuint Ptr)
Declare Sub glBindTexture(ByVal target As GLenum, ByVal texture As GLuint)
Declare Sub glPrioritizeTextures(ByVal n As GLsizei, ByVal textures As GLuint Ptr, ByVal priorities As GLclampf Ptr)
Declare Function glAreTexturesResident(ByVal n As GLsizei, ByVal textures As GLuint Ptr, ByVal residences As GLboolean Ptr) As GLboolean
Declare Function glIsTexture(ByVal texture As GLuint) As GLboolean
/' texture mapping '/
Declare Sub glTexSubImage1D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glTexSubImage2D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glCopyTexImage1D(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal border As GLint)
Declare Sub glCopyTexImage2D(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint)
Declare Sub glCopyTexSubImage1D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Declare Sub glCopyTexSubImage2D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
/' vertex arrays '/
Declare Sub glVertexPointer(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Ptr As GLvoid Ptr)
Declare Sub glNormalPointer(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Ptr As GLvoid Ptr)
Declare Sub glColorPointer(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Ptr As GLvoid Ptr)
Declare Sub glIndexPointer(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Ptr As GLvoid Ptr)
Declare Sub glTexCoordPointer(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Ptr As GLvoid Ptr)
Declare Sub glEdgeFlagPointer(ByVal stride As GLsizei, ByVal Ptr As GLvoid Ptr)
Declare Sub glGetPointerv(ByVal pname As GLenum, ByVal params As GLvoid Ptr Ptr)
Declare Sub glArrayElement(ByVal i As GLint)
Declare Sub glDrawArrays(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei)
Declare Sub glDrawElements(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr)
Declare Sub glInterleavedArrays(ByVal Format As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)



/' Under Windows, we do not define OpenGL 1.2 & 1.3 functionality, since
   it is treated as extensions (defined in glext.h) '/
#Ifndef __FB_WIN32__

/' 1.2 functions '/
Declare Sub glDrawRangeElements(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr)
Declare Sub glTexImage3D(ByVal target As GLenum, ByVal level As GLint, ByVal internalFormat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glTexSubImage3D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glCopyTexSubImage3D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)

/' 1.2 imaging extension functions '/
Declare Sub glColorTable(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal table As GLvoid Ptr)
Declare Sub glColorSubTable(ByVal target As GLenum, ByVal start As GLsizei, ByVal count As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal Data As GLvoid Ptr)
Declare Sub glColorTableParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glColorTableParameterfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glCopyColorSubTable(ByVal target As GLenum, ByVal start As GLsizei, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Declare Sub glCopyColorTable(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Declare Sub glGetColorTable(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal table As GLvoid Ptr)
Declare Sub glGetColorTableParameterfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetColorTableParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glBlendEquation(ByVal mode As GLenum)
Declare Sub glBlendColor(ByVal red As GLclampf, ByVal green As GLclampf, ByVal blue As GLclampf, ByVal Alpha As GLclampf)
Declare Sub glHistogram(ByVal target As GLenum, ByVal Width As GLsizei, ByVal internalformat As GLenum, ByVal sink As GLboolean)
Declare Sub glResetHistogram(ByVal target As GLenum)
Declare Sub glGetHistogram(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal values As GLvoid Ptr)
Declare Sub glGetHistogramParameterfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetHistogramParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glMinmax(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal sink As GLboolean)
Declare Sub glResetMinmax(ByVal target As GLenum)
Declare Sub glGetMinmax(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal types As GLenum, ByVal values As GLvoid Ptr)
Declare Sub glGetMinmaxParameterfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetMinmaxParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glConvolutionFilter1D(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal image As GLvoid Ptr)
Declare Sub glConvolutionFilter2D(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal image As GLvoid Ptr)
Declare Sub glConvolutionParameterf(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat)
Declare Sub glConvolutionParameterfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glConvolutionParameteri(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint)
Declare Sub glConvolutionParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glCopyConvolutionFilter1D(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Declare Sub glCopyConvolutionFilter2D(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glGetConvolutionFilter(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal image As GLvoid Ptr)
Declare Sub glGetConvolutionParameterfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetConvolutionParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glSeparableFilter2D(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal row As GLvoid Ptr, ByVal column As GLvoid Ptr)
Declare Sub glGetSeparableFilter(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal row As GLvoid Ptr, ByVal column As GLvoid Ptr, ByVal span As GLvoid Ptr)

/' 1.3 functions '/
Declare Sub glActiveTexture(ByVal texture As GLenum)
Declare Sub glClientActiveTexture(ByVal texture As GLenum)
Declare Sub glCompressedTexImage1D(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexImage2D(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexImage3D(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexSubImage1D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexSubImage2D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexSubImage3D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glGetCompressedTexImage(ByVal target As GLenum, ByVal lod As GLint, ByVal img As GLvoid Ptr)
Declare Sub glMultiTexCoord1d(ByVal target As GLenum, ByVal s As GLdouble)
Declare Sub glMultiTexCoord1dv(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Declare Sub glMultiTexCoord1f(ByVal target As GLenum, ByVal s As GLfloat)
Declare Sub glMultiTexCoord1fv(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Declare Sub glMultiTexCoord1i(ByVal target As GLenum, ByVal s As GLint)
Declare Sub glMultiTexCoord1iv(ByVal target As GLenum, ByVal v As GLint Ptr)
Declare Sub glMultiTexCoord1s(ByVal target As GLenum, ByVal s As GLshort)
Declare Sub glMultiTexCoord1sv(ByVal target As GLenum, ByVal v As GLshort Ptr)
Declare Sub glMultiTexCoord2d(ByVal target As GLenum, ByVal s As GLdouble, ByVal t As GLdouble)
Declare Sub glMultiTexCoord2dv(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Declare Sub glMultiTexCoord2f(ByVal target As GLenum, ByVal s As GLfloat, ByVal t As GLfloat)
Declare Sub glMultiTexCoord2fv(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Declare Sub glMultiTexCoord2i(ByVal target As GLenum, ByVal s As GLint, ByVal t As GLint)
Declare Sub glMultiTexCoord2iv(ByVal target As GLenum, ByVal v As GLint Ptr)
Declare Sub glMultiTexCoord2s(ByVal target As GLenum, ByVal s As GLshort, ByVal t As GLshort)
Declare Sub glMultiTexCoord2sv(ByVal target As GLenum, ByVal v As GLshort Ptr)
Declare Sub glMultiTexCoord3d(ByVal target As GLenum, ByVal s As GLdouble, ByVal t As GLdouble, ByVal r As GLdouble)
Declare Sub glMultiTexCoord3dv(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Declare Sub glMultiTexCoord3f(ByVal target As GLenum, ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat)
Declare Sub glMultiTexCoord3fv(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Declare Sub glMultiTexCoord3i(ByVal target As GLenum, ByVal s As GLint, ByVal t As GLint, ByVal r As GLint)
Declare Sub glMultiTexCoord3iv(ByVal target As GLenum, ByVal v As GLint Ptr)
Declare Sub glMultiTexCoord3s(ByVal target As GLenum, ByVal s As GLshort, ByVal t As GLshort, ByVal r As GLshort)
Declare Sub glMultiTexCoord3sv(ByVal target As GLenum, ByVal v As GLshort Ptr)
Declare Sub glMultiTexCoord4d(ByVal target As GLenum, ByVal s As GLdouble, ByVal t As GLdouble, ByVal r As GLdouble, ByVal q As GLdouble)
Declare Sub glMultiTexCoord4dv(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Declare Sub glMultiTexCoord4f(ByVal target As GLenum, ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat, ByVal q As GLfloat)
Declare Sub glMultiTexCoord4fv(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Declare Sub glMultiTexCoord4i(ByVal target As GLenum, ByVal s As GLint, ByVal t As GLint, ByVal r As GLint, ByVal q As GLint)
Declare Sub glMultiTexCoord4iv(ByVal target As GLenum, ByVal v As GLint Ptr)
Declare Sub glMultiTexCoord4s(ByVal target As GLenum, ByVal s As GLshort, ByVal t As GLshort, ByVal r As GLshort, ByVal q As GLshort)
Declare Sub glMultiTexCoord4sv(ByVal target As GLenum, ByVal v As GLshort Ptr)
Declare Sub glLoadTransposeMatrixd(ByVal m As GLdouble Ptr)
Declare Sub glLoadTransposeMatrixf(ByVal m As GLfloat Ptr)
Declare Sub glMultTransposeMatrixd(ByVal m As GLdouble Ptr)
Declare Sub glMultTransposeMatrixf(ByVal m As GLfloat Ptr)
Declare Sub glSampleCoverage(ByVal value As GLclampf, ByVal invert As GLboolean)
Declare Sub glSamplePass(ByVal pass As GLenum)

#EndIf /' __WIN32__ '/

End Extern

#EndIf /' __gl_bi__ '/
