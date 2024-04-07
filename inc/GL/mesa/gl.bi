'' FreeBASIC binding for mesa-10.6.4
''
'' based on the C header files:
''   Mesa 3-D graphics library
''
''   Copyright (C) 1999-2006  Brian Paul   All Rights Reserved.
''   Copyright (C) 2009  VMware, Inc.  All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included
''   in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
''   OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
''   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
''   OTHER DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   FreeBASIC development team

#pragma once

#ifdef __FB_WIN32__
	#inclib "opengl32"
#elseif defined(__FB_DOS__)
	#inclib "gl"
#else
	#inclib "GL"
#endif

#ifdef __FB_WIN32__
	extern "Windows"
#else
	extern "C"
#endif

#define __gl_h_
const GL_VERSION_1_1 = 1
const GL_VERSION_1_2 = 1
const GL_VERSION_1_3 = 1
const GL_ARB_imaging = 1

type GLenum as ulong
type GLboolean as ubyte
type GLbitfield as ulong
type GLvoid as any
type GLbyte as byte
type GLshort as short
type GLint as long
type GLubyte as ubyte
type GLushort as ushort
type GLuint as ulong
type GLsizei as long
type GLfloat as single
type GLclampf as single
type GLdouble as double
type GLclampd as double

const GL_FALSE = 0
const GL_TRUE = 1
const GL_BYTE = &h1400
const GL_UNSIGNED_BYTE = &h1401
const GL_SHORT = &h1402
const GL_UNSIGNED_SHORT = &h1403
const GL_INT = &h1404
const GL_UNSIGNED_INT = &h1405
const GL_FLOAT = &h1406
const GL_2_BYTES = &h1407
const GL_3_BYTES = &h1408
const GL_4_BYTES = &h1409
const GL_DOUBLE = &h140A
const GL_POINTS = &h0000
const GL_LINES = &h0001
const GL_LINE_LOOP = &h0002
const GL_LINE_STRIP = &h0003
const GL_TRIANGLES = &h0004
const GL_TRIANGLE_STRIP = &h0005
const GL_TRIANGLE_FAN = &h0006
const GL_QUADS = &h0007
const GL_QUAD_STRIP = &h0008
const GL_POLYGON = &h0009
const GL_VERTEX_ARRAY = &h8074
const GL_NORMAL_ARRAY = &h8075
const GL_COLOR_ARRAY = &h8076
const GL_INDEX_ARRAY = &h8077
const GL_TEXTURE_COORD_ARRAY = &h8078
const GL_EDGE_FLAG_ARRAY = &h8079
const GL_VERTEX_ARRAY_SIZE = &h807A
const GL_VERTEX_ARRAY_TYPE = &h807B
const GL_VERTEX_ARRAY_STRIDE = &h807C
const GL_NORMAL_ARRAY_TYPE = &h807E
const GL_NORMAL_ARRAY_STRIDE = &h807F
const GL_COLOR_ARRAY_SIZE = &h8081
const GL_COLOR_ARRAY_TYPE = &h8082
const GL_COLOR_ARRAY_STRIDE = &h8083
const GL_INDEX_ARRAY_TYPE = &h8085
const GL_INDEX_ARRAY_STRIDE = &h8086
const GL_TEXTURE_COORD_ARRAY_SIZE = &h8088
const GL_TEXTURE_COORD_ARRAY_TYPE = &h8089
const GL_TEXTURE_COORD_ARRAY_STRIDE = &h808A
const GL_EDGE_FLAG_ARRAY_STRIDE = &h808C
const GL_VERTEX_ARRAY_POINTER = &h808E
const GL_NORMAL_ARRAY_POINTER = &h808F
const GL_COLOR_ARRAY_POINTER = &h8090
const GL_INDEX_ARRAY_POINTER = &h8091
const GL_TEXTURE_COORD_ARRAY_POINTER = &h8092
const GL_EDGE_FLAG_ARRAY_POINTER = &h8093
const GL_V2F = &h2A20
const GL_V3F = &h2A21
const GL_C4UB_V2F = &h2A22
const GL_C4UB_V3F = &h2A23
const GL_C3F_V3F = &h2A24
const GL_N3F_V3F = &h2A25
const GL_C4F_N3F_V3F = &h2A26
const GL_T2F_V3F = &h2A27
const GL_T4F_V4F = &h2A28
const GL_T2F_C4UB_V3F = &h2A29
const GL_T2F_C3F_V3F = &h2A2A
const GL_T2F_N3F_V3F = &h2A2B
const GL_T2F_C4F_N3F_V3F = &h2A2C
const GL_T4F_C4F_N3F_V4F = &h2A2D
const GL_MATRIX_MODE = &h0BA0
const GL_MODELVIEW = &h1700
const GL_PROJECTION = &h1701
const GL_TEXTURE = &h1702
const GL_POINT_SMOOTH = &h0B10
const GL_POINT_SIZE = &h0B11
const GL_POINT_SIZE_GRANULARITY = &h0B13
const GL_POINT_SIZE_RANGE = &h0B12
const GL_LINE_SMOOTH = &h0B20
const GL_LINE_STIPPLE = &h0B24
const GL_LINE_STIPPLE_PATTERN = &h0B25
const GL_LINE_STIPPLE_REPEAT = &h0B26
const GL_LINE_WIDTH = &h0B21
const GL_LINE_WIDTH_GRANULARITY = &h0B23
const GL_LINE_WIDTH_RANGE = &h0B22
const GL_POINT = &h1B00
const GL_LINE = &h1B01
const GL_FILL = &h1B02
const GL_CW = &h0900
const GL_CCW = &h0901
const GL_FRONT = &h0404
const GL_BACK = &h0405
const GL_POLYGON_MODE = &h0B40
const GL_POLYGON_SMOOTH = &h0B41
const GL_POLYGON_STIPPLE = &h0B42
const GL_EDGE_FLAG = &h0B43
const GL_CULL_FACE = &h0B44
const GL_CULL_FACE_MODE = &h0B45
const GL_FRONT_FACE = &h0B46
const GL_POLYGON_OFFSET_FACTOR = &h8038
const GL_POLYGON_OFFSET_UNITS = &h2A00
const GL_POLYGON_OFFSET_POINT = &h2A01
const GL_POLYGON_OFFSET_LINE = &h2A02
const GL_POLYGON_OFFSET_FILL = &h8037
const GL_COMPILE = &h1300
const GL_COMPILE_AND_EXECUTE = &h1301
const GL_LIST_BASE = &h0B32
const GL_LIST_INDEX = &h0B33
const GL_LIST_MODE = &h0B30
const GL_NEVER = &h0200
const GL_LESS = &h0201
const GL_EQUAL = &h0202
const GL_LEQUAL = &h0203
const GL_GREATER = &h0204
const GL_NOTEQUAL = &h0205
const GL_GEQUAL = &h0206
const GL_ALWAYS = &h0207
const GL_DEPTH_TEST = &h0B71
const GL_DEPTH_BITS = &h0D56
const GL_DEPTH_CLEAR_VALUE = &h0B73
const GL_DEPTH_FUNC = &h0B74
const GL_DEPTH_RANGE = &h0B70
const GL_DEPTH_WRITEMASK = &h0B72
const GL_DEPTH_COMPONENT = &h1902
const GL_LIGHTING = &h0B50
const GL_LIGHT0 = &h4000
const GL_LIGHT1 = &h4001
const GL_LIGHT2 = &h4002
const GL_LIGHT3 = &h4003
const GL_LIGHT4 = &h4004
const GL_LIGHT5 = &h4005
const GL_LIGHT6 = &h4006
const GL_LIGHT7 = &h4007
const GL_SPOT_EXPONENT = &h1205
const GL_SPOT_CUTOFF = &h1206
const GL_CONSTANT_ATTENUATION = &h1207
const GL_LINEAR_ATTENUATION = &h1208
const GL_QUADRATIC_ATTENUATION = &h1209
const GL_AMBIENT = &h1200
const GL_DIFFUSE = &h1201
const GL_SPECULAR = &h1202
const GL_SHININESS = &h1601
const GL_EMISSION = &h1600
const GL_POSITION = &h1203
const GL_SPOT_DIRECTION = &h1204
const GL_AMBIENT_AND_DIFFUSE = &h1602
const GL_COLOR_INDEXES = &h1603
const GL_LIGHT_MODEL_TWO_SIDE = &h0B52
const GL_LIGHT_MODEL_LOCAL_VIEWER = &h0B51
const GL_LIGHT_MODEL_AMBIENT = &h0B53
const GL_FRONT_AND_BACK = &h0408
const GL_SHADE_MODEL = &h0B54
const GL_FLAT = &h1D00
const GL_SMOOTH = &h1D01
const GL_COLOR_MATERIAL = &h0B57
const GL_COLOR_MATERIAL_FACE = &h0B55
const GL_COLOR_MATERIAL_PARAMETER = &h0B56
const GL_NORMALIZE = &h0BA1
const GL_CLIP_PLANE0 = &h3000
const GL_CLIP_PLANE1 = &h3001
const GL_CLIP_PLANE2 = &h3002
const GL_CLIP_PLANE3 = &h3003
const GL_CLIP_PLANE4 = &h3004
const GL_CLIP_PLANE5 = &h3005
const GL_ACCUM_RED_BITS = &h0D58
const GL_ACCUM_GREEN_BITS = &h0D59
const GL_ACCUM_BLUE_BITS = &h0D5A
const GL_ACCUM_ALPHA_BITS = &h0D5B
const GL_ACCUM_CLEAR_VALUE = &h0B80
const GL_ACCUM = &h0100
const GL_ADD = &h0104
const GL_LOAD = &h0101
const GL_MULT = &h0103
const GL_RETURN = &h0102
const GL_ALPHA_TEST = &h0BC0
const GL_ALPHA_TEST_REF = &h0BC2
const GL_ALPHA_TEST_FUNC = &h0BC1
const GL_BLEND = &h0BE2
const GL_BLEND_SRC = &h0BE1
const GL_BLEND_DST = &h0BE0
const GL_ZERO = 0
const GL_ONE = 1
const GL_SRC_COLOR = &h0300
const GL_ONE_MINUS_SRC_COLOR = &h0301
const GL_SRC_ALPHA = &h0302
const GL_ONE_MINUS_SRC_ALPHA = &h0303
const GL_DST_ALPHA = &h0304
const GL_ONE_MINUS_DST_ALPHA = &h0305
const GL_DST_COLOR = &h0306
const GL_ONE_MINUS_DST_COLOR = &h0307
const GL_SRC_ALPHA_SATURATE = &h0308
const GL_FEEDBACK = &h1C01
const GL_RENDER = &h1C00
const GL_SELECT = &h1C02
const GL_2D = &h0600
const GL_3D = &h0601
const GL_3D_COLOR = &h0602
const GL_3D_COLOR_TEXTURE = &h0603
const GL_4D_COLOR_TEXTURE = &h0604
const GL_POINT_TOKEN = &h0701
const GL_LINE_TOKEN = &h0702
const GL_LINE_RESET_TOKEN = &h0707
const GL_POLYGON_TOKEN = &h0703
const GL_BITMAP_TOKEN = &h0704
const GL_DRAW_PIXEL_TOKEN = &h0705
const GL_COPY_PIXEL_TOKEN = &h0706
const GL_PASS_THROUGH_TOKEN = &h0700
const GL_FEEDBACK_BUFFER_POINTER = &h0DF0
const GL_FEEDBACK_BUFFER_SIZE = &h0DF1
const GL_FEEDBACK_BUFFER_TYPE = &h0DF2
const GL_SELECTION_BUFFER_POINTER = &h0DF3
const GL_SELECTION_BUFFER_SIZE = &h0DF4
const GL_FOG = &h0B60
const GL_FOG_MODE = &h0B65
const GL_FOG_DENSITY = &h0B62
const GL_FOG_COLOR = &h0B66
const GL_FOG_INDEX = &h0B61
const GL_FOG_START = &h0B63
const GL_FOG_END = &h0B64
const GL_LINEAR = &h2601
const GL_EXP = &h0800
const GL_EXP2 = &h0801
const GL_LOGIC_OP = &h0BF1
const GL_INDEX_LOGIC_OP = &h0BF1
const GL_COLOR_LOGIC_OP = &h0BF2
const GL_LOGIC_OP_MODE = &h0BF0
const GL_CLEAR = &h1500
const GL_SET = &h150F
const GL_COPY = &h1503
const GL_COPY_INVERTED = &h150C
const GL_NOOP = &h1505
const GL_INVERT = &h150A
const GL_AND = &h1501
const GL_NAND = &h150E
const GL_OR = &h1507
const GL_NOR = &h1508
const GL_XOR = &h1506
const GL_EQUIV = &h1509
const GL_AND_REVERSE = &h1502
const GL_AND_INVERTED = &h1504
const GL_OR_REVERSE = &h150B
const GL_OR_INVERTED = &h150D
const GL_STENCIL_BITS = &h0D57
const GL_STENCIL_TEST = &h0B90
const GL_STENCIL_CLEAR_VALUE = &h0B91
const GL_STENCIL_FUNC = &h0B92
const GL_STENCIL_VALUE_MASK = &h0B93
const GL_STENCIL_FAIL = &h0B94
const GL_STENCIL_PASS_DEPTH_FAIL = &h0B95
const GL_STENCIL_PASS_DEPTH_PASS = &h0B96
const GL_STENCIL_REF = &h0B97
const GL_STENCIL_WRITEMASK = &h0B98
const GL_STENCIL_INDEX = &h1901
const GL_KEEP = &h1E00
const GL_REPLACE = &h1E01
const GL_INCR = &h1E02
const GL_DECR = &h1E03
const GL_NONE = 0
const GL_LEFT = &h0406
const GL_RIGHT = &h0407
const GL_FRONT_LEFT = &h0400
const GL_FRONT_RIGHT = &h0401
const GL_BACK_LEFT = &h0402
const GL_BACK_RIGHT = &h0403
const GL_AUX0 = &h0409
const GL_AUX1 = &h040A
const GL_AUX2 = &h040B
const GL_AUX3 = &h040C
const GL_COLOR_INDEX = &h1900
const GL_RED = &h1903
const GL_GREEN = &h1904
const GL_BLUE = &h1905
const GL_ALPHA = &h1906
const GL_LUMINANCE = &h1909
const GL_LUMINANCE_ALPHA = &h190A
const GL_ALPHA_BITS = &h0D55
const GL_RED_BITS = &h0D52
const GL_GREEN_BITS = &h0D53
const GL_BLUE_BITS = &h0D54
const GL_INDEX_BITS = &h0D51
const GL_SUBPIXEL_BITS = &h0D50
const GL_AUX_BUFFERS = &h0C00
const GL_READ_BUFFER = &h0C02
const GL_DRAW_BUFFER = &h0C01
const GL_DOUBLEBUFFER = &h0C32
const GL_STEREO = &h0C33
const GL_BITMAP = &h1A00
const GL_COLOR = &h1800
const GL_DEPTH = &h1801
const GL_STENCIL = &h1802
const GL_DITHER = &h0BD0
const GL_RGB = &h1907
const GL_RGBA = &h1908
const GL_MAX_LIST_NESTING = &h0B31
const GL_MAX_EVAL_ORDER = &h0D30
const GL_MAX_LIGHTS = &h0D31
const GL_MAX_CLIP_PLANES = &h0D32
const GL_MAX_TEXTURE_SIZE = &h0D33
const GL_MAX_PIXEL_MAP_TABLE = &h0D34
const GL_MAX_ATTRIB_STACK_DEPTH = &h0D35
const GL_MAX_MODELVIEW_STACK_DEPTH = &h0D36
const GL_MAX_NAME_STACK_DEPTH = &h0D37
const GL_MAX_PROJECTION_STACK_DEPTH = &h0D38
const GL_MAX_TEXTURE_STACK_DEPTH = &h0D39
const GL_MAX_VIEWPORT_DIMS = &h0D3A
const GL_MAX_CLIENT_ATTRIB_STACK_DEPTH = &h0D3B
const GL_ATTRIB_STACK_DEPTH = &h0BB0
const GL_CLIENT_ATTRIB_STACK_DEPTH = &h0BB1
const GL_COLOR_CLEAR_VALUE = &h0C22
const GL_COLOR_WRITEMASK = &h0C23
const GL_CURRENT_INDEX = &h0B01
const GL_CURRENT_COLOR = &h0B00
const GL_CURRENT_NORMAL = &h0B02
const GL_CURRENT_RASTER_COLOR = &h0B04
const GL_CURRENT_RASTER_DISTANCE = &h0B09
const GL_CURRENT_RASTER_INDEX = &h0B05
const GL_CURRENT_RASTER_POSITION = &h0B07
const GL_CURRENT_RASTER_TEXTURE_COORDS = &h0B06
const GL_CURRENT_RASTER_POSITION_VALID = &h0B08
const GL_CURRENT_TEXTURE_COORDS = &h0B03
const GL_INDEX_CLEAR_VALUE = &h0C20
const GL_INDEX_MODE = &h0C30
const GL_INDEX_WRITEMASK = &h0C21
const GL_MODELVIEW_MATRIX = &h0BA6
const GL_MODELVIEW_STACK_DEPTH = &h0BA3
const GL_NAME_STACK_DEPTH = &h0D70
const GL_PROJECTION_MATRIX = &h0BA7
const GL_PROJECTION_STACK_DEPTH = &h0BA4
const GL_RENDER_MODE = &h0C40
const GL_RGBA_MODE = &h0C31
const GL_TEXTURE_MATRIX = &h0BA8
const GL_TEXTURE_STACK_DEPTH = &h0BA5
const GL_VIEWPORT = &h0BA2
const GL_AUTO_NORMAL = &h0D80
const GL_MAP1_COLOR_4 = &h0D90
const GL_MAP1_INDEX = &h0D91
const GL_MAP1_NORMAL = &h0D92
const GL_MAP1_TEXTURE_COORD_1 = &h0D93
const GL_MAP1_TEXTURE_COORD_2 = &h0D94
const GL_MAP1_TEXTURE_COORD_3 = &h0D95
const GL_MAP1_TEXTURE_COORD_4 = &h0D96
const GL_MAP1_VERTEX_3 = &h0D97
const GL_MAP1_VERTEX_4 = &h0D98
const GL_MAP2_COLOR_4 = &h0DB0
const GL_MAP2_INDEX = &h0DB1
const GL_MAP2_NORMAL = &h0DB2
const GL_MAP2_TEXTURE_COORD_1 = &h0DB3
const GL_MAP2_TEXTURE_COORD_2 = &h0DB4
const GL_MAP2_TEXTURE_COORD_3 = &h0DB5
const GL_MAP2_TEXTURE_COORD_4 = &h0DB6
const GL_MAP2_VERTEX_3 = &h0DB7
const GL_MAP2_VERTEX_4 = &h0DB8
const GL_MAP1_GRID_DOMAIN = &h0DD0
const GL_MAP1_GRID_SEGMENTS = &h0DD1
const GL_MAP2_GRID_DOMAIN = &h0DD2
const GL_MAP2_GRID_SEGMENTS = &h0DD3
const GL_COEFF = &h0A00
const GL_ORDER = &h0A01
const GL_DOMAIN = &h0A02
const GL_PERSPECTIVE_CORRECTION_HINT = &h0C50
const GL_POINT_SMOOTH_HINT = &h0C51
const GL_LINE_SMOOTH_HINT = &h0C52
const GL_POLYGON_SMOOTH_HINT = &h0C53
const GL_FOG_HINT = &h0C54
const GL_DONT_CARE = &h1100
const GL_FASTEST = &h1101
const GL_NICEST = &h1102
const GL_SCISSOR_BOX = &h0C10
const GL_SCISSOR_TEST = &h0C11
const GL_MAP_COLOR = &h0D10
const GL_MAP_STENCIL = &h0D11
const GL_INDEX_SHIFT = &h0D12
const GL_INDEX_OFFSET = &h0D13
const GL_RED_SCALE = &h0D14
const GL_RED_BIAS = &h0D15
const GL_GREEN_SCALE = &h0D18
const GL_GREEN_BIAS = &h0D19
const GL_BLUE_SCALE = &h0D1A
const GL_BLUE_BIAS = &h0D1B
const GL_ALPHA_SCALE = &h0D1C
const GL_ALPHA_BIAS = &h0D1D
const GL_DEPTH_SCALE = &h0D1E
const GL_DEPTH_BIAS = &h0D1F
const GL_PIXEL_MAP_S_TO_S_SIZE = &h0CB1
const GL_PIXEL_MAP_I_TO_I_SIZE = &h0CB0
const GL_PIXEL_MAP_I_TO_R_SIZE = &h0CB2
const GL_PIXEL_MAP_I_TO_G_SIZE = &h0CB3
const GL_PIXEL_MAP_I_TO_B_SIZE = &h0CB4
const GL_PIXEL_MAP_I_TO_A_SIZE = &h0CB5
const GL_PIXEL_MAP_R_TO_R_SIZE = &h0CB6
const GL_PIXEL_MAP_G_TO_G_SIZE = &h0CB7
const GL_PIXEL_MAP_B_TO_B_SIZE = &h0CB8
const GL_PIXEL_MAP_A_TO_A_SIZE = &h0CB9
const GL_PIXEL_MAP_S_TO_S = &h0C71
const GL_PIXEL_MAP_I_TO_I = &h0C70
const GL_PIXEL_MAP_I_TO_R = &h0C72
const GL_PIXEL_MAP_I_TO_G = &h0C73
const GL_PIXEL_MAP_I_TO_B = &h0C74
const GL_PIXEL_MAP_I_TO_A = &h0C75
const GL_PIXEL_MAP_R_TO_R = &h0C76
const GL_PIXEL_MAP_G_TO_G = &h0C77
const GL_PIXEL_MAP_B_TO_B = &h0C78
const GL_PIXEL_MAP_A_TO_A = &h0C79
const GL_PACK_ALIGNMENT = &h0D05
const GL_PACK_LSB_FIRST = &h0D01
const GL_PACK_ROW_LENGTH = &h0D02
const GL_PACK_SKIP_PIXELS = &h0D04
const GL_PACK_SKIP_ROWS = &h0D03
const GL_PACK_SWAP_BYTES = &h0D00
const GL_UNPACK_ALIGNMENT = &h0CF5
const GL_UNPACK_LSB_FIRST = &h0CF1
const GL_UNPACK_ROW_LENGTH = &h0CF2
const GL_UNPACK_SKIP_PIXELS = &h0CF4
const GL_UNPACK_SKIP_ROWS = &h0CF3
const GL_UNPACK_SWAP_BYTES = &h0CF0
const GL_ZOOM_X = &h0D16
const GL_ZOOM_Y = &h0D17
const GL_TEXTURE_ENV = &h2300
const GL_TEXTURE_ENV_MODE = &h2200
const GL_TEXTURE_1D = &h0DE0
const GL_TEXTURE_2D = &h0DE1
const GL_TEXTURE_WRAP_S = &h2802
const GL_TEXTURE_WRAP_T = &h2803
const GL_TEXTURE_MAG_FILTER = &h2800
const GL_TEXTURE_MIN_FILTER = &h2801
const GL_TEXTURE_ENV_COLOR = &h2201
const GL_TEXTURE_GEN_S = &h0C60
const GL_TEXTURE_GEN_T = &h0C61
const GL_TEXTURE_GEN_R = &h0C62
const GL_TEXTURE_GEN_Q = &h0C63
const GL_TEXTURE_GEN_MODE = &h2500
const GL_TEXTURE_BORDER_COLOR = &h1004
const GL_TEXTURE_WIDTH = &h1000
const GL_TEXTURE_HEIGHT = &h1001
const GL_TEXTURE_BORDER = &h1005
const GL_TEXTURE_COMPONENTS = &h1003
const GL_TEXTURE_RED_SIZE = &h805C
const GL_TEXTURE_GREEN_SIZE = &h805D
const GL_TEXTURE_BLUE_SIZE = &h805E
const GL_TEXTURE_ALPHA_SIZE = &h805F
const GL_TEXTURE_LUMINANCE_SIZE = &h8060
const GL_TEXTURE_INTENSITY_SIZE = &h8061
const GL_NEAREST_MIPMAP_NEAREST = &h2700
const GL_NEAREST_MIPMAP_LINEAR = &h2702
const GL_LINEAR_MIPMAP_NEAREST = &h2701
const GL_LINEAR_MIPMAP_LINEAR = &h2703
const GL_OBJECT_LINEAR = &h2401
const GL_OBJECT_PLANE = &h2501
const GL_EYE_LINEAR = &h2400
const GL_EYE_PLANE = &h2502
const GL_SPHERE_MAP = &h2402
const GL_DECAL = &h2101
const GL_MODULATE = &h2100
const GL_NEAREST = &h2600
const GL_REPEAT = &h2901
const GL_CLAMP = &h2900
const GL_S = &h2000
const GL_T = &h2001
const GL_R = &h2002
const GL_Q = &h2003
const GL_VENDOR = &h1F00
const GL_RENDERER = &h1F01
const GL_VERSION = &h1F02
const GL_EXTENSIONS = &h1F03
const GL_NO_ERROR = 0
const GL_INVALID_ENUM = &h0500
const GL_INVALID_VALUE = &h0501
const GL_INVALID_OPERATION = &h0502
const GL_STACK_OVERFLOW = &h0503
const GL_STACK_UNDERFLOW = &h0504
const GL_OUT_OF_MEMORY = &h0505
const GL_CURRENT_BIT = &h00000001
const GL_POINT_BIT = &h00000002
const GL_LINE_BIT = &h00000004
const GL_POLYGON_BIT = &h00000008
const GL_POLYGON_STIPPLE_BIT = &h00000010
const GL_PIXEL_MODE_BIT = &h00000020
const GL_LIGHTING_BIT = &h00000040
const GL_FOG_BIT = &h00000080
const GL_DEPTH_BUFFER_BIT = &h00000100
const GL_ACCUM_BUFFER_BIT = &h00000200
const GL_STENCIL_BUFFER_BIT = &h00000400
const GL_VIEWPORT_BIT = &h00000800
const GL_TRANSFORM_BIT = &h00001000
const GL_ENABLE_BIT = &h00002000
const GL_COLOR_BUFFER_BIT = &h00004000
const GL_HINT_BIT = &h00008000
const GL_EVAL_BIT = &h00010000
const GL_LIST_BIT = &h00020000
const GL_TEXTURE_BIT = &h00040000
const GL_SCISSOR_BIT = &h00080000
const GL_ALL_ATTRIB_BITS = &hFFFFFFFF
const GL_PROXY_TEXTURE_1D = &h8063
const GL_PROXY_TEXTURE_2D = &h8064
const GL_TEXTURE_PRIORITY = &h8066
const GL_TEXTURE_RESIDENT = &h8067
const GL_TEXTURE_BINDING_1D = &h8068
const GL_TEXTURE_BINDING_2D = &h8069
const GL_TEXTURE_INTERNAL_FORMAT = &h1003
const GL_ALPHA4 = &h803B
const GL_ALPHA8 = &h803C
const GL_ALPHA12 = &h803D
const GL_ALPHA16 = &h803E
const GL_LUMINANCE4 = &h803F
const GL_LUMINANCE8 = &h8040
const GL_LUMINANCE12 = &h8041
const GL_LUMINANCE16 = &h8042
const GL_LUMINANCE4_ALPHA4 = &h8043
const GL_LUMINANCE6_ALPHA2 = &h8044
const GL_LUMINANCE8_ALPHA8 = &h8045
const GL_LUMINANCE12_ALPHA4 = &h8046
const GL_LUMINANCE12_ALPHA12 = &h8047
const GL_LUMINANCE16_ALPHA16 = &h8048
const GL_INTENSITY = &h8049
const GL_INTENSITY4 = &h804A
const GL_INTENSITY8 = &h804B
const GL_INTENSITY12 = &h804C
const GL_INTENSITY16 = &h804D
const GL_R3_G3_B2 = &h2A10
const GL_RGB4 = &h804F
const GL_RGB5 = &h8050
const GL_RGB8 = &h8051
const GL_RGB10 = &h8052
const GL_RGB12 = &h8053
const GL_RGB16 = &h8054
const GL_RGBA2 = &h8055
const GL_RGBA4 = &h8056
const GL_RGB5_A1 = &h8057
const GL_RGBA8 = &h8058
const GL_RGB10_A2 = &h8059
const GL_RGBA12 = &h805A
const GL_RGBA16 = &h805B
const GL_CLIENT_PIXEL_STORE_BIT = &h00000001
const GL_CLIENT_VERTEX_ARRAY_BIT = &h00000002
const GL_ALL_CLIENT_ATTRIB_BITS = &hFFFFFFFF
const GL_CLIENT_ALL_ATTRIB_BITS = &hFFFFFFFF

declare sub glClearIndex(byval c as GLfloat)
declare sub glClearColor(byval red as GLclampf, byval green as GLclampf, byval blue as GLclampf, byval alpha as GLclampf)
declare sub glClear(byval mask as GLbitfield)
declare sub glIndexMask(byval mask as GLuint)
declare sub glColorMask(byval red as GLboolean, byval green as GLboolean, byval blue as GLboolean, byval alpha as GLboolean)
declare sub glAlphaFunc(byval func as GLenum, byval ref as GLclampf)
declare sub glBlendFunc(byval sfactor as GLenum, byval dfactor as GLenum)
declare sub glLogicOp(byval opcode as GLenum)
declare sub glCullFace(byval mode as GLenum)
declare sub glFrontFace(byval mode as GLenum)
declare sub glPointSize(byval size as GLfloat)
declare sub glLineWidth(byval width as GLfloat)
declare sub glLineStipple(byval factor as GLint, byval pattern as GLushort)
declare sub glPolygonMode(byval face as GLenum, byval mode as GLenum)
declare sub glPolygonOffset(byval factor as GLfloat, byval units as GLfloat)
declare sub glPolygonStipple(byval mask as const GLubyte ptr)
declare sub glGetPolygonStipple(byval mask as GLubyte ptr)
declare sub glEdgeFlag(byval flag as GLboolean)
declare sub glEdgeFlagv(byval flag as const GLboolean ptr)
declare sub glScissor(byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
declare sub glClipPlane(byval plane as GLenum, byval equation as const GLdouble ptr)
declare sub glGetClipPlane(byval plane as GLenum, byval equation as GLdouble ptr)
declare sub glDrawBuffer(byval mode as GLenum)
declare sub glReadBuffer(byval mode as GLenum)
declare sub glEnable(byval cap as GLenum)
declare sub glDisable(byval cap as GLenum)
declare function glIsEnabled(byval cap as GLenum) as GLboolean
declare sub glEnableClientState(byval cap as GLenum)
declare sub glDisableClientState(byval cap as GLenum)
declare sub glGetBooleanv(byval pname as GLenum, byval params as GLboolean ptr)
declare sub glGetDoublev(byval pname as GLenum, byval params as GLdouble ptr)
declare sub glGetFloatv(byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetIntegerv(byval pname as GLenum, byval params as GLint ptr)
declare sub glPushAttrib(byval mask as GLbitfield)
declare sub glPopAttrib()
declare sub glPushClientAttrib(byval mask as GLbitfield)
declare sub glPopClientAttrib()
declare function glRenderMode(byval mode as GLenum) as GLint
declare function glGetError() as GLenum
declare function glGetString(byval name as GLenum) as const zstring ptr
declare sub glFinish()
declare sub glFlush()
declare sub glHint(byval target as GLenum, byval mode as GLenum)
declare sub glClearDepth(byval depth as GLclampd)
declare sub glDepthFunc(byval func as GLenum)
declare sub glDepthMask(byval flag as GLboolean)
declare sub glDepthRange(byval near_val as GLclampd, byval far_val as GLclampd)
declare sub glClearAccum(byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat, byval alpha as GLfloat)
declare sub glAccum(byval op as GLenum, byval value as GLfloat)
declare sub glMatrixMode(byval mode as GLenum)
declare sub glOrtho(byval left as GLdouble, byval right as GLdouble, byval bottom as GLdouble, byval top as GLdouble, byval near_val as GLdouble, byval far_val as GLdouble)
declare sub glFrustum(byval left as GLdouble, byval right as GLdouble, byval bottom as GLdouble, byval top as GLdouble, byval near_val as GLdouble, byval far_val as GLdouble)
declare sub glViewport(byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
declare sub glPushMatrix()
declare sub glPopMatrix()
declare sub glLoadIdentity()
declare sub glLoadMatrixd(byval m as const GLdouble ptr)
declare sub glLoadMatrixf(byval m as const GLfloat ptr)
declare sub glMultMatrixd(byval m as const GLdouble ptr)
declare sub glMultMatrixf(byval m as const GLfloat ptr)
declare sub glRotated(byval angle as GLdouble, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
declare sub glRotatef(byval angle as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
declare sub glScaled(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
declare sub glScalef(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
declare sub glTranslated(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
declare sub glTranslatef(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
declare function glIsList(byval list as GLuint) as GLboolean
declare sub glDeleteLists(byval list as GLuint, byval range as GLsizei)
declare function glGenLists(byval range as GLsizei) as GLuint
declare sub glNewList(byval list as GLuint, byval mode as GLenum)
declare sub glEndList()
declare sub glCallList(byval list as GLuint)
declare sub glCallLists(byval n as GLsizei, byval type as GLenum, byval lists as const GLvoid ptr)
declare sub glListBase(byval base as GLuint)
declare sub glBegin(byval mode as GLenum)
declare sub glEnd()
declare sub glVertex2d(byval x as GLdouble, byval y as GLdouble)
declare sub glVertex2f(byval x as GLfloat, byval y as GLfloat)
declare sub glVertex2i(byval x as GLint, byval y as GLint)
declare sub glVertex2s(byval x as GLshort, byval y as GLshort)
declare sub glVertex3d(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
declare sub glVertex3f(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
declare sub glVertex3i(byval x as GLint, byval y as GLint, byval z as GLint)
declare sub glVertex3s(byval x as GLshort, byval y as GLshort, byval z as GLshort)
declare sub glVertex4d(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
declare sub glVertex4f(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
declare sub glVertex4i(byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
declare sub glVertex4s(byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
declare sub glVertex2dv(byval v as const GLdouble ptr)
declare sub glVertex2fv(byval v as const GLfloat ptr)
declare sub glVertex2iv(byval v as const GLint ptr)
declare sub glVertex2sv(byval v as const GLshort ptr)
declare sub glVertex3dv(byval v as const GLdouble ptr)
declare sub glVertex3fv(byval v as const GLfloat ptr)
declare sub glVertex3iv(byval v as const GLint ptr)
declare sub glVertex3sv(byval v as const GLshort ptr)
declare sub glVertex4dv(byval v as const GLdouble ptr)
declare sub glVertex4fv(byval v as const GLfloat ptr)
declare sub glVertex4iv(byval v as const GLint ptr)
declare sub glVertex4sv(byval v as const GLshort ptr)
declare sub glNormal3b(byval nx as GLbyte, byval ny as GLbyte, byval nz as GLbyte)
declare sub glNormal3d(byval nx as GLdouble, byval ny as GLdouble, byval nz as GLdouble)
declare sub glNormal3f(byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat)
declare sub glNormal3i(byval nx as GLint, byval ny as GLint, byval nz as GLint)
declare sub glNormal3s(byval nx as GLshort, byval ny as GLshort, byval nz as GLshort)
declare sub glNormal3bv(byval v as const GLbyte ptr)
declare sub glNormal3dv(byval v as const GLdouble ptr)
declare sub glNormal3fv(byval v as const GLfloat ptr)
declare sub glNormal3iv(byval v as const GLint ptr)
declare sub glNormal3sv(byval v as const GLshort ptr)
declare sub glIndexd(byval c as GLdouble)
declare sub glIndexf(byval c as GLfloat)
declare sub glIndexi(byval c as GLint)
declare sub glIndexs(byval c as GLshort)
declare sub glIndexub(byval c as GLubyte)
declare sub glIndexdv(byval c as const GLdouble ptr)
declare sub glIndexfv(byval c as const GLfloat ptr)
declare sub glIndexiv(byval c as const GLint ptr)
declare sub glIndexsv(byval c as const GLshort ptr)
declare sub glIndexubv(byval c as const GLubyte ptr)
declare sub glColor3b(byval red as GLbyte, byval green as GLbyte, byval blue as GLbyte)
declare sub glColor3d(byval red as GLdouble, byval green as GLdouble, byval blue as GLdouble)
declare sub glColor3f(byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat)
declare sub glColor3i(byval red as GLint, byval green as GLint, byval blue as GLint)
declare sub glColor3s(byval red as GLshort, byval green as GLshort, byval blue as GLshort)
declare sub glColor3ub(byval red as GLubyte, byval green as GLubyte, byval blue as GLubyte)
declare sub glColor3ui(byval red as GLuint, byval green as GLuint, byval blue as GLuint)
declare sub glColor3us(byval red as GLushort, byval green as GLushort, byval blue as GLushort)
declare sub glColor4b(byval red as GLbyte, byval green as GLbyte, byval blue as GLbyte, byval alpha as GLbyte)
declare sub glColor4d(byval red as GLdouble, byval green as GLdouble, byval blue as GLdouble, byval alpha as GLdouble)
declare sub glColor4f(byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat, byval alpha as GLfloat)
declare sub glColor4i(byval red as GLint, byval green as GLint, byval blue as GLint, byval alpha as GLint)
declare sub glColor4s(byval red as GLshort, byval green as GLshort, byval blue as GLshort, byval alpha as GLshort)
declare sub glColor4ub(byval red as GLubyte, byval green as GLubyte, byval blue as GLubyte, byval alpha as GLubyte)
declare sub glColor4ui(byval red as GLuint, byval green as GLuint, byval blue as GLuint, byval alpha as GLuint)
declare sub glColor4us(byval red as GLushort, byval green as GLushort, byval blue as GLushort, byval alpha as GLushort)
declare sub glColor3bv(byval v as const GLbyte ptr)
declare sub glColor3dv(byval v as const GLdouble ptr)
declare sub glColor3fv(byval v as const GLfloat ptr)
declare sub glColor3iv(byval v as const GLint ptr)
declare sub glColor3sv(byval v as const GLshort ptr)
declare sub glColor3ubv(byval v as const GLubyte ptr)
declare sub glColor3uiv(byval v as const GLuint ptr)
declare sub glColor3usv(byval v as const GLushort ptr)
declare sub glColor4bv(byval v as const GLbyte ptr)
declare sub glColor4dv(byval v as const GLdouble ptr)
declare sub glColor4fv(byval v as const GLfloat ptr)
declare sub glColor4iv(byval v as const GLint ptr)
declare sub glColor4sv(byval v as const GLshort ptr)
declare sub glColor4ubv(byval v as const GLubyte ptr)
declare sub glColor4uiv(byval v as const GLuint ptr)
declare sub glColor4usv(byval v as const GLushort ptr)
declare sub glTexCoord1d(byval s as GLdouble)
declare sub glTexCoord1f(byval s as GLfloat)
declare sub glTexCoord1i(byval s as GLint)
declare sub glTexCoord1s(byval s as GLshort)
declare sub glTexCoord2d(byval s as GLdouble, byval t as GLdouble)
declare sub glTexCoord2f(byval s as GLfloat, byval t as GLfloat)
declare sub glTexCoord2i(byval s as GLint, byval t as GLint)
declare sub glTexCoord2s(byval s as GLshort, byval t as GLshort)
declare sub glTexCoord3d(byval s as GLdouble, byval t as GLdouble, byval r as GLdouble)
declare sub glTexCoord3f(byval s as GLfloat, byval t as GLfloat, byval r as GLfloat)
declare sub glTexCoord3i(byval s as GLint, byval t as GLint, byval r as GLint)
declare sub glTexCoord3s(byval s as GLshort, byval t as GLshort, byval r as GLshort)
declare sub glTexCoord4d(byval s as GLdouble, byval t as GLdouble, byval r as GLdouble, byval q as GLdouble)
declare sub glTexCoord4f(byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval q as GLfloat)
declare sub glTexCoord4i(byval s as GLint, byval t as GLint, byval r as GLint, byval q as GLint)
declare sub glTexCoord4s(byval s as GLshort, byval t as GLshort, byval r as GLshort, byval q as GLshort)
declare sub glTexCoord1dv(byval v as const GLdouble ptr)
declare sub glTexCoord1fv(byval v as const GLfloat ptr)
declare sub glTexCoord1iv(byval v as const GLint ptr)
declare sub glTexCoord1sv(byval v as const GLshort ptr)
declare sub glTexCoord2dv(byval v as const GLdouble ptr)
declare sub glTexCoord2fv(byval v as const GLfloat ptr)
declare sub glTexCoord2iv(byval v as const GLint ptr)
declare sub glTexCoord2sv(byval v as const GLshort ptr)
declare sub glTexCoord3dv(byval v as const GLdouble ptr)
declare sub glTexCoord3fv(byval v as const GLfloat ptr)
declare sub glTexCoord3iv(byval v as const GLint ptr)
declare sub glTexCoord3sv(byval v as const GLshort ptr)
declare sub glTexCoord4dv(byval v as const GLdouble ptr)
declare sub glTexCoord4fv(byval v as const GLfloat ptr)
declare sub glTexCoord4iv(byval v as const GLint ptr)
declare sub glTexCoord4sv(byval v as const GLshort ptr)
declare sub glRasterPos2d(byval x as GLdouble, byval y as GLdouble)
declare sub glRasterPos2f(byval x as GLfloat, byval y as GLfloat)
declare sub glRasterPos2i(byval x as GLint, byval y as GLint)
declare sub glRasterPos2s(byval x as GLshort, byval y as GLshort)
declare sub glRasterPos3d(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
declare sub glRasterPos3f(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
declare sub glRasterPos3i(byval x as GLint, byval y as GLint, byval z as GLint)
declare sub glRasterPos3s(byval x as GLshort, byval y as GLshort, byval z as GLshort)
declare sub glRasterPos4d(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
declare sub glRasterPos4f(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
declare sub glRasterPos4i(byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
declare sub glRasterPos4s(byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
declare sub glRasterPos2dv(byval v as const GLdouble ptr)
declare sub glRasterPos2fv(byval v as const GLfloat ptr)
declare sub glRasterPos2iv(byval v as const GLint ptr)
declare sub glRasterPos2sv(byval v as const GLshort ptr)
declare sub glRasterPos3dv(byval v as const GLdouble ptr)
declare sub glRasterPos3fv(byval v as const GLfloat ptr)
declare sub glRasterPos3iv(byval v as const GLint ptr)
declare sub glRasterPos3sv(byval v as const GLshort ptr)
declare sub glRasterPos4dv(byval v as const GLdouble ptr)
declare sub glRasterPos4fv(byval v as const GLfloat ptr)
declare sub glRasterPos4iv(byval v as const GLint ptr)
declare sub glRasterPos4sv(byval v as const GLshort ptr)
declare sub glRectd(byval x1 as GLdouble, byval y1 as GLdouble, byval x2 as GLdouble, byval y2 as GLdouble)
declare sub glRectf(byval x1 as GLfloat, byval y1 as GLfloat, byval x2 as GLfloat, byval y2 as GLfloat)
declare sub glRecti(byval x1 as GLint, byval y1 as GLint, byval x2 as GLint, byval y2 as GLint)
declare sub glRects(byval x1 as GLshort, byval y1 as GLshort, byval x2 as GLshort, byval y2 as GLshort)
declare sub glRectdv(byval v1 as const GLdouble ptr, byval v2 as const GLdouble ptr)
declare sub glRectfv(byval v1 as const GLfloat ptr, byval v2 as const GLfloat ptr)
declare sub glRectiv(byval v1 as const GLint ptr, byval v2 as const GLint ptr)
declare sub glRectsv(byval v1 as const GLshort ptr, byval v2 as const GLshort ptr)
declare sub glVertexPointer(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval ptr as const GLvoid ptr)
declare sub glNormalPointer(byval type as GLenum, byval stride as GLsizei, byval ptr as const GLvoid ptr)
declare sub glColorPointer(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval ptr as const GLvoid ptr)
declare sub glIndexPointer(byval type as GLenum, byval stride as GLsizei, byval ptr as const GLvoid ptr)
declare sub glTexCoordPointer(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval ptr as const GLvoid ptr)
declare sub glEdgeFlagPointer(byval stride as GLsizei, byval ptr as const GLvoid ptr)
declare sub glGetPointerv(byval pname as GLenum, byval params as GLvoid ptr ptr)
declare sub glArrayElement(byval i as GLint)
declare sub glDrawArrays(byval mode as GLenum, byval first as GLint, byval count as GLsizei)
declare sub glDrawElements(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const GLvoid ptr)
declare sub glInterleavedArrays(byval format as GLenum, byval stride as GLsizei, byval pointer as const GLvoid ptr)
declare sub glShadeModel(byval mode as GLenum)
declare sub glLightf(byval light as GLenum, byval pname as GLenum, byval param as GLfloat)
declare sub glLighti(byval light as GLenum, byval pname as GLenum, byval param as GLint)
declare sub glLightfv(byval light as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
declare sub glLightiv(byval light as GLenum, byval pname as GLenum, byval params as const GLint ptr)
declare sub glGetLightfv(byval light as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetLightiv(byval light as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glLightModelf(byval pname as GLenum, byval param as GLfloat)
declare sub glLightModeli(byval pname as GLenum, byval param as GLint)
declare sub glLightModelfv(byval pname as GLenum, byval params as const GLfloat ptr)
declare sub glLightModeliv(byval pname as GLenum, byval params as const GLint ptr)
declare sub glMaterialf(byval face as GLenum, byval pname as GLenum, byval param as GLfloat)
declare sub glMateriali(byval face as GLenum, byval pname as GLenum, byval param as GLint)
declare sub glMaterialfv(byval face as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
declare sub glMaterialiv(byval face as GLenum, byval pname as GLenum, byval params as const GLint ptr)
declare sub glGetMaterialfv(byval face as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetMaterialiv(byval face as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glColorMaterial(byval face as GLenum, byval mode as GLenum)
declare sub glPixelZoom(byval xfactor as GLfloat, byval yfactor as GLfloat)
declare sub glPixelStoref(byval pname as GLenum, byval param as GLfloat)
declare sub glPixelStorei(byval pname as GLenum, byval param as GLint)
declare sub glPixelTransferf(byval pname as GLenum, byval param as GLfloat)
declare sub glPixelTransferi(byval pname as GLenum, byval param as GLint)
declare sub glPixelMapfv(byval map as GLenum, byval mapsize as GLsizei, byval values as const GLfloat ptr)
declare sub glPixelMapuiv(byval map as GLenum, byval mapsize as GLsizei, byval values as const GLuint ptr)
declare sub glPixelMapusv(byval map as GLenum, byval mapsize as GLsizei, byval values as const GLushort ptr)
declare sub glGetPixelMapfv(byval map as GLenum, byval values as GLfloat ptr)
declare sub glGetPixelMapuiv(byval map as GLenum, byval values as GLuint ptr)
declare sub glGetPixelMapusv(byval map as GLenum, byval values as GLushort ptr)
declare sub glBitmap(byval width as GLsizei, byval height as GLsizei, byval xorig as GLfloat, byval yorig as GLfloat, byval xmove as GLfloat, byval ymove as GLfloat, byval bitmap as const GLubyte ptr)
declare sub glReadPixels(byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as GLvoid ptr)
declare sub glDrawPixels(byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const GLvoid ptr)
declare sub glCopyPixels(byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval type as GLenum)
declare sub glStencilFunc(byval func as GLenum, byval ref as GLint, byval mask as GLuint)
declare sub glStencilMask(byval mask as GLuint)
declare sub glStencilOp(byval fail as GLenum, byval zfail as GLenum, byval zpass as GLenum)
declare sub glClearStencil(byval s as GLint)
declare sub glTexGend(byval coord as GLenum, byval pname as GLenum, byval param as GLdouble)
declare sub glTexGenf(byval coord as GLenum, byval pname as GLenum, byval param as GLfloat)
declare sub glTexGeni(byval coord as GLenum, byval pname as GLenum, byval param as GLint)
declare sub glTexGendv(byval coord as GLenum, byval pname as GLenum, byval params as const GLdouble ptr)
declare sub glTexGenfv(byval coord as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
declare sub glTexGeniv(byval coord as GLenum, byval pname as GLenum, byval params as const GLint ptr)
declare sub glGetTexGendv(byval coord as GLenum, byval pname as GLenum, byval params as GLdouble ptr)
declare sub glGetTexGenfv(byval coord as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetTexGeniv(byval coord as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glTexEnvf(byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
declare sub glTexEnvi(byval target as GLenum, byval pname as GLenum, byval param as GLint)
declare sub glTexEnvfv(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
declare sub glTexEnviv(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
declare sub glGetTexEnvfv(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetTexEnviv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glTexParameterf(byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
declare sub glTexParameteri(byval target as GLenum, byval pname as GLenum, byval param as GLint)
declare sub glTexParameterfv(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
declare sub glTexParameteriv(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
declare sub glGetTexParameterfv(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetTexParameteriv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glGetTexLevelParameterfv(byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetTexLevelParameteriv(byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLint ptr)
declare sub glTexImage1D(byval target as GLenum, byval level as GLint, byval internalFormat as GLint, byval width as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const GLvoid ptr)
declare sub glTexImage2D(byval target as GLenum, byval level as GLint, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const GLvoid ptr)
declare sub glGetTexImage(byval target as GLenum, byval level as GLint, byval format as GLenum, byval type as GLenum, byval pixels as GLvoid ptr)
declare sub glGenTextures(byval n as GLsizei, byval textures as GLuint ptr)
declare sub glDeleteTextures(byval n as GLsizei, byval textures as const GLuint ptr)
declare sub glBindTexture(byval target as GLenum, byval texture as GLuint)
declare sub glPrioritizeTextures(byval n as GLsizei, byval textures as const GLuint ptr, byval priorities as const GLclampf ptr)
declare function glAreTexturesResident(byval n as GLsizei, byval textures as const GLuint ptr, byval residences as GLboolean ptr) as GLboolean
declare function glIsTexture(byval texture as GLuint) as GLboolean
declare sub glTexSubImage1D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const GLvoid ptr)
declare sub glTexSubImage2D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const GLvoid ptr)
declare sub glCopyTexImage1D(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval border as GLint)
declare sub glCopyTexImage2D(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint)
declare sub glCopyTexSubImage1D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei)
declare sub glCopyTexSubImage2D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
declare sub glMap1d(byval target as GLenum, byval u1 as GLdouble, byval u2 as GLdouble, byval stride as GLint, byval order as GLint, byval points as const GLdouble ptr)
declare sub glMap1f(byval target as GLenum, byval u1 as GLfloat, byval u2 as GLfloat, byval stride as GLint, byval order as GLint, byval points as const GLfloat ptr)
declare sub glMap2d(byval target as GLenum, byval u1 as GLdouble, byval u2 as GLdouble, byval ustride as GLint, byval uorder as GLint, byval v1 as GLdouble, byval v2 as GLdouble, byval vstride as GLint, byval vorder as GLint, byval points as const GLdouble ptr)
declare sub glMap2f(byval target as GLenum, byval u1 as GLfloat, byval u2 as GLfloat, byval ustride as GLint, byval uorder as GLint, byval v1 as GLfloat, byval v2 as GLfloat, byval vstride as GLint, byval vorder as GLint, byval points as const GLfloat ptr)
declare sub glGetMapdv(byval target as GLenum, byval query as GLenum, byval v as GLdouble ptr)
declare sub glGetMapfv(byval target as GLenum, byval query as GLenum, byval v as GLfloat ptr)
declare sub glGetMapiv(byval target as GLenum, byval query as GLenum, byval v as GLint ptr)
declare sub glEvalCoord1d(byval u as GLdouble)
declare sub glEvalCoord1f(byval u as GLfloat)
declare sub glEvalCoord1dv(byval u as const GLdouble ptr)
declare sub glEvalCoord1fv(byval u as const GLfloat ptr)
declare sub glEvalCoord2d(byval u as GLdouble, byval v as GLdouble)
declare sub glEvalCoord2f(byval u as GLfloat, byval v as GLfloat)
declare sub glEvalCoord2dv(byval u as const GLdouble ptr)
declare sub glEvalCoord2fv(byval u as const GLfloat ptr)
declare sub glMapGrid1d(byval un as GLint, byval u1 as GLdouble, byval u2 as GLdouble)
declare sub glMapGrid1f(byval un as GLint, byval u1 as GLfloat, byval u2 as GLfloat)
declare sub glMapGrid2d(byval un as GLint, byval u1 as GLdouble, byval u2 as GLdouble, byval vn as GLint, byval v1 as GLdouble, byval v2 as GLdouble)
declare sub glMapGrid2f(byval un as GLint, byval u1 as GLfloat, byval u2 as GLfloat, byval vn as GLint, byval v1 as GLfloat, byval v2 as GLfloat)
declare sub glEvalPoint1(byval i as GLint)
declare sub glEvalPoint2(byval i as GLint, byval j as GLint)
declare sub glEvalMesh1(byval mode as GLenum, byval i1 as GLint, byval i2 as GLint)
declare sub glEvalMesh2(byval mode as GLenum, byval i1 as GLint, byval i2 as GLint, byval j1 as GLint, byval j2 as GLint)
declare sub glFogf(byval pname as GLenum, byval param as GLfloat)
declare sub glFogi(byval pname as GLenum, byval param as GLint)
declare sub glFogfv(byval pname as GLenum, byval params as const GLfloat ptr)
declare sub glFogiv(byval pname as GLenum, byval params as const GLint ptr)
declare sub glFeedbackBuffer(byval size as GLsizei, byval type as GLenum, byval buffer as GLfloat ptr)
declare sub glPassThrough(byval token as GLfloat)
declare sub glSelectBuffer(byval size as GLsizei, byval buffer as GLuint ptr)
declare sub glInitNames()
declare sub glLoadName(byval name as GLuint)
declare sub glPushName(byval name as GLuint)
declare sub glPopName()

const GL_RESCALE_NORMAL = &h803A
const GL_CLAMP_TO_EDGE = &h812F
const GL_MAX_ELEMENTS_VERTICES = &h80E8
const GL_MAX_ELEMENTS_INDICES = &h80E9
const GL_BGR = &h80E0
const GL_BGRA = &h80E1
const GL_UNSIGNED_BYTE_3_3_2 = &h8032
const GL_UNSIGNED_BYTE_2_3_3_REV = &h8362
const GL_UNSIGNED_SHORT_5_6_5 = &h8363
const GL_UNSIGNED_SHORT_5_6_5_REV = &h8364
const GL_UNSIGNED_SHORT_4_4_4_4 = &h8033
const GL_UNSIGNED_SHORT_4_4_4_4_REV = &h8365
const GL_UNSIGNED_SHORT_5_5_5_1 = &h8034
const GL_UNSIGNED_SHORT_1_5_5_5_REV = &h8366
const GL_UNSIGNED_INT_8_8_8_8 = &h8035
const GL_UNSIGNED_INT_8_8_8_8_REV = &h8367
const GL_UNSIGNED_INT_10_10_10_2 = &h8036
const GL_UNSIGNED_INT_2_10_10_10_REV = &h8368
const GL_LIGHT_MODEL_COLOR_CONTROL = &h81F8
const GL_SINGLE_COLOR = &h81F9
const GL_SEPARATE_SPECULAR_COLOR = &h81FA
const GL_TEXTURE_MIN_LOD = &h813A
const GL_TEXTURE_MAX_LOD = &h813B
const GL_TEXTURE_BASE_LEVEL = &h813C
const GL_TEXTURE_MAX_LEVEL = &h813D
const GL_SMOOTH_POINT_SIZE_RANGE = &h0B12
const GL_SMOOTH_POINT_SIZE_GRANULARITY = &h0B13
const GL_SMOOTH_LINE_WIDTH_RANGE = &h0B22
const GL_SMOOTH_LINE_WIDTH_GRANULARITY = &h0B23
const GL_ALIASED_POINT_SIZE_RANGE = &h846D
const GL_ALIASED_LINE_WIDTH_RANGE = &h846E
const GL_PACK_SKIP_IMAGES = &h806B
const GL_PACK_IMAGE_HEIGHT = &h806C
const GL_UNPACK_SKIP_IMAGES = &h806D
const GL_UNPACK_IMAGE_HEIGHT = &h806E
const GL_TEXTURE_3D = &h806F
const GL_PROXY_TEXTURE_3D = &h8070
const GL_TEXTURE_DEPTH = &h8071
const GL_TEXTURE_WRAP_R = &h8072
const GL_MAX_3D_TEXTURE_SIZE = &h8073
const GL_TEXTURE_BINDING_3D = &h806A

declare sub glDrawRangeElements(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval count as GLsizei, byval type as GLenum, byval indices as const GLvoid ptr)
declare sub glTexImage3D(byval target as GLenum, byval level as GLint, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const GLvoid ptr)
declare sub glTexSubImage3D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const GLvoid ptr)
declare sub glCopyTexSubImage3D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)

type PFNGLDRAWRANGEELEMENTSPROC as sub(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval count as GLsizei, byval type as GLenum, byval indices as const GLvoid ptr)
type PFNGLTEXIMAGE3DPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const GLvoid ptr)
type PFNGLTEXSUBIMAGE3DPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const GLvoid ptr)
type PFNGLCOPYTEXSUBIMAGE3DPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)

const GL_CONSTANT_COLOR = &h8001
const GL_ONE_MINUS_CONSTANT_COLOR = &h8002
const GL_CONSTANT_ALPHA = &h8003
const GL_ONE_MINUS_CONSTANT_ALPHA = &h8004
const GL_COLOR_TABLE = &h80D0
const GL_POST_CONVOLUTION_COLOR_TABLE = &h80D1
const GL_POST_COLOR_MATRIX_COLOR_TABLE = &h80D2
const GL_PROXY_COLOR_TABLE = &h80D3
const GL_PROXY_POST_CONVOLUTION_COLOR_TABLE = &h80D4
const GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE = &h80D5
const GL_COLOR_TABLE_SCALE = &h80D6
const GL_COLOR_TABLE_BIAS = &h80D7
const GL_COLOR_TABLE_FORMAT = &h80D8
const GL_COLOR_TABLE_WIDTH = &h80D9
const GL_COLOR_TABLE_RED_SIZE = &h80DA
const GL_COLOR_TABLE_GREEN_SIZE = &h80DB
const GL_COLOR_TABLE_BLUE_SIZE = &h80DC
const GL_COLOR_TABLE_ALPHA_SIZE = &h80DD
const GL_COLOR_TABLE_LUMINANCE_SIZE = &h80DE
const GL_COLOR_TABLE_INTENSITY_SIZE = &h80DF
const GL_CONVOLUTION_1D = &h8010
const GL_CONVOLUTION_2D = &h8011
const GL_SEPARABLE_2D = &h8012
const GL_CONVOLUTION_BORDER_MODE = &h8013
const GL_CONVOLUTION_FILTER_SCALE = &h8014
const GL_CONVOLUTION_FILTER_BIAS = &h8015
const GL_REDUCE = &h8016
const GL_CONVOLUTION_FORMAT = &h8017
const GL_CONVOLUTION_WIDTH = &h8018
const GL_CONVOLUTION_HEIGHT = &h8019
const GL_MAX_CONVOLUTION_WIDTH = &h801A
const GL_MAX_CONVOLUTION_HEIGHT = &h801B
const GL_POST_CONVOLUTION_RED_SCALE = &h801C
const GL_POST_CONVOLUTION_GREEN_SCALE = &h801D
const GL_POST_CONVOLUTION_BLUE_SCALE = &h801E
const GL_POST_CONVOLUTION_ALPHA_SCALE = &h801F
const GL_POST_CONVOLUTION_RED_BIAS = &h8020
const GL_POST_CONVOLUTION_GREEN_BIAS = &h8021
const GL_POST_CONVOLUTION_BLUE_BIAS = &h8022
const GL_POST_CONVOLUTION_ALPHA_BIAS = &h8023
const GL_CONSTANT_BORDER = &h8151
const GL_REPLICATE_BORDER = &h8153
const GL_CONVOLUTION_BORDER_COLOR = &h8154
const GL_COLOR_MATRIX = &h80B1
const GL_COLOR_MATRIX_STACK_DEPTH = &h80B2
const GL_MAX_COLOR_MATRIX_STACK_DEPTH = &h80B3
const GL_POST_COLOR_MATRIX_RED_SCALE = &h80B4
const GL_POST_COLOR_MATRIX_GREEN_SCALE = &h80B5
const GL_POST_COLOR_MATRIX_BLUE_SCALE = &h80B6
const GL_POST_COLOR_MATRIX_ALPHA_SCALE = &h80B7
const GL_POST_COLOR_MATRIX_RED_BIAS = &h80B8
const GL_POST_COLOR_MATRIX_GREEN_BIAS = &h80B9
const GL_POST_COLOR_MATRIX_BLUE_BIAS = &h80BA
const GL_POST_COLOR_MATRIX_ALPHA_BIAS = &h80BB
const GL_HISTOGRAM = &h8024
const GL_PROXY_HISTOGRAM = &h8025
const GL_HISTOGRAM_WIDTH = &h8026
const GL_HISTOGRAM_FORMAT = &h8027
const GL_HISTOGRAM_RED_SIZE = &h8028
const GL_HISTOGRAM_GREEN_SIZE = &h8029
const GL_HISTOGRAM_BLUE_SIZE = &h802A
const GL_HISTOGRAM_ALPHA_SIZE = &h802B
const GL_HISTOGRAM_LUMINANCE_SIZE = &h802C
const GL_HISTOGRAM_SINK = &h802D
const GL_MINMAX = &h802E
const GL_MINMAX_FORMAT = &h802F
const GL_MINMAX_SINK = &h8030
const GL_TABLE_TOO_LARGE = &h8031
const GL_BLEND_EQUATION = &h8009
const GL_MIN = &h8007
const GL_MAX = &h8008
const GL_FUNC_ADD = &h8006
const GL_FUNC_SUBTRACT = &h800A
const GL_FUNC_REVERSE_SUBTRACT = &h800B
const GL_BLEND_COLOR = &h8005

declare sub glColorTable(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval table as const GLvoid ptr)
declare sub glColorSubTable(byval target as GLenum, byval start as GLsizei, byval count as GLsizei, byval format as GLenum, byval type as GLenum, byval data as const GLvoid ptr)
declare sub glColorTableParameteriv(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
declare sub glColorTableParameterfv(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
declare sub glCopyColorSubTable(byval target as GLenum, byval start as GLsizei, byval x as GLint, byval y as GLint, byval width as GLsizei)
declare sub glCopyColorTable(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei)
declare sub glGetColorTable(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval table as GLvoid ptr)
declare sub glGetColorTableParameterfv(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetColorTableParameteriv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glBlendEquation(byval mode as GLenum)
declare sub glBlendColor(byval red as GLclampf, byval green as GLclampf, byval blue as GLclampf, byval alpha as GLclampf)
declare sub glHistogram(byval target as GLenum, byval width as GLsizei, byval internalformat as GLenum, byval sink as GLboolean)
declare sub glResetHistogram(byval target as GLenum)
declare sub glGetHistogram(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval values as GLvoid ptr)
declare sub glGetHistogramParameterfv(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetHistogramParameteriv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glMinmax(byval target as GLenum, byval internalformat as GLenum, byval sink as GLboolean)
declare sub glResetMinmax(byval target as GLenum)
declare sub glGetMinmax(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval types as GLenum, byval values as GLvoid ptr)
declare sub glGetMinmaxParameterfv(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetMinmaxParameteriv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glConvolutionFilter1D(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval image as const GLvoid ptr)
declare sub glConvolutionFilter2D(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval image as const GLvoid ptr)
declare sub glConvolutionParameterf(byval target as GLenum, byval pname as GLenum, byval params as GLfloat)
declare sub glConvolutionParameterfv(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
declare sub glConvolutionParameteri(byval target as GLenum, byval pname as GLenum, byval params as GLint)
declare sub glConvolutionParameteriv(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
declare sub glCopyConvolutionFilter1D(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei)
declare sub glCopyConvolutionFilter2D(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
declare sub glGetConvolutionFilter(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval image as GLvoid ptr)
declare sub glGetConvolutionParameterfv(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
declare sub glGetConvolutionParameteriv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
declare sub glSeparableFilter2D(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval row as const GLvoid ptr, byval column as const GLvoid ptr)
declare sub glGetSeparableFilter(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval row as GLvoid ptr, byval column as GLvoid ptr, byval span as GLvoid ptr)

const GL_TEXTURE0 = &h84C0
const GL_TEXTURE1 = &h84C1
const GL_TEXTURE2 = &h84C2
const GL_TEXTURE3 = &h84C3
const GL_TEXTURE4 = &h84C4
const GL_TEXTURE5 = &h84C5
const GL_TEXTURE6 = &h84C6
const GL_TEXTURE7 = &h84C7
const GL_TEXTURE8 = &h84C8
const GL_TEXTURE9 = &h84C9
const GL_TEXTURE10 = &h84CA
const GL_TEXTURE11 = &h84CB
const GL_TEXTURE12 = &h84CC
const GL_TEXTURE13 = &h84CD
const GL_TEXTURE14 = &h84CE
const GL_TEXTURE15 = &h84CF
const GL_TEXTURE16 = &h84D0
const GL_TEXTURE17 = &h84D1
const GL_TEXTURE18 = &h84D2
const GL_TEXTURE19 = &h84D3
const GL_TEXTURE20 = &h84D4
const GL_TEXTURE21 = &h84D5
const GL_TEXTURE22 = &h84D6
const GL_TEXTURE23 = &h84D7
const GL_TEXTURE24 = &h84D8
const GL_TEXTURE25 = &h84D9
const GL_TEXTURE26 = &h84DA
const GL_TEXTURE27 = &h84DB
const GL_TEXTURE28 = &h84DC
const GL_TEXTURE29 = &h84DD
const GL_TEXTURE30 = &h84DE
const GL_TEXTURE31 = &h84DF
const GL_ACTIVE_TEXTURE = &h84E0
const GL_CLIENT_ACTIVE_TEXTURE = &h84E1
const GL_MAX_TEXTURE_UNITS = &h84E2
const GL_NORMAL_MAP = &h8511
const GL_REFLECTION_MAP = &h8512
const GL_TEXTURE_CUBE_MAP = &h8513
const GL_TEXTURE_BINDING_CUBE_MAP = &h8514
const GL_TEXTURE_CUBE_MAP_POSITIVE_X = &h8515
const GL_TEXTURE_CUBE_MAP_NEGATIVE_X = &h8516
const GL_TEXTURE_CUBE_MAP_POSITIVE_Y = &h8517
const GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = &h8518
const GL_TEXTURE_CUBE_MAP_POSITIVE_Z = &h8519
const GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = &h851A
const GL_PROXY_TEXTURE_CUBE_MAP = &h851B
const GL_MAX_CUBE_MAP_TEXTURE_SIZE = &h851C
const GL_COMPRESSED_ALPHA = &h84E9
const GL_COMPRESSED_LUMINANCE = &h84EA
const GL_COMPRESSED_LUMINANCE_ALPHA = &h84EB
const GL_COMPRESSED_INTENSITY = &h84EC
const GL_COMPRESSED_RGB = &h84ED
const GL_COMPRESSED_RGBA = &h84EE
const GL_TEXTURE_COMPRESSION_HINT = &h84EF
const GL_TEXTURE_COMPRESSED_IMAGE_SIZE = &h86A0
const GL_TEXTURE_COMPRESSED = &h86A1
const GL_NUM_COMPRESSED_TEXTURE_FORMATS = &h86A2
const GL_COMPRESSED_TEXTURE_FORMATS = &h86A3
const GL_MULTISAMPLE = &h809D
const GL_SAMPLE_ALPHA_TO_COVERAGE = &h809E
const GL_SAMPLE_ALPHA_TO_ONE = &h809F
const GL_SAMPLE_COVERAGE = &h80A0
const GL_SAMPLE_BUFFERS = &h80A8
const GL_SAMPLES = &h80A9
const GL_SAMPLE_COVERAGE_VALUE = &h80AA
const GL_SAMPLE_COVERAGE_INVERT = &h80AB
const GL_MULTISAMPLE_BIT = &h20000000
const GL_TRANSPOSE_MODELVIEW_MATRIX = &h84E3
const GL_TRANSPOSE_PROJECTION_MATRIX = &h84E4
const GL_TRANSPOSE_TEXTURE_MATRIX = &h84E5
const GL_TRANSPOSE_COLOR_MATRIX = &h84E6
const GL_COMBINE = &h8570
const GL_COMBINE_RGB = &h8571
const GL_COMBINE_ALPHA = &h8572
const GL_SOURCE0_RGB = &h8580
const GL_SOURCE1_RGB = &h8581
const GL_SOURCE2_RGB = &h8582
const GL_SOURCE0_ALPHA = &h8588
const GL_SOURCE1_ALPHA = &h8589
const GL_SOURCE2_ALPHA = &h858A
const GL_OPERAND0_RGB = &h8590
const GL_OPERAND1_RGB = &h8591
const GL_OPERAND2_RGB = &h8592
const GL_OPERAND0_ALPHA = &h8598
const GL_OPERAND1_ALPHA = &h8599
const GL_OPERAND2_ALPHA = &h859A
const GL_RGB_SCALE = &h8573
const GL_ADD_SIGNED = &h8574
const GL_INTERPOLATE = &h8575
const GL_SUBTRACT = &h84E7
const GL_CONSTANT = &h8576
const GL_PRIMARY_COLOR = &h8577
const GL_PREVIOUS = &h8578
const GL_DOT3_RGB = &h86AE
const GL_DOT3_RGBA = &h86AF
const GL_CLAMP_TO_BORDER = &h812D

declare sub glActiveTexture(byval texture as GLenum)
declare sub glClientActiveTexture(byval texture as GLenum)
declare sub glCompressedTexImage1D(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const GLvoid ptr)
declare sub glCompressedTexImage2D(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const GLvoid ptr)
declare sub glCompressedTexImage3D(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const GLvoid ptr)
declare sub glCompressedTexSubImage1D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const GLvoid ptr)
declare sub glCompressedTexSubImage2D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const GLvoid ptr)
declare sub glCompressedTexSubImage3D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const GLvoid ptr)
declare sub glGetCompressedTexImage(byval target as GLenum, byval lod as GLint, byval img as GLvoid ptr)
declare sub glMultiTexCoord1d(byval target as GLenum, byval s as GLdouble)
declare sub glMultiTexCoord1dv(byval target as GLenum, byval v as const GLdouble ptr)
declare sub glMultiTexCoord1f(byval target as GLenum, byval s as GLfloat)
declare sub glMultiTexCoord1fv(byval target as GLenum, byval v as const GLfloat ptr)
declare sub glMultiTexCoord1i(byval target as GLenum, byval s as GLint)
declare sub glMultiTexCoord1iv(byval target as GLenum, byval v as const GLint ptr)
declare sub glMultiTexCoord1s(byval target as GLenum, byval s as GLshort)
declare sub glMultiTexCoord1sv(byval target as GLenum, byval v as const GLshort ptr)
declare sub glMultiTexCoord2d(byval target as GLenum, byval s as GLdouble, byval t as GLdouble)
declare sub glMultiTexCoord2dv(byval target as GLenum, byval v as const GLdouble ptr)
declare sub glMultiTexCoord2f(byval target as GLenum, byval s as GLfloat, byval t as GLfloat)
declare sub glMultiTexCoord2fv(byval target as GLenum, byval v as const GLfloat ptr)
declare sub glMultiTexCoord2i(byval target as GLenum, byval s as GLint, byval t as GLint)
declare sub glMultiTexCoord2iv(byval target as GLenum, byval v as const GLint ptr)
declare sub glMultiTexCoord2s(byval target as GLenum, byval s as GLshort, byval t as GLshort)
declare sub glMultiTexCoord2sv(byval target as GLenum, byval v as const GLshort ptr)
declare sub glMultiTexCoord3d(byval target as GLenum, byval s as GLdouble, byval t as GLdouble, byval r as GLdouble)
declare sub glMultiTexCoord3dv(byval target as GLenum, byval v as const GLdouble ptr)
declare sub glMultiTexCoord3f(byval target as GLenum, byval s as GLfloat, byval t as GLfloat, byval r as GLfloat)
declare sub glMultiTexCoord3fv(byval target as GLenum, byval v as const GLfloat ptr)
declare sub glMultiTexCoord3i(byval target as GLenum, byval s as GLint, byval t as GLint, byval r as GLint)
declare sub glMultiTexCoord3iv(byval target as GLenum, byval v as const GLint ptr)
declare sub glMultiTexCoord3s(byval target as GLenum, byval s as GLshort, byval t as GLshort, byval r as GLshort)
declare sub glMultiTexCoord3sv(byval target as GLenum, byval v as const GLshort ptr)
declare sub glMultiTexCoord4d(byval target as GLenum, byval s as GLdouble, byval t as GLdouble, byval r as GLdouble, byval q as GLdouble)
declare sub glMultiTexCoord4dv(byval target as GLenum, byval v as const GLdouble ptr)
declare sub glMultiTexCoord4f(byval target as GLenum, byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval q as GLfloat)
declare sub glMultiTexCoord4fv(byval target as GLenum, byval v as const GLfloat ptr)
declare sub glMultiTexCoord4i(byval target as GLenum, byval s as GLint, byval t as GLint, byval r as GLint, byval q as GLint)
declare sub glMultiTexCoord4iv(byval target as GLenum, byval v as const GLint ptr)
declare sub glMultiTexCoord4s(byval target as GLenum, byval s as GLshort, byval t as GLshort, byval r as GLshort, byval q as GLshort)
declare sub glMultiTexCoord4sv(byval target as GLenum, byval v as const GLshort ptr)
declare sub glLoadTransposeMatrixd(byval m as const GLdouble ptr)
declare sub glLoadTransposeMatrixf(byval m as const GLfloat ptr)
declare sub glMultTransposeMatrixd(byval m as const GLdouble ptr)
declare sub glMultTransposeMatrixf(byval m as const GLfloat ptr)
declare sub glSampleCoverage(byval value as GLclampf, byval invert as GLboolean)

type PFNGLACTIVETEXTUREPROC as sub(byval texture as GLenum)
type PFNGLSAMPLECOVERAGEPROC as sub(byval value as GLclampf, byval invert as GLboolean)
type PFNGLCOMPRESSEDTEXIMAGE3DPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const GLvoid ptr)
type PFNGLCOMPRESSEDTEXIMAGE2DPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const GLvoid ptr)
type PFNGLCOMPRESSEDTEXIMAGE1DPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const GLvoid ptr)
type PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const GLvoid ptr)
type PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const GLvoid ptr)
type PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const GLvoid ptr)
type PFNGLGETCOMPRESSEDTEXIMAGEPROC as sub(byval target as GLenum, byval level as GLint, byval img as GLvoid ptr)

const GL_ARB_multitexture = 1
const GL_TEXTURE0_ARB = &h84C0
const GL_TEXTURE1_ARB = &h84C1
const GL_TEXTURE2_ARB = &h84C2
const GL_TEXTURE3_ARB = &h84C3
const GL_TEXTURE4_ARB = &h84C4
const GL_TEXTURE5_ARB = &h84C5
const GL_TEXTURE6_ARB = &h84C6
const GL_TEXTURE7_ARB = &h84C7
const GL_TEXTURE8_ARB = &h84C8
const GL_TEXTURE9_ARB = &h84C9
const GL_TEXTURE10_ARB = &h84CA
const GL_TEXTURE11_ARB = &h84CB
const GL_TEXTURE12_ARB = &h84CC
const GL_TEXTURE13_ARB = &h84CD
const GL_TEXTURE14_ARB = &h84CE
const GL_TEXTURE15_ARB = &h84CF
const GL_TEXTURE16_ARB = &h84D0
const GL_TEXTURE17_ARB = &h84D1
const GL_TEXTURE18_ARB = &h84D2
const GL_TEXTURE19_ARB = &h84D3
const GL_TEXTURE20_ARB = &h84D4
const GL_TEXTURE21_ARB = &h84D5
const GL_TEXTURE22_ARB = &h84D6
const GL_TEXTURE23_ARB = &h84D7
const GL_TEXTURE24_ARB = &h84D8
const GL_TEXTURE25_ARB = &h84D9
const GL_TEXTURE26_ARB = &h84DA
const GL_TEXTURE27_ARB = &h84DB
const GL_TEXTURE28_ARB = &h84DC
const GL_TEXTURE29_ARB = &h84DD
const GL_TEXTURE30_ARB = &h84DE
const GL_TEXTURE31_ARB = &h84DF
const GL_ACTIVE_TEXTURE_ARB = &h84E0
const GL_CLIENT_ACTIVE_TEXTURE_ARB = &h84E1
const GL_MAX_TEXTURE_UNITS_ARB = &h84E2

declare sub glActiveTextureARB(byval texture as GLenum)
declare sub glClientActiveTextureARB(byval texture as GLenum)
declare sub glMultiTexCoord1dARB(byval target as GLenum, byval s as GLdouble)
declare sub glMultiTexCoord1dvARB(byval target as GLenum, byval v as const GLdouble ptr)
declare sub glMultiTexCoord1fARB(byval target as GLenum, byval s as GLfloat)
declare sub glMultiTexCoord1fvARB(byval target as GLenum, byval v as const GLfloat ptr)
declare sub glMultiTexCoord1iARB(byval target as GLenum, byval s as GLint)
declare sub glMultiTexCoord1ivARB(byval target as GLenum, byval v as const GLint ptr)
declare sub glMultiTexCoord1sARB(byval target as GLenum, byval s as GLshort)
declare sub glMultiTexCoord1svARB(byval target as GLenum, byval v as const GLshort ptr)
declare sub glMultiTexCoord2dARB(byval target as GLenum, byval s as GLdouble, byval t as GLdouble)
declare sub glMultiTexCoord2dvARB(byval target as GLenum, byval v as const GLdouble ptr)
declare sub glMultiTexCoord2fARB(byval target as GLenum, byval s as GLfloat, byval t as GLfloat)
declare sub glMultiTexCoord2fvARB(byval target as GLenum, byval v as const GLfloat ptr)
declare sub glMultiTexCoord2iARB(byval target as GLenum, byval s as GLint, byval t as GLint)
declare sub glMultiTexCoord2ivARB(byval target as GLenum, byval v as const GLint ptr)
declare sub glMultiTexCoord2sARB(byval target as GLenum, byval s as GLshort, byval t as GLshort)
declare sub glMultiTexCoord2svARB(byval target as GLenum, byval v as const GLshort ptr)
declare sub glMultiTexCoord3dARB(byval target as GLenum, byval s as GLdouble, byval t as GLdouble, byval r as GLdouble)
declare sub glMultiTexCoord3dvARB(byval target as GLenum, byval v as const GLdouble ptr)
declare sub glMultiTexCoord3fARB(byval target as GLenum, byval s as GLfloat, byval t as GLfloat, byval r as GLfloat)
declare sub glMultiTexCoord3fvARB(byval target as GLenum, byval v as const GLfloat ptr)
declare sub glMultiTexCoord3iARB(byval target as GLenum, byval s as GLint, byval t as GLint, byval r as GLint)
declare sub glMultiTexCoord3ivARB(byval target as GLenum, byval v as const GLint ptr)
declare sub glMultiTexCoord3sARB(byval target as GLenum, byval s as GLshort, byval t as GLshort, byval r as GLshort)
declare sub glMultiTexCoord3svARB(byval target as GLenum, byval v as const GLshort ptr)
declare sub glMultiTexCoord4dARB(byval target as GLenum, byval s as GLdouble, byval t as GLdouble, byval r as GLdouble, byval q as GLdouble)
declare sub glMultiTexCoord4dvARB(byval target as GLenum, byval v as const GLdouble ptr)
declare sub glMultiTexCoord4fARB(byval target as GLenum, byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval q as GLfloat)
declare sub glMultiTexCoord4fvARB(byval target as GLenum, byval v as const GLfloat ptr)
declare sub glMultiTexCoord4iARB(byval target as GLenum, byval s as GLint, byval t as GLint, byval r as GLint, byval q as GLint)
declare sub glMultiTexCoord4ivARB(byval target as GLenum, byval v as const GLint ptr)
declare sub glMultiTexCoord4sARB(byval target as GLenum, byval s as GLshort, byval t as GLshort, byval r as GLshort, byval q as GLshort)
declare sub glMultiTexCoord4svARB(byval target as GLenum, byval v as const GLshort ptr)

type PFNGLACTIVETEXTUREARBPROC as sub(byval texture as GLenum)
type PFNGLCLIENTACTIVETEXTUREARBPROC as sub(byval texture as GLenum)
type PFNGLMULTITEXCOORD1DARBPROC as sub(byval target as GLenum, byval s as GLdouble)
type PFNGLMULTITEXCOORD1DVARBPROC as sub(byval target as GLenum, byval v as const GLdouble ptr)
type PFNGLMULTITEXCOORD1FARBPROC as sub(byval target as GLenum, byval s as GLfloat)
type PFNGLMULTITEXCOORD1FVARBPROC as sub(byval target as GLenum, byval v as const GLfloat ptr)
type PFNGLMULTITEXCOORD1IARBPROC as sub(byval target as GLenum, byval s as GLint)
type PFNGLMULTITEXCOORD1IVARBPROC as sub(byval target as GLenum, byval v as const GLint ptr)
type PFNGLMULTITEXCOORD1SARBPROC as sub(byval target as GLenum, byval s as GLshort)
type PFNGLMULTITEXCOORD1SVARBPROC as sub(byval target as GLenum, byval v as const GLshort ptr)
type PFNGLMULTITEXCOORD2DARBPROC as sub(byval target as GLenum, byval s as GLdouble, byval t as GLdouble)
type PFNGLMULTITEXCOORD2DVARBPROC as sub(byval target as GLenum, byval v as const GLdouble ptr)
type PFNGLMULTITEXCOORD2FARBPROC as sub(byval target as GLenum, byval s as GLfloat, byval t as GLfloat)
type PFNGLMULTITEXCOORD2FVARBPROC as sub(byval target as GLenum, byval v as const GLfloat ptr)
type PFNGLMULTITEXCOORD2IARBPROC as sub(byval target as GLenum, byval s as GLint, byval t as GLint)
type PFNGLMULTITEXCOORD2IVARBPROC as sub(byval target as GLenum, byval v as const GLint ptr)
type PFNGLMULTITEXCOORD2SARBPROC as sub(byval target as GLenum, byval s as GLshort, byval t as GLshort)
type PFNGLMULTITEXCOORD2SVARBPROC as sub(byval target as GLenum, byval v as const GLshort ptr)
type PFNGLMULTITEXCOORD3DARBPROC as sub(byval target as GLenum, byval s as GLdouble, byval t as GLdouble, byval r as GLdouble)
type PFNGLMULTITEXCOORD3DVARBPROC as sub(byval target as GLenum, byval v as const GLdouble ptr)
type PFNGLMULTITEXCOORD3FARBPROC as sub(byval target as GLenum, byval s as GLfloat, byval t as GLfloat, byval r as GLfloat)
type PFNGLMULTITEXCOORD3FVARBPROC as sub(byval target as GLenum, byval v as const GLfloat ptr)
type PFNGLMULTITEXCOORD3IARBPROC as sub(byval target as GLenum, byval s as GLint, byval t as GLint, byval r as GLint)
type PFNGLMULTITEXCOORD3IVARBPROC as sub(byval target as GLenum, byval v as const GLint ptr)
type PFNGLMULTITEXCOORD3SARBPROC as sub(byval target as GLenum, byval s as GLshort, byval t as GLshort, byval r as GLshort)
type PFNGLMULTITEXCOORD3SVARBPROC as sub(byval target as GLenum, byval v as const GLshort ptr)
type PFNGLMULTITEXCOORD4DARBPROC as sub(byval target as GLenum, byval s as GLdouble, byval t as GLdouble, byval r as GLdouble, byval q as GLdouble)
type PFNGLMULTITEXCOORD4DVARBPROC as sub(byval target as GLenum, byval v as const GLdouble ptr)
type PFNGLMULTITEXCOORD4FARBPROC as sub(byval target as GLenum, byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval q as GLfloat)
type PFNGLMULTITEXCOORD4FVARBPROC as sub(byval target as GLenum, byval v as const GLfloat ptr)
type PFNGLMULTITEXCOORD4IARBPROC as sub(byval target as GLenum, byval s as GLint, byval t as GLint, byval r as GLint, byval q as GLint)
type PFNGLMULTITEXCOORD4IVARBPROC as sub(byval target as GLenum, byval v as const GLint ptr)
type PFNGLMULTITEXCOORD4SARBPROC as sub(byval target as GLenum, byval s as GLshort, byval t as GLshort, byval r as GLshort, byval q as GLshort)
type PFNGLMULTITEXCOORD4SVARBPROC as sub(byval target as GLenum, byval v as const GLshort ptr)

#ifndef GL_GLEXT_LEGACY
	#include once "GL/mesa/glext.bi"
#endif

const GL_MESA_packed_depth_stencil = 1
const GL_DEPTH_STENCIL_MESA = &h8750
const GL_UNSIGNED_INT_24_8_MESA = &h8751
const GL_UNSIGNED_INT_8_24_REV_MESA = &h8752
const GL_UNSIGNED_SHORT_15_1_MESA = &h8753
const GL_UNSIGNED_SHORT_1_15_REV_MESA = &h8754
const GL_ATI_blend_equation_separate = 1
const GL_ALPHA_BLEND_EQUATION_ATI = &h883D
declare sub glBlendEquationSeparateATI(byval modeRGB as GLenum, byval modeA as GLenum)
type PFNGLBLENDEQUATIONSEPARATEATIPROC as sub(byval modeRGB as GLenum, byval modeA as GLenum)
type GLeglImageOES as any ptr
const GL_OES_EGL_image = 1

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glEGLImageTargetTexture2DOES(byval target as GLenum, byval image as GLeglImageOES)
	declare sub glEGLImageTargetRenderbufferStorageOES(byval target as GLenum, byval image as GLeglImageOES)
#endif

type PFNGLEGLIMAGETARGETTEXTURE2DOESPROC as sub(byval target as GLenum, byval image as GLeglImageOES)
type PFNGLEGLIMAGETARGETRENDERBUFFERSTORAGEOESPROC as sub(byval target as GLenum, byval image as GLeglImageOES)

end extern
