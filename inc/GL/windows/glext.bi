'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (c) 2013-2014 The Khronos Group Inc.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and/or associated documentation files (the
''   "Materials"), to deal in the Materials without restriction, including
''   without limitation the rights to use, copy, modify, merge, publish,
''   distribute, sublicense, and/or sell copies of the Materials, and to
''   permit persons to whom the Materials are furnished to do so, subject to
''   the following conditions:
''
''   The above copyright notice and this permission notice shall be included
''   in all copies or substantial portions of the Materials.
''
''   THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
''   MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "GL/windows/gl.bi"

extern "Windows"

const __glext_h_ = 1
const GL_GLEXT_VERSION = 20150104
const GL_VERSION_1_2 = 1
const GL_UNSIGNED_BYTE_3_3_2 = &h8032
const GL_UNSIGNED_SHORT_4_4_4_4 = &h8033
const GL_UNSIGNED_SHORT_5_5_5_1 = &h8034
const GL_UNSIGNED_INT_8_8_8_8 = &h8035
const GL_UNSIGNED_INT_10_10_10_2 = &h8036
const GL_TEXTURE_BINDING_3D = &h806A
const GL_PACK_SKIP_IMAGES = &h806B
const GL_PACK_IMAGE_HEIGHT = &h806C
const GL_UNPACK_SKIP_IMAGES = &h806D
const GL_UNPACK_IMAGE_HEIGHT = &h806E
const GL_TEXTURE_3D = &h806F
const GL_PROXY_TEXTURE_3D = &h8070
const GL_TEXTURE_DEPTH = &h8071
const GL_TEXTURE_WRAP_R = &h8072
const GL_MAX_3D_TEXTURE_SIZE = &h8073
const GL_UNSIGNED_BYTE_2_3_3_REV = &h8362
const GL_UNSIGNED_SHORT_5_6_5 = &h8363
const GL_UNSIGNED_SHORT_5_6_5_REV = &h8364
const GL_UNSIGNED_SHORT_4_4_4_4_REV = &h8365
const GL_UNSIGNED_SHORT_1_5_5_5_REV = &h8366
const GL_UNSIGNED_INT_8_8_8_8_REV = &h8367
const GL_UNSIGNED_INT_2_10_10_10_REV = &h8368
const GL_BGR = &h80E0
const GL_BGRA = &h80E1
const GL_MAX_ELEMENTS_VERTICES = &h80E8
const GL_MAX_ELEMENTS_INDICES = &h80E9
const GL_CLAMP_TO_EDGE = &h812F
const GL_TEXTURE_MIN_LOD = &h813A
const GL_TEXTURE_MAX_LOD = &h813B
const GL_TEXTURE_BASE_LEVEL = &h813C
const GL_TEXTURE_MAX_LEVEL = &h813D
const GL_SMOOTH_POINT_SIZE_RANGE = &h0B12
const GL_SMOOTH_POINT_SIZE_GRANULARITY = &h0B13
const GL_SMOOTH_LINE_WIDTH_RANGE = &h0B22
const GL_SMOOTH_LINE_WIDTH_GRANULARITY = &h0B23
const GL_ALIASED_LINE_WIDTH_RANGE = &h846E
const GL_RESCALE_NORMAL = &h803A
const GL_LIGHT_MODEL_COLOR_CONTROL = &h81F8
const GL_SINGLE_COLOR = &h81F9
const GL_SEPARATE_SPECULAR_COLOR = &h81FA
const GL_ALIASED_POINT_SIZE_RANGE = &h846D

type PFNGLDRAWRANGEELEMENTSPROC as sub(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr)
type PFNGLTEXIMAGE3DPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLTEXSUBIMAGE3DPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLCOPYTEXSUBIMAGE3DPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDrawRangeElements(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr)
	declare sub glTexImage3D(byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glTexSubImage3D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glCopyTexSubImage3D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
#endif

const GL_VERSION_1_3 = 1
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
const GL_MULTISAMPLE = &h809D
const GL_SAMPLE_ALPHA_TO_COVERAGE = &h809E
const GL_SAMPLE_ALPHA_TO_ONE = &h809F
const GL_SAMPLE_COVERAGE = &h80A0
const GL_SAMPLE_BUFFERS = &h80A8
const GL_SAMPLES = &h80A9
const GL_SAMPLE_COVERAGE_VALUE = &h80AA
const GL_SAMPLE_COVERAGE_INVERT = &h80AB
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
const GL_COMPRESSED_RGB = &h84ED
const GL_COMPRESSED_RGBA = &h84EE
const GL_TEXTURE_COMPRESSION_HINT = &h84EF
const GL_TEXTURE_COMPRESSED_IMAGE_SIZE = &h86A0
const GL_TEXTURE_COMPRESSED = &h86A1
const GL_NUM_COMPRESSED_TEXTURE_FORMATS = &h86A2
const GL_COMPRESSED_TEXTURE_FORMATS = &h86A3
const GL_CLAMP_TO_BORDER = &h812D
const GL_CLIENT_ACTIVE_TEXTURE = &h84E1
const GL_MAX_TEXTURE_UNITS = &h84E2
const GL_TRANSPOSE_MODELVIEW_MATRIX = &h84E3
const GL_TRANSPOSE_PROJECTION_MATRIX = &h84E4
const GL_TRANSPOSE_TEXTURE_MATRIX = &h84E5
const GL_TRANSPOSE_COLOR_MATRIX = &h84E6
const GL_MULTISAMPLE_BIT = &h20000000
const GL_NORMAL_MAP = &h8511
const GL_REFLECTION_MAP = &h8512
const GL_COMPRESSED_ALPHA = &h84E9
const GL_COMPRESSED_LUMINANCE = &h84EA
const GL_COMPRESSED_LUMINANCE_ALPHA = &h84EB
const GL_COMPRESSED_INTENSITY = &h84EC
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

type PFNGLACTIVETEXTUREPROC as sub(byval texture as GLenum)
type PFNGLSAMPLECOVERAGEPROC as sub(byval value as GLfloat, byval invert as GLboolean)
type PFNGLCOMPRESSEDTEXIMAGE3DPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOMPRESSEDTEXIMAGE2DPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOMPRESSEDTEXIMAGE1DPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLGETCOMPRESSEDTEXIMAGEPROC as sub(byval target as GLenum, byval level as GLint, byval img as any ptr)
type PFNGLCLIENTACTIVETEXTUREPROC as sub(byval texture as GLenum)
type PFNGLMULTITEXCOORD1DPROC as sub(byval target as GLenum, byval s as GLdouble)
type PFNGLMULTITEXCOORD1DVPROC as sub(byval target as GLenum, byval v as const GLdouble ptr)
type PFNGLMULTITEXCOORD1FPROC as sub(byval target as GLenum, byval s as GLfloat)
type PFNGLMULTITEXCOORD1FVPROC as sub(byval target as GLenum, byval v as const GLfloat ptr)
type PFNGLMULTITEXCOORD1IPROC as sub(byval target as GLenum, byval s as GLint)
type PFNGLMULTITEXCOORD1IVPROC as sub(byval target as GLenum, byval v as const GLint ptr)
type PFNGLMULTITEXCOORD1SPROC as sub(byval target as GLenum, byval s as GLshort)
type PFNGLMULTITEXCOORD1SVPROC as sub(byval target as GLenum, byval v as const GLshort ptr)
type PFNGLMULTITEXCOORD2DPROC as sub(byval target as GLenum, byval s as GLdouble, byval t as GLdouble)
type PFNGLMULTITEXCOORD2DVPROC as sub(byval target as GLenum, byval v as const GLdouble ptr)
type PFNGLMULTITEXCOORD2FPROC as sub(byval target as GLenum, byval s as GLfloat, byval t as GLfloat)
type PFNGLMULTITEXCOORD2FVPROC as sub(byval target as GLenum, byval v as const GLfloat ptr)
type PFNGLMULTITEXCOORD2IPROC as sub(byval target as GLenum, byval s as GLint, byval t as GLint)
type PFNGLMULTITEXCOORD2IVPROC as sub(byval target as GLenum, byval v as const GLint ptr)
type PFNGLMULTITEXCOORD2SPROC as sub(byval target as GLenum, byval s as GLshort, byval t as GLshort)
type PFNGLMULTITEXCOORD2SVPROC as sub(byval target as GLenum, byval v as const GLshort ptr)
type PFNGLMULTITEXCOORD3DPROC as sub(byval target as GLenum, byval s as GLdouble, byval t as GLdouble, byval r as GLdouble)
type PFNGLMULTITEXCOORD3DVPROC as sub(byval target as GLenum, byval v as const GLdouble ptr)
type PFNGLMULTITEXCOORD3FPROC as sub(byval target as GLenum, byval s as GLfloat, byval t as GLfloat, byval r as GLfloat)
type PFNGLMULTITEXCOORD3FVPROC as sub(byval target as GLenum, byval v as const GLfloat ptr)
type PFNGLMULTITEXCOORD3IPROC as sub(byval target as GLenum, byval s as GLint, byval t as GLint, byval r as GLint)
type PFNGLMULTITEXCOORD3IVPROC as sub(byval target as GLenum, byval v as const GLint ptr)
type PFNGLMULTITEXCOORD3SPROC as sub(byval target as GLenum, byval s as GLshort, byval t as GLshort, byval r as GLshort)
type PFNGLMULTITEXCOORD3SVPROC as sub(byval target as GLenum, byval v as const GLshort ptr)
type PFNGLMULTITEXCOORD4DPROC as sub(byval target as GLenum, byval s as GLdouble, byval t as GLdouble, byval r as GLdouble, byval q as GLdouble)
type PFNGLMULTITEXCOORD4DVPROC as sub(byval target as GLenum, byval v as const GLdouble ptr)
type PFNGLMULTITEXCOORD4FPROC as sub(byval target as GLenum, byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval q as GLfloat)
type PFNGLMULTITEXCOORD4FVPROC as sub(byval target as GLenum, byval v as const GLfloat ptr)
type PFNGLMULTITEXCOORD4IPROC as sub(byval target as GLenum, byval s as GLint, byval t as GLint, byval r as GLint, byval q as GLint)
type PFNGLMULTITEXCOORD4IVPROC as sub(byval target as GLenum, byval v as const GLint ptr)
type PFNGLMULTITEXCOORD4SPROC as sub(byval target as GLenum, byval s as GLshort, byval t as GLshort, byval r as GLshort, byval q as GLshort)
type PFNGLMULTITEXCOORD4SVPROC as sub(byval target as GLenum, byval v as const GLshort ptr)
type PFNGLLOADTRANSPOSEMATRIXFPROC as sub(byval m as const GLfloat ptr)
type PFNGLLOADTRANSPOSEMATRIXDPROC as sub(byval m as const GLdouble ptr)
type PFNGLMULTTRANSPOSEMATRIXFPROC as sub(byval m as const GLfloat ptr)
type PFNGLMULTTRANSPOSEMATRIXDPROC as sub(byval m as const GLdouble ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glActiveTexture(byval texture as GLenum)
	declare sub glSampleCoverage(byval value as GLfloat, byval invert as GLboolean)
	declare sub glCompressedTexImage3D(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCompressedTexImage2D(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCompressedTexImage1D(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCompressedTexSubImage3D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCompressedTexSubImage2D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCompressedTexSubImage1D(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glGetCompressedTexImage(byval target as GLenum, byval level as GLint, byval img as any ptr)
	declare sub glClientActiveTexture(byval texture as GLenum)
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
	declare sub glLoadTransposeMatrixf(byval m as const GLfloat ptr)
	declare sub glLoadTransposeMatrixd(byval m as const GLdouble ptr)
	declare sub glMultTransposeMatrixf(byval m as const GLfloat ptr)
	declare sub glMultTransposeMatrixd(byval m as const GLdouble ptr)
#endif

const GL_VERSION_1_4 = 1
const GL_BLEND_DST_RGB = &h80C8
const GL_BLEND_SRC_RGB = &h80C9
const GL_BLEND_DST_ALPHA = &h80CA
const GL_BLEND_SRC_ALPHA = &h80CB
const GL_POINT_FADE_THRESHOLD_SIZE = &h8128
const GL_DEPTH_COMPONENT16 = &h81A5
const GL_DEPTH_COMPONENT24 = &h81A6
const GL_DEPTH_COMPONENT32 = &h81A7
const GL_MIRRORED_REPEAT = &h8370
const GL_MAX_TEXTURE_LOD_BIAS = &h84FD
const GL_TEXTURE_LOD_BIAS = &h8501
const GL_INCR_WRAP = &h8507
const GL_DECR_WRAP = &h8508
const GL_TEXTURE_DEPTH_SIZE = &h884A
const GL_TEXTURE_COMPARE_MODE = &h884C
const GL_TEXTURE_COMPARE_FUNC = &h884D
const GL_POINT_SIZE_MIN = &h8126
const GL_POINT_SIZE_MAX = &h8127
const GL_POINT_DISTANCE_ATTENUATION = &h8129
const GL_GENERATE_MIPMAP = &h8191
const GL_GENERATE_MIPMAP_HINT = &h8192
const GL_FOG_COORDINATE_SOURCE = &h8450
const GL_FOG_COORDINATE = &h8451
const GL_FRAGMENT_DEPTH = &h8452
const GL_CURRENT_FOG_COORDINATE = &h8453
const GL_FOG_COORDINATE_ARRAY_TYPE = &h8454
const GL_FOG_COORDINATE_ARRAY_STRIDE = &h8455
const GL_FOG_COORDINATE_ARRAY_POINTER = &h8456
const GL_FOG_COORDINATE_ARRAY = &h8457
const GL_COLOR_SUM = &h8458
const GL_CURRENT_SECONDARY_COLOR = &h8459
const GL_SECONDARY_COLOR_ARRAY_SIZE = &h845A
const GL_SECONDARY_COLOR_ARRAY_TYPE = &h845B
const GL_SECONDARY_COLOR_ARRAY_STRIDE = &h845C
const GL_SECONDARY_COLOR_ARRAY_POINTER = &h845D
const GL_SECONDARY_COLOR_ARRAY = &h845E
const GL_TEXTURE_FILTER_CONTROL = &h8500
const GL_DEPTH_TEXTURE_MODE = &h884B
const GL_COMPARE_R_TO_TEXTURE = &h884E
const GL_FUNC_ADD = &h8006
const GL_FUNC_SUBTRACT = &h800A
const GL_FUNC_REVERSE_SUBTRACT = &h800B
const GL_MIN = &h8007
const GL_MAX = &h8008
const GL_CONSTANT_COLOR = &h8001
const GL_ONE_MINUS_CONSTANT_COLOR = &h8002
const GL_CONSTANT_ALPHA = &h8003
const GL_ONE_MINUS_CONSTANT_ALPHA = &h8004

type PFNGLBLENDFUNCSEPARATEPROC as sub(byval sfactorRGB as GLenum, byval dfactorRGB as GLenum, byval sfactorAlpha as GLenum, byval dfactorAlpha as GLenum)
type PFNGLMULTIDRAWARRAYSPROC as sub(byval mode as GLenum, byval first as const GLint ptr, byval count as const GLsizei ptr, byval drawcount as GLsizei)
type PFNGLMULTIDRAWELEMENTSPROC as sub(byval mode as GLenum, byval count as const GLsizei ptr, byval type as GLenum, byval indices as const any const ptr ptr, byval drawcount as GLsizei)
type PFNGLPOINTPARAMETERFPROC as sub(byval pname as GLenum, byval param as GLfloat)
type PFNGLPOINTPARAMETERFVPROC as sub(byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLPOINTPARAMETERIPROC as sub(byval pname as GLenum, byval param as GLint)
type PFNGLPOINTPARAMETERIVPROC as sub(byval pname as GLenum, byval params as const GLint ptr)
type PFNGLFOGCOORDFPROC as sub(byval coord as GLfloat)
type PFNGLFOGCOORDFVPROC as sub(byval coord as const GLfloat ptr)
type PFNGLFOGCOORDDPROC as sub(byval coord as GLdouble)
type PFNGLFOGCOORDDVPROC as sub(byval coord as const GLdouble ptr)
type PFNGLFOGCOORDPOINTERPROC as sub(byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
type PFNGLSECONDARYCOLOR3BPROC as sub(byval red as GLbyte, byval green as GLbyte, byval blue as GLbyte)
type PFNGLSECONDARYCOLOR3BVPROC as sub(byval v as const GLbyte ptr)
type PFNGLSECONDARYCOLOR3DPROC as sub(byval red as GLdouble, byval green as GLdouble, byval blue as GLdouble)
type PFNGLSECONDARYCOLOR3DVPROC as sub(byval v as const GLdouble ptr)
type PFNGLSECONDARYCOLOR3FPROC as sub(byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat)
type PFNGLSECONDARYCOLOR3FVPROC as sub(byval v as const GLfloat ptr)
type PFNGLSECONDARYCOLOR3IPROC as sub(byval red as GLint, byval green as GLint, byval blue as GLint)
type PFNGLSECONDARYCOLOR3IVPROC as sub(byval v as const GLint ptr)
type PFNGLSECONDARYCOLOR3SPROC as sub(byval red as GLshort, byval green as GLshort, byval blue as GLshort)
type PFNGLSECONDARYCOLOR3SVPROC as sub(byval v as const GLshort ptr)
type PFNGLSECONDARYCOLOR3UBPROC as sub(byval red as GLubyte, byval green as GLubyte, byval blue as GLubyte)
type PFNGLSECONDARYCOLOR3UBVPROC as sub(byval v as const GLubyte ptr)
type PFNGLSECONDARYCOLOR3UIPROC as sub(byval red as GLuint, byval green as GLuint, byval blue as GLuint)
type PFNGLSECONDARYCOLOR3UIVPROC as sub(byval v as const GLuint ptr)
type PFNGLSECONDARYCOLOR3USPROC as sub(byval red as GLushort, byval green as GLushort, byval blue as GLushort)
type PFNGLSECONDARYCOLOR3USVPROC as sub(byval v as const GLushort ptr)
type PFNGLSECONDARYCOLORPOINTERPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
type PFNGLWINDOWPOS2DPROC as sub(byval x as GLdouble, byval y as GLdouble)
type PFNGLWINDOWPOS2DVPROC as sub(byval v as const GLdouble ptr)
type PFNGLWINDOWPOS2FPROC as sub(byval x as GLfloat, byval y as GLfloat)
type PFNGLWINDOWPOS2FVPROC as sub(byval v as const GLfloat ptr)
type PFNGLWINDOWPOS2IPROC as sub(byval x as GLint, byval y as GLint)
type PFNGLWINDOWPOS2IVPROC as sub(byval v as const GLint ptr)
type PFNGLWINDOWPOS2SPROC as sub(byval x as GLshort, byval y as GLshort)
type PFNGLWINDOWPOS2SVPROC as sub(byval v as const GLshort ptr)
type PFNGLWINDOWPOS3DPROC as sub(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLWINDOWPOS3DVPROC as sub(byval v as const GLdouble ptr)
type PFNGLWINDOWPOS3FPROC as sub(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLWINDOWPOS3FVPROC as sub(byval v as const GLfloat ptr)
type PFNGLWINDOWPOS3IPROC as sub(byval x as GLint, byval y as GLint, byval z as GLint)
type PFNGLWINDOWPOS3IVPROC as sub(byval v as const GLint ptr)
type PFNGLWINDOWPOS3SPROC as sub(byval x as GLshort, byval y as GLshort, byval z as GLshort)
type PFNGLWINDOWPOS3SVPROC as sub(byval v as const GLshort ptr)
type PFNGLBLENDCOLORPROC as sub(byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat, byval alpha as GLfloat)
type PFNGLBLENDEQUATIONPROC as sub(byval mode as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBlendFuncSeparate(byval sfactorRGB as GLenum, byval dfactorRGB as GLenum, byval sfactorAlpha as GLenum, byval dfactorAlpha as GLenum)
	declare sub glMultiDrawArrays(byval mode as GLenum, byval first as const GLint ptr, byval count as const GLsizei ptr, byval drawcount as GLsizei)
	declare sub glMultiDrawElements(byval mode as GLenum, byval count as const GLsizei ptr, byval type as GLenum, byval indices as const any const ptr ptr, byval drawcount as GLsizei)
	declare sub glPointParameterf(byval pname as GLenum, byval param as GLfloat)
	declare sub glPointParameterfv(byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glPointParameteri(byval pname as GLenum, byval param as GLint)
	declare sub glPointParameteriv(byval pname as GLenum, byval params as const GLint ptr)
	declare sub glFogCoordf(byval coord as GLfloat)
	declare sub glFogCoordfv(byval coord as const GLfloat ptr)
	declare sub glFogCoordd(byval coord as GLdouble)
	declare sub glFogCoorddv(byval coord as const GLdouble ptr)
	declare sub glFogCoordPointer(byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
	declare sub glSecondaryColor3b(byval red as GLbyte, byval green as GLbyte, byval blue as GLbyte)
	declare sub glSecondaryColor3bv(byval v as const GLbyte ptr)
	declare sub glSecondaryColor3d(byval red as GLdouble, byval green as GLdouble, byval blue as GLdouble)
	declare sub glSecondaryColor3dv(byval v as const GLdouble ptr)
	declare sub glSecondaryColor3f(byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat)
	declare sub glSecondaryColor3fv(byval v as const GLfloat ptr)
	declare sub glSecondaryColor3i(byval red as GLint, byval green as GLint, byval blue as GLint)
	declare sub glSecondaryColor3iv(byval v as const GLint ptr)
	declare sub glSecondaryColor3s(byval red as GLshort, byval green as GLshort, byval blue as GLshort)
	declare sub glSecondaryColor3sv(byval v as const GLshort ptr)
	declare sub glSecondaryColor3ub(byval red as GLubyte, byval green as GLubyte, byval blue as GLubyte)
	declare sub glSecondaryColor3ubv(byval v as const GLubyte ptr)
	declare sub glSecondaryColor3ui(byval red as GLuint, byval green as GLuint, byval blue as GLuint)
	declare sub glSecondaryColor3uiv(byval v as const GLuint ptr)
	declare sub glSecondaryColor3us(byval red as GLushort, byval green as GLushort, byval blue as GLushort)
	declare sub glSecondaryColor3usv(byval v as const GLushort ptr)
	declare sub glSecondaryColorPointer(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
	declare sub glWindowPos2d(byval x as GLdouble, byval y as GLdouble)
	declare sub glWindowPos2dv(byval v as const GLdouble ptr)
	declare sub glWindowPos2f(byval x as GLfloat, byval y as GLfloat)
	declare sub glWindowPos2fv(byval v as const GLfloat ptr)
	declare sub glWindowPos2i(byval x as GLint, byval y as GLint)
	declare sub glWindowPos2iv(byval v as const GLint ptr)
	declare sub glWindowPos2s(byval x as GLshort, byval y as GLshort)
	declare sub glWindowPos2sv(byval v as const GLshort ptr)
	declare sub glWindowPos3d(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glWindowPos3dv(byval v as const GLdouble ptr)
	declare sub glWindowPos3f(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glWindowPos3fv(byval v as const GLfloat ptr)
	declare sub glWindowPos3i(byval x as GLint, byval y as GLint, byval z as GLint)
	declare sub glWindowPos3iv(byval v as const GLint ptr)
	declare sub glWindowPos3s(byval x as GLshort, byval y as GLshort, byval z as GLshort)
	declare sub glWindowPos3sv(byval v as const GLshort ptr)
	declare sub glBlendColor(byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat, byval alpha as GLfloat)
	declare sub glBlendEquation(byval mode as GLenum)
#endif

const GL_VERSION_1_5 = 1
type GLsizeiptr as integer
type GLintptr as integer
const GL_BUFFER_SIZE = &h8764
const GL_BUFFER_USAGE = &h8765
const GL_QUERY_COUNTER_BITS = &h8864
const GL_CURRENT_QUERY = &h8865
const GL_QUERY_RESULT = &h8866
const GL_QUERY_RESULT_AVAILABLE = &h8867
const GL_ARRAY_BUFFER = &h8892
const GL_ELEMENT_ARRAY_BUFFER = &h8893
const GL_ARRAY_BUFFER_BINDING = &h8894
const GL_ELEMENT_ARRAY_BUFFER_BINDING = &h8895
const GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = &h889F
const GL_READ_ONLY = &h88B8
const GL_WRITE_ONLY = &h88B9
const GL_READ_WRITE = &h88BA
const GL_BUFFER_ACCESS = &h88BB
const GL_BUFFER_MAPPED = &h88BC
const GL_BUFFER_MAP_POINTER = &h88BD
const GL_STREAM_DRAW = &h88E0
const GL_STREAM_READ = &h88E1
const GL_STREAM_COPY = &h88E2
const GL_STATIC_DRAW = &h88E4
const GL_STATIC_READ = &h88E5
const GL_STATIC_COPY = &h88E6
const GL_DYNAMIC_DRAW = &h88E8
const GL_DYNAMIC_READ = &h88E9
const GL_DYNAMIC_COPY = &h88EA
const GL_SAMPLES_PASSED = &h8914
const GL_SRC1_ALPHA = &h8589
const GL_VERTEX_ARRAY_BUFFER_BINDING = &h8896
const GL_NORMAL_ARRAY_BUFFER_BINDING = &h8897
const GL_COLOR_ARRAY_BUFFER_BINDING = &h8898
const GL_INDEX_ARRAY_BUFFER_BINDING = &h8899
const GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING = &h889A
const GL_EDGE_FLAG_ARRAY_BUFFER_BINDING = &h889B
const GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING = &h889C
const GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING = &h889D
const GL_WEIGHT_ARRAY_BUFFER_BINDING = &h889E
const GL_FOG_COORD_SRC = &h8450
const GL_FOG_COORD = &h8451
const GL_CURRENT_FOG_COORD = &h8453
const GL_FOG_COORD_ARRAY_TYPE = &h8454
const GL_FOG_COORD_ARRAY_STRIDE = &h8455
const GL_FOG_COORD_ARRAY_POINTER = &h8456
const GL_FOG_COORD_ARRAY = &h8457
const GL_FOG_COORD_ARRAY_BUFFER_BINDING = &h889D
const GL_SRC0_RGB = &h8580
const GL_SRC1_RGB = &h8581
const GL_SRC2_RGB = &h8582
const GL_SRC0_ALPHA = &h8588
const GL_SRC2_ALPHA = &h858A

type PFNGLGENQUERIESPROC as sub(byval n as GLsizei, byval ids as GLuint ptr)
type PFNGLDELETEQUERIESPROC as sub(byval n as GLsizei, byval ids as const GLuint ptr)
type PFNGLISQUERYPROC as function(byval id as GLuint) as GLboolean
type PFNGLBEGINQUERYPROC as sub(byval target as GLenum, byval id as GLuint)
type PFNGLENDQUERYPROC as sub(byval target as GLenum)
type PFNGLGETQUERYIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETQUERYOBJECTIVPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETQUERYOBJECTUIVPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLuint ptr)
type PFNGLBINDBUFFERPROC as sub(byval target as GLenum, byval buffer as GLuint)
type PFNGLDELETEBUFFERSPROC as sub(byval n as GLsizei, byval buffers as const GLuint ptr)
type PFNGLGENBUFFERSPROC as sub(byval n as GLsizei, byval buffers as GLuint ptr)
type PFNGLISBUFFERPROC as function(byval buffer as GLuint) as GLboolean
type PFNGLBUFFERDATAPROC as sub(byval target as GLenum, byval size as GLsizeiptr, byval data as const any ptr, byval usage as GLenum)
type PFNGLBUFFERSUBDATAPROC as sub(byval target as GLenum, byval offset as GLintptr, byval size as GLsizeiptr, byval data as const any ptr)
type PFNGLGETBUFFERSUBDATAPROC as sub(byval target as GLenum, byval offset as GLintptr, byval size as GLsizeiptr, byval data as any ptr)
type PFNGLMAPBUFFERPROC as function(byval target as GLenum, byval access as GLenum) as any ptr
type PFNGLUNMAPBUFFERPROC as function(byval target as GLenum) as GLboolean
type PFNGLGETBUFFERPARAMETERIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETBUFFERPOINTERVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as any ptr ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGenQueries(byval n as GLsizei, byval ids as GLuint ptr)
	declare sub glDeleteQueries(byval n as GLsizei, byval ids as const GLuint ptr)
	declare function glIsQuery(byval id as GLuint) as GLboolean
	declare sub glBeginQuery(byval target as GLenum, byval id as GLuint)
	declare sub glEndQuery(byval target as GLenum)
	declare sub glGetQueryiv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetQueryObjectiv(byval id as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetQueryObjectuiv(byval id as GLuint, byval pname as GLenum, byval params as GLuint ptr)
	declare sub glBindBuffer(byval target as GLenum, byval buffer as GLuint)
	declare sub glDeleteBuffers(byval n as GLsizei, byval buffers as const GLuint ptr)
	declare sub glGenBuffers(byval n as GLsizei, byval buffers as GLuint ptr)
	declare function glIsBuffer(byval buffer as GLuint) as GLboolean
	declare sub glBufferData(byval target as GLenum, byval size as GLsizeiptr, byval data as const any ptr, byval usage as GLenum)
	declare sub glBufferSubData(byval target as GLenum, byval offset as GLintptr, byval size as GLsizeiptr, byval data as const any ptr)
	declare sub glGetBufferSubData(byval target as GLenum, byval offset as GLintptr, byval size as GLsizeiptr, byval data as any ptr)
	declare function glMapBuffer(byval target as GLenum, byval access as GLenum) as any ptr
	declare function glUnmapBuffer(byval target as GLenum) as GLboolean
	declare sub glGetBufferParameteriv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetBufferPointerv(byval target as GLenum, byval pname as GLenum, byval params as any ptr ptr)
#endif

const GL_VERSION_2_0 = 1
type GLchar as zstring
const GL_BLEND_EQUATION_RGB = &h8009
const GL_VERTEX_ATTRIB_ARRAY_ENABLED = &h8622
const GL_VERTEX_ATTRIB_ARRAY_SIZE = &h8623
const GL_VERTEX_ATTRIB_ARRAY_STRIDE = &h8624
const GL_VERTEX_ATTRIB_ARRAY_TYPE = &h8625
const GL_CURRENT_VERTEX_ATTRIB = &h8626
const GL_VERTEX_PROGRAM_POINT_SIZE = &h8642
const GL_VERTEX_ATTRIB_ARRAY_POINTER = &h8645
const GL_STENCIL_BACK_FUNC = &h8800
const GL_STENCIL_BACK_FAIL = &h8801
const GL_STENCIL_BACK_PASS_DEPTH_FAIL = &h8802
const GL_STENCIL_BACK_PASS_DEPTH_PASS = &h8803
const GL_MAX_DRAW_BUFFERS = &h8824
const GL_DRAW_BUFFER0 = &h8825
const GL_DRAW_BUFFER1 = &h8826
const GL_DRAW_BUFFER2 = &h8827
const GL_DRAW_BUFFER3 = &h8828
const GL_DRAW_BUFFER4 = &h8829
const GL_DRAW_BUFFER5 = &h882A
const GL_DRAW_BUFFER6 = &h882B
const GL_DRAW_BUFFER7 = &h882C
const GL_DRAW_BUFFER8 = &h882D
const GL_DRAW_BUFFER9 = &h882E
const GL_DRAW_BUFFER10 = &h882F
const GL_DRAW_BUFFER11 = &h8830
const GL_DRAW_BUFFER12 = &h8831
const GL_DRAW_BUFFER13 = &h8832
const GL_DRAW_BUFFER14 = &h8833
const GL_DRAW_BUFFER15 = &h8834
const GL_BLEND_EQUATION_ALPHA = &h883D
const GL_MAX_VERTEX_ATTRIBS = &h8869
const GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = &h886A
const GL_MAX_TEXTURE_IMAGE_UNITS = &h8872
const GL_FRAGMENT_SHADER = &h8B30
const GL_VERTEX_SHADER = &h8B31
const GL_MAX_FRAGMENT_UNIFORM_COMPONENTS = &h8B49
const GL_MAX_VERTEX_UNIFORM_COMPONENTS = &h8B4A
const GL_MAX_VARYING_FLOATS = &h8B4B
const GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS = &h8B4C
const GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS = &h8B4D
const GL_SHADER_TYPE = &h8B4F
const GL_FLOAT_VEC2 = &h8B50
const GL_FLOAT_VEC3 = &h8B51
const GL_FLOAT_VEC4 = &h8B52
const GL_INT_VEC2 = &h8B53
const GL_INT_VEC3 = &h8B54
const GL_INT_VEC4 = &h8B55
const GL_BOOL = &h8B56
const GL_BOOL_VEC2 = &h8B57
const GL_BOOL_VEC3 = &h8B58
const GL_BOOL_VEC4 = &h8B59
const GL_FLOAT_MAT2 = &h8B5A
const GL_FLOAT_MAT3 = &h8B5B
const GL_FLOAT_MAT4 = &h8B5C
const GL_SAMPLER_1D = &h8B5D
const GL_SAMPLER_2D = &h8B5E
const GL_SAMPLER_3D = &h8B5F
const GL_SAMPLER_CUBE = &h8B60
const GL_SAMPLER_1D_SHADOW = &h8B61
const GL_SAMPLER_2D_SHADOW = &h8B62
const GL_DELETE_STATUS = &h8B80
const GL_COMPILE_STATUS = &h8B81
const GL_LINK_STATUS = &h8B82
const GL_VALIDATE_STATUS = &h8B83
const GL_INFO_LOG_LENGTH = &h8B84
const GL_ATTACHED_SHADERS = &h8B85
const GL_ACTIVE_UNIFORMS = &h8B86
const GL_ACTIVE_UNIFORM_MAX_LENGTH = &h8B87
const GL_SHADER_SOURCE_LENGTH = &h8B88
const GL_ACTIVE_ATTRIBUTES = &h8B89
const GL_ACTIVE_ATTRIBUTE_MAX_LENGTH = &h8B8A
const GL_FRAGMENT_SHADER_DERIVATIVE_HINT = &h8B8B
const GL_SHADING_LANGUAGE_VERSION = &h8B8C
const GL_CURRENT_PROGRAM = &h8B8D
const GL_POINT_SPRITE_COORD_ORIGIN = &h8CA0
const GL_LOWER_LEFT = &h8CA1
const GL_UPPER_LEFT = &h8CA2
const GL_STENCIL_BACK_REF = &h8CA3
const GL_STENCIL_BACK_VALUE_MASK = &h8CA4
const GL_STENCIL_BACK_WRITEMASK = &h8CA5
const GL_VERTEX_PROGRAM_TWO_SIDE = &h8643
const GL_POINT_SPRITE = &h8861
const GL_COORD_REPLACE = &h8862
const GL_MAX_TEXTURE_COORDS = &h8871

type PFNGLBLENDEQUATIONSEPARATEPROC as sub(byval modeRGB as GLenum, byval modeAlpha as GLenum)
type PFNGLDRAWBUFFERSPROC as sub(byval n as GLsizei, byval bufs as const GLenum ptr)
type PFNGLSTENCILOPSEPARATEPROC as sub(byval face as GLenum, byval sfail as GLenum, byval dpfail as GLenum, byval dppass as GLenum)
type PFNGLSTENCILFUNCSEPARATEPROC as sub(byval face as GLenum, byval func as GLenum, byval ref as GLint, byval mask as GLuint)
type PFNGLSTENCILMASKSEPARATEPROC as sub(byval face as GLenum, byval mask as GLuint)
type PFNGLATTACHSHADERPROC as sub(byval program as GLuint, byval shader as GLuint)
type PFNGLBINDATTRIBLOCATIONPROC as sub(byval program as GLuint, byval index as GLuint, byval name as const GLchar ptr)
type PFNGLCOMPILESHADERPROC as sub(byval shader as GLuint)
type PFNGLCREATEPROGRAMPROC as function() as GLuint
type PFNGLCREATESHADERPROC as function(byval type as GLenum) as GLuint
type PFNGLDELETEPROGRAMPROC as sub(byval program as GLuint)
type PFNGLDELETESHADERPROC as sub(byval shader as GLuint)
type PFNGLDETACHSHADERPROC as sub(byval program as GLuint, byval shader as GLuint)
type PFNGLDISABLEVERTEXATTRIBARRAYPROC as sub(byval index as GLuint)
type PFNGLENABLEVERTEXATTRIBARRAYPROC as sub(byval index as GLuint)
type PFNGLGETACTIVEATTRIBPROC as sub(byval program as GLuint, byval index as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval size as GLint ptr, byval type as GLenum ptr, byval name as GLchar ptr)
type PFNGLGETACTIVEUNIFORMPROC as sub(byval program as GLuint, byval index as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval size as GLint ptr, byval type as GLenum ptr, byval name as GLchar ptr)
type PFNGLGETATTACHEDSHADERSPROC as sub(byval program as GLuint, byval maxCount as GLsizei, byval count as GLsizei ptr, byval shaders as GLuint ptr)
type PFNGLGETATTRIBLOCATIONPROC as function(byval program as GLuint, byval name as const GLchar ptr) as GLint
type PFNGLGETPROGRAMIVPROC as sub(byval program as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETPROGRAMINFOLOGPROC as sub(byval program as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval infoLog as GLchar ptr)
type PFNGLGETSHADERIVPROC as sub(byval shader as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETSHADERINFOLOGPROC as sub(byval shader as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval infoLog as GLchar ptr)
type PFNGLGETSHADERSOURCEPROC as sub(byval shader as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval source as GLchar ptr)
type PFNGLGETUNIFORMLOCATIONPROC as function(byval program as GLuint, byval name as const GLchar ptr) as GLint
type PFNGLGETUNIFORMFVPROC as sub(byval program as GLuint, byval location as GLint, byval params as GLfloat ptr)
type PFNGLGETUNIFORMIVPROC as sub(byval program as GLuint, byval location as GLint, byval params as GLint ptr)
type PFNGLGETVERTEXATTRIBDVPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
type PFNGLGETVERTEXATTRIBFVPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETVERTEXATTRIBIVPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETVERTEXATTRIBPOINTERVPROC as sub(byval index as GLuint, byval pname as GLenum, byval pointer as any ptr ptr)
type PFNGLISPROGRAMPROC as function(byval program as GLuint) as GLboolean
type PFNGLISSHADERPROC as function(byval shader as GLuint) as GLboolean
type PFNGLLINKPROGRAMPROC as sub(byval program as GLuint)
type PFNGLSHADERSOURCEPROC as sub(byval shader as GLuint, byval count as GLsizei, byval string as const GLchar const ptr ptr, byval length as const GLint ptr)
type PFNGLUSEPROGRAMPROC as sub(byval program as GLuint)
type PFNGLUNIFORM1FPROC as sub(byval location as GLint, byval v0 as GLfloat)
type PFNGLUNIFORM2FPROC as sub(byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat)
type PFNGLUNIFORM3FPROC as sub(byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat)
type PFNGLUNIFORM4FPROC as sub(byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat, byval v3 as GLfloat)
type PFNGLUNIFORM1IPROC as sub(byval location as GLint, byval v0 as GLint)
type PFNGLUNIFORM2IPROC as sub(byval location as GLint, byval v0 as GLint, byval v1 as GLint)
type PFNGLUNIFORM3IPROC as sub(byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint)
type PFNGLUNIFORM4IPROC as sub(byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint, byval v3 as GLint)
type PFNGLUNIFORM1FVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLUNIFORM2FVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLUNIFORM3FVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLUNIFORM4FVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLUNIFORM1IVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLUNIFORM2IVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLUNIFORM3IVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLUNIFORM4IVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLUNIFORMMATRIX2FVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLUNIFORMMATRIX3FVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLUNIFORMMATRIX4FVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLVALIDATEPROGRAMPROC as sub(byval program as GLuint)
type PFNGLVERTEXATTRIB1DPROC as sub(byval index as GLuint, byval x as GLdouble)
type PFNGLVERTEXATTRIB1DVPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIB1FPROC as sub(byval index as GLuint, byval x as GLfloat)
type PFNGLVERTEXATTRIB1FVPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIB1SPROC as sub(byval index as GLuint, byval x as GLshort)
type PFNGLVERTEXATTRIB1SVPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB2DPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble)
type PFNGLVERTEXATTRIB2DVPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIB2FPROC as sub(byval index as GLuint, byval x as GLfloat, byval y as GLfloat)
type PFNGLVERTEXATTRIB2FVPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIB2SPROC as sub(byval index as GLuint, byval x as GLshort, byval y as GLshort)
type PFNGLVERTEXATTRIB2SVPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB3DPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLVERTEXATTRIB3DVPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIB3FPROC as sub(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLVERTEXATTRIB3FVPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIB3SPROC as sub(byval index as GLuint, byval x as GLshort, byval y as GLshort, byval z as GLshort)
type PFNGLVERTEXATTRIB3SVPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB4NBVPROC as sub(byval index as GLuint, byval v as const GLbyte ptr)
type PFNGLVERTEXATTRIB4NIVPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLVERTEXATTRIB4NSVPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB4NUBPROC as sub(byval index as GLuint, byval x as GLubyte, byval y as GLubyte, byval z as GLubyte, byval w as GLubyte)
type PFNGLVERTEXATTRIB4NUBVPROC as sub(byval index as GLuint, byval v as const GLubyte ptr)
type PFNGLVERTEXATTRIB4NUIVPROC as sub(byval index as GLuint, byval v as const GLuint ptr)
type PFNGLVERTEXATTRIB4NUSVPROC as sub(byval index as GLuint, byval v as const GLushort ptr)
type PFNGLVERTEXATTRIB4BVPROC as sub(byval index as GLuint, byval v as const GLbyte ptr)
type PFNGLVERTEXATTRIB4DPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLVERTEXATTRIB4DVPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIB4FPROC as sub(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
type PFNGLVERTEXATTRIB4FVPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIB4IVPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLVERTEXATTRIB4SPROC as sub(byval index as GLuint, byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
type PFNGLVERTEXATTRIB4SVPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB4UBVPROC as sub(byval index as GLuint, byval v as const GLubyte ptr)
type PFNGLVERTEXATTRIB4UIVPROC as sub(byval index as GLuint, byval v as const GLuint ptr)
type PFNGLVERTEXATTRIB4USVPROC as sub(byval index as GLuint, byval v as const GLushort ptr)
type PFNGLVERTEXATTRIBPOINTERPROC as sub(byval index as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval stride as GLsizei, byval pointer as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBlendEquationSeparate(byval modeRGB as GLenum, byval modeAlpha as GLenum)
	declare sub glDrawBuffers(byval n as GLsizei, byval bufs as const GLenum ptr)
	declare sub glStencilOpSeparate(byval face as GLenum, byval sfail as GLenum, byval dpfail as GLenum, byval dppass as GLenum)
	declare sub glStencilFuncSeparate(byval face as GLenum, byval func as GLenum, byval ref as GLint, byval mask as GLuint)
	declare sub glStencilMaskSeparate(byval face as GLenum, byval mask as GLuint)
	declare sub glAttachShader(byval program as GLuint, byval shader as GLuint)
	declare sub glBindAttribLocation(byval program as GLuint, byval index as GLuint, byval name as const GLchar ptr)
	declare sub glCompileShader(byval shader as GLuint)
	declare function glCreateProgram() as GLuint
	declare function glCreateShader(byval type as GLenum) as GLuint
	declare sub glDeleteProgram(byval program as GLuint)
	declare sub glDeleteShader(byval shader as GLuint)
	declare sub glDetachShader(byval program as GLuint, byval shader as GLuint)
	declare sub glDisableVertexAttribArray(byval index as GLuint)
	declare sub glEnableVertexAttribArray(byval index as GLuint)
	declare sub glGetActiveAttrib(byval program as GLuint, byval index as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval size as GLint ptr, byval type as GLenum ptr, byval name as GLchar ptr)
	declare sub glGetActiveUniform(byval program as GLuint, byval index as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval size as GLint ptr, byval type as GLenum ptr, byval name as GLchar ptr)
	declare sub glGetAttachedShaders(byval program as GLuint, byval maxCount as GLsizei, byval count as GLsizei ptr, byval shaders as GLuint ptr)
	declare function glGetAttribLocation(byval program as GLuint, byval name as const GLchar ptr) as GLint
	declare sub glGetProgramiv(byval program as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetProgramInfoLog(byval program as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval infoLog as GLchar ptr)
	declare sub glGetShaderiv(byval shader as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetShaderInfoLog(byval shader as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval infoLog as GLchar ptr)
	declare sub glGetShaderSource(byval shader as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval source as GLchar ptr)
	declare function glGetUniformLocation(byval program as GLuint, byval name as const GLchar ptr) as GLint
	declare sub glGetUniformfv(byval program as GLuint, byval location as GLint, byval params as GLfloat ptr)
	declare sub glGetUniformiv(byval program as GLuint, byval location as GLint, byval params as GLint ptr)
	declare sub glGetVertexAttribdv(byval index as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
	declare sub glGetVertexAttribfv(byval index as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetVertexAttribiv(byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetVertexAttribPointerv(byval index as GLuint, byval pname as GLenum, byval pointer as any ptr ptr)
	declare function glIsProgram(byval program as GLuint) as GLboolean
	declare function glIsShader(byval shader as GLuint) as GLboolean
	declare sub glLinkProgram(byval program as GLuint)
	declare sub glShaderSource(byval shader as GLuint, byval count as GLsizei, byval string as const GLchar const ptr ptr, byval length as const GLint ptr)
	declare sub glUseProgram(byval program as GLuint)
	declare sub glUniform1f(byval location as GLint, byval v0 as GLfloat)
	declare sub glUniform2f(byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat)
	declare sub glUniform3f(byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat)
	declare sub glUniform4f(byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat, byval v3 as GLfloat)
	declare sub glUniform1i(byval location as GLint, byval v0 as GLint)
	declare sub glUniform2i(byval location as GLint, byval v0 as GLint, byval v1 as GLint)
	declare sub glUniform3i(byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint)
	declare sub glUniform4i(byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint, byval v3 as GLint)
	declare sub glUniform1fv(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glUniform2fv(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glUniform3fv(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glUniform4fv(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glUniform1iv(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glUniform2iv(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glUniform3iv(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glUniform4iv(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glUniformMatrix2fv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glUniformMatrix3fv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glUniformMatrix4fv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glValidateProgram(byval program as GLuint)
	declare sub glVertexAttrib1d(byval index as GLuint, byval x as GLdouble)
	declare sub glVertexAttrib1dv(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttrib1f(byval index as GLuint, byval x as GLfloat)
	declare sub glVertexAttrib1fv(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glVertexAttrib1s(byval index as GLuint, byval x as GLshort)
	declare sub glVertexAttrib1sv(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib2d(byval index as GLuint, byval x as GLdouble, byval y as GLdouble)
	declare sub glVertexAttrib2dv(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttrib2f(byval index as GLuint, byval x as GLfloat, byval y as GLfloat)
	declare sub glVertexAttrib2fv(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glVertexAttrib2s(byval index as GLuint, byval x as GLshort, byval y as GLshort)
	declare sub glVertexAttrib2sv(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib3d(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glVertexAttrib3dv(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttrib3f(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glVertexAttrib3fv(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glVertexAttrib3s(byval index as GLuint, byval x as GLshort, byval y as GLshort, byval z as GLshort)
	declare sub glVertexAttrib3sv(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib4Nbv(byval index as GLuint, byval v as const GLbyte ptr)
	declare sub glVertexAttrib4Niv(byval index as GLuint, byval v as const GLint ptr)
	declare sub glVertexAttrib4Nsv(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib4Nub(byval index as GLuint, byval x as GLubyte, byval y as GLubyte, byval z as GLubyte, byval w as GLubyte)
	declare sub glVertexAttrib4Nubv(byval index as GLuint, byval v as const GLubyte ptr)
	declare sub glVertexAttrib4Nuiv(byval index as GLuint, byval v as const GLuint ptr)
	declare sub glVertexAttrib4Nusv(byval index as GLuint, byval v as const GLushort ptr)
	declare sub glVertexAttrib4bv(byval index as GLuint, byval v as const GLbyte ptr)
	declare sub glVertexAttrib4d(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glVertexAttrib4dv(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttrib4f(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
	declare sub glVertexAttrib4fv(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glVertexAttrib4iv(byval index as GLuint, byval v as const GLint ptr)
	declare sub glVertexAttrib4s(byval index as GLuint, byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
	declare sub glVertexAttrib4sv(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib4ubv(byval index as GLuint, byval v as const GLubyte ptr)
	declare sub glVertexAttrib4uiv(byval index as GLuint, byval v as const GLuint ptr)
	declare sub glVertexAttrib4usv(byval index as GLuint, byval v as const GLushort ptr)
	declare sub glVertexAttribPointer(byval index as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval stride as GLsizei, byval pointer as const any ptr)
#endif

const GL_VERSION_2_1 = 1
const GL_PIXEL_PACK_BUFFER = &h88EB
const GL_PIXEL_UNPACK_BUFFER = &h88EC
const GL_PIXEL_PACK_BUFFER_BINDING = &h88ED
const GL_PIXEL_UNPACK_BUFFER_BINDING = &h88EF
const GL_FLOAT_MAT2x3 = &h8B65
const GL_FLOAT_MAT2x4 = &h8B66
const GL_FLOAT_MAT3x2 = &h8B67
const GL_FLOAT_MAT3x4 = &h8B68
const GL_FLOAT_MAT4x2 = &h8B69
const GL_FLOAT_MAT4x3 = &h8B6A
const GL_SRGB = &h8C40
const GL_SRGB8 = &h8C41
const GL_SRGB_ALPHA = &h8C42
const GL_SRGB8_ALPHA8 = &h8C43
const GL_COMPRESSED_SRGB = &h8C48
const GL_COMPRESSED_SRGB_ALPHA = &h8C49
const GL_CURRENT_RASTER_SECONDARY_COLOR = &h845F
const GL_SLUMINANCE_ALPHA = &h8C44
const GL_SLUMINANCE8_ALPHA8 = &h8C45
const GL_SLUMINANCE = &h8C46
const GL_SLUMINANCE8 = &h8C47
const GL_COMPRESSED_SLUMINANCE = &h8C4A
const GL_COMPRESSED_SLUMINANCE_ALPHA = &h8C4B

type PFNGLUNIFORMMATRIX2X3FVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLUNIFORMMATRIX3X2FVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLUNIFORMMATRIX2X4FVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLUNIFORMMATRIX4X2FVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLUNIFORMMATRIX3X4FVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLUNIFORMMATRIX4X3FVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glUniformMatrix2x3fv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glUniformMatrix3x2fv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glUniformMatrix2x4fv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glUniformMatrix4x2fv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glUniformMatrix3x4fv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glUniformMatrix4x3fv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
#endif

const GL_VERSION_3_0 = 1
type GLhalf as ushort
const GL_COMPARE_REF_TO_TEXTURE = &h884E
const GL_CLIP_DISTANCE0 = &h3000
const GL_CLIP_DISTANCE1 = &h3001
const GL_CLIP_DISTANCE2 = &h3002
const GL_CLIP_DISTANCE3 = &h3003
const GL_CLIP_DISTANCE4 = &h3004
const GL_CLIP_DISTANCE5 = &h3005
const GL_CLIP_DISTANCE6 = &h3006
const GL_CLIP_DISTANCE7 = &h3007
const GL_MAX_CLIP_DISTANCES = &h0D32
const GL_MAJOR_VERSION = &h821B
const GL_MINOR_VERSION = &h821C
const GL_NUM_EXTENSIONS = &h821D
const GL_CONTEXT_FLAGS = &h821E
const GL_COMPRESSED_RED = &h8225
const GL_COMPRESSED_RG = &h8226
const GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = &h00000001
const GL_RGBA32F = &h8814
const GL_RGB32F = &h8815
const GL_RGBA16F = &h881A
const GL_RGB16F = &h881B
const GL_VERTEX_ATTRIB_ARRAY_INTEGER = &h88FD
const GL_MAX_ARRAY_TEXTURE_LAYERS = &h88FF
const GL_MIN_PROGRAM_TEXEL_OFFSET = &h8904
const GL_MAX_PROGRAM_TEXEL_OFFSET = &h8905
const GL_CLAMP_READ_COLOR = &h891C
const GL_FIXED_ONLY = &h891D
const GL_MAX_VARYING_COMPONENTS = &h8B4B
const GL_TEXTURE_1D_ARRAY = &h8C18
const GL_PROXY_TEXTURE_1D_ARRAY = &h8C19
const GL_TEXTURE_2D_ARRAY = &h8C1A
const GL_PROXY_TEXTURE_2D_ARRAY = &h8C1B
const GL_TEXTURE_BINDING_1D_ARRAY = &h8C1C
const GL_TEXTURE_BINDING_2D_ARRAY = &h8C1D
const GL_R11F_G11F_B10F = &h8C3A
const GL_UNSIGNED_INT_10F_11F_11F_REV = &h8C3B
const GL_RGB9_E5 = &h8C3D
const GL_UNSIGNED_INT_5_9_9_9_REV = &h8C3E
const GL_TEXTURE_SHARED_SIZE = &h8C3F
const GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = &h8C76
const GL_TRANSFORM_FEEDBACK_BUFFER_MODE = &h8C7F
const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = &h8C80
const GL_TRANSFORM_FEEDBACK_VARYINGS = &h8C83
const GL_TRANSFORM_FEEDBACK_BUFFER_START = &h8C84
const GL_TRANSFORM_FEEDBACK_BUFFER_SIZE = &h8C85
const GL_PRIMITIVES_GENERATED = &h8C87
const GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = &h8C88
const GL_RASTERIZER_DISCARD = &h8C89
const GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = &h8C8A
const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = &h8C8B
const GL_INTERLEAVED_ATTRIBS = &h8C8C
const GL_SEPARATE_ATTRIBS = &h8C8D
const GL_TRANSFORM_FEEDBACK_BUFFER = &h8C8E
const GL_TRANSFORM_FEEDBACK_BUFFER_BINDING = &h8C8F
const GL_RGBA32UI = &h8D70
const GL_RGB32UI = &h8D71
const GL_RGBA16UI = &h8D76
const GL_RGB16UI = &h8D77
const GL_RGBA8UI = &h8D7C
const GL_RGB8UI = &h8D7D
const GL_RGBA32I = &h8D82
const GL_RGB32I = &h8D83
const GL_RGBA16I = &h8D88
const GL_RGB16I = &h8D89
const GL_RGBA8I = &h8D8E
const GL_RGB8I = &h8D8F
const GL_RED_INTEGER = &h8D94
const GL_GREEN_INTEGER = &h8D95
const GL_BLUE_INTEGER = &h8D96
const GL_RGB_INTEGER = &h8D98
const GL_RGBA_INTEGER = &h8D99
const GL_BGR_INTEGER = &h8D9A
const GL_BGRA_INTEGER = &h8D9B
const GL_SAMPLER_1D_ARRAY = &h8DC0
const GL_SAMPLER_2D_ARRAY = &h8DC1
const GL_SAMPLER_1D_ARRAY_SHADOW = &h8DC3
const GL_SAMPLER_2D_ARRAY_SHADOW = &h8DC4
const GL_SAMPLER_CUBE_SHADOW = &h8DC5
const GL_UNSIGNED_INT_VEC2 = &h8DC6
const GL_UNSIGNED_INT_VEC3 = &h8DC7
const GL_UNSIGNED_INT_VEC4 = &h8DC8
const GL_INT_SAMPLER_1D = &h8DC9
const GL_INT_SAMPLER_2D = &h8DCA
const GL_INT_SAMPLER_3D = &h8DCB
const GL_INT_SAMPLER_CUBE = &h8DCC
const GL_INT_SAMPLER_1D_ARRAY = &h8DCE
const GL_INT_SAMPLER_2D_ARRAY = &h8DCF
const GL_UNSIGNED_INT_SAMPLER_1D = &h8DD1
const GL_UNSIGNED_INT_SAMPLER_2D = &h8DD2
const GL_UNSIGNED_INT_SAMPLER_3D = &h8DD3
const GL_UNSIGNED_INT_SAMPLER_CUBE = &h8DD4
const GL_UNSIGNED_INT_SAMPLER_1D_ARRAY = &h8DD6
const GL_UNSIGNED_INT_SAMPLER_2D_ARRAY = &h8DD7
const GL_QUERY_WAIT = &h8E13
const GL_QUERY_NO_WAIT = &h8E14
const GL_QUERY_BY_REGION_WAIT = &h8E15
const GL_QUERY_BY_REGION_NO_WAIT = &h8E16
const GL_BUFFER_ACCESS_FLAGS = &h911F
const GL_BUFFER_MAP_LENGTH = &h9120
const GL_BUFFER_MAP_OFFSET = &h9121
const GL_DEPTH_COMPONENT32F = &h8CAC
const GL_DEPTH32F_STENCIL8 = &h8CAD
const GL_FLOAT_32_UNSIGNED_INT_24_8_REV = &h8DAD
const GL_INVALID_FRAMEBUFFER_OPERATION = &h0506
const GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = &h8210
const GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = &h8211
const GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE = &h8212
const GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = &h8213
const GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = &h8214
const GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = &h8215
const GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = &h8216
const GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = &h8217
const GL_FRAMEBUFFER_DEFAULT = &h8218
const GL_FRAMEBUFFER_UNDEFINED = &h8219
const GL_DEPTH_STENCIL_ATTACHMENT = &h821A
const GL_MAX_RENDERBUFFER_SIZE = &h84E8
const GL_DEPTH_STENCIL = &h84F9
const GL_UNSIGNED_INT_24_8 = &h84FA
const GL_DEPTH24_STENCIL8 = &h88F0
const GL_TEXTURE_STENCIL_SIZE = &h88F1
const GL_TEXTURE_RED_TYPE = &h8C10
const GL_TEXTURE_GREEN_TYPE = &h8C11
const GL_TEXTURE_BLUE_TYPE = &h8C12
const GL_TEXTURE_ALPHA_TYPE = &h8C13
const GL_TEXTURE_DEPTH_TYPE = &h8C16
const GL_UNSIGNED_NORMALIZED = &h8C17
const GL_FRAMEBUFFER_BINDING = &h8CA6
const GL_DRAW_FRAMEBUFFER_BINDING = &h8CA6
const GL_RENDERBUFFER_BINDING = &h8CA7
const GL_READ_FRAMEBUFFER = &h8CA8
const GL_DRAW_FRAMEBUFFER = &h8CA9
const GL_READ_FRAMEBUFFER_BINDING = &h8CAA
const GL_RENDERBUFFER_SAMPLES = &h8CAB
const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = &h8CD0
const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = &h8CD1
const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = &h8CD2
const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = &h8CD3
const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = &h8CD4
const GL_FRAMEBUFFER_COMPLETE = &h8CD5
const GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT = &h8CD6
const GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = &h8CD7
const GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = &h8CDB
const GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER = &h8CDC
const GL_FRAMEBUFFER_UNSUPPORTED = &h8CDD
const GL_MAX_COLOR_ATTACHMENTS = &h8CDF
const GL_COLOR_ATTACHMENT0 = &h8CE0
const GL_COLOR_ATTACHMENT1 = &h8CE1
const GL_COLOR_ATTACHMENT2 = &h8CE2
const GL_COLOR_ATTACHMENT3 = &h8CE3
const GL_COLOR_ATTACHMENT4 = &h8CE4
const GL_COLOR_ATTACHMENT5 = &h8CE5
const GL_COLOR_ATTACHMENT6 = &h8CE6
const GL_COLOR_ATTACHMENT7 = &h8CE7
const GL_COLOR_ATTACHMENT8 = &h8CE8
const GL_COLOR_ATTACHMENT9 = &h8CE9
const GL_COLOR_ATTACHMENT10 = &h8CEA
const GL_COLOR_ATTACHMENT11 = &h8CEB
const GL_COLOR_ATTACHMENT12 = &h8CEC
const GL_COLOR_ATTACHMENT13 = &h8CED
const GL_COLOR_ATTACHMENT14 = &h8CEE
const GL_COLOR_ATTACHMENT15 = &h8CEF
const GL_DEPTH_ATTACHMENT = &h8D00
const GL_STENCIL_ATTACHMENT = &h8D20
const GL_FRAMEBUFFER = &h8D40
const GL_RENDERBUFFER = &h8D41
const GL_RENDERBUFFER_WIDTH = &h8D42
const GL_RENDERBUFFER_HEIGHT = &h8D43
const GL_RENDERBUFFER_INTERNAL_FORMAT = &h8D44
const GL_STENCIL_INDEX1 = &h8D46
const GL_STENCIL_INDEX4 = &h8D47
const GL_STENCIL_INDEX8 = &h8D48
const GL_STENCIL_INDEX16 = &h8D49
const GL_RENDERBUFFER_RED_SIZE = &h8D50
const GL_RENDERBUFFER_GREEN_SIZE = &h8D51
const GL_RENDERBUFFER_BLUE_SIZE = &h8D52
const GL_RENDERBUFFER_ALPHA_SIZE = &h8D53
const GL_RENDERBUFFER_DEPTH_SIZE = &h8D54
const GL_RENDERBUFFER_STENCIL_SIZE = &h8D55
const GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = &h8D56
const GL_MAX_SAMPLES = &h8D57
const GL_INDEX = &h8222
const GL_TEXTURE_LUMINANCE_TYPE = &h8C14
const GL_TEXTURE_INTENSITY_TYPE = &h8C15
const GL_FRAMEBUFFER_SRGB = &h8DB9
const GL_HALF_FLOAT = &h140B
const GL_MAP_READ_BIT = &h0001
const GL_MAP_WRITE_BIT = &h0002
const GL_MAP_INVALIDATE_RANGE_BIT = &h0004
const GL_MAP_INVALIDATE_BUFFER_BIT = &h0008
const GL_MAP_FLUSH_EXPLICIT_BIT = &h0010
const GL_MAP_UNSYNCHRONIZED_BIT = &h0020
const GL_COMPRESSED_RED_RGTC1 = &h8DBB
const GL_COMPRESSED_SIGNED_RED_RGTC1 = &h8DBC
const GL_COMPRESSED_RG_RGTC2 = &h8DBD
const GL_COMPRESSED_SIGNED_RG_RGTC2 = &h8DBE
const GL_RG = &h8227
const GL_RG_INTEGER = &h8228
const GL_R8 = &h8229
const GL_R16 = &h822A
const GL_RG8 = &h822B
const GL_RG16 = &h822C
const GL_R16F = &h822D
const GL_R32F = &h822E
const GL_RG16F = &h822F
const GL_RG32F = &h8230
const GL_R8I = &h8231
const GL_R8UI = &h8232
const GL_R16I = &h8233
const GL_R16UI = &h8234
const GL_R32I = &h8235
const GL_R32UI = &h8236
const GL_RG8I = &h8237
const GL_RG8UI = &h8238
const GL_RG16I = &h8239
const GL_RG16UI = &h823A
const GL_RG32I = &h823B
const GL_RG32UI = &h823C
const GL_VERTEX_ARRAY_BINDING = &h85B5
const GL_CLAMP_VERTEX_COLOR = &h891A
const GL_CLAMP_FRAGMENT_COLOR = &h891B
const GL_ALPHA_INTEGER = &h8D97

type PFNGLCOLORMASKIPROC as sub(byval index as GLuint, byval r as GLboolean, byval g as GLboolean, byval b as GLboolean, byval a as GLboolean)
type PFNGLGETBOOLEANI_VPROC as sub(byval target as GLenum, byval index as GLuint, byval data as GLboolean ptr)
type PFNGLGETINTEGERI_VPROC as sub(byval target as GLenum, byval index as GLuint, byval data as GLint ptr)
type PFNGLENABLEIPROC as sub(byval target as GLenum, byval index as GLuint)
type PFNGLDISABLEIPROC as sub(byval target as GLenum, byval index as GLuint)
type PFNGLISENABLEDIPROC as function(byval target as GLenum, byval index as GLuint) as GLboolean
type PFNGLBEGINTRANSFORMFEEDBACKPROC as sub(byval primitiveMode as GLenum)
type PFNGLENDTRANSFORMFEEDBACKPROC as sub()
type PFNGLBINDBUFFERRANGEPROC as sub(byval target as GLenum, byval index as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr)
type PFNGLBINDBUFFERBASEPROC as sub(byval target as GLenum, byval index as GLuint, byval buffer as GLuint)
type PFNGLTRANSFORMFEEDBACKVARYINGSPROC as sub(byval program as GLuint, byval count as GLsizei, byval varyings as const GLchar const ptr ptr, byval bufferMode as GLenum)
type PFNGLGETTRANSFORMFEEDBACKVARYINGPROC as sub(byval program as GLuint, byval index as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval size as GLsizei ptr, byval type as GLenum ptr, byval name as GLchar ptr)
type PFNGLCLAMPCOLORPROC as sub(byval target as GLenum, byval clamp as GLenum)
type PFNGLBEGINCONDITIONALRENDERPROC as sub(byval id as GLuint, byval mode as GLenum)
type PFNGLENDCONDITIONALRENDERPROC as sub()
type PFNGLVERTEXATTRIBIPOINTERPROC as sub(byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
type PFNGLGETVERTEXATTRIBIIVPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETVERTEXATTRIBIUIVPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLuint ptr)
type PFNGLVERTEXATTRIBI1IPROC as sub(byval index as GLuint, byval x as GLint)
type PFNGLVERTEXATTRIBI2IPROC as sub(byval index as GLuint, byval x as GLint, byval y as GLint)
type PFNGLVERTEXATTRIBI3IPROC as sub(byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint)
type PFNGLVERTEXATTRIBI4IPROC as sub(byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
type PFNGLVERTEXATTRIBI1UIPROC as sub(byval index as GLuint, byval x as GLuint)
type PFNGLVERTEXATTRIBI2UIPROC as sub(byval index as GLuint, byval x as GLuint, byval y as GLuint)
type PFNGLVERTEXATTRIBI3UIPROC as sub(byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint)
type PFNGLVERTEXATTRIBI4UIPROC as sub(byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint, byval w as GLuint)
type PFNGLVERTEXATTRIBI1IVPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLVERTEXATTRIBI2IVPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLVERTEXATTRIBI3IVPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLVERTEXATTRIBI4IVPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLVERTEXATTRIBI1UIVPROC as sub(byval index as GLuint, byval v as const GLuint ptr)
type PFNGLVERTEXATTRIBI2UIVPROC as sub(byval index as GLuint, byval v as const GLuint ptr)
type PFNGLVERTEXATTRIBI3UIVPROC as sub(byval index as GLuint, byval v as const GLuint ptr)
type PFNGLVERTEXATTRIBI4UIVPROC as sub(byval index as GLuint, byval v as const GLuint ptr)
type PFNGLVERTEXATTRIBI4BVPROC as sub(byval index as GLuint, byval v as const GLbyte ptr)
type PFNGLVERTEXATTRIBI4SVPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIBI4UBVPROC as sub(byval index as GLuint, byval v as const GLubyte ptr)
type PFNGLVERTEXATTRIBI4USVPROC as sub(byval index as GLuint, byval v as const GLushort ptr)
type PFNGLGETUNIFORMUIVPROC as sub(byval program as GLuint, byval location as GLint, byval params as GLuint ptr)
type PFNGLBINDFRAGDATALOCATIONPROC as sub(byval program as GLuint, byval color as GLuint, byval name as const GLchar ptr)
type PFNGLGETFRAGDATALOCATIONPROC as function(byval program as GLuint, byval name as const GLchar ptr) as GLint
type PFNGLUNIFORM1UIPROC as sub(byval location as GLint, byval v0 as GLuint)
type PFNGLUNIFORM2UIPROC as sub(byval location as GLint, byval v0 as GLuint, byval v1 as GLuint)
type PFNGLUNIFORM3UIPROC as sub(byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint)
type PFNGLUNIFORM4UIPROC as sub(byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint, byval v3 as GLuint)
type PFNGLUNIFORM1UIVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLUNIFORM2UIVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLUNIFORM3UIVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLUNIFORM4UIVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLTEXPARAMETERIIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLTEXPARAMETERIUIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLuint ptr)
type PFNGLGETTEXPARAMETERIIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETTEXPARAMETERIUIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLuint ptr)
type PFNGLCLEARBUFFERIVPROC as sub(byval buffer as GLenum, byval drawbuffer as GLint, byval value as const GLint ptr)
type PFNGLCLEARBUFFERUIVPROC as sub(byval buffer as GLenum, byval drawbuffer as GLint, byval value as const GLuint ptr)
type PFNGLCLEARBUFFERFVPROC as sub(byval buffer as GLenum, byval drawbuffer as GLint, byval value as const GLfloat ptr)
type PFNGLCLEARBUFFERFIPROC as sub(byval buffer as GLenum, byval drawbuffer as GLint, byval depth as GLfloat, byval stencil as GLint)
type PFNGLGETSTRINGIPROC as function(byval name as GLenum, byval index as GLuint) as const zstring ptr
type PFNGLISRENDERBUFFERPROC as function(byval renderbuffer as GLuint) as GLboolean
type PFNGLBINDRENDERBUFFERPROC as sub(byval target as GLenum, byval renderbuffer as GLuint)
type PFNGLDELETERENDERBUFFERSPROC as sub(byval n as GLsizei, byval renderbuffers as const GLuint ptr)
type PFNGLGENRENDERBUFFERSPROC as sub(byval n as GLsizei, byval renderbuffers as GLuint ptr)
type PFNGLRENDERBUFFERSTORAGEPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
type PFNGLGETRENDERBUFFERPARAMETERIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLISFRAMEBUFFERPROC as function(byval framebuffer as GLuint) as GLboolean
type PFNGLBINDFRAMEBUFFERPROC as sub(byval target as GLenum, byval framebuffer as GLuint)
type PFNGLDELETEFRAMEBUFFERSPROC as sub(byval n as GLsizei, byval framebuffers as const GLuint ptr)
type PFNGLGENFRAMEBUFFERSPROC as sub(byval n as GLsizei, byval framebuffers as GLuint ptr)
type PFNGLCHECKFRAMEBUFFERSTATUSPROC as function(byval target as GLenum) as GLenum
type PFNGLFRAMEBUFFERTEXTURE1DPROC as sub(byval target as GLenum, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint)
type PFNGLFRAMEBUFFERTEXTURE2DPROC as sub(byval target as GLenum, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint)
type PFNGLFRAMEBUFFERTEXTURE3DPROC as sub(byval target as GLenum, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint, byval zoffset as GLint)
type PFNGLFRAMEBUFFERRENDERBUFFERPROC as sub(byval target as GLenum, byval attachment as GLenum, byval renderbuffertarget as GLenum, byval renderbuffer as GLuint)
type PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC as sub(byval target as GLenum, byval attachment as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGENERATEMIPMAPPROC as sub(byval target as GLenum)
type PFNGLBLITFRAMEBUFFERPROC as sub(byval srcX0 as GLint, byval srcY0 as GLint, byval srcX1 as GLint, byval srcY1 as GLint, byval dstX0 as GLint, byval dstY0 as GLint, byval dstX1 as GLint, byval dstY1 as GLint, byval mask as GLbitfield, byval filter as GLenum)
type PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC as sub(byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
type PFNGLFRAMEBUFFERTEXTURELAYERPROC as sub(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval layer as GLint)
type PFNGLMAPBUFFERRANGEPROC as function(byval target as GLenum, byval offset as GLintptr, byval length as GLsizeiptr, byval access as GLbitfield) as any ptr
type PFNGLFLUSHMAPPEDBUFFERRANGEPROC as sub(byval target as GLenum, byval offset as GLintptr, byval length as GLsizeiptr)
type PFNGLBINDVERTEXARRAYPROC as sub(byval array as GLuint)
type PFNGLDELETEVERTEXARRAYSPROC as sub(byval n as GLsizei, byval arrays as const GLuint ptr)
type PFNGLGENVERTEXARRAYSPROC as sub(byval n as GLsizei, byval arrays as GLuint ptr)
type PFNGLISVERTEXARRAYPROC as function(byval array as GLuint) as GLboolean

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glColorMaski(byval index as GLuint, byval r as GLboolean, byval g as GLboolean, byval b as GLboolean, byval a as GLboolean)
	declare sub glGetBooleani_v(byval target as GLenum, byval index as GLuint, byval data as GLboolean ptr)
	declare sub glGetIntegeri_v(byval target as GLenum, byval index as GLuint, byval data as GLint ptr)
	declare sub glEnablei(byval target as GLenum, byval index as GLuint)
	declare sub glDisablei(byval target as GLenum, byval index as GLuint)
	declare function glIsEnabledi(byval target as GLenum, byval index as GLuint) as GLboolean
	declare sub glBeginTransformFeedback(byval primitiveMode as GLenum)
	declare sub glEndTransformFeedback()
	declare sub glBindBufferRange(byval target as GLenum, byval index as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr)
	declare sub glBindBufferBase(byval target as GLenum, byval index as GLuint, byval buffer as GLuint)
	declare sub glTransformFeedbackVaryings(byval program as GLuint, byval count as GLsizei, byval varyings as const GLchar const ptr ptr, byval bufferMode as GLenum)
	declare sub glGetTransformFeedbackVarying(byval program as GLuint, byval index as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval size as GLsizei ptr, byval type as GLenum ptr, byval name as GLchar ptr)
	declare sub glClampColor(byval target as GLenum, byval clamp as GLenum)
	declare sub glBeginConditionalRender(byval id as GLuint, byval mode as GLenum)
	declare sub glEndConditionalRender()
	declare sub glVertexAttribIPointer(byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
	declare sub glGetVertexAttribIiv(byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetVertexAttribIuiv(byval index as GLuint, byval pname as GLenum, byval params as GLuint ptr)
	declare sub glVertexAttribI1i(byval index as GLuint, byval x as GLint)
	declare sub glVertexAttribI2i(byval index as GLuint, byval x as GLint, byval y as GLint)
	declare sub glVertexAttribI3i(byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint)
	declare sub glVertexAttribI4i(byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
	declare sub glVertexAttribI1ui(byval index as GLuint, byval x as GLuint)
	declare sub glVertexAttribI2ui(byval index as GLuint, byval x as GLuint, byval y as GLuint)
	declare sub glVertexAttribI3ui(byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint)
	declare sub glVertexAttribI4ui(byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint, byval w as GLuint)
	declare sub glVertexAttribI1iv(byval index as GLuint, byval v as const GLint ptr)
	declare sub glVertexAttribI2iv(byval index as GLuint, byval v as const GLint ptr)
	declare sub glVertexAttribI3iv(byval index as GLuint, byval v as const GLint ptr)
	declare sub glVertexAttribI4iv(byval index as GLuint, byval v as const GLint ptr)
	declare sub glVertexAttribI1uiv(byval index as GLuint, byval v as const GLuint ptr)
	declare sub glVertexAttribI2uiv(byval index as GLuint, byval v as const GLuint ptr)
	declare sub glVertexAttribI3uiv(byval index as GLuint, byval v as const GLuint ptr)
	declare sub glVertexAttribI4uiv(byval index as GLuint, byval v as const GLuint ptr)
	declare sub glVertexAttribI4bv(byval index as GLuint, byval v as const GLbyte ptr)
	declare sub glVertexAttribI4sv(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttribI4ubv(byval index as GLuint, byval v as const GLubyte ptr)
	declare sub glVertexAttribI4usv(byval index as GLuint, byval v as const GLushort ptr)
	declare sub glGetUniformuiv(byval program as GLuint, byval location as GLint, byval params as GLuint ptr)
	declare sub glBindFragDataLocation(byval program as GLuint, byval color as GLuint, byval name as const GLchar ptr)
	declare function glGetFragDataLocation(byval program as GLuint, byval name as const GLchar ptr) as GLint
	declare sub glUniform1ui(byval location as GLint, byval v0 as GLuint)
	declare sub glUniform2ui(byval location as GLint, byval v0 as GLuint, byval v1 as GLuint)
	declare sub glUniform3ui(byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint)
	declare sub glUniform4ui(byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint, byval v3 as GLuint)
	declare sub glUniform1uiv(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glUniform2uiv(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glUniform3uiv(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glUniform4uiv(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glTexParameterIiv(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glTexParameterIuiv(byval target as GLenum, byval pname as GLenum, byval params as const GLuint ptr)
	declare sub glGetTexParameterIiv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetTexParameterIuiv(byval target as GLenum, byval pname as GLenum, byval params as GLuint ptr)
	declare sub glClearBufferiv(byval buffer as GLenum, byval drawbuffer as GLint, byval value as const GLint ptr)
	declare sub glClearBufferuiv(byval buffer as GLenum, byval drawbuffer as GLint, byval value as const GLuint ptr)
	declare sub glClearBufferfv(byval buffer as GLenum, byval drawbuffer as GLint, byval value as const GLfloat ptr)
	declare sub glClearBufferfi(byval buffer as GLenum, byval drawbuffer as GLint, byval depth as GLfloat, byval stencil as GLint)
	declare function glGetStringi(byval name as GLenum, byval index as GLuint) as const zstring ptr
	declare function glIsRenderbuffer(byval renderbuffer as GLuint) as GLboolean
	declare sub glBindRenderbuffer(byval target as GLenum, byval renderbuffer as GLuint)
	declare sub glDeleteRenderbuffers(byval n as GLsizei, byval renderbuffers as const GLuint ptr)
	declare sub glGenRenderbuffers(byval n as GLsizei, byval renderbuffers as GLuint ptr)
	declare sub glRenderbufferStorage(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
	declare sub glGetRenderbufferParameteriv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare function glIsFramebuffer(byval framebuffer as GLuint) as GLboolean
	declare sub glBindFramebuffer(byval target as GLenum, byval framebuffer as GLuint)
	declare sub glDeleteFramebuffers(byval n as GLsizei, byval framebuffers as const GLuint ptr)
	declare sub glGenFramebuffers(byval n as GLsizei, byval framebuffers as GLuint ptr)
	declare function glCheckFramebufferStatus(byval target as GLenum) as GLenum
	declare sub glFramebufferTexture1D(byval target as GLenum, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint)
	declare sub glFramebufferTexture2D(byval target as GLenum, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint)
	declare sub glFramebufferTexture3D(byval target as GLenum, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint, byval zoffset as GLint)
	declare sub glFramebufferRenderbuffer(byval target as GLenum, byval attachment as GLenum, byval renderbuffertarget as GLenum, byval renderbuffer as GLuint)
	declare sub glGetFramebufferAttachmentParameteriv(byval target as GLenum, byval attachment as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGenerateMipmap(byval target as GLenum)
	declare sub glBlitFramebuffer(byval srcX0 as GLint, byval srcY0 as GLint, byval srcX1 as GLint, byval srcY1 as GLint, byval dstX0 as GLint, byval dstY0 as GLint, byval dstX1 as GLint, byval dstY1 as GLint, byval mask as GLbitfield, byval filter as GLenum)
	declare sub glRenderbufferStorageMultisample(byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
	declare sub glFramebufferTextureLayer(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval layer as GLint)
	declare function glMapBufferRange(byval target as GLenum, byval offset as GLintptr, byval length as GLsizeiptr, byval access as GLbitfield) as any ptr
	declare sub glFlushMappedBufferRange(byval target as GLenum, byval offset as GLintptr, byval length as GLsizeiptr)
	declare sub glBindVertexArray(byval array as GLuint)
	declare sub glDeleteVertexArrays(byval n as GLsizei, byval arrays as const GLuint ptr)
	declare sub glGenVertexArrays(byval n as GLsizei, byval arrays as GLuint ptr)
	declare function glIsVertexArray(byval array as GLuint) as GLboolean
#endif

const GL_VERSION_3_1 = 1
const GL_SAMPLER_2D_RECT = &h8B63
const GL_SAMPLER_2D_RECT_SHADOW = &h8B64
const GL_SAMPLER_BUFFER = &h8DC2
const GL_INT_SAMPLER_2D_RECT = &h8DCD
const GL_INT_SAMPLER_BUFFER = &h8DD0
const GL_UNSIGNED_INT_SAMPLER_2D_RECT = &h8DD5
const GL_UNSIGNED_INT_SAMPLER_BUFFER = &h8DD8
const GL_TEXTURE_BUFFER = &h8C2A
const GL_MAX_TEXTURE_BUFFER_SIZE = &h8C2B
const GL_TEXTURE_BINDING_BUFFER = &h8C2C
const GL_TEXTURE_BUFFER_DATA_STORE_BINDING = &h8C2D
const GL_TEXTURE_RECTANGLE = &h84F5
const GL_TEXTURE_BINDING_RECTANGLE = &h84F6
const GL_PROXY_TEXTURE_RECTANGLE = &h84F7
const GL_MAX_RECTANGLE_TEXTURE_SIZE = &h84F8
const GL_R8_SNORM = &h8F94
const GL_RG8_SNORM = &h8F95
const GL_RGB8_SNORM = &h8F96
const GL_RGBA8_SNORM = &h8F97
const GL_R16_SNORM = &h8F98
const GL_RG16_SNORM = &h8F99
const GL_RGB16_SNORM = &h8F9A
const GL_RGBA16_SNORM = &h8F9B
const GL_SIGNED_NORMALIZED = &h8F9C
const GL_PRIMITIVE_RESTART = &h8F9D
const GL_PRIMITIVE_RESTART_INDEX = &h8F9E
const GL_COPY_READ_BUFFER = &h8F36
const GL_COPY_WRITE_BUFFER = &h8F37
const GL_UNIFORM_BUFFER = &h8A11
const GL_UNIFORM_BUFFER_BINDING = &h8A28
const GL_UNIFORM_BUFFER_START = &h8A29
const GL_UNIFORM_BUFFER_SIZE = &h8A2A
const GL_MAX_VERTEX_UNIFORM_BLOCKS = &h8A2B
const GL_MAX_GEOMETRY_UNIFORM_BLOCKS = &h8A2C
const GL_MAX_FRAGMENT_UNIFORM_BLOCKS = &h8A2D
const GL_MAX_COMBINED_UNIFORM_BLOCKS = &h8A2E
const GL_MAX_UNIFORM_BUFFER_BINDINGS = &h8A2F
const GL_MAX_UNIFORM_BLOCK_SIZE = &h8A30
const GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = &h8A31
const GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS = &h8A32
const GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = &h8A33
const GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT = &h8A34
const GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = &h8A35
const GL_ACTIVE_UNIFORM_BLOCKS = &h8A36
const GL_UNIFORM_TYPE = &h8A37
const GL_UNIFORM_SIZE = &h8A38
const GL_UNIFORM_NAME_LENGTH = &h8A39
const GL_UNIFORM_BLOCK_INDEX = &h8A3A
const GL_UNIFORM_OFFSET = &h8A3B
const GL_UNIFORM_ARRAY_STRIDE = &h8A3C
const GL_UNIFORM_MATRIX_STRIDE = &h8A3D
const GL_UNIFORM_IS_ROW_MAJOR = &h8A3E
const GL_UNIFORM_BLOCK_BINDING = &h8A3F
const GL_UNIFORM_BLOCK_DATA_SIZE = &h8A40
const GL_UNIFORM_BLOCK_NAME_LENGTH = &h8A41
const GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS = &h8A42
const GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = &h8A43
const GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = &h8A44
const GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER = &h8A45
const GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = &h8A46
const GL_INVALID_INDEX = &hFFFFFFFFu

type PFNGLDRAWARRAYSINSTANCEDPROC as sub(byval mode as GLenum, byval first as GLint, byval count as GLsizei, byval instancecount as GLsizei)
type PFNGLDRAWELEMENTSINSTANCEDPROC as sub(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval instancecount as GLsizei)
type PFNGLTEXBUFFERPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint)
type PFNGLPRIMITIVERESTARTINDEXPROC as sub(byval index as GLuint)
type PFNGLCOPYBUFFERSUBDATAPROC as sub(byval readTarget as GLenum, byval writeTarget as GLenum, byval readOffset as GLintptr, byval writeOffset as GLintptr, byval size as GLsizeiptr)
type PFNGLGETUNIFORMINDICESPROC as sub(byval program as GLuint, byval uniformCount as GLsizei, byval uniformNames as const GLchar const ptr ptr, byval uniformIndices as GLuint ptr)
type PFNGLGETACTIVEUNIFORMSIVPROC as sub(byval program as GLuint, byval uniformCount as GLsizei, byval uniformIndices as const GLuint ptr, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETACTIVEUNIFORMNAMEPROC as sub(byval program as GLuint, byval uniformIndex as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval uniformName as GLchar ptr)
type PFNGLGETUNIFORMBLOCKINDEXPROC as function(byval program as GLuint, byval uniformBlockName as const GLchar ptr) as GLuint
type PFNGLGETACTIVEUNIFORMBLOCKIVPROC as sub(byval program as GLuint, byval uniformBlockIndex as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC as sub(byval program as GLuint, byval uniformBlockIndex as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval uniformBlockName as GLchar ptr)
type PFNGLUNIFORMBLOCKBINDINGPROC as sub(byval program as GLuint, byval uniformBlockIndex as GLuint, byval uniformBlockBinding as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDrawArraysInstanced(byval mode as GLenum, byval first as GLint, byval count as GLsizei, byval instancecount as GLsizei)
	declare sub glDrawElementsInstanced(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval instancecount as GLsizei)
	declare sub glTexBuffer(byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint)
	declare sub glPrimitiveRestartIndex(byval index as GLuint)
	declare sub glCopyBufferSubData(byval readTarget as GLenum, byval writeTarget as GLenum, byval readOffset as GLintptr, byval writeOffset as GLintptr, byval size as GLsizeiptr)
	declare sub glGetUniformIndices(byval program as GLuint, byval uniformCount as GLsizei, byval uniformNames as const GLchar const ptr ptr, byval uniformIndices as GLuint ptr)
	declare sub glGetActiveUniformsiv(byval program as GLuint, byval uniformCount as GLsizei, byval uniformIndices as const GLuint ptr, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetActiveUniformName(byval program as GLuint, byval uniformIndex as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval uniformName as GLchar ptr)
	declare function glGetUniformBlockIndex(byval program as GLuint, byval uniformBlockName as const GLchar ptr) as GLuint
	declare sub glGetActiveUniformBlockiv(byval program as GLuint, byval uniformBlockIndex as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetActiveUniformBlockName(byval program as GLuint, byval uniformBlockIndex as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval uniformBlockName as GLchar ptr)
	declare sub glUniformBlockBinding(byval program as GLuint, byval uniformBlockIndex as GLuint, byval uniformBlockBinding as GLuint)
#endif

const GL_VERSION_3_2 = 1
type GLsync as __GLsync ptr
#define GLEXT_64_TYPES_DEFINED
type GLuint64 as ulongint
type GLint64 as longint
const GL_CONTEXT_CORE_PROFILE_BIT = &h00000001
const GL_CONTEXT_COMPATIBILITY_PROFILE_BIT = &h00000002
const GL_LINES_ADJACENCY = &h000A
const GL_LINE_STRIP_ADJACENCY = &h000B
const GL_TRIANGLES_ADJACENCY = &h000C
const GL_TRIANGLE_STRIP_ADJACENCY = &h000D
const GL_PROGRAM_POINT_SIZE = &h8642
const GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = &h8C29
const GL_FRAMEBUFFER_ATTACHMENT_LAYERED = &h8DA7
const GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS = &h8DA8
const GL_GEOMETRY_SHADER = &h8DD9
const GL_GEOMETRY_VERTICES_OUT = &h8916
const GL_GEOMETRY_INPUT_TYPE = &h8917
const GL_GEOMETRY_OUTPUT_TYPE = &h8918
const GL_MAX_GEOMETRY_UNIFORM_COMPONENTS = &h8DDF
const GL_MAX_GEOMETRY_OUTPUT_VERTICES = &h8DE0
const GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = &h8DE1
const GL_MAX_VERTEX_OUTPUT_COMPONENTS = &h9122
const GL_MAX_GEOMETRY_INPUT_COMPONENTS = &h9123
const GL_MAX_GEOMETRY_OUTPUT_COMPONENTS = &h9124
const GL_MAX_FRAGMENT_INPUT_COMPONENTS = &h9125
const GL_CONTEXT_PROFILE_MASK = &h9126
const GL_DEPTH_CLAMP = &h864F
const GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION = &h8E4C
const GL_FIRST_VERTEX_CONVENTION = &h8E4D
const GL_LAST_VERTEX_CONVENTION = &h8E4E
const GL_PROVOKING_VERTEX = &h8E4F
const GL_TEXTURE_CUBE_MAP_SEAMLESS = &h884F
const GL_MAX_SERVER_WAIT_TIMEOUT = &h9111
const GL_OBJECT_TYPE = &h9112
const GL_SYNC_CONDITION = &h9113
const GL_SYNC_STATUS = &h9114
const GL_SYNC_FLAGS = &h9115
const GL_SYNC_FENCE = &h9116
const GL_SYNC_GPU_COMMANDS_COMPLETE = &h9117
const GL_UNSIGNALED = &h9118
const GL_SIGNALED = &h9119
const GL_ALREADY_SIGNALED = &h911A
const GL_TIMEOUT_EXPIRED = &h911B
const GL_CONDITION_SATISFIED = &h911C
const GL_WAIT_FAILED = &h911D
const GL_TIMEOUT_IGNORED = &hFFFFFFFFFFFFFFFFull
const GL_SYNC_FLUSH_COMMANDS_BIT = &h00000001
const GL_SAMPLE_POSITION = &h8E50
const GL_SAMPLE_MASK = &h8E51
const GL_SAMPLE_MASK_VALUE = &h8E52
const GL_MAX_SAMPLE_MASK_WORDS = &h8E59
const GL_TEXTURE_2D_MULTISAMPLE = &h9100
const GL_PROXY_TEXTURE_2D_MULTISAMPLE = &h9101
const GL_TEXTURE_2D_MULTISAMPLE_ARRAY = &h9102
const GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY = &h9103
const GL_TEXTURE_BINDING_2D_MULTISAMPLE = &h9104
const GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY = &h9105
const GL_TEXTURE_SAMPLES = &h9106
const GL_TEXTURE_FIXED_SAMPLE_LOCATIONS = &h9107
const GL_SAMPLER_2D_MULTISAMPLE = &h9108
const GL_INT_SAMPLER_2D_MULTISAMPLE = &h9109
const GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = &h910A
const GL_SAMPLER_2D_MULTISAMPLE_ARRAY = &h910B
const GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = &h910C
const GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = &h910D
const GL_MAX_COLOR_TEXTURE_SAMPLES = &h910E
const GL_MAX_DEPTH_TEXTURE_SAMPLES = &h910F
const GL_MAX_INTEGER_SAMPLES = &h9110

type PFNGLDRAWELEMENTSBASEVERTEXPROC as sub(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval basevertex as GLint)
type PFNGLDRAWRANGEELEMENTSBASEVERTEXPROC as sub(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval basevertex as GLint)
type PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC as sub(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval instancecount as GLsizei, byval basevertex as GLint)
type PFNGLMULTIDRAWELEMENTSBASEVERTEXPROC as sub(byval mode as GLenum, byval count as const GLsizei ptr, byval type as GLenum, byval indices as const any const ptr ptr, byval drawcount as GLsizei, byval basevertex as const GLint ptr)
type PFNGLPROVOKINGVERTEXPROC as sub(byval mode as GLenum)
type PFNGLFENCESYNCPROC as function(byval condition as GLenum, byval flags as GLbitfield) as GLsync
type PFNGLISSYNCPROC as function(byval sync as GLsync) as GLboolean
type PFNGLDELETESYNCPROC as sub(byval sync as GLsync)
type PFNGLCLIENTWAITSYNCPROC as function(byval sync as GLsync, byval flags as GLbitfield, byval timeout as GLuint64) as GLenum
type PFNGLWAITSYNCPROC as sub(byval sync as GLsync, byval flags as GLbitfield, byval timeout as GLuint64)
type PFNGLGETINTEGER64VPROC as sub(byval pname as GLenum, byval data as GLint64 ptr)
type PFNGLGETSYNCIVPROC as sub(byval sync as GLsync, byval pname as GLenum, byval bufSize as GLsizei, byval length as GLsizei ptr, byval values as GLint ptr)
type PFNGLGETINTEGER64I_VPROC as sub(byval target as GLenum, byval index as GLuint, byval data as GLint64 ptr)
type PFNGLGETBUFFERPARAMETERI64VPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint64 ptr)
type PFNGLFRAMEBUFFERTEXTUREPROC as sub(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint)
type PFNGLTEXIMAGE2DMULTISAMPLEPROC as sub(byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval fixedsamplelocations as GLboolean)
type PFNGLTEXIMAGE3DMULTISAMPLEPROC as sub(byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedsamplelocations as GLboolean)
type PFNGLGETMULTISAMPLEFVPROC as sub(byval pname as GLenum, byval index as GLuint, byval val as GLfloat ptr)
type PFNGLSAMPLEMASKIPROC as sub(byval maskNumber as GLuint, byval mask as GLbitfield)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDrawElementsBaseVertex(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval basevertex as GLint)
	declare sub glDrawRangeElementsBaseVertex(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval basevertex as GLint)
	declare sub glDrawElementsInstancedBaseVertex(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval instancecount as GLsizei, byval basevertex as GLint)
	declare sub glMultiDrawElementsBaseVertex(byval mode as GLenum, byval count as const GLsizei ptr, byval type as GLenum, byval indices as const any const ptr ptr, byval drawcount as GLsizei, byval basevertex as const GLint ptr)
	declare sub glProvokingVertex(byval mode as GLenum)
	declare function glFenceSync(byval condition as GLenum, byval flags as GLbitfield) as GLsync
	declare function glIsSync(byval sync as GLsync) as GLboolean
	declare sub glDeleteSync(byval sync as GLsync)
	declare function glClientWaitSync(byval sync as GLsync, byval flags as GLbitfield, byval timeout as GLuint64) as GLenum
	declare sub glWaitSync(byval sync as GLsync, byval flags as GLbitfield, byval timeout as GLuint64)
	declare sub glGetInteger64v(byval pname as GLenum, byval data as GLint64 ptr)
	declare sub glGetSynciv(byval sync as GLsync, byval pname as GLenum, byval bufSize as GLsizei, byval length as GLsizei ptr, byval values as GLint ptr)
	declare sub glGetInteger64i_v(byval target as GLenum, byval index as GLuint, byval data as GLint64 ptr)
	declare sub glGetBufferParameteri64v(byval target as GLenum, byval pname as GLenum, byval params as GLint64 ptr)
	declare sub glFramebufferTexture(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint)
	declare sub glTexImage2DMultisample(byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval fixedsamplelocations as GLboolean)
	declare sub glTexImage3DMultisample(byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedsamplelocations as GLboolean)
	declare sub glGetMultisamplefv(byval pname as GLenum, byval index as GLuint, byval val as GLfloat ptr)
	declare sub glSampleMaski(byval maskNumber as GLuint, byval mask as GLbitfield)
#endif

const GL_VERSION_3_3 = 1
const GL_VERTEX_ATTRIB_ARRAY_DIVISOR = &h88FE
const GL_SRC1_COLOR = &h88F9
const GL_ONE_MINUS_SRC1_COLOR = &h88FA
const GL_ONE_MINUS_SRC1_ALPHA = &h88FB
const GL_MAX_DUAL_SOURCE_DRAW_BUFFERS = &h88FC
const GL_ANY_SAMPLES_PASSED = &h8C2F
const GL_SAMPLER_BINDING = &h8919
const GL_RGB10_A2UI = &h906F
const GL_TEXTURE_SWIZZLE_R = &h8E42
const GL_TEXTURE_SWIZZLE_G = &h8E43
const GL_TEXTURE_SWIZZLE_B = &h8E44
const GL_TEXTURE_SWIZZLE_A = &h8E45
const GL_TEXTURE_SWIZZLE_RGBA = &h8E46
const GL_TIME_ELAPSED = &h88BF
const GL_TIMESTAMP = &h8E28
const GL_INT_2_10_10_10_REV = &h8D9F

type PFNGLBINDFRAGDATALOCATIONINDEXEDPROC as sub(byval program as GLuint, byval colorNumber as GLuint, byval index as GLuint, byval name as const GLchar ptr)
type PFNGLGETFRAGDATAINDEXPROC as function(byval program as GLuint, byval name as const GLchar ptr) as GLint
type PFNGLGENSAMPLERSPROC as sub(byval count as GLsizei, byval samplers as GLuint ptr)
type PFNGLDELETESAMPLERSPROC as sub(byval count as GLsizei, byval samplers as const GLuint ptr)
type PFNGLISSAMPLERPROC as function(byval sampler as GLuint) as GLboolean
type PFNGLBINDSAMPLERPROC as sub(byval unit as GLuint, byval sampler as GLuint)
type PFNGLSAMPLERPARAMETERIPROC as sub(byval sampler as GLuint, byval pname as GLenum, byval param as GLint)
type PFNGLSAMPLERPARAMETERIVPROC as sub(byval sampler as GLuint, byval pname as GLenum, byval param as const GLint ptr)
type PFNGLSAMPLERPARAMETERFPROC as sub(byval sampler as GLuint, byval pname as GLenum, byval param as GLfloat)
type PFNGLSAMPLERPARAMETERFVPROC as sub(byval sampler as GLuint, byval pname as GLenum, byval param as const GLfloat ptr)
type PFNGLSAMPLERPARAMETERIIVPROC as sub(byval sampler as GLuint, byval pname as GLenum, byval param as const GLint ptr)
type PFNGLSAMPLERPARAMETERIUIVPROC as sub(byval sampler as GLuint, byval pname as GLenum, byval param as const GLuint ptr)
type PFNGLGETSAMPLERPARAMETERIVPROC as sub(byval sampler as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETSAMPLERPARAMETERIIVPROC as sub(byval sampler as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETSAMPLERPARAMETERFVPROC as sub(byval sampler as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETSAMPLERPARAMETERIUIVPROC as sub(byval sampler as GLuint, byval pname as GLenum, byval params as GLuint ptr)
type PFNGLQUERYCOUNTERPROC as sub(byval id as GLuint, byval target as GLenum)
type PFNGLGETQUERYOBJECTI64VPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLint64 ptr)
type PFNGLGETQUERYOBJECTUI64VPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLuint64 ptr)
type PFNGLVERTEXATTRIBDIVISORPROC as sub(byval index as GLuint, byval divisor as GLuint)
type PFNGLVERTEXATTRIBP1UIPROC as sub(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as GLuint)
type PFNGLVERTEXATTRIBP1UIVPROC as sub(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as const GLuint ptr)
type PFNGLVERTEXATTRIBP2UIPROC as sub(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as GLuint)
type PFNGLVERTEXATTRIBP2UIVPROC as sub(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as const GLuint ptr)
type PFNGLVERTEXATTRIBP3UIPROC as sub(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as GLuint)
type PFNGLVERTEXATTRIBP3UIVPROC as sub(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as const GLuint ptr)
type PFNGLVERTEXATTRIBP4UIPROC as sub(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as GLuint)
type PFNGLVERTEXATTRIBP4UIVPROC as sub(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as const GLuint ptr)
type PFNGLVERTEXP2UIPROC as sub(byval type as GLenum, byval value as GLuint)
type PFNGLVERTEXP2UIVPROC as sub(byval type as GLenum, byval value as const GLuint ptr)
type PFNGLVERTEXP3UIPROC as sub(byval type as GLenum, byval value as GLuint)
type PFNGLVERTEXP3UIVPROC as sub(byval type as GLenum, byval value as const GLuint ptr)
type PFNGLVERTEXP4UIPROC as sub(byval type as GLenum, byval value as GLuint)
type PFNGLVERTEXP4UIVPROC as sub(byval type as GLenum, byval value as const GLuint ptr)
type PFNGLTEXCOORDP1UIPROC as sub(byval type as GLenum, byval coords as GLuint)
type PFNGLTEXCOORDP1UIVPROC as sub(byval type as GLenum, byval coords as const GLuint ptr)
type PFNGLTEXCOORDP2UIPROC as sub(byval type as GLenum, byval coords as GLuint)
type PFNGLTEXCOORDP2UIVPROC as sub(byval type as GLenum, byval coords as const GLuint ptr)
type PFNGLTEXCOORDP3UIPROC as sub(byval type as GLenum, byval coords as GLuint)
type PFNGLTEXCOORDP3UIVPROC as sub(byval type as GLenum, byval coords as const GLuint ptr)
type PFNGLTEXCOORDP4UIPROC as sub(byval type as GLenum, byval coords as GLuint)
type PFNGLTEXCOORDP4UIVPROC as sub(byval type as GLenum, byval coords as const GLuint ptr)
type PFNGLMULTITEXCOORDP1UIPROC as sub(byval texture as GLenum, byval type as GLenum, byval coords as GLuint)
type PFNGLMULTITEXCOORDP1UIVPROC as sub(byval texture as GLenum, byval type as GLenum, byval coords as const GLuint ptr)
type PFNGLMULTITEXCOORDP2UIPROC as sub(byval texture as GLenum, byval type as GLenum, byval coords as GLuint)
type PFNGLMULTITEXCOORDP2UIVPROC as sub(byval texture as GLenum, byval type as GLenum, byval coords as const GLuint ptr)
type PFNGLMULTITEXCOORDP3UIPROC as sub(byval texture as GLenum, byval type as GLenum, byval coords as GLuint)
type PFNGLMULTITEXCOORDP3UIVPROC as sub(byval texture as GLenum, byval type as GLenum, byval coords as const GLuint ptr)
type PFNGLMULTITEXCOORDP4UIPROC as sub(byval texture as GLenum, byval type as GLenum, byval coords as GLuint)
type PFNGLMULTITEXCOORDP4UIVPROC as sub(byval texture as GLenum, byval type as GLenum, byval coords as const GLuint ptr)
type PFNGLNORMALP3UIPROC as sub(byval type as GLenum, byval coords as GLuint)
type PFNGLNORMALP3UIVPROC as sub(byval type as GLenum, byval coords as const GLuint ptr)
type PFNGLCOLORP3UIPROC as sub(byval type as GLenum, byval color as GLuint)
type PFNGLCOLORP3UIVPROC as sub(byval type as GLenum, byval color as const GLuint ptr)
type PFNGLCOLORP4UIPROC as sub(byval type as GLenum, byval color as GLuint)
type PFNGLCOLORP4UIVPROC as sub(byval type as GLenum, byval color as const GLuint ptr)
type PFNGLSECONDARYCOLORP3UIPROC as sub(byval type as GLenum, byval color as GLuint)
type PFNGLSECONDARYCOLORP3UIVPROC as sub(byval type as GLenum, byval color as const GLuint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBindFragDataLocationIndexed(byval program as GLuint, byval colorNumber as GLuint, byval index as GLuint, byval name as const GLchar ptr)
	declare function glGetFragDataIndex(byval program as GLuint, byval name as const GLchar ptr) as GLint
	declare sub glGenSamplers(byval count as GLsizei, byval samplers as GLuint ptr)
	declare sub glDeleteSamplers(byval count as GLsizei, byval samplers as const GLuint ptr)
	declare function glIsSampler(byval sampler as GLuint) as GLboolean
	declare sub glBindSampler(byval unit as GLuint, byval sampler as GLuint)
	declare sub glSamplerParameteri(byval sampler as GLuint, byval pname as GLenum, byval param as GLint)
	declare sub glSamplerParameteriv(byval sampler as GLuint, byval pname as GLenum, byval param as const GLint ptr)
	declare sub glSamplerParameterf(byval sampler as GLuint, byval pname as GLenum, byval param as GLfloat)
	declare sub glSamplerParameterfv(byval sampler as GLuint, byval pname as GLenum, byval param as const GLfloat ptr)
	declare sub glSamplerParameterIiv(byval sampler as GLuint, byval pname as GLenum, byval param as const GLint ptr)
	declare sub glSamplerParameterIuiv(byval sampler as GLuint, byval pname as GLenum, byval param as const GLuint ptr)
	declare sub glGetSamplerParameteriv(byval sampler as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetSamplerParameterIiv(byval sampler as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetSamplerParameterfv(byval sampler as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetSamplerParameterIuiv(byval sampler as GLuint, byval pname as GLenum, byval params as GLuint ptr)
	declare sub glQueryCounter(byval id as GLuint, byval target as GLenum)
	declare sub glGetQueryObjecti64v(byval id as GLuint, byval pname as GLenum, byval params as GLint64 ptr)
	declare sub glGetQueryObjectui64v(byval id as GLuint, byval pname as GLenum, byval params as GLuint64 ptr)
	declare sub glVertexAttribDivisor(byval index as GLuint, byval divisor as GLuint)
	declare sub glVertexAttribP1ui(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as GLuint)
	declare sub glVertexAttribP1uiv(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as const GLuint ptr)
	declare sub glVertexAttribP2ui(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as GLuint)
	declare sub glVertexAttribP2uiv(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as const GLuint ptr)
	declare sub glVertexAttribP3ui(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as GLuint)
	declare sub glVertexAttribP3uiv(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as const GLuint ptr)
	declare sub glVertexAttribP4ui(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as GLuint)
	declare sub glVertexAttribP4uiv(byval index as GLuint, byval type as GLenum, byval normalized as GLboolean, byval value as const GLuint ptr)
	declare sub glVertexP2ui(byval type as GLenum, byval value as GLuint)
	declare sub glVertexP2uiv(byval type as GLenum, byval value as const GLuint ptr)
	declare sub glVertexP3ui(byval type as GLenum, byval value as GLuint)
	declare sub glVertexP3uiv(byval type as GLenum, byval value as const GLuint ptr)
	declare sub glVertexP4ui(byval type as GLenum, byval value as GLuint)
	declare sub glVertexP4uiv(byval type as GLenum, byval value as const GLuint ptr)
	declare sub glTexCoordP1ui(byval type as GLenum, byval coords as GLuint)
	declare sub glTexCoordP1uiv(byval type as GLenum, byval coords as const GLuint ptr)
	declare sub glTexCoordP2ui(byval type as GLenum, byval coords as GLuint)
	declare sub glTexCoordP2uiv(byval type as GLenum, byval coords as const GLuint ptr)
	declare sub glTexCoordP3ui(byval type as GLenum, byval coords as GLuint)
	declare sub glTexCoordP3uiv(byval type as GLenum, byval coords as const GLuint ptr)
	declare sub glTexCoordP4ui(byval type as GLenum, byval coords as GLuint)
	declare sub glTexCoordP4uiv(byval type as GLenum, byval coords as const GLuint ptr)
	declare sub glMultiTexCoordP1ui(byval texture as GLenum, byval type as GLenum, byval coords as GLuint)
	declare sub glMultiTexCoordP1uiv(byval texture as GLenum, byval type as GLenum, byval coords as const GLuint ptr)
	declare sub glMultiTexCoordP2ui(byval texture as GLenum, byval type as GLenum, byval coords as GLuint)
	declare sub glMultiTexCoordP2uiv(byval texture as GLenum, byval type as GLenum, byval coords as const GLuint ptr)
	declare sub glMultiTexCoordP3ui(byval texture as GLenum, byval type as GLenum, byval coords as GLuint)
	declare sub glMultiTexCoordP3uiv(byval texture as GLenum, byval type as GLenum, byval coords as const GLuint ptr)
	declare sub glMultiTexCoordP4ui(byval texture as GLenum, byval type as GLenum, byval coords as GLuint)
	declare sub glMultiTexCoordP4uiv(byval texture as GLenum, byval type as GLenum, byval coords as const GLuint ptr)
	declare sub glNormalP3ui(byval type as GLenum, byval coords as GLuint)
	declare sub glNormalP3uiv(byval type as GLenum, byval coords as const GLuint ptr)
	declare sub glColorP3ui(byval type as GLenum, byval color as GLuint)
	declare sub glColorP3uiv(byval type as GLenum, byval color as const GLuint ptr)
	declare sub glColorP4ui(byval type as GLenum, byval color as GLuint)
	declare sub glColorP4uiv(byval type as GLenum, byval color as const GLuint ptr)
	declare sub glSecondaryColorP3ui(byval type as GLenum, byval color as GLuint)
	declare sub glSecondaryColorP3uiv(byval type as GLenum, byval color as const GLuint ptr)
#endif

const GL_VERSION_4_0 = 1
const GL_SAMPLE_SHADING = &h8C36
const GL_MIN_SAMPLE_SHADING_VALUE = &h8C37
const GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET = &h8E5E
const GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET = &h8E5F
const GL_TEXTURE_CUBE_MAP_ARRAY = &h9009
const GL_TEXTURE_BINDING_CUBE_MAP_ARRAY = &h900A
const GL_PROXY_TEXTURE_CUBE_MAP_ARRAY = &h900B
const GL_SAMPLER_CUBE_MAP_ARRAY = &h900C
const GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW = &h900D
const GL_INT_SAMPLER_CUBE_MAP_ARRAY = &h900E
const GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY = &h900F
const GL_DRAW_INDIRECT_BUFFER = &h8F3F
const GL_DRAW_INDIRECT_BUFFER_BINDING = &h8F43
const GL_GEOMETRY_SHADER_INVOCATIONS = &h887F
const GL_MAX_GEOMETRY_SHADER_INVOCATIONS = &h8E5A
const GL_MIN_FRAGMENT_INTERPOLATION_OFFSET = &h8E5B
const GL_MAX_FRAGMENT_INTERPOLATION_OFFSET = &h8E5C
const GL_FRAGMENT_INTERPOLATION_OFFSET_BITS = &h8E5D
const GL_MAX_VERTEX_STREAMS = &h8E71
const GL_DOUBLE_VEC2 = &h8FFC
const GL_DOUBLE_VEC3 = &h8FFD
const GL_DOUBLE_VEC4 = &h8FFE
const GL_DOUBLE_MAT2 = &h8F46
const GL_DOUBLE_MAT3 = &h8F47
const GL_DOUBLE_MAT4 = &h8F48
const GL_DOUBLE_MAT2x3 = &h8F49
const GL_DOUBLE_MAT2x4 = &h8F4A
const GL_DOUBLE_MAT3x2 = &h8F4B
const GL_DOUBLE_MAT3x4 = &h8F4C
const GL_DOUBLE_MAT4x2 = &h8F4D
const GL_DOUBLE_MAT4x3 = &h8F4E
const GL_ACTIVE_SUBROUTINES = &h8DE5
const GL_ACTIVE_SUBROUTINE_UNIFORMS = &h8DE6
const GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS = &h8E47
const GL_ACTIVE_SUBROUTINE_MAX_LENGTH = &h8E48
const GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH = &h8E49
const GL_MAX_SUBROUTINES = &h8DE7
const GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS = &h8DE8
const GL_NUM_COMPATIBLE_SUBROUTINES = &h8E4A
const GL_COMPATIBLE_SUBROUTINES = &h8E4B
const GL_PATCHES = &h000E
const GL_PATCH_VERTICES = &h8E72
const GL_PATCH_DEFAULT_INNER_LEVEL = &h8E73
const GL_PATCH_DEFAULT_OUTER_LEVEL = &h8E74
const GL_TESS_CONTROL_OUTPUT_VERTICES = &h8E75
const GL_TESS_GEN_MODE = &h8E76
const GL_TESS_GEN_SPACING = &h8E77
const GL_TESS_GEN_VERTEX_ORDER = &h8E78
const GL_TESS_GEN_POINT_MODE = &h8E79
const GL_ISOLINES = &h8E7A
const GL_FRACTIONAL_ODD = &h8E7B
const GL_FRACTIONAL_EVEN = &h8E7C
const GL_MAX_PATCH_VERTICES = &h8E7D
const GL_MAX_TESS_GEN_LEVEL = &h8E7E
const GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS = &h8E7F
const GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS = &h8E80
const GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS = &h8E81
const GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS = &h8E82
const GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS = &h8E83
const GL_MAX_TESS_PATCH_COMPONENTS = &h8E84
const GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS = &h8E85
const GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS = &h8E86
const GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS = &h8E89
const GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS = &h8E8A
const GL_MAX_TESS_CONTROL_INPUT_COMPONENTS = &h886C
const GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS = &h886D
const GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS = &h8E1E
const GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS = &h8E1F
const GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER = &h84F0
const GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER = &h84F1
const GL_TESS_EVALUATION_SHADER = &h8E87
const GL_TESS_CONTROL_SHADER = &h8E88
const GL_TRANSFORM_FEEDBACK = &h8E22
const GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED = &h8E23
const GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE = &h8E24
const GL_TRANSFORM_FEEDBACK_BINDING = &h8E25
const GL_MAX_TRANSFORM_FEEDBACK_BUFFERS = &h8E70

type PFNGLMINSAMPLESHADINGPROC as sub(byval value as GLfloat)
type PFNGLBLENDEQUATIONIPROC as sub(byval buf as GLuint, byval mode as GLenum)
type PFNGLBLENDEQUATIONSEPARATEIPROC as sub(byval buf as GLuint, byval modeRGB as GLenum, byval modeAlpha as GLenum)
type PFNGLBLENDFUNCIPROC as sub(byval buf as GLuint, byval src as GLenum, byval dst as GLenum)
type PFNGLBLENDFUNCSEPARATEIPROC as sub(byval buf as GLuint, byval srcRGB as GLenum, byval dstRGB as GLenum, byval srcAlpha as GLenum, byval dstAlpha as GLenum)
type PFNGLDRAWARRAYSINDIRECTPROC as sub(byval mode as GLenum, byval indirect as const any ptr)
type PFNGLDRAWELEMENTSINDIRECTPROC as sub(byval mode as GLenum, byval type as GLenum, byval indirect as const any ptr)
type PFNGLUNIFORM1DPROC as sub(byval location as GLint, byval x as GLdouble)
type PFNGLUNIFORM2DPROC as sub(byval location as GLint, byval x as GLdouble, byval y as GLdouble)
type PFNGLUNIFORM3DPROC as sub(byval location as GLint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLUNIFORM4DPROC as sub(byval location as GLint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLUNIFORM1DVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
type PFNGLUNIFORM2DVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
type PFNGLUNIFORM3DVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
type PFNGLUNIFORM4DVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
type PFNGLUNIFORMMATRIX2DVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLUNIFORMMATRIX3DVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLUNIFORMMATRIX4DVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLUNIFORMMATRIX2X3DVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLUNIFORMMATRIX2X4DVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLUNIFORMMATRIX3X2DVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLUNIFORMMATRIX3X4DVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLUNIFORMMATRIX4X2DVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLUNIFORMMATRIX4X3DVPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLGETUNIFORMDVPROC as sub(byval program as GLuint, byval location as GLint, byval params as GLdouble ptr)
type PFNGLGETSUBROUTINEUNIFORMLOCATIONPROC as function(byval program as GLuint, byval shadertype as GLenum, byval name as const GLchar ptr) as GLint
type PFNGLGETSUBROUTINEINDEXPROC as function(byval program as GLuint, byval shadertype as GLenum, byval name as const GLchar ptr) as GLuint
type PFNGLGETACTIVESUBROUTINEUNIFORMIVPROC as sub(byval program as GLuint, byval shadertype as GLenum, byval index as GLuint, byval pname as GLenum, byval values as GLint ptr)
type PFNGLGETACTIVESUBROUTINEUNIFORMNAMEPROC as sub(byval program as GLuint, byval shadertype as GLenum, byval index as GLuint, byval bufsize as GLsizei, byval length as GLsizei ptr, byval name as GLchar ptr)
type PFNGLGETACTIVESUBROUTINENAMEPROC as sub(byval program as GLuint, byval shadertype as GLenum, byval index as GLuint, byval bufsize as GLsizei, byval length as GLsizei ptr, byval name as GLchar ptr)
type PFNGLUNIFORMSUBROUTINESUIVPROC as sub(byval shadertype as GLenum, byval count as GLsizei, byval indices as const GLuint ptr)
type PFNGLGETUNIFORMSUBROUTINEUIVPROC as sub(byval shadertype as GLenum, byval location as GLint, byval params as GLuint ptr)
type PFNGLGETPROGRAMSTAGEIVPROC as sub(byval program as GLuint, byval shadertype as GLenum, byval pname as GLenum, byval values as GLint ptr)
type PFNGLPATCHPARAMETERIPROC as sub(byval pname as GLenum, byval value as GLint)
type PFNGLPATCHPARAMETERFVPROC as sub(byval pname as GLenum, byval values as const GLfloat ptr)
type PFNGLBINDTRANSFORMFEEDBACKPROC as sub(byval target as GLenum, byval id as GLuint)
type PFNGLDELETETRANSFORMFEEDBACKSPROC as sub(byval n as GLsizei, byval ids as const GLuint ptr)
type PFNGLGENTRANSFORMFEEDBACKSPROC as sub(byval n as GLsizei, byval ids as GLuint ptr)
type PFNGLISTRANSFORMFEEDBACKPROC as function(byval id as GLuint) as GLboolean
type PFNGLPAUSETRANSFORMFEEDBACKPROC as sub()
type PFNGLRESUMETRANSFORMFEEDBACKPROC as sub()
type PFNGLDRAWTRANSFORMFEEDBACKPROC as sub(byval mode as GLenum, byval id as GLuint)
type PFNGLDRAWTRANSFORMFEEDBACKSTREAMPROC as sub(byval mode as GLenum, byval id as GLuint, byval stream as GLuint)
type PFNGLBEGINQUERYINDEXEDPROC as sub(byval target as GLenum, byval index as GLuint, byval id as GLuint)
type PFNGLENDQUERYINDEXEDPROC as sub(byval target as GLenum, byval index as GLuint)
type PFNGLGETQUERYINDEXEDIVPROC as sub(byval target as GLenum, byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glMinSampleShading(byval value as GLfloat)
	declare sub glBlendEquationi(byval buf as GLuint, byval mode as GLenum)
	declare sub glBlendEquationSeparatei(byval buf as GLuint, byval modeRGB as GLenum, byval modeAlpha as GLenum)
	declare sub glBlendFunci(byval buf as GLuint, byval src as GLenum, byval dst as GLenum)
	declare sub glBlendFuncSeparatei(byval buf as GLuint, byval srcRGB as GLenum, byval dstRGB as GLenum, byval srcAlpha as GLenum, byval dstAlpha as GLenum)
	declare sub glDrawArraysIndirect(byval mode as GLenum, byval indirect as const any ptr)
	declare sub glDrawElementsIndirect(byval mode as GLenum, byval type as GLenum, byval indirect as const any ptr)
	declare sub glUniform1d(byval location as GLint, byval x as GLdouble)
	declare sub glUniform2d(byval location as GLint, byval x as GLdouble, byval y as GLdouble)
	declare sub glUniform3d(byval location as GLint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glUniform4d(byval location as GLint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glUniform1dv(byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
	declare sub glUniform2dv(byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
	declare sub glUniform3dv(byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
	declare sub glUniform4dv(byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
	declare sub glUniformMatrix2dv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glUniformMatrix3dv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glUniformMatrix4dv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glUniformMatrix2x3dv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glUniformMatrix2x4dv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glUniformMatrix3x2dv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glUniformMatrix3x4dv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glUniformMatrix4x2dv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glUniformMatrix4x3dv(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glGetUniformdv(byval program as GLuint, byval location as GLint, byval params as GLdouble ptr)
	declare function glGetSubroutineUniformLocation(byval program as GLuint, byval shadertype as GLenum, byval name as const GLchar ptr) as GLint
	declare function glGetSubroutineIndex(byval program as GLuint, byval shadertype as GLenum, byval name as const GLchar ptr) as GLuint
	declare sub glGetActiveSubroutineUniformiv(byval program as GLuint, byval shadertype as GLenum, byval index as GLuint, byval pname as GLenum, byval values as GLint ptr)
	declare sub glGetActiveSubroutineUniformName(byval program as GLuint, byval shadertype as GLenum, byval index as GLuint, byval bufsize as GLsizei, byval length as GLsizei ptr, byval name as GLchar ptr)
	declare sub glGetActiveSubroutineName(byval program as GLuint, byval shadertype as GLenum, byval index as GLuint, byval bufsize as GLsizei, byval length as GLsizei ptr, byval name as GLchar ptr)
	declare sub glUniformSubroutinesuiv(byval shadertype as GLenum, byval count as GLsizei, byval indices as const GLuint ptr)
	declare sub glGetUniformSubroutineuiv(byval shadertype as GLenum, byval location as GLint, byval params as GLuint ptr)
	declare sub glGetProgramStageiv(byval program as GLuint, byval shadertype as GLenum, byval pname as GLenum, byval values as GLint ptr)
	declare sub glPatchParameteri(byval pname as GLenum, byval value as GLint)
	declare sub glPatchParameterfv(byval pname as GLenum, byval values as const GLfloat ptr)
	declare sub glBindTransformFeedback(byval target as GLenum, byval id as GLuint)
	declare sub glDeleteTransformFeedbacks(byval n as GLsizei, byval ids as const GLuint ptr)
	declare sub glGenTransformFeedbacks(byval n as GLsizei, byval ids as GLuint ptr)
	declare function glIsTransformFeedback(byval id as GLuint) as GLboolean
	declare sub glPauseTransformFeedback()
	declare sub glResumeTransformFeedback()
	declare sub glDrawTransformFeedback(byval mode as GLenum, byval id as GLuint)
	declare sub glDrawTransformFeedbackStream(byval mode as GLenum, byval id as GLuint, byval stream as GLuint)
	declare sub glBeginQueryIndexed(byval target as GLenum, byval index as GLuint, byval id as GLuint)
	declare sub glEndQueryIndexed(byval target as GLenum, byval index as GLuint)
	declare sub glGetQueryIndexediv(byval target as GLenum, byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
#endif

const GL_VERSION_4_1 = 1
const GL_FIXED = &h140C
const GL_IMPLEMENTATION_COLOR_READ_TYPE = &h8B9A
const GL_IMPLEMENTATION_COLOR_READ_FORMAT = &h8B9B
const GL_LOW_FLOAT = &h8DF0
const GL_MEDIUM_FLOAT = &h8DF1
const GL_HIGH_FLOAT = &h8DF2
const GL_LOW_INT = &h8DF3
const GL_MEDIUM_INT = &h8DF4
const GL_HIGH_INT = &h8DF5
const GL_SHADER_COMPILER = &h8DFA
const GL_SHADER_BINARY_FORMATS = &h8DF8
const GL_NUM_SHADER_BINARY_FORMATS = &h8DF9
const GL_MAX_VERTEX_UNIFORM_VECTORS = &h8DFB
const GL_MAX_VARYING_VECTORS = &h8DFC
const GL_MAX_FRAGMENT_UNIFORM_VECTORS = &h8DFD
const GL_RGB565 = &h8D62
const GL_PROGRAM_BINARY_RETRIEVABLE_HINT = &h8257
const GL_PROGRAM_BINARY_LENGTH = &h8741
const GL_NUM_PROGRAM_BINARY_FORMATS = &h87FE
const GL_PROGRAM_BINARY_FORMATS = &h87FF
const GL_VERTEX_SHADER_BIT = &h00000001
const GL_FRAGMENT_SHADER_BIT = &h00000002
const GL_GEOMETRY_SHADER_BIT = &h00000004
const GL_TESS_CONTROL_SHADER_BIT = &h00000008
const GL_TESS_EVALUATION_SHADER_BIT = &h00000010
const GL_ALL_SHADER_BITS = &hFFFFFFFF
const GL_PROGRAM_SEPARABLE = &h8258
const GL_ACTIVE_PROGRAM = &h8259
const GL_PROGRAM_PIPELINE_BINDING = &h825A
const GL_MAX_VIEWPORTS = &h825B
const GL_VIEWPORT_SUBPIXEL_BITS = &h825C
const GL_VIEWPORT_BOUNDS_RANGE = &h825D
const GL_LAYER_PROVOKING_VERTEX = &h825E
const GL_VIEWPORT_INDEX_PROVOKING_VERTEX = &h825F
const GL_UNDEFINED_VERTEX = &h8260

type PFNGLRELEASESHADERCOMPILERPROC as sub()
type PFNGLSHADERBINARYPROC as sub(byval count as GLsizei, byval shaders as const GLuint ptr, byval binaryformat as GLenum, byval binary as const any ptr, byval length as GLsizei)
type PFNGLGETSHADERPRECISIONFORMATPROC as sub(byval shadertype as GLenum, byval precisiontype as GLenum, byval range as GLint ptr, byval precision as GLint ptr)
type PFNGLDEPTHRANGEFPROC as sub(byval n as GLfloat, byval f as GLfloat)
type PFNGLCLEARDEPTHFPROC as sub(byval d as GLfloat)
type PFNGLGETPROGRAMBINARYPROC as sub(byval program as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval binaryFormat as GLenum ptr, byval binary as any ptr)
type PFNGLPROGRAMBINARYPROC as sub(byval program as GLuint, byval binaryFormat as GLenum, byval binary as const any ptr, byval length as GLsizei)
type PFNGLPROGRAMPARAMETERIPROC as sub(byval program as GLuint, byval pname as GLenum, byval value as GLint)
type PFNGLUSEPROGRAMSTAGESPROC as sub(byval pipeline as GLuint, byval stages as GLbitfield, byval program as GLuint)
type PFNGLACTIVESHADERPROGRAMPROC as sub(byval pipeline as GLuint, byval program as GLuint)
type PFNGLCREATESHADERPROGRAMVPROC as function(byval type as GLenum, byval count as GLsizei, byval strings as const GLchar const ptr ptr) as GLuint
type PFNGLBINDPROGRAMPIPELINEPROC as sub(byval pipeline as GLuint)
type PFNGLDELETEPROGRAMPIPELINESPROC as sub(byval n as GLsizei, byval pipelines as const GLuint ptr)
type PFNGLGENPROGRAMPIPELINESPROC as sub(byval n as GLsizei, byval pipelines as GLuint ptr)
type PFNGLISPROGRAMPIPELINEPROC as function(byval pipeline as GLuint) as GLboolean
type PFNGLGETPROGRAMPIPELINEIVPROC as sub(byval pipeline as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLPROGRAMUNIFORM1IPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLint)
type PFNGLPROGRAMUNIFORM1IVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLPROGRAMUNIFORM1FPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLfloat)
type PFNGLPROGRAMUNIFORM1FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORM1DPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLdouble)
type PFNGLPROGRAMUNIFORM1DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORM1UIPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLuint)
type PFNGLPROGRAMUNIFORM1UIVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLPROGRAMUNIFORM2IPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLint, byval v1 as GLint)
type PFNGLPROGRAMUNIFORM2IVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLPROGRAMUNIFORM2FPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat)
type PFNGLPROGRAMUNIFORM2FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORM2DPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLdouble, byval v1 as GLdouble)
type PFNGLPROGRAMUNIFORM2DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORM2UIPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLuint, byval v1 as GLuint)
type PFNGLPROGRAMUNIFORM2UIVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLPROGRAMUNIFORM3IPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint)
type PFNGLPROGRAMUNIFORM3IVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLPROGRAMUNIFORM3FPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat)
type PFNGLPROGRAMUNIFORM3FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORM3DPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLdouble, byval v1 as GLdouble, byval v2 as GLdouble)
type PFNGLPROGRAMUNIFORM3DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORM3UIPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint)
type PFNGLPROGRAMUNIFORM3UIVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLPROGRAMUNIFORM4IPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint, byval v3 as GLint)
type PFNGLPROGRAMUNIFORM4IVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLPROGRAMUNIFORM4FPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat, byval v3 as GLfloat)
type PFNGLPROGRAMUNIFORM4FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORM4DPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLdouble, byval v1 as GLdouble, byval v2 as GLdouble, byval v3 as GLdouble)
type PFNGLPROGRAMUNIFORM4DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORM4UIPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint, byval v3 as GLuint)
type PFNGLPROGRAMUNIFORM4UIVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLPROGRAMUNIFORMMATRIX2FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX3FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX4FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX2DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX3DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX4DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX2X3FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX3X2FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX2X4FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX4X2FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX3X4FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX4X3FVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX2X3DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX3X2DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX2X4DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX4X2DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX3X4DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX4X3DVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLVALIDATEPROGRAMPIPELINEPROC as sub(byval pipeline as GLuint)
type PFNGLGETPROGRAMPIPELINEINFOLOGPROC as sub(byval pipeline as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval infoLog as GLchar ptr)
type PFNGLVERTEXATTRIBL1DPROC as sub(byval index as GLuint, byval x as GLdouble)
type PFNGLVERTEXATTRIBL2DPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble)
type PFNGLVERTEXATTRIBL3DPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLVERTEXATTRIBL4DPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLVERTEXATTRIBL1DVPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIBL2DVPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIBL3DVPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIBL4DVPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIBLPOINTERPROC as sub(byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
type PFNGLGETVERTEXATTRIBLDVPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
type PFNGLVIEWPORTARRAYVPROC as sub(byval first as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
type PFNGLVIEWPORTINDEXEDFPROC as sub(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval w as GLfloat, byval h as GLfloat)
type PFNGLVIEWPORTINDEXEDFVPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLSCISSORARRAYVPROC as sub(byval first as GLuint, byval count as GLsizei, byval v as const GLint ptr)
type PFNGLSCISSORINDEXEDPROC as sub(byval index as GLuint, byval left as GLint, byval bottom as GLint, byval width as GLsizei, byval height as GLsizei)
type PFNGLSCISSORINDEXEDVPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLDEPTHRANGEARRAYVPROC as sub(byval first as GLuint, byval count as GLsizei, byval v as const GLdouble ptr)
type PFNGLDEPTHRANGEINDEXEDPROC as sub(byval index as GLuint, byval n as GLdouble, byval f as GLdouble)
type PFNGLGETFLOATI_VPROC as sub(byval target as GLenum, byval index as GLuint, byval data as GLfloat ptr)
type PFNGLGETDOUBLEI_VPROC as sub(byval target as GLenum, byval index as GLuint, byval data as GLdouble ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glReleaseShaderCompiler()
	declare sub glShaderBinary(byval count as GLsizei, byval shaders as const GLuint ptr, byval binaryformat as GLenum, byval binary as const any ptr, byval length as GLsizei)
	declare sub glGetShaderPrecisionFormat(byval shadertype as GLenum, byval precisiontype as GLenum, byval range as GLint ptr, byval precision as GLint ptr)
	declare sub glDepthRangef(byval n as GLfloat, byval f as GLfloat)
	declare sub glClearDepthf(byval d as GLfloat)
	declare sub glGetProgramBinary(byval program as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval binaryFormat as GLenum ptr, byval binary as any ptr)
	declare sub glProgramBinary(byval program as GLuint, byval binaryFormat as GLenum, byval binary as const any ptr, byval length as GLsizei)
	declare sub glProgramParameteri(byval program as GLuint, byval pname as GLenum, byval value as GLint)
	declare sub glUseProgramStages(byval pipeline as GLuint, byval stages as GLbitfield, byval program as GLuint)
	declare sub glActiveShaderProgram(byval pipeline as GLuint, byval program as GLuint)
	declare function glCreateShaderProgramv(byval type as GLenum, byval count as GLsizei, byval strings as const GLchar const ptr ptr) as GLuint
	declare sub glBindProgramPipeline(byval pipeline as GLuint)
	declare sub glDeleteProgramPipelines(byval n as GLsizei, byval pipelines as const GLuint ptr)
	declare sub glGenProgramPipelines(byval n as GLsizei, byval pipelines as GLuint ptr)
	declare function glIsProgramPipeline(byval pipeline as GLuint) as GLboolean
	declare sub glGetProgramPipelineiv(byval pipeline as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glProgramUniform1i(byval program as GLuint, byval location as GLint, byval v0 as GLint)
	declare sub glProgramUniform1iv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glProgramUniform1f(byval program as GLuint, byval location as GLint, byval v0 as GLfloat)
	declare sub glProgramUniform1fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glProgramUniform1d(byval program as GLuint, byval location as GLint, byval v0 as GLdouble)
	declare sub glProgramUniform1dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
	declare sub glProgramUniform1ui(byval program as GLuint, byval location as GLint, byval v0 as GLuint)
	declare sub glProgramUniform1uiv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glProgramUniform2i(byval program as GLuint, byval location as GLint, byval v0 as GLint, byval v1 as GLint)
	declare sub glProgramUniform2iv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glProgramUniform2f(byval program as GLuint, byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat)
	declare sub glProgramUniform2fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glProgramUniform2d(byval program as GLuint, byval location as GLint, byval v0 as GLdouble, byval v1 as GLdouble)
	declare sub glProgramUniform2dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
	declare sub glProgramUniform2ui(byval program as GLuint, byval location as GLint, byval v0 as GLuint, byval v1 as GLuint)
	declare sub glProgramUniform2uiv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glProgramUniform3i(byval program as GLuint, byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint)
	declare sub glProgramUniform3iv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glProgramUniform3f(byval program as GLuint, byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat)
	declare sub glProgramUniform3fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glProgramUniform3d(byval program as GLuint, byval location as GLint, byval v0 as GLdouble, byval v1 as GLdouble, byval v2 as GLdouble)
	declare sub glProgramUniform3dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
	declare sub glProgramUniform3ui(byval program as GLuint, byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint)
	declare sub glProgramUniform3uiv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glProgramUniform4i(byval program as GLuint, byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint, byval v3 as GLint)
	declare sub glProgramUniform4iv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glProgramUniform4f(byval program as GLuint, byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat, byval v3 as GLfloat)
	declare sub glProgramUniform4fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glProgramUniform4d(byval program as GLuint, byval location as GLint, byval v0 as GLdouble, byval v1 as GLdouble, byval v2 as GLdouble, byval v3 as GLdouble)
	declare sub glProgramUniform4dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
	declare sub glProgramUniform4ui(byval program as GLuint, byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint, byval v3 as GLuint)
	declare sub glProgramUniform4uiv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glProgramUniformMatrix2fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix3fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix4fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix2dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix3dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix4dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix2x3fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix3x2fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix2x4fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix4x2fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix3x4fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix4x3fv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix2x3dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix3x2dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix2x4dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix4x2dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix3x4dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix4x3dv(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glValidateProgramPipeline(byval pipeline as GLuint)
	declare sub glGetProgramPipelineInfoLog(byval pipeline as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval infoLog as GLchar ptr)
	declare sub glVertexAttribL1d(byval index as GLuint, byval x as GLdouble)
	declare sub glVertexAttribL2d(byval index as GLuint, byval x as GLdouble, byval y as GLdouble)
	declare sub glVertexAttribL3d(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glVertexAttribL4d(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glVertexAttribL1dv(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttribL2dv(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttribL3dv(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttribL4dv(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttribLPointer(byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
	declare sub glGetVertexAttribLdv(byval index as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
	declare sub glViewportArrayv(byval first as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
	declare sub glViewportIndexedf(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval w as GLfloat, byval h as GLfloat)
	declare sub glViewportIndexedfv(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glScissorArrayv(byval first as GLuint, byval count as GLsizei, byval v as const GLint ptr)
	declare sub glScissorIndexed(byval index as GLuint, byval left as GLint, byval bottom as GLint, byval width as GLsizei, byval height as GLsizei)
	declare sub glScissorIndexedv(byval index as GLuint, byval v as const GLint ptr)
	declare sub glDepthRangeArrayv(byval first as GLuint, byval count as GLsizei, byval v as const GLdouble ptr)
	declare sub glDepthRangeIndexed(byval index as GLuint, byval n as GLdouble, byval f as GLdouble)
	declare sub glGetFloati_v(byval target as GLenum, byval index as GLuint, byval data as GLfloat ptr)
	declare sub glGetDoublei_v(byval target as GLenum, byval index as GLuint, byval data as GLdouble ptr)
#endif

const GL_VERSION_4_2 = 1
const GL_COPY_READ_BUFFER_BINDING = &h8F36
const GL_COPY_WRITE_BUFFER_BINDING = &h8F37
const GL_TRANSFORM_FEEDBACK_ACTIVE = &h8E24
const GL_TRANSFORM_FEEDBACK_PAUSED = &h8E23
const GL_UNPACK_COMPRESSED_BLOCK_WIDTH = &h9127
const GL_UNPACK_COMPRESSED_BLOCK_HEIGHT = &h9128
const GL_UNPACK_COMPRESSED_BLOCK_DEPTH = &h9129
const GL_UNPACK_COMPRESSED_BLOCK_SIZE = &h912A
const GL_PACK_COMPRESSED_BLOCK_WIDTH = &h912B
const GL_PACK_COMPRESSED_BLOCK_HEIGHT = &h912C
const GL_PACK_COMPRESSED_BLOCK_DEPTH = &h912D
const GL_PACK_COMPRESSED_BLOCK_SIZE = &h912E
const GL_NUM_SAMPLE_COUNTS = &h9380
const GL_MIN_MAP_BUFFER_ALIGNMENT = &h90BC
const GL_ATOMIC_COUNTER_BUFFER = &h92C0
const GL_ATOMIC_COUNTER_BUFFER_BINDING = &h92C1
const GL_ATOMIC_COUNTER_BUFFER_START = &h92C2
const GL_ATOMIC_COUNTER_BUFFER_SIZE = &h92C3
const GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE = &h92C4
const GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS = &h92C5
const GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES = &h92C6
const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER = &h92C7
const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER = &h92C8
const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER = &h92C9
const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER = &h92CA
const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER = &h92CB
const GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS = &h92CC
const GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS = &h92CD
const GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS = &h92CE
const GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS = &h92CF
const GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS = &h92D0
const GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS = &h92D1
const GL_MAX_VERTEX_ATOMIC_COUNTERS = &h92D2
const GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS = &h92D3
const GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS = &h92D4
const GL_MAX_GEOMETRY_ATOMIC_COUNTERS = &h92D5
const GL_MAX_FRAGMENT_ATOMIC_COUNTERS = &h92D6
const GL_MAX_COMBINED_ATOMIC_COUNTERS = &h92D7
const GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE = &h92D8
const GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS = &h92DC
const GL_ACTIVE_ATOMIC_COUNTER_BUFFERS = &h92D9
const GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX = &h92DA
const GL_UNSIGNED_INT_ATOMIC_COUNTER = &h92DB
const GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT = &h00000001
const GL_ELEMENT_ARRAY_BARRIER_BIT = &h00000002
const GL_UNIFORM_BARRIER_BIT = &h00000004
const GL_TEXTURE_FETCH_BARRIER_BIT = &h00000008
const GL_SHADER_IMAGE_ACCESS_BARRIER_BIT = &h00000020
const GL_COMMAND_BARRIER_BIT = &h00000040
const GL_PIXEL_BUFFER_BARRIER_BIT = &h00000080
const GL_TEXTURE_UPDATE_BARRIER_BIT = &h00000100
const GL_BUFFER_UPDATE_BARRIER_BIT = &h00000200
const GL_FRAMEBUFFER_BARRIER_BIT = &h00000400
const GL_TRANSFORM_FEEDBACK_BARRIER_BIT = &h00000800
const GL_ATOMIC_COUNTER_BARRIER_BIT = &h00001000
const GL_ALL_BARRIER_BITS = &hFFFFFFFF
const GL_MAX_IMAGE_UNITS = &h8F38
const GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS = &h8F39
const GL_IMAGE_BINDING_NAME = &h8F3A
const GL_IMAGE_BINDING_LEVEL = &h8F3B
const GL_IMAGE_BINDING_LAYERED = &h8F3C
const GL_IMAGE_BINDING_LAYER = &h8F3D
const GL_IMAGE_BINDING_ACCESS = &h8F3E
const GL_IMAGE_1D = &h904C
const GL_IMAGE_2D = &h904D
const GL_IMAGE_3D = &h904E
const GL_IMAGE_2D_RECT = &h904F
const GL_IMAGE_CUBE = &h9050
const GL_IMAGE_BUFFER = &h9051
const GL_IMAGE_1D_ARRAY = &h9052
const GL_IMAGE_2D_ARRAY = &h9053
const GL_IMAGE_CUBE_MAP_ARRAY = &h9054
const GL_IMAGE_2D_MULTISAMPLE = &h9055
const GL_IMAGE_2D_MULTISAMPLE_ARRAY = &h9056
const GL_INT_IMAGE_1D = &h9057
const GL_INT_IMAGE_2D = &h9058
const GL_INT_IMAGE_3D = &h9059
const GL_INT_IMAGE_2D_RECT = &h905A
const GL_INT_IMAGE_CUBE = &h905B
const GL_INT_IMAGE_BUFFER = &h905C
const GL_INT_IMAGE_1D_ARRAY = &h905D
const GL_INT_IMAGE_2D_ARRAY = &h905E
const GL_INT_IMAGE_CUBE_MAP_ARRAY = &h905F
const GL_INT_IMAGE_2D_MULTISAMPLE = &h9060
const GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY = &h9061
const GL_UNSIGNED_INT_IMAGE_1D = &h9062
const GL_UNSIGNED_INT_IMAGE_2D = &h9063
const GL_UNSIGNED_INT_IMAGE_3D = &h9064
const GL_UNSIGNED_INT_IMAGE_2D_RECT = &h9065
const GL_UNSIGNED_INT_IMAGE_CUBE = &h9066
const GL_UNSIGNED_INT_IMAGE_BUFFER = &h9067
const GL_UNSIGNED_INT_IMAGE_1D_ARRAY = &h9068
const GL_UNSIGNED_INT_IMAGE_2D_ARRAY = &h9069
const GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY = &h906A
const GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE = &h906B
const GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY = &h906C
const GL_MAX_IMAGE_SAMPLES = &h906D
const GL_IMAGE_BINDING_FORMAT = &h906E
const GL_IMAGE_FORMAT_COMPATIBILITY_TYPE = &h90C7
const GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE = &h90C8
const GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS = &h90C9
const GL_MAX_VERTEX_IMAGE_UNIFORMS = &h90CA
const GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS = &h90CB
const GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS = &h90CC
const GL_MAX_GEOMETRY_IMAGE_UNIFORMS = &h90CD
const GL_MAX_FRAGMENT_IMAGE_UNIFORMS = &h90CE
const GL_MAX_COMBINED_IMAGE_UNIFORMS = &h90CF
const GL_COMPRESSED_RGBA_BPTC_UNORM = &h8E8C
const GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM = &h8E8D
const GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT = &h8E8E
const GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT = &h8E8F
const GL_TEXTURE_IMMUTABLE_FORMAT = &h912F

type PFNGLDRAWARRAYSINSTANCEDBASEINSTANCEPROC as sub(byval mode as GLenum, byval first as GLint, byval count as GLsizei, byval instancecount as GLsizei, byval baseinstance as GLuint)
type PFNGLDRAWELEMENTSINSTANCEDBASEINSTANCEPROC as sub(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval instancecount as GLsizei, byval baseinstance as GLuint)
type PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXBASEINSTANCEPROC as sub(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval instancecount as GLsizei, byval basevertex as GLint, byval baseinstance as GLuint)
type PFNGLGETINTERNALFORMATIVPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval pname as GLenum, byval bufSize as GLsizei, byval params as GLint ptr)
type PFNGLGETACTIVEATOMICCOUNTERBUFFERIVPROC as sub(byval program as GLuint, byval bufferIndex as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLBINDIMAGETEXTUREPROC as sub(byval unit as GLuint, byval texture as GLuint, byval level as GLint, byval layered as GLboolean, byval layer as GLint, byval access as GLenum, byval format as GLenum)
type PFNGLMEMORYBARRIERPROC as sub(byval barriers as GLbitfield)
type PFNGLTEXSTORAGE1DPROC as sub(byval target as GLenum, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei)
type PFNGLTEXSTORAGE2DPROC as sub(byval target as GLenum, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
type PFNGLTEXSTORAGE3DPROC as sub(byval target as GLenum, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei)
type PFNGLDRAWTRANSFORMFEEDBACKINSTANCEDPROC as sub(byval mode as GLenum, byval id as GLuint, byval instancecount as GLsizei)
type PFNGLDRAWTRANSFORMFEEDBACKSTREAMINSTANCEDPROC as sub(byval mode as GLenum, byval id as GLuint, byval stream as GLuint, byval instancecount as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDrawArraysInstancedBaseInstance(byval mode as GLenum, byval first as GLint, byval count as GLsizei, byval instancecount as GLsizei, byval baseinstance as GLuint)
	declare sub glDrawElementsInstancedBaseInstance(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval instancecount as GLsizei, byval baseinstance as GLuint)
	declare sub glDrawElementsInstancedBaseVertexBaseInstance(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval instancecount as GLsizei, byval basevertex as GLint, byval baseinstance as GLuint)
	declare sub glGetInternalformativ(byval target as GLenum, byval internalformat as GLenum, byval pname as GLenum, byval bufSize as GLsizei, byval params as GLint ptr)
	declare sub glGetActiveAtomicCounterBufferiv(byval program as GLuint, byval bufferIndex as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glBindImageTexture(byval unit as GLuint, byval texture as GLuint, byval level as GLint, byval layered as GLboolean, byval layer as GLint, byval access as GLenum, byval format as GLenum)
	declare sub glMemoryBarrier(byval barriers as GLbitfield)
	declare sub glTexStorage1D(byval target as GLenum, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei)
	declare sub glTexStorage2D(byval target as GLenum, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
	declare sub glTexStorage3D(byval target as GLenum, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei)
	declare sub glDrawTransformFeedbackInstanced(byval mode as GLenum, byval id as GLuint, byval instancecount as GLsizei)
	declare sub glDrawTransformFeedbackStreamInstanced(byval mode as GLenum, byval id as GLuint, byval stream as GLuint, byval instancecount as GLsizei)
#endif

const GL_VERSION_4_3 = 1
type GLDEBUGPROC as sub(byval source as GLenum, byval type as GLenum, byval id as GLuint, byval severity as GLenum, byval length as GLsizei, byval message as const GLchar ptr, byval userParam as const any ptr)
const GL_NUM_SHADING_LANGUAGE_VERSIONS = &h82E9
const GL_VERTEX_ATTRIB_ARRAY_LONG = &h874E
const GL_COMPRESSED_RGB8_ETC2 = &h9274
const GL_COMPRESSED_SRGB8_ETC2 = &h9275
const GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 = &h9276
const GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 = &h9277
const GL_COMPRESSED_RGBA8_ETC2_EAC = &h9278
const GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC = &h9279
const GL_COMPRESSED_R11_EAC = &h9270
const GL_COMPRESSED_SIGNED_R11_EAC = &h9271
const GL_COMPRESSED_RG11_EAC = &h9272
const GL_COMPRESSED_SIGNED_RG11_EAC = &h9273
const GL_PRIMITIVE_RESTART_FIXED_INDEX = &h8D69
const GL_ANY_SAMPLES_PASSED_CONSERVATIVE = &h8D6A
const GL_MAX_ELEMENT_INDEX = &h8D6B
const GL_COMPUTE_SHADER = &h91B9
const GL_MAX_COMPUTE_UNIFORM_BLOCKS = &h91BB
const GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS = &h91BC
const GL_MAX_COMPUTE_IMAGE_UNIFORMS = &h91BD
const GL_MAX_COMPUTE_SHARED_MEMORY_SIZE = &h8262
const GL_MAX_COMPUTE_UNIFORM_COMPONENTS = &h8263
const GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS = &h8264
const GL_MAX_COMPUTE_ATOMIC_COUNTERS = &h8265
const GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS = &h8266
const GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS = &h90EB
const GL_MAX_COMPUTE_WORK_GROUP_COUNT = &h91BE
const GL_MAX_COMPUTE_WORK_GROUP_SIZE = &h91BF
const GL_COMPUTE_WORK_GROUP_SIZE = &h8267
const GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER = &h90EC
const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER = &h90ED
const GL_DISPATCH_INDIRECT_BUFFER = &h90EE
const GL_DISPATCH_INDIRECT_BUFFER_BINDING = &h90EF
const GL_COMPUTE_SHADER_BIT = &h00000020
const GL_DEBUG_OUTPUT_SYNCHRONOUS = &h8242
const GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH = &h8243
const GL_DEBUG_CALLBACK_FUNCTION = &h8244
const GL_DEBUG_CALLBACK_USER_PARAM = &h8245
const GL_DEBUG_SOURCE_API = &h8246
const GL_DEBUG_SOURCE_WINDOW_SYSTEM = &h8247
const GL_DEBUG_SOURCE_SHADER_COMPILER = &h8248
const GL_DEBUG_SOURCE_THIRD_PARTY = &h8249
const GL_DEBUG_SOURCE_APPLICATION = &h824A
const GL_DEBUG_SOURCE_OTHER = &h824B
const GL_DEBUG_TYPE_ERROR = &h824C
const GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR = &h824D
const GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR = &h824E
const GL_DEBUG_TYPE_PORTABILITY = &h824F
const GL_DEBUG_TYPE_PERFORMANCE = &h8250
const GL_DEBUG_TYPE_OTHER = &h8251
const GL_MAX_DEBUG_MESSAGE_LENGTH = &h9143
const GL_MAX_DEBUG_LOGGED_MESSAGES = &h9144
const GL_DEBUG_LOGGED_MESSAGES = &h9145
const GL_DEBUG_SEVERITY_HIGH = &h9146
const GL_DEBUG_SEVERITY_MEDIUM = &h9147
const GL_DEBUG_SEVERITY_LOW = &h9148
const GL_DEBUG_TYPE_MARKER = &h8268
const GL_DEBUG_TYPE_PUSH_GROUP = &h8269
const GL_DEBUG_TYPE_POP_GROUP = &h826A
const GL_DEBUG_SEVERITY_NOTIFICATION = &h826B
const GL_MAX_DEBUG_GROUP_STACK_DEPTH = &h826C
const GL_DEBUG_GROUP_STACK_DEPTH = &h826D
const GL_BUFFER = &h82E0
const GL_SHADER = &h82E1
const GL_PROGRAM = &h82E2
const GL_QUERY = &h82E3
const GL_PROGRAM_PIPELINE = &h82E4
const GL_SAMPLER = &h82E6
const GL_MAX_LABEL_LENGTH = &h82E8
const GL_DEBUG_OUTPUT = &h92E0
const GL_CONTEXT_FLAG_DEBUG_BIT = &h00000002
const GL_MAX_UNIFORM_LOCATIONS = &h826E
const GL_FRAMEBUFFER_DEFAULT_WIDTH = &h9310
const GL_FRAMEBUFFER_DEFAULT_HEIGHT = &h9311
const GL_FRAMEBUFFER_DEFAULT_LAYERS = &h9312
const GL_FRAMEBUFFER_DEFAULT_SAMPLES = &h9313
const GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS = &h9314
const GL_MAX_FRAMEBUFFER_WIDTH = &h9315
const GL_MAX_FRAMEBUFFER_HEIGHT = &h9316
const GL_MAX_FRAMEBUFFER_LAYERS = &h9317
const GL_MAX_FRAMEBUFFER_SAMPLES = &h9318
const GL_INTERNALFORMAT_SUPPORTED = &h826F
const GL_INTERNALFORMAT_PREFERRED = &h8270
const GL_INTERNALFORMAT_RED_SIZE = &h8271
const GL_INTERNALFORMAT_GREEN_SIZE = &h8272
const GL_INTERNALFORMAT_BLUE_SIZE = &h8273
const GL_INTERNALFORMAT_ALPHA_SIZE = &h8274
const GL_INTERNALFORMAT_DEPTH_SIZE = &h8275
const GL_INTERNALFORMAT_STENCIL_SIZE = &h8276
const GL_INTERNALFORMAT_SHARED_SIZE = &h8277
const GL_INTERNALFORMAT_RED_TYPE = &h8278
const GL_INTERNALFORMAT_GREEN_TYPE = &h8279
const GL_INTERNALFORMAT_BLUE_TYPE = &h827A
const GL_INTERNALFORMAT_ALPHA_TYPE = &h827B
const GL_INTERNALFORMAT_DEPTH_TYPE = &h827C
const GL_INTERNALFORMAT_STENCIL_TYPE = &h827D
const GL_MAX_WIDTH = &h827E
const GL_MAX_HEIGHT = &h827F
const GL_MAX_DEPTH = &h8280
const GL_MAX_LAYERS = &h8281
const GL_MAX_COMBINED_DIMENSIONS = &h8282
const GL_COLOR_COMPONENTS = &h8283
const GL_DEPTH_COMPONENTS = &h8284
const GL_STENCIL_COMPONENTS = &h8285
const GL_COLOR_RENDERABLE = &h8286
const GL_DEPTH_RENDERABLE = &h8287
const GL_STENCIL_RENDERABLE = &h8288
const GL_FRAMEBUFFER_RENDERABLE = &h8289
const GL_FRAMEBUFFER_RENDERABLE_LAYERED = &h828A
const GL_FRAMEBUFFER_BLEND = &h828B
const GL_READ_PIXELS = &h828C
const GL_READ_PIXELS_FORMAT = &h828D
const GL_READ_PIXELS_TYPE = &h828E
const GL_TEXTURE_IMAGE_FORMAT = &h828F
const GL_TEXTURE_IMAGE_TYPE = &h8290
const GL_GET_TEXTURE_IMAGE_FORMAT = &h8291
const GL_GET_TEXTURE_IMAGE_TYPE = &h8292
const GL_MIPMAP = &h8293
const GL_MANUAL_GENERATE_MIPMAP = &h8294
const GL_AUTO_GENERATE_MIPMAP = &h8295
const GL_COLOR_ENCODING = &h8296
const GL_SRGB_READ = &h8297
const GL_SRGB_WRITE = &h8298
const GL_FILTER = &h829A
const GL_VERTEX_TEXTURE = &h829B
const GL_TESS_CONTROL_TEXTURE = &h829C
const GL_TESS_EVALUATION_TEXTURE = &h829D
const GL_GEOMETRY_TEXTURE = &h829E
const GL_FRAGMENT_TEXTURE = &h829F
const GL_COMPUTE_TEXTURE = &h82A0
const GL_TEXTURE_SHADOW = &h82A1
const GL_TEXTURE_GATHER = &h82A2
const GL_TEXTURE_GATHER_SHADOW = &h82A3
const GL_SHADER_IMAGE_LOAD = &h82A4
const GL_SHADER_IMAGE_STORE = &h82A5
const GL_SHADER_IMAGE_ATOMIC = &h82A6
const GL_IMAGE_TEXEL_SIZE = &h82A7
const GL_IMAGE_COMPATIBILITY_CLASS = &h82A8
const GL_IMAGE_PIXEL_FORMAT = &h82A9
const GL_IMAGE_PIXEL_TYPE = &h82AA
const GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST = &h82AC
const GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST = &h82AD
const GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE = &h82AE
const GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE = &h82AF
const GL_TEXTURE_COMPRESSED_BLOCK_WIDTH = &h82B1
const GL_TEXTURE_COMPRESSED_BLOCK_HEIGHT = &h82B2
const GL_TEXTURE_COMPRESSED_BLOCK_SIZE = &h82B3
const GL_CLEAR_BUFFER = &h82B4
const GL_TEXTURE_VIEW = &h82B5
const GL_VIEW_COMPATIBILITY_CLASS = &h82B6
const GL_FULL_SUPPORT = &h82B7
const GL_CAVEAT_SUPPORT = &h82B8
const GL_IMAGE_CLASS_4_X_32 = &h82B9
const GL_IMAGE_CLASS_2_X_32 = &h82BA
const GL_IMAGE_CLASS_1_X_32 = &h82BB
const GL_IMAGE_CLASS_4_X_16 = &h82BC
const GL_IMAGE_CLASS_2_X_16 = &h82BD
const GL_IMAGE_CLASS_1_X_16 = &h82BE
const GL_IMAGE_CLASS_4_X_8 = &h82BF
const GL_IMAGE_CLASS_2_X_8 = &h82C0
const GL_IMAGE_CLASS_1_X_8 = &h82C1
const GL_IMAGE_CLASS_11_11_10 = &h82C2
const GL_IMAGE_CLASS_10_10_10_2 = &h82C3
const GL_VIEW_CLASS_128_BITS = &h82C4
const GL_VIEW_CLASS_96_BITS = &h82C5
const GL_VIEW_CLASS_64_BITS = &h82C6
const GL_VIEW_CLASS_48_BITS = &h82C7
const GL_VIEW_CLASS_32_BITS = &h82C8
const GL_VIEW_CLASS_24_BITS = &h82C9
const GL_VIEW_CLASS_16_BITS = &h82CA
const GL_VIEW_CLASS_8_BITS = &h82CB
const GL_VIEW_CLASS_S3TC_DXT1_RGB = &h82CC
const GL_VIEW_CLASS_S3TC_DXT1_RGBA = &h82CD
const GL_VIEW_CLASS_S3TC_DXT3_RGBA = &h82CE
const GL_VIEW_CLASS_S3TC_DXT5_RGBA = &h82CF
const GL_VIEW_CLASS_RGTC1_RED = &h82D0
const GL_VIEW_CLASS_RGTC2_RG = &h82D1
const GL_VIEW_CLASS_BPTC_UNORM = &h82D2
const GL_VIEW_CLASS_BPTC_FLOAT = &h82D3
const GL_UNIFORM = &h92E1
const GL_UNIFORM_BLOCK = &h92E2
const GL_PROGRAM_INPUT = &h92E3
const GL_PROGRAM_OUTPUT = &h92E4
const GL_BUFFER_VARIABLE = &h92E5
const GL_SHADER_STORAGE_BLOCK = &h92E6
const GL_VERTEX_SUBROUTINE = &h92E8
const GL_TESS_CONTROL_SUBROUTINE = &h92E9
const GL_TESS_EVALUATION_SUBROUTINE = &h92EA
const GL_GEOMETRY_SUBROUTINE = &h92EB
const GL_FRAGMENT_SUBROUTINE = &h92EC
const GL_COMPUTE_SUBROUTINE = &h92ED
const GL_VERTEX_SUBROUTINE_UNIFORM = &h92EE
const GL_TESS_CONTROL_SUBROUTINE_UNIFORM = &h92EF
const GL_TESS_EVALUATION_SUBROUTINE_UNIFORM = &h92F0
const GL_GEOMETRY_SUBROUTINE_UNIFORM = &h92F1
const GL_FRAGMENT_SUBROUTINE_UNIFORM = &h92F2
const GL_COMPUTE_SUBROUTINE_UNIFORM = &h92F3
const GL_TRANSFORM_FEEDBACK_VARYING = &h92F4
const GL_ACTIVE_RESOURCES = &h92F5
const GL_MAX_NAME_LENGTH = &h92F6
const GL_MAX_NUM_ACTIVE_VARIABLES = &h92F7
const GL_MAX_NUM_COMPATIBLE_SUBROUTINES = &h92F8
const GL_NAME_LENGTH = &h92F9
const GL_TYPE = &h92FA
const GL_ARRAY_SIZE = &h92FB
const GL_OFFSET = &h92FC
const GL_BLOCK_INDEX = &h92FD
const GL_ARRAY_STRIDE = &h92FE
const GL_MATRIX_STRIDE = &h92FF
const GL_IS_ROW_MAJOR = &h9300
const GL_ATOMIC_COUNTER_BUFFER_INDEX = &h9301
const GL_BUFFER_BINDING = &h9302
const GL_BUFFER_DATA_SIZE = &h9303
const GL_NUM_ACTIVE_VARIABLES = &h9304
const GL_ACTIVE_VARIABLES = &h9305
const GL_REFERENCED_BY_VERTEX_SHADER = &h9306
const GL_REFERENCED_BY_TESS_CONTROL_SHADER = &h9307
const GL_REFERENCED_BY_TESS_EVALUATION_SHADER = &h9308
const GL_REFERENCED_BY_GEOMETRY_SHADER = &h9309
const GL_REFERENCED_BY_FRAGMENT_SHADER = &h930A
const GL_REFERENCED_BY_COMPUTE_SHADER = &h930B
const GL_TOP_LEVEL_ARRAY_SIZE = &h930C
const GL_TOP_LEVEL_ARRAY_STRIDE = &h930D
const GL_LOCATION = &h930E
const GL_LOCATION_INDEX = &h930F
const GL_IS_PER_PATCH = &h92E7
const GL_SHADER_STORAGE_BUFFER = &h90D2
const GL_SHADER_STORAGE_BUFFER_BINDING = &h90D3
const GL_SHADER_STORAGE_BUFFER_START = &h90D4
const GL_SHADER_STORAGE_BUFFER_SIZE = &h90D5
const GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS = &h90D6
const GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS = &h90D7
const GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS = &h90D8
const GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS = &h90D9
const GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS = &h90DA
const GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS = &h90DB
const GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS = &h90DC
const GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS = &h90DD
const GL_MAX_SHADER_STORAGE_BLOCK_SIZE = &h90DE
const GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT = &h90DF
const GL_SHADER_STORAGE_BARRIER_BIT = &h00002000
const GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES = &h8F39
const GL_DEPTH_STENCIL_TEXTURE_MODE = &h90EA
const GL_TEXTURE_BUFFER_OFFSET = &h919D
const GL_TEXTURE_BUFFER_SIZE = &h919E
const GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT = &h919F
const GL_TEXTURE_VIEW_MIN_LEVEL = &h82DB
const GL_TEXTURE_VIEW_NUM_LEVELS = &h82DC
const GL_TEXTURE_VIEW_MIN_LAYER = &h82DD
const GL_TEXTURE_VIEW_NUM_LAYERS = &h82DE
const GL_TEXTURE_IMMUTABLE_LEVELS = &h82DF
const GL_VERTEX_ATTRIB_BINDING = &h82D4
const GL_VERTEX_ATTRIB_RELATIVE_OFFSET = &h82D5
const GL_VERTEX_BINDING_DIVISOR = &h82D6
const GL_VERTEX_BINDING_OFFSET = &h82D7
const GL_VERTEX_BINDING_STRIDE = &h82D8
const GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET = &h82D9
const GL_MAX_VERTEX_ATTRIB_BINDINGS = &h82DA
const GL_VERTEX_BINDING_BUFFER = &h8F4F
const GL_DISPLAY_LIST = &h82E7

type PFNGLCLEARBUFFERDATAPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
type PFNGLCLEARBUFFERSUBDATAPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval offset as GLintptr, byval size as GLsizeiptr, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
type PFNGLDISPATCHCOMPUTEPROC as sub(byval num_groups_x as GLuint, byval num_groups_y as GLuint, byval num_groups_z as GLuint)
type PFNGLDISPATCHCOMPUTEINDIRECTPROC as sub(byval indirect as GLintptr)
type PFNGLCOPYIMAGESUBDATAPROC as sub(byval srcName as GLuint, byval srcTarget as GLenum, byval srcLevel as GLint, byval srcX as GLint, byval srcY as GLint, byval srcZ as GLint, byval dstName as GLuint, byval dstTarget as GLenum, byval dstLevel as GLint, byval dstX as GLint, byval dstY as GLint, byval dstZ as GLint, byval srcWidth as GLsizei, byval srcHeight as GLsizei, byval srcDepth as GLsizei)
type PFNGLFRAMEBUFFERPARAMETERIPROC as sub(byval target as GLenum, byval pname as GLenum, byval param as GLint)
type PFNGLGETFRAMEBUFFERPARAMETERIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETINTERNALFORMATI64VPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval pname as GLenum, byval bufSize as GLsizei, byval params as GLint64 ptr)
type PFNGLINVALIDATETEXSUBIMAGEPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei)
type PFNGLINVALIDATETEXIMAGEPROC as sub(byval texture as GLuint, byval level as GLint)
type PFNGLINVALIDATEBUFFERSUBDATAPROC as sub(byval buffer as GLuint, byval offset as GLintptr, byval length as GLsizeiptr)
type PFNGLINVALIDATEBUFFERDATAPROC as sub(byval buffer as GLuint)
type PFNGLINVALIDATEFRAMEBUFFERPROC as sub(byval target as GLenum, byval numAttachments as GLsizei, byval attachments as const GLenum ptr)
type PFNGLINVALIDATESUBFRAMEBUFFERPROC as sub(byval target as GLenum, byval numAttachments as GLsizei, byval attachments as const GLenum ptr, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
type PFNGLMULTIDRAWARRAYSINDIRECTPROC as sub(byval mode as GLenum, byval indirect as const any ptr, byval drawcount as GLsizei, byval stride as GLsizei)
type PFNGLMULTIDRAWELEMENTSINDIRECTPROC as sub(byval mode as GLenum, byval type as GLenum, byval indirect as const any ptr, byval drawcount as GLsizei, byval stride as GLsizei)
type PFNGLGETPROGRAMINTERFACEIVPROC as sub(byval program as GLuint, byval programInterface as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETPROGRAMRESOURCEINDEXPROC as function(byval program as GLuint, byval programInterface as GLenum, byval name as const GLchar ptr) as GLuint
type PFNGLGETPROGRAMRESOURCENAMEPROC as sub(byval program as GLuint, byval programInterface as GLenum, byval index as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval name as GLchar ptr)
type PFNGLGETPROGRAMRESOURCEIVPROC as sub(byval program as GLuint, byval programInterface as GLenum, byval index as GLuint, byval propCount as GLsizei, byval props as const GLenum ptr, byval bufSize as GLsizei, byval length as GLsizei ptr, byval params as GLint ptr)
type PFNGLGETPROGRAMRESOURCELOCATIONPROC as function(byval program as GLuint, byval programInterface as GLenum, byval name as const GLchar ptr) as GLint
type PFNGLGETPROGRAMRESOURCELOCATIONINDEXPROC as function(byval program as GLuint, byval programInterface as GLenum, byval name as const GLchar ptr) as GLint
type PFNGLSHADERSTORAGEBLOCKBINDINGPROC as sub(byval program as GLuint, byval storageBlockIndex as GLuint, byval storageBlockBinding as GLuint)
type PFNGLTEXBUFFERRANGEPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr)
type PFNGLTEXSTORAGE2DMULTISAMPLEPROC as sub(byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval fixedsamplelocations as GLboolean)
type PFNGLTEXSTORAGE3DMULTISAMPLEPROC as sub(byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedsamplelocations as GLboolean)
type PFNGLTEXTUREVIEWPROC as sub(byval texture as GLuint, byval target as GLenum, byval origtexture as GLuint, byval internalformat as GLenum, byval minlevel as GLuint, byval numlevels as GLuint, byval minlayer as GLuint, byval numlayers as GLuint)
type PFNGLBINDVERTEXBUFFERPROC as sub(byval bindingindex as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval stride as GLsizei)
type PFNGLVERTEXATTRIBFORMATPROC as sub(byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval relativeoffset as GLuint)
type PFNGLVERTEXATTRIBIFORMATPROC as sub(byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval relativeoffset as GLuint)
type PFNGLVERTEXATTRIBLFORMATPROC as sub(byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval relativeoffset as GLuint)
type PFNGLVERTEXATTRIBBINDINGPROC as sub(byval attribindex as GLuint, byval bindingindex as GLuint)
type PFNGLVERTEXBINDINGDIVISORPROC as sub(byval bindingindex as GLuint, byval divisor as GLuint)
type PFNGLDEBUGMESSAGECONTROLPROC as sub(byval source as GLenum, byval type as GLenum, byval severity as GLenum, byval count as GLsizei, byval ids as const GLuint ptr, byval enabled as GLboolean)
type PFNGLDEBUGMESSAGEINSERTPROC as sub(byval source as GLenum, byval type as GLenum, byval id as GLuint, byval severity as GLenum, byval length as GLsizei, byval buf as const GLchar ptr)
type PFNGLDEBUGMESSAGECALLBACKPROC as sub(byval callback as GLDEBUGPROC, byval userParam as const any ptr)
type PFNGLGETDEBUGMESSAGELOGPROC as function(byval count as GLuint, byval bufSize as GLsizei, byval sources as GLenum ptr, byval types as GLenum ptr, byval ids as GLuint ptr, byval severities as GLenum ptr, byval lengths as GLsizei ptr, byval messageLog as GLchar ptr) as GLuint
type PFNGLPUSHDEBUGGROUPPROC as sub(byval source as GLenum, byval id as GLuint, byval length as GLsizei, byval message as const GLchar ptr)
type PFNGLPOPDEBUGGROUPPROC as sub()
type PFNGLOBJECTLABELPROC as sub(byval identifier as GLenum, byval name as GLuint, byval length as GLsizei, byval label as const GLchar ptr)
type PFNGLGETOBJECTLABELPROC as sub(byval identifier as GLenum, byval name as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval label as GLchar ptr)
type PFNGLOBJECTPTRLABELPROC as sub(byval ptr as const any ptr, byval length as GLsizei, byval label as const GLchar ptr)
type PFNGLGETOBJECTPTRLABELPROC as sub(byval ptr as const any ptr, byval bufSize as GLsizei, byval length as GLsizei ptr, byval label as GLchar ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glClearBufferData(byval target as GLenum, byval internalformat as GLenum, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
	declare sub glClearBufferSubData(byval target as GLenum, byval internalformat as GLenum, byval offset as GLintptr, byval size as GLsizeiptr, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
	declare sub glDispatchCompute(byval num_groups_x as GLuint, byval num_groups_y as GLuint, byval num_groups_z as GLuint)
	declare sub glDispatchComputeIndirect(byval indirect as GLintptr)
	declare sub glCopyImageSubData(byval srcName as GLuint, byval srcTarget as GLenum, byval srcLevel as GLint, byval srcX as GLint, byval srcY as GLint, byval srcZ as GLint, byval dstName as GLuint, byval dstTarget as GLenum, byval dstLevel as GLint, byval dstX as GLint, byval dstY as GLint, byval dstZ as GLint, byval srcWidth as GLsizei, byval srcHeight as GLsizei, byval srcDepth as GLsizei)
	declare sub glFramebufferParameteri(byval target as GLenum, byval pname as GLenum, byval param as GLint)
	declare sub glGetFramebufferParameteriv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetInternalformati64v(byval target as GLenum, byval internalformat as GLenum, byval pname as GLenum, byval bufSize as GLsizei, byval params as GLint64 ptr)
	declare sub glInvalidateTexSubImage(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei)
	declare sub glInvalidateTexImage(byval texture as GLuint, byval level as GLint)
	declare sub glInvalidateBufferSubData(byval buffer as GLuint, byval offset as GLintptr, byval length as GLsizeiptr)
	declare sub glInvalidateBufferData(byval buffer as GLuint)
	declare sub glInvalidateFramebuffer(byval target as GLenum, byval numAttachments as GLsizei, byval attachments as const GLenum ptr)
	declare sub glInvalidateSubFramebuffer(byval target as GLenum, byval numAttachments as GLsizei, byval attachments as const GLenum ptr, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
	declare sub glMultiDrawArraysIndirect(byval mode as GLenum, byval indirect as const any ptr, byval drawcount as GLsizei, byval stride as GLsizei)
	declare sub glMultiDrawElementsIndirect(byval mode as GLenum, byval type as GLenum, byval indirect as const any ptr, byval drawcount as GLsizei, byval stride as GLsizei)
	declare sub glGetProgramInterfaceiv(byval program as GLuint, byval programInterface as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare function glGetProgramResourceIndex(byval program as GLuint, byval programInterface as GLenum, byval name as const GLchar ptr) as GLuint
	declare sub glGetProgramResourceName(byval program as GLuint, byval programInterface as GLenum, byval index as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval name as GLchar ptr)
	declare sub glGetProgramResourceiv(byval program as GLuint, byval programInterface as GLenum, byval index as GLuint, byval propCount as GLsizei, byval props as const GLenum ptr, byval bufSize as GLsizei, byval length as GLsizei ptr, byval params as GLint ptr)
	declare function glGetProgramResourceLocation(byval program as GLuint, byval programInterface as GLenum, byval name as const GLchar ptr) as GLint
	declare function glGetProgramResourceLocationIndex(byval program as GLuint, byval programInterface as GLenum, byval name as const GLchar ptr) as GLint
	declare sub glShaderStorageBlockBinding(byval program as GLuint, byval storageBlockIndex as GLuint, byval storageBlockBinding as GLuint)
	declare sub glTexBufferRange(byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr)
	declare sub glTexStorage2DMultisample(byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval fixedsamplelocations as GLboolean)
	declare sub glTexStorage3DMultisample(byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedsamplelocations as GLboolean)
	declare sub glTextureView(byval texture as GLuint, byval target as GLenum, byval origtexture as GLuint, byval internalformat as GLenum, byval minlevel as GLuint, byval numlevels as GLuint, byval minlayer as GLuint, byval numlayers as GLuint)
	declare sub glBindVertexBuffer(byval bindingindex as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval stride as GLsizei)
	declare sub glVertexAttribFormat(byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval relativeoffset as GLuint)
	declare sub glVertexAttribIFormat(byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval relativeoffset as GLuint)
	declare sub glVertexAttribLFormat(byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval relativeoffset as GLuint)
	declare sub glVertexAttribBinding(byval attribindex as GLuint, byval bindingindex as GLuint)
	declare sub glVertexBindingDivisor(byval bindingindex as GLuint, byval divisor as GLuint)
	declare sub glDebugMessageControl(byval source as GLenum, byval type as GLenum, byval severity as GLenum, byval count as GLsizei, byval ids as const GLuint ptr, byval enabled as GLboolean)
	declare sub glDebugMessageInsert(byval source as GLenum, byval type as GLenum, byval id as GLuint, byval severity as GLenum, byval length as GLsizei, byval buf as const GLchar ptr)
	declare sub glDebugMessageCallback(byval callback as GLDEBUGPROC, byval userParam as const any ptr)
	declare function glGetDebugMessageLog(byval count as GLuint, byval bufSize as GLsizei, byval sources as GLenum ptr, byval types as GLenum ptr, byval ids as GLuint ptr, byval severities as GLenum ptr, byval lengths as GLsizei ptr, byval messageLog as GLchar ptr) as GLuint
	declare sub glPushDebugGroup(byval source as GLenum, byval id as GLuint, byval length as GLsizei, byval message as const GLchar ptr)
	declare sub glPopDebugGroup()
	declare sub glObjectLabel(byval identifier as GLenum, byval name as GLuint, byval length as GLsizei, byval label as const GLchar ptr)
	declare sub glGetObjectLabel(byval identifier as GLenum, byval name as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval label as GLchar ptr)
	declare sub glObjectPtrLabel(byval ptr as const any ptr, byval length as GLsizei, byval label as const GLchar ptr)
	declare sub glGetObjectPtrLabel(byval ptr as const any ptr, byval bufSize as GLsizei, byval length as GLsizei ptr, byval label as GLchar ptr)
#endif

const GL_VERSION_4_4 = 1
const GL_MAX_VERTEX_ATTRIB_STRIDE = &h82E5
const GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED = &h8221
const GL_TEXTURE_BUFFER_BINDING = &h8C2A
const GL_MAP_PERSISTENT_BIT = &h0040
const GL_MAP_COHERENT_BIT = &h0080
const GL_DYNAMIC_STORAGE_BIT = &h0100
const GL_CLIENT_STORAGE_BIT = &h0200
const GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT = &h00004000
const GL_BUFFER_IMMUTABLE_STORAGE = &h821F
const GL_BUFFER_STORAGE_FLAGS = &h8220
const GL_CLEAR_TEXTURE = &h9365
const GL_LOCATION_COMPONENT = &h934A
const GL_TRANSFORM_FEEDBACK_BUFFER_INDEX = &h934B
const GL_TRANSFORM_FEEDBACK_BUFFER_STRIDE = &h934C
const GL_QUERY_BUFFER = &h9192
const GL_QUERY_BUFFER_BARRIER_BIT = &h00008000
const GL_QUERY_BUFFER_BINDING = &h9193
const GL_QUERY_RESULT_NO_WAIT = &h9194
const GL_MIRROR_CLAMP_TO_EDGE = &h8743

type PFNGLBUFFERSTORAGEPROC as sub(byval target as GLenum, byval size as GLsizeiptr, byval data as const any ptr, byval flags as GLbitfield)
type PFNGLCLEARTEXIMAGEPROC as sub(byval texture as GLuint, byval level as GLint, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
type PFNGLCLEARTEXSUBIMAGEPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
type PFNGLBINDBUFFERSBASEPROC as sub(byval target as GLenum, byval first as GLuint, byval count as GLsizei, byval buffers as const GLuint ptr)
type PFNGLBINDBUFFERSRANGEPROC as sub(byval target as GLenum, byval first as GLuint, byval count as GLsizei, byval buffers as const GLuint ptr, byval offsets as const GLintptr ptr, byval sizes as const GLsizeiptr ptr)
type PFNGLBINDTEXTURESPROC as sub(byval first as GLuint, byval count as GLsizei, byval textures as const GLuint ptr)
type PFNGLBINDSAMPLERSPROC as sub(byval first as GLuint, byval count as GLsizei, byval samplers as const GLuint ptr)
type PFNGLBINDIMAGETEXTURESPROC as sub(byval first as GLuint, byval count as GLsizei, byval textures as const GLuint ptr)
type PFNGLBINDVERTEXBUFFERSPROC as sub(byval first as GLuint, byval count as GLsizei, byval buffers as const GLuint ptr, byval offsets as const GLintptr ptr, byval strides as const GLsizei ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBufferStorage(byval target as GLenum, byval size as GLsizeiptr, byval data as const any ptr, byval flags as GLbitfield)
	declare sub glClearTexImage(byval texture as GLuint, byval level as GLint, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
	declare sub glClearTexSubImage(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
	declare sub glBindBuffersBase(byval target as GLenum, byval first as GLuint, byval count as GLsizei, byval buffers as const GLuint ptr)
	declare sub glBindBuffersRange(byval target as GLenum, byval first as GLuint, byval count as GLsizei, byval buffers as const GLuint ptr, byval offsets as const GLintptr ptr, byval sizes as const GLsizeiptr ptr)
	declare sub glBindTextures(byval first as GLuint, byval count as GLsizei, byval textures as const GLuint ptr)
	declare sub glBindSamplers(byval first as GLuint, byval count as GLsizei, byval samplers as const GLuint ptr)
	declare sub glBindImageTextures(byval first as GLuint, byval count as GLsizei, byval textures as const GLuint ptr)
	declare sub glBindVertexBuffers(byval first as GLuint, byval count as GLsizei, byval buffers as const GLuint ptr, byval offsets as const GLintptr ptr, byval strides as const GLsizei ptr)
#endif

const GL_VERSION_4_5 = 1
const GL_CONTEXT_LOST = &h0507
const GL_NEGATIVE_ONE_TO_ONE = &h935E
const GL_ZERO_TO_ONE = &h935F
const GL_CLIP_ORIGIN = &h935C
const GL_CLIP_DEPTH_MODE = &h935D
const GL_QUERY_WAIT_INVERTED = &h8E17
const GL_QUERY_NO_WAIT_INVERTED = &h8E18
const GL_QUERY_BY_REGION_WAIT_INVERTED = &h8E19
const GL_QUERY_BY_REGION_NO_WAIT_INVERTED = &h8E1A
const GL_MAX_CULL_DISTANCES = &h82F9
const GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES = &h82FA
const GL_TEXTURE_TARGET = &h1006
const GL_QUERY_TARGET = &h82EA
const GL_TEXTURE_BINDING = &h82EB
const GL_GUILTY_CONTEXT_RESET = &h8253
const GL_INNOCENT_CONTEXT_RESET = &h8254
const GL_UNKNOWN_CONTEXT_RESET = &h8255
const GL_RESET_NOTIFICATION_STRATEGY = &h8256
const GL_LOSE_CONTEXT_ON_RESET = &h8252
const GL_NO_RESET_NOTIFICATION = &h8261
const GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT = &h00000004
const GL_CONTEXT_RELEASE_BEHAVIOR = &h82FB
const GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = &h82FC

type PFNGLCLIPCONTROLPROC as sub(byval origin as GLenum, byval depth as GLenum)
type PFNGLCREATETRANSFORMFEEDBACKSPROC as sub(byval n as GLsizei, byval ids as GLuint ptr)
type PFNGLTRANSFORMFEEDBACKBUFFERBASEPROC as sub(byval xfb as GLuint, byval index as GLuint, byval buffer as GLuint)
type PFNGLTRANSFORMFEEDBACKBUFFERRANGEPROC as sub(byval xfb as GLuint, byval index as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizei)
type PFNGLGETTRANSFORMFEEDBACKIVPROC as sub(byval xfb as GLuint, byval pname as GLenum, byval param as GLint ptr)
type PFNGLGETTRANSFORMFEEDBACKI_VPROC as sub(byval xfb as GLuint, byval pname as GLenum, byval index as GLuint, byval param as GLint ptr)
type PFNGLGETTRANSFORMFEEDBACKI64_VPROC as sub(byval xfb as GLuint, byval pname as GLenum, byval index as GLuint, byval param as GLint64 ptr)
type PFNGLCREATEBUFFERSPROC as sub(byval n as GLsizei, byval buffers as GLuint ptr)
type PFNGLNAMEDBUFFERSTORAGEPROC as sub(byval buffer as GLuint, byval size as GLsizei, byval data as const any ptr, byval flags as GLbitfield)
type PFNGLNAMEDBUFFERDATAPROC as sub(byval buffer as GLuint, byval size as GLsizei, byval data as const any ptr, byval usage as GLenum)
type PFNGLNAMEDBUFFERSUBDATAPROC as sub(byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizei, byval data as const any ptr)
type PFNGLCOPYNAMEDBUFFERSUBDATAPROC as sub(byval readBuffer as GLuint, byval writeBuffer as GLuint, byval readOffset as GLintptr, byval writeOffset as GLintptr, byval size as GLsizei)
type PFNGLCLEARNAMEDBUFFERDATAPROC as sub(byval buffer as GLuint, byval internalformat as GLenum, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
type PFNGLCLEARNAMEDBUFFERSUBDATAPROC as sub(byval buffer as GLuint, byval internalformat as GLenum, byval offset as GLintptr, byval size as GLsizei, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
type PFNGLMAPNAMEDBUFFERPROC as function(byval buffer as GLuint, byval access as GLenum) as any ptr
type PFNGLMAPNAMEDBUFFERRANGEPROC as function(byval buffer as GLuint, byval offset as GLintptr, byval length as GLsizei, byval access as GLbitfield) as any ptr
type PFNGLUNMAPNAMEDBUFFERPROC as function(byval buffer as GLuint) as GLboolean
type PFNGLFLUSHMAPPEDNAMEDBUFFERRANGEPROC as sub(byval buffer as GLuint, byval offset as GLintptr, byval length as GLsizei)
type PFNGLGETNAMEDBUFFERPARAMETERIVPROC as sub(byval buffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETNAMEDBUFFERPARAMETERI64VPROC as sub(byval buffer as GLuint, byval pname as GLenum, byval params as GLint64 ptr)
type PFNGLGETNAMEDBUFFERPOINTERVPROC as sub(byval buffer as GLuint, byval pname as GLenum, byval params as any ptr ptr)
type PFNGLGETNAMEDBUFFERSUBDATAPROC as sub(byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizei, byval data as any ptr)
type PFNGLCREATEFRAMEBUFFERSPROC as sub(byval n as GLsizei, byval framebuffers as GLuint ptr)
type PFNGLNAMEDFRAMEBUFFERRENDERBUFFERPROC as sub(byval framebuffer as GLuint, byval attachment as GLenum, byval renderbuffertarget as GLenum, byval renderbuffer as GLuint)
type PFNGLNAMEDFRAMEBUFFERPARAMETERIPROC as sub(byval framebuffer as GLuint, byval pname as GLenum, byval param as GLint)
type PFNGLNAMEDFRAMEBUFFERTEXTUREPROC as sub(byval framebuffer as GLuint, byval attachment as GLenum, byval texture as GLuint, byval level as GLint)
type PFNGLNAMEDFRAMEBUFFERTEXTURELAYERPROC as sub(byval framebuffer as GLuint, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval layer as GLint)
type PFNGLNAMEDFRAMEBUFFERDRAWBUFFERPROC as sub(byval framebuffer as GLuint, byval buf as GLenum)
type PFNGLNAMEDFRAMEBUFFERDRAWBUFFERSPROC as sub(byval framebuffer as GLuint, byval n as GLsizei, byval bufs as const GLenum ptr)
type PFNGLNAMEDFRAMEBUFFERREADBUFFERPROC as sub(byval framebuffer as GLuint, byval src as GLenum)
type PFNGLINVALIDATENAMEDFRAMEBUFFERDATAPROC as sub(byval framebuffer as GLuint, byval numAttachments as GLsizei, byval attachments as const GLenum ptr)
type PFNGLINVALIDATENAMEDFRAMEBUFFERSUBDATAPROC as sub(byval framebuffer as GLuint, byval numAttachments as GLsizei, byval attachments as const GLenum ptr, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
type PFNGLCLEARNAMEDFRAMEBUFFERIVPROC as sub(byval framebuffer as GLuint, byval buffer as GLenum, byval drawbuffer as GLint, byval value as const GLint ptr)
type PFNGLCLEARNAMEDFRAMEBUFFERUIVPROC as sub(byval framebuffer as GLuint, byval buffer as GLenum, byval drawbuffer as GLint, byval value as const GLuint ptr)
type PFNGLCLEARNAMEDFRAMEBUFFERFVPROC as sub(byval framebuffer as GLuint, byval buffer as GLenum, byval drawbuffer as GLint, byval value as const GLfloat ptr)
type PFNGLCLEARNAMEDFRAMEBUFFERFIPROC as sub(byval framebuffer as GLuint, byval buffer as GLenum, byval depth as const GLfloat, byval stencil as GLint)
type PFNGLBLITNAMEDFRAMEBUFFERPROC as sub(byval readFramebuffer as GLuint, byval drawFramebuffer as GLuint, byval srcX0 as GLint, byval srcY0 as GLint, byval srcX1 as GLint, byval srcY1 as GLint, byval dstX0 as GLint, byval dstY0 as GLint, byval dstX1 as GLint, byval dstY1 as GLint, byval mask as GLbitfield, byval filter as GLenum)
type PFNGLCHECKNAMEDFRAMEBUFFERSTATUSPROC as function(byval framebuffer as GLuint, byval target as GLenum) as GLenum
type PFNGLGETNAMEDFRAMEBUFFERPARAMETERIVPROC as sub(byval framebuffer as GLuint, byval pname as GLenum, byval param as GLint ptr)
type PFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVPROC as sub(byval framebuffer as GLuint, byval attachment as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLCREATERENDERBUFFERSPROC as sub(byval n as GLsizei, byval renderbuffers as GLuint ptr)
type PFNGLNAMEDRENDERBUFFERSTORAGEPROC as sub(byval renderbuffer as GLuint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
type PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEPROC as sub(byval renderbuffer as GLuint, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
type PFNGLGETNAMEDRENDERBUFFERPARAMETERIVPROC as sub(byval renderbuffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLCREATETEXTURESPROC as sub(byval target as GLenum, byval n as GLsizei, byval textures as GLuint ptr)
type PFNGLTEXTUREBUFFERPROC as sub(byval texture as GLuint, byval internalformat as GLenum, byval buffer as GLuint)
type PFNGLTEXTUREBUFFERRANGEPROC as sub(byval texture as GLuint, byval internalformat as GLenum, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizei)
type PFNGLTEXTURESTORAGE1DPROC as sub(byval texture as GLuint, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei)
type PFNGLTEXTURESTORAGE2DPROC as sub(byval texture as GLuint, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
type PFNGLTEXTURESTORAGE3DPROC as sub(byval texture as GLuint, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei)
type PFNGLTEXTURESTORAGE2DMULTISAMPLEPROC as sub(byval texture as GLuint, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval fixedsamplelocations as GLboolean)
type PFNGLTEXTURESTORAGE3DMULTISAMPLEPROC as sub(byval texture as GLuint, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedsamplelocations as GLboolean)
type PFNGLTEXTURESUBIMAGE1DPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLTEXTURESUBIMAGE2DPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLTEXTURESUBIMAGE3DPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLCOMPRESSEDTEXTURESUBIMAGE1DPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOMPRESSEDTEXTURESUBIMAGE2DPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOMPRESSEDTEXTURESUBIMAGE3DPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOPYTEXTURESUBIMAGE1DPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei)
type PFNGLCOPYTEXTURESUBIMAGE2DPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
type PFNGLCOPYTEXTURESUBIMAGE3DPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
type PFNGLTEXTUREPARAMETERFPROC as sub(byval texture as GLuint, byval pname as GLenum, byval param as GLfloat)
type PFNGLTEXTUREPARAMETERFVPROC as sub(byval texture as GLuint, byval pname as GLenum, byval param as const GLfloat ptr)
type PFNGLTEXTUREPARAMETERIPROC as sub(byval texture as GLuint, byval pname as GLenum, byval param as GLint)
type PFNGLTEXTUREPARAMETERIIVPROC as sub(byval texture as GLuint, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLTEXTUREPARAMETERIUIVPROC as sub(byval texture as GLuint, byval pname as GLenum, byval params as const GLuint ptr)
type PFNGLTEXTUREPARAMETERIVPROC as sub(byval texture as GLuint, byval pname as GLenum, byval param as const GLint ptr)
type PFNGLGENERATETEXTUREMIPMAPPROC as sub(byval texture as GLuint)
type PFNGLBINDTEXTUREUNITPROC as sub(byval unit as GLuint, byval texture as GLuint)
type PFNGLGETTEXTUREIMAGEPROC as sub(byval texture as GLuint, byval level as GLint, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval pixels as any ptr)
type PFNGLGETCOMPRESSEDTEXTUREIMAGEPROC as sub(byval texture as GLuint, byval level as GLint, byval bufSize as GLsizei, byval pixels as any ptr)
type PFNGLGETTEXTURELEVELPARAMETERFVPROC as sub(byval texture as GLuint, byval level as GLint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETTEXTURELEVELPARAMETERIVPROC as sub(byval texture as GLuint, byval level as GLint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETTEXTUREPARAMETERFVPROC as sub(byval texture as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETTEXTUREPARAMETERIIVPROC as sub(byval texture as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETTEXTUREPARAMETERIUIVPROC as sub(byval texture as GLuint, byval pname as GLenum, byval params as GLuint ptr)
type PFNGLGETTEXTUREPARAMETERIVPROC as sub(byval texture as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLCREATEVERTEXARRAYSPROC as sub(byval n as GLsizei, byval arrays as GLuint ptr)
type PFNGLDISABLEVERTEXARRAYATTRIBPROC as sub(byval vaobj as GLuint, byval index as GLuint)
type PFNGLENABLEVERTEXARRAYATTRIBPROC as sub(byval vaobj as GLuint, byval index as GLuint)
type PFNGLVERTEXARRAYELEMENTBUFFERPROC as sub(byval vaobj as GLuint, byval buffer as GLuint)
type PFNGLVERTEXARRAYVERTEXBUFFERPROC as sub(byval vaobj as GLuint, byval bindingindex as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval stride as GLsizei)
type PFNGLVERTEXARRAYVERTEXBUFFERSPROC as sub(byval vaobj as GLuint, byval first as GLuint, byval count as GLsizei, byval buffers as const GLuint ptr, byval offsets as const GLintptr ptr, byval strides as const GLsizei ptr)
type PFNGLVERTEXARRAYATTRIBBINDINGPROC as sub(byval vaobj as GLuint, byval attribindex as GLuint, byval bindingindex as GLuint)
type PFNGLVERTEXARRAYATTRIBFORMATPROC as sub(byval vaobj as GLuint, byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval relativeoffset as GLuint)
type PFNGLVERTEXARRAYATTRIBIFORMATPROC as sub(byval vaobj as GLuint, byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval relativeoffset as GLuint)
type PFNGLVERTEXARRAYATTRIBLFORMATPROC as sub(byval vaobj as GLuint, byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval relativeoffset as GLuint)
type PFNGLVERTEXARRAYBINDINGDIVISORPROC as sub(byval vaobj as GLuint, byval bindingindex as GLuint, byval divisor as GLuint)
type PFNGLGETVERTEXARRAYIVPROC as sub(byval vaobj as GLuint, byval pname as GLenum, byval param as GLint ptr)
type PFNGLGETVERTEXARRAYINDEXEDIVPROC as sub(byval vaobj as GLuint, byval index as GLuint, byval pname as GLenum, byval param as GLint ptr)
type PFNGLGETVERTEXARRAYINDEXED64IVPROC as sub(byval vaobj as GLuint, byval index as GLuint, byval pname as GLenum, byval param as GLint64 ptr)
type PFNGLCREATESAMPLERSPROC as sub(byval n as GLsizei, byval samplers as GLuint ptr)
type PFNGLCREATEPROGRAMPIPELINESPROC as sub(byval n as GLsizei, byval pipelines as GLuint ptr)
type PFNGLCREATEQUERIESPROC as sub(byval target as GLenum, byval n as GLsizei, byval ids as GLuint ptr)
type PFNGLGETQUERYBUFFEROBJECTI64VPROC as sub(byval id as GLuint, byval buffer as GLuint, byval pname as GLenum, byval offset as GLintptr)
type PFNGLGETQUERYBUFFEROBJECTIVPROC as sub(byval id as GLuint, byval buffer as GLuint, byval pname as GLenum, byval offset as GLintptr)
type PFNGLGETQUERYBUFFEROBJECTUI64VPROC as sub(byval id as GLuint, byval buffer as GLuint, byval pname as GLenum, byval offset as GLintptr)
type PFNGLGETQUERYBUFFEROBJECTUIVPROC as sub(byval id as GLuint, byval buffer as GLuint, byval pname as GLenum, byval offset as GLintptr)
type PFNGLMEMORYBARRIERBYREGIONPROC as sub(byval barriers as GLbitfield)
type PFNGLGETTEXTURESUBIMAGEPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval pixels as any ptr)
type PFNGLGETCOMPRESSEDTEXTURESUBIMAGEPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval bufSize as GLsizei, byval pixels as any ptr)
type PFNGLGETGRAPHICSRESETSTATUSPROC as function() as GLenum
type PFNGLGETNCOMPRESSEDTEXIMAGEPROC as sub(byval target as GLenum, byval lod as GLint, byval bufSize as GLsizei, byval pixels as any ptr)
type PFNGLGETNTEXIMAGEPROC as sub(byval target as GLenum, byval level as GLint, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval pixels as any ptr)
type PFNGLGETNUNIFORMDVPROC as sub(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLdouble ptr)
type PFNGLGETNUNIFORMFVPROC as sub(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLfloat ptr)
type PFNGLGETNUNIFORMIVPROC as sub(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLint ptr)
type PFNGLGETNUNIFORMUIVPROC as sub(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLuint ptr)
type PFNGLREADNPIXELSPROC as sub(byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval data as any ptr)
type PFNGLGETNMAPDVPROC as sub(byval target as GLenum, byval query as GLenum, byval bufSize as GLsizei, byval v as GLdouble ptr)
type PFNGLGETNMAPFVPROC as sub(byval target as GLenum, byval query as GLenum, byval bufSize as GLsizei, byval v as GLfloat ptr)
type PFNGLGETNMAPIVPROC as sub(byval target as GLenum, byval query as GLenum, byval bufSize as GLsizei, byval v as GLint ptr)
type PFNGLGETNPIXELMAPFVPROC as sub(byval map as GLenum, byval bufSize as GLsizei, byval values as GLfloat ptr)
type PFNGLGETNPIXELMAPUIVPROC as sub(byval map as GLenum, byval bufSize as GLsizei, byval values as GLuint ptr)
type PFNGLGETNPIXELMAPUSVPROC as sub(byval map as GLenum, byval bufSize as GLsizei, byval values as GLushort ptr)
type PFNGLGETNPOLYGONSTIPPLEPROC as sub(byval bufSize as GLsizei, byval pattern as GLubyte ptr)
type PFNGLGETNCOLORTABLEPROC as sub(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval table as any ptr)
type PFNGLGETNCONVOLUTIONFILTERPROC as sub(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval image as any ptr)
type PFNGLGETNSEPARABLEFILTERPROC as sub(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval rowBufSize as GLsizei, byval row as any ptr, byval columnBufSize as GLsizei, byval column as any ptr, byval span as any ptr)
type PFNGLGETNHISTOGRAMPROC as sub(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval values as any ptr)
type PFNGLGETNMINMAXPROC as sub(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval values as any ptr)
type PFNGLTEXTUREBARRIERPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glClipControl(byval origin as GLenum, byval depth as GLenum)
	declare sub glCreateTransformFeedbacks(byval n as GLsizei, byval ids as GLuint ptr)
	declare sub glTransformFeedbackBufferBase(byval xfb as GLuint, byval index as GLuint, byval buffer as GLuint)
	declare sub glTransformFeedbackBufferRange(byval xfb as GLuint, byval index as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizei)
	declare sub glGetTransformFeedbackiv(byval xfb as GLuint, byval pname as GLenum, byval param as GLint ptr)
	declare sub glGetTransformFeedbacki_v(byval xfb as GLuint, byval pname as GLenum, byval index as GLuint, byval param as GLint ptr)
	declare sub glGetTransformFeedbacki64_v(byval xfb as GLuint, byval pname as GLenum, byval index as GLuint, byval param as GLint64 ptr)
	declare sub glCreateBuffers(byval n as GLsizei, byval buffers as GLuint ptr)
	declare sub glNamedBufferStorage(byval buffer as GLuint, byval size as GLsizei, byval data as const any ptr, byval flags as GLbitfield)
	declare sub glNamedBufferData(byval buffer as GLuint, byval size as GLsizei, byval data as const any ptr, byval usage as GLenum)
	declare sub glNamedBufferSubData(byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizei, byval data as const any ptr)
	declare sub glCopyNamedBufferSubData(byval readBuffer as GLuint, byval writeBuffer as GLuint, byval readOffset as GLintptr, byval writeOffset as GLintptr, byval size as GLsizei)
	declare sub glClearNamedBufferData(byval buffer as GLuint, byval internalformat as GLenum, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
	declare sub glClearNamedBufferSubData(byval buffer as GLuint, byval internalformat as GLenum, byval offset as GLintptr, byval size as GLsizei, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
	declare function glMapNamedBuffer(byval buffer as GLuint, byval access as GLenum) as any ptr
	declare function glMapNamedBufferRange(byval buffer as GLuint, byval offset as GLintptr, byval length as GLsizei, byval access as GLbitfield) as any ptr
	declare function glUnmapNamedBuffer(byval buffer as GLuint) as GLboolean
	declare sub glFlushMappedNamedBufferRange(byval buffer as GLuint, byval offset as GLintptr, byval length as GLsizei)
	declare sub glGetNamedBufferParameteriv(byval buffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetNamedBufferParameteri64v(byval buffer as GLuint, byval pname as GLenum, byval params as GLint64 ptr)
	declare sub glGetNamedBufferPointerv(byval buffer as GLuint, byval pname as GLenum, byval params as any ptr ptr)
	declare sub glGetNamedBufferSubData(byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizei, byval data as any ptr)
	declare sub glCreateFramebuffers(byval n as GLsizei, byval framebuffers as GLuint ptr)
	declare sub glNamedFramebufferRenderbuffer(byval framebuffer as GLuint, byval attachment as GLenum, byval renderbuffertarget as GLenum, byval renderbuffer as GLuint)
	declare sub glNamedFramebufferParameteri(byval framebuffer as GLuint, byval pname as GLenum, byval param as GLint)
	declare sub glNamedFramebufferTexture(byval framebuffer as GLuint, byval attachment as GLenum, byval texture as GLuint, byval level as GLint)
	declare sub glNamedFramebufferTextureLayer(byval framebuffer as GLuint, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval layer as GLint)
	declare sub glNamedFramebufferDrawBuffer(byval framebuffer as GLuint, byval buf as GLenum)
	declare sub glNamedFramebufferDrawBuffers(byval framebuffer as GLuint, byval n as GLsizei, byval bufs as const GLenum ptr)
	declare sub glNamedFramebufferReadBuffer(byval framebuffer as GLuint, byval src as GLenum)
	declare sub glInvalidateNamedFramebufferData(byval framebuffer as GLuint, byval numAttachments as GLsizei, byval attachments as const GLenum ptr)
	declare sub glInvalidateNamedFramebufferSubData(byval framebuffer as GLuint, byval numAttachments as GLsizei, byval attachments as const GLenum ptr, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
	declare sub glClearNamedFramebufferiv(byval framebuffer as GLuint, byval buffer as GLenum, byval drawbuffer as GLint, byval value as const GLint ptr)
	declare sub glClearNamedFramebufferuiv(byval framebuffer as GLuint, byval buffer as GLenum, byval drawbuffer as GLint, byval value as const GLuint ptr)
	declare sub glClearNamedFramebufferfv(byval framebuffer as GLuint, byval buffer as GLenum, byval drawbuffer as GLint, byval value as const GLfloat ptr)
	declare sub glClearNamedFramebufferfi(byval framebuffer as GLuint, byval buffer as GLenum, byval depth as const GLfloat, byval stencil as GLint)
	declare sub glBlitNamedFramebuffer(byval readFramebuffer as GLuint, byval drawFramebuffer as GLuint, byval srcX0 as GLint, byval srcY0 as GLint, byval srcX1 as GLint, byval srcY1 as GLint, byval dstX0 as GLint, byval dstY0 as GLint, byval dstX1 as GLint, byval dstY1 as GLint, byval mask as GLbitfield, byval filter as GLenum)
	declare function glCheckNamedFramebufferStatus(byval framebuffer as GLuint, byval target as GLenum) as GLenum
	declare sub glGetNamedFramebufferParameteriv(byval framebuffer as GLuint, byval pname as GLenum, byval param as GLint ptr)
	declare sub glGetNamedFramebufferAttachmentParameteriv(byval framebuffer as GLuint, byval attachment as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glCreateRenderbuffers(byval n as GLsizei, byval renderbuffers as GLuint ptr)
	declare sub glNamedRenderbufferStorage(byval renderbuffer as GLuint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
	declare sub glNamedRenderbufferStorageMultisample(byval renderbuffer as GLuint, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
	declare sub glGetNamedRenderbufferParameteriv(byval renderbuffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glCreateTextures(byval target as GLenum, byval n as GLsizei, byval textures as GLuint ptr)
	declare sub glTextureBuffer(byval texture as GLuint, byval internalformat as GLenum, byval buffer as GLuint)
	declare sub glTextureBufferRange(byval texture as GLuint, byval internalformat as GLenum, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizei)
	declare sub glTextureStorage1D(byval texture as GLuint, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei)
	declare sub glTextureStorage2D(byval texture as GLuint, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
	declare sub glTextureStorage3D(byval texture as GLuint, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei)
	declare sub glTextureStorage2DMultisample(byval texture as GLuint, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval fixedsamplelocations as GLboolean)
	declare sub glTextureStorage3DMultisample(byval texture as GLuint, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedsamplelocations as GLboolean)
	declare sub glTextureSubImage1D(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glTextureSubImage2D(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glTextureSubImage3D(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glCompressedTextureSubImage1D(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCompressedTextureSubImage2D(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCompressedTextureSubImage3D(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCopyTextureSubImage1D(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei)
	declare sub glCopyTextureSubImage2D(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
	declare sub glCopyTextureSubImage3D(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
	declare sub glTextureParameterf(byval texture as GLuint, byval pname as GLenum, byval param as GLfloat)
	declare sub glTextureParameterfv(byval texture as GLuint, byval pname as GLenum, byval param as const GLfloat ptr)
	declare sub glTextureParameteri(byval texture as GLuint, byval pname as GLenum, byval param as GLint)
	declare sub glTextureParameterIiv(byval texture as GLuint, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glTextureParameterIuiv(byval texture as GLuint, byval pname as GLenum, byval params as const GLuint ptr)
	declare sub glTextureParameteriv(byval texture as GLuint, byval pname as GLenum, byval param as const GLint ptr)
	declare sub glGenerateTextureMipmap(byval texture as GLuint)
	declare sub glBindTextureUnit(byval unit as GLuint, byval texture as GLuint)
	declare sub glGetTextureImage(byval texture as GLuint, byval level as GLint, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval pixels as any ptr)
	declare sub glGetCompressedTextureImage(byval texture as GLuint, byval level as GLint, byval bufSize as GLsizei, byval pixels as any ptr)
	declare sub glGetTextureLevelParameterfv(byval texture as GLuint, byval level as GLint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetTextureLevelParameteriv(byval texture as GLuint, byval level as GLint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetTextureParameterfv(byval texture as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetTextureParameterIiv(byval texture as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetTextureParameterIuiv(byval texture as GLuint, byval pname as GLenum, byval params as GLuint ptr)
	declare sub glGetTextureParameteriv(byval texture as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glCreateVertexArrays(byval n as GLsizei, byval arrays as GLuint ptr)
	declare sub glDisableVertexArrayAttrib(byval vaobj as GLuint, byval index as GLuint)
	declare sub glEnableVertexArrayAttrib(byval vaobj as GLuint, byval index as GLuint)
	declare sub glVertexArrayElementBuffer(byval vaobj as GLuint, byval buffer as GLuint)
	declare sub glVertexArrayVertexBuffer(byval vaobj as GLuint, byval bindingindex as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval stride as GLsizei)
	declare sub glVertexArrayVertexBuffers(byval vaobj as GLuint, byval first as GLuint, byval count as GLsizei, byval buffers as const GLuint ptr, byval offsets as const GLintptr ptr, byval strides as const GLsizei ptr)
	declare sub glVertexArrayAttribBinding(byval vaobj as GLuint, byval attribindex as GLuint, byval bindingindex as GLuint)
	declare sub glVertexArrayAttribFormat(byval vaobj as GLuint, byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval relativeoffset as GLuint)
	declare sub glVertexArrayAttribIFormat(byval vaobj as GLuint, byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval relativeoffset as GLuint)
	declare sub glVertexArrayAttribLFormat(byval vaobj as GLuint, byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval relativeoffset as GLuint)
	declare sub glVertexArrayBindingDivisor(byval vaobj as GLuint, byval bindingindex as GLuint, byval divisor as GLuint)
	declare sub glGetVertexArrayiv(byval vaobj as GLuint, byval pname as GLenum, byval param as GLint ptr)
	declare sub glGetVertexArrayIndexediv(byval vaobj as GLuint, byval index as GLuint, byval pname as GLenum, byval param as GLint ptr)
	declare sub glGetVertexArrayIndexed64iv(byval vaobj as GLuint, byval index as GLuint, byval pname as GLenum, byval param as GLint64 ptr)
	declare sub glCreateSamplers(byval n as GLsizei, byval samplers as GLuint ptr)
	declare sub glCreateProgramPipelines(byval n as GLsizei, byval pipelines as GLuint ptr)
	declare sub glCreateQueries(byval target as GLenum, byval n as GLsizei, byval ids as GLuint ptr)
	declare sub glGetQueryBufferObjecti64v(byval id as GLuint, byval buffer as GLuint, byval pname as GLenum, byval offset as GLintptr)
	declare sub glGetQueryBufferObjectiv(byval id as GLuint, byval buffer as GLuint, byval pname as GLenum, byval offset as GLintptr)
	declare sub glGetQueryBufferObjectui64v(byval id as GLuint, byval buffer as GLuint, byval pname as GLenum, byval offset as GLintptr)
	declare sub glGetQueryBufferObjectuiv(byval id as GLuint, byval buffer as GLuint, byval pname as GLenum, byval offset as GLintptr)
	declare sub glMemoryBarrierByRegion(byval barriers as GLbitfield)
	declare sub glGetTextureSubImage(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval pixels as any ptr)
	declare sub glGetCompressedTextureSubImage(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval bufSize as GLsizei, byval pixels as any ptr)
	declare function glGetGraphicsResetStatus() as GLenum
	declare sub glGetnCompressedTexImage(byval target as GLenum, byval lod as GLint, byval bufSize as GLsizei, byval pixels as any ptr)
	declare sub glGetnTexImage(byval target as GLenum, byval level as GLint, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval pixels as any ptr)
	declare sub glGetnUniformdv(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLdouble ptr)
	declare sub glGetnUniformfv(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLfloat ptr)
	declare sub glGetnUniformiv(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLint ptr)
	declare sub glGetnUniformuiv(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLuint ptr)
	declare sub glReadnPixels(byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval data as any ptr)
	declare sub glGetnMapdv(byval target as GLenum, byval query as GLenum, byval bufSize as GLsizei, byval v as GLdouble ptr)
	declare sub glGetnMapfv(byval target as GLenum, byval query as GLenum, byval bufSize as GLsizei, byval v as GLfloat ptr)
	declare sub glGetnMapiv(byval target as GLenum, byval query as GLenum, byval bufSize as GLsizei, byval v as GLint ptr)
	declare sub glGetnPixelMapfv(byval map as GLenum, byval bufSize as GLsizei, byval values as GLfloat ptr)
	declare sub glGetnPixelMapuiv(byval map as GLenum, byval bufSize as GLsizei, byval values as GLuint ptr)
	declare sub glGetnPixelMapusv(byval map as GLenum, byval bufSize as GLsizei, byval values as GLushort ptr)
	declare sub glGetnPolygonStipple(byval bufSize as GLsizei, byval pattern as GLubyte ptr)
	declare sub glGetnColorTable(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval table as any ptr)
	declare sub glGetnConvolutionFilter(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval image as any ptr)
	declare sub glGetnSeparableFilter(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval rowBufSize as GLsizei, byval row as any ptr, byval columnBufSize as GLsizei, byval column as any ptr, byval span as any ptr)
	declare sub glGetnHistogram(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval values as any ptr)
	declare sub glGetnMinmax(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval values as any ptr)
	declare sub glTextureBarrier()
#endif

const GL_ARB_ES2_compatibility = 1
const GL_ARB_ES3_1_compatibility = 1
const GL_ARB_ES3_compatibility = 1
const GL_ARB_arrays_of_arrays = 1
const GL_ARB_base_instance = 1
const GL_ARB_bindless_texture = 1
type GLuint64EXT as ulongint
const GL_UNSIGNED_INT64_ARB = &h140F

type PFNGLGETTEXTUREHANDLEARBPROC as function(byval texture as GLuint) as GLuint64
type PFNGLGETTEXTURESAMPLERHANDLEARBPROC as function(byval texture as GLuint, byval sampler as GLuint) as GLuint64
type PFNGLMAKETEXTUREHANDLERESIDENTARBPROC as sub(byval handle as GLuint64)
type PFNGLMAKETEXTUREHANDLENONRESIDENTARBPROC as sub(byval handle as GLuint64)
type PFNGLGETIMAGEHANDLEARBPROC as function(byval texture as GLuint, byval level as GLint, byval layered as GLboolean, byval layer as GLint, byval format as GLenum) as GLuint64
type PFNGLMAKEIMAGEHANDLERESIDENTARBPROC as sub(byval handle as GLuint64, byval access as GLenum)
type PFNGLMAKEIMAGEHANDLENONRESIDENTARBPROC as sub(byval handle as GLuint64)
type PFNGLUNIFORMHANDLEUI64ARBPROC as sub(byval location as GLint, byval value as GLuint64)
type PFNGLUNIFORMHANDLEUI64VARBPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint64 ptr)
type PFNGLPROGRAMUNIFORMHANDLEUI64ARBPROC as sub(byval program as GLuint, byval location as GLint, byval value as GLuint64)
type PFNGLPROGRAMUNIFORMHANDLEUI64VARBPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval values as const GLuint64 ptr)
type PFNGLISTEXTUREHANDLERESIDENTARBPROC as function(byval handle as GLuint64) as GLboolean
type PFNGLISIMAGEHANDLERESIDENTARBPROC as function(byval handle as GLuint64) as GLboolean
type PFNGLVERTEXATTRIBL1UI64ARBPROC as sub(byval index as GLuint, byval x as GLuint64EXT)
type PFNGLVERTEXATTRIBL1UI64VARBPROC as sub(byval index as GLuint, byval v as const GLuint64EXT ptr)
type PFNGLGETVERTEXATTRIBLUI64VARBPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLuint64EXT ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare function glGetTextureHandleARB(byval texture as GLuint) as GLuint64
	declare function glGetTextureSamplerHandleARB(byval texture as GLuint, byval sampler as GLuint) as GLuint64
	declare sub glMakeTextureHandleResidentARB(byval handle as GLuint64)
	declare sub glMakeTextureHandleNonResidentARB(byval handle as GLuint64)
	declare function glGetImageHandleARB(byval texture as GLuint, byval level as GLint, byval layered as GLboolean, byval layer as GLint, byval format as GLenum) as GLuint64
	declare sub glMakeImageHandleResidentARB(byval handle as GLuint64, byval access as GLenum)
	declare sub glMakeImageHandleNonResidentARB(byval handle as GLuint64)
	declare sub glUniformHandleui64ARB(byval location as GLint, byval value as GLuint64)
	declare sub glUniformHandleui64vARB(byval location as GLint, byval count as GLsizei, byval value as const GLuint64 ptr)
	declare sub glProgramUniformHandleui64ARB(byval program as GLuint, byval location as GLint, byval value as GLuint64)
	declare sub glProgramUniformHandleui64vARB(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval values as const GLuint64 ptr)
	declare function glIsTextureHandleResidentARB(byval handle as GLuint64) as GLboolean
	declare function glIsImageHandleResidentARB(byval handle as GLuint64) as GLboolean
	declare sub glVertexAttribL1ui64ARB(byval index as GLuint, byval x as GLuint64EXT)
	declare sub glVertexAttribL1ui64vARB(byval index as GLuint, byval v as const GLuint64EXT ptr)
	declare sub glGetVertexAttribLui64vARB(byval index as GLuint, byval pname as GLenum, byval params as GLuint64EXT ptr)
#endif

const GL_ARB_blend_func_extended = 1
const GL_ARB_buffer_storage = 1
const GL_ARB_cl_event = 1
const GL_SYNC_CL_EVENT_ARB = &h8240
const GL_SYNC_CL_EVENT_COMPLETE_ARB = &h8241

type _cl_context as _cl_context_
type _cl_event as _cl_event_
type PFNGLCREATESYNCFROMCLEVENTARBPROC as function(byval context as _cl_context ptr, byval event as _cl_event ptr, byval flags as GLbitfield) as GLsync

#ifdef GL_GLEXT_PROTOTYPES
	declare function glCreateSyncFromCLeventARB(byval context as _cl_context ptr, byval event as _cl_event ptr, byval flags as GLbitfield) as GLsync
#endif

const GL_ARB_clear_buffer_object = 1
const GL_ARB_clear_texture = 1
const GL_ARB_clip_control = 1
const GL_ARB_color_buffer_float = 1
const GL_RGBA_FLOAT_MODE_ARB = &h8820
const GL_CLAMP_VERTEX_COLOR_ARB = &h891A
const GL_CLAMP_FRAGMENT_COLOR_ARB = &h891B
const GL_CLAMP_READ_COLOR_ARB = &h891C
const GL_FIXED_ONLY_ARB = &h891D
type PFNGLCLAMPCOLORARBPROC as sub(byval target as GLenum, byval clamp as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glClampColorARB(byval target as GLenum, byval clamp as GLenum)
#endif

const GL_ARB_compatibility = 1
const GL_ARB_compressed_texture_pixel_storage = 1
const GL_ARB_compute_shader = 1
const GL_ARB_compute_variable_group_size = 1
const GL_MAX_COMPUTE_VARIABLE_GROUP_INVOCATIONS_ARB = &h9344
const GL_MAX_COMPUTE_FIXED_GROUP_INVOCATIONS_ARB = &h90EB
const GL_MAX_COMPUTE_VARIABLE_GROUP_SIZE_ARB = &h9345
const GL_MAX_COMPUTE_FIXED_GROUP_SIZE_ARB = &h91BF
type PFNGLDISPATCHCOMPUTEGROUPSIZEARBPROC as sub(byval num_groups_x as GLuint, byval num_groups_y as GLuint, byval num_groups_z as GLuint, byval group_size_x as GLuint, byval group_size_y as GLuint, byval group_size_z as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDispatchComputeGroupSizeARB(byval num_groups_x as GLuint, byval num_groups_y as GLuint, byval num_groups_z as GLuint, byval group_size_x as GLuint, byval group_size_y as GLuint, byval group_size_z as GLuint)
#endif

const GL_ARB_conditional_render_inverted = 1
const GL_ARB_conservative_depth = 1
const GL_ARB_copy_buffer = 1
const GL_ARB_copy_image = 1
const GL_ARB_cull_distance = 1
const GL_ARB_debug_output = 1
type GLDEBUGPROCARB as sub(byval source as GLenum, byval type as GLenum, byval id as GLuint, byval severity as GLenum, byval length as GLsizei, byval message as const GLchar ptr, byval userParam as const any ptr)
const GL_DEBUG_OUTPUT_SYNCHRONOUS_ARB = &h8242
const GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH_ARB = &h8243
const GL_DEBUG_CALLBACK_FUNCTION_ARB = &h8244
const GL_DEBUG_CALLBACK_USER_PARAM_ARB = &h8245
const GL_DEBUG_SOURCE_API_ARB = &h8246
const GL_DEBUG_SOURCE_WINDOW_SYSTEM_ARB = &h8247
const GL_DEBUG_SOURCE_SHADER_COMPILER_ARB = &h8248
const GL_DEBUG_SOURCE_THIRD_PARTY_ARB = &h8249
const GL_DEBUG_SOURCE_APPLICATION_ARB = &h824A
const GL_DEBUG_SOURCE_OTHER_ARB = &h824B
const GL_DEBUG_TYPE_ERROR_ARB = &h824C
const GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB = &h824D
const GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB = &h824E
const GL_DEBUG_TYPE_PORTABILITY_ARB = &h824F
const GL_DEBUG_TYPE_PERFORMANCE_ARB = &h8250
const GL_DEBUG_TYPE_OTHER_ARB = &h8251
const GL_MAX_DEBUG_MESSAGE_LENGTH_ARB = &h9143
const GL_MAX_DEBUG_LOGGED_MESSAGES_ARB = &h9144
const GL_DEBUG_LOGGED_MESSAGES_ARB = &h9145
const GL_DEBUG_SEVERITY_HIGH_ARB = &h9146
const GL_DEBUG_SEVERITY_MEDIUM_ARB = &h9147
const GL_DEBUG_SEVERITY_LOW_ARB = &h9148

type PFNGLDEBUGMESSAGECONTROLARBPROC as sub(byval source as GLenum, byval type as GLenum, byval severity as GLenum, byval count as GLsizei, byval ids as const GLuint ptr, byval enabled as GLboolean)
type PFNGLDEBUGMESSAGEINSERTARBPROC as sub(byval source as GLenum, byval type as GLenum, byval id as GLuint, byval severity as GLenum, byval length as GLsizei, byval buf as const GLchar ptr)
type PFNGLDEBUGMESSAGECALLBACKARBPROC as sub(byval callback as GLDEBUGPROCARB, byval userParam as const any ptr)
type PFNGLGETDEBUGMESSAGELOGARBPROC as function(byval count as GLuint, byval bufSize as GLsizei, byval sources as GLenum ptr, byval types as GLenum ptr, byval ids as GLuint ptr, byval severities as GLenum ptr, byval lengths as GLsizei ptr, byval messageLog as GLchar ptr) as GLuint

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDebugMessageControlARB(byval source as GLenum, byval type as GLenum, byval severity as GLenum, byval count as GLsizei, byval ids as const GLuint ptr, byval enabled as GLboolean)
	declare sub glDebugMessageInsertARB(byval source as GLenum, byval type as GLenum, byval id as GLuint, byval severity as GLenum, byval length as GLsizei, byval buf as const GLchar ptr)
	declare sub glDebugMessageCallbackARB(byval callback as GLDEBUGPROCARB, byval userParam as const any ptr)
	declare function glGetDebugMessageLogARB(byval count as GLuint, byval bufSize as GLsizei, byval sources as GLenum ptr, byval types as GLenum ptr, byval ids as GLuint ptr, byval severities as GLenum ptr, byval lengths as GLsizei ptr, byval messageLog as GLchar ptr) as GLuint
#endif

const GL_ARB_depth_buffer_float = 1
const GL_ARB_depth_clamp = 1
const GL_ARB_depth_texture = 1
const GL_DEPTH_COMPONENT16_ARB = &h81A5
const GL_DEPTH_COMPONENT24_ARB = &h81A6
const GL_DEPTH_COMPONENT32_ARB = &h81A7
const GL_TEXTURE_DEPTH_SIZE_ARB = &h884A
const GL_DEPTH_TEXTURE_MODE_ARB = &h884B
const GL_ARB_derivative_control = 1
const GL_ARB_direct_state_access = 1
const GL_ARB_draw_buffers = 1
const GL_MAX_DRAW_BUFFERS_ARB = &h8824
const GL_DRAW_BUFFER0_ARB = &h8825
const GL_DRAW_BUFFER1_ARB = &h8826
const GL_DRAW_BUFFER2_ARB = &h8827
const GL_DRAW_BUFFER3_ARB = &h8828
const GL_DRAW_BUFFER4_ARB = &h8829
const GL_DRAW_BUFFER5_ARB = &h882A
const GL_DRAW_BUFFER6_ARB = &h882B
const GL_DRAW_BUFFER7_ARB = &h882C
const GL_DRAW_BUFFER8_ARB = &h882D
const GL_DRAW_BUFFER9_ARB = &h882E
const GL_DRAW_BUFFER10_ARB = &h882F
const GL_DRAW_BUFFER11_ARB = &h8830
const GL_DRAW_BUFFER12_ARB = &h8831
const GL_DRAW_BUFFER13_ARB = &h8832
const GL_DRAW_BUFFER14_ARB = &h8833
const GL_DRAW_BUFFER15_ARB = &h8834
type PFNGLDRAWBUFFERSARBPROC as sub(byval n as GLsizei, byval bufs as const GLenum ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDrawBuffersARB(byval n as GLsizei, byval bufs as const GLenum ptr)
#endif

const GL_ARB_draw_buffers_blend = 1
type PFNGLBLENDEQUATIONIARBPROC as sub(byval buf as GLuint, byval mode as GLenum)
type PFNGLBLENDEQUATIONSEPARATEIARBPROC as sub(byval buf as GLuint, byval modeRGB as GLenum, byval modeAlpha as GLenum)
type PFNGLBLENDFUNCIARBPROC as sub(byval buf as GLuint, byval src as GLenum, byval dst as GLenum)
type PFNGLBLENDFUNCSEPARATEIARBPROC as sub(byval buf as GLuint, byval srcRGB as GLenum, byval dstRGB as GLenum, byval srcAlpha as GLenum, byval dstAlpha as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBlendEquationiARB(byval buf as GLuint, byval mode as GLenum)
	declare sub glBlendEquationSeparateiARB(byval buf as GLuint, byval modeRGB as GLenum, byval modeAlpha as GLenum)
	declare sub glBlendFunciARB(byval buf as GLuint, byval src as GLenum, byval dst as GLenum)
	declare sub glBlendFuncSeparateiARB(byval buf as GLuint, byval srcRGB as GLenum, byval dstRGB as GLenum, byval srcAlpha as GLenum, byval dstAlpha as GLenum)
#endif

const GL_ARB_draw_elements_base_vertex = 1
const GL_ARB_draw_indirect = 1
const GL_ARB_draw_instanced = 1
type PFNGLDRAWARRAYSINSTANCEDARBPROC as sub(byval mode as GLenum, byval first as GLint, byval count as GLsizei, byval primcount as GLsizei)
type PFNGLDRAWELEMENTSINSTANCEDARBPROC as sub(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval primcount as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDrawArraysInstancedARB(byval mode as GLenum, byval first as GLint, byval count as GLsizei, byval primcount as GLsizei)
	declare sub glDrawElementsInstancedARB(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval primcount as GLsizei)
#endif

const GL_ARB_enhanced_layouts = 1
const GL_ARB_explicit_attrib_location = 1
const GL_ARB_explicit_uniform_location = 1
const GL_ARB_fragment_coord_conventions = 1
const GL_ARB_fragment_layer_viewport = 1
const GL_ARB_fragment_program = 1
const GL_FRAGMENT_PROGRAM_ARB = &h8804
const GL_PROGRAM_FORMAT_ASCII_ARB = &h8875
const GL_PROGRAM_LENGTH_ARB = &h8627
const GL_PROGRAM_FORMAT_ARB = &h8876
const GL_PROGRAM_BINDING_ARB = &h8677
const GL_PROGRAM_INSTRUCTIONS_ARB = &h88A0
const GL_MAX_PROGRAM_INSTRUCTIONS_ARB = &h88A1
const GL_PROGRAM_NATIVE_INSTRUCTIONS_ARB = &h88A2
const GL_MAX_PROGRAM_NATIVE_INSTRUCTIONS_ARB = &h88A3
const GL_PROGRAM_TEMPORARIES_ARB = &h88A4
const GL_MAX_PROGRAM_TEMPORARIES_ARB = &h88A5
const GL_PROGRAM_NATIVE_TEMPORARIES_ARB = &h88A6
const GL_MAX_PROGRAM_NATIVE_TEMPORARIES_ARB = &h88A7
const GL_PROGRAM_PARAMETERS_ARB = &h88A8
const GL_MAX_PROGRAM_PARAMETERS_ARB = &h88A9
const GL_PROGRAM_NATIVE_PARAMETERS_ARB = &h88AA
const GL_MAX_PROGRAM_NATIVE_PARAMETERS_ARB = &h88AB
const GL_PROGRAM_ATTRIBS_ARB = &h88AC
const GL_MAX_PROGRAM_ATTRIBS_ARB = &h88AD
const GL_PROGRAM_NATIVE_ATTRIBS_ARB = &h88AE
const GL_MAX_PROGRAM_NATIVE_ATTRIBS_ARB = &h88AF
const GL_MAX_PROGRAM_LOCAL_PARAMETERS_ARB = &h88B4
const GL_MAX_PROGRAM_ENV_PARAMETERS_ARB = &h88B5
const GL_PROGRAM_UNDER_NATIVE_LIMITS_ARB = &h88B6
const GL_PROGRAM_ALU_INSTRUCTIONS_ARB = &h8805
const GL_PROGRAM_TEX_INSTRUCTIONS_ARB = &h8806
const GL_PROGRAM_TEX_INDIRECTIONS_ARB = &h8807
const GL_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB = &h8808
const GL_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB = &h8809
const GL_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB = &h880A
const GL_MAX_PROGRAM_ALU_INSTRUCTIONS_ARB = &h880B
const GL_MAX_PROGRAM_TEX_INSTRUCTIONS_ARB = &h880C
const GL_MAX_PROGRAM_TEX_INDIRECTIONS_ARB = &h880D
const GL_MAX_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB = &h880E
const GL_MAX_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB = &h880F
const GL_MAX_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB = &h8810
const GL_PROGRAM_STRING_ARB = &h8628
const GL_PROGRAM_ERROR_POSITION_ARB = &h864B
const GL_CURRENT_MATRIX_ARB = &h8641
const GL_TRANSPOSE_CURRENT_MATRIX_ARB = &h88B7
const GL_CURRENT_MATRIX_STACK_DEPTH_ARB = &h8640
const GL_MAX_PROGRAM_MATRICES_ARB = &h862F
const GL_MAX_PROGRAM_MATRIX_STACK_DEPTH_ARB = &h862E
const GL_MAX_TEXTURE_COORDS_ARB = &h8871
const GL_MAX_TEXTURE_IMAGE_UNITS_ARB = &h8872
const GL_PROGRAM_ERROR_STRING_ARB = &h8874
const GL_MATRIX0_ARB = &h88C0
const GL_MATRIX1_ARB = &h88C1
const GL_MATRIX2_ARB = &h88C2
const GL_MATRIX3_ARB = &h88C3
const GL_MATRIX4_ARB = &h88C4
const GL_MATRIX5_ARB = &h88C5
const GL_MATRIX6_ARB = &h88C6
const GL_MATRIX7_ARB = &h88C7
const GL_MATRIX8_ARB = &h88C8
const GL_MATRIX9_ARB = &h88C9
const GL_MATRIX10_ARB = &h88CA
const GL_MATRIX11_ARB = &h88CB
const GL_MATRIX12_ARB = &h88CC
const GL_MATRIX13_ARB = &h88CD
const GL_MATRIX14_ARB = &h88CE
const GL_MATRIX15_ARB = &h88CF
const GL_MATRIX16_ARB = &h88D0
const GL_MATRIX17_ARB = &h88D1
const GL_MATRIX18_ARB = &h88D2
const GL_MATRIX19_ARB = &h88D3
const GL_MATRIX20_ARB = &h88D4
const GL_MATRIX21_ARB = &h88D5
const GL_MATRIX22_ARB = &h88D6
const GL_MATRIX23_ARB = &h88D7
const GL_MATRIX24_ARB = &h88D8
const GL_MATRIX25_ARB = &h88D9
const GL_MATRIX26_ARB = &h88DA
const GL_MATRIX27_ARB = &h88DB
const GL_MATRIX28_ARB = &h88DC
const GL_MATRIX29_ARB = &h88DD
const GL_MATRIX30_ARB = &h88DE
const GL_MATRIX31_ARB = &h88DF

type PFNGLPROGRAMSTRINGARBPROC as sub(byval target as GLenum, byval format as GLenum, byval len as GLsizei, byval string as const any ptr)
type PFNGLBINDPROGRAMARBPROC as sub(byval target as GLenum, byval program as GLuint)
type PFNGLDELETEPROGRAMSARBPROC as sub(byval n as GLsizei, byval programs as const GLuint ptr)
type PFNGLGENPROGRAMSARBPROC as sub(byval n as GLsizei, byval programs as GLuint ptr)
type PFNGLPROGRAMENVPARAMETER4DARBPROC as sub(byval target as GLenum, byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLPROGRAMENVPARAMETER4DVARBPROC as sub(byval target as GLenum, byval index as GLuint, byval params as const GLdouble ptr)
type PFNGLPROGRAMENVPARAMETER4FARBPROC as sub(byval target as GLenum, byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
type PFNGLPROGRAMENVPARAMETER4FVARBPROC as sub(byval target as GLenum, byval index as GLuint, byval params as const GLfloat ptr)
type PFNGLPROGRAMLOCALPARAMETER4DARBPROC as sub(byval target as GLenum, byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLPROGRAMLOCALPARAMETER4DVARBPROC as sub(byval target as GLenum, byval index as GLuint, byval params as const GLdouble ptr)
type PFNGLPROGRAMLOCALPARAMETER4FARBPROC as sub(byval target as GLenum, byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
type PFNGLPROGRAMLOCALPARAMETER4FVARBPROC as sub(byval target as GLenum, byval index as GLuint, byval params as const GLfloat ptr)
type PFNGLGETPROGRAMENVPARAMETERDVARBPROC as sub(byval target as GLenum, byval index as GLuint, byval params as GLdouble ptr)
type PFNGLGETPROGRAMENVPARAMETERFVARBPROC as sub(byval target as GLenum, byval index as GLuint, byval params as GLfloat ptr)
type PFNGLGETPROGRAMLOCALPARAMETERDVARBPROC as sub(byval target as GLenum, byval index as GLuint, byval params as GLdouble ptr)
type PFNGLGETPROGRAMLOCALPARAMETERFVARBPROC as sub(byval target as GLenum, byval index as GLuint, byval params as GLfloat ptr)
type PFNGLGETPROGRAMIVARBPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETPROGRAMSTRINGARBPROC as sub(byval target as GLenum, byval pname as GLenum, byval string as any ptr)
type PFNGLISPROGRAMARBPROC as function(byval program as GLuint) as GLboolean

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glProgramStringARB(byval target as GLenum, byval format as GLenum, byval len as GLsizei, byval string as const any ptr)
	declare sub glBindProgramARB(byval target as GLenum, byval program as GLuint)
	declare sub glDeleteProgramsARB(byval n as GLsizei, byval programs as const GLuint ptr)
	declare sub glGenProgramsARB(byval n as GLsizei, byval programs as GLuint ptr)
	declare sub glProgramEnvParameter4dARB(byval target as GLenum, byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glProgramEnvParameter4dvARB(byval target as GLenum, byval index as GLuint, byval params as const GLdouble ptr)
	declare sub glProgramEnvParameter4fARB(byval target as GLenum, byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
	declare sub glProgramEnvParameter4fvARB(byval target as GLenum, byval index as GLuint, byval params as const GLfloat ptr)
	declare sub glProgramLocalParameter4dARB(byval target as GLenum, byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glProgramLocalParameter4dvARB(byval target as GLenum, byval index as GLuint, byval params as const GLdouble ptr)
	declare sub glProgramLocalParameter4fARB(byval target as GLenum, byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
	declare sub glProgramLocalParameter4fvARB(byval target as GLenum, byval index as GLuint, byval params as const GLfloat ptr)
	declare sub glGetProgramEnvParameterdvARB(byval target as GLenum, byval index as GLuint, byval params as GLdouble ptr)
	declare sub glGetProgramEnvParameterfvARB(byval target as GLenum, byval index as GLuint, byval params as GLfloat ptr)
	declare sub glGetProgramLocalParameterdvARB(byval target as GLenum, byval index as GLuint, byval params as GLdouble ptr)
	declare sub glGetProgramLocalParameterfvARB(byval target as GLenum, byval index as GLuint, byval params as GLfloat ptr)
	declare sub glGetProgramivARB(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetProgramStringARB(byval target as GLenum, byval pname as GLenum, byval string as any ptr)
	declare function glIsProgramARB(byval program as GLuint) as GLboolean
#endif

const GL_ARB_fragment_program_shadow = 1
const GL_ARB_fragment_shader = 1
const GL_FRAGMENT_SHADER_ARB = &h8B30
const GL_MAX_FRAGMENT_UNIFORM_COMPONENTS_ARB = &h8B49
const GL_FRAGMENT_SHADER_DERIVATIVE_HINT_ARB = &h8B8B
const GL_ARB_framebuffer_no_attachments = 1
const GL_ARB_framebuffer_object = 1
const GL_ARB_framebuffer_sRGB = 1
const GL_ARB_geometry_shader4 = 1
const GL_LINES_ADJACENCY_ARB = &h000A
const GL_LINE_STRIP_ADJACENCY_ARB = &h000B
const GL_TRIANGLES_ADJACENCY_ARB = &h000C
const GL_TRIANGLE_STRIP_ADJACENCY_ARB = &h000D
const GL_PROGRAM_POINT_SIZE_ARB = &h8642
const GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_ARB = &h8C29
const GL_FRAMEBUFFER_ATTACHMENT_LAYERED_ARB = &h8DA7
const GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_ARB = &h8DA8
const GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_ARB = &h8DA9
const GL_GEOMETRY_SHADER_ARB = &h8DD9
const GL_GEOMETRY_VERTICES_OUT_ARB = &h8DDA
const GL_GEOMETRY_INPUT_TYPE_ARB = &h8DDB
const GL_GEOMETRY_OUTPUT_TYPE_ARB = &h8DDC
const GL_MAX_GEOMETRY_VARYING_COMPONENTS_ARB = &h8DDD
const GL_MAX_VERTEX_VARYING_COMPONENTS_ARB = &h8DDE
const GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_ARB = &h8DDF
const GL_MAX_GEOMETRY_OUTPUT_VERTICES_ARB = &h8DE0
const GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_ARB = &h8DE1

type PFNGLPROGRAMPARAMETERIARBPROC as sub(byval program as GLuint, byval pname as GLenum, byval value as GLint)
type PFNGLFRAMEBUFFERTEXTUREARBPROC as sub(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint)
type PFNGLFRAMEBUFFERTEXTURELAYERARBPROC as sub(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval layer as GLint)
type PFNGLFRAMEBUFFERTEXTUREFACEARBPROC as sub(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval face as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glProgramParameteriARB(byval program as GLuint, byval pname as GLenum, byval value as GLint)
	declare sub glFramebufferTextureARB(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint)
	declare sub glFramebufferTextureLayerARB(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval layer as GLint)
	declare sub glFramebufferTextureFaceARB(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval face as GLenum)
#endif

const GL_ARB_get_program_binary = 1
const GL_ARB_get_texture_sub_image = 1
const GL_ARB_gpu_shader5 = 1
const GL_ARB_gpu_shader_fp64 = 1
const GL_ARB_half_float_pixel = 1
type GLhalfARB as ushort
const GL_HALF_FLOAT_ARB = &h140B
const GL_ARB_half_float_vertex = 1
const GL_ARB_imaging = 1
const GL_BLEND_COLOR = &h8005
const GL_BLEND_EQUATION = &h8009
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
const GL_CONSTANT_BORDER = &h8151
const GL_REPLICATE_BORDER = &h8153
const GL_CONVOLUTION_BORDER_COLOR = &h8154

type PFNGLCOLORTABLEPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval table as const any ptr)
type PFNGLCOLORTABLEPARAMETERFVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLCOLORTABLEPARAMETERIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLCOPYCOLORTABLEPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei)
type PFNGLGETCOLORTABLEPROC as sub(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval table as any ptr)
type PFNGLGETCOLORTABLEPARAMETERFVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETCOLORTABLEPARAMETERIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLCOLORSUBTABLEPROC as sub(byval target as GLenum, byval start as GLsizei, byval count as GLsizei, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
type PFNGLCOPYCOLORSUBTABLEPROC as sub(byval target as GLenum, byval start as GLsizei, byval x as GLint, byval y as GLint, byval width as GLsizei)
type PFNGLCONVOLUTIONFILTER1DPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval image as const any ptr)
type PFNGLCONVOLUTIONFILTER2DPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval image as const any ptr)
type PFNGLCONVOLUTIONPARAMETERFPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat)
type PFNGLCONVOLUTIONPARAMETERFVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLCONVOLUTIONPARAMETERIPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint)
type PFNGLCONVOLUTIONPARAMETERIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLCOPYCONVOLUTIONFILTER1DPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei)
type PFNGLCOPYCONVOLUTIONFILTER2DPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
type PFNGLGETCONVOLUTIONFILTERPROC as sub(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval image as any ptr)
type PFNGLGETCONVOLUTIONPARAMETERFVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETCONVOLUTIONPARAMETERIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETSEPARABLEFILTERPROC as sub(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval row as any ptr, byval column as any ptr, byval span as any ptr)
type PFNGLSEPARABLEFILTER2DPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval row as const any ptr, byval column as const any ptr)
type PFNGLGETHISTOGRAMPROC as sub(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval values as any ptr)
type PFNGLGETHISTOGRAMPARAMETERFVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETHISTOGRAMPARAMETERIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETMINMAXPROC as sub(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval values as any ptr)
type PFNGLGETMINMAXPARAMETERFVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETMINMAXPARAMETERIVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLHISTOGRAMPROC as sub(byval target as GLenum, byval width as GLsizei, byval internalformat as GLenum, byval sink as GLboolean)
type PFNGLMINMAXPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval sink as GLboolean)
type PFNGLRESETHISTOGRAMPROC as sub(byval target as GLenum)
type PFNGLRESETMINMAXPROC as sub(byval target as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glColorTable(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval table as const any ptr)
	declare sub glColorTableParameterfv(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glColorTableParameteriv(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glCopyColorTable(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei)
	declare sub glGetColorTable(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval table as any ptr)
	declare sub glGetColorTableParameterfv(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetColorTableParameteriv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glColorSubTable(byval target as GLenum, byval start as GLsizei, byval count as GLsizei, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
	declare sub glCopyColorSubTable(byval target as GLenum, byval start as GLsizei, byval x as GLint, byval y as GLint, byval width as GLsizei)
	declare sub glConvolutionFilter1D(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval image as const any ptr)
	declare sub glConvolutionFilter2D(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval image as const any ptr)
	declare sub glConvolutionParameterf(byval target as GLenum, byval pname as GLenum, byval params as GLfloat)
	declare sub glConvolutionParameterfv(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glConvolutionParameteri(byval target as GLenum, byval pname as GLenum, byval params as GLint)
	declare sub glConvolutionParameteriv(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glCopyConvolutionFilter1D(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei)
	declare sub glCopyConvolutionFilter2D(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
	declare sub glGetConvolutionFilter(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval image as any ptr)
	declare sub glGetConvolutionParameterfv(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetConvolutionParameteriv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetSeparableFilter(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval row as any ptr, byval column as any ptr, byval span as any ptr)
	declare sub glSeparableFilter2D(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval row as const any ptr, byval column as const any ptr)
	declare sub glGetHistogram(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval values as any ptr)
	declare sub glGetHistogramParameterfv(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetHistogramParameteriv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetMinmax(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval values as any ptr)
	declare sub glGetMinmaxParameterfv(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetMinmaxParameteriv(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glHistogram(byval target as GLenum, byval width as GLsizei, byval internalformat as GLenum, byval sink as GLboolean)
	declare sub glMinmax(byval target as GLenum, byval internalformat as GLenum, byval sink as GLboolean)
	declare sub glResetHistogram(byval target as GLenum)
	declare sub glResetMinmax(byval target as GLenum)
#endif

const GL_ARB_indirect_parameters = 1
const GL_PARAMETER_BUFFER_ARB = &h80EE
const GL_PARAMETER_BUFFER_BINDING_ARB = &h80EF
type PFNGLMULTIDRAWARRAYSINDIRECTCOUNTARBPROC as sub(byval mode as GLenum, byval indirect as GLintptr, byval drawcount as GLintptr, byval maxdrawcount as GLsizei, byval stride as GLsizei)
type PFNGLMULTIDRAWELEMENTSINDIRECTCOUNTARBPROC as sub(byval mode as GLenum, byval type as GLenum, byval indirect as GLintptr, byval drawcount as GLintptr, byval maxdrawcount as GLsizei, byval stride as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glMultiDrawArraysIndirectCountARB(byval mode as GLenum, byval indirect as GLintptr, byval drawcount as GLintptr, byval maxdrawcount as GLsizei, byval stride as GLsizei)
	declare sub glMultiDrawElementsIndirectCountARB(byval mode as GLenum, byval type as GLenum, byval indirect as GLintptr, byval drawcount as GLintptr, byval maxdrawcount as GLsizei, byval stride as GLsizei)
#endif

const GL_ARB_instanced_arrays = 1
const GL_VERTEX_ATTRIB_ARRAY_DIVISOR_ARB = &h88FE
type PFNGLVERTEXATTRIBDIVISORARBPROC as sub(byval index as GLuint, byval divisor as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVertexAttribDivisorARB(byval index as GLuint, byval divisor as GLuint)
#endif

const GL_ARB_internalformat_query = 1
const GL_ARB_internalformat_query2 = 1
const GL_SRGB_DECODE_ARB = &h8299
const GL_ARB_invalidate_subdata = 1
const GL_ARB_map_buffer_alignment = 1
const GL_ARB_map_buffer_range = 1
const GL_ARB_matrix_palette = 1
const GL_MATRIX_PALETTE_ARB = &h8840
const GL_MAX_MATRIX_PALETTE_STACK_DEPTH_ARB = &h8841
const GL_MAX_PALETTE_MATRICES_ARB = &h8842
const GL_CURRENT_PALETTE_MATRIX_ARB = &h8843
const GL_MATRIX_INDEX_ARRAY_ARB = &h8844
const GL_CURRENT_MATRIX_INDEX_ARB = &h8845
const GL_MATRIX_INDEX_ARRAY_SIZE_ARB = &h8846
const GL_MATRIX_INDEX_ARRAY_TYPE_ARB = &h8847
const GL_MATRIX_INDEX_ARRAY_STRIDE_ARB = &h8848
const GL_MATRIX_INDEX_ARRAY_POINTER_ARB = &h8849

type PFNGLCURRENTPALETTEMATRIXARBPROC as sub(byval index as GLint)
type PFNGLMATRIXINDEXUBVARBPROC as sub(byval size as GLint, byval indices as const GLubyte ptr)
type PFNGLMATRIXINDEXUSVARBPROC as sub(byval size as GLint, byval indices as const GLushort ptr)
type PFNGLMATRIXINDEXUIVARBPROC as sub(byval size as GLint, byval indices as const GLuint ptr)
type PFNGLMATRIXINDEXPOINTERARBPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glCurrentPaletteMatrixARB(byval index as GLint)
	declare sub glMatrixIndexubvARB(byval size as GLint, byval indices as const GLubyte ptr)
	declare sub glMatrixIndexusvARB(byval size as GLint, byval indices as const GLushort ptr)
	declare sub glMatrixIndexuivARB(byval size as GLint, byval indices as const GLuint ptr)
	declare sub glMatrixIndexPointerARB(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
#endif

const GL_ARB_multi_bind = 1
const GL_ARB_multi_draw_indirect = 1
const GL_ARB_multisample = 1
const GL_MULTISAMPLE_ARB = &h809D
const GL_SAMPLE_ALPHA_TO_COVERAGE_ARB = &h809E
const GL_SAMPLE_ALPHA_TO_ONE_ARB = &h809F
const GL_SAMPLE_COVERAGE_ARB = &h80A0
const GL_SAMPLE_BUFFERS_ARB = &h80A8
const GL_SAMPLES_ARB = &h80A9
const GL_SAMPLE_COVERAGE_VALUE_ARB = &h80AA
const GL_SAMPLE_COVERAGE_INVERT_ARB = &h80AB
const GL_MULTISAMPLE_BIT_ARB = &h20000000
type PFNGLSAMPLECOVERAGEARBPROC as sub(byval value as GLfloat, byval invert as GLboolean)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glSampleCoverageARB(byval value as GLfloat, byval invert as GLboolean)
#endif

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

#ifdef GL_GLEXT_PROTOTYPES
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
#endif

const GL_ARB_occlusion_query = 1
const GL_QUERY_COUNTER_BITS_ARB = &h8864
const GL_CURRENT_QUERY_ARB = &h8865
const GL_QUERY_RESULT_ARB = &h8866
const GL_QUERY_RESULT_AVAILABLE_ARB = &h8867
const GL_SAMPLES_PASSED_ARB = &h8914

type PFNGLGENQUERIESARBPROC as sub(byval n as GLsizei, byval ids as GLuint ptr)
type PFNGLDELETEQUERIESARBPROC as sub(byval n as GLsizei, byval ids as const GLuint ptr)
type PFNGLISQUERYARBPROC as function(byval id as GLuint) as GLboolean
type PFNGLBEGINQUERYARBPROC as sub(byval target as GLenum, byval id as GLuint)
type PFNGLENDQUERYARBPROC as sub(byval target as GLenum)
type PFNGLGETQUERYIVARBPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETQUERYOBJECTIVARBPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETQUERYOBJECTUIVARBPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLuint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGenQueriesARB(byval n as GLsizei, byval ids as GLuint ptr)
	declare sub glDeleteQueriesARB(byval n as GLsizei, byval ids as const GLuint ptr)
	declare function glIsQueryARB(byval id as GLuint) as GLboolean
	declare sub glBeginQueryARB(byval target as GLenum, byval id as GLuint)
	declare sub glEndQueryARB(byval target as GLenum)
	declare sub glGetQueryivARB(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetQueryObjectivARB(byval id as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetQueryObjectuivARB(byval id as GLuint, byval pname as GLenum, byval params as GLuint ptr)
#endif

const GL_ARB_occlusion_query2 = 1
const GL_ARB_pipeline_statistics_query = 1
const GL_VERTICES_SUBMITTED_ARB = &h82EE
const GL_PRIMITIVES_SUBMITTED_ARB = &h82EF
const GL_VERTEX_SHADER_INVOCATIONS_ARB = &h82F0
const GL_TESS_CONTROL_SHADER_PATCHES_ARB = &h82F1
const GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB = &h82F2
const GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB = &h82F3
const GL_FRAGMENT_SHADER_INVOCATIONS_ARB = &h82F4
const GL_COMPUTE_SHADER_INVOCATIONS_ARB = &h82F5
const GL_CLIPPING_INPUT_PRIMITIVES_ARB = &h82F6
const GL_CLIPPING_OUTPUT_PRIMITIVES_ARB = &h82F7
const GL_ARB_pixel_buffer_object = 1
const GL_PIXEL_PACK_BUFFER_ARB = &h88EB
const GL_PIXEL_UNPACK_BUFFER_ARB = &h88EC
const GL_PIXEL_PACK_BUFFER_BINDING_ARB = &h88ED
const GL_PIXEL_UNPACK_BUFFER_BINDING_ARB = &h88EF
const GL_ARB_point_parameters = 1
const GL_POINT_SIZE_MIN_ARB = &h8126
const GL_POINT_SIZE_MAX_ARB = &h8127
const GL_POINT_FADE_THRESHOLD_SIZE_ARB = &h8128
const GL_POINT_DISTANCE_ATTENUATION_ARB = &h8129
type PFNGLPOINTPARAMETERFARBPROC as sub(byval pname as GLenum, byval param as GLfloat)
type PFNGLPOINTPARAMETERFVARBPROC as sub(byval pname as GLenum, byval params as const GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPointParameterfARB(byval pname as GLenum, byval param as GLfloat)
	declare sub glPointParameterfvARB(byval pname as GLenum, byval params as const GLfloat ptr)
#endif

const GL_ARB_point_sprite = 1
const GL_POINT_SPRITE_ARB = &h8861
const GL_COORD_REPLACE_ARB = &h8862
const GL_ARB_program_interface_query = 1
const GL_ARB_provoking_vertex = 1
const GL_ARB_query_buffer_object = 1
const GL_ARB_robust_buffer_access_behavior = 1
const GL_ARB_robustness = 1
const GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT_ARB = &h00000004
const GL_LOSE_CONTEXT_ON_RESET_ARB = &h8252
const GL_GUILTY_CONTEXT_RESET_ARB = &h8253
const GL_INNOCENT_CONTEXT_RESET_ARB = &h8254
const GL_UNKNOWN_CONTEXT_RESET_ARB = &h8255
const GL_RESET_NOTIFICATION_STRATEGY_ARB = &h8256
const GL_NO_RESET_NOTIFICATION_ARB = &h8261

type PFNGLGETGRAPHICSRESETSTATUSARBPROC as function() as GLenum
type PFNGLGETNTEXIMAGEARBPROC as sub(byval target as GLenum, byval level as GLint, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval img as any ptr)
type PFNGLREADNPIXELSARBPROC as sub(byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval data as any ptr)
type PFNGLGETNCOMPRESSEDTEXIMAGEARBPROC as sub(byval target as GLenum, byval lod as GLint, byval bufSize as GLsizei, byval img as any ptr)
type PFNGLGETNUNIFORMFVARBPROC as sub(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLfloat ptr)
type PFNGLGETNUNIFORMIVARBPROC as sub(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLint ptr)
type PFNGLGETNUNIFORMUIVARBPROC as sub(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLuint ptr)
type PFNGLGETNUNIFORMDVARBPROC as sub(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLdouble ptr)
type PFNGLGETNMAPDVARBPROC as sub(byval target as GLenum, byval query as GLenum, byval bufSize as GLsizei, byval v as GLdouble ptr)
type PFNGLGETNMAPFVARBPROC as sub(byval target as GLenum, byval query as GLenum, byval bufSize as GLsizei, byval v as GLfloat ptr)
type PFNGLGETNMAPIVARBPROC as sub(byval target as GLenum, byval query as GLenum, byval bufSize as GLsizei, byval v as GLint ptr)
type PFNGLGETNPIXELMAPFVARBPROC as sub(byval map as GLenum, byval bufSize as GLsizei, byval values as GLfloat ptr)
type PFNGLGETNPIXELMAPUIVARBPROC as sub(byval map as GLenum, byval bufSize as GLsizei, byval values as GLuint ptr)
type PFNGLGETNPIXELMAPUSVARBPROC as sub(byval map as GLenum, byval bufSize as GLsizei, byval values as GLushort ptr)
type PFNGLGETNPOLYGONSTIPPLEARBPROC as sub(byval bufSize as GLsizei, byval pattern as GLubyte ptr)
type PFNGLGETNCOLORTABLEARBPROC as sub(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval table as any ptr)
type PFNGLGETNCONVOLUTIONFILTERARBPROC as sub(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval image as any ptr)
type PFNGLGETNSEPARABLEFILTERARBPROC as sub(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval rowBufSize as GLsizei, byval row as any ptr, byval columnBufSize as GLsizei, byval column as any ptr, byval span as any ptr)
type PFNGLGETNHISTOGRAMARBPROC as sub(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval values as any ptr)
type PFNGLGETNMINMAXARBPROC as sub(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval values as any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare function glGetGraphicsResetStatusARB() as GLenum
	declare sub glGetnTexImageARB(byval target as GLenum, byval level as GLint, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval img as any ptr)
	declare sub glReadnPixelsARB(byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval data as any ptr)
	declare sub glGetnCompressedTexImageARB(byval target as GLenum, byval lod as GLint, byval bufSize as GLsizei, byval img as any ptr)
	declare sub glGetnUniformfvARB(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLfloat ptr)
	declare sub glGetnUniformivARB(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLint ptr)
	declare sub glGetnUniformuivARB(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLuint ptr)
	declare sub glGetnUniformdvARB(byval program as GLuint, byval location as GLint, byval bufSize as GLsizei, byval params as GLdouble ptr)
	declare sub glGetnMapdvARB(byval target as GLenum, byval query as GLenum, byval bufSize as GLsizei, byval v as GLdouble ptr)
	declare sub glGetnMapfvARB(byval target as GLenum, byval query as GLenum, byval bufSize as GLsizei, byval v as GLfloat ptr)
	declare sub glGetnMapivARB(byval target as GLenum, byval query as GLenum, byval bufSize as GLsizei, byval v as GLint ptr)
	declare sub glGetnPixelMapfvARB(byval map as GLenum, byval bufSize as GLsizei, byval values as GLfloat ptr)
	declare sub glGetnPixelMapuivARB(byval map as GLenum, byval bufSize as GLsizei, byval values as GLuint ptr)
	declare sub glGetnPixelMapusvARB(byval map as GLenum, byval bufSize as GLsizei, byval values as GLushort ptr)
	declare sub glGetnPolygonStippleARB(byval bufSize as GLsizei, byval pattern as GLubyte ptr)
	declare sub glGetnColorTableARB(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval table as any ptr)
	declare sub glGetnConvolutionFilterARB(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval image as any ptr)
	declare sub glGetnSeparableFilterARB(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval rowBufSize as GLsizei, byval row as any ptr, byval columnBufSize as GLsizei, byval column as any ptr, byval span as any ptr)
	declare sub glGetnHistogramARB(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval values as any ptr)
	declare sub glGetnMinmaxARB(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval bufSize as GLsizei, byval values as any ptr)
#endif

const GL_ARB_robustness_isolation = 1
const GL_ARB_sample_shading = 1
const GL_SAMPLE_SHADING_ARB = &h8C36
const GL_MIN_SAMPLE_SHADING_VALUE_ARB = &h8C37
type PFNGLMINSAMPLESHADINGARBPROC as sub(byval value as GLfloat)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glMinSampleShadingARB(byval value as GLfloat)
#endif

const GL_ARB_sampler_objects = 1
const GL_ARB_seamless_cube_map = 1
const GL_ARB_seamless_cubemap_per_texture = 1
const GL_ARB_separate_shader_objects = 1
const GL_ARB_shader_atomic_counters = 1
const GL_ARB_shader_bit_encoding = 1
const GL_ARB_shader_draw_parameters = 1
const GL_ARB_shader_group_vote = 1
const GL_ARB_shader_image_load_store = 1
const GL_ARB_shader_image_size = 1
const GL_ARB_shader_objects = 1
type GLhandleARB as ulong
type GLcharARB as zstring
const GL_PROGRAM_OBJECT_ARB = &h8B40
const GL_SHADER_OBJECT_ARB = &h8B48
const GL_OBJECT_TYPE_ARB = &h8B4E
const GL_OBJECT_SUBTYPE_ARB = &h8B4F
const GL_FLOAT_VEC2_ARB = &h8B50
const GL_FLOAT_VEC3_ARB = &h8B51
const GL_FLOAT_VEC4_ARB = &h8B52
const GL_INT_VEC2_ARB = &h8B53
const GL_INT_VEC3_ARB = &h8B54
const GL_INT_VEC4_ARB = &h8B55
const GL_BOOL_ARB = &h8B56
const GL_BOOL_VEC2_ARB = &h8B57
const GL_BOOL_VEC3_ARB = &h8B58
const GL_BOOL_VEC4_ARB = &h8B59
const GL_FLOAT_MAT2_ARB = &h8B5A
const GL_FLOAT_MAT3_ARB = &h8B5B
const GL_FLOAT_MAT4_ARB = &h8B5C
const GL_SAMPLER_1D_ARB = &h8B5D
const GL_SAMPLER_2D_ARB = &h8B5E
const GL_SAMPLER_3D_ARB = &h8B5F
const GL_SAMPLER_CUBE_ARB = &h8B60
const GL_SAMPLER_1D_SHADOW_ARB = &h8B61
const GL_SAMPLER_2D_SHADOW_ARB = &h8B62
const GL_SAMPLER_2D_RECT_ARB = &h8B63
const GL_SAMPLER_2D_RECT_SHADOW_ARB = &h8B64
const GL_OBJECT_DELETE_STATUS_ARB = &h8B80
const GL_OBJECT_COMPILE_STATUS_ARB = &h8B81
const GL_OBJECT_LINK_STATUS_ARB = &h8B82
const GL_OBJECT_VALIDATE_STATUS_ARB = &h8B83
const GL_OBJECT_INFO_LOG_LENGTH_ARB = &h8B84
const GL_OBJECT_ATTACHED_OBJECTS_ARB = &h8B85
const GL_OBJECT_ACTIVE_UNIFORMS_ARB = &h8B86
const GL_OBJECT_ACTIVE_UNIFORM_MAX_LENGTH_ARB = &h8B87
const GL_OBJECT_SHADER_SOURCE_LENGTH_ARB = &h8B88

type PFNGLDELETEOBJECTARBPROC as sub(byval obj as GLhandleARB)
type PFNGLGETHANDLEARBPROC as function(byval pname as GLenum) as GLhandleARB
type PFNGLDETACHOBJECTARBPROC as sub(byval containerObj as GLhandleARB, byval attachedObj as GLhandleARB)
type PFNGLCREATESHADEROBJECTARBPROC as function(byval shaderType as GLenum) as GLhandleARB
type PFNGLSHADERSOURCEARBPROC as sub(byval shaderObj as GLhandleARB, byval count as GLsizei, byval string as const GLcharARB ptr ptr, byval length as const GLint ptr)
type PFNGLCOMPILESHADERARBPROC as sub(byval shaderObj as GLhandleARB)
type PFNGLCREATEPROGRAMOBJECTARBPROC as function() as GLhandleARB
type PFNGLATTACHOBJECTARBPROC as sub(byval containerObj as GLhandleARB, byval obj as GLhandleARB)
type PFNGLLINKPROGRAMARBPROC as sub(byval programObj as GLhandleARB)
type PFNGLUSEPROGRAMOBJECTARBPROC as sub(byval programObj as GLhandleARB)
type PFNGLVALIDATEPROGRAMARBPROC as sub(byval programObj as GLhandleARB)
type PFNGLUNIFORM1FARBPROC as sub(byval location as GLint, byval v0 as GLfloat)
type PFNGLUNIFORM2FARBPROC as sub(byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat)
type PFNGLUNIFORM3FARBPROC as sub(byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat)
type PFNGLUNIFORM4FARBPROC as sub(byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat, byval v3 as GLfloat)
type PFNGLUNIFORM1IARBPROC as sub(byval location as GLint, byval v0 as GLint)
type PFNGLUNIFORM2IARBPROC as sub(byval location as GLint, byval v0 as GLint, byval v1 as GLint)
type PFNGLUNIFORM3IARBPROC as sub(byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint)
type PFNGLUNIFORM4IARBPROC as sub(byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint, byval v3 as GLint)
type PFNGLUNIFORM1FVARBPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLUNIFORM2FVARBPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLUNIFORM3FVARBPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLUNIFORM4FVARBPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLUNIFORM1IVARBPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLUNIFORM2IVARBPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLUNIFORM3IVARBPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLUNIFORM4IVARBPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLUNIFORMMATRIX2FVARBPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLUNIFORMMATRIX3FVARBPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLUNIFORMMATRIX4FVARBPROC as sub(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLGETOBJECTPARAMETERFVARBPROC as sub(byval obj as GLhandleARB, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETOBJECTPARAMETERIVARBPROC as sub(byval obj as GLhandleARB, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETINFOLOGARBPROC as sub(byval obj as GLhandleARB, byval maxLength as GLsizei, byval length as GLsizei ptr, byval infoLog as GLcharARB ptr)
type PFNGLGETATTACHEDOBJECTSARBPROC as sub(byval containerObj as GLhandleARB, byval maxCount as GLsizei, byval count as GLsizei ptr, byval obj as GLhandleARB ptr)
type PFNGLGETUNIFORMLOCATIONARBPROC as function(byval programObj as GLhandleARB, byval name as const GLcharARB ptr) as GLint
type PFNGLGETACTIVEUNIFORMARBPROC as sub(byval programObj as GLhandleARB, byval index as GLuint, byval maxLength as GLsizei, byval length as GLsizei ptr, byval size as GLint ptr, byval type as GLenum ptr, byval name as GLcharARB ptr)
type PFNGLGETUNIFORMFVARBPROC as sub(byval programObj as GLhandleARB, byval location as GLint, byval params as GLfloat ptr)
type PFNGLGETUNIFORMIVARBPROC as sub(byval programObj as GLhandleARB, byval location as GLint, byval params as GLint ptr)
type PFNGLGETSHADERSOURCEARBPROC as sub(byval obj as GLhandleARB, byval maxLength as GLsizei, byval length as GLsizei ptr, byval source as GLcharARB ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDeleteObjectARB(byval obj as GLhandleARB)
	declare function glGetHandleARB(byval pname as GLenum) as GLhandleARB
	declare sub glDetachObjectARB(byval containerObj as GLhandleARB, byval attachedObj as GLhandleARB)
	declare function glCreateShaderObjectARB(byval shaderType as GLenum) as GLhandleARB
	declare sub glShaderSourceARB(byval shaderObj as GLhandleARB, byval count as GLsizei, byval string as const GLcharARB ptr ptr, byval length as const GLint ptr)
	declare sub glCompileShaderARB(byval shaderObj as GLhandleARB)
	declare function glCreateProgramObjectARB() as GLhandleARB
	declare sub glAttachObjectARB(byval containerObj as GLhandleARB, byval obj as GLhandleARB)
	declare sub glLinkProgramARB(byval programObj as GLhandleARB)
	declare sub glUseProgramObjectARB(byval programObj as GLhandleARB)
	declare sub glValidateProgramARB(byval programObj as GLhandleARB)
	declare sub glUniform1fARB(byval location as GLint, byval v0 as GLfloat)
	declare sub glUniform2fARB(byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat)
	declare sub glUniform3fARB(byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat)
	declare sub glUniform4fARB(byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat, byval v3 as GLfloat)
	declare sub glUniform1iARB(byval location as GLint, byval v0 as GLint)
	declare sub glUniform2iARB(byval location as GLint, byval v0 as GLint, byval v1 as GLint)
	declare sub glUniform3iARB(byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint)
	declare sub glUniform4iARB(byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint, byval v3 as GLint)
	declare sub glUniform1fvARB(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glUniform2fvARB(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glUniform3fvARB(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glUniform4fvARB(byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glUniform1ivARB(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glUniform2ivARB(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glUniform3ivARB(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glUniform4ivARB(byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glUniformMatrix2fvARB(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glUniformMatrix3fvARB(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glUniformMatrix4fvARB(byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glGetObjectParameterfvARB(byval obj as GLhandleARB, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetObjectParameterivARB(byval obj as GLhandleARB, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetInfoLogARB(byval obj as GLhandleARB, byval maxLength as GLsizei, byval length as GLsizei ptr, byval infoLog as GLcharARB ptr)
	declare sub glGetAttachedObjectsARB(byval containerObj as GLhandleARB, byval maxCount as GLsizei, byval count as GLsizei ptr, byval obj as GLhandleARB ptr)
	declare function glGetUniformLocationARB(byval programObj as GLhandleARB, byval name as const GLcharARB ptr) as GLint
	declare sub glGetActiveUniformARB(byval programObj as GLhandleARB, byval index as GLuint, byval maxLength as GLsizei, byval length as GLsizei ptr, byval size as GLint ptr, byval type as GLenum ptr, byval name as GLcharARB ptr)
	declare sub glGetUniformfvARB(byval programObj as GLhandleARB, byval location as GLint, byval params as GLfloat ptr)
	declare sub glGetUniformivARB(byval programObj as GLhandleARB, byval location as GLint, byval params as GLint ptr)
	declare sub glGetShaderSourceARB(byval obj as GLhandleARB, byval maxLength as GLsizei, byval length as GLsizei ptr, byval source as GLcharARB ptr)
#endif

const GL_ARB_shader_precision = 1
const GL_ARB_shader_stencil_export = 1
const GL_ARB_shader_storage_buffer_object = 1
const GL_ARB_shader_subroutine = 1
const GL_ARB_shader_texture_image_samples = 1
const GL_ARB_shader_texture_lod = 1
const GL_ARB_shading_language_100 = 1
const GL_SHADING_LANGUAGE_VERSION_ARB = &h8B8C
const GL_ARB_shading_language_420pack = 1
const GL_ARB_shading_language_include = 1
const GL_SHADER_INCLUDE_ARB = &h8DAE
const GL_NAMED_STRING_LENGTH_ARB = &h8DE9
const GL_NAMED_STRING_TYPE_ARB = &h8DEA

type PFNGLNAMEDSTRINGARBPROC as sub(byval type as GLenum, byval namelen as GLint, byval name as const GLchar ptr, byval stringlen as GLint, byval string as const GLchar ptr)
type PFNGLDELETENAMEDSTRINGARBPROC as sub(byval namelen as GLint, byval name as const GLchar ptr)
type PFNGLCOMPILESHADERINCLUDEARBPROC as sub(byval shader as GLuint, byval count as GLsizei, byval path as const GLchar const ptr ptr, byval length as const GLint ptr)
type PFNGLISNAMEDSTRINGARBPROC as function(byval namelen as GLint, byval name as const GLchar ptr) as GLboolean
type PFNGLGETNAMEDSTRINGARBPROC as sub(byval namelen as GLint, byval name as const GLchar ptr, byval bufSize as GLsizei, byval stringlen as GLint ptr, byval string as GLchar ptr)
type PFNGLGETNAMEDSTRINGIVARBPROC as sub(byval namelen as GLint, byval name as const GLchar ptr, byval pname as GLenum, byval params as GLint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glNamedStringARB(byval type as GLenum, byval namelen as GLint, byval name as const GLchar ptr, byval stringlen as GLint, byval string as const GLchar ptr)
	declare sub glDeleteNamedStringARB(byval namelen as GLint, byval name as const GLchar ptr)
	declare sub glCompileShaderIncludeARB(byval shader as GLuint, byval count as GLsizei, byval path as const GLchar const ptr ptr, byval length as const GLint ptr)
	declare function glIsNamedStringARB(byval namelen as GLint, byval name as const GLchar ptr) as GLboolean
	declare sub glGetNamedStringARB(byval namelen as GLint, byval name as const GLchar ptr, byval bufSize as GLsizei, byval stringlen as GLint ptr, byval string as GLchar ptr)
	declare sub glGetNamedStringivARB(byval namelen as GLint, byval name as const GLchar ptr, byval pname as GLenum, byval params as GLint ptr)
#endif

const GL_ARB_shading_language_packing = 1
const GL_ARB_shadow = 1
const GL_TEXTURE_COMPARE_MODE_ARB = &h884C
const GL_TEXTURE_COMPARE_FUNC_ARB = &h884D
const GL_COMPARE_R_TO_TEXTURE_ARB = &h884E
const GL_ARB_shadow_ambient = 1
const GL_TEXTURE_COMPARE_FAIL_VALUE_ARB = &h80BF
const GL_ARB_sparse_buffer = 1
const GL_SPARSE_STORAGE_BIT_ARB = &h0400
const GL_SPARSE_BUFFER_PAGE_SIZE_ARB = &h82F8

type PFNGLBUFFERPAGECOMMITMENTARBPROC as sub(byval target as GLenum, byval offset as GLintptr, byval size as GLsizeiptr, byval commit as GLboolean)
type PFNGLNAMEDBUFFERPAGECOMMITMENTEXTPROC as sub(byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr, byval commit as GLboolean)
type PFNGLNAMEDBUFFERPAGECOMMITMENTARBPROC as sub(byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr, byval commit as GLboolean)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBufferPageCommitmentARB(byval target as GLenum, byval offset as GLintptr, byval size as GLsizeiptr, byval commit as GLboolean)
	declare sub glNamedBufferPageCommitmentEXT(byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr, byval commit as GLboolean)
	declare sub glNamedBufferPageCommitmentARB(byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr, byval commit as GLboolean)
#endif

const GL_ARB_sparse_texture = 1
const GL_TEXTURE_SPARSE_ARB = &h91A6
const GL_VIRTUAL_PAGE_SIZE_INDEX_ARB = &h91A7
const GL_NUM_SPARSE_LEVELS_ARB = &h91AA
const GL_NUM_VIRTUAL_PAGE_SIZES_ARB = &h91A8
const GL_VIRTUAL_PAGE_SIZE_X_ARB = &h9195
const GL_VIRTUAL_PAGE_SIZE_Y_ARB = &h9196
const GL_VIRTUAL_PAGE_SIZE_Z_ARB = &h9197
const GL_MAX_SPARSE_TEXTURE_SIZE_ARB = &h9198
const GL_MAX_SPARSE_3D_TEXTURE_SIZE_ARB = &h9199
const GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS_ARB = &h919A
const GL_SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_ARB = &h91A9
type PFNGLTEXPAGECOMMITMENTARBPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval resident as GLboolean)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTexPageCommitmentARB(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval resident as GLboolean)
#endif

const GL_ARB_stencil_texturing = 1
const GL_ARB_sync = 1
const GL_ARB_tessellation_shader = 1
const GL_ARB_texture_barrier = 1
const GL_ARB_texture_border_clamp = 1
const GL_CLAMP_TO_BORDER_ARB = &h812D
const GL_ARB_texture_buffer_object = 1
const GL_TEXTURE_BUFFER_ARB = &h8C2A
const GL_MAX_TEXTURE_BUFFER_SIZE_ARB = &h8C2B
const GL_TEXTURE_BINDING_BUFFER_ARB = &h8C2C
const GL_TEXTURE_BUFFER_DATA_STORE_BINDING_ARB = &h8C2D
const GL_TEXTURE_BUFFER_FORMAT_ARB = &h8C2E
type PFNGLTEXBUFFERARBPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTexBufferARB(byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint)
#endif

const GL_ARB_texture_buffer_object_rgb32 = 1
const GL_ARB_texture_buffer_range = 1
const GL_ARB_texture_compression = 1
const GL_COMPRESSED_ALPHA_ARB = &h84E9
const GL_COMPRESSED_LUMINANCE_ARB = &h84EA
const GL_COMPRESSED_LUMINANCE_ALPHA_ARB = &h84EB
const GL_COMPRESSED_INTENSITY_ARB = &h84EC
const GL_COMPRESSED_RGB_ARB = &h84ED
const GL_COMPRESSED_RGBA_ARB = &h84EE
const GL_TEXTURE_COMPRESSION_HINT_ARB = &h84EF
const GL_TEXTURE_COMPRESSED_IMAGE_SIZE_ARB = &h86A0
const GL_TEXTURE_COMPRESSED_ARB = &h86A1
const GL_NUM_COMPRESSED_TEXTURE_FORMATS_ARB = &h86A2
const GL_COMPRESSED_TEXTURE_FORMATS_ARB = &h86A3

type PFNGLCOMPRESSEDTEXIMAGE3DARBPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOMPRESSEDTEXIMAGE2DARBPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOMPRESSEDTEXIMAGE1DARBPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOMPRESSEDTEXSUBIMAGE3DARBPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOMPRESSEDTEXSUBIMAGE2DARBPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLCOMPRESSEDTEXSUBIMAGE1DARBPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
type PFNGLGETCOMPRESSEDTEXIMAGEARBPROC as sub(byval target as GLenum, byval level as GLint, byval img as any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glCompressedTexImage3DARB(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCompressedTexImage2DARB(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCompressedTexImage1DARB(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCompressedTexSubImage3DARB(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCompressedTexSubImage2DARB(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glCompressedTexSubImage1DARB(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval data as const any ptr)
	declare sub glGetCompressedTexImageARB(byval target as GLenum, byval level as GLint, byval img as any ptr)
#endif

const GL_ARB_texture_compression_bptc = 1
const GL_COMPRESSED_RGBA_BPTC_UNORM_ARB = &h8E8C
const GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB = &h8E8D
const GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB = &h8E8E
const GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB = &h8E8F
const GL_ARB_texture_compression_rgtc = 1
const GL_ARB_texture_cube_map = 1
const GL_NORMAL_MAP_ARB = &h8511
const GL_REFLECTION_MAP_ARB = &h8512
const GL_TEXTURE_CUBE_MAP_ARB = &h8513
const GL_TEXTURE_BINDING_CUBE_MAP_ARB = &h8514
const GL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB = &h8515
const GL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB = &h8516
const GL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB = &h8517
const GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB = &h8518
const GL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB = &h8519
const GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB = &h851A
const GL_PROXY_TEXTURE_CUBE_MAP_ARB = &h851B
const GL_MAX_CUBE_MAP_TEXTURE_SIZE_ARB = &h851C
const GL_ARB_texture_cube_map_array = 1
const GL_TEXTURE_CUBE_MAP_ARRAY_ARB = &h9009
const GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_ARB = &h900A
const GL_PROXY_TEXTURE_CUBE_MAP_ARRAY_ARB = &h900B
const GL_SAMPLER_CUBE_MAP_ARRAY_ARB = &h900C
const GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW_ARB = &h900D
const GL_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = &h900E
const GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = &h900F
const GL_ARB_texture_env_add = 1
const GL_ARB_texture_env_combine = 1
const GL_COMBINE_ARB = &h8570
const GL_COMBINE_RGB_ARB = &h8571
const GL_COMBINE_ALPHA_ARB = &h8572
const GL_SOURCE0_RGB_ARB = &h8580
const GL_SOURCE1_RGB_ARB = &h8581
const GL_SOURCE2_RGB_ARB = &h8582
const GL_SOURCE0_ALPHA_ARB = &h8588
const GL_SOURCE1_ALPHA_ARB = &h8589
const GL_SOURCE2_ALPHA_ARB = &h858A
const GL_OPERAND0_RGB_ARB = &h8590
const GL_OPERAND1_RGB_ARB = &h8591
const GL_OPERAND2_RGB_ARB = &h8592
const GL_OPERAND0_ALPHA_ARB = &h8598
const GL_OPERAND1_ALPHA_ARB = &h8599
const GL_OPERAND2_ALPHA_ARB = &h859A
const GL_RGB_SCALE_ARB = &h8573
const GL_ADD_SIGNED_ARB = &h8574
const GL_INTERPOLATE_ARB = &h8575
const GL_SUBTRACT_ARB = &h84E7
const GL_CONSTANT_ARB = &h8576
const GL_PRIMARY_COLOR_ARB = &h8577
const GL_PREVIOUS_ARB = &h8578
const GL_ARB_texture_env_crossbar = 1
const GL_ARB_texture_env_dot3 = 1
const GL_DOT3_RGB_ARB = &h86AE
const GL_DOT3_RGBA_ARB = &h86AF
const GL_ARB_texture_float = 1
const GL_TEXTURE_RED_TYPE_ARB = &h8C10
const GL_TEXTURE_GREEN_TYPE_ARB = &h8C11
const GL_TEXTURE_BLUE_TYPE_ARB = &h8C12
const GL_TEXTURE_ALPHA_TYPE_ARB = &h8C13
const GL_TEXTURE_LUMINANCE_TYPE_ARB = &h8C14
const GL_TEXTURE_INTENSITY_TYPE_ARB = &h8C15
const GL_TEXTURE_DEPTH_TYPE_ARB = &h8C16
const GL_UNSIGNED_NORMALIZED_ARB = &h8C17
const GL_RGBA32F_ARB = &h8814
const GL_RGB32F_ARB = &h8815
const GL_ALPHA32F_ARB = &h8816
const GL_INTENSITY32F_ARB = &h8817
const GL_LUMINANCE32F_ARB = &h8818
const GL_LUMINANCE_ALPHA32F_ARB = &h8819
const GL_RGBA16F_ARB = &h881A
const GL_RGB16F_ARB = &h881B
const GL_ALPHA16F_ARB = &h881C
const GL_INTENSITY16F_ARB = &h881D
const GL_LUMINANCE16F_ARB = &h881E
const GL_LUMINANCE_ALPHA16F_ARB = &h881F
const GL_ARB_texture_gather = 1
const GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = &h8E5E
const GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = &h8E5F
const GL_MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS_ARB = &h8F9F
const GL_ARB_texture_mirror_clamp_to_edge = 1
const GL_ARB_texture_mirrored_repeat = 1
const GL_MIRRORED_REPEAT_ARB = &h8370
const GL_ARB_texture_multisample = 1
const GL_ARB_texture_non_power_of_two = 1
const GL_ARB_texture_query_levels = 1
const GL_ARB_texture_query_lod = 1
const GL_ARB_texture_rectangle = 1
const GL_TEXTURE_RECTANGLE_ARB = &h84F5
const GL_TEXTURE_BINDING_RECTANGLE_ARB = &h84F6
const GL_PROXY_TEXTURE_RECTANGLE_ARB = &h84F7
const GL_MAX_RECTANGLE_TEXTURE_SIZE_ARB = &h84F8
const GL_ARB_texture_rg = 1
const GL_ARB_texture_rgb10_a2ui = 1
const GL_ARB_texture_stencil8 = 1
const GL_ARB_texture_storage = 1
const GL_ARB_texture_storage_multisample = 1
const GL_ARB_texture_swizzle = 1
const GL_ARB_texture_view = 1
const GL_ARB_timer_query = 1
const GL_ARB_transform_feedback2 = 1
const GL_ARB_transform_feedback3 = 1
const GL_ARB_transform_feedback_instanced = 1
const GL_ARB_transform_feedback_overflow_query = 1
const GL_TRANSFORM_FEEDBACK_OVERFLOW_ARB = &h82EC
const GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW_ARB = &h82ED
const GL_ARB_transpose_matrix = 1
const GL_TRANSPOSE_MODELVIEW_MATRIX_ARB = &h84E3
const GL_TRANSPOSE_PROJECTION_MATRIX_ARB = &h84E4
const GL_TRANSPOSE_TEXTURE_MATRIX_ARB = &h84E5
const GL_TRANSPOSE_COLOR_MATRIX_ARB = &h84E6

type PFNGLLOADTRANSPOSEMATRIXFARBPROC as sub(byval m as const GLfloat ptr)
type PFNGLLOADTRANSPOSEMATRIXDARBPROC as sub(byval m as const GLdouble ptr)
type PFNGLMULTTRANSPOSEMATRIXFARBPROC as sub(byval m as const GLfloat ptr)
type PFNGLMULTTRANSPOSEMATRIXDARBPROC as sub(byval m as const GLdouble ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glLoadTransposeMatrixfARB(byval m as const GLfloat ptr)
	declare sub glLoadTransposeMatrixdARB(byval m as const GLdouble ptr)
	declare sub glMultTransposeMatrixfARB(byval m as const GLfloat ptr)
	declare sub glMultTransposeMatrixdARB(byval m as const GLdouble ptr)
#endif

const GL_ARB_uniform_buffer_object = 1
const GL_ARB_vertex_array_bgra = 1
const GL_ARB_vertex_array_object = 1
const GL_ARB_vertex_attrib_64bit = 1
const GL_ARB_vertex_attrib_binding = 1
const GL_ARB_vertex_blend = 1
const GL_MAX_VERTEX_UNITS_ARB = &h86A4
const GL_ACTIVE_VERTEX_UNITS_ARB = &h86A5
const GL_WEIGHT_SUM_UNITY_ARB = &h86A6
const GL_VERTEX_BLEND_ARB = &h86A7
const GL_CURRENT_WEIGHT_ARB = &h86A8
const GL_WEIGHT_ARRAY_TYPE_ARB = &h86A9
const GL_WEIGHT_ARRAY_STRIDE_ARB = &h86AA
const GL_WEIGHT_ARRAY_SIZE_ARB = &h86AB
const GL_WEIGHT_ARRAY_POINTER_ARB = &h86AC
const GL_WEIGHT_ARRAY_ARB = &h86AD
const GL_MODELVIEW0_ARB = &h1700
const GL_MODELVIEW1_ARB = &h850A
const GL_MODELVIEW2_ARB = &h8722
const GL_MODELVIEW3_ARB = &h8723
const GL_MODELVIEW4_ARB = &h8724
const GL_MODELVIEW5_ARB = &h8725
const GL_MODELVIEW6_ARB = &h8726
const GL_MODELVIEW7_ARB = &h8727
const GL_MODELVIEW8_ARB = &h8728
const GL_MODELVIEW9_ARB = &h8729
const GL_MODELVIEW10_ARB = &h872A
const GL_MODELVIEW11_ARB = &h872B
const GL_MODELVIEW12_ARB = &h872C
const GL_MODELVIEW13_ARB = &h872D
const GL_MODELVIEW14_ARB = &h872E
const GL_MODELVIEW15_ARB = &h872F
const GL_MODELVIEW16_ARB = &h8730
const GL_MODELVIEW17_ARB = &h8731
const GL_MODELVIEW18_ARB = &h8732
const GL_MODELVIEW19_ARB = &h8733
const GL_MODELVIEW20_ARB = &h8734
const GL_MODELVIEW21_ARB = &h8735
const GL_MODELVIEW22_ARB = &h8736
const GL_MODELVIEW23_ARB = &h8737
const GL_MODELVIEW24_ARB = &h8738
const GL_MODELVIEW25_ARB = &h8739
const GL_MODELVIEW26_ARB = &h873A
const GL_MODELVIEW27_ARB = &h873B
const GL_MODELVIEW28_ARB = &h873C
const GL_MODELVIEW29_ARB = &h873D
const GL_MODELVIEW30_ARB = &h873E
const GL_MODELVIEW31_ARB = &h873F

type PFNGLWEIGHTBVARBPROC as sub(byval size as GLint, byval weights as const GLbyte ptr)
type PFNGLWEIGHTSVARBPROC as sub(byval size as GLint, byval weights as const GLshort ptr)
type PFNGLWEIGHTIVARBPROC as sub(byval size as GLint, byval weights as const GLint ptr)
type PFNGLWEIGHTFVARBPROC as sub(byval size as GLint, byval weights as const GLfloat ptr)
type PFNGLWEIGHTDVARBPROC as sub(byval size as GLint, byval weights as const GLdouble ptr)
type PFNGLWEIGHTUBVARBPROC as sub(byval size as GLint, byval weights as const GLubyte ptr)
type PFNGLWEIGHTUSVARBPROC as sub(byval size as GLint, byval weights as const GLushort ptr)
type PFNGLWEIGHTUIVARBPROC as sub(byval size as GLint, byval weights as const GLuint ptr)
type PFNGLWEIGHTPOINTERARBPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
type PFNGLVERTEXBLENDARBPROC as sub(byval count as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glWeightbvARB(byval size as GLint, byval weights as const GLbyte ptr)
	declare sub glWeightsvARB(byval size as GLint, byval weights as const GLshort ptr)
	declare sub glWeightivARB(byval size as GLint, byval weights as const GLint ptr)
	declare sub glWeightfvARB(byval size as GLint, byval weights as const GLfloat ptr)
	declare sub glWeightdvARB(byval size as GLint, byval weights as const GLdouble ptr)
	declare sub glWeightubvARB(byval size as GLint, byval weights as const GLubyte ptr)
	declare sub glWeightusvARB(byval size as GLint, byval weights as const GLushort ptr)
	declare sub glWeightuivARB(byval size as GLint, byval weights as const GLuint ptr)
	declare sub glWeightPointerARB(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
	declare sub glVertexBlendARB(byval count as GLint)
#endif

const GL_ARB_vertex_buffer_object = 1
type GLsizeiptrARB as integer
type GLintptrARB as integer
const GL_BUFFER_SIZE_ARB = &h8764
const GL_BUFFER_USAGE_ARB = &h8765
const GL_ARRAY_BUFFER_ARB = &h8892
const GL_ELEMENT_ARRAY_BUFFER_ARB = &h8893
const GL_ARRAY_BUFFER_BINDING_ARB = &h8894
const GL_ELEMENT_ARRAY_BUFFER_BINDING_ARB = &h8895
const GL_VERTEX_ARRAY_BUFFER_BINDING_ARB = &h8896
const GL_NORMAL_ARRAY_BUFFER_BINDING_ARB = &h8897
const GL_COLOR_ARRAY_BUFFER_BINDING_ARB = &h8898
const GL_INDEX_ARRAY_BUFFER_BINDING_ARB = &h8899
const GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING_ARB = &h889A
const GL_EDGE_FLAG_ARRAY_BUFFER_BINDING_ARB = &h889B
const GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING_ARB = &h889C
const GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING_ARB = &h889D
const GL_WEIGHT_ARRAY_BUFFER_BINDING_ARB = &h889E
const GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING_ARB = &h889F
const GL_READ_ONLY_ARB = &h88B8
const GL_WRITE_ONLY_ARB = &h88B9
const GL_READ_WRITE_ARB = &h88BA
const GL_BUFFER_ACCESS_ARB = &h88BB
const GL_BUFFER_MAPPED_ARB = &h88BC
const GL_BUFFER_MAP_POINTER_ARB = &h88BD
const GL_STREAM_DRAW_ARB = &h88E0
const GL_STREAM_READ_ARB = &h88E1
const GL_STREAM_COPY_ARB = &h88E2
const GL_STATIC_DRAW_ARB = &h88E4
const GL_STATIC_READ_ARB = &h88E5
const GL_STATIC_COPY_ARB = &h88E6
const GL_DYNAMIC_DRAW_ARB = &h88E8
const GL_DYNAMIC_READ_ARB = &h88E9
const GL_DYNAMIC_COPY_ARB = &h88EA

type PFNGLBINDBUFFERARBPROC as sub(byval target as GLenum, byval buffer as GLuint)
type PFNGLDELETEBUFFERSARBPROC as sub(byval n as GLsizei, byval buffers as const GLuint ptr)
type PFNGLGENBUFFERSARBPROC as sub(byval n as GLsizei, byval buffers as GLuint ptr)
type PFNGLISBUFFERARBPROC as function(byval buffer as GLuint) as GLboolean
type PFNGLBUFFERDATAARBPROC as sub(byval target as GLenum, byval size as GLsizeiptrARB, byval data as const any ptr, byval usage as GLenum)
type PFNGLBUFFERSUBDATAARBPROC as sub(byval target as GLenum, byval offset as GLintptrARB, byval size as GLsizeiptrARB, byval data as const any ptr)
type PFNGLGETBUFFERSUBDATAARBPROC as sub(byval target as GLenum, byval offset as GLintptrARB, byval size as GLsizeiptrARB, byval data as any ptr)
type PFNGLMAPBUFFERARBPROC as function(byval target as GLenum, byval access as GLenum) as any ptr
type PFNGLUNMAPBUFFERARBPROC as function(byval target as GLenum) as GLboolean
type PFNGLGETBUFFERPARAMETERIVARBPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETBUFFERPOINTERVARBPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as any ptr ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBindBufferARB(byval target as GLenum, byval buffer as GLuint)
	declare sub glDeleteBuffersARB(byval n as GLsizei, byval buffers as const GLuint ptr)
	declare sub glGenBuffersARB(byval n as GLsizei, byval buffers as GLuint ptr)
	declare function glIsBufferARB(byval buffer as GLuint) as GLboolean
	declare sub glBufferDataARB(byval target as GLenum, byval size as GLsizeiptrARB, byval data as const any ptr, byval usage as GLenum)
	declare sub glBufferSubDataARB(byval target as GLenum, byval offset as GLintptrARB, byval size as GLsizeiptrARB, byval data as const any ptr)
	declare sub glGetBufferSubDataARB(byval target as GLenum, byval offset as GLintptrARB, byval size as GLsizeiptrARB, byval data as any ptr)
	declare function glMapBufferARB(byval target as GLenum, byval access as GLenum) as any ptr
	declare function glUnmapBufferARB(byval target as GLenum) as GLboolean
	declare sub glGetBufferParameterivARB(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetBufferPointervARB(byval target as GLenum, byval pname as GLenum, byval params as any ptr ptr)
#endif

const GL_ARB_vertex_program = 1
const GL_COLOR_SUM_ARB = &h8458
const GL_VERTEX_PROGRAM_ARB = &h8620
const GL_VERTEX_ATTRIB_ARRAY_ENABLED_ARB = &h8622
const GL_VERTEX_ATTRIB_ARRAY_SIZE_ARB = &h8623
const GL_VERTEX_ATTRIB_ARRAY_STRIDE_ARB = &h8624
const GL_VERTEX_ATTRIB_ARRAY_TYPE_ARB = &h8625
const GL_CURRENT_VERTEX_ATTRIB_ARB = &h8626
const GL_VERTEX_PROGRAM_POINT_SIZE_ARB = &h8642
const GL_VERTEX_PROGRAM_TWO_SIDE_ARB = &h8643
const GL_VERTEX_ATTRIB_ARRAY_POINTER_ARB = &h8645
const GL_MAX_VERTEX_ATTRIBS_ARB = &h8869
const GL_VERTEX_ATTRIB_ARRAY_NORMALIZED_ARB = &h886A
const GL_PROGRAM_ADDRESS_REGISTERS_ARB = &h88B0
const GL_MAX_PROGRAM_ADDRESS_REGISTERS_ARB = &h88B1
const GL_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = &h88B2
const GL_MAX_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB = &h88B3

type PFNGLVERTEXATTRIB1DARBPROC as sub(byval index as GLuint, byval x as GLdouble)
type PFNGLVERTEXATTRIB1DVARBPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIB1FARBPROC as sub(byval index as GLuint, byval x as GLfloat)
type PFNGLVERTEXATTRIB1FVARBPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIB1SARBPROC as sub(byval index as GLuint, byval x as GLshort)
type PFNGLVERTEXATTRIB1SVARBPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB2DARBPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble)
type PFNGLVERTEXATTRIB2DVARBPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIB2FARBPROC as sub(byval index as GLuint, byval x as GLfloat, byval y as GLfloat)
type PFNGLVERTEXATTRIB2FVARBPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIB2SARBPROC as sub(byval index as GLuint, byval x as GLshort, byval y as GLshort)
type PFNGLVERTEXATTRIB2SVARBPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB3DARBPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLVERTEXATTRIB3DVARBPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIB3FARBPROC as sub(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLVERTEXATTRIB3FVARBPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIB3SARBPROC as sub(byval index as GLuint, byval x as GLshort, byval y as GLshort, byval z as GLshort)
type PFNGLVERTEXATTRIB3SVARBPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB4NBVARBPROC as sub(byval index as GLuint, byval v as const GLbyte ptr)
type PFNGLVERTEXATTRIB4NIVARBPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLVERTEXATTRIB4NSVARBPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB4NUBARBPROC as sub(byval index as GLuint, byval x as GLubyte, byval y as GLubyte, byval z as GLubyte, byval w as GLubyte)
type PFNGLVERTEXATTRIB4NUBVARBPROC as sub(byval index as GLuint, byval v as const GLubyte ptr)
type PFNGLVERTEXATTRIB4NUIVARBPROC as sub(byval index as GLuint, byval v as const GLuint ptr)
type PFNGLVERTEXATTRIB4NUSVARBPROC as sub(byval index as GLuint, byval v as const GLushort ptr)
type PFNGLVERTEXATTRIB4BVARBPROC as sub(byval index as GLuint, byval v as const GLbyte ptr)
type PFNGLVERTEXATTRIB4DARBPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLVERTEXATTRIB4DVARBPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIB4FARBPROC as sub(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
type PFNGLVERTEXATTRIB4FVARBPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIB4IVARBPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLVERTEXATTRIB4SARBPROC as sub(byval index as GLuint, byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
type PFNGLVERTEXATTRIB4SVARBPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB4UBVARBPROC as sub(byval index as GLuint, byval v as const GLubyte ptr)
type PFNGLVERTEXATTRIB4UIVARBPROC as sub(byval index as GLuint, byval v as const GLuint ptr)
type PFNGLVERTEXATTRIB4USVARBPROC as sub(byval index as GLuint, byval v as const GLushort ptr)
type PFNGLVERTEXATTRIBPOINTERARBPROC as sub(byval index as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval stride as GLsizei, byval pointer as const any ptr)
type PFNGLENABLEVERTEXATTRIBARRAYARBPROC as sub(byval index as GLuint)
type PFNGLDISABLEVERTEXATTRIBARRAYARBPROC as sub(byval index as GLuint)
type PFNGLGETVERTEXATTRIBDVARBPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
type PFNGLGETVERTEXATTRIBFVARBPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETVERTEXATTRIBIVARBPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETVERTEXATTRIBPOINTERVARBPROC as sub(byval index as GLuint, byval pname as GLenum, byval pointer as any ptr ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVertexAttrib1dARB(byval index as GLuint, byval x as GLdouble)
	declare sub glVertexAttrib1dvARB(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttrib1fARB(byval index as GLuint, byval x as GLfloat)
	declare sub glVertexAttrib1fvARB(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glVertexAttrib1sARB(byval index as GLuint, byval x as GLshort)
	declare sub glVertexAttrib1svARB(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib2dARB(byval index as GLuint, byval x as GLdouble, byval y as GLdouble)
	declare sub glVertexAttrib2dvARB(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttrib2fARB(byval index as GLuint, byval x as GLfloat, byval y as GLfloat)
	declare sub glVertexAttrib2fvARB(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glVertexAttrib2sARB(byval index as GLuint, byval x as GLshort, byval y as GLshort)
	declare sub glVertexAttrib2svARB(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib3dARB(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glVertexAttrib3dvARB(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttrib3fARB(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glVertexAttrib3fvARB(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glVertexAttrib3sARB(byval index as GLuint, byval x as GLshort, byval y as GLshort, byval z as GLshort)
	declare sub glVertexAttrib3svARB(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib4NbvARB(byval index as GLuint, byval v as const GLbyte ptr)
	declare sub glVertexAttrib4NivARB(byval index as GLuint, byval v as const GLint ptr)
	declare sub glVertexAttrib4NsvARB(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib4NubARB(byval index as GLuint, byval x as GLubyte, byval y as GLubyte, byval z as GLubyte, byval w as GLubyte)
	declare sub glVertexAttrib4NubvARB(byval index as GLuint, byval v as const GLubyte ptr)
	declare sub glVertexAttrib4NuivARB(byval index as GLuint, byval v as const GLuint ptr)
	declare sub glVertexAttrib4NusvARB(byval index as GLuint, byval v as const GLushort ptr)
	declare sub glVertexAttrib4bvARB(byval index as GLuint, byval v as const GLbyte ptr)
	declare sub glVertexAttrib4dARB(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glVertexAttrib4dvARB(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttrib4fARB(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
	declare sub glVertexAttrib4fvARB(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glVertexAttrib4ivARB(byval index as GLuint, byval v as const GLint ptr)
	declare sub glVertexAttrib4sARB(byval index as GLuint, byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
	declare sub glVertexAttrib4svARB(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib4ubvARB(byval index as GLuint, byval v as const GLubyte ptr)
	declare sub glVertexAttrib4uivARB(byval index as GLuint, byval v as const GLuint ptr)
	declare sub glVertexAttrib4usvARB(byval index as GLuint, byval v as const GLushort ptr)
	declare sub glVertexAttribPointerARB(byval index as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval stride as GLsizei, byval pointer as const any ptr)
	declare sub glEnableVertexAttribArrayARB(byval index as GLuint)
	declare sub glDisableVertexAttribArrayARB(byval index as GLuint)
	declare sub glGetVertexAttribdvARB(byval index as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
	declare sub glGetVertexAttribfvARB(byval index as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetVertexAttribivARB(byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetVertexAttribPointervARB(byval index as GLuint, byval pname as GLenum, byval pointer as any ptr ptr)
#endif

const GL_ARB_vertex_shader = 1
const GL_VERTEX_SHADER_ARB = &h8B31
const GL_MAX_VERTEX_UNIFORM_COMPONENTS_ARB = &h8B4A
const GL_MAX_VARYING_FLOATS_ARB = &h8B4B
const GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB = &h8B4C
const GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS_ARB = &h8B4D
const GL_OBJECT_ACTIVE_ATTRIBUTES_ARB = &h8B89
const GL_OBJECT_ACTIVE_ATTRIBUTE_MAX_LENGTH_ARB = &h8B8A

type PFNGLBINDATTRIBLOCATIONARBPROC as sub(byval programObj as GLhandleARB, byval index as GLuint, byval name as const GLcharARB ptr)
type PFNGLGETACTIVEATTRIBARBPROC as sub(byval programObj as GLhandleARB, byval index as GLuint, byval maxLength as GLsizei, byval length as GLsizei ptr, byval size as GLint ptr, byval type as GLenum ptr, byval name as GLcharARB ptr)
type PFNGLGETATTRIBLOCATIONARBPROC as function(byval programObj as GLhandleARB, byval name as const GLcharARB ptr) as GLint

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBindAttribLocationARB(byval programObj as GLhandleARB, byval index as GLuint, byval name as const GLcharARB ptr)
	declare sub glGetActiveAttribARB(byval programObj as GLhandleARB, byval index as GLuint, byval maxLength as GLsizei, byval length as GLsizei ptr, byval size as GLint ptr, byval type as GLenum ptr, byval name as GLcharARB ptr)
	declare function glGetAttribLocationARB(byval programObj as GLhandleARB, byval name as const GLcharARB ptr) as GLint
#endif

const GL_ARB_vertex_type_10f_11f_11f_rev = 1
const GL_ARB_vertex_type_2_10_10_10_rev = 1
const GL_ARB_viewport_array = 1
const GL_ARB_window_pos = 1

type PFNGLWINDOWPOS2DARBPROC as sub(byval x as GLdouble, byval y as GLdouble)
type PFNGLWINDOWPOS2DVARBPROC as sub(byval v as const GLdouble ptr)
type PFNGLWINDOWPOS2FARBPROC as sub(byval x as GLfloat, byval y as GLfloat)
type PFNGLWINDOWPOS2FVARBPROC as sub(byval v as const GLfloat ptr)
type PFNGLWINDOWPOS2IARBPROC as sub(byval x as GLint, byval y as GLint)
type PFNGLWINDOWPOS2IVARBPROC as sub(byval v as const GLint ptr)
type PFNGLWINDOWPOS2SARBPROC as sub(byval x as GLshort, byval y as GLshort)
type PFNGLWINDOWPOS2SVARBPROC as sub(byval v as const GLshort ptr)
type PFNGLWINDOWPOS3DARBPROC as sub(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLWINDOWPOS3DVARBPROC as sub(byval v as const GLdouble ptr)
type PFNGLWINDOWPOS3FARBPROC as sub(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLWINDOWPOS3FVARBPROC as sub(byval v as const GLfloat ptr)
type PFNGLWINDOWPOS3IARBPROC as sub(byval x as GLint, byval y as GLint, byval z as GLint)
type PFNGLWINDOWPOS3IVARBPROC as sub(byval v as const GLint ptr)
type PFNGLWINDOWPOS3SARBPROC as sub(byval x as GLshort, byval y as GLshort, byval z as GLshort)
type PFNGLWINDOWPOS3SVARBPROC as sub(byval v as const GLshort ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glWindowPos2dARB(byval x as GLdouble, byval y as GLdouble)
	declare sub glWindowPos2dvARB(byval v as const GLdouble ptr)
	declare sub glWindowPos2fARB(byval x as GLfloat, byval y as GLfloat)
	declare sub glWindowPos2fvARB(byval v as const GLfloat ptr)
	declare sub glWindowPos2iARB(byval x as GLint, byval y as GLint)
	declare sub glWindowPos2ivARB(byval v as const GLint ptr)
	declare sub glWindowPos2sARB(byval x as GLshort, byval y as GLshort)
	declare sub glWindowPos2svARB(byval v as const GLshort ptr)
	declare sub glWindowPos3dARB(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glWindowPos3dvARB(byval v as const GLdouble ptr)
	declare sub glWindowPos3fARB(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glWindowPos3fvARB(byval v as const GLfloat ptr)
	declare sub glWindowPos3iARB(byval x as GLint, byval y as GLint, byval z as GLint)
	declare sub glWindowPos3ivARB(byval v as const GLint ptr)
	declare sub glWindowPos3sARB(byval x as GLshort, byval y as GLshort, byval z as GLshort)
	declare sub glWindowPos3svARB(byval v as const GLshort ptr)
#endif

const GL_KHR_blend_equation_advanced = 1
const GL_MULTIPLY_KHR = &h9294
const GL_SCREEN_KHR = &h9295
const GL_OVERLAY_KHR = &h9296
const GL_DARKEN_KHR = &h9297
const GL_LIGHTEN_KHR = &h9298
const GL_COLORDODGE_KHR = &h9299
const GL_COLORBURN_KHR = &h929A
const GL_HARDLIGHT_KHR = &h929B
const GL_SOFTLIGHT_KHR = &h929C
const GL_DIFFERENCE_KHR = &h929E
const GL_EXCLUSION_KHR = &h92A0
const GL_HSL_HUE_KHR = &h92AD
const GL_HSL_SATURATION_KHR = &h92AE
const GL_HSL_COLOR_KHR = &h92AF
const GL_HSL_LUMINOSITY_KHR = &h92B0
type PFNGLBLENDBARRIERKHRPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBlendBarrierKHR()
#endif

const GL_KHR_blend_equation_advanced_coherent = 1
const GL_BLEND_ADVANCED_COHERENT_KHR = &h9285
const GL_KHR_context_flush_control = 1
const GL_KHR_debug = 1
const GL_KHR_robust_buffer_access_behavior = 1
const GL_KHR_robustness = 1
const GL_CONTEXT_ROBUST_ACCESS = &h90F3
const GL_KHR_texture_compression_astc_hdr = 1
const GL_COMPRESSED_RGBA_ASTC_4x4_KHR = &h93B0
const GL_COMPRESSED_RGBA_ASTC_5x4_KHR = &h93B1
const GL_COMPRESSED_RGBA_ASTC_5x5_KHR = &h93B2
const GL_COMPRESSED_RGBA_ASTC_6x5_KHR = &h93B3
const GL_COMPRESSED_RGBA_ASTC_6x6_KHR = &h93B4
const GL_COMPRESSED_RGBA_ASTC_8x5_KHR = &h93B5
const GL_COMPRESSED_RGBA_ASTC_8x6_KHR = &h93B6
const GL_COMPRESSED_RGBA_ASTC_8x8_KHR = &h93B7
const GL_COMPRESSED_RGBA_ASTC_10x5_KHR = &h93B8
const GL_COMPRESSED_RGBA_ASTC_10x6_KHR = &h93B9
const GL_COMPRESSED_RGBA_ASTC_10x8_KHR = &h93BA
const GL_COMPRESSED_RGBA_ASTC_10x10_KHR = &h93BB
const GL_COMPRESSED_RGBA_ASTC_12x10_KHR = &h93BC
const GL_COMPRESSED_RGBA_ASTC_12x12_KHR = &h93BD
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR = &h93D0
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR = &h93D1
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR = &h93D2
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR = &h93D3
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR = &h93D4
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR = &h93D5
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR = &h93D6
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR = &h93D7
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR = &h93D8
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR = &h93D9
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR = &h93DA
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR = &h93DB
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR = &h93DC
const GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR = &h93DD
const GL_KHR_texture_compression_astc_ldr = 1
const GL_OES_byte_coordinates = 1

type PFNGLMULTITEXCOORD1BOESPROC as sub(byval texture as GLenum, byval s as GLbyte)
type PFNGLMULTITEXCOORD1BVOESPROC as sub(byval texture as GLenum, byval coords as const GLbyte ptr)
type PFNGLMULTITEXCOORD2BOESPROC as sub(byval texture as GLenum, byval s as GLbyte, byval t as GLbyte)
type PFNGLMULTITEXCOORD2BVOESPROC as sub(byval texture as GLenum, byval coords as const GLbyte ptr)
type PFNGLMULTITEXCOORD3BOESPROC as sub(byval texture as GLenum, byval s as GLbyte, byval t as GLbyte, byval r as GLbyte)
type PFNGLMULTITEXCOORD3BVOESPROC as sub(byval texture as GLenum, byval coords as const GLbyte ptr)
type PFNGLMULTITEXCOORD4BOESPROC as sub(byval texture as GLenum, byval s as GLbyte, byval t as GLbyte, byval r as GLbyte, byval q as GLbyte)
type PFNGLMULTITEXCOORD4BVOESPROC as sub(byval texture as GLenum, byval coords as const GLbyte ptr)
type PFNGLTEXCOORD1BOESPROC as sub(byval s as GLbyte)
type PFNGLTEXCOORD1BVOESPROC as sub(byval coords as const GLbyte ptr)
type PFNGLTEXCOORD2BOESPROC as sub(byval s as GLbyte, byval t as GLbyte)
type PFNGLTEXCOORD2BVOESPROC as sub(byval coords as const GLbyte ptr)
type PFNGLTEXCOORD3BOESPROC as sub(byval s as GLbyte, byval t as GLbyte, byval r as GLbyte)
type PFNGLTEXCOORD3BVOESPROC as sub(byval coords as const GLbyte ptr)
type PFNGLTEXCOORD4BOESPROC as sub(byval s as GLbyte, byval t as GLbyte, byval r as GLbyte, byval q as GLbyte)
type PFNGLTEXCOORD4BVOESPROC as sub(byval coords as const GLbyte ptr)
type PFNGLVERTEX2BOESPROC as sub(byval x as GLbyte, byval y as GLbyte)
type PFNGLVERTEX2BVOESPROC as sub(byval coords as const GLbyte ptr)
type PFNGLVERTEX3BOESPROC as sub(byval x as GLbyte, byval y as GLbyte, byval z as GLbyte)
type PFNGLVERTEX3BVOESPROC as sub(byval coords as const GLbyte ptr)
type PFNGLVERTEX4BOESPROC as sub(byval x as GLbyte, byval y as GLbyte, byval z as GLbyte, byval w as GLbyte)
type PFNGLVERTEX4BVOESPROC as sub(byval coords as const GLbyte ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glMultiTexCoord1bOES(byval texture as GLenum, byval s as GLbyte)
	declare sub glMultiTexCoord1bvOES(byval texture as GLenum, byval coords as const GLbyte ptr)
	declare sub glMultiTexCoord2bOES(byval texture as GLenum, byval s as GLbyte, byval t as GLbyte)
	declare sub glMultiTexCoord2bvOES(byval texture as GLenum, byval coords as const GLbyte ptr)
	declare sub glMultiTexCoord3bOES(byval texture as GLenum, byval s as GLbyte, byval t as GLbyte, byval r as GLbyte)
	declare sub glMultiTexCoord3bvOES(byval texture as GLenum, byval coords as const GLbyte ptr)
	declare sub glMultiTexCoord4bOES(byval texture as GLenum, byval s as GLbyte, byval t as GLbyte, byval r as GLbyte, byval q as GLbyte)
	declare sub glMultiTexCoord4bvOES(byval texture as GLenum, byval coords as const GLbyte ptr)
	declare sub glTexCoord1bOES(byval s as GLbyte)
	declare sub glTexCoord1bvOES(byval coords as const GLbyte ptr)
	declare sub glTexCoord2bOES(byval s as GLbyte, byval t as GLbyte)
	declare sub glTexCoord2bvOES(byval coords as const GLbyte ptr)
	declare sub glTexCoord3bOES(byval s as GLbyte, byval t as GLbyte, byval r as GLbyte)
	declare sub glTexCoord3bvOES(byval coords as const GLbyte ptr)
	declare sub glTexCoord4bOES(byval s as GLbyte, byval t as GLbyte, byval r as GLbyte, byval q as GLbyte)
	declare sub glTexCoord4bvOES(byval coords as const GLbyte ptr)
	declare sub glVertex2bOES(byval x as GLbyte, byval y as GLbyte)
	declare sub glVertex2bvOES(byval coords as const GLbyte ptr)
	declare sub glVertex3bOES(byval x as GLbyte, byval y as GLbyte, byval z as GLbyte)
	declare sub glVertex3bvOES(byval coords as const GLbyte ptr)
	declare sub glVertex4bOES(byval x as GLbyte, byval y as GLbyte, byval z as GLbyte, byval w as GLbyte)
	declare sub glVertex4bvOES(byval coords as const GLbyte ptr)
#endif

const GL_OES_compressed_paletted_texture = 1
const GL_PALETTE4_RGB8_OES = &h8B90
const GL_PALETTE4_RGBA8_OES = &h8B91
const GL_PALETTE4_R5_G6_B5_OES = &h8B92
const GL_PALETTE4_RGBA4_OES = &h8B93
const GL_PALETTE4_RGB5_A1_OES = &h8B94
const GL_PALETTE8_RGB8_OES = &h8B95
const GL_PALETTE8_RGBA8_OES = &h8B96
const GL_PALETTE8_R5_G6_B5_OES = &h8B97
const GL_PALETTE8_RGBA4_OES = &h8B98
const GL_PALETTE8_RGB5_A1_OES = &h8B99
const GL_OES_fixed_point = 1
type GLfixed as GLint
const GL_FIXED_OES = &h140C

type PFNGLALPHAFUNCXOESPROC as sub(byval func as GLenum, byval ref as GLfixed)
type PFNGLCLEARCOLORXOESPROC as sub(byval red as GLfixed, byval green as GLfixed, byval blue as GLfixed, byval alpha as GLfixed)
type PFNGLCLEARDEPTHXOESPROC as sub(byval depth as GLfixed)
type PFNGLCLIPPLANEXOESPROC as sub(byval plane as GLenum, byval equation as const GLfixed ptr)
type PFNGLCOLOR4XOESPROC as sub(byval red as GLfixed, byval green as GLfixed, byval blue as GLfixed, byval alpha as GLfixed)
type PFNGLDEPTHRANGEXOESPROC as sub(byval n as GLfixed, byval f as GLfixed)
type PFNGLFOGXOESPROC as sub(byval pname as GLenum, byval param as GLfixed)
type PFNGLFOGXVOESPROC as sub(byval pname as GLenum, byval param as const GLfixed ptr)
type PFNGLFRUSTUMXOESPROC as sub(byval l as GLfixed, byval r as GLfixed, byval b as GLfixed, byval t as GLfixed, byval n as GLfixed, byval f as GLfixed)
type PFNGLGETCLIPPLANEXOESPROC as sub(byval plane as GLenum, byval equation as GLfixed ptr)
type PFNGLGETFIXEDVOESPROC as sub(byval pname as GLenum, byval params as GLfixed ptr)
type PFNGLGETTEXENVXVOESPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfixed ptr)
type PFNGLGETTEXPARAMETERXVOESPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfixed ptr)
type PFNGLLIGHTMODELXOESPROC as sub(byval pname as GLenum, byval param as GLfixed)
type PFNGLLIGHTMODELXVOESPROC as sub(byval pname as GLenum, byval param as const GLfixed ptr)
type PFNGLLIGHTXOESPROC as sub(byval light as GLenum, byval pname as GLenum, byval param as GLfixed)
type PFNGLLIGHTXVOESPROC as sub(byval light as GLenum, byval pname as GLenum, byval params as const GLfixed ptr)
type PFNGLLINEWIDTHXOESPROC as sub(byval width as GLfixed)
type PFNGLLOADMATRIXXOESPROC as sub(byval m as const GLfixed ptr)
type PFNGLMATERIALXOESPROC as sub(byval face as GLenum, byval pname as GLenum, byval param as GLfixed)
type PFNGLMATERIALXVOESPROC as sub(byval face as GLenum, byval pname as GLenum, byval param as const GLfixed ptr)
type PFNGLMULTMATRIXXOESPROC as sub(byval m as const GLfixed ptr)
type PFNGLMULTITEXCOORD4XOESPROC as sub(byval texture as GLenum, byval s as GLfixed, byval t as GLfixed, byval r as GLfixed, byval q as GLfixed)
type PFNGLNORMAL3XOESPROC as sub(byval nx as GLfixed, byval ny as GLfixed, byval nz as GLfixed)
type PFNGLORTHOXOESPROC as sub(byval l as GLfixed, byval r as GLfixed, byval b as GLfixed, byval t as GLfixed, byval n as GLfixed, byval f as GLfixed)
type PFNGLPOINTPARAMETERXVOESPROC as sub(byval pname as GLenum, byval params as const GLfixed ptr)
type PFNGLPOINTSIZEXOESPROC as sub(byval size as GLfixed)
type PFNGLPOLYGONOFFSETXOESPROC as sub(byval factor as GLfixed, byval units as GLfixed)
type PFNGLROTATEXOESPROC as sub(byval angle as GLfixed, byval x as GLfixed, byval y as GLfixed, byval z as GLfixed)
type PFNGLSAMPLECOVERAGEOESPROC as sub(byval value as GLfixed, byval invert as GLboolean)
type PFNGLSCALEXOESPROC as sub(byval x as GLfixed, byval y as GLfixed, byval z as GLfixed)
type PFNGLTEXENVXOESPROC as sub(byval target as GLenum, byval pname as GLenum, byval param as GLfixed)
type PFNGLTEXENVXVOESPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLfixed ptr)
type PFNGLTEXPARAMETERXOESPROC as sub(byval target as GLenum, byval pname as GLenum, byval param as GLfixed)
type PFNGLTEXPARAMETERXVOESPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLfixed ptr)
type PFNGLTRANSLATEXOESPROC as sub(byval x as GLfixed, byval y as GLfixed, byval z as GLfixed)
type PFNGLACCUMXOESPROC as sub(byval op as GLenum, byval value as GLfixed)
type PFNGLBITMAPXOESPROC as sub(byval width as GLsizei, byval height as GLsizei, byval xorig as GLfixed, byval yorig as GLfixed, byval xmove as GLfixed, byval ymove as GLfixed, byval bitmap as const GLubyte ptr)
type PFNGLBLENDCOLORXOESPROC as sub(byval red as GLfixed, byval green as GLfixed, byval blue as GLfixed, byval alpha as GLfixed)
type PFNGLCLEARACCUMXOESPROC as sub(byval red as GLfixed, byval green as GLfixed, byval blue as GLfixed, byval alpha as GLfixed)
type PFNGLCOLOR3XOESPROC as sub(byval red as GLfixed, byval green as GLfixed, byval blue as GLfixed)
type PFNGLCOLOR3XVOESPROC as sub(byval components as const GLfixed ptr)
type PFNGLCOLOR4XVOESPROC as sub(byval components as const GLfixed ptr)
type PFNGLCONVOLUTIONPARAMETERXOESPROC as sub(byval target as GLenum, byval pname as GLenum, byval param as GLfixed)
type PFNGLCONVOLUTIONPARAMETERXVOESPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLfixed ptr)
type PFNGLEVALCOORD1XOESPROC as sub(byval u as GLfixed)
type PFNGLEVALCOORD1XVOESPROC as sub(byval coords as const GLfixed ptr)
type PFNGLEVALCOORD2XOESPROC as sub(byval u as GLfixed, byval v as GLfixed)
type PFNGLEVALCOORD2XVOESPROC as sub(byval coords as const GLfixed ptr)
type PFNGLFEEDBACKBUFFERXOESPROC as sub(byval n as GLsizei, byval type as GLenum, byval buffer as const GLfixed ptr)
type PFNGLGETCONVOLUTIONPARAMETERXVOESPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfixed ptr)
type PFNGLGETHISTOGRAMPARAMETERXVOESPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfixed ptr)
type PFNGLGETLIGHTXOESPROC as sub(byval light as GLenum, byval pname as GLenum, byval params as GLfixed ptr)
type PFNGLGETMAPXVOESPROC as sub(byval target as GLenum, byval query as GLenum, byval v as GLfixed ptr)
type PFNGLGETMATERIALXOESPROC as sub(byval face as GLenum, byval pname as GLenum, byval param as GLfixed)
type PFNGLGETPIXELMAPXVPROC as sub(byval map as GLenum, byval size as GLint, byval values as GLfixed ptr)
type PFNGLGETTEXGENXVOESPROC as sub(byval coord as GLenum, byval pname as GLenum, byval params as GLfixed ptr)
type PFNGLGETTEXLEVELPARAMETERXVOESPROC as sub(byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLfixed ptr)
type PFNGLINDEXXOESPROC as sub(byval component as GLfixed)
type PFNGLINDEXXVOESPROC as sub(byval component as const GLfixed ptr)
type PFNGLLOADTRANSPOSEMATRIXXOESPROC as sub(byval m as const GLfixed ptr)
type PFNGLMAP1XOESPROC as sub(byval target as GLenum, byval u1 as GLfixed, byval u2 as GLfixed, byval stride as GLint, byval order as GLint, byval points as GLfixed)
type PFNGLMAP2XOESPROC as sub(byval target as GLenum, byval u1 as GLfixed, byval u2 as GLfixed, byval ustride as GLint, byval uorder as GLint, byval v1 as GLfixed, byval v2 as GLfixed, byval vstride as GLint, byval vorder as GLint, byval points as GLfixed)
type PFNGLMAPGRID1XOESPROC as sub(byval n as GLint, byval u1 as GLfixed, byval u2 as GLfixed)
type PFNGLMAPGRID2XOESPROC as sub(byval n as GLint, byval u1 as GLfixed, byval u2 as GLfixed, byval v1 as GLfixed, byval v2 as GLfixed)
type PFNGLMULTTRANSPOSEMATRIXXOESPROC as sub(byval m as const GLfixed ptr)
type PFNGLMULTITEXCOORD1XOESPROC as sub(byval texture as GLenum, byval s as GLfixed)
type PFNGLMULTITEXCOORD1XVOESPROC as sub(byval texture as GLenum, byval coords as const GLfixed ptr)
type PFNGLMULTITEXCOORD2XOESPROC as sub(byval texture as GLenum, byval s as GLfixed, byval t as GLfixed)
type PFNGLMULTITEXCOORD2XVOESPROC as sub(byval texture as GLenum, byval coords as const GLfixed ptr)
type PFNGLMULTITEXCOORD3XOESPROC as sub(byval texture as GLenum, byval s as GLfixed, byval t as GLfixed, byval r as GLfixed)
type PFNGLMULTITEXCOORD3XVOESPROC as sub(byval texture as GLenum, byval coords as const GLfixed ptr)
type PFNGLMULTITEXCOORD4XVOESPROC as sub(byval texture as GLenum, byval coords as const GLfixed ptr)
type PFNGLNORMAL3XVOESPROC as sub(byval coords as const GLfixed ptr)
type PFNGLPASSTHROUGHXOESPROC as sub(byval token as GLfixed)
type PFNGLPIXELMAPXPROC as sub(byval map as GLenum, byval size as GLint, byval values as const GLfixed ptr)
type PFNGLPIXELSTOREXPROC as sub(byval pname as GLenum, byval param as GLfixed)
type PFNGLPIXELTRANSFERXOESPROC as sub(byval pname as GLenum, byval param as GLfixed)
type PFNGLPIXELZOOMXOESPROC as sub(byval xfactor as GLfixed, byval yfactor as GLfixed)
type PFNGLPRIORITIZETEXTURESXOESPROC as sub(byval n as GLsizei, byval textures as const GLuint ptr, byval priorities as const GLfixed ptr)
type PFNGLRASTERPOS2XOESPROC as sub(byval x as GLfixed, byval y as GLfixed)
type PFNGLRASTERPOS2XVOESPROC as sub(byval coords as const GLfixed ptr)
type PFNGLRASTERPOS3XOESPROC as sub(byval x as GLfixed, byval y as GLfixed, byval z as GLfixed)
type PFNGLRASTERPOS3XVOESPROC as sub(byval coords as const GLfixed ptr)
type PFNGLRASTERPOS4XOESPROC as sub(byval x as GLfixed, byval y as GLfixed, byval z as GLfixed, byval w as GLfixed)
type PFNGLRASTERPOS4XVOESPROC as sub(byval coords as const GLfixed ptr)
type PFNGLRECTXOESPROC as sub(byval x1 as GLfixed, byval y1 as GLfixed, byval x2 as GLfixed, byval y2 as GLfixed)
type PFNGLRECTXVOESPROC as sub(byval v1 as const GLfixed ptr, byval v2 as const GLfixed ptr)
type PFNGLTEXCOORD1XOESPROC as sub(byval s as GLfixed)
type PFNGLTEXCOORD1XVOESPROC as sub(byval coords as const GLfixed ptr)
type PFNGLTEXCOORD2XOESPROC as sub(byval s as GLfixed, byval t as GLfixed)
type PFNGLTEXCOORD2XVOESPROC as sub(byval coords as const GLfixed ptr)
type PFNGLTEXCOORD3XOESPROC as sub(byval s as GLfixed, byval t as GLfixed, byval r as GLfixed)
type PFNGLTEXCOORD3XVOESPROC as sub(byval coords as const GLfixed ptr)
type PFNGLTEXCOORD4XOESPROC as sub(byval s as GLfixed, byval t as GLfixed, byval r as GLfixed, byval q as GLfixed)
type PFNGLTEXCOORD4XVOESPROC as sub(byval coords as const GLfixed ptr)
type PFNGLTEXGENXOESPROC as sub(byval coord as GLenum, byval pname as GLenum, byval param as GLfixed)
type PFNGLTEXGENXVOESPROC as sub(byval coord as GLenum, byval pname as GLenum, byval params as const GLfixed ptr)
type PFNGLVERTEX2XOESPROC as sub(byval x as GLfixed)
type PFNGLVERTEX2XVOESPROC as sub(byval coords as const GLfixed ptr)
type PFNGLVERTEX3XOESPROC as sub(byval x as GLfixed, byval y as GLfixed)
type PFNGLVERTEX3XVOESPROC as sub(byval coords as const GLfixed ptr)
type PFNGLVERTEX4XOESPROC as sub(byval x as GLfixed, byval y as GLfixed, byval z as GLfixed)
type PFNGLVERTEX4XVOESPROC as sub(byval coords as const GLfixed ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glAlphaFuncxOES(byval func as GLenum, byval ref as GLfixed)
	declare sub glClearColorxOES(byval red as GLfixed, byval green as GLfixed, byval blue as GLfixed, byval alpha as GLfixed)
	declare sub glClearDepthxOES(byval depth as GLfixed)
	declare sub glClipPlanexOES(byval plane as GLenum, byval equation as const GLfixed ptr)
	declare sub glColor4xOES(byval red as GLfixed, byval green as GLfixed, byval blue as GLfixed, byval alpha as GLfixed)
	declare sub glDepthRangexOES(byval n as GLfixed, byval f as GLfixed)
	declare sub glFogxOES(byval pname as GLenum, byval param as GLfixed)
	declare sub glFogxvOES(byval pname as GLenum, byval param as const GLfixed ptr)
	declare sub glFrustumxOES(byval l as GLfixed, byval r as GLfixed, byval b as GLfixed, byval t as GLfixed, byval n as GLfixed, byval f as GLfixed)
	declare sub glGetClipPlanexOES(byval plane as GLenum, byval equation as GLfixed ptr)
	declare sub glGetFixedvOES(byval pname as GLenum, byval params as GLfixed ptr)
	declare sub glGetTexEnvxvOES(byval target as GLenum, byval pname as GLenum, byval params as GLfixed ptr)
	declare sub glGetTexParameterxvOES(byval target as GLenum, byval pname as GLenum, byval params as GLfixed ptr)
	declare sub glLightModelxOES(byval pname as GLenum, byval param as GLfixed)
	declare sub glLightModelxvOES(byval pname as GLenum, byval param as const GLfixed ptr)
	declare sub glLightxOES(byval light as GLenum, byval pname as GLenum, byval param as GLfixed)
	declare sub glLightxvOES(byval light as GLenum, byval pname as GLenum, byval params as const GLfixed ptr)
	declare sub glLineWidthxOES(byval width as GLfixed)
	declare sub glLoadMatrixxOES(byval m as const GLfixed ptr)
	declare sub glMaterialxOES(byval face as GLenum, byval pname as GLenum, byval param as GLfixed)
	declare sub glMaterialxvOES(byval face as GLenum, byval pname as GLenum, byval param as const GLfixed ptr)
	declare sub glMultMatrixxOES(byval m as const GLfixed ptr)
	declare sub glMultiTexCoord4xOES(byval texture as GLenum, byval s as GLfixed, byval t as GLfixed, byval r as GLfixed, byval q as GLfixed)
	declare sub glNormal3xOES(byval nx as GLfixed, byval ny as GLfixed, byval nz as GLfixed)
	declare sub glOrthoxOES(byval l as GLfixed, byval r as GLfixed, byval b as GLfixed, byval t as GLfixed, byval n as GLfixed, byval f as GLfixed)
	declare sub glPointParameterxvOES(byval pname as GLenum, byval params as const GLfixed ptr)
	declare sub glPointSizexOES(byval size as GLfixed)
	declare sub glPolygonOffsetxOES(byval factor as GLfixed, byval units as GLfixed)
	declare sub glRotatexOES(byval angle as GLfixed, byval x as GLfixed, byval y as GLfixed, byval z as GLfixed)
	declare sub glSampleCoverageOES(byval value as GLfixed, byval invert as GLboolean)
	declare sub glScalexOES(byval x as GLfixed, byval y as GLfixed, byval z as GLfixed)
	declare sub glTexEnvxOES(byval target as GLenum, byval pname as GLenum, byval param as GLfixed)
	declare sub glTexEnvxvOES(byval target as GLenum, byval pname as GLenum, byval params as const GLfixed ptr)
	declare sub glTexParameterxOES(byval target as GLenum, byval pname as GLenum, byval param as GLfixed)
	declare sub glTexParameterxvOES(byval target as GLenum, byval pname as GLenum, byval params as const GLfixed ptr)
	declare sub glTranslatexOES(byval x as GLfixed, byval y as GLfixed, byval z as GLfixed)
	declare sub glAccumxOES(byval op as GLenum, byval value as GLfixed)
	declare sub glBitmapxOES(byval width as GLsizei, byval height as GLsizei, byval xorig as GLfixed, byval yorig as GLfixed, byval xmove as GLfixed, byval ymove as GLfixed, byval bitmap as const GLubyte ptr)
	declare sub glBlendColorxOES(byval red as GLfixed, byval green as GLfixed, byval blue as GLfixed, byval alpha as GLfixed)
	declare sub glClearAccumxOES(byval red as GLfixed, byval green as GLfixed, byval blue as GLfixed, byval alpha as GLfixed)
	declare sub glColor3xOES(byval red as GLfixed, byval green as GLfixed, byval blue as GLfixed)
	declare sub glColor3xvOES(byval components as const GLfixed ptr)
	declare sub glColor4xvOES(byval components as const GLfixed ptr)
	declare sub glConvolutionParameterxOES(byval target as GLenum, byval pname as GLenum, byval param as GLfixed)
	declare sub glConvolutionParameterxvOES(byval target as GLenum, byval pname as GLenum, byval params as const GLfixed ptr)
	declare sub glEvalCoord1xOES(byval u as GLfixed)
	declare sub glEvalCoord1xvOES(byval coords as const GLfixed ptr)
	declare sub glEvalCoord2xOES(byval u as GLfixed, byval v as GLfixed)
	declare sub glEvalCoord2xvOES(byval coords as const GLfixed ptr)
	declare sub glFeedbackBufferxOES(byval n as GLsizei, byval type as GLenum, byval buffer as const GLfixed ptr)
	declare sub glGetConvolutionParameterxvOES(byval target as GLenum, byval pname as GLenum, byval params as GLfixed ptr)
	declare sub glGetHistogramParameterxvOES(byval target as GLenum, byval pname as GLenum, byval params as GLfixed ptr)
	declare sub glGetLightxOES(byval light as GLenum, byval pname as GLenum, byval params as GLfixed ptr)
	declare sub glGetMapxvOES(byval target as GLenum, byval query as GLenum, byval v as GLfixed ptr)
	declare sub glGetMaterialxOES(byval face as GLenum, byval pname as GLenum, byval param as GLfixed)
	declare sub glGetPixelMapxv(byval map as GLenum, byval size as GLint, byval values as GLfixed ptr)
	declare sub glGetTexGenxvOES(byval coord as GLenum, byval pname as GLenum, byval params as GLfixed ptr)
	declare sub glGetTexLevelParameterxvOES(byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLfixed ptr)
	declare sub glIndexxOES(byval component as GLfixed)
	declare sub glIndexxvOES(byval component as const GLfixed ptr)
	declare sub glLoadTransposeMatrixxOES(byval m as const GLfixed ptr)
	declare sub glMap1xOES(byval target as GLenum, byval u1 as GLfixed, byval u2 as GLfixed, byval stride as GLint, byval order as GLint, byval points as GLfixed)
	declare sub glMap2xOES(byval target as GLenum, byval u1 as GLfixed, byval u2 as GLfixed, byval ustride as GLint, byval uorder as GLint, byval v1 as GLfixed, byval v2 as GLfixed, byval vstride as GLint, byval vorder as GLint, byval points as GLfixed)
	declare sub glMapGrid1xOES(byval n as GLint, byval u1 as GLfixed, byval u2 as GLfixed)
	declare sub glMapGrid2xOES(byval n as GLint, byval u1 as GLfixed, byval u2 as GLfixed, byval v1 as GLfixed, byval v2 as GLfixed)
	declare sub glMultTransposeMatrixxOES(byval m as const GLfixed ptr)
	declare sub glMultiTexCoord1xOES(byval texture as GLenum, byval s as GLfixed)
	declare sub glMultiTexCoord1xvOES(byval texture as GLenum, byval coords as const GLfixed ptr)
	declare sub glMultiTexCoord2xOES(byval texture as GLenum, byval s as GLfixed, byval t as GLfixed)
	declare sub glMultiTexCoord2xvOES(byval texture as GLenum, byval coords as const GLfixed ptr)
	declare sub glMultiTexCoord3xOES(byval texture as GLenum, byval s as GLfixed, byval t as GLfixed, byval r as GLfixed)
	declare sub glMultiTexCoord3xvOES(byval texture as GLenum, byval coords as const GLfixed ptr)
	declare sub glMultiTexCoord4xvOES(byval texture as GLenum, byval coords as const GLfixed ptr)
	declare sub glNormal3xvOES(byval coords as const GLfixed ptr)
	declare sub glPassThroughxOES(byval token as GLfixed)
	declare sub glPixelMapx(byval map as GLenum, byval size as GLint, byval values as const GLfixed ptr)
	declare sub glPixelStorex(byval pname as GLenum, byval param as GLfixed)
	declare sub glPixelTransferxOES(byval pname as GLenum, byval param as GLfixed)
	declare sub glPixelZoomxOES(byval xfactor as GLfixed, byval yfactor as GLfixed)
	declare sub glPrioritizeTexturesxOES(byval n as GLsizei, byval textures as const GLuint ptr, byval priorities as const GLfixed ptr)
	declare sub glRasterPos2xOES(byval x as GLfixed, byval y as GLfixed)
	declare sub glRasterPos2xvOES(byval coords as const GLfixed ptr)
	declare sub glRasterPos3xOES(byval x as GLfixed, byval y as GLfixed, byval z as GLfixed)
	declare sub glRasterPos3xvOES(byval coords as const GLfixed ptr)
	declare sub glRasterPos4xOES(byval x as GLfixed, byval y as GLfixed, byval z as GLfixed, byval w as GLfixed)
	declare sub glRasterPos4xvOES(byval coords as const GLfixed ptr)
	declare sub glRectxOES(byval x1 as GLfixed, byval y1 as GLfixed, byval x2 as GLfixed, byval y2 as GLfixed)
	declare sub glRectxvOES(byval v1 as const GLfixed ptr, byval v2 as const GLfixed ptr)
	declare sub glTexCoord1xOES(byval s as GLfixed)
	declare sub glTexCoord1xvOES(byval coords as const GLfixed ptr)
	declare sub glTexCoord2xOES(byval s as GLfixed, byval t as GLfixed)
	declare sub glTexCoord2xvOES(byval coords as const GLfixed ptr)
	declare sub glTexCoord3xOES(byval s as GLfixed, byval t as GLfixed, byval r as GLfixed)
	declare sub glTexCoord3xvOES(byval coords as const GLfixed ptr)
	declare sub glTexCoord4xOES(byval s as GLfixed, byval t as GLfixed, byval r as GLfixed, byval q as GLfixed)
	declare sub glTexCoord4xvOES(byval coords as const GLfixed ptr)
	declare sub glTexGenxOES(byval coord as GLenum, byval pname as GLenum, byval param as GLfixed)
	declare sub glTexGenxvOES(byval coord as GLenum, byval pname as GLenum, byval params as const GLfixed ptr)
	declare sub glVertex2xOES(byval x as GLfixed)
	declare sub glVertex2xvOES(byval coords as const GLfixed ptr)
	declare sub glVertex3xOES(byval x as GLfixed, byval y as GLfixed)
	declare sub glVertex3xvOES(byval coords as const GLfixed ptr)
	declare sub glVertex4xOES(byval x as GLfixed, byval y as GLfixed, byval z as GLfixed)
	declare sub glVertex4xvOES(byval coords as const GLfixed ptr)
#endif

const GL_OES_query_matrix = 1
type PFNGLQUERYMATRIXXOESPROC as function(byval mantissa as GLfixed ptr, byval exponent as GLint ptr) as GLbitfield

#ifdef GL_GLEXT_PROTOTYPES
	declare function glQueryMatrixxOES(byval mantissa as GLfixed ptr, byval exponent as GLint ptr) as GLbitfield
#endif

const GL_OES_read_format = 1
const GL_IMPLEMENTATION_COLOR_READ_TYPE_OES = &h8B9A
const GL_IMPLEMENTATION_COLOR_READ_FORMAT_OES = &h8B9B
const GL_OES_single_precision = 1

type PFNGLCLEARDEPTHFOESPROC as sub(byval depth as GLclampf)
type PFNGLCLIPPLANEFOESPROC as sub(byval plane as GLenum, byval equation as const GLfloat ptr)
type PFNGLDEPTHRANGEFOESPROC as sub(byval n as GLclampf, byval f as GLclampf)
type PFNGLFRUSTUMFOESPROC as sub(byval l as GLfloat, byval r as GLfloat, byval b as GLfloat, byval t as GLfloat, byval n as GLfloat, byval f as GLfloat)
type PFNGLGETCLIPPLANEFOESPROC as sub(byval plane as GLenum, byval equation as GLfloat ptr)
type PFNGLORTHOFOESPROC as sub(byval l as GLfloat, byval r as GLfloat, byval b as GLfloat, byval t as GLfloat, byval n as GLfloat, byval f as GLfloat)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glClearDepthfOES(byval depth as GLclampf)
	declare sub glClipPlanefOES(byval plane as GLenum, byval equation as const GLfloat ptr)
	declare sub glDepthRangefOES(byval n as GLclampf, byval f as GLclampf)
	declare sub glFrustumfOES(byval l as GLfloat, byval r as GLfloat, byval b as GLfloat, byval t as GLfloat, byval n as GLfloat, byval f as GLfloat)
	declare sub glGetClipPlanefOES(byval plane as GLenum, byval equation as GLfloat ptr)
	declare sub glOrthofOES(byval l as GLfloat, byval r as GLfloat, byval b as GLfloat, byval t as GLfloat, byval n as GLfloat, byval f as GLfloat)
#endif

const GL_3DFX_multisample = 1
const GL_MULTISAMPLE_3DFX = &h86B2
const GL_SAMPLE_BUFFERS_3DFX = &h86B3
const GL_SAMPLES_3DFX = &h86B4
const GL_MULTISAMPLE_BIT_3DFX = &h20000000
const GL_3DFX_tbuffer = 1
type PFNGLTBUFFERMASK3DFXPROC as sub(byval mask as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTbufferMask3DFX(byval mask as GLuint)
#endif

const GL_3DFX_texture_compression_FXT1 = 1
const GL_COMPRESSED_RGB_FXT1_3DFX = &h86B0
const GL_COMPRESSED_RGBA_FXT1_3DFX = &h86B1
const GL_AMD_blend_minmax_factor = 1
const GL_FACTOR_MIN_AMD = &h901C
const GL_FACTOR_MAX_AMD = &h901D
const GL_AMD_conservative_depth = 1
const GL_AMD_debug_output = 1
type GLDEBUGPROCAMD as sub(byval id as GLuint, byval category as GLenum, byval severity as GLenum, byval length as GLsizei, byval message as const GLchar ptr, byval userParam as any ptr)
const GL_MAX_DEBUG_MESSAGE_LENGTH_AMD = &h9143
const GL_MAX_DEBUG_LOGGED_MESSAGES_AMD = &h9144
const GL_DEBUG_LOGGED_MESSAGES_AMD = &h9145
const GL_DEBUG_SEVERITY_HIGH_AMD = &h9146
const GL_DEBUG_SEVERITY_MEDIUM_AMD = &h9147
const GL_DEBUG_SEVERITY_LOW_AMD = &h9148
const GL_DEBUG_CATEGORY_API_ERROR_AMD = &h9149
const GL_DEBUG_CATEGORY_WINDOW_SYSTEM_AMD = &h914A
const GL_DEBUG_CATEGORY_DEPRECATION_AMD = &h914B
const GL_DEBUG_CATEGORY_UNDEFINED_BEHAVIOR_AMD = &h914C
const GL_DEBUG_CATEGORY_PERFORMANCE_AMD = &h914D
const GL_DEBUG_CATEGORY_SHADER_COMPILER_AMD = &h914E
const GL_DEBUG_CATEGORY_APPLICATION_AMD = &h914F
const GL_DEBUG_CATEGORY_OTHER_AMD = &h9150

type PFNGLDEBUGMESSAGEENABLEAMDPROC as sub(byval category as GLenum, byval severity as GLenum, byval count as GLsizei, byval ids as const GLuint ptr, byval enabled as GLboolean)
type PFNGLDEBUGMESSAGEINSERTAMDPROC as sub(byval category as GLenum, byval severity as GLenum, byval id as GLuint, byval length as GLsizei, byval buf as const GLchar ptr)
type PFNGLDEBUGMESSAGECALLBACKAMDPROC as sub(byval callback as GLDEBUGPROCAMD, byval userParam as any ptr)
type PFNGLGETDEBUGMESSAGELOGAMDPROC as function(byval count as GLuint, byval bufsize as GLsizei, byval categories as GLenum ptr, byval severities as GLuint ptr, byval ids as GLuint ptr, byval lengths as GLsizei ptr, byval message as GLchar ptr) as GLuint

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDebugMessageEnableAMD(byval category as GLenum, byval severity as GLenum, byval count as GLsizei, byval ids as const GLuint ptr, byval enabled as GLboolean)
	declare sub glDebugMessageInsertAMD(byval category as GLenum, byval severity as GLenum, byval id as GLuint, byval length as GLsizei, byval buf as const GLchar ptr)
	declare sub glDebugMessageCallbackAMD(byval callback as GLDEBUGPROCAMD, byval userParam as any ptr)
	declare function glGetDebugMessageLogAMD(byval count as GLuint, byval bufsize as GLsizei, byval categories as GLenum ptr, byval severities as GLuint ptr, byval ids as GLuint ptr, byval lengths as GLsizei ptr, byval message as GLchar ptr) as GLuint
#endif

const GL_AMD_depth_clamp_separate = 1
const GL_DEPTH_CLAMP_NEAR_AMD = &h901E
const GL_DEPTH_CLAMP_FAR_AMD = &h901F
const GL_AMD_draw_buffers_blend = 1

type PFNGLBLENDFUNCINDEXEDAMDPROC as sub(byval buf as GLuint, byval src as GLenum, byval dst as GLenum)
type PFNGLBLENDFUNCSEPARATEINDEXEDAMDPROC as sub(byval buf as GLuint, byval srcRGB as GLenum, byval dstRGB as GLenum, byval srcAlpha as GLenum, byval dstAlpha as GLenum)
type PFNGLBLENDEQUATIONINDEXEDAMDPROC as sub(byval buf as GLuint, byval mode as GLenum)
type PFNGLBLENDEQUATIONSEPARATEINDEXEDAMDPROC as sub(byval buf as GLuint, byval modeRGB as GLenum, byval modeAlpha as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBlendFuncIndexedAMD(byval buf as GLuint, byval src as GLenum, byval dst as GLenum)
	declare sub glBlendFuncSeparateIndexedAMD(byval buf as GLuint, byval srcRGB as GLenum, byval dstRGB as GLenum, byval srcAlpha as GLenum, byval dstAlpha as GLenum)
	declare sub glBlendEquationIndexedAMD(byval buf as GLuint, byval mode as GLenum)
	declare sub glBlendEquationSeparateIndexedAMD(byval buf as GLuint, byval modeRGB as GLenum, byval modeAlpha as GLenum)
#endif

const GL_AMD_gcn_shader = 1
const GL_AMD_gpu_shader_int64 = 1
type GLint64EXT as longint
const GL_INT64_NV = &h140E
const GL_UNSIGNED_INT64_NV = &h140F
const GL_INT8_NV = &h8FE0
const GL_INT8_VEC2_NV = &h8FE1
const GL_INT8_VEC3_NV = &h8FE2
const GL_INT8_VEC4_NV = &h8FE3
const GL_INT16_NV = &h8FE4
const GL_INT16_VEC2_NV = &h8FE5
const GL_INT16_VEC3_NV = &h8FE6
const GL_INT16_VEC4_NV = &h8FE7
const GL_INT64_VEC2_NV = &h8FE9
const GL_INT64_VEC3_NV = &h8FEA
const GL_INT64_VEC4_NV = &h8FEB
const GL_UNSIGNED_INT8_NV = &h8FEC
const GL_UNSIGNED_INT8_VEC2_NV = &h8FED
const GL_UNSIGNED_INT8_VEC3_NV = &h8FEE
const GL_UNSIGNED_INT8_VEC4_NV = &h8FEF
const GL_UNSIGNED_INT16_NV = &h8FF0
const GL_UNSIGNED_INT16_VEC2_NV = &h8FF1
const GL_UNSIGNED_INT16_VEC3_NV = &h8FF2
const GL_UNSIGNED_INT16_VEC4_NV = &h8FF3
const GL_UNSIGNED_INT64_VEC2_NV = &h8FF5
const GL_UNSIGNED_INT64_VEC3_NV = &h8FF6
const GL_UNSIGNED_INT64_VEC4_NV = &h8FF7
const GL_FLOAT16_NV = &h8FF8
const GL_FLOAT16_VEC2_NV = &h8FF9
const GL_FLOAT16_VEC3_NV = &h8FFA
const GL_FLOAT16_VEC4_NV = &h8FFB

type PFNGLUNIFORM1I64NVPROC as sub(byval location as GLint, byval x as GLint64EXT)
type PFNGLUNIFORM2I64NVPROC as sub(byval location as GLint, byval x as GLint64EXT, byval y as GLint64EXT)
type PFNGLUNIFORM3I64NVPROC as sub(byval location as GLint, byval x as GLint64EXT, byval y as GLint64EXT, byval z as GLint64EXT)
type PFNGLUNIFORM4I64NVPROC as sub(byval location as GLint, byval x as GLint64EXT, byval y as GLint64EXT, byval z as GLint64EXT, byval w as GLint64EXT)
type PFNGLUNIFORM1I64VNVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
type PFNGLUNIFORM2I64VNVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
type PFNGLUNIFORM3I64VNVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
type PFNGLUNIFORM4I64VNVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
type PFNGLUNIFORM1UI64NVPROC as sub(byval location as GLint, byval x as GLuint64EXT)
type PFNGLUNIFORM2UI64NVPROC as sub(byval location as GLint, byval x as GLuint64EXT, byval y as GLuint64EXT)
type PFNGLUNIFORM3UI64NVPROC as sub(byval location as GLint, byval x as GLuint64EXT, byval y as GLuint64EXT, byval z as GLuint64EXT)
type PFNGLUNIFORM4UI64NVPROC as sub(byval location as GLint, byval x as GLuint64EXT, byval y as GLuint64EXT, byval z as GLuint64EXT, byval w as GLuint64EXT)
type PFNGLUNIFORM1UI64VNVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
type PFNGLUNIFORM2UI64VNVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
type PFNGLUNIFORM3UI64VNVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
type PFNGLUNIFORM4UI64VNVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
type PFNGLGETUNIFORMI64VNVPROC as sub(byval program as GLuint, byval location as GLint, byval params as GLint64EXT ptr)
type PFNGLGETUNIFORMUI64VNVPROC as sub(byval program as GLuint, byval location as GLint, byval params as GLuint64EXT ptr)
type PFNGLPROGRAMUNIFORM1I64NVPROC as sub(byval program as GLuint, byval location as GLint, byval x as GLint64EXT)
type PFNGLPROGRAMUNIFORM2I64NVPROC as sub(byval program as GLuint, byval location as GLint, byval x as GLint64EXT, byval y as GLint64EXT)
type PFNGLPROGRAMUNIFORM3I64NVPROC as sub(byval program as GLuint, byval location as GLint, byval x as GLint64EXT, byval y as GLint64EXT, byval z as GLint64EXT)
type PFNGLPROGRAMUNIFORM4I64NVPROC as sub(byval program as GLuint, byval location as GLint, byval x as GLint64EXT, byval y as GLint64EXT, byval z as GLint64EXT, byval w as GLint64EXT)
type PFNGLPROGRAMUNIFORM1I64VNVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
type PFNGLPROGRAMUNIFORM2I64VNVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
type PFNGLPROGRAMUNIFORM3I64VNVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
type PFNGLPROGRAMUNIFORM4I64VNVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
type PFNGLPROGRAMUNIFORM1UI64NVPROC as sub(byval program as GLuint, byval location as GLint, byval x as GLuint64EXT)
type PFNGLPROGRAMUNIFORM2UI64NVPROC as sub(byval program as GLuint, byval location as GLint, byval x as GLuint64EXT, byval y as GLuint64EXT)
type PFNGLPROGRAMUNIFORM3UI64NVPROC as sub(byval program as GLuint, byval location as GLint, byval x as GLuint64EXT, byval y as GLuint64EXT, byval z as GLuint64EXT)
type PFNGLPROGRAMUNIFORM4UI64NVPROC as sub(byval program as GLuint, byval location as GLint, byval x as GLuint64EXT, byval y as GLuint64EXT, byval z as GLuint64EXT, byval w as GLuint64EXT)
type PFNGLPROGRAMUNIFORM1UI64VNVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
type PFNGLPROGRAMUNIFORM2UI64VNVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
type PFNGLPROGRAMUNIFORM3UI64VNVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
type PFNGLPROGRAMUNIFORM4UI64VNVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glUniform1i64NV(byval location as GLint, byval x as GLint64EXT)
	declare sub glUniform2i64NV(byval location as GLint, byval x as GLint64EXT, byval y as GLint64EXT)
	declare sub glUniform3i64NV(byval location as GLint, byval x as GLint64EXT, byval y as GLint64EXT, byval z as GLint64EXT)
	declare sub glUniform4i64NV(byval location as GLint, byval x as GLint64EXT, byval y as GLint64EXT, byval z as GLint64EXT, byval w as GLint64EXT)
	declare sub glUniform1i64vNV(byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
	declare sub glUniform2i64vNV(byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
	declare sub glUniform3i64vNV(byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
	declare sub glUniform4i64vNV(byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
	declare sub glUniform1ui64NV(byval location as GLint, byval x as GLuint64EXT)
	declare sub glUniform2ui64NV(byval location as GLint, byval x as GLuint64EXT, byval y as GLuint64EXT)
	declare sub glUniform3ui64NV(byval location as GLint, byval x as GLuint64EXT, byval y as GLuint64EXT, byval z as GLuint64EXT)
	declare sub glUniform4ui64NV(byval location as GLint, byval x as GLuint64EXT, byval y as GLuint64EXT, byval z as GLuint64EXT, byval w as GLuint64EXT)
	declare sub glUniform1ui64vNV(byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
	declare sub glUniform2ui64vNV(byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
	declare sub glUniform3ui64vNV(byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
	declare sub glUniform4ui64vNV(byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
	declare sub glGetUniformi64vNV(byval program as GLuint, byval location as GLint, byval params as GLint64EXT ptr)
	declare sub glGetUniformui64vNV(byval program as GLuint, byval location as GLint, byval params as GLuint64EXT ptr)
	declare sub glProgramUniform1i64NV(byval program as GLuint, byval location as GLint, byval x as GLint64EXT)
	declare sub glProgramUniform2i64NV(byval program as GLuint, byval location as GLint, byval x as GLint64EXT, byval y as GLint64EXT)
	declare sub glProgramUniform3i64NV(byval program as GLuint, byval location as GLint, byval x as GLint64EXT, byval y as GLint64EXT, byval z as GLint64EXT)
	declare sub glProgramUniform4i64NV(byval program as GLuint, byval location as GLint, byval x as GLint64EXT, byval y as GLint64EXT, byval z as GLint64EXT, byval w as GLint64EXT)
	declare sub glProgramUniform1i64vNV(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
	declare sub glProgramUniform2i64vNV(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
	declare sub glProgramUniform3i64vNV(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
	declare sub glProgramUniform4i64vNV(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint64EXT ptr)
	declare sub glProgramUniform1ui64NV(byval program as GLuint, byval location as GLint, byval x as GLuint64EXT)
	declare sub glProgramUniform2ui64NV(byval program as GLuint, byval location as GLint, byval x as GLuint64EXT, byval y as GLuint64EXT)
	declare sub glProgramUniform3ui64NV(byval program as GLuint, byval location as GLint, byval x as GLuint64EXT, byval y as GLuint64EXT, byval z as GLuint64EXT)
	declare sub glProgramUniform4ui64NV(byval program as GLuint, byval location as GLint, byval x as GLuint64EXT, byval y as GLuint64EXT, byval z as GLuint64EXT, byval w as GLuint64EXT)
	declare sub glProgramUniform1ui64vNV(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
	declare sub glProgramUniform2ui64vNV(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
	declare sub glProgramUniform3ui64vNV(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
	declare sub glProgramUniform4ui64vNV(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
#endif

const GL_AMD_interleaved_elements = 1
const GL_VERTEX_ELEMENT_SWIZZLE_AMD = &h91A4
const GL_VERTEX_ID_SWIZZLE_AMD = &h91A5
type PFNGLVERTEXATTRIBPARAMETERIAMDPROC as sub(byval index as GLuint, byval pname as GLenum, byval param as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVertexAttribParameteriAMD(byval index as GLuint, byval pname as GLenum, byval param as GLint)
#endif

const GL_AMD_multi_draw_indirect = 1
type PFNGLMULTIDRAWARRAYSINDIRECTAMDPROC as sub(byval mode as GLenum, byval indirect as const any ptr, byval primcount as GLsizei, byval stride as GLsizei)
type PFNGLMULTIDRAWELEMENTSINDIRECTAMDPROC as sub(byval mode as GLenum, byval type as GLenum, byval indirect as const any ptr, byval primcount as GLsizei, byval stride as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glMultiDrawArraysIndirectAMD(byval mode as GLenum, byval indirect as const any ptr, byval primcount as GLsizei, byval stride as GLsizei)
	declare sub glMultiDrawElementsIndirectAMD(byval mode as GLenum, byval type as GLenum, byval indirect as const any ptr, byval primcount as GLsizei, byval stride as GLsizei)
#endif

const GL_AMD_name_gen_delete = 1
const GL_DATA_BUFFER_AMD = &h9151
const GL_PERFORMANCE_MONITOR_AMD = &h9152
const GL_QUERY_OBJECT_AMD = &h9153
const GL_VERTEX_ARRAY_OBJECT_AMD = &h9154
const GL_SAMPLER_OBJECT_AMD = &h9155

type PFNGLGENNAMESAMDPROC as sub(byval identifier as GLenum, byval num as GLuint, byval names as GLuint ptr)
type PFNGLDELETENAMESAMDPROC as sub(byval identifier as GLenum, byval num as GLuint, byval names as const GLuint ptr)
type PFNGLISNAMEAMDPROC as function(byval identifier as GLenum, byval name as GLuint) as GLboolean

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGenNamesAMD(byval identifier as GLenum, byval num as GLuint, byval names as GLuint ptr)
	declare sub glDeleteNamesAMD(byval identifier as GLenum, byval num as GLuint, byval names as const GLuint ptr)
	declare function glIsNameAMD(byval identifier as GLenum, byval name as GLuint) as GLboolean
#endif

const GL_AMD_occlusion_query_event = 1
const GL_OCCLUSION_QUERY_EVENT_MASK_AMD = &h874F
const GL_QUERY_DEPTH_PASS_EVENT_BIT_AMD = &h00000001
const GL_QUERY_DEPTH_FAIL_EVENT_BIT_AMD = &h00000002
const GL_QUERY_STENCIL_FAIL_EVENT_BIT_AMD = &h00000004
const GL_QUERY_DEPTH_BOUNDS_FAIL_EVENT_BIT_AMD = &h00000008
const GL_QUERY_ALL_EVENT_BITS_AMD = &hFFFFFFFF
type PFNGLQUERYOBJECTPARAMETERUIAMDPROC as sub(byval target as GLenum, byval id as GLuint, byval pname as GLenum, byval param as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glQueryObjectParameteruiAMD(byval target as GLenum, byval id as GLuint, byval pname as GLenum, byval param as GLuint)
#endif

const GL_AMD_performance_monitor = 1
const GL_COUNTER_TYPE_AMD = &h8BC0
const GL_COUNTER_RANGE_AMD = &h8BC1
const GL_UNSIGNED_INT64_AMD = &h8BC2
const GL_PERCENTAGE_AMD = &h8BC3
const GL_PERFMON_RESULT_AVAILABLE_AMD = &h8BC4
const GL_PERFMON_RESULT_SIZE_AMD = &h8BC5
const GL_PERFMON_RESULT_AMD = &h8BC6

type PFNGLGETPERFMONITORGROUPSAMDPROC as sub(byval numGroups as GLint ptr, byval groupsSize as GLsizei, byval groups as GLuint ptr)
type PFNGLGETPERFMONITORCOUNTERSAMDPROC as sub(byval group as GLuint, byval numCounters as GLint ptr, byval maxActiveCounters as GLint ptr, byval counterSize as GLsizei, byval counters as GLuint ptr)
type PFNGLGETPERFMONITORGROUPSTRINGAMDPROC as sub(byval group as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval groupString as GLchar ptr)
type PFNGLGETPERFMONITORCOUNTERSTRINGAMDPROC as sub(byval group as GLuint, byval counter as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval counterString as GLchar ptr)
type PFNGLGETPERFMONITORCOUNTERINFOAMDPROC as sub(byval group as GLuint, byval counter as GLuint, byval pname as GLenum, byval data as any ptr)
type PFNGLGENPERFMONITORSAMDPROC as sub(byval n as GLsizei, byval monitors as GLuint ptr)
type PFNGLDELETEPERFMONITORSAMDPROC as sub(byval n as GLsizei, byval monitors as GLuint ptr)
type PFNGLSELECTPERFMONITORCOUNTERSAMDPROC as sub(byval monitor as GLuint, byval enable as GLboolean, byval group as GLuint, byval numCounters as GLint, byval counterList as GLuint ptr)
type PFNGLBEGINPERFMONITORAMDPROC as sub(byval monitor as GLuint)
type PFNGLENDPERFMONITORAMDPROC as sub(byval monitor as GLuint)
type PFNGLGETPERFMONITORCOUNTERDATAAMDPROC as sub(byval monitor as GLuint, byval pname as GLenum, byval dataSize as GLsizei, byval data as GLuint ptr, byval bytesWritten as GLint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGetPerfMonitorGroupsAMD(byval numGroups as GLint ptr, byval groupsSize as GLsizei, byval groups as GLuint ptr)
	declare sub glGetPerfMonitorCountersAMD(byval group as GLuint, byval numCounters as GLint ptr, byval maxActiveCounters as GLint ptr, byval counterSize as GLsizei, byval counters as GLuint ptr)
	declare sub glGetPerfMonitorGroupStringAMD(byval group as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval groupString as GLchar ptr)
	declare sub glGetPerfMonitorCounterStringAMD(byval group as GLuint, byval counter as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval counterString as GLchar ptr)
	declare sub glGetPerfMonitorCounterInfoAMD(byval group as GLuint, byval counter as GLuint, byval pname as GLenum, byval data as any ptr)
	declare sub glGenPerfMonitorsAMD(byval n as GLsizei, byval monitors as GLuint ptr)
	declare sub glDeletePerfMonitorsAMD(byval n as GLsizei, byval monitors as GLuint ptr)
	declare sub glSelectPerfMonitorCountersAMD(byval monitor as GLuint, byval enable as GLboolean, byval group as GLuint, byval numCounters as GLint, byval counterList as GLuint ptr)
	declare sub glBeginPerfMonitorAMD(byval monitor as GLuint)
	declare sub glEndPerfMonitorAMD(byval monitor as GLuint)
	declare sub glGetPerfMonitorCounterDataAMD(byval monitor as GLuint, byval pname as GLenum, byval dataSize as GLsizei, byval data as GLuint ptr, byval bytesWritten as GLint ptr)
#endif

const GL_AMD_pinned_memory = 1
const GL_EXTERNAL_VIRTUAL_MEMORY_BUFFER_AMD = &h9160
const GL_AMD_query_buffer_object = 1
const GL_QUERY_BUFFER_AMD = &h9192
const GL_QUERY_BUFFER_BINDING_AMD = &h9193
const GL_QUERY_RESULT_NO_WAIT_AMD = &h9194
const GL_AMD_sample_positions = 1
const GL_SUBSAMPLE_DISTANCE_AMD = &h883F
type PFNGLSETMULTISAMPLEFVAMDPROC as sub(byval pname as GLenum, byval index as GLuint, byval val as const GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glSetMultisamplefvAMD(byval pname as GLenum, byval index as GLuint, byval val as const GLfloat ptr)
#endif

const GL_AMD_seamless_cubemap_per_texture = 1
const GL_AMD_shader_atomic_counter_ops = 1
const GL_AMD_shader_stencil_export = 1
const GL_AMD_shader_trinary_minmax = 1
const GL_AMD_sparse_texture = 1
const GL_VIRTUAL_PAGE_SIZE_X_AMD = &h9195
const GL_VIRTUAL_PAGE_SIZE_Y_AMD = &h9196
const GL_VIRTUAL_PAGE_SIZE_Z_AMD = &h9197
const GL_MAX_SPARSE_TEXTURE_SIZE_AMD = &h9198
const GL_MAX_SPARSE_3D_TEXTURE_SIZE_AMD = &h9199
const GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS = &h919A
const GL_MIN_SPARSE_LEVEL_AMD = &h919B
const GL_MIN_LOD_WARNING_AMD = &h919C
const GL_TEXTURE_STORAGE_SPARSE_BIT_AMD = &h00000001
type PFNGLTEXSTORAGESPARSEAMDPROC as sub(byval target as GLenum, byval internalFormat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval layers as GLsizei, byval flags as GLbitfield)
type PFNGLTEXTURESTORAGESPARSEAMDPROC as sub(byval texture as GLuint, byval target as GLenum, byval internalFormat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval layers as GLsizei, byval flags as GLbitfield)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTexStorageSparseAMD(byval target as GLenum, byval internalFormat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval layers as GLsizei, byval flags as GLbitfield)
	declare sub glTextureStorageSparseAMD(byval texture as GLuint, byval target as GLenum, byval internalFormat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval layers as GLsizei, byval flags as GLbitfield)
#endif

const GL_AMD_stencil_operation_extended = 1
const GL_SET_AMD = &h874A
const GL_REPLACE_VALUE_AMD = &h874B
const GL_STENCIL_OP_VALUE_AMD = &h874C
const GL_STENCIL_BACK_OP_VALUE_AMD = &h874D
type PFNGLSTENCILOPVALUEAMDPROC as sub(byval face as GLenum, byval value as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glStencilOpValueAMD(byval face as GLenum, byval value as GLuint)
#endif

const GL_AMD_texture_texture4 = 1
const GL_AMD_transform_feedback3_lines_triangles = 1
const GL_AMD_transform_feedback4 = 1
const GL_STREAM_RASTERIZATION_AMD = &h91A0
const GL_AMD_vertex_shader_layer = 1
const GL_AMD_vertex_shader_tessellator = 1
const GL_SAMPLER_BUFFER_AMD = &h9001
const GL_INT_SAMPLER_BUFFER_AMD = &h9002
const GL_UNSIGNED_INT_SAMPLER_BUFFER_AMD = &h9003
const GL_TESSELLATION_MODE_AMD = &h9004
const GL_TESSELLATION_FACTOR_AMD = &h9005
const GL_DISCRETE_AMD = &h9006
const GL_CONTINUOUS_AMD = &h9007
type PFNGLTESSELLATIONFACTORAMDPROC as sub(byval factor as GLfloat)
type PFNGLTESSELLATIONMODEAMDPROC as sub(byval mode as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTessellationFactorAMD(byval factor as GLfloat)
	declare sub glTessellationModeAMD(byval mode as GLenum)
#endif

const GL_AMD_vertex_shader_viewport_index = 1
const GL_APPLE_aux_depth_stencil = 1
const GL_AUX_DEPTH_STENCIL_APPLE = &h8A14
const GL_APPLE_client_storage = 1
const GL_UNPACK_CLIENT_STORAGE_APPLE = &h85B2
const GL_APPLE_element_array = 1
const GL_ELEMENT_ARRAY_APPLE = &h8A0C
const GL_ELEMENT_ARRAY_TYPE_APPLE = &h8A0D
const GL_ELEMENT_ARRAY_POINTER_APPLE = &h8A0E

type PFNGLELEMENTPOINTERAPPLEPROC as sub(byval type as GLenum, byval pointer as const any ptr)
type PFNGLDRAWELEMENTARRAYAPPLEPROC as sub(byval mode as GLenum, byval first as GLint, byval count as GLsizei)
type PFNGLDRAWRANGEELEMENTARRAYAPPLEPROC as sub(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval first as GLint, byval count as GLsizei)
type PFNGLMULTIDRAWELEMENTARRAYAPPLEPROC as sub(byval mode as GLenum, byval first as const GLint ptr, byval count as const GLsizei ptr, byval primcount as GLsizei)
type PFNGLMULTIDRAWRANGEELEMENTARRAYAPPLEPROC as sub(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval first as const GLint ptr, byval count as const GLsizei ptr, byval primcount as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glElementPointerAPPLE(byval type as GLenum, byval pointer as const any ptr)
	declare sub glDrawElementArrayAPPLE(byval mode as GLenum, byval first as GLint, byval count as GLsizei)
	declare sub glDrawRangeElementArrayAPPLE(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval first as GLint, byval count as GLsizei)
	declare sub glMultiDrawElementArrayAPPLE(byval mode as GLenum, byval first as const GLint ptr, byval count as const GLsizei ptr, byval primcount as GLsizei)
	declare sub glMultiDrawRangeElementArrayAPPLE(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval first as const GLint ptr, byval count as const GLsizei ptr, byval primcount as GLsizei)
#endif

const GL_APPLE_fence = 1
const GL_DRAW_PIXELS_APPLE = &h8A0A
const GL_FENCE_APPLE = &h8A0B

type PFNGLGENFENCESAPPLEPROC as sub(byval n as GLsizei, byval fences as GLuint ptr)
type PFNGLDELETEFENCESAPPLEPROC as sub(byval n as GLsizei, byval fences as const GLuint ptr)
type PFNGLSETFENCEAPPLEPROC as sub(byval fence as GLuint)
type PFNGLISFENCEAPPLEPROC as function(byval fence as GLuint) as GLboolean
type PFNGLTESTFENCEAPPLEPROC as function(byval fence as GLuint) as GLboolean
type PFNGLFINISHFENCEAPPLEPROC as sub(byval fence as GLuint)
type PFNGLTESTOBJECTAPPLEPROC as function(byval object as GLenum, byval name as GLuint) as GLboolean
type PFNGLFINISHOBJECTAPPLEPROC as sub(byval object as GLenum, byval name as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGenFencesAPPLE(byval n as GLsizei, byval fences as GLuint ptr)
	declare sub glDeleteFencesAPPLE(byval n as GLsizei, byval fences as const GLuint ptr)
	declare sub glSetFenceAPPLE(byval fence as GLuint)
	declare function glIsFenceAPPLE(byval fence as GLuint) as GLboolean
	declare function glTestFenceAPPLE(byval fence as GLuint) as GLboolean
	declare sub glFinishFenceAPPLE(byval fence as GLuint)
	declare function glTestObjectAPPLE(byval object as GLenum, byval name as GLuint) as GLboolean
	declare sub glFinishObjectAPPLE(byval object as GLenum, byval name as GLint)
#endif

const GL_APPLE_float_pixels = 1
const GL_HALF_APPLE = &h140B
const GL_RGBA_FLOAT32_APPLE = &h8814
const GL_RGB_FLOAT32_APPLE = &h8815
const GL_ALPHA_FLOAT32_APPLE = &h8816
const GL_INTENSITY_FLOAT32_APPLE = &h8817
const GL_LUMINANCE_FLOAT32_APPLE = &h8818
const GL_LUMINANCE_ALPHA_FLOAT32_APPLE = &h8819
const GL_RGBA_FLOAT16_APPLE = &h881A
const GL_RGB_FLOAT16_APPLE = &h881B
const GL_ALPHA_FLOAT16_APPLE = &h881C
const GL_INTENSITY_FLOAT16_APPLE = &h881D
const GL_LUMINANCE_FLOAT16_APPLE = &h881E
const GL_LUMINANCE_ALPHA_FLOAT16_APPLE = &h881F
const GL_COLOR_FLOAT_APPLE = &h8A0F
const GL_APPLE_flush_buffer_range = 1
const GL_BUFFER_SERIALIZED_MODIFY_APPLE = &h8A12
const GL_BUFFER_FLUSHING_UNMAP_APPLE = &h8A13
type PFNGLBUFFERPARAMETERIAPPLEPROC as sub(byval target as GLenum, byval pname as GLenum, byval param as GLint)
type PFNGLFLUSHMAPPEDBUFFERRANGEAPPLEPROC as sub(byval target as GLenum, byval offset as GLintptr, byval size as GLsizeiptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBufferParameteriAPPLE(byval target as GLenum, byval pname as GLenum, byval param as GLint)
	declare sub glFlushMappedBufferRangeAPPLE(byval target as GLenum, byval offset as GLintptr, byval size as GLsizeiptr)
#endif

const GL_APPLE_object_purgeable = 1
const GL_BUFFER_OBJECT_APPLE = &h85B3
const GL_RELEASED_APPLE = &h8A19
const GL_VOLATILE_APPLE = &h8A1A
const GL_RETAINED_APPLE = &h8A1B
const GL_UNDEFINED_APPLE = &h8A1C
const GL_PURGEABLE_APPLE = &h8A1D

type PFNGLOBJECTPURGEABLEAPPLEPROC as function(byval objectType as GLenum, byval name as GLuint, byval option as GLenum) as GLenum
type PFNGLOBJECTUNPURGEABLEAPPLEPROC as function(byval objectType as GLenum, byval name as GLuint, byval option as GLenum) as GLenum
type PFNGLGETOBJECTPARAMETERIVAPPLEPROC as sub(byval objectType as GLenum, byval name as GLuint, byval pname as GLenum, byval params as GLint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare function glObjectPurgeableAPPLE(byval objectType as GLenum, byval name as GLuint, byval option as GLenum) as GLenum
	declare function glObjectUnpurgeableAPPLE(byval objectType as GLenum, byval name as GLuint, byval option as GLenum) as GLenum
	declare sub glGetObjectParameterivAPPLE(byval objectType as GLenum, byval name as GLuint, byval pname as GLenum, byval params as GLint ptr)
#endif

const GL_APPLE_rgb_422 = 1
const GL_RGB_422_APPLE = &h8A1F
const GL_UNSIGNED_SHORT_8_8_APPLE = &h85BA
const GL_UNSIGNED_SHORT_8_8_REV_APPLE = &h85BB
const GL_RGB_RAW_422_APPLE = &h8A51
const GL_APPLE_row_bytes = 1
const GL_PACK_ROW_BYTES_APPLE = &h8A15
const GL_UNPACK_ROW_BYTES_APPLE = &h8A16
const GL_APPLE_specular_vector = 1
const GL_LIGHT_MODEL_SPECULAR_VECTOR_APPLE = &h85B0
const GL_APPLE_texture_range = 1
const GL_TEXTURE_RANGE_LENGTH_APPLE = &h85B7
const GL_TEXTURE_RANGE_POINTER_APPLE = &h85B8
const GL_TEXTURE_STORAGE_HINT_APPLE = &h85BC
const GL_STORAGE_PRIVATE_APPLE = &h85BD
const GL_STORAGE_CACHED_APPLE = &h85BE
const GL_STORAGE_SHARED_APPLE = &h85BF
type PFNGLTEXTURERANGEAPPLEPROC as sub(byval target as GLenum, byval length as GLsizei, byval pointer as const any ptr)
type PFNGLGETTEXPARAMETERPOINTERVAPPLEPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as any ptr ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTextureRangeAPPLE(byval target as GLenum, byval length as GLsizei, byval pointer as const any ptr)
	declare sub glGetTexParameterPointervAPPLE(byval target as GLenum, byval pname as GLenum, byval params as any ptr ptr)
#endif

const GL_APPLE_transform_hint = 1
const GL_TRANSFORM_HINT_APPLE = &h85B1
const GL_APPLE_vertex_array_object = 1
const GL_VERTEX_ARRAY_BINDING_APPLE = &h85B5

type PFNGLBINDVERTEXARRAYAPPLEPROC as sub(byval array as GLuint)
type PFNGLDELETEVERTEXARRAYSAPPLEPROC as sub(byval n as GLsizei, byval arrays as const GLuint ptr)
type PFNGLGENVERTEXARRAYSAPPLEPROC as sub(byval n as GLsizei, byval arrays as GLuint ptr)
type PFNGLISVERTEXARRAYAPPLEPROC as function(byval array as GLuint) as GLboolean

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBindVertexArrayAPPLE(byval array as GLuint)
	declare sub glDeleteVertexArraysAPPLE(byval n as GLsizei, byval arrays as const GLuint ptr)
	declare sub glGenVertexArraysAPPLE(byval n as GLsizei, byval arrays as GLuint ptr)
	declare function glIsVertexArrayAPPLE(byval array as GLuint) as GLboolean
#endif

const GL_APPLE_vertex_array_range = 1
const GL_VERTEX_ARRAY_RANGE_APPLE = &h851D
const GL_VERTEX_ARRAY_RANGE_LENGTH_APPLE = &h851E
const GL_VERTEX_ARRAY_STORAGE_HINT_APPLE = &h851F
const GL_VERTEX_ARRAY_RANGE_POINTER_APPLE = &h8521
const GL_STORAGE_CLIENT_APPLE = &h85B4

type PFNGLVERTEXARRAYRANGEAPPLEPROC as sub(byval length as GLsizei, byval pointer as any ptr)
type PFNGLFLUSHVERTEXARRAYRANGEAPPLEPROC as sub(byval length as GLsizei, byval pointer as any ptr)
type PFNGLVERTEXARRAYPARAMETERIAPPLEPROC as sub(byval pname as GLenum, byval param as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVertexArrayRangeAPPLE(byval length as GLsizei, byval pointer as any ptr)
	declare sub glFlushVertexArrayRangeAPPLE(byval length as GLsizei, byval pointer as any ptr)
	declare sub glVertexArrayParameteriAPPLE(byval pname as GLenum, byval param as GLint)
#endif

const GL_APPLE_vertex_program_evaluators = 1
const GL_VERTEX_ATTRIB_MAP1_APPLE = &h8A00
const GL_VERTEX_ATTRIB_MAP2_APPLE = &h8A01
const GL_VERTEX_ATTRIB_MAP1_SIZE_APPLE = &h8A02
const GL_VERTEX_ATTRIB_MAP1_COEFF_APPLE = &h8A03
const GL_VERTEX_ATTRIB_MAP1_ORDER_APPLE = &h8A04
const GL_VERTEX_ATTRIB_MAP1_DOMAIN_APPLE = &h8A05
const GL_VERTEX_ATTRIB_MAP2_SIZE_APPLE = &h8A06
const GL_VERTEX_ATTRIB_MAP2_COEFF_APPLE = &h8A07
const GL_VERTEX_ATTRIB_MAP2_ORDER_APPLE = &h8A08
const GL_VERTEX_ATTRIB_MAP2_DOMAIN_APPLE = &h8A09

type PFNGLENABLEVERTEXATTRIBAPPLEPROC as sub(byval index as GLuint, byval pname as GLenum)
type PFNGLDISABLEVERTEXATTRIBAPPLEPROC as sub(byval index as GLuint, byval pname as GLenum)
type PFNGLISVERTEXATTRIBENABLEDAPPLEPROC as function(byval index as GLuint, byval pname as GLenum) as GLboolean
type PFNGLMAPVERTEXATTRIB1DAPPLEPROC as sub(byval index as GLuint, byval size as GLuint, byval u1 as GLdouble, byval u2 as GLdouble, byval stride as GLint, byval order as GLint, byval points as const GLdouble ptr)
type PFNGLMAPVERTEXATTRIB1FAPPLEPROC as sub(byval index as GLuint, byval size as GLuint, byval u1 as GLfloat, byval u2 as GLfloat, byval stride as GLint, byval order as GLint, byval points as const GLfloat ptr)
type PFNGLMAPVERTEXATTRIB2DAPPLEPROC as sub(byval index as GLuint, byval size as GLuint, byval u1 as GLdouble, byval u2 as GLdouble, byval ustride as GLint, byval uorder as GLint, byval v1 as GLdouble, byval v2 as GLdouble, byval vstride as GLint, byval vorder as GLint, byval points as const GLdouble ptr)
type PFNGLMAPVERTEXATTRIB2FAPPLEPROC as sub(byval index as GLuint, byval size as GLuint, byval u1 as GLfloat, byval u2 as GLfloat, byval ustride as GLint, byval uorder as GLint, byval v1 as GLfloat, byval v2 as GLfloat, byval vstride as GLint, byval vorder as GLint, byval points as const GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glEnableVertexAttribAPPLE(byval index as GLuint, byval pname as GLenum)
	declare sub glDisableVertexAttribAPPLE(byval index as GLuint, byval pname as GLenum)
	declare function glIsVertexAttribEnabledAPPLE(byval index as GLuint, byval pname as GLenum) as GLboolean
	declare sub glMapVertexAttrib1dAPPLE(byval index as GLuint, byval size as GLuint, byval u1 as GLdouble, byval u2 as GLdouble, byval stride as GLint, byval order as GLint, byval points as const GLdouble ptr)
	declare sub glMapVertexAttrib1fAPPLE(byval index as GLuint, byval size as GLuint, byval u1 as GLfloat, byval u2 as GLfloat, byval stride as GLint, byval order as GLint, byval points as const GLfloat ptr)
	declare sub glMapVertexAttrib2dAPPLE(byval index as GLuint, byval size as GLuint, byval u1 as GLdouble, byval u2 as GLdouble, byval ustride as GLint, byval uorder as GLint, byval v1 as GLdouble, byval v2 as GLdouble, byval vstride as GLint, byval vorder as GLint, byval points as const GLdouble ptr)
	declare sub glMapVertexAttrib2fAPPLE(byval index as GLuint, byval size as GLuint, byval u1 as GLfloat, byval u2 as GLfloat, byval ustride as GLint, byval uorder as GLint, byval v1 as GLfloat, byval v2 as GLfloat, byval vstride as GLint, byval vorder as GLint, byval points as const GLfloat ptr)
#endif

const GL_APPLE_ycbcr_422 = 1
const GL_YCBCR_422_APPLE = &h85B9
const GL_ATI_draw_buffers = 1
const GL_MAX_DRAW_BUFFERS_ATI = &h8824
const GL_DRAW_BUFFER0_ATI = &h8825
const GL_DRAW_BUFFER1_ATI = &h8826
const GL_DRAW_BUFFER2_ATI = &h8827
const GL_DRAW_BUFFER3_ATI = &h8828
const GL_DRAW_BUFFER4_ATI = &h8829
const GL_DRAW_BUFFER5_ATI = &h882A
const GL_DRAW_BUFFER6_ATI = &h882B
const GL_DRAW_BUFFER7_ATI = &h882C
const GL_DRAW_BUFFER8_ATI = &h882D
const GL_DRAW_BUFFER9_ATI = &h882E
const GL_DRAW_BUFFER10_ATI = &h882F
const GL_DRAW_BUFFER11_ATI = &h8830
const GL_DRAW_BUFFER12_ATI = &h8831
const GL_DRAW_BUFFER13_ATI = &h8832
const GL_DRAW_BUFFER14_ATI = &h8833
const GL_DRAW_BUFFER15_ATI = &h8834
type PFNGLDRAWBUFFERSATIPROC as sub(byval n as GLsizei, byval bufs as const GLenum ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDrawBuffersATI(byval n as GLsizei, byval bufs as const GLenum ptr)
#endif

const GL_ATI_element_array = 1
const GL_ELEMENT_ARRAY_ATI = &h8768
const GL_ELEMENT_ARRAY_TYPE_ATI = &h8769
const GL_ELEMENT_ARRAY_POINTER_ATI = &h876A

type PFNGLELEMENTPOINTERATIPROC as sub(byval type as GLenum, byval pointer as const any ptr)
type PFNGLDRAWELEMENTARRAYATIPROC as sub(byval mode as GLenum, byval count as GLsizei)
type PFNGLDRAWRANGEELEMENTARRAYATIPROC as sub(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval count as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glElementPointerATI(byval type as GLenum, byval pointer as const any ptr)
	declare sub glDrawElementArrayATI(byval mode as GLenum, byval count as GLsizei)
	declare sub glDrawRangeElementArrayATI(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval count as GLsizei)
#endif

const GL_ATI_envmap_bumpmap = 1
const GL_BUMP_ROT_MATRIX_ATI = &h8775
const GL_BUMP_ROT_MATRIX_SIZE_ATI = &h8776
const GL_BUMP_NUM_TEX_UNITS_ATI = &h8777
const GL_BUMP_TEX_UNITS_ATI = &h8778
const GL_DUDV_ATI = &h8779
const GL_DU8DV8_ATI = &h877A
const GL_BUMP_ENVMAP_ATI = &h877B
const GL_BUMP_TARGET_ATI = &h877C

type PFNGLTEXBUMPPARAMETERIVATIPROC as sub(byval pname as GLenum, byval param as const GLint ptr)
type PFNGLTEXBUMPPARAMETERFVATIPROC as sub(byval pname as GLenum, byval param as const GLfloat ptr)
type PFNGLGETTEXBUMPPARAMETERIVATIPROC as sub(byval pname as GLenum, byval param as GLint ptr)
type PFNGLGETTEXBUMPPARAMETERFVATIPROC as sub(byval pname as GLenum, byval param as GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTexBumpParameterivATI(byval pname as GLenum, byval param as const GLint ptr)
	declare sub glTexBumpParameterfvATI(byval pname as GLenum, byval param as const GLfloat ptr)
	declare sub glGetTexBumpParameterivATI(byval pname as GLenum, byval param as GLint ptr)
	declare sub glGetTexBumpParameterfvATI(byval pname as GLenum, byval param as GLfloat ptr)
#endif

const GL_ATI_fragment_shader = 1
const GL_FRAGMENT_SHADER_ATI = &h8920
const GL_REG_0_ATI = &h8921
const GL_REG_1_ATI = &h8922
const GL_REG_2_ATI = &h8923
const GL_REG_3_ATI = &h8924
const GL_REG_4_ATI = &h8925
const GL_REG_5_ATI = &h8926
const GL_REG_6_ATI = &h8927
const GL_REG_7_ATI = &h8928
const GL_REG_8_ATI = &h8929
const GL_REG_9_ATI = &h892A
const GL_REG_10_ATI = &h892B
const GL_REG_11_ATI = &h892C
const GL_REG_12_ATI = &h892D
const GL_REG_13_ATI = &h892E
const GL_REG_14_ATI = &h892F
const GL_REG_15_ATI = &h8930
const GL_REG_16_ATI = &h8931
const GL_REG_17_ATI = &h8932
const GL_REG_18_ATI = &h8933
const GL_REG_19_ATI = &h8934
const GL_REG_20_ATI = &h8935
const GL_REG_21_ATI = &h8936
const GL_REG_22_ATI = &h8937
const GL_REG_23_ATI = &h8938
const GL_REG_24_ATI = &h8939
const GL_REG_25_ATI = &h893A
const GL_REG_26_ATI = &h893B
const GL_REG_27_ATI = &h893C
const GL_REG_28_ATI = &h893D
const GL_REG_29_ATI = &h893E
const GL_REG_30_ATI = &h893F
const GL_REG_31_ATI = &h8940
const GL_CON_0_ATI = &h8941
const GL_CON_1_ATI = &h8942
const GL_CON_2_ATI = &h8943
const GL_CON_3_ATI = &h8944
const GL_CON_4_ATI = &h8945
const GL_CON_5_ATI = &h8946
const GL_CON_6_ATI = &h8947
const GL_CON_7_ATI = &h8948
const GL_CON_8_ATI = &h8949
const GL_CON_9_ATI = &h894A
const GL_CON_10_ATI = &h894B
const GL_CON_11_ATI = &h894C
const GL_CON_12_ATI = &h894D
const GL_CON_13_ATI = &h894E
const GL_CON_14_ATI = &h894F
const GL_CON_15_ATI = &h8950
const GL_CON_16_ATI = &h8951
const GL_CON_17_ATI = &h8952
const GL_CON_18_ATI = &h8953
const GL_CON_19_ATI = &h8954
const GL_CON_20_ATI = &h8955
const GL_CON_21_ATI = &h8956
const GL_CON_22_ATI = &h8957
const GL_CON_23_ATI = &h8958
const GL_CON_24_ATI = &h8959
const GL_CON_25_ATI = &h895A
const GL_CON_26_ATI = &h895B
const GL_CON_27_ATI = &h895C
const GL_CON_28_ATI = &h895D
const GL_CON_29_ATI = &h895E
const GL_CON_30_ATI = &h895F
const GL_CON_31_ATI = &h8960
const GL_MOV_ATI = &h8961
const GL_ADD_ATI = &h8963
const GL_MUL_ATI = &h8964
const GL_SUB_ATI = &h8965
const GL_DOT3_ATI = &h8966
const GL_DOT4_ATI = &h8967
const GL_MAD_ATI = &h8968
const GL_LERP_ATI = &h8969
const GL_CND_ATI = &h896A
const GL_CND0_ATI = &h896B
const GL_DOT2_ADD_ATI = &h896C
const GL_SECONDARY_INTERPOLATOR_ATI = &h896D
const GL_NUM_FRAGMENT_REGISTERS_ATI = &h896E
const GL_NUM_FRAGMENT_CONSTANTS_ATI = &h896F
const GL_NUM_PASSES_ATI = &h8970
const GL_NUM_INSTRUCTIONS_PER_PASS_ATI = &h8971
const GL_NUM_INSTRUCTIONS_TOTAL_ATI = &h8972
const GL_NUM_INPUT_INTERPOLATOR_COMPONENTS_ATI = &h8973
const GL_NUM_LOOPBACK_COMPONENTS_ATI = &h8974
const GL_COLOR_ALPHA_PAIRING_ATI = &h8975
const GL_SWIZZLE_STR_ATI = &h8976
const GL_SWIZZLE_STQ_ATI = &h8977
const GL_SWIZZLE_STR_DR_ATI = &h8978
const GL_SWIZZLE_STQ_DQ_ATI = &h8979
const GL_SWIZZLE_STRQ_ATI = &h897A
const GL_SWIZZLE_STRQ_DQ_ATI = &h897B
const GL_RED_BIT_ATI = &h00000001
const GL_GREEN_BIT_ATI = &h00000002
const GL_BLUE_BIT_ATI = &h00000004
const GL_2X_BIT_ATI = &h00000001
const GL_4X_BIT_ATI = &h00000002
const GL_8X_BIT_ATI = &h00000004
const GL_HALF_BIT_ATI = &h00000008
const GL_QUARTER_BIT_ATI = &h00000010
const GL_EIGHTH_BIT_ATI = &h00000020
const GL_SATURATE_BIT_ATI = &h00000040
const GL_COMP_BIT_ATI = &h00000002
const GL_NEGATE_BIT_ATI = &h00000004
const GL_BIAS_BIT_ATI = &h00000008

type PFNGLGENFRAGMENTSHADERSATIPROC as function(byval range as GLuint) as GLuint
type PFNGLBINDFRAGMENTSHADERATIPROC as sub(byval id as GLuint)
type PFNGLDELETEFRAGMENTSHADERATIPROC as sub(byval id as GLuint)
type PFNGLBEGINFRAGMENTSHADERATIPROC as sub()
type PFNGLENDFRAGMENTSHADERATIPROC as sub()
type PFNGLPASSTEXCOORDATIPROC as sub(byval dst as GLuint, byval coord as GLuint, byval swizzle as GLenum)
type PFNGLSAMPLEMAPATIPROC as sub(byval dst as GLuint, byval interp as GLuint, byval swizzle as GLenum)
type PFNGLCOLORFRAGMENTOP1ATIPROC as sub(byval op as GLenum, byval dst as GLuint, byval dstMask as GLuint, byval dstMod as GLuint, byval arg1 as GLuint, byval arg1Rep as GLuint, byval arg1Mod as GLuint)
type PFNGLCOLORFRAGMENTOP2ATIPROC as sub(byval op as GLenum, byval dst as GLuint, byval dstMask as GLuint, byval dstMod as GLuint, byval arg1 as GLuint, byval arg1Rep as GLuint, byval arg1Mod as GLuint, byval arg2 as GLuint, byval arg2Rep as GLuint, byval arg2Mod as GLuint)
type PFNGLCOLORFRAGMENTOP3ATIPROC as sub(byval op as GLenum, byval dst as GLuint, byval dstMask as GLuint, byval dstMod as GLuint, byval arg1 as GLuint, byval arg1Rep as GLuint, byval arg1Mod as GLuint, byval arg2 as GLuint, byval arg2Rep as GLuint, byval arg2Mod as GLuint, byval arg3 as GLuint, byval arg3Rep as GLuint, byval arg3Mod as GLuint)
type PFNGLALPHAFRAGMENTOP1ATIPROC as sub(byval op as GLenum, byval dst as GLuint, byval dstMod as GLuint, byval arg1 as GLuint, byval arg1Rep as GLuint, byval arg1Mod as GLuint)
type PFNGLALPHAFRAGMENTOP2ATIPROC as sub(byval op as GLenum, byval dst as GLuint, byval dstMod as GLuint, byval arg1 as GLuint, byval arg1Rep as GLuint, byval arg1Mod as GLuint, byval arg2 as GLuint, byval arg2Rep as GLuint, byval arg2Mod as GLuint)
type PFNGLALPHAFRAGMENTOP3ATIPROC as sub(byval op as GLenum, byval dst as GLuint, byval dstMod as GLuint, byval arg1 as GLuint, byval arg1Rep as GLuint, byval arg1Mod as GLuint, byval arg2 as GLuint, byval arg2Rep as GLuint, byval arg2Mod as GLuint, byval arg3 as GLuint, byval arg3Rep as GLuint, byval arg3Mod as GLuint)
type PFNGLSETFRAGMENTSHADERCONSTANTATIPROC as sub(byval dst as GLuint, byval value as const GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare function glGenFragmentShadersATI(byval range as GLuint) as GLuint
	declare sub glBindFragmentShaderATI(byval id as GLuint)
	declare sub glDeleteFragmentShaderATI(byval id as GLuint)
	declare sub glBeginFragmentShaderATI()
	declare sub glEndFragmentShaderATI()
	declare sub glPassTexCoordATI(byval dst as GLuint, byval coord as GLuint, byval swizzle as GLenum)
	declare sub glSampleMapATI(byval dst as GLuint, byval interp as GLuint, byval swizzle as GLenum)
	declare sub glColorFragmentOp1ATI(byval op as GLenum, byval dst as GLuint, byval dstMask as GLuint, byval dstMod as GLuint, byval arg1 as GLuint, byval arg1Rep as GLuint, byval arg1Mod as GLuint)
	declare sub glColorFragmentOp2ATI(byval op as GLenum, byval dst as GLuint, byval dstMask as GLuint, byval dstMod as GLuint, byval arg1 as GLuint, byval arg1Rep as GLuint, byval arg1Mod as GLuint, byval arg2 as GLuint, byval arg2Rep as GLuint, byval arg2Mod as GLuint)
	declare sub glColorFragmentOp3ATI(byval op as GLenum, byval dst as GLuint, byval dstMask as GLuint, byval dstMod as GLuint, byval arg1 as GLuint, byval arg1Rep as GLuint, byval arg1Mod as GLuint, byval arg2 as GLuint, byval arg2Rep as GLuint, byval arg2Mod as GLuint, byval arg3 as GLuint, byval arg3Rep as GLuint, byval arg3Mod as GLuint)
	declare sub glAlphaFragmentOp1ATI(byval op as GLenum, byval dst as GLuint, byval dstMod as GLuint, byval arg1 as GLuint, byval arg1Rep as GLuint, byval arg1Mod as GLuint)
	declare sub glAlphaFragmentOp2ATI(byval op as GLenum, byval dst as GLuint, byval dstMod as GLuint, byval arg1 as GLuint, byval arg1Rep as GLuint, byval arg1Mod as GLuint, byval arg2 as GLuint, byval arg2Rep as GLuint, byval arg2Mod as GLuint)
	declare sub glAlphaFragmentOp3ATI(byval op as GLenum, byval dst as GLuint, byval dstMod as GLuint, byval arg1 as GLuint, byval arg1Rep as GLuint, byval arg1Mod as GLuint, byval arg2 as GLuint, byval arg2Rep as GLuint, byval arg2Mod as GLuint, byval arg3 as GLuint, byval arg3Rep as GLuint, byval arg3Mod as GLuint)
	declare sub glSetFragmentShaderConstantATI(byval dst as GLuint, byval value as const GLfloat ptr)
#endif

const GL_ATI_map_object_buffer = 1
type PFNGLMAPOBJECTBUFFERATIPROC as function(byval buffer as GLuint) as any ptr
type PFNGLUNMAPOBJECTBUFFERATIPROC as sub(byval buffer as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare function glMapObjectBufferATI(byval buffer as GLuint) as any ptr
	declare sub glUnmapObjectBufferATI(byval buffer as GLuint)
#endif

const GL_ATI_meminfo = 1
const GL_VBO_FREE_MEMORY_ATI = &h87FB
const GL_TEXTURE_FREE_MEMORY_ATI = &h87FC
const GL_RENDERBUFFER_FREE_MEMORY_ATI = &h87FD
const GL_ATI_pixel_format_float = 1
const GL_RGBA_FLOAT_MODE_ATI = &h8820
const GL_COLOR_CLEAR_UNCLAMPED_VALUE_ATI = &h8835
const GL_ATI_pn_triangles = 1
const GL_PN_TRIANGLES_ATI = &h87F0
const GL_MAX_PN_TRIANGLES_TESSELATION_LEVEL_ATI = &h87F1
const GL_PN_TRIANGLES_POINT_MODE_ATI = &h87F2
const GL_PN_TRIANGLES_NORMAL_MODE_ATI = &h87F3
const GL_PN_TRIANGLES_TESSELATION_LEVEL_ATI = &h87F4
const GL_PN_TRIANGLES_POINT_MODE_LINEAR_ATI = &h87F5
const GL_PN_TRIANGLES_POINT_MODE_CUBIC_ATI = &h87F6
const GL_PN_TRIANGLES_NORMAL_MODE_LINEAR_ATI = &h87F7
const GL_PN_TRIANGLES_NORMAL_MODE_QUADRATIC_ATI = &h87F8
type PFNGLPNTRIANGLESIATIPROC as sub(byval pname as GLenum, byval param as GLint)
type PFNGLPNTRIANGLESFATIPROC as sub(byval pname as GLenum, byval param as GLfloat)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPNTrianglesiATI(byval pname as GLenum, byval param as GLint)
	declare sub glPNTrianglesfATI(byval pname as GLenum, byval param as GLfloat)
#endif

const GL_ATI_separate_stencil = 1
const GL_STENCIL_BACK_FUNC_ATI = &h8800
const GL_STENCIL_BACK_FAIL_ATI = &h8801
const GL_STENCIL_BACK_PASS_DEPTH_FAIL_ATI = &h8802
const GL_STENCIL_BACK_PASS_DEPTH_PASS_ATI = &h8803
type PFNGLSTENCILOPSEPARATEATIPROC as sub(byval face as GLenum, byval sfail as GLenum, byval dpfail as GLenum, byval dppass as GLenum)
type PFNGLSTENCILFUNCSEPARATEATIPROC as sub(byval frontfunc as GLenum, byval backfunc as GLenum, byval ref as GLint, byval mask as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glStencilOpSeparateATI(byval face as GLenum, byval sfail as GLenum, byval dpfail as GLenum, byval dppass as GLenum)
	declare sub glStencilFuncSeparateATI(byval frontfunc as GLenum, byval backfunc as GLenum, byval ref as GLint, byval mask as GLuint)
#endif

const GL_ATI_text_fragment_shader = 1
const GL_TEXT_FRAGMENT_SHADER_ATI = &h8200
const GL_ATI_texture_env_combine3 = 1
const GL_MODULATE_ADD_ATI = &h8744
const GL_MODULATE_SIGNED_ADD_ATI = &h8745
const GL_MODULATE_SUBTRACT_ATI = &h8746
const GL_ATI_texture_float = 1
const GL_RGBA_FLOAT32_ATI = &h8814
const GL_RGB_FLOAT32_ATI = &h8815
const GL_ALPHA_FLOAT32_ATI = &h8816
const GL_INTENSITY_FLOAT32_ATI = &h8817
const GL_LUMINANCE_FLOAT32_ATI = &h8818
const GL_LUMINANCE_ALPHA_FLOAT32_ATI = &h8819
const GL_RGBA_FLOAT16_ATI = &h881A
const GL_RGB_FLOAT16_ATI = &h881B
const GL_ALPHA_FLOAT16_ATI = &h881C
const GL_INTENSITY_FLOAT16_ATI = &h881D
const GL_LUMINANCE_FLOAT16_ATI = &h881E
const GL_LUMINANCE_ALPHA_FLOAT16_ATI = &h881F
const GL_ATI_texture_mirror_once = 1
const GL_MIRROR_CLAMP_ATI = &h8742
const GL_MIRROR_CLAMP_TO_EDGE_ATI = &h8743
const GL_ATI_vertex_array_object = 1
const GL_STATIC_ATI = &h8760
const GL_DYNAMIC_ATI = &h8761
const GL_PRESERVE_ATI = &h8762
const GL_DISCARD_ATI = &h8763
const GL_OBJECT_BUFFER_SIZE_ATI = &h8764
const GL_OBJECT_BUFFER_USAGE_ATI = &h8765
const GL_ARRAY_OBJECT_BUFFER_ATI = &h8766
const GL_ARRAY_OBJECT_OFFSET_ATI = &h8767

type PFNGLNEWOBJECTBUFFERATIPROC as function(byval size as GLsizei, byval pointer as const any ptr, byval usage as GLenum) as GLuint
type PFNGLISOBJECTBUFFERATIPROC as function(byval buffer as GLuint) as GLboolean
type PFNGLUPDATEOBJECTBUFFERATIPROC as sub(byval buffer as GLuint, byval offset as GLuint, byval size as GLsizei, byval pointer as const any ptr, byval preserve as GLenum)
type PFNGLGETOBJECTBUFFERFVATIPROC as sub(byval buffer as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETOBJECTBUFFERIVATIPROC as sub(byval buffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLFREEOBJECTBUFFERATIPROC as sub(byval buffer as GLuint)
type PFNGLARRAYOBJECTATIPROC as sub(byval array as GLenum, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval buffer as GLuint, byval offset as GLuint)
type PFNGLGETARRAYOBJECTFVATIPROC as sub(byval array as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETARRAYOBJECTIVATIPROC as sub(byval array as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLVARIANTARRAYOBJECTATIPROC as sub(byval id as GLuint, byval type as GLenum, byval stride as GLsizei, byval buffer as GLuint, byval offset as GLuint)
type PFNGLGETVARIANTARRAYOBJECTFVATIPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETVARIANTARRAYOBJECTIVATIPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare function glNewObjectBufferATI(byval size as GLsizei, byval pointer as const any ptr, byval usage as GLenum) as GLuint
	declare function glIsObjectBufferATI(byval buffer as GLuint) as GLboolean
	declare sub glUpdateObjectBufferATI(byval buffer as GLuint, byval offset as GLuint, byval size as GLsizei, byval pointer as const any ptr, byval preserve as GLenum)
	declare sub glGetObjectBufferfvATI(byval buffer as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetObjectBufferivATI(byval buffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glFreeObjectBufferATI(byval buffer as GLuint)
	declare sub glArrayObjectATI(byval array as GLenum, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval buffer as GLuint, byval offset as GLuint)
	declare sub glGetArrayObjectfvATI(byval array as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetArrayObjectivATI(byval array as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glVariantArrayObjectATI(byval id as GLuint, byval type as GLenum, byval stride as GLsizei, byval buffer as GLuint, byval offset as GLuint)
	declare sub glGetVariantArrayObjectfvATI(byval id as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetVariantArrayObjectivATI(byval id as GLuint, byval pname as GLenum, byval params as GLint ptr)
#endif

const GL_ATI_vertex_attrib_array_object = 1
type PFNGLVERTEXATTRIBARRAYOBJECTATIPROC as sub(byval index as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval stride as GLsizei, byval buffer as GLuint, byval offset as GLuint)
type PFNGLGETVERTEXATTRIBARRAYOBJECTFVATIPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETVERTEXATTRIBARRAYOBJECTIVATIPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVertexAttribArrayObjectATI(byval index as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval stride as GLsizei, byval buffer as GLuint, byval offset as GLuint)
	declare sub glGetVertexAttribArrayObjectfvATI(byval index as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetVertexAttribArrayObjectivATI(byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
#endif

const GL_ATI_vertex_streams = 1
const GL_MAX_VERTEX_STREAMS_ATI = &h876B
const GL_VERTEX_STREAM0_ATI = &h876C
const GL_VERTEX_STREAM1_ATI = &h876D
const GL_VERTEX_STREAM2_ATI = &h876E
const GL_VERTEX_STREAM3_ATI = &h876F
const GL_VERTEX_STREAM4_ATI = &h8770
const GL_VERTEX_STREAM5_ATI = &h8771
const GL_VERTEX_STREAM6_ATI = &h8772
const GL_VERTEX_STREAM7_ATI = &h8773
const GL_VERTEX_SOURCE_ATI = &h8774

type PFNGLVERTEXSTREAM1SATIPROC as sub(byval stream as GLenum, byval x as GLshort)
type PFNGLVERTEXSTREAM1SVATIPROC as sub(byval stream as GLenum, byval coords as const GLshort ptr)
type PFNGLVERTEXSTREAM1IATIPROC as sub(byval stream as GLenum, byval x as GLint)
type PFNGLVERTEXSTREAM1IVATIPROC as sub(byval stream as GLenum, byval coords as const GLint ptr)
type PFNGLVERTEXSTREAM1FATIPROC as sub(byval stream as GLenum, byval x as GLfloat)
type PFNGLVERTEXSTREAM1FVATIPROC as sub(byval stream as GLenum, byval coords as const GLfloat ptr)
type PFNGLVERTEXSTREAM1DATIPROC as sub(byval stream as GLenum, byval x as GLdouble)
type PFNGLVERTEXSTREAM1DVATIPROC as sub(byval stream as GLenum, byval coords as const GLdouble ptr)
type PFNGLVERTEXSTREAM2SATIPROC as sub(byval stream as GLenum, byval x as GLshort, byval y as GLshort)
type PFNGLVERTEXSTREAM2SVATIPROC as sub(byval stream as GLenum, byval coords as const GLshort ptr)
type PFNGLVERTEXSTREAM2IATIPROC as sub(byval stream as GLenum, byval x as GLint, byval y as GLint)
type PFNGLVERTEXSTREAM2IVATIPROC as sub(byval stream as GLenum, byval coords as const GLint ptr)
type PFNGLVERTEXSTREAM2FATIPROC as sub(byval stream as GLenum, byval x as GLfloat, byval y as GLfloat)
type PFNGLVERTEXSTREAM2FVATIPROC as sub(byval stream as GLenum, byval coords as const GLfloat ptr)
type PFNGLVERTEXSTREAM2DATIPROC as sub(byval stream as GLenum, byval x as GLdouble, byval y as GLdouble)
type PFNGLVERTEXSTREAM2DVATIPROC as sub(byval stream as GLenum, byval coords as const GLdouble ptr)
type PFNGLVERTEXSTREAM3SATIPROC as sub(byval stream as GLenum, byval x as GLshort, byval y as GLshort, byval z as GLshort)
type PFNGLVERTEXSTREAM3SVATIPROC as sub(byval stream as GLenum, byval coords as const GLshort ptr)
type PFNGLVERTEXSTREAM3IATIPROC as sub(byval stream as GLenum, byval x as GLint, byval y as GLint, byval z as GLint)
type PFNGLVERTEXSTREAM3IVATIPROC as sub(byval stream as GLenum, byval coords as const GLint ptr)
type PFNGLVERTEXSTREAM3FATIPROC as sub(byval stream as GLenum, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLVERTEXSTREAM3FVATIPROC as sub(byval stream as GLenum, byval coords as const GLfloat ptr)
type PFNGLVERTEXSTREAM3DATIPROC as sub(byval stream as GLenum, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLVERTEXSTREAM3DVATIPROC as sub(byval stream as GLenum, byval coords as const GLdouble ptr)
type PFNGLVERTEXSTREAM4SATIPROC as sub(byval stream as GLenum, byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
type PFNGLVERTEXSTREAM4SVATIPROC as sub(byval stream as GLenum, byval coords as const GLshort ptr)
type PFNGLVERTEXSTREAM4IATIPROC as sub(byval stream as GLenum, byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
type PFNGLVERTEXSTREAM4IVATIPROC as sub(byval stream as GLenum, byval coords as const GLint ptr)
type PFNGLVERTEXSTREAM4FATIPROC as sub(byval stream as GLenum, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
type PFNGLVERTEXSTREAM4FVATIPROC as sub(byval stream as GLenum, byval coords as const GLfloat ptr)
type PFNGLVERTEXSTREAM4DATIPROC as sub(byval stream as GLenum, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLVERTEXSTREAM4DVATIPROC as sub(byval stream as GLenum, byval coords as const GLdouble ptr)
type PFNGLNORMALSTREAM3BATIPROC as sub(byval stream as GLenum, byval nx as GLbyte, byval ny as GLbyte, byval nz as GLbyte)
type PFNGLNORMALSTREAM3BVATIPROC as sub(byval stream as GLenum, byval coords as const GLbyte ptr)
type PFNGLNORMALSTREAM3SATIPROC as sub(byval stream as GLenum, byval nx as GLshort, byval ny as GLshort, byval nz as GLshort)
type PFNGLNORMALSTREAM3SVATIPROC as sub(byval stream as GLenum, byval coords as const GLshort ptr)
type PFNGLNORMALSTREAM3IATIPROC as sub(byval stream as GLenum, byval nx as GLint, byval ny as GLint, byval nz as GLint)
type PFNGLNORMALSTREAM3IVATIPROC as sub(byval stream as GLenum, byval coords as const GLint ptr)
type PFNGLNORMALSTREAM3FATIPROC as sub(byval stream as GLenum, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat)
type PFNGLNORMALSTREAM3FVATIPROC as sub(byval stream as GLenum, byval coords as const GLfloat ptr)
type PFNGLNORMALSTREAM3DATIPROC as sub(byval stream as GLenum, byval nx as GLdouble, byval ny as GLdouble, byval nz as GLdouble)
type PFNGLNORMALSTREAM3DVATIPROC as sub(byval stream as GLenum, byval coords as const GLdouble ptr)
type PFNGLCLIENTACTIVEVERTEXSTREAMATIPROC as sub(byval stream as GLenum)
type PFNGLVERTEXBLENDENVIATIPROC as sub(byval pname as GLenum, byval param as GLint)
type PFNGLVERTEXBLENDENVFATIPROC as sub(byval pname as GLenum, byval param as GLfloat)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVertexStream1sATI(byval stream as GLenum, byval x as GLshort)
	declare sub glVertexStream1svATI(byval stream as GLenum, byval coords as const GLshort ptr)
	declare sub glVertexStream1iATI(byval stream as GLenum, byval x as GLint)
	declare sub glVertexStream1ivATI(byval stream as GLenum, byval coords as const GLint ptr)
	declare sub glVertexStream1fATI(byval stream as GLenum, byval x as GLfloat)
	declare sub glVertexStream1fvATI(byval stream as GLenum, byval coords as const GLfloat ptr)
	declare sub glVertexStream1dATI(byval stream as GLenum, byval x as GLdouble)
	declare sub glVertexStream1dvATI(byval stream as GLenum, byval coords as const GLdouble ptr)
	declare sub glVertexStream2sATI(byval stream as GLenum, byval x as GLshort, byval y as GLshort)
	declare sub glVertexStream2svATI(byval stream as GLenum, byval coords as const GLshort ptr)
	declare sub glVertexStream2iATI(byval stream as GLenum, byval x as GLint, byval y as GLint)
	declare sub glVertexStream2ivATI(byval stream as GLenum, byval coords as const GLint ptr)
	declare sub glVertexStream2fATI(byval stream as GLenum, byval x as GLfloat, byval y as GLfloat)
	declare sub glVertexStream2fvATI(byval stream as GLenum, byval coords as const GLfloat ptr)
	declare sub glVertexStream2dATI(byval stream as GLenum, byval x as GLdouble, byval y as GLdouble)
	declare sub glVertexStream2dvATI(byval stream as GLenum, byval coords as const GLdouble ptr)
	declare sub glVertexStream3sATI(byval stream as GLenum, byval x as GLshort, byval y as GLshort, byval z as GLshort)
	declare sub glVertexStream3svATI(byval stream as GLenum, byval coords as const GLshort ptr)
	declare sub glVertexStream3iATI(byval stream as GLenum, byval x as GLint, byval y as GLint, byval z as GLint)
	declare sub glVertexStream3ivATI(byval stream as GLenum, byval coords as const GLint ptr)
	declare sub glVertexStream3fATI(byval stream as GLenum, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glVertexStream3fvATI(byval stream as GLenum, byval coords as const GLfloat ptr)
	declare sub glVertexStream3dATI(byval stream as GLenum, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glVertexStream3dvATI(byval stream as GLenum, byval coords as const GLdouble ptr)
	declare sub glVertexStream4sATI(byval stream as GLenum, byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
	declare sub glVertexStream4svATI(byval stream as GLenum, byval coords as const GLshort ptr)
	declare sub glVertexStream4iATI(byval stream as GLenum, byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
	declare sub glVertexStream4ivATI(byval stream as GLenum, byval coords as const GLint ptr)
	declare sub glVertexStream4fATI(byval stream as GLenum, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
	declare sub glVertexStream4fvATI(byval stream as GLenum, byval coords as const GLfloat ptr)
	declare sub glVertexStream4dATI(byval stream as GLenum, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glVertexStream4dvATI(byval stream as GLenum, byval coords as const GLdouble ptr)
	declare sub glNormalStream3bATI(byval stream as GLenum, byval nx as GLbyte, byval ny as GLbyte, byval nz as GLbyte)
	declare sub glNormalStream3bvATI(byval stream as GLenum, byval coords as const GLbyte ptr)
	declare sub glNormalStream3sATI(byval stream as GLenum, byval nx as GLshort, byval ny as GLshort, byval nz as GLshort)
	declare sub glNormalStream3svATI(byval stream as GLenum, byval coords as const GLshort ptr)
	declare sub glNormalStream3iATI(byval stream as GLenum, byval nx as GLint, byval ny as GLint, byval nz as GLint)
	declare sub glNormalStream3ivATI(byval stream as GLenum, byval coords as const GLint ptr)
	declare sub glNormalStream3fATI(byval stream as GLenum, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat)
	declare sub glNormalStream3fvATI(byval stream as GLenum, byval coords as const GLfloat ptr)
	declare sub glNormalStream3dATI(byval stream as GLenum, byval nx as GLdouble, byval ny as GLdouble, byval nz as GLdouble)
	declare sub glNormalStream3dvATI(byval stream as GLenum, byval coords as const GLdouble ptr)
	declare sub glClientActiveVertexStreamATI(byval stream as GLenum)
	declare sub glVertexBlendEnviATI(byval pname as GLenum, byval param as GLint)
	declare sub glVertexBlendEnvfATI(byval pname as GLenum, byval param as GLfloat)
#endif

const GL_EXT_422_pixels = 1
const GL_422_EXT = &h80CC
const GL_422_REV_EXT = &h80CD
const GL_422_AVERAGE_EXT = &h80CE
const GL_422_REV_AVERAGE_EXT = &h80CF
const GL_EXT_abgr = 1
const GL_ABGR_EXT = &h8000
const GL_EXT_bindable_uniform = 1
const GL_MAX_VERTEX_BINDABLE_UNIFORMS_EXT = &h8DE2
const GL_MAX_FRAGMENT_BINDABLE_UNIFORMS_EXT = &h8DE3
const GL_MAX_GEOMETRY_BINDABLE_UNIFORMS_EXT = &h8DE4
const GL_MAX_BINDABLE_UNIFORM_SIZE_EXT = &h8DED
const GL_UNIFORM_BUFFER_EXT = &h8DEE
const GL_UNIFORM_BUFFER_BINDING_EXT = &h8DEF

type PFNGLUNIFORMBUFFEREXTPROC as sub(byval program as GLuint, byval location as GLint, byval buffer as GLuint)
type PFNGLGETUNIFORMBUFFERSIZEEXTPROC as function(byval program as GLuint, byval location as GLint) as GLint
type PFNGLGETUNIFORMOFFSETEXTPROC as function(byval program as GLuint, byval location as GLint) as GLintptr

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glUniformBufferEXT(byval program as GLuint, byval location as GLint, byval buffer as GLuint)
	declare function glGetUniformBufferSizeEXT(byval program as GLuint, byval location as GLint) as GLint
	declare function glGetUniformOffsetEXT(byval program as GLuint, byval location as GLint) as GLintptr
#endif

const GL_EXT_blend_color = 1
const GL_CONSTANT_COLOR_EXT = &h8001
const GL_ONE_MINUS_CONSTANT_COLOR_EXT = &h8002
const GL_CONSTANT_ALPHA_EXT = &h8003
const GL_ONE_MINUS_CONSTANT_ALPHA_EXT = &h8004
const GL_BLEND_COLOR_EXT = &h8005
type PFNGLBLENDCOLOREXTPROC as sub(byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat, byval alpha as GLfloat)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBlendColorEXT(byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat, byval alpha as GLfloat)
#endif

const GL_EXT_blend_equation_separate = 1
const GL_BLEND_EQUATION_RGB_EXT = &h8009
const GL_BLEND_EQUATION_ALPHA_EXT = &h883D
type PFNGLBLENDEQUATIONSEPARATEEXTPROC as sub(byval modeRGB as GLenum, byval modeAlpha as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBlendEquationSeparateEXT(byval modeRGB as GLenum, byval modeAlpha as GLenum)
#endif

const GL_EXT_blend_func_separate = 1
const GL_BLEND_DST_RGB_EXT = &h80C8
const GL_BLEND_SRC_RGB_EXT = &h80C9
const GL_BLEND_DST_ALPHA_EXT = &h80CA
const GL_BLEND_SRC_ALPHA_EXT = &h80CB
type PFNGLBLENDFUNCSEPARATEEXTPROC as sub(byval sfactorRGB as GLenum, byval dfactorRGB as GLenum, byval sfactorAlpha as GLenum, byval dfactorAlpha as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBlendFuncSeparateEXT(byval sfactorRGB as GLenum, byval dfactorRGB as GLenum, byval sfactorAlpha as GLenum, byval dfactorAlpha as GLenum)
#endif

const GL_EXT_blend_logic_op = 1
const GL_EXT_blend_minmax = 1
const GL_MIN_EXT = &h8007
const GL_MAX_EXT = &h8008
const GL_FUNC_ADD_EXT = &h8006
const GL_BLEND_EQUATION_EXT = &h8009
type PFNGLBLENDEQUATIONEXTPROC as sub(byval mode as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBlendEquationEXT(byval mode as GLenum)
#endif

const GL_EXT_blend_subtract = 1
const GL_FUNC_SUBTRACT_EXT = &h800A
const GL_FUNC_REVERSE_SUBTRACT_EXT = &h800B
const GL_EXT_clip_volume_hint = 1
const GL_CLIP_VOLUME_CLIPPING_HINT_EXT = &h80F0
const GL_EXT_cmyka = 1
const GL_CMYK_EXT = &h800C
const GL_CMYKA_EXT = &h800D
const GL_PACK_CMYK_HINT_EXT = &h800E
const GL_UNPACK_CMYK_HINT_EXT = &h800F
const GL_EXT_color_subtable = 1
type PFNGLCOLORSUBTABLEEXTPROC as sub(byval target as GLenum, byval start as GLsizei, byval count as GLsizei, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
type PFNGLCOPYCOLORSUBTABLEEXTPROC as sub(byval target as GLenum, byval start as GLsizei, byval x as GLint, byval y as GLint, byval width as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glColorSubTableEXT(byval target as GLenum, byval start as GLsizei, byval count as GLsizei, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
	declare sub glCopyColorSubTableEXT(byval target as GLenum, byval start as GLsizei, byval x as GLint, byval y as GLint, byval width as GLsizei)
#endif

const GL_EXT_compiled_vertex_array = 1
const GL_ARRAY_ELEMENT_LOCK_FIRST_EXT = &h81A8
const GL_ARRAY_ELEMENT_LOCK_COUNT_EXT = &h81A9
type PFNGLLOCKARRAYSEXTPROC as sub(byval first as GLint, byval count as GLsizei)
type PFNGLUNLOCKARRAYSEXTPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glLockArraysEXT(byval first as GLint, byval count as GLsizei)
	declare sub glUnlockArraysEXT()
#endif

const GL_EXT_convolution = 1
const GL_CONVOLUTION_1D_EXT = &h8010
const GL_CONVOLUTION_2D_EXT = &h8011
const GL_SEPARABLE_2D_EXT = &h8012
const GL_CONVOLUTION_BORDER_MODE_EXT = &h8013
const GL_CONVOLUTION_FILTER_SCALE_EXT = &h8014
const GL_CONVOLUTION_FILTER_BIAS_EXT = &h8015
const GL_REDUCE_EXT = &h8016
const GL_CONVOLUTION_FORMAT_EXT = &h8017
const GL_CONVOLUTION_WIDTH_EXT = &h8018
const GL_CONVOLUTION_HEIGHT_EXT = &h8019
const GL_MAX_CONVOLUTION_WIDTH_EXT = &h801A
const GL_MAX_CONVOLUTION_HEIGHT_EXT = &h801B
const GL_POST_CONVOLUTION_RED_SCALE_EXT = &h801C
const GL_POST_CONVOLUTION_GREEN_SCALE_EXT = &h801D
const GL_POST_CONVOLUTION_BLUE_SCALE_EXT = &h801E
const GL_POST_CONVOLUTION_ALPHA_SCALE_EXT = &h801F
const GL_POST_CONVOLUTION_RED_BIAS_EXT = &h8020
const GL_POST_CONVOLUTION_GREEN_BIAS_EXT = &h8021
const GL_POST_CONVOLUTION_BLUE_BIAS_EXT = &h8022
const GL_POST_CONVOLUTION_ALPHA_BIAS_EXT = &h8023

type PFNGLCONVOLUTIONFILTER1DEXTPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval image as const any ptr)
type PFNGLCONVOLUTIONFILTER2DEXTPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval image as const any ptr)
type PFNGLCONVOLUTIONPARAMETERFEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat)
type PFNGLCONVOLUTIONPARAMETERFVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLCONVOLUTIONPARAMETERIEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint)
type PFNGLCONVOLUTIONPARAMETERIVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLCOPYCONVOLUTIONFILTER1DEXTPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei)
type PFNGLCOPYCONVOLUTIONFILTER2DEXTPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
type PFNGLGETCONVOLUTIONFILTEREXTPROC as sub(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval image as any ptr)
type PFNGLGETCONVOLUTIONPARAMETERFVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETCONVOLUTIONPARAMETERIVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETSEPARABLEFILTEREXTPROC as sub(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval row as any ptr, byval column as any ptr, byval span as any ptr)
type PFNGLSEPARABLEFILTER2DEXTPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval row as const any ptr, byval column as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glConvolutionFilter1DEXT(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval image as const any ptr)
	declare sub glConvolutionFilter2DEXT(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval image as const any ptr)
	declare sub glConvolutionParameterfEXT(byval target as GLenum, byval pname as GLenum, byval params as GLfloat)
	declare sub glConvolutionParameterfvEXT(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glConvolutionParameteriEXT(byval target as GLenum, byval pname as GLenum, byval params as GLint)
	declare sub glConvolutionParameterivEXT(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glCopyConvolutionFilter1DEXT(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei)
	declare sub glCopyConvolutionFilter2DEXT(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
	declare sub glGetConvolutionFilterEXT(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval image as any ptr)
	declare sub glGetConvolutionParameterfvEXT(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetConvolutionParameterivEXT(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetSeparableFilterEXT(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval row as any ptr, byval column as any ptr, byval span as any ptr)
	declare sub glSeparableFilter2DEXT(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval row as const any ptr, byval column as const any ptr)
#endif

const GL_EXT_coordinate_frame = 1
const GL_TANGENT_ARRAY_EXT = &h8439
const GL_BINORMAL_ARRAY_EXT = &h843A
const GL_CURRENT_TANGENT_EXT = &h843B
const GL_CURRENT_BINORMAL_EXT = &h843C
const GL_TANGENT_ARRAY_TYPE_EXT = &h843E
const GL_TANGENT_ARRAY_STRIDE_EXT = &h843F
const GL_BINORMAL_ARRAY_TYPE_EXT = &h8440
const GL_BINORMAL_ARRAY_STRIDE_EXT = &h8441
const GL_TANGENT_ARRAY_POINTER_EXT = &h8442
const GL_BINORMAL_ARRAY_POINTER_EXT = &h8443
const GL_MAP1_TANGENT_EXT = &h8444
const GL_MAP2_TANGENT_EXT = &h8445
const GL_MAP1_BINORMAL_EXT = &h8446
const GL_MAP2_BINORMAL_EXT = &h8447

type PFNGLTANGENT3BEXTPROC as sub(byval tx as GLbyte, byval ty as GLbyte, byval tz as GLbyte)
type PFNGLTANGENT3BVEXTPROC as sub(byval v as const GLbyte ptr)
type PFNGLTANGENT3DEXTPROC as sub(byval tx as GLdouble, byval ty as GLdouble, byval tz as GLdouble)
type PFNGLTANGENT3DVEXTPROC as sub(byval v as const GLdouble ptr)
type PFNGLTANGENT3FEXTPROC as sub(byval tx as GLfloat, byval ty as GLfloat, byval tz as GLfloat)
type PFNGLTANGENT3FVEXTPROC as sub(byval v as const GLfloat ptr)
type PFNGLTANGENT3IEXTPROC as sub(byval tx as GLint, byval ty as GLint, byval tz as GLint)
type PFNGLTANGENT3IVEXTPROC as sub(byval v as const GLint ptr)
type PFNGLTANGENT3SEXTPROC as sub(byval tx as GLshort, byval ty as GLshort, byval tz as GLshort)
type PFNGLTANGENT3SVEXTPROC as sub(byval v as const GLshort ptr)
type PFNGLBINORMAL3BEXTPROC as sub(byval bx as GLbyte, byval by as GLbyte, byval bz as GLbyte)
type PFNGLBINORMAL3BVEXTPROC as sub(byval v as const GLbyte ptr)
type PFNGLBINORMAL3DEXTPROC as sub(byval bx as GLdouble, byval by as GLdouble, byval bz as GLdouble)
type PFNGLBINORMAL3DVEXTPROC as sub(byval v as const GLdouble ptr)
type PFNGLBINORMAL3FEXTPROC as sub(byval bx as GLfloat, byval by as GLfloat, byval bz as GLfloat)
type PFNGLBINORMAL3FVEXTPROC as sub(byval v as const GLfloat ptr)
type PFNGLBINORMAL3IEXTPROC as sub(byval bx as GLint, byval by as GLint, byval bz as GLint)
type PFNGLBINORMAL3IVEXTPROC as sub(byval v as const GLint ptr)
type PFNGLBINORMAL3SEXTPROC as sub(byval bx as GLshort, byval by as GLshort, byval bz as GLshort)
type PFNGLBINORMAL3SVEXTPROC as sub(byval v as const GLshort ptr)
type PFNGLTANGENTPOINTEREXTPROC as sub(byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
type PFNGLBINORMALPOINTEREXTPROC as sub(byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTangent3bEXT(byval tx as GLbyte, byval ty as GLbyte, byval tz as GLbyte)
	declare sub glTangent3bvEXT(byval v as const GLbyte ptr)
	declare sub glTangent3dEXT(byval tx as GLdouble, byval ty as GLdouble, byval tz as GLdouble)
	declare sub glTangent3dvEXT(byval v as const GLdouble ptr)
	declare sub glTangent3fEXT(byval tx as GLfloat, byval ty as GLfloat, byval tz as GLfloat)
	declare sub glTangent3fvEXT(byval v as const GLfloat ptr)
	declare sub glTangent3iEXT(byval tx as GLint, byval ty as GLint, byval tz as GLint)
	declare sub glTangent3ivEXT(byval v as const GLint ptr)
	declare sub glTangent3sEXT(byval tx as GLshort, byval ty as GLshort, byval tz as GLshort)
	declare sub glTangent3svEXT(byval v as const GLshort ptr)
	declare sub glBinormal3bEXT(byval bx as GLbyte, byval by as GLbyte, byval bz as GLbyte)
	declare sub glBinormal3bvEXT(byval v as const GLbyte ptr)
	declare sub glBinormal3dEXT(byval bx as GLdouble, byval by as GLdouble, byval bz as GLdouble)
	declare sub glBinormal3dvEXT(byval v as const GLdouble ptr)
	declare sub glBinormal3fEXT(byval bx as GLfloat, byval by as GLfloat, byval bz as GLfloat)
	declare sub glBinormal3fvEXT(byval v as const GLfloat ptr)
	declare sub glBinormal3iEXT(byval bx as GLint, byval by as GLint, byval bz as GLint)
	declare sub glBinormal3ivEXT(byval v as const GLint ptr)
	declare sub glBinormal3sEXT(byval bx as GLshort, byval by as GLshort, byval bz as GLshort)
	declare sub glBinormal3svEXT(byval v as const GLshort ptr)
	declare sub glTangentPointerEXT(byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
	declare sub glBinormalPointerEXT(byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
#endif

const GL_EXT_copy_texture = 1
type PFNGLCOPYTEXIMAGE1DEXTPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval border as GLint)
type PFNGLCOPYTEXIMAGE2DEXTPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint)
type PFNGLCOPYTEXSUBIMAGE1DEXTPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei)
type PFNGLCOPYTEXSUBIMAGE2DEXTPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
type PFNGLCOPYTEXSUBIMAGE3DEXTPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glCopyTexImage1DEXT(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval border as GLint)
	declare sub glCopyTexImage2DEXT(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint)
	declare sub glCopyTexSubImage1DEXT(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei)
	declare sub glCopyTexSubImage2DEXT(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
	declare sub glCopyTexSubImage3DEXT(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
#endif

const GL_EXT_cull_vertex = 1
const GL_CULL_VERTEX_EXT = &h81AA
const GL_CULL_VERTEX_EYE_POSITION_EXT = &h81AB
const GL_CULL_VERTEX_OBJECT_POSITION_EXT = &h81AC
type PFNGLCULLPARAMETERDVEXTPROC as sub(byval pname as GLenum, byval params as GLdouble ptr)
type PFNGLCULLPARAMETERFVEXTPROC as sub(byval pname as GLenum, byval params as GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glCullParameterdvEXT(byval pname as GLenum, byval params as GLdouble ptr)
	declare sub glCullParameterfvEXT(byval pname as GLenum, byval params as GLfloat ptr)
#endif

const GL_EXT_debug_label = 1
const GL_PROGRAM_PIPELINE_OBJECT_EXT = &h8A4F
const GL_PROGRAM_OBJECT_EXT = &h8B40
const GL_SHADER_OBJECT_EXT = &h8B48
const GL_BUFFER_OBJECT_EXT = &h9151
const GL_QUERY_OBJECT_EXT = &h9153
const GL_VERTEX_ARRAY_OBJECT_EXT = &h9154
type PFNGLLABELOBJECTEXTPROC as sub(byval type as GLenum, byval object as GLuint, byval length as GLsizei, byval label as const GLchar ptr)
type PFNGLGETOBJECTLABELEXTPROC as sub(byval type as GLenum, byval object as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval label as GLchar ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glLabelObjectEXT(byval type as GLenum, byval object as GLuint, byval length as GLsizei, byval label as const GLchar ptr)
	declare sub glGetObjectLabelEXT(byval type as GLenum, byval object as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval label as GLchar ptr)
#endif

const GL_EXT_debug_marker = 1
type PFNGLINSERTEVENTMARKEREXTPROC as sub(byval length as GLsizei, byval marker as const GLchar ptr)
type PFNGLPUSHGROUPMARKEREXTPROC as sub(byval length as GLsizei, byval marker as const GLchar ptr)
type PFNGLPOPGROUPMARKEREXTPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glInsertEventMarkerEXT(byval length as GLsizei, byval marker as const GLchar ptr)
	declare sub glPushGroupMarkerEXT(byval length as GLsizei, byval marker as const GLchar ptr)
	declare sub glPopGroupMarkerEXT()
#endif

const GL_EXT_depth_bounds_test = 1
const GL_DEPTH_BOUNDS_TEST_EXT = &h8890
const GL_DEPTH_BOUNDS_EXT = &h8891
type PFNGLDEPTHBOUNDSEXTPROC as sub(byval zmin as GLclampd, byval zmax as GLclampd)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDepthBoundsEXT(byval zmin as GLclampd, byval zmax as GLclampd)
#endif

const GL_EXT_direct_state_access = 1
const GL_PROGRAM_MATRIX_EXT = &h8E2D
const GL_TRANSPOSE_PROGRAM_MATRIX_EXT = &h8E2E
const GL_PROGRAM_MATRIX_STACK_DEPTH_EXT = &h8E2F

type PFNGLMATRIXLOADFEXTPROC as sub(byval mode as GLenum, byval m as const GLfloat ptr)
type PFNGLMATRIXLOADDEXTPROC as sub(byval mode as GLenum, byval m as const GLdouble ptr)
type PFNGLMATRIXMULTFEXTPROC as sub(byval mode as GLenum, byval m as const GLfloat ptr)
type PFNGLMATRIXMULTDEXTPROC as sub(byval mode as GLenum, byval m as const GLdouble ptr)
type PFNGLMATRIXLOADIDENTITYEXTPROC as sub(byval mode as GLenum)
type PFNGLMATRIXROTATEFEXTPROC as sub(byval mode as GLenum, byval angle as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLMATRIXROTATEDEXTPROC as sub(byval mode as GLenum, byval angle as GLdouble, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLMATRIXSCALEFEXTPROC as sub(byval mode as GLenum, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLMATRIXSCALEDEXTPROC as sub(byval mode as GLenum, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLMATRIXTRANSLATEFEXTPROC as sub(byval mode as GLenum, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLMATRIXTRANSLATEDEXTPROC as sub(byval mode as GLenum, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLMATRIXFRUSTUMEXTPROC as sub(byval mode as GLenum, byval left as GLdouble, byval right as GLdouble, byval bottom as GLdouble, byval top as GLdouble, byval zNear as GLdouble, byval zFar as GLdouble)
type PFNGLMATRIXORTHOEXTPROC as sub(byval mode as GLenum, byval left as GLdouble, byval right as GLdouble, byval bottom as GLdouble, byval top as GLdouble, byval zNear as GLdouble, byval zFar as GLdouble)
type PFNGLMATRIXPOPEXTPROC as sub(byval mode as GLenum)
type PFNGLMATRIXPUSHEXTPROC as sub(byval mode as GLenum)
type PFNGLCLIENTATTRIBDEFAULTEXTPROC as sub(byval mask as GLbitfield)
type PFNGLPUSHCLIENTATTRIBDEFAULTEXTPROC as sub(byval mask as GLbitfield)
type PFNGLTEXTUREPARAMETERFEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
type PFNGLTEXTUREPARAMETERFVEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLTEXTUREPARAMETERIEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval param as GLint)
type PFNGLTEXTUREPARAMETERIVEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLTEXTUREIMAGE1DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLTEXTUREIMAGE2DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLTEXTURESUBIMAGE1DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLTEXTURESUBIMAGE2DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLCOPYTEXTUREIMAGE1DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval border as GLint)
type PFNGLCOPYTEXTUREIMAGE2DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint)
type PFNGLCOPYTEXTURESUBIMAGE1DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei)
type PFNGLCOPYTEXTURESUBIMAGE2DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
type PFNGLGETTEXTUREIMAGEEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval format as GLenum, byval type as GLenum, byval pixels as any ptr)
type PFNGLGETTEXTUREPARAMETERFVEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETTEXTUREPARAMETERIVEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETTEXTURELEVELPARAMETERFVEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETTEXTURELEVELPARAMETERIVEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLTEXTUREIMAGE3DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLTEXTURESUBIMAGE3DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLCOPYTEXTURESUBIMAGE3DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
type PFNGLBINDMULTITEXTUREEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval texture as GLuint)
type PFNGLMULTITEXCOORDPOINTEREXTPROC as sub(byval texunit as GLenum, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
type PFNGLMULTITEXENVFEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
type PFNGLMULTITEXENVFVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLMULTITEXENVIEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval param as GLint)
type PFNGLMULTITEXENVIVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLMULTITEXGENDEXTPROC as sub(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval param as GLdouble)
type PFNGLMULTITEXGENDVEXTPROC as sub(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval params as const GLdouble ptr)
type PFNGLMULTITEXGENFEXTPROC as sub(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval param as GLfloat)
type PFNGLMULTITEXGENFVEXTPROC as sub(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLMULTITEXGENIEXTPROC as sub(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval param as GLint)
type PFNGLMULTITEXGENIVEXTPROC as sub(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLGETMULTITEXENVFVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETMULTITEXENVIVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETMULTITEXGENDVEXTPROC as sub(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval params as GLdouble ptr)
type PFNGLGETMULTITEXGENFVEXTPROC as sub(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETMULTITEXGENIVEXTPROC as sub(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLMULTITEXPARAMETERIEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval param as GLint)
type PFNGLMULTITEXPARAMETERIVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLMULTITEXPARAMETERFEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
type PFNGLMULTITEXPARAMETERFVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLMULTITEXIMAGE1DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLMULTITEXIMAGE2DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLMULTITEXSUBIMAGE1DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLMULTITEXSUBIMAGE2DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLCOPYMULTITEXIMAGE1DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval border as GLint)
type PFNGLCOPYMULTITEXIMAGE2DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint)
type PFNGLCOPYMULTITEXSUBIMAGE1DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei)
type PFNGLCOPYMULTITEXSUBIMAGE2DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
type PFNGLGETMULTITEXIMAGEEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval format as GLenum, byval type as GLenum, byval pixels as any ptr)
type PFNGLGETMULTITEXPARAMETERFVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETMULTITEXPARAMETERIVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETMULTITEXLEVELPARAMETERFVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETMULTITEXLEVELPARAMETERIVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLMULTITEXIMAGE3DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLMULTITEXSUBIMAGE3DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLCOPYMULTITEXSUBIMAGE3DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
type PFNGLENABLECLIENTSTATEINDEXEDEXTPROC as sub(byval array as GLenum, byval index as GLuint)
type PFNGLDISABLECLIENTSTATEINDEXEDEXTPROC as sub(byval array as GLenum, byval index as GLuint)
type PFNGLGETFLOATINDEXEDVEXTPROC as sub(byval target as GLenum, byval index as GLuint, byval data as GLfloat ptr)
type PFNGLGETDOUBLEINDEXEDVEXTPROC as sub(byval target as GLenum, byval index as GLuint, byval data as GLdouble ptr)
type PFNGLGETPOINTERINDEXEDVEXTPROC as sub(byval target as GLenum, byval index as GLuint, byval data as any ptr ptr)
type PFNGLENABLEINDEXEDEXTPROC as sub(byval target as GLenum, byval index as GLuint)
type PFNGLDISABLEINDEXEDEXTPROC as sub(byval target as GLenum, byval index as GLuint)
type PFNGLISENABLEDINDEXEDEXTPROC as function(byval target as GLenum, byval index as GLuint) as GLboolean
type PFNGLGETINTEGERINDEXEDVEXTPROC as sub(byval target as GLenum, byval index as GLuint, byval data as GLint ptr)
type PFNGLGETBOOLEANINDEXEDVEXTPROC as sub(byval target as GLenum, byval index as GLuint, byval data as GLboolean ptr)
type PFNGLCOMPRESSEDTEXTUREIMAGE3DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval bits as const any ptr)
type PFNGLCOMPRESSEDTEXTUREIMAGE2DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval bits as const any ptr)
type PFNGLCOMPRESSEDTEXTUREIMAGE1DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval bits as const any ptr)
type PFNGLCOMPRESSEDTEXTURESUBIMAGE3DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval bits as const any ptr)
type PFNGLCOMPRESSEDTEXTURESUBIMAGE2DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval bits as const any ptr)
type PFNGLCOMPRESSEDTEXTURESUBIMAGE1DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval bits as const any ptr)
type PFNGLGETCOMPRESSEDTEXTUREIMAGEEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval lod as GLint, byval img as any ptr)
type PFNGLCOMPRESSEDMULTITEXIMAGE3DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval bits as const any ptr)
type PFNGLCOMPRESSEDMULTITEXIMAGE2DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval bits as const any ptr)
type PFNGLCOMPRESSEDMULTITEXIMAGE1DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval bits as const any ptr)
type PFNGLCOMPRESSEDMULTITEXSUBIMAGE3DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval bits as const any ptr)
type PFNGLCOMPRESSEDMULTITEXSUBIMAGE2DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval bits as const any ptr)
type PFNGLCOMPRESSEDMULTITEXSUBIMAGE1DEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval bits as const any ptr)
type PFNGLGETCOMPRESSEDMULTITEXIMAGEEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval lod as GLint, byval img as any ptr)
type PFNGLMATRIXLOADTRANSPOSEFEXTPROC as sub(byval mode as GLenum, byval m as const GLfloat ptr)
type PFNGLMATRIXLOADTRANSPOSEDEXTPROC as sub(byval mode as GLenum, byval m as const GLdouble ptr)
type PFNGLMATRIXMULTTRANSPOSEFEXTPROC as sub(byval mode as GLenum, byval m as const GLfloat ptr)
type PFNGLMATRIXMULTTRANSPOSEDEXTPROC as sub(byval mode as GLenum, byval m as const GLdouble ptr)
type PFNGLNAMEDBUFFERDATAEXTPROC as sub(byval buffer as GLuint, byval size as GLsizeiptr, byval data as const any ptr, byval usage as GLenum)
type PFNGLNAMEDBUFFERSUBDATAEXTPROC as sub(byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr, byval data as const any ptr)
type PFNGLMAPNAMEDBUFFEREXTPROC as function(byval buffer as GLuint, byval access as GLenum) as any ptr
type PFNGLUNMAPNAMEDBUFFEREXTPROC as function(byval buffer as GLuint) as GLboolean
type PFNGLGETNAMEDBUFFERPARAMETERIVEXTPROC as sub(byval buffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETNAMEDBUFFERPOINTERVEXTPROC as sub(byval buffer as GLuint, byval pname as GLenum, byval params as any ptr ptr)
type PFNGLGETNAMEDBUFFERSUBDATAEXTPROC as sub(byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr, byval data as any ptr)
type PFNGLPROGRAMUNIFORM1FEXTPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLfloat)
type PFNGLPROGRAMUNIFORM2FEXTPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat)
type PFNGLPROGRAMUNIFORM3FEXTPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat)
type PFNGLPROGRAMUNIFORM4FEXTPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat, byval v3 as GLfloat)
type PFNGLPROGRAMUNIFORM1IEXTPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLint)
type PFNGLPROGRAMUNIFORM2IEXTPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLint, byval v1 as GLint)
type PFNGLPROGRAMUNIFORM3IEXTPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint)
type PFNGLPROGRAMUNIFORM4IEXTPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint, byval v3 as GLint)
type PFNGLPROGRAMUNIFORM1FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORM2FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORM3FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORM4FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORM1IVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLPROGRAMUNIFORM2IVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLPROGRAMUNIFORM3IVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLPROGRAMUNIFORM4IVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
type PFNGLPROGRAMUNIFORMMATRIX2FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX3FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX4FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX2X3FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX3X2FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX2X4FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX4X2FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX3X4FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLPROGRAMUNIFORMMATRIX4X3FVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
type PFNGLTEXTUREBUFFEREXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint)
type PFNGLMULTITEXBUFFEREXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint)
type PFNGLTEXTUREPARAMETERIIVEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLTEXTUREPARAMETERIUIVEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as const GLuint ptr)
type PFNGLGETTEXTUREPARAMETERIIVEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETTEXTUREPARAMETERIUIVEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as GLuint ptr)
type PFNGLMULTITEXPARAMETERIIVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLMULTITEXPARAMETERIUIVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as const GLuint ptr)
type PFNGLGETMULTITEXPARAMETERIIVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETMULTITEXPARAMETERIUIVEXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as GLuint ptr)
type PFNGLPROGRAMUNIFORM1UIEXTPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLuint)
type PFNGLPROGRAMUNIFORM2UIEXTPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLuint, byval v1 as GLuint)
type PFNGLPROGRAMUNIFORM3UIEXTPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint)
type PFNGLPROGRAMUNIFORM4UIEXTPROC as sub(byval program as GLuint, byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint, byval v3 as GLuint)
type PFNGLPROGRAMUNIFORM1UIVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLPROGRAMUNIFORM2UIVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLPROGRAMUNIFORM3UIVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLPROGRAMUNIFORM4UIVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLNAMEDPROGRAMLOCALPARAMETERS4FVEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLfloat ptr)
type PFNGLNAMEDPROGRAMLOCALPARAMETERI4IEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
type PFNGLNAMEDPROGRAMLOCALPARAMETERI4IVEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as const GLint ptr)
type PFNGLNAMEDPROGRAMLOCALPARAMETERSI4IVEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLint ptr)
type PFNGLNAMEDPROGRAMLOCALPARAMETERI4UIEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint, byval w as GLuint)
type PFNGLNAMEDPROGRAMLOCALPARAMETERI4UIVEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as const GLuint ptr)
type PFNGLNAMEDPROGRAMLOCALPARAMETERSI4UIVEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLuint ptr)
type PFNGLGETNAMEDPROGRAMLOCALPARAMETERIIVEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as GLint ptr)
type PFNGLGETNAMEDPROGRAMLOCALPARAMETERIUIVEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as GLuint ptr)
type PFNGLENABLECLIENTSTATEIEXTPROC as sub(byval array as GLenum, byval index as GLuint)
type PFNGLDISABLECLIENTSTATEIEXTPROC as sub(byval array as GLenum, byval index as GLuint)
type PFNGLGETFLOATI_VEXTPROC as sub(byval pname as GLenum, byval index as GLuint, byval params as GLfloat ptr)
type PFNGLGETDOUBLEI_VEXTPROC as sub(byval pname as GLenum, byval index as GLuint, byval params as GLdouble ptr)
type PFNGLGETPOINTERI_VEXTPROC as sub(byval pname as GLenum, byval index as GLuint, byval params as any ptr ptr)
type PFNGLNAMEDPROGRAMSTRINGEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval format as GLenum, byval len as GLsizei, byval string as const any ptr)
type PFNGLNAMEDPROGRAMLOCALPARAMETER4DEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLNAMEDPROGRAMLOCALPARAMETER4DVEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as const GLdouble ptr)
type PFNGLNAMEDPROGRAMLOCALPARAMETER4FEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
type PFNGLNAMEDPROGRAMLOCALPARAMETER4FVEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as const GLfloat ptr)
type PFNGLGETNAMEDPROGRAMLOCALPARAMETERDVEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as GLdouble ptr)
type PFNGLGETNAMEDPROGRAMLOCALPARAMETERFVEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as GLfloat ptr)
type PFNGLGETNAMEDPROGRAMIVEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETNAMEDPROGRAMSTRINGEXTPROC as sub(byval program as GLuint, byval target as GLenum, byval pname as GLenum, byval string as any ptr)
type PFNGLNAMEDRENDERBUFFERSTORAGEEXTPROC as sub(byval renderbuffer as GLuint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
type PFNGLGETNAMEDRENDERBUFFERPARAMETERIVEXTPROC as sub(byval renderbuffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC as sub(byval renderbuffer as GLuint, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
type PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLECOVERAGEEXTPROC as sub(byval renderbuffer as GLuint, byval coverageSamples as GLsizei, byval colorSamples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
type PFNGLCHECKNAMEDFRAMEBUFFERSTATUSEXTPROC as function(byval framebuffer as GLuint, byval target as GLenum) as GLenum
type PFNGLNAMEDFRAMEBUFFERTEXTURE1DEXTPROC as sub(byval framebuffer as GLuint, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint)
type PFNGLNAMEDFRAMEBUFFERTEXTURE2DEXTPROC as sub(byval framebuffer as GLuint, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint)
type PFNGLNAMEDFRAMEBUFFERTEXTURE3DEXTPROC as sub(byval framebuffer as GLuint, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint, byval zoffset as GLint)
type PFNGLNAMEDFRAMEBUFFERRENDERBUFFEREXTPROC as sub(byval framebuffer as GLuint, byval attachment as GLenum, byval renderbuffertarget as GLenum, byval renderbuffer as GLuint)
type PFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC as sub(byval framebuffer as GLuint, byval attachment as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGENERATETEXTUREMIPMAPEXTPROC as sub(byval texture as GLuint, byval target as GLenum)
type PFNGLGENERATEMULTITEXMIPMAPEXTPROC as sub(byval texunit as GLenum, byval target as GLenum)
type PFNGLFRAMEBUFFERDRAWBUFFEREXTPROC as sub(byval framebuffer as GLuint, byval mode as GLenum)
type PFNGLFRAMEBUFFERDRAWBUFFERSEXTPROC as sub(byval framebuffer as GLuint, byval n as GLsizei, byval bufs as const GLenum ptr)
type PFNGLFRAMEBUFFERREADBUFFEREXTPROC as sub(byval framebuffer as GLuint, byval mode as GLenum)
type PFNGLGETFRAMEBUFFERPARAMETERIVEXTPROC as sub(byval framebuffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLNAMEDCOPYBUFFERSUBDATAEXTPROC as sub(byval readBuffer as GLuint, byval writeBuffer as GLuint, byval readOffset as GLintptr, byval writeOffset as GLintptr, byval size as GLsizeiptr)
type PFNGLNAMEDFRAMEBUFFERTEXTUREEXTPROC as sub(byval framebuffer as GLuint, byval attachment as GLenum, byval texture as GLuint, byval level as GLint)
type PFNGLNAMEDFRAMEBUFFERTEXTURELAYEREXTPROC as sub(byval framebuffer as GLuint, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval layer as GLint)
type PFNGLNAMEDFRAMEBUFFERTEXTUREFACEEXTPROC as sub(byval framebuffer as GLuint, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval face as GLenum)
type PFNGLTEXTURERENDERBUFFEREXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval renderbuffer as GLuint)
type PFNGLMULTITEXRENDERBUFFEREXTPROC as sub(byval texunit as GLenum, byval target as GLenum, byval renderbuffer as GLuint)
type PFNGLVERTEXARRAYVERTEXOFFSETEXTPROC as sub(byval vaobj as GLuint, byval buffer as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
type PFNGLVERTEXARRAYCOLOROFFSETEXTPROC as sub(byval vaobj as GLuint, byval buffer as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
type PFNGLVERTEXARRAYEDGEFLAGOFFSETEXTPROC as sub(byval vaobj as GLuint, byval buffer as GLuint, byval stride as GLsizei, byval offset as GLintptr)
type PFNGLVERTEXARRAYINDEXOFFSETEXTPROC as sub(byval vaobj as GLuint, byval buffer as GLuint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
type PFNGLVERTEXARRAYNORMALOFFSETEXTPROC as sub(byval vaobj as GLuint, byval buffer as GLuint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
type PFNGLVERTEXARRAYTEXCOORDOFFSETEXTPROC as sub(byval vaobj as GLuint, byval buffer as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
type PFNGLVERTEXARRAYMULTITEXCOORDOFFSETEXTPROC as sub(byval vaobj as GLuint, byval buffer as GLuint, byval texunit as GLenum, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
type PFNGLVERTEXARRAYFOGCOORDOFFSETEXTPROC as sub(byval vaobj as GLuint, byval buffer as GLuint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
type PFNGLVERTEXARRAYSECONDARYCOLOROFFSETEXTPROC as sub(byval vaobj as GLuint, byval buffer as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
type PFNGLVERTEXARRAYVERTEXATTRIBOFFSETEXTPROC as sub(byval vaobj as GLuint, byval buffer as GLuint, byval index as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval stride as GLsizei, byval offset as GLintptr)
type PFNGLVERTEXARRAYVERTEXATTRIBIOFFSETEXTPROC as sub(byval vaobj as GLuint, byval buffer as GLuint, byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
type PFNGLENABLEVERTEXARRAYEXTPROC as sub(byval vaobj as GLuint, byval array as GLenum)
type PFNGLDISABLEVERTEXARRAYEXTPROC as sub(byval vaobj as GLuint, byval array as GLenum)
type PFNGLENABLEVERTEXARRAYATTRIBEXTPROC as sub(byval vaobj as GLuint, byval index as GLuint)
type PFNGLDISABLEVERTEXARRAYATTRIBEXTPROC as sub(byval vaobj as GLuint, byval index as GLuint)
type PFNGLGETVERTEXARRAYINTEGERVEXTPROC as sub(byval vaobj as GLuint, byval pname as GLenum, byval param as GLint ptr)
type PFNGLGETVERTEXARRAYPOINTERVEXTPROC as sub(byval vaobj as GLuint, byval pname as GLenum, byval param as any ptr ptr)
type PFNGLGETVERTEXARRAYINTEGERI_VEXTPROC as sub(byval vaobj as GLuint, byval index as GLuint, byval pname as GLenum, byval param as GLint ptr)
type PFNGLGETVERTEXARRAYPOINTERI_VEXTPROC as sub(byval vaobj as GLuint, byval index as GLuint, byval pname as GLenum, byval param as any ptr ptr)
type PFNGLMAPNAMEDBUFFERRANGEEXTPROC as function(byval buffer as GLuint, byval offset as GLintptr, byval length as GLsizeiptr, byval access as GLbitfield) as any ptr
type PFNGLFLUSHMAPPEDNAMEDBUFFERRANGEEXTPROC as sub(byval buffer as GLuint, byval offset as GLintptr, byval length as GLsizeiptr)
type PFNGLNAMEDBUFFERSTORAGEEXTPROC as sub(byval buffer as GLuint, byval size as GLsizeiptr, byval data as const any ptr, byval flags as GLbitfield)
type PFNGLCLEARNAMEDBUFFERDATAEXTPROC as sub(byval buffer as GLuint, byval internalformat as GLenum, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
type PFNGLCLEARNAMEDBUFFERSUBDATAEXTPROC as sub(byval buffer as GLuint, byval internalformat as GLenum, byval offset as GLsizeiptr, byval size as GLsizeiptr, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
type PFNGLNAMEDFRAMEBUFFERPARAMETERIEXTPROC as sub(byval framebuffer as GLuint, byval pname as GLenum, byval param as GLint)
type PFNGLGETNAMEDFRAMEBUFFERPARAMETERIVEXTPROC as sub(byval framebuffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLPROGRAMUNIFORM1DEXTPROC as sub(byval program as GLuint, byval location as GLint, byval x as GLdouble)
type PFNGLPROGRAMUNIFORM2DEXTPROC as sub(byval program as GLuint, byval location as GLint, byval x as GLdouble, byval y as GLdouble)
type PFNGLPROGRAMUNIFORM3DEXTPROC as sub(byval program as GLuint, byval location as GLint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLPROGRAMUNIFORM4DEXTPROC as sub(byval program as GLuint, byval location as GLint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLPROGRAMUNIFORM1DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORM2DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORM3DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORM4DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX2DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX3DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX4DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX2X3DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX2X4DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX3X2DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX3X4DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX4X2DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLPROGRAMUNIFORMMATRIX4X3DVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
type PFNGLTEXTUREBUFFERRANGEEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr)
type PFNGLTEXTURESTORAGE1DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei)
type PFNGLTEXTURESTORAGE2DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
type PFNGLTEXTURESTORAGE3DEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei)
type PFNGLTEXTURESTORAGE2DMULTISAMPLEEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval fixedsamplelocations as GLboolean)
type PFNGLTEXTURESTORAGE3DMULTISAMPLEEXTPROC as sub(byval texture as GLuint, byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedsamplelocations as GLboolean)
type PFNGLVERTEXARRAYBINDVERTEXBUFFEREXTPROC as sub(byval vaobj as GLuint, byval bindingindex as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval stride as GLsizei)
type PFNGLVERTEXARRAYVERTEXATTRIBFORMATEXTPROC as sub(byval vaobj as GLuint, byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval relativeoffset as GLuint)
type PFNGLVERTEXARRAYVERTEXATTRIBIFORMATEXTPROC as sub(byval vaobj as GLuint, byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval relativeoffset as GLuint)
type PFNGLVERTEXARRAYVERTEXATTRIBLFORMATEXTPROC as sub(byval vaobj as GLuint, byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval relativeoffset as GLuint)
type PFNGLVERTEXARRAYVERTEXATTRIBBINDINGEXTPROC as sub(byval vaobj as GLuint, byval attribindex as GLuint, byval bindingindex as GLuint)
type PFNGLVERTEXARRAYVERTEXBINDINGDIVISOREXTPROC as sub(byval vaobj as GLuint, byval bindingindex as GLuint, byval divisor as GLuint)
type PFNGLVERTEXARRAYVERTEXATTRIBLOFFSETEXTPROC as sub(byval vaobj as GLuint, byval buffer as GLuint, byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
type PFNGLTEXTUREPAGECOMMITMENTEXTPROC as sub(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval resident as GLboolean)
type PFNGLVERTEXARRAYVERTEXATTRIBDIVISOREXTPROC as sub(byval vaobj as GLuint, byval index as GLuint, byval divisor as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glMatrixLoadfEXT(byval mode as GLenum, byval m as const GLfloat ptr)
	declare sub glMatrixLoaddEXT(byval mode as GLenum, byval m as const GLdouble ptr)
	declare sub glMatrixMultfEXT(byval mode as GLenum, byval m as const GLfloat ptr)
	declare sub glMatrixMultdEXT(byval mode as GLenum, byval m as const GLdouble ptr)
	declare sub glMatrixLoadIdentityEXT(byval mode as GLenum)
	declare sub glMatrixRotatefEXT(byval mode as GLenum, byval angle as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glMatrixRotatedEXT(byval mode as GLenum, byval angle as GLdouble, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glMatrixScalefEXT(byval mode as GLenum, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glMatrixScaledEXT(byval mode as GLenum, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glMatrixTranslatefEXT(byval mode as GLenum, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glMatrixTranslatedEXT(byval mode as GLenum, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glMatrixFrustumEXT(byval mode as GLenum, byval left as GLdouble, byval right as GLdouble, byval bottom as GLdouble, byval top as GLdouble, byval zNear as GLdouble, byval zFar as GLdouble)
	declare sub glMatrixOrthoEXT(byval mode as GLenum, byval left as GLdouble, byval right as GLdouble, byval bottom as GLdouble, byval top as GLdouble, byval zNear as GLdouble, byval zFar as GLdouble)
	declare sub glMatrixPopEXT(byval mode as GLenum)
	declare sub glMatrixPushEXT(byval mode as GLenum)
	declare sub glClientAttribDefaultEXT(byval mask as GLbitfield)
	declare sub glPushClientAttribDefaultEXT(byval mask as GLbitfield)
	declare sub glTextureParameterfEXT(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
	declare sub glTextureParameterfvEXT(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glTextureParameteriEXT(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval param as GLint)
	declare sub glTextureParameterivEXT(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glTextureImage1DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glTextureImage2DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glTextureSubImage1DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glTextureSubImage2DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glCopyTextureImage1DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval border as GLint)
	declare sub glCopyTextureImage2DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint)
	declare sub glCopyTextureSubImage1DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei)
	declare sub glCopyTextureSubImage2DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
	declare sub glGetTextureImageEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval format as GLenum, byval type as GLenum, byval pixels as any ptr)
	declare sub glGetTextureParameterfvEXT(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetTextureParameterivEXT(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetTextureLevelParameterfvEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetTextureLevelParameterivEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glTextureImage3DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glTextureSubImage3DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glCopyTextureSubImage3DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
	declare sub glBindMultiTextureEXT(byval texunit as GLenum, byval target as GLenum, byval texture as GLuint)
	declare sub glMultiTexCoordPointerEXT(byval texunit as GLenum, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
	declare sub glMultiTexEnvfEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
	declare sub glMultiTexEnvfvEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glMultiTexEnviEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval param as GLint)
	declare sub glMultiTexEnvivEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glMultiTexGendEXT(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval param as GLdouble)
	declare sub glMultiTexGendvEXT(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval params as const GLdouble ptr)
	declare sub glMultiTexGenfEXT(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval param as GLfloat)
	declare sub glMultiTexGenfvEXT(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glMultiTexGeniEXT(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval param as GLint)
	declare sub glMultiTexGenivEXT(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glGetMultiTexEnvfvEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetMultiTexEnvivEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetMultiTexGendvEXT(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval params as GLdouble ptr)
	declare sub glGetMultiTexGenfvEXT(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetMultiTexGenivEXT(byval texunit as GLenum, byval coord as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glMultiTexParameteriEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval param as GLint)
	declare sub glMultiTexParameterivEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glMultiTexParameterfEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
	declare sub glMultiTexParameterfvEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glMultiTexImage1DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glMultiTexImage2DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glMultiTexSubImage1DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glMultiTexSubImage2DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glCopyMultiTexImage1DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval border as GLint)
	declare sub glCopyMultiTexImage2DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei, byval border as GLint)
	declare sub glCopyMultiTexSubImage1DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei)
	declare sub glCopyMultiTexSubImage2DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
	declare sub glGetMultiTexImageEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval format as GLenum, byval type as GLenum, byval pixels as any ptr)
	declare sub glGetMultiTexParameterfvEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetMultiTexParameterivEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetMultiTexLevelParameterfvEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetMultiTexLevelParameterivEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glMultiTexImage3DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glMultiTexSubImage3DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glCopyMultiTexSubImage3DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval x as GLint, byval y as GLint, byval width as GLsizei, byval height as GLsizei)
	declare sub glEnableClientStateIndexedEXT(byval array as GLenum, byval index as GLuint)
	declare sub glDisableClientStateIndexedEXT(byval array as GLenum, byval index as GLuint)
	declare sub glGetFloatIndexedvEXT(byval target as GLenum, byval index as GLuint, byval data as GLfloat ptr)
	declare sub glGetDoubleIndexedvEXT(byval target as GLenum, byval index as GLuint, byval data as GLdouble ptr)
	declare sub glGetPointerIndexedvEXT(byval target as GLenum, byval index as GLuint, byval data as any ptr ptr)
	declare sub glEnableIndexedEXT(byval target as GLenum, byval index as GLuint)
	declare sub glDisableIndexedEXT(byval target as GLenum, byval index as GLuint)
	declare function glIsEnabledIndexedEXT(byval target as GLenum, byval index as GLuint) as GLboolean
	declare sub glGetIntegerIndexedvEXT(byval target as GLenum, byval index as GLuint, byval data as GLint ptr)
	declare sub glGetBooleanIndexedvEXT(byval target as GLenum, byval index as GLuint, byval data as GLboolean ptr)
	declare sub glCompressedTextureImage3DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval bits as const any ptr)
	declare sub glCompressedTextureImage2DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval bits as const any ptr)
	declare sub glCompressedTextureImage1DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval bits as const any ptr)
	declare sub glCompressedTextureSubImage3DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval bits as const any ptr)
	declare sub glCompressedTextureSubImage2DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval bits as const any ptr)
	declare sub glCompressedTextureSubImage1DEXT(byval texture as GLuint, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval bits as const any ptr)
	declare sub glGetCompressedTextureImageEXT(byval texture as GLuint, byval target as GLenum, byval lod as GLint, byval img as any ptr)
	declare sub glCompressedMultiTexImage3DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval bits as const any ptr)
	declare sub glCompressedMultiTexImage2DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval bits as const any ptr)
	declare sub glCompressedMultiTexImage1DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval border as GLint, byval imageSize as GLsizei, byval bits as const any ptr)
	declare sub glCompressedMultiTexSubImage3DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval bits as const any ptr)
	declare sub glCompressedMultiTexSubImage2DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval bits as const any ptr)
	declare sub glCompressedMultiTexSubImage1DEXT(byval texunit as GLenum, byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval imageSize as GLsizei, byval bits as const any ptr)
	declare sub glGetCompressedMultiTexImageEXT(byval texunit as GLenum, byval target as GLenum, byval lod as GLint, byval img as any ptr)
	declare sub glMatrixLoadTransposefEXT(byval mode as GLenum, byval m as const GLfloat ptr)
	declare sub glMatrixLoadTransposedEXT(byval mode as GLenum, byval m as const GLdouble ptr)
	declare sub glMatrixMultTransposefEXT(byval mode as GLenum, byval m as const GLfloat ptr)
	declare sub glMatrixMultTransposedEXT(byval mode as GLenum, byval m as const GLdouble ptr)
	declare sub glNamedBufferDataEXT(byval buffer as GLuint, byval size as GLsizeiptr, byval data as const any ptr, byval usage as GLenum)
	declare sub glNamedBufferSubDataEXT(byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr, byval data as const any ptr)
	declare function glMapNamedBufferEXT(byval buffer as GLuint, byval access as GLenum) as any ptr
	declare function glUnmapNamedBufferEXT(byval buffer as GLuint) as GLboolean
	declare sub glGetNamedBufferParameterivEXT(byval buffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetNamedBufferPointervEXT(byval buffer as GLuint, byval pname as GLenum, byval params as any ptr ptr)
	declare sub glGetNamedBufferSubDataEXT(byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr, byval data as any ptr)
	declare sub glProgramUniform1fEXT(byval program as GLuint, byval location as GLint, byval v0 as GLfloat)
	declare sub glProgramUniform2fEXT(byval program as GLuint, byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat)
	declare sub glProgramUniform3fEXT(byval program as GLuint, byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat)
	declare sub glProgramUniform4fEXT(byval program as GLuint, byval location as GLint, byval v0 as GLfloat, byval v1 as GLfloat, byval v2 as GLfloat, byval v3 as GLfloat)
	declare sub glProgramUniform1iEXT(byval program as GLuint, byval location as GLint, byval v0 as GLint)
	declare sub glProgramUniform2iEXT(byval program as GLuint, byval location as GLint, byval v0 as GLint, byval v1 as GLint)
	declare sub glProgramUniform3iEXT(byval program as GLuint, byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint)
	declare sub glProgramUniform4iEXT(byval program as GLuint, byval location as GLint, byval v0 as GLint, byval v1 as GLint, byval v2 as GLint, byval v3 as GLint)
	declare sub glProgramUniform1fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glProgramUniform2fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glProgramUniform3fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glProgramUniform4fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLfloat ptr)
	declare sub glProgramUniform1ivEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glProgramUniform2ivEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glProgramUniform3ivEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glProgramUniform4ivEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLint ptr)
	declare sub glProgramUniformMatrix2fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix3fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix4fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix2x3fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix3x2fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix2x4fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix4x2fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix3x4fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glProgramUniformMatrix4x3fvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLfloat ptr)
	declare sub glTextureBufferEXT(byval texture as GLuint, byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint)
	declare sub glMultiTexBufferEXT(byval texunit as GLenum, byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint)
	declare sub glTextureParameterIivEXT(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glTextureParameterIuivEXT(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as const GLuint ptr)
	declare sub glGetTextureParameterIivEXT(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetTextureParameterIuivEXT(byval texture as GLuint, byval target as GLenum, byval pname as GLenum, byval params as GLuint ptr)
	declare sub glMultiTexParameterIivEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glMultiTexParameterIuivEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as const GLuint ptr)
	declare sub glGetMultiTexParameterIivEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetMultiTexParameterIuivEXT(byval texunit as GLenum, byval target as GLenum, byval pname as GLenum, byval params as GLuint ptr)
	declare sub glProgramUniform1uiEXT(byval program as GLuint, byval location as GLint, byval v0 as GLuint)
	declare sub glProgramUniform2uiEXT(byval program as GLuint, byval location as GLint, byval v0 as GLuint, byval v1 as GLuint)
	declare sub glProgramUniform3uiEXT(byval program as GLuint, byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint)
	declare sub glProgramUniform4uiEXT(byval program as GLuint, byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint, byval v3 as GLuint)
	declare sub glProgramUniform1uivEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glProgramUniform2uivEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glProgramUniform3uivEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glProgramUniform4uivEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glNamedProgramLocalParameters4fvEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLfloat ptr)
	declare sub glNamedProgramLocalParameterI4iEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
	declare sub glNamedProgramLocalParameterI4ivEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as const GLint ptr)
	declare sub glNamedProgramLocalParametersI4ivEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLint ptr)
	declare sub glNamedProgramLocalParameterI4uiEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint, byval w as GLuint)
	declare sub glNamedProgramLocalParameterI4uivEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as const GLuint ptr)
	declare sub glNamedProgramLocalParametersI4uivEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLuint ptr)
	declare sub glGetNamedProgramLocalParameterIivEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as GLint ptr)
	declare sub glGetNamedProgramLocalParameterIuivEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as GLuint ptr)
	declare sub glEnableClientStateiEXT(byval array as GLenum, byval index as GLuint)
	declare sub glDisableClientStateiEXT(byval array as GLenum, byval index as GLuint)
	declare sub glGetFloati_vEXT(byval pname as GLenum, byval index as GLuint, byval params as GLfloat ptr)
	declare sub glGetDoublei_vEXT(byval pname as GLenum, byval index as GLuint, byval params as GLdouble ptr)
	declare sub glGetPointeri_vEXT(byval pname as GLenum, byval index as GLuint, byval params as any ptr ptr)
	declare sub glNamedProgramStringEXT(byval program as GLuint, byval target as GLenum, byval format as GLenum, byval len as GLsizei, byval string as const any ptr)
	declare sub glNamedProgramLocalParameter4dEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glNamedProgramLocalParameter4dvEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as const GLdouble ptr)
	declare sub glNamedProgramLocalParameter4fEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
	declare sub glNamedProgramLocalParameter4fvEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as const GLfloat ptr)
	declare sub glGetNamedProgramLocalParameterdvEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as GLdouble ptr)
	declare sub glGetNamedProgramLocalParameterfvEXT(byval program as GLuint, byval target as GLenum, byval index as GLuint, byval params as GLfloat ptr)
	declare sub glGetNamedProgramivEXT(byval program as GLuint, byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetNamedProgramStringEXT(byval program as GLuint, byval target as GLenum, byval pname as GLenum, byval string as any ptr)
	declare sub glNamedRenderbufferStorageEXT(byval renderbuffer as GLuint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
	declare sub glGetNamedRenderbufferParameterivEXT(byval renderbuffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glNamedRenderbufferStorageMultisampleEXT(byval renderbuffer as GLuint, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
	declare sub glNamedRenderbufferStorageMultisampleCoverageEXT(byval renderbuffer as GLuint, byval coverageSamples as GLsizei, byval colorSamples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
	declare function glCheckNamedFramebufferStatusEXT(byval framebuffer as GLuint, byval target as GLenum) as GLenum
	declare sub glNamedFramebufferTexture1DEXT(byval framebuffer as GLuint, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint)
	declare sub glNamedFramebufferTexture2DEXT(byval framebuffer as GLuint, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint)
	declare sub glNamedFramebufferTexture3DEXT(byval framebuffer as GLuint, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint, byval zoffset as GLint)
	declare sub glNamedFramebufferRenderbufferEXT(byval framebuffer as GLuint, byval attachment as GLenum, byval renderbuffertarget as GLenum, byval renderbuffer as GLuint)
	declare sub glGetNamedFramebufferAttachmentParameterivEXT(byval framebuffer as GLuint, byval attachment as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGenerateTextureMipmapEXT(byval texture as GLuint, byval target as GLenum)
	declare sub glGenerateMultiTexMipmapEXT(byval texunit as GLenum, byval target as GLenum)
	declare sub glFramebufferDrawBufferEXT(byval framebuffer as GLuint, byval mode as GLenum)
	declare sub glFramebufferDrawBuffersEXT(byval framebuffer as GLuint, byval n as GLsizei, byval bufs as const GLenum ptr)
	declare sub glFramebufferReadBufferEXT(byval framebuffer as GLuint, byval mode as GLenum)
	declare sub glGetFramebufferParameterivEXT(byval framebuffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glNamedCopyBufferSubDataEXT(byval readBuffer as GLuint, byval writeBuffer as GLuint, byval readOffset as GLintptr, byval writeOffset as GLintptr, byval size as GLsizeiptr)
	declare sub glNamedFramebufferTextureEXT(byval framebuffer as GLuint, byval attachment as GLenum, byval texture as GLuint, byval level as GLint)
	declare sub glNamedFramebufferTextureLayerEXT(byval framebuffer as GLuint, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval layer as GLint)
	declare sub glNamedFramebufferTextureFaceEXT(byval framebuffer as GLuint, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval face as GLenum)
	declare sub glTextureRenderbufferEXT(byval texture as GLuint, byval target as GLenum, byval renderbuffer as GLuint)
	declare sub glMultiTexRenderbufferEXT(byval texunit as GLenum, byval target as GLenum, byval renderbuffer as GLuint)
	declare sub glVertexArrayVertexOffsetEXT(byval vaobj as GLuint, byval buffer as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
	declare sub glVertexArrayColorOffsetEXT(byval vaobj as GLuint, byval buffer as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
	declare sub glVertexArrayEdgeFlagOffsetEXT(byval vaobj as GLuint, byval buffer as GLuint, byval stride as GLsizei, byval offset as GLintptr)
	declare sub glVertexArrayIndexOffsetEXT(byval vaobj as GLuint, byval buffer as GLuint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
	declare sub glVertexArrayNormalOffsetEXT(byval vaobj as GLuint, byval buffer as GLuint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
	declare sub glVertexArrayTexCoordOffsetEXT(byval vaobj as GLuint, byval buffer as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
	declare sub glVertexArrayMultiTexCoordOffsetEXT(byval vaobj as GLuint, byval buffer as GLuint, byval texunit as GLenum, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
	declare sub glVertexArrayFogCoordOffsetEXT(byval vaobj as GLuint, byval buffer as GLuint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
	declare sub glVertexArraySecondaryColorOffsetEXT(byval vaobj as GLuint, byval buffer as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
	declare sub glVertexArrayVertexAttribOffsetEXT(byval vaobj as GLuint, byval buffer as GLuint, byval index as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval stride as GLsizei, byval offset as GLintptr)
	declare sub glVertexArrayVertexAttribIOffsetEXT(byval vaobj as GLuint, byval buffer as GLuint, byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
	declare sub glEnableVertexArrayEXT(byval vaobj as GLuint, byval array as GLenum)
	declare sub glDisableVertexArrayEXT(byval vaobj as GLuint, byval array as GLenum)
	declare sub glEnableVertexArrayAttribEXT(byval vaobj as GLuint, byval index as GLuint)
	declare sub glDisableVertexArrayAttribEXT(byval vaobj as GLuint, byval index as GLuint)
	declare sub glGetVertexArrayIntegervEXT(byval vaobj as GLuint, byval pname as GLenum, byval param as GLint ptr)
	declare sub glGetVertexArrayPointervEXT(byval vaobj as GLuint, byval pname as GLenum, byval param as any ptr ptr)
	declare sub glGetVertexArrayIntegeri_vEXT(byval vaobj as GLuint, byval index as GLuint, byval pname as GLenum, byval param as GLint ptr)
	declare sub glGetVertexArrayPointeri_vEXT(byval vaobj as GLuint, byval index as GLuint, byval pname as GLenum, byval param as any ptr ptr)
	declare function glMapNamedBufferRangeEXT(byval buffer as GLuint, byval offset as GLintptr, byval length as GLsizeiptr, byval access as GLbitfield) as any ptr
	declare sub glFlushMappedNamedBufferRangeEXT(byval buffer as GLuint, byval offset as GLintptr, byval length as GLsizeiptr)
	declare sub glNamedBufferStorageEXT(byval buffer as GLuint, byval size as GLsizeiptr, byval data as const any ptr, byval flags as GLbitfield)
	declare sub glClearNamedBufferDataEXT(byval buffer as GLuint, byval internalformat as GLenum, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
	declare sub glClearNamedBufferSubDataEXT(byval buffer as GLuint, byval internalformat as GLenum, byval offset as GLsizeiptr, byval size as GLsizeiptr, byval format as GLenum, byval type as GLenum, byval data as const any ptr)
	declare sub glNamedFramebufferParameteriEXT(byval framebuffer as GLuint, byval pname as GLenum, byval param as GLint)
	declare sub glGetNamedFramebufferParameterivEXT(byval framebuffer as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glProgramUniform1dEXT(byval program as GLuint, byval location as GLint, byval x as GLdouble)
	declare sub glProgramUniform2dEXT(byval program as GLuint, byval location as GLint, byval x as GLdouble, byval y as GLdouble)
	declare sub glProgramUniform3dEXT(byval program as GLuint, byval location as GLint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glProgramUniform4dEXT(byval program as GLuint, byval location as GLint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glProgramUniform1dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
	declare sub glProgramUniform2dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
	declare sub glProgramUniform3dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
	declare sub glProgramUniform4dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix2dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix3dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix4dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix2x3dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix2x4dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix3x2dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix3x4dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix4x2dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glProgramUniformMatrix4x3dvEXT(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval transpose as GLboolean, byval value as const GLdouble ptr)
	declare sub glTextureBufferRangeEXT(byval texture as GLuint, byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr)
	declare sub glTextureStorage1DEXT(byval texture as GLuint, byval target as GLenum, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei)
	declare sub glTextureStorage2DEXT(byval texture as GLuint, byval target as GLenum, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
	declare sub glTextureStorage3DEXT(byval texture as GLuint, byval target as GLenum, byval levels as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei)
	declare sub glTextureStorage2DMultisampleEXT(byval texture as GLuint, byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval fixedsamplelocations as GLboolean)
	declare sub glTextureStorage3DMultisampleEXT(byval texture as GLuint, byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedsamplelocations as GLboolean)
	declare sub glVertexArrayBindVertexBufferEXT(byval vaobj as GLuint, byval bindingindex as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval stride as GLsizei)
	declare sub glVertexArrayVertexAttribFormatEXT(byval vaobj as GLuint, byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval relativeoffset as GLuint)
	declare sub glVertexArrayVertexAttribIFormatEXT(byval vaobj as GLuint, byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval relativeoffset as GLuint)
	declare sub glVertexArrayVertexAttribLFormatEXT(byval vaobj as GLuint, byval attribindex as GLuint, byval size as GLint, byval type as GLenum, byval relativeoffset as GLuint)
	declare sub glVertexArrayVertexAttribBindingEXT(byval vaobj as GLuint, byval attribindex as GLuint, byval bindingindex as GLuint)
	declare sub glVertexArrayVertexBindingDivisorEXT(byval vaobj as GLuint, byval bindingindex as GLuint, byval divisor as GLuint)
	declare sub glVertexArrayVertexAttribLOffsetEXT(byval vaobj as GLuint, byval buffer as GLuint, byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval offset as GLintptr)
	declare sub glTexturePageCommitmentEXT(byval texture as GLuint, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval resident as GLboolean)
	declare sub glVertexArrayVertexAttribDivisorEXT(byval vaobj as GLuint, byval index as GLuint, byval divisor as GLuint)
#endif

const GL_EXT_draw_buffers2 = 1
type PFNGLCOLORMASKINDEXEDEXTPROC as sub(byval index as GLuint, byval r as GLboolean, byval g as GLboolean, byval b as GLboolean, byval a as GLboolean)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glColorMaskIndexedEXT(byval index as GLuint, byval r as GLboolean, byval g as GLboolean, byval b as GLboolean, byval a as GLboolean)
#endif

const GL_EXT_draw_instanced = 1
type PFNGLDRAWARRAYSINSTANCEDEXTPROC as sub(byval mode as GLenum, byval start as GLint, byval count as GLsizei, byval primcount as GLsizei)
type PFNGLDRAWELEMENTSINSTANCEDEXTPROC as sub(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval primcount as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDrawArraysInstancedEXT(byval mode as GLenum, byval start as GLint, byval count as GLsizei, byval primcount as GLsizei)
	declare sub glDrawElementsInstancedEXT(byval mode as GLenum, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr, byval primcount as GLsizei)
#endif

const GL_EXT_draw_range_elements = 1
const GL_MAX_ELEMENTS_VERTICES_EXT = &h80E8
const GL_MAX_ELEMENTS_INDICES_EXT = &h80E9
type PFNGLDRAWRANGEELEMENTSEXTPROC as sub(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDrawRangeElementsEXT(byval mode as GLenum, byval start as GLuint, byval end as GLuint, byval count as GLsizei, byval type as GLenum, byval indices as const any ptr)
#endif

const GL_EXT_fog_coord = 1
const GL_FOG_COORDINATE_SOURCE_EXT = &h8450
const GL_FOG_COORDINATE_EXT = &h8451
const GL_FRAGMENT_DEPTH_EXT = &h8452
const GL_CURRENT_FOG_COORDINATE_EXT = &h8453
const GL_FOG_COORDINATE_ARRAY_TYPE_EXT = &h8454
const GL_FOG_COORDINATE_ARRAY_STRIDE_EXT = &h8455
const GL_FOG_COORDINATE_ARRAY_POINTER_EXT = &h8456
const GL_FOG_COORDINATE_ARRAY_EXT = &h8457

type PFNGLFOGCOORDFEXTPROC as sub(byval coord as GLfloat)
type PFNGLFOGCOORDFVEXTPROC as sub(byval coord as const GLfloat ptr)
type PFNGLFOGCOORDDEXTPROC as sub(byval coord as GLdouble)
type PFNGLFOGCOORDDVEXTPROC as sub(byval coord as const GLdouble ptr)
type PFNGLFOGCOORDPOINTEREXTPROC as sub(byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glFogCoordfEXT(byval coord as GLfloat)
	declare sub glFogCoordfvEXT(byval coord as const GLfloat ptr)
	declare sub glFogCoorddEXT(byval coord as GLdouble)
	declare sub glFogCoorddvEXT(byval coord as const GLdouble ptr)
	declare sub glFogCoordPointerEXT(byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
#endif

const GL_EXT_framebuffer_blit = 1
const GL_READ_FRAMEBUFFER_EXT = &h8CA8
const GL_DRAW_FRAMEBUFFER_EXT = &h8CA9
const GL_DRAW_FRAMEBUFFER_BINDING_EXT = &h8CA6
const GL_READ_FRAMEBUFFER_BINDING_EXT = &h8CAA
type PFNGLBLITFRAMEBUFFEREXTPROC as sub(byval srcX0 as GLint, byval srcY0 as GLint, byval srcX1 as GLint, byval srcY1 as GLint, byval dstX0 as GLint, byval dstY0 as GLint, byval dstX1 as GLint, byval dstY1 as GLint, byval mask as GLbitfield, byval filter as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBlitFramebufferEXT(byval srcX0 as GLint, byval srcY0 as GLint, byval srcX1 as GLint, byval srcY1 as GLint, byval dstX0 as GLint, byval dstY0 as GLint, byval dstX1 as GLint, byval dstY1 as GLint, byval mask as GLbitfield, byval filter as GLenum)
#endif

const GL_EXT_framebuffer_multisample = 1
const GL_RENDERBUFFER_SAMPLES_EXT = &h8CAB
const GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_EXT = &h8D56
const GL_MAX_SAMPLES_EXT = &h8D57
type PFNGLRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC as sub(byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glRenderbufferStorageMultisampleEXT(byval target as GLenum, byval samples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
#endif

const GL_EXT_framebuffer_multisample_blit_scaled = 1
const GL_SCALED_RESOLVE_FASTEST_EXT = &h90BA
const GL_SCALED_RESOLVE_NICEST_EXT = &h90BB
const GL_EXT_framebuffer_object = 1
const GL_INVALID_FRAMEBUFFER_OPERATION_EXT = &h0506
const GL_MAX_RENDERBUFFER_SIZE_EXT = &h84E8
const GL_FRAMEBUFFER_BINDING_EXT = &h8CA6
const GL_RENDERBUFFER_BINDING_EXT = &h8CA7
const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE_EXT = &h8CD0
const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME_EXT = &h8CD1
const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL_EXT = &h8CD2
const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE_EXT = &h8CD3
const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_3D_ZOFFSET_EXT = &h8CD4
const GL_FRAMEBUFFER_COMPLETE_EXT = &h8CD5
const GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT_EXT = &h8CD6
const GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_EXT = &h8CD7
const GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_EXT = &h8CD9
const GL_FRAMEBUFFER_INCOMPLETE_FORMATS_EXT = &h8CDA
const GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER_EXT = &h8CDB
const GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER_EXT = &h8CDC
const GL_FRAMEBUFFER_UNSUPPORTED_EXT = &h8CDD
const GL_MAX_COLOR_ATTACHMENTS_EXT = &h8CDF
const GL_COLOR_ATTACHMENT0_EXT = &h8CE0
const GL_COLOR_ATTACHMENT1_EXT = &h8CE1
const GL_COLOR_ATTACHMENT2_EXT = &h8CE2
const GL_COLOR_ATTACHMENT3_EXT = &h8CE3
const GL_COLOR_ATTACHMENT4_EXT = &h8CE4
const GL_COLOR_ATTACHMENT5_EXT = &h8CE5
const GL_COLOR_ATTACHMENT6_EXT = &h8CE6
const GL_COLOR_ATTACHMENT7_EXT = &h8CE7
const GL_COLOR_ATTACHMENT8_EXT = &h8CE8
const GL_COLOR_ATTACHMENT9_EXT = &h8CE9
const GL_COLOR_ATTACHMENT10_EXT = &h8CEA
const GL_COLOR_ATTACHMENT11_EXT = &h8CEB
const GL_COLOR_ATTACHMENT12_EXT = &h8CEC
const GL_COLOR_ATTACHMENT13_EXT = &h8CED
const GL_COLOR_ATTACHMENT14_EXT = &h8CEE
const GL_COLOR_ATTACHMENT15_EXT = &h8CEF
const GL_DEPTH_ATTACHMENT_EXT = &h8D00
const GL_STENCIL_ATTACHMENT_EXT = &h8D20
const GL_FRAMEBUFFER_EXT = &h8D40
const GL_RENDERBUFFER_EXT = &h8D41
const GL_RENDERBUFFER_WIDTH_EXT = &h8D42
const GL_RENDERBUFFER_HEIGHT_EXT = &h8D43
const GL_RENDERBUFFER_INTERNAL_FORMAT_EXT = &h8D44
const GL_STENCIL_INDEX1_EXT = &h8D46
const GL_STENCIL_INDEX4_EXT = &h8D47
const GL_STENCIL_INDEX8_EXT = &h8D48
const GL_STENCIL_INDEX16_EXT = &h8D49
const GL_RENDERBUFFER_RED_SIZE_EXT = &h8D50
const GL_RENDERBUFFER_GREEN_SIZE_EXT = &h8D51
const GL_RENDERBUFFER_BLUE_SIZE_EXT = &h8D52
const GL_RENDERBUFFER_ALPHA_SIZE_EXT = &h8D53
const GL_RENDERBUFFER_DEPTH_SIZE_EXT = &h8D54
const GL_RENDERBUFFER_STENCIL_SIZE_EXT = &h8D55

type PFNGLISRENDERBUFFEREXTPROC as function(byval renderbuffer as GLuint) as GLboolean
type PFNGLBINDRENDERBUFFEREXTPROC as sub(byval target as GLenum, byval renderbuffer as GLuint)
type PFNGLDELETERENDERBUFFERSEXTPROC as sub(byval n as GLsizei, byval renderbuffers as const GLuint ptr)
type PFNGLGENRENDERBUFFERSEXTPROC as sub(byval n as GLsizei, byval renderbuffers as GLuint ptr)
type PFNGLRENDERBUFFERSTORAGEEXTPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
type PFNGLGETRENDERBUFFERPARAMETERIVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLISFRAMEBUFFEREXTPROC as function(byval framebuffer as GLuint) as GLboolean
type PFNGLBINDFRAMEBUFFEREXTPROC as sub(byval target as GLenum, byval framebuffer as GLuint)
type PFNGLDELETEFRAMEBUFFERSEXTPROC as sub(byval n as GLsizei, byval framebuffers as const GLuint ptr)
type PFNGLGENFRAMEBUFFERSEXTPROC as sub(byval n as GLsizei, byval framebuffers as GLuint ptr)
type PFNGLCHECKFRAMEBUFFERSTATUSEXTPROC as function(byval target as GLenum) as GLenum
type PFNGLFRAMEBUFFERTEXTURE1DEXTPROC as sub(byval target as GLenum, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint)
type PFNGLFRAMEBUFFERTEXTURE2DEXTPROC as sub(byval target as GLenum, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint)
type PFNGLFRAMEBUFFERTEXTURE3DEXTPROC as sub(byval target as GLenum, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint, byval zoffset as GLint)
type PFNGLFRAMEBUFFERRENDERBUFFEREXTPROC as sub(byval target as GLenum, byval attachment as GLenum, byval renderbuffertarget as GLenum, byval renderbuffer as GLuint)
type PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC as sub(byval target as GLenum, byval attachment as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGENERATEMIPMAPEXTPROC as sub(byval target as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare function glIsRenderbufferEXT(byval renderbuffer as GLuint) as GLboolean
	declare sub glBindRenderbufferEXT(byval target as GLenum, byval renderbuffer as GLuint)
	declare sub glDeleteRenderbuffersEXT(byval n as GLsizei, byval renderbuffers as const GLuint ptr)
	declare sub glGenRenderbuffersEXT(byval n as GLsizei, byval renderbuffers as GLuint ptr)
	declare sub glRenderbufferStorageEXT(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
	declare sub glGetRenderbufferParameterivEXT(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare function glIsFramebufferEXT(byval framebuffer as GLuint) as GLboolean
	declare sub glBindFramebufferEXT(byval target as GLenum, byval framebuffer as GLuint)
	declare sub glDeleteFramebuffersEXT(byval n as GLsizei, byval framebuffers as const GLuint ptr)
	declare sub glGenFramebuffersEXT(byval n as GLsizei, byval framebuffers as GLuint ptr)
	declare function glCheckFramebufferStatusEXT(byval target as GLenum) as GLenum
	declare sub glFramebufferTexture1DEXT(byval target as GLenum, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint)
	declare sub glFramebufferTexture2DEXT(byval target as GLenum, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint)
	declare sub glFramebufferTexture3DEXT(byval target as GLenum, byval attachment as GLenum, byval textarget as GLenum, byval texture as GLuint, byval level as GLint, byval zoffset as GLint)
	declare sub glFramebufferRenderbufferEXT(byval target as GLenum, byval attachment as GLenum, byval renderbuffertarget as GLenum, byval renderbuffer as GLuint)
	declare sub glGetFramebufferAttachmentParameterivEXT(byval target as GLenum, byval attachment as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGenerateMipmapEXT(byval target as GLenum)
#endif

const GL_EXT_framebuffer_sRGB = 1
const GL_FRAMEBUFFER_SRGB_EXT = &h8DB9
const GL_FRAMEBUFFER_SRGB_CAPABLE_EXT = &h8DBA
const GL_EXT_geometry_shader4 = 1
const GL_GEOMETRY_SHADER_EXT = &h8DD9
const GL_GEOMETRY_VERTICES_OUT_EXT = &h8DDA
const GL_GEOMETRY_INPUT_TYPE_EXT = &h8DDB
const GL_GEOMETRY_OUTPUT_TYPE_EXT = &h8DDC
const GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT = &h8C29
const GL_MAX_GEOMETRY_VARYING_COMPONENTS_EXT = &h8DDD
const GL_MAX_VERTEX_VARYING_COMPONENTS_EXT = &h8DDE
const GL_MAX_VARYING_COMPONENTS_EXT = &h8B4B
const GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT = &h8DDF
const GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT = &h8DE0
const GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT = &h8DE1
const GL_LINES_ADJACENCY_EXT = &h000A
const GL_LINE_STRIP_ADJACENCY_EXT = &h000B
const GL_TRIANGLES_ADJACENCY_EXT = &h000C
const GL_TRIANGLE_STRIP_ADJACENCY_EXT = &h000D
const GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_EXT = &h8DA8
const GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_EXT = &h8DA9
const GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT = &h8DA7
const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT = &h8CD4
const GL_PROGRAM_POINT_SIZE_EXT = &h8642
type PFNGLPROGRAMPARAMETERIEXTPROC as sub(byval program as GLuint, byval pname as GLenum, byval value as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glProgramParameteriEXT(byval program as GLuint, byval pname as GLenum, byval value as GLint)
#endif

const GL_EXT_gpu_program_parameters = 1
type PFNGLPROGRAMENVPARAMETERS4FVEXTPROC as sub(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLfloat ptr)
type PFNGLPROGRAMLOCALPARAMETERS4FVEXTPROC as sub(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glProgramEnvParameters4fvEXT(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLfloat ptr)
	declare sub glProgramLocalParameters4fvEXT(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLfloat ptr)
#endif

const GL_EXT_gpu_shader4 = 1
const GL_VERTEX_ATTRIB_ARRAY_INTEGER_EXT = &h88FD
const GL_SAMPLER_1D_ARRAY_EXT = &h8DC0
const GL_SAMPLER_2D_ARRAY_EXT = &h8DC1
const GL_SAMPLER_BUFFER_EXT = &h8DC2
const GL_SAMPLER_1D_ARRAY_SHADOW_EXT = &h8DC3
const GL_SAMPLER_2D_ARRAY_SHADOW_EXT = &h8DC4
const GL_SAMPLER_CUBE_SHADOW_EXT = &h8DC5
const GL_UNSIGNED_INT_VEC2_EXT = &h8DC6
const GL_UNSIGNED_INT_VEC3_EXT = &h8DC7
const GL_UNSIGNED_INT_VEC4_EXT = &h8DC8
const GL_INT_SAMPLER_1D_EXT = &h8DC9
const GL_INT_SAMPLER_2D_EXT = &h8DCA
const GL_INT_SAMPLER_3D_EXT = &h8DCB
const GL_INT_SAMPLER_CUBE_EXT = &h8DCC
const GL_INT_SAMPLER_2D_RECT_EXT = &h8DCD
const GL_INT_SAMPLER_1D_ARRAY_EXT = &h8DCE
const GL_INT_SAMPLER_2D_ARRAY_EXT = &h8DCF
const GL_INT_SAMPLER_BUFFER_EXT = &h8DD0
const GL_UNSIGNED_INT_SAMPLER_1D_EXT = &h8DD1
const GL_UNSIGNED_INT_SAMPLER_2D_EXT = &h8DD2
const GL_UNSIGNED_INT_SAMPLER_3D_EXT = &h8DD3
const GL_UNSIGNED_INT_SAMPLER_CUBE_EXT = &h8DD4
const GL_UNSIGNED_INT_SAMPLER_2D_RECT_EXT = &h8DD5
const GL_UNSIGNED_INT_SAMPLER_1D_ARRAY_EXT = &h8DD6
const GL_UNSIGNED_INT_SAMPLER_2D_ARRAY_EXT = &h8DD7
const GL_UNSIGNED_INT_SAMPLER_BUFFER_EXT = &h8DD8
const GL_MIN_PROGRAM_TEXEL_OFFSET_EXT = &h8904
const GL_MAX_PROGRAM_TEXEL_OFFSET_EXT = &h8905

type PFNGLGETUNIFORMUIVEXTPROC as sub(byval program as GLuint, byval location as GLint, byval params as GLuint ptr)
type PFNGLBINDFRAGDATALOCATIONEXTPROC as sub(byval program as GLuint, byval color as GLuint, byval name as const GLchar ptr)
type PFNGLGETFRAGDATALOCATIONEXTPROC as function(byval program as GLuint, byval name as const GLchar ptr) as GLint
type PFNGLUNIFORM1UIEXTPROC as sub(byval location as GLint, byval v0 as GLuint)
type PFNGLUNIFORM2UIEXTPROC as sub(byval location as GLint, byval v0 as GLuint, byval v1 as GLuint)
type PFNGLUNIFORM3UIEXTPROC as sub(byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint)
type PFNGLUNIFORM4UIEXTPROC as sub(byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint, byval v3 as GLuint)
type PFNGLUNIFORM1UIVEXTPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLUNIFORM2UIVEXTPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLUNIFORM3UIVEXTPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
type PFNGLUNIFORM4UIVEXTPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGetUniformuivEXT(byval program as GLuint, byval location as GLint, byval params as GLuint ptr)
	declare sub glBindFragDataLocationEXT(byval program as GLuint, byval color as GLuint, byval name as const GLchar ptr)
	declare function glGetFragDataLocationEXT(byval program as GLuint, byval name as const GLchar ptr) as GLint
	declare sub glUniform1uiEXT(byval location as GLint, byval v0 as GLuint)
	declare sub glUniform2uiEXT(byval location as GLint, byval v0 as GLuint, byval v1 as GLuint)
	declare sub glUniform3uiEXT(byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint)
	declare sub glUniform4uiEXT(byval location as GLint, byval v0 as GLuint, byval v1 as GLuint, byval v2 as GLuint, byval v3 as GLuint)
	declare sub glUniform1uivEXT(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glUniform2uivEXT(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glUniform3uivEXT(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
	declare sub glUniform4uivEXT(byval location as GLint, byval count as GLsizei, byval value as const GLuint ptr)
#endif

const GL_EXT_histogram = 1
const GL_HISTOGRAM_EXT = &h8024
const GL_PROXY_HISTOGRAM_EXT = &h8025
const GL_HISTOGRAM_WIDTH_EXT = &h8026
const GL_HISTOGRAM_FORMAT_EXT = &h8027
const GL_HISTOGRAM_RED_SIZE_EXT = &h8028
const GL_HISTOGRAM_GREEN_SIZE_EXT = &h8029
const GL_HISTOGRAM_BLUE_SIZE_EXT = &h802A
const GL_HISTOGRAM_ALPHA_SIZE_EXT = &h802B
const GL_HISTOGRAM_LUMINANCE_SIZE_EXT = &h802C
const GL_HISTOGRAM_SINK_EXT = &h802D
const GL_MINMAX_EXT = &h802E
const GL_MINMAX_FORMAT_EXT = &h802F
const GL_MINMAX_SINK_EXT = &h8030
const GL_TABLE_TOO_LARGE_EXT = &h8031

type PFNGLGETHISTOGRAMEXTPROC as sub(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval values as any ptr)
type PFNGLGETHISTOGRAMPARAMETERFVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETHISTOGRAMPARAMETERIVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETMINMAXEXTPROC as sub(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval values as any ptr)
type PFNGLGETMINMAXPARAMETERFVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETMINMAXPARAMETERIVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLHISTOGRAMEXTPROC as sub(byval target as GLenum, byval width as GLsizei, byval internalformat as GLenum, byval sink as GLboolean)
type PFNGLMINMAXEXTPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval sink as GLboolean)
type PFNGLRESETHISTOGRAMEXTPROC as sub(byval target as GLenum)
type PFNGLRESETMINMAXEXTPROC as sub(byval target as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGetHistogramEXT(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval values as any ptr)
	declare sub glGetHistogramParameterfvEXT(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetHistogramParameterivEXT(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetMinmaxEXT(byval target as GLenum, byval reset as GLboolean, byval format as GLenum, byval type as GLenum, byval values as any ptr)
	declare sub glGetMinmaxParameterfvEXT(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetMinmaxParameterivEXT(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glHistogramEXT(byval target as GLenum, byval width as GLsizei, byval internalformat as GLenum, byval sink as GLboolean)
	declare sub glMinmaxEXT(byval target as GLenum, byval internalformat as GLenum, byval sink as GLboolean)
	declare sub glResetHistogramEXT(byval target as GLenum)
	declare sub glResetMinmaxEXT(byval target as GLenum)
#endif

const GL_EXT_index_array_formats = 1
const GL_IUI_V2F_EXT = &h81AD
const GL_IUI_V3F_EXT = &h81AE
const GL_IUI_N3F_V2F_EXT = &h81AF
const GL_IUI_N3F_V3F_EXT = &h81B0
const GL_T2F_IUI_V2F_EXT = &h81B1
const GL_T2F_IUI_V3F_EXT = &h81B2
const GL_T2F_IUI_N3F_V2F_EXT = &h81B3
const GL_T2F_IUI_N3F_V3F_EXT = &h81B4
const GL_EXT_index_func = 1
const GL_INDEX_TEST_EXT = &h81B5
const GL_INDEX_TEST_FUNC_EXT = &h81B6
const GL_INDEX_TEST_REF_EXT = &h81B7
type PFNGLINDEXFUNCEXTPROC as sub(byval func as GLenum, byval ref as GLclampf)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glIndexFuncEXT(byval func as GLenum, byval ref as GLclampf)
#endif

const GL_EXT_index_material = 1
const GL_INDEX_MATERIAL_EXT = &h81B8
const GL_INDEX_MATERIAL_PARAMETER_EXT = &h81B9
const GL_INDEX_MATERIAL_FACE_EXT = &h81BA
type PFNGLINDEXMATERIALEXTPROC as sub(byval face as GLenum, byval mode as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glIndexMaterialEXT(byval face as GLenum, byval mode as GLenum)
#endif

const GL_EXT_index_texture = 1
const GL_EXT_light_texture = 1
const GL_FRAGMENT_MATERIAL_EXT = &h8349
const GL_FRAGMENT_NORMAL_EXT = &h834A
const GL_FRAGMENT_COLOR_EXT = &h834C
const GL_ATTENUATION_EXT = &h834D
const GL_SHADOW_ATTENUATION_EXT = &h834E
const GL_TEXTURE_APPLICATION_MODE_EXT = &h834F
const GL_TEXTURE_LIGHT_EXT = &h8350
const GL_TEXTURE_MATERIAL_FACE_EXT = &h8351
const GL_TEXTURE_MATERIAL_PARAMETER_EXT = &h8352

type PFNGLAPPLYTEXTUREEXTPROC as sub(byval mode as GLenum)
type PFNGLTEXTURELIGHTEXTPROC as sub(byval pname as GLenum)
type PFNGLTEXTUREMATERIALEXTPROC as sub(byval face as GLenum, byval mode as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glApplyTextureEXT(byval mode as GLenum)
	declare sub glTextureLightEXT(byval pname as GLenum)
	declare sub glTextureMaterialEXT(byval face as GLenum, byval mode as GLenum)
#endif

const GL_EXT_misc_attribute = 1
const GL_EXT_multi_draw_arrays = 1
type PFNGLMULTIDRAWARRAYSEXTPROC as sub(byval mode as GLenum, byval first as const GLint ptr, byval count as const GLsizei ptr, byval primcount as GLsizei)
type PFNGLMULTIDRAWELEMENTSEXTPROC as sub(byval mode as GLenum, byval count as const GLsizei ptr, byval type as GLenum, byval indices as const any const ptr ptr, byval primcount as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glMultiDrawArraysEXT(byval mode as GLenum, byval first as const GLint ptr, byval count as const GLsizei ptr, byval primcount as GLsizei)
	declare sub glMultiDrawElementsEXT(byval mode as GLenum, byval count as const GLsizei ptr, byval type as GLenum, byval indices as const any const ptr ptr, byval primcount as GLsizei)
#endif

const GL_EXT_multisample = 1
const GL_MULTISAMPLE_EXT = &h809D
const GL_SAMPLE_ALPHA_TO_MASK_EXT = &h809E
const GL_SAMPLE_ALPHA_TO_ONE_EXT = &h809F
const GL_SAMPLE_MASK_EXT = &h80A0
const GL_1PASS_EXT = &h80A1
const GL_2PASS_0_EXT = &h80A2
const GL_2PASS_1_EXT = &h80A3
const GL_4PASS_0_EXT = &h80A4
const GL_4PASS_1_EXT = &h80A5
const GL_4PASS_2_EXT = &h80A6
const GL_4PASS_3_EXT = &h80A7
const GL_SAMPLE_BUFFERS_EXT = &h80A8
const GL_SAMPLES_EXT = &h80A9
const GL_SAMPLE_MASK_VALUE_EXT = &h80AA
const GL_SAMPLE_MASK_INVERT_EXT = &h80AB
const GL_SAMPLE_PATTERN_EXT = &h80AC
const GL_MULTISAMPLE_BIT_EXT = &h20000000
type PFNGLSAMPLEMASKEXTPROC as sub(byval value as GLclampf, byval invert as GLboolean)
type PFNGLSAMPLEPATTERNEXTPROC as sub(byval pattern as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glSampleMaskEXT(byval value as GLclampf, byval invert as GLboolean)
	declare sub glSamplePatternEXT(byval pattern as GLenum)
#endif

const GL_EXT_packed_depth_stencil = 1
const GL_DEPTH_STENCIL_EXT = &h84F9
const GL_UNSIGNED_INT_24_8_EXT = &h84FA
const GL_DEPTH24_STENCIL8_EXT = &h88F0
const GL_TEXTURE_STENCIL_SIZE_EXT = &h88F1
const GL_EXT_packed_float = 1
const GL_R11F_G11F_B10F_EXT = &h8C3A
const GL_UNSIGNED_INT_10F_11F_11F_REV_EXT = &h8C3B
const GL_RGBA_SIGNED_COMPONENTS_EXT = &h8C3C
const GL_EXT_packed_pixels = 1
const GL_UNSIGNED_BYTE_3_3_2_EXT = &h8032
const GL_UNSIGNED_SHORT_4_4_4_4_EXT = &h8033
const GL_UNSIGNED_SHORT_5_5_5_1_EXT = &h8034
const GL_UNSIGNED_INT_8_8_8_8_EXT = &h8035
const GL_UNSIGNED_INT_10_10_10_2_EXT = &h8036
const GL_EXT_pixel_buffer_object = 1
const GL_PIXEL_PACK_BUFFER_EXT = &h88EB
const GL_PIXEL_UNPACK_BUFFER_EXT = &h88EC
const GL_PIXEL_PACK_BUFFER_BINDING_EXT = &h88ED
const GL_PIXEL_UNPACK_BUFFER_BINDING_EXT = &h88EF
const GL_EXT_pixel_transform = 1
const GL_PIXEL_TRANSFORM_2D_EXT = &h8330
const GL_PIXEL_MAG_FILTER_EXT = &h8331
const GL_PIXEL_MIN_FILTER_EXT = &h8332
const GL_PIXEL_CUBIC_WEIGHT_EXT = &h8333
const GL_CUBIC_EXT = &h8334
const GL_AVERAGE_EXT = &h8335
const GL_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT = &h8336
const GL_MAX_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT = &h8337
const GL_PIXEL_TRANSFORM_2D_MATRIX_EXT = &h8338

type PFNGLPIXELTRANSFORMPARAMETERIEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval param as GLint)
type PFNGLPIXELTRANSFORMPARAMETERFEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
type PFNGLPIXELTRANSFORMPARAMETERIVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLPIXELTRANSFORMPARAMETERFVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLGETPIXELTRANSFORMPARAMETERIVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETPIXELTRANSFORMPARAMETERFVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPixelTransformParameteriEXT(byval target as GLenum, byval pname as GLenum, byval param as GLint)
	declare sub glPixelTransformParameterfEXT(byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
	declare sub glPixelTransformParameterivEXT(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glPixelTransformParameterfvEXT(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glGetPixelTransformParameterivEXT(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetPixelTransformParameterfvEXT(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
#endif

const GL_EXT_pixel_transform_color_table = 1
const GL_EXT_point_parameters = 1
const GL_POINT_SIZE_MIN_EXT = &h8126
const GL_POINT_SIZE_MAX_EXT = &h8127
const GL_POINT_FADE_THRESHOLD_SIZE_EXT = &h8128
const GL_DISTANCE_ATTENUATION_EXT = &h8129
type PFNGLPOINTPARAMETERFEXTPROC as sub(byval pname as GLenum, byval param as GLfloat)
type PFNGLPOINTPARAMETERFVEXTPROC as sub(byval pname as GLenum, byval params as const GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPointParameterfEXT(byval pname as GLenum, byval param as GLfloat)
	declare sub glPointParameterfvEXT(byval pname as GLenum, byval params as const GLfloat ptr)
#endif

const GL_EXT_polygon_offset = 1
const GL_POLYGON_OFFSET_EXT = &h8037
const GL_POLYGON_OFFSET_FACTOR_EXT = &h8038
const GL_POLYGON_OFFSET_BIAS_EXT = &h8039
type PFNGLPOLYGONOFFSETEXTPROC as sub(byval factor as GLfloat, byval bias as GLfloat)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPolygonOffsetEXT(byval factor as GLfloat, byval bias as GLfloat)
#endif

const GL_EXT_polygon_offset_clamp = 1
const GL_POLYGON_OFFSET_CLAMP_EXT = &h8E1B
type PFNGLPOLYGONOFFSETCLAMPEXTPROC as sub(byval factor as GLfloat, byval units as GLfloat, byval clamp as GLfloat)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPolygonOffsetClampEXT(byval factor as GLfloat, byval units as GLfloat, byval clamp as GLfloat)
#endif

const GL_EXT_post_depth_coverage = 1
const GL_EXT_provoking_vertex = 1
const GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION_EXT = &h8E4C
const GL_FIRST_VERTEX_CONVENTION_EXT = &h8E4D
const GL_LAST_VERTEX_CONVENTION_EXT = &h8E4E
const GL_PROVOKING_VERTEX_EXT = &h8E4F
type PFNGLPROVOKINGVERTEXEXTPROC as sub(byval mode as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glProvokingVertexEXT(byval mode as GLenum)
#endif

const GL_EXT_raster_multisample = 1
const GL_RASTER_MULTISAMPLE_EXT = &h9327
const GL_RASTER_SAMPLES_EXT = &h9328
const GL_MAX_RASTER_SAMPLES_EXT = &h9329
const GL_RASTER_FIXED_SAMPLE_LOCATIONS_EXT = &h932A
const GL_MULTISAMPLE_RASTERIZATION_ALLOWED_EXT = &h932B
const GL_EFFECTIVE_RASTER_SAMPLES_EXT = &h932C
type PFNGLRASTERSAMPLESEXTPROC as sub(byval samples as GLuint, byval fixedsamplelocations as GLboolean)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glRasterSamplesEXT(byval samples as GLuint, byval fixedsamplelocations as GLboolean)
#endif

const GL_EXT_rescale_normal = 1
const GL_RESCALE_NORMAL_EXT = &h803A
const GL_EXT_secondary_color = 1
const GL_COLOR_SUM_EXT = &h8458
const GL_CURRENT_SECONDARY_COLOR_EXT = &h8459
const GL_SECONDARY_COLOR_ARRAY_SIZE_EXT = &h845A
const GL_SECONDARY_COLOR_ARRAY_TYPE_EXT = &h845B
const GL_SECONDARY_COLOR_ARRAY_STRIDE_EXT = &h845C
const GL_SECONDARY_COLOR_ARRAY_POINTER_EXT = &h845D
const GL_SECONDARY_COLOR_ARRAY_EXT = &h845E

type PFNGLSECONDARYCOLOR3BEXTPROC as sub(byval red as GLbyte, byval green as GLbyte, byval blue as GLbyte)
type PFNGLSECONDARYCOLOR3BVEXTPROC as sub(byval v as const GLbyte ptr)
type PFNGLSECONDARYCOLOR3DEXTPROC as sub(byval red as GLdouble, byval green as GLdouble, byval blue as GLdouble)
type PFNGLSECONDARYCOLOR3DVEXTPROC as sub(byval v as const GLdouble ptr)
type PFNGLSECONDARYCOLOR3FEXTPROC as sub(byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat)
type PFNGLSECONDARYCOLOR3FVEXTPROC as sub(byval v as const GLfloat ptr)
type PFNGLSECONDARYCOLOR3IEXTPROC as sub(byval red as GLint, byval green as GLint, byval blue as GLint)
type PFNGLSECONDARYCOLOR3IVEXTPROC as sub(byval v as const GLint ptr)
type PFNGLSECONDARYCOLOR3SEXTPROC as sub(byval red as GLshort, byval green as GLshort, byval blue as GLshort)
type PFNGLSECONDARYCOLOR3SVEXTPROC as sub(byval v as const GLshort ptr)
type PFNGLSECONDARYCOLOR3UBEXTPROC as sub(byval red as GLubyte, byval green as GLubyte, byval blue as GLubyte)
type PFNGLSECONDARYCOLOR3UBVEXTPROC as sub(byval v as const GLubyte ptr)
type PFNGLSECONDARYCOLOR3UIEXTPROC as sub(byval red as GLuint, byval green as GLuint, byval blue as GLuint)
type PFNGLSECONDARYCOLOR3UIVEXTPROC as sub(byval v as const GLuint ptr)
type PFNGLSECONDARYCOLOR3USEXTPROC as sub(byval red as GLushort, byval green as GLushort, byval blue as GLushort)
type PFNGLSECONDARYCOLOR3USVEXTPROC as sub(byval v as const GLushort ptr)
type PFNGLSECONDARYCOLORPOINTEREXTPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glSecondaryColor3bEXT(byval red as GLbyte, byval green as GLbyte, byval blue as GLbyte)
	declare sub glSecondaryColor3bvEXT(byval v as const GLbyte ptr)
	declare sub glSecondaryColor3dEXT(byval red as GLdouble, byval green as GLdouble, byval blue as GLdouble)
	declare sub glSecondaryColor3dvEXT(byval v as const GLdouble ptr)
	declare sub glSecondaryColor3fEXT(byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat)
	declare sub glSecondaryColor3fvEXT(byval v as const GLfloat ptr)
	declare sub glSecondaryColor3iEXT(byval red as GLint, byval green as GLint, byval blue as GLint)
	declare sub glSecondaryColor3ivEXT(byval v as const GLint ptr)
	declare sub glSecondaryColor3sEXT(byval red as GLshort, byval green as GLshort, byval blue as GLshort)
	declare sub glSecondaryColor3svEXT(byval v as const GLshort ptr)
	declare sub glSecondaryColor3ubEXT(byval red as GLubyte, byval green as GLubyte, byval blue as GLubyte)
	declare sub glSecondaryColor3ubvEXT(byval v as const GLubyte ptr)
	declare sub glSecondaryColor3uiEXT(byval red as GLuint, byval green as GLuint, byval blue as GLuint)
	declare sub glSecondaryColor3uivEXT(byval v as const GLuint ptr)
	declare sub glSecondaryColor3usEXT(byval red as GLushort, byval green as GLushort, byval blue as GLushort)
	declare sub glSecondaryColor3usvEXT(byval v as const GLushort ptr)
	declare sub glSecondaryColorPointerEXT(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
#endif

const GL_EXT_separate_shader_objects = 1
const GL_ACTIVE_PROGRAM_EXT = &h8B8D
type PFNGLUSESHADERPROGRAMEXTPROC as sub(byval type as GLenum, byval program as GLuint)
type PFNGLACTIVEPROGRAMEXTPROC as sub(byval program as GLuint)
type PFNGLCREATESHADERPROGRAMEXTPROC as function(byval type as GLenum, byval string as const GLchar ptr) as GLuint

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glUseShaderProgramEXT(byval type as GLenum, byval program as GLuint)
	declare sub glActiveProgramEXT(byval program as GLuint)
	declare function glCreateShaderProgramEXT(byval type as GLenum, byval string as const GLchar ptr) as GLuint
#endif

const GL_EXT_separate_specular_color = 1
const GL_LIGHT_MODEL_COLOR_CONTROL_EXT = &h81F8
const GL_SINGLE_COLOR_EXT = &h81F9
const GL_SEPARATE_SPECULAR_COLOR_EXT = &h81FA
const GL_EXT_shader_image_load_formatted = 1
const GL_EXT_shader_image_load_store = 1
const GL_MAX_IMAGE_UNITS_EXT = &h8F38
const GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS_EXT = &h8F39
const GL_IMAGE_BINDING_NAME_EXT = &h8F3A
const GL_IMAGE_BINDING_LEVEL_EXT = &h8F3B
const GL_IMAGE_BINDING_LAYERED_EXT = &h8F3C
const GL_IMAGE_BINDING_LAYER_EXT = &h8F3D
const GL_IMAGE_BINDING_ACCESS_EXT = &h8F3E
const GL_IMAGE_1D_EXT = &h904C
const GL_IMAGE_2D_EXT = &h904D
const GL_IMAGE_3D_EXT = &h904E
const GL_IMAGE_2D_RECT_EXT = &h904F
const GL_IMAGE_CUBE_EXT = &h9050
const GL_IMAGE_BUFFER_EXT = &h9051
const GL_IMAGE_1D_ARRAY_EXT = &h9052
const GL_IMAGE_2D_ARRAY_EXT = &h9053
const GL_IMAGE_CUBE_MAP_ARRAY_EXT = &h9054
const GL_IMAGE_2D_MULTISAMPLE_EXT = &h9055
const GL_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = &h9056
const GL_INT_IMAGE_1D_EXT = &h9057
const GL_INT_IMAGE_2D_EXT = &h9058
const GL_INT_IMAGE_3D_EXT = &h9059
const GL_INT_IMAGE_2D_RECT_EXT = &h905A
const GL_INT_IMAGE_CUBE_EXT = &h905B
const GL_INT_IMAGE_BUFFER_EXT = &h905C
const GL_INT_IMAGE_1D_ARRAY_EXT = &h905D
const GL_INT_IMAGE_2D_ARRAY_EXT = &h905E
const GL_INT_IMAGE_CUBE_MAP_ARRAY_EXT = &h905F
const GL_INT_IMAGE_2D_MULTISAMPLE_EXT = &h9060
const GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = &h9061
const GL_UNSIGNED_INT_IMAGE_1D_EXT = &h9062
const GL_UNSIGNED_INT_IMAGE_2D_EXT = &h9063
const GL_UNSIGNED_INT_IMAGE_3D_EXT = &h9064
const GL_UNSIGNED_INT_IMAGE_2D_RECT_EXT = &h9065
const GL_UNSIGNED_INT_IMAGE_CUBE_EXT = &h9066
const GL_UNSIGNED_INT_IMAGE_BUFFER_EXT = &h9067
const GL_UNSIGNED_INT_IMAGE_1D_ARRAY_EXT = &h9068
const GL_UNSIGNED_INT_IMAGE_2D_ARRAY_EXT = &h9069
const GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY_EXT = &h906A
const GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_EXT = &h906B
const GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT = &h906C
const GL_MAX_IMAGE_SAMPLES_EXT = &h906D
const GL_IMAGE_BINDING_FORMAT_EXT = &h906E
const GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT_EXT = &h00000001
const GL_ELEMENT_ARRAY_BARRIER_BIT_EXT = &h00000002
const GL_UNIFORM_BARRIER_BIT_EXT = &h00000004
const GL_TEXTURE_FETCH_BARRIER_BIT_EXT = &h00000008
const GL_SHADER_IMAGE_ACCESS_BARRIER_BIT_EXT = &h00000020
const GL_COMMAND_BARRIER_BIT_EXT = &h00000040
const GL_PIXEL_BUFFER_BARRIER_BIT_EXT = &h00000080
const GL_TEXTURE_UPDATE_BARRIER_BIT_EXT = &h00000100
const GL_BUFFER_UPDATE_BARRIER_BIT_EXT = &h00000200
const GL_FRAMEBUFFER_BARRIER_BIT_EXT = &h00000400
const GL_TRANSFORM_FEEDBACK_BARRIER_BIT_EXT = &h00000800
const GL_ATOMIC_COUNTER_BARRIER_BIT_EXT = &h00001000
const GL_ALL_BARRIER_BITS_EXT = &hFFFFFFFF
type PFNGLBINDIMAGETEXTUREEXTPROC as sub(byval index as GLuint, byval texture as GLuint, byval level as GLint, byval layered as GLboolean, byval layer as GLint, byval access as GLenum, byval format as GLint)
type PFNGLMEMORYBARRIEREXTPROC as sub(byval barriers as GLbitfield)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBindImageTextureEXT(byval index as GLuint, byval texture as GLuint, byval level as GLint, byval layered as GLboolean, byval layer as GLint, byval access as GLenum, byval format as GLint)
	declare sub glMemoryBarrierEXT(byval barriers as GLbitfield)
#endif

const GL_EXT_shader_integer_mix = 1
const GL_EXT_shadow_funcs = 1
const GL_EXT_shared_texture_palette = 1
const GL_SHARED_TEXTURE_PALETTE_EXT = &h81FB
const GL_EXT_sparse_texture2 = 1
const GL_EXT_stencil_clear_tag = 1
const GL_STENCIL_TAG_BITS_EXT = &h88F2
const GL_STENCIL_CLEAR_TAG_VALUE_EXT = &h88F3
type PFNGLSTENCILCLEARTAGEXTPROC as sub(byval stencilTagBits as GLsizei, byval stencilClearTag as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glStencilClearTagEXT(byval stencilTagBits as GLsizei, byval stencilClearTag as GLuint)
#endif

const GL_EXT_stencil_two_side = 1
const GL_STENCIL_TEST_TWO_SIDE_EXT = &h8910
const GL_ACTIVE_STENCIL_FACE_EXT = &h8911
type PFNGLACTIVESTENCILFACEEXTPROC as sub(byval face as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glActiveStencilFaceEXT(byval face as GLenum)
#endif

const GL_EXT_stencil_wrap = 1
const GL_INCR_WRAP_EXT = &h8507
const GL_DECR_WRAP_EXT = &h8508
const GL_EXT_subtexture = 1
type PFNGLTEXSUBIMAGE1DEXTPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLTEXSUBIMAGE2DEXTPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTexSubImage1DEXT(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glTexSubImage2DEXT(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
#endif

const GL_EXT_texture = 1
const GL_ALPHA4_EXT = &h803B
const GL_ALPHA8_EXT = &h803C
const GL_ALPHA12_EXT = &h803D
const GL_ALPHA16_EXT = &h803E
const GL_LUMINANCE4_EXT = &h803F
const GL_LUMINANCE8_EXT = &h8040
const GL_LUMINANCE12_EXT = &h8041
const GL_LUMINANCE16_EXT = &h8042
const GL_LUMINANCE4_ALPHA4_EXT = &h8043
const GL_LUMINANCE6_ALPHA2_EXT = &h8044
const GL_LUMINANCE8_ALPHA8_EXT = &h8045
const GL_LUMINANCE12_ALPHA4_EXT = &h8046
const GL_LUMINANCE12_ALPHA12_EXT = &h8047
const GL_LUMINANCE16_ALPHA16_EXT = &h8048
const GL_INTENSITY_EXT = &h8049
const GL_INTENSITY4_EXT = &h804A
const GL_INTENSITY8_EXT = &h804B
const GL_INTENSITY12_EXT = &h804C
const GL_INTENSITY16_EXT = &h804D
const GL_RGB2_EXT = &h804E
const GL_RGB4_EXT = &h804F
const GL_RGB5_EXT = &h8050
const GL_RGB8_EXT = &h8051
const GL_RGB10_EXT = &h8052
const GL_RGB12_EXT = &h8053
const GL_RGB16_EXT = &h8054
const GL_RGBA2_EXT = &h8055
const GL_RGBA4_EXT = &h8056
const GL_RGB5_A1_EXT = &h8057
const GL_RGBA8_EXT = &h8058
const GL_RGB10_A2_EXT = &h8059
const GL_RGBA12_EXT = &h805A
const GL_RGBA16_EXT = &h805B
const GL_TEXTURE_RED_SIZE_EXT = &h805C
const GL_TEXTURE_GREEN_SIZE_EXT = &h805D
const GL_TEXTURE_BLUE_SIZE_EXT = &h805E
const GL_TEXTURE_ALPHA_SIZE_EXT = &h805F
const GL_TEXTURE_LUMINANCE_SIZE_EXT = &h8060
const GL_TEXTURE_INTENSITY_SIZE_EXT = &h8061
const GL_REPLACE_EXT = &h8062
const GL_PROXY_TEXTURE_1D_EXT = &h8063
const GL_PROXY_TEXTURE_2D_EXT = &h8064
const GL_TEXTURE_TOO_LARGE_EXT = &h8065
const GL_EXT_texture3D = 1
const GL_PACK_SKIP_IMAGES_EXT = &h806B
const GL_PACK_IMAGE_HEIGHT_EXT = &h806C
const GL_UNPACK_SKIP_IMAGES_EXT = &h806D
const GL_UNPACK_IMAGE_HEIGHT_EXT = &h806E
const GL_TEXTURE_3D_EXT = &h806F
const GL_PROXY_TEXTURE_3D_EXT = &h8070
const GL_TEXTURE_DEPTH_EXT = &h8071
const GL_TEXTURE_WRAP_R_EXT = &h8072
const GL_MAX_3D_TEXTURE_SIZE_EXT = &h8073
type PFNGLTEXIMAGE3DEXTPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLTEXSUBIMAGE3DEXTPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTexImage3DEXT(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glTexSubImage3DEXT(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
#endif

const GL_EXT_texture_array = 1
const GL_TEXTURE_1D_ARRAY_EXT = &h8C18
const GL_PROXY_TEXTURE_1D_ARRAY_EXT = &h8C19
const GL_TEXTURE_2D_ARRAY_EXT = &h8C1A
const GL_PROXY_TEXTURE_2D_ARRAY_EXT = &h8C1B
const GL_TEXTURE_BINDING_1D_ARRAY_EXT = &h8C1C
const GL_TEXTURE_BINDING_2D_ARRAY_EXT = &h8C1D
const GL_MAX_ARRAY_TEXTURE_LAYERS_EXT = &h88FF
const GL_COMPARE_REF_DEPTH_TO_TEXTURE_EXT = &h884E
type PFNGLFRAMEBUFFERTEXTURELAYEREXTPROC as sub(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval layer as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glFramebufferTextureLayerEXT(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval layer as GLint)
#endif

const GL_EXT_texture_buffer_object = 1
const GL_TEXTURE_BUFFER_EXT = &h8C2A
const GL_MAX_TEXTURE_BUFFER_SIZE_EXT = &h8C2B
const GL_TEXTURE_BINDING_BUFFER_EXT = &h8C2C
const GL_TEXTURE_BUFFER_DATA_STORE_BINDING_EXT = &h8C2D
const GL_TEXTURE_BUFFER_FORMAT_EXT = &h8C2E
type PFNGLTEXBUFFEREXTPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTexBufferEXT(byval target as GLenum, byval internalformat as GLenum, byval buffer as GLuint)
#endif

const GL_EXT_texture_compression_latc = 1
const GL_COMPRESSED_LUMINANCE_LATC1_EXT = &h8C70
const GL_COMPRESSED_SIGNED_LUMINANCE_LATC1_EXT = &h8C71
const GL_COMPRESSED_LUMINANCE_ALPHA_LATC2_EXT = &h8C72
const GL_COMPRESSED_SIGNED_LUMINANCE_ALPHA_LATC2_EXT = &h8C73
const GL_EXT_texture_compression_rgtc = 1
const GL_COMPRESSED_RED_RGTC1_EXT = &h8DBB
const GL_COMPRESSED_SIGNED_RED_RGTC1_EXT = &h8DBC
const GL_COMPRESSED_RED_GREEN_RGTC2_EXT = &h8DBD
const GL_COMPRESSED_SIGNED_RED_GREEN_RGTC2_EXT = &h8DBE
const GL_EXT_texture_compression_s3tc = 1
const GL_COMPRESSED_RGB_S3TC_DXT1_EXT = &h83F0
const GL_COMPRESSED_RGBA_S3TC_DXT1_EXT = &h83F1
const GL_COMPRESSED_RGBA_S3TC_DXT3_EXT = &h83F2
const GL_COMPRESSED_RGBA_S3TC_DXT5_EXT = &h83F3
const GL_EXT_texture_cube_map = 1
const GL_NORMAL_MAP_EXT = &h8511
const GL_REFLECTION_MAP_EXT = &h8512
const GL_TEXTURE_CUBE_MAP_EXT = &h8513
const GL_TEXTURE_BINDING_CUBE_MAP_EXT = &h8514
const GL_TEXTURE_CUBE_MAP_POSITIVE_X_EXT = &h8515
const GL_TEXTURE_CUBE_MAP_NEGATIVE_X_EXT = &h8516
const GL_TEXTURE_CUBE_MAP_POSITIVE_Y_EXT = &h8517
const GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_EXT = &h8518
const GL_TEXTURE_CUBE_MAP_POSITIVE_Z_EXT = &h8519
const GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_EXT = &h851A
const GL_PROXY_TEXTURE_CUBE_MAP_EXT = &h851B
const GL_MAX_CUBE_MAP_TEXTURE_SIZE_EXT = &h851C
const GL_EXT_texture_env_add = 1
const GL_EXT_texture_env_combine = 1
const GL_COMBINE_EXT = &h8570
const GL_COMBINE_RGB_EXT = &h8571
const GL_COMBINE_ALPHA_EXT = &h8572
const GL_RGB_SCALE_EXT = &h8573
const GL_ADD_SIGNED_EXT = &h8574
const GL_INTERPOLATE_EXT = &h8575
const GL_CONSTANT_EXT = &h8576
const GL_PRIMARY_COLOR_EXT = &h8577
const GL_PREVIOUS_EXT = &h8578
const GL_SOURCE0_RGB_EXT = &h8580
const GL_SOURCE1_RGB_EXT = &h8581
const GL_SOURCE2_RGB_EXT = &h8582
const GL_SOURCE0_ALPHA_EXT = &h8588
const GL_SOURCE1_ALPHA_EXT = &h8589
const GL_SOURCE2_ALPHA_EXT = &h858A
const GL_OPERAND0_RGB_EXT = &h8590
const GL_OPERAND1_RGB_EXT = &h8591
const GL_OPERAND2_RGB_EXT = &h8592
const GL_OPERAND0_ALPHA_EXT = &h8598
const GL_OPERAND1_ALPHA_EXT = &h8599
const GL_OPERAND2_ALPHA_EXT = &h859A
const GL_EXT_texture_env_dot3 = 1
const GL_DOT3_RGB_EXT = &h8740
const GL_DOT3_RGBA_EXT = &h8741
const GL_EXT_texture_filter_anisotropic = 1
const GL_TEXTURE_MAX_ANISOTROPY_EXT = &h84FE
const GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT = &h84FF
const GL_EXT_texture_filter_minmax = 1
const GL_EXT_texture_integer = 1
const GL_RGBA32UI_EXT = &h8D70
const GL_RGB32UI_EXT = &h8D71
const GL_ALPHA32UI_EXT = &h8D72
const GL_INTENSITY32UI_EXT = &h8D73
const GL_LUMINANCE32UI_EXT = &h8D74
const GL_LUMINANCE_ALPHA32UI_EXT = &h8D75
const GL_RGBA16UI_EXT = &h8D76
const GL_RGB16UI_EXT = &h8D77
const GL_ALPHA16UI_EXT = &h8D78
const GL_INTENSITY16UI_EXT = &h8D79
const GL_LUMINANCE16UI_EXT = &h8D7A
const GL_LUMINANCE_ALPHA16UI_EXT = &h8D7B
const GL_RGBA8UI_EXT = &h8D7C
const GL_RGB8UI_EXT = &h8D7D
const GL_ALPHA8UI_EXT = &h8D7E
const GL_INTENSITY8UI_EXT = &h8D7F
const GL_LUMINANCE8UI_EXT = &h8D80
const GL_LUMINANCE_ALPHA8UI_EXT = &h8D81
const GL_RGBA32I_EXT = &h8D82
const GL_RGB32I_EXT = &h8D83
const GL_ALPHA32I_EXT = &h8D84
const GL_INTENSITY32I_EXT = &h8D85
const GL_LUMINANCE32I_EXT = &h8D86
const GL_LUMINANCE_ALPHA32I_EXT = &h8D87
const GL_RGBA16I_EXT = &h8D88
const GL_RGB16I_EXT = &h8D89
const GL_ALPHA16I_EXT = &h8D8A
const GL_INTENSITY16I_EXT = &h8D8B
const GL_LUMINANCE16I_EXT = &h8D8C
const GL_LUMINANCE_ALPHA16I_EXT = &h8D8D
const GL_RGBA8I_EXT = &h8D8E
const GL_RGB8I_EXT = &h8D8F
const GL_ALPHA8I_EXT = &h8D90
const GL_INTENSITY8I_EXT = &h8D91
const GL_LUMINANCE8I_EXT = &h8D92
const GL_LUMINANCE_ALPHA8I_EXT = &h8D93
const GL_RED_INTEGER_EXT = &h8D94
const GL_GREEN_INTEGER_EXT = &h8D95
const GL_BLUE_INTEGER_EXT = &h8D96
const GL_ALPHA_INTEGER_EXT = &h8D97
const GL_RGB_INTEGER_EXT = &h8D98
const GL_RGBA_INTEGER_EXT = &h8D99
const GL_BGR_INTEGER_EXT = &h8D9A
const GL_BGRA_INTEGER_EXT = &h8D9B
const GL_LUMINANCE_INTEGER_EXT = &h8D9C
const GL_LUMINANCE_ALPHA_INTEGER_EXT = &h8D9D
const GL_RGBA_INTEGER_MODE_EXT = &h8D9E

type PFNGLTEXPARAMETERIIVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLTEXPARAMETERIUIVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLuint ptr)
type PFNGLGETTEXPARAMETERIIVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETTEXPARAMETERIUIVEXTPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLuint ptr)
type PFNGLCLEARCOLORIIEXTPROC as sub(byval red as GLint, byval green as GLint, byval blue as GLint, byval alpha as GLint)
type PFNGLCLEARCOLORIUIEXTPROC as sub(byval red as GLuint, byval green as GLuint, byval blue as GLuint, byval alpha as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTexParameterIivEXT(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glTexParameterIuivEXT(byval target as GLenum, byval pname as GLenum, byval params as const GLuint ptr)
	declare sub glGetTexParameterIivEXT(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetTexParameterIuivEXT(byval target as GLenum, byval pname as GLenum, byval params as GLuint ptr)
	declare sub glClearColorIiEXT(byval red as GLint, byval green as GLint, byval blue as GLint, byval alpha as GLint)
	declare sub glClearColorIuiEXT(byval red as GLuint, byval green as GLuint, byval blue as GLuint, byval alpha as GLuint)
#endif

const GL_EXT_texture_lod_bias = 1
const GL_MAX_TEXTURE_LOD_BIAS_EXT = &h84FD
const GL_TEXTURE_FILTER_CONTROL_EXT = &h8500
const GL_TEXTURE_LOD_BIAS_EXT = &h8501
const GL_EXT_texture_mirror_clamp = 1
const GL_MIRROR_CLAMP_EXT = &h8742
const GL_MIRROR_CLAMP_TO_EDGE_EXT = &h8743
const GL_MIRROR_CLAMP_TO_BORDER_EXT = &h8912
const GL_EXT_texture_object = 1
const GL_TEXTURE_PRIORITY_EXT = &h8066
const GL_TEXTURE_RESIDENT_EXT = &h8067
const GL_TEXTURE_1D_BINDING_EXT = &h8068
const GL_TEXTURE_2D_BINDING_EXT = &h8069
const GL_TEXTURE_3D_BINDING_EXT = &h806A

type PFNGLARETEXTURESRESIDENTEXTPROC as function(byval n as GLsizei, byval textures as const GLuint ptr, byval residences as GLboolean ptr) as GLboolean
type PFNGLBINDTEXTUREEXTPROC as sub(byval target as GLenum, byval texture as GLuint)
type PFNGLDELETETEXTURESEXTPROC as sub(byval n as GLsizei, byval textures as const GLuint ptr)
type PFNGLGENTEXTURESEXTPROC as sub(byval n as GLsizei, byval textures as GLuint ptr)
type PFNGLISTEXTUREEXTPROC as function(byval texture as GLuint) as GLboolean
type PFNGLPRIORITIZETEXTURESEXTPROC as sub(byval n as GLsizei, byval textures as const GLuint ptr, byval priorities as const GLclampf ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare function glAreTexturesResidentEXT(byval n as GLsizei, byval textures as const GLuint ptr, byval residences as GLboolean ptr) as GLboolean
	declare sub glBindTextureEXT(byval target as GLenum, byval texture as GLuint)
	declare sub glDeleteTexturesEXT(byval n as GLsizei, byval textures as const GLuint ptr)
	declare sub glGenTexturesEXT(byval n as GLsizei, byval textures as GLuint ptr)
	declare function glIsTextureEXT(byval texture as GLuint) as GLboolean
	declare sub glPrioritizeTexturesEXT(byval n as GLsizei, byval textures as const GLuint ptr, byval priorities as const GLclampf ptr)
#endif

const GL_EXT_texture_perturb_normal = 1
const GL_PERTURB_EXT = &h85AE
const GL_TEXTURE_NORMAL_EXT = &h85AF
type PFNGLTEXTURENORMALEXTPROC as sub(byval mode as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTextureNormalEXT(byval mode as GLenum)
#endif

const GL_EXT_texture_sRGB = 1
const GL_SRGB_EXT = &h8C40
const GL_SRGB8_EXT = &h8C41
const GL_SRGB_ALPHA_EXT = &h8C42
const GL_SRGB8_ALPHA8_EXT = &h8C43
const GL_SLUMINANCE_ALPHA_EXT = &h8C44
const GL_SLUMINANCE8_ALPHA8_EXT = &h8C45
const GL_SLUMINANCE_EXT = &h8C46
const GL_SLUMINANCE8_EXT = &h8C47
const GL_COMPRESSED_SRGB_EXT = &h8C48
const GL_COMPRESSED_SRGB_ALPHA_EXT = &h8C49
const GL_COMPRESSED_SLUMINANCE_EXT = &h8C4A
const GL_COMPRESSED_SLUMINANCE_ALPHA_EXT = &h8C4B
const GL_COMPRESSED_SRGB_S3TC_DXT1_EXT = &h8C4C
const GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT1_EXT = &h8C4D
const GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT3_EXT = &h8C4E
const GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT = &h8C4F
const GL_EXT_texture_sRGB_decode = 1
const GL_TEXTURE_SRGB_DECODE_EXT = &h8A48
const GL_DECODE_EXT = &h8A49
const GL_SKIP_DECODE_EXT = &h8A4A
const GL_EXT_texture_shared_exponent = 1
const GL_RGB9_E5_EXT = &h8C3D
const GL_UNSIGNED_INT_5_9_9_9_REV_EXT = &h8C3E
const GL_TEXTURE_SHARED_SIZE_EXT = &h8C3F
const GL_EXT_texture_snorm = 1
const GL_ALPHA_SNORM = &h9010
const GL_LUMINANCE_SNORM = &h9011
const GL_LUMINANCE_ALPHA_SNORM = &h9012
const GL_INTENSITY_SNORM = &h9013
const GL_ALPHA8_SNORM = &h9014
const GL_LUMINANCE8_SNORM = &h9015
const GL_LUMINANCE8_ALPHA8_SNORM = &h9016
const GL_INTENSITY8_SNORM = &h9017
const GL_ALPHA16_SNORM = &h9018
const GL_LUMINANCE16_SNORM = &h9019
const GL_LUMINANCE16_ALPHA16_SNORM = &h901A
const GL_INTENSITY16_SNORM = &h901B
const GL_RED_SNORM = &h8F90
const GL_RG_SNORM = &h8F91
const GL_RGB_SNORM = &h8F92
const GL_RGBA_SNORM = &h8F93
const GL_EXT_texture_swizzle = 1
const GL_TEXTURE_SWIZZLE_R_EXT = &h8E42
const GL_TEXTURE_SWIZZLE_G_EXT = &h8E43
const GL_TEXTURE_SWIZZLE_B_EXT = &h8E44
const GL_TEXTURE_SWIZZLE_A_EXT = &h8E45
const GL_TEXTURE_SWIZZLE_RGBA_EXT = &h8E46
const GL_EXT_timer_query = 1
const GL_TIME_ELAPSED_EXT = &h88BF
type PFNGLGETQUERYOBJECTI64VEXTPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLint64 ptr)
type PFNGLGETQUERYOBJECTUI64VEXTPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLuint64 ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGetQueryObjecti64vEXT(byval id as GLuint, byval pname as GLenum, byval params as GLint64 ptr)
	declare sub glGetQueryObjectui64vEXT(byval id as GLuint, byval pname as GLenum, byval params as GLuint64 ptr)
#endif

const GL_EXT_transform_feedback = 1
const GL_TRANSFORM_FEEDBACK_BUFFER_EXT = &h8C8E
const GL_TRANSFORM_FEEDBACK_BUFFER_START_EXT = &h8C84
const GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_EXT = &h8C85
const GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_EXT = &h8C8F
const GL_INTERLEAVED_ATTRIBS_EXT = &h8C8C
const GL_SEPARATE_ATTRIBS_EXT = &h8C8D
const GL_PRIMITIVES_GENERATED_EXT = &h8C87
const GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_EXT = &h8C88
const GL_RASTERIZER_DISCARD_EXT = &h8C89
const GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_EXT = &h8C8A
const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_EXT = &h8C8B
const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_EXT = &h8C80
const GL_TRANSFORM_FEEDBACK_VARYINGS_EXT = &h8C83
const GL_TRANSFORM_FEEDBACK_BUFFER_MODE_EXT = &h8C7F
const GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH_EXT = &h8C76

type PFNGLBEGINTRANSFORMFEEDBACKEXTPROC as sub(byval primitiveMode as GLenum)
type PFNGLENDTRANSFORMFEEDBACKEXTPROC as sub()
type PFNGLBINDBUFFERRANGEEXTPROC as sub(byval target as GLenum, byval index as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr)
type PFNGLBINDBUFFEROFFSETEXTPROC as sub(byval target as GLenum, byval index as GLuint, byval buffer as GLuint, byval offset as GLintptr)
type PFNGLBINDBUFFERBASEEXTPROC as sub(byval target as GLenum, byval index as GLuint, byval buffer as GLuint)
type PFNGLTRANSFORMFEEDBACKVARYINGSEXTPROC as sub(byval program as GLuint, byval count as GLsizei, byval varyings as const GLchar const ptr ptr, byval bufferMode as GLenum)
type PFNGLGETTRANSFORMFEEDBACKVARYINGEXTPROC as sub(byval program as GLuint, byval index as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval size as GLsizei ptr, byval type as GLenum ptr, byval name as GLchar ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBeginTransformFeedbackEXT(byval primitiveMode as GLenum)
	declare sub glEndTransformFeedbackEXT()
	declare sub glBindBufferRangeEXT(byval target as GLenum, byval index as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr)
	declare sub glBindBufferOffsetEXT(byval target as GLenum, byval index as GLuint, byval buffer as GLuint, byval offset as GLintptr)
	declare sub glBindBufferBaseEXT(byval target as GLenum, byval index as GLuint, byval buffer as GLuint)
	declare sub glTransformFeedbackVaryingsEXT(byval program as GLuint, byval count as GLsizei, byval varyings as const GLchar const ptr ptr, byval bufferMode as GLenum)
	declare sub glGetTransformFeedbackVaryingEXT(byval program as GLuint, byval index as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval size as GLsizei ptr, byval type as GLenum ptr, byval name as GLchar ptr)
#endif

const GL_EXT_vertex_array_bgra = 1
const GL_EXT_vertex_attrib_64bit = 1
const GL_DOUBLE_VEC2_EXT = &h8FFC
const GL_DOUBLE_VEC3_EXT = &h8FFD
const GL_DOUBLE_VEC4_EXT = &h8FFE
const GL_DOUBLE_MAT2_EXT = &h8F46
const GL_DOUBLE_MAT3_EXT = &h8F47
const GL_DOUBLE_MAT4_EXT = &h8F48
const GL_DOUBLE_MAT2x3_EXT = &h8F49
const GL_DOUBLE_MAT2x4_EXT = &h8F4A
const GL_DOUBLE_MAT3x2_EXT = &h8F4B
const GL_DOUBLE_MAT3x4_EXT = &h8F4C
const GL_DOUBLE_MAT4x2_EXT = &h8F4D
const GL_DOUBLE_MAT4x3_EXT = &h8F4E

type PFNGLVERTEXATTRIBL1DEXTPROC as sub(byval index as GLuint, byval x as GLdouble)
type PFNGLVERTEXATTRIBL2DEXTPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble)
type PFNGLVERTEXATTRIBL3DEXTPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLVERTEXATTRIBL4DEXTPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLVERTEXATTRIBL1DVEXTPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIBL2DVEXTPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIBL3DVEXTPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIBL4DVEXTPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIBLPOINTEREXTPROC as sub(byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
type PFNGLGETVERTEXATTRIBLDVEXTPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLdouble ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVertexAttribL1dEXT(byval index as GLuint, byval x as GLdouble)
	declare sub glVertexAttribL2dEXT(byval index as GLuint, byval x as GLdouble, byval y as GLdouble)
	declare sub glVertexAttribL3dEXT(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glVertexAttribL4dEXT(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glVertexAttribL1dvEXT(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttribL2dvEXT(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttribL3dvEXT(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttribL4dvEXT(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttribLPointerEXT(byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
	declare sub glGetVertexAttribLdvEXT(byval index as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
#endif

const GL_EXT_vertex_shader = 1
const GL_VERTEX_SHADER_EXT = &h8780
const GL_VERTEX_SHADER_BINDING_EXT = &h8781
const GL_OP_INDEX_EXT = &h8782
const GL_OP_NEGATE_EXT = &h8783
const GL_OP_DOT3_EXT = &h8784
const GL_OP_DOT4_EXT = &h8785
const GL_OP_MUL_EXT = &h8786
const GL_OP_ADD_EXT = &h8787
const GL_OP_MADD_EXT = &h8788
const GL_OP_FRAC_EXT = &h8789
const GL_OP_MAX_EXT = &h878A
const GL_OP_MIN_EXT = &h878B
const GL_OP_SET_GE_EXT = &h878C
const GL_OP_SET_LT_EXT = &h878D
const GL_OP_CLAMP_EXT = &h878E
const GL_OP_FLOOR_EXT = &h878F
const GL_OP_ROUND_EXT = &h8790
const GL_OP_EXP_BASE_2_EXT = &h8791
const GL_OP_LOG_BASE_2_EXT = &h8792
const GL_OP_POWER_EXT = &h8793
const GL_OP_RECIP_EXT = &h8794
const GL_OP_RECIP_SQRT_EXT = &h8795
const GL_OP_SUB_EXT = &h8796
const GL_OP_CROSS_PRODUCT_EXT = &h8797
const GL_OP_MULTIPLY_MATRIX_EXT = &h8798
const GL_OP_MOV_EXT = &h8799
const GL_OUTPUT_VERTEX_EXT = &h879A
const GL_OUTPUT_COLOR0_EXT = &h879B
const GL_OUTPUT_COLOR1_EXT = &h879C
const GL_OUTPUT_TEXTURE_COORD0_EXT = &h879D
const GL_OUTPUT_TEXTURE_COORD1_EXT = &h879E
const GL_OUTPUT_TEXTURE_COORD2_EXT = &h879F
const GL_OUTPUT_TEXTURE_COORD3_EXT = &h87A0
const GL_OUTPUT_TEXTURE_COORD4_EXT = &h87A1
const GL_OUTPUT_TEXTURE_COORD5_EXT = &h87A2
const GL_OUTPUT_TEXTURE_COORD6_EXT = &h87A3
const GL_OUTPUT_TEXTURE_COORD7_EXT = &h87A4
const GL_OUTPUT_TEXTURE_COORD8_EXT = &h87A5
const GL_OUTPUT_TEXTURE_COORD9_EXT = &h87A6
const GL_OUTPUT_TEXTURE_COORD10_EXT = &h87A7
const GL_OUTPUT_TEXTURE_COORD11_EXT = &h87A8
const GL_OUTPUT_TEXTURE_COORD12_EXT = &h87A9
const GL_OUTPUT_TEXTURE_COORD13_EXT = &h87AA
const GL_OUTPUT_TEXTURE_COORD14_EXT = &h87AB
const GL_OUTPUT_TEXTURE_COORD15_EXT = &h87AC
const GL_OUTPUT_TEXTURE_COORD16_EXT = &h87AD
const GL_OUTPUT_TEXTURE_COORD17_EXT = &h87AE
const GL_OUTPUT_TEXTURE_COORD18_EXT = &h87AF
const GL_OUTPUT_TEXTURE_COORD19_EXT = &h87B0
const GL_OUTPUT_TEXTURE_COORD20_EXT = &h87B1
const GL_OUTPUT_TEXTURE_COORD21_EXT = &h87B2
const GL_OUTPUT_TEXTURE_COORD22_EXT = &h87B3
const GL_OUTPUT_TEXTURE_COORD23_EXT = &h87B4
const GL_OUTPUT_TEXTURE_COORD24_EXT = &h87B5
const GL_OUTPUT_TEXTURE_COORD25_EXT = &h87B6
const GL_OUTPUT_TEXTURE_COORD26_EXT = &h87B7
const GL_OUTPUT_TEXTURE_COORD27_EXT = &h87B8
const GL_OUTPUT_TEXTURE_COORD28_EXT = &h87B9
const GL_OUTPUT_TEXTURE_COORD29_EXT = &h87BA
const GL_OUTPUT_TEXTURE_COORD30_EXT = &h87BB
const GL_OUTPUT_TEXTURE_COORD31_EXT = &h87BC
const GL_OUTPUT_FOG_EXT = &h87BD
const GL_SCALAR_EXT = &h87BE
const GL_VECTOR_EXT = &h87BF
const GL_MATRIX_EXT = &h87C0
const GL_VARIANT_EXT = &h87C1
const GL_INVARIANT_EXT = &h87C2
const GL_LOCAL_CONSTANT_EXT = &h87C3
const GL_LOCAL_EXT = &h87C4
const GL_MAX_VERTEX_SHADER_INSTRUCTIONS_EXT = &h87C5
const GL_MAX_VERTEX_SHADER_VARIANTS_EXT = &h87C6
const GL_MAX_VERTEX_SHADER_INVARIANTS_EXT = &h87C7
const GL_MAX_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = &h87C8
const GL_MAX_VERTEX_SHADER_LOCALS_EXT = &h87C9
const GL_MAX_OPTIMIZED_VERTEX_SHADER_INSTRUCTIONS_EXT = &h87CA
const GL_MAX_OPTIMIZED_VERTEX_SHADER_VARIANTS_EXT = &h87CB
const GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = &h87CC
const GL_MAX_OPTIMIZED_VERTEX_SHADER_INVARIANTS_EXT = &h87CD
const GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCALS_EXT = &h87CE
const GL_VERTEX_SHADER_INSTRUCTIONS_EXT = &h87CF
const GL_VERTEX_SHADER_VARIANTS_EXT = &h87D0
const GL_VERTEX_SHADER_INVARIANTS_EXT = &h87D1
const GL_VERTEX_SHADER_LOCAL_CONSTANTS_EXT = &h87D2
const GL_VERTEX_SHADER_LOCALS_EXT = &h87D3
const GL_VERTEX_SHADER_OPTIMIZED_EXT = &h87D4
const GL_X_EXT = &h87D5
const GL_Y_EXT = &h87D6
const GL_Z_EXT = &h87D7
const GL_W_EXT = &h87D8
const GL_NEGATIVE_X_EXT = &h87D9
const GL_NEGATIVE_Y_EXT = &h87DA
const GL_NEGATIVE_Z_EXT = &h87DB
const GL_NEGATIVE_W_EXT = &h87DC
const GL_ZERO_EXT = &h87DD
const GL_ONE_EXT = &h87DE
const GL_NEGATIVE_ONE_EXT = &h87DF
const GL_NORMALIZED_RANGE_EXT = &h87E0
const GL_FULL_RANGE_EXT = &h87E1
const GL_CURRENT_VERTEX_EXT = &h87E2
const GL_MVP_MATRIX_EXT = &h87E3
const GL_VARIANT_VALUE_EXT = &h87E4
const GL_VARIANT_DATATYPE_EXT = &h87E5
const GL_VARIANT_ARRAY_STRIDE_EXT = &h87E6
const GL_VARIANT_ARRAY_TYPE_EXT = &h87E7
const GL_VARIANT_ARRAY_EXT = &h87E8
const GL_VARIANT_ARRAY_POINTER_EXT = &h87E9
const GL_INVARIANT_VALUE_EXT = &h87EA
const GL_INVARIANT_DATATYPE_EXT = &h87EB
const GL_LOCAL_CONSTANT_VALUE_EXT = &h87EC
const GL_LOCAL_CONSTANT_DATATYPE_EXT = &h87ED

type PFNGLBEGINVERTEXSHADEREXTPROC as sub()
type PFNGLENDVERTEXSHADEREXTPROC as sub()
type PFNGLBINDVERTEXSHADEREXTPROC as sub(byval id as GLuint)
type PFNGLGENVERTEXSHADERSEXTPROC as function(byval range as GLuint) as GLuint
type PFNGLDELETEVERTEXSHADEREXTPROC as sub(byval id as GLuint)
type PFNGLSHADEROP1EXTPROC as sub(byval op as GLenum, byval res as GLuint, byval arg1 as GLuint)
type PFNGLSHADEROP2EXTPROC as sub(byval op as GLenum, byval res as GLuint, byval arg1 as GLuint, byval arg2 as GLuint)
type PFNGLSHADEROP3EXTPROC as sub(byval op as GLenum, byval res as GLuint, byval arg1 as GLuint, byval arg2 as GLuint, byval arg3 as GLuint)
type PFNGLSWIZZLEEXTPROC as sub(byval res as GLuint, byval in as GLuint, byval outX as GLenum, byval outY as GLenum, byval outZ as GLenum, byval outW as GLenum)
type PFNGLWRITEMASKEXTPROC as sub(byval res as GLuint, byval in as GLuint, byval outX as GLenum, byval outY as GLenum, byval outZ as GLenum, byval outW as GLenum)
type PFNGLINSERTCOMPONENTEXTPROC as sub(byval res as GLuint, byval src as GLuint, byval num as GLuint)
type PFNGLEXTRACTCOMPONENTEXTPROC as sub(byval res as GLuint, byval src as GLuint, byval num as GLuint)
type PFNGLGENSYMBOLSEXTPROC as function(byval datatype as GLenum, byval storagetype as GLenum, byval range as GLenum, byval components as GLuint) as GLuint
type PFNGLSETINVARIANTEXTPROC as sub(byval id as GLuint, byval type as GLenum, byval addr as const any ptr)
type PFNGLSETLOCALCONSTANTEXTPROC as sub(byval id as GLuint, byval type as GLenum, byval addr as const any ptr)
type PFNGLVARIANTBVEXTPROC as sub(byval id as GLuint, byval addr as const GLbyte ptr)
type PFNGLVARIANTSVEXTPROC as sub(byval id as GLuint, byval addr as const GLshort ptr)
type PFNGLVARIANTIVEXTPROC as sub(byval id as GLuint, byval addr as const GLint ptr)
type PFNGLVARIANTFVEXTPROC as sub(byval id as GLuint, byval addr as const GLfloat ptr)
type PFNGLVARIANTDVEXTPROC as sub(byval id as GLuint, byval addr as const GLdouble ptr)
type PFNGLVARIANTUBVEXTPROC as sub(byval id as GLuint, byval addr as const GLubyte ptr)
type PFNGLVARIANTUSVEXTPROC as sub(byval id as GLuint, byval addr as const GLushort ptr)
type PFNGLVARIANTUIVEXTPROC as sub(byval id as GLuint, byval addr as const GLuint ptr)
type PFNGLVARIANTPOINTEREXTPROC as sub(byval id as GLuint, byval type as GLenum, byval stride as GLuint, byval addr as const any ptr)
type PFNGLENABLEVARIANTCLIENTSTATEEXTPROC as sub(byval id as GLuint)
type PFNGLDISABLEVARIANTCLIENTSTATEEXTPROC as sub(byval id as GLuint)
type PFNGLBINDLIGHTPARAMETEREXTPROC as function(byval light as GLenum, byval value as GLenum) as GLuint
type PFNGLBINDMATERIALPARAMETEREXTPROC as function(byval face as GLenum, byval value as GLenum) as GLuint
type PFNGLBINDTEXGENPARAMETEREXTPROC as function(byval unit as GLenum, byval coord as GLenum, byval value as GLenum) as GLuint
type PFNGLBINDTEXTUREUNITPARAMETEREXTPROC as function(byval unit as GLenum, byval value as GLenum) as GLuint
type PFNGLBINDPARAMETEREXTPROC as function(byval value as GLenum) as GLuint
type PFNGLISVARIANTENABLEDEXTPROC as function(byval id as GLuint, byval cap as GLenum) as GLboolean
type PFNGLGETVARIANTBOOLEANVEXTPROC as sub(byval id as GLuint, byval value as GLenum, byval data as GLboolean ptr)
type PFNGLGETVARIANTINTEGERVEXTPROC as sub(byval id as GLuint, byval value as GLenum, byval data as GLint ptr)
type PFNGLGETVARIANTFLOATVEXTPROC as sub(byval id as GLuint, byval value as GLenum, byval data as GLfloat ptr)
type PFNGLGETVARIANTPOINTERVEXTPROC as sub(byval id as GLuint, byval value as GLenum, byval data as any ptr ptr)
type PFNGLGETINVARIANTBOOLEANVEXTPROC as sub(byval id as GLuint, byval value as GLenum, byval data as GLboolean ptr)
type PFNGLGETINVARIANTINTEGERVEXTPROC as sub(byval id as GLuint, byval value as GLenum, byval data as GLint ptr)
type PFNGLGETINVARIANTFLOATVEXTPROC as sub(byval id as GLuint, byval value as GLenum, byval data as GLfloat ptr)
type PFNGLGETLOCALCONSTANTBOOLEANVEXTPROC as sub(byval id as GLuint, byval value as GLenum, byval data as GLboolean ptr)
type PFNGLGETLOCALCONSTANTINTEGERVEXTPROC as sub(byval id as GLuint, byval value as GLenum, byval data as GLint ptr)
type PFNGLGETLOCALCONSTANTFLOATVEXTPROC as sub(byval id as GLuint, byval value as GLenum, byval data as GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBeginVertexShaderEXT()
	declare sub glEndVertexShaderEXT()
	declare sub glBindVertexShaderEXT(byval id as GLuint)
	declare function glGenVertexShadersEXT(byval range as GLuint) as GLuint
	declare sub glDeleteVertexShaderEXT(byval id as GLuint)
	declare sub glShaderOp1EXT(byval op as GLenum, byval res as GLuint, byval arg1 as GLuint)
	declare sub glShaderOp2EXT(byval op as GLenum, byval res as GLuint, byval arg1 as GLuint, byval arg2 as GLuint)
	declare sub glShaderOp3EXT(byval op as GLenum, byval res as GLuint, byval arg1 as GLuint, byval arg2 as GLuint, byval arg3 as GLuint)
	declare sub glSwizzleEXT(byval res as GLuint, byval in as GLuint, byval outX as GLenum, byval outY as GLenum, byval outZ as GLenum, byval outW as GLenum)
	declare sub glWriteMaskEXT(byval res as GLuint, byval in as GLuint, byval outX as GLenum, byval outY as GLenum, byval outZ as GLenum, byval outW as GLenum)
	declare sub glInsertComponentEXT(byval res as GLuint, byval src as GLuint, byval num as GLuint)
	declare sub glExtractComponentEXT(byval res as GLuint, byval src as GLuint, byval num as GLuint)
	declare function glGenSymbolsEXT(byval datatype as GLenum, byval storagetype as GLenum, byval range as GLenum, byval components as GLuint) as GLuint
	declare sub glSetInvariantEXT(byval id as GLuint, byval type as GLenum, byval addr as const any ptr)
	declare sub glSetLocalConstantEXT(byval id as GLuint, byval type as GLenum, byval addr as const any ptr)
	declare sub glVariantbvEXT(byval id as GLuint, byval addr as const GLbyte ptr)
	declare sub glVariantsvEXT(byval id as GLuint, byval addr as const GLshort ptr)
	declare sub glVariantivEXT(byval id as GLuint, byval addr as const GLint ptr)
	declare sub glVariantfvEXT(byval id as GLuint, byval addr as const GLfloat ptr)
	declare sub glVariantdvEXT(byval id as GLuint, byval addr as const GLdouble ptr)
	declare sub glVariantubvEXT(byval id as GLuint, byval addr as const GLubyte ptr)
	declare sub glVariantusvEXT(byval id as GLuint, byval addr as const GLushort ptr)
	declare sub glVariantuivEXT(byval id as GLuint, byval addr as const GLuint ptr)
	declare sub glVariantPointerEXT(byval id as GLuint, byval type as GLenum, byval stride as GLuint, byval addr as const any ptr)
	declare sub glEnableVariantClientStateEXT(byval id as GLuint)
	declare sub glDisableVariantClientStateEXT(byval id as GLuint)
	declare function glBindLightParameterEXT(byval light as GLenum, byval value as GLenum) as GLuint
	declare function glBindMaterialParameterEXT(byval face as GLenum, byval value as GLenum) as GLuint
	declare function glBindTexGenParameterEXT(byval unit as GLenum, byval coord as GLenum, byval value as GLenum) as GLuint
	declare function glBindTextureUnitParameterEXT(byval unit as GLenum, byval value as GLenum) as GLuint
	declare function glBindParameterEXT(byval value as GLenum) as GLuint
	declare function glIsVariantEnabledEXT(byval id as GLuint, byval cap as GLenum) as GLboolean
	declare sub glGetVariantBooleanvEXT(byval id as GLuint, byval value as GLenum, byval data as GLboolean ptr)
	declare sub glGetVariantIntegervEXT(byval id as GLuint, byval value as GLenum, byval data as GLint ptr)
	declare sub glGetVariantFloatvEXT(byval id as GLuint, byval value as GLenum, byval data as GLfloat ptr)
	declare sub glGetVariantPointervEXT(byval id as GLuint, byval value as GLenum, byval data as any ptr ptr)
	declare sub glGetInvariantBooleanvEXT(byval id as GLuint, byval value as GLenum, byval data as GLboolean ptr)
	declare sub glGetInvariantIntegervEXT(byval id as GLuint, byval value as GLenum, byval data as GLint ptr)
	declare sub glGetInvariantFloatvEXT(byval id as GLuint, byval value as GLenum, byval data as GLfloat ptr)
	declare sub glGetLocalConstantBooleanvEXT(byval id as GLuint, byval value as GLenum, byval data as GLboolean ptr)
	declare sub glGetLocalConstantIntegervEXT(byval id as GLuint, byval value as GLenum, byval data as GLint ptr)
	declare sub glGetLocalConstantFloatvEXT(byval id as GLuint, byval value as GLenum, byval data as GLfloat ptr)
#endif

const GL_EXT_vertex_weighting = 1
const GL_MODELVIEW0_STACK_DEPTH_EXT = &h0BA3
const GL_MODELVIEW1_STACK_DEPTH_EXT = &h8502
const GL_MODELVIEW0_MATRIX_EXT = &h0BA6
const GL_MODELVIEW1_MATRIX_EXT = &h8506
const GL_VERTEX_WEIGHTING_EXT = &h8509
const GL_MODELVIEW0_EXT = &h1700
const GL_MODELVIEW1_EXT = &h850A
const GL_CURRENT_VERTEX_WEIGHT_EXT = &h850B
const GL_VERTEX_WEIGHT_ARRAY_EXT = &h850C
const GL_VERTEX_WEIGHT_ARRAY_SIZE_EXT = &h850D
const GL_VERTEX_WEIGHT_ARRAY_TYPE_EXT = &h850E
const GL_VERTEX_WEIGHT_ARRAY_STRIDE_EXT = &h850F
const GL_VERTEX_WEIGHT_ARRAY_POINTER_EXT = &h8510

type PFNGLVERTEXWEIGHTFEXTPROC as sub(byval weight as GLfloat)
type PFNGLVERTEXWEIGHTFVEXTPROC as sub(byval weight as const GLfloat ptr)
type PFNGLVERTEXWEIGHTPOINTEREXTPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVertexWeightfEXT(byval weight as GLfloat)
	declare sub glVertexWeightfvEXT(byval weight as const GLfloat ptr)
	declare sub glVertexWeightPointerEXT(byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
#endif

const GL_EXT_x11_sync_object = 1
const GL_SYNC_X11_FENCE_EXT = &h90E1
type PFNGLIMPORTSYNCEXTPROC as function(byval external_sync_type as GLenum, byval external_sync as GLintptr, byval flags as GLbitfield) as GLsync

#ifdef GL_GLEXT_PROTOTYPES
	declare function glImportSyncEXT(byval external_sync_type as GLenum, byval external_sync as GLintptr, byval flags as GLbitfield) as GLsync
#endif

const GL_GREMEDY_frame_terminator = 1
type PFNGLFRAMETERMINATORGREMEDYPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glFrameTerminatorGREMEDY()
#endif

const GL_GREMEDY_string_marker = 1
type PFNGLSTRINGMARKERGREMEDYPROC as sub(byval len as GLsizei, byval string as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glStringMarkerGREMEDY(byval len as GLsizei, byval string as const any ptr)
#endif

const GL_HP_convolution_border_modes = 1
const GL_IGNORE_BORDER_HP = &h8150
const GL_CONSTANT_BORDER_HP = &h8151
const GL_REPLICATE_BORDER_HP = &h8153
const GL_CONVOLUTION_BORDER_COLOR_HP = &h8154
const GL_HP_image_transform = 1
const GL_IMAGE_SCALE_X_HP = &h8155
const GL_IMAGE_SCALE_Y_HP = &h8156
const GL_IMAGE_TRANSLATE_X_HP = &h8157
const GL_IMAGE_TRANSLATE_Y_HP = &h8158
const GL_IMAGE_ROTATE_ANGLE_HP = &h8159
const GL_IMAGE_ROTATE_ORIGIN_X_HP = &h815A
const GL_IMAGE_ROTATE_ORIGIN_Y_HP = &h815B
const GL_IMAGE_MAG_FILTER_HP = &h815C
const GL_IMAGE_MIN_FILTER_HP = &h815D
const GL_IMAGE_CUBIC_WEIGHT_HP = &h815E
const GL_CUBIC_HP = &h815F
const GL_AVERAGE_HP = &h8160
const GL_IMAGE_TRANSFORM_2D_HP = &h8161
const GL_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP = &h8162
const GL_PROXY_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP = &h8163

type PFNGLIMAGETRANSFORMPARAMETERIHPPROC as sub(byval target as GLenum, byval pname as GLenum, byval param as GLint)
type PFNGLIMAGETRANSFORMPARAMETERFHPPROC as sub(byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
type PFNGLIMAGETRANSFORMPARAMETERIVHPPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLIMAGETRANSFORMPARAMETERFVHPPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLGETIMAGETRANSFORMPARAMETERIVHPPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETIMAGETRANSFORMPARAMETERFVHPPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glImageTransformParameteriHP(byval target as GLenum, byval pname as GLenum, byval param as GLint)
	declare sub glImageTransformParameterfHP(byval target as GLenum, byval pname as GLenum, byval param as GLfloat)
	declare sub glImageTransformParameterivHP(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glImageTransformParameterfvHP(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glGetImageTransformParameterivHP(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetImageTransformParameterfvHP(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
#endif

const GL_HP_occlusion_test = 1
const GL_OCCLUSION_TEST_HP = &h8165
const GL_OCCLUSION_TEST_RESULT_HP = &h8166
const GL_HP_texture_lighting = 1
const GL_TEXTURE_LIGHTING_MODE_HP = &h8167
const GL_TEXTURE_POST_SPECULAR_HP = &h8168
const GL_TEXTURE_PRE_SPECULAR_HP = &h8169
const GL_IBM_cull_vertex = 1
const GL_CULL_VERTEX_IBM = 103050
const GL_IBM_multimode_draw_arrays = 1
type PFNGLMULTIMODEDRAWARRAYSIBMPROC as sub(byval mode as const GLenum ptr, byval first as const GLint ptr, byval count as const GLsizei ptr, byval primcount as GLsizei, byval modestride as GLint)
type PFNGLMULTIMODEDRAWELEMENTSIBMPROC as sub(byval mode as const GLenum ptr, byval count as const GLsizei ptr, byval type as GLenum, byval indices as const any const ptr ptr, byval primcount as GLsizei, byval modestride as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glMultiModeDrawArraysIBM(byval mode as const GLenum ptr, byval first as const GLint ptr, byval count as const GLsizei ptr, byval primcount as GLsizei, byval modestride as GLint)
	declare sub glMultiModeDrawElementsIBM(byval mode as const GLenum ptr, byval count as const GLsizei ptr, byval type as GLenum, byval indices as const any const ptr ptr, byval primcount as GLsizei, byval modestride as GLint)
#endif

const GL_IBM_rasterpos_clip = 1
const GL_RASTER_POSITION_UNCLIPPED_IBM = &h19262
const GL_IBM_static_data = 1
const GL_ALL_STATIC_DATA_IBM = 103060
const GL_STATIC_VERTEX_ARRAY_IBM = 103061
type PFNGLFLUSHSTATICDATAIBMPROC as sub(byval target as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glFlushStaticDataIBM(byval target as GLenum)
#endif

const GL_IBM_texture_mirrored_repeat = 1
const GL_MIRRORED_REPEAT_IBM = &h8370
const GL_IBM_vertex_array_lists = 1
const GL_VERTEX_ARRAY_LIST_IBM = 103070
const GL_NORMAL_ARRAY_LIST_IBM = 103071
const GL_COLOR_ARRAY_LIST_IBM = 103072
const GL_INDEX_ARRAY_LIST_IBM = 103073
const GL_TEXTURE_COORD_ARRAY_LIST_IBM = 103074
const GL_EDGE_FLAG_ARRAY_LIST_IBM = 103075
const GL_FOG_COORDINATE_ARRAY_LIST_IBM = 103076
const GL_SECONDARY_COLOR_ARRAY_LIST_IBM = 103077
const GL_VERTEX_ARRAY_LIST_STRIDE_IBM = 103080
const GL_NORMAL_ARRAY_LIST_STRIDE_IBM = 103081
const GL_COLOR_ARRAY_LIST_STRIDE_IBM = 103082
const GL_INDEX_ARRAY_LIST_STRIDE_IBM = 103083
const GL_TEXTURE_COORD_ARRAY_LIST_STRIDE_IBM = 103084
const GL_EDGE_FLAG_ARRAY_LIST_STRIDE_IBM = 103085
const GL_FOG_COORDINATE_ARRAY_LIST_STRIDE_IBM = 103086
const GL_SECONDARY_COLOR_ARRAY_LIST_STRIDE_IBM = 103087

type PFNGLCOLORPOINTERLISTIBMPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
type PFNGLSECONDARYCOLORPOINTERLISTIBMPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
type PFNGLEDGEFLAGPOINTERLISTIBMPROC as sub(byval stride as GLint, byval pointer as const GLboolean ptr ptr, byval ptrstride as GLint)
type PFNGLFOGCOORDPOINTERLISTIBMPROC as sub(byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
type PFNGLINDEXPOINTERLISTIBMPROC as sub(byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
type PFNGLNORMALPOINTERLISTIBMPROC as sub(byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
type PFNGLTEXCOORDPOINTERLISTIBMPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
type PFNGLVERTEXPOINTERLISTIBMPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glColorPointerListIBM(byval size as GLint, byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
	declare sub glSecondaryColorPointerListIBM(byval size as GLint, byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
	declare sub glEdgeFlagPointerListIBM(byval stride as GLint, byval pointer as const GLboolean ptr ptr, byval ptrstride as GLint)
	declare sub glFogCoordPointerListIBM(byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
	declare sub glIndexPointerListIBM(byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
	declare sub glNormalPointerListIBM(byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
	declare sub glTexCoordPointerListIBM(byval size as GLint, byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
	declare sub glVertexPointerListIBM(byval size as GLint, byval type as GLenum, byval stride as GLint, byval pointer as const any ptr ptr, byval ptrstride as GLint)
#endif

const GL_INGR_blend_func_separate = 1
type PFNGLBLENDFUNCSEPARATEINGRPROC as sub(byval sfactorRGB as GLenum, byval dfactorRGB as GLenum, byval sfactorAlpha as GLenum, byval dfactorAlpha as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBlendFuncSeparateINGR(byval sfactorRGB as GLenum, byval dfactorRGB as GLenum, byval sfactorAlpha as GLenum, byval dfactorAlpha as GLenum)
#endif

const GL_INGR_color_clamp = 1
const GL_RED_MIN_CLAMP_INGR = &h8560
const GL_GREEN_MIN_CLAMP_INGR = &h8561
const GL_BLUE_MIN_CLAMP_INGR = &h8562
const GL_ALPHA_MIN_CLAMP_INGR = &h8563
const GL_RED_MAX_CLAMP_INGR = &h8564
const GL_GREEN_MAX_CLAMP_INGR = &h8565
const GL_BLUE_MAX_CLAMP_INGR = &h8566
const GL_ALPHA_MAX_CLAMP_INGR = &h8567
const GL_INGR_interlace_read = 1
const GL_INTERLACE_READ_INGR = &h8568
const GL_INTEL_fragment_shader_ordering = 1
const GL_INTEL_map_texture = 1
const GL_TEXTURE_MEMORY_LAYOUT_INTEL = &h83FF
const GL_LAYOUT_DEFAULT_INTEL = 0
const GL_LAYOUT_LINEAR_INTEL = 1
const GL_LAYOUT_LINEAR_CPU_CACHED_INTEL = 2

type PFNGLSYNCTEXTUREINTELPROC as sub(byval texture as GLuint)
type PFNGLUNMAPTEXTURE2DINTELPROC as sub(byval texture as GLuint, byval level as GLint)
type PFNGLMAPTEXTURE2DINTELPROC as function(byval texture as GLuint, byval level as GLint, byval access as GLbitfield, byval stride as GLint ptr, byval layout as GLenum ptr) as any ptr

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glSyncTextureINTEL(byval texture as GLuint)
	declare sub glUnmapTexture2DINTEL(byval texture as GLuint, byval level as GLint)
	declare function glMapTexture2DINTEL(byval texture as GLuint, byval level as GLint, byval access as GLbitfield, byval stride as GLint ptr, byval layout as GLenum ptr) as any ptr
#endif

const GL_INTEL_parallel_arrays = 1
const GL_PARALLEL_ARRAYS_INTEL = &h83F4
const GL_VERTEX_ARRAY_PARALLEL_POINTERS_INTEL = &h83F5
const GL_NORMAL_ARRAY_PARALLEL_POINTERS_INTEL = &h83F6
const GL_COLOR_ARRAY_PARALLEL_POINTERS_INTEL = &h83F7
const GL_TEXTURE_COORD_ARRAY_PARALLEL_POINTERS_INTEL = &h83F8

type PFNGLVERTEXPOINTERVINTELPROC as sub(byval size as GLint, byval type as GLenum, byval pointer as const any ptr ptr)
type PFNGLNORMALPOINTERVINTELPROC as sub(byval type as GLenum, byval pointer as const any ptr ptr)
type PFNGLCOLORPOINTERVINTELPROC as sub(byval size as GLint, byval type as GLenum, byval pointer as const any ptr ptr)
type PFNGLTEXCOORDPOINTERVINTELPROC as sub(byval size as GLint, byval type as GLenum, byval pointer as const any ptr ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVertexPointervINTEL(byval size as GLint, byval type as GLenum, byval pointer as const any ptr ptr)
	declare sub glNormalPointervINTEL(byval type as GLenum, byval pointer as const any ptr ptr)
	declare sub glColorPointervINTEL(byval size as GLint, byval type as GLenum, byval pointer as const any ptr ptr)
	declare sub glTexCoordPointervINTEL(byval size as GLint, byval type as GLenum, byval pointer as const any ptr ptr)
#endif

const GL_INTEL_performance_query = 1
const GL_PERFQUERY_SINGLE_CONTEXT_INTEL = &h00000000
const GL_PERFQUERY_GLOBAL_CONTEXT_INTEL = &h00000001
const GL_PERFQUERY_WAIT_INTEL = &h83FB
const GL_PERFQUERY_FLUSH_INTEL = &h83FA
const GL_PERFQUERY_DONOT_FLUSH_INTEL = &h83F9
const GL_PERFQUERY_COUNTER_EVENT_INTEL = &h94F0
const GL_PERFQUERY_COUNTER_DURATION_NORM_INTEL = &h94F1
const GL_PERFQUERY_COUNTER_DURATION_RAW_INTEL = &h94F2
const GL_PERFQUERY_COUNTER_THROUGHPUT_INTEL = &h94F3
const GL_PERFQUERY_COUNTER_RAW_INTEL = &h94F4
const GL_PERFQUERY_COUNTER_TIMESTAMP_INTEL = &h94F5
const GL_PERFQUERY_COUNTER_DATA_UINT32_INTEL = &h94F8
const GL_PERFQUERY_COUNTER_DATA_UINT64_INTEL = &h94F9
const GL_PERFQUERY_COUNTER_DATA_FLOAT_INTEL = &h94FA
const GL_PERFQUERY_COUNTER_DATA_DOUBLE_INTEL = &h94FB
const GL_PERFQUERY_COUNTER_DATA_BOOL32_INTEL = &h94FC
const GL_PERFQUERY_QUERY_NAME_LENGTH_MAX_INTEL = &h94FD
const GL_PERFQUERY_COUNTER_NAME_LENGTH_MAX_INTEL = &h94FE
const GL_PERFQUERY_COUNTER_DESC_LENGTH_MAX_INTEL = &h94FF
const GL_PERFQUERY_GPA_EXTENDED_COUNTERS_INTEL = &h9500

type PFNGLBEGINPERFQUERYINTELPROC as sub(byval queryHandle as GLuint)
type PFNGLCREATEPERFQUERYINTELPROC as sub(byval queryId as GLuint, byval queryHandle as GLuint ptr)
type PFNGLDELETEPERFQUERYINTELPROC as sub(byval queryHandle as GLuint)
type PFNGLENDPERFQUERYINTELPROC as sub(byval queryHandle as GLuint)
type PFNGLGETFIRSTPERFQUERYIDINTELPROC as sub(byval queryId as GLuint ptr)
type PFNGLGETNEXTPERFQUERYIDINTELPROC as sub(byval queryId as GLuint, byval nextQueryId as GLuint ptr)
type PFNGLGETPERFCOUNTERINFOINTELPROC as sub(byval queryId as GLuint, byval counterId as GLuint, byval counterNameLength as GLuint, byval counterName as GLchar ptr, byval counterDescLength as GLuint, byval counterDesc as GLchar ptr, byval counterOffset as GLuint ptr, byval counterDataSize as GLuint ptr, byval counterTypeEnum as GLuint ptr, byval counterDataTypeEnum as GLuint ptr, byval rawCounterMaxValue as GLuint64 ptr)
type PFNGLGETPERFQUERYDATAINTELPROC as sub(byval queryHandle as GLuint, byval flags as GLuint, byval dataSize as GLsizei, byval data as GLvoid ptr, byval bytesWritten as GLuint ptr)
type PFNGLGETPERFQUERYIDBYNAMEINTELPROC as sub(byval queryName as GLchar ptr, byval queryId as GLuint ptr)
type PFNGLGETPERFQUERYINFOINTELPROC as sub(byval queryId as GLuint, byval queryNameLength as GLuint, byval queryName as GLchar ptr, byval dataSize as GLuint ptr, byval noCounters as GLuint ptr, byval noInstances as GLuint ptr, byval capsMask as GLuint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBeginPerfQueryINTEL(byval queryHandle as GLuint)
	declare sub glCreatePerfQueryINTEL(byval queryId as GLuint, byval queryHandle as GLuint ptr)
	declare sub glDeletePerfQueryINTEL(byval queryHandle as GLuint)
	declare sub glEndPerfQueryINTEL(byval queryHandle as GLuint)
	declare sub glGetFirstPerfQueryIdINTEL(byval queryId as GLuint ptr)
	declare sub glGetNextPerfQueryIdINTEL(byval queryId as GLuint, byval nextQueryId as GLuint ptr)
	declare sub glGetPerfCounterInfoINTEL(byval queryId as GLuint, byval counterId as GLuint, byval counterNameLength as GLuint, byval counterName as GLchar ptr, byval counterDescLength as GLuint, byval counterDesc as GLchar ptr, byval counterOffset as GLuint ptr, byval counterDataSize as GLuint ptr, byval counterTypeEnum as GLuint ptr, byval counterDataTypeEnum as GLuint ptr, byval rawCounterMaxValue as GLuint64 ptr)
	declare sub glGetPerfQueryDataINTEL(byval queryHandle as GLuint, byval flags as GLuint, byval dataSize as GLsizei, byval data as GLvoid ptr, byval bytesWritten as GLuint ptr)
	declare sub glGetPerfQueryIdByNameINTEL(byval queryName as GLchar ptr, byval queryId as GLuint ptr)
	declare sub glGetPerfQueryInfoINTEL(byval queryId as GLuint, byval queryNameLength as GLuint, byval queryName as GLchar ptr, byval dataSize as GLuint ptr, byval noCounters as GLuint ptr, byval noInstances as GLuint ptr, byval capsMask as GLuint ptr)
#endif

const GL_MESAX_texture_stack = 1
const GL_TEXTURE_1D_STACK_MESAX = &h8759
const GL_TEXTURE_2D_STACK_MESAX = &h875A
const GL_PROXY_TEXTURE_1D_STACK_MESAX = &h875B
const GL_PROXY_TEXTURE_2D_STACK_MESAX = &h875C
const GL_TEXTURE_1D_STACK_BINDING_MESAX = &h875D
const GL_TEXTURE_2D_STACK_BINDING_MESAX = &h875E
const GL_MESA_pack_invert = 1
const GL_PACK_INVERT_MESA = &h8758
const GL_MESA_resize_buffers = 1
type PFNGLRESIZEBUFFERSMESAPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glResizeBuffersMESA()
#endif

const GL_MESA_window_pos = 1
type PFNGLWINDOWPOS2DMESAPROC as sub(byval x as GLdouble, byval y as GLdouble)
type PFNGLWINDOWPOS2DVMESAPROC as sub(byval v as const GLdouble ptr)
type PFNGLWINDOWPOS2FMESAPROC as sub(byval x as GLfloat, byval y as GLfloat)
type PFNGLWINDOWPOS2FVMESAPROC as sub(byval v as const GLfloat ptr)
type PFNGLWINDOWPOS2IMESAPROC as sub(byval x as GLint, byval y as GLint)
type PFNGLWINDOWPOS2IVMESAPROC as sub(byval v as const GLint ptr)
type PFNGLWINDOWPOS2SMESAPROC as sub(byval x as GLshort, byval y as GLshort)
type PFNGLWINDOWPOS2SVMESAPROC as sub(byval v as const GLshort ptr)
type PFNGLWINDOWPOS3DMESAPROC as sub(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLWINDOWPOS3DVMESAPROC as sub(byval v as const GLdouble ptr)
type PFNGLWINDOWPOS3FMESAPROC as sub(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLWINDOWPOS3FVMESAPROC as sub(byval v as const GLfloat ptr)
type PFNGLWINDOWPOS3IMESAPROC as sub(byval x as GLint, byval y as GLint, byval z as GLint)
type PFNGLWINDOWPOS3IVMESAPROC as sub(byval v as const GLint ptr)
type PFNGLWINDOWPOS3SMESAPROC as sub(byval x as GLshort, byval y as GLshort, byval z as GLshort)
type PFNGLWINDOWPOS3SVMESAPROC as sub(byval v as const GLshort ptr)
type PFNGLWINDOWPOS4DMESAPROC as sub(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLWINDOWPOS4DVMESAPROC as sub(byval v as const GLdouble ptr)
type PFNGLWINDOWPOS4FMESAPROC as sub(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
type PFNGLWINDOWPOS4FVMESAPROC as sub(byval v as const GLfloat ptr)
type PFNGLWINDOWPOS4IMESAPROC as sub(byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
type PFNGLWINDOWPOS4IVMESAPROC as sub(byval v as const GLint ptr)
type PFNGLWINDOWPOS4SMESAPROC as sub(byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
type PFNGLWINDOWPOS4SVMESAPROC as sub(byval v as const GLshort ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glWindowPos2dMESA(byval x as GLdouble, byval y as GLdouble)
	declare sub glWindowPos2dvMESA(byval v as const GLdouble ptr)
	declare sub glWindowPos2fMESA(byval x as GLfloat, byval y as GLfloat)
	declare sub glWindowPos2fvMESA(byval v as const GLfloat ptr)
	declare sub glWindowPos2iMESA(byval x as GLint, byval y as GLint)
	declare sub glWindowPos2ivMESA(byval v as const GLint ptr)
	declare sub glWindowPos2sMESA(byval x as GLshort, byval y as GLshort)
	declare sub glWindowPos2svMESA(byval v as const GLshort ptr)
	declare sub glWindowPos3dMESA(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glWindowPos3dvMESA(byval v as const GLdouble ptr)
	declare sub glWindowPos3fMESA(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glWindowPos3fvMESA(byval v as const GLfloat ptr)
	declare sub glWindowPos3iMESA(byval x as GLint, byval y as GLint, byval z as GLint)
	declare sub glWindowPos3ivMESA(byval v as const GLint ptr)
	declare sub glWindowPos3sMESA(byval x as GLshort, byval y as GLshort, byval z as GLshort)
	declare sub glWindowPos3svMESA(byval v as const GLshort ptr)
	declare sub glWindowPos4dMESA(byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glWindowPos4dvMESA(byval v as const GLdouble ptr)
	declare sub glWindowPos4fMESA(byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
	declare sub glWindowPos4fvMESA(byval v as const GLfloat ptr)
	declare sub glWindowPos4iMESA(byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
	declare sub glWindowPos4ivMESA(byval v as const GLint ptr)
	declare sub glWindowPos4sMESA(byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
	declare sub glWindowPos4svMESA(byval v as const GLshort ptr)
#endif

const GL_MESA_ycbcr_texture = 1
const GL_UNSIGNED_SHORT_8_8_MESA = &h85BA
const GL_UNSIGNED_SHORT_8_8_REV_MESA = &h85BB
const GL_YCBCR_MESA = &h8757
const GL_NVX_conditional_render = 1
type PFNGLBEGINCONDITIONALRENDERNVXPROC as sub(byval id as GLuint)
type PFNGLENDCONDITIONALRENDERNVXPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBeginConditionalRenderNVX(byval id as GLuint)
	declare sub glEndConditionalRenderNVX()
#endif

const GL_NVX_gpu_memory_info = 1
const GL_GPU_MEMORY_INFO_DEDICATED_VIDMEM_NVX = &h9047
const GL_GPU_MEMORY_INFO_TOTAL_AVAILABLE_MEMORY_NVX = &h9048
const GL_GPU_MEMORY_INFO_CURRENT_AVAILABLE_VIDMEM_NVX = &h9049
const GL_GPU_MEMORY_INFO_EVICTION_COUNT_NVX = &h904A
const GL_GPU_MEMORY_INFO_EVICTED_MEMORY_NVX = &h904B
const GL_NV_bindless_multi_draw_indirect = 1
type PFNGLMULTIDRAWARRAYSINDIRECTBINDLESSNVPROC as sub(byval mode as GLenum, byval indirect as const any ptr, byval drawCount as GLsizei, byval stride as GLsizei, byval vertexBufferCount as GLint)
type PFNGLMULTIDRAWELEMENTSINDIRECTBINDLESSNVPROC as sub(byval mode as GLenum, byval type as GLenum, byval indirect as const any ptr, byval drawCount as GLsizei, byval stride as GLsizei, byval vertexBufferCount as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glMultiDrawArraysIndirectBindlessNV(byval mode as GLenum, byval indirect as const any ptr, byval drawCount as GLsizei, byval stride as GLsizei, byval vertexBufferCount as GLint)
	declare sub glMultiDrawElementsIndirectBindlessNV(byval mode as GLenum, byval type as GLenum, byval indirect as const any ptr, byval drawCount as GLsizei, byval stride as GLsizei, byval vertexBufferCount as GLint)
#endif

const GL_NV_bindless_multi_draw_indirect_count = 1
type PFNGLMULTIDRAWARRAYSINDIRECTBINDLESSCOUNTNVPROC as sub(byval mode as GLenum, byval indirect as const any ptr, byval drawCount as GLsizei, byval maxDrawCount as GLsizei, byval stride as GLsizei, byval vertexBufferCount as GLint)
type PFNGLMULTIDRAWELEMENTSINDIRECTBINDLESSCOUNTNVPROC as sub(byval mode as GLenum, byval type as GLenum, byval indirect as const any ptr, byval drawCount as GLsizei, byval maxDrawCount as GLsizei, byval stride as GLsizei, byval vertexBufferCount as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glMultiDrawArraysIndirectBindlessCountNV(byval mode as GLenum, byval indirect as const any ptr, byval drawCount as GLsizei, byval maxDrawCount as GLsizei, byval stride as GLsizei, byval vertexBufferCount as GLint)
	declare sub glMultiDrawElementsIndirectBindlessCountNV(byval mode as GLenum, byval type as GLenum, byval indirect as const any ptr, byval drawCount as GLsizei, byval maxDrawCount as GLsizei, byval stride as GLsizei, byval vertexBufferCount as GLint)
#endif

const GL_NV_bindless_texture = 1
type PFNGLGETTEXTUREHANDLENVPROC as function(byval texture as GLuint) as GLuint64
type PFNGLGETTEXTURESAMPLERHANDLENVPROC as function(byval texture as GLuint, byval sampler as GLuint) as GLuint64
type PFNGLMAKETEXTUREHANDLERESIDENTNVPROC as sub(byval handle as GLuint64)
type PFNGLMAKETEXTUREHANDLENONRESIDENTNVPROC as sub(byval handle as GLuint64)
type PFNGLGETIMAGEHANDLENVPROC as function(byval texture as GLuint, byval level as GLint, byval layered as GLboolean, byval layer as GLint, byval format as GLenum) as GLuint64
type PFNGLMAKEIMAGEHANDLERESIDENTNVPROC as sub(byval handle as GLuint64, byval access as GLenum)
type PFNGLMAKEIMAGEHANDLENONRESIDENTNVPROC as sub(byval handle as GLuint64)
type PFNGLUNIFORMHANDLEUI64NVPROC as sub(byval location as GLint, byval value as GLuint64)
type PFNGLUNIFORMHANDLEUI64VNVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint64 ptr)
type PFNGLPROGRAMUNIFORMHANDLEUI64NVPROC as sub(byval program as GLuint, byval location as GLint, byval value as GLuint64)
type PFNGLPROGRAMUNIFORMHANDLEUI64VNVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval values as const GLuint64 ptr)
type PFNGLISTEXTUREHANDLERESIDENTNVPROC as function(byval handle as GLuint64) as GLboolean
type PFNGLISIMAGEHANDLERESIDENTNVPROC as function(byval handle as GLuint64) as GLboolean

#ifdef GL_GLEXT_PROTOTYPES
	declare function glGetTextureHandleNV(byval texture as GLuint) as GLuint64
	declare function glGetTextureSamplerHandleNV(byval texture as GLuint, byval sampler as GLuint) as GLuint64
	declare sub glMakeTextureHandleResidentNV(byval handle as GLuint64)
	declare sub glMakeTextureHandleNonResidentNV(byval handle as GLuint64)
	declare function glGetImageHandleNV(byval texture as GLuint, byval level as GLint, byval layered as GLboolean, byval layer as GLint, byval format as GLenum) as GLuint64
	declare sub glMakeImageHandleResidentNV(byval handle as GLuint64, byval access as GLenum)
	declare sub glMakeImageHandleNonResidentNV(byval handle as GLuint64)
	declare sub glUniformHandleui64NV(byval location as GLint, byval value as GLuint64)
	declare sub glUniformHandleui64vNV(byval location as GLint, byval count as GLsizei, byval value as const GLuint64 ptr)
	declare sub glProgramUniformHandleui64NV(byval program as GLuint, byval location as GLint, byval value as GLuint64)
	declare sub glProgramUniformHandleui64vNV(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval values as const GLuint64 ptr)
	declare function glIsTextureHandleResidentNV(byval handle as GLuint64) as GLboolean
	declare function glIsImageHandleResidentNV(byval handle as GLuint64) as GLboolean
#endif

const GL_NV_blend_equation_advanced = 1
const GL_BLEND_OVERLAP_NV = &h9281
const GL_BLEND_PREMULTIPLIED_SRC_NV = &h9280
const GL_BLUE_NV = &h1905
const GL_COLORBURN_NV = &h929A
const GL_COLORDODGE_NV = &h9299
const GL_CONJOINT_NV = &h9284
const GL_CONTRAST_NV = &h92A1
const GL_DARKEN_NV = &h9297
const GL_DIFFERENCE_NV = &h929E
const GL_DISJOINT_NV = &h9283
const GL_DST_ATOP_NV = &h928F
const GL_DST_IN_NV = &h928B
const GL_DST_NV = &h9287
const GL_DST_OUT_NV = &h928D
const GL_DST_OVER_NV = &h9289
const GL_EXCLUSION_NV = &h92A0
const GL_GREEN_NV = &h1904
const GL_HARDLIGHT_NV = &h929B
const GL_HARDMIX_NV = &h92A9
const GL_HSL_COLOR_NV = &h92AF
const GL_HSL_HUE_NV = &h92AD
const GL_HSL_LUMINOSITY_NV = &h92B0
const GL_HSL_SATURATION_NV = &h92AE
const GL_INVERT_OVG_NV = &h92B4
const GL_INVERT_RGB_NV = &h92A3
const GL_LIGHTEN_NV = &h9298
const GL_LINEARBURN_NV = &h92A5
const GL_LINEARDODGE_NV = &h92A4
const GL_LINEARLIGHT_NV = &h92A7
const GL_MINUS_CLAMPED_NV = &h92B3
const GL_MINUS_NV = &h929F
const GL_MULTIPLY_NV = &h9294
const GL_OVERLAY_NV = &h9296
const GL_PINLIGHT_NV = &h92A8
const GL_PLUS_CLAMPED_ALPHA_NV = &h92B2
const GL_PLUS_CLAMPED_NV = &h92B1
const GL_PLUS_DARKER_NV = &h9292
const GL_PLUS_NV = &h9291
const GL_RED_NV = &h1903
const GL_SCREEN_NV = &h9295
const GL_SOFTLIGHT_NV = &h929C
const GL_SRC_ATOP_NV = &h928E
const GL_SRC_IN_NV = &h928A
const GL_SRC_NV = &h9286
const GL_SRC_OUT_NV = &h928C
const GL_SRC_OVER_NV = &h9288
const GL_UNCORRELATED_NV = &h9282
const GL_VIVIDLIGHT_NV = &h92A6
const GL_XOR_NV = &h1506
type PFNGLBLENDPARAMETERINVPROC as sub(byval pname as GLenum, byval value as GLint)
type PFNGLBLENDBARRIERNVPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBlendParameteriNV(byval pname as GLenum, byval value as GLint)
	declare sub glBlendBarrierNV()
#endif

const GL_NV_blend_equation_advanced_coherent = 1
const GL_BLEND_ADVANCED_COHERENT_NV = &h9285
const GL_NV_blend_square = 1
const GL_NV_compute_program5 = 1
const GL_COMPUTE_PROGRAM_NV = &h90FB
const GL_COMPUTE_PROGRAM_PARAMETER_BUFFER_NV = &h90FC
const GL_NV_conditional_render = 1
const GL_QUERY_WAIT_NV = &h8E13
const GL_QUERY_NO_WAIT_NV = &h8E14
const GL_QUERY_BY_REGION_WAIT_NV = &h8E15
const GL_QUERY_BY_REGION_NO_WAIT_NV = &h8E16
type PFNGLBEGINCONDITIONALRENDERNVPROC as sub(byval id as GLuint, byval mode as GLenum)
type PFNGLENDCONDITIONALRENDERNVPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBeginConditionalRenderNV(byval id as GLuint, byval mode as GLenum)
	declare sub glEndConditionalRenderNV()
#endif

const GL_NV_conservative_raster = 1
const GL_CONSERVATIVE_RASTERIZATION_NV = &h9346
const GL_SUBPIXEL_PRECISION_BIAS_X_BITS_NV = &h9347
const GL_SUBPIXEL_PRECISION_BIAS_Y_BITS_NV = &h9348
const GL_MAX_SUBPIXEL_PRECISION_BIAS_BITS_NV = &h9349
type PFNGLSUBPIXELPRECISIONBIASNVPROC as sub(byval xbits as GLuint, byval ybits as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glSubpixelPrecisionBiasNV(byval xbits as GLuint, byval ybits as GLuint)
#endif

const GL_NV_copy_depth_to_color = 1
const GL_DEPTH_STENCIL_TO_RGBA_NV = &h886E
const GL_DEPTH_STENCIL_TO_BGRA_NV = &h886F
const GL_NV_copy_image = 1
type PFNGLCOPYIMAGESUBDATANVPROC as sub(byval srcName as GLuint, byval srcTarget as GLenum, byval srcLevel as GLint, byval srcX as GLint, byval srcY as GLint, byval srcZ as GLint, byval dstName as GLuint, byval dstTarget as GLenum, byval dstLevel as GLint, byval dstX as GLint, byval dstY as GLint, byval dstZ as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glCopyImageSubDataNV(byval srcName as GLuint, byval srcTarget as GLenum, byval srcLevel as GLint, byval srcX as GLint, byval srcY as GLint, byval srcZ as GLint, byval dstName as GLuint, byval dstTarget as GLenum, byval dstLevel as GLint, byval dstX as GLint, byval dstY as GLint, byval dstZ as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei)
#endif

const GL_NV_deep_texture3D = 1
const GL_MAX_DEEP_3D_TEXTURE_WIDTH_HEIGHT_NV = &h90D0
const GL_MAX_DEEP_3D_TEXTURE_DEPTH_NV = &h90D1
const GL_NV_depth_buffer_float = 1
const GL_DEPTH_COMPONENT32F_NV = &h8DAB
const GL_DEPTH32F_STENCIL8_NV = &h8DAC
const GL_FLOAT_32_UNSIGNED_INT_24_8_REV_NV = &h8DAD
const GL_DEPTH_BUFFER_FLOAT_MODE_NV = &h8DAF

type PFNGLDEPTHRANGEDNVPROC as sub(byval zNear as GLdouble, byval zFar as GLdouble)
type PFNGLCLEARDEPTHDNVPROC as sub(byval depth as GLdouble)
type PFNGLDEPTHBOUNDSDNVPROC as sub(byval zmin as GLdouble, byval zmax as GLdouble)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDepthRangedNV(byval zNear as GLdouble, byval zFar as GLdouble)
	declare sub glClearDepthdNV(byval depth as GLdouble)
	declare sub glDepthBoundsdNV(byval zmin as GLdouble, byval zmax as GLdouble)
#endif

const GL_NV_depth_clamp = 1
const GL_DEPTH_CLAMP_NV = &h864F
const GL_NV_draw_texture = 1
type PFNGLDRAWTEXTURENVPROC as sub(byval texture as GLuint, byval sampler as GLuint, byval x0 as GLfloat, byval y0 as GLfloat, byval x1 as GLfloat, byval y1 as GLfloat, byval z as GLfloat, byval s0 as GLfloat, byval t0 as GLfloat, byval s1 as GLfloat, byval t1 as GLfloat)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDrawTextureNV(byval texture as GLuint, byval sampler as GLuint, byval x0 as GLfloat, byval y0 as GLfloat, byval x1 as GLfloat, byval y1 as GLfloat, byval z as GLfloat, byval s0 as GLfloat, byval t0 as GLfloat, byval s1 as GLfloat, byval t1 as GLfloat)
#endif

const GL_NV_evaluators = 1
const GL_EVAL_2D_NV = &h86C0
const GL_EVAL_TRIANGULAR_2D_NV = &h86C1
const GL_MAP_TESSELLATION_NV = &h86C2
const GL_MAP_ATTRIB_U_ORDER_NV = &h86C3
const GL_MAP_ATTRIB_V_ORDER_NV = &h86C4
const GL_EVAL_FRACTIONAL_TESSELLATION_NV = &h86C5
const GL_EVAL_VERTEX_ATTRIB0_NV = &h86C6
const GL_EVAL_VERTEX_ATTRIB1_NV = &h86C7
const GL_EVAL_VERTEX_ATTRIB2_NV = &h86C8
const GL_EVAL_VERTEX_ATTRIB3_NV = &h86C9
const GL_EVAL_VERTEX_ATTRIB4_NV = &h86CA
const GL_EVAL_VERTEX_ATTRIB5_NV = &h86CB
const GL_EVAL_VERTEX_ATTRIB6_NV = &h86CC
const GL_EVAL_VERTEX_ATTRIB7_NV = &h86CD
const GL_EVAL_VERTEX_ATTRIB8_NV = &h86CE
const GL_EVAL_VERTEX_ATTRIB9_NV = &h86CF
const GL_EVAL_VERTEX_ATTRIB10_NV = &h86D0
const GL_EVAL_VERTEX_ATTRIB11_NV = &h86D1
const GL_EVAL_VERTEX_ATTRIB12_NV = &h86D2
const GL_EVAL_VERTEX_ATTRIB13_NV = &h86D3
const GL_EVAL_VERTEX_ATTRIB14_NV = &h86D4
const GL_EVAL_VERTEX_ATTRIB15_NV = &h86D5
const GL_MAX_MAP_TESSELLATION_NV = &h86D6
const GL_MAX_RATIONAL_EVAL_ORDER_NV = &h86D7

type PFNGLMAPCONTROLPOINTSNVPROC as sub(byval target as GLenum, byval index as GLuint, byval type as GLenum, byval ustride as GLsizei, byval vstride as GLsizei, byval uorder as GLint, byval vorder as GLint, byval packed as GLboolean, byval points as const any ptr)
type PFNGLMAPPARAMETERIVNVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLMAPPARAMETERFVNVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLGETMAPCONTROLPOINTSNVPROC as sub(byval target as GLenum, byval index as GLuint, byval type as GLenum, byval ustride as GLsizei, byval vstride as GLsizei, byval packed as GLboolean, byval points as any ptr)
type PFNGLGETMAPPARAMETERIVNVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETMAPPARAMETERFVNVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETMAPATTRIBPARAMETERIVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETMAPATTRIBPARAMETERFVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLEVALMAPSNVPROC as sub(byval target as GLenum, byval mode as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glMapControlPointsNV(byval target as GLenum, byval index as GLuint, byval type as GLenum, byval ustride as GLsizei, byval vstride as GLsizei, byval uorder as GLint, byval vorder as GLint, byval packed as GLboolean, byval points as const any ptr)
	declare sub glMapParameterivNV(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glMapParameterfvNV(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glGetMapControlPointsNV(byval target as GLenum, byval index as GLuint, byval type as GLenum, byval ustride as GLsizei, byval vstride as GLsizei, byval packed as GLboolean, byval points as any ptr)
	declare sub glGetMapParameterivNV(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetMapParameterfvNV(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetMapAttribParameterivNV(byval target as GLenum, byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetMapAttribParameterfvNV(byval target as GLenum, byval index as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glEvalMapsNV(byval target as GLenum, byval mode as GLenum)
#endif

const GL_NV_explicit_multisample = 1
const GL_SAMPLE_POSITION_NV = &h8E50
const GL_SAMPLE_MASK_NV = &h8E51
const GL_SAMPLE_MASK_VALUE_NV = &h8E52
const GL_TEXTURE_BINDING_RENDERBUFFER_NV = &h8E53
const GL_TEXTURE_RENDERBUFFER_DATA_STORE_BINDING_NV = &h8E54
const GL_TEXTURE_RENDERBUFFER_NV = &h8E55
const GL_SAMPLER_RENDERBUFFER_NV = &h8E56
const GL_INT_SAMPLER_RENDERBUFFER_NV = &h8E57
const GL_UNSIGNED_INT_SAMPLER_RENDERBUFFER_NV = &h8E58
const GL_MAX_SAMPLE_MASK_WORDS_NV = &h8E59

type PFNGLGETMULTISAMPLEFVNVPROC as sub(byval pname as GLenum, byval index as GLuint, byval val as GLfloat ptr)
type PFNGLSAMPLEMASKINDEXEDNVPROC as sub(byval index as GLuint, byval mask as GLbitfield)
type PFNGLTEXRENDERBUFFERNVPROC as sub(byval target as GLenum, byval renderbuffer as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGetMultisamplefvNV(byval pname as GLenum, byval index as GLuint, byval val as GLfloat ptr)
	declare sub glSampleMaskIndexedNV(byval index as GLuint, byval mask as GLbitfield)
	declare sub glTexRenderbufferNV(byval target as GLenum, byval renderbuffer as GLuint)
#endif

const GL_NV_fence = 1
const GL_ALL_COMPLETED_NV = &h84F2
const GL_FENCE_STATUS_NV = &h84F3
const GL_FENCE_CONDITION_NV = &h84F4

type PFNGLDELETEFENCESNVPROC as sub(byval n as GLsizei, byval fences as const GLuint ptr)
type PFNGLGENFENCESNVPROC as sub(byval n as GLsizei, byval fences as GLuint ptr)
type PFNGLISFENCENVPROC as function(byval fence as GLuint) as GLboolean
type PFNGLTESTFENCENVPROC as function(byval fence as GLuint) as GLboolean
type PFNGLGETFENCEIVNVPROC as sub(byval fence as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLFINISHFENCENVPROC as sub(byval fence as GLuint)
type PFNGLSETFENCENVPROC as sub(byval fence as GLuint, byval condition as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDeleteFencesNV(byval n as GLsizei, byval fences as const GLuint ptr)
	declare sub glGenFencesNV(byval n as GLsizei, byval fences as GLuint ptr)
	declare function glIsFenceNV(byval fence as GLuint) as GLboolean
	declare function glTestFenceNV(byval fence as GLuint) as GLboolean
	declare sub glGetFenceivNV(byval fence as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glFinishFenceNV(byval fence as GLuint)
	declare sub glSetFenceNV(byval fence as GLuint, byval condition as GLenum)
#endif

const GL_NV_fill_rectangle = 1
const GL_FILL_RECTANGLE_NV = &h933C
const GL_NV_float_buffer = 1
const GL_FLOAT_R_NV = &h8880
const GL_FLOAT_RG_NV = &h8881
const GL_FLOAT_RGB_NV = &h8882
const GL_FLOAT_RGBA_NV = &h8883
const GL_FLOAT_R16_NV = &h8884
const GL_FLOAT_R32_NV = &h8885
const GL_FLOAT_RG16_NV = &h8886
const GL_FLOAT_RG32_NV = &h8887
const GL_FLOAT_RGB16_NV = &h8888
const GL_FLOAT_RGB32_NV = &h8889
const GL_FLOAT_RGBA16_NV = &h888A
const GL_FLOAT_RGBA32_NV = &h888B
const GL_TEXTURE_FLOAT_COMPONENTS_NV = &h888C
const GL_FLOAT_CLEAR_COLOR_VALUE_NV = &h888D
const GL_FLOAT_RGBA_MODE_NV = &h888E
const GL_NV_fog_distance = 1
const GL_FOG_DISTANCE_MODE_NV = &h855A
const GL_EYE_RADIAL_NV = &h855B
const GL_EYE_PLANE_ABSOLUTE_NV = &h855C
const GL_NV_fragment_coverage_to_color = 1
const GL_FRAGMENT_COVERAGE_TO_COLOR_NV = &h92DD
const GL_FRAGMENT_COVERAGE_COLOR_NV = &h92DE
type PFNGLFRAGMENTCOVERAGECOLORNVPROC as sub(byval color as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glFragmentCoverageColorNV(byval color as GLuint)
#endif

const GL_NV_fragment_program = 1
const GL_MAX_FRAGMENT_PROGRAM_LOCAL_PARAMETERS_NV = &h8868
const GL_FRAGMENT_PROGRAM_NV = &h8870
const GL_MAX_TEXTURE_COORDS_NV = &h8871
const GL_MAX_TEXTURE_IMAGE_UNITS_NV = &h8872
const GL_FRAGMENT_PROGRAM_BINDING_NV = &h8873
const GL_PROGRAM_ERROR_STRING_NV = &h8874

type PFNGLPROGRAMNAMEDPARAMETER4FNVPROC as sub(byval id as GLuint, byval len as GLsizei, byval name as const GLubyte ptr, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
type PFNGLPROGRAMNAMEDPARAMETER4FVNVPROC as sub(byval id as GLuint, byval len as GLsizei, byval name as const GLubyte ptr, byval v as const GLfloat ptr)
type PFNGLPROGRAMNAMEDPARAMETER4DNVPROC as sub(byval id as GLuint, byval len as GLsizei, byval name as const GLubyte ptr, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLPROGRAMNAMEDPARAMETER4DVNVPROC as sub(byval id as GLuint, byval len as GLsizei, byval name as const GLubyte ptr, byval v as const GLdouble ptr)
type PFNGLGETPROGRAMNAMEDPARAMETERFVNVPROC as sub(byval id as GLuint, byval len as GLsizei, byval name as const GLubyte ptr, byval params as GLfloat ptr)
type PFNGLGETPROGRAMNAMEDPARAMETERDVNVPROC as sub(byval id as GLuint, byval len as GLsizei, byval name as const GLubyte ptr, byval params as GLdouble ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glProgramNamedParameter4fNV(byval id as GLuint, byval len as GLsizei, byval name as const GLubyte ptr, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
	declare sub glProgramNamedParameter4fvNV(byval id as GLuint, byval len as GLsizei, byval name as const GLubyte ptr, byval v as const GLfloat ptr)
	declare sub glProgramNamedParameter4dNV(byval id as GLuint, byval len as GLsizei, byval name as const GLubyte ptr, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glProgramNamedParameter4dvNV(byval id as GLuint, byval len as GLsizei, byval name as const GLubyte ptr, byval v as const GLdouble ptr)
	declare sub glGetProgramNamedParameterfvNV(byval id as GLuint, byval len as GLsizei, byval name as const GLubyte ptr, byval params as GLfloat ptr)
	declare sub glGetProgramNamedParameterdvNV(byval id as GLuint, byval len as GLsizei, byval name as const GLubyte ptr, byval params as GLdouble ptr)
#endif

const GL_NV_fragment_program2 = 1
const GL_MAX_PROGRAM_EXEC_INSTRUCTIONS_NV = &h88F4
const GL_MAX_PROGRAM_CALL_DEPTH_NV = &h88F5
const GL_MAX_PROGRAM_IF_DEPTH_NV = &h88F6
const GL_MAX_PROGRAM_LOOP_DEPTH_NV = &h88F7
const GL_MAX_PROGRAM_LOOP_COUNT_NV = &h88F8
const GL_NV_fragment_program4 = 1
const GL_NV_fragment_program_option = 1
const GL_NV_fragment_shader_interlock = 1
const GL_NV_framebuffer_mixed_samples = 1
const GL_COVERAGE_MODULATION_TABLE_NV = &h9331
const GL_COLOR_SAMPLES_NV = &h8E20
const GL_DEPTH_SAMPLES_NV = &h932D
const GL_STENCIL_SAMPLES_NV = &h932E
const GL_MIXED_DEPTH_SAMPLES_SUPPORTED_NV = &h932F
const GL_MIXED_STENCIL_SAMPLES_SUPPORTED_NV = &h9330
const GL_COVERAGE_MODULATION_NV = &h9332
const GL_COVERAGE_MODULATION_TABLE_SIZE_NV = &h9333

type PFNGLCOVERAGEMODULATIONTABLENVPROC as sub(byval n as GLsizei, byval v as const GLfloat ptr)
type PFNGLGETCOVERAGEMODULATIONTABLENVPROC as sub(byval bufsize as GLsizei, byval v as GLfloat ptr)
type PFNGLCOVERAGEMODULATIONNVPROC as sub(byval components as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glCoverageModulationTableNV(byval n as GLsizei, byval v as const GLfloat ptr)
	declare sub glGetCoverageModulationTableNV(byval bufsize as GLsizei, byval v as GLfloat ptr)
	declare sub glCoverageModulationNV(byval components as GLenum)
#endif

const GL_NV_framebuffer_multisample_coverage = 1
const GL_RENDERBUFFER_COVERAGE_SAMPLES_NV = &h8CAB
const GL_RENDERBUFFER_COLOR_SAMPLES_NV = &h8E10
const GL_MAX_MULTISAMPLE_COVERAGE_MODES_NV = &h8E11
const GL_MULTISAMPLE_COVERAGE_MODES_NV = &h8E12
type PFNGLRENDERBUFFERSTORAGEMULTISAMPLECOVERAGENVPROC as sub(byval target as GLenum, byval coverageSamples as GLsizei, byval colorSamples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glRenderbufferStorageMultisampleCoverageNV(byval target as GLenum, byval coverageSamples as GLsizei, byval colorSamples as GLsizei, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei)
#endif

const GL_NV_geometry_program4 = 1
const GL_GEOMETRY_PROGRAM_NV = &h8C26
const GL_MAX_PROGRAM_OUTPUT_VERTICES_NV = &h8C27
const GL_MAX_PROGRAM_TOTAL_OUTPUT_COMPONENTS_NV = &h8C28

type PFNGLPROGRAMVERTEXLIMITNVPROC as sub(byval target as GLenum, byval limit as GLint)
type PFNGLFRAMEBUFFERTEXTUREEXTPROC as sub(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint)
type PFNGLFRAMEBUFFERTEXTUREFACEEXTPROC as sub(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval face as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glProgramVertexLimitNV(byval target as GLenum, byval limit as GLint)
	declare sub glFramebufferTextureEXT(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint)
	declare sub glFramebufferTextureFaceEXT(byval target as GLenum, byval attachment as GLenum, byval texture as GLuint, byval level as GLint, byval face as GLenum)
#endif

const GL_NV_geometry_shader4 = 1
const GL_NV_geometry_shader_passthrough = 1
const GL_NV_gpu_program4 = 1
const GL_MIN_PROGRAM_TEXEL_OFFSET_NV = &h8904
const GL_MAX_PROGRAM_TEXEL_OFFSET_NV = &h8905
const GL_PROGRAM_ATTRIB_COMPONENTS_NV = &h8906
const GL_PROGRAM_RESULT_COMPONENTS_NV = &h8907
const GL_MAX_PROGRAM_ATTRIB_COMPONENTS_NV = &h8908
const GL_MAX_PROGRAM_RESULT_COMPONENTS_NV = &h8909
const GL_MAX_PROGRAM_GENERIC_ATTRIBS_NV = &h8DA5
const GL_MAX_PROGRAM_GENERIC_RESULTS_NV = &h8DA6

type PFNGLPROGRAMLOCALPARAMETERI4INVPROC as sub(byval target as GLenum, byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
type PFNGLPROGRAMLOCALPARAMETERI4IVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval params as const GLint ptr)
type PFNGLPROGRAMLOCALPARAMETERSI4IVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLint ptr)
type PFNGLPROGRAMLOCALPARAMETERI4UINVPROC as sub(byval target as GLenum, byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint, byval w as GLuint)
type PFNGLPROGRAMLOCALPARAMETERI4UIVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval params as const GLuint ptr)
type PFNGLPROGRAMLOCALPARAMETERSI4UIVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLuint ptr)
type PFNGLPROGRAMENVPARAMETERI4INVPROC as sub(byval target as GLenum, byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
type PFNGLPROGRAMENVPARAMETERI4IVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval params as const GLint ptr)
type PFNGLPROGRAMENVPARAMETERSI4IVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLint ptr)
type PFNGLPROGRAMENVPARAMETERI4UINVPROC as sub(byval target as GLenum, byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint, byval w as GLuint)
type PFNGLPROGRAMENVPARAMETERI4UIVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval params as const GLuint ptr)
type PFNGLPROGRAMENVPARAMETERSI4UIVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLuint ptr)
type PFNGLGETPROGRAMLOCALPARAMETERIIVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval params as GLint ptr)
type PFNGLGETPROGRAMLOCALPARAMETERIUIVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval params as GLuint ptr)
type PFNGLGETPROGRAMENVPARAMETERIIVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval params as GLint ptr)
type PFNGLGETPROGRAMENVPARAMETERIUIVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval params as GLuint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glProgramLocalParameterI4iNV(byval target as GLenum, byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
	declare sub glProgramLocalParameterI4ivNV(byval target as GLenum, byval index as GLuint, byval params as const GLint ptr)
	declare sub glProgramLocalParametersI4ivNV(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLint ptr)
	declare sub glProgramLocalParameterI4uiNV(byval target as GLenum, byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint, byval w as GLuint)
	declare sub glProgramLocalParameterI4uivNV(byval target as GLenum, byval index as GLuint, byval params as const GLuint ptr)
	declare sub glProgramLocalParametersI4uivNV(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLuint ptr)
	declare sub glProgramEnvParameterI4iNV(byval target as GLenum, byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
	declare sub glProgramEnvParameterI4ivNV(byval target as GLenum, byval index as GLuint, byval params as const GLint ptr)
	declare sub glProgramEnvParametersI4ivNV(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLint ptr)
	declare sub glProgramEnvParameterI4uiNV(byval target as GLenum, byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint, byval w as GLuint)
	declare sub glProgramEnvParameterI4uivNV(byval target as GLenum, byval index as GLuint, byval params as const GLuint ptr)
	declare sub glProgramEnvParametersI4uivNV(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval params as const GLuint ptr)
	declare sub glGetProgramLocalParameterIivNV(byval target as GLenum, byval index as GLuint, byval params as GLint ptr)
	declare sub glGetProgramLocalParameterIuivNV(byval target as GLenum, byval index as GLuint, byval params as GLuint ptr)
	declare sub glGetProgramEnvParameterIivNV(byval target as GLenum, byval index as GLuint, byval params as GLint ptr)
	declare sub glGetProgramEnvParameterIuivNV(byval target as GLenum, byval index as GLuint, byval params as GLuint ptr)
#endif

const GL_NV_gpu_program5 = 1
const GL_MAX_GEOMETRY_PROGRAM_INVOCATIONS_NV = &h8E5A
const GL_MIN_FRAGMENT_INTERPOLATION_OFFSET_NV = &h8E5B
const GL_MAX_FRAGMENT_INTERPOLATION_OFFSET_NV = &h8E5C
const GL_FRAGMENT_PROGRAM_INTERPOLATION_OFFSET_BITS_NV = &h8E5D
const GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_NV = &h8E5E
const GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_NV = &h8E5F
const GL_MAX_PROGRAM_SUBROUTINE_PARAMETERS_NV = &h8F44
const GL_MAX_PROGRAM_SUBROUTINE_NUM_NV = &h8F45
type PFNGLPROGRAMSUBROUTINEPARAMETERSUIVNVPROC as sub(byval target as GLenum, byval count as GLsizei, byval params as const GLuint ptr)
type PFNGLGETPROGRAMSUBROUTINEPARAMETERUIVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval param as GLuint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glProgramSubroutineParametersuivNV(byval target as GLenum, byval count as GLsizei, byval params as const GLuint ptr)
	declare sub glGetProgramSubroutineParameteruivNV(byval target as GLenum, byval index as GLuint, byval param as GLuint ptr)
#endif

const GL_NV_gpu_program5_mem_extended = 1
const GL_NV_gpu_shader5 = 1
const GL_NV_half_float = 1
type GLhalfNV as ushort
const GL_HALF_FLOAT_NV = &h140B

type PFNGLVERTEX2HNVPROC as sub(byval x as GLhalfNV, byval y as GLhalfNV)
type PFNGLVERTEX2HVNVPROC as sub(byval v as const GLhalfNV ptr)
type PFNGLVERTEX3HNVPROC as sub(byval x as GLhalfNV, byval y as GLhalfNV, byval z as GLhalfNV)
type PFNGLVERTEX3HVNVPROC as sub(byval v as const GLhalfNV ptr)
type PFNGLVERTEX4HNVPROC as sub(byval x as GLhalfNV, byval y as GLhalfNV, byval z as GLhalfNV, byval w as GLhalfNV)
type PFNGLVERTEX4HVNVPROC as sub(byval v as const GLhalfNV ptr)
type PFNGLNORMAL3HNVPROC as sub(byval nx as GLhalfNV, byval ny as GLhalfNV, byval nz as GLhalfNV)
type PFNGLNORMAL3HVNVPROC as sub(byval v as const GLhalfNV ptr)
type PFNGLCOLOR3HNVPROC as sub(byval red as GLhalfNV, byval green as GLhalfNV, byval blue as GLhalfNV)
type PFNGLCOLOR3HVNVPROC as sub(byval v as const GLhalfNV ptr)
type PFNGLCOLOR4HNVPROC as sub(byval red as GLhalfNV, byval green as GLhalfNV, byval blue as GLhalfNV, byval alpha as GLhalfNV)
type PFNGLCOLOR4HVNVPROC as sub(byval v as const GLhalfNV ptr)
type PFNGLTEXCOORD1HNVPROC as sub(byval s as GLhalfNV)
type PFNGLTEXCOORD1HVNVPROC as sub(byval v as const GLhalfNV ptr)
type PFNGLTEXCOORD2HNVPROC as sub(byval s as GLhalfNV, byval t as GLhalfNV)
type PFNGLTEXCOORD2HVNVPROC as sub(byval v as const GLhalfNV ptr)
type PFNGLTEXCOORD3HNVPROC as sub(byval s as GLhalfNV, byval t as GLhalfNV, byval r as GLhalfNV)
type PFNGLTEXCOORD3HVNVPROC as sub(byval v as const GLhalfNV ptr)
type PFNGLTEXCOORD4HNVPROC as sub(byval s as GLhalfNV, byval t as GLhalfNV, byval r as GLhalfNV, byval q as GLhalfNV)
type PFNGLTEXCOORD4HVNVPROC as sub(byval v as const GLhalfNV ptr)
type PFNGLMULTITEXCOORD1HNVPROC as sub(byval target as GLenum, byval s as GLhalfNV)
type PFNGLMULTITEXCOORD1HVNVPROC as sub(byval target as GLenum, byval v as const GLhalfNV ptr)
type PFNGLMULTITEXCOORD2HNVPROC as sub(byval target as GLenum, byval s as GLhalfNV, byval t as GLhalfNV)
type PFNGLMULTITEXCOORD2HVNVPROC as sub(byval target as GLenum, byval v as const GLhalfNV ptr)
type PFNGLMULTITEXCOORD3HNVPROC as sub(byval target as GLenum, byval s as GLhalfNV, byval t as GLhalfNV, byval r as GLhalfNV)
type PFNGLMULTITEXCOORD3HVNVPROC as sub(byval target as GLenum, byval v as const GLhalfNV ptr)
type PFNGLMULTITEXCOORD4HNVPROC as sub(byval target as GLenum, byval s as GLhalfNV, byval t as GLhalfNV, byval r as GLhalfNV, byval q as GLhalfNV)
type PFNGLMULTITEXCOORD4HVNVPROC as sub(byval target as GLenum, byval v as const GLhalfNV ptr)
type PFNGLFOGCOORDHNVPROC as sub(byval fog as GLhalfNV)
type PFNGLFOGCOORDHVNVPROC as sub(byval fog as const GLhalfNV ptr)
type PFNGLSECONDARYCOLOR3HNVPROC as sub(byval red as GLhalfNV, byval green as GLhalfNV, byval blue as GLhalfNV)
type PFNGLSECONDARYCOLOR3HVNVPROC as sub(byval v as const GLhalfNV ptr)
type PFNGLVERTEXWEIGHTHNVPROC as sub(byval weight as GLhalfNV)
type PFNGLVERTEXWEIGHTHVNVPROC as sub(byval weight as const GLhalfNV ptr)
type PFNGLVERTEXATTRIB1HNVPROC as sub(byval index as GLuint, byval x as GLhalfNV)
type PFNGLVERTEXATTRIB1HVNVPROC as sub(byval index as GLuint, byval v as const GLhalfNV ptr)
type PFNGLVERTEXATTRIB2HNVPROC as sub(byval index as GLuint, byval x as GLhalfNV, byval y as GLhalfNV)
type PFNGLVERTEXATTRIB2HVNVPROC as sub(byval index as GLuint, byval v as const GLhalfNV ptr)
type PFNGLVERTEXATTRIB3HNVPROC as sub(byval index as GLuint, byval x as GLhalfNV, byval y as GLhalfNV, byval z as GLhalfNV)
type PFNGLVERTEXATTRIB3HVNVPROC as sub(byval index as GLuint, byval v as const GLhalfNV ptr)
type PFNGLVERTEXATTRIB4HNVPROC as sub(byval index as GLuint, byval x as GLhalfNV, byval y as GLhalfNV, byval z as GLhalfNV, byval w as GLhalfNV)
type PFNGLVERTEXATTRIB4HVNVPROC as sub(byval index as GLuint, byval v as const GLhalfNV ptr)
type PFNGLVERTEXATTRIBS1HVNVPROC as sub(byval index as GLuint, byval n as GLsizei, byval v as const GLhalfNV ptr)
type PFNGLVERTEXATTRIBS2HVNVPROC as sub(byval index as GLuint, byval n as GLsizei, byval v as const GLhalfNV ptr)
type PFNGLVERTEXATTRIBS3HVNVPROC as sub(byval index as GLuint, byval n as GLsizei, byval v as const GLhalfNV ptr)
type PFNGLVERTEXATTRIBS4HVNVPROC as sub(byval index as GLuint, byval n as GLsizei, byval v as const GLhalfNV ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVertex2hNV(byval x as GLhalfNV, byval y as GLhalfNV)
	declare sub glVertex2hvNV(byval v as const GLhalfNV ptr)
	declare sub glVertex3hNV(byval x as GLhalfNV, byval y as GLhalfNV, byval z as GLhalfNV)
	declare sub glVertex3hvNV(byval v as const GLhalfNV ptr)
	declare sub glVertex4hNV(byval x as GLhalfNV, byval y as GLhalfNV, byval z as GLhalfNV, byval w as GLhalfNV)
	declare sub glVertex4hvNV(byval v as const GLhalfNV ptr)
	declare sub glNormal3hNV(byval nx as GLhalfNV, byval ny as GLhalfNV, byval nz as GLhalfNV)
	declare sub glNormal3hvNV(byval v as const GLhalfNV ptr)
	declare sub glColor3hNV(byval red as GLhalfNV, byval green as GLhalfNV, byval blue as GLhalfNV)
	declare sub glColor3hvNV(byval v as const GLhalfNV ptr)
	declare sub glColor4hNV(byval red as GLhalfNV, byval green as GLhalfNV, byval blue as GLhalfNV, byval alpha as GLhalfNV)
	declare sub glColor4hvNV(byval v as const GLhalfNV ptr)
	declare sub glTexCoord1hNV(byval s as GLhalfNV)
	declare sub glTexCoord1hvNV(byval v as const GLhalfNV ptr)
	declare sub glTexCoord2hNV(byval s as GLhalfNV, byval t as GLhalfNV)
	declare sub glTexCoord2hvNV(byval v as const GLhalfNV ptr)
	declare sub glTexCoord3hNV(byval s as GLhalfNV, byval t as GLhalfNV, byval r as GLhalfNV)
	declare sub glTexCoord3hvNV(byval v as const GLhalfNV ptr)
	declare sub glTexCoord4hNV(byval s as GLhalfNV, byval t as GLhalfNV, byval r as GLhalfNV, byval q as GLhalfNV)
	declare sub glTexCoord4hvNV(byval v as const GLhalfNV ptr)
	declare sub glMultiTexCoord1hNV(byval target as GLenum, byval s as GLhalfNV)
	declare sub glMultiTexCoord1hvNV(byval target as GLenum, byval v as const GLhalfNV ptr)
	declare sub glMultiTexCoord2hNV(byval target as GLenum, byval s as GLhalfNV, byval t as GLhalfNV)
	declare sub glMultiTexCoord2hvNV(byval target as GLenum, byval v as const GLhalfNV ptr)
	declare sub glMultiTexCoord3hNV(byval target as GLenum, byval s as GLhalfNV, byval t as GLhalfNV, byval r as GLhalfNV)
	declare sub glMultiTexCoord3hvNV(byval target as GLenum, byval v as const GLhalfNV ptr)
	declare sub glMultiTexCoord4hNV(byval target as GLenum, byval s as GLhalfNV, byval t as GLhalfNV, byval r as GLhalfNV, byval q as GLhalfNV)
	declare sub glMultiTexCoord4hvNV(byval target as GLenum, byval v as const GLhalfNV ptr)
	declare sub glFogCoordhNV(byval fog as GLhalfNV)
	declare sub glFogCoordhvNV(byval fog as const GLhalfNV ptr)
	declare sub glSecondaryColor3hNV(byval red as GLhalfNV, byval green as GLhalfNV, byval blue as GLhalfNV)
	declare sub glSecondaryColor3hvNV(byval v as const GLhalfNV ptr)
	declare sub glVertexWeighthNV(byval weight as GLhalfNV)
	declare sub glVertexWeighthvNV(byval weight as const GLhalfNV ptr)
	declare sub glVertexAttrib1hNV(byval index as GLuint, byval x as GLhalfNV)
	declare sub glVertexAttrib1hvNV(byval index as GLuint, byval v as const GLhalfNV ptr)
	declare sub glVertexAttrib2hNV(byval index as GLuint, byval x as GLhalfNV, byval y as GLhalfNV)
	declare sub glVertexAttrib2hvNV(byval index as GLuint, byval v as const GLhalfNV ptr)
	declare sub glVertexAttrib3hNV(byval index as GLuint, byval x as GLhalfNV, byval y as GLhalfNV, byval z as GLhalfNV)
	declare sub glVertexAttrib3hvNV(byval index as GLuint, byval v as const GLhalfNV ptr)
	declare sub glVertexAttrib4hNV(byval index as GLuint, byval x as GLhalfNV, byval y as GLhalfNV, byval z as GLhalfNV, byval w as GLhalfNV)
	declare sub glVertexAttrib4hvNV(byval index as GLuint, byval v as const GLhalfNV ptr)
	declare sub glVertexAttribs1hvNV(byval index as GLuint, byval n as GLsizei, byval v as const GLhalfNV ptr)
	declare sub glVertexAttribs2hvNV(byval index as GLuint, byval n as GLsizei, byval v as const GLhalfNV ptr)
	declare sub glVertexAttribs3hvNV(byval index as GLuint, byval n as GLsizei, byval v as const GLhalfNV ptr)
	declare sub glVertexAttribs4hvNV(byval index as GLuint, byval n as GLsizei, byval v as const GLhalfNV ptr)
#endif

const GL_NV_internalformat_sample_query = 1
const GL_MULTISAMPLES_NV = &h9371
const GL_SUPERSAMPLE_SCALE_X_NV = &h9372
const GL_SUPERSAMPLE_SCALE_Y_NV = &h9373
const GL_CONFORMANT_NV = &h9374
type PFNGLGETINTERNALFORMATSAMPLEIVNVPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval samples as GLsizei, byval pname as GLenum, byval bufSize as GLsizei, byval params as GLint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGetInternalformatSampleivNV(byval target as GLenum, byval internalformat as GLenum, byval samples as GLsizei, byval pname as GLenum, byval bufSize as GLsizei, byval params as GLint ptr)
#endif

const GL_NV_light_max_exponent = 1
const GL_MAX_SHININESS_NV = &h8504
const GL_MAX_SPOT_EXPONENT_NV = &h8505
const GL_NV_multisample_coverage = 1
const GL_NV_multisample_filter_hint = 1
const GL_MULTISAMPLE_FILTER_HINT_NV = &h8534
const GL_NV_occlusion_query = 1
const GL_PIXEL_COUNTER_BITS_NV = &h8864
const GL_CURRENT_OCCLUSION_QUERY_ID_NV = &h8865
const GL_PIXEL_COUNT_NV = &h8866
const GL_PIXEL_COUNT_AVAILABLE_NV = &h8867

type PFNGLGENOCCLUSIONQUERIESNVPROC as sub(byval n as GLsizei, byval ids as GLuint ptr)
type PFNGLDELETEOCCLUSIONQUERIESNVPROC as sub(byval n as GLsizei, byval ids as const GLuint ptr)
type PFNGLISOCCLUSIONQUERYNVPROC as function(byval id as GLuint) as GLboolean
type PFNGLBEGINOCCLUSIONQUERYNVPROC as sub(byval id as GLuint)
type PFNGLENDOCCLUSIONQUERYNVPROC as sub()
type PFNGLGETOCCLUSIONQUERYIVNVPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETOCCLUSIONQUERYUIVNVPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLuint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGenOcclusionQueriesNV(byval n as GLsizei, byval ids as GLuint ptr)
	declare sub glDeleteOcclusionQueriesNV(byval n as GLsizei, byval ids as const GLuint ptr)
	declare function glIsOcclusionQueryNV(byval id as GLuint) as GLboolean
	declare sub glBeginOcclusionQueryNV(byval id as GLuint)
	declare sub glEndOcclusionQueryNV()
	declare sub glGetOcclusionQueryivNV(byval id as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetOcclusionQueryuivNV(byval id as GLuint, byval pname as GLenum, byval params as GLuint ptr)
#endif

const GL_NV_packed_depth_stencil = 1
const GL_DEPTH_STENCIL_NV = &h84F9
const GL_UNSIGNED_INT_24_8_NV = &h84FA
const GL_NV_parameter_buffer_object = 1
const GL_MAX_PROGRAM_PARAMETER_BUFFER_BINDINGS_NV = &h8DA0
const GL_MAX_PROGRAM_PARAMETER_BUFFER_SIZE_NV = &h8DA1
const GL_VERTEX_PROGRAM_PARAMETER_BUFFER_NV = &h8DA2
const GL_GEOMETRY_PROGRAM_PARAMETER_BUFFER_NV = &h8DA3
const GL_FRAGMENT_PROGRAM_PARAMETER_BUFFER_NV = &h8DA4

type PFNGLPROGRAMBUFFERPARAMETERSFVNVPROC as sub(byval target as GLenum, byval bindingIndex as GLuint, byval wordIndex as GLuint, byval count as GLsizei, byval params as const GLfloat ptr)
type PFNGLPROGRAMBUFFERPARAMETERSIIVNVPROC as sub(byval target as GLenum, byval bindingIndex as GLuint, byval wordIndex as GLuint, byval count as GLsizei, byval params as const GLint ptr)
type PFNGLPROGRAMBUFFERPARAMETERSIUIVNVPROC as sub(byval target as GLenum, byval bindingIndex as GLuint, byval wordIndex as GLuint, byval count as GLsizei, byval params as const GLuint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glProgramBufferParametersfvNV(byval target as GLenum, byval bindingIndex as GLuint, byval wordIndex as GLuint, byval count as GLsizei, byval params as const GLfloat ptr)
	declare sub glProgramBufferParametersIivNV(byval target as GLenum, byval bindingIndex as GLuint, byval wordIndex as GLuint, byval count as GLsizei, byval params as const GLint ptr)
	declare sub glProgramBufferParametersIuivNV(byval target as GLenum, byval bindingIndex as GLuint, byval wordIndex as GLuint, byval count as GLsizei, byval params as const GLuint ptr)
#endif

const GL_NV_parameter_buffer_object2 = 1
const GL_NV_path_rendering = 1
const GL_PATH_FORMAT_SVG_NV = &h9070
const GL_PATH_FORMAT_PS_NV = &h9071
const GL_STANDARD_FONT_NAME_NV = &h9072
const GL_SYSTEM_FONT_NAME_NV = &h9073
const GL_FILE_NAME_NV = &h9074
const GL_PATH_STROKE_WIDTH_NV = &h9075
const GL_PATH_END_CAPS_NV = &h9076
const GL_PATH_INITIAL_END_CAP_NV = &h9077
const GL_PATH_TERMINAL_END_CAP_NV = &h9078
const GL_PATH_JOIN_STYLE_NV = &h9079
const GL_PATH_MITER_LIMIT_NV = &h907A
const GL_PATH_DASH_CAPS_NV = &h907B
const GL_PATH_INITIAL_DASH_CAP_NV = &h907C
const GL_PATH_TERMINAL_DASH_CAP_NV = &h907D
const GL_PATH_DASH_OFFSET_NV = &h907E
const GL_PATH_CLIENT_LENGTH_NV = &h907F
const GL_PATH_FILL_MODE_NV = &h9080
const GL_PATH_FILL_MASK_NV = &h9081
const GL_PATH_FILL_COVER_MODE_NV = &h9082
const GL_PATH_STROKE_COVER_MODE_NV = &h9083
const GL_PATH_STROKE_MASK_NV = &h9084
const GL_COUNT_UP_NV = &h9088
const GL_COUNT_DOWN_NV = &h9089
const GL_PATH_OBJECT_BOUNDING_BOX_NV = &h908A
const GL_CONVEX_HULL_NV = &h908B
const GL_BOUNDING_BOX_NV = &h908D
const GL_TRANSLATE_X_NV = &h908E
const GL_TRANSLATE_Y_NV = &h908F
const GL_TRANSLATE_2D_NV = &h9090
const GL_TRANSLATE_3D_NV = &h9091
const GL_AFFINE_2D_NV = &h9092
const GL_AFFINE_3D_NV = &h9094
const GL_TRANSPOSE_AFFINE_2D_NV = &h9096
const GL_TRANSPOSE_AFFINE_3D_NV = &h9098
const GL_UTF8_NV = &h909A
const GL_UTF16_NV = &h909B
const GL_BOUNDING_BOX_OF_BOUNDING_BOXES_NV = &h909C
const GL_PATH_COMMAND_COUNT_NV = &h909D
const GL_PATH_COORD_COUNT_NV = &h909E
const GL_PATH_DASH_ARRAY_COUNT_NV = &h909F
const GL_PATH_COMPUTED_LENGTH_NV = &h90A0
const GL_PATH_FILL_BOUNDING_BOX_NV = &h90A1
const GL_PATH_STROKE_BOUNDING_BOX_NV = &h90A2
const GL_SQUARE_NV = &h90A3
const GL_ROUND_NV = &h90A4
const GL_TRIANGULAR_NV = &h90A5
const GL_BEVEL_NV = &h90A6
const GL_MITER_REVERT_NV = &h90A7
const GL_MITER_TRUNCATE_NV = &h90A8
const GL_SKIP_MISSING_GLYPH_NV = &h90A9
const GL_USE_MISSING_GLYPH_NV = &h90AA
const GL_PATH_ERROR_POSITION_NV = &h90AB
const GL_ACCUM_ADJACENT_PAIRS_NV = &h90AD
const GL_ADJACENT_PAIRS_NV = &h90AE
const GL_FIRST_TO_REST_NV = &h90AF
const GL_PATH_GEN_MODE_NV = &h90B0
const GL_PATH_GEN_COEFF_NV = &h90B1
const GL_PATH_GEN_COMPONENTS_NV = &h90B3
const GL_PATH_STENCIL_FUNC_NV = &h90B7
const GL_PATH_STENCIL_REF_NV = &h90B8
const GL_PATH_STENCIL_VALUE_MASK_NV = &h90B9
const GL_PATH_STENCIL_DEPTH_OFFSET_FACTOR_NV = &h90BD
const GL_PATH_STENCIL_DEPTH_OFFSET_UNITS_NV = &h90BE
const GL_PATH_COVER_DEPTH_FUNC_NV = &h90BF
const GL_PATH_DASH_OFFSET_RESET_NV = &h90B4
const GL_MOVE_TO_RESETS_NV = &h90B5
const GL_MOVE_TO_CONTINUES_NV = &h90B6
const GL_CLOSE_PATH_NV = &h00
const GL_MOVE_TO_NV = &h02
const GL_RELATIVE_MOVE_TO_NV = &h03
const GL_LINE_TO_NV = &h04
const GL_RELATIVE_LINE_TO_NV = &h05
const GL_HORIZONTAL_LINE_TO_NV = &h06
const GL_RELATIVE_HORIZONTAL_LINE_TO_NV = &h07
const GL_VERTICAL_LINE_TO_NV = &h08
const GL_RELATIVE_VERTICAL_LINE_TO_NV = &h09
const GL_QUADRATIC_CURVE_TO_NV = &h0A
const GL_RELATIVE_QUADRATIC_CURVE_TO_NV = &h0B
const GL_CUBIC_CURVE_TO_NV = &h0C
const GL_RELATIVE_CUBIC_CURVE_TO_NV = &h0D
const GL_SMOOTH_QUADRATIC_CURVE_TO_NV = &h0E
const GL_RELATIVE_SMOOTH_QUADRATIC_CURVE_TO_NV = &h0F
const GL_SMOOTH_CUBIC_CURVE_TO_NV = &h10
const GL_RELATIVE_SMOOTH_CUBIC_CURVE_TO_NV = &h11
const GL_SMALL_CCW_ARC_TO_NV = &h12
const GL_RELATIVE_SMALL_CCW_ARC_TO_NV = &h13
const GL_SMALL_CW_ARC_TO_NV = &h14
const GL_RELATIVE_SMALL_CW_ARC_TO_NV = &h15
const GL_LARGE_CCW_ARC_TO_NV = &h16
const GL_RELATIVE_LARGE_CCW_ARC_TO_NV = &h17
const GL_LARGE_CW_ARC_TO_NV = &h18
const GL_RELATIVE_LARGE_CW_ARC_TO_NV = &h19
const GL_RESTART_PATH_NV = &hF0
const GL_DUP_FIRST_CUBIC_CURVE_TO_NV = &hF2
const GL_DUP_LAST_CUBIC_CURVE_TO_NV = &hF4
const GL_RECT_NV = &hF6
const GL_CIRCULAR_CCW_ARC_TO_NV = &hF8
const GL_CIRCULAR_CW_ARC_TO_NV = &hFA
const GL_CIRCULAR_TANGENT_ARC_TO_NV = &hFC
const GL_ARC_TO_NV = &hFE
const GL_RELATIVE_ARC_TO_NV = &hFF
const GL_BOLD_BIT_NV = &h01
const GL_ITALIC_BIT_NV = &h02
const GL_GLYPH_WIDTH_BIT_NV = &h01
const GL_GLYPH_HEIGHT_BIT_NV = &h02
const GL_GLYPH_HORIZONTAL_BEARING_X_BIT_NV = &h04
const GL_GLYPH_HORIZONTAL_BEARING_Y_BIT_NV = &h08
const GL_GLYPH_HORIZONTAL_BEARING_ADVANCE_BIT_NV = &h10
const GL_GLYPH_VERTICAL_BEARING_X_BIT_NV = &h20
const GL_GLYPH_VERTICAL_BEARING_Y_BIT_NV = &h40
const GL_GLYPH_VERTICAL_BEARING_ADVANCE_BIT_NV = &h80
const GL_GLYPH_HAS_KERNING_BIT_NV = &h100
const GL_FONT_X_MIN_BOUNDS_BIT_NV = &h00010000
const GL_FONT_Y_MIN_BOUNDS_BIT_NV = &h00020000
const GL_FONT_X_MAX_BOUNDS_BIT_NV = &h00040000
const GL_FONT_Y_MAX_BOUNDS_BIT_NV = &h00080000
const GL_FONT_UNITS_PER_EM_BIT_NV = &h00100000
const GL_FONT_ASCENDER_BIT_NV = &h00200000
const GL_FONT_DESCENDER_BIT_NV = &h00400000
const GL_FONT_HEIGHT_BIT_NV = &h00800000
const GL_FONT_MAX_ADVANCE_WIDTH_BIT_NV = &h01000000
const GL_FONT_MAX_ADVANCE_HEIGHT_BIT_NV = &h02000000
const GL_FONT_UNDERLINE_POSITION_BIT_NV = &h04000000
const GL_FONT_UNDERLINE_THICKNESS_BIT_NV = &h08000000
const GL_FONT_HAS_KERNING_BIT_NV = &h10000000
const GL_ROUNDED_RECT_NV = &hE8
const GL_RELATIVE_ROUNDED_RECT_NV = &hE9
const GL_ROUNDED_RECT2_NV = &hEA
const GL_RELATIVE_ROUNDED_RECT2_NV = &hEB
const GL_ROUNDED_RECT4_NV = &hEC
const GL_RELATIVE_ROUNDED_RECT4_NV = &hED
const GL_ROUNDED_RECT8_NV = &hEE
const GL_RELATIVE_ROUNDED_RECT8_NV = &hEF
const GL_RELATIVE_RECT_NV = &hF7
const GL_FONT_GLYPHS_AVAILABLE_NV = &h9368
const GL_FONT_TARGET_UNAVAILABLE_NV = &h9369
const GL_FONT_UNAVAILABLE_NV = &h936A
const GL_FONT_UNINTELLIGIBLE_NV = &h936B
const GL_CONIC_CURVE_TO_NV = &h1A
const GL_RELATIVE_CONIC_CURVE_TO_NV = &h1B
const GL_FONT_NUM_GLYPH_INDICES_BIT_NV = &h20000000
const GL_STANDARD_FONT_FORMAT_NV = &h936C
const GL_2_BYTES_NV = &h1407
const GL_3_BYTES_NV = &h1408
const GL_4_BYTES_NV = &h1409
const GL_EYE_LINEAR_NV = &h2400
const GL_OBJECT_LINEAR_NV = &h2401
const GL_CONSTANT_NV = &h8576
const GL_PATH_FOG_GEN_MODE_NV = &h90AC
const GL_PRIMARY_COLOR_NV = &h852C
const GL_SECONDARY_COLOR_NV = &h852D
const GL_PATH_GEN_COLOR_FORMAT_NV = &h90B2
const GL_PATH_PROJECTION_NV = &h1701
const GL_PATH_MODELVIEW_NV = &h1700
const GL_PATH_MODELVIEW_STACK_DEPTH_NV = &h0BA3
const GL_PATH_MODELVIEW_MATRIX_NV = &h0BA6
const GL_PATH_MAX_MODELVIEW_STACK_DEPTH_NV = &h0D36
const GL_PATH_TRANSPOSE_MODELVIEW_MATRIX_NV = &h84E3
const GL_PATH_PROJECTION_STACK_DEPTH_NV = &h0BA4
const GL_PATH_PROJECTION_MATRIX_NV = &h0BA7
const GL_PATH_MAX_PROJECTION_STACK_DEPTH_NV = &h0D38
const GL_PATH_TRANSPOSE_PROJECTION_MATRIX_NV = &h84E4
const GL_FRAGMENT_INPUT_NV = &h936D

type PFNGLGENPATHSNVPROC as function(byval range as GLsizei) as GLuint
type PFNGLDELETEPATHSNVPROC as sub(byval path as GLuint, byval range as GLsizei)
type PFNGLISPATHNVPROC as function(byval path as GLuint) as GLboolean
type PFNGLPATHCOMMANDSNVPROC as sub(byval path as GLuint, byval numCommands as GLsizei, byval commands as const GLubyte ptr, byval numCoords as GLsizei, byval coordType as GLenum, byval coords as const any ptr)
type PFNGLPATHCOORDSNVPROC as sub(byval path as GLuint, byval numCoords as GLsizei, byval coordType as GLenum, byval coords as const any ptr)
type PFNGLPATHSUBCOMMANDSNVPROC as sub(byval path as GLuint, byval commandStart as GLsizei, byval commandsToDelete as GLsizei, byval numCommands as GLsizei, byval commands as const GLubyte ptr, byval numCoords as GLsizei, byval coordType as GLenum, byval coords as const any ptr)
type PFNGLPATHSUBCOORDSNVPROC as sub(byval path as GLuint, byval coordStart as GLsizei, byval numCoords as GLsizei, byval coordType as GLenum, byval coords as const any ptr)
type PFNGLPATHSTRINGNVPROC as sub(byval path as GLuint, byval format as GLenum, byval length as GLsizei, byval pathString as const any ptr)
type PFNGLPATHGLYPHSNVPROC as sub(byval firstPathName as GLuint, byval fontTarget as GLenum, byval fontName as const any ptr, byval fontStyle as GLbitfield, byval numGlyphs as GLsizei, byval type as GLenum, byval charcodes as const any ptr, byval handleMissingGlyphs as GLenum, byval pathParameterTemplate as GLuint, byval emScale as GLfloat)
type PFNGLPATHGLYPHRANGENVPROC as sub(byval firstPathName as GLuint, byval fontTarget as GLenum, byval fontName as const any ptr, byval fontStyle as GLbitfield, byval firstGlyph as GLuint, byval numGlyphs as GLsizei, byval handleMissingGlyphs as GLenum, byval pathParameterTemplate as GLuint, byval emScale as GLfloat)
type PFNGLWEIGHTPATHSNVPROC as sub(byval resultPath as GLuint, byval numPaths as GLsizei, byval paths as const GLuint ptr, byval weights as const GLfloat ptr)
type PFNGLCOPYPATHNVPROC as sub(byval resultPath as GLuint, byval srcPath as GLuint)
type PFNGLINTERPOLATEPATHSNVPROC as sub(byval resultPath as GLuint, byval pathA as GLuint, byval pathB as GLuint, byval weight as GLfloat)
type PFNGLTRANSFORMPATHNVPROC as sub(byval resultPath as GLuint, byval srcPath as GLuint, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
type PFNGLPATHPARAMETERIVNVPROC as sub(byval path as GLuint, byval pname as GLenum, byval value as const GLint ptr)
type PFNGLPATHPARAMETERINVPROC as sub(byval path as GLuint, byval pname as GLenum, byval value as GLint)
type PFNGLPATHPARAMETERFVNVPROC as sub(byval path as GLuint, byval pname as GLenum, byval value as const GLfloat ptr)
type PFNGLPATHPARAMETERFNVPROC as sub(byval path as GLuint, byval pname as GLenum, byval value as GLfloat)
type PFNGLPATHDASHARRAYNVPROC as sub(byval path as GLuint, byval dashCount as GLsizei, byval dashArray as const GLfloat ptr)
type PFNGLPATHSTENCILFUNCNVPROC as sub(byval func as GLenum, byval ref as GLint, byval mask as GLuint)
type PFNGLPATHSTENCILDEPTHOFFSETNVPROC as sub(byval factor as GLfloat, byval units as GLfloat)
type PFNGLSTENCILFILLPATHNVPROC as sub(byval path as GLuint, byval fillMode as GLenum, byval mask as GLuint)
type PFNGLSTENCILSTROKEPATHNVPROC as sub(byval path as GLuint, byval reference as GLint, byval mask as GLuint)
type PFNGLSTENCILFILLPATHINSTANCEDNVPROC as sub(byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval fillMode as GLenum, byval mask as GLuint, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
type PFNGLSTENCILSTROKEPATHINSTANCEDNVPROC as sub(byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval reference as GLint, byval mask as GLuint, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
type PFNGLPATHCOVERDEPTHFUNCNVPROC as sub(byval func as GLenum)
type PFNGLCOVERFILLPATHNVPROC as sub(byval path as GLuint, byval coverMode as GLenum)
type PFNGLCOVERSTROKEPATHNVPROC as sub(byval path as GLuint, byval coverMode as GLenum)
type PFNGLCOVERFILLPATHINSTANCEDNVPROC as sub(byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval coverMode as GLenum, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
type PFNGLCOVERSTROKEPATHINSTANCEDNVPROC as sub(byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval coverMode as GLenum, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
type PFNGLGETPATHPARAMETERIVNVPROC as sub(byval path as GLuint, byval pname as GLenum, byval value as GLint ptr)
type PFNGLGETPATHPARAMETERFVNVPROC as sub(byval path as GLuint, byval pname as GLenum, byval value as GLfloat ptr)
type PFNGLGETPATHCOMMANDSNVPROC as sub(byval path as GLuint, byval commands as GLubyte ptr)
type PFNGLGETPATHCOORDSNVPROC as sub(byval path as GLuint, byval coords as GLfloat ptr)
type PFNGLGETPATHDASHARRAYNVPROC as sub(byval path as GLuint, byval dashArray as GLfloat ptr)
type PFNGLGETPATHMETRICSNVPROC as sub(byval metricQueryMask as GLbitfield, byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval stride as GLsizei, byval metrics as GLfloat ptr)
type PFNGLGETPATHMETRICRANGENVPROC as sub(byval metricQueryMask as GLbitfield, byval firstPathName as GLuint, byval numPaths as GLsizei, byval stride as GLsizei, byval metrics as GLfloat ptr)
type PFNGLGETPATHSPACINGNVPROC as sub(byval pathListMode as GLenum, byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval advanceScale as GLfloat, byval kerningScale as GLfloat, byval transformType as GLenum, byval returnedSpacing as GLfloat ptr)
type PFNGLISPOINTINFILLPATHNVPROC as function(byval path as GLuint, byval mask as GLuint, byval x as GLfloat, byval y as GLfloat) as GLboolean
type PFNGLISPOINTINSTROKEPATHNVPROC as function(byval path as GLuint, byval x as GLfloat, byval y as GLfloat) as GLboolean
type PFNGLGETPATHLENGTHNVPROC as function(byval path as GLuint, byval startSegment as GLsizei, byval numSegments as GLsizei) as GLfloat
type PFNGLPOINTALONGPATHNVPROC as function(byval path as GLuint, byval startSegment as GLsizei, byval numSegments as GLsizei, byval distance as GLfloat, byval x as GLfloat ptr, byval y as GLfloat ptr, byval tangentX as GLfloat ptr, byval tangentY as GLfloat ptr) as GLboolean
type PFNGLMATRIXLOAD3X2FNVPROC as sub(byval matrixMode as GLenum, byval m as const GLfloat ptr)
type PFNGLMATRIXLOAD3X3FNVPROC as sub(byval matrixMode as GLenum, byval m as const GLfloat ptr)
type PFNGLMATRIXLOADTRANSPOSE3X3FNVPROC as sub(byval matrixMode as GLenum, byval m as const GLfloat ptr)
type PFNGLMATRIXMULT3X2FNVPROC as sub(byval matrixMode as GLenum, byval m as const GLfloat ptr)
type PFNGLMATRIXMULT3X3FNVPROC as sub(byval matrixMode as GLenum, byval m as const GLfloat ptr)
type PFNGLMATRIXMULTTRANSPOSE3X3FNVPROC as sub(byval matrixMode as GLenum, byval m as const GLfloat ptr)
type PFNGLSTENCILTHENCOVERFILLPATHNVPROC as sub(byval path as GLuint, byval fillMode as GLenum, byval mask as GLuint, byval coverMode as GLenum)
type PFNGLSTENCILTHENCOVERSTROKEPATHNVPROC as sub(byval path as GLuint, byval reference as GLint, byval mask as GLuint, byval coverMode as GLenum)
type PFNGLSTENCILTHENCOVERFILLPATHINSTANCEDNVPROC as sub(byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval fillMode as GLenum, byval mask as GLuint, byval coverMode as GLenum, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
type PFNGLSTENCILTHENCOVERSTROKEPATHINSTANCEDNVPROC as sub(byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval reference as GLint, byval mask as GLuint, byval coverMode as GLenum, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
type PFNGLPATHGLYPHINDEXRANGENVPROC as function(byval fontTarget as GLenum, byval fontName as const any ptr, byval fontStyle as GLbitfield, byval pathParameterTemplate as GLuint, byval emScale as GLfloat, byval baseAndCount as GLuint ptr) as GLenum
type PFNGLPATHGLYPHINDEXARRAYNVPROC as function(byval firstPathName as GLuint, byval fontTarget as GLenum, byval fontName as const any ptr, byval fontStyle as GLbitfield, byval firstGlyphIndex as GLuint, byval numGlyphs as GLsizei, byval pathParameterTemplate as GLuint, byval emScale as GLfloat) as GLenum
type PFNGLPATHMEMORYGLYPHINDEXARRAYNVPROC as function(byval firstPathName as GLuint, byval fontTarget as GLenum, byval fontSize as GLsizeiptr, byval fontData as const any ptr, byval faceIndex as GLsizei, byval firstGlyphIndex as GLuint, byval numGlyphs as GLsizei, byval pathParameterTemplate as GLuint, byval emScale as GLfloat) as GLenum
type PFNGLPROGRAMPATHFRAGMENTINPUTGENNVPROC as sub(byval program as GLuint, byval location as GLint, byval genMode as GLenum, byval components as GLint, byval coeffs as const GLfloat ptr)
type PFNGLGETPROGRAMRESOURCEFVNVPROC as sub(byval program as GLuint, byval programInterface as GLenum, byval index as GLuint, byval propCount as GLsizei, byval props as const GLenum ptr, byval bufSize as GLsizei, byval length as GLsizei ptr, byval params as GLfloat ptr)
type PFNGLPATHCOLORGENNVPROC as sub(byval color as GLenum, byval genMode as GLenum, byval colorFormat as GLenum, byval coeffs as const GLfloat ptr)
type PFNGLPATHTEXGENNVPROC as sub(byval texCoordSet as GLenum, byval genMode as GLenum, byval components as GLint, byval coeffs as const GLfloat ptr)
type PFNGLPATHFOGGENNVPROC as sub(byval genMode as GLenum)
type PFNGLGETPATHCOLORGENIVNVPROC as sub(byval color as GLenum, byval pname as GLenum, byval value as GLint ptr)
type PFNGLGETPATHCOLORGENFVNVPROC as sub(byval color as GLenum, byval pname as GLenum, byval value as GLfloat ptr)
type PFNGLGETPATHTEXGENIVNVPROC as sub(byval texCoordSet as GLenum, byval pname as GLenum, byval value as GLint ptr)
type PFNGLGETPATHTEXGENFVNVPROC as sub(byval texCoordSet as GLenum, byval pname as GLenum, byval value as GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare function glGenPathsNV(byval range as GLsizei) as GLuint
	declare sub glDeletePathsNV(byval path as GLuint, byval range as GLsizei)
	declare function glIsPathNV(byval path as GLuint) as GLboolean
	declare sub glPathCommandsNV(byval path as GLuint, byval numCommands as GLsizei, byval commands as const GLubyte ptr, byval numCoords as GLsizei, byval coordType as GLenum, byval coords as const any ptr)
	declare sub glPathCoordsNV(byval path as GLuint, byval numCoords as GLsizei, byval coordType as GLenum, byval coords as const any ptr)
	declare sub glPathSubCommandsNV(byval path as GLuint, byval commandStart as GLsizei, byval commandsToDelete as GLsizei, byval numCommands as GLsizei, byval commands as const GLubyte ptr, byval numCoords as GLsizei, byval coordType as GLenum, byval coords as const any ptr)
	declare sub glPathSubCoordsNV(byval path as GLuint, byval coordStart as GLsizei, byval numCoords as GLsizei, byval coordType as GLenum, byval coords as const any ptr)
	declare sub glPathStringNV(byval path as GLuint, byval format as GLenum, byval length as GLsizei, byval pathString as const any ptr)
	declare sub glPathGlyphsNV(byval firstPathName as GLuint, byval fontTarget as GLenum, byval fontName as const any ptr, byval fontStyle as GLbitfield, byval numGlyphs as GLsizei, byval type as GLenum, byval charcodes as const any ptr, byval handleMissingGlyphs as GLenum, byval pathParameterTemplate as GLuint, byval emScale as GLfloat)
	declare sub glPathGlyphRangeNV(byval firstPathName as GLuint, byval fontTarget as GLenum, byval fontName as const any ptr, byval fontStyle as GLbitfield, byval firstGlyph as GLuint, byval numGlyphs as GLsizei, byval handleMissingGlyphs as GLenum, byval pathParameterTemplate as GLuint, byval emScale as GLfloat)
	declare sub glWeightPathsNV(byval resultPath as GLuint, byval numPaths as GLsizei, byval paths as const GLuint ptr, byval weights as const GLfloat ptr)
	declare sub glCopyPathNV(byval resultPath as GLuint, byval srcPath as GLuint)
	declare sub glInterpolatePathsNV(byval resultPath as GLuint, byval pathA as GLuint, byval pathB as GLuint, byval weight as GLfloat)
	declare sub glTransformPathNV(byval resultPath as GLuint, byval srcPath as GLuint, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
	declare sub glPathParameterivNV(byval path as GLuint, byval pname as GLenum, byval value as const GLint ptr)
	declare sub glPathParameteriNV(byval path as GLuint, byval pname as GLenum, byval value as GLint)
	declare sub glPathParameterfvNV(byval path as GLuint, byval pname as GLenum, byval value as const GLfloat ptr)
	declare sub glPathParameterfNV(byval path as GLuint, byval pname as GLenum, byval value as GLfloat)
	declare sub glPathDashArrayNV(byval path as GLuint, byval dashCount as GLsizei, byval dashArray as const GLfloat ptr)
	declare sub glPathStencilFuncNV(byval func as GLenum, byval ref as GLint, byval mask as GLuint)
	declare sub glPathStencilDepthOffsetNV(byval factor as GLfloat, byval units as GLfloat)
	declare sub glStencilFillPathNV(byval path as GLuint, byval fillMode as GLenum, byval mask as GLuint)
	declare sub glStencilStrokePathNV(byval path as GLuint, byval reference as GLint, byval mask as GLuint)
	declare sub glStencilFillPathInstancedNV(byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval fillMode as GLenum, byval mask as GLuint, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
	declare sub glStencilStrokePathInstancedNV(byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval reference as GLint, byval mask as GLuint, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
	declare sub glPathCoverDepthFuncNV(byval func as GLenum)
	declare sub glCoverFillPathNV(byval path as GLuint, byval coverMode as GLenum)
	declare sub glCoverStrokePathNV(byval path as GLuint, byval coverMode as GLenum)
	declare sub glCoverFillPathInstancedNV(byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval coverMode as GLenum, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
	declare sub glCoverStrokePathInstancedNV(byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval coverMode as GLenum, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
	declare sub glGetPathParameterivNV(byval path as GLuint, byval pname as GLenum, byval value as GLint ptr)
	declare sub glGetPathParameterfvNV(byval path as GLuint, byval pname as GLenum, byval value as GLfloat ptr)
	declare sub glGetPathCommandsNV(byval path as GLuint, byval commands as GLubyte ptr)
	declare sub glGetPathCoordsNV(byval path as GLuint, byval coords as GLfloat ptr)
	declare sub glGetPathDashArrayNV(byval path as GLuint, byval dashArray as GLfloat ptr)
	declare sub glGetPathMetricsNV(byval metricQueryMask as GLbitfield, byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval stride as GLsizei, byval metrics as GLfloat ptr)
	declare sub glGetPathMetricRangeNV(byval metricQueryMask as GLbitfield, byval firstPathName as GLuint, byval numPaths as GLsizei, byval stride as GLsizei, byval metrics as GLfloat ptr)
	declare sub glGetPathSpacingNV(byval pathListMode as GLenum, byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval advanceScale as GLfloat, byval kerningScale as GLfloat, byval transformType as GLenum, byval returnedSpacing as GLfloat ptr)
	declare function glIsPointInFillPathNV(byval path as GLuint, byval mask as GLuint, byval x as GLfloat, byval y as GLfloat) as GLboolean
	declare function glIsPointInStrokePathNV(byval path as GLuint, byval x as GLfloat, byval y as GLfloat) as GLboolean
	declare function glGetPathLengthNV(byval path as GLuint, byval startSegment as GLsizei, byval numSegments as GLsizei) as GLfloat
	declare function glPointAlongPathNV(byval path as GLuint, byval startSegment as GLsizei, byval numSegments as GLsizei, byval distance as GLfloat, byval x as GLfloat ptr, byval y as GLfloat ptr, byval tangentX as GLfloat ptr, byval tangentY as GLfloat ptr) as GLboolean
	declare sub glMatrixLoad3x2fNV(byval matrixMode as GLenum, byval m as const GLfloat ptr)
	declare sub glMatrixLoad3x3fNV(byval matrixMode as GLenum, byval m as const GLfloat ptr)
	declare sub glMatrixLoadTranspose3x3fNV(byval matrixMode as GLenum, byval m as const GLfloat ptr)
	declare sub glMatrixMult3x2fNV(byval matrixMode as GLenum, byval m as const GLfloat ptr)
	declare sub glMatrixMult3x3fNV(byval matrixMode as GLenum, byval m as const GLfloat ptr)
	declare sub glMatrixMultTranspose3x3fNV(byval matrixMode as GLenum, byval m as const GLfloat ptr)
	declare sub glStencilThenCoverFillPathNV(byval path as GLuint, byval fillMode as GLenum, byval mask as GLuint, byval coverMode as GLenum)
	declare sub glStencilThenCoverStrokePathNV(byval path as GLuint, byval reference as GLint, byval mask as GLuint, byval coverMode as GLenum)
	declare sub glStencilThenCoverFillPathInstancedNV(byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval fillMode as GLenum, byval mask as GLuint, byval coverMode as GLenum, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
	declare sub glStencilThenCoverStrokePathInstancedNV(byval numPaths as GLsizei, byval pathNameType as GLenum, byval paths as const any ptr, byval pathBase as GLuint, byval reference as GLint, byval mask as GLuint, byval coverMode as GLenum, byval transformType as GLenum, byval transformValues as const GLfloat ptr)
	declare function glPathGlyphIndexRangeNV(byval fontTarget as GLenum, byval fontName as const any ptr, byval fontStyle as GLbitfield, byval pathParameterTemplate as GLuint, byval emScale as GLfloat, byval baseAndCount as GLuint ptr) as GLenum
	declare function glPathGlyphIndexArrayNV(byval firstPathName as GLuint, byval fontTarget as GLenum, byval fontName as const any ptr, byval fontStyle as GLbitfield, byval firstGlyphIndex as GLuint, byval numGlyphs as GLsizei, byval pathParameterTemplate as GLuint, byval emScale as GLfloat) as GLenum
	declare function glPathMemoryGlyphIndexArrayNV(byval firstPathName as GLuint, byval fontTarget as GLenum, byval fontSize as GLsizeiptr, byval fontData as const any ptr, byval faceIndex as GLsizei, byval firstGlyphIndex as GLuint, byval numGlyphs as GLsizei, byval pathParameterTemplate as GLuint, byval emScale as GLfloat) as GLenum
	declare sub glProgramPathFragmentInputGenNV(byval program as GLuint, byval location as GLint, byval genMode as GLenum, byval components as GLint, byval coeffs as const GLfloat ptr)
	declare sub glGetProgramResourcefvNV(byval program as GLuint, byval programInterface as GLenum, byval index as GLuint, byval propCount as GLsizei, byval props as const GLenum ptr, byval bufSize as GLsizei, byval length as GLsizei ptr, byval params as GLfloat ptr)
	declare sub glPathColorGenNV(byval color as GLenum, byval genMode as GLenum, byval colorFormat as GLenum, byval coeffs as const GLfloat ptr)
	declare sub glPathTexGenNV(byval texCoordSet as GLenum, byval genMode as GLenum, byval components as GLint, byval coeffs as const GLfloat ptr)
	declare sub glPathFogGenNV(byval genMode as GLenum)
	declare sub glGetPathColorGenivNV(byval color as GLenum, byval pname as GLenum, byval value as GLint ptr)
	declare sub glGetPathColorGenfvNV(byval color as GLenum, byval pname as GLenum, byval value as GLfloat ptr)
	declare sub glGetPathTexGenivNV(byval texCoordSet as GLenum, byval pname as GLenum, byval value as GLint ptr)
	declare sub glGetPathTexGenfvNV(byval texCoordSet as GLenum, byval pname as GLenum, byval value as GLfloat ptr)
#endif

const GL_NV_path_rendering_shared_edge = 1
const GL_SHARED_EDGE_NV = &hC0
const GL_NV_pixel_data_range = 1
const GL_WRITE_PIXEL_DATA_RANGE_NV = &h8878
const GL_READ_PIXEL_DATA_RANGE_NV = &h8879
const GL_WRITE_PIXEL_DATA_RANGE_LENGTH_NV = &h887A
const GL_READ_PIXEL_DATA_RANGE_LENGTH_NV = &h887B
const GL_WRITE_PIXEL_DATA_RANGE_POINTER_NV = &h887C
const GL_READ_PIXEL_DATA_RANGE_POINTER_NV = &h887D
type PFNGLPIXELDATARANGENVPROC as sub(byval target as GLenum, byval length as GLsizei, byval pointer as const any ptr)
type PFNGLFLUSHPIXELDATARANGENVPROC as sub(byval target as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPixelDataRangeNV(byval target as GLenum, byval length as GLsizei, byval pointer as const any ptr)
	declare sub glFlushPixelDataRangeNV(byval target as GLenum)
#endif

const GL_NV_point_sprite = 1
const GL_POINT_SPRITE_NV = &h8861
const GL_COORD_REPLACE_NV = &h8862
const GL_POINT_SPRITE_R_MODE_NV = &h8863
type PFNGLPOINTPARAMETERINVPROC as sub(byval pname as GLenum, byval param as GLint)
type PFNGLPOINTPARAMETERIVNVPROC as sub(byval pname as GLenum, byval params as const GLint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPointParameteriNV(byval pname as GLenum, byval param as GLint)
	declare sub glPointParameterivNV(byval pname as GLenum, byval params as const GLint ptr)
#endif

const GL_NV_present_video = 1
const GL_FRAME_NV = &h8E26
const GL_FIELDS_NV = &h8E27
const GL_CURRENT_TIME_NV = &h8E28
const GL_NUM_FILL_STREAMS_NV = &h8E29
const GL_PRESENT_TIME_NV = &h8E2A
const GL_PRESENT_DURATION_NV = &h8E2B

type PFNGLPRESENTFRAMEKEYEDNVPROC as sub(byval video_slot as GLuint, byval minPresentTime as GLuint64EXT, byval beginPresentTimeId as GLuint, byval presentDurationId as GLuint, byval type as GLenum, byval target0 as GLenum, byval fill0 as GLuint, byval key0 as GLuint, byval target1 as GLenum, byval fill1 as GLuint, byval key1 as GLuint)
type PFNGLPRESENTFRAMEDUALFILLNVPROC as sub(byval video_slot as GLuint, byval minPresentTime as GLuint64EXT, byval beginPresentTimeId as GLuint, byval presentDurationId as GLuint, byval type as GLenum, byval target0 as GLenum, byval fill0 as GLuint, byval target1 as GLenum, byval fill1 as GLuint, byval target2 as GLenum, byval fill2 as GLuint, byval target3 as GLenum, byval fill3 as GLuint)
type PFNGLGETVIDEOIVNVPROC as sub(byval video_slot as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETVIDEOUIVNVPROC as sub(byval video_slot as GLuint, byval pname as GLenum, byval params as GLuint ptr)
type PFNGLGETVIDEOI64VNVPROC as sub(byval video_slot as GLuint, byval pname as GLenum, byval params as GLint64EXT ptr)
type PFNGLGETVIDEOUI64VNVPROC as sub(byval video_slot as GLuint, byval pname as GLenum, byval params as GLuint64EXT ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPresentFrameKeyedNV(byval video_slot as GLuint, byval minPresentTime as GLuint64EXT, byval beginPresentTimeId as GLuint, byval presentDurationId as GLuint, byval type as GLenum, byval target0 as GLenum, byval fill0 as GLuint, byval key0 as GLuint, byval target1 as GLenum, byval fill1 as GLuint, byval key1 as GLuint)
	declare sub glPresentFrameDualFillNV(byval video_slot as GLuint, byval minPresentTime as GLuint64EXT, byval beginPresentTimeId as GLuint, byval presentDurationId as GLuint, byval type as GLenum, byval target0 as GLenum, byval fill0 as GLuint, byval target1 as GLenum, byval fill1 as GLuint, byval target2 as GLenum, byval fill2 as GLuint, byval target3 as GLenum, byval fill3 as GLuint)
	declare sub glGetVideoivNV(byval video_slot as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetVideouivNV(byval video_slot as GLuint, byval pname as GLenum, byval params as GLuint ptr)
	declare sub glGetVideoi64vNV(byval video_slot as GLuint, byval pname as GLenum, byval params as GLint64EXT ptr)
	declare sub glGetVideoui64vNV(byval video_slot as GLuint, byval pname as GLenum, byval params as GLuint64EXT ptr)
#endif

const GL_NV_primitive_restart = 1
const GL_PRIMITIVE_RESTART_NV = &h8558
const GL_PRIMITIVE_RESTART_INDEX_NV = &h8559
type PFNGLPRIMITIVERESTARTNVPROC as sub()
type PFNGLPRIMITIVERESTARTINDEXNVPROC as sub(byval index as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPrimitiveRestartNV()
	declare sub glPrimitiveRestartIndexNV(byval index as GLuint)
#endif

const GL_NV_register_combiners = 1
const GL_REGISTER_COMBINERS_NV = &h8522
const GL_VARIABLE_A_NV = &h8523
const GL_VARIABLE_B_NV = &h8524
const GL_VARIABLE_C_NV = &h8525
const GL_VARIABLE_D_NV = &h8526
const GL_VARIABLE_E_NV = &h8527
const GL_VARIABLE_F_NV = &h8528
const GL_VARIABLE_G_NV = &h8529
const GL_CONSTANT_COLOR0_NV = &h852A
const GL_CONSTANT_COLOR1_NV = &h852B
const GL_SPARE0_NV = &h852E
const GL_SPARE1_NV = &h852F
const GL_DISCARD_NV = &h8530
const GL_E_TIMES_F_NV = &h8531
const GL_SPARE0_PLUS_SECONDARY_COLOR_NV = &h8532
const GL_UNSIGNED_IDENTITY_NV = &h8536
const GL_UNSIGNED_INVERT_NV = &h8537
const GL_EXPAND_NORMAL_NV = &h8538
const GL_EXPAND_NEGATE_NV = &h8539
const GL_HALF_BIAS_NORMAL_NV = &h853A
const GL_HALF_BIAS_NEGATE_NV = &h853B
const GL_SIGNED_IDENTITY_NV = &h853C
const GL_SIGNED_NEGATE_NV = &h853D
const GL_SCALE_BY_TWO_NV = &h853E
const GL_SCALE_BY_FOUR_NV = &h853F
const GL_SCALE_BY_ONE_HALF_NV = &h8540
const GL_BIAS_BY_NEGATIVE_ONE_HALF_NV = &h8541
const GL_COMBINER_INPUT_NV = &h8542
const GL_COMBINER_MAPPING_NV = &h8543
const GL_COMBINER_COMPONENT_USAGE_NV = &h8544
const GL_COMBINER_AB_DOT_PRODUCT_NV = &h8545
const GL_COMBINER_CD_DOT_PRODUCT_NV = &h8546
const GL_COMBINER_MUX_SUM_NV = &h8547
const GL_COMBINER_SCALE_NV = &h8548
const GL_COMBINER_BIAS_NV = &h8549
const GL_COMBINER_AB_OUTPUT_NV = &h854A
const GL_COMBINER_CD_OUTPUT_NV = &h854B
const GL_COMBINER_SUM_OUTPUT_NV = &h854C
const GL_MAX_GENERAL_COMBINERS_NV = &h854D
const GL_NUM_GENERAL_COMBINERS_NV = &h854E
const GL_COLOR_SUM_CLAMP_NV = &h854F
const GL_COMBINER0_NV = &h8550
const GL_COMBINER1_NV = &h8551
const GL_COMBINER2_NV = &h8552
const GL_COMBINER3_NV = &h8553
const GL_COMBINER4_NV = &h8554
const GL_COMBINER5_NV = &h8555
const GL_COMBINER6_NV = &h8556
const GL_COMBINER7_NV = &h8557

type PFNGLCOMBINERPARAMETERFVNVPROC as sub(byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLCOMBINERPARAMETERFNVPROC as sub(byval pname as GLenum, byval param as GLfloat)
type PFNGLCOMBINERPARAMETERIVNVPROC as sub(byval pname as GLenum, byval params as const GLint ptr)
type PFNGLCOMBINERPARAMETERINVPROC as sub(byval pname as GLenum, byval param as GLint)
type PFNGLCOMBINERINPUTNVPROC as sub(byval stage as GLenum, byval portion as GLenum, byval variable as GLenum, byval input as GLenum, byval mapping as GLenum, byval componentUsage as GLenum)
type PFNGLCOMBINEROUTPUTNVPROC as sub(byval stage as GLenum, byval portion as GLenum, byval abOutput as GLenum, byval cdOutput as GLenum, byval sumOutput as GLenum, byval scale as GLenum, byval bias as GLenum, byval abDotProduct as GLboolean, byval cdDotProduct as GLboolean, byval muxSum as GLboolean)
type PFNGLFINALCOMBINERINPUTNVPROC as sub(byval variable as GLenum, byval input as GLenum, byval mapping as GLenum, byval componentUsage as GLenum)
type PFNGLGETCOMBINERINPUTPARAMETERFVNVPROC as sub(byval stage as GLenum, byval portion as GLenum, byval variable as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETCOMBINERINPUTPARAMETERIVNVPROC as sub(byval stage as GLenum, byval portion as GLenum, byval variable as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETCOMBINEROUTPUTPARAMETERFVNVPROC as sub(byval stage as GLenum, byval portion as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETCOMBINEROUTPUTPARAMETERIVNVPROC as sub(byval stage as GLenum, byval portion as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETFINALCOMBINERINPUTPARAMETERFVNVPROC as sub(byval variable as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETFINALCOMBINERINPUTPARAMETERIVNVPROC as sub(byval variable as GLenum, byval pname as GLenum, byval params as GLint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glCombinerParameterfvNV(byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glCombinerParameterfNV(byval pname as GLenum, byval param as GLfloat)
	declare sub glCombinerParameterivNV(byval pname as GLenum, byval params as const GLint ptr)
	declare sub glCombinerParameteriNV(byval pname as GLenum, byval param as GLint)
	declare sub glCombinerInputNV(byval stage as GLenum, byval portion as GLenum, byval variable as GLenum, byval input as GLenum, byval mapping as GLenum, byval componentUsage as GLenum)
	declare sub glCombinerOutputNV(byval stage as GLenum, byval portion as GLenum, byval abOutput as GLenum, byval cdOutput as GLenum, byval sumOutput as GLenum, byval scale as GLenum, byval bias as GLenum, byval abDotProduct as GLboolean, byval cdDotProduct as GLboolean, byval muxSum as GLboolean)
	declare sub glFinalCombinerInputNV(byval variable as GLenum, byval input as GLenum, byval mapping as GLenum, byval componentUsage as GLenum)
	declare sub glGetCombinerInputParameterfvNV(byval stage as GLenum, byval portion as GLenum, byval variable as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetCombinerInputParameterivNV(byval stage as GLenum, byval portion as GLenum, byval variable as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetCombinerOutputParameterfvNV(byval stage as GLenum, byval portion as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetCombinerOutputParameterivNV(byval stage as GLenum, byval portion as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetFinalCombinerInputParameterfvNV(byval variable as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetFinalCombinerInputParameterivNV(byval variable as GLenum, byval pname as GLenum, byval params as GLint ptr)
#endif

const GL_NV_register_combiners2 = 1
const GL_PER_STAGE_CONSTANTS_NV = &h8535
type PFNGLCOMBINERSTAGEPARAMETERFVNVPROC as sub(byval stage as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLGETCOMBINERSTAGEPARAMETERFVNVPROC as sub(byval stage as GLenum, byval pname as GLenum, byval params as GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glCombinerStageParameterfvNV(byval stage as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glGetCombinerStageParameterfvNV(byval stage as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
#endif

const GL_NV_sample_locations = 1
const GL_SAMPLE_LOCATION_SUBPIXEL_BITS_NV = &h933D
const GL_SAMPLE_LOCATION_PIXEL_GRID_WIDTH_NV = &h933E
const GL_SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_NV = &h933F
const GL_PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_NV = &h9340
const GL_SAMPLE_LOCATION_NV = &h8E50
const GL_PROGRAMMABLE_SAMPLE_LOCATION_NV = &h9341
const GL_FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_NV = &h9342
const GL_FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_NV = &h9343

type PFNGLFRAMEBUFFERSAMPLELOCATIONSFVNVPROC as sub(byval target as GLenum, byval start as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
type PFNGLNAMEDFRAMEBUFFERSAMPLELOCATIONSFVNVPROC as sub(byval framebuffer as GLuint, byval start as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
type PFNGLRESOLVEDEPTHVALUESNVPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glFramebufferSampleLocationsfvNV(byval target as GLenum, byval start as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
	declare sub glNamedFramebufferSampleLocationsfvNV(byval framebuffer as GLuint, byval start as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
	declare sub glResolveDepthValuesNV()
#endif

const GL_NV_sample_mask_override_coverage = 1
const GL_NV_shader_atomic_counters = 1
const GL_NV_shader_atomic_float = 1
const GL_NV_shader_atomic_fp16_vector = 1
const GL_NV_shader_atomic_int64 = 1
const GL_NV_shader_buffer_load = 1
const GL_BUFFER_GPU_ADDRESS_NV = &h8F1D
const GL_GPU_ADDRESS_NV = &h8F34
const GL_MAX_SHADER_BUFFER_ADDRESS_NV = &h8F35

type PFNGLMAKEBUFFERRESIDENTNVPROC as sub(byval target as GLenum, byval access as GLenum)
type PFNGLMAKEBUFFERNONRESIDENTNVPROC as sub(byval target as GLenum)
type PFNGLISBUFFERRESIDENTNVPROC as function(byval target as GLenum) as GLboolean
type PFNGLMAKENAMEDBUFFERRESIDENTNVPROC as sub(byval buffer as GLuint, byval access as GLenum)
type PFNGLMAKENAMEDBUFFERNONRESIDENTNVPROC as sub(byval buffer as GLuint)
type PFNGLISNAMEDBUFFERRESIDENTNVPROC as function(byval buffer as GLuint) as GLboolean
type PFNGLGETBUFFERPARAMETERUI64VNVPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLuint64EXT ptr)
type PFNGLGETNAMEDBUFFERPARAMETERUI64VNVPROC as sub(byval buffer as GLuint, byval pname as GLenum, byval params as GLuint64EXT ptr)
type PFNGLGETINTEGERUI64VNVPROC as sub(byval value as GLenum, byval result as GLuint64EXT ptr)
type PFNGLUNIFORMUI64NVPROC as sub(byval location as GLint, byval value as GLuint64EXT)
type PFNGLUNIFORMUI64VNVPROC as sub(byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
type PFNGLPROGRAMUNIFORMUI64NVPROC as sub(byval program as GLuint, byval location as GLint, byval value as GLuint64EXT)
type PFNGLPROGRAMUNIFORMUI64VNVPROC as sub(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glMakeBufferResidentNV(byval target as GLenum, byval access as GLenum)
	declare sub glMakeBufferNonResidentNV(byval target as GLenum)
	declare function glIsBufferResidentNV(byval target as GLenum) as GLboolean
	declare sub glMakeNamedBufferResidentNV(byval buffer as GLuint, byval access as GLenum)
	declare sub glMakeNamedBufferNonResidentNV(byval buffer as GLuint)
	declare function glIsNamedBufferResidentNV(byval buffer as GLuint) as GLboolean
	declare sub glGetBufferParameterui64vNV(byval target as GLenum, byval pname as GLenum, byval params as GLuint64EXT ptr)
	declare sub glGetNamedBufferParameterui64vNV(byval buffer as GLuint, byval pname as GLenum, byval params as GLuint64EXT ptr)
	declare sub glGetIntegerui64vNV(byval value as GLenum, byval result as GLuint64EXT ptr)
	declare sub glUniformui64NV(byval location as GLint, byval value as GLuint64EXT)
	declare sub glUniformui64vNV(byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
	declare sub glProgramUniformui64NV(byval program as GLuint, byval location as GLint, byval value as GLuint64EXT)
	declare sub glProgramUniformui64vNV(byval program as GLuint, byval location as GLint, byval count as GLsizei, byval value as const GLuint64EXT ptr)
#endif

const GL_NV_shader_buffer_store = 1
const GL_SHADER_GLOBAL_ACCESS_BARRIER_BIT_NV = &h00000010
const GL_NV_shader_storage_buffer_object = 1
const GL_NV_shader_thread_group = 1
const GL_WARP_SIZE_NV = &h9339
const GL_WARPS_PER_SM_NV = &h933A
const GL_SM_COUNT_NV = &h933B
const GL_NV_shader_thread_shuffle = 1
const GL_NV_tessellation_program5 = 1
const GL_MAX_PROGRAM_PATCH_ATTRIBS_NV = &h86D8
const GL_TESS_CONTROL_PROGRAM_NV = &h891E
const GL_TESS_EVALUATION_PROGRAM_NV = &h891F
const GL_TESS_CONTROL_PROGRAM_PARAMETER_BUFFER_NV = &h8C74
const GL_TESS_EVALUATION_PROGRAM_PARAMETER_BUFFER_NV = &h8C75
const GL_NV_texgen_emboss = 1
const GL_EMBOSS_LIGHT_NV = &h855D
const GL_EMBOSS_CONSTANT_NV = &h855E
const GL_EMBOSS_MAP_NV = &h855F
const GL_NV_texgen_reflection = 1
const GL_NORMAL_MAP_NV = &h8511
const GL_REFLECTION_MAP_NV = &h8512
const GL_NV_texture_barrier = 1
type PFNGLTEXTUREBARRIERNVPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTextureBarrierNV()
#endif

const GL_NV_texture_compression_vtc = 1
const GL_NV_texture_env_combine4 = 1
const GL_COMBINE4_NV = &h8503
const GL_SOURCE3_RGB_NV = &h8583
const GL_SOURCE3_ALPHA_NV = &h858B
const GL_OPERAND3_RGB_NV = &h8593
const GL_OPERAND3_ALPHA_NV = &h859B
const GL_NV_texture_expand_normal = 1
const GL_TEXTURE_UNSIGNED_REMAP_MODE_NV = &h888F
const GL_NV_texture_multisample = 1
const GL_TEXTURE_COVERAGE_SAMPLES_NV = &h9045
const GL_TEXTURE_COLOR_SAMPLES_NV = &h9046

type PFNGLTEXIMAGE2DMULTISAMPLECOVERAGENVPROC as sub(byval target as GLenum, byval coverageSamples as GLsizei, byval colorSamples as GLsizei, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval fixedSampleLocations as GLboolean)
type PFNGLTEXIMAGE3DMULTISAMPLECOVERAGENVPROC as sub(byval target as GLenum, byval coverageSamples as GLsizei, byval colorSamples as GLsizei, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedSampleLocations as GLboolean)
type PFNGLTEXTUREIMAGE2DMULTISAMPLENVPROC as sub(byval texture as GLuint, byval target as GLenum, byval samples as GLsizei, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval fixedSampleLocations as GLboolean)
type PFNGLTEXTUREIMAGE3DMULTISAMPLENVPROC as sub(byval texture as GLuint, byval target as GLenum, byval samples as GLsizei, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedSampleLocations as GLboolean)
type PFNGLTEXTUREIMAGE2DMULTISAMPLECOVERAGENVPROC as sub(byval texture as GLuint, byval target as GLenum, byval coverageSamples as GLsizei, byval colorSamples as GLsizei, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval fixedSampleLocations as GLboolean)
type PFNGLTEXTUREIMAGE3DMULTISAMPLECOVERAGENVPROC as sub(byval texture as GLuint, byval target as GLenum, byval coverageSamples as GLsizei, byval colorSamples as GLsizei, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedSampleLocations as GLboolean)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTexImage2DMultisampleCoverageNV(byval target as GLenum, byval coverageSamples as GLsizei, byval colorSamples as GLsizei, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval fixedSampleLocations as GLboolean)
	declare sub glTexImage3DMultisampleCoverageNV(byval target as GLenum, byval coverageSamples as GLsizei, byval colorSamples as GLsizei, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedSampleLocations as GLboolean)
	declare sub glTextureImage2DMultisampleNV(byval texture as GLuint, byval target as GLenum, byval samples as GLsizei, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval fixedSampleLocations as GLboolean)
	declare sub glTextureImage3DMultisampleNV(byval texture as GLuint, byval target as GLenum, byval samples as GLsizei, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedSampleLocations as GLboolean)
	declare sub glTextureImage2DMultisampleCoverageNV(byval texture as GLuint, byval target as GLenum, byval coverageSamples as GLsizei, byval colorSamples as GLsizei, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval fixedSampleLocations as GLboolean)
	declare sub glTextureImage3DMultisampleCoverageNV(byval texture as GLuint, byval target as GLenum, byval coverageSamples as GLsizei, byval colorSamples as GLsizei, byval internalFormat as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval fixedSampleLocations as GLboolean)
#endif

const GL_NV_texture_rectangle = 1
const GL_TEXTURE_RECTANGLE_NV = &h84F5
const GL_TEXTURE_BINDING_RECTANGLE_NV = &h84F6
const GL_PROXY_TEXTURE_RECTANGLE_NV = &h84F7
const GL_MAX_RECTANGLE_TEXTURE_SIZE_NV = &h84F8
const GL_NV_texture_shader = 1
const GL_OFFSET_TEXTURE_RECTANGLE_NV = &h864C
const GL_OFFSET_TEXTURE_RECTANGLE_SCALE_NV = &h864D
const GL_DOT_PRODUCT_TEXTURE_RECTANGLE_NV = &h864E
const GL_RGBA_UNSIGNED_DOT_PRODUCT_MAPPING_NV = &h86D9
const GL_UNSIGNED_INT_S8_S8_8_8_NV = &h86DA
const GL_UNSIGNED_INT_8_8_S8_S8_REV_NV = &h86DB
const GL_DSDT_MAG_INTENSITY_NV = &h86DC
const GL_SHADER_CONSISTENT_NV = &h86DD
const GL_TEXTURE_SHADER_NV = &h86DE
const GL_SHADER_OPERATION_NV = &h86DF
const GL_CULL_MODES_NV = &h86E0
const GL_OFFSET_TEXTURE_MATRIX_NV = &h86E1
const GL_OFFSET_TEXTURE_SCALE_NV = &h86E2
const GL_OFFSET_TEXTURE_BIAS_NV = &h86E3
const GL_OFFSET_TEXTURE_2D_MATRIX_NV = &h86E1
const GL_OFFSET_TEXTURE_2D_SCALE_NV = &h86E2
const GL_OFFSET_TEXTURE_2D_BIAS_NV = &h86E3
const GL_PREVIOUS_TEXTURE_INPUT_NV = &h86E4
const GL_CONST_EYE_NV = &h86E5
const GL_PASS_THROUGH_NV = &h86E6
const GL_CULL_FRAGMENT_NV = &h86E7
const GL_OFFSET_TEXTURE_2D_NV = &h86E8
const GL_DEPENDENT_AR_TEXTURE_2D_NV = &h86E9
const GL_DEPENDENT_GB_TEXTURE_2D_NV = &h86EA
const GL_DOT_PRODUCT_NV = &h86EC
const GL_DOT_PRODUCT_DEPTH_REPLACE_NV = &h86ED
const GL_DOT_PRODUCT_TEXTURE_2D_NV = &h86EE
const GL_DOT_PRODUCT_TEXTURE_CUBE_MAP_NV = &h86F0
const GL_DOT_PRODUCT_DIFFUSE_CUBE_MAP_NV = &h86F1
const GL_DOT_PRODUCT_REFLECT_CUBE_MAP_NV = &h86F2
const GL_DOT_PRODUCT_CONST_EYE_REFLECT_CUBE_MAP_NV = &h86F3
const GL_HILO_NV = &h86F4
const GL_DSDT_NV = &h86F5
const GL_DSDT_MAG_NV = &h86F6
const GL_DSDT_MAG_VIB_NV = &h86F7
const GL_HILO16_NV = &h86F8
const GL_SIGNED_HILO_NV = &h86F9
const GL_SIGNED_HILO16_NV = &h86FA
const GL_SIGNED_RGBA_NV = &h86FB
const GL_SIGNED_RGBA8_NV = &h86FC
const GL_SIGNED_RGB_NV = &h86FE
const GL_SIGNED_RGB8_NV = &h86FF
const GL_SIGNED_LUMINANCE_NV = &h8701
const GL_SIGNED_LUMINANCE8_NV = &h8702
const GL_SIGNED_LUMINANCE_ALPHA_NV = &h8703
const GL_SIGNED_LUMINANCE8_ALPHA8_NV = &h8704
const GL_SIGNED_ALPHA_NV = &h8705
const GL_SIGNED_ALPHA8_NV = &h8706
const GL_SIGNED_INTENSITY_NV = &h8707
const GL_SIGNED_INTENSITY8_NV = &h8708
const GL_DSDT8_NV = &h8709
const GL_DSDT8_MAG8_NV = &h870A
const GL_DSDT8_MAG8_INTENSITY8_NV = &h870B
const GL_SIGNED_RGB_UNSIGNED_ALPHA_NV = &h870C
const GL_SIGNED_RGB8_UNSIGNED_ALPHA8_NV = &h870D
const GL_HI_SCALE_NV = &h870E
const GL_LO_SCALE_NV = &h870F
const GL_DS_SCALE_NV = &h8710
const GL_DT_SCALE_NV = &h8711
const GL_MAGNITUDE_SCALE_NV = &h8712
const GL_VIBRANCE_SCALE_NV = &h8713
const GL_HI_BIAS_NV = &h8714
const GL_LO_BIAS_NV = &h8715
const GL_DS_BIAS_NV = &h8716
const GL_DT_BIAS_NV = &h8717
const GL_MAGNITUDE_BIAS_NV = &h8718
const GL_VIBRANCE_BIAS_NV = &h8719
const GL_TEXTURE_BORDER_VALUES_NV = &h871A
const GL_TEXTURE_HI_SIZE_NV = &h871B
const GL_TEXTURE_LO_SIZE_NV = &h871C
const GL_TEXTURE_DS_SIZE_NV = &h871D
const GL_TEXTURE_DT_SIZE_NV = &h871E
const GL_TEXTURE_MAG_SIZE_NV = &h871F
const GL_NV_texture_shader2 = 1
const GL_DOT_PRODUCT_TEXTURE_3D_NV = &h86EF
const GL_NV_texture_shader3 = 1
const GL_OFFSET_PROJECTIVE_TEXTURE_2D_NV = &h8850
const GL_OFFSET_PROJECTIVE_TEXTURE_2D_SCALE_NV = &h8851
const GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_NV = &h8852
const GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_SCALE_NV = &h8853
const GL_OFFSET_HILO_TEXTURE_2D_NV = &h8854
const GL_OFFSET_HILO_TEXTURE_RECTANGLE_NV = &h8855
const GL_OFFSET_HILO_PROJECTIVE_TEXTURE_2D_NV = &h8856
const GL_OFFSET_HILO_PROJECTIVE_TEXTURE_RECTANGLE_NV = &h8857
const GL_DEPENDENT_HILO_TEXTURE_2D_NV = &h8858
const GL_DEPENDENT_RGB_TEXTURE_3D_NV = &h8859
const GL_DEPENDENT_RGB_TEXTURE_CUBE_MAP_NV = &h885A
const GL_DOT_PRODUCT_PASS_THROUGH_NV = &h885B
const GL_DOT_PRODUCT_TEXTURE_1D_NV = &h885C
const GL_DOT_PRODUCT_AFFINE_DEPTH_REPLACE_NV = &h885D
const GL_HILO8_NV = &h885E
const GL_SIGNED_HILO8_NV = &h885F
const GL_FORCE_BLUE_TO_ONE_NV = &h8860
const GL_NV_transform_feedback = 1
const GL_BACK_PRIMARY_COLOR_NV = &h8C77
const GL_BACK_SECONDARY_COLOR_NV = &h8C78
const GL_TEXTURE_COORD_NV = &h8C79
const GL_CLIP_DISTANCE_NV = &h8C7A
const GL_VERTEX_ID_NV = &h8C7B
const GL_PRIMITIVE_ID_NV = &h8C7C
const GL_GENERIC_ATTRIB_NV = &h8C7D
const GL_TRANSFORM_FEEDBACK_ATTRIBS_NV = &h8C7E
const GL_TRANSFORM_FEEDBACK_BUFFER_MODE_NV = &h8C7F
const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_NV = &h8C80
const GL_ACTIVE_VARYINGS_NV = &h8C81
const GL_ACTIVE_VARYING_MAX_LENGTH_NV = &h8C82
const GL_TRANSFORM_FEEDBACK_VARYINGS_NV = &h8C83
const GL_TRANSFORM_FEEDBACK_BUFFER_START_NV = &h8C84
const GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_NV = &h8C85
const GL_TRANSFORM_FEEDBACK_RECORD_NV = &h8C86
const GL_PRIMITIVES_GENERATED_NV = &h8C87
const GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_NV = &h8C88
const GL_RASTERIZER_DISCARD_NV = &h8C89
const GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_NV = &h8C8A
const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_NV = &h8C8B
const GL_INTERLEAVED_ATTRIBS_NV = &h8C8C
const GL_SEPARATE_ATTRIBS_NV = &h8C8D
const GL_TRANSFORM_FEEDBACK_BUFFER_NV = &h8C8E
const GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_NV = &h8C8F
const GL_LAYER_NV = &h8DAA
const GL_NEXT_BUFFER_NV = -2
const GL_SKIP_COMPONENTS4_NV = -3
const GL_SKIP_COMPONENTS3_NV = -4
const GL_SKIP_COMPONENTS2_NV = -5
const GL_SKIP_COMPONENTS1_NV = -6

type PFNGLBEGINTRANSFORMFEEDBACKNVPROC as sub(byval primitiveMode as GLenum)
type PFNGLENDTRANSFORMFEEDBACKNVPROC as sub()
type PFNGLTRANSFORMFEEDBACKATTRIBSNVPROC as sub(byval count as GLsizei, byval attribs as const GLint ptr, byval bufferMode as GLenum)
type PFNGLBINDBUFFERRANGENVPROC as sub(byval target as GLenum, byval index as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr)
type PFNGLBINDBUFFEROFFSETNVPROC as sub(byval target as GLenum, byval index as GLuint, byval buffer as GLuint, byval offset as GLintptr)
type PFNGLBINDBUFFERBASENVPROC as sub(byval target as GLenum, byval index as GLuint, byval buffer as GLuint)
type PFNGLTRANSFORMFEEDBACKVARYINGSNVPROC as sub(byval program as GLuint, byval count as GLsizei, byval locations as const GLint ptr, byval bufferMode as GLenum)
type PFNGLACTIVEVARYINGNVPROC as sub(byval program as GLuint, byval name as const GLchar ptr)
type PFNGLGETVARYINGLOCATIONNVPROC as function(byval program as GLuint, byval name as const GLchar ptr) as GLint
type PFNGLGETACTIVEVARYINGNVPROC as sub(byval program as GLuint, byval index as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval size as GLsizei ptr, byval type as GLenum ptr, byval name as GLchar ptr)
type PFNGLGETTRANSFORMFEEDBACKVARYINGNVPROC as sub(byval program as GLuint, byval index as GLuint, byval location as GLint ptr)
type PFNGLTRANSFORMFEEDBACKSTREAMATTRIBSNVPROC as sub(byval count as GLsizei, byval attribs as const GLint ptr, byval nbuffers as GLsizei, byval bufstreams as const GLint ptr, byval bufferMode as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBeginTransformFeedbackNV(byval primitiveMode as GLenum)
	declare sub glEndTransformFeedbackNV()
	declare sub glTransformFeedbackAttribsNV(byval count as GLsizei, byval attribs as const GLint ptr, byval bufferMode as GLenum)
	declare sub glBindBufferRangeNV(byval target as GLenum, byval index as GLuint, byval buffer as GLuint, byval offset as GLintptr, byval size as GLsizeiptr)
	declare sub glBindBufferOffsetNV(byval target as GLenum, byval index as GLuint, byval buffer as GLuint, byval offset as GLintptr)
	declare sub glBindBufferBaseNV(byval target as GLenum, byval index as GLuint, byval buffer as GLuint)
	declare sub glTransformFeedbackVaryingsNV(byval program as GLuint, byval count as GLsizei, byval locations as const GLint ptr, byval bufferMode as GLenum)
	declare sub glActiveVaryingNV(byval program as GLuint, byval name as const GLchar ptr)
	declare function glGetVaryingLocationNV(byval program as GLuint, byval name as const GLchar ptr) as GLint
	declare sub glGetActiveVaryingNV(byval program as GLuint, byval index as GLuint, byval bufSize as GLsizei, byval length as GLsizei ptr, byval size as GLsizei ptr, byval type as GLenum ptr, byval name as GLchar ptr)
	declare sub glGetTransformFeedbackVaryingNV(byval program as GLuint, byval index as GLuint, byval location as GLint ptr)
	declare sub glTransformFeedbackStreamAttribsNV(byval count as GLsizei, byval attribs as const GLint ptr, byval nbuffers as GLsizei, byval bufstreams as const GLint ptr, byval bufferMode as GLenum)
#endif

const GL_NV_transform_feedback2 = 1
const GL_TRANSFORM_FEEDBACK_NV = &h8E22
const GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED_NV = &h8E23
const GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE_NV = &h8E24
const GL_TRANSFORM_FEEDBACK_BINDING_NV = &h8E25

type PFNGLBINDTRANSFORMFEEDBACKNVPROC as sub(byval target as GLenum, byval id as GLuint)
type PFNGLDELETETRANSFORMFEEDBACKSNVPROC as sub(byval n as GLsizei, byval ids as const GLuint ptr)
type PFNGLGENTRANSFORMFEEDBACKSNVPROC as sub(byval n as GLsizei, byval ids as GLuint ptr)
type PFNGLISTRANSFORMFEEDBACKNVPROC as function(byval id as GLuint) as GLboolean
type PFNGLPAUSETRANSFORMFEEDBACKNVPROC as sub()
type PFNGLRESUMETRANSFORMFEEDBACKNVPROC as sub()
type PFNGLDRAWTRANSFORMFEEDBACKNVPROC as sub(byval mode as GLenum, byval id as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBindTransformFeedbackNV(byval target as GLenum, byval id as GLuint)
	declare sub glDeleteTransformFeedbacksNV(byval n as GLsizei, byval ids as const GLuint ptr)
	declare sub glGenTransformFeedbacksNV(byval n as GLsizei, byval ids as GLuint ptr)
	declare function glIsTransformFeedbackNV(byval id as GLuint) as GLboolean
	declare sub glPauseTransformFeedbackNV()
	declare sub glResumeTransformFeedbackNV()
	declare sub glDrawTransformFeedbackNV(byval mode as GLenum, byval id as GLuint)
#endif

const GL_NV_uniform_buffer_unified_memory = 1
const GL_UNIFORM_BUFFER_UNIFIED_NV = &h936E
const GL_UNIFORM_BUFFER_ADDRESS_NV = &h936F
const GL_UNIFORM_BUFFER_LENGTH_NV = &h9370
const GL_NV_vdpau_interop = 1
type GLvdpauSurfaceNV as GLintptr
const GL_SURFACE_STATE_NV = &h86EB
const GL_SURFACE_REGISTERED_NV = &h86FD
const GL_SURFACE_MAPPED_NV = &h8700
const GL_WRITE_DISCARD_NV = &h88BE

type PFNGLVDPAUINITNVPROC as sub(byval vdpDevice as const any ptr, byval getProcAddress as const any ptr)
type PFNGLVDPAUFININVPROC as sub()
type PFNGLVDPAUREGISTERVIDEOSURFACENVPROC as function(byval vdpSurface as const any ptr, byval target as GLenum, byval numTextureNames as GLsizei, byval textureNames as const GLuint ptr) as GLvdpauSurfaceNV
type PFNGLVDPAUREGISTEROUTPUTSURFACENVPROC as function(byval vdpSurface as const any ptr, byval target as GLenum, byval numTextureNames as GLsizei, byval textureNames as const GLuint ptr) as GLvdpauSurfaceNV
type PFNGLVDPAUISSURFACENVPROC as function(byval surface as GLvdpauSurfaceNV) as GLboolean
type PFNGLVDPAUUNREGISTERSURFACENVPROC as sub(byval surface as GLvdpauSurfaceNV)
type PFNGLVDPAUGETSURFACEIVNVPROC as sub(byval surface as GLvdpauSurfaceNV, byval pname as GLenum, byval bufSize as GLsizei, byval length as GLsizei ptr, byval values as GLint ptr)
type PFNGLVDPAUSURFACEACCESSNVPROC as sub(byval surface as GLvdpauSurfaceNV, byval access as GLenum)
type PFNGLVDPAUMAPSURFACESNVPROC as sub(byval numSurfaces as GLsizei, byval surfaces as const GLvdpauSurfaceNV ptr)
type PFNGLVDPAUUNMAPSURFACESNVPROC as sub(byval numSurface as GLsizei, byval surfaces as const GLvdpauSurfaceNV ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVDPAUInitNV(byval vdpDevice as const any ptr, byval getProcAddress as const any ptr)
	declare sub glVDPAUFiniNV()
	declare function glVDPAURegisterVideoSurfaceNV(byval vdpSurface as const any ptr, byval target as GLenum, byval numTextureNames as GLsizei, byval textureNames as const GLuint ptr) as GLvdpauSurfaceNV
	declare function glVDPAURegisterOutputSurfaceNV(byval vdpSurface as const any ptr, byval target as GLenum, byval numTextureNames as GLsizei, byval textureNames as const GLuint ptr) as GLvdpauSurfaceNV
	declare function glVDPAUIsSurfaceNV(byval surface as GLvdpauSurfaceNV) as GLboolean
	declare sub glVDPAUUnregisterSurfaceNV(byval surface as GLvdpauSurfaceNV)
	declare sub glVDPAUGetSurfaceivNV(byval surface as GLvdpauSurfaceNV, byval pname as GLenum, byval bufSize as GLsizei, byval length as GLsizei ptr, byval values as GLint ptr)
	declare sub glVDPAUSurfaceAccessNV(byval surface as GLvdpauSurfaceNV, byval access as GLenum)
	declare sub glVDPAUMapSurfacesNV(byval numSurfaces as GLsizei, byval surfaces as const GLvdpauSurfaceNV ptr)
	declare sub glVDPAUUnmapSurfacesNV(byval numSurface as GLsizei, byval surfaces as const GLvdpauSurfaceNV ptr)
#endif

const GL_NV_vertex_array_range = 1
const GL_VERTEX_ARRAY_RANGE_NV = &h851D
const GL_VERTEX_ARRAY_RANGE_LENGTH_NV = &h851E
const GL_VERTEX_ARRAY_RANGE_VALID_NV = &h851F
const GL_MAX_VERTEX_ARRAY_RANGE_ELEMENT_NV = &h8520
const GL_VERTEX_ARRAY_RANGE_POINTER_NV = &h8521
type PFNGLFLUSHVERTEXARRAYRANGENVPROC as sub()
type PFNGLVERTEXARRAYRANGENVPROC as sub(byval length as GLsizei, byval pointer as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glFlushVertexArrayRangeNV()
	declare sub glVertexArrayRangeNV(byval length as GLsizei, byval pointer as const any ptr)
#endif

const GL_NV_vertex_array_range2 = 1
const GL_VERTEX_ARRAY_RANGE_WITHOUT_FLUSH_NV = &h8533
const GL_NV_vertex_attrib_integer_64bit = 1

type PFNGLVERTEXATTRIBL1I64NVPROC as sub(byval index as GLuint, byval x as GLint64EXT)
type PFNGLVERTEXATTRIBL2I64NVPROC as sub(byval index as GLuint, byval x as GLint64EXT, byval y as GLint64EXT)
type PFNGLVERTEXATTRIBL3I64NVPROC as sub(byval index as GLuint, byval x as GLint64EXT, byval y as GLint64EXT, byval z as GLint64EXT)
type PFNGLVERTEXATTRIBL4I64NVPROC as sub(byval index as GLuint, byval x as GLint64EXT, byval y as GLint64EXT, byval z as GLint64EXT, byval w as GLint64EXT)
type PFNGLVERTEXATTRIBL1I64VNVPROC as sub(byval index as GLuint, byval v as const GLint64EXT ptr)
type PFNGLVERTEXATTRIBL2I64VNVPROC as sub(byval index as GLuint, byval v as const GLint64EXT ptr)
type PFNGLVERTEXATTRIBL3I64VNVPROC as sub(byval index as GLuint, byval v as const GLint64EXT ptr)
type PFNGLVERTEXATTRIBL4I64VNVPROC as sub(byval index as GLuint, byval v as const GLint64EXT ptr)
type PFNGLVERTEXATTRIBL1UI64NVPROC as sub(byval index as GLuint, byval x as GLuint64EXT)
type PFNGLVERTEXATTRIBL2UI64NVPROC as sub(byval index as GLuint, byval x as GLuint64EXT, byval y as GLuint64EXT)
type PFNGLVERTEXATTRIBL3UI64NVPROC as sub(byval index as GLuint, byval x as GLuint64EXT, byval y as GLuint64EXT, byval z as GLuint64EXT)
type PFNGLVERTEXATTRIBL4UI64NVPROC as sub(byval index as GLuint, byval x as GLuint64EXT, byval y as GLuint64EXT, byval z as GLuint64EXT, byval w as GLuint64EXT)
type PFNGLVERTEXATTRIBL1UI64VNVPROC as sub(byval index as GLuint, byval v as const GLuint64EXT ptr)
type PFNGLVERTEXATTRIBL2UI64VNVPROC as sub(byval index as GLuint, byval v as const GLuint64EXT ptr)
type PFNGLVERTEXATTRIBL3UI64VNVPROC as sub(byval index as GLuint, byval v as const GLuint64EXT ptr)
type PFNGLVERTEXATTRIBL4UI64VNVPROC as sub(byval index as GLuint, byval v as const GLuint64EXT ptr)
type PFNGLGETVERTEXATTRIBLI64VNVPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLint64EXT ptr)
type PFNGLGETVERTEXATTRIBLUI64VNVPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLuint64EXT ptr)
type PFNGLVERTEXATTRIBLFORMATNVPROC as sub(byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVertexAttribL1i64NV(byval index as GLuint, byval x as GLint64EXT)
	declare sub glVertexAttribL2i64NV(byval index as GLuint, byval x as GLint64EXT, byval y as GLint64EXT)
	declare sub glVertexAttribL3i64NV(byval index as GLuint, byval x as GLint64EXT, byval y as GLint64EXT, byval z as GLint64EXT)
	declare sub glVertexAttribL4i64NV(byval index as GLuint, byval x as GLint64EXT, byval y as GLint64EXT, byval z as GLint64EXT, byval w as GLint64EXT)
	declare sub glVertexAttribL1i64vNV(byval index as GLuint, byval v as const GLint64EXT ptr)
	declare sub glVertexAttribL2i64vNV(byval index as GLuint, byval v as const GLint64EXT ptr)
	declare sub glVertexAttribL3i64vNV(byval index as GLuint, byval v as const GLint64EXT ptr)
	declare sub glVertexAttribL4i64vNV(byval index as GLuint, byval v as const GLint64EXT ptr)
	declare sub glVertexAttribL1ui64NV(byval index as GLuint, byval x as GLuint64EXT)
	declare sub glVertexAttribL2ui64NV(byval index as GLuint, byval x as GLuint64EXT, byval y as GLuint64EXT)
	declare sub glVertexAttribL3ui64NV(byval index as GLuint, byval x as GLuint64EXT, byval y as GLuint64EXT, byval z as GLuint64EXT)
	declare sub glVertexAttribL4ui64NV(byval index as GLuint, byval x as GLuint64EXT, byval y as GLuint64EXT, byval z as GLuint64EXT, byval w as GLuint64EXT)
	declare sub glVertexAttribL1ui64vNV(byval index as GLuint, byval v as const GLuint64EXT ptr)
	declare sub glVertexAttribL2ui64vNV(byval index as GLuint, byval v as const GLuint64EXT ptr)
	declare sub glVertexAttribL3ui64vNV(byval index as GLuint, byval v as const GLuint64EXT ptr)
	declare sub glVertexAttribL4ui64vNV(byval index as GLuint, byval v as const GLuint64EXT ptr)
	declare sub glGetVertexAttribLi64vNV(byval index as GLuint, byval pname as GLenum, byval params as GLint64EXT ptr)
	declare sub glGetVertexAttribLui64vNV(byval index as GLuint, byval pname as GLenum, byval params as GLuint64EXT ptr)
	declare sub glVertexAttribLFormatNV(byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei)
#endif

const GL_NV_vertex_buffer_unified_memory = 1
const GL_VERTEX_ATTRIB_ARRAY_UNIFIED_NV = &h8F1E
const GL_ELEMENT_ARRAY_UNIFIED_NV = &h8F1F
const GL_VERTEX_ATTRIB_ARRAY_ADDRESS_NV = &h8F20
const GL_VERTEX_ARRAY_ADDRESS_NV = &h8F21
const GL_NORMAL_ARRAY_ADDRESS_NV = &h8F22
const GL_COLOR_ARRAY_ADDRESS_NV = &h8F23
const GL_INDEX_ARRAY_ADDRESS_NV = &h8F24
const GL_TEXTURE_COORD_ARRAY_ADDRESS_NV = &h8F25
const GL_EDGE_FLAG_ARRAY_ADDRESS_NV = &h8F26
const GL_SECONDARY_COLOR_ARRAY_ADDRESS_NV = &h8F27
const GL_FOG_COORD_ARRAY_ADDRESS_NV = &h8F28
const GL_ELEMENT_ARRAY_ADDRESS_NV = &h8F29
const GL_VERTEX_ATTRIB_ARRAY_LENGTH_NV = &h8F2A
const GL_VERTEX_ARRAY_LENGTH_NV = &h8F2B
const GL_NORMAL_ARRAY_LENGTH_NV = &h8F2C
const GL_COLOR_ARRAY_LENGTH_NV = &h8F2D
const GL_INDEX_ARRAY_LENGTH_NV = &h8F2E
const GL_TEXTURE_COORD_ARRAY_LENGTH_NV = &h8F2F
const GL_EDGE_FLAG_ARRAY_LENGTH_NV = &h8F30
const GL_SECONDARY_COLOR_ARRAY_LENGTH_NV = &h8F31
const GL_FOG_COORD_ARRAY_LENGTH_NV = &h8F32
const GL_ELEMENT_ARRAY_LENGTH_NV = &h8F33
const GL_DRAW_INDIRECT_UNIFIED_NV = &h8F40
const GL_DRAW_INDIRECT_ADDRESS_NV = &h8F41
const GL_DRAW_INDIRECT_LENGTH_NV = &h8F42

type PFNGLBUFFERADDRESSRANGENVPROC as sub(byval pname as GLenum, byval index as GLuint, byval address as GLuint64EXT, byval length as GLsizeiptr)
type PFNGLVERTEXFORMATNVPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLsizei)
type PFNGLNORMALFORMATNVPROC as sub(byval type as GLenum, byval stride as GLsizei)
type PFNGLCOLORFORMATNVPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLsizei)
type PFNGLINDEXFORMATNVPROC as sub(byval type as GLenum, byval stride as GLsizei)
type PFNGLTEXCOORDFORMATNVPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLsizei)
type PFNGLEDGEFLAGFORMATNVPROC as sub(byval stride as GLsizei)
type PFNGLSECONDARYCOLORFORMATNVPROC as sub(byval size as GLint, byval type as GLenum, byval stride as GLsizei)
type PFNGLFOGCOORDFORMATNVPROC as sub(byval type as GLenum, byval stride as GLsizei)
type PFNGLVERTEXATTRIBFORMATNVPROC as sub(byval index as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval stride as GLsizei)
type PFNGLVERTEXATTRIBIFORMATNVPROC as sub(byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei)
type PFNGLGETINTEGERUI64I_VNVPROC as sub(byval value as GLenum, byval index as GLuint, byval result as GLuint64EXT ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBufferAddressRangeNV(byval pname as GLenum, byval index as GLuint, byval address as GLuint64EXT, byval length as GLsizeiptr)
	declare sub glVertexFormatNV(byval size as GLint, byval type as GLenum, byval stride as GLsizei)
	declare sub glNormalFormatNV(byval type as GLenum, byval stride as GLsizei)
	declare sub glColorFormatNV(byval size as GLint, byval type as GLenum, byval stride as GLsizei)
	declare sub glIndexFormatNV(byval type as GLenum, byval stride as GLsizei)
	declare sub glTexCoordFormatNV(byval size as GLint, byval type as GLenum, byval stride as GLsizei)
	declare sub glEdgeFlagFormatNV(byval stride as GLsizei)
	declare sub glSecondaryColorFormatNV(byval size as GLint, byval type as GLenum, byval stride as GLsizei)
	declare sub glFogCoordFormatNV(byval type as GLenum, byval stride as GLsizei)
	declare sub glVertexAttribFormatNV(byval index as GLuint, byval size as GLint, byval type as GLenum, byval normalized as GLboolean, byval stride as GLsizei)
	declare sub glVertexAttribIFormatNV(byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei)
	declare sub glGetIntegerui64i_vNV(byval value as GLenum, byval index as GLuint, byval result as GLuint64EXT ptr)
#endif

const GL_NV_vertex_program = 1
const GL_VERTEX_PROGRAM_NV = &h8620
const GL_VERTEX_STATE_PROGRAM_NV = &h8621
const GL_ATTRIB_ARRAY_SIZE_NV = &h8623
const GL_ATTRIB_ARRAY_STRIDE_NV = &h8624
const GL_ATTRIB_ARRAY_TYPE_NV = &h8625
const GL_CURRENT_ATTRIB_NV = &h8626
const GL_PROGRAM_LENGTH_NV = &h8627
const GL_PROGRAM_STRING_NV = &h8628
const GL_MODELVIEW_PROJECTION_NV = &h8629
const GL_IDENTITY_NV = &h862A
const GL_INVERSE_NV = &h862B
const GL_TRANSPOSE_NV = &h862C
const GL_INVERSE_TRANSPOSE_NV = &h862D
const GL_MAX_TRACK_MATRIX_STACK_DEPTH_NV = &h862E
const GL_MAX_TRACK_MATRICES_NV = &h862F
const GL_MATRIX0_NV = &h8630
const GL_MATRIX1_NV = &h8631
const GL_MATRIX2_NV = &h8632
const GL_MATRIX3_NV = &h8633
const GL_MATRIX4_NV = &h8634
const GL_MATRIX5_NV = &h8635
const GL_MATRIX6_NV = &h8636
const GL_MATRIX7_NV = &h8637
const GL_CURRENT_MATRIX_STACK_DEPTH_NV = &h8640
const GL_CURRENT_MATRIX_NV = &h8641
const GL_VERTEX_PROGRAM_POINT_SIZE_NV = &h8642
const GL_VERTEX_PROGRAM_TWO_SIDE_NV = &h8643
const GL_PROGRAM_PARAMETER_NV = &h8644
const GL_ATTRIB_ARRAY_POINTER_NV = &h8645
const GL_PROGRAM_TARGET_NV = &h8646
const GL_PROGRAM_RESIDENT_NV = &h8647
const GL_TRACK_MATRIX_NV = &h8648
const GL_TRACK_MATRIX_TRANSFORM_NV = &h8649
const GL_VERTEX_PROGRAM_BINDING_NV = &h864A
const GL_PROGRAM_ERROR_POSITION_NV = &h864B
const GL_VERTEX_ATTRIB_ARRAY0_NV = &h8650
const GL_VERTEX_ATTRIB_ARRAY1_NV = &h8651
const GL_VERTEX_ATTRIB_ARRAY2_NV = &h8652
const GL_VERTEX_ATTRIB_ARRAY3_NV = &h8653
const GL_VERTEX_ATTRIB_ARRAY4_NV = &h8654
const GL_VERTEX_ATTRIB_ARRAY5_NV = &h8655
const GL_VERTEX_ATTRIB_ARRAY6_NV = &h8656
const GL_VERTEX_ATTRIB_ARRAY7_NV = &h8657
const GL_VERTEX_ATTRIB_ARRAY8_NV = &h8658
const GL_VERTEX_ATTRIB_ARRAY9_NV = &h8659
const GL_VERTEX_ATTRIB_ARRAY10_NV = &h865A
const GL_VERTEX_ATTRIB_ARRAY11_NV = &h865B
const GL_VERTEX_ATTRIB_ARRAY12_NV = &h865C
const GL_VERTEX_ATTRIB_ARRAY13_NV = &h865D
const GL_VERTEX_ATTRIB_ARRAY14_NV = &h865E
const GL_VERTEX_ATTRIB_ARRAY15_NV = &h865F
const GL_MAP1_VERTEX_ATTRIB0_4_NV = &h8660
const GL_MAP1_VERTEX_ATTRIB1_4_NV = &h8661
const GL_MAP1_VERTEX_ATTRIB2_4_NV = &h8662
const GL_MAP1_VERTEX_ATTRIB3_4_NV = &h8663
const GL_MAP1_VERTEX_ATTRIB4_4_NV = &h8664
const GL_MAP1_VERTEX_ATTRIB5_4_NV = &h8665
const GL_MAP1_VERTEX_ATTRIB6_4_NV = &h8666
const GL_MAP1_VERTEX_ATTRIB7_4_NV = &h8667
const GL_MAP1_VERTEX_ATTRIB8_4_NV = &h8668
const GL_MAP1_VERTEX_ATTRIB9_4_NV = &h8669
const GL_MAP1_VERTEX_ATTRIB10_4_NV = &h866A
const GL_MAP1_VERTEX_ATTRIB11_4_NV = &h866B
const GL_MAP1_VERTEX_ATTRIB12_4_NV = &h866C
const GL_MAP1_VERTEX_ATTRIB13_4_NV = &h866D
const GL_MAP1_VERTEX_ATTRIB14_4_NV = &h866E
const GL_MAP1_VERTEX_ATTRIB15_4_NV = &h866F
const GL_MAP2_VERTEX_ATTRIB0_4_NV = &h8670
const GL_MAP2_VERTEX_ATTRIB1_4_NV = &h8671
const GL_MAP2_VERTEX_ATTRIB2_4_NV = &h8672
const GL_MAP2_VERTEX_ATTRIB3_4_NV = &h8673
const GL_MAP2_VERTEX_ATTRIB4_4_NV = &h8674
const GL_MAP2_VERTEX_ATTRIB5_4_NV = &h8675
const GL_MAP2_VERTEX_ATTRIB6_4_NV = &h8676
const GL_MAP2_VERTEX_ATTRIB7_4_NV = &h8677
const GL_MAP2_VERTEX_ATTRIB8_4_NV = &h8678
const GL_MAP2_VERTEX_ATTRIB9_4_NV = &h8679
const GL_MAP2_VERTEX_ATTRIB10_4_NV = &h867A
const GL_MAP2_VERTEX_ATTRIB11_4_NV = &h867B
const GL_MAP2_VERTEX_ATTRIB12_4_NV = &h867C
const GL_MAP2_VERTEX_ATTRIB13_4_NV = &h867D
const GL_MAP2_VERTEX_ATTRIB14_4_NV = &h867E
const GL_MAP2_VERTEX_ATTRIB15_4_NV = &h867F

type PFNGLAREPROGRAMSRESIDENTNVPROC as function(byval n as GLsizei, byval programs as const GLuint ptr, byval residences as GLboolean ptr) as GLboolean
type PFNGLBINDPROGRAMNVPROC as sub(byval target as GLenum, byval id as GLuint)
type PFNGLDELETEPROGRAMSNVPROC as sub(byval n as GLsizei, byval programs as const GLuint ptr)
type PFNGLEXECUTEPROGRAMNVPROC as sub(byval target as GLenum, byval id as GLuint, byval params as const GLfloat ptr)
type PFNGLGENPROGRAMSNVPROC as sub(byval n as GLsizei, byval programs as GLuint ptr)
type PFNGLGETPROGRAMPARAMETERDVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
type PFNGLGETPROGRAMPARAMETERFVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETPROGRAMIVNVPROC as sub(byval id as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETPROGRAMSTRINGNVPROC as sub(byval id as GLuint, byval pname as GLenum, byval program as GLubyte ptr)
type PFNGLGETTRACKMATRIXIVNVPROC as sub(byval target as GLenum, byval address as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETVERTEXATTRIBDVNVPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
type PFNGLGETVERTEXATTRIBFVNVPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETVERTEXATTRIBIVNVPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETVERTEXATTRIBPOINTERVNVPROC as sub(byval index as GLuint, byval pname as GLenum, byval pointer as any ptr ptr)
type PFNGLISPROGRAMNVPROC as function(byval id as GLuint) as GLboolean
type PFNGLLOADPROGRAMNVPROC as sub(byval target as GLenum, byval id as GLuint, byval len as GLsizei, byval program as const GLubyte ptr)
type PFNGLPROGRAMPARAMETER4DNVPROC as sub(byval target as GLenum, byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLPROGRAMPARAMETER4DVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLPROGRAMPARAMETER4FNVPROC as sub(byval target as GLenum, byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
type PFNGLPROGRAMPARAMETER4FVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLPROGRAMPARAMETERS4DVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval v as const GLdouble ptr)
type PFNGLPROGRAMPARAMETERS4FVNVPROC as sub(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
type PFNGLREQUESTRESIDENTPROGRAMSNVPROC as sub(byval n as GLsizei, byval programs as const GLuint ptr)
type PFNGLTRACKMATRIXNVPROC as sub(byval target as GLenum, byval address as GLuint, byval matrix as GLenum, byval transform as GLenum)
type PFNGLVERTEXATTRIBPOINTERNVPROC as sub(byval index as GLuint, byval fsize as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
type PFNGLVERTEXATTRIB1DNVPROC as sub(byval index as GLuint, byval x as GLdouble)
type PFNGLVERTEXATTRIB1DVNVPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIB1FNVPROC as sub(byval index as GLuint, byval x as GLfloat)
type PFNGLVERTEXATTRIB1FVNVPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIB1SNVPROC as sub(byval index as GLuint, byval x as GLshort)
type PFNGLVERTEXATTRIB1SVNVPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB2DNVPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble)
type PFNGLVERTEXATTRIB2DVNVPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIB2FNVPROC as sub(byval index as GLuint, byval x as GLfloat, byval y as GLfloat)
type PFNGLVERTEXATTRIB2FVNVPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIB2SNVPROC as sub(byval index as GLuint, byval x as GLshort, byval y as GLshort)
type PFNGLVERTEXATTRIB2SVNVPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB3DNVPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
type PFNGLVERTEXATTRIB3DVNVPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIB3FNVPROC as sub(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLVERTEXATTRIB3FVNVPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIB3SNVPROC as sub(byval index as GLuint, byval x as GLshort, byval y as GLshort, byval z as GLshort)
type PFNGLVERTEXATTRIB3SVNVPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB4DNVPROC as sub(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
type PFNGLVERTEXATTRIB4DVNVPROC as sub(byval index as GLuint, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIB4FNVPROC as sub(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
type PFNGLVERTEXATTRIB4FVNVPROC as sub(byval index as GLuint, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIB4SNVPROC as sub(byval index as GLuint, byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
type PFNGLVERTEXATTRIB4SVNVPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIB4UBNVPROC as sub(byval index as GLuint, byval x as GLubyte, byval y as GLubyte, byval z as GLubyte, byval w as GLubyte)
type PFNGLVERTEXATTRIB4UBVNVPROC as sub(byval index as GLuint, byval v as const GLubyte ptr)
type PFNGLVERTEXATTRIBS1DVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIBS1FVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIBS1SVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIBS2DVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIBS2FVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIBS2SVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIBS3DVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIBS3FVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIBS3SVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIBS4DVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLdouble ptr)
type PFNGLVERTEXATTRIBS4FVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
type PFNGLVERTEXATTRIBS4SVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIBS4UBVNVPROC as sub(byval index as GLuint, byval count as GLsizei, byval v as const GLubyte ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare function glAreProgramsResidentNV(byval n as GLsizei, byval programs as const GLuint ptr, byval residences as GLboolean ptr) as GLboolean
	declare sub glBindProgramNV(byval target as GLenum, byval id as GLuint)
	declare sub glDeleteProgramsNV(byval n as GLsizei, byval programs as const GLuint ptr)
	declare sub glExecuteProgramNV(byval target as GLenum, byval id as GLuint, byval params as const GLfloat ptr)
	declare sub glGenProgramsNV(byval n as GLsizei, byval programs as GLuint ptr)
	declare sub glGetProgramParameterdvNV(byval target as GLenum, byval index as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
	declare sub glGetProgramParameterfvNV(byval target as GLenum, byval index as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetProgramivNV(byval id as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetProgramStringNV(byval id as GLuint, byval pname as GLenum, byval program as GLubyte ptr)
	declare sub glGetTrackMatrixivNV(byval target as GLenum, byval address as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetVertexAttribdvNV(byval index as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
	declare sub glGetVertexAttribfvNV(byval index as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetVertexAttribivNV(byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetVertexAttribPointervNV(byval index as GLuint, byval pname as GLenum, byval pointer as any ptr ptr)
	declare function glIsProgramNV(byval id as GLuint) as GLboolean
	declare sub glLoadProgramNV(byval target as GLenum, byval id as GLuint, byval len as GLsizei, byval program as const GLubyte ptr)
	declare sub glProgramParameter4dNV(byval target as GLenum, byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glProgramParameter4dvNV(byval target as GLenum, byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glProgramParameter4fNV(byval target as GLenum, byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
	declare sub glProgramParameter4fvNV(byval target as GLenum, byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glProgramParameters4dvNV(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval v as const GLdouble ptr)
	declare sub glProgramParameters4fvNV(byval target as GLenum, byval index as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
	declare sub glRequestResidentProgramsNV(byval n as GLsizei, byval programs as const GLuint ptr)
	declare sub glTrackMatrixNV(byval target as GLenum, byval address as GLuint, byval matrix as GLenum, byval transform as GLenum)
	declare sub glVertexAttribPointerNV(byval index as GLuint, byval fsize as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
	declare sub glVertexAttrib1dNV(byval index as GLuint, byval x as GLdouble)
	declare sub glVertexAttrib1dvNV(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttrib1fNV(byval index as GLuint, byval x as GLfloat)
	declare sub glVertexAttrib1fvNV(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glVertexAttrib1sNV(byval index as GLuint, byval x as GLshort)
	declare sub glVertexAttrib1svNV(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib2dNV(byval index as GLuint, byval x as GLdouble, byval y as GLdouble)
	declare sub glVertexAttrib2dvNV(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttrib2fNV(byval index as GLuint, byval x as GLfloat, byval y as GLfloat)
	declare sub glVertexAttrib2fvNV(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glVertexAttrib2sNV(byval index as GLuint, byval x as GLshort, byval y as GLshort)
	declare sub glVertexAttrib2svNV(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib3dNV(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble)
	declare sub glVertexAttrib3dvNV(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttrib3fNV(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glVertexAttrib3fvNV(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glVertexAttrib3sNV(byval index as GLuint, byval x as GLshort, byval y as GLshort, byval z as GLshort)
	declare sub glVertexAttrib3svNV(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib4dNV(byval index as GLuint, byval x as GLdouble, byval y as GLdouble, byval z as GLdouble, byval w as GLdouble)
	declare sub glVertexAttrib4dvNV(byval index as GLuint, byval v as const GLdouble ptr)
	declare sub glVertexAttrib4fNV(byval index as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
	declare sub glVertexAttrib4fvNV(byval index as GLuint, byval v as const GLfloat ptr)
	declare sub glVertexAttrib4sNV(byval index as GLuint, byval x as GLshort, byval y as GLshort, byval z as GLshort, byval w as GLshort)
	declare sub glVertexAttrib4svNV(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttrib4ubNV(byval index as GLuint, byval x as GLubyte, byval y as GLubyte, byval z as GLubyte, byval w as GLubyte)
	declare sub glVertexAttrib4ubvNV(byval index as GLuint, byval v as const GLubyte ptr)
	declare sub glVertexAttribs1dvNV(byval index as GLuint, byval count as GLsizei, byval v as const GLdouble ptr)
	declare sub glVertexAttribs1fvNV(byval index as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
	declare sub glVertexAttribs1svNV(byval index as GLuint, byval count as GLsizei, byval v as const GLshort ptr)
	declare sub glVertexAttribs2dvNV(byval index as GLuint, byval count as GLsizei, byval v as const GLdouble ptr)
	declare sub glVertexAttribs2fvNV(byval index as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
	declare sub glVertexAttribs2svNV(byval index as GLuint, byval count as GLsizei, byval v as const GLshort ptr)
	declare sub glVertexAttribs3dvNV(byval index as GLuint, byval count as GLsizei, byval v as const GLdouble ptr)
	declare sub glVertexAttribs3fvNV(byval index as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
	declare sub glVertexAttribs3svNV(byval index as GLuint, byval count as GLsizei, byval v as const GLshort ptr)
	declare sub glVertexAttribs4dvNV(byval index as GLuint, byval count as GLsizei, byval v as const GLdouble ptr)
	declare sub glVertexAttribs4fvNV(byval index as GLuint, byval count as GLsizei, byval v as const GLfloat ptr)
	declare sub glVertexAttribs4svNV(byval index as GLuint, byval count as GLsizei, byval v as const GLshort ptr)
	declare sub glVertexAttribs4ubvNV(byval index as GLuint, byval count as GLsizei, byval v as const GLubyte ptr)
#endif

const GL_NV_vertex_program1_1 = 1
const GL_NV_vertex_program2 = 1
const GL_NV_vertex_program2_option = 1
const GL_NV_vertex_program3 = 1
const GL_NV_vertex_program4 = 1
const GL_VERTEX_ATTRIB_ARRAY_INTEGER_NV = &h88FD

type PFNGLVERTEXATTRIBI1IEXTPROC as sub(byval index as GLuint, byval x as GLint)
type PFNGLVERTEXATTRIBI2IEXTPROC as sub(byval index as GLuint, byval x as GLint, byval y as GLint)
type PFNGLVERTEXATTRIBI3IEXTPROC as sub(byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint)
type PFNGLVERTEXATTRIBI4IEXTPROC as sub(byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
type PFNGLVERTEXATTRIBI1UIEXTPROC as sub(byval index as GLuint, byval x as GLuint)
type PFNGLVERTEXATTRIBI2UIEXTPROC as sub(byval index as GLuint, byval x as GLuint, byval y as GLuint)
type PFNGLVERTEXATTRIBI3UIEXTPROC as sub(byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint)
type PFNGLVERTEXATTRIBI4UIEXTPROC as sub(byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint, byval w as GLuint)
type PFNGLVERTEXATTRIBI1IVEXTPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLVERTEXATTRIBI2IVEXTPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLVERTEXATTRIBI3IVEXTPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLVERTEXATTRIBI4IVEXTPROC as sub(byval index as GLuint, byval v as const GLint ptr)
type PFNGLVERTEXATTRIBI1UIVEXTPROC as sub(byval index as GLuint, byval v as const GLuint ptr)
type PFNGLVERTEXATTRIBI2UIVEXTPROC as sub(byval index as GLuint, byval v as const GLuint ptr)
type PFNGLVERTEXATTRIBI3UIVEXTPROC as sub(byval index as GLuint, byval v as const GLuint ptr)
type PFNGLVERTEXATTRIBI4UIVEXTPROC as sub(byval index as GLuint, byval v as const GLuint ptr)
type PFNGLVERTEXATTRIBI4BVEXTPROC as sub(byval index as GLuint, byval v as const GLbyte ptr)
type PFNGLVERTEXATTRIBI4SVEXTPROC as sub(byval index as GLuint, byval v as const GLshort ptr)
type PFNGLVERTEXATTRIBI4UBVEXTPROC as sub(byval index as GLuint, byval v as const GLubyte ptr)
type PFNGLVERTEXATTRIBI4USVEXTPROC as sub(byval index as GLuint, byval v as const GLushort ptr)
type PFNGLVERTEXATTRIBIPOINTEREXTPROC as sub(byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
type PFNGLGETVERTEXATTRIBIIVEXTPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETVERTEXATTRIBIUIVEXTPROC as sub(byval index as GLuint, byval pname as GLenum, byval params as GLuint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glVertexAttribI1iEXT(byval index as GLuint, byval x as GLint)
	declare sub glVertexAttribI2iEXT(byval index as GLuint, byval x as GLint, byval y as GLint)
	declare sub glVertexAttribI3iEXT(byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint)
	declare sub glVertexAttribI4iEXT(byval index as GLuint, byval x as GLint, byval y as GLint, byval z as GLint, byval w as GLint)
	declare sub glVertexAttribI1uiEXT(byval index as GLuint, byval x as GLuint)
	declare sub glVertexAttribI2uiEXT(byval index as GLuint, byval x as GLuint, byval y as GLuint)
	declare sub glVertexAttribI3uiEXT(byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint)
	declare sub glVertexAttribI4uiEXT(byval index as GLuint, byval x as GLuint, byval y as GLuint, byval z as GLuint, byval w as GLuint)
	declare sub glVertexAttribI1ivEXT(byval index as GLuint, byval v as const GLint ptr)
	declare sub glVertexAttribI2ivEXT(byval index as GLuint, byval v as const GLint ptr)
	declare sub glVertexAttribI3ivEXT(byval index as GLuint, byval v as const GLint ptr)
	declare sub glVertexAttribI4ivEXT(byval index as GLuint, byval v as const GLint ptr)
	declare sub glVertexAttribI1uivEXT(byval index as GLuint, byval v as const GLuint ptr)
	declare sub glVertexAttribI2uivEXT(byval index as GLuint, byval v as const GLuint ptr)
	declare sub glVertexAttribI3uivEXT(byval index as GLuint, byval v as const GLuint ptr)
	declare sub glVertexAttribI4uivEXT(byval index as GLuint, byval v as const GLuint ptr)
	declare sub glVertexAttribI4bvEXT(byval index as GLuint, byval v as const GLbyte ptr)
	declare sub glVertexAttribI4svEXT(byval index as GLuint, byval v as const GLshort ptr)
	declare sub glVertexAttribI4ubvEXT(byval index as GLuint, byval v as const GLubyte ptr)
	declare sub glVertexAttribI4usvEXT(byval index as GLuint, byval v as const GLushort ptr)
	declare sub glVertexAttribIPointerEXT(byval index as GLuint, byval size as GLint, byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr)
	declare sub glGetVertexAttribIivEXT(byval index as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetVertexAttribIuivEXT(byval index as GLuint, byval pname as GLenum, byval params as GLuint ptr)
#endif

const GL_NV_video_capture = 1
const GL_VIDEO_BUFFER_NV = &h9020
const GL_VIDEO_BUFFER_BINDING_NV = &h9021
const GL_FIELD_UPPER_NV = &h9022
const GL_FIELD_LOWER_NV = &h9023
const GL_NUM_VIDEO_CAPTURE_STREAMS_NV = &h9024
const GL_NEXT_VIDEO_CAPTURE_BUFFER_STATUS_NV = &h9025
const GL_VIDEO_CAPTURE_TO_422_SUPPORTED_NV = &h9026
const GL_LAST_VIDEO_CAPTURE_STATUS_NV = &h9027
const GL_VIDEO_BUFFER_PITCH_NV = &h9028
const GL_VIDEO_COLOR_CONVERSION_MATRIX_NV = &h9029
const GL_VIDEO_COLOR_CONVERSION_MAX_NV = &h902A
const GL_VIDEO_COLOR_CONVERSION_MIN_NV = &h902B
const GL_VIDEO_COLOR_CONVERSION_OFFSET_NV = &h902C
const GL_VIDEO_BUFFER_INTERNAL_FORMAT_NV = &h902D
const GL_PARTIAL_SUCCESS_NV = &h902E
const GL_SUCCESS_NV = &h902F
const GL_FAILURE_NV = &h9030
const GL_YCBYCR8_422_NV = &h9031
const GL_YCBAYCR8A_4224_NV = &h9032
const GL_Z6Y10Z6CB10Z6Y10Z6CR10_422_NV = &h9033
const GL_Z6Y10Z6CB10Z6A10Z6Y10Z6CR10Z6A10_4224_NV = &h9034
const GL_Z4Y12Z4CB12Z4Y12Z4CR12_422_NV = &h9035
const GL_Z4Y12Z4CB12Z4A12Z4Y12Z4CR12Z4A12_4224_NV = &h9036
const GL_Z4Y12Z4CB12Z4CR12_444_NV = &h9037
const GL_VIDEO_CAPTURE_FRAME_WIDTH_NV = &h9038
const GL_VIDEO_CAPTURE_FRAME_HEIGHT_NV = &h9039
const GL_VIDEO_CAPTURE_FIELD_UPPER_HEIGHT_NV = &h903A
const GL_VIDEO_CAPTURE_FIELD_LOWER_HEIGHT_NV = &h903B
const GL_VIDEO_CAPTURE_SURFACE_ORIGIN_NV = &h903C

type PFNGLBEGINVIDEOCAPTURENVPROC as sub(byval video_capture_slot as GLuint)
type PFNGLBINDVIDEOCAPTURESTREAMBUFFERNVPROC as sub(byval video_capture_slot as GLuint, byval stream as GLuint, byval frame_region as GLenum, byval offset as GLintptrARB)
type PFNGLBINDVIDEOCAPTURESTREAMTEXTURENVPROC as sub(byval video_capture_slot as GLuint, byval stream as GLuint, byval frame_region as GLenum, byval target as GLenum, byval texture as GLuint)
type PFNGLENDVIDEOCAPTURENVPROC as sub(byval video_capture_slot as GLuint)
type PFNGLGETVIDEOCAPTUREIVNVPROC as sub(byval video_capture_slot as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETVIDEOCAPTURESTREAMIVNVPROC as sub(byval video_capture_slot as GLuint, byval stream as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETVIDEOCAPTURESTREAMFVNVPROC as sub(byval video_capture_slot as GLuint, byval stream as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETVIDEOCAPTURESTREAMDVNVPROC as sub(byval video_capture_slot as GLuint, byval stream as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
type PFNGLVIDEOCAPTURENVPROC as function(byval video_capture_slot as GLuint, byval sequence_num as GLuint ptr, byval capture_time as GLuint64EXT ptr) as GLenum
type PFNGLVIDEOCAPTURESTREAMPARAMETERIVNVPROC as sub(byval video_capture_slot as GLuint, byval stream as GLuint, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLVIDEOCAPTURESTREAMPARAMETERFVNVPROC as sub(byval video_capture_slot as GLuint, byval stream as GLuint, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLVIDEOCAPTURESTREAMPARAMETERDVNVPROC as sub(byval video_capture_slot as GLuint, byval stream as GLuint, byval pname as GLenum, byval params as const GLdouble ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glBeginVideoCaptureNV(byval video_capture_slot as GLuint)
	declare sub glBindVideoCaptureStreamBufferNV(byval video_capture_slot as GLuint, byval stream as GLuint, byval frame_region as GLenum, byval offset as GLintptrARB)
	declare sub glBindVideoCaptureStreamTextureNV(byval video_capture_slot as GLuint, byval stream as GLuint, byval frame_region as GLenum, byval target as GLenum, byval texture as GLuint)
	declare sub glEndVideoCaptureNV(byval video_capture_slot as GLuint)
	declare sub glGetVideoCaptureivNV(byval video_capture_slot as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetVideoCaptureStreamivNV(byval video_capture_slot as GLuint, byval stream as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetVideoCaptureStreamfvNV(byval video_capture_slot as GLuint, byval stream as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetVideoCaptureStreamdvNV(byval video_capture_slot as GLuint, byval stream as GLuint, byval pname as GLenum, byval params as GLdouble ptr)
	declare function glVideoCaptureNV(byval video_capture_slot as GLuint, byval sequence_num as GLuint ptr, byval capture_time as GLuint64EXT ptr) as GLenum
	declare sub glVideoCaptureStreamParameterivNV(byval video_capture_slot as GLuint, byval stream as GLuint, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glVideoCaptureStreamParameterfvNV(byval video_capture_slot as GLuint, byval stream as GLuint, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glVideoCaptureStreamParameterdvNV(byval video_capture_slot as GLuint, byval stream as GLuint, byval pname as GLenum, byval params as const GLdouble ptr)
#endif

const GL_NV_viewport_array2 = 1
const GL_OML_interlace = 1
const GL_INTERLACE_OML = &h8980
const GL_INTERLACE_READ_OML = &h8981
const GL_OML_resample = 1
const GL_PACK_RESAMPLE_OML = &h8984
const GL_UNPACK_RESAMPLE_OML = &h8985
const GL_RESAMPLE_REPLICATE_OML = &h8986
const GL_RESAMPLE_ZERO_FILL_OML = &h8987
const GL_RESAMPLE_AVERAGE_OML = &h8988
const GL_RESAMPLE_DECIMATE_OML = &h8989
const GL_OML_subsample = 1
const GL_FORMAT_SUBSAMPLE_24_24_OML = &h8982
const GL_FORMAT_SUBSAMPLE_244_244_OML = &h8983
const GL_PGI_misc_hints = 1
const GL_PREFER_DOUBLEBUFFER_HINT_PGI = &h1A1F8
const GL_CONSERVE_MEMORY_HINT_PGI = &h1A1FD
const GL_RECLAIM_MEMORY_HINT_PGI = &h1A1FE
const GL_NATIVE_GRAPHICS_HANDLE_PGI = &h1A202
const GL_NATIVE_GRAPHICS_BEGIN_HINT_PGI = &h1A203
const GL_NATIVE_GRAPHICS_END_HINT_PGI = &h1A204
const GL_ALWAYS_FAST_HINT_PGI = &h1A20C
const GL_ALWAYS_SOFT_HINT_PGI = &h1A20D
const GL_ALLOW_DRAW_OBJ_HINT_PGI = &h1A20E
const GL_ALLOW_DRAW_WIN_HINT_PGI = &h1A20F
const GL_ALLOW_DRAW_FRG_HINT_PGI = &h1A210
const GL_ALLOW_DRAW_MEM_HINT_PGI = &h1A211
const GL_STRICT_DEPTHFUNC_HINT_PGI = &h1A216
const GL_STRICT_LIGHTING_HINT_PGI = &h1A217
const GL_STRICT_SCISSOR_HINT_PGI = &h1A218
const GL_FULL_STIPPLE_HINT_PGI = &h1A219
const GL_CLIP_NEAR_HINT_PGI = &h1A220
const GL_CLIP_FAR_HINT_PGI = &h1A221
const GL_WIDE_LINE_HINT_PGI = &h1A222
const GL_BACK_NORMALS_HINT_PGI = &h1A223
type PFNGLHINTPGIPROC as sub(byval target as GLenum, byval mode as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glHintPGI(byval target as GLenum, byval mode as GLint)
#endif

const GL_PGI_vertex_hints = 1
const GL_VERTEX_DATA_HINT_PGI = &h1A22A
const GL_VERTEX_CONSISTENT_HINT_PGI = &h1A22B
const GL_MATERIAL_SIDE_HINT_PGI = &h1A22C
const GL_MAX_VERTEX_HINT_PGI = &h1A22D
const GL_COLOR3_BIT_PGI = &h00010000
const GL_COLOR4_BIT_PGI = &h00020000
const GL_EDGEFLAG_BIT_PGI = &h00040000
const GL_INDEX_BIT_PGI = &h00080000
const GL_MAT_AMBIENT_BIT_PGI = &h00100000
const GL_MAT_AMBIENT_AND_DIFFUSE_BIT_PGI = &h00200000
const GL_MAT_DIFFUSE_BIT_PGI = &h00400000
const GL_MAT_EMISSION_BIT_PGI = &h00800000
const GL_MAT_COLOR_INDEXES_BIT_PGI = &h01000000
const GL_MAT_SHININESS_BIT_PGI = &h02000000
const GL_MAT_SPECULAR_BIT_PGI = &h04000000
const GL_NORMAL_BIT_PGI = &h08000000
const GL_TEXCOORD1_BIT_PGI = &h10000000
const GL_TEXCOORD2_BIT_PGI = &h20000000
const GL_TEXCOORD3_BIT_PGI = &h40000000
const GL_TEXCOORD4_BIT_PGI = &h80000000
const GL_VERTEX23_BIT_PGI = &h00000004
const GL_VERTEX4_BIT_PGI = &h00000008
const GL_REND_screen_coordinates = 1
const GL_SCREEN_COORDINATES_REND = &h8490
const GL_INVERTED_SCREEN_W_REND = &h8491
const GL_S3_s3tc = 1
const GL_RGB_S3TC = &h83A0
const GL_RGB4_S3TC = &h83A1
const GL_RGBA_S3TC = &h83A2
const GL_RGBA4_S3TC = &h83A3
const GL_RGBA_DXT5_S3TC = &h83A4
const GL_RGBA4_DXT5_S3TC = &h83A5
const GL_SGIS_detail_texture = 1
const GL_DETAIL_TEXTURE_2D_SGIS = &h8095
const GL_DETAIL_TEXTURE_2D_BINDING_SGIS = &h8096
const GL_LINEAR_DETAIL_SGIS = &h8097
const GL_LINEAR_DETAIL_ALPHA_SGIS = &h8098
const GL_LINEAR_DETAIL_COLOR_SGIS = &h8099
const GL_DETAIL_TEXTURE_LEVEL_SGIS = &h809A
const GL_DETAIL_TEXTURE_MODE_SGIS = &h809B
const GL_DETAIL_TEXTURE_FUNC_POINTS_SGIS = &h809C
type PFNGLDETAILTEXFUNCSGISPROC as sub(byval target as GLenum, byval n as GLsizei, byval points as const GLfloat ptr)
type PFNGLGETDETAILTEXFUNCSGISPROC as sub(byval target as GLenum, byval points as GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDetailTexFuncSGIS(byval target as GLenum, byval n as GLsizei, byval points as const GLfloat ptr)
	declare sub glGetDetailTexFuncSGIS(byval target as GLenum, byval points as GLfloat ptr)
#endif

const GL_SGIS_fog_function = 1
const GL_FOG_FUNC_SGIS = &h812A
const GL_FOG_FUNC_POINTS_SGIS = &h812B
const GL_MAX_FOG_FUNC_POINTS_SGIS = &h812C
type PFNGLFOGFUNCSGISPROC as sub(byval n as GLsizei, byval points as const GLfloat ptr)
type PFNGLGETFOGFUNCSGISPROC as sub(byval points as GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glFogFuncSGIS(byval n as GLsizei, byval points as const GLfloat ptr)
	declare sub glGetFogFuncSGIS(byval points as GLfloat ptr)
#endif

const GL_SGIS_generate_mipmap = 1
const GL_GENERATE_MIPMAP_SGIS = &h8191
const GL_GENERATE_MIPMAP_HINT_SGIS = &h8192
const GL_SGIS_multisample = 1
const GL_MULTISAMPLE_SGIS = &h809D
const GL_SAMPLE_ALPHA_TO_MASK_SGIS = &h809E
const GL_SAMPLE_ALPHA_TO_ONE_SGIS = &h809F
const GL_SAMPLE_MASK_SGIS = &h80A0
const GL_1PASS_SGIS = &h80A1
const GL_2PASS_0_SGIS = &h80A2
const GL_2PASS_1_SGIS = &h80A3
const GL_4PASS_0_SGIS = &h80A4
const GL_4PASS_1_SGIS = &h80A5
const GL_4PASS_2_SGIS = &h80A6
const GL_4PASS_3_SGIS = &h80A7
const GL_SAMPLE_BUFFERS_SGIS = &h80A8
const GL_SAMPLES_SGIS = &h80A9
const GL_SAMPLE_MASK_VALUE_SGIS = &h80AA
const GL_SAMPLE_MASK_INVERT_SGIS = &h80AB
const GL_SAMPLE_PATTERN_SGIS = &h80AC
type PFNGLSAMPLEMASKSGISPROC as sub(byval value as GLclampf, byval invert as GLboolean)
type PFNGLSAMPLEPATTERNSGISPROC as sub(byval pattern as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glSampleMaskSGIS(byval value as GLclampf, byval invert as GLboolean)
	declare sub glSamplePatternSGIS(byval pattern as GLenum)
#endif

const GL_SGIS_pixel_texture = 1
const GL_PIXEL_TEXTURE_SGIS = &h8353
const GL_PIXEL_FRAGMENT_RGB_SOURCE_SGIS = &h8354
const GL_PIXEL_FRAGMENT_ALPHA_SOURCE_SGIS = &h8355
const GL_PIXEL_GROUP_COLOR_SGIS = &h8356

type PFNGLPIXELTEXGENPARAMETERISGISPROC as sub(byval pname as GLenum, byval param as GLint)
type PFNGLPIXELTEXGENPARAMETERIVSGISPROC as sub(byval pname as GLenum, byval params as const GLint ptr)
type PFNGLPIXELTEXGENPARAMETERFSGISPROC as sub(byval pname as GLenum, byval param as GLfloat)
type PFNGLPIXELTEXGENPARAMETERFVSGISPROC as sub(byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLGETPIXELTEXGENPARAMETERIVSGISPROC as sub(byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETPIXELTEXGENPARAMETERFVSGISPROC as sub(byval pname as GLenum, byval params as GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPixelTexGenParameteriSGIS(byval pname as GLenum, byval param as GLint)
	declare sub glPixelTexGenParameterivSGIS(byval pname as GLenum, byval params as const GLint ptr)
	declare sub glPixelTexGenParameterfSGIS(byval pname as GLenum, byval param as GLfloat)
	declare sub glPixelTexGenParameterfvSGIS(byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glGetPixelTexGenParameterivSGIS(byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetPixelTexGenParameterfvSGIS(byval pname as GLenum, byval params as GLfloat ptr)
#endif

const GL_SGIS_point_line_texgen = 1
const GL_EYE_DISTANCE_TO_POINT_SGIS = &h81F0
const GL_OBJECT_DISTANCE_TO_POINT_SGIS = &h81F1
const GL_EYE_DISTANCE_TO_LINE_SGIS = &h81F2
const GL_OBJECT_DISTANCE_TO_LINE_SGIS = &h81F3
const GL_EYE_POINT_SGIS = &h81F4
const GL_OBJECT_POINT_SGIS = &h81F5
const GL_EYE_LINE_SGIS = &h81F6
const GL_OBJECT_LINE_SGIS = &h81F7
const GL_SGIS_point_parameters = 1
const GL_POINT_SIZE_MIN_SGIS = &h8126
const GL_POINT_SIZE_MAX_SGIS = &h8127
const GL_POINT_FADE_THRESHOLD_SIZE_SGIS = &h8128
const GL_DISTANCE_ATTENUATION_SGIS = &h8129
type PFNGLPOINTPARAMETERFSGISPROC as sub(byval pname as GLenum, byval param as GLfloat)
type PFNGLPOINTPARAMETERFVSGISPROC as sub(byval pname as GLenum, byval params as const GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPointParameterfSGIS(byval pname as GLenum, byval param as GLfloat)
	declare sub glPointParameterfvSGIS(byval pname as GLenum, byval params as const GLfloat ptr)
#endif

const GL_SGIS_sharpen_texture = 1
const GL_LINEAR_SHARPEN_SGIS = &h80AD
const GL_LINEAR_SHARPEN_ALPHA_SGIS = &h80AE
const GL_LINEAR_SHARPEN_COLOR_SGIS = &h80AF
const GL_SHARPEN_TEXTURE_FUNC_POINTS_SGIS = &h80B0
type PFNGLSHARPENTEXFUNCSGISPROC as sub(byval target as GLenum, byval n as GLsizei, byval points as const GLfloat ptr)
type PFNGLGETSHARPENTEXFUNCSGISPROC as sub(byval target as GLenum, byval points as GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glSharpenTexFuncSGIS(byval target as GLenum, byval n as GLsizei, byval points as const GLfloat ptr)
	declare sub glGetSharpenTexFuncSGIS(byval target as GLenum, byval points as GLfloat ptr)
#endif

const GL_SGIS_texture4D = 1
const GL_PACK_SKIP_VOLUMES_SGIS = &h8130
const GL_PACK_IMAGE_DEPTH_SGIS = &h8131
const GL_UNPACK_SKIP_VOLUMES_SGIS = &h8132
const GL_UNPACK_IMAGE_DEPTH_SGIS = &h8133
const GL_TEXTURE_4D_SGIS = &h8134
const GL_PROXY_TEXTURE_4D_SGIS = &h8135
const GL_TEXTURE_4DSIZE_SGIS = &h8136
const GL_TEXTURE_WRAP_Q_SGIS = &h8137
const GL_MAX_4D_TEXTURE_SIZE_SGIS = &h8138
const GL_TEXTURE_4D_BINDING_SGIS = &h814F
type PFNGLTEXIMAGE4DSGISPROC as sub(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval size4d as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
type PFNGLTEXSUBIMAGE4DSGISPROC as sub(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval woffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval size4d as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTexImage4DSGIS(byval target as GLenum, byval level as GLint, byval internalformat as GLenum, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval size4d as GLsizei, byval border as GLint, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
	declare sub glTexSubImage4DSGIS(byval target as GLenum, byval level as GLint, byval xoffset as GLint, byval yoffset as GLint, byval zoffset as GLint, byval woffset as GLint, byval width as GLsizei, byval height as GLsizei, byval depth as GLsizei, byval size4d as GLsizei, byval format as GLenum, byval type as GLenum, byval pixels as const any ptr)
#endif

const GL_SGIS_texture_border_clamp = 1
const GL_CLAMP_TO_BORDER_SGIS = &h812D
const GL_SGIS_texture_color_mask = 1
const GL_TEXTURE_COLOR_WRITEMASK_SGIS = &h81EF
type PFNGLTEXTURECOLORMASKSGISPROC as sub(byval red as GLboolean, byval green as GLboolean, byval blue as GLboolean, byval alpha as GLboolean)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTextureColorMaskSGIS(byval red as GLboolean, byval green as GLboolean, byval blue as GLboolean, byval alpha as GLboolean)
#endif

const GL_SGIS_texture_edge_clamp = 1
const GL_CLAMP_TO_EDGE_SGIS = &h812F
const GL_SGIS_texture_filter4 = 1
const GL_FILTER4_SGIS = &h8146
const GL_TEXTURE_FILTER4_SIZE_SGIS = &h8147
type PFNGLGETTEXFILTERFUNCSGISPROC as sub(byval target as GLenum, byval filter as GLenum, byval weights as GLfloat ptr)
type PFNGLTEXFILTERFUNCSGISPROC as sub(byval target as GLenum, byval filter as GLenum, byval n as GLsizei, byval weights as const GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGetTexFilterFuncSGIS(byval target as GLenum, byval filter as GLenum, byval weights as GLfloat ptr)
	declare sub glTexFilterFuncSGIS(byval target as GLenum, byval filter as GLenum, byval n as GLsizei, byval weights as const GLfloat ptr)
#endif

const GL_SGIS_texture_lod = 1
const GL_TEXTURE_MIN_LOD_SGIS = &h813A
const GL_TEXTURE_MAX_LOD_SGIS = &h813B
const GL_TEXTURE_BASE_LEVEL_SGIS = &h813C
const GL_TEXTURE_MAX_LEVEL_SGIS = &h813D
const GL_SGIS_texture_select = 1
const GL_DUAL_ALPHA4_SGIS = &h8110
const GL_DUAL_ALPHA8_SGIS = &h8111
const GL_DUAL_ALPHA12_SGIS = &h8112
const GL_DUAL_ALPHA16_SGIS = &h8113
const GL_DUAL_LUMINANCE4_SGIS = &h8114
const GL_DUAL_LUMINANCE8_SGIS = &h8115
const GL_DUAL_LUMINANCE12_SGIS = &h8116
const GL_DUAL_LUMINANCE16_SGIS = &h8117
const GL_DUAL_INTENSITY4_SGIS = &h8118
const GL_DUAL_INTENSITY8_SGIS = &h8119
const GL_DUAL_INTENSITY12_SGIS = &h811A
const GL_DUAL_INTENSITY16_SGIS = &h811B
const GL_DUAL_LUMINANCE_ALPHA4_SGIS = &h811C
const GL_DUAL_LUMINANCE_ALPHA8_SGIS = &h811D
const GL_QUAD_ALPHA4_SGIS = &h811E
const GL_QUAD_ALPHA8_SGIS = &h811F
const GL_QUAD_LUMINANCE4_SGIS = &h8120
const GL_QUAD_LUMINANCE8_SGIS = &h8121
const GL_QUAD_INTENSITY4_SGIS = &h8122
const GL_QUAD_INTENSITY8_SGIS = &h8123
const GL_DUAL_TEXTURE_SELECT_SGIS = &h8124
const GL_QUAD_TEXTURE_SELECT_SGIS = &h8125
const GL_SGIX_async = 1
const GL_ASYNC_MARKER_SGIX = &h8329

type PFNGLASYNCMARKERSGIXPROC as sub(byval marker as GLuint)
type PFNGLFINISHASYNCSGIXPROC as function(byval markerp as GLuint ptr) as GLint
type PFNGLPOLLASYNCSGIXPROC as function(byval markerp as GLuint ptr) as GLint
type PFNGLGENASYNCMARKERSSGIXPROC as function(byval range as GLsizei) as GLuint
type PFNGLDELETEASYNCMARKERSSGIXPROC as sub(byval marker as GLuint, byval range as GLsizei)
type PFNGLISASYNCMARKERSGIXPROC as function(byval marker as GLuint) as GLboolean

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glAsyncMarkerSGIX(byval marker as GLuint)
	declare function glFinishAsyncSGIX(byval markerp as GLuint ptr) as GLint
	declare function glPollAsyncSGIX(byval markerp as GLuint ptr) as GLint
	declare function glGenAsyncMarkersSGIX(byval range as GLsizei) as GLuint
	declare sub glDeleteAsyncMarkersSGIX(byval marker as GLuint, byval range as GLsizei)
	declare function glIsAsyncMarkerSGIX(byval marker as GLuint) as GLboolean
#endif

const GL_SGIX_async_histogram = 1
const GL_ASYNC_HISTOGRAM_SGIX = &h832C
const GL_MAX_ASYNC_HISTOGRAM_SGIX = &h832D
const GL_SGIX_async_pixel = 1
const GL_ASYNC_TEX_IMAGE_SGIX = &h835C
const GL_ASYNC_DRAW_PIXELS_SGIX = &h835D
const GL_ASYNC_READ_PIXELS_SGIX = &h835E
const GL_MAX_ASYNC_TEX_IMAGE_SGIX = &h835F
const GL_MAX_ASYNC_DRAW_PIXELS_SGIX = &h8360
const GL_MAX_ASYNC_READ_PIXELS_SGIX = &h8361
const GL_SGIX_blend_alpha_minmax = 1
const GL_ALPHA_MIN_SGIX = &h8320
const GL_ALPHA_MAX_SGIX = &h8321
const GL_SGIX_calligraphic_fragment = 1
const GL_CALLIGRAPHIC_FRAGMENT_SGIX = &h8183
const GL_SGIX_clipmap = 1
const GL_LINEAR_CLIPMAP_LINEAR_SGIX = &h8170
const GL_TEXTURE_CLIPMAP_CENTER_SGIX = &h8171
const GL_TEXTURE_CLIPMAP_FRAME_SGIX = &h8172
const GL_TEXTURE_CLIPMAP_OFFSET_SGIX = &h8173
const GL_TEXTURE_CLIPMAP_VIRTUAL_DEPTH_SGIX = &h8174
const GL_TEXTURE_CLIPMAP_LOD_OFFSET_SGIX = &h8175
const GL_TEXTURE_CLIPMAP_DEPTH_SGIX = &h8176
const GL_MAX_CLIPMAP_DEPTH_SGIX = &h8177
const GL_MAX_CLIPMAP_VIRTUAL_DEPTH_SGIX = &h8178
const GL_NEAREST_CLIPMAP_NEAREST_SGIX = &h844D
const GL_NEAREST_CLIPMAP_LINEAR_SGIX = &h844E
const GL_LINEAR_CLIPMAP_NEAREST_SGIX = &h844F
const GL_SGIX_convolution_accuracy = 1
const GL_CONVOLUTION_HINT_SGIX = &h8316
const GL_SGIX_depth_pass_instrument = 1
const GL_SGIX_depth_texture = 1
const GL_DEPTH_COMPONENT16_SGIX = &h81A5
const GL_DEPTH_COMPONENT24_SGIX = &h81A6
const GL_DEPTH_COMPONENT32_SGIX = &h81A7
const GL_SGIX_flush_raster = 1
type PFNGLFLUSHRASTERSGIXPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glFlushRasterSGIX()
#endif

const GL_SGIX_fog_offset = 1
const GL_FOG_OFFSET_SGIX = &h8198
const GL_FOG_OFFSET_VALUE_SGIX = &h8199
const GL_SGIX_fragment_lighting = 1
const GL_FRAGMENT_LIGHTING_SGIX = &h8400
const GL_FRAGMENT_COLOR_MATERIAL_SGIX = &h8401
const GL_FRAGMENT_COLOR_MATERIAL_FACE_SGIX = &h8402
const GL_FRAGMENT_COLOR_MATERIAL_PARAMETER_SGIX = &h8403
const GL_MAX_FRAGMENT_LIGHTS_SGIX = &h8404
const GL_MAX_ACTIVE_LIGHTS_SGIX = &h8405
const GL_CURRENT_RASTER_NORMAL_SGIX = &h8406
const GL_LIGHT_ENV_MODE_SGIX = &h8407
const GL_FRAGMENT_LIGHT_MODEL_LOCAL_VIEWER_SGIX = &h8408
const GL_FRAGMENT_LIGHT_MODEL_TWO_SIDE_SGIX = &h8409
const GL_FRAGMENT_LIGHT_MODEL_AMBIENT_SGIX = &h840A
const GL_FRAGMENT_LIGHT_MODEL_NORMAL_INTERPOLATION_SGIX = &h840B
const GL_FRAGMENT_LIGHT0_SGIX = &h840C
const GL_FRAGMENT_LIGHT1_SGIX = &h840D
const GL_FRAGMENT_LIGHT2_SGIX = &h840E
const GL_FRAGMENT_LIGHT3_SGIX = &h840F
const GL_FRAGMENT_LIGHT4_SGIX = &h8410
const GL_FRAGMENT_LIGHT5_SGIX = &h8411
const GL_FRAGMENT_LIGHT6_SGIX = &h8412
const GL_FRAGMENT_LIGHT7_SGIX = &h8413

type PFNGLFRAGMENTCOLORMATERIALSGIXPROC as sub(byval face as GLenum, byval mode as GLenum)
type PFNGLFRAGMENTLIGHTFSGIXPROC as sub(byval light as GLenum, byval pname as GLenum, byval param as GLfloat)
type PFNGLFRAGMENTLIGHTFVSGIXPROC as sub(byval light as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLFRAGMENTLIGHTISGIXPROC as sub(byval light as GLenum, byval pname as GLenum, byval param as GLint)
type PFNGLFRAGMENTLIGHTIVSGIXPROC as sub(byval light as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLFRAGMENTLIGHTMODELFSGIXPROC as sub(byval pname as GLenum, byval param as GLfloat)
type PFNGLFRAGMENTLIGHTMODELFVSGIXPROC as sub(byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLFRAGMENTLIGHTMODELISGIXPROC as sub(byval pname as GLenum, byval param as GLint)
type PFNGLFRAGMENTLIGHTMODELIVSGIXPROC as sub(byval pname as GLenum, byval params as const GLint ptr)
type PFNGLFRAGMENTMATERIALFSGIXPROC as sub(byval face as GLenum, byval pname as GLenum, byval param as GLfloat)
type PFNGLFRAGMENTMATERIALFVSGIXPROC as sub(byval face as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLFRAGMENTMATERIALISGIXPROC as sub(byval face as GLenum, byval pname as GLenum, byval param as GLint)
type PFNGLFRAGMENTMATERIALIVSGIXPROC as sub(byval face as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLGETFRAGMENTLIGHTFVSGIXPROC as sub(byval light as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETFRAGMENTLIGHTIVSGIXPROC as sub(byval light as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLGETFRAGMENTMATERIALFVSGIXPROC as sub(byval face as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETFRAGMENTMATERIALIVSGIXPROC as sub(byval face as GLenum, byval pname as GLenum, byval params as GLint ptr)
type PFNGLLIGHTENVISGIXPROC as sub(byval pname as GLenum, byval param as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glFragmentColorMaterialSGIX(byval face as GLenum, byval mode as GLenum)
	declare sub glFragmentLightfSGIX(byval light as GLenum, byval pname as GLenum, byval param as GLfloat)
	declare sub glFragmentLightfvSGIX(byval light as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glFragmentLightiSGIX(byval light as GLenum, byval pname as GLenum, byval param as GLint)
	declare sub glFragmentLightivSGIX(byval light as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glFragmentLightModelfSGIX(byval pname as GLenum, byval param as GLfloat)
	declare sub glFragmentLightModelfvSGIX(byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glFragmentLightModeliSGIX(byval pname as GLenum, byval param as GLint)
	declare sub glFragmentLightModelivSGIX(byval pname as GLenum, byval params as const GLint ptr)
	declare sub glFragmentMaterialfSGIX(byval face as GLenum, byval pname as GLenum, byval param as GLfloat)
	declare sub glFragmentMaterialfvSGIX(byval face as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glFragmentMaterialiSGIX(byval face as GLenum, byval pname as GLenum, byval param as GLint)
	declare sub glFragmentMaterialivSGIX(byval face as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glGetFragmentLightfvSGIX(byval light as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetFragmentLightivSGIX(byval light as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glGetFragmentMaterialfvSGIX(byval face as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetFragmentMaterialivSGIX(byval face as GLenum, byval pname as GLenum, byval params as GLint ptr)
	declare sub glLightEnviSGIX(byval pname as GLenum, byval param as GLint)
#endif

const GL_SGIX_framezoom = 1
const GL_FRAMEZOOM_SGIX = &h818B
const GL_FRAMEZOOM_FACTOR_SGIX = &h818C
const GL_MAX_FRAMEZOOM_FACTOR_SGIX = &h818D
type PFNGLFRAMEZOOMSGIXPROC as sub(byval factor as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glFrameZoomSGIX(byval factor as GLint)
#endif

const GL_SGIX_igloo_interface = 1
type PFNGLIGLOOINTERFACESGIXPROC as sub(byval pname as GLenum, byval params as const any ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glIglooInterfaceSGIX(byval pname as GLenum, byval params as const any ptr)
#endif

const GL_SGIX_instruments = 1
const GL_INSTRUMENT_BUFFER_POINTER_SGIX = &h8180
const GL_INSTRUMENT_MEASUREMENTS_SGIX = &h8181

type PFNGLGETINSTRUMENTSSGIXPROC as function() as GLint
type PFNGLINSTRUMENTSBUFFERSGIXPROC as sub(byval size as GLsizei, byval buffer as GLint ptr)
type PFNGLPOLLINSTRUMENTSSGIXPROC as function(byval marker_p as GLint ptr) as GLint
type PFNGLREADINSTRUMENTSSGIXPROC as sub(byval marker as GLint)
type PFNGLSTARTINSTRUMENTSSGIXPROC as sub()
type PFNGLSTOPINSTRUMENTSSGIXPROC as sub(byval marker as GLint)

#ifdef GL_GLEXT_PROTOTYPES
	declare function glGetInstrumentsSGIX() as GLint
	declare sub glInstrumentsBufferSGIX(byval size as GLsizei, byval buffer as GLint ptr)
	declare function glPollInstrumentsSGIX(byval marker_p as GLint ptr) as GLint
	declare sub glReadInstrumentsSGIX(byval marker as GLint)
	declare sub glStartInstrumentsSGIX()
	declare sub glStopInstrumentsSGIX(byval marker as GLint)
#endif

const GL_SGIX_interlace = 1
const GL_INTERLACE_SGIX = &h8094
const GL_SGIX_ir_instrument1 = 1
const GL_IR_INSTRUMENT1_SGIX = &h817F
const GL_SGIX_list_priority = 1
const GL_LIST_PRIORITY_SGIX = &h8182

type PFNGLGETLISTPARAMETERFVSGIXPROC as sub(byval list as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETLISTPARAMETERIVSGIXPROC as sub(byval list as GLuint, byval pname as GLenum, byval params as GLint ptr)
type PFNGLLISTPARAMETERFSGIXPROC as sub(byval list as GLuint, byval pname as GLenum, byval param as GLfloat)
type PFNGLLISTPARAMETERFVSGIXPROC as sub(byval list as GLuint, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLLISTPARAMETERISGIXPROC as sub(byval list as GLuint, byval pname as GLenum, byval param as GLint)
type PFNGLLISTPARAMETERIVSGIXPROC as sub(byval list as GLuint, byval pname as GLenum, byval params as const GLint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGetListParameterfvSGIX(byval list as GLuint, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetListParameterivSGIX(byval list as GLuint, byval pname as GLenum, byval params as GLint ptr)
	declare sub glListParameterfSGIX(byval list as GLuint, byval pname as GLenum, byval param as GLfloat)
	declare sub glListParameterfvSGIX(byval list as GLuint, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glListParameteriSGIX(byval list as GLuint, byval pname as GLenum, byval param as GLint)
	declare sub glListParameterivSGIX(byval list as GLuint, byval pname as GLenum, byval params as const GLint ptr)
#endif

const GL_SGIX_pixel_texture = 1
const GL_PIXEL_TEX_GEN_SGIX = &h8139
const GL_PIXEL_TEX_GEN_MODE_SGIX = &h832B
type PFNGLPIXELTEXGENSGIXPROC as sub(byval mode as GLenum)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glPixelTexGenSGIX(byval mode as GLenum)
#endif

const GL_SGIX_pixel_tiles = 1
const GL_PIXEL_TILE_BEST_ALIGNMENT_SGIX = &h813E
const GL_PIXEL_TILE_CACHE_INCREMENT_SGIX = &h813F
const GL_PIXEL_TILE_WIDTH_SGIX = &h8140
const GL_PIXEL_TILE_HEIGHT_SGIX = &h8141
const GL_PIXEL_TILE_GRID_WIDTH_SGIX = &h8142
const GL_PIXEL_TILE_GRID_HEIGHT_SGIX = &h8143
const GL_PIXEL_TILE_GRID_DEPTH_SGIX = &h8144
const GL_PIXEL_TILE_CACHE_SIZE_SGIX = &h8145
const GL_SGIX_polynomial_ffd = 1
const GL_TEXTURE_DEFORMATION_BIT_SGIX = &h00000001
const GL_GEOMETRY_DEFORMATION_BIT_SGIX = &h00000002
const GL_GEOMETRY_DEFORMATION_SGIX = &h8194
const GL_TEXTURE_DEFORMATION_SGIX = &h8195
const GL_DEFORMATIONS_MASK_SGIX = &h8196
const GL_MAX_DEFORMATION_ORDER_SGIX = &h8197

type PFNGLDEFORMATIONMAP3DSGIXPROC as sub(byval target as GLenum, byval u1 as GLdouble, byval u2 as GLdouble, byval ustride as GLint, byval uorder as GLint, byval v1 as GLdouble, byval v2 as GLdouble, byval vstride as GLint, byval vorder as GLint, byval w1 as GLdouble, byval w2 as GLdouble, byval wstride as GLint, byval worder as GLint, byval points as const GLdouble ptr)
type PFNGLDEFORMATIONMAP3FSGIXPROC as sub(byval target as GLenum, byval u1 as GLfloat, byval u2 as GLfloat, byval ustride as GLint, byval uorder as GLint, byval v1 as GLfloat, byval v2 as GLfloat, byval vstride as GLint, byval vorder as GLint, byval w1 as GLfloat, byval w2 as GLfloat, byval wstride as GLint, byval worder as GLint, byval points as const GLfloat ptr)
type PFNGLDEFORMSGIXPROC as sub(byval mask as GLbitfield)
type PFNGLLOADIDENTITYDEFORMATIONMAPSGIXPROC as sub(byval mask as GLbitfield)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDeformationMap3dSGIX(byval target as GLenum, byval u1 as GLdouble, byval u2 as GLdouble, byval ustride as GLint, byval uorder as GLint, byval v1 as GLdouble, byval v2 as GLdouble, byval vstride as GLint, byval vorder as GLint, byval w1 as GLdouble, byval w2 as GLdouble, byval wstride as GLint, byval worder as GLint, byval points as const GLdouble ptr)
	declare sub glDeformationMap3fSGIX(byval target as GLenum, byval u1 as GLfloat, byval u2 as GLfloat, byval ustride as GLint, byval uorder as GLint, byval v1 as GLfloat, byval v2 as GLfloat, byval vstride as GLint, byval vorder as GLint, byval w1 as GLfloat, byval w2 as GLfloat, byval wstride as GLint, byval worder as GLint, byval points as const GLfloat ptr)
	declare sub glDeformSGIX(byval mask as GLbitfield)
	declare sub glLoadIdentityDeformationMapSGIX(byval mask as GLbitfield)
#endif

const GL_SGIX_reference_plane = 1
const GL_REFERENCE_PLANE_SGIX = &h817D
const GL_REFERENCE_PLANE_EQUATION_SGIX = &h817E
type PFNGLREFERENCEPLANESGIXPROC as sub(byval equation as const GLdouble ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glReferencePlaneSGIX(byval equation as const GLdouble ptr)
#endif

const GL_SGIX_resample = 1
const GL_PACK_RESAMPLE_SGIX = &h842C
const GL_UNPACK_RESAMPLE_SGIX = &h842D
const GL_RESAMPLE_REPLICATE_SGIX = &h842E
const GL_RESAMPLE_ZERO_FILL_SGIX = &h842F
const GL_RESAMPLE_DECIMATE_SGIX = &h8430
const GL_SGIX_scalebias_hint = 1
const GL_SCALEBIAS_HINT_SGIX = &h8322
const GL_SGIX_shadow = 1
const GL_TEXTURE_COMPARE_SGIX = &h819A
const GL_TEXTURE_COMPARE_OPERATOR_SGIX = &h819B
const GL_TEXTURE_LEQUAL_R_SGIX = &h819C
const GL_TEXTURE_GEQUAL_R_SGIX = &h819D
const GL_SGIX_shadow_ambient = 1
const GL_SHADOW_AMBIENT_SGIX = &h80BF
const GL_SGIX_sprite = 1
const GL_SPRITE_SGIX = &h8148
const GL_SPRITE_MODE_SGIX = &h8149
const GL_SPRITE_AXIS_SGIX = &h814A
const GL_SPRITE_TRANSLATION_SGIX = &h814B
const GL_SPRITE_AXIAL_SGIX = &h814C
const GL_SPRITE_OBJECT_ALIGNED_SGIX = &h814D
const GL_SPRITE_EYE_ALIGNED_SGIX = &h814E

type PFNGLSPRITEPARAMETERFSGIXPROC as sub(byval pname as GLenum, byval param as GLfloat)
type PFNGLSPRITEPARAMETERFVSGIXPROC as sub(byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLSPRITEPARAMETERISGIXPROC as sub(byval pname as GLenum, byval param as GLint)
type PFNGLSPRITEPARAMETERIVSGIXPROC as sub(byval pname as GLenum, byval params as const GLint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glSpriteParameterfSGIX(byval pname as GLenum, byval param as GLfloat)
	declare sub glSpriteParameterfvSGIX(byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glSpriteParameteriSGIX(byval pname as GLenum, byval param as GLint)
	declare sub glSpriteParameterivSGIX(byval pname as GLenum, byval params as const GLint ptr)
#endif

const GL_SGIX_subsample = 1
const GL_PACK_SUBSAMPLE_RATE_SGIX = &h85A0
const GL_UNPACK_SUBSAMPLE_RATE_SGIX = &h85A1
const GL_PIXEL_SUBSAMPLE_4444_SGIX = &h85A2
const GL_PIXEL_SUBSAMPLE_2424_SGIX = &h85A3
const GL_PIXEL_SUBSAMPLE_4242_SGIX = &h85A4
const GL_SGIX_tag_sample_buffer = 1
type PFNGLTAGSAMPLEBUFFERSGIXPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glTagSampleBufferSGIX()
#endif

const GL_SGIX_texture_add_env = 1
const GL_TEXTURE_ENV_BIAS_SGIX = &h80BE
const GL_SGIX_texture_coordinate_clamp = 1
const GL_TEXTURE_MAX_CLAMP_S_SGIX = &h8369
const GL_TEXTURE_MAX_CLAMP_T_SGIX = &h836A
const GL_TEXTURE_MAX_CLAMP_R_SGIX = &h836B
const GL_SGIX_texture_lod_bias = 1
const GL_TEXTURE_LOD_BIAS_S_SGIX = &h818E
const GL_TEXTURE_LOD_BIAS_T_SGIX = &h818F
const GL_TEXTURE_LOD_BIAS_R_SGIX = &h8190
const GL_SGIX_texture_multi_buffer = 1
const GL_TEXTURE_MULTI_BUFFER_HINT_SGIX = &h812E
const GL_SGIX_texture_scale_bias = 1
const GL_POST_TEXTURE_FILTER_BIAS_SGIX = &h8179
const GL_POST_TEXTURE_FILTER_SCALE_SGIX = &h817A
const GL_POST_TEXTURE_FILTER_BIAS_RANGE_SGIX = &h817B
const GL_POST_TEXTURE_FILTER_SCALE_RANGE_SGIX = &h817C
const GL_SGIX_vertex_preclip = 1
const GL_VERTEX_PRECLIP_SGIX = &h83EE
const GL_VERTEX_PRECLIP_HINT_SGIX = &h83EF
const GL_SGIX_ycrcb = 1
const GL_YCRCB_422_SGIX = &h81BB
const GL_YCRCB_444_SGIX = &h81BC
const GL_SGIX_ycrcb_subsample = 1
const GL_SGIX_ycrcba = 1
const GL_YCRCB_SGIX = &h8318
const GL_YCRCBA_SGIX = &h8319
const GL_SGI_color_matrix = 1
const GL_COLOR_MATRIX_SGI = &h80B1
const GL_COLOR_MATRIX_STACK_DEPTH_SGI = &h80B2
const GL_MAX_COLOR_MATRIX_STACK_DEPTH_SGI = &h80B3
const GL_POST_COLOR_MATRIX_RED_SCALE_SGI = &h80B4
const GL_POST_COLOR_MATRIX_GREEN_SCALE_SGI = &h80B5
const GL_POST_COLOR_MATRIX_BLUE_SCALE_SGI = &h80B6
const GL_POST_COLOR_MATRIX_ALPHA_SCALE_SGI = &h80B7
const GL_POST_COLOR_MATRIX_RED_BIAS_SGI = &h80B8
const GL_POST_COLOR_MATRIX_GREEN_BIAS_SGI = &h80B9
const GL_POST_COLOR_MATRIX_BLUE_BIAS_SGI = &h80BA
const GL_POST_COLOR_MATRIX_ALPHA_BIAS_SGI = &h80BB
const GL_SGI_color_table = 1
const GL_COLOR_TABLE_SGI = &h80D0
const GL_POST_CONVOLUTION_COLOR_TABLE_SGI = &h80D1
const GL_POST_COLOR_MATRIX_COLOR_TABLE_SGI = &h80D2
const GL_PROXY_COLOR_TABLE_SGI = &h80D3
const GL_PROXY_POST_CONVOLUTION_COLOR_TABLE_SGI = &h80D4
const GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE_SGI = &h80D5
const GL_COLOR_TABLE_SCALE_SGI = &h80D6
const GL_COLOR_TABLE_BIAS_SGI = &h80D7
const GL_COLOR_TABLE_FORMAT_SGI = &h80D8
const GL_COLOR_TABLE_WIDTH_SGI = &h80D9
const GL_COLOR_TABLE_RED_SIZE_SGI = &h80DA
const GL_COLOR_TABLE_GREEN_SIZE_SGI = &h80DB
const GL_COLOR_TABLE_BLUE_SIZE_SGI = &h80DC
const GL_COLOR_TABLE_ALPHA_SIZE_SGI = &h80DD
const GL_COLOR_TABLE_LUMINANCE_SIZE_SGI = &h80DE
const GL_COLOR_TABLE_INTENSITY_SIZE_SGI = &h80DF

type PFNGLCOLORTABLESGIPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval table as const any ptr)
type PFNGLCOLORTABLEPARAMETERFVSGIPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
type PFNGLCOLORTABLEPARAMETERIVSGIPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
type PFNGLCOPYCOLORTABLESGIPROC as sub(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei)
type PFNGLGETCOLORTABLESGIPROC as sub(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval table as any ptr)
type PFNGLGETCOLORTABLEPARAMETERFVSGIPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
type PFNGLGETCOLORTABLEPARAMETERIVSGIPROC as sub(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glColorTableSGI(byval target as GLenum, byval internalformat as GLenum, byval width as GLsizei, byval format as GLenum, byval type as GLenum, byval table as const any ptr)
	declare sub glColorTableParameterfvSGI(byval target as GLenum, byval pname as GLenum, byval params as const GLfloat ptr)
	declare sub glColorTableParameterivSGI(byval target as GLenum, byval pname as GLenum, byval params as const GLint ptr)
	declare sub glCopyColorTableSGI(byval target as GLenum, byval internalformat as GLenum, byval x as GLint, byval y as GLint, byval width as GLsizei)
	declare sub glGetColorTableSGI(byval target as GLenum, byval format as GLenum, byval type as GLenum, byval table as any ptr)
	declare sub glGetColorTableParameterfvSGI(byval target as GLenum, byval pname as GLenum, byval params as GLfloat ptr)
	declare sub glGetColorTableParameterivSGI(byval target as GLenum, byval pname as GLenum, byval params as GLint ptr)
#endif

const GL_SGI_texture_color_table = 1
const GL_TEXTURE_COLOR_TABLE_SGI = &h80BC
const GL_PROXY_TEXTURE_COLOR_TABLE_SGI = &h80BD
const GL_SUNX_constant_data = 1
const GL_UNPACK_CONSTANT_DATA_SUNX = &h81D5
const GL_TEXTURE_CONSTANT_DATA_SUNX = &h81D6
type PFNGLFINISHTEXTURESUNXPROC as sub()

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glFinishTextureSUNX()
#endif

const GL_SUN_convolution_border_modes = 1
const GL_WRAP_BORDER_SUN = &h81D4
const GL_SUN_global_alpha = 1
const GL_GLOBAL_ALPHA_SUN = &h81D9
const GL_GLOBAL_ALPHA_FACTOR_SUN = &h81DA

type PFNGLGLOBALALPHAFACTORBSUNPROC as sub(byval factor as GLbyte)
type PFNGLGLOBALALPHAFACTORSSUNPROC as sub(byval factor as GLshort)
type PFNGLGLOBALALPHAFACTORISUNPROC as sub(byval factor as GLint)
type PFNGLGLOBALALPHAFACTORFSUNPROC as sub(byval factor as GLfloat)
type PFNGLGLOBALALPHAFACTORDSUNPROC as sub(byval factor as GLdouble)
type PFNGLGLOBALALPHAFACTORUBSUNPROC as sub(byval factor as GLubyte)
type PFNGLGLOBALALPHAFACTORUSSUNPROC as sub(byval factor as GLushort)
type PFNGLGLOBALALPHAFACTORUISUNPROC as sub(byval factor as GLuint)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glGlobalAlphaFactorbSUN(byval factor as GLbyte)
	declare sub glGlobalAlphaFactorsSUN(byval factor as GLshort)
	declare sub glGlobalAlphaFactoriSUN(byval factor as GLint)
	declare sub glGlobalAlphaFactorfSUN(byval factor as GLfloat)
	declare sub glGlobalAlphaFactordSUN(byval factor as GLdouble)
	declare sub glGlobalAlphaFactorubSUN(byval factor as GLubyte)
	declare sub glGlobalAlphaFactorusSUN(byval factor as GLushort)
	declare sub glGlobalAlphaFactoruiSUN(byval factor as GLuint)
#endif

const GL_SUN_mesh_array = 1
const GL_QUAD_MESH_SUN = &h8614
const GL_TRIANGLE_MESH_SUN = &h8615
type PFNGLDRAWMESHARRAYSSUNPROC as sub(byval mode as GLenum, byval first as GLint, byval count as GLsizei, byval width as GLsizei)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glDrawMeshArraysSUN(byval mode as GLenum, byval first as GLint, byval count as GLsizei, byval width as GLsizei)
#endif

const GL_SUN_slice_accum = 1
const GL_SLICE_ACCUM_SUN = &h85CC
const GL_SUN_triangle_list = 1
const GL_RESTART_SUN = &h0001
const GL_REPLACE_MIDDLE_SUN = &h0002
const GL_REPLACE_OLDEST_SUN = &h0003
const GL_TRIANGLE_LIST_SUN = &h81D7
const GL_REPLACEMENT_CODE_SUN = &h81D8
const GL_REPLACEMENT_CODE_ARRAY_SUN = &h85C0
const GL_REPLACEMENT_CODE_ARRAY_TYPE_SUN = &h85C1
const GL_REPLACEMENT_CODE_ARRAY_STRIDE_SUN = &h85C2
const GL_REPLACEMENT_CODE_ARRAY_POINTER_SUN = &h85C3
const GL_R1UI_V3F_SUN = &h85C4
const GL_R1UI_C4UB_V3F_SUN = &h85C5
const GL_R1UI_C3F_V3F_SUN = &h85C6
const GL_R1UI_N3F_V3F_SUN = &h85C7
const GL_R1UI_C4F_N3F_V3F_SUN = &h85C8
const GL_R1UI_T2F_V3F_SUN = &h85C9
const GL_R1UI_T2F_N3F_V3F_SUN = &h85CA
const GL_R1UI_T2F_C4F_N3F_V3F_SUN = &h85CB

type PFNGLREPLACEMENTCODEUISUNPROC as sub(byval code as GLuint)
type PFNGLREPLACEMENTCODEUSSUNPROC as sub(byval code as GLushort)
type PFNGLREPLACEMENTCODEUBSUNPROC as sub(byval code as GLubyte)
type PFNGLREPLACEMENTCODEUIVSUNPROC as sub(byval code as const GLuint ptr)
type PFNGLREPLACEMENTCODEUSVSUNPROC as sub(byval code as const GLushort ptr)
type PFNGLREPLACEMENTCODEUBVSUNPROC as sub(byval code as const GLubyte ptr)
type PFNGLREPLACEMENTCODEPOINTERSUNPROC as sub(byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glReplacementCodeuiSUN(byval code as GLuint)
	declare sub glReplacementCodeusSUN(byval code as GLushort)
	declare sub glReplacementCodeubSUN(byval code as GLubyte)
	declare sub glReplacementCodeuivSUN(byval code as const GLuint ptr)
	declare sub glReplacementCodeusvSUN(byval code as const GLushort ptr)
	declare sub glReplacementCodeubvSUN(byval code as const GLubyte ptr)
	declare sub glReplacementCodePointerSUN(byval type as GLenum, byval stride as GLsizei, byval pointer as const any ptr ptr)
#endif

const GL_SUN_vertex = 1
type PFNGLCOLOR4UBVERTEX2FSUNPROC as sub(byval r as GLubyte, byval g as GLubyte, byval b as GLubyte, byval a as GLubyte, byval x as GLfloat, byval y as GLfloat)
type PFNGLCOLOR4UBVERTEX2FVSUNPROC as sub(byval c as const GLubyte ptr, byval v as const GLfloat ptr)
type PFNGLCOLOR4UBVERTEX3FSUNPROC as sub(byval r as GLubyte, byval g as GLubyte, byval b as GLubyte, byval a as GLubyte, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLCOLOR4UBVERTEX3FVSUNPROC as sub(byval c as const GLubyte ptr, byval v as const GLfloat ptr)
type PFNGLCOLOR3FVERTEX3FSUNPROC as sub(byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLCOLOR3FVERTEX3FVSUNPROC as sub(byval c as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLNORMAL3FVERTEX3FSUNPROC as sub(byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLNORMAL3FVERTEX3FVSUNPROC as sub(byval n as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLCOLOR4FNORMAL3FVERTEX3FSUNPROC as sub(byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval a as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLCOLOR4FNORMAL3FVERTEX3FVSUNPROC as sub(byval c as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLTEXCOORD2FVERTEX3FSUNPROC as sub(byval s as GLfloat, byval t as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLTEXCOORD2FVERTEX3FVSUNPROC as sub(byval tc as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLTEXCOORD4FVERTEX4FSUNPROC as sub(byval s as GLfloat, byval t as GLfloat, byval p as GLfloat, byval q as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
type PFNGLTEXCOORD4FVERTEX4FVSUNPROC as sub(byval tc as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLTEXCOORD2FCOLOR4UBVERTEX3FSUNPROC as sub(byval s as GLfloat, byval t as GLfloat, byval r as GLubyte, byval g as GLubyte, byval b as GLubyte, byval a as GLubyte, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLTEXCOORD2FCOLOR4UBVERTEX3FVSUNPROC as sub(byval tc as const GLfloat ptr, byval c as const GLubyte ptr, byval v as const GLfloat ptr)
type PFNGLTEXCOORD2FCOLOR3FVERTEX3FSUNPROC as sub(byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLTEXCOORD2FCOLOR3FVERTEX3FVSUNPROC as sub(byval tc as const GLfloat ptr, byval c as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLTEXCOORD2FNORMAL3FVERTEX3FSUNPROC as sub(byval s as GLfloat, byval t as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLTEXCOORD2FNORMAL3FVERTEX3FVSUNPROC as sub(byval tc as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLTEXCOORD2FCOLOR4FNORMAL3FVERTEX3FSUNPROC as sub(byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval a as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLTEXCOORD2FCOLOR4FNORMAL3FVERTEX3FVSUNPROC as sub(byval tc as const GLfloat ptr, byval c as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLTEXCOORD4FCOLOR4FNORMAL3FVERTEX4FSUNPROC as sub(byval s as GLfloat, byval t as GLfloat, byval p as GLfloat, byval q as GLfloat, byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval a as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
type PFNGLTEXCOORD4FCOLOR4FNORMAL3FVERTEX4FVSUNPROC as sub(byval tc as const GLfloat ptr, byval c as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLREPLACEMENTCODEUIVERTEX3FSUNPROC as sub(byval rc as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLREPLACEMENTCODEUIVERTEX3FVSUNPROC as sub(byval rc as const GLuint ptr, byval v as const GLfloat ptr)
type PFNGLREPLACEMENTCODEUICOLOR4UBVERTEX3FSUNPROC as sub(byval rc as GLuint, byval r as GLubyte, byval g as GLubyte, byval b as GLubyte, byval a as GLubyte, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLREPLACEMENTCODEUICOLOR4UBVERTEX3FVSUNPROC as sub(byval rc as const GLuint ptr, byval c as const GLubyte ptr, byval v as const GLfloat ptr)
type PFNGLREPLACEMENTCODEUICOLOR3FVERTEX3FSUNPROC as sub(byval rc as GLuint, byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLREPLACEMENTCODEUICOLOR3FVERTEX3FVSUNPROC as sub(byval rc as const GLuint ptr, byval c as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLREPLACEMENTCODEUINORMAL3FVERTEX3FSUNPROC as sub(byval rc as GLuint, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLREPLACEMENTCODEUINORMAL3FVERTEX3FVSUNPROC as sub(byval rc as const GLuint ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLREPLACEMENTCODEUICOLOR4FNORMAL3FVERTEX3FSUNPROC as sub(byval rc as GLuint, byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval a as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLREPLACEMENTCODEUICOLOR4FNORMAL3FVERTEX3FVSUNPROC as sub(byval rc as const GLuint ptr, byval c as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLREPLACEMENTCODEUITEXCOORD2FVERTEX3FSUNPROC as sub(byval rc as GLuint, byval s as GLfloat, byval t as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLREPLACEMENTCODEUITEXCOORD2FVERTEX3FVSUNPROC as sub(byval rc as const GLuint ptr, byval tc as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLREPLACEMENTCODEUITEXCOORD2FNORMAL3FVERTEX3FSUNPROC as sub(byval rc as GLuint, byval s as GLfloat, byval t as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLREPLACEMENTCODEUITEXCOORD2FNORMAL3FVERTEX3FVSUNPROC as sub(byval rc as const GLuint ptr, byval tc as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
type PFNGLREPLACEMENTCODEUITEXCOORD2FCOLOR4FNORMAL3FVERTEX3FSUNPROC as sub(byval rc as GLuint, byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval a as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
type PFNGLREPLACEMENTCODEUITEXCOORD2FCOLOR4FNORMAL3FVERTEX3FVSUNPROC as sub(byval rc as const GLuint ptr, byval tc as const GLfloat ptr, byval c as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)

#ifdef GL_GLEXT_PROTOTYPES
	declare sub glColor4ubVertex2fSUN(byval r as GLubyte, byval g as GLubyte, byval b as GLubyte, byval a as GLubyte, byval x as GLfloat, byval y as GLfloat)
	declare sub glColor4ubVertex2fvSUN(byval c as const GLubyte ptr, byval v as const GLfloat ptr)
	declare sub glColor4ubVertex3fSUN(byval r as GLubyte, byval g as GLubyte, byval b as GLubyte, byval a as GLubyte, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glColor4ubVertex3fvSUN(byval c as const GLubyte ptr, byval v as const GLfloat ptr)
	declare sub glColor3fVertex3fSUN(byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glColor3fVertex3fvSUN(byval c as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glNormal3fVertex3fSUN(byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glNormal3fVertex3fvSUN(byval n as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glColor4fNormal3fVertex3fSUN(byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval a as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glColor4fNormal3fVertex3fvSUN(byval c as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glTexCoord2fVertex3fSUN(byval s as GLfloat, byval t as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glTexCoord2fVertex3fvSUN(byval tc as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glTexCoord4fVertex4fSUN(byval s as GLfloat, byval t as GLfloat, byval p as GLfloat, byval q as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
	declare sub glTexCoord4fVertex4fvSUN(byval tc as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glTexCoord2fColor4ubVertex3fSUN(byval s as GLfloat, byval t as GLfloat, byval r as GLubyte, byval g as GLubyte, byval b as GLubyte, byval a as GLubyte, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glTexCoord2fColor4ubVertex3fvSUN(byval tc as const GLfloat ptr, byval c as const GLubyte ptr, byval v as const GLfloat ptr)
	declare sub glTexCoord2fColor3fVertex3fSUN(byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glTexCoord2fColor3fVertex3fvSUN(byval tc as const GLfloat ptr, byval c as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glTexCoord2fNormal3fVertex3fSUN(byval s as GLfloat, byval t as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glTexCoord2fNormal3fVertex3fvSUN(byval tc as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glTexCoord2fColor4fNormal3fVertex3fSUN(byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval a as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glTexCoord2fColor4fNormal3fVertex3fvSUN(byval tc as const GLfloat ptr, byval c as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glTexCoord4fColor4fNormal3fVertex4fSUN(byval s as GLfloat, byval t as GLfloat, byval p as GLfloat, byval q as GLfloat, byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval a as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat, byval w as GLfloat)
	declare sub glTexCoord4fColor4fNormal3fVertex4fvSUN(byval tc as const GLfloat ptr, byval c as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glReplacementCodeuiVertex3fSUN(byval rc as GLuint, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glReplacementCodeuiVertex3fvSUN(byval rc as const GLuint ptr, byval v as const GLfloat ptr)
	declare sub glReplacementCodeuiColor4ubVertex3fSUN(byval rc as GLuint, byval r as GLubyte, byval g as GLubyte, byval b as GLubyte, byval a as GLubyte, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glReplacementCodeuiColor4ubVertex3fvSUN(byval rc as const GLuint ptr, byval c as const GLubyte ptr, byval v as const GLfloat ptr)
	declare sub glReplacementCodeuiColor3fVertex3fSUN(byval rc as GLuint, byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glReplacementCodeuiColor3fVertex3fvSUN(byval rc as const GLuint ptr, byval c as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glReplacementCodeuiNormal3fVertex3fSUN(byval rc as GLuint, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glReplacementCodeuiNormal3fVertex3fvSUN(byval rc as const GLuint ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glReplacementCodeuiColor4fNormal3fVertex3fSUN(byval rc as GLuint, byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval a as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glReplacementCodeuiColor4fNormal3fVertex3fvSUN(byval rc as const GLuint ptr, byval c as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glReplacementCodeuiTexCoord2fVertex3fSUN(byval rc as GLuint, byval s as GLfloat, byval t as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glReplacementCodeuiTexCoord2fVertex3fvSUN(byval rc as const GLuint ptr, byval tc as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN(byval rc as GLuint, byval s as GLfloat, byval t as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN(byval rc as const GLuint ptr, byval tc as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
	declare sub glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN(byval rc as GLuint, byval s as GLfloat, byval t as GLfloat, byval r as GLfloat, byval g as GLfloat, byval b as GLfloat, byval a as GLfloat, byval nx as GLfloat, byval ny as GLfloat, byval nz as GLfloat, byval x as GLfloat, byval y as GLfloat, byval z as GLfloat)
	declare sub glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN(byval rc as const GLuint ptr, byval tc as const GLfloat ptr, byval c as const GLfloat ptr, byval n as const GLfloat ptr, byval v as const GLfloat ptr)
#endif

const GL_WIN_phong_shading = 1
const GL_PHONG_WIN = &h80EA
const GL_PHONG_HINT_WIN = &h80EB
const GL_WIN_specular_fog = 1
const GL_FOG_SPECULAR_TEXTURE_WIN = &h80EC

end extern
