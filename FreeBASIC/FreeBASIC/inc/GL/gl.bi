''
''
'' gl -- OpenGL include file (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gl_bi__
#define __gl_bi__

#ifdef __FB_WIN32__
# inclib "opengl32"
#elseif defined(__FB_LINUX__)
# inclib "GL"
#elseif defined(__FB_DOS__)
# inclib "gl"
#endif

#define GL_VERSION_1_1 1
#define GL_VERSION_1_2 1
#define GL_VERSION_1_3 1
#define GL_ARB_imaging 1

type GLenum as uinteger
type GLboolean as ubyte
type GLbitfield as uinteger
type GLvoid as any
type GLbyte as byte
type GLshort as short
type GLint as integer
type GLubyte as ubyte
type GLushort as ushort
type GLuint as uinteger
type GLsizei as integer
type GLfloat as single
type GLclampf as single
type GLdouble as double
type GLclampd as double

#define GL_FALSE &h0
#define GL_TRUE &h1
#define GL_BYTE &h1400
#define GL_UNSIGNED_BYTE &h1401
#define GL_SHORT &h1402
#define GL_UNSIGNED_SHORT &h1403
#define GL_INT &h1404
#define GL_UNSIGNED_INT &h1405
#define GL_FLOAT &h1406
#define GL_DOUBLE &h140A
#define GL_2_BYTES &h1407
#define GL_3_BYTES &h1408
#define GL_4_BYTES &h1409
#define GL_POINTS &h0000
#define GL_LINES &h0001
#define GL_LINE_LOOP &h0002
#define GL_LINE_STRIP &h0003
#define GL_TRIANGLES &h0004
#define GL_TRIANGLE_STRIP &h0005
#define GL_TRIANGLE_FAN &h0006
#define GL_QUADS &h0007
#define GL_QUAD_STRIP &h0008
#define GL_POLYGON &h0009
#define GL_VERTEX_ARRAY &h8074
#define GL_NORMAL_ARRAY &h8075
#define GL_COLOR_ARRAY &h8076
#define GL_INDEX_ARRAY &h8077
#define GL_TEXTURE_COORD_ARRAY &h8078
#define GL_EDGE_FLAG_ARRAY &h8079
#define GL_VERTEX_ARRAY_SIZE &h807A
#define GL_VERTEX_ARRAY_TYPE &h807B
#define GL_VERTEX_ARRAY_STRIDE &h807C
#define GL_NORMAL_ARRAY_TYPE &h807E
#define GL_NORMAL_ARRAY_STRIDE &h807F
#define GL_COLOR_ARRAY_SIZE &h8081
#define GL_COLOR_ARRAY_TYPE &h8082
#define GL_COLOR_ARRAY_STRIDE &h8083
#define GL_INDEX_ARRAY_TYPE &h8085
#define GL_INDEX_ARRAY_STRIDE &h8086
#define GL_TEXTURE_COORD_ARRAY_SIZE &h8088
#define GL_TEXTURE_COORD_ARRAY_TYPE &h8089
#define GL_TEXTURE_COORD_ARRAY_STRIDE &h808A
#define GL_EDGE_FLAG_ARRAY_STRIDE &h808C
#define GL_VERTEX_ARRAY_POINTER &h808E
#define GL_NORMAL_ARRAY_POINTER &h808F
#define GL_COLOR_ARRAY_POINTER &h8090
#define GL_INDEX_ARRAY_POINTER &h8091
#define GL_TEXTURE_COORD_ARRAY_POINTER &h8092
#define GL_EDGE_FLAG_ARRAY_POINTER &h8093
#define GL_V2F &h2A20
#define GL_V3F &h2A21
#define GL_C4UB_V2F &h2A22
#define GL_C4UB_V3F &h2A23
#define GL_C3F_V3F &h2A24
#define GL_N3F_V3F &h2A25
#define GL_C4F_N3F_V3F &h2A26
#define GL_T2F_V3F &h2A27
#define GL_T4F_V4F &h2A28
#define GL_T2F_C4UB_V3F &h2A29
#define GL_T2F_C3F_V3F &h2A2A
#define GL_T2F_N3F_V3F &h2A2B
#define GL_T2F_C4F_N3F_V3F &h2A2C
#define GL_T4F_C4F_N3F_V4F &h2A2D
#define GL_MATRIX_MODE &h0BA0
#define GL_MODELVIEW &h1700
#define GL_PROJECTION &h1701
#define GL_TEXTURE &h1702
#define GL_POINT_SMOOTH &h0B10
#define GL_POINT_SIZE &h0B11
#define GL_POINT_SIZE_GRANULARITY &h0B13
#define GL_POINT_SIZE_RANGE &h0B12
#define GL_LINE_SMOOTH &h0B20
#define GL_LINE_STIPPLE &h0B24
#define GL_LINE_STIPPLE_PATTERN &h0B25
#define GL_LINE_STIPPLE_REPEAT &h0B26
#define GL_LINE_WIDTH &h0B21
#define GL_LINE_WIDTH_GRANULARITY &h0B23
#define GL_LINE_WIDTH_RANGE &h0B22
#define GL_POINT &h1B00
#define GL_LINE &h1B01
#define GL_FILL &h1B02
#define GL_CW &h0900
#define GL_CCW &h0901
#define GL_FRONT &h0404
#define GL_BACK &h0405
#define GL_POLYGON_MODE &h0B40
#define GL_POLYGON_SMOOTH &h0B41
#define GL_POLYGON_STIPPLE &h0B42
#define GL_EDGE_FLAG &h0B43
#define GL_CULL_FACE &h0B44
#define GL_CULL_FACE_MODE &h0B45
#define GL_FRONT_FACE &h0B46
#define GL_POLYGON_OFFSET_FACTOR &h8038
#define GL_POLYGON_OFFSET_UNITS &h2A00
#define GL_POLYGON_OFFSET_POINT &h2A01
#define GL_POLYGON_OFFSET_LINE &h2A02
#define GL_POLYGON_OFFSET_FILL &h8037
#define GL_COMPILE &h1300
#define GL_COMPILE_AND_EXECUTE &h1301
#define GL_LIST_BASE &h0B32
#define GL_LIST_INDEX &h0B33
#define GL_LIST_MODE &h0B30
#define GL_NEVER &h0200
#define GL_LESS &h0201
#define GL_EQUAL &h0202
#define GL_LEQUAL &h0203
#define GL_GREATER &h0204
#define GL_NOTEQUAL &h0205
#define GL_GEQUAL &h0206
#define GL_ALWAYS &h0207
#define GL_DEPTH_TEST &h0B71
#define GL_DEPTH_BITS &h0D56
#define GL_DEPTH_CLEAR_VALUE &h0B73
#define GL_DEPTH_FUNC &h0B74
#define GL_DEPTH_RANGE &h0B70
#define GL_DEPTH_WRITEMASK &h0B72
#define GL_DEPTH_COMPONENT &h1902
#define GL_LIGHTING &h0B50
#define GL_LIGHT0 &h4000
#define GL_LIGHT1 &h4001
#define GL_LIGHT2 &h4002
#define GL_LIGHT3 &h4003
#define GL_LIGHT4 &h4004
#define GL_LIGHT5 &h4005
#define GL_LIGHT6 &h4006
#define GL_LIGHT7 &h4007
#define GL_SPOT_EXPONENT &h1205
#define GL_SPOT_CUTOFF &h1206
#define GL_CONSTANT_ATTENUATION &h1207
#define GL_LINEAR_ATTENUATION &h1208
#define GL_QUADRATIC_ATTENUATION &h1209
#define GL_AMBIENT &h1200
#define GL_DIFFUSE &h1201
#define GL_SPECULAR &h1202
#define GL_SHININESS &h1601
#define GL_EMISSION &h1600
#define GL_POSITION &h1203
#define GL_SPOT_DIRECTION &h1204
#define GL_AMBIENT_AND_DIFFUSE &h1602
#define GL_COLOR_INDEXES &h1603
#define GL_LIGHT_MODEL_TWO_SIDE &h0B52
#define GL_LIGHT_MODEL_LOCAL_VIEWER &h0B51
#define GL_LIGHT_MODEL_AMBIENT &h0B53
#define GL_FRONT_AND_BACK &h0408
#define GL_SHADE_MODEL &h0B54
#define GL_FLAT &h1D00
#define GL_SMOOTH &h1D01
#define GL_COLOR_MATERIAL &h0B57
#define GL_COLOR_MATERIAL_FACE &h0B55
#define GL_COLOR_MATERIAL_PARAMETER &h0B56
#define GL_NORMALIZE &h0BA1
#define GL_CLIP_PLANE0 &h3000
#define GL_CLIP_PLANE1 &h3001
#define GL_CLIP_PLANE2 &h3002
#define GL_CLIP_PLANE3 &h3003
#define GL_CLIP_PLANE4 &h3004
#define GL_CLIP_PLANE5 &h3005
#define GL_ACCUM_RED_BITS &h0D58
#define GL_ACCUM_GREEN_BITS &h0D59
#define GL_ACCUM_BLUE_BITS &h0D5A
#define GL_ACCUM_ALPHA_BITS &h0D5B
#define GL_ACCUM_CLEAR_VALUE &h0B80
#define GL_ACCUM &h0100
#define GL_ADD &h0104
#define GL_LOAD &h0101
#define GL_MULT &h0103
#define GL_RETURN &h0102
#define GL_ALPHA_TEST &h0BC0
#define GL_ALPHA_TEST_REF &h0BC2
#define GL_ALPHA_TEST_FUNC &h0BC1
#define GL_BLEND &h0BE2
#define GL_BLEND_SRC &h0BE1
#define GL_BLEND_DST &h0BE0
#define GL_ZERO &h0
#define GL_ONE &h1
#define GL_SRC_COLOR &h0300
#define GL_ONE_MINUS_SRC_COLOR &h0301
#define GL_SRC_ALPHA &h0302
#define GL_ONE_MINUS_SRC_ALPHA &h0303
#define GL_DST_ALPHA &h0304
#define GL_ONE_MINUS_DST_ALPHA &h0305
#define GL_DST_COLOR &h0306
#define GL_ONE_MINUS_DST_COLOR &h0307
#define GL_SRC_ALPHA_SATURATE &h0308
#define GL_CONSTANT_COLOR &h8001
#define GL_ONE_MINUS_CONSTANT_COLOR &h8002
#define GL_CONSTANT_ALPHA &h8003
#define GL_ONE_MINUS_CONSTANT_ALPHA &h8004
#define GL_FEEDBACK &h1C01
#define GL_RENDER &h1C00
#define GL_SELECT &h1C02
#define GL_2D &h0600
#define GL_3D &h0601
#define GL_3D_COLOR &h0602
#define GL_3D_COLOR_TEXTURE &h0603
#define GL_4D_COLOR_TEXTURE &h0604
#define GL_POINT_TOKEN &h0701
#define GL_LINE_TOKEN &h0702
#define GL_LINE_RESET_TOKEN &h0707
#define GL_POLYGON_TOKEN &h0703
#define GL_BITMAP_TOKEN &h0704
#define GL_DRAW_PIXEL_TOKEN &h0705
#define GL_COPY_PIXEL_TOKEN &h0706
#define GL_PASS_THROUGH_TOKEN &h0700
#define GL_FEEDBACK_BUFFER_POINTER &h0DF0
#define GL_FEEDBACK_BUFFER_SIZE &h0DF1
#define GL_FEEDBACK_BUFFER_TYPE &h0DF2
#define GL_SELECTION_BUFFER_POINTER &h0DF3
#define GL_SELECTION_BUFFER_SIZE &h0DF4
#define GL_FOG &h0B60
#define GL_FOG_MODE &h0B65
#define GL_FOG_DENSITY &h0B62
#define GL_FOG_COLOR &h0B66
#define GL_FOG_INDEX &h0B61
#define GL_FOG_START &h0B63
#define GL_FOG_END &h0B64
#define GL_LINEAR &h2601
#define GL_EXP &h0800
#define GL_EXP2 &h0801
#define GL_LOGIC_OP &h0BF1
#define GL_INDEX_LOGIC_OP &h0BF1
#define GL_COLOR_LOGIC_OP &h0BF2
#define GL_LOGIC_OP_MODE &h0BF0
#define GL_CLEAR &h1500
#define GL_SET &h150F
#define GL_COPY &h1503
#define GL_COPY_INVERTED &h150C
#define GL_NOOP &h1505
#define GL_INVERT &h150A
#define GL_AND &h1501
#define GL_NAND &h150E
#define GL_OR &h1507
#define GL_NOR &h1508
#define GL_XOR &h1506
#define GL_EQUIV &h1509
#define GL_AND_REVERSE &h1502
#define GL_AND_INVERTED &h1504
#define GL_OR_REVERSE &h150B
#define GL_OR_INVERTED &h150D
#define GL_STENCIL_TEST &h0B90
#define GL_STENCIL_WRITEMASK &h0B98
#define GL_STENCIL_BITS &h0D57
#define GL_STENCIL_FUNC &h0B92
#define GL_STENCIL_VALUE_MASK &h0B93
#define GL_STENCIL_REF &h0B97
#define GL_STENCIL_FAIL &h0B94
#define GL_STENCIL_PASS_DEPTH_PASS &h0B96
#define GL_STENCIL_PASS_DEPTH_FAIL &h0B95
#define GL_STENCIL_CLEAR_VALUE &h0B91
#define GL_STENCIL_INDEX &h1901
#define GL_KEEP &h1E00
#define GL_REPLACE &h1E01
#define GL_INCR &h1E02
#define GL_DECR &h1E03
#define GL_NONE &h0
#define GL_LEFT &h0406
#define GL_RIGHT &h0407
#define GL_FRONT_LEFT &h0400
#define GL_FRONT_RIGHT &h0401
#define GL_BACK_LEFT &h0402
#define GL_BACK_RIGHT &h0403
#define GL_AUX0 &h0409
#define GL_AUX1 &h040A
#define GL_AUX2 &h040B
#define GL_AUX3 &h040C
#define GL_COLOR_INDEX &h1900
#define GL_RED &h1903
#define GL_GREEN &h1904
#define GL_BLUE &h1905
#define GL_ALPHA &h1906
#define GL_LUMINANCE &h1909
#define GL_LUMINANCE_ALPHA &h190A
#define GL_ALPHA_BITS &h0D55
#define GL_RED_BITS &h0D52
#define GL_GREEN_BITS &h0D53
#define GL_BLUE_BITS &h0D54
#define GL_INDEX_BITS &h0D51
#define GL_SUBPIXEL_BITS &h0D50
#define GL_AUX_BUFFERS &h0C00
#define GL_READ_BUFFER &h0C02
#define GL_DRAW_BUFFER &h0C01
#define GL_DOUBLEBUFFER &h0C32
#define GL_STEREO &h0C33
#define GL_BITMAP &h1A00
#define GL_COLOR &h1800
#define GL_DEPTH &h1801
#define GL_STENCIL &h1802
#define GL_DITHER &h0BD0
#define GL_RGB &h1907
#define GL_RGBA &h1908
#define GL_MAX_LIST_NESTING &h0B31
#define GL_MAX_ATTRIB_STACK_DEPTH &h0D35
#define GL_MAX_MODELVIEW_STACK_DEPTH &h0D36
#define GL_MAX_NAME_STACK_DEPTH &h0D37
#define GL_MAX_PROJECTION_STACK_DEPTH &h0D38
#define GL_MAX_TEXTURE_STACK_DEPTH &h0D39
#define GL_MAX_EVAL_ORDER &h0D30
#define GL_MAX_LIGHTS &h0D31
#define GL_MAX_CLIP_PLANES &h0D32
#define GL_MAX_TEXTURE_SIZE &h0D33
#define GL_MAX_PIXEL_MAP_TABLE &h0D34
#define GL_MAX_VIEWPORT_DIMS &h0D3A
#define GL_MAX_CLIENT_ATTRIB_STACK_DEPTH &h0D3B
#define GL_ATTRIB_STACK_DEPTH &h0BB0
#define GL_CLIENT_ATTRIB_STACK_DEPTH &h0BB1
#define GL_COLOR_CLEAR_VALUE &h0C22
#define GL_COLOR_WRITEMASK &h0C23
#define GL_CURRENT_INDEX &h0B01
#define GL_CURRENT_COLOR &h0B00
#define GL_CURRENT_NORMAL &h0B02
#define GL_CURRENT_RASTER_COLOR &h0B04
#define GL_CURRENT_RASTER_DISTANCE &h0B09
#define GL_CURRENT_RASTER_INDEX &h0B05
#define GL_CURRENT_RASTER_POSITION &h0B07
#define GL_CURRENT_RASTER_TEXTURE_COORDS &h0B06
#define GL_CURRENT_RASTER_POSITION_VALID &h0B08
#define GL_CURRENT_TEXTURE_COORDS &h0B03
#define GL_INDEX_CLEAR_VALUE &h0C20
#define GL_INDEX_MODE &h0C30
#define GL_INDEX_WRITEMASK &h0C21
#define GL_MODELVIEW_MATRIX &h0BA6
#define GL_MODELVIEW_STACK_DEPTH &h0BA3
#define GL_NAME_STACK_DEPTH &h0D70
#define GL_PROJECTION_MATRIX &h0BA7
#define GL_PROJECTION_STACK_DEPTH &h0BA4
#define GL_RENDER_MODE &h0C40
#define GL_RGBA_MODE &h0C31
#define GL_TEXTURE_MATRIX &h0BA8
#define GL_TEXTURE_STACK_DEPTH &h0BA5
#define GL_VIEWPORT &h0BA2
#define GL_AUTO_NORMAL &h0D80
#define GL_MAP1_COLOR_4 &h0D90
#define GL_MAP1_GRID_DOMAIN &h0DD0
#define GL_MAP1_GRID_SEGMENTS &h0DD1
#define GL_MAP1_INDEX &h0D91
#define GL_MAP1_NORMAL &h0D92
#define GL_MAP1_TEXTURE_COORD_1 &h0D93
#define GL_MAP1_TEXTURE_COORD_2 &h0D94
#define GL_MAP1_TEXTURE_COORD_3 &h0D95
#define GL_MAP1_TEXTURE_COORD_4 &h0D96
#define GL_MAP1_VERTEX_3 &h0D97
#define GL_MAP1_VERTEX_4 &h0D98
#define GL_MAP2_COLOR_4 &h0DB0
#define GL_MAP2_GRID_DOMAIN &h0DD2
#define GL_MAP2_GRID_SEGMENTS &h0DD3
#define GL_MAP2_INDEX &h0DB1
#define GL_MAP2_NORMAL &h0DB2
#define GL_MAP2_TEXTURE_COORD_1 &h0DB3
#define GL_MAP2_TEXTURE_COORD_2 &h0DB4
#define GL_MAP2_TEXTURE_COORD_3 &h0DB5
#define GL_MAP2_TEXTURE_COORD_4 &h0DB6
#define GL_MAP2_VERTEX_3 &h0DB7
#define GL_MAP2_VERTEX_4 &h0DB8
#define GL_COEFF &h0A00
#define GL_DOMAIN &h0A02
#define GL_ORDER &h0A01
#define GL_FOG_HINT &h0C54
#define GL_LINE_SMOOTH_HINT &h0C52
#define GL_PERSPECTIVE_CORRECTION_HINT &h0C50
#define GL_POINT_SMOOTH_HINT &h0C51
#define GL_POLYGON_SMOOTH_HINT &h0C53
#define GL_DONT_CARE &h1100
#define GL_FASTEST &h1101
#define GL_NICEST &h1102
#define GL_SCISSOR_TEST &h0C11
#define GL_SCISSOR_BOX &h0C10
#define GL_MAP_COLOR &h0D10
#define GL_MAP_STENCIL &h0D11
#define GL_INDEX_SHIFT &h0D12
#define GL_INDEX_OFFSET &h0D13
#define GL_RED_SCALE &h0D14
#define GL_RED_BIAS &h0D15
#define GL_GREEN_SCALE &h0D18
#define GL_GREEN_BIAS &h0D19
#define GL_BLUE_SCALE &h0D1A
#define GL_BLUE_BIAS &h0D1B
#define GL_ALPHA_SCALE &h0D1C
#define GL_ALPHA_BIAS &h0D1D
#define GL_DEPTH_SCALE &h0D1E
#define GL_DEPTH_BIAS &h0D1F
#define GL_PIXEL_MAP_S_TO_S_SIZE &h0CB1
#define GL_PIXEL_MAP_I_TO_I_SIZE &h0CB0
#define GL_PIXEL_MAP_I_TO_R_SIZE &h0CB2
#define GL_PIXEL_MAP_I_TO_G_SIZE &h0CB3
#define GL_PIXEL_MAP_I_TO_B_SIZE &h0CB4
#define GL_PIXEL_MAP_I_TO_A_SIZE &h0CB5
#define GL_PIXEL_MAP_R_TO_R_SIZE &h0CB6
#define GL_PIXEL_MAP_G_TO_G_SIZE &h0CB7
#define GL_PIXEL_MAP_B_TO_B_SIZE &h0CB8
#define GL_PIXEL_MAP_A_TO_A_SIZE &h0CB9
#define GL_PIXEL_MAP_S_TO_S &h0C71
#define GL_PIXEL_MAP_I_TO_I &h0C70
#define GL_PIXEL_MAP_I_TO_R &h0C72
#define GL_PIXEL_MAP_I_TO_G &h0C73
#define GL_PIXEL_MAP_I_TO_B &h0C74
#define GL_PIXEL_MAP_I_TO_A &h0C75
#define GL_PIXEL_MAP_R_TO_R &h0C76
#define GL_PIXEL_MAP_G_TO_G &h0C77
#define GL_PIXEL_MAP_B_TO_B &h0C78
#define GL_PIXEL_MAP_A_TO_A &h0C79
#define GL_PACK_ALIGNMENT &h0D05
#define GL_PACK_LSB_FIRST &h0D01
#define GL_PACK_ROW_LENGTH &h0D02
#define GL_PACK_SKIP_PIXELS &h0D04
#define GL_PACK_SKIP_ROWS &h0D03
#define GL_PACK_SWAP_BYTES &h0D00
#define GL_UNPACK_ALIGNMENT &h0CF5
#define GL_UNPACK_LSB_FIRST &h0CF1
#define GL_UNPACK_ROW_LENGTH &h0CF2
#define GL_UNPACK_SKIP_PIXELS &h0CF4
#define GL_UNPACK_SKIP_ROWS &h0CF3
#define GL_UNPACK_SWAP_BYTES &h0CF0
#define GL_ZOOM_X &h0D16
#define GL_ZOOM_Y &h0D17
#define GL_TEXTURE_ENV &h2300
#define GL_TEXTURE_ENV_MODE &h2200
#define GL_TEXTURE_1D &h0DE0
#define GL_TEXTURE_2D &h0DE1
#define GL_TEXTURE_WRAP_S &h2802
#define GL_TEXTURE_WRAP_T &h2803
#define GL_TEXTURE_MAG_FILTER &h2800
#define GL_TEXTURE_MIN_FILTER &h2801
#define GL_TEXTURE_ENV_COLOR &h2201
#define GL_TEXTURE_GEN_S &h0C60
#define GL_TEXTURE_GEN_T &h0C61
#define GL_TEXTURE_GEN_MODE &h2500
#define GL_TEXTURE_BORDER_COLOR &h1004
#define GL_TEXTURE_WIDTH &h1000
#define GL_TEXTURE_HEIGHT &h1001
#define GL_TEXTURE_BORDER &h1005
#define GL_TEXTURE_COMPONENTS &h1003
#define GL_TEXTURE_RED_SIZE &h805C
#define GL_TEXTURE_GREEN_SIZE &h805D
#define GL_TEXTURE_BLUE_SIZE &h805E
#define GL_TEXTURE_ALPHA_SIZE &h805F
#define GL_TEXTURE_LUMINANCE_SIZE &h8060
#define GL_TEXTURE_INTENSITY_SIZE &h8061
#define GL_NEAREST_MIPMAP_NEAREST &h2700
#define GL_NEAREST_MIPMAP_LINEAR &h2702
#define GL_LINEAR_MIPMAP_NEAREST &h2701
#define GL_LINEAR_MIPMAP_LINEAR &h2703
#define GL_OBJECT_LINEAR &h2401
#define GL_OBJECT_PLANE &h2501
#define GL_EYE_LINEAR &h2400
#define GL_EYE_PLANE &h2502
#define GL_SPHERE_MAP &h2402
#define GL_DECAL &h2101
#define GL_MODULATE &h2100
#define GL_NEAREST &h2600
#define GL_REPEAT &h2901
#define GL_CLAMP &h2900
#define GL_S &h2000
#define GL_T &h2001
#define GL_R &h2002
#define GL_Q &h2003
#define GL_TEXTURE_GEN_R &h0C62
#define GL_TEXTURE_GEN_Q &h0C63
#define GL_VENDOR &h1F00
#define GL_RENDERER &h1F01
#define GL_VERSION &h1F02
#define GL_EXTENSIONS &h1F03
#define GL_NO_ERROR &h0
#define GL_INVALID_VALUE &h0501
#define GL_INVALID_ENUM &h0500
#define GL_INVALID_OPERATION &h0502
#define GL_STACK_OVERFLOW &h0503
#define GL_STACK_UNDERFLOW &h0504
#define GL_OUT_OF_MEMORY &h0505
#define GL_CURRENT_BIT &h00000001
#define GL_POINT_BIT &h00000002
#define GL_LINE_BIT &h00000004
#define GL_POLYGON_BIT &h00000008
#define GL_POLYGON_STIPPLE_BIT &h00000010
#define GL_PIXEL_MODE_BIT &h00000020
#define GL_LIGHTING_BIT &h00000040
#define GL_FOG_BIT &h00000080
#define GL_DEPTH_BUFFER_BIT &h00000100
#define GL_ACCUM_BUFFER_BIT &h00000200
#define GL_STENCIL_BUFFER_BIT &h00000400
#define GL_VIEWPORT_BIT &h00000800
#define GL_TRANSFORM_BIT &h00001000
#define GL_ENABLE_BIT &h00002000
#define GL_COLOR_BUFFER_BIT &h00004000
#define GL_HINT_BIT &h00008000
#define GL_EVAL_BIT &h00010000
#define GL_LIST_BIT &h00020000
#define GL_TEXTURE_BIT &h00040000
#define GL_SCISSOR_BIT &h00080000
#define GL_ALL_ATTRIB_BITS &h000FFFFF
#define GL_PROXY_TEXTURE_1D &h8063
#define GL_PROXY_TEXTURE_2D &h8064
#define GL_TEXTURE_PRIORITY &h8066
#define GL_TEXTURE_RESIDENT &h8067
#define GL_TEXTURE_BINDING_1D &h8068
#define GL_TEXTURE_BINDING_2D &h8069
#define GL_TEXTURE_INTERNAL_FORMAT &h1003
#define GL_ALPHA4 &h803B
#define GL_ALPHA8 &h803C
#define GL_ALPHA12 &h803D
#define GL_ALPHA16 &h803E
#define GL_LUMINANCE4 &h803F
#define GL_LUMINANCE8 &h8040
#define GL_LUMINANCE12 &h8041
#define GL_LUMINANCE16 &h8042
#define GL_LUMINANCE4_ALPHA4 &h8043
#define GL_LUMINANCE6_ALPHA2 &h8044
#define GL_LUMINANCE8_ALPHA8 &h8045
#define GL_LUMINANCE12_ALPHA4 &h8046
#define GL_LUMINANCE12_ALPHA12 &h8047
#define GL_LUMINANCE16_ALPHA16 &h8048
#define GL_INTENSITY &h8049
#define GL_INTENSITY4 &h804A
#define GL_INTENSITY8 &h804B
#define GL_INTENSITY12 &h804C
#define GL_INTENSITY16 &h804D
#define GL_R3_G3_B2 &h2A10
#define GL_RGB4 &h804F
#define GL_RGB5 &h8050
#define GL_RGB8 &h8051
#define GL_RGB10 &h8052
#define GL_RGB12 &h8053
#define GL_RGB16 &h8054
#define GL_RGBA2 &h8055
#define GL_RGBA4 &h8056
#define GL_RGB5_A1 &h8057
#define GL_RGBA8 &h8058
#define GL_RGB10_A2 &h8059
#define GL_RGBA12 &h805A
#define GL_RGBA16 &h805B
#define GL_CLIENT_PIXEL_STORE_BIT &h00000001
#define GL_CLIENT_VERTEX_ARRAY_BIT &h00000002
#define GL_ALL_CLIENT_ATTRIB_BITS &hFFFFFFFF
#define GL_CLIENT_ALL_ATTRIB_BITS &hFFFFFFFF
#define GL_RESCALE_NORMAL &h803A
#define GL_CLAMP_TO_EDGE &h812F
#define GL_MAX_ELEMENTS_VERTICES &h80E8
#define GL_MAX_ELEMENTS_INDICES &h80E9
#define GL_BGR &h80E0
#define GL_BGRA &h80E1
#define GL_UNSIGNED_BYTE_3_3_2 &h8032
#define GL_UNSIGNED_BYTE_2_3_3_REV &h8362
#define GL_UNSIGNED_SHORT_5_6_5 &h8363
#define GL_UNSIGNED_SHORT_5_6_5_REV &h8364
#define GL_UNSIGNED_SHORT_4_4_4_4 &h8033
#define GL_UNSIGNED_SHORT_4_4_4_4_REV &h8365
#define GL_UNSIGNED_SHORT_5_5_5_1 &h8034
#define GL_UNSIGNED_SHORT_1_5_5_5_REV &h8366
#define GL_UNSIGNED_INT_8_8_8_8 &h8035
#define GL_UNSIGNED_INT_8_8_8_8_REV &h8367
#define GL_UNSIGNED_INT_10_10_10_2 &h8036
#define GL_UNSIGNED_INT_2_10_10_10_REV &h8368
#define GL_LIGHT_MODEL_COLOR_CONTROL &h81F8
#define GL_SINGLE_COLOR &h81F9
#define GL_SEPARATE_SPECULAR_COLOR &h81FA
#define GL_TEXTURE_MIN_LOD &h813A
#define GL_TEXTURE_MAX_LOD &h813B
#define GL_TEXTURE_BASE_LEVEL &h813C
#define GL_TEXTURE_MAX_LEVEL &h813D
#define GL_SMOOTH_POINT_SIZE_RANGE &h0B12
#define GL_SMOOTH_POINT_SIZE_GRANULARITY &h0B13
#define GL_SMOOTH_LINE_WIDTH_RANGE &h0B22
#define GL_SMOOTH_LINE_WIDTH_GRANULARITY &h0B23
#define GL_ALIASED_POINT_SIZE_RANGE &h846D
#define GL_ALIASED_LINE_WIDTH_RANGE &h846E
#define GL_PACK_SKIP_IMAGES &h806B
#define GL_PACK_IMAGE_HEIGHT &h806C
#define GL_UNPACK_SKIP_IMAGES &h806D
#define GL_UNPACK_IMAGE_HEIGHT &h806E
#define GL_TEXTURE_3D &h806F
#define GL_PROXY_TEXTURE_3D &h8070
#define GL_TEXTURE_DEPTH &h8071
#define GL_TEXTURE_WRAP_R &h8072
#define GL_MAX_3D_TEXTURE_SIZE &h8073
#define GL_TEXTURE_BINDING_3D &h806A
#define GL_COLOR_TABLE &h80D0
#define GL_POST_CONVOLUTION_COLOR_TABLE &h80D1
#define GL_POST_COLOR_MATRIX_COLOR_TABLE &h80D2
#define GL_PROXY_COLOR_TABLE &h80D3
#define GL_PROXY_POST_CONVOLUTION_COLOR_TABLE &h80D4
#define GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE &h80D5
#define GL_COLOR_TABLE_SCALE &h80D6
#define GL_COLOR_TABLE_BIAS &h80D7
#define GL_COLOR_TABLE_FORMAT &h80D8
#define GL_COLOR_TABLE_WIDTH &h80D9
#define GL_COLOR_TABLE_RED_SIZE &h80DA
#define GL_COLOR_TABLE_GREEN_SIZE &h80DB
#define GL_COLOR_TABLE_BLUE_SIZE &h80DC
#define GL_COLOR_TABLE_ALPHA_SIZE &h80DD
#define GL_COLOR_TABLE_LUMINANCE_SIZE &h80DE
#define GL_COLOR_TABLE_INTENSITY_SIZE &h80DF
#define GL_CONVOLUTION_1D &h8010
#define GL_CONVOLUTION_2D &h8011
#define GL_SEPARABLE_2D &h8012
#define GL_CONVOLUTION_BORDER_MODE &h8013
#define GL_CONVOLUTION_FILTER_SCALE &h8014
#define GL_CONVOLUTION_FILTER_BIAS &h8015
#define GL_REDUCE &h8016
#define GL_CONVOLUTION_FORMAT &h8017
#define GL_CONVOLUTION_WIDTH &h8018
#define GL_CONVOLUTION_HEIGHT &h8019
#define GL_MAX_CONVOLUTION_WIDTH &h801A
#define GL_MAX_CONVOLUTION_HEIGHT &h801B
#define GL_POST_CONVOLUTION_RED_SCALE &h801C
#define GL_POST_CONVOLUTION_GREEN_SCALE &h801D
#define GL_POST_CONVOLUTION_BLUE_SCALE &h801E
#define GL_POST_CONVOLUTION_ALPHA_SCALE &h801F
#define GL_POST_CONVOLUTION_RED_BIAS &h8020
#define GL_POST_CONVOLUTION_GREEN_BIAS &h8021
#define GL_POST_CONVOLUTION_BLUE_BIAS &h8022
#define GL_POST_CONVOLUTION_ALPHA_BIAS &h8023
#define GL_CONSTANT_BORDER &h8151
#define GL_REPLICATE_BORDER &h8153
#define GL_CONVOLUTION_BORDER_COLOR &h8154
#define GL_COLOR_MATRIX &h80B1
#define GL_COLOR_MATRIX_STACK_DEPTH &h80B2
#define GL_MAX_COLOR_MATRIX_STACK_DEPTH &h80B3
#define GL_POST_COLOR_MATRIX_RED_SCALE &h80B4
#define GL_POST_COLOR_MATRIX_GREEN_SCALE &h80B5
#define GL_POST_COLOR_MATRIX_BLUE_SCALE &h80B6
#define GL_POST_COLOR_MATRIX_ALPHA_SCALE &h80B7
#define GL_POST_COLOR_MATRIX_RED_BIAS &h80B8
#define GL_POST_COLOR_MATRIX_GREEN_BIAS &h80B9
#define GL_POST_COLOR_MATRIX_BLUE_BIAS &h80BA
#define GL_POST_COLOR_MATRIX_ALPHA_BIAS &h80BB
#define GL_HISTOGRAM &h8024
#define GL_PROXY_HISTOGRAM &h8025
#define GL_HISTOGRAM_WIDTH &h8026
#define GL_HISTOGRAM_FORMAT &h8027
#define GL_HISTOGRAM_RED_SIZE &h8028
#define GL_HISTOGRAM_GREEN_SIZE &h8029
#define GL_HISTOGRAM_BLUE_SIZE &h802A
#define GL_HISTOGRAM_ALPHA_SIZE &h802B
#define GL_HISTOGRAM_LUMINANCE_SIZE &h802C
#define GL_HISTOGRAM_SINK &h802D
#define GL_MINMAX &h802E
#define GL_MINMAX_FORMAT &h802F
#define GL_MINMAX_SINK &h8030
#define GL_TABLE_TOO_LARGE &h8031
#define GL_BLEND_EQUATION &h8009
#define GL_MIN &h8007
#define GL_MAX &h8008
#define GL_FUNC_ADD &h8006
#define GL_FUNC_SUBTRACT &h800A
#define GL_FUNC_REVERSE_SUBTRACT &h800B
#define GL_BLEND_COLOR &h8005
#define GL_TEXTURE0 &h84C0
#define GL_TEXTURE1 &h84C1
#define GL_TEXTURE2 &h84C2
#define GL_TEXTURE3 &h84C3
#define GL_TEXTURE4 &h84C4
#define GL_TEXTURE5 &h84C5
#define GL_TEXTURE6 &h84C6
#define GL_TEXTURE7 &h84C7
#define GL_TEXTURE8 &h84C8
#define GL_TEXTURE9 &h84C9
#define GL_TEXTURE10 &h84CA
#define GL_TEXTURE11 &h84CB
#define GL_TEXTURE12 &h84CC
#define GL_TEXTURE13 &h84CD
#define GL_TEXTURE14 &h84CE
#define GL_TEXTURE15 &h84CF
#define GL_TEXTURE16 &h84D0
#define GL_TEXTURE17 &h84D1
#define GL_TEXTURE18 &h84D2
#define GL_TEXTURE19 &h84D3
#define GL_TEXTURE20 &h84D4
#define GL_TEXTURE21 &h84D5
#define GL_TEXTURE22 &h84D6
#define GL_TEXTURE23 &h84D7
#define GL_TEXTURE24 &h84D8
#define GL_TEXTURE25 &h84D9
#define GL_TEXTURE26 &h84DA
#define GL_TEXTURE27 &h84DB
#define GL_TEXTURE28 &h84DC
#define GL_TEXTURE29 &h84DD
#define GL_TEXTURE30 &h84DE
#define GL_TEXTURE31 &h84DF
#define GL_ACTIVE_TEXTURE &h84E0
#define GL_CLIENT_ACTIVE_TEXTURE &h84E1
#define GL_MAX_TEXTURE_UNITS &h84E2
#define GL_NORMAL_MAP &h8511
#define GL_REFLECTION_MAP &h8512
#define GL_TEXTURE_CUBE_MAP &h8513
#define GL_TEXTURE_BINDING_CUBE_MAP &h8514
#define GL_TEXTURE_CUBE_MAP_POSITIVE_X &h8515
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_X &h8516
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Y &h8517
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Y &h8518
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Z &h8519
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Z &h851A
#define GL_PROXY_TEXTURE_CUBE_MAP &h851B
#define GL_MAX_CUBE_MAP_TEXTURE_SIZE &h851C
#define GL_COMPRESSED_ALPHA &h84E9
#define GL_COMPRESSED_LUMINANCE &h84EA
#define GL_COMPRESSED_LUMINANCE_ALPHA &h84EB
#define GL_COMPRESSED_INTENSITY &h84EC
#define GL_COMPRESSED_RGB &h84ED
#define GL_COMPRESSED_RGBA &h84EE
#define GL_TEXTURE_COMPRESSION_HINT &h84EF
#define GL_TEXTURE_COMPRESSED_IMAGE_SIZE &h86A0
#define GL_TEXTURE_COMPRESSED &h86A1
#define GL_NUM_COMPRESSED_TEXTURE_FORMATS &h86A2
#define GL_COMPRESSED_TEXTURE_FORMATS &h86A3
#define GL_MULTISAMPLE &h809D
#define GL_SAMPLE_ALPHA_TO_COVERAGE &h809E
#define GL_SAMPLE_ALPHA_TO_ONE &h809F
#define GL_SAMPLE_COVERAGE &h80A0
#define GL_SAMPLE_BUFFERS &h80A8
#define GL_SAMPLES &h80A9
#define GL_SAMPLE_COVERAGE_VALUE &h80AA
#define GL_SAMPLE_COVERAGE_INVERT &h80AB
#define GL_MULTISAMPLE_BIT &h20000000
#define GL_TRANSPOSE_MODELVIEW_MATRIX &h84E3
#define GL_TRANSPOSE_PROJECTION_MATRIX &h84E4
#define GL_TRANSPOSE_TEXTURE_MATRIX &h84E5
#define GL_TRANSPOSE_COLOR_MATRIX &h84E6
#define GL_COMBINE &h8570
#define GL_COMBINE_RGB &h8571
#define GL_COMBINE_ALPHA &h8572
#define GL_SOURCE0_RGB &h8580
#define GL_SOURCE1_RGB &h8581
#define GL_SOURCE2_RGB &h8582
#define GL_SOURCE0_ALPHA &h8588
#define GL_SOURCE1_ALPHA &h8589
#define GL_SOURCE2_ALPHA &h858A
#define GL_OPERAND0_RGB &h8590
#define GL_OPERAND1_RGB &h8591
#define GL_OPERAND2_RGB &h8592
#define GL_OPERAND0_ALPHA &h8598
#define GL_OPERAND1_ALPHA &h8599
#define GL_OPERAND2_ALPHA &h859A
#define GL_RGB_SCALE &h8573
#define GL_ADD_SIGNED &h8574
#define GL_INTERPOLATE &h8575
#define GL_SUBTRACT &h84E7
#define GL_CONSTANT &h8576
#define GL_PRIMARY_COLOR &h8577
#define GL_PREVIOUS &h8578
#define GL_DOT3_RGB &h86AE
#define GL_DOT3_RGBA &h86AF
#define GL_CLAMP_TO_BORDER &h812D

declare sub glClearIndex alias "glClearIndex" (byval c as GLfloat)
declare sub glClearColor alias "glClearColor" (byval red as GLclampf, byval green as GLclampf, byval blue as GLclampf, byval alpha as GLclampf)
declare sub glClear alias "glClear" (byval mask as GLbitfield)
declare sub glIndexMask alias "glIndexMask" (byval mask as GLuint)
declare sub glColorMask alias "glColorMask" (byval red as GLboolean, byval green as GLboolean, byval blue as GLboolean, byval alpha as GLboolean)
declare sub glAlphaFunc alias "glAlphaFunc" (byval func as GLenum, byval ref as GLclampf)
declare sub glBlendFunc alias "glBlendFunc" (byval sfactor as GLenum, byval dfactor as GLenum)
declare sub glLogicOp alias "glLogicOp" (byval opcode as GLenum)
declare sub glCullFace alias "glCullFace" (byval mode as GLenum)
declare sub glFrontFace alias "glFrontFace" (byval mode as GLenum)
declare sub glPointSize alias "glPointSize" (byval size as GLfloat)
declare sub glLineWidth alias "glLineWidth" (byval width as GLfloat)
declare sub glLineStipple alias "glLineStipple" (byval factor as GLint, byval pattern as GLushort)
declare sub glPolygonMode alias "glPolygonMode" (byval face as GLenum, byval mode as GLenum)
declare sub glPolygonOffset alias "glPolygonOffset" (byval factor as GLfloat, byval units as GLfloat)
declare sub glPolygonStipple alias "glPolygonStipple" (byval mask as GLubyte ptr)
declare sub glGetPolygonStipple alias "glGetPolygonStipple" (byval mask as GLubyte ptr)
declare sub glEdgeFlag alias "glEdgeFlag" (byval flag as GLboolean)
declare sub glEdgeFlagv alias "glEdgeFlagv" (byval flag as GLboolean ptr)
declare sub glScissor alias "glScissor" (byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
declare sub glClipPlane alias "glClipPlane" (byval plane as GLenum, byval equation as GLdouble ptr)
declare sub glGetClipPlane alias "glGetClipPlane" (byval plane as GLenum, byval equation as GLdouble ptr)
declare sub glDrawBuffer alias "glDrawBuffer" (byval mode as GLenum)
declare sub glReadBuffer alias "glReadBuffer" (byval mode as GLenum)
declare sub glEnable alias "glEnable" (byval cap as GLenum)
declare sub glDisable alias "glDisable" (byval cap as GLenum)
declare function glIsEnabled alias "glIsEnabled" (byval cap as GLenum) as GLboolean
declare sub glEnableClientState alias "glEnableClientState" (byval cap as GLenum)
declare sub glDisableClientState alias "glDisableClientState" (byval cap as GLenum)
declare sub glGetBooleanv alias "glGetBooleanv" (byval pname as GLenum, byval params as GLboolean ptr)
declare sub glGetDoublev alias "glGetDoublev" (byval pname as GLenum, byval params as GLdouble ptr)
declare sub glGetFloatv alias "glGetFloatv" (byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetIntegerv alias "glGetIntegerv" (byval pname as GLenum, byval params as GLint ptr)
declare sub glPushAttrib alias "glPushAttrib" (byval mask as GLbitfield)
declare sub glPopAttrib alias "glPopAttrib" ()
declare sub glPushClientAttrib alias "glPushClientAttrib" (byval mask as GLbitfield)
declare sub glPopClientAttrib alias "glPopClientAttrib" ()
declare function glRenderMode alias "glRenderMode" (byval mode as GLenum) as GLint
declare function glGetError alias "glGetError" () as GLenum
declare function glGetString alias "glGetString" (byval name as GLenum) as zstring ptr
declare sub glFinish alias "glFinish" ()
declare sub glFlush alias "glFlush" ()
declare sub glHint alias "glHint" (byval target as GLenum, byval mode as GLenum)
declare sub glClearDepth alias "glClearDepth" (byval depth as GLclampd)
declare sub glDepthFunc alias "glDepthFunc" (byval func as GLenum)
declare sub glDepthMask alias "glDepthMask" (byval flag as GLboolean)
declare sub glDepthRange alias "glDepthRange" (byval near_val as GLclampd, byval far_val as GLclampd)
declare sub glClearAccum alias "glClearAccum" (byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat, byval alpha as GLfloat)
declare sub glAccum alias "glAccum" (byval op as GLenum, byval value as GLfloat)
declare sub glMatrixMode alias "glMatrixMode" (byval mode as GLenum)
declare sub glOrtho alias "glOrtho" (byval left as GLdouble, byval right as GLdouble, byval bottom as GLdouble, byval top as GLdouble, byval near_val as GLdouble, byval far_val as GLdouble)
declare sub glFrustum alias "glFrustum" (byval left as GLdouble, byval right as GLdouble, byval bottom as GLdouble, byval top as GLdouble, byval near_val as GLdouble, byval far_val as GLdouble)
declare sub glViewport alias "glViewport" (byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
declare sub glPushMatrix alias "glPushMatrix" ()
declare sub glPopMatrix alias "glPopMatrix" ()
declare sub glLoadIdentity alias "glLoadIdentity" ()
declare sub glLoadMatrixd alias "glLoadMatrixd" (byval m as GLdouble ptr)
declare sub glLoadMatrixf alias "glLoadMatrixf" (byval m as GLfloat ptr)
declare sub glMultMatrixd alias "glMultMatrixd" (byval m as GLdouble ptr)
declare sub glMultMatrixf alias "glMultMatrixf" (byval m as GLfloat ptr)
declare sub glRotated alias "glRotated" (byval angle as GLdouble, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
declare sub glRotatef alias "glRotatef" (byval angle as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
declare sub glScaled alias "glScaled" (byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
declare sub glScalef alias "glScalef" (byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
declare sub glTranslated alias "glTranslated" (byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
declare sub glTranslatef alias "glTranslatef" (byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
declare function glIsList alias "glIsList" (byval list as GLuint) as GLboolean
declare sub glDeleteLists alias "glDeleteLists" (byval list as GLuint, byval range as GLsizei)
declare function glGenLists alias "glGenLists" (byval range as GLsizei) as GLuint
declare sub glNewList alias "glNewList" (byval list as GLuint, byval mode as GLenum)
declare sub glEndList alias "glEndList" ()
declare sub glCallList alias "glCallList" (byval list as GLuint)
declare sub glCallLists alias "glCallLists" (byval n as GLsizei, byval type as GLenum, byval lists as GLvoid ptr)
declare sub glListBase alias "glListBase" (byval base as GLuint)
declare sub glBegin alias "glBegin" (byval mode as GLenum)
declare sub glEnd alias "glEnd" ()
declare sub glVertex2d alias "glVertex2d" (byval x as GLdouble, byval y as GLdouble)
declare sub glVertex2f alias "glVertex2f" (byval x as GLfloat, byval y as GLfloat)
declare sub glVertex2i alias "glVertex2i" (byval x as GLint, byval y as GLint)
declare sub glVertex2s alias "glVertex2s" (byval x as GLshort, byval y as GLshort)
declare sub glVertex3d alias "glVertex3d" (byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
declare sub glVertex3f alias "glVertex3f" (byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
declare sub glVertex3i alias "glVertex3i" (byval x as GLint, byval y as GLint, byval z as GLint)
declare sub glVertex3s alias "glVertex3s" (byval x as GLshort, byval y as GLshort, byval z as GLshort)
declare sub glVertex4d alias "glVertex4d" (byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
declare sub glVertex4f alias "glVertex4f" (byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
declare sub glVertex4i alias "glVertex4i" (byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
declare sub glVertex4s alias "glVertex4s" (byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
declare sub glVertex2dv alias "glVertex2dv" (byval v as GLdouble ptr)
declare sub glVertex2fv alias "glVertex2fv" (byval v as GLfloat ptr)
declare sub glVertex2iv alias "glVertex2iv" (byval v as GLint ptr)
declare sub glVertex2sv alias "glVertex2sv" (byval v as GLshort ptr)
declare sub glVertex3dv alias "glVertex3dv" (byval v as GLdouble ptr)
declare sub glVertex3fv alias "glVertex3fv" (byval v as GLfloat ptr)
declare sub glVertex3iv alias "glVertex3iv" (byval v as GLint ptr)
declare sub glVertex3sv alias "glVertex3sv" (byval v as GLshort ptr)
declare sub glVertex4dv alias "glVertex4dv" (byval v as GLdouble ptr)
declare sub glVertex4fv alias "glVertex4fv" (byval v as GLfloat ptr)
declare sub glVertex4iv alias "glVertex4iv" (byval v as GLint ptr)
declare sub glVertex4sv alias "glVertex4sv" (byval v as GLshort ptr)
declare sub glNormal3b alias "glNormal3b" (byval nx as GLbyte, byval ny as GLbyte, byval nz as GLbyte)
declare sub glNormal3d alias "glNormal3d" (byval nx as GLdouble, byval ny as GLdouble, byval nz as GLdouble)
declare sub glNormal3f alias "glNormal3f" (byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat)
declare sub glNormal3i alias "glNormal3i" (byval nx as GLint, byval ny as GLint, byval nz as GLint)
declare sub glNormal3s alias "glNormal3s" (byval nx as GLshort, byval ny as GLshort, byval nz as GLshort)
declare sub glNormal3bv alias "glNormal3bv" (byval v as GLbyte ptr)
declare sub glNormal3dv alias "glNormal3dv" (byval v as GLdouble ptr)
declare sub glNormal3fv alias "glNormal3fv" (byval v as GLfloat ptr)
declare sub glNormal3iv alias "glNormal3iv" (byval v as GLint ptr)
declare sub glNormal3sv alias "glNormal3sv" (byval v as GLshort ptr)
declare sub glIndexd alias "glIndexd" (byval c as GLdouble)
declare sub glIndexf alias "glIndexf" (byval c as GLfloat)
declare sub glIndexi alias "glIndexi" (byval c as GLint)
declare sub glIndexs alias "glIndexs" (byval c as GLshort)
declare sub glIndexub alias "glIndexub" (byval c as GLubyte)
declare sub glIndexdv alias "glIndexdv" (byval c as GLdouble ptr)
declare sub glIndexfv alias "glIndexfv" (byval c as GLfloat ptr)
declare sub glIndexiv alias "glIndexiv" (byval c as GLint ptr)
declare sub glIndexsv alias "glIndexsv" (byval c as GLshort ptr)
declare sub glIndexubv alias "glIndexubv" (byval c as GLubyte ptr)
declare sub glColor3b alias "glColor3b" (byval red as GLbyte, byval green as GLbyte, byval blue as GLbyte)
declare sub glColor3d alias "glColor3d" (byval red as GLdouble, byval green as GLdouble, byval blue as GLdouble)
declare sub glColor3f alias "glColor3f" (byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat)
declare sub glColor3i alias "glColor3i" (byval red as GLint, byval green as GLint, byval blue as GLint)
declare sub glColor3s alias "glColor3s" (byval red as GLshort, byval green as GLshort, byval blue as GLshort)
declare sub glColor3ub alias "glColor3ub" (byval red as GLubyte, byval green as GLubyte, byval blue as GLubyte)
declare sub glColor3ui alias "glColor3ui" (byval red as GLuint, byval green as GLuint, byval blue as GLuint)
declare sub glColor3us alias "glColor3us" (byval red as GLushort, byval green as GLushort, byval blue as GLushort)
declare sub glColor4b alias "glColor4b" (byval red as GLbyte, byval green as GLbyte, byval blue as GLbyte, byval alpha as GLbyte)
declare sub glColor4d alias "glColor4d" (byval red as GLdouble, byval green as GLdouble, byval blue as GLdouble, byval alpha as GLdouble)
declare sub glColor4f alias "glColor4f" (byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat, byval alpha as GLfloat)
declare sub glColor4i alias "glColor4i" (byval red as GLint, byval green as GLint, byval blue as GLint, byval alpha as GLint)
declare sub glColor4s alias "glColor4s" (byval red as GLshort, byval green as GLshort, byval blue as GLshort, byval alpha as GLshort)
declare sub glColor4ub alias "glColor4ub" (byval red as GLubyte, byval green as GLubyte, byval blue as GLubyte, byval alpha as GLubyte)
declare sub glColor4ui alias "glColor4ui" (byval red as GLuint, byval green as GLuint, byval blue as GLuint, byval alpha as GLuint)
declare sub glColor4us alias "glColor4us" (byval red as GLushort, byval green as GLushort, byval blue as GLushort, byval alpha as GLushort)
declare sub glColor3bv alias "glColor3bv" (byval v as GLbyte ptr)
declare sub glColor3dv alias "glColor3dv" (byval v as GLdouble ptr)
declare sub glColor3fv alias "glColor3fv" (byval v as GLfloat ptr)
declare sub glColor3iv alias "glColor3iv" (byval v as GLint ptr)
declare sub glColor3sv alias "glColor3sv" (byval v as GLshort ptr)
declare sub glColor3ubv alias "glColor3ubv" (byval v as GLubyte ptr)
declare sub glColor3uiv alias "glColor3uiv" (byval v as GLuint ptr)
declare sub glColor3usv alias "glColor3usv" (byval v as GLushort ptr)
declare sub glColor4bv alias "glColor4bv" (byval v as GLbyte ptr)
declare sub glColor4dv alias "glColor4dv" (byval v as GLdouble ptr)
declare sub glColor4fv alias "glColor4fv" (byval v as GLfloat ptr)
declare sub glColor4iv alias "glColor4iv" (byval v as GLint ptr)
declare sub glColor4sv alias "glColor4sv" (byval v as GLshort ptr)
declare sub glColor4ubv alias "glColor4ubv" (byval v as GLubyte ptr)
declare sub glColor4uiv alias "glColor4uiv" (byval v as GLuint ptr)
declare sub glColor4usv alias "glColor4usv" (byval v as GLushort ptr)
declare sub glTexCoord1d alias "glTexCoord1d" (byval s as GLdouble)
declare sub glTexCoord1f alias "glTexCoord1f" (byval s as GLfloat)
declare sub glTexCoord1i alias "glTexCoord1i" (byval s as GLint)
declare sub glTexCoord1s alias "glTexCoord1s" (byval s as GLshort)
declare sub glTexCoord2d alias "glTexCoord2d" (byval s as GLdouble, byval t as GLdouble)
declare sub glTexCoord2f alias "glTexCoord2f" (byval s as GLfloat, byval t as GLfloat)
declare sub glTexCoord2i alias "glTexCoord2i" (byval s as GLint, byval t as GLint)
declare sub glTexCoord2s alias "glTexCoord2s" (byval s as GLshort, byval t as GLshort)
declare sub glTexCoord3d alias "glTexCoord3d" (byval s as GLdouble, byval t as GLdouble, byval r as GLdouble)
declare sub glTexCoord3f alias "glTexCoord3f" (byval s as GLfloat, byval t as GLfloat, byval r as GLfloat)
declare sub glTexCoord3i alias "glTexCoord3i" (byval s as GLint, byval t as GLint, byval r as GLint)
declare sub glTexCoord3s alias "glTexCoord3s" (byval s as GLshort, byval t as GLshort, byval r as GLshort)
declare sub glTexCoord4d alias "glTexCoord4d" (byval s as GLdouble, byval t as GLdouble, byval r as GLdouble, byval q as GLdouble)
declare sub glTexCoord4f alias "glTexCoord4f" (byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval q as GLfloat)
declare sub glTexCoord4i alias "glTexCoord4i" (byval s as GLint, byval t as GLint, byval r as GLint, byval q as GLint)
declare sub glTexCoord4s alias "glTexCoord4s" (byval s as GLshort, byval t as GLshort, byval r as GLshort, byval q as GLshort)
declare sub glTexCoord1dv alias "glTexCoord1dv" (byval v as GLdouble ptr)
declare sub glTexCoord1fv alias "glTexCoord1fv" (byval v as GLfloat ptr)
declare sub glTexCoord1iv alias "glTexCoord1iv" (byval v as GLint ptr)
declare sub glTexCoord1sv alias "glTexCoord1sv" (byval v as GLshort ptr)
declare sub glTexCoord2dv alias "glTexCoord2dv" (byval v as GLdouble ptr)
declare sub glTexCoord2fv alias "glTexCoord2fv" (byval v as GLfloat ptr)
declare sub glTexCoord2iv alias "glTexCoord2iv" (byval v as GLint ptr)
declare sub glTexCoord2sv alias "glTexCoord2sv" (byval v as GLshort ptr)
declare sub glTexCoord3dv alias "glTexCoord3dv" (byval v as GLdouble ptr)
declare sub glTexCoord3fv alias "glTexCoord3fv" (byval v as GLfloat ptr)
declare sub glTexCoord3iv alias "glTexCoord3iv" (byval v as GLint ptr)
declare sub glTexCoord3sv alias "glTexCoord3sv" (byval v as GLshort ptr)
declare sub glTexCoord4dv alias "glTexCoord4dv" (byval v as GLdouble ptr)
declare sub glTexCoord4fv alias "glTexCoord4fv" (byval v as GLfloat ptr)
declare sub glTexCoord4iv alias "glTexCoord4iv" (byval v as GLint ptr)
declare sub glTexCoord4sv alias "glTexCoord4sv" (byval v as GLshort ptr)
declare sub glRasterPos2d alias "glRasterPos2d" (byval x as GLdouble, byval y as GLdouble)
declare sub glRasterPos2f alias "glRasterPos2f" (byval x as GLfloat, byval y as GLfloat)
declare sub glRasterPos2i alias "glRasterPos2i" (byval x as GLint, byval y as GLint)
declare sub glRasterPos2s alias "glRasterPos2s" (byval x as GLshort, byval y as GLshort)
declare sub glRasterPos3d alias "glRasterPos3d" (byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
declare sub glRasterPos3f alias "glRasterPos3f" (byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
declare sub glRasterPos3i alias "glRasterPos3i" (byval x as GLint, byval y as GLint, byval z as GLint)
declare sub glRasterPos3s alias "glRasterPos3s" (byval x as GLshort, byval y as GLshort, byval z as GLshort)
declare sub glRasterPos4d alias "glRasterPos4d" (byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
declare sub glRasterPos4f alias "glRasterPos4f" (byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
declare sub glRasterPos4i alias "glRasterPos4i" (byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
declare sub glRasterPos4s alias "glRasterPos4s" (byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
declare sub glRasterPos2dv alias "glRasterPos2dv" (byval v as GLdouble ptr)
declare sub glRasterPos2fv alias "glRasterPos2fv" (byval v as GLfloat ptr)
declare sub glRasterPos2iv alias "glRasterPos2iv" (byval v as GLint ptr)
declare sub glRasterPos2sv alias "glRasterPos2sv" (byval v as GLshort ptr)
declare sub glRasterPos3dv alias "glRasterPos3dv" (byval v as GLdouble ptr)
declare sub glRasterPos3fv alias "glRasterPos3fv" (byval v as GLfloat ptr)
declare sub glRasterPos3iv alias "glRasterPos3iv" (byval v as GLint ptr)
declare sub glRasterPos3sv alias "glRasterPos3sv" (byval v as GLshort ptr)
declare sub glRasterPos4dv alias "glRasterPos4dv" (byval v as GLdouble ptr)
declare sub glRasterPos4fv alias "glRasterPos4fv" (byval v as GLfloat ptr)
declare sub glRasterPos4iv alias "glRasterPos4iv" (byval v as GLint ptr)
declare sub glRasterPos4sv alias "glRasterPos4sv" (byval v as GLshort ptr)
declare sub glRectd alias "glRectd" (byval x1 as GLdouble, byval y1 as GLdouble, byval x2 as GLdouble, byval y2 as GLdouble)
declare sub glRectf alias "glRectf" (byval x1 as GLfloat, byval y1 as GLfloat, byval x2 as GLfloat, byval y2 as GLfloat)
declare sub glRecti alias "glRecti" (byval x1 as GLint, byval y1 as GLint, byval x2 as GLint, byval y2 as GLint)
declare sub glRects alias "glRects" (byval x1 as GLshort, byval y1 as GLshort, byval x2 as GLshort, byval y2 as GLshort)
declare sub glRectdv alias "glRectdv" (byval v1 as GLdouble ptr, byval v2 as GLdouble ptr)
declare sub glRectfv alias "glRectfv" (byval v1 as GLfloat ptr, byval v2 as GLfloat ptr)
declare sub glRectiv alias "glRectiv" (byval v1 as GLint ptr, byval v2 as GLint ptr)
declare sub glRectsv alias "glRectsv" (byval v1 as GLshort ptr, byval v2 as GLshort ptr)
declare sub glShadeModel alias "glShadeModel" (byval mode as GLenum)
declare sub glLightf alias "glLightf" (byval light as GLenum, byval pname as GLenum, byval param as GLfloat)
declare sub glLighti alias "glLighti" (byval light as GLenum, byval pname as GLenum, byval param as GLint)
declare sub glLightfv alias "glLightfv" (byval light as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glLightiv alias "glLightiv" (byval light as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glGetLightfv alias "glGetLightfv" (byval light as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetLightiv alias "glGetLightiv" (byval light as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glLightModelf alias "glLightModelf" (byval pname as GLenum, byval param as GLfloat)
declare sub glLightModeli alias "glLightModeli" (byval pname as GLenum, byval param as GLint)
declare sub glLightModelfv alias "glLightModelfv" (byval pname as GLenum, byval params as GLfloat ptr)
declare sub glLightModeliv alias "glLightModeliv" (byval pname as GLenum, byval params as GLint ptr)
declare sub glMaterialf alias "glMaterialf" (byval face as GLenum, byval pname as GLenum, byval param as GLfloat)
declare sub glMateriali alias "glMateriali" (byval face as GLenum, byval pname as GLenum, byval param as GLint)
declare sub glMaterialfv alias "glMaterialfv" (byval face as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glMaterialiv alias "glMaterialiv" (byval face as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glGetMaterialfv alias "glGetMaterialfv" (byval face as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetMaterialiv alias "glGetMaterialiv" (byval face as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glColorMaterial alias "glColorMaterial" (byval face as GLenum, byval mode as GLenum)
declare sub glPixelZoom alias "glPixelZoom" (byval xfactor as GLfloat, byval yfactor as GLfloat)
declare sub glPixelStoref alias "glPixelStoref" (byval pname as GLenum, byval param as GLfloat)
declare sub glPixelStorei alias "glPixelStorei" (byval pname as GLenum, byval param as GLint)
declare sub glPixelTransferf alias "glPixelTransferf" (byval pname as GLenum, byval param as GLfloat)
declare sub glPixelTransferi alias "glPixelTransferi" (byval pname as GLenum, byval param as GLint)
declare sub glPixelMapfv alias "glPixelMapfv" (byval map as GLenum, byval mapsize as GLint, byval values as GLfloat ptr)
declare sub glPixelMapuiv alias "glPixelMapuiv" (byval map as GLenum, byval mapsize as GLint, byval values as GLuint ptr)
declare sub glPixelMapusv alias "glPixelMapusv" (byval map as GLenum, byval mapsize as GLint, byval values as GLushort ptr)
declare sub glGetPixelMapfv alias "glGetPixelMapfv" (byval map as GLenum, byval values as GLfloat ptr)
declare sub glGetPixelMapuiv alias "glGetPixelMapuiv" (byval map as GLenum, byval values as GLuint ptr)
declare sub glGetPixelMapusv alias "glGetPixelMapusv" (byval map as GLenum, byval values as GLushort ptr)
declare sub glBitmap alias "glBitmap" (byval width as GLsizei, byval height as GLsizei, byval xorig as GLfloat, byval yorig as GLfloat, byval xmove as GLfloat, byval ymove as GLfloat, byval bitmap as GLubyte ptr)
declare sub glReadPixels alias "glReadPixels" (byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as GLvoid ptr)
declare sub glDrawPixels alias "glDrawPixels" (byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as GLvoid ptr)
declare sub glCopyPixels alias "glCopyPixels" (byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval type as GLenum)
declare sub glStencilFunc alias "glStencilFunc" (byval func as GLenum, byval ref as GLint, byval mask as GLuint)
declare sub glStencilMask alias "glStencilMask" (byval mask as GLuint)
declare sub glStencilOp alias "glStencilOp" (byval fail as GLenum, byval zfail as GLenum, byval zpass as GLenum)
declare sub glClearStencil alias "glClearStencil" (byval s as GLint)
declare sub glTexGend alias "glTexGend" (byval coord as GLenum, byval pname as GLenum, byval param as GLdouble)
declare sub glTexGenf alias "glTexGenf" (byval coord as GLenum, byval pname as GLenum, byval param as GLfloat)
declare sub glTexGeni alias "glTexGeni" (byval coord as GLenum, byval pname as GLenum, byval param as GLint)
declare sub glTexGendv alias "glTexGendv" (byval coord as GLenum, byval pname as GLenum, byval params as GLdouble ptr)
declare sub glTexGenfv alias "glTexGenfv" (byval coord as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glTexGeniv alias "glTexGeniv" (byval coord as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glGetTexGendv alias "glGetTexGendv" (byval coord as GLenum, byval pname as GLenum, byval params as GLdouble ptr)
declare sub glGetTexGenfv alias "glGetTexGenfv" (byval coord as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetTexGeniv alias "glGetTexGeniv" (byval coord as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glTexEnvf alias "glTexEnvf" (byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
declare sub glTexEnvi alias "glTexEnvi" (byval target as GLenum, byval pname as GLenum, byval param as GLint)
declare sub glTexEnvfv alias "glTexEnvfv" (byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glTexEnviv alias "glTexEnviv" (byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glGetTexEnvfv alias "glGetTexEnvfv" (byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetTexEnviv alias "glGetTexEnviv" (byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glTexParameterf alias "glTexParameterf" (byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
declare sub glTexParameteri alias "glTexParameteri" (byval target as GLenum, byval pname as GLenum, byval param as GLint)
declare sub glTexParameterfv alias "glTexParameterfv" (byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glTexParameteriv alias "glTexParameteriv" (byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glGetTexParameterfv alias "glGetTexParameterfv" (byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetTexParameteriv alias "glGetTexParameteriv" (byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glGetTexLevelParameterfv alias "glGetTexLevelParameterfv" (byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetTexLevelParameteriv alias "glGetTexLevelParameteriv" (byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLint ptr)
declare sub glTexImage1D alias "glTexImage1D" (byval target as GLenum, byval level as GLint, byval internalFormat as GLint, byval width as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as GLvoid ptr)
declare sub glTexImage2D alias "glTexImage2D" (byval target as GLenum, byval level as GLint, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as GLvoid ptr)
declare sub glGetTexImage alias "glGetTexImage" (byval target as GLenum, byval level as GLint, byval format as GLenum, byval type as GLenum, byval pixels as GLvoid ptr)
declare sub glMap1d alias "glMap1d" (byval target as GLenum, byval u1 as GLdouble, byval u2 as GLdouble, byval stride as GLint, byval order as GLint, byval points as GLdouble ptr)
declare sub glMap1f alias "glMap1f" (byval target as GLenum, byval u1 as GLfloat, byval u2 as GLfloat, byval stride as GLint, byval order as GLint, byval points as GLfloat ptr)
declare sub glMap2d alias "glMap2d" (byval target as GLenum, byval u1 as GLdouble, byval u2 as GLdouble, byval ustride as GLint, byval uorder as GLint, byval v1 as GLdouble, byval v2 as GLdouble, byval vstride as GLint, byval vorder as GLint, byval points as GLdouble ptr)
declare sub glMap2f alias "glMap2f" (byval target as GLenum, byval u1 as GLfloat, byval u2 as GLfloat, byval ustride as GLint, byval uorder as GLint, byval v1 as GLfloat, byval v2 as GLfloat, byval vstride as GLint, byval vorder as GLint, byval points as GLfloat ptr)
declare sub glGetMapdv alias "glGetMapdv" (byval target as GLenum, byval query as GLenum, byval v as GLdouble ptr)
declare sub glGetMapfv alias "glGetMapfv" (byval target as GLenum, byval query as GLenum, byval v as GLfloat ptr)
declare sub glGetMapiv alias "glGetMapiv" (byval target as GLenum, byval query as GLenum, byval v as GLint ptr)
declare sub glEvalCoord1d alias "glEvalCoord1d" (byval u as GLdouble)
declare sub glEvalCoord1f alias "glEvalCoord1f" (byval u as GLfloat)
declare sub glEvalCoord1dv alias "glEvalCoord1dv" (byval u as GLdouble ptr)
declare sub glEvalCoord1fv alias "glEvalCoord1fv" (byval u as GLfloat ptr)
declare sub glEvalCoord2d alias "glEvalCoord2d" (byval u as GLdouble, byval v as GLdouble)
declare sub glEvalCoord2f alias "glEvalCoord2f" (byval u as GLfloat, byval v as GLfloat)
declare sub glEvalCoord2dv alias "glEvalCoord2dv" (byval u as GLdouble ptr)
declare sub glEvalCoord2fv alias "glEvalCoord2fv" (byval u as GLfloat ptr)
declare sub glMapGrid1d alias "glMapGrid1d" (byval un as GLint, byval u1 as GLdouble, byval u2 as GLdouble)
declare sub glMapGrid1f alias "glMapGrid1f" (byval un as GLint, byval u1 as GLfloat, byval u2 as GLfloat)
declare sub glMapGrid2d alias "glMapGrid2d" (byval un as GLint, byval u1 as GLdouble, byval u2 as GLdouble, byval vn as GLint, byval v1 as GLdouble, byval v2 as GLdouble)
declare sub glMapGrid2f alias "glMapGrid2f" (byval un as GLint, byval u1 as GLfloat, byval u2 as GLfloat, byval vn as GLint, byval v1 as GLfloat, byval v2 as GLfloat)
declare sub glEvalPoint1 alias "glEvalPoint1" (byval i as GLint)
declare sub glEvalPoint2 alias "glEvalPoint2" (byval i as GLint, byval j as GLint)
declare sub glEvalMesh1 alias "glEvalMesh1" (byval mode as GLenum, byval i1 as GLint, byval i2 as GLint)
declare sub glEvalMesh2 alias "glEvalMesh2" (byval mode as GLenum, byval i1 as GLint, byval i2 as GLint, byval j1 as GLint, byval j2 as GLint)
declare sub glFogf alias "glFogf" (byval pname as GLenum, byval param as GLfloat)
declare sub glFogi alias "glFogi" (byval pname as GLenum, byval param as GLint)
declare sub glFogfv alias "glFogfv" (byval pname as GLenum, byval params as GLfloat ptr)
declare sub glFogiv alias "glFogiv" (byval pname as GLenum, byval params as GLint ptr)
declare sub glFeedbackBuffer alias "glFeedbackBuffer" (byval size as GLsizei, byval type as GLenum, byval buffer as GLfloat ptr)
declare sub glPassThrough alias "glPassThrough" (byval token as GLfloat)
declare sub glSelectBuffer alias "glSelectBuffer" (byval size as GLsizei, byval buffer as GLuint ptr)
declare sub glInitNames alias "glInitNames" ()
declare sub glLoadName alias "glLoadName" (byval name as GLuint)
declare sub glPushName alias "glPushName" (byval name as GLuint)
declare sub glPopName alias "glPopName" ()
declare sub glGenTextures alias "glGenTextures" (byval n as GLsizei, byval textures as GLuint ptr)
declare sub glDeleteTextures alias "glDeleteTextures" (byval n as GLsizei, byval textures as GLuint ptr)
declare sub glBindTexture alias "glBindTexture" (byval target as GLenum, byval texture as GLuint)
declare sub glPrioritizeTextures alias "glPrioritizeTextures" (byval n as GLsizei, byval textures as GLuint ptr, byval priorities as GLclampf ptr)
declare function glAreTexturesResident alias "glAreTexturesResident" (byval n as GLsizei, byval textures as GLuint ptr, byval residences as GLboolean ptr) as GLboolean
declare function glIsTexture alias "glIsTexture" (byval texture as GLuint) as GLboolean
declare sub glTexSubImage1D alias "glTexSubImage1D" (byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as GLvoid ptr)
declare sub glTexSubImage2D alias "glTexSubImage2D" (byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as GLvoid ptr)
declare sub glCopyTexImage1D alias "glCopyTexImage1D" (byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval border as GLint)
declare sub glCopyTexImage2D alias "glCopyTexImage2D" (byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint)
declare sub glCopyTexSubImage1D alias "glCopyTexSubImage1D" (byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei)
declare sub glCopyTexSubImage2D alias "glCopyTexSubImage2D" (byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
declare sub glVertexPointer alias "glVertexPointer" (byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval ptr as GLvoid ptr)
declare sub glNormalPointer alias "glNormalPointer" (byval type as GLenum, byval stride as GLsizei, byval ptr as GLvoid ptr)
declare sub glColorPointer alias "glColorPointer" (byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval ptr as GLvoid ptr)
declare sub glIndexPointer alias "glIndexPointer" (byval type as GLenum, byval stride as GLsizei, byval ptr as GLvoid ptr)
declare sub glTexCoordPointer alias "glTexCoordPointer" (byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval ptr as GLvoid ptr)
declare sub glEdgeFlagPointer alias "glEdgeFlagPointer" (byval stride as GLsizei, byval ptr as GLvoid ptr)
declare sub glGetPointerv alias "glGetPointerv" (byval pname as GLenum, byval params as GLvoid ptr ptr)
declare sub glArrayElement alias "glArrayElement" (byval i as GLint)
declare sub glDrawArrays alias "glDrawArrays" (byval mode as GLenum, byval first as GLint, byval count as GLsizei)
declare sub glDrawElements alias "glDrawElements" (byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as GLvoid ptr)
declare sub glInterleavedArrays alias "glInterleavedArrays" (byval format as GLenum, byval stride as GLsizei, byval pointer as GLvoid ptr)

#if not defined(__FB_WIN32__)

declare sub glDrawRangeElements alias "glDrawRangeElements" (byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval count as GLsizei, byval type as GLenum, byval indices as GLvoid ptr)
declare sub glTexImage3D alias "glTexImage3D" (byval target as GLenum, byval level as GLint, byval internalFormat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as GLvoid ptr)
declare sub glTexSubImage3D alias "glTexSubImage3D" (byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as GLvoid ptr)
declare sub glCopyTexSubImage3D alias "glCopyTexSubImage3D" (byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
declare sub glColorTable alias "glColorTable" (byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval table as GLvoid ptr)
declare sub glColorSubTable alias "glColorSubTable" (byval target as GLenum, byval start as GLsizei, byval count as GLsizei, byval format as GLenum, byval type as GLenum, byval data as GLvoid ptr)
declare sub glColorTableParameteriv alias "glColorTableParameteriv" (byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glColorTableParameterfv alias "glColorTableParameterfv" (byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glCopyColorSubTable alias "glCopyColorSubTable" (byval target as GLenum, byval start as GLsizei, byval x as GLint, byval y as GLint, byval width as GLsizei)
declare sub glCopyColorTable alias "glCopyColorTable" (byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei)
declare sub glGetColorTable alias "glGetColorTable" (byval target as GLenum, byval format as GLenum, byval type as GLenum, byval table as GLvoid ptr)
declare sub glGetColorTableParameterfv alias "glGetColorTableParameterfv" (byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetColorTableParameteriv alias "glGetColorTableParameteriv" (byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glBlendEquation alias "glBlendEquation" (byval mode as GLenum)
declare sub glBlendColor alias "glBlendColor" (byval red as GLclampf, byval green as GLclampf, byval blue as GLclampf, byval alpha as GLclampf)
declare sub glHistogram alias "glHistogram" (byval target as GLenum, byval width as GLsizei, byval internalformat as GLenum, byval sink as GLboolean)
declare sub glResetHistogram alias "glResetHistogram" (byval target as GLenum)
declare sub glGetHistogram alias "glGetHistogram" (byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval values as GLvoid ptr)
declare sub glGetHistogramParameterfv alias "glGetHistogramParameterfv" (byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetHistogramParameteriv alias "glGetHistogramParameteriv" (byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glMinmax alias "glMinmax" (byval target as GLenum, byval internalformat as GLenum, byval sink as GLboolean)
declare sub glResetMinmax alias "glResetMinmax" (byval target as GLenum)
declare sub glGetMinmax alias "glGetMinmax" (byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval types as GLenum, byval values as GLvoid ptr)
declare sub glGetMinmaxParameterfv alias "glGetMinmaxParameterfv" (byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetMinmaxParameteriv alias "glGetMinmaxParameteriv" (byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glConvolutionFilter1D alias "glConvolutionFilter1D" (byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval image as GLvoid ptr)
declare sub glConvolutionFilter2D alias "glConvolutionFilter2D" (byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval image as GLvoid ptr)
declare sub glConvolutionParameterf alias "glConvolutionParameterf" (byval target as GLenum, byval pname as GLenum, byval params as GLfloat)
declare sub glConvolutionParameterfv alias "glConvolutionParameterfv" (byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glConvolutionParameteri alias "glConvolutionParameteri" (byval target as GLenum, byval pname as GLenum, byval params as GLint)
declare sub glConvolutionParameteriv alias "glConvolutionParameteriv" (byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glCopyConvolutionFilter1D alias "glCopyConvolutionFilter1D" (byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei)
declare sub glCopyConvolutionFilter2D alias "glCopyConvolutionFilter2D" (byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
declare sub glGetConvolutionFilter alias "glGetConvolutionFilter" (byval target as GLenum, byval format as GLenum, byval type as GLenum, byval image as GLvoid ptr)
declare sub glGetConvolutionParameterfv alias "glGetConvolutionParameterfv" (byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetConvolutionParameteriv alias "glGetConvolutionParameteriv" (byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glSeparableFilter2D alias "glSeparableFilter2D" (byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval row as GLvoid ptr, byval column as GLvoid ptr)
declare sub glGetSeparableFilter alias "glGetSeparableFilter" (byval target as GLenum, byval format as GLenum, byval type as GLenum, byval row as GLvoid ptr, byval column as GLvoid ptr, byval span as GLvoid ptr)
declare sub glActiveTexture alias "glActiveTexture" (byval texture as GLenum)
declare sub glClientActiveTexture alias "glClientActiveTexture" (byval texture as GLenum)
declare sub glCompressedTexImage1D alias "glCompressedTexImage1D" (byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as GLvoid ptr)
declare sub glCompressedTexImage2D alias "glCompressedTexImage2D" (byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as GLvoid ptr)
declare sub glCompressedTexImage3D alias "glCompressedTexImage3D" (byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as GLvoid ptr)
declare sub glCompressedTexSubImage1D alias "glCompressedTexSubImage1D" (byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as GLvoid ptr)
declare sub glCompressedTexSubImage2D alias "glCompressedTexSubImage2D" (byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as GLvoid ptr)
declare sub glCompressedTexSubImage3D alias "glCompressedTexSubImage3D" (byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as GLvoid ptr)
declare sub glGetCompressedTexImage alias "glGetCompressedTexImage" (byval target as GLenum, byval lod as GLint, byval img as GLvoid ptr)
declare sub glMultiTexCoord1d alias "glMultiTexCoord1d" (byval target as GLenum, byval s as GLdouble)
declare sub glMultiTexCoord1dv alias "glMultiTexCoord1dv" (byval target as GLenum, byval v as GLdouble ptr)
declare sub glMultiTexCoord1f alias "glMultiTexCoord1f" (byval target as GLenum, byval s as GLfloat)
declare sub glMultiTexCoord1fv alias "glMultiTexCoord1fv" (byval target as GLenum, byval v as GLfloat ptr)
declare sub glMultiTexCoord1i alias "glMultiTexCoord1i" (byval target as GLenum, byval s as GLint)
declare sub glMultiTexCoord1iv alias "glMultiTexCoord1iv" (byval target as GLenum, byval v as GLint ptr)
declare sub glMultiTexCoord1s alias "glMultiTexCoord1s" (byval target as GLenum, byval s as GLshort)
declare sub glMultiTexCoord1sv alias "glMultiTexCoord1sv" (byval target as GLenum, byval v as GLshort ptr)
declare sub glMultiTexCoord2d alias "glMultiTexCoord2d" (byval target as GLenum, byval s as GLdouble, byval t as GLdouble)
declare sub glMultiTexCoord2dv alias "glMultiTexCoord2dv" (byval target as GLenum, byval v as GLdouble ptr)
declare sub glMultiTexCoord2f alias "glMultiTexCoord2f" (byval target as GLenum, byval s as GLfloat, byval t as GLfloat)
declare sub glMultiTexCoord2fv alias "glMultiTexCoord2fv" (byval target as GLenum, byval v as GLfloat ptr)
declare sub glMultiTexCoord2i alias "glMultiTexCoord2i" (byval target as GLenum, byval s as GLint, byval t as GLint)
declare sub glMultiTexCoord2iv alias "glMultiTexCoord2iv" (byval target as GLenum, byval v as GLint ptr)
declare sub glMultiTexCoord2s alias "glMultiTexCoord2s" (byval target as GLenum, byval s as GLshort, byval t as GLshort)
declare sub glMultiTexCoord2sv alias "glMultiTexCoord2sv" (byval target as GLenum, byval v as GLshort ptr)
declare sub glMultiTexCoord3d alias "glMultiTexCoord3d" (byval target as GLenum, byval s as GLdouble, byval t as GLdouble, byval r as GLdouble)
declare sub glMultiTexCoord3dv alias "glMultiTexCoord3dv" (byval target as GLenum, byval v as GLdouble ptr)
declare sub glMultiTexCoord3f alias "glMultiTexCoord3f" (byval target as GLenum, byval s as GLfloat, byval t as GLfloat, byval r as GLfloat)
declare sub glMultiTexCoord3fv alias "glMultiTexCoord3fv" (byval target as GLenum, byval v as GLfloat ptr)
declare sub glMultiTexCoord3i alias "glMultiTexCoord3i" (byval target as GLenum, byval s as GLint, byval t as GLint, byval r as GLint)
declare sub glMultiTexCoord3iv alias "glMultiTexCoord3iv" (byval target as GLenum, byval v as GLint ptr)
declare sub glMultiTexCoord3s alias "glMultiTexCoord3s" (byval target as GLenum, byval s as GLshort, byval t as GLshort, byval r as GLshort)
declare sub glMultiTexCoord3sv alias "glMultiTexCoord3sv" (byval target as GLenum, byval v as GLshort ptr)
declare sub glMultiTexCoord4d alias "glMultiTexCoord4d" (byval target as GLenum, byval s as GLdouble, byval t as GLdouble, byval r as GLdouble, byval q as GLdouble)
declare sub glMultiTexCoord4dv alias "glMultiTexCoord4dv" (byval target as GLenum, byval v as GLdouble ptr)
declare sub glMultiTexCoord4f alias "glMultiTexCoord4f" (byval target as GLenum, byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval q as GLfloat)
declare sub glMultiTexCoord4fv alias "glMultiTexCoord4fv" (byval target as GLenum, byval v as GLfloat ptr)
declare sub glMultiTexCoord4i alias "glMultiTexCoord4i" (byval target as GLenum, byval s as GLint, byval t as GLint, byval r as GLint, byval q as GLint)
declare sub glMultiTexCoord4iv alias "glMultiTexCoord4iv" (byval target as GLenum, byval v as GLint ptr)
declare sub glMultiTexCoord4s alias "glMultiTexCoord4s" (byval target as GLenum, byval s as GLshort, byval t as GLshort, byval r as GLshort, byval q as GLshort)
declare sub glMultiTexCoord4sv alias "glMultiTexCoord4sv" (byval target as GLenum, byval v as GLshort ptr)
declare sub glLoadTransposeMatrixd alias "glLoadTransposeMatrixd" (byval m as GLdouble ptr)
declare sub glLoadTransposeMatrixf alias "glLoadTransposeMatrixf" (byval m as GLfloat ptr)
declare sub glMultTransposeMatrixd alias "glMultTransposeMatrixd" (byval m as GLdouble ptr)
declare sub glMultTransposeMatrixf alias "glMultTransposeMatrixf" (byval m as GLfloat ptr)
declare sub glSampleCoverage alias "glSampleCoverage" (byval value as GLclampf, byval invert as GLboolean)
declare sub glSamplePass alias "glSamplePass" (byval pass as GLenum)

#endif

#endif
