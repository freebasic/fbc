
'  FileName: GL.BI
'  Ported by: Richard Eric M. Lope BSN RN aka Relsoft
'  To be used by the FreeBASIC compiler
'  01/16/2005
'  send bug reports to vic_viperph@yahoo.com
'  most of the prototypes untested.


'' Set checks for include do that we don't inadvertently include this header twice
#ifndef gl_bi
#define gl_bi

#ifdef FB__WIN32
	'$inclib: "opengl32"
#elseif defined( FB__LINUX)
	'$inclib: "GL"
#endif




#define GL_VERSION_1_1   1

''******data types

#define GLenum         uinteger
#define GLboolean      ubyte
#define GLbitfield     uinteger
#define GLvoid         any
#define GLbyte         byte
#define GLshort        short
#define GLint          integer
#define GLubyte        ubyte
#define GLushort       ushort
#define GLuint         uinteger
#define GLsizei        integer
#define GLfloat        single
#define GLclampf       single				 '/* single precision float in [0,1] */
#define GLdouble       double
#define GLclampd       double 				 '/* double precision float in [0,1] */


'' ************************************************************************
'' *
'' * Constants
'' *
'' ************************************************************************

'' * Boolean values *
#define GL_FALSE                                &H0
#define GL_TRUE                                 &H1

''* Data types *
#define GL_BYTE                                 &H1400
#define GL_UNSIGNED_BYTE                        &H1401
#define GL_SHORT                                &H1402
#define GL_UNSIGNED_SHORT                       &H1403
#define GL_INT                                  &H1404
#define GL_UNSIGNED_INT                         &H1405
#define GL_FLOAT                                &H1406
#define GL_DOUBLE                               &H140A
#define GL_2_BYTES                              &H1407
#define GL_3_BYTES                              &H1408
#define GL_4_BYTES                              &H1409

''* Primitives *
#define GL_POINTS                               &H0000
#define GL_LINES                                &H0001
#define GL_LINE_LOOP                            &H0002
#define GL_LINE_STRIP                           &H0003
#define GL_TRIANGLES                            &H0004
#define GL_TRIANGLE_STRIP                       &H0005
#define GL_TRIANGLE_FAN                         &H0006
#define GL_QUADS                                &H0007
#define GL_QUAD_STRIP                           &H0008
#define GL_POLYGON                              &H0009

''* Vertex Arrays *
#define GL_VERTEX_ARRAY                         &H8074
#define GL_NORMAL_ARRAY                         &H8075
#define GL_COLOR_ARRAY                          &H8076
#define GL_INDEX_ARRAY                          &H8077
#define GL_TEXTURE_COORD_ARRAY                  &H8078
#define GL_EDGE_FLAG_ARRAY                      &H8079
#define GL_VERTEX_ARRAY_SIZE                    &H807A
#define GL_VERTEX_ARRAY_TYPE                    &H807B
#define GL_VERTEX_ARRAY_STRIDE                  &H807C
#define GL_NORMAL_ARRAY_TYPE                    &H807E
#define GL_NORMAL_ARRAY_STRIDE                  &H807F
#define GL_COLOR_ARRAY_SIZE                     &H8081
#define GL_COLOR_ARRAY_TYPE                     &H8082
#define GL_COLOR_ARRAY_STRIDE                   &H8083
#define GL_INDEX_ARRAY_TYPE                     &H8085
#define GL_INDEX_ARRAY_STRIDE                   &H8086
#define GL_TEXTURE_COORD_ARRAY_SIZE             &H8088
#define GL_TEXTURE_COORD_ARRAY_TYPE             &H8089
#define GL_TEXTURE_COORD_ARRAY_STRIDE           &H808A
#define GL_EDGE_FLAG_ARRAY_STRIDE               &H808C
#define GL_VERTEX_ARRAY_POINTER                 &H808E
#define GL_NORMAL_ARRAY_POINTER                 &H808F
#define GL_COLOR_ARRAY_POINTER                  &H8090
#define GL_INDEX_ARRAY_POINTER                  &H8091
#define GL_TEXTURE_COORD_ARRAY_POINTER          &H8092
#define GL_EDGE_FLAG_ARRAY_POINTER              &H8093
#define GL_V2F                                  &H2A20
#define GL_V3F                                  &H2A21
#define GL_C4UB_V2F                             &H2A22
#define GL_C4UB_V3F                             &H2A23
#define GL_C3F_V3F                              &H2A24
#define GL_N3F_V3F                              &H2A25
#define GL_C4F_N3F_V3F                          &H2A26
#define GL_T2F_V3F                              &H2A27
#define GL_T4F_V4F                              &H2A28
#define GL_T2F_C4UB_V3F                         &H2A29
#define GL_T2F_C3F_V3F                          &H2A2A
#define GL_T2F_N3F_V3F                          &H2A2B
#define GL_T2F_C4F_N3F_V3F                      &H2A2C
#define GL_T4F_C4F_N3F_V4F                      &H2A2D

''* Matrix Mode *
#define GL_MATRIX_MODE                          &H0BA0
#define GL_MODELVIEW                            &H1700
#define GL_PROJECTION                           &H1701
#define GL_TEXTURE                              &H1702

''* Points *
#define GL_POINT_SMOOTH                         &H0B10
#define GL_POINT_SIZE                           &H0B11
#define GL_POINT_SIZE_GRANULARITY               &H0B13
#define GL_POINT_SIZE_RANGE                     &H0B12

''* Lines *
#define GL_LINE_SMOOTH                          &H0B20
#define GL_LINE_STIPPLE                         &H0B24
#define GL_LINE_STIPPLE_PATTERN                 &H0B25
#define GL_LINE_STIPPLE_REPEAT                  &H0B26
#define GL_LINE_WIDTH                           &H0B21
#define GL_LINE_WIDTH_GRANULARITY               &H0B23
#define GL_LINE_WIDTH_RANGE                     &H0B22

''* Polygons *
#define GL_POINT                                &H1B00
#define GL_LINE                                 &H1B01
#define GL_FILL                                 &H1B02
#define GL_CW                                   &H0900
#define GL_CCW                                  &H0901
#define GL_FRONT                                &H0404
#define GL_BACK                                 &H0405
#define GL_POLYGON_MODE                         &H0B40
#define GL_POLYGON_SMOOTH                       &H0B41
#define GL_POLYGON_STIPPLE                      &H0B42
#define GL_EDGE_FLAG                            &H0B43
#define GL_CULL_FACE                            &H0B44
#define GL_CULL_FACE_MODE                       &H0B45
#define GL_FRONT_FACE                           &H0B46
#define GL_POLYGON_OFFSET_FACTOR                &H8038
#define GL_POLYGON_OFFSET_UNITS                 &H2A00
#define GL_POLYGON_OFFSET_POINT                 &H2A01
#define GL_POLYGON_OFFSET_LINE                  &H2A02
#define GL_POLYGON_OFFSET_FILL                  &H8037

''* Display Lists *
#define GL_COMPILE                              &H1300
#define GL_COMPILE_AND_EXECUTE                  &H1301
#define GL_LIST_BASE                            &H0B32
#define GL_LIST_INDEX                           &H0B33
#define GL_LIST_MODE                            &H0B30

''* Depth buffer *
#define GL_NEVER                                &H0200
#define GL_LESS                                 &H0201
#define GL_EQUAL                                &H0202
#define GL_LEQUAL                               &H0203
#define GL_GREATER                              &H0204
#define GL_NOTEQUAL                             &H0205
#define GL_GEQUAL                               &H0206
#define GL_ALWAYS                               &H0207
#define GL_DEPTH_TEST                           &H0B71
#define GL_DEPTH_BITS                           &H0D56
#define GL_DEPTH_CLEAR_VALUE                    &H0B73
#define GL_DEPTH_FUNC                           &H0B74
#define GL_DEPTH_RANGE                          &H0B70
#define GL_DEPTH_WRITEMASK                      &H0B72
#define GL_DEPTH_COMPONENT                      &H1902

''* Lighting *
#define GL_LIGHTING                             &H0B50
#define GL_LIGHT0                               &H4000
#define GL_LIGHT1                               &H4001
#define GL_LIGHT2                               &H4002
#define GL_LIGHT3                               &H4003
#define GL_LIGHT4                               &H4004
#define GL_LIGHT5                               &H4005
#define GL_LIGHT6                               &H4006
#define GL_LIGHT7                               &H4007
#define GL_SPOT_EXPONENT                        &H1205
#define GL_SPOT_CUTOFF                          &H1206
#define GL_CONSTANT_ATTENUATION                 &H1207
#define GL_LINEAR_ATTENUATION                   &H1208
#define GL_QUADRATIC_ATTENUATION                &H1209
#define GL_AMBIENT                              &H1200
#define GL_DIFFUSE                              &H1201
#define GL_SPECULAR                             &H1202
#define GL_SHININESS                            &H1601
#define GL_EMISSION                             &H1600
#define GL_POSITION                             &H1203
#define GL_SPOT_DIRECTION                       &H1204
#define GL_AMBIENT_AND_DIFFUSE                  &H1602
#define GL_COLOR_INDEXES                        &H1603
#define GL_LIGHT_MODEL_TWO_SIDE                 &H0B52
#define GL_LIGHT_MODEL_LOCAL_VIEWER             &H0B51
#define GL_LIGHT_MODEL_AMBIENT                  &H0B53
#define GL_FRONT_AND_BACK                       &H0408
#define GL_SHADE_MODEL                          &H0B54
#define GL_FLAT                                 &H1D00
#define GL_SMOOTH                               &H1D01
#define GL_COLOR_MATERIAL                       &H0B57
#define GL_COLOR_MATERIAL_FACE                  &H0B55
#define GL_COLOR_MATERIAL_PARAMETER             &H0B56
#define GL_NORMALIZE                            &H0BA1

''* User clipping planes *
#define GL_CLIP_PLANE0                          &H3000
#define GL_CLIP_PLANE1                          &H3001
#define GL_CLIP_PLANE2                          &H3002
#define GL_CLIP_PLANE3                          &H3003
#define GL_CLIP_PLANE4                          &H3004
#define GL_CLIP_PLANE5                          &H3005

''* Accumulation buffer *
#define GL_ACCUM_RED_BITS                       &H0D58
#define GL_ACCUM_GREEN_BITS                     &H0D59
#define GL_ACCUM_BLUE_BITS                      &H0D5A
#define GL_ACCUM_ALPHA_BITS                     &H0D5B
#define GL_ACCUM_CLEAR_VALUE                    &H0B80
#define GL_ACCUM                                &H0100
#define GL_ADD                                  &H0104
#define GL_LOAD                                 &H0101
#define GL_MULT                                 &H0103
#define GL_RETURN                               &H0102

''* Alpha testing *
#define GL_ALPHA_TEST                           &H0BC0
#define GL_ALPHA_TEST_REF                       &H0BC2
#define GL_ALPHA_TEST_FUNC                      &H0BC1

''* Blending *
#define GL_BLEND                                &H0BE2
#define GL_BLEND_SRC                            &H0BE1
#define GL_BLEND_DST                            &H0BE0
#define GL_ZERO                                 &H0
#define GL_ONE                                  &H1
#define GL_SRC_COLOR                            &H0300
#define GL_ONE_MINUS_SRC_COLOR                  &H0301
#define GL_SRC_ALPHA                            &H0302
#define GL_ONE_MINUS_SRC_ALPHA                  &H0303
#define GL_DST_ALPHA                            &H0304
#define GL_ONE_MINUS_DST_ALPHA                  &H0305
#define GL_DST_COLOR                            &H0306
#define GL_ONE_MINUS_DST_COLOR                  &H0307
#define GL_SRC_ALPHA_SATURATE                   &H0308
#define GL_CONSTANT_COLOR                       &H8001
#define GL_ONE_MINUS_CONSTANT_COLOR             &H8002
#define GL_CONSTANT_ALPHA                       &H8003
#define GL_ONE_MINUS_CONSTANT_ALPHA             &H8004

''* Render Mode *
#define GL_FEEDBACK                             &H1C01
#define GL_RENDER                               &H1C00
#define GL_SELECT                               &H1C02

''* Feedback *
#define GL_2D                                   &H0600
#define GL_3D                                   &H0601
#define GL_3D_COLOR                             &H0602
#define GL_3D_COLOR_TEXTURE                     &H0603
#define GL_4D_COLOR_TEXTURE                     &H0604
#define GL_POINT_TOKEN                          &H0701
#define GL_LINE_TOKEN                           &H0702
#define GL_LINE_RESET_TOKEN                     &H0707
#define GL_POLYGON_TOKEN                        &H0703
#define GL_BITMAP_TOKEN                         &H0704
#define GL_DRAW_PIXEL_TOKEN                     &H0705
#define GL_COPY_PIXEL_TOKEN                     &H0706
#define GL_PASS_THROUGH_TOKEN                   &H0700
#define GL_FEEDBACK_BUFFER_POINTER              &H0DF0
#define GL_FEEDBACK_BUFFER_SIZE                 &H0DF1
#define GL_FEEDBACK_BUFFER_TYPE                 &H0DF2

''* Selection *
#define GL_SELECTION_BUFFER_POINTER             &H0DF3
#define GL_SELECTION_BUFFER_SIZE                &H0DF4

''* Fog *
#define GL_FOG                                  &H0B60
#define GL_FOG_MODE                             &H0B65
#define GL_FOG_DENSITY                          &H0B62
#define GL_FOG_COLOR                            &H0B66
#define GL_FOG_INDEX                            &H0B61
#define GL_FOG_START                            &H0B63
#define GL_FOG_END                              &H0B64
#define GL_LINEAR                               &H2601
#define GL_EXP                                  &H0800
#define GL_EXP2                                 &H0801

''* Logic Ops *
#define GL_LOGIC_OP                             &H0BF1
#define GL_INDEX_LOGIC_OP                       &H0BF1
#define GL_COLOR_LOGIC_OP                       &H0BF2
#define GL_LOGIC_OP_MODE                        &H0BF0
#define GL_CLEAR                                &H1500
#define GL_SET                                  &H150F
#define GL_COPY                                 &H1503
#define GL_COPY_INVERTED                        &H150C
#define GL_NOOP                                 &H1505
#define GL_INVERT                               &H150A
#define GL_AND                                  &H1501
#define GL_NAND                                 &H150E
#define GL_OR                                   &H1507
#define GL_NOR                                  &H1508
#define GL_XOR                                  &H1506
#define GL_EQUIV                                &H1509
#define GL_AND_REVERSE                          &H1502
#define GL_AND_INVERTED                         &H1504
#define GL_OR_REVERSE                           &H150B
#define GL_OR_INVERTED                          &H150D

''* Stencil *
#define GL_STENCIL_TEST                         &H0B90
#define GL_STENCIL_WRITEMASK                    &H0B98
#define GL_STENCIL_BITS                         &H0D57
#define GL_STENCIL_FUNC                         &H0B92
#define GL_STENCIL_VALUE_MASK                   &H0B93
#define GL_STENCIL_REF                          &H0B97
#define GL_STENCIL_FAIL                         &H0B94
#define GL_STENCIL_PASS_DEPTH_PASS              &H0B96
#define GL_STENCIL_PASS_DEPTH_FAIL              &H0B95
#define GL_STENCIL_CLEAR_VALUE                  &H0B91
#define GL_STENCIL_INDEX                        &H1901
#define GL_KEEP                                 &H1E00
#define GL_REPLACE                              &H1E01
#define GL_INCR                                 &H1E02
#define GL_DECR                                 &H1E03

''* Buffers, Pixel Drawing/Reading *
#define GL_NONE                                 &H0
#define GL_LEFT                                 &H0406
#define GL_RIGHT                                &H0407
''#define GL_FRONT                                &H0404      ''404h, 405h, 408h
''#define GL_BACK                                 &H0405	  ''are REMend in GL.H
''#define GL_FRONT_AND_BACK                       &H0408
#define GL_FRONT_LEFT                           &H0400
#define GL_FRONT_RIGHT                          &H0401
#define GL_BACK_LEFT                            &H0402
#define GL_BACK_RIGHT                           &H0403
#define GL_AUX0                                 &H0409
#define GL_AUX1                                 &H040A
#define GL_AUX2                                 &H040B
#define GL_AUX3                                 &H040C
#define GL_COLOR_INDEX                          &H1900
#define GL_RED                                  &H1903
#define GL_GREEN                                &H1904
#define GL_BLUE                                 &H1905
#define GL_ALPHA                                &H1906
#define GL_LUMINANCE                            &H1909
#define GL_LUMINANCE_ALPHA                      &H190A
#define GL_ALPHA_BITS                           &H0D55
#define GL_RED_BITS                             &H0D52
#define GL_GREEN_BITS                           &H0D53
#define GL_BLUE_BITS                            &H0D54
#define GL_INDEX_BITS                           &H0D51
#define GL_SUBPIXEL_BITS                        &H0D50
#define GL_AUX_BUFFERS                          &H0C00
#define GL_READ_BUFFER                          &H0C02
#define GL_DRAW_BUFFER                          &H0C01
#define GL_DOUBLEBUFFER                         &H0C32
#define GL_STEREO                               &H0C33
#define GL_BITMAP                               &H1A00
#define GL_COLOR                                &H1800
#define GL_DEPTH                                &H1801
#define GL_STENCIL                              &H1802
#define GL_DITHER                               &H0BD0
#define GL_RGB                                  &H1907
#define GL_RGBA                                 &H1908

''* Implementation limits *
#define GL_MAX_LIST_NESTING                     &H0B31
#define GL_MAX_ATTRIB_STACK_DEPTH               &H0D35
#define GL_MAX_MODELVIEW_STACK_DEPTH            &H0D36
#define GL_MAX_NAME_STACK_DEPTH                 &H0D37
#define GL_MAX_PROJECTION_STACK_DEPTH           &H0D38
#define GL_MAX_TEXTURE_STACK_DEPTH              &H0D39
#define GL_MAX_EVAL_ORDER                       &H0D30
#define GL_MAX_LIGHTS                           &H0D31
#define GL_MAX_CLIP_PLANES                      &H0D32
#define GL_MAX_TEXTURE_SIZE                     &H0D33
#define GL_MAX_PIXEL_MAP_TABLE                  &H0D34
#define GL_MAX_VIEWPORT_DIMS                    &H0D3A
#define GL_MAX_CLIENT_ATTRIB_STACK_DEPTH        &H0D3B

''* Gets *
#define GL_ATTRIB_STACK_DEPTH                   &H0BB0
#define GL_CLIENT_ATTRIB_STACK_DEPTH            &H0BB1
#define GL_COLOR_CLEAR_VALUE                    &H0C22
#define GL_COLOR_WRITEMASK                      &H0C23
#define GL_CURRENT_INDEX                        &H0B01
#define GL_CURRENT_COLOR                        &H0B00
#define GL_CURRENT_NORMAL                       &H0B02
#define GL_CURRENT_RASTER_COLOR                 &H0B04
#define GL_CURRENT_RASTER_DISTANCE              &H0B09
#define GL_CURRENT_RASTER_INDEX                 &H0B05
#define GL_CURRENT_RASTER_POSITION              &H0B07
#define GL_CURRENT_RASTER_TEXTURE_COORDS        &H0B06
#define GL_CURRENT_RASTER_POSITION_VALID        &H0B08
#define GL_CURRENT_TEXTURE_COORDS               &H0B03
#define GL_INDEX_CLEAR_VALUE                    &H0C20
#define GL_INDEX_MODE                           &H0C30
#define GL_INDEX_WRITEMASK                      &H0C21
#define GL_MODELVIEW_MATRIX                     &H0BA6
#define GL_MODELVIEW_STACK_DEPTH                &H0BA3
#define GL_NAME_STACK_DEPTH                     &H0D70
#define GL_PROJECTION_MATRIX                    &H0BA7
#define GL_PROJECTION_STACK_DEPTH               &H0BA4
#define GL_RENDER_MODE                          &H0C40
#define GL_RGBA_MODE                            &H0C31
#define GL_TEXTURE_MATRIX                       &H0BA8
#define GL_TEXTURE_STACK_DEPTH                  &H0BA5
#define GL_VIEWPORT                             &H0BA2

''* Evaluators *
#define GL_AUTO_NORMAL                          &H0D80
#define GL_MAP1_COLOR_4                         &H0D90
#define GL_MAP1_GRID_DOMAIN                     &H0DD0
#define GL_MAP1_GRID_SEGMENTS                   &H0DD1
#define GL_MAP1_INDEX                           &H0D91
#define GL_MAP1_NORMAL                          &H0D92
#define GL_MAP1_TEXTURE_COORD_1                 &H0D93
#define GL_MAP1_TEXTURE_COORD_2                 &H0D94
#define GL_MAP1_TEXTURE_COORD_3                 &H0D95
#define GL_MAP1_TEXTURE_COORD_4                 &H0D96
#define GL_MAP1_VERTEX_3                        &H0D97
#define GL_MAP1_VERTEX_4                        &H0D98
#define GL_MAP2_COLOR_4                         &H0DB0
#define GL_MAP2_GRID_DOMAIN                     &H0DD2
#define GL_MAP2_GRID_SEGMENTS                   &H0DD3
#define GL_MAP2_INDEX                           &H0DB1
#define GL_MAP2_NORMAL                          &H0DB2
#define GL_MAP2_TEXTURE_COORD_1                 &H0DB3
#define GL_MAP2_TEXTURE_COORD_2                 &H0DB4
#define GL_MAP2_TEXTURE_COORD_3                 &H0DB5
#define GL_MAP2_TEXTURE_COORD_4                 &H0DB6
#define GL_MAP2_VERTEX_3                        &H0DB7
#define GL_MAP2_VERTEX_4                        &H0DB8
#define GL_COEFF                                &H0A00
#define GL_DOMAIN                               &H0A02
#define GL_ORDER                                &H0A01

''* Hints *
#define GL_FOG_HINT                             &H0C54
#define GL_LINE_SMOOTH_HINT                     &H0C52
#define GL_PERSPECTIVE_CORRECTION_HINT          &H0C50
#define GL_POINT_SMOOTH_HINT                    &H0C51
#define GL_POLYGON_SMOOTH_HINT                  &H0C53
#define GL_DONT_CARE                            &H1100
#define GL_FASTEST                              &H1101
#define GL_NICEST                               &H1102

''* Scissor box *
#define GL_SCISSOR_TEST                         &H0C11
#define GL_SCISSOR_BOX                          &H0C10

''* Pixel Mode / Transfer *
#define GL_MAP_COLOR                            &H0D10
#define GL_MAP_STENCIL                          &H0D11
#define GL_INDEX_SHIFT                          &H0D12
#define GL_INDEX_OFFSET                         &H0D13
#define GL_RED_SCALE                            &H0D14
#define GL_RED_BIAS                             &H0D15
#define GL_GREEN_SCALE                          &H0D18
#define GL_GREEN_BIAS                           &H0D19
#define GL_BLUE_SCALE                           &H0D1A
#define GL_BLUE_BIAS                            &H0D1B
#define GL_ALPHA_SCALE                          &H0D1C
#define GL_ALPHA_BIAS                           &H0D1D
#define GL_DEPTH_SCALE                          &H0D1E
#define GL_DEPTH_BIAS                           &H0D1F
#define GL_PIXEL_MAP_S_TO_S_SIZE                &H0CB1
#define GL_PIXEL_MAP_I_TO_I_SIZE                &H0CB0
#define GL_PIXEL_MAP_I_TO_R_SIZE                &H0CB2
#define GL_PIXEL_MAP_I_TO_G_SIZE                &H0CB3
#define GL_PIXEL_MAP_I_TO_B_SIZE                &H0CB4
#define GL_PIXEL_MAP_I_TO_A_SIZE                &H0CB5
#define GL_PIXEL_MAP_R_TO_R_SIZE                &H0CB6
#define GL_PIXEL_MAP_G_TO_G_SIZE                &H0CB7
#define GL_PIXEL_MAP_B_TO_B_SIZE                &H0CB8
#define GL_PIXEL_MAP_A_TO_A_SIZE                &H0CB9
#define GL_PIXEL_MAP_S_TO_S                     &H0C71
#define GL_PIXEL_MAP_I_TO_I                     &H0C70
#define GL_PIXEL_MAP_I_TO_R                     &H0C72
#define GL_PIXEL_MAP_I_TO_G                     &H0C73
#define GL_PIXEL_MAP_I_TO_B                     &H0C74
#define GL_PIXEL_MAP_I_TO_A                     &H0C75
#define GL_PIXEL_MAP_R_TO_R                     &H0C76
#define GL_PIXEL_MAP_G_TO_G                     &H0C77
#define GL_PIXEL_MAP_B_TO_B                     &H0C78
#define GL_PIXEL_MAP_A_TO_A                     &H0C79
#define GL_PACK_ALIGNMENT                       &H0D05
#define GL_PACK_LSB_FIRST                       &H0D01
#define GL_PACK_ROW_LENGTH                      &H0D02
#define GL_PACK_SKIP_PIXELS                     &H0D04
#define GL_PACK_SKIP_ROWS                       &H0D03
#define GL_PACK_SWAP_BYTES                      &H0D00
#define GL_UNPACK_ALIGNMENT                     &H0CF5
#define GL_UNPACK_LSB_FIRST                     &H0CF1
#define GL_UNPACK_ROW_LENGTH                    &H0CF2
#define GL_UNPACK_SKIP_PIXELS                   &H0CF4
#define GL_UNPACK_SKIP_ROWS                     &H0CF3
#define GL_UNPACK_SWAP_BYTES                    &H0CF0
#define GL_ZOOM_X                               &H0D16
#define GL_ZOOM_Y                               &H0D17

''* Texture mapping *
#define GL_TEXTURE_ENV                          &H2300
#define GL_TEXTURE_ENV_MODE                     &H2200
#define GL_TEXTURE_1D                           &H0DE0
#define GL_TEXTURE_2D                           &H0DE1
#define GL_TEXTURE_WRAP_S                       &H2802
#define GL_TEXTURE_WRAP_T                       &H2803
#define GL_TEXTURE_MAG_FILTER                   &H2800
#define GL_TEXTURE_MIN_FILTER                   &H2801
#define GL_TEXTURE_ENV_COLOR                    &H2201
#define GL_TEXTURE_GEN_S                        &H0C60
#define GL_TEXTURE_GEN_T                        &H0C61
#define GL_TEXTURE_GEN_MODE                     &H2500
#define GL_TEXTURE_BORDER_COLOR                 &H1004
#define GL_TEXTURE_WIDTH                        &H1000
#define GL_TEXTURE_HEIGHT                       &H1001
#define GL_TEXTURE_BORDER                       &H1005
#define GL_TEXTURE_COMPONENTS                   &H1003
#define GL_TEXTURE_RED_SIZE                     &H805C
#define GL_TEXTURE_GREEN_SIZE                   &H805D
#define GL_TEXTURE_BLUE_SIZE                    &H805E
#define GL_TEXTURE_ALPHA_SIZE                   &H805F
#define GL_TEXTURE_LUMINANCE_SIZE               &H8060
#define GL_TEXTURE_INTENSITY_SIZE               &H8061
#define GL_NEAREST_MIPMAP_NEAREST               &H2700
#define GL_NEAREST_MIPMAP_LINEAR                &H2702
#define GL_LINEAR_MIPMAP_NEAREST                &H2701
#define GL_LINEAR_MIPMAP_LINEAR                 &H2703
#define GL_OBJECT_LINEAR                        &H2401
#define GL_OBJECT_PLANE                         &H2501
#define GL_EYE_LINEAR                           &H2400
#define GL_EYE_PLANE                            &H2502
#define GL_SPHERE_MAP                           &H2402
#define GL_DECAL                                &H2101
#define GL_MODULATE                             &H2100
#define GL_NEAREST                              &H2600
#define GL_REPEAT                               &H2901
#define GL_CLAMP                                &H2900
#define GL_S                                    &H2000
#define GL_T                                    &H2001
#define GL_R                                    &H2002
#define GL_Q                                    &H2003
#define GL_TEXTURE_GEN_R                        &H0C62
#define GL_TEXTURE_GEN_Q                        &H0C63

''* Utility *
#define GL_VENDOR                               &H1F00
#define GL_RENDERER                             &H1F01
#define GL_VERSION                              &H1F02
#define GL_EXTENSIONS                           &H1F03

''* Errors *
#define GL_NO_ERROR                             &H0
#define GL_INVALID_VALUE                        &H0501
#define GL_INVALID_ENUM                         &H0500
#define GL_INVALID_OPERATION                    &H0502
#define GL_STACK_OVERFLOW                       &H0503
#define GL_STACK_UNDERFLOW                      &H0504
#define GL_OUT_OF_MEMORY                        &H0505

''* glPush/PopAttrib bits *
#define GL_CURRENT_BIT                          &H00000001
#define GL_POINT_BIT                            &H00000002
#define GL_LINE_BIT                             &H00000004
#define GL_POLYGON_BIT                          &H00000008
#define GL_POLYGON_STIPPLE_BIT                  &H00000010
#define GL_PIXEL_MODE_BIT                       &H00000020
#define GL_LIGHTING_BIT                         &H00000040
#define GL_FOG_BIT                              &H00000080
#define GL_DEPTH_BUFFER_BIT                     &H00000100
#define GL_ACCUM_BUFFER_BIT                     &H00000200
#define GL_STENCIL_BUFFER_BIT                   &H00000400
#define GL_VIEWPORT_BIT                         &H00000800
#define GL_TRANSFORM_BIT                        &H00001000
#define GL_ENABLE_BIT                           &H00002000
#define GL_COLOR_BUFFER_BIT                     &H00004000
#define GL_HINT_BIT                             &H00008000
#define GL_EVAL_BIT                             &H00010000
#define GL_LIST_BIT                             &H00020000
#define GL_TEXTURE_BIT                          &H00040000
#define GL_SCISSOR_BIT                          &H00080000
#define GL_ALL_ATTRIB_BITS                      &H000FFFFF


''* OpenGL 1.1 *
#define GL_PROXY_TEXTURE_1D                     &H8063
#define GL_PROXY_TEXTURE_2D                     &H8064
#define GL_TEXTURE_PRIORITY                     &H8066
#define GL_TEXTURE_RESIDENT                     &H8067
#define GL_TEXTURE_BINDING_1D                   &H8068
#define GL_TEXTURE_BINDING_2D                   &H8069
#define GL_TEXTURE_INTERNAL_FORMAT              &H1003
#define GL_ALPHA4                               &H803B
#define GL_ALPHA8                               &H803C
#define GL_ALPHA12                              &H803D
#define GL_ALPHA16                              &H803E
#define GL_LUMINANCE4                           &H803F
#define GL_LUMINANCE8                           &H8040
#define GL_LUMINANCE12                          &H8041
#define GL_LUMINANCE16                          &H8042
#define GL_LUMINANCE4_ALPHA4                    &H8043
#define GL_LUMINANCE6_ALPHA2                    &H8044
#define GL_LUMINANCE8_ALPHA8                    &H8045
#define GL_LUMINANCE12_ALPHA4                   &H8046
#define GL_LUMINANCE12_ALPHA12                  &H8047
#define GL_LUMINANCE16_ALPHA16                  &H8048
#define GL_INTENSITY                            &H8049
#define GL_INTENSITY4                           &H804A
#define GL_INTENSITY8                           &H804B
#define GL_INTENSITY12                          &H804C
#define GL_INTENSITY16                          &H804D
#define GL_R3_G3_B2                             &H2A10
#define GL_RGB4                                 &H804F
#define GL_RGB5                                 &H8050
#define GL_RGB8                                 &H8051
#define GL_RGB10                                &H8052
#define GL_RGB12                                &H8053
#define GL_RGB16                                &H8054
#define GL_RGBA2                                &H8055
#define GL_RGBA4                                &H8056
#define GL_RGB5_A1                              &H8057
#define GL_RGBA8                                &H8058
#define GL_RGB10_A2                             &H8059
#define GL_RGBA12                               &H805A
#define GL_RGBA16                               &H805B
#define GL_CLIENT_PIXEL_STORE_BIT               &H00000001
#define GL_CLIENT_VERTEX_ARRAY_BIT              &H00000002
#define GL_ALL_CLIENT_ATTRIB_BITS               &HFFFFFFFF
#define GL_CLIENT_ALL_ATTRIB_BITS               &HFFFFFFFF



''************************************************************************
'' *
'' * Function prototypes
'' *
'' ************************************************************************

''* Miscellaneous *
DECLARE SUB 	  glClearIndex ALIAS "glClearIndex"  ( BYVAL c AS GLfloat )
DECLARE SUB 	  glClearColor ALIAS "glClearColor" ( BYVAL red AS GLclampf, BYVAL green AS GLclampf, BYVAL blue AS GLclampf, BYVAL alpha AS GLclampf )
DECLARE SUB 	  glClear ALIAS "glClear" ( BYVAL mask AS GLbitfield )
DECLARE SUB 	  glIndexMask ALIAS "glIndexMask" ( BYVAL mask AS GLuint )
DECLARE SUB 	  glColorMask ALIAS "glColorMask" ( BYVAL red AS GLboolean, BYVAL green AS GLboolean, BYVAL blue AS GLboolean, BYVAL alpha AS GLboolean )
DECLARE SUB 	  glAlphaFunc ALIAS "glAlphaFunc" ( BYVAL func AS GLenum, BYVAL ref AS GLclampf )
DECLARE SUB 	  glBlendFunc ALIAS "glBlendFunc" ( BYVAL sfactor AS GLenum, BYVAL  dfactor AS GLenum )
DECLARE SUB 	  glLogicOp ALIAS "glLogicOp" ( BYVAL opcode AS GLenum )
DECLARE SUB 	  glCullFace ALIAS "glCullFace" ( BYVAL mode AS GLenum )
DECLARE SUB 	  glFrontFace ALIAS "glFrontFace" ( BYVAL mode AS GLenum )
DECLARE SUB 	  glPointSize ALIAS "glPointSize" ( BYVAL size AS GLfloat )
DECLARE SUB 	  glLineWidth ALIAS "glLineWidth" ( BYVAL width AS GLfloat )
DECLARE SUB 	  glLineStipple ALIAS "glLineStipple" ( BYVAL factor AS GLint, BYVAL pattern AS GLushort )
DECLARE SUB 	  glPolygonMode ALIAS "glPolygonMode" ( BYVAL face AS GLenum, BYVAL mode AS GLenum )
DECLARE SUB 	  glPolygonOffset ALIAS "glPolygonOffset" ( BYVAL factor AS GLfloat, BYVAL units AS GLfloat )
DECLARE SUB 	  glPolygonStipple ALIAS "glPolygonStipple" ( BYVAL mask AS GLubyte PTR )
DECLARE SUB 	  glGetPolygonStipple ALIAS "glGetPolygonStipple" ( BYVAL mask AS GLubyte PTR )
DECLARE SUB 	  glEdgeFlag ALIAS "glEdgeFlag" ( BYVAL flag AS GLboolean )
DECLARE SUB 	  glEdgeFlagv ALIAS "glEdgeFlagv" ( BYVAL flag AS GLboolean PTR )
DECLARE SUB 	  glScissor ALIAS "glScissor" ( BYVAL x AS GLint, BYVAL y AS GLint, BYVAL width AS GLsizei, BYVAL height AS GLsizei )
DECLARE SUB 	  glClipPlane ALIAS "glClipPlane" ( BYVAL plane AS GLenum , BYVAL equation AS GLdouble PTR )
DECLARE SUB 	  glGetClipPlane ALIAS "glGetClipPlane" ( BYVAL plane AS GLenum, BYVAL equation AS GLdouble PTR )
DECLARE SUB 	  glDrawBuffer ALIAS "glDrawBuffer" ( BYVAL mode AS GLenum )
DECLARE SUB 	  glReadBuffer ALIAS "glReadBuffer" ( BYVAL mode AS GLenum )
DECLARE SUB 	  glEnable ALIAS "glEnable" ( BYVAL cap AS GLenum )
DECLARE SUB 	  glDisable ALIAS "glDisable" ( BYVAL cap AS GLenum )
DECLARE FUNCTION  glIsEnabled ALIAS "glIsEnabled" ( BYVAL cap AS GLenum ) AS Glboolean
DECLARE SUB 	  glEnableClientState ALIAS "glEnableClientState" ( BYVAL cap AS GLenum )   ''* 1.1 *
DECLARE SUB 	  glDisableClientState ALIAS "glDisableClientState" ( BYVAL cap AS GLenum )  ''* 1.1 *
DECLARE SUB 	  glGetBooleanv ALIAS "glGetBooleanv" ( BYVAL pname AS GLenum, BYVAL params AS GLboolean PTR )
DECLARE SUB 	  glGetDoublev ALIAS "glGetDoublev" ( BYVAL pname AS GLenum, BYVAL params AS GLdouble PTR )
DECLARE SUB 	  glGetFloatv ALIAS "glGetFloatv" ( BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glGetIntegerv ALIAS "glGetIntegerv" ( BYVAL pname AS GLenum , BYVAL params AS GLint PTR )
DECLARE SUB 	  glPushAttrib ALIAS "glPushAttrib" ( BYVAL mask AS GLbitfield )
DECLARE SUB 	  glPopAttrib ALIAS "glPopAttrib" ()
DECLARE SUB 	  glPushClientAttrib ALIAS "glPushClientAttrib" ( BYVAL mask AS GLbitfield )  ''* 1.1 *
DECLARE SUB 	  glPopClientAttrib ALIAS "glPopClientAttrib" ()        	 			   	  ''* 1.1 *
DECLARE FUNCTION  glRenderMode ALIAS "glRenderMode" ( BYVAL mode AS GLenum ) AS GLint
DECLARE FUNCTION  glGetError ALIAS "glGetError" ( BYVAL) AS GLenum
DECLARE FUNCTION  glGetString ALIAS "glGetString" ( BYVAL name AS GLenum ) AS GLubyte PTR
DECLARE SUB 	  glFinish ALIAS "glFinish" ()
DECLARE SUB 	  glFlush ALIAS "glFlush" ()
DECLARE SUB 	  glHint ALIAS "glHint" ( BYVAL target AS GLenum, BYVAL mode AS GLenum )

''* Depth Buffer *
DECLARE SUB 	  glClearDepth ALIAS "glClearDepth" ( BYVAL depth AS GLclampd )
DECLARE SUB 	  glDepthFunc ALIAS "glDepthFunc" ( BYVAL func AS GLenum )
DECLARE SUB 	  glDepthMask ALIAS "glDepthMask" ( BYVAL flag AS GLboolean )
DECLARE SUB 	  glDepthRange ALIAS "glDepthRange" ( BYVAL near_val AS GLclampd , BYVAL far_val AS GLclampd )

''* Accumulation Buffer *
DECLARE SUB 	  glClearAccum ALIAS "glClearAccum" ( BYVAL red AS GLfloat, BYVAL green AS GLfloat, BYVAL blue AS GLfloat, BYVAL alpha AS GLfloat )
DECLARE SUB 	  glAccum ALIAS "glAccum" ( BYVAL op AS GLenum, BYVAL value AS GLfloat )

''* Transformation *
DECLARE SUB 	  glMatrixMode ALIAS "glMatrixMode" ( BYVAL mode AS GLenum )
DECLARE SUB 	  glOrtho ALIAS "glOrtho" ( BYVAL left AS GLdouble, BYVAL right AS GLdouble, BYVAL bottom AS GLdouble, BYVAL top AS GLdouble, BYVAL near_val AS GLdouble, BYVAL far_val AS GLdouble )
DECLARE SUB 	  glFrustum ALIAS "glFrustum" ( BYVAL left AS GLdouble, BYVAL right AS GLdouble, BYVAL bottom AS GLdouble, BYVAL top AS GLdouble, BYVAL near_val AS GLdouble, BYVAL far_val AS GLdouble )
DECLARE SUB 	  glViewport ALIAS "glViewport" ( BYVAL x AS GLint, BYVAL y AS GLint, BYVAL width AS GLsizei, BYVAL height AS GLsizei )
DECLARE SUB 	  glPushMatrix ALIAS "glPushMatrix" ()
DECLARE SUB 	  glPopMatrix ALIAS "glPopMatrix" ()
DECLARE SUB 	  glLoadIdentity ALIAS "glLoadIdentity" ()
DECLARE SUB 	  glLoadMatrixd ALIAS "glLoadMatrixd" ( BYVAL m AS GLdouble PTR )
DECLARE SUB 	  glLoadMatrixf ALIAS "glLoadMatrixf" ( BYVAL m AS GLfloat PTR )
DECLARE SUB 	  glMultMatrixd ALIAS "glMultMatrixd" ( BYVAL m AS GLdouble PTR )
DECLARE SUB 	  glMultMatrixf ALIAS "glMultMatrixf" ( BYVAL m AS GLfloat PTR )
DECLARE SUB 	  glRotated ALIAS "glRotated" ( BYVAL angle AS GLdouble, BYVAL x AS GLdouble, BYVAL y AS GLdouble, BYVAL z AS GLdouble )
DECLARE SUB 	  glRotatef ALIAS "glRotatef" ( BYVAL angle AS GLfloat, BYVAL x AS GLfloat, BYVAL y AS GLfloat, BYVAL z AS GLfloat )
DECLARE SUB 	  glScaled ALIAS "glScaled" ( BYVAL x AS GLdouble, BYVAL y AS GLdouble, BYVAL z AS GLdouble )
DECLARE SUB 	  glScalef ALIAS "glScalef" ( BYVAL x AS GLfloat, BYVAL y AS GLfloat, BYVAL z AS GLfloat )
DECLARE SUB 	  glTranslated ALIAS "glTranslated" ( BYVAL x AS GLdouble, BYVAL y AS GLdouble, BYVAL z AS GLdouble )
DECLARE SUB 	  glTranslatef ALIAS "glTranslatef" ( BYVAL x AS GLfloat, BYVAL y AS GLfloat, BYVAL z AS GLfloat )

''* Display Lists *
DECLARE FUNCTION  glIsList ALIAS "glTranslatef" ( BYVAL list AS GLuint ) AS GLboolean
DECLARE SUB 	  glDeleteLists ALIAS "glDeleteLists" ( BYVAL list AS GLuint, BYVAL range AS GLsizei )
DECLARE FUNCTION  glGenLists ALIAS "glGenLists" ( BYVAL range AS GLsizei ) AS GLuint
DECLARE SUB 	  glNewList ALIAS "glNewList" ( BYVAL list AS GLuint, BYVAL mode AS GLenum )
DECLARE SUB 	  glEndList ALIAS "glEndList" ()
DECLARE SUB 	  glCallList ALIAS "glCallList" ( BYVAL list AS GLuint )
DECLARE SUB 	  glCallLists ALIAS "glCallLists" ( BYVAL n AS GLsizei, BYVAL type AS GLenum, BYVAL lists AS GLvoid PTR)
DECLARE SUB 	  glListBase ALIAS "glListBase" ( BYVAL base AS GLuint )

''* Drawing Functions *
DECLARE SUB 	  glBegin ALIAS "glBegin" ( BYVAL mode AS GLenum )
DECLARE SUB 	  glEnd 	  ALIAS "glEnd" ()
DECLARE SUB 	  glVertex2d ALIAS "glVertex2d" ( BYVAL x AS GLdouble, BYVAL y AS GLdouble )
DECLARE SUB 	  glVertex2f ALIAS "glVertex2f" ( BYVAL x AS GLfloat, BYVAL y AS GLfloat )
DECLARE SUB 	  glVertex2i ALIAS "glVertex2i" ( BYVAL x AS GLint, BYVAL y AS GLint )
DECLARE SUB 	  glVertex2s ALIAS "glVertex2s" ( BYVAL x AS GLshort, BYVAL y AS GLshort )
DECLARE SUB 	  glVertex3d ALIAS "glVertex3d" ( BYVAL x AS GLdouble, BYVAL y AS GLdouble, BYVAL z AS GLdouble)
DECLARE SUB 	  glVertex3f ALIAS "glVertex3f" ( BYVAL x AS GLfloat, BYVAL y AS GLfloat, BYVAL z AS GLfloat )
DECLARE SUB 	  glVertex3i ALIAS "glVertex3i" ( BYVAL x AS GLint, BYVAL y AS GLint, BYVAL z AS GLint )
DECLARE SUB 	  glVertex3s ALIAS "glVertex3s" ( BYVAL x AS GLshort, BYVAL y AS GLshort, BYVAL z AS GLshort )
DECLARE SUB 	  glVertex4d ALIAS "glVertex4d" ( BYVAL x AS GLdouble, BYVAL y AS GLdouble, BYVAL z AS GLdouble, BYVAL w AS GLdouble )
DECLARE SUB 	  glVertex4f ALIAS "glVertex4f" ( BYVAL x AS GLfloat, BYVAL y AS GLfloat, BYVAL z AS GLfloat, BYVAL w AS GLfloat )
DECLARE SUB 	  glVertex4i ALIAS "glVertex4i" ( BYVAL x AS GLint, BYVAL y AS GLint, BYVAL z AS GLint, BYVAL w AS GLint )
DECLARE SUB 	  glVertex4s ALIAS "glVertex4s" ( BYVAL x AS GLshort, BYVAL y AS GLshort, BYVAL z AS GLshort, BYVAL w AS GLshort )
DECLARE SUB 	  glVertex2dv ALIAS "glVertex2dv" ( BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glVertex2fv ALIAS "glVertex2fv" ( BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glVertex2iv ALIAS "glVertex2iv" ( BYVAL v AS GLint PTR )
DECLARE SUB 	  glVertex2sv ALIAS "glVertex2sv" ( BYVAL v AS GLshort PTR )
DECLARE SUB 	  glVertex3dv ALIAS "glVertex3dv" ( BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glVertex3fv ALIAS "glVertex3fv" ( BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glVertex3iv ALIAS "glVertex3iv" ( BYVAL v AS GLint PTR )
DECLARE SUB 	  glVertex3sv ALIAS "glVertex3sv" ( BYVAL v AS GLshort PTR )
DECLARE SUB 	  glVertex4dv ALIAS "glVertex4dv" ( BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glVertex4fv ALIAS "glVertex4fv" ( BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glVertex4iv ALIAS "glVertex4iv" ( BYVAL v AS GLint PTR )
DECLARE SUB 	  glVertex4sv ALIAS "glVertex4sv" ( BYVAL v AS GLshort PTR )
DECLARE SUB 	  glNormal3b ALIAS "glNormal3b" ( BYVAL nx AS GLbyte, BYVAL ny AS GLbyte, BYVAL nz AS GLbyte )
DECLARE SUB 	  glNormal3d ALIAS "glNormal3d" ( BYVAL nx AS GLdouble, BYVAL ny AS GLdouble, BYVAL nz AS GLdouble )
DECLARE SUB 	  glNormal3f ALIAS "glNormal3f" ( BYVAL nx AS GLfloat, BYVAL ny AS GLfloat, BYVAL nz AS GLfloat )
DECLARE SUB 	  glNormal3i ALIAS "glNormal3i" ( BYVAL nx AS GLint, BYVAL ny AS GLint, BYVAL nz AS GLint )
DECLARE SUB 	  glNormal3s ALIAS "glNormal3s" ( BYVAL nx AS GLshort, BYVAL ny AS GLshort, BYVAL nz AS GLshort )
DECLARE SUB 	  glNormal3bv ALIAS "glNormal3bv" ( BYVAL  v AS GLbyte PTR )
DECLARE SUB 	  glNormal3dv ALIAS "glNormal3dv" ( BYVAL  v AS GLdouble PTR )
DECLARE SUB 	  glNormal3fv ALIAS "glNormal3fv" ( BYVAL  v AS GLfloat PTR )
DECLARE SUB 	  glNormal3iv ALIAS "glNormal3iv" ( BYVAL  v AS GLint PTR )
DECLARE SUB 	  glNormal3sv ALIAS "glNormal3sv" ( BYVAL  v AS GLshort PTR )
DECLARE SUB 	  glIndexd ALIAS "glIndexd" ( BYVAL c AS GLdouble )
DECLARE SUB 	  glIndexf ALIAS "glIndexf" ( BYVAL c AS GLfloat )
DECLARE SUB 	  glIndexi ALIAS "glIndexi" ( BYVAL c AS GLint )
DECLARE SUB 	  glIndexs ALIAS "glIndexs" ( BYVAL c AS GLshort )
DECLARE SUB 	  glIndexub ALIAS "glIndexub" ( BYVAL c AS GLubyte )  ''* 1.1 *
DECLARE SUB 	  glIndexdv ALIAS "glIndexdv" ( BYVAL c AS GLdouble PTR )
DECLARE SUB 	  glIndexfv ALIAS "glIndexfv" ( BYVAL c AS GLfloat PTR )
DECLARE SUB 	  glIndexiv ALIAS "glIndexiv" ( BYVAL c AS GLint PTR )
DECLARE SUB 	  glIndexsv ALIAS "glIndexsv" ( BYVAL c AS GLshort PTR )
DECLARE SUB 	  glIndexubv ALIAS "glIndexubv" ( BYVAL c AS GLubyte PTR )  ''* 1.1 *
DECLARE SUB 	  glColor3b ALIAS "glColor3b" ( BYVAL red AS GLbyte, BYVAL green AS GLbyte, BYVAL blue AS GLbyte )
DECLARE SUB 	  glColor3d ALIAS "glColor3d" ( BYVAL red AS GLdouble, BYVAL green AS GLdouble, BYVAL blue AS GLdouble)
DECLARE SUB 	  glColor3f ALIAS "glColor3f" ( BYVAL red AS GLfloat, BYVAL green AS GLfloat, BYVAL blue AS GLfloat )
DECLARE SUB 	  glColor3i ALIAS "glColor3i" ( BYVAL red AS GLint, BYVAL green AS GLint, BYVAL blue AS GLint )
DECLARE SUB 	  glColor3s ALIAS "glColor3s" ( BYVAL red AS GLshort, BYVAL green AS GLshort, BYVAL blue AS GLshort )
DECLARE SUB 	  glColor3ub ALIAS "glColor3ub" ( BYVAL red AS GLubyte, BYVAL green AS GLubyte, BYVAL blue AS GLubyte )
DECLARE SUB 	  glColor3ui ALIAS "glColor3ui" ( BYVAL red AS GLuint, BYVAL green AS GLuint, BYVAL blue AS GLuint )
DECLARE SUB 	  glColor3us ALIAS "glColor3us" ( BYVAL red AS GLushort, BYVAL green AS GLushort, BYVAL blue AS GLushort )
DECLARE SUB 	  glColor4b ALIAS "glColor4b" ( BYVAL red AS GLbyte, BYVAL green AS GLbyte, BYVAL blue AS GLbyte, BYVAL alpha AS GLbyte )
DECLARE SUB 	  glColor4d ALIAS "glColor4d" ( BYVAL red AS GLdouble, BYVAL green AS GLdouble, BYVAL blue AS GLdouble, BYVAL alpha AS GLdouble )
DECLARE SUB 	  glColor4f ALIAS "glColor4f" ( BYVAL red AS GLfloat, BYVAL green AS GLfloat, BYVAL blue AS GLfloat, BYVAL alpha AS GLfloat )
DECLARE SUB 	  glColor4i ALIAS "glColor4i" ( BYVAL red AS GLint, BYVAL green AS GLint, BYVAL blue AS GLint, BYVAL alpha AS GLint)
DECLARE SUB 	  glColor4s ALIAS "glColor4s" ( BYVAL red AS GLshort, BYVAL green AS GLshort, BYVAL blue AS GLshort, BYVAL alpha AS GLshort )
DECLARE SUB 	  glColor4ub ALIAS "glColor4ub" ( BYVAL red AS GLubyte, BYVAL green AS GLubyte, BYVAL blue AS GLubyte, BYVAL alpha AS GLubyte )
DECLARE SUB 	  glColor4ui ALIAS "glColor4ui" ( BYVAL red AS GLuint, BYVAL green AS GLuint, BYVAL blue AS GLuint, BYVAL alpha AS GLuint )
DECLARE SUB 	  glColor4us ALIAS "glColor4us" ( BYVAL red AS GLushort, BYVAL green AS GLushort, BYVAL blue AS GLushort, BYVAL alpha AS GLushort )
DECLARE SUB 	  glColor3bv ALIAS "glColor3bv" ( BYVAL v AS GLbyte PTR )
DECLARE SUB 	  glColor3dv ALIAS "glColor3dv" ( BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glColor3fv ALIAS "glColor3fv" ( BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glColor3iv ALIAS "glColor3iv" ( BYVAL v AS GLint PTR )
DECLARE SUB 	  glColor3sv ALIAS "glColor3sv" ( BYVAL v AS GLshort PTR )
DECLARE SUB 	  glColor3ubv ALIAS "glColor3ubv" ( BYVAL v AS GLubyte PTR )
DECLARE SUB 	  glColor3uiv ALIAS "glColor3uiv" ( BYVAL v AS GLuint PTR )
DECLARE SUB 	  glColor3usv ALIAS "glColor3usv" ( BYVAL v AS GLushort PTR )
DECLARE SUB 	  glColor4bv ALIAS "glColor4bv" ( BYVAL v AS GLbyte PTR )
DECLARE SUB 	  glColor4dv ALIAS "glColor4dv" ( BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glColor4fv ALIAS "glColor4fv" ( BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glColor4iv ALIAS "glColor4iv" ( BYVAL v AS GLint PTR )
DECLARE SUB 	  glColor4sv ALIAS "glColor4sv" ( BYVAL v AS GLshort PTR )
DECLARE SUB 	  glColor4ubv ALIAS "glColor4ubv" ( BYVAL v AS GLubyte PTR )
DECLARE SUB 	  glColor4uiv ALIAS "glColor4uiv" ( BYVAL v AS GLuint PTR )
DECLARE SUB 	  glColor4usv ALIAS "glColor4usv" ( BYVAL v AS GLushort PTR )
DECLARE SUB 	  glTexCoord1d ALIAS "glTexCoord1d" ( BYVAL s AS GLdouble )
DECLARE SUB 	  glTexCoord1f ALIAS "glTexCoord1f" ( BYVAL s AS GLfloat )
DECLARE SUB 	  glTexCoord1i ALIAS "glTexCoord1i" ( BYVAL s AS GLint )
DECLARE SUB 	  glTexCoord1s ALIAS "glTexCoord1s" ( BYVAL s AS GLshort )
DECLARE SUB 	  glTexCoord2d ALIAS "glTexCoord2d" ( BYVAL s AS GLdouble, BYVAL t AS GLdouble )
DECLARE SUB 	  glTexCoord2f ALIAS "glTexCoord2f" ( BYVAL s AS GLfloat , BYVAL t AS GLfloat )
DECLARE SUB 	  glTexCoord2i ALIAS "glTexCoord2i" ( BYVAL s AS GLint , BYVAL t AS GLint )
DECLARE SUB 	  glTexCoord2s ALIAS "glTexCoord2s" ( BYVAL s AS GLshort , BYVAL t AS GLshort )
DECLARE SUB 	  glTexCoord3d ALIAS "glTexCoord3d" ( BYVAL s AS GLdouble, BYVAL t AS GLdouble, BYVAL r AS GLdouble )
DECLARE SUB 	  glTexCoord3f ALIAS "glTexCoord3f" ( BYVAL s AS GLfloat, BYVAL t AS GLfloat, BYVAL r AS GLfloat )
DECLARE SUB 	  glTexCoord3i ALIAS "glTexCoord3i" ( BYVAL s AS GLint, BYVAL t AS GLint, BYVAL r AS GLint )
DECLARE SUB 	  glTexCoord3s ALIAS "glTexCoord3s" ( BYVAL s AS GLshort, BYVAL t AS GLshort, BYVAL r AS GLshort )
DECLARE SUB 	  glTexCoord4d ALIAS "glTexCoord4d" ( BYVAL s AS GLdouble, BYVAL t AS GLdouble, BYVAL r AS GLdouble, BYVAL q AS GLdouble )
DECLARE SUB 	  glTexCoord4f ALIAS "glTexCoord4f" ( BYVAL s AS GLfloat, BYVAL t AS GLfloat, BYVAL r AS GLfloat, BYVAL q AS GLfloat )
DECLARE SUB 	  glTexCoord4i ALIAS "glTexCoord4i" ( BYVAL s AS GLint, BYVAL t AS GLint, BYVAL r AS GLint, BYVAL q AS GLint )
DECLARE SUB 	  glTexCoord4s ALIAS "glTexCoord4s" ( BYVAL s AS GLshort, BYVAL t AS GLshort, BYVAL r AS GLshort, BYVAL q AS GLshort )
DECLARE SUB 	  glTexCoord1dv ALIAS "glTexCoord1dv" ( BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glTexCoord1fv ALIAS "glTexCoord1fv" ( BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glTexCoord1iv ALIAS "glTexCoord1iv" ( BYVAL v AS GLint PTR )
DECLARE SUB 	  glTexCoord1sv ALIAS "glTexCoord1sv" ( BYVAL v AS GLshort PTR )
DECLARE SUB 	  glTexCoord2dv ALIAS "glTexCoord2dv" ( BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glTexCoord2fv ALIAS "glTexCoord2fv" ( BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glTexCoord2iv ALIAS "glTexCoord2iv" ( BYVAL v AS GLint PTR )
DECLARE SUB 	  glTexCoord2sv ALIAS "glTexCoord2sv" ( BYVAL v AS GLshort PTR )
DECLARE SUB 	  glTexCoord3dv ALIAS "glTexCoord3dv" ( BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glTexCoord3fv ALIAS "glTexCoord3fv" ( BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glTexCoord3iv ALIAS "glTexCoord3iv" ( BYVAL v AS GLint PTR )
DECLARE SUB 	  glTexCoord3sv ALIAS "glTexCoord3sv" ( BYVAL v AS GLshort PTR )
DECLARE SUB 	  glTexCoord4dv ALIAS "glTexCoord4dv" ( BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glTexCoord4fv ALIAS "glTexCoord4fv" ( BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glTexCoord4iv ALIAS "glTexCoord4iv" ( BYVAL v AS GLint PTR )
DECLARE SUB 	  glTexCoord4sv ALIAS "glTexCoord4sv" ( BYVAL v AS GLshort PTR )
DECLARE SUB 	  glRasterPos2d ALIAS "glRasterPos2d" ( BYVAL x AS GLdouble, BYVAL y AS GLdouble )
DECLARE SUB 	  glRasterPos2f ALIAS "glRasterPos2f" ( BYVAL x AS GLfloat, BYVAL y AS GLfloat )
DECLARE SUB 	  glRasterPos2i ALIAS "glRasterPos2i" ( BYVAL x AS GLint, BYVAL y AS GLint )
DECLARE SUB 	  glRasterPos2s ALIAS "glRasterPos2s" ( BYVAL x AS GLshort, BYVAL y AS GLshort )
DECLARE SUB 	  glRasterPos3d ALIAS "glRasterPos3d" ( BYVAL x AS GLdouble, BYVAL y AS GLdouble, BYVAL z AS GLdouble )
DECLARE SUB 	  glRasterPos3f ALIAS "glRasterPos3f" ( BYVAL x AS GLfloat, BYVAL y AS GLfloat, BYVAL z AS GLfloat )
DECLARE SUB 	  glRasterPos3i ALIAS "glRasterPos3i" ( BYVAL x AS GLint, BYVAL y AS GLint, BYVAL z AS GLint )
DECLARE SUB 	  glRasterPos3s ALIAS "glRasterPos3s" ( BYVAL x AS GLshort, BYVAL y AS GLshort, BYVAL z AS GLshort )
DECLARE SUB 	  glRasterPos4d ALIAS "glRasterPos4d" ( BYVAL x AS GLdouble, BYVAL y AS GLdouble, BYVAL z AS GLdouble, BYVAL w AS GLdouble )
DECLARE SUB 	  glRasterPos4f ALIAS "glRasterPos4f" ( BYVAL x AS GLfloat, BYVAL y AS GLfloat, BYVAL z AS GLfloat, BYVAL w AS GLfloat )
DECLARE SUB 	  glRasterPos4i ALIAS "glRasterPos4i" ( BYVAL x AS GLint, BYVAL y AS GLint, BYVAL z AS GLint, BYVAL w AS GLint )
DECLARE SUB 	  glRasterPos4s ALIAS "glRasterPos4s" ( BYVAL x AS GLshort, BYVAL y AS GLshort, BYVAL z AS GLshort, BYVAL w AS GLshort )
DECLARE SUB 	  glRasterPos2dv ALIAS "glRasterPos2dv" ( BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glRasterPos2fv ALIAS "glRasterPos2fv" ( BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glRasterPos2iv ALIAS "glRasterPos2iv" ( BYVAL v AS GLint PTR )
DECLARE SUB 	  glRasterPos2sv ALIAS "glRasterPos2sv" ( BYVAL v AS GLshort PTR )
DECLARE SUB 	  glRasterPos3dv ALIAS "glRasterPos3dv" ( BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glRasterPos3fv ALIAS "glRasterPos3fv" ( BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glRasterPos3iv ALIAS "glRasterPos3iv" ( BYVAL v AS GLint PTR )
DECLARE SUB 	  glRasterPos3sv ALIAS "glRasterPos3sv" ( BYVAL v AS GLshort PTR )
DECLARE SUB 	  glRasterPos4dv ALIAS "glRasterPos4dv" ( BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glRasterPos4fv ALIAS "glRasterPos4fv" ( BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glRasterPos4iv ALIAS "glRasterPos4iv" ( BYVAL v AS GLint PTR )
DECLARE SUB 	  glRasterPos4sv ALIAS "glRasterPos4sv" ( BYVAL v AS GLshort PTR )
DECLARE SUB 	  glRectd ALIAS "glRectd" ( BYVAL x1 AS GLdouble, BYVAL y1 AS GLdouble, BYVAL x2 AS GLdouble, BYVAL y2 AS GLdouble )
DECLARE SUB 	  glRectf ALIAS "glRectf" ( BYVAL x1 AS GLfloat, BYVAL y1 AS GLfloat , BYVAL x2 AS GLfloat, BYVAL y2 AS GLfloat )
DECLARE SUB 	  glRecti ALIAS "glRecti" ( BYVAL x1 AS GLint, BYVAL y1 AS GLint, BYVAL x2 AS GLint, BYVAL y2 AS GLint )
DECLARE SUB 	  glRects ALIAS "glRects" ( BYVAL x1 AS GLshort, BYVAL y1 AS GLshort , BYVAL x2 AS GLshort, BYVAL y2 AS GLshort )
DECLARE SUB 	  glRectdv ALIAS "glRectdv" ( BYVAL v1 AS GLdouble PTR, BYVAL v2 AS GLdouble PTR)
DECLARE SUB 	  glRectfv ALIAS "glRectfv" ( BYVAL v1 AS GLfloat PTR, BYVAL v2 AS GLfloat PTR)
DECLARE SUB 	  glRectiv ALIAS "glRectiv" ( BYVAL v1 AS GLint PTR, BYVAL v2 AS GLint PTR)
DECLARE SUB 	  glRectsv ALIAS "glRectsv" ( BYVAL v1 AS GLshort PTR, BYVAL v2 AS GLshort PTR)

''* Lighting *
DECLARE SUB   	  glShadeModel ALIAS "glShadeModel" ( BYVAL mode AS GLenum )
DECLARE SUB 	  glLightf ALIAS "glLightf" ( BYVAL light AS GLenum, BYVAL pname AS GLenum, BYVAL param AS GLfloat )
DECLARE SUB 	  glLighti ALIAS "glLighti" ( BYVAL light AS GLenum, BYVAL pname AS GLenum, BYVAL param AS GLint )
DECLARE SUB 	  glLightfv ALIAS "glLightfv" ( BYVAL light AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glLightiv ALIAS "glLightiv" ( BYVAL light AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLint PTR )
DECLARE SUB 	  glGetLightfv ALIAS "glGetLightfv" ( BYVAL light AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glGetLightiv ALIAS "glGetLightiv" ( BYVAL light AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLint PTR )
DECLARE SUB 	  glLightModelf ALIAS "glLightModelf" ( BYVAL pname AS GLenum, BYVAL param AS GLfloat )
DECLARE SUB 	  glLightModeli ALIAS "glLightModeli" ( BYVAL pname AS GLenum, BYVAL param AS GLint )
DECLARE SUB 	  glLightModelfv ALIAS "glLightModelfv" ( BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glLightModeliv ALIAS "glLightModeliv" ( BYVAL pname AS GLenum, BYVAL params AS GLint PTR )
DECLARE SUB 	  glMaterialf ALIAS "glMaterialf" ( BYVAL face AS GLenum, BYVAL pname AS GLenum, BYVAL param AS GLfloat )
DECLARE SUB 	  glMateriali ALIAS "glMateriali" ( BYVAL face AS GLenum, BYVAL pname AS GLenum, BYVAL param AS GLint )
DECLARE SUB 	  glMaterialfv ALIAS "glMaterialfv" ( BYVAL face AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glMaterialiv ALIAS "glMaterialiv" ( BYVAL face AS GLenum, BYVAL pname AS GLenum , BYVAL params AS GLint PTR )
DECLARE SUB 	  glGetMaterialfv ALIAS "glGetMaterialfv" ( BYVAL face AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glGetMaterialiv ALIAS "glGetMaterialiv" ( BYVAL face AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLint PTR )
DECLARE SUB 	  glColorMaterial ALIAS "glColorMaterial" ( BYVAL face AS GLenum, BYVAL mode AS GLenum )

''* Raster functions *
DECLARE SUB 	  glPixelZoom ALIAS "glPixelZoom" ( BYVAL xfactor AS GLfloat, BYVAL yfactor AS GLfloat )
DECLARE SUB 	  glPixelStoref ALIAS "glPixelStoref" ( BYVAL pname AS GLenum, BYVAL param AS GLfloat )
DECLARE SUB 	  glPixelStorei ALIAS "glPixelStorei" ( BYVAL pname AS GLenum, BYVAL param AS GLint )
DECLARE SUB 	  glPixelTransferf ALIAS "glPixelTransferf" ( BYVAL pname AS GLenum, BYVAL param AS GLfloat )
DECLARE SUB 	  glPixelTransferi ALIAS "glPixelTransferi" ( BYVAL pname AS GLenum, BYVAL param AS GLint )
DECLARE SUB 	  glPixelMapfv ALIAS "glPixelMapfv" ( BYVAL map AS GLenum, BYVAL mapsize AS GLint, BYVAL values AS GLfloat PTR )
DECLARE SUB 	  glPixelMapuiv ALIAS "glPixelMapuiv" ( BYVAL map AS GLenum, BYVAL mapsize AS GLint, BYVAL values AS GLuint PTR )
DECLARE SUB 	  glPixelMapusv ALIAS "glPixelMapusv" ( BYVAL map AS GLenum, BYVAL mapsize AS GLint, BYVAL values AS GLushort PTR )
DECLARE SUB 	  glGetPixelMapfv ALIAS "glGetPixelMapfv" ( BYVAL map AS GLenum, BYVAL values AS GLfloat PTR )
DECLARE SUB 	  glGetPixelMapuiv ALIAS "glGetPixelMapuiv" ( BYVAL map AS GLenum, BYVAL values AS GLuint PTR )
DECLARE SUB 	  glGetPixelMapusv ALIAS "glGetPixelMapusv" ( BYVAL map AS GLenum, BYVAL values AS GLushort PTR )
DECLARE SUB 	  glBitmap ALIAS "glBitmap" ( BYVAL width AS GLsizei, BYVAL height AS GLsizei, BYVAL xorig AS GLfloat, BYVAL yorig AS GLfloat, BYVAL xmove AS GLfloat, BYVAL ymove AS GLfloat, BYVAL bitmap AS GLubyte PTR )
DECLARE SUB 	  glReadPixels ALIAS "glReadPixels" ( BYVAL x AS GLint, BYVAL y AS GLint, BYVAL width AS GLsizei, BYVAL height AS GLsizei, BYVAL format AS GLenum, BYVAL type AS GLenum, BYVAL pixels AS GLvoid PTR )
DECLARE SUB 	  glDrawPixels ALIAS "glDrawPixels" ( BYVAL width AS GLsizei, BYVAL height AS GLsizei, BYVAL format AS GLenum, BYVAL type AS GLenum, BYVAL pixels AS GLvoid PTR )
DECLARE SUB 	  glCopyPixels ALIAS "glCopyPixels" ( BYVAL x AS GLint, BYVAL y AS GLint, BYVAL width AS GLsizei, BYVAL height AS GLsizei, BYVAL type AS GLenum )

''* Stenciling *
DECLARE SUB    	  glStencilFunc ALIAS "glStencilFunc" ( BYVAL func AS GLenum, BYVAL ref AS GLint, BYVAL mask AS GLuint )
DECLARE SUB 	  glStencilMask ALIAS "glStencilMask" ( BYVAL mask AS GLuint )
DECLARE SUB 	  glStencilOp ALIAS "glStencilOp" ( BYVAL fail AS GLenum, BYVAL zfail AS GLenum, BYVAL zpass AS GLenum )
DECLARE SUB 	  glClearStencil ALIAS "glClearStencil" ( BYVAL s AS GLint )

''* Texture mapping *
DECLARE SUB 	  glTexGend ALIAS "glTexGend" ( BYVAL coord AS GLenum, BYVAL pname AS GLenum, BYVAL param AS GLdouble)
DECLARE SUB 	  glTexGenf ALIAS "glTexGenf" ( BYVAL coord AS GLenum, BYVAL pname AS GLenum, BYVAL param AS GLfloat )
DECLARE SUB 	  glTexGeni ALIAS "glTexGeni" ( BYVAL coord AS GLenum, BYVAL pname AS GLenum, BYVAL param AS GLint )
DECLARE SUB 	  glTexGendv ALIAS "glTexGendv" ( BYVAL coord AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLdouble PTR )
DECLARE SUB 	  glTexGenfv ALIAS "glTexGenfv" ( BYVAL coord AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glTexGeniv ALIAS "glTexGeniv" ( BYVAL coord AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLint PTR )
DECLARE SUB 	  glGetTexGendv ALIAS "glGetTexGendv" ( BYVAL coord AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLdouble PTR )
DECLARE SUB 	  glGetTexGenfv ALIAS "glGetTexGenfv" ( BYVAL coord AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glGetTexGeniv ALIAS "glGetTexGeniv" ( BYVAL coord AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLint PTR )
DECLARE SUB 	  glTexEnvf ALIAS "glTexEnvf" ( BYVAL target AS GLenum, BYVAL pname AS GLenum, BYVAL param AS GLfloat )
DECLARE SUB 	  glTexEnvi ALIAS "glTexEnvi" ( BYVAL target AS GLenum, BYVAL pname AS GLenum, BYVAL param AS GLint )
DECLARE SUB 	  glTexEnvfv ALIAS "glTexEnvfv" ( BYVAL target AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glTexEnviv ALIAS "glTexEnviv" ( BYVAL target AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLint PTR )
DECLARE SUB 	  glGetTexEnvfv ALIAS "glGetTexEnvfv" ( BYVAL target AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glGetTexEnviv ALIAS "glGetTexEnviv" ( BYVAL target AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLint PTR )
DECLARE SUB 	  glTexParameterf ALIAS "glTexParameterf" ( BYVAL target AS GLenum, BYVAL pname AS GLenum, BYVAL param AS GLfloat )
DECLARE SUB 	  glTexParameteri ALIAS "glTexParameteri" ( BYVAL target AS GLenum, BYVAL pname AS GLenum, BYVAL param AS GLint )
DECLARE SUB 	  glTexParameterfv ALIAS "glTexParameterfv" ( BYVAL target AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glTexParameteriv ALIAS "glTexParameteriv" ( BYVAL target AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLint PTR )
DECLARE SUB 	  glGetTexParameterfv ALIAS "glGetTexParameterfv" ( BYVAL target AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glGetTexParameteriv ALIAS "glGetTexParameteriv" ( BYVAL target AS GLenum, BYVAL pname AS GLenum, BYVAL params AS GLint PTR )
DECLARE SUB 	  glGetTexLevelParameterfv ALIAS "glGetTexLevelParameterfv" ( BYVAL target AS GLenum, BYVAL level AS GLint, BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glGetTexLevelParameteriv ALIAS "glGetTexLevelParameteriv" ( BYVAL target AS GLenum, BYVAL level AS GLint, BYVAL pname AS GLenum, BYVAL params AS GLint PTR )
DECLARE SUB 	  glTexImage1D ALIAS "glTexImage1D" ( BYVAL target AS GLenum, BYVAL level AS GLint, BYVAL internalFormat AS GLint, BYVAL width AS GLsizei, BYVAL border AS GLint, BYVAL format AS GLenum, BYVAL type AS GLenum, BYVAL pixels AS GLvoid PTR )
DECLARE SUB 	  glTexImage2D ALIAS "glTexImage2D" ( BYVAL target AS GLenum, BYVAL level AS GLint, BYVAL internalFormat AS GLint, BYVAL width AS GLsizei, BYVAL height AS GLsizei, BYVAL border AS GLint, BYVAL format AS GLenum, BYVAL type AS GLenum, BYVAL pixels AS GLvoid PTR )
DECLARE SUB 	  glGetTexImage ALIAS "glGetTexImage" ( BYVAL target AS GLenum, BYVAL level AS GLint, BYVAL format AS GLenum, BYVAL type AS GLenum, BYVAL pixels AS GLvoid PTR )

''* Evaluators *
DECLARE SUB    	  glMap1d ALIAS "glMap1d" ( BYVAL target AS GLenum, BYVAL u1 AS GLdouble, BYVAL u2 AS GLdouble, BYVAL stride AS GLint, BYVAL order AS GLint, BYVAL points AS GLdouble PTR )
DECLARE SUB 	  glMap1f ALIAS "glMap1f" ( BYVAL target AS GLenum, BYVAL u1 AS GLfloat, BYVAL u2 AS GLfloat, BYVAL stride AS GLint, BYVAL order AS GLint, BYVAL points AS GLfloat PTR )
DECLARE SUB 	  glMap2d ALIAS "glMap2d" ( BYVAL target AS GLenum, BYVAL u1 AS GLdouble, BYVAL u2 AS GLdouble, BYVAL ustride AS GLint, BYVAL uorder AS GLint, BYVAL v1 AS GLdouble, BYVAL v2 AS GLdouble, BYVAL vstride AS GLint, BYVAL vorder AS GLint, BYVAL points AS GLdouble PTR )
DECLARE SUB 	  glMap2f ALIAS "glMap2f" ( BYVAL target AS GLenum, BYVAL u1 AS GLfloat, BYVAL u2 AS GLfloat, BYVAL ustride AS GLint, BYVAL uorder AS GLint, BYVAL v1 AS GLfloat, BYVAL v2 AS GLfloat, BYVAL vstride AS GLint, BYVAL vorder AS GLint, BYVAL points AS GLfloat PTR )
DECLARE SUB 	  glGetMapdv ALIAS "glGetMapdv" ( BYVAL target AS GLenum, BYVAL query AS GLenum, BYVAL v AS GLdouble PTR )
DECLARE SUB 	  glGetMapfv ALIAS "glGetMapfv" ( BYVAL target AS GLenum, BYVAL query AS GLenum, BYVAL v AS GLfloat PTR )
DECLARE SUB 	  glGetMapiv ALIAS "glGetMapiv" ( BYVAL target AS GLenum, BYVAL query AS GLenum, BYVAL v AS GLint PTR )
DECLARE SUB 	  glEvalCoord1d ALIAS "glEvalCoord1d" ( BYVAL u AS GLdouble )
DECLARE SUB 	  glEvalCoord1f ALIAS "glEvalCoord1f" ( BYVAL u AS GLfloat )
DECLARE SUB 	  glEvalCoord1dv ALIAS "glEvalCoord1dv" ( BYVAL u AS GLdouble PTR )
DECLARE SUB 	  glEvalCoord1fv ALIAS "glEvalCoord1fv" ( BYVAL u AS GLfloat PTR )
DECLARE SUB 	  glEvalCoord2d ALIAS "glEvalCoord2d" ( BYVAL u AS GLdouble, BYVAL v AS GLdouble )
DECLARE SUB 	  glEvalCoord2f ALIAS "glEvalCoord2f" ( BYVAL u AS GLfloat, BYVAL v AS GLfloat )
DECLARE SUB 	  glEvalCoord2dv ALIAS "glEvalCoord2dv" ( BYVAL u AS GLdouble PTR )
DECLARE SUB 	  glEvalCoord2fv ALIAS "glEvalCoord2fv" ( BYVAL u AS GLfloat PTR )
DECLARE SUB 	  glMapGrid1d ALIAS "glMapGrid1d" ( BYVAL un AS GLint, BYVAL u1 AS GLdouble, BYVAL u2 AS GLdouble )
DECLARE SUB 	  glMapGrid1f ALIAS "glMapGrid1f" ( BYVAL un AS GLint, BYVAL u1 AS GLfloat, BYVAL u2 AS GLfloat )
DECLARE SUB 	  glMapGrid2d ALIAS "glMapGrid2d" ( BYVAL un AS GLint, BYVAL u1 AS GLdouble, BYVAL u2 AS GLdouble, BYVAL vn AS GLint, BYVAL v1 AS GLdouble, BYVAL v2 AS GLdouble )
DECLARE SUB 	  glMapGrid2f ALIAS "glMapGrid2f" ( BYVAL un AS GLint, BYVAL u1 AS GLfloat, BYVAL u2 AS GLfloat, BYVAL vn AS GLint, BYVAL v1 AS GLfloat, BYVAL v2 AS GLfloat )
DECLARE SUB 	  glEvalPoint1 ALIAS "glEvalPoint1" ( BYVAL i AS GLint )
DECLARE SUB 	  glEvalPoint2 ALIAS "glEvalPoint2" ( BYVAL i AS GLint, BYVAL j AS GLint )
DECLARE SUB 	  glEvalMesh1 ALIAS "glEvalMesh1" ( BYVAL mode AS GLenum, BYVAL i1 AS GLint, BYVAL i2 AS GLint )
DECLARE SUB 	  glEvalMesh2 ALIAS "glEvalMesh2" ( BYVAL mode AS GLenum, BYVAL i1 AS GLint, BYVAL i2 AS GLint, BYVAL j1 AS GLint, BYVAL j2 AS GLint )

''* Fog *
DECLARE SUB 	  glFogf ALIAS "glFogf" ( BYVAL pname AS GLenum, BYVAL param AS GLfloat )
DECLARE SUB 	  glFogi ALIAS "glFogi" ( BYVAL pname AS GLenum, BYVAL param AS GLint )
DECLARE SUB 	  glFogfv ALIAS "glFogfv" ( BYVAL pname AS GLenum, BYVAL params AS GLfloat PTR )
DECLARE SUB 	  glFogiv ALIAS "glFogiv" ( BYVAL pname AS GLenum, BYVAL params AS GLint PTR )

''* Selection and Feedback *
DECLARE SUB   	  glFeedbackBuffer ALIAS "glFeedbackBuffer" ( BYVAL size AS GLsizei, BYVAL type AS GLenum, BYVAL buffer AS GLfloat PTR )
DECLARE SUB 	  glPassThrough ALIAS "glPassThrough" ( BYVAL token AS GLfloat )
DECLARE SUB 	  glSelectBuffer ALIAS "glSelectBuffer" ( BYVAL size AS GLsizei, BYVAL buffer AS GLuint PTR )
DECLARE SUB 	  glInitNames ALIAS "glInitNames" ()
DECLARE SUB 	  glLoadName ALIAS "glLoadName" ( BYVAL name AS GLuint )
DECLARE SUB 	  glPushName ALIAS "glPushName" ( BYVAL name AS GLuint )
DECLARE SUB 	  glPopName ALIAS "glPopName" ()


''********************************************************************
''* 1.1 functions *
''********************************************************************

''* texture objects *
DECLARE SUB 	  glGenTextures ALIAS "glGenTextures" ( BYVAL n AS GLsizei, BYVAL textures AS GLuint PTR )
DECLARE SUB 	  glDeleteTextures ALIAS "glDeleteTextures" ( BYVAL n AS GLsizei, BYVAL textures AS GLuint PTR )
DECLARE SUB 	  glBindTexture ALIAS "glBindTexture" ( BYVAL target AS GLenum, BYVAL texture AS GLuint )
DECLARE SUB 	  glPrioritizeTextures ALIAS "glPrioritizeTextures" ( BYVAL n AS GLsizei, BYVAL textures AS GLuint PTR , BYVAL priorities AS GLclampf PTR )
DECLARE FUNCTION  glAreTexturesResident ALIAS "glAreTexturesResident" ( BYVAL n AS GLsizei, BYVAL textures AS GLuint PTR , BYVAL residences AS GLboolean PTR ) AS GLboolean
DECLARE FUNCTION  glIsTexture ALIAS "glIsTexture" ( BYVAL texture AS GLuint ) AS GLboolean

''* texture mapping *
DECLARE SUB 	  glTexSubImage1D ALIAS "glTexSubImage1D" ( BYVAL target AS GLenum, BYVAL level AS GLint, BYVAL xoffset AS GLint, BYVAL width AS GLsizei, BYVAL format AS GLenum, BYVAL type AS GLenum, BYVAL pixels AS GLvoid PTR )
DECLARE SUB 	  glTexSubImage2D ALIAS "glTexSubImage2D" ( BYVAL target AS GLenum, BYVAL level AS GLint, BYVAL xoffset AS GLint, BYVAL yoffset AS GLint, BYVAL width AS GLsizei, BYVAL height AS GLsizei, BYVAL format AS GLenum, BYVAL type AS GLenum, BYVAL pixels AS GLvoid PTR )
DECLARE SUB 	  glCopyTexImage1D ALIAS "glCopyTexImage1D" ( BYVAL target AS GLenum, BYVAL level AS GLint, BYVAL internalformat AS GLenum, BYVAL x AS GLint, BYVAL y AS GLint, BYVAL width AS GLsizei, BYVAL border AS GLint )
DECLARE SUB 	  glCopyTexImage2D ALIAS "glCopyTexImage2D" ( BYVAL target AS GLenum, BYVAL level AS GLint, BYVAL internalformat AS GLenum, BYVAL x AS GLint, BYVAL y AS GLint, BYVAL width AS GLsizei, BYVAL height AS GLsizei, BYVAL border AS GLint )
DECLARE SUB 	  glCopyTexSubImage1D ALIAS "glCopyTexSubImage1D" ( BYVAL target AS GLenum, BYVAL level AS GLint, BYVAL xoffset AS GLint, BYVAL x AS GLint, BYVAL y AS GLint, BYVAL width AS GLsizei )
DECLARE SUB 	  glCopyTexSubImage2D ALIAS "glCopyTexSubImage2D" ( BYVAL target AS GLenum, BYVAL level AS GLint, BYVAL xoffset AS GLint, BYVAL yoffset AS GLint, BYVAL x AS GLint , BYVAL y AS GLint , BYVAL width AS GLsizei, BYVAL height AS GLsizei )

''/* vertex arrays *
DECLARE SUB       glVertexPointer ALIAS "glVertexPointer" ( BYVAL size AS GLint, BYVAL type AS GLenum, BYVAL stride AS GLsizei, BYVAL pointer AS GLvoid PTR )
DECLARE SUB 	  glNormalPointer ALIAS "glNormalPointer" ( BYVAL type AS GLenum, BYVAL stride AS GLsizei, BYVAL pointer AS GLvoid PTR )
DECLARE SUB 	  glColorPointer ALIAS "glColorPointer" ( BYVAL size AS GLint, BYVAL type AS GLenum, BYVAL stride AS GLsizei, BYVAL pointer AS GLvoid PTR )
DECLARE SUB 	  glIndexPointer ALIAS "glIndexPointer" ( BYVAL type AS GLenum, BYVAL stride AS GLsizei, BYVAL pointer AS GLvoid PTR )
DECLARE SUB 	  glTexCoordPointer ALIAS "glTexCoordPointer" ( BYVAL size AS GLint, BYVAL type AS GLenum, BYVAL stride AS GLsizei, BYVAL pointer AS GLvoid PTR )
DECLARE SUB 	  glEdgeFlagPointer ALIAS "glEdgeFlagPointer" ( BYVAL stride AS GLsizei, BYVAL pointer AS GLvoid PTR )
DECLARE SUB 	  glGetPointerv ALIAS "glGetPointerv" ( BYVAL pname AS GLenum, BYVAL params AS GLvoid PTR PTR ) 
DECLARE SUB 	  glArrayElement ALIAS "glArrayElement" ( BYVAL i AS GLint )
DECLARE SUB 	  glDrawArrays ALIAS "glDrawArrays" ( BYVAL mode AS GLenum, BYVAL first AS GLint, BYVAL count AS GLsizei )
DECLARE SUB 	  glDrawElements ALIAS "glDrawElements" ( BYVAL mode AS GLenum, BYVAL count AS GLsizei, BYVAL type AS GLenum, BYVAL indices AS GLvoid PTR )
DECLARE SUB 	  glInterleavedArrays ALIAS "glInterleavedArrays" ( BYVAL format AS GLenum, BYVAL stride AS GLsizei, BYVAL pointer AS GLvoid PTR )


#endif ''gl_bi
