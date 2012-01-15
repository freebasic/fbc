#Ifndef __glext_bi__
#define __glext_bi__


/'
** Copyright (c) 2007-2011 The Khronos Group Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and/or associated documentation files (the
** "Materials"), to deal in the Materials without restriction, including
** without limitation the rights to use, copy, modify, merge, publish,
** distribute, sublicense, and/or sell copies of the Materials, and to
** permit persons to whom the Materials are furnished to do so, subject to
** the following conditions:
**
** The above copyright notice and this permission notice shall be included
** in all copies or substantial portions of the Materials.
**
** THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
** MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
** IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
** CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
** TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
** MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.
'/

/' Header file version number, required by OpenGL ABI for Linux '/
/' glext.h last updated $Date: 2011-10-02 22:22:16 -0700 (Sun, 02 Oct 2011) $ '/
/' Current version at http://www.opengl.org/registry/ '/
#define GL_GLEXT_VERSION 73
/' Function declaration macros - to move into glplatform.h '/

#include "GL/gl.bi"

#Ifndef ptrdiff_t
#Include Once "crt/stddef.bi"
#EndIf

#If Defined(__FB_WIN32__) Or Defined(__FB_CYGWIN__)
Extern "Windows"
#ElseIf Defined(__FB_UNIX__)
Extern "C"
#Else
Extern "C"
#EndIf


/'***********************************************************'/

#Ifndef GL_VERSION_1_2
#define GL_UNSIGNED_BYTE_3_3_2            &h8032
#define GL_UNSIGNED_SHORT_4_4_4_4         &h8033
#define GL_UNSIGNED_SHORT_5_5_5_1         &h8034
#define GL_UNSIGNED_INT_8_8_8_8           &h8035
#define GL_UNSIGNED_INT_10_10_10_2        &h8036
#define GL_TEXTURE_BINDING_3D             &h806A
#define GL_PACK_SKIP_IMAGES               &h806B
#define GL_PACK_IMAGE_HEIGHT              &h806C
#define GL_UNPACK_SKIP_IMAGES             &h806D
#define GL_UNPACK_IMAGE_HEIGHT            &h806E
#define GL_TEXTURE_3D                     &h806F
#define GL_PROXY_TEXTURE_3D               &h8070
#define GL_TEXTURE_DEPTH                  &h8071
#define GL_TEXTURE_WRAP_R                 &h8072
#define GL_MAX_3D_TEXTURE_SIZE            &h8073
#define GL_UNSIGNED_BYTE_2_3_3_REV        &h8362
#define GL_UNSIGNED_SHORT_5_6_5           &h8363
#define GL_UNSIGNED_SHORT_5_6_5_REV       &h8364
#define GL_UNSIGNED_SHORT_4_4_4_4_REV     &h8365
#define GL_UNSIGNED_SHORT_1_5_5_5_REV     &h8366
#define GL_UNSIGNED_INT_8_8_8_8_REV       &h8367
#define GL_UNSIGNED_INT_2_10_10_10_REV    &h8368
#define GL_BGR                            &h80E0
#define GL_BGRA                           &h80E1
#define GL_MAX_ELEMENTS_VERTICES          &h80E8
#define GL_MAX_ELEMENTS_INDICES           &h80E9
#define GL_CLAMP_TO_EDGE                  &h812F
#define GL_TEXTURE_MIN_LOD                &h813A
#define GL_TEXTURE_MAX_LOD                &h813B
#define GL_TEXTURE_BASE_LEVEL             &h813C
#define GL_TEXTURE_MAX_LEVEL              &h813D
#define GL_SMOOTH_POINT_SIZE_RANGE        &h0B12
#define GL_SMOOTH_POINT_SIZE_GRANULARITY  &h0B13
#define GL_SMOOTH_LINE_WIDTH_RANGE        &h0B22
#define GL_SMOOTH_LINE_WIDTH_GRANULARITY  &h0B23
#define GL_ALIASED_LINE_WIDTH_RANGE       &h846E
#EndIf

#Ifndef GL_VERSION_1_2_DEPRECATED
#define GL_RESCALE_NORMAL                 &h803A
#define GL_LIGHT_MODEL_COLOR_CONTROL      &h81F8
#define GL_SINGLE_COLOR                   &h81F9
#define GL_SEPARATE_SPECULAR_COLOR        &h81FA
#define GL_ALIASED_POINT_SIZE_RANGE       &h846D
#EndIf

#Ifndef GL_ARB_imaging
#define GL_CONSTANT_COLOR                 &h8001
#define GL_ONE_MINUS_CONSTANT_COLOR       &h8002
#define GL_CONSTANT_ALPHA                 &h8003
#define GL_ONE_MINUS_CONSTANT_ALPHA       &h8004
#define GL_BLEND_COLOR                    &h8005
#define GL_FUNC_ADD                       &h8006
#define GL_MIN                            &h8007
#define GL_MAX                            &h8008
#define GL_BLEND_EQUATION                 &h8009
#define GL_FUNC_SUBTRACT                  &h800A
#define GL_FUNC_REVERSE_SUBTRACT          &h800B
#EndIf

#Ifndef GL_ARB_imaging_DEPRECATED
#define GL_CONVOLUTION_1D                 &h8010
#define GL_CONVOLUTION_2D                 &h8011
#define GL_SEPARABLE_2D                   &h8012
#define GL_CONVOLUTION_BORDER_MODE        &h8013
#define GL_CONVOLUTION_FILTER_SCALE       &h8014
#define GL_CONVOLUTION_FILTER_BIAS        &h8015
#define GL_REDUCE                         &h8016
#define GL_CONVOLUTION_FORMAT             &h8017
#define GL_CONVOLUTION_WIDTH              &h8018
#define GL_CONVOLUTION_HEIGHT             &h8019
#define GL_MAX_CONVOLUTION_WIDTH          &h801A
#define GL_MAX_CONVOLUTION_HEIGHT         &h801B
#define GL_POST_CONVOLUTION_RED_SCALE     &h801C
#define GL_POST_CONVOLUTION_GREEN_SCALE   &h801D
#define GL_POST_CONVOLUTION_BLUE_SCALE    &h801E
#define GL_POST_CONVOLUTION_ALPHA_SCALE   &h801F
#define GL_POST_CONVOLUTION_RED_BIAS      &h8020
#define GL_POST_CONVOLUTION_GREEN_BIAS    &h8021
#define GL_POST_CONVOLUTION_BLUE_BIAS     &h8022
#define GL_POST_CONVOLUTION_ALPHA_BIAS    &h8023
#define GL_HISTOGRAM                      &h8024
#define GL_PROXY_HISTOGRAM                &h8025
#define GL_HISTOGRAM_WIDTH                &h8026
#define GL_HISTOGRAM_FORMAT               &h8027
#define GL_HISTOGRAM_RED_SIZE             &h8028
#define GL_HISTOGRAM_GREEN_SIZE           &h8029
#define GL_HISTOGRAM_BLUE_SIZE            &h802A
#define GL_HISTOGRAM_ALPHA_SIZE           &h802B
#define GL_HISTOGRAM_LUMINANCE_SIZE       &h802C
#define GL_HISTOGRAM_SINK                 &h802D
#define GL_MINMAX                         &h802E
#define GL_MINMAX_FORMAT                  &h802F
#define GL_MINMAX_SINK                    &h8030
#define GL_TABLE_TOO_LARGE                &h8031
#define GL_COLOR_MATRIX                   &h80B1
#define GL_COLOR_MATRIX_STACK_DEPTH       &h80B2
#define GL_MAX_COLOR_MATRIX_STACK_DEPTH   &h80B3
#define GL_POST_COLOR_MATRIX_RED_SCALE    &h80B4
#define GL_POST_COLOR_MATRIX_GREEN_SCALE  &h80B5
#define GL_POST_COLOR_MATRIX_BLUE_SCALE   &h80B6
#define GL_POST_COLOR_MATRIX_ALPHA_SCALE  &h80B7
#define GL_POST_COLOR_MATRIX_RED_BIAS     &h80B8
#define GL_POST_COLOR_MATRIX_GREEN_BIAS   &h80B9
#define GL_POST_COLOR_MATRIX_BLUE_BIAS    &h80BA
#define GL_POST_COLOR_MATRIX_ALPHA_BIAS   &h80BB
#define GL_COLOR_TABLE                    &h80D0
#define GL_POST_CONVOLUTION_COLOR_TABLE   &h80D1
#define GL_POST_COLOR_MATRIX_COLOR_TABLE  &h80D2
#define GL_PROXY_COLOR_TABLE              &h80D3
#define GL_PROXY_POST_CONVOLUTION_COLOR_TABLE &h80D4
#define GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE &h80D5
#define GL_COLOR_TABLE_SCALE              &h80D6
#define GL_COLOR_TABLE_BIAS               &h80D7
#define GL_COLOR_TABLE_FORMAT             &h80D8
#define GL_COLOR_TABLE_WIDTH              &h80D9
#define GL_COLOR_TABLE_RED_SIZE           &h80DA
#define GL_COLOR_TABLE_GREEN_SIZE         &h80DB
#define GL_COLOR_TABLE_BLUE_SIZE          &h80DC
#define GL_COLOR_TABLE_ALPHA_SIZE         &h80DD
#define GL_COLOR_TABLE_LUMINANCE_SIZE     &h80DE
#define GL_COLOR_TABLE_INTENSITY_SIZE     &h80DF
#define GL_CONSTANT_BORDER                &h8151
#define GL_REPLICATE_BORDER               &h8153
#define GL_CONVOLUTION_BORDER_COLOR       &h8154
#EndIf

#Ifndef GL_VERSION_1_3
#define GL_TEXTURE0                       &h84C0
#define GL_TEXTURE1                       &h84C1
#define GL_TEXTURE2                       &h84C2
#define GL_TEXTURE3                       &h84C3
#define GL_TEXTURE4                       &h84C4
#define GL_TEXTURE5                       &h84C5
#define GL_TEXTURE6                       &h84C6
#define GL_TEXTURE7                       &h84C7
#define GL_TEXTURE8                       &h84C8
#define GL_TEXTURE9                       &h84C9
#define GL_TEXTURE10                      &h84CA
#define GL_TEXTURE11                      &h84CB
#define GL_TEXTURE12                      &h84CC
#define GL_TEXTURE13                      &h84CD
#define GL_TEXTURE14                      &h84CE
#define GL_TEXTURE15                      &h84CF
#define GL_TEXTURE16                      &h84D0
#define GL_TEXTURE17                      &h84D1
#define GL_TEXTURE18                      &h84D2
#define GL_TEXTURE19                      &h84D3
#define GL_TEXTURE20                      &h84D4
#define GL_TEXTURE21                      &h84D5
#define GL_TEXTURE22                      &h84D6
#define GL_TEXTURE23                      &h84D7
#define GL_TEXTURE24                      &h84D8
#define GL_TEXTURE25                      &h84D9
#define GL_TEXTURE26                      &h84DA
#define GL_TEXTURE27                      &h84DB
#define GL_TEXTURE28                      &h84DC
#define GL_TEXTURE29                      &h84DD
#define GL_TEXTURE30                      &h84DE
#define GL_TEXTURE31                      &h84DF
#define GL_ACTIVE_TEXTURE                 &h84E0
#define GL_MULTISAMPLE                    &h809D
#define GL_SAMPLE_ALPHA_TO_COVERAGE       &h809E
#define GL_SAMPLE_ALPHA_TO_ONE            &h809F
#define GL_SAMPLE_COVERAGE                &h80A0
#define GL_SAMPLE_BUFFERS                 &h80A8
#define GL_SAMPLES                        &h80A9
#define GL_SAMPLE_COVERAGE_VALUE          &h80AA
#define GL_SAMPLE_COVERAGE_INVERT         &h80AB
#define GL_TEXTURE_CUBE_MAP               &h8513
#define GL_TEXTURE_BINDING_CUBE_MAP       &h8514
#define GL_TEXTURE_CUBE_MAP_POSITIVE_X    &h8515
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_X    &h8516
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Y    &h8517
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Y    &h8518
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Z    &h8519
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Z    &h851A
#define GL_PROXY_TEXTURE_CUBE_MAP         &h851B
#define GL_MAX_CUBE_MAP_TEXTURE_SIZE      &h851C
#define GL_COMPRESSED_RGB                 &h84ED
#define GL_COMPRESSED_RGBA                &h84EE
#define GL_TEXTURE_COMPRESSION_HINT       &h84EF
#define GL_TEXTURE_COMPRESSED_IMAGE_SIZE  &h86A0
#define GL_TEXTURE_COMPRESSED             &h86A1
#define GL_NUM_COMPRESSED_TEXTURE_FORMATS &h86A2
#define GL_COMPRESSED_TEXTURE_FORMATS     &h86A3
#define GL_CLAMP_TO_BORDER                &h812D
#EndIf

#Ifndef GL_VERSION_1_3_DEPRECATED
#define GL_CLIENT_ACTIVE_TEXTURE          &h84E1
#define GL_MAX_TEXTURE_UNITS              &h84E2
#define GL_TRANSPOSE_MODELVIEW_MATRIX     &h84E3
#define GL_TRANSPOSE_PROJECTION_MATRIX    &h84E4
#define GL_TRANSPOSE_TEXTURE_MATRIX       &h84E5
#define GL_TRANSPOSE_COLOR_MATRIX         &h84E6
#define GL_MULTISAMPLE_BIT                &h20000000
#define GL_NORMAL_MAP                     &h8511
#define GL_REFLECTION_MAP                 &h8512
#define GL_COMPRESSED_ALPHA               &h84E9
#define GL_COMPRESSED_LUMINANCE           &h84EA
#define GL_COMPRESSED_LUMINANCE_ALPHA     &h84EB
#define GL_COMPRESSED_INTENSITY           &h84EC
#define GL_COMBINE                        &h8570
#define GL_COMBINE_RGB                    &h8571
#define GL_COMBINE_ALPHA                  &h8572
#define GL_SOURCE0_RGB                    &h8580
#define GL_SOURCE1_RGB                    &h8581
#define GL_SOURCE2_RGB                    &h8582
#define GL_SOURCE0_ALPHA                  &h8588
#define GL_SOURCE1_ALPHA                  &h8589
#define GL_SOURCE2_ALPHA                  &h858A
#define GL_OPERAND0_RGB                   &h8590
#define GL_OPERAND1_RGB                   &h8591
#define GL_OPERAND2_RGB                   &h8592
#define GL_OPERAND0_ALPHA                 &h8598
#define GL_OPERAND1_ALPHA                 &h8599
#define GL_OPERAND2_ALPHA                 &h859A
#define GL_RGB_SCALE                      &h8573
#define GL_ADD_SIGNED                     &h8574
#define GL_INTERPOLATE                    &h8575
#define GL_SUBTRACT                       &h84E7
#define GL_CONSTANT                       &h8576
#define GL_PRIMARY_COLOR                  &h8577
#define GL_PREVIOUS                       &h8578
#define GL_DOT3_RGB                       &h86AE
#define GL_DOT3_RGBA                      &h86AF
#EndIf

#Ifndef GL_VERSION_1_4
#define GL_BLEND_DST_RGB                  &h80C8
#define GL_BLEND_SRC_RGB                  &h80C9
#define GL_BLEND_DST_ALPHA                &h80CA
#define GL_BLEND_SRC_ALPHA                &h80CB
#define GL_POINT_FADE_THRESHOLD_SIZE      &h8128
#define GL_DEPTH_COMPONENT16              &h81A5
#define GL_DEPTH_COMPONENT24              &h81A6
#define GL_DEPTH_COMPONENT32              &h81A7
#define GL_MIRRORED_REPEAT                &h8370
#define GL_MAX_TEXTURE_LOD_BIAS           &h84FD
#define GL_TEXTURE_LOD_BIAS               &h8501
#define GL_INCR_WRAP                      &h8507
#define GL_DECR_WRAP                      &h8508
#define GL_TEXTURE_DEPTH_SIZE             &h884A
#define GL_TEXTURE_COMPARE_MODE           &h884C
#define GL_TEXTURE_COMPARE_FUNC           &h884D
#EndIf

#Ifndef GL_VERSION_1_4_DEPRECATED
#define GL_POINT_SIZE_MIN                 &h8126
#define GL_POINT_SIZE_MAX                 &h8127
#define GL_POINT_DISTANCE_ATTENUATION     &h8129
#define GL_GENERATE_MIPMAP                &h8191
#define GL_GENERATE_MIPMAP_HINT           &h8192
#define GL_FOG_COORDINATE_SOURCE          &h8450
#define GL_FOG_COORDINATE                 &h8451
#define GL_FRAGMENT_DEPTH                 &h8452
#define GL_CURRENT_FOG_COORDINATE         &h8453
#define GL_FOG_COORDINATE_ARRAY_TYPE      &h8454
#define GL_FOG_COORDINATE_ARRAY_STRIDE    &h8455
#define GL_FOG_COORDINATE_ARRAY_POINTER   &h8456
#define GL_FOG_COORDINATE_ARRAY           &h8457
#define GL_COLOR_SUM                      &h8458
#define GL_CURRENT_SECONDARY_COLOR        &h8459
#define GL_SECONDARY_COLOR_ARRAY_SIZE     &h845A
#define GL_SECONDARY_COLOR_ARRAY_TYPE     &h845B
#define GL_SECONDARY_COLOR_ARRAY_STRIDE   &h845C
#define GL_SECONDARY_COLOR_ARRAY_POINTER  &h845D
#define GL_SECONDARY_COLOR_ARRAY          &h845E
#define GL_TEXTURE_FILTER_CONTROL         &h8500
#define GL_DEPTH_TEXTURE_MODE             &h884B
#define GL_COMPARE_R_TO_TEXTURE           &h884E
#EndIf

#Ifndef GL_VERSION_1_5
#define GL_BUFFER_SIZE                    &h8764
#define GL_BUFFER_USAGE                   &h8765
#define GL_QUERY_COUNTER_BITS             &h8864
#define GL_CURRENT_QUERY                  &h8865
#define GL_QUERY_RESULT                   &h8866
#define GL_QUERY_RESULT_AVAILABLE         &h8867
#define GL_ARRAY_BUFFER                   &h8892
#define GL_ELEMENT_ARRAY_BUFFER           &h8893
#define GL_ARRAY_BUFFER_BINDING           &h8894
#define GL_ELEMENT_ARRAY_BUFFER_BINDING   &h8895
#define GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING &h889F
#define GL_READ_ONLY                      &h88B8
#define GL_WRITE_ONLY                     &h88B9
#define GL_READ_WRITE                     &h88BA
#define GL_BUFFER_ACCESS                  &h88BB
#define GL_BUFFER_MAPPED                  &h88BC
#define GL_BUFFER_MAP_POINTER             &h88BD
#define GL_STREAM_DRAW                    &h88E0
#define GL_STREAM_READ                    &h88E1
#define GL_STREAM_COPY                    &h88E2
#define GL_STATIC_DRAW                    &h88E4
#define GL_STATIC_READ                    &h88E5
#define GL_STATIC_COPY                    &h88E6
#define GL_DYNAMIC_DRAW                   &h88E8
#define GL_DYNAMIC_READ                   &h88E9
#define GL_DYNAMIC_COPY                   &h88EA
#define GL_SAMPLES_PASSED                 &h8914
#EndIf

#Ifndef GL_VERSION_1_5_DEPRECATED
#define GL_VERTEX_ARRAY_BUFFER_BINDING    &h8896
#define GL_NORMAL_ARRAY_BUFFER_BINDING    &h8897
#define GL_COLOR_ARRAY_BUFFER_BINDING     &h8898
#define GL_INDEX_ARRAY_BUFFER_BINDING     &h8899
#define GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING &h889A
#define GL_EDGE_FLAG_ARRAY_BUFFER_BINDING &h889B
#define GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING &h889C
#define GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING &h889D
#define GL_WEIGHT_ARRAY_BUFFER_BINDING    &h889E
#define GL_FOG_COORD_SRC                  &h8450
#define GL_FOG_COORD                      &h8451
#define GL_CURRENT_FOG_COORD              &h8453
#define GL_FOG_COORD_ARRAY_TYPE           &h8454
#define GL_FOG_COORD_ARRAY_STRIDE         &h8455
#define GL_FOG_COORD_ARRAY_POINTER        &h8456
#define GL_FOG_COORD_ARRAY                &h8457
#define GL_FOG_COORD_ARRAY_BUFFER_BINDING &h889D
#define GL_SRC0_RGB                       &h8580
#define GL_SRC1_RGB                       &h8581
#define GL_SRC2_RGB                       &h8582
#define GL_SRC0_ALPHA                     &h8588
#define GL_SRC1_ALPHA                     &h8589
#define GL_SRC2_ALPHA                     &h858A
#EndIf

#Ifndef GL_VERSION_2_0
#define GL_BLEND_EQUATION_RGB             &h8009
#define GL_VERTEX_ATTRIB_ARRAY_ENABLED    &h8622
#define GL_VERTEX_ATTRIB_ARRAY_SIZE       &h8623
#define GL_VERTEX_ATTRIB_ARRAY_STRIDE     &h8624
#define GL_VERTEX_ATTRIB_ARRAY_TYPE       &h8625
#define GL_CURRENT_VERTEX_ATTRIB          &h8626
#define GL_VERTEX_PROGRAM_POINT_SIZE      &h8642
#define GL_VERTEX_ATTRIB_ARRAY_POINTER    &h8645
#define GL_STENCIL_BACK_FUNC              &h8800
#define GL_STENCIL_BACK_FAIL              &h8801
#define GL_STENCIL_BACK_PASS_DEPTH_FAIL   &h8802
#define GL_STENCIL_BACK_PASS_DEPTH_PASS   &h8803
#define GL_MAX_DRAW_BUFFERS               &h8824
#define GL_DRAW_BUFFER0                   &h8825
#define GL_DRAW_BUFFER1                   &h8826
#define GL_DRAW_BUFFER2                   &h8827
#define GL_DRAW_BUFFER3                   &h8828
#define GL_DRAW_BUFFER4                   &h8829
#define GL_DRAW_BUFFER5                   &h882A
#define GL_DRAW_BUFFER6                   &h882B
#define GL_DRAW_BUFFER7                   &h882C
#define GL_DRAW_BUFFER8                   &h882D
#define GL_DRAW_BUFFER9                   &h882E
#define GL_DRAW_BUFFER10                  &h882F
#define GL_DRAW_BUFFER11                  &h8830
#define GL_DRAW_BUFFER12                  &h8831
#define GL_DRAW_BUFFER13                  &h8832
#define GL_DRAW_BUFFER14                  &h8833
#define GL_DRAW_BUFFER15                  &h8834
#define GL_BLEND_EQUATION_ALPHA           &h883D
#define GL_MAX_VERTEX_ATTRIBS             &h8869
#define GL_VERTEX_ATTRIB_ARRAY_NORMALIZED &h886A
#define GL_MAX_TEXTURE_IMAGE_UNITS        &h8872
#define GL_FRAGMENT_SHADER                &h8B30
#define GL_VERTEX_SHADER                  &h8B31
#define GL_MAX_FRAGMENT_UNIFORM_COMPONENTS &h8B49
#define GL_MAX_VERTEX_UNIFORM_COMPONENTS  &h8B4A
#define GL_MAX_VARYING_FLOATS             &h8B4B
#define GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS &h8B4C
#define GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS &h8B4D
#define GL_SHADER_TYPE                    &h8B4F
#define GL_FLOAT_VEC2                     &h8B50
#define GL_FLOAT_VEC3                     &h8B51
#define GL_FLOAT_VEC4                     &h8B52
#define GL_INT_VEC2                       &h8B53
#define GL_INT_VEC3                       &h8B54
#define GL_INT_VEC4                       &h8B55
#define GL_BOOL                           &h8B56
#define GL_BOOL_VEC2                      &h8B57
#define GL_BOOL_VEC3                      &h8B58
#define GL_BOOL_VEC4                      &h8B59
#define GL_FLOAT_MAT2                     &h8B5A
#define GL_FLOAT_MAT3                     &h8B5B
#define GL_FLOAT_MAT4                     &h8B5C
#define GL_SAMPLER_1D                     &h8B5D
#define GL_SAMPLER_2D                     &h8B5E
#define GL_SAMPLER_3D                     &h8B5F
#define GL_SAMPLER_CUBE                   &h8B60
#define GL_SAMPLER_1D_SHADOW              &h8B61
#define GL_SAMPLER_2D_SHADOW              &h8B62
#define GL_DELETE_STATUS                  &h8B80
#define GL_COMPILE_STATUS                 &h8B81
#define GL_LINK_STATUS                    &h8B82
#define GL_VALIDATE_STATUS                &h8B83
#define GL_INFO_LOG_LENGTH                &h8B84
#define GL_ATTACHED_SHADERS               &h8B85
#define GL_ACTIVE_UNIFORMS                &h8B86
#define GL_ACTIVE_UNIFORM_MAX_LENGTH      &h8B87
#define GL_SHADER_SOURCE_LENGTH           &h8B88
#define GL_ACTIVE_ATTRIBUTES              &h8B89
#define GL_ACTIVE_ATTRIBUTE_MAX_LENGTH    &h8B8A
#define GL_FRAGMENT_SHADER_DERIVATIVE_HINT &h8B8B
#define GL_SHADING_LANGUAGE_VERSION       &h8B8C
#define GL_CURRENT_PROGRAM                &h8B8D
#define GL_POINT_SPRITE_COORD_ORIGIN      &h8CA0
#define GL_LOWER_LEFT                     &h8CA1
#define GL_UPPER_LEFT                     &h8CA2
#define GL_STENCIL_BACK_REF               &h8CA3
#define GL_STENCIL_BACK_VALUE_MASK        &h8CA4
#define GL_STENCIL_BACK_WRITEMASK         &h8CA5
#EndIf

#Ifndef GL_VERSION_2_0_DEPRECATED
#define GL_VERTEX_PROGRAM_TWO_SIDE        &h8643
#define GL_POINT_SPRITE                   &h8861
#define GL_COORD_REPLACE                  &h8862
#define GL_MAX_TEXTURE_COORDS             &h8871
#EndIf

#Ifndef GL_VERSION_2_1
#define GL_PIXEL_PACK_BUFFER              &h88EB
#define GL_PIXEL_UNPACK_BUFFER            &h88EC
#define GL_PIXEL_PACK_BUFFER_BINDING      &h88ED
#define GL_PIXEL_UNPACK_BUFFER_BINDING    &h88EF
#define GL_FLOAT_MAT2x3                   &h8B65
#define GL_FLOAT_MAT2x4                   &h8B66
#define GL_FLOAT_MAT3x2                   &h8B67
#define GL_FLOAT_MAT3x4                   &h8B68
#define GL_FLOAT_MAT4x2                   &h8B69
#define GL_FLOAT_MAT4x3                   &h8B6A
#define GL_SRGB                           &h8C40
#define GL_SRGB8                          &h8C41
#define GL_SRGB_ALPHA                     &h8C42
#define GL_SRGB8_ALPHA8                   &h8C43
#define GL_COMPRESSED_SRGB                &h8C48
#define GL_COMPRESSED_SRGB_ALPHA          &h8C49
#EndIf

#Ifndef GL_VERSION_2_1_DEPRECATED
#define GL_CURRENT_RASTER_SECONDARY_COLOR &h845F
#define GL_SLUMINANCE_ALPHA               &h8C44
#define GL_SLUMINANCE8_ALPHA8             &h8C45
#define GL_SLUMINANCE                     &h8C46
#define GL_SLUMINANCE8                    &h8C47
#define GL_COMPRESSED_SLUMINANCE          &h8C4A
#define GL_COMPRESSED_SLUMINANCE_ALPHA    &h8C4B
#EndIf

#Ifndef GL_VERSION_3_0
#define GL_COMPARE_REF_TO_TEXTURE         &h884E
#define GL_CLIP_DISTANCE0                 &h3000
#define GL_CLIP_DISTANCE1                 &h3001
#define GL_CLIP_DISTANCE2                 &h3002
#define GL_CLIP_DISTANCE3                 &h3003
#define GL_CLIP_DISTANCE4                 &h3004
#define GL_CLIP_DISTANCE5                 &h3005
#define GL_CLIP_DISTANCE6                 &h3006
#define GL_CLIP_DISTANCE7                 &h3007
#define GL_MAX_CLIP_DISTANCES             &h0D32
#define GL_MAJOR_VERSION                  &h821B
#define GL_MINOR_VERSION                  &h821C
#define GL_NUM_EXTENSIONS                 &h821D
#define GL_CONTEXT_FLAGS                  &h821E
#define GL_COMPRESSED_RED                 &h8225
#define GL_COMPRESSED_RG                  &h8226
#define GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT &h0001
#define GL_RGBA32F                        &h8814
#define GL_RGB32F                         &h8815
#define GL_RGBA16F                        &h881A
#define GL_RGB16F                         &h881B
#define GL_VERTEX_ATTRIB_ARRAY_INTEGER    &h88FD
#define GL_MAX_ARRAY_TEXTURE_LAYERS       &h88FF
#define GL_MIN_PROGRAM_TEXEL_OFFSET       &h8904
#define GL_MAX_PROGRAM_TEXEL_OFFSET       &h8905
#define GL_CLAMP_READ_COLOR               &h891C
#define GL_FIXED_ONLY                     &h891D
#define GL_MAX_VARYING_COMPONENTS         &h8B4B
#define GL_TEXTURE_1D_ARRAY               &h8C18
#define GL_PROXY_TEXTURE_1D_ARRAY         &h8C19
#define GL_TEXTURE_2D_ARRAY               &h8C1A
#define GL_PROXY_TEXTURE_2D_ARRAY         &h8C1B
#define GL_TEXTURE_BINDING_1D_ARRAY       &h8C1C
#define GL_TEXTURE_BINDING_2D_ARRAY       &h8C1D
#define GL_R11F_G11F_B10F                 &h8C3A
#define GL_UNSIGNED_INT_10F_11F_11F_REV   &h8C3B
#define GL_RGB9_E5                        &h8C3D
#define GL_UNSIGNED_INT_5_9_9_9_REV       &h8C3E
#define GL_TEXTURE_SHARED_SIZE            &h8C3F
#define GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH &h8C76
#define GL_TRANSFORM_FEEDBACK_BUFFER_MODE &h8C7F
#define GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS &h8C80
#define GL_TRANSFORM_FEEDBACK_VARYINGS    &h8C83
#define GL_TRANSFORM_FEEDBACK_BUFFER_START &h8C84
#define GL_TRANSFORM_FEEDBACK_BUFFER_SIZE &h8C85
#define GL_PRIMITIVES_GENERATED           &h8C87
#define GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN &h8C88
#define GL_RASTERIZER_DISCARD             &h8C89
#define GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS &h8C8A
#define GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS &h8C8B
#define GL_INTERLEAVED_ATTRIBS            &h8C8C
#define GL_SEPARATE_ATTRIBS               &h8C8D
#define GL_TRANSFORM_FEEDBACK_BUFFER      &h8C8E
#define GL_TRANSFORM_FEEDBACK_BUFFER_BINDING &h8C8F
#define GL_RGBA32UI                       &h8D70
#define GL_RGB32UI                        &h8D71
#define GL_RGBA16UI                       &h8D76
#define GL_RGB16UI                        &h8D77
#define GL_RGBA8UI                        &h8D7C
#define GL_RGB8UI                         &h8D7D
#define GL_RGBA32I                        &h8D82
#define GL_RGB32I                         &h8D83
#define GL_RGBA16I                        &h8D88
#define GL_RGB16I                         &h8D89
#define GL_RGBA8I                         &h8D8E
#define GL_RGB8I                          &h8D8F
#define GL_RED_INTEGER                    &h8D94
#define GL_GREEN_INTEGER                  &h8D95
#define GL_BLUE_INTEGER                   &h8D96
#define GL_RGB_INTEGER                    &h8D98
#define GL_RGBA_INTEGER                   &h8D99
#define GL_BGR_INTEGER                    &h8D9A
#define GL_BGRA_INTEGER                   &h8D9B
#define GL_SAMPLER_1D_ARRAY               &h8DC0
#define GL_SAMPLER_2D_ARRAY               &h8DC1
#define GL_SAMPLER_1D_ARRAY_SHADOW        &h8DC3
#define GL_SAMPLER_2D_ARRAY_SHADOW        &h8DC4
#define GL_SAMPLER_CUBE_SHADOW            &h8DC5
#define GL_UNSIGNED_INT_VEC2              &h8DC6
#define GL_UNSIGNED_INT_VEC3              &h8DC7
#define GL_UNSIGNED_INT_VEC4              &h8DC8
#define GL_INT_SAMPLER_1D                 &h8DC9
#define GL_INT_SAMPLER_2D                 &h8DCA
#define GL_INT_SAMPLER_3D                 &h8DCB
#define GL_INT_SAMPLER_CUBE               &h8DCC
#define GL_INT_SAMPLER_1D_ARRAY           &h8DCE
#define GL_INT_SAMPLER_2D_ARRAY           &h8DCF
#define GL_UNSIGNED_INT_SAMPLER_1D        &h8DD1
#define GL_UNSIGNED_INT_SAMPLER_2D        &h8DD2
#define GL_UNSIGNED_INT_SAMPLER_3D        &h8DD3
#define GL_UNSIGNED_INT_SAMPLER_CUBE      &h8DD4
#define GL_UNSIGNED_INT_SAMPLER_1D_ARRAY  &h8DD6
#define GL_UNSIGNED_INT_SAMPLER_2D_ARRAY  &h8DD7
#define GL_QUERY_WAIT                     &h8E13
#define GL_QUERY_NO_WAIT                  &h8E14
#define GL_QUERY_BY_REGION_WAIT           &h8E15
#define GL_QUERY_BY_REGION_NO_WAIT        &h8E16
#define GL_BUFFER_ACCESS_FLAGS            &h911F
#define GL_BUFFER_MAP_LENGTH              &h9120
#define GL_BUFFER_MAP_OFFSET              &h9121
/' Reuse tokens from ARB_depth_buffer_float '/
/' reuse GL_DEPTH_COMPONENT32F '/
/' reuse GL_DEPTH32F_STENCIL8 '/
/' reuse GL_FLOAT_32_UNSIGNED_INT_24_8_REV '/
/' Reuse tokens from ARB_framebuffer_object '/
/' reuse GL_INVALID_FRAMEBUFFER_OPERATION '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE '/
/' reuse GL_FRAMEBUFFER_DEFAULT '/
/' reuse GL_FRAMEBUFFER_UNDEFINED '/
/' reuse GL_DEPTH_STENCIL_ATTACHMENT '/
/' reuse GL_INDEX '/
/' reuse GL_MAX_RENDERBUFFER_SIZE '/
/' reuse GL_DEPTH_STENCIL '/
/' reuse GL_UNSIGNED_INT_24_8 '/
/' reuse GL_DEPTH24_STENCIL8 '/
/' reuse GL_TEXTURE_STENCIL_SIZE '/
/' reuse GL_TEXTURE_RED_TYPE '/
/' reuse GL_TEXTURE_GREEN_TYPE '/
/' reuse GL_TEXTURE_BLUE_TYPE '/
/' reuse GL_TEXTURE_ALPHA_TYPE '/
/' reuse GL_TEXTURE_DEPTH_TYPE '/
/' reuse GL_UNSIGNED_NORMALIZED '/
/' reuse GL_FRAMEBUFFER_BINDING '/
/' reuse GL_DRAW_FRAMEBUFFER_BINDING '/
/' reuse GL_RENDERBUFFER_BINDING '/
/' reuse GL_READ_FRAMEBUFFER '/
/' reuse GL_DRAW_FRAMEBUFFER '/
/' reuse GL_READ_FRAMEBUFFER_BINDING '/
/' reuse GL_RENDERBUFFER_SAMPLES '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER '/
/' reuse GL_FRAMEBUFFER_COMPLETE '/
/' reuse GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT '/
/' reuse GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT '/
/' reuse GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER '/
/' reuse GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER '/
/' reuse GL_FRAMEBUFFER_UNSUPPORTED '/
/' reuse GL_MAX_COLOR_ATTACHMENTS '/
/' reuse GL_COLOR_ATTACHMENT0 '/
/' reuse GL_COLOR_ATTACHMENT1 '/
/' reuse GL_COLOR_ATTACHMENT2 '/
/' reuse GL_COLOR_ATTACHMENT3 '/
/' reuse GL_COLOR_ATTACHMENT4 '/
/' reuse GL_COLOR_ATTACHMENT5 '/
/' reuse GL_COLOR_ATTACHMENT6 '/
/' reuse GL_COLOR_ATTACHMENT7 '/
/' reuse GL_COLOR_ATTACHMENT8 '/
/' reuse GL_COLOR_ATTACHMENT9 '/
/' reuse GL_COLOR_ATTACHMENT10 '/
/' reuse GL_COLOR_ATTACHMENT11 '/
/' reuse GL_COLOR_ATTACHMENT12 '/
/' reuse GL_COLOR_ATTACHMENT13 '/
/' reuse GL_COLOR_ATTACHMENT14 '/
/' reuse GL_COLOR_ATTACHMENT15 '/
/' reuse GL_DEPTH_ATTACHMENT '/
/' reuse GL_STENCIL_ATTACHMENT '/
/' reuse GL_FRAMEBUFFER '/
/' reuse GL_RENDERBUFFER '/
/' reuse GL_RENDERBUFFER_WIDTH '/
/' reuse GL_RENDERBUFFER_HEIGHT '/
/' reuse GL_RENDERBUFFER_INTERNAL_FORMAT '/
/' reuse GL_STENCIL_INDEX1 '/
/' reuse GL_STENCIL_INDEX4 '/
/' reuse GL_STENCIL_INDEX8 '/
/' reuse GL_STENCIL_INDEX16 '/
/' reuse GL_RENDERBUFFER_RED_SIZE '/
/' reuse GL_RENDERBUFFER_GREEN_SIZE '/
/' reuse GL_RENDERBUFFER_BLUE_SIZE '/
/' reuse GL_RENDERBUFFER_ALPHA_SIZE '/
/' reuse GL_RENDERBUFFER_DEPTH_SIZE '/
/' reuse GL_RENDERBUFFER_STENCIL_SIZE '/
/' reuse GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE '/
/' reuse GL_MAX_SAMPLES '/
/' Reuse tokens from ARB_framebuffer_sRGB '/
/' reuse GL_FRAMEBUFFER_SRGB '/
/' Reuse tokens from ARB_half_float_vertex '/
/' reuse GL_HALF_FLOAT '/
/' Reuse tokens from ARB_map_buffer_range '/
/' reuse GL_MAP_READ_BIT '/
/' reuse GL_MAP_WRITE_BIT '/
/' reuse GL_MAP_INVALIDATE_RANGE_BIT '/
/' reuse GL_MAP_INVALIDATE_BUFFER_BIT '/
/' reuse GL_MAP_FLUSH_EXPLICIT_BIT '/
/' reuse GL_MAP_UNSYNCHRONIZED_BIT '/
/' Reuse tokens from ARB_texture_compression_rgtc '/
/' reuse GL_COMPRESSED_RED_RGTC1 '/
/' reuse GL_COMPRESSED_SIGNED_RED_RGTC1 '/
/' reuse GL_COMPRESSED_RG_RGTC2 '/
/' reuse GL_COMPRESSED_SIGNED_RG_RGTC2 '/
/' Reuse tokens from ARB_texture_rg '/
/' reuse GL_RG '/
/' reuse GL_RG_INTEGER '/
/' reuse GL_R8 '/
/' reuse GL_R16 '/
/' reuse GL_RG8 '/
/' reuse GL_RG16 '/
/' reuse GL_R16F '/
/' reuse GL_R32F '/
/' reuse GL_RG16F '/
/' reuse GL_RG32F '/
/' reuse GL_R8I '/
/' reuse GL_R8UI '/
/' reuse GL_R16I '/
/' reuse GL_R16UI '/
/' reuse GL_R32I '/
/' reuse GL_R32UI '/
/' reuse GL_RG8I '/
/' reuse GL_RG8UI '/
/' reuse GL_RG16I '/
/' reuse GL_RG16UI '/
/' reuse GL_RG32I '/
/' reuse GL_RG32UI '/
/' Reuse tokens from ARB_vertex_array_object '/
/' reuse GL_VERTEX_ARRAY_BINDING '/
#EndIf

#Ifndef GL_VERSION_3_0_DEPRECATED
#define GL_CLAMP_VERTEX_COLOR             &h891A
#define GL_CLAMP_FRAGMENT_COLOR           &h891B
#define GL_ALPHA_INTEGER                  &h8D97
/' Reuse tokens from ARB_framebuffer_object '/
/' reuse GL_TEXTURE_LUMINANCE_TYPE '/
/' reuse GL_TEXTURE_INTENSITY_TYPE '/
#EndIf

#Ifndef GL_VERSION_3_1
#define GL_SAMPLER_2D_RECT                &h8B63
#define GL_SAMPLER_2D_RECT_SHADOW         &h8B64
#define GL_SAMPLER_BUFFER                 &h8DC2
#define GL_INT_SAMPLER_2D_RECT            &h8DCD
#define GL_INT_SAMPLER_BUFFER             &h8DD0
#define GL_UNSIGNED_INT_SAMPLER_2D_RECT   &h8DD5
#define GL_UNSIGNED_INT_SAMPLER_BUFFER    &h8DD8
#define GL_TEXTURE_BUFFER                 &h8C2A
#define GL_MAX_TEXTURE_BUFFER_SIZE        &h8C2B
#define GL_TEXTURE_BINDING_BUFFER         &h8C2C
#define GL_TEXTURE_BUFFER_DATA_STORE_BINDING &h8C2D
#define GL_TEXTURE_BUFFER_FORMAT          &h8C2E
#define GL_TEXTURE_RECTANGLE              &h84F5
#define GL_TEXTURE_BINDING_RECTANGLE      &h84F6
#define GL_PROXY_TEXTURE_RECTANGLE        &h84F7
#define GL_MAX_RECTANGLE_TEXTURE_SIZE     &h84F8
#define GL_RED_SNORM                      &h8F90
#define GL_RG_SNORM                       &h8F91
#define GL_RGB_SNORM                      &h8F92
#define GL_RGBA_SNORM                     &h8F93
#define GL_R8_SNORM                       &h8F94
#define GL_RG8_SNORM                      &h8F95
#define GL_RGB8_SNORM                     &h8F96
#define GL_RGBA8_SNORM                    &h8F97
#define GL_R16_SNORM                      &h8F98
#define GL_RG16_SNORM                     &h8F99
#define GL_RGB16_SNORM                    &h8F9A
#define GL_RGBA16_SNORM                   &h8F9B
#define GL_SIGNED_NORMALIZED              &h8F9C
#define GL_PRIMITIVE_RESTART              &h8F9D
#define GL_PRIMITIVE_RESTART_INDEX        &h8F9E
/' Reuse tokens from ARB_copy_buffer '/
/' reuse GL_COPY_READ_BUFFER '/
/' reuse GL_COPY_WRITE_BUFFER '/
/' Reuse tokens from ARB_draw_instanced (none) '/
/' Reuse tokens from ARB_uniform_buffer_object '/
/' reuse GL_UNIFORM_BUFFER '/
/' reuse GL_UNIFORM_BUFFER_BINDING '/
/' reuse GL_UNIFORM_BUFFER_START '/
/' reuse GL_UNIFORM_BUFFER_SIZE '/
/' reuse GL_MAX_VERTEX_UNIFORM_BLOCKS '/
/' reuse GL_MAX_FRAGMENT_UNIFORM_BLOCKS '/
/' reuse GL_MAX_COMBINED_UNIFORM_BLOCKS '/
/' reuse GL_MAX_UNIFORM_BUFFER_BINDINGS '/
/' reuse GL_MAX_UNIFORM_BLOCK_SIZE '/
/' reuse GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS '/
/' reuse GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS '/
/' reuse GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT '/
/' reuse GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH '/
/' reuse GL_ACTIVE_UNIFORM_BLOCKS '/
/' reuse GL_UNIFORM_TYPE '/
/' reuse GL_UNIFORM_SIZE '/
/' reuse GL_UNIFORM_NAME_LENGTH '/
/' reuse GL_UNIFORM_BLOCK_INDEX '/
/' reuse GL_UNIFORM_OFFSET '/
/' reuse GL_UNIFORM_ARRAY_STRIDE '/
/' reuse GL_UNIFORM_MATRIX_STRIDE '/
/' reuse GL_UNIFORM_IS_ROW_MAJOR '/
/' reuse GL_UNIFORM_BLOCK_BINDING '/
/' reuse GL_UNIFORM_BLOCK_DATA_SIZE '/
/' reuse GL_UNIFORM_BLOCK_NAME_LENGTH '/
/' reuse GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS '/
/' reuse GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES '/
/' reuse GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER '/
/' reuse GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER '/
/' reuse GL_INVALID_INDEX '/
#EndIf

#Ifndef GL_VERSION_3_2
#define GL_CONTEXT_CORE_PROFILE_BIT       &h00000001
#define GL_CONTEXT_COMPATIBILITY_PROFILE_BIT &h00000002
#define GL_LINES_ADJACENCY                &h000A
#define GL_LINE_STRIP_ADJACENCY           &h000B
#define GL_TRIANGLES_ADJACENCY            &h000C
#define GL_TRIANGLE_STRIP_ADJACENCY       &h000D
#define GL_PROGRAM_POINT_SIZE             &h8642
#define GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS &h8C29
#define GL_FRAMEBUFFER_ATTACHMENT_LAYERED &h8DA7
#define GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS &h8DA8
#define GL_GEOMETRY_SHADER                &h8DD9
#define GL_GEOMETRY_VERTICES_OUT          &h8916
#define GL_GEOMETRY_INPUT_TYPE            &h8917
#define GL_GEOMETRY_OUTPUT_TYPE           &h8918
#define GL_MAX_GEOMETRY_UNIFORM_COMPONENTS &h8DDF
#define GL_MAX_GEOMETRY_OUTPUT_VERTICES   &h8DE0
#define GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS &h8DE1
#define GL_MAX_VERTEX_OUTPUT_COMPONENTS   &h9122
#define GL_MAX_GEOMETRY_INPUT_COMPONENTS  &h9123
#define GL_MAX_GEOMETRY_OUTPUT_COMPONENTS &h9124
#define GL_MAX_FRAGMENT_INPUT_COMPONENTS  &h9125
#define GL_CONTEXT_PROFILE_MASK           &h9126
/' reuse GL_MAX_VARYING_COMPONENTS '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER '/
/' Reuse tokens from ARB_depth_clamp '/
/' reuse GL_DEPTH_CLAMP '/
/' Reuse tokens from ARB_draw_elements_base_vertex (none) '/
/' Reuse tokens from ARB_fragment_coord_conventions (none) '/
/' Reuse tokens from ARB_provoking_vertex '/
/' reuse GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION '/
/' reuse GL_FIRST_VERTEX_CONVENTION '/
/' reuse GL_LAST_VERTEX_CONVENTION '/
/' reuse GL_PROVOKING_VERTEX '/
/' Reuse tokens from ARB_seamless_cube_map '/
/' reuse GL_TEXTURE_CUBE_MAP_SEAMLESS '/
/' Reuse tokens from ARB_sync '/
/' reuse GL_MAX_SERVER_WAIT_TIMEOUT '/
/' reuse GL_OBJECT_TYPE '/
/' reuse GL_SYNC_CONDITION '/
/' reuse GL_SYNC_STATUS '/
/' reuse GL_SYNC_FLAGS '/
/' reuse GL_SYNC_FENCE '/
/' reuse GL_SYNC_GPU_COMMANDS_COMPLETE '/
/' reuse GL_UNSIGNALED '/
/' reuse GL_SIGNALED '/
/' reuse GL_ALREADY_SIGNALED '/
/' reuse GL_TIMEOUT_EXPIRED '/
/' reuse GL_CONDITION_SATISFIED '/
/' reuse GL_WAIT_FAILED '/
/' reuse GL_TIMEOUT_IGNORED '/
/' reuse GL_SYNC_FLUSH_COMMANDS_BIT '/
/' reuse GL_TIMEOUT_IGNORED '/
/' Reuse tokens from ARB_texture_multisample '/
/' reuse GL_SAMPLE_POSITION '/
/' reuse GL_SAMPLE_MASK '/
/' reuse GL_SAMPLE_MASK_VALUE '/
/' reuse GL_MAX_SAMPLE_MASK_WORDS '/
/' reuse GL_TEXTURE_2D_MULTISAMPLE '/
/' reuse GL_PROXY_TEXTURE_2D_MULTISAMPLE '/
/' reuse GL_TEXTURE_2D_MULTISAMPLE_ARRAY '/
/' reuse GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY '/
/' reuse GL_TEXTURE_BINDING_2D_MULTISAMPLE '/
/' reuse GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY '/
/' reuse GL_TEXTURE_SAMPLES '/
/' reuse GL_TEXTURE_FIXED_SAMPLE_LOCATIONS '/
/' reuse GL_SAMPLER_2D_MULTISAMPLE '/
/' reuse GL_INT_SAMPLER_2D_MULTISAMPLE '/
/' reuse GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE '/
/' reuse GL_SAMPLER_2D_MULTISAMPLE_ARRAY '/
/' reuse GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY '/
/' reuse GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY '/
/' reuse GL_MAX_COLOR_TEXTURE_SAMPLES '/
/' reuse GL_MAX_DEPTH_TEXTURE_SAMPLES '/
/' reuse GL_MAX_INTEGER_SAMPLES '/
'' Don't need to reuse tokens from ARB_vertex_array_bgra since they're already in 1.2 core ''
#EndIf

#Ifndef GL_VERSION_3_3
#define GL_VERTEX_ATTRIB_ARRAY_DIVISOR    &h88FE
/' Reuse tokens from ARB_blend_func_extended '/
/' reuse GL_SRC1_COLOR '/
/' reuse GL_ONE_MINUS_SRC1_COLOR '/
/' reuse GL_ONE_MINUS_SRC1_ALPHA '/
/' reuse GL_MAX_DUAL_SOURCE_DRAW_BUFFERS '/
/' Reuse tokens from ARB_explicit_attrib_location (none) '/
/' Reuse tokens from ARB_occlusion_query2 '/
/' reuse GL_ANY_SAMPLES_PASSED '/
/' Reuse tokens from ARB_sampler_objects '/
/' reuse GL_SAMPLER_BINDING '/
/' Reuse tokens from ARB_shader_bit_encoding (none) '/
/' Reuse tokens from ARB_texture_rgb10_a2ui '/
/' reuse GL_RGB10_A2UI '/
/' Reuse tokens from ARB_texture_swizzle '/
/' reuse GL_TEXTURE_SWIZZLE_R '/
/' reuse GL_TEXTURE_SWIZZLE_G '/
/' reuse GL_TEXTURE_SWIZZLE_B '/
/' reuse GL_TEXTURE_SWIZZLE_A '/
/' reuse GL_TEXTURE_SWIZZLE_RGBA '/
/' Reuse tokens from ARB_timer_query '/
/' reuse GL_TIME_ELAPSED '/
/' reuse GL_TIMESTAMP '/
/' Reuse tokens from ARB_vertex_type_2_10_10_10_rev '/
/' reuse GL_INT_2_10_10_10_REV '/
#EndIf

#Ifndef GL_VERSION_4_0
#define GL_SAMPLE_SHADING                 &h8C36
#define GL_MIN_SAMPLE_SHADING_VALUE       &h8C37
#define GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET &h8E5E
#define GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET &h8E5F
#define GL_TEXTURE_CUBE_MAP_ARRAY         &h9009
#define GL_TEXTURE_BINDING_CUBE_MAP_ARRAY &h900A
#define GL_PROXY_TEXTURE_CUBE_MAP_ARRAY   &h900B
#define GL_SAMPLER_CUBE_MAP_ARRAY         &h900C
#define GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW  &h900D
#define GL_INT_SAMPLER_CUBE_MAP_ARRAY     &h900E
#define GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY &h900F
/' Reuse tokens from ARB_texture_query_lod (none) '/
/' Reuse tokens from ARB_draw_buffers_blend (none) '/
/' Reuse tokens from ARB_draw_indirect '/
/' reuse GL_DRAW_INDIRECT_BUFFER '/
/' reuse GL_DRAW_INDIRECT_BUFFER_BINDING '/
/' Reuse tokens from ARB_gpu_shader5 '/
/' reuse GL_GEOMETRY_SHADER_INVOCATIONS '/
/' reuse GL_MAX_GEOMETRY_SHADER_INVOCATIONS '/
/' reuse GL_MIN_FRAGMENT_INTERPOLATION_OFFSET '/
/' reuse GL_MAX_FRAGMENT_INTERPOLATION_OFFSET '/
/' reuse GL_FRAGMENT_INTERPOLATION_OFFSET_BITS '/
/' reuse GL_MAX_VERTEX_STREAMS '/
/' Reuse tokens from ARB_gpu_shader_fp64 '/
/' reuse GL_DOUBLE_VEC2 '/
/' reuse GL_DOUBLE_VEC3 '/
/' reuse GL_DOUBLE_VEC4 '/
/' reuse GL_DOUBLE_MAT2 '/
/' reuse GL_DOUBLE_MAT3 '/
/' reuse GL_DOUBLE_MAT4 '/
/' reuse GL_DOUBLE_MAT2x3 '/
/' reuse GL_DOUBLE_MAT2x4 '/
/' reuse GL_DOUBLE_MAT3x2 '/
/' reuse GL_DOUBLE_MAT3x4 '/
/' reuse GL_DOUBLE_MAT4x2 '/
/' reuse GL_DOUBLE_MAT4x3 '/
/' Reuse tokens from ARB_shader_subroutine '/
/' reuse GL_ACTIVE_SUBROUTINES '/
/' reuse GL_ACTIVE_SUBROUTINE_UNIFORMS '/
/' reuse GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS '/
/' reuse GL_ACTIVE_SUBROUTINE_MAX_LENGTH '/
/' reuse GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH '/
/' reuse GL_MAX_SUBROUTINES '/
/' reuse GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS '/
/' reuse GL_NUM_COMPATIBLE_SUBROUTINES '/
/' reuse GL_COMPATIBLE_SUBROUTINES '/
/' Reuse tokens from ARB_tessellation_shader '/
/' reuse GL_PATCHES '/
/' reuse GL_PATCH_VERTICES '/
/' reuse GL_PATCH_DEFAULT_INNER_LEVEL '/
/' reuse GL_PATCH_DEFAULT_OUTER_LEVEL '/
/' reuse GL_TESS_CONTROL_OUTPUT_VERTICES '/
/' reuse GL_TESS_GEN_MODE '/
/' reuse GL_TESS_GEN_SPACING '/
/' reuse GL_TESS_GEN_VERTEX_ORDER '/
/' reuse GL_TESS_GEN_POINT_MODE '/
/' reuse GL_ISOLINES '/
/' reuse GL_FRACTIONAL_ODD '/
/' reuse GL_FRACTIONAL_EVEN '/
/' reuse GL_MAX_PATCH_VERTICES '/
/' reuse GL_MAX_TESS_GEN_LEVEL '/
/' reuse GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS '/
/' reuse GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS '/
/' reuse GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS '/
/' reuse GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS '/
/' reuse GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS '/
/' reuse GL_MAX_TESS_PATCH_COMPONENTS '/
/' reuse GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS '/
/' reuse GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS '/
/' reuse GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS '/
/' reuse GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS '/
/' reuse GL_MAX_TESS_CONTROL_INPUT_COMPONENTS '/
/' reuse GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS '/
/' reuse GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS '/
/' reuse GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS '/
/' reuse GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER '/
/' reuse GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER '/
/' reuse GL_TESS_EVALUATION_SHADER '/
/' reuse GL_TESS_CONTROL_SHADER '/
/' Reuse tokens from ARB_texture_buffer_object_rgb32 (none) '/
/' Reuse tokens from ARB_transform_feedback2 '/
/' reuse GL_TRANSFORM_FEEDBACK '/
/' reuse GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED '/
/' reuse GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE '/
/' reuse GL_TRANSFORM_FEEDBACK_BINDING '/
/' Reuse tokens from ARB_transform_feedback3 '/
/' reuse GL_MAX_TRANSFORM_FEEDBACK_BUFFERS '/
/' reuse GL_MAX_VERTEX_STREAMS '/
#EndIf

#Ifndef GL_VERSION_4_1
/' Reuse tokens from ARB_ES2_compatibility '/
/' reuse GL_FIXED '/
/' reuse GL_IMPLEMENTATION_COLOR_READ_TYPE '/
/' reuse GL_IMPLEMENTATION_COLOR_READ_FORMAT '/
/' reuse GL_LOW_FLOAT '/
/' reuse GL_MEDIUM_FLOAT '/
/' reuse GL_HIGH_FLOAT '/
/' reuse GL_LOW_INT '/
/' reuse GL_MEDIUM_INT '/
/' reuse GL_HIGH_INT '/
/' reuse GL_SHADER_COMPILER '/
/' reuse GL_NUM_SHADER_BINARY_FORMATS '/
/' reuse GL_MAX_VERTEX_UNIFORM_VECTORS '/
/' reuse GL_MAX_VARYING_VECTORS '/
/' reuse GL_MAX_FRAGMENT_UNIFORM_VECTORS '/
/' Reuse tokens from ARB_get_program_binary '/
/' reuse GL_PROGRAM_BINARY_RETRIEVABLE_HINT '/
/' reuse GL_PROGRAM_BINARY_LENGTH '/
/' reuse GL_NUM_PROGRAM_BINARY_FORMATS '/
/' reuse GL_PROGRAM_BINARY_FORMATS '/
/' Reuse tokens from ARB_separate_shader_objects '/
/' reuse GL_VERTEX_SHADER_BIT '/
/' reuse GL_FRAGMENT_SHADER_BIT '/
/' reuse GL_GEOMETRY_SHADER_BIT '/
/' reuse GL_TESS_CONTROL_SHADER_BIT '/
/' reuse GL_TESS_EVALUATION_SHADER_BIT '/
/' reuse GL_ALL_SHADER_BITS '/
/' reuse GL_PROGRAM_SEPARABLE '/
/' reuse GL_ACTIVE_PROGRAM '/
/' reuse GL_PROGRAM_PIPELINE_BINDING '/
/' Reuse tokens from ARB_shader_precision (none) '/
/' Reuse tokens from ARB_vertex_attrib_64bit - all are in GL 3.0 and 4.0 already '/
/' Reuse tokens from ARB_viewport_array - some are in GL 1.1 and ARB_provoking_vertex already '/
/' reuse GL_MAX_VIEWPORTS '/
/' reuse GL_VIEWPORT_SUBPIXEL_BITS '/
/' reuse GL_VIEWPORT_BOUNDS_RANGE '/
/' reuse GL_LAYER_PROVOKING_VERTEX '/
/' reuse GL_VIEWPORT_INDEX_PROVOKING_VERTEX '/
/' reuse GL_UNDEFINED_VERTEX '/
#EndIf

#Ifndef GL_VERSION_4_2
/' Reuse tokens from ARB_base_instance (none) '/
/' Reuse tokens from ARB_shading_language_420pack (none) '/
/' Reuse tokens from ARB_transform_feedback_instanced (none) '/
/' Reuse tokens from ARB_compressed_texture_pixel_storage '/
/' reuse GL_UNPACK_COMPRESSED_BLOCK_WIDTH '/
/' reuse GL_UNPACK_COMPRESSED_BLOCK_HEIGHT '/
/' reuse GL_UNPACK_COMPRESSED_BLOCK_DEPTH '/
/' reuse GL_UNPACK_COMPRESSED_BLOCK_SIZE '/
/' reuse GL_PACK_COMPRESSED_BLOCK_WIDTH '/
/' reuse GL_PACK_COMPRESSED_BLOCK_HEIGHT '/
/' reuse GL_PACK_COMPRESSED_BLOCK_DEPTH '/
/' reuse GL_PACK_COMPRESSED_BLOCK_SIZE '/
/' Reuse tokens from ARB_conservative_depth (none) '/
/' Reuse tokens from ARB_internalformat_query '/
/' reuse GL_NUM_SAMPLE_COUNTS '/
/' Reuse tokens from ARB_map_buffer_alignment '/
/' reuse GL_MIN_MAP_BUFFER_ALIGNMENT '/
/' Reuse tokens from ARB_shader_atomic_counters '/
/' reuse GL_ATOMIC_COUNTER_BUFFER '/
/' reuse GL_ATOMIC_COUNTER_BUFFER_BINDING '/
/' reuse GL_ATOMIC_COUNTER_BUFFER_START '/
/' reuse GL_ATOMIC_COUNTER_BUFFER_SIZE '/
/' reuse GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE '/
/' reuse GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS '/
/' reuse GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES '/
/' reuse GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER '/
/' reuse GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER '/
/' reuse GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER '/
/' reuse GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER '/
/' reuse GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER '/
/' reuse GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS '/
/' reuse GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS '/
/' reuse GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS '/
/' reuse GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS '/
/' reuse GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS '/
/' reuse GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS '/
/' reuse GL_MAX_VERTEX_ATOMIC_COUNTERS '/
/' reuse GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS '/
/' reuse GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS '/
/' reuse GL_MAX_GEOMETRY_ATOMIC_COUNTERS '/
/' reuse GL_MAX_FRAGMENT_ATOMIC_COUNTERS '/
/' reuse GL_MAX_COMBINED_ATOMIC_COUNTERS '/
/' reuse GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE '/
/' reuse GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS '/
/' reuse GL_ACTIVE_ATOMIC_COUNTER_BUFFERS '/
/' reuse GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX '/
/' reuse GL_UNSIGNED_INT_ATOMIC_COUNTER '/
/' Reuse tokens from ARB_shader_image_load_store '/
/' reuse GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT '/
/' reuse GL_ELEMENT_ARRAY_BARRIER_BIT '/
/' reuse GL_UNIFORM_BARRIER_BIT '/
/' reuse GL_TEXTURE_FETCH_BARRIER_BIT '/
/' reuse GL_SHADER_IMAGE_ACCESS_BARRIER_BIT '/
/' reuse GL_COMMAND_BARRIER_BIT '/
/' reuse GL_PIXEL_BUFFER_BARRIER_BIT '/
/' reuse GL_TEXTURE_UPDATE_BARRIER_BIT '/
/' reuse GL_BUFFER_UPDATE_BARRIER_BIT '/
/' reuse GL_FRAMEBUFFER_BARRIER_BIT '/
/' reuse GL_TRANSFORM_FEEDBACK_BARRIER_BIT '/
/' reuse GL_ATOMIC_COUNTER_BARRIER_BIT '/
/' reuse GL_ALL_BARRIER_BITS '/
/' reuse GL_MAX_IMAGE_UNITS '/
/' reuse GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS '/
/' reuse GL_IMAGE_BINDING_NAME '/
/' reuse GL_IMAGE_BINDING_LEVEL '/
/' reuse GL_IMAGE_BINDING_LAYERED '/
/' reuse GL_IMAGE_BINDING_LAYER '/
/' reuse GL_IMAGE_BINDING_ACCESS '/
/' reuse GL_IMAGE_1D '/
/' reuse GL_IMAGE_2D '/
/' reuse GL_IMAGE_3D '/
/' reuse GL_IMAGE_2D_RECT '/
/' reuse GL_IMAGE_CUBE '/
/' reuse GL_IMAGE_BUFFER '/
/' reuse GL_IMAGE_1D_ARRAY '/
/' reuse GL_IMAGE_2D_ARRAY '/
/' reuse GL_IMAGE_CUBE_MAP_ARRAY '/
/' reuse GL_IMAGE_2D_MULTISAMPLE '/
/' reuse GL_IMAGE_2D_MULTISAMPLE_ARRAY '/
/' reuse GL_INT_IMAGE_1D '/
/' reuse GL_INT_IMAGE_2D '/
/' reuse GL_INT_IMAGE_3D '/
/' reuse GL_INT_IMAGE_2D_RECT '/
/' reuse GL_INT_IMAGE_CUBE '/
/' reuse GL_INT_IMAGE_BUFFER '/
/' reuse GL_INT_IMAGE_1D_ARRAY '/
/' reuse GL_INT_IMAGE_2D_ARRAY '/
/' reuse GL_INT_IMAGE_CUBE_MAP_ARRAY '/
/' reuse GL_INT_IMAGE_2D_MULTISAMPLE '/
/' reuse GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY '/
/' reuse GL_UNSIGNED_INT_IMAGE_1D '/
/' reuse GL_UNSIGNED_INT_IMAGE_2D '/
/' reuse GL_UNSIGNED_INT_IMAGE_3D '/
/' reuse GL_UNSIGNED_INT_IMAGE_2D_RECT '/
/' reuse GL_UNSIGNED_INT_IMAGE_CUBE '/
/' reuse GL_UNSIGNED_INT_IMAGE_BUFFER '/
/' reuse GL_UNSIGNED_INT_IMAGE_1D_ARRAY '/
/' reuse GL_UNSIGNED_INT_IMAGE_2D_ARRAY '/
/' reuse GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY '/
/' reuse GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE '/
/' reuse GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY '/
/' reuse GL_MAX_IMAGE_SAMPLES '/
/' reuse GL_IMAGE_BINDING_FORMAT '/
/' reuse GL_IMAGE_FORMAT_COMPATIBILITY_TYPE '/
/' reuse GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE '/
/' reuse GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS '/
/' reuse GL_MAX_VERTEX_IMAGE_UNIFORMS '/
/' reuse GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS '/
/' reuse GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS '/
/' reuse GL_MAX_GEOMETRY_IMAGE_UNIFORMS '/
/' reuse GL_MAX_FRAGMENT_IMAGE_UNIFORMS '/
/' reuse GL_MAX_COMBINED_IMAGE_UNIFORMS '/
/' Reuse tokens from ARB_shading_language_packing (none) '/
/' Reuse tokens from ARB_texture_storage '/
/' reuse GL_TEXTURE_IMMUTABLE_FORMAT '/
#EndIf

#Ifndef GL_ARB_multitexture
#define GL_TEXTURE0_ARB                   &h84C0
#define GL_TEXTURE1_ARB                   &h84C1
#define GL_TEXTURE2_ARB                   &h84C2
#define GL_TEXTURE3_ARB                   &h84C3
#define GL_TEXTURE4_ARB                   &h84C4
#define GL_TEXTURE5_ARB                   &h84C5
#define GL_TEXTURE6_ARB                   &h84C6
#define GL_TEXTURE7_ARB                   &h84C7
#define GL_TEXTURE8_ARB                   &h84C8
#define GL_TEXTURE9_ARB                   &h84C9
#define GL_TEXTURE10_ARB                  &h84CA
#define GL_TEXTURE11_ARB                  &h84CB
#define GL_TEXTURE12_ARB                  &h84CC
#define GL_TEXTURE13_ARB                  &h84CD
#define GL_TEXTURE14_ARB                  &h84CE
#define GL_TEXTURE15_ARB                  &h84CF
#define GL_TEXTURE16_ARB                  &h84D0
#define GL_TEXTURE17_ARB                  &h84D1
#define GL_TEXTURE18_ARB                  &h84D2
#define GL_TEXTURE19_ARB                  &h84D3
#define GL_TEXTURE20_ARB                  &h84D4
#define GL_TEXTURE21_ARB                  &h84D5
#define GL_TEXTURE22_ARB                  &h84D6
#define GL_TEXTURE23_ARB                  &h84D7
#define GL_TEXTURE24_ARB                  &h84D8
#define GL_TEXTURE25_ARB                  &h84D9
#define GL_TEXTURE26_ARB                  &h84DA
#define GL_TEXTURE27_ARB                  &h84DB
#define GL_TEXTURE28_ARB                  &h84DC
#define GL_TEXTURE29_ARB                  &h84DD
#define GL_TEXTURE30_ARB                  &h84DE
#define GL_TEXTURE31_ARB                  &h84DF
#define GL_ACTIVE_TEXTURE_ARB             &h84E0
#define GL_CLIENT_ACTIVE_TEXTURE_ARB      &h84E1
#define GL_MAX_TEXTURE_UNITS_ARB          &h84E2
#EndIf

#Ifndef GL_ARB_transpose_matrix
#define GL_TRANSPOSE_MODELVIEW_MATRIX_ARB &h84E3
#define GL_TRANSPOSE_PROJECTION_MATRIX_ARB &h84E4
#define GL_TRANSPOSE_TEXTURE_MATRIX_ARB   &h84E5
#define GL_TRANSPOSE_COLOR_MATRIX_ARB     &h84E6
#EndIf

#Ifndef GL_ARB_multisample
#define GL_MULTISAMPLE_ARB                &h809D
#define GL_SAMPLE_ALPHA_TO_COVERAGE_ARB   &h809E
#define GL_SAMPLE_ALPHA_TO_ONE_ARB        &h809F
#define GL_SAMPLE_COVERAGE_ARB            &h80A0
#define GL_SAMPLE_BUFFERS_ARB             &h80A8
#define GL_SAMPLES_ARB                    &h80A9
#define GL_SAMPLE_COVERAGE_VALUE_ARB      &h80AA
#define GL_SAMPLE_COVERAGE_INVERT_ARB     &h80AB
#define GL_MULTISAMPLE_BIT_ARB            &h20000000
#EndIf

#Ifndef GL_ARB_texture_env_add
#EndIf

#Ifndef GL_ARB_texture_cube_map
#define GL_NORMAL_MAP_ARB                 &h8511
#define GL_REFLECTION_MAP_ARB             &h8512
#define GL_TEXTURE_CUBE_MAP_ARB           &h8513
#define GL_TEXTURE_BINDING_CUBE_MAP_ARB   &h8514
#define GL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB &h8515
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB &h8516
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB &h8517
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB &h8518
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB &h8519
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB &h851A
#define GL_PROXY_TEXTURE_CUBE_MAP_ARB     &h851B
#define GL_MAX_CUBE_MAP_TEXTURE_SIZE_ARB  &h851C
#EndIf

#Ifndef GL_ARB_texture_compression
#define GL_COMPRESSED_ALPHA_ARB           &h84E9
#define GL_COMPRESSED_LUMINANCE_ARB       &h84EA
#define GL_COMPRESSED_LUMINANCE_ALPHA_ARB &h84EB
#define GL_COMPRESSED_INTENSITY_ARB       &h84EC
#define GL_COMPRESSED_RGB_ARB             &h84ED
#define GL_COMPRESSED_RGBA_ARB            &h84EE
#define GL_TEXTURE_COMPRESSION_HINT_ARB   &h84EF
#define GL_TEXTURE_COMPRESSED_IMAGE_SIZE_ARB &h86A0
#define GL_TEXTURE_COMPRESSED_ARB         &h86A1
#define GL_NUM_COMPRESSED_TEXTURE_FORMATS_ARB &h86A2
#define GL_COMPRESSED_TEXTURE_FORMATS_ARB &h86A3
#EndIf

#Ifndef GL_ARB_texture_border_clamp
#define GL_CLAMP_TO_BORDER_ARB            &h812D
#EndIf

#Ifndef GL_ARB_point_parameters
#define GL_POINT_SIZE_MIN_ARB             &h8126
#define GL_POINT_SIZE_MAX_ARB             &h8127
#define GL_POINT_FADE_THRESHOLD_SIZE_ARB  &h8128
#define GL_POINT_DISTANCE_ATTENUATION_ARB &h8129
#EndIf

#Ifndef GL_ARB_vertex_blend
#define GL_MAX_VERTEX_UNITS_ARB           &h86A4
#define GL_ACTIVE_VERTEX_UNITS_ARB        &h86A5
#define GL_WEIGHT_SUM_UNITY_ARB           &h86A6
#define GL_VERTEX_BLEND_ARB               &h86A7
#define GL_CURRENT_WEIGHT_ARB             &h86A8
#define GL_WEIGHT_ARRAY_TYPE_ARB          &h86A9
#define GL_WEIGHT_ARRAY_STRIDE_ARB        &h86AA
#define GL_WEIGHT_ARRAY_SIZE_ARB          &h86AB
#define GL_WEIGHT_ARRAY_POINTER_ARB       &h86AC
#define GL_WEIGHT_ARRAY_ARB               &h86AD
#define GL_MODELVIEW0_ARB                 &h1700
#define GL_MODELVIEW1_ARB                 &h850A
#define GL_MODELVIEW2_ARB                 &h8722
#define GL_MODELVIEW3_ARB                 &h8723
#define GL_MODELVIEW4_ARB                 &h8724
#define GL_MODELVIEW5_ARB                 &h8725
#define GL_MODELVIEW6_ARB                 &h8726
#define GL_MODELVIEW7_ARB                 &h8727
#define GL_MODELVIEW8_ARB                 &h8728
#define GL_MODELVIEW9_ARB                 &h8729
#define GL_MODELVIEW10_ARB                &h872A
#define GL_MODELVIEW11_ARB                &h872B
#define GL_MODELVIEW12_ARB                &h872C
#define GL_MODELVIEW13_ARB                &h872D
#define GL_MODELVIEW14_ARB                &h872E
#define GL_MODELVIEW15_ARB                &h872F
#define GL_MODELVIEW16_ARB                &h8730
#define GL_MODELVIEW17_ARB                &h8731
#define GL_MODELVIEW18_ARB                &h8732
#define GL_MODELVIEW19_ARB                &h8733
#define GL_MODELVIEW20_ARB                &h8734
#define GL_MODELVIEW21_ARB                &h8735
#define GL_MODELVIEW22_ARB                &h8736
#define GL_MODELVIEW23_ARB                &h8737
#define GL_MODELVIEW24_ARB                &h8738
#define GL_MODELVIEW25_ARB                &h8739
#define GL_MODELVIEW26_ARB                &h873A
#define GL_MODELVIEW27_ARB                &h873B
#define GL_MODELVIEW28_ARB                &h873C
#define GL_MODELVIEW29_ARB                &h873D
#define GL_MODELVIEW30_ARB                &h873E
#define GL_MODELVIEW31_ARB                &h873F
#EndIf

#Ifndef GL_ARB_matrix_palette
#define GL_MATRIX_PALETTE_ARB             &h8840
#define GL_MAX_MATRIX_PALETTE_STACK_DEPTH_ARB &h8841
#define GL_MAX_PALETTE_MATRICES_ARB       &h8842
#define GL_CURRENT_PALETTE_MATRIX_ARB     &h8843
#define GL_MATRIX_INDEX_ARRAY_ARB         &h8844
#define GL_CURRENT_MATRIX_INDEX_ARB       &h8845
#define GL_MATRIX_INDEX_ARRAY_SIZE_ARB    &h8846
#define GL_MATRIX_INDEX_ARRAY_TYPE_ARB    &h8847
#define GL_MATRIX_INDEX_ARRAY_STRIDE_ARB  &h8848
#define GL_MATRIX_INDEX_ARRAY_POINTER_ARB &h8849
#EndIf

#Ifndef GL_ARB_texture_env_combine
#define GL_COMBINE_ARB                    &h8570
#define GL_COMBINE_RGB_ARB                &h8571
#define GL_COMBINE_ALPHA_ARB              &h8572
#define GL_SOURCE0_RGB_ARB                &h8580
#define GL_SOURCE1_RGB_ARB                &h8581
#define GL_SOURCE2_RGB_ARB                &h8582
#define GL_SOURCE0_ALPHA_ARB              &h8588
#define GL_SOURCE1_ALPHA_ARB              &h8589
#define GL_SOURCE2_ALPHA_ARB              &h858A
#define GL_OPERAND0_RGB_ARB               &h8590
#define GL_OPERAND1_RGB_ARB               &h8591
#define GL_OPERAND2_RGB_ARB               &h8592
#define GL_OPERAND0_ALPHA_ARB             &h8598
#define GL_OPERAND1_ALPHA_ARB             &h8599
#define GL_OPERAND2_ALPHA_ARB             &h859A
#define GL_RGB_SCALE_ARB                  &h8573
#define GL_ADD_SIGNED_ARB                 &h8574
#define GL_INTERPOLATE_ARB                &h8575
#define GL_SUBTRACT_ARB                   &h84E7
#define GL_CONSTANT_ARB                   &h8576
#define GL_PRIMARY_COLOR_ARB              &h8577
#define GL_PREVIOUS_ARB                   &h8578
#EndIf

#Ifndef GL_ARB_texture_env_crossbar
#EndIf

#Ifndef GL_ARB_texture_env_dot3
#define GL_DOT3_RGB_ARB                   &h86AE
#define GL_DOT3_RGBA_ARB                  &h86AF
#EndIf

#Ifndef GL_ARB_texture_mirrored_repeat
#define GL_MIRRORED_REPEAT_ARB            &h8370
#EndIf

#Ifndef GL_ARB_depth_texture
#define GL_DEPTH_COMPONENT16_ARB          &h81A5
#define GL_DEPTH_COMPONENT24_ARB          &h81A6
#define GL_DEPTH_COMPONENT32_ARB          &h81A7
#define GL_TEXTURE_DEPTH_SIZE_ARB         &h884A
#define GL_DEPTH_TEXTURE_MODE_ARB         &h884B
#EndIf

#Ifndef GL_ARB_shadow
#define GL_TEXTURE_COMPARE_MODE_ARB       &h884C
#define GL_TEXTURE_COMPARE_FUNC_ARB       &h884D
#define GL_COMPARE_R_TO_TEXTURE_ARB       &h884E
#EndIf

#Ifndef GL_ARB_shadow_ambient
#define GL_TEXTURE_COMPARE_FAIL_VALUE_ARB &h80BF
#EndIf

#Ifndef GL_ARB_window_pos
#EndIf

#Ifndef GL_ARB_vertex_program
#define GL_COLOR_SUM_ARB                  &h8458
#define GL_VERTEX_PROGRAM_ARB             &h8620
#define GL_VERTEX_ATTRIB_ARRAY_ENABLED_ARB &h8622
#define GL_VERTEX_ATTRIB_ARRAY_SIZE_ARB   &h8623
#define GL_VERTEX_ATTRIB_ARRAY_STRIDE_ARB &h8624
#define GL_VERTEX_ATTRIB_ARRAY_TYPE_ARB   &h8625
#define GL_CURRENT_VERTEX_ATTRIB_ARB      &h8626
#define GL_PROGRAM_LENGTH_ARB             &h8627
#define GL_PROGRAM_STRING_ARB             &h8628
#define GL_MAX_PROGRAM_MATRIX_STACK_DEPTH_ARB &h862E
#define GL_MAX_PROGRAM_MATRICES_ARB       &h862F
#define GL_CURRENT_MATRIX_STACK_DEPTH_ARB &h8640
#define GL_CURRENT_MATRIX_ARB             &h8641
#define GL_VERTEX_PROGRAM_POINT_SIZE_ARB  &h8642
#define GL_VERTEX_PROGRAM_TWO_SIDE_ARB    &h8643
#define GL_VERTEX_ATTRIB_ARRAY_POINTER_ARB &h8645
#define GL_PROGRAM_ERROR_POSITION_ARB     &h864B
#define GL_PROGRAM_BINDING_ARB            &h8677
#define GL_MAX_VERTEX_ATTRIBS_ARB         &h8869
#define GL_VERTEX_ATTRIB_ARRAY_NORMALIZED_ARB &h886A
#define GL_PROGRAM_ERROR_STRING_ARB       &h8874
#define GL_PROGRAM_FORMAT_ASCII_ARB       &h8875
#define GL_PROGRAM_FORMAT_ARB             &h8876
#define GL_PROGRAM_INSTRUCTIONS_ARB       &h88A0
#define GL_MAX_PROGRAM_INSTRUCTIONS_ARB   &h88A1
#define GL_PROGRAM_NATIVE_INSTRUCTIONS_ARB &h88A2
#define GL_MAX_PROGRAM_NATIVE_INSTRUCTIONS_ARB &h88A3
#define GL_PROGRAM_TEMPORARIES_ARB        &h88A4
#define GL_MAX_PROGRAM_TEMPORARIES_ARB    &h88A5
#define GL_PROGRAM_NATIVE_TEMPORARIES_ARB &h88A6
#define GL_MAX_PROGRAM_NATIVE_TEMPORARIES_ARB &h88A7
#define GL_PROGRAM_PARAMETERS_ARB         &h88A8
#define GL_MAX_PROGRAM_PARAMETERS_ARB     &h88A9
#define GL_PROGRAM_NATIVE_PARAMETERS_ARB  &h88AA
#define GL_MAX_PROGRAM_NATIVE_PARAMETERS_ARB &h88AB
#define GL_PROGRAM_ATTRIBS_ARB            &h88AC
#define GL_MAX_PROGRAM_ATTRIBS_ARB        &h88AD
#define GL_PROGRAM_NATIVE_ATTRIBS_ARB     &h88AE
#define GL_MAX_PROGRAM_NATIVE_ATTRIBS_ARB &h88AF
#define GL_PROGRAM_ADDRESS_REGISTERS_ARB  &h88B0
#define GL_MAX_PROGRAM_ADDRESS_REGISTERS_ARB &h88B1
#define GL_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB &h88B2
#define GL_MAX_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB &h88B3
#define GL_MAX_PROGRAM_LOCAL_PARAMETERS_ARB &h88B4
#define GL_MAX_PROGRAM_ENV_PARAMETERS_ARB &h88B5
#define GL_PROGRAM_UNDER_NATIVE_LIMITS_ARB &h88B6
#define GL_TRANSPOSE_CURRENT_MATRIX_ARB   &h88B7
#define GL_MATRIX0_ARB                    &h88C0
#define GL_MATRIX1_ARB                    &h88C1
#define GL_MATRIX2_ARB                    &h88C2
#define GL_MATRIX3_ARB                    &h88C3
#define GL_MATRIX4_ARB                    &h88C4
#define GL_MATRIX5_ARB                    &h88C5
#define GL_MATRIX6_ARB                    &h88C6
#define GL_MATRIX7_ARB                    &h88C7
#define GL_MATRIX8_ARB                    &h88C8
#define GL_MATRIX9_ARB                    &h88C9
#define GL_MATRIX10_ARB                   &h88CA
#define GL_MATRIX11_ARB                   &h88CB
#define GL_MATRIX12_ARB                   &h88CC
#define GL_MATRIX13_ARB                   &h88CD
#define GL_MATRIX14_ARB                   &h88CE
#define GL_MATRIX15_ARB                   &h88CF
#define GL_MATRIX16_ARB                   &h88D0
#define GL_MATRIX17_ARB                   &h88D1
#define GL_MATRIX18_ARB                   &h88D2
#define GL_MATRIX19_ARB                   &h88D3
#define GL_MATRIX20_ARB                   &h88D4
#define GL_MATRIX21_ARB                   &h88D5
#define GL_MATRIX22_ARB                   &h88D6
#define GL_MATRIX23_ARB                   &h88D7
#define GL_MATRIX24_ARB                   &h88D8
#define GL_MATRIX25_ARB                   &h88D9
#define GL_MATRIX26_ARB                   &h88DA
#define GL_MATRIX27_ARB                   &h88DB
#define GL_MATRIX28_ARB                   &h88DC
#define GL_MATRIX29_ARB                   &h88DD
#define GL_MATRIX30_ARB                   &h88DE
#define GL_MATRIX31_ARB                   &h88DF
#EndIf

#Ifndef GL_ARB_fragment_program
#define GL_FRAGMENT_PROGRAM_ARB           &h8804
#define GL_PROGRAM_ALU_INSTRUCTIONS_ARB   &h8805
#define GL_PROGRAM_TEX_INSTRUCTIONS_ARB   &h8806
#define GL_PROGRAM_TEX_INDIRECTIONS_ARB   &h8807
#define GL_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB &h8808
#define GL_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB &h8809
#define GL_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB &h880A
#define GL_MAX_PROGRAM_ALU_INSTRUCTIONS_ARB &h880B
#define GL_MAX_PROGRAM_TEX_INSTRUCTIONS_ARB &h880C
#define GL_MAX_PROGRAM_TEX_INDIRECTIONS_ARB &h880D
#define GL_MAX_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB &h880E
#define GL_MAX_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB &h880F
#define GL_MAX_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB &h8810
#define GL_MAX_TEXTURE_COORDS_ARB         &h8871
#define GL_MAX_TEXTURE_IMAGE_UNITS_ARB    &h8872
#EndIf

#Ifndef GL_ARB_vertex_buffer_object
#define GL_BUFFER_SIZE_ARB                &h8764
#define GL_BUFFER_USAGE_ARB               &h8765
#define GL_ARRAY_BUFFER_ARB               &h8892
#define GL_ELEMENT_ARRAY_BUFFER_ARB       &h8893
#define GL_ARRAY_BUFFER_BINDING_ARB       &h8894
#define GL_ELEMENT_ARRAY_BUFFER_BINDING_ARB &h8895
#define GL_VERTEX_ARRAY_BUFFER_BINDING_ARB &h8896
#define GL_NORMAL_ARRAY_BUFFER_BINDING_ARB &h8897
#define GL_COLOR_ARRAY_BUFFER_BINDING_ARB &h8898
#define GL_INDEX_ARRAY_BUFFER_BINDING_ARB &h8899
#define GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING_ARB &h889A
#define GL_EDGE_FLAG_ARRAY_BUFFER_BINDING_ARB &h889B
#define GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING_ARB &h889C
#define GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING_ARB &h889D
#define GL_WEIGHT_ARRAY_BUFFER_BINDING_ARB &h889E
#define GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING_ARB &h889F
#define GL_READ_ONLY_ARB                  &h88B8
#define GL_WRITE_ONLY_ARB                 &h88B9
#define GL_READ_WRITE_ARB                 &h88BA
#define GL_BUFFER_ACCESS_ARB              &h88BB
#define GL_BUFFER_MAPPED_ARB              &h88BC
#define GL_BUFFER_MAP_POINTER_ARB         &h88BD
#define GL_STREAM_DRAW_ARB                &h88E0
#define GL_STREAM_READ_ARB                &h88E1
#define GL_STREAM_COPY_ARB                &h88E2
#define GL_STATIC_DRAW_ARB                &h88E4
#define GL_STATIC_READ_ARB                &h88E5
#define GL_STATIC_COPY_ARB                &h88E6
#define GL_DYNAMIC_DRAW_ARB               &h88E8
#define GL_DYNAMIC_READ_ARB               &h88E9
#define GL_DYNAMIC_COPY_ARB               &h88EA
#EndIf

#Ifndef GL_ARB_occlusion_query
#define GL_QUERY_COUNTER_BITS_ARB         &h8864
#define GL_CURRENT_QUERY_ARB              &h8865
#define GL_QUERY_RESULT_ARB               &h8866
#define GL_QUERY_RESULT_AVAILABLE_ARB     &h8867
#define GL_SAMPLES_PASSED_ARB             &h8914
#EndIf

#Ifndef GL_ARB_shader_objects
#define GL_PROGRAM_OBJECT_ARB             &h8B40
#define GL_SHADER_OBJECT_ARB              &h8B48
#define GL_OBJECT_TYPE_ARB                &h8B4E
#define GL_OBJECT_SUBTYPE_ARB             &h8B4F
#define GL_FLOAT_VEC2_ARB                 &h8B50
#define GL_FLOAT_VEC3_ARB                 &h8B51
#define GL_FLOAT_VEC4_ARB                 &h8B52
#define GL_INT_VEC2_ARB                   &h8B53
#define GL_INT_VEC3_ARB                   &h8B54
#define GL_INT_VEC4_ARB                   &h8B55
#define GL_BOOL_ARB                       &h8B56
#define GL_BOOL_VEC2_ARB                  &h8B57
#define GL_BOOL_VEC3_ARB                  &h8B58
#define GL_BOOL_VEC4_ARB                  &h8B59
#define GL_FLOAT_MAT2_ARB                 &h8B5A
#define GL_FLOAT_MAT3_ARB                 &h8B5B
#define GL_FLOAT_MAT4_ARB                 &h8B5C
#define GL_SAMPLER_1D_ARB                 &h8B5D
#define GL_SAMPLER_2D_ARB                 &h8B5E
#define GL_SAMPLER_3D_ARB                 &h8B5F
#define GL_SAMPLER_CUBE_ARB               &h8B60
#define GL_SAMPLER_1D_SHADOW_ARB          &h8B61
#define GL_SAMPLER_2D_SHADOW_ARB          &h8B62
#define GL_SAMPLER_2D_RECT_ARB            &h8B63
#define GL_SAMPLER_2D_RECT_SHADOW_ARB     &h8B64
#define GL_OBJECT_DELETE_STATUS_ARB       &h8B80
#define GL_OBJECT_COMPILE_STATUS_ARB      &h8B81
#define GL_OBJECT_LINK_STATUS_ARB         &h8B82
#define GL_OBJECT_VALIDATE_STATUS_ARB     &h8B83
#define GL_OBJECT_INFO_LOG_LENGTH_ARB     &h8B84
#define GL_OBJECT_ATTACHED_OBJECTS_ARB    &h8B85
#define GL_OBJECT_ACTIVE_UNIFORMS_ARB     &h8B86
#define GL_OBJECT_ACTIVE_UNIFORM_MAX_LENGTH_ARB &h8B87
#define GL_OBJECT_SHADER_SOURCE_LENGTH_ARB &h8B88
#EndIf

#Ifndef GL_ARB_vertex_shader
#define GL_VERTEX_SHADER_ARB              &h8B31
#define GL_MAX_VERTEX_UNIFORM_COMPONENTS_ARB &h8B4A
#define GL_MAX_VARYING_FLOATS_ARB         &h8B4B
#define GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB &h8B4C
#define GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS_ARB &h8B4D
#define GL_OBJECT_ACTIVE_ATTRIBUTES_ARB   &h8B89
#define GL_OBJECT_ACTIVE_ATTRIBUTE_MAX_LENGTH_ARB &h8B8A
#EndIf

#Ifndef GL_ARB_fragment_shader
#define GL_FRAGMENT_SHADER_ARB            &h8B30
#define GL_MAX_FRAGMENT_UNIFORM_COMPONENTS_ARB &h8B49
#define GL_FRAGMENT_SHADER_DERIVATIVE_HINT_ARB &h8B8B
#EndIf

#Ifndef GL_ARB_shading_language_100
#define GL_SHADING_LANGUAGE_VERSION_ARB   &h8B8C
#EndIf

#Ifndef GL_ARB_texture_non_power_of_two
#EndIf

#Ifndef GL_ARB_point_sprite
#define GL_POINT_SPRITE_ARB               &h8861
#define GL_COORD_REPLACE_ARB              &h8862
#EndIf

#Ifndef GL_ARB_fragment_program_shadow
#EndIf

#Ifndef GL_ARB_draw_buffers
#define GL_MAX_DRAW_BUFFERS_ARB           &h8824
#define GL_DRAW_BUFFER0_ARB               &h8825
#define GL_DRAW_BUFFER1_ARB               &h8826
#define GL_DRAW_BUFFER2_ARB               &h8827
#define GL_DRAW_BUFFER3_ARB               &h8828
#define GL_DRAW_BUFFER4_ARB               &h8829
#define GL_DRAW_BUFFER5_ARB               &h882A
#define GL_DRAW_BUFFER6_ARB               &h882B
#define GL_DRAW_BUFFER7_ARB               &h882C
#define GL_DRAW_BUFFER8_ARB               &h882D
#define GL_DRAW_BUFFER9_ARB               &h882E
#define GL_DRAW_BUFFER10_ARB              &h882F
#define GL_DRAW_BUFFER11_ARB              &h8830
#define GL_DRAW_BUFFER12_ARB              &h8831
#define GL_DRAW_BUFFER13_ARB              &h8832
#define GL_DRAW_BUFFER14_ARB              &h8833
#define GL_DRAW_BUFFER15_ARB              &h8834
#EndIf

#Ifndef GL_ARB_texture_rectangle
#define GL_TEXTURE_RECTANGLE_ARB          &h84F5
#define GL_TEXTURE_BINDING_RECTANGLE_ARB  &h84F6
#define GL_PROXY_TEXTURE_RECTANGLE_ARB    &h84F7
#define GL_MAX_RECTANGLE_TEXTURE_SIZE_ARB &h84F8
#EndIf

#Ifndef GL_ARB_color_buffer_float
#define GL_RGBA_FLOAT_MODE_ARB            &h8820
#define GL_CLAMP_VERTEX_COLOR_ARB         &h891A
#define GL_CLAMP_FRAGMENT_COLOR_ARB       &h891B
#define GL_CLAMP_READ_COLOR_ARB           &h891C
#define GL_FIXED_ONLY_ARB                 &h891D
#EndIf

#Ifndef GL_ARB_half_float_pixel
#define GL_HALF_FLOAT_ARB                 &h140B
#EndIf

#Ifndef GL_ARB_texture_float
#define GL_TEXTURE_RED_TYPE_ARB           &h8C10
#define GL_TEXTURE_GREEN_TYPE_ARB         &h8C11
#define GL_TEXTURE_BLUE_TYPE_ARB          &h8C12
#define GL_TEXTURE_ALPHA_TYPE_ARB         &h8C13
#define GL_TEXTURE_LUMINANCE_TYPE_ARB     &h8C14
#define GL_TEXTURE_INTENSITY_TYPE_ARB     &h8C15
#define GL_TEXTURE_DEPTH_TYPE_ARB         &h8C16
#define GL_UNSIGNED_NORMALIZED_ARB        &h8C17
#define GL_RGBA32F_ARB                    &h8814
#define GL_RGB32F_ARB                     &h8815
#define GL_ALPHA32F_ARB                   &h8816
#define GL_INTENSITY32F_ARB               &h8817
#define GL_LUMINANCE32F_ARB               &h8818
#define GL_LUMINANCE_ALPHA32F_ARB         &h8819
#define GL_RGBA16F_ARB                    &h881A
#define GL_RGB16F_ARB                     &h881B
#define GL_ALPHA16F_ARB                   &h881C
#define GL_INTENSITY16F_ARB               &h881D
#define GL_LUMINANCE16F_ARB               &h881E
#define GL_LUMINANCE_ALPHA16F_ARB         &h881F
#EndIf

#Ifndef GL_ARB_pixel_buffer_object
#define GL_PIXEL_PACK_BUFFER_ARB          &h88EB
#define GL_PIXEL_UNPACK_BUFFER_ARB        &h88EC
#define GL_PIXEL_PACK_BUFFER_BINDING_ARB  &h88ED
#define GL_PIXEL_UNPACK_BUFFER_BINDING_ARB &h88EF
#EndIf

#Ifndef GL_ARB_depth_buffer_float
#define GL_DEPTH_COMPONENT32F             &h8CAC
#define GL_DEPTH32F_STENCIL8              &h8CAD
#define GL_FLOAT_32_UNSIGNED_INT_24_8_REV &h8DAD
#EndIf

#Ifndef GL_ARB_draw_instanced
#EndIf

#Ifndef GL_ARB_framebuffer_object
#define GL_INVALID_FRAMEBUFFER_OPERATION  &h0506
#define GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING &h8210
#define GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE &h8211
#define GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE &h8212
#define GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE &h8213
#define GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE &h8214
#define GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE &h8215
#define GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE &h8216
#define GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE &h8217
#define GL_FRAMEBUFFER_DEFAULT            &h8218
#define GL_FRAMEBUFFER_UNDEFINED          &h8219
#define GL_DEPTH_STENCIL_ATTACHMENT       &h821A
#define GL_MAX_RENDERBUFFER_SIZE          &h84E8
#define GL_DEPTH_STENCIL                  &h84F9
#define GL_UNSIGNED_INT_24_8              &h84FA
#define GL_DEPTH24_STENCIL8               &h88F0
#define GL_TEXTURE_STENCIL_SIZE           &h88F1
#define GL_TEXTURE_RED_TYPE               &h8C10
#define GL_TEXTURE_GREEN_TYPE             &h8C11
#define GL_TEXTURE_BLUE_TYPE              &h8C12
#define GL_TEXTURE_ALPHA_TYPE             &h8C13
#define GL_TEXTURE_DEPTH_TYPE             &h8C16
#define GL_UNSIGNED_NORMALIZED            &h8C17
#define GL_FRAMEBUFFER_BINDING            &h8CA6
#define GL_DRAW_FRAMEBUFFER_BINDING       GL_FRAMEBUFFER_BINDING
#define GL_RENDERBUFFER_BINDING           &h8CA7
#define GL_READ_FRAMEBUFFER               &h8CA8
#define GL_DRAW_FRAMEBUFFER               &h8CA9
#define GL_READ_FRAMEBUFFER_BINDING       &h8CAA
#define GL_RENDERBUFFER_SAMPLES           &h8CAB
#define GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE &h8CD0
#define GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME &h8CD1
#define GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL &h8CD2
#define GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE &h8CD3
#define GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER &h8CD4
#define GL_FRAMEBUFFER_COMPLETE           &h8CD5
#define GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT &h8CD6
#define GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT &h8CD7
#define GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER &h8CDB
#define GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER &h8CDC
#define GL_FRAMEBUFFER_UNSUPPORTED        &h8CDD
#define GL_MAX_COLOR_ATTACHMENTS          &h8CDF
#define GL_COLOR_ATTACHMENT0              &h8CE0
#define GL_COLOR_ATTACHMENT1              &h8CE1
#define GL_COLOR_ATTACHMENT2              &h8CE2
#define GL_COLOR_ATTACHMENT3              &h8CE3
#define GL_COLOR_ATTACHMENT4              &h8CE4
#define GL_COLOR_ATTACHMENT5              &h8CE5
#define GL_COLOR_ATTACHMENT6              &h8CE6
#define GL_COLOR_ATTACHMENT7              &h8CE7
#define GL_COLOR_ATTACHMENT8              &h8CE8
#define GL_COLOR_ATTACHMENT9              &h8CE9
#define GL_COLOR_ATTACHMENT10             &h8CEA
#define GL_COLOR_ATTACHMENT11             &h8CEB
#define GL_COLOR_ATTACHMENT12             &h8CEC
#define GL_COLOR_ATTACHMENT13             &h8CED
#define GL_COLOR_ATTACHMENT14             &h8CEE
#define GL_COLOR_ATTACHMENT15             &h8CEF
#define GL_DEPTH_ATTACHMENT               &h8D00
#define GL_STENCIL_ATTACHMENT             &h8D20
#define GL_FRAMEBUFFER                    &h8D40
#define GL_RENDERBUFFER                   &h8D41
#define GL_RENDERBUFFER_WIDTH             &h8D42
#define GL_RENDERBUFFER_HEIGHT            &h8D43
#define GL_RENDERBUFFER_INTERNAL_FORMAT   &h8D44
#define GL_STENCIL_INDEX1                 &h8D46
#define GL_STENCIL_INDEX4                 &h8D47
#define GL_STENCIL_INDEX8                 &h8D48
#define GL_STENCIL_INDEX16                &h8D49
#define GL_RENDERBUFFER_RED_SIZE          &h8D50
#define GL_RENDERBUFFER_GREEN_SIZE        &h8D51
#define GL_RENDERBUFFER_BLUE_SIZE         &h8D52
#define GL_RENDERBUFFER_ALPHA_SIZE        &h8D53
#define GL_RENDERBUFFER_DEPTH_SIZE        &h8D54
#define GL_RENDERBUFFER_STENCIL_SIZE      &h8D55
#define GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE &h8D56
#define GL_MAX_SAMPLES                    &h8D57
#EndIf

#Ifndef GL_ARB_framebuffer_object_DEPRECATED
#define GL_INDEX                          &h8222
#define GL_TEXTURE_LUMINANCE_TYPE         &h8C14
#define GL_TEXTURE_INTENSITY_TYPE         &h8C15
#EndIf

#Ifndef GL_ARB_framebuffer_sRGB
#define GL_FRAMEBUFFER_SRGB               &h8DB9
#EndIf

#Ifndef GL_ARB_geometry_shader4
#define GL_LINES_ADJACENCY_ARB            &h000A
#define GL_LINE_STRIP_ADJACENCY_ARB       &h000B
#define GL_TRIANGLES_ADJACENCY_ARB        &h000C
#define GL_TRIANGLE_STRIP_ADJACENCY_ARB   &h000D
#define GL_PROGRAM_POINT_SIZE_ARB         &h8642
#define GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_ARB &h8C29
#define GL_FRAMEBUFFER_ATTACHMENT_LAYERED_ARB &h8DA7
#define GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_ARB &h8DA8
#define GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_ARB &h8DA9
#define GL_GEOMETRY_SHADER_ARB            &h8DD9
#define GL_GEOMETRY_VERTICES_OUT_ARB      &h8DDA
#define GL_GEOMETRY_INPUT_TYPE_ARB        &h8DDB
#define GL_GEOMETRY_OUTPUT_TYPE_ARB       &h8DDC
#define GL_MAX_GEOMETRY_VARYING_COMPONENTS_ARB &h8DDD
#define GL_MAX_VERTEX_VARYING_COMPONENTS_ARB &h8DDE
#define GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_ARB &h8DDF
#define GL_MAX_GEOMETRY_OUTPUT_VERTICES_ARB &h8DE0
#define GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_ARB &h8DE1
/' reuse GL_MAX_VARYING_COMPONENTS '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER '/
#EndIf

#Ifndef GL_ARB_half_float_vertex
#define GL_HALF_FLOAT                     &h140B
#EndIf

#Ifndef GL_ARB_instanced_arrays
#define GL_VERTEX_ATTRIB_ARRAY_DIVISOR_ARB &h88FE
#EndIf

#Ifndef GL_ARB_map_buffer_range
#define GL_MAP_READ_BIT                   &h0001
#define GL_MAP_WRITE_BIT                  &h0002
#define GL_MAP_INVALIDATE_RANGE_BIT       &h0004
#define GL_MAP_INVALIDATE_BUFFER_BIT      &h0008
#define GL_MAP_FLUSH_EXPLICIT_BIT         &h0010
#define GL_MAP_UNSYNCHRONIZED_BIT         &h0020
#EndIf

#Ifndef GL_ARB_texture_buffer_object
#define GL_TEXTURE_BUFFER_ARB             &h8C2A
#define GL_MAX_TEXTURE_BUFFER_SIZE_ARB    &h8C2B
#define GL_TEXTURE_BINDING_BUFFER_ARB     &h8C2C
#define GL_TEXTURE_BUFFER_DATA_STORE_BINDING_ARB &h8C2D
#define GL_TEXTURE_BUFFER_FORMAT_ARB      &h8C2E
#EndIf

#Ifndef GL_ARB_texture_compression_rgtc
#define GL_COMPRESSED_RED_RGTC1           &h8DBB
#define GL_COMPRESSED_SIGNED_RED_RGTC1    &h8DBC
#define GL_COMPRESSED_RG_RGTC2            &h8DBD
#define GL_COMPRESSED_SIGNED_RG_RGTC2     &h8DBE
#EndIf

#Ifndef GL_ARB_texture_rg
#define GL_RG                             &h8227
#define GL_RG_INTEGER                     &h8228
#define GL_R8                             &h8229
#define GL_R16                            &h822A
#define GL_RG8                            &h822B
#define GL_RG16                           &h822C
#define GL_R16F                           &h822D
#define GL_R32F                           &h822E
#define GL_RG16F                          &h822F
#define GL_RG32F                          &h8230
#define GL_R8I                            &h8231
#define GL_R8UI                           &h8232
#define GL_R16I                           &h8233
#define GL_R16UI                          &h8234
#define GL_R32I                           &h8235
#define GL_R32UI                          &h8236
#define GL_RG8I                           &h8237
#define GL_RG8UI                          &h8238
#define GL_RG16I                          &h8239
#define GL_RG16UI                         &h823A
#define GL_RG32I                          &h823B
#define GL_RG32UI                         &h823C
#EndIf

#Ifndef GL_ARB_vertex_array_object
#define GL_VERTEX_ARRAY_BINDING           &h85B5
#EndIf

#Ifndef GL_ARB_uniform_buffer_object
#define GL_UNIFORM_BUFFER                 &h8A11
#define GL_UNIFORM_BUFFER_BINDING         &h8A28
#define GL_UNIFORM_BUFFER_START           &h8A29
#define GL_UNIFORM_BUFFER_SIZE            &h8A2A
#define GL_MAX_VERTEX_UNIFORM_BLOCKS      &h8A2B
#define GL_MAX_GEOMETRY_UNIFORM_BLOCKS    &h8A2C
#define GL_MAX_FRAGMENT_UNIFORM_BLOCKS    &h8A2D
#define GL_MAX_COMBINED_UNIFORM_BLOCKS    &h8A2E
#define GL_MAX_UNIFORM_BUFFER_BINDINGS    &h8A2F
#define GL_MAX_UNIFORM_BLOCK_SIZE         &h8A30
#define GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS &h8A31
#define GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS &h8A32
#define GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS &h8A33
#define GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT &h8A34
#define GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH &h8A35
#define GL_ACTIVE_UNIFORM_BLOCKS          &h8A36
#define GL_UNIFORM_TYPE                   &h8A37
#define GL_UNIFORM_SIZE                   &h8A38
#define GL_UNIFORM_NAME_LENGTH            &h8A39
#define GL_UNIFORM_BLOCK_INDEX            &h8A3A
#define GL_UNIFORM_OFFSET                 &h8A3B
#define GL_UNIFORM_ARRAY_STRIDE           &h8A3C
#define GL_UNIFORM_MATRIX_STRIDE          &h8A3D
#define GL_UNIFORM_IS_ROW_MAJOR           &h8A3E
#define GL_UNIFORM_BLOCK_BINDING          &h8A3F
#define GL_UNIFORM_BLOCK_DATA_SIZE        &h8A40
#define GL_UNIFORM_BLOCK_NAME_LENGTH      &h8A41
#define GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS  &h8A42
#define GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES &h8A43
#define GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER &h8A44
#define GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER &h8A45
#define GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER &h8A46
#define GL_INVALID_INDEX                  &hFFFFFFFFu
#EndIf

#Ifndef GL_ARB_compatibility
/' ARB_compatibility just defines tokens from core 3.0 '/
#EndIf

#Ifndef GL_ARB_copy_buffer
#define GL_COPY_READ_BUFFER               &h8F36
#define GL_COPY_WRITE_BUFFER              &h8F37
#EndIf

#Ifndef GL_ARB_shader_texture_lod
#EndIf

#Ifndef GL_ARB_depth_clamp
#define GL_DEPTH_CLAMP                    &h864F
#EndIf

#Ifndef GL_ARB_draw_elements_base_vertex
#EndIf

#Ifndef GL_ARB_fragment_coord_conventions
#EndIf

#Ifndef GL_ARB_provoking_vertex
#define GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION &h8E4C
#define GL_FIRST_VERTEX_CONVENTION        &h8E4D
#define GL_LAST_VERTEX_CONVENTION         &h8E4E
#define GL_PROVOKING_VERTEX               &h8E4F
#EndIf

#Ifndef GL_ARB_seamless_cube_map
#define GL_TEXTURE_CUBE_MAP_SEAMLESS      &h884F
#EndIf

#Ifndef GL_ARB_sync
#define GL_MAX_SERVER_WAIT_TIMEOUT        &h9111
#define GL_OBJECT_TYPE                    &h9112
#define GL_SYNC_CONDITION                 &h9113
#define GL_SYNC_STATUS                    &h9114
#define GL_SYNC_FLAGS                     &h9115
#define GL_SYNC_FENCE                     &h9116
#define GL_SYNC_GPU_COMMANDS_COMPLETE     &h9117
#define GL_UNSIGNALED                     &h9118
#define GL_SIGNALED                       &h9119
#define GL_ALREADY_SIGNALED               &h911A
#define GL_TIMEOUT_EXPIRED                &h911B
#define GL_CONDITION_SATISFIED            &h911C
#define GL_WAIT_FAILED                    &h911D
#define GL_SYNC_FLUSH_COMMANDS_BIT        &h00000001
#define GL_TIMEOUT_IGNORED                &hFFFFFFFFFFFFFFFFull
#EndIf

#Ifndef GL_ARB_texture_multisample
#define GL_SAMPLE_POSITION                &h8E50
#define GL_SAMPLE_MASK                    &h8E51
#define GL_SAMPLE_MASK_VALUE              &h8E52
#define GL_MAX_SAMPLE_MASK_WORDS          &h8E59
#define GL_TEXTURE_2D_MULTISAMPLE         &h9100
#define GL_PROXY_TEXTURE_2D_MULTISAMPLE   &h9101
#define GL_TEXTURE_2D_MULTISAMPLE_ARRAY   &h9102
#define GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY &h9103
#define GL_TEXTURE_BINDING_2D_MULTISAMPLE &h9104
#define GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY &h9105
#define GL_TEXTURE_SAMPLES                &h9106
#define GL_TEXTURE_FIXED_SAMPLE_LOCATIONS &h9107
#define GL_SAMPLER_2D_MULTISAMPLE         &h9108
#define GL_INT_SAMPLER_2D_MULTISAMPLE     &h9109
#define GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE &h910A
#define GL_SAMPLER_2D_MULTISAMPLE_ARRAY   &h910B
#define GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY &h910C
#define GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY &h910D
#define GL_MAX_COLOR_TEXTURE_SAMPLES      &h910E
#define GL_MAX_DEPTH_TEXTURE_SAMPLES      &h910F
#define GL_MAX_INTEGER_SAMPLES            &h9110
#EndIf

#Ifndef GL_ARB_vertex_array_bgra
/' reuse GL_BGRA '/
#EndIf

#Ifndef GL_ARB_draw_buffers_blend
#EndIf

#Ifndef GL_ARB_sample_shading
#define GL_SAMPLE_SHADING_ARB             &h8C36
#define GL_MIN_SAMPLE_SHADING_VALUE_ARB   &h8C37
#EndIf

#Ifndef GL_ARB_texture_cube_map_array
#define GL_TEXTURE_CUBE_MAP_ARRAY_ARB     &h9009
#define GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_ARB &h900A
#define GL_PROXY_TEXTURE_CUBE_MAP_ARRAY_ARB &h900B
#define GL_SAMPLER_CUBE_MAP_ARRAY_ARB     &h900C
#define GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW_ARB &h900D
#define GL_INT_SAMPLER_CUBE_MAP_ARRAY_ARB &h900E
#define GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_ARB &h900F
#EndIf

#Ifndef GL_ARB_texture_gather
#define GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_ARB &h8E5E
#define GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_ARB &h8E5F
#EndIf

#Ifndef GL_ARB_texture_query_lod
#EndIf

#Ifndef GL_ARB_shading_language_include
#define GL_SHADER_INCLUDE_ARB             &h8DAE
#define GL_NAMED_STRING_LENGTH_ARB        &h8DE9
#define GL_NAMED_STRING_TYPE_ARB          &h8DEA
#EndIf

#Ifndef GL_ARB_texture_compression_bptc
#define GL_COMPRESSED_RGBA_BPTC_UNORM_ARB &h8E8C
#define GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB &h8E8D
#define GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB &h8E8E
#define GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB &h8E8F
#EndIf

#Ifndef GL_ARB_blend_func_extended
#define GL_SRC1_COLOR                     &h88F9
/' reuse GL_SRC1_ALPHA '/
#define GL_ONE_MINUS_SRC1_COLOR           &h88FA
#define GL_ONE_MINUS_SRC1_ALPHA           &h88FB
#define GL_MAX_DUAL_SOURCE_DRAW_BUFFERS   &h88FC
#EndIf

#Ifndef GL_ARB_explicit_attrib_location
#EndIf

#Ifndef GL_ARB_occlusion_query2
#define GL_ANY_SAMPLES_PASSED             &h8C2F
#EndIf

#Ifndef GL_ARB_sampler_objects
#define GL_SAMPLER_BINDING                &h8919
#EndIf

#Ifndef GL_ARB_shader_bit_encoding
#EndIf

#Ifndef GL_ARB_texture_rgb10_a2ui
#define GL_RGB10_A2UI                     &h906F
#EndIf

#Ifndef GL_ARB_texture_swizzle
#define GL_TEXTURE_SWIZZLE_R              &h8E42
#define GL_TEXTURE_SWIZZLE_G              &h8E43
#define GL_TEXTURE_SWIZZLE_B              &h8E44
#define GL_TEXTURE_SWIZZLE_A              &h8E45
#define GL_TEXTURE_SWIZZLE_RGBA           &h8E46
#EndIf

#Ifndef GL_ARB_timer_query
#define GL_TIME_ELAPSED                   &h88BF
#define GL_TIMESTAMP                      &h8E28
#EndIf

#Ifndef GL_ARB_vertex_type_2_10_10_10_rev
/' reuse GL_UNSIGNED_INT_2_10_10_10_REV '/
#define GL_INT_2_10_10_10_REV             &h8D9F
#EndIf

#Ifndef GL_ARB_draw_indirect
#define GL_DRAW_INDIRECT_BUFFER           &h8F3F
#define GL_DRAW_INDIRECT_BUFFER_BINDING   &h8F43
#EndIf

#Ifndef GL_ARB_gpu_shader5
#define GL_GEOMETRY_SHADER_INVOCATIONS    &h887F
#define GL_MAX_GEOMETRY_SHADER_INVOCATIONS &h8E5A
#define GL_MIN_FRAGMENT_INTERPOLATION_OFFSET &h8E5B
#define GL_MAX_FRAGMENT_INTERPOLATION_OFFSET &h8E5C
#define GL_FRAGMENT_INTERPOLATION_OFFSET_BITS &h8E5D
/' reuse GL_MAX_VERTEX_STREAMS '/
#EndIf

#Ifndef GL_ARB_gpu_shader_fp64
/' reuse GL_DOUBLE '/
#define GL_DOUBLE_VEC2                    &h8FFC
#define GL_DOUBLE_VEC3                    &h8FFD
#define GL_DOUBLE_VEC4                    &h8FFE
#define GL_DOUBLE_MAT2                    &h8F46
#define GL_DOUBLE_MAT3                    &h8F47
#define GL_DOUBLE_MAT4                    &h8F48
#define GL_DOUBLE_MAT2x3                  &h8F49
#define GL_DOUBLE_MAT2x4                  &h8F4A
#define GL_DOUBLE_MAT3x2                  &h8F4B
#define GL_DOUBLE_MAT3x4                  &h8F4C
#define GL_DOUBLE_MAT4x2                  &h8F4D
#define GL_DOUBLE_MAT4x3                  &h8F4E
#EndIf

#Ifndef GL_ARB_shader_subroutine
#define GL_ACTIVE_SUBROUTINES             &h8DE5
#define GL_ACTIVE_SUBROUTINE_UNIFORMS     &h8DE6
#define GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS &h8E47
#define GL_ACTIVE_SUBROUTINE_MAX_LENGTH   &h8E48
#define GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH &h8E49
#define GL_MAX_SUBROUTINES                &h8DE7
#define GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS &h8DE8
#define GL_NUM_COMPATIBLE_SUBROUTINES     &h8E4A
#define GL_COMPATIBLE_SUBROUTINES         &h8E4B
/' reuse GL_UNIFORM_SIZE '/
/' reuse GL_UNIFORM_NAME_LENGTH '/
#EndIf

#Ifndef GL_ARB_tessellation_shader
#define GL_PATCHES                        &h000E
#define GL_PATCH_VERTICES                 &h8E72
#define GL_PATCH_DEFAULT_INNER_LEVEL      &h8E73
#define GL_PATCH_DEFAULT_OUTER_LEVEL      &h8E74
#define GL_TESS_CONTROL_OUTPUT_VERTICES   &h8E75
#define GL_TESS_GEN_MODE                  &h8E76
#define GL_TESS_GEN_SPACING               &h8E77
#define GL_TESS_GEN_VERTEX_ORDER          &h8E78
#define GL_TESS_GEN_POINT_MODE            &h8E79
/' reuse GL_TRIANGLES '/
/' reuse GL_QUADS '/
#define GL_ISOLINES                       &h8E7A
/' reuse GL_EQUAL '/
#define GL_FRACTIONAL_ODD                 &h8E7B
#define GL_FRACTIONAL_EVEN                &h8E7C
/' reuse GL_CCW '/
/' reuse GL_CW '/
#define GL_MAX_PATCH_VERTICES             &h8E7D
#define GL_MAX_TESS_GEN_LEVEL             &h8E7E
#define GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS &h8E7F
#define GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS &h8E80
#define GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS &h8E81
#define GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS &h8E82
#define GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS &h8E83
#define GL_MAX_TESS_PATCH_COMPONENTS      &h8E84
#define GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS &h8E85
#define GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS &h8E86
#define GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS &h8E89
#define GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS &h8E8A
#define GL_MAX_TESS_CONTROL_INPUT_COMPONENTS &h886C
#define GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS &h886D
#define GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS &h8E1E
#define GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS &h8E1F
#define GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER &h84F0
#define GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER &h84F1
#define GL_TESS_EVALUATION_SHADER         &h8E87
#define GL_TESS_CONTROL_SHADER            &h8E88
#EndIf

#Ifndef GL_ARB_texture_buffer_object_rgb32
/' reuse GL_RGB32F '/
/' reuse GL_RGB32UI '/
/' reuse GL_RGB32I '/
#EndIf

#Ifndef GL_ARB_transform_feedback2
#define GL_TRANSFORM_FEEDBACK             &h8E22
#define GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED &h8E23
#define GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE &h8E24
#define GL_TRANSFORM_FEEDBACK_BINDING     &h8E25
#EndIf

#Ifndef GL_ARB_transform_feedback3
#define GL_MAX_TRANSFORM_FEEDBACK_BUFFERS &h8E70
#define GL_MAX_VERTEX_STREAMS             &h8E71
#EndIf

#Ifndef GL_ARB_ES2_compatibility
#define GL_FIXED                          &h140C
#define GL_IMPLEMENTATION_COLOR_READ_TYPE &h8B9A
#define GL_IMPLEMENTATION_COLOR_READ_FORMAT &h8B9B
#define GL_LOW_FLOAT                      &h8DF0
#define GL_MEDIUM_FLOAT                   &h8DF1
#define GL_HIGH_FLOAT                     &h8DF2
#define GL_LOW_INT                        &h8DF3
#define GL_MEDIUM_INT                     &h8DF4
#define GL_HIGH_INT                       &h8DF5
#define GL_SHADER_COMPILER                &h8DFA
#define GL_NUM_SHADER_BINARY_FORMATS      &h8DF9
#define GL_MAX_VERTEX_UNIFORM_VECTORS     &h8DFB
#define GL_MAX_VARYING_VECTORS            &h8DFC
#define GL_MAX_FRAGMENT_UNIFORM_VECTORS   &h8DFD
#EndIf

#Ifndef GL_ARB_get_program_binary
#define GL_PROGRAM_BINARY_RETRIEVABLE_HINT &h8257
#define GL_PROGRAM_BINARY_LENGTH          &h8741
#define GL_NUM_PROGRAM_BINARY_FORMATS     &h87FE
#define GL_PROGRAM_BINARY_FORMATS         &h87FF
#EndIf

#Ifndef GL_ARB_separate_shader_objects
#define GL_VERTEX_SHADER_BIT              &h00000001
#define GL_FRAGMENT_SHADER_BIT            &h00000002
#define GL_GEOMETRY_SHADER_BIT            &h00000004
#define GL_TESS_CONTROL_SHADER_BIT        &h00000008
#define GL_TESS_EVALUATION_SHADER_BIT     &h00000010
#define GL_ALL_SHADER_BITS                &hFFFFFFFF
#define GL_PROGRAM_SEPARABLE              &h8258
#define GL_ACTIVE_PROGRAM                 &h8259
#define GL_PROGRAM_PIPELINE_BINDING       &h825A
#EndIf

#Ifndef GL_ARB_shader_precision
#EndIf

#Ifndef GL_ARB_vertex_attrib_64bit
/' reuse GL_RGB32I '/
/' reuse GL_DOUBLE_VEC2 '/
/' reuse GL_DOUBLE_VEC3 '/
/' reuse GL_DOUBLE_VEC4 '/
/' reuse GL_DOUBLE_MAT2 '/
/' reuse GL_DOUBLE_MAT3 '/
/' reuse GL_DOUBLE_MAT4 '/
/' reuse GL_DOUBLE_MAT2x3 '/
/' reuse GL_DOUBLE_MAT2x4 '/
/' reuse GL_DOUBLE_MAT3x2 '/
/' reuse GL_DOUBLE_MAT3x4 '/
/' reuse GL_DOUBLE_MAT4x2 '/
/' reuse GL_DOUBLE_MAT4x3 '/
#EndIf

#Ifndef GL_ARB_viewport_array
/' reuse GL_SCISSOR_BOX '/
/' reuse GL_VIEWPORT '/
/' reuse GL_DEPTH_RANGE '/
/' reuse GL_SCISSOR_TEST '/
#define GL_MAX_VIEWPORTS                  &h825B
#define GL_VIEWPORT_SUBPIXEL_BITS         &h825C
#define GL_VIEWPORT_BOUNDS_RANGE          &h825D
#define GL_LAYER_PROVOKING_VERTEX         &h825E
#define GL_VIEWPORT_INDEX_PROVOKING_VERTEX &h825F
#define GL_UNDEFINED_VERTEX               &h8260
/' reuse GL_FIRST_VERTEX_CONVENTION '/
/' reuse GL_LAST_VERTEX_CONVENTION '/
/' reuse GL_PROVOKING_VERTEX '/
#EndIf

#Ifndef GL_ARB_cl_event
#define GL_SYNC_CL_EVENT_ARB              &h8240
#define GL_SYNC_CL_EVENT_COMPLETE_ARB     &h8241
#EndIf

#Ifndef GL_ARB_debug_output
#define GL_DEBUG_OUTPUT_SYNCHRONOUS_ARB   &h8242
#define GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH_ARB &h8243
#define GL_DEBUG_CALLBACK_FUNCTION_ARB    &h8244
#define GL_DEBUG_CALLBACK_USER_PARAM_ARB  &h8245
#define GL_DEBUG_SOURCE_API_ARB           &h8246
#define GL_DEBUG_SOURCE_WINDOW_SYSTEM_ARB &h8247
#define GL_DEBUG_SOURCE_SHADER_COMPILER_ARB &h8248
#define GL_DEBUG_SOURCE_THIRD_PARTY_ARB   &h8249
#define GL_DEBUG_SOURCE_APPLICATION_ARB   &h824A
#define GL_DEBUG_SOURCE_OTHER_ARB         &h824B
#define GL_DEBUG_TYPE_ERROR_ARB           &h824C
#define GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB &h824D
#define GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB &h824E
#define GL_DEBUG_TYPE_PORTABILITY_ARB     &h824F
#define GL_DEBUG_TYPE_PERFORMANCE_ARB     &h8250
#define GL_DEBUG_TYPE_OTHER_ARB           &h8251
#define GL_MAX_DEBUG_MESSAGE_LENGTH_ARB   &h9143
#define GL_MAX_DEBUG_LOGGED_MESSAGES_ARB  &h9144
#define GL_DEBUG_LOGGED_MESSAGES_ARB      &h9145
#define GL_DEBUG_SEVERITY_HIGH_ARB        &h9146
#define GL_DEBUG_SEVERITY_MEDIUM_ARB      &h9147
#define GL_DEBUG_SEVERITY_LOW_ARB         &h9148
#EndIf

#Ifndef GL_ARB_robustness
/' reuse GL_NO_ERROR '/
#define GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT_ARB &h00000004
#define GL_LOSE_CONTEXT_ON_RESET_ARB      &h8252
#define GL_GUILTY_CONTEXT_RESET_ARB       &h8253
#define GL_INNOCENT_CONTEXT_RESET_ARB     &h8254
#define GL_UNKNOWN_CONTEXT_RESET_ARB      &h8255
#define GL_RESET_NOTIFICATION_STRATEGY_ARB &h8256
#define GL_NO_RESET_NOTIFICATION_ARB      &h8261
#EndIf

#Ifndef GL_ARB_shader_stencil_export
#EndIf

#Ifndef GL_ARB_base_instance
#EndIf

#Ifndef GL_ARB_shading_language_420pack
#EndIf

#Ifndef GL_ARB_transform_feedback_instanced
#EndIf

#Ifndef GL_ARB_compressed_texture_pixel_storage
#define GL_UNPACK_COMPRESSED_BLOCK_WIDTH  &h9127
#define GL_UNPACK_COMPRESSED_BLOCK_HEIGHT &h9128
#define GL_UNPACK_COMPRESSED_BLOCK_DEPTH  &h9129
#define GL_UNPACK_COMPRESSED_BLOCK_SIZE   &h912A
#define GL_PACK_COMPRESSED_BLOCK_WIDTH    &h912B
#define GL_PACK_COMPRESSED_BLOCK_HEIGHT   &h912C
#define GL_PACK_COMPRESSED_BLOCK_DEPTH    &h912D
#define GL_PACK_COMPRESSED_BLOCK_SIZE     &h912E
#EndIf

#Ifndef GL_ARB_conservative_depth
#EndIf

#Ifndef GL_ARB_internalformat_query
#define GL_NUM_SAMPLE_COUNTS              &h9380
#EndIf

#Ifndef GL_ARB_map_buffer_alignment
#define GL_MIN_MAP_BUFFER_ALIGNMENT       &h90BC
#EndIf

#Ifndef GL_ARB_shader_atomic_counters
#define GL_ATOMIC_COUNTER_BUFFER          &h92C0
#define GL_ATOMIC_COUNTER_BUFFER_BINDING  &h92C1
#define GL_ATOMIC_COUNTER_BUFFER_START    &h92C2
#define GL_ATOMIC_COUNTER_BUFFER_SIZE     &h92C3
#define GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE &h92C4
#define GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS &h92C5
#define GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES &h92C6
#define GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER &h92C7
#define GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER &h92C8
#define GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER &h92C9
#define GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER &h92CA
#define GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER &h92CB
#define GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS &h92CC
#define GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS &h92CD
#define GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS &h92CE
#define GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS &h92CF
#define GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS &h92D0
#define GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS &h92D1
#define GL_MAX_VERTEX_ATOMIC_COUNTERS     &h92D2
#define GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS &h92D3
#define GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS &h92D4
#define GL_MAX_GEOMETRY_ATOMIC_COUNTERS   &h92D5
#define GL_MAX_FRAGMENT_ATOMIC_COUNTERS   &h92D6
#define GL_MAX_COMBINED_ATOMIC_COUNTERS   &h92D7
#define GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE &h92D8
#define GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS &h92DC
#define GL_ACTIVE_ATOMIC_COUNTER_BUFFERS  &h92D9
#define GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX &h92DA
#define GL_UNSIGNED_INT_ATOMIC_COUNTER    &h92DB
#EndIf

#Ifndef GL_ARB_shader_image_load_store
#define GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT &h00000001
#define GL_ELEMENT_ARRAY_BARRIER_BIT      &h00000002
#define GL_UNIFORM_BARRIER_BIT            &h00000004
#define GL_TEXTURE_FETCH_BARRIER_BIT      &h00000008
#define GL_SHADER_IMAGE_ACCESS_BARRIER_BIT &h00000020
#define GL_COMMAND_BARRIER_BIT            &h00000040
#define GL_PIXEL_BUFFER_BARRIER_BIT       &h00000080
#define GL_TEXTURE_UPDATE_BARRIER_BIT     &h00000100
#define GL_BUFFER_UPDATE_BARRIER_BIT      &h00000200
#define GL_FRAMEBUFFER_BARRIER_BIT        &h00000400
#define GL_TRANSFORM_FEEDBACK_BARRIER_BIT &h00000800
#define GL_ATOMIC_COUNTER_BARRIER_BIT     &h00001000
#define GL_ALL_BARRIER_BITS               &hFFFFFFFF
#define GL_MAX_IMAGE_UNITS                &h8F38
#define GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS &h8F39
#define GL_IMAGE_BINDING_NAME             &h8F3A
#define GL_IMAGE_BINDING_LEVEL            &h8F3B
#define GL_IMAGE_BINDING_LAYERED          &h8F3C
#define GL_IMAGE_BINDING_LAYER            &h8F3D
#define GL_IMAGE_BINDING_ACCESS           &h8F3E
#define GL_IMAGE_1D                       &h904C
#define GL_IMAGE_2D                       &h904D
#define GL_IMAGE_3D                       &h904E
#define GL_IMAGE_2D_RECT                  &h904F
#define GL_IMAGE_CUBE                     &h9050
#define GL_IMAGE_BUFFER                   &h9051
#define GL_IMAGE_1D_ARRAY                 &h9052
#define GL_IMAGE_2D_ARRAY                 &h9053
#define GL_IMAGE_CUBE_MAP_ARRAY           &h9054
#define GL_IMAGE_2D_MULTISAMPLE           &h9055
#define GL_IMAGE_2D_MULTISAMPLE_ARRAY     &h9056
#define GL_INT_IMAGE_1D                   &h9057
#define GL_INT_IMAGE_2D                   &h9058
#define GL_INT_IMAGE_3D                   &h9059
#define GL_INT_IMAGE_2D_RECT              &h905A
#define GL_INT_IMAGE_CUBE                 &h905B
#define GL_INT_IMAGE_BUFFER               &h905C
#define GL_INT_IMAGE_1D_ARRAY             &h905D
#define GL_INT_IMAGE_2D_ARRAY             &h905E
#define GL_INT_IMAGE_CUBE_MAP_ARRAY       &h905F
#define GL_INT_IMAGE_2D_MULTISAMPLE       &h9060
#define GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY &h9061
#define GL_UNSIGNED_INT_IMAGE_1D          &h9062
#define GL_UNSIGNED_INT_IMAGE_2D          &h9063
#define GL_UNSIGNED_INT_IMAGE_3D          &h9064
#define GL_UNSIGNED_INT_IMAGE_2D_RECT     &h9065
#define GL_UNSIGNED_INT_IMAGE_CUBE        &h9066
#define GL_UNSIGNED_INT_IMAGE_BUFFER      &h9067
#define GL_UNSIGNED_INT_IMAGE_1D_ARRAY    &h9068
#define GL_UNSIGNED_INT_IMAGE_2D_ARRAY    &h9069
#define GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY &h906A
#define GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE &h906B
#define GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY &h906C
#define GL_MAX_IMAGE_SAMPLES              &h906D
#define GL_IMAGE_BINDING_FORMAT           &h906E
#define GL_IMAGE_FORMAT_COMPATIBILITY_TYPE &h90C7
#define GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE &h90C8
#define GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS &h90C9
#define GL_MAX_VERTEX_IMAGE_UNIFORMS      &h90CA
#define GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS &h90CB
#define GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS &h90CC
#define GL_MAX_GEOMETRY_IMAGE_UNIFORMS    &h90CD
#define GL_MAX_FRAGMENT_IMAGE_UNIFORMS    &h90CE
#define GL_MAX_COMBINED_IMAGE_UNIFORMS    &h90CF
#EndIf

#Ifndef GL_ARB_shading_language_packing
#EndIf

#Ifndef GL_ARB_texture_storage
#define GL_TEXTURE_IMMUTABLE_FORMAT       &h912F
#EndIf

#Ifndef GL_EXT_abgr
#define GL_ABGR_EXT                       &h8000
#EndIf

#Ifndef GL_EXT_blend_color
#define GL_CONSTANT_COLOR_EXT             &h8001
#define GL_ONE_MINUS_CONSTANT_COLOR_EXT   &h8002
#define GL_CONSTANT_ALPHA_EXT             &h8003
#define GL_ONE_MINUS_CONSTANT_ALPHA_EXT   &h8004
#define GL_BLEND_COLOR_EXT                &h8005
#EndIf

#Ifndef GL_EXT_polygon_offset
#define GL_POLYGON_OFFSET_EXT             &h8037
#define GL_POLYGON_OFFSET_FACTOR_EXT      &h8038
#define GL_POLYGON_OFFSET_BIAS_EXT        &h8039
#EndIf

#Ifndef GL_EXT_texture
#define GL_ALPHA4_EXT                     &h803B
#define GL_ALPHA8_EXT                     &h803C
#define GL_ALPHA12_EXT                    &h803D
#define GL_ALPHA16_EXT                    &h803E
#define GL_LUMINANCE4_EXT                 &h803F
#define GL_LUMINANCE8_EXT                 &h8040
#define GL_LUMINANCE12_EXT                &h8041
#define GL_LUMINANCE16_EXT                &h8042
#define GL_LUMINANCE4_ALPHA4_EXT          &h8043
#define GL_LUMINANCE6_ALPHA2_EXT          &h8044
#define GL_LUMINANCE8_ALPHA8_EXT          &h8045
#define GL_LUMINANCE12_ALPHA4_EXT         &h8046
#define GL_LUMINANCE12_ALPHA12_EXT        &h8047
#define GL_LUMINANCE16_ALPHA16_EXT        &h8048
#define GL_INTENSITY_EXT                  &h8049
#define GL_INTENSITY4_EXT                 &h804A
#define GL_INTENSITY8_EXT                 &h804B
#define GL_INTENSITY12_EXT                &h804C
#define GL_INTENSITY16_EXT                &h804D
#define GL_RGB2_EXT                       &h804E
#define GL_RGB4_EXT                       &h804F
#define GL_RGB5_EXT                       &h8050
#define GL_RGB8_EXT                       &h8051
#define GL_RGB10_EXT                      &h8052
#define GL_RGB12_EXT                      &h8053
#define GL_RGB16_EXT                      &h8054
#define GL_RGBA2_EXT                      &h8055
#define GL_RGBA4_EXT                      &h8056
#define GL_RGB5_A1_EXT                    &h8057
#define GL_RGBA8_EXT                      &h8058
#define GL_RGB10_A2_EXT                   &h8059
#define GL_RGBA12_EXT                     &h805A
#define GL_RGBA16_EXT                     &h805B
#define GL_TEXTURE_RED_SIZE_EXT           &h805C
#define GL_TEXTURE_GREEN_SIZE_EXT         &h805D
#define GL_TEXTURE_BLUE_SIZE_EXT          &h805E
#define GL_TEXTURE_ALPHA_SIZE_EXT         &h805F
#define GL_TEXTURE_LUMINANCE_SIZE_EXT     &h8060
#define GL_TEXTURE_INTENSITY_SIZE_EXT     &h8061
#define GL_REPLACE_EXT                    &h8062
#define GL_PROXY_TEXTURE_1D_EXT           &h8063
#define GL_PROXY_TEXTURE_2D_EXT           &h8064
#define GL_TEXTURE_TOO_LARGE_EXT          &h8065
#EndIf

#Ifndef GL_EXT_texture3D
#define GL_PACK_SKIP_IMAGES_EXT           &h806B
#define GL_PACK_IMAGE_HEIGHT_EXT          &h806C
#define GL_UNPACK_SKIP_IMAGES_EXT         &h806D
#define GL_UNPACK_IMAGE_HEIGHT_EXT        &h806E
#define GL_TEXTURE_3D_EXT                 &h806F
#define GL_PROXY_TEXTURE_3D_EXT           &h8070
#define GL_TEXTURE_DEPTH_EXT              &h8071
#define GL_TEXTURE_WRAP_R_EXT             &h8072
#define GL_MAX_3D_TEXTURE_SIZE_EXT        &h8073
#EndIf

#Ifndef GL_SGIS_texture_filter4
#define GL_FILTER4_SGIS                   &h8146
#define GL_TEXTURE_FILTER4_SIZE_SGIS      &h8147
#EndIf

#Ifndef GL_EXT_subtexture
#EndIf

#Ifndef GL_EXT_copy_texture
#EndIf

#Ifndef GL_EXT_histogram
#define GL_HISTOGRAM_EXT                  &h8024
#define GL_PROXY_HISTOGRAM_EXT            &h8025
#define GL_HISTOGRAM_WIDTH_EXT            &h8026
#define GL_HISTOGRAM_FORMAT_EXT           &h8027
#define GL_HISTOGRAM_RED_SIZE_EXT         &h8028
#define GL_HISTOGRAM_GREEN_SIZE_EXT       &h8029
#define GL_HISTOGRAM_BLUE_SIZE_EXT        &h802A
#define GL_HISTOGRAM_ALPHA_SIZE_EXT       &h802B
#define GL_HISTOGRAM_LUMINANCE_SIZE_EXT   &h802C
#define GL_HISTOGRAM_SINK_EXT             &h802D
#define GL_MINMAX_EXT                     &h802E
#define GL_MINMAX_FORMAT_EXT              &h802F
#define GL_MINMAX_SINK_EXT                &h8030
#define GL_TABLE_TOO_LARGE_EXT            &h8031
#EndIf

#Ifndef GL_EXT_convolution
#define GL_CONVOLUTION_1D_EXT             &h8010
#define GL_CONVOLUTION_2D_EXT             &h8011
#define GL_SEPARABLE_2D_EXT               &h8012
#define GL_CONVOLUTION_BORDER_MODE_EXT    &h8013
#define GL_CONVOLUTION_FILTER_SCALE_EXT   &h8014
#define GL_CONVOLUTION_FILTER_BIAS_EXT    &h8015
#define GL_REDUCE_EXT                     &h8016
#define GL_CONVOLUTION_FORMAT_EXT         &h8017
#define GL_CONVOLUTION_WIDTH_EXT          &h8018
#define GL_CONVOLUTION_HEIGHT_EXT         &h8019
#define GL_MAX_CONVOLUTION_WIDTH_EXT      &h801A
#define GL_MAX_CONVOLUTION_HEIGHT_EXT     &h801B
#define GL_POST_CONVOLUTION_RED_SCALE_EXT &h801C
#define GL_POST_CONVOLUTION_GREEN_SCALE_EXT &h801D
#define GL_POST_CONVOLUTION_BLUE_SCALE_EXT &h801E
#define GL_POST_CONVOLUTION_ALPHA_SCALE_EXT &h801F
#define GL_POST_CONVOLUTION_RED_BIAS_EXT  &h8020
#define GL_POST_CONVOLUTION_GREEN_BIAS_EXT &h8021
#define GL_POST_CONVOLUTION_BLUE_BIAS_EXT &h8022
#define GL_POST_CONVOLUTION_ALPHA_BIAS_EXT &h8023
#EndIf

#Ifndef GL_SGI_color_matrix
#define GL_COLOR_MATRIX_SGI               &h80B1
#define GL_COLOR_MATRIX_STACK_DEPTH_SGI   &h80B2
#define GL_MAX_COLOR_MATRIX_STACK_DEPTH_SGI &h80B3
#define GL_POST_COLOR_MATRIX_RED_SCALE_SGI &h80B4
#define GL_POST_COLOR_MATRIX_GREEN_SCALE_SGI &h80B5
#define GL_POST_COLOR_MATRIX_BLUE_SCALE_SGI &h80B6
#define GL_POST_COLOR_MATRIX_ALPHA_SCALE_SGI &h80B7
#define GL_POST_COLOR_MATRIX_RED_BIAS_SGI &h80B8
#define GL_POST_COLOR_MATRIX_GREEN_BIAS_SGI &h80B9
#define GL_POST_COLOR_MATRIX_BLUE_BIAS_SGI &h80BA
#define GL_POST_COLOR_MATRIX_ALPHA_BIAS_SGI &h80BB
#EndIf

#Ifndef GL_SGI_color_table
#define GL_COLOR_TABLE_SGI                &h80D0
#define GL_POST_CONVOLUTION_COLOR_TABLE_SGI &h80D1
#define GL_POST_COLOR_MATRIX_COLOR_TABLE_SGI &h80D2
#define GL_PROXY_COLOR_TABLE_SGI          &h80D3
#define GL_PROXY_POST_CONVOLUTION_COLOR_TABLE_SGI &h80D4
#define GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE_SGI &h80D5
#define GL_COLOR_TABLE_SCALE_SGI          &h80D6
#define GL_COLOR_TABLE_BIAS_SGI           &h80D7
#define GL_COLOR_TABLE_FORMAT_SGI         &h80D8
#define GL_COLOR_TABLE_WIDTH_SGI          &h80D9
#define GL_COLOR_TABLE_RED_SIZE_SGI       &h80DA
#define GL_COLOR_TABLE_GREEN_SIZE_SGI     &h80DB
#define GL_COLOR_TABLE_BLUE_SIZE_SGI      &h80DC
#define GL_COLOR_TABLE_ALPHA_SIZE_SGI     &h80DD
#define GL_COLOR_TABLE_LUMINANCE_SIZE_SGI &h80DE
#define GL_COLOR_TABLE_INTENSITY_SIZE_SGI &h80DF
#EndIf

#Ifndef GL_SGIS_pixel_texture
#define GL_PIXEL_TEXTURE_SGIS             &h8353
#define GL_PIXEL_FRAGMENT_RGB_SOURCE_SGIS &h8354
#define GL_PIXEL_FRAGMENT_ALPHA_SOURCE_SGIS &h8355
#define GL_PIXEL_GROUP_COLOR_SGIS         &h8356
#EndIf

#Ifndef GL_SGIX_pixel_texture
#define GL_PIXEL_TEX_GEN_SGIX             &h8139
#define GL_PIXEL_TEX_GEN_MODE_SGIX        &h832B
#EndIf

#Ifndef GL_SGIS_texture4D
#define GL_PACK_SKIP_VOLUMES_SGIS         &h8130
#define GL_PACK_IMAGE_DEPTH_SGIS          &h8131
#define GL_UNPACK_SKIP_VOLUMES_SGIS       &h8132
#define GL_UNPACK_IMAGE_DEPTH_SGIS        &h8133
#define GL_TEXTURE_4D_SGIS                &h8134
#define GL_PROXY_TEXTURE_4D_SGIS          &h8135
#define GL_TEXTURE_4DSIZE_SGIS            &h8136
#define GL_TEXTURE_WRAP_Q_SGIS            &h8137
#define GL_MAX_4D_TEXTURE_SIZE_SGIS       &h8138
#define GL_TEXTURE_4D_BINDING_SGIS        &h814F
#EndIf

#Ifndef GL_SGI_texture_color_table
#define GL_TEXTURE_COLOR_TABLE_SGI        &h80BC
#define GL_PROXY_TEXTURE_COLOR_TABLE_SGI  &h80BD
#EndIf

#Ifndef GL_EXT_cmyka
#define GL_CMYK_EXT                       &h800C
#define GL_CMYKA_EXT                      &h800D
#define GL_PACK_CMYK_HINT_EXT             &h800E
#define GL_UNPACK_CMYK_HINT_EXT           &h800F
#EndIf

#Ifndef GL_EXT_texture_object
#define GL_TEXTURE_PRIORITY_EXT           &h8066
#define GL_TEXTURE_RESIDENT_EXT           &h8067
#define GL_TEXTURE_1D_BINDING_EXT         &h8068
#define GL_TEXTURE_2D_BINDING_EXT         &h8069
#define GL_TEXTURE_3D_BINDING_EXT         &h806A
#EndIf

#Ifndef GL_SGIS_detail_texture
#define GL_DETAIL_TEXTURE_2D_SGIS         &h8095
#define GL_DETAIL_TEXTURE_2D_BINDING_SGIS &h8096
#define GL_LINEAR_DETAIL_SGIS             &h8097
#define GL_LINEAR_DETAIL_ALPHA_SGIS       &h8098
#define GL_LINEAR_DETAIL_COLOR_SGIS       &h8099
#define GL_DETAIL_TEXTURE_LEVEL_SGIS      &h809A
#define GL_DETAIL_TEXTURE_MODE_SGIS       &h809B
#define GL_DETAIL_TEXTURE_FUNC_POINTS_SGIS &h809C
#EndIf

#Ifndef GL_SGIS_sharpen_texture
#define GL_LINEAR_SHARPEN_SGIS            &h80AD
#define GL_LINEAR_SHARPEN_ALPHA_SGIS      &h80AE
#define GL_LINEAR_SHARPEN_COLOR_SGIS      &h80AF
#define GL_SHARPEN_TEXTURE_FUNC_POINTS_SGIS &h80B0
#EndIf

#Ifndef GL_EXT_packed_pixels
#define GL_UNSIGNED_BYTE_3_3_2_EXT        &h8032
#define GL_UNSIGNED_SHORT_4_4_4_4_EXT     &h8033
#define GL_UNSIGNED_SHORT_5_5_5_1_EXT     &h8034
#define GL_UNSIGNED_INT_8_8_8_8_EXT       &h8035
#define GL_UNSIGNED_INT_10_10_10_2_EXT    &h8036
#EndIf

#Ifndef GL_SGIS_texture_lod
#define GL_TEXTURE_MIN_LOD_SGIS           &h813A
#define GL_TEXTURE_MAX_LOD_SGIS           &h813B
#define GL_TEXTURE_BASE_LEVEL_SGIS        &h813C
#define GL_TEXTURE_MAX_LEVEL_SGIS         &h813D
#EndIf

#Ifndef GL_SGIS_multisample
#define GL_MULTISAMPLE_SGIS               &h809D
#define GL_SAMPLE_ALPHA_TO_MASK_SGIS      &h809E
#define GL_SAMPLE_ALPHA_TO_ONE_SGIS       &h809F
#define GL_SAMPLE_MASK_SGIS               &h80A0
#define GL_1PASS_SGIS                     &h80A1
#define GL_2PASS_0_SGIS                   &h80A2
#define GL_2PASS_1_SGIS                   &h80A3
#define GL_4PASS_0_SGIS                   &h80A4
#define GL_4PASS_1_SGIS                   &h80A5
#define GL_4PASS_2_SGIS                   &h80A6
#define GL_4PASS_3_SGIS                   &h80A7
#define GL_SAMPLE_BUFFERS_SGIS            &h80A8
#define GL_SAMPLES_SGIS                   &h80A9
#define GL_SAMPLE_MASK_VALUE_SGIS         &h80AA
#define GL_SAMPLE_MASK_INVERT_SGIS        &h80AB
#define GL_SAMPLE_PATTERN_SGIS            &h80AC
#EndIf

#Ifndef GL_EXT_rescale_normal
#define GL_RESCALE_NORMAL_EXT             &h803A
#EndIf

#Ifndef GL_EXT_vertex_array
#define GL_VERTEX_ARRAY_EXT               &h8074
#define GL_NORMAL_ARRAY_EXT               &h8075
#define GL_COLOR_ARRAY_EXT                &h8076
#define GL_INDEX_ARRAY_EXT                &h8077
#define GL_TEXTURE_COORD_ARRAY_EXT        &h8078
#define GL_EDGE_FLAG_ARRAY_EXT            &h8079
#define GL_VERTEX_ARRAY_SIZE_EXT          &h807A
#define GL_VERTEX_ARRAY_TYPE_EXT          &h807B
#define GL_VERTEX_ARRAY_STRIDE_EXT        &h807C
#define GL_VERTEX_ARRAY_COUNT_EXT         &h807D
#define GL_NORMAL_ARRAY_TYPE_EXT          &h807E
#define GL_NORMAL_ARRAY_STRIDE_EXT        &h807F
#define GL_NORMAL_ARRAY_COUNT_EXT         &h8080
#define GL_COLOR_ARRAY_SIZE_EXT           &h8081
#define GL_COLOR_ARRAY_TYPE_EXT           &h8082
#define GL_COLOR_ARRAY_STRIDE_EXT         &h8083
#define GL_COLOR_ARRAY_COUNT_EXT          &h8084
#define GL_INDEX_ARRAY_TYPE_EXT           &h8085
#define GL_INDEX_ARRAY_STRIDE_EXT         &h8086
#define GL_INDEX_ARRAY_COUNT_EXT          &h8087
#define GL_TEXTURE_COORD_ARRAY_SIZE_EXT   &h8088
#define GL_TEXTURE_COORD_ARRAY_TYPE_EXT   &h8089
#define GL_TEXTURE_COORD_ARRAY_STRIDE_EXT &h808A
#define GL_TEXTURE_COORD_ARRAY_COUNT_EXT  &h808B
#define GL_EDGE_FLAG_ARRAY_STRIDE_EXT     &h808C
#define GL_EDGE_FLAG_ARRAY_COUNT_EXT      &h808D
#define GL_VERTEX_ARRAY_POINTER_EXT       &h808E
#define GL_NORMAL_ARRAY_POINTER_EXT       &h808F
#define GL_COLOR_ARRAY_POINTER_EXT        &h8090
#define GL_INDEX_ARRAY_POINTER_EXT        &h8091
#define GL_TEXTURE_COORD_ARRAY_POINTER_EXT &h8092
#define GL_EDGE_FLAG_ARRAY_POINTER_EXT    &h8093
#EndIf

#Ifndef GL_EXT_misc_attribute
#EndIf

#Ifndef GL_SGIS_generate_mipmap
#define GL_GENERATE_MIPMAP_SGIS           &h8191
#define GL_GENERATE_MIPMAP_HINT_SGIS      &h8192
#EndIf

#Ifndef GL_SGIX_clipmap
#define GL_LINEAR_CLIPMAP_LINEAR_SGIX     &h8170
#define GL_TEXTURE_CLIPMAP_CENTER_SGIX    &h8171
#define GL_TEXTURE_CLIPMAP_FRAME_SGIX     &h8172
#define GL_TEXTURE_CLIPMAP_OFFSET_SGIX    &h8173
#define GL_TEXTURE_CLIPMAP_VIRTUAL_DEPTH_SGIX &h8174
#define GL_TEXTURE_CLIPMAP_LOD_OFFSET_SGIX &h8175
#define GL_TEXTURE_CLIPMAP_DEPTH_SGIX     &h8176
#define GL_MAX_CLIPMAP_DEPTH_SGIX         &h8177
#define GL_MAX_CLIPMAP_VIRTUAL_DEPTH_SGIX &h8178
#define GL_NEAREST_CLIPMAP_NEAREST_SGIX   &h844D
#define GL_NEAREST_CLIPMAP_LINEAR_SGIX    &h844E
#define GL_LINEAR_CLIPMAP_NEAREST_SGIX    &h844F
#EndIf

#Ifndef GL_SGIX_shadow
#define GL_TEXTURE_COMPARE_SGIX           &h819A
#define GL_TEXTURE_COMPARE_OPERATOR_SGIX  &h819B
#define GL_TEXTURE_LEQUAL_R_SGIX          &h819C
#define GL_TEXTURE_GEQUAL_R_SGIX          &h819D
#EndIf

#Ifndef GL_SGIS_texture_edge_clamp
#define GL_CLAMP_TO_EDGE_SGIS             &h812F
#EndIf

#Ifndef GL_SGIS_texture_border_clamp
#define GL_CLAMP_TO_BORDER_SGIS           &h812D
#EndIf

#Ifndef GL_EXT_blend_minmax
#define GL_FUNC_ADD_EXT                   &h8006
#define GL_MIN_EXT                        &h8007
#define GL_MAX_EXT                        &h8008
#define GL_BLEND_EQUATION_EXT             &h8009
#EndIf

#Ifndef GL_EXT_blend_subtract
#define GL_FUNC_SUBTRACT_EXT              &h800A
#define GL_FUNC_REVERSE_SUBTRACT_EXT      &h800B
#EndIf

#Ifndef GL_EXT_blend_logic_op
#EndIf

#Ifndef GL_SGIX_interlace
#define GL_INTERLACE_SGIX                 &h8094
#EndIf

#Ifndef GL_SGIX_pixel_tiles
#define GL_PIXEL_TILE_BEST_ALIGNMENT_SGIX &h813E
#define GL_PIXEL_TILE_CACHE_INCREMENT_SGIX &h813F
#define GL_PIXEL_TILE_WIDTH_SGIX          &h8140
#define GL_PIXEL_TILE_HEIGHT_SGIX         &h8141
#define GL_PIXEL_TILE_GRID_WIDTH_SGIX     &h8142
#define GL_PIXEL_TILE_GRID_HEIGHT_SGIX    &h8143
#define GL_PIXEL_TILE_GRID_DEPTH_SGIX     &h8144
#define GL_PIXEL_TILE_CACHE_SIZE_SGIX     &h8145
#EndIf

#Ifndef GL_SGIS_texture_select
#define GL_DUAL_ALPHA4_SGIS               &h8110
#define GL_DUAL_ALPHA8_SGIS               &h8111
#define GL_DUAL_ALPHA12_SGIS              &h8112
#define GL_DUAL_ALPHA16_SGIS              &h8113
#define GL_DUAL_LUMINANCE4_SGIS           &h8114
#define GL_DUAL_LUMINANCE8_SGIS           &h8115
#define GL_DUAL_LUMINANCE12_SGIS          &h8116
#define GL_DUAL_LUMINANCE16_SGIS          &h8117
#define GL_DUAL_INTENSITY4_SGIS           &h8118
#define GL_DUAL_INTENSITY8_SGIS           &h8119
#define GL_DUAL_INTENSITY12_SGIS          &h811A
#define GL_DUAL_INTENSITY16_SGIS          &h811B
#define GL_DUAL_LUMINANCE_ALPHA4_SGIS     &h811C
#define GL_DUAL_LUMINANCE_ALPHA8_SGIS     &h811D
#define GL_QUAD_ALPHA4_SGIS               &h811E
#define GL_QUAD_ALPHA8_SGIS               &h811F
#define GL_QUAD_LUMINANCE4_SGIS           &h8120
#define GL_QUAD_LUMINANCE8_SGIS           &h8121
#define GL_QUAD_INTENSITY4_SGIS           &h8122
#define GL_QUAD_INTENSITY8_SGIS           &h8123
#define GL_DUAL_TEXTURE_SELECT_SGIS       &h8124
#define GL_QUAD_TEXTURE_SELECT_SGIS       &h8125
#EndIf

#Ifndef GL_SGIX_sprite
#define GL_SPRITE_SGIX                    &h8148
#define GL_SPRITE_MODE_SGIX               &h8149
#define GL_SPRITE_AXIS_SGIX               &h814A
#define GL_SPRITE_TRANSLATION_SGIX        &h814B
#define GL_SPRITE_AXIAL_SGIX              &h814C
#define GL_SPRITE_OBJECT_ALIGNED_SGIX     &h814D
#define GL_SPRITE_EYE_ALIGNED_SGIX        &h814E
#EndIf

#Ifndef GL_SGIX_texture_multi_buffer
#define GL_TEXTURE_MULTI_BUFFER_HINT_SGIX &h812E
#EndIf

#Ifndef GL_EXT_point_parameters
#define GL_POINT_SIZE_MIN_EXT             &h8126
#define GL_POINT_SIZE_MAX_EXT             &h8127
#define GL_POINT_FADE_THRESHOLD_SIZE_EXT  &h8128
#define GL_DISTANCE_ATTENUATION_EXT       &h8129
#EndIf

#Ifndef GL_SGIS_point_parameters
#define GL_POINT_SIZE_MIN_SGIS            &h8126
#define GL_POINT_SIZE_MAX_SGIS            &h8127
#define GL_POINT_FADE_THRESHOLD_SIZE_SGIS &h8128
#define GL_DISTANCE_ATTENUATION_SGIS      &h8129
#EndIf

#Ifndef GL_SGIX_instruments
#define GL_INSTRUMENT_BUFFER_POINTER_SGIX &h8180
#define GL_INSTRUMENT_MEASUREMENTS_SGIX   &h8181
#EndIf

#Ifndef GL_SGIX_texture_scale_bias
#define GL_POST_TEXTURE_FILTER_BIAS_SGIX  &h8179
#define GL_POST_TEXTURE_FILTER_SCALE_SGIX &h817A
#define GL_POST_TEXTURE_FILTER_BIAS_RANGE_SGIX &h817B
#define GL_POST_TEXTURE_FILTER_SCALE_RANGE_SGIX &h817C
#EndIf

#Ifndef GL_SGIX_framezoom
#define GL_FRAMEZOOM_SGIX                 &h818B
#define GL_FRAMEZOOM_FACTOR_SGIX          &h818C
#define GL_MAX_FRAMEZOOM_FACTOR_SGIX      &h818D
#EndIf

#Ifndef GL_SGIX_tag_sample_buffer
#EndIf

#Ifndef GL_FfdMaskSGIX
#define GL_TEXTURE_DEFORMATION_BIT_SGIX   &h00000001
#define GL_GEOMETRY_DEFORMATION_BIT_SGIX  &h00000002
#EndIf

#Ifndef GL_SGIX_polynomial_ffd
#define GL_GEOMETRY_DEFORMATION_SGIX      &h8194
#define GL_TEXTURE_DEFORMATION_SGIX       &h8195
#define GL_DEFORMATIONS_MASK_SGIX         &h8196
#define GL_MAX_DEFORMATION_ORDER_SGIX     &h8197
#EndIf

#Ifndef GL_SGIX_reference_plane
#define GL_REFERENCE_PLANE_SGIX           &h817D
#define GL_REFERENCE_PLANE_EQUATION_SGIX  &h817E
#EndIf

#Ifndef GL_SGIX_flush_raster
#EndIf

#Ifndef GL_SGIX_depth_texture
#define GL_DEPTH_COMPONENT16_SGIX         &h81A5
#define GL_DEPTH_COMPONENT24_SGIX         &h81A6
#define GL_DEPTH_COMPONENT32_SGIX         &h81A7
#EndIf

#Ifndef GL_SGIS_fog_function
#define GL_FOG_FUNC_SGIS                  &h812A
#define GL_FOG_FUNC_POINTS_SGIS           &h812B
#define GL_MAX_FOG_FUNC_POINTS_SGIS       &h812C
#EndIf

#Ifndef GL_SGIX_fog_offset
#define GL_FOG_OFFSET_SGIX                &h8198
#define GL_FOG_OFFSET_VALUE_SGIX          &h8199
#EndIf

#Ifndef GL_HP_image_transform
#define GL_IMAGE_SCALE_X_HP               &h8155
#define GL_IMAGE_SCALE_Y_HP               &h8156
#define GL_IMAGE_TRANSLATE_X_HP           &h8157
#define GL_IMAGE_TRANSLATE_Y_HP           &h8158
#define GL_IMAGE_ROTATE_ANGLE_HP          &h8159
#define GL_IMAGE_ROTATE_ORIGIN_X_HP       &h815A
#define GL_IMAGE_ROTATE_ORIGIN_Y_HP       &h815B
#define GL_IMAGE_MAG_FILTER_HP            &h815C
#define GL_IMAGE_MIN_FILTER_HP            &h815D
#define GL_IMAGE_CUBIC_WEIGHT_HP          &h815E
#define GL_CUBIC_HP                       &h815F
#define GL_AVERAGE_HP                     &h8160
#define GL_IMAGE_TRANSFORM_2D_HP          &h8161
#define GL_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP &h8162
#define GL_PROXY_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP &h8163
#EndIf

#Ifndef GL_HP_convolution_border_modes
#define GL_IGNORE_BORDER_HP               &h8150
#define GL_CONSTANT_BORDER_HP             &h8151
#define GL_REPLICATE_BORDER_HP            &h8153
#define GL_CONVOLUTION_BORDER_COLOR_HP    &h8154
#EndIf

#Ifndef GL_INGR_palette_buffer
#EndIf

#Ifndef GL_SGIX_texture_add_env
#define GL_TEXTURE_ENV_BIAS_SGIX          &h80BE
#EndIf

#Ifndef GL_EXT_color_subtable
#EndIf

#Ifndef GL_PGI_vertex_hints
#define GL_VERTEX_DATA_HINT_PGI           &h1A22A
#define GL_VERTEX_CONSISTENT_HINT_PGI     &h1A22B
#define GL_MATERIAL_SIDE_HINT_PGI         &h1A22C
#define GL_MAX_VERTEX_HINT_PGI            &h1A22D
#define GL_COLOR3_BIT_PGI                 &h00010000
#define GL_COLOR4_BIT_PGI                 &h00020000
#define GL_EDGEFLAG_BIT_PGI               &h00040000
#define GL_INDEX_BIT_PGI                  &h00080000
#define GL_MAT_AMBIENT_BIT_PGI            &h00100000
#define GL_MAT_AMBIENT_AND_DIFFUSE_BIT_PGI &h00200000
#define GL_MAT_DIFFUSE_BIT_PGI            &h00400000
#define GL_MAT_EMISSION_BIT_PGI           &h00800000
#define GL_MAT_COLOR_INDEXES_BIT_PGI      &h01000000
#define GL_MAT_SHININESS_BIT_PGI          &h02000000
#define GL_MAT_SPECULAR_BIT_PGI           &h04000000
#define GL_NORMAL_BIT_PGI                 &h08000000
#define GL_TEXCOORD1_BIT_PGI              &h10000000
#define GL_TEXCOORD2_BIT_PGI              &h20000000
#define GL_TEXCOORD3_BIT_PGI              &h40000000
#define GL_TEXCOORD4_BIT_PGI              &h80000000
#define GL_VERTEX23_BIT_PGI               &h00000004
#define GL_VERTEX4_BIT_PGI                &h00000008
#EndIf

#Ifndef GL_PGI_misc_hints
#define GL_PREFER_DOUBLEBUFFER_HINT_PGI   &h1A1F8
#define GL_CONSERVE_MEMORY_HINT_PGI       &h1A1FD
#define GL_RECLAIM_MEMORY_HINT_PGI        &h1A1FE
#define GL_NATIVE_GRAPHICS_HANDLE_PGI     &h1A202
#define GL_NATIVE_GRAPHICS_BEGIN_HINT_PGI &h1A203
#define GL_NATIVE_GRAPHICS_END_HINT_PGI   &h1A204
#define GL_ALWAYS_FAST_HINT_PGI           &h1A20C
#define GL_ALWAYS_SOFT_HINT_PGI           &h1A20D
#define GL_ALLOW_DRAW_OBJ_HINT_PGI        &h1A20E
#define GL_ALLOW_DRAW_WIN_HINT_PGI        &h1A20F
#define GL_ALLOW_DRAW_FRG_HINT_PGI        &h1A210
#define GL_ALLOW_DRAW_MEM_HINT_PGI        &h1A211
#define GL_STRICT_DEPTHFUNC_HINT_PGI      &h1A216
#define GL_STRICT_LIGHTING_HINT_PGI       &h1A217
#define GL_STRICT_SCISSOR_HINT_PGI        &h1A218
#define GL_FULL_STIPPLE_HINT_PGI          &h1A219
#define GL_CLIP_NEAR_HINT_PGI             &h1A220
#define GL_CLIP_FAR_HINT_PGI              &h1A221
#define GL_WIDE_LINE_HINT_PGI             &h1A222
#define GL_BACK_NORMALS_HINT_PGI          &h1A223
#EndIf

#Ifndef GL_EXT_paletted_texture
#define GL_COLOR_INDEX1_EXT               &h80E2
#define GL_COLOR_INDEX2_EXT               &h80E3
#define GL_COLOR_INDEX4_EXT               &h80E4
#define GL_COLOR_INDEX8_EXT               &h80E5
#define GL_COLOR_INDEX12_EXT              &h80E6
#define GL_COLOR_INDEX16_EXT              &h80E7
#define GL_TEXTURE_INDEX_SIZE_EXT         &h80ED
#EndIf

#Ifndef GL_EXT_clip_volume_hint
#define GL_CLIP_VOLUME_CLIPPING_HINT_EXT  &h80F0
#EndIf

#Ifndef GL_SGIX_list_priority
#define GL_LIST_PRIORITY_SGIX             &h8182
#EndIf

#Ifndef GL_SGIX_ir_instrument1
#define GL_IR_INSTRUMENT1_SGIX            &h817F
#EndIf

#Ifndef GL_SGIX_calligraphic_fragment
#define GL_CALLIGRAPHIC_FRAGMENT_SGIX     &h8183
#EndIf

#Ifndef GL_SGIX_texture_lod_bias
#define GL_TEXTURE_LOD_BIAS_S_SGIX        &h818E
#define GL_TEXTURE_LOD_BIAS_T_SGIX        &h818F
#define GL_TEXTURE_LOD_BIAS_R_SGIX        &h8190
#EndIf

#Ifndef GL_SGIX_shadow_ambient
#define GL_SHADOW_AMBIENT_SGIX            &h80BF
#EndIf

#Ifndef GL_EXT_index_texture
#EndIf

#Ifndef GL_EXT_index_material
#define GL_INDEX_MATERIAL_EXT             &h81B8
#define GL_INDEX_MATERIAL_PARAMETER_EXT   &h81B9
#define GL_INDEX_MATERIAL_FACE_EXT        &h81BA
#EndIf

#Ifndef GL_EXT_index_func
#define GL_INDEX_TEST_EXT                 &h81B5
#define GL_INDEX_TEST_FUNC_EXT            &h81B6
#define GL_INDEX_TEST_REF_EXT             &h81B7
#EndIf

#Ifndef GL_EXT_index_array_formats
#define GL_IUI_V2F_EXT                    &h81AD
#define GL_IUI_V3F_EXT                    &h81AE
#define GL_IUI_N3F_V2F_EXT                &h81AF
#define GL_IUI_N3F_V3F_EXT                &h81B0
#define GL_T2F_IUI_V2F_EXT                &h81B1
#define GL_T2F_IUI_V3F_EXT                &h81B2
#define GL_T2F_IUI_N3F_V2F_EXT            &h81B3
#define GL_T2F_IUI_N3F_V3F_EXT            &h81B4
#EndIf

#Ifndef GL_EXT_compiled_vertex_array
#define GL_ARRAY_ELEMENT_LOCK_FIRST_EXT   &h81A8
#define GL_ARRAY_ELEMENT_LOCK_COUNT_EXT   &h81A9
#EndIf

#Ifndef GL_EXT_cull_vertex
#define GL_CULL_VERTEX_EXT                &h81AA
#define GL_CULL_VERTEX_EYE_POSITION_EXT   &h81AB
#define GL_CULL_VERTEX_OBJECT_POSITION_EXT &h81AC
#EndIf

#Ifndef GL_SGIX_ycrcb
#define GL_YCRCB_422_SGIX                 &h81BB
#define GL_YCRCB_444_SGIX                 &h81BC
#EndIf

#Ifndef GL_SGIX_fragment_lighting
#define GL_FRAGMENT_LIGHTING_SGIX         &h8400
#define GL_FRAGMENT_COLOR_MATERIAL_SGIX   &h8401
#define GL_FRAGMENT_COLOR_MATERIAL_FACE_SGIX &h8402
#define GL_FRAGMENT_COLOR_MATERIAL_PARAMETER_SGIX &h8403
#define GL_MAX_FRAGMENT_LIGHTS_SGIX       &h8404
#define GL_MAX_ACTIVE_LIGHTS_SGIX         &h8405
#define GL_CURRENT_RASTER_NORMAL_SGIX     &h8406
#define GL_LIGHT_ENV_MODE_SGIX            &h8407
#define GL_FRAGMENT_LIGHT_MODEL_LOCAL_VIEWER_SGIX &h8408
#define GL_FRAGMENT_LIGHT_MODEL_TWO_SIDE_SGIX &h8409
#define GL_FRAGMENT_LIGHT_MODEL_AMBIENT_SGIX &h840A
#define GL_FRAGMENT_LIGHT_MODEL_NORMAL_INTERPOLATION_SGIX &h840B
#define GL_FRAGMENT_LIGHT0_SGIX           &h840C
#define GL_FRAGMENT_LIGHT1_SGIX           &h840D
#define GL_FRAGMENT_LIGHT2_SGIX           &h840E
#define GL_FRAGMENT_LIGHT3_SGIX           &h840F
#define GL_FRAGMENT_LIGHT4_SGIX           &h8410
#define GL_FRAGMENT_LIGHT5_SGIX           &h8411
#define GL_FRAGMENT_LIGHT6_SGIX           &h8412
#define GL_FRAGMENT_LIGHT7_SGIX           &h8413
#EndIf

#Ifndef GL_IBM_rasterpos_clip
#define GL_RASTER_POSITION_UNCLIPPED_IBM  &h19262
#EndIf

#Ifndef GL_HP_texture_lighting
#define GL_TEXTURE_LIGHTING_MODE_HP       &h8167
#define GL_TEXTURE_POST_SPECULAR_HP       &h8168
#define GL_TEXTURE_PRE_SPECULAR_HP        &h8169
#EndIf

#Ifndef GL_EXT_draw_range_elements
#define GL_MAX_ELEMENTS_VERTICES_EXT      &h80E8
#define GL_MAX_ELEMENTS_INDICES_EXT       &h80E9
#EndIf

#Ifndef GL_WIN_phong_shading
#define GL_PHONG_WIN                      &h80EA
#define GL_PHONG_HINT_WIN                 &h80EB
#EndIf

#Ifndef GL_WIN_specular_fog
#define GL_FOG_SPECULAR_TEXTURE_WIN       &h80EC
#EndIf

#Ifndef GL_EXT_light_texture
#define GL_FRAGMENT_MATERIAL_EXT          &h8349
#define GL_FRAGMENT_NORMAL_EXT            &h834A
#define GL_FRAGMENT_COLOR_EXT             &h834C
#define GL_ATTENUATION_EXT                &h834D
#define GL_SHADOW_ATTENUATION_EXT         &h834E
#define GL_TEXTURE_APPLICATION_MODE_EXT   &h834F
#define GL_TEXTURE_LIGHT_EXT              &h8350
#define GL_TEXTURE_MATERIAL_FACE_EXT      &h8351
#define GL_TEXTURE_MATERIAL_PARAMETER_EXT &h8352
/' reuse GL_FRAGMENT_DEPTH_EXT '/
#EndIf

#Ifndef GL_SGIX_blend_alpha_minmax
#define GL_ALPHA_MIN_SGIX                 &h8320
#define GL_ALPHA_MAX_SGIX                 &h8321
#EndIf

#Ifndef GL_SGIX_impact_pixel_texture
#define GL_PIXEL_TEX_GEN_Q_CEILING_SGIX   &h8184
#define GL_PIXEL_TEX_GEN_Q_ROUND_SGIX     &h8185
#define GL_PIXEL_TEX_GEN_Q_FLOOR_SGIX     &h8186
#define GL_PIXEL_TEX_GEN_ALPHA_REPLACE_SGIX &h8187
#define GL_PIXEL_TEX_GEN_ALPHA_NO_REPLACE_SGIX &h8188
#define GL_PIXEL_TEX_GEN_ALPHA_LS_SGIX    &h8189
#define GL_PIXEL_TEX_GEN_ALPHA_MS_SGIX    &h818A
#EndIf

#Ifndef GL_EXT_bgra
#define GL_BGR_EXT                        &h80E0
#define GL_BGRA_EXT                       &h80E1
#EndIf

#Ifndef GL_SGIX_async
#define GL_ASYNC_MARKER_SGIX              &h8329
#EndIf

#Ifndef GL_SGIX_async_pixel
#define GL_ASYNC_TEX_IMAGE_SGIX           &h835C
#define GL_ASYNC_DRAW_PIXELS_SGIX         &h835D
#define GL_ASYNC_READ_PIXELS_SGIX         &h835E
#define GL_MAX_ASYNC_TEX_IMAGE_SGIX       &h835F
#define GL_MAX_ASYNC_DRAW_PIXELS_SGIX     &h8360
#define GL_MAX_ASYNC_READ_PIXELS_SGIX     &h8361
#EndIf

#Ifndef GL_SGIX_async_histogram
#define GL_ASYNC_HISTOGRAM_SGIX           &h832C
#define GL_MAX_ASYNC_HISTOGRAM_SGIX       &h832D
#EndIf

#Ifndef GL_INTEL_texture_scissor
#EndIf

#Ifndef GL_INTEL_parallel_arrays
#define GL_PARALLEL_ARRAYS_INTEL          &h83F4
#define GL_VERTEX_ARRAY_PARALLEL_POINTERS_INTEL &h83F5
#define GL_NORMAL_ARRAY_PARALLEL_POINTERS_INTEL &h83F6
#define GL_COLOR_ARRAY_PARALLEL_POINTERS_INTEL &h83F7
#define GL_TEXTURE_COORD_ARRAY_PARALLEL_POINTERS_INTEL &h83F8
#EndIf

#Ifndef GL_HP_occlusion_test
#define GL_OCCLUSION_TEST_HP              &h8165
#define GL_OCCLUSION_TEST_RESULT_HP       &h8166
#EndIf

#Ifndef GL_EXT_pixel_transform
#define GL_PIXEL_TRANSFORM_2D_EXT         &h8330
#define GL_PIXEL_MAG_FILTER_EXT           &h8331
#define GL_PIXEL_MIN_FILTER_EXT           &h8332
#define GL_PIXEL_CUBIC_WEIGHT_EXT         &h8333
#define GL_CUBIC_EXT                      &h8334
#define GL_AVERAGE_EXT                    &h8335
#define GL_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT &h8336
#define GL_MAX_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT &h8337
#define GL_PIXEL_TRANSFORM_2D_MATRIX_EXT  &h8338
#EndIf

#Ifndef GL_EXT_pixel_transform_color_table
#EndIf

#Ifndef GL_EXT_shared_texture_palette
#define GL_SHARED_TEXTURE_PALETTE_EXT     &h81FB
#EndIf

#Ifndef GL_EXT_separate_specular_color
#define GL_LIGHT_MODEL_COLOR_CONTROL_EXT  &h81F8
#define GL_SINGLE_COLOR_EXT               &h81F9
#define GL_SEPARATE_SPECULAR_COLOR_EXT    &h81FA
#EndIf

#Ifndef GL_EXT_secondary_color
#define GL_COLOR_SUM_EXT                  &h8458
#define GL_CURRENT_SECONDARY_COLOR_EXT    &h8459
#define GL_SECONDARY_COLOR_ARRAY_SIZE_EXT &h845A
#define GL_SECONDARY_COLOR_ARRAY_TYPE_EXT &h845B
#define GL_SECONDARY_COLOR_ARRAY_STRIDE_EXT &h845C
#define GL_SECONDARY_COLOR_ARRAY_POINTER_EXT &h845D
#define GL_SECONDARY_COLOR_ARRAY_EXT      &h845E
#EndIf

#Ifndef GL_EXT_texture_perturb_normal
#define GL_PERTURB_EXT                    &h85AE
#define GL_TEXTURE_NORMAL_EXT             &h85AF
#EndIf

#Ifndef GL_EXT_multi_draw_arrays
#EndIf

#Ifndef GL_EXT_fog_coord
#define GL_FOG_COORDINATE_SOURCE_EXT      &h8450
#define GL_FOG_COORDINATE_EXT             &h8451
#define GL_FRAGMENT_DEPTH_EXT             &h8452
#define GL_CURRENT_FOG_COORDINATE_EXT     &h8453
#define GL_FOG_COORDINATE_ARRAY_TYPE_EXT  &h8454
#define GL_FOG_COORDINATE_ARRAY_STRIDE_EXT &h8455
#define GL_FOG_COORDINATE_ARRAY_POINTER_EXT &h8456
#define GL_FOG_COORDINATE_ARRAY_EXT       &h8457
#EndIf

#Ifndef GL_REND_screen_coordinates
#define GL_SCREEN_COORDINATES_REND        &h8490
#define GL_INVERTED_SCREEN_W_REND         &h8491
#EndIf

#Ifndef GL_EXT_coordinate_frame
#define GL_TANGENT_ARRAY_EXT              &h8439
#define GL_BINORMAL_ARRAY_EXT             &h843A
#define GL_CURRENT_TANGENT_EXT            &h843B
#define GL_CURRENT_BINORMAL_EXT           &h843C
#define GL_TANGENT_ARRAY_TYPE_EXT         &h843E
#define GL_TANGENT_ARRAY_STRIDE_EXT       &h843F
#define GL_BINORMAL_ARRAY_TYPE_EXT        &h8440
#define GL_BINORMAL_ARRAY_STRIDE_EXT      &h8441
#define GL_TANGENT_ARRAY_POINTER_EXT      &h8442
#define GL_BINORMAL_ARRAY_POINTER_EXT     &h8443
#define GL_MAP1_TANGENT_EXT               &h8444
#define GL_MAP2_TANGENT_EXT               &h8445
#define GL_MAP1_BINORMAL_EXT              &h8446
#define GL_MAP2_BINORMAL_EXT              &h8447
#EndIf

#Ifndef GL_EXT_texture_env_combine
#define GL_COMBINE_EXT                    &h8570
#define GL_COMBINE_RGB_EXT                &h8571
#define GL_COMBINE_ALPHA_EXT              &h8572
#define GL_RGB_SCALE_EXT                  &h8573
#define GL_ADD_SIGNED_EXT                 &h8574
#define GL_INTERPOLATE_EXT                &h8575
#define GL_CONSTANT_EXT                   &h8576
#define GL_PRIMARY_COLOR_EXT              &h8577
#define GL_PREVIOUS_EXT                   &h8578
#define GL_SOURCE0_RGB_EXT                &h8580
#define GL_SOURCE1_RGB_EXT                &h8581
#define GL_SOURCE2_RGB_EXT                &h8582
#define GL_SOURCE0_ALPHA_EXT              &h8588
#define GL_SOURCE1_ALPHA_EXT              &h8589
#define GL_SOURCE2_ALPHA_EXT              &h858A
#define GL_OPERAND0_RGB_EXT               &h8590
#define GL_OPERAND1_RGB_EXT               &h8591
#define GL_OPERAND2_RGB_EXT               &h8592
#define GL_OPERAND0_ALPHA_EXT             &h8598
#define GL_OPERAND1_ALPHA_EXT             &h8599
#define GL_OPERAND2_ALPHA_EXT             &h859A
#EndIf

#Ifndef GL_APPLE_specular_vector
#define GL_LIGHT_MODEL_SPECULAR_VECTOR_APPLE &h85B0
#EndIf

#Ifndef GL_APPLE_transform_hint
#define GL_TRANSFORM_HINT_APPLE           &h85B1
#EndIf

#Ifndef GL_SGIX_fog_scale
#define GL_FOG_SCALE_SGIX                 &h81FC
#define GL_FOG_SCALE_VALUE_SGIX           &h81FD
#EndIf

#Ifndef GL_SUNX_constant_data
#define GL_UNPACK_CONSTANT_DATA_SUNX      &h81D5
#define GL_TEXTURE_CONSTANT_DATA_SUNX     &h81D6
#EndIf

#Ifndef GL_SUN_global_alpha
#define GL_GLOBAL_ALPHA_SUN               &h81D9
#define GL_GLOBAL_ALPHA_FACTOR_SUN        &h81DA
#EndIf

#Ifndef GL_SUN_triangle_list
#define GL_RESTART_SUN                    &h0001
#define GL_REPLACE_MIDDLE_SUN             &h0002
#define GL_REPLACE_OLDEST_SUN             &h0003
#define GL_TRIANGLE_LIST_SUN              &h81D7
#define GL_REPLACEMENT_CODE_SUN           &h81D8
#define GL_REPLACEMENT_CODE_ARRAY_SUN     &h85C0
#define GL_REPLACEMENT_CODE_ARRAY_TYPE_SUN &h85C1
#define GL_REPLACEMENT_CODE_ARRAY_STRIDE_SUN &h85C2
#define GL_REPLACEMENT_CODE_ARRAY_POINTER_SUN &h85C3
#define GL_R1UI_V3F_SUN                   &h85C4
#define GL_R1UI_C4UB_V3F_SUN              &h85C5
#define GL_R1UI_C3F_V3F_SUN               &h85C6
#define GL_R1UI_N3F_V3F_SUN               &h85C7
#define GL_R1UI_C4F_N3F_V3F_SUN           &h85C8
#define GL_R1UI_T2F_V3F_SUN               &h85C9
#define GL_R1UI_T2F_N3F_V3F_SUN           &h85CA
#define GL_R1UI_T2F_C4F_N3F_V3F_SUN       &h85CB
#EndIf

#Ifndef GL_SUN_vertex
#EndIf

#Ifndef GL_EXT_blend_func_separate
#define GL_BLEND_DST_RGB_EXT              &h80C8
#define GL_BLEND_SRC_RGB_EXT              &h80C9
#define GL_BLEND_DST_ALPHA_EXT            &h80CA
#define GL_BLEND_SRC_ALPHA_EXT            &h80CB
#EndIf

#Ifndef GL_INGR_color_clamp
#define GL_RED_MIN_CLAMP_INGR             &h8560
#define GL_GREEN_MIN_CLAMP_INGR           &h8561
#define GL_BLUE_MIN_CLAMP_INGR            &h8562
#define GL_ALPHA_MIN_CLAMP_INGR           &h8563
#define GL_RED_MAX_CLAMP_INGR             &h8564
#define GL_GREEN_MAX_CLAMP_INGR           &h8565
#define GL_BLUE_MAX_CLAMP_INGR            &h8566
#define GL_ALPHA_MAX_CLAMP_INGR           &h8567
#EndIf

#Ifndef GL_INGR_interlace_read
#define GL_INTERLACE_READ_INGR            &h8568
#EndIf

#Ifndef GL_EXT_stencil_wrap
#define GL_INCR_WRAP_EXT                  &h8507
#define GL_DECR_WRAP_EXT                  &h8508
#EndIf

#Ifndef GL_EXT_422_pixels
#define GL_422_EXT                        &h80CC
#define GL_422_REV_EXT                    &h80CD
#define GL_422_AVERAGE_EXT                &h80CE
#define GL_422_REV_AVERAGE_EXT            &h80CF
#EndIf

#Ifndef GL_NV_texgen_reflection
#define GL_NORMAL_MAP_NV                  &h8511
#define GL_REFLECTION_MAP_NV              &h8512
#EndIf

#Ifndef GL_EXT_texture_cube_map
#define GL_NORMAL_MAP_EXT                 &h8511
#define GL_REFLECTION_MAP_EXT             &h8512
#define GL_TEXTURE_CUBE_MAP_EXT           &h8513
#define GL_TEXTURE_BINDING_CUBE_MAP_EXT   &h8514
#define GL_TEXTURE_CUBE_MAP_POSITIVE_X_EXT &h8515
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_X_EXT &h8516
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Y_EXT &h8517
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_EXT &h8518
#define GL_TEXTURE_CUBE_MAP_POSITIVE_Z_EXT &h8519
#define GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_EXT &h851A
#define GL_PROXY_TEXTURE_CUBE_MAP_EXT     &h851B
#define GL_MAX_CUBE_MAP_TEXTURE_SIZE_EXT  &h851C
#EndIf

#Ifndef GL_SUN_convolution_border_modes
#define GL_WRAP_BORDER_SUN                &h81D4
#EndIf

#Ifndef GL_EXT_texture_env_add
#EndIf

#Ifndef GL_EXT_texture_lod_bias
#define GL_MAX_TEXTURE_LOD_BIAS_EXT       &h84FD
#define GL_TEXTURE_FILTER_CONTROL_EXT     &h8500
#define GL_TEXTURE_LOD_BIAS_EXT           &h8501
#EndIf

#Ifndef GL_EXT_texture_filter_anisotropic
#define GL_TEXTURE_MAX_ANISOTROPY_EXT     &h84FE
#define GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT &h84FF
#EndIf

#Ifndef GL_EXT_vertex_weighting
#define GL_MODELVIEW0_STACK_DEPTH_EXT     GL_MODELVIEW_STACK_DEPTH
#define GL_MODELVIEW1_STACK_DEPTH_EXT     &h8502
#define GL_MODELVIEW0_MATRIX_EXT          GL_MODELVIEW_MATRIX
#define GL_MODELVIEW1_MATRIX_EXT          &h8506
#define GL_VERTEX_WEIGHTING_EXT           &h8509
#define GL_MODELVIEW0_EXT                 GL_MODELVIEW
#define GL_MODELVIEW1_EXT                 &h850A
#define GL_CURRENT_VERTEX_WEIGHT_EXT      &h850B
#define GL_VERTEX_WEIGHT_ARRAY_EXT        &h850C
#define GL_VERTEX_WEIGHT_ARRAY_SIZE_EXT   &h850D
#define GL_VERTEX_WEIGHT_ARRAY_TYPE_EXT   &h850E
#define GL_VERTEX_WEIGHT_ARRAY_STRIDE_EXT &h850F
#define GL_VERTEX_WEIGHT_ARRAY_POINTER_EXT &h8510
#EndIf

#Ifndef GL_NV_light_max_exponent
#define GL_MAX_SHININESS_NV               &h8504
#define GL_MAX_SPOT_EXPONENT_NV           &h8505
#EndIf

#Ifndef GL_NV_vertex_array_range
#define GL_VERTEX_ARRAY_RANGE_NV          &h851D
#define GL_VERTEX_ARRAY_RANGE_LENGTH_NV   &h851E
#define GL_VERTEX_ARRAY_RANGE_VALID_NV    &h851F
#define GL_MAX_VERTEX_ARRAY_RANGE_ELEMENT_NV &h8520
#define GL_VERTEX_ARRAY_RANGE_POINTER_NV  &h8521
#EndIf

#Ifndef GL_NV_register_combiners
#define GL_REGISTER_COMBINERS_NV          &h8522
#define GL_VARIABLE_A_NV                  &h8523
#define GL_VARIABLE_B_NV                  &h8524
#define GL_VARIABLE_C_NV                  &h8525
#define GL_VARIABLE_D_NV                  &h8526
#define GL_VARIABLE_E_NV                  &h8527
#define GL_VARIABLE_F_NV                  &h8528
#define GL_VARIABLE_G_NV                  &h8529
#define GL_CONSTANT_COLOR0_NV             &h852A
#define GL_CONSTANT_COLOR1_NV             &h852B
#define GL_PRIMARY_COLOR_NV               &h852C
#define GL_SECONDARY_COLOR_NV             &h852D
#define GL_SPARE0_NV                      &h852E
#define GL_SPARE1_NV                      &h852F
#define GL_DISCARD_NV                     &h8530
#define GL_E_TIMES_F_NV                   &h8531
#define GL_SPARE0_PLUS_SECONDARY_COLOR_NV &h8532
#define GL_UNSIGNED_IDENTITY_NV           &h8536
#define GL_UNSIGNED_INVERT_NV             &h8537
#define GL_EXPAND_NORMAL_NV               &h8538
#define GL_EXPAND_NEGATE_NV               &h8539
#define GL_HALF_BIAS_NORMAL_NV            &h853A
#define GL_HALF_BIAS_NEGATE_NV            &h853B
#define GL_SIGNED_IDENTITY_NV             &h853C
#define GL_SIGNED_NEGATE_NV               &h853D
#define GL_SCALE_BY_TWO_NV                &h853E
#define GL_SCALE_BY_FOUR_NV               &h853F
#define GL_SCALE_BY_ONE_HALF_NV           &h8540
#define GL_BIAS_BY_NEGATIVE_ONE_HALF_NV   &h8541
#define GL_COMBINER_INPUT_NV              &h8542
#define GL_COMBINER_MAPPING_NV            &h8543
#define GL_COMBINER_COMPONENT_USAGE_NV    &h8544
#define GL_COMBINER_AB_DOT_PRODUCT_NV     &h8545
#define GL_COMBINER_CD_DOT_PRODUCT_NV     &h8546
#define GL_COMBINER_MUX_SUM_NV            &h8547
#define GL_COMBINER_SCALE_NV              &h8548
#define GL_COMBINER_BIAS_NV               &h8549
#define GL_COMBINER_AB_OUTPUT_NV          &h854A
#define GL_COMBINER_CD_OUTPUT_NV          &h854B
#define GL_COMBINER_SUM_OUTPUT_NV         &h854C
#define GL_MAX_GENERAL_COMBINERS_NV       &h854D
#define GL_NUM_GENERAL_COMBINERS_NV       &h854E
#define GL_COLOR_SUM_CLAMP_NV             &h854F
#define GL_COMBINER0_NV                   &h8550
#define GL_COMBINER1_NV                   &h8551
#define GL_COMBINER2_NV                   &h8552
#define GL_COMBINER3_NV                   &h8553
#define GL_COMBINER4_NV                   &h8554
#define GL_COMBINER5_NV                   &h8555
#define GL_COMBINER6_NV                   &h8556
#define GL_COMBINER7_NV                   &h8557
/' reuse GL_TEXTURE0_ARB '/
/' reuse GL_TEXTURE1_ARB '/
/' reuse GL_ZERO '/
/' reuse GL_NONE '/
/' reuse GL_FOG '/
#EndIf

#Ifndef GL_NV_fog_distance
#define GL_FOG_DISTANCE_MODE_NV           &h855A
#define GL_EYE_RADIAL_NV                  &h855B
#define GL_EYE_PLANE_ABSOLUTE_NV          &h855C
/' reuse GL_EYE_PLANE '/
#EndIf

#Ifndef GL_NV_texgen_emboss
#define GL_EMBOSS_LIGHT_NV                &h855D
#define GL_EMBOSS_CONSTANT_NV             &h855E
#define GL_EMBOSS_MAP_NV                  &h855F
#EndIf

#Ifndef GL_NV_blend_square
#EndIf

#Ifndef GL_NV_texture_env_combine4
#define GL_COMBINE4_NV                    &h8503
#define GL_SOURCE3_RGB_NV                 &h8583
#define GL_SOURCE3_ALPHA_NV               &h858B
#define GL_OPERAND3_RGB_NV                &h8593
#define GL_OPERAND3_ALPHA_NV              &h859B
#EndIf

#Ifndef GL_MESA_resize_buffers
#EndIf

#Ifndef GL_MESA_window_pos
#EndIf

#Ifndef GL_EXT_texture_compression_s3tc
#define GL_COMPRESSED_RGB_S3TC_DXT1_EXT   &h83F0
#define GL_COMPRESSED_RGBA_S3TC_DXT1_EXT  &h83F1
#define GL_COMPRESSED_RGBA_S3TC_DXT3_EXT  &h83F2
#define GL_COMPRESSED_RGBA_S3TC_DXT5_EXT  &h83F3
#EndIf

#Ifndef GL_IBM_cull_vertex
#define GL_CULL_VERTEX_IBM                103050
#EndIf

#Ifndef GL_IBM_multimode_draw_arrays
#EndIf

#Ifndef GL_IBM_vertex_array_lists
#define GL_VERTEX_ARRAY_LIST_IBM          103070
#define GL_NORMAL_ARRAY_LIST_IBM          103071
#define GL_COLOR_ARRAY_LIST_IBM           103072
#define GL_INDEX_ARRAY_LIST_IBM           103073
#define GL_TEXTURE_COORD_ARRAY_LIST_IBM   103074
#define GL_EDGE_FLAG_ARRAY_LIST_IBM       103075
#define GL_FOG_COORDINATE_ARRAY_LIST_IBM  103076
#define GL_SECONDARY_COLOR_ARRAY_LIST_IBM 103077
#define GL_VERTEX_ARRAY_LIST_STRIDE_IBM   103080
#define GL_NORMAL_ARRAY_LIST_STRIDE_IBM   103081
#define GL_COLOR_ARRAY_LIST_STRIDE_IBM    103082
#define GL_INDEX_ARRAY_LIST_STRIDE_IBM    103083
#define GL_TEXTURE_COORD_ARRAY_LIST_STRIDE_IBM 103084
#define GL_EDGE_FLAG_ARRAY_LIST_STRIDE_IBM 103085
#define GL_FOG_COORDINATE_ARRAY_LIST_STRIDE_IBM 103086
#define GL_SECONDARY_COLOR_ARRAY_LIST_STRIDE_IBM 103087
#EndIf

#Ifndef GL_SGIX_subsample
#define GL_PACK_SUBSAMPLE_RATE_SGIX       &h85A0
#define GL_UNPACK_SUBSAMPLE_RATE_SGIX     &h85A1
#define GL_PIXEL_SUBSAMPLE_4444_SGIX      &h85A2
#define GL_PIXEL_SUBSAMPLE_2424_SGIX      &h85A3
#define GL_PIXEL_SUBSAMPLE_4242_SGIX      &h85A4
#EndIf

#Ifndef GL_SGIX_ycrcb_subsample
#EndIf

#Ifndef GL_SGIX_ycrcba
#define GL_YCRCB_SGIX                     &h8318
#define GL_YCRCBA_SGIX                    &h8319
#EndIf

#Ifndef GL_SGI_depth_pass_instrument
#define GL_DEPTH_PASS_INSTRUMENT_SGIX     &h8310
#define GL_DEPTH_PASS_INSTRUMENT_COUNTERS_SGIX &h8311
#define GL_DEPTH_PASS_INSTRUMENT_MAX_SGIX &h8312
#EndIf

#Ifndef GL_3DFX_texture_compression_FXT1
#define GL_COMPRESSED_RGB_FXT1_3DFX       &h86B0
#define GL_COMPRESSED_RGBA_FXT1_3DFX      &h86B1
#EndIf

#Ifndef GL_3DFX_multisample
#define GL_MULTISAMPLE_3DFX               &h86B2
#define GL_SAMPLE_BUFFERS_3DFX            &h86B3
#define GL_SAMPLES_3DFX                   &h86B4
#define GL_MULTISAMPLE_BIT_3DFX           &h20000000
#EndIf

#Ifndef GL_3DFX_tbuffer
#EndIf

#Ifndef GL_EXT_multisample
#define GL_MULTISAMPLE_EXT                &h809D
#define GL_SAMPLE_ALPHA_TO_MASK_EXT       &h809E
#define GL_SAMPLE_ALPHA_TO_ONE_EXT        &h809F
#define GL_SAMPLE_MASK_EXT                &h80A0
#define GL_1PASS_EXT                      &h80A1
#define GL_2PASS_0_EXT                    &h80A2
#define GL_2PASS_1_EXT                    &h80A3
#define GL_4PASS_0_EXT                    &h80A4
#define GL_4PASS_1_EXT                    &h80A5
#define GL_4PASS_2_EXT                    &h80A6
#define GL_4PASS_3_EXT                    &h80A7
#define GL_SAMPLE_BUFFERS_EXT             &h80A8
#define GL_SAMPLES_EXT                    &h80A9
#define GL_SAMPLE_MASK_VALUE_EXT          &h80AA
#define GL_SAMPLE_MASK_INVERT_EXT         &h80AB
#define GL_SAMPLE_PATTERN_EXT             &h80AC
#define GL_MULTISAMPLE_BIT_EXT            &h20000000
#EndIf

#Ifndef GL_SGIX_vertex_preclip
#define GL_VERTEX_PRECLIP_SGIX            &h83EE
#define GL_VERTEX_PRECLIP_HINT_SGIX       &h83EF
#EndIf

#Ifndef GL_SGIX_convolution_accuracy
#define GL_CONVOLUTION_HINT_SGIX          &h8316
#EndIf

#Ifndef GL_SGIX_resample
#define GL_PACK_RESAMPLE_SGIX             &h842C
#define GL_UNPACK_RESAMPLE_SGIX           &h842D
#define GL_RESAMPLE_REPLICATE_SGIX        &h842E
#define GL_RESAMPLE_ZERO_FILL_SGIX        &h842F
#define GL_RESAMPLE_DECIMATE_SGIX         &h8430
#EndIf

#Ifndef GL_SGIS_point_line_texgen
#define GL_EYE_DISTANCE_TO_POINT_SGIS     &h81F0
#define GL_OBJECT_DISTANCE_TO_POINT_SGIS  &h81F1
#define GL_EYE_DISTANCE_TO_LINE_SGIS      &h81F2
#define GL_OBJECT_DISTANCE_TO_LINE_SGIS   &h81F3
#define GL_EYE_POINT_SGIS                 &h81F4
#define GL_OBJECT_POINT_SGIS              &h81F5
#define GL_EYE_LINE_SGIS                  &h81F6
#define GL_OBJECT_LINE_SGIS               &h81F7
#EndIf

#Ifndef GL_SGIS_texture_color_mask
#define GL_TEXTURE_COLOR_WRITEMASK_SGIS   &h81EF
#EndIf

#Ifndef GL_EXT_texture_env_dot3
#define GL_DOT3_RGB_EXT                   &h8740
#define GL_DOT3_RGBA_EXT                  &h8741
#EndIf

#Ifndef GL_ATI_texture_mirror_once
#define GL_MIRROR_CLAMP_ATI               &h8742
#define GL_MIRROR_CLAMP_TO_EDGE_ATI       &h8743
#EndIf

#Ifndef GL_NV_fence
#define GL_ALL_COMPLETED_NV               &h84F2
#define GL_FENCE_STATUS_NV                &h84F3
#define GL_FENCE_CONDITION_NV             &h84F4
#EndIf

#Ifndef GL_IBM_texture_mirrored_repeat
#define GL_MIRRORED_REPEAT_IBM            &h8370
#EndIf

#Ifndef GL_NV_evaluators
#define GL_EVAL_2D_NV                     &h86C0
#define GL_EVAL_TRIANGULAR_2D_NV          &h86C1
#define GL_MAP_TESSELLATION_NV            &h86C2
#define GL_MAP_ATTRIB_U_ORDER_NV          &h86C3
#define GL_MAP_ATTRIB_V_ORDER_NV          &h86C4
#define GL_EVAL_FRACTIONAL_TESSELLATION_NV &h86C5
#define GL_EVAL_VERTEX_ATTRIB0_NV         &h86C6
#define GL_EVAL_VERTEX_ATTRIB1_NV         &h86C7
#define GL_EVAL_VERTEX_ATTRIB2_NV         &h86C8
#define GL_EVAL_VERTEX_ATTRIB3_NV         &h86C9
#define GL_EVAL_VERTEX_ATTRIB4_NV         &h86CA
#define GL_EVAL_VERTEX_ATTRIB5_NV         &h86CB
#define GL_EVAL_VERTEX_ATTRIB6_NV         &h86CC
#define GL_EVAL_VERTEX_ATTRIB7_NV         &h86CD
#define GL_EVAL_VERTEX_ATTRIB8_NV         &h86CE
#define GL_EVAL_VERTEX_ATTRIB9_NV         &h86CF
#define GL_EVAL_VERTEX_ATTRIB10_NV        &h86D0
#define GL_EVAL_VERTEX_ATTRIB11_NV        &h86D1
#define GL_EVAL_VERTEX_ATTRIB12_NV        &h86D2
#define GL_EVAL_VERTEX_ATTRIB13_NV        &h86D3
#define GL_EVAL_VERTEX_ATTRIB14_NV        &h86D4
#define GL_EVAL_VERTEX_ATTRIB15_NV        &h86D5
#define GL_MAX_MAP_TESSELLATION_NV        &h86D6
#define GL_MAX_RATIONAL_EVAL_ORDER_NV     &h86D7
#EndIf

#Ifndef GL_NV_packed_depth_stencil
#define GL_DEPTH_STENCIL_NV               &h84F9
#define GL_UNSIGNED_INT_24_8_NV           &h84FA
#EndIf

#Ifndef GL_NV_register_combiners2
#define GL_PER_STAGE_CONSTANTS_NV         &h8535
#EndIf

#Ifndef GL_NV_texture_compression_vtc
#EndIf

#Ifndef GL_NV_texture_rectangle
#define GL_TEXTURE_RECTANGLE_NV           &h84F5
#define GL_TEXTURE_BINDING_RECTANGLE_NV   &h84F6
#define GL_PROXY_TEXTURE_RECTANGLE_NV     &h84F7
#define GL_MAX_RECTANGLE_TEXTURE_SIZE_NV  &h84F8
#EndIf

#Ifndef GL_NV_texture_shader
#define GL_OFFSET_TEXTURE_RECTANGLE_NV    &h864C
#define GL_OFFSET_TEXTURE_RECTANGLE_SCALE_NV &h864D
#define GL_DOT_PRODUCT_TEXTURE_RECTANGLE_NV &h864E
#define GL_RGBA_UNSIGNED_DOT_PRODUCT_MAPPING_NV &h86D9
#define GL_UNSIGNED_INT_S8_S8_8_8_NV      &h86DA
#define GL_UNSIGNED_INT_8_8_S8_S8_REV_NV  &h86DB
#define GL_DSDT_MAG_INTENSITY_NV          &h86DC
#define GL_SHADER_CONSISTENT_NV           &h86DD
#define GL_TEXTURE_SHADER_NV              &h86DE
#define GL_SHADER_OPERATION_NV            &h86DF
#define GL_CULL_MODES_NV                  &h86E0
#define GL_OFFSET_TEXTURE_MATRIX_NV       &h86E1
#define GL_OFFSET_TEXTURE_SCALE_NV        &h86E2
#define GL_OFFSET_TEXTURE_BIAS_NV         &h86E3
#define GL_OFFSET_TEXTURE_2D_MATRIX_NV    GL_OFFSET_TEXTURE_MATRIX_NV
#define GL_OFFSET_TEXTURE_2D_SCALE_NV     GL_OFFSET_TEXTURE_SCALE_NV
#define GL_OFFSET_TEXTURE_2D_BIAS_NV      GL_OFFSET_TEXTURE_BIAS_NV
#define GL_PREVIOUS_TEXTURE_INPUT_NV      &h86E4
#define GL_CONST_EYE_NV                   &h86E5
#define GL_PASS_THROUGH_NV                &h86E6
#define GL_CULL_FRAGMENT_NV               &h86E7
#define GL_OFFSET_TEXTURE_2D_NV           &h86E8
#define GL_DEPENDENT_AR_TEXTURE_2D_NV     &h86E9
#define GL_DEPENDENT_GB_TEXTURE_2D_NV     &h86EA
#define GL_DOT_PRODUCT_NV                 &h86EC
#define GL_DOT_PRODUCT_DEPTH_REPLACE_NV   &h86ED
#define GL_DOT_PRODUCT_TEXTURE_2D_NV      &h86EE
#define GL_DOT_PRODUCT_TEXTURE_CUBE_MAP_NV &h86F0
#define GL_DOT_PRODUCT_DIFFUSE_CUBE_MAP_NV &h86F1
#define GL_DOT_PRODUCT_REFLECT_CUBE_MAP_NV &h86F2
#define GL_DOT_PRODUCT_CONST_EYE_REFLECT_CUBE_MAP_NV &h86F3
#define GL_HILO_NV                        &h86F4
#define GL_DSDT_NV                        &h86F5
#define GL_DSDT_MAG_NV                    &h86F6
#define GL_DSDT_MAG_VIB_NV                &h86F7
#define GL_HILO16_NV                      &h86F8
#define GL_SIGNED_HILO_NV                 &h86F9
#define GL_SIGNED_HILO16_NV               &h86FA
#define GL_SIGNED_RGBA_NV                 &h86FB
#define GL_SIGNED_RGBA8_NV                &h86FC
#define GL_SIGNED_RGB_NV                  &h86FE
#define GL_SIGNED_RGB8_NV                 &h86FF
#define GL_SIGNED_LUMINANCE_NV            &h8701
#define GL_SIGNED_LUMINANCE8_NV           &h8702
#define GL_SIGNED_LUMINANCE_ALPHA_NV      &h8703
#define GL_SIGNED_LUMINANCE8_ALPHA8_NV    &h8704
#define GL_SIGNED_ALPHA_NV                &h8705
#define GL_SIGNED_ALPHA8_NV               &h8706
#define GL_SIGNED_INTENSITY_NV            &h8707
#define GL_SIGNED_INTENSITY8_NV           &h8708
#define GL_DSDT8_NV                       &h8709
#define GL_DSDT8_MAG8_NV                  &h870A
#define GL_DSDT8_MAG8_INTENSITY8_NV       &h870B
#define GL_SIGNED_RGB_UNSIGNED_ALPHA_NV   &h870C
#define GL_SIGNED_RGB8_UNSIGNED_ALPHA8_NV &h870D
#define GL_HI_SCALE_NV                    &h870E
#define GL_LO_SCALE_NV                    &h870F
#define GL_DS_SCALE_NV                    &h8710
#define GL_DT_SCALE_NV                    &h8711
#define GL_MAGNITUDE_SCALE_NV             &h8712
#define GL_VIBRANCE_SCALE_NV              &h8713
#define GL_HI_BIAS_NV                     &h8714
#define GL_LO_BIAS_NV                     &h8715
#define GL_DS_BIAS_NV                     &h8716
#define GL_DT_BIAS_NV                     &h8717
#define GL_MAGNITUDE_BIAS_NV              &h8718
#define GL_VIBRANCE_BIAS_NV               &h8719
#define GL_TEXTURE_BORDER_VALUES_NV       &h871A
#define GL_TEXTURE_HI_SIZE_NV             &h871B
#define GL_TEXTURE_LO_SIZE_NV             &h871C
#define GL_TEXTURE_DS_SIZE_NV             &h871D
#define GL_TEXTURE_DT_SIZE_NV             &h871E
#define GL_TEXTURE_MAG_SIZE_NV            &h871F
#EndIf

#Ifndef GL_NV_texture_shader2
#define GL_DOT_PRODUCT_TEXTURE_3D_NV      &h86EF
#EndIf

#Ifndef GL_NV_vertex_array_range2
#define GL_VERTEX_ARRAY_RANGE_WITHOUT_FLUSH_NV &h8533
#EndIf

#Ifndef GL_NV_vertex_program
#define GL_VERTEX_PROGRAM_NV              &h8620
#define GL_VERTEX_STATE_PROGRAM_NV        &h8621
#define GL_ATTRIB_ARRAY_SIZE_NV           &h8623
#define GL_ATTRIB_ARRAY_STRIDE_NV         &h8624
#define GL_ATTRIB_ARRAY_TYPE_NV           &h8625
#define GL_CURRENT_ATTRIB_NV              &h8626
#define GL_PROGRAM_LENGTH_NV              &h8627
#define GL_PROGRAM_STRING_NV              &h8628
#define GL_MODELVIEW_PROJECTION_NV        &h8629
#define GL_IDENTITY_NV                    &h862A
#define GL_INVERSE_NV                     &h862B
#define GL_TRANSPOSE_NV                   &h862C
#define GL_INVERSE_TRANSPOSE_NV           &h862D
#define GL_MAX_TRACK_MATRIX_STACK_DEPTH_NV &h862E
#define GL_MAX_TRACK_MATRICES_NV          &h862F
#define GL_MATRIX0_NV                     &h8630
#define GL_MATRIX1_NV                     &h8631
#define GL_MATRIX2_NV                     &h8632
#define GL_MATRIX3_NV                     &h8633
#define GL_MATRIX4_NV                     &h8634
#define GL_MATRIX5_NV                     &h8635
#define GL_MATRIX6_NV                     &h8636
#define GL_MATRIX7_NV                     &h8637
#define GL_CURRENT_MATRIX_STACK_DEPTH_NV  &h8640
#define GL_CURRENT_MATRIX_NV              &h8641
#define GL_VERTEX_PROGRAM_POINT_SIZE_NV   &h8642
#define GL_VERTEX_PROGRAM_TWO_SIDE_NV     &h8643
#define GL_PROGRAM_PARAMETER_NV           &h8644
#define GL_ATTRIB_ARRAY_POINTER_NV        &h8645
#define GL_PROGRAM_TARGET_NV              &h8646
#define GL_PROGRAM_RESIDENT_NV            &h8647
#define GL_TRACK_MATRIX_NV                &h8648
#define GL_TRACK_MATRIX_TRANSFORM_NV      &h8649
#define GL_VERTEX_PROGRAM_BINDING_NV      &h864A
#define GL_PROGRAM_ERROR_POSITION_NV      &h864B
#define GL_VERTEX_ATTRIB_ARRAY0_NV        &h8650
#define GL_VERTEX_ATTRIB_ARRAY1_NV        &h8651
#define GL_VERTEX_ATTRIB_ARRAY2_NV        &h8652
#define GL_VERTEX_ATTRIB_ARRAY3_NV        &h8653
#define GL_VERTEX_ATTRIB_ARRAY4_NV        &h8654
#define GL_VERTEX_ATTRIB_ARRAY5_NV        &h8655
#define GL_VERTEX_ATTRIB_ARRAY6_NV        &h8656
#define GL_VERTEX_ATTRIB_ARRAY7_NV        &h8657
#define GL_VERTEX_ATTRIB_ARRAY8_NV        &h8658
#define GL_VERTEX_ATTRIB_ARRAY9_NV        &h8659
#define GL_VERTEX_ATTRIB_ARRAY10_NV       &h865A
#define GL_VERTEX_ATTRIB_ARRAY11_NV       &h865B
#define GL_VERTEX_ATTRIB_ARRAY12_NV       &h865C
#define GL_VERTEX_ATTRIB_ARRAY13_NV       &h865D
#define GL_VERTEX_ATTRIB_ARRAY14_NV       &h865E
#define GL_VERTEX_ATTRIB_ARRAY15_NV       &h865F
#define GL_MAP1_VERTEX_ATTRIB0_4_NV       &h8660
#define GL_MAP1_VERTEX_ATTRIB1_4_NV       &h8661
#define GL_MAP1_VERTEX_ATTRIB2_4_NV       &h8662
#define GL_MAP1_VERTEX_ATTRIB3_4_NV       &h8663
#define GL_MAP1_VERTEX_ATTRIB4_4_NV       &h8664
#define GL_MAP1_VERTEX_ATTRIB5_4_NV       &h8665
#define GL_MAP1_VERTEX_ATTRIB6_4_NV       &h8666
#define GL_MAP1_VERTEX_ATTRIB7_4_NV       &h8667
#define GL_MAP1_VERTEX_ATTRIB8_4_NV       &h8668
#define GL_MAP1_VERTEX_ATTRIB9_4_NV       &h8669
#define GL_MAP1_VERTEX_ATTRIB10_4_NV      &h866A
#define GL_MAP1_VERTEX_ATTRIB11_4_NV      &h866B
#define GL_MAP1_VERTEX_ATTRIB12_4_NV      &h866C
#define GL_MAP1_VERTEX_ATTRIB13_4_NV      &h866D
#define GL_MAP1_VERTEX_ATTRIB14_4_NV      &h866E
#define GL_MAP1_VERTEX_ATTRIB15_4_NV      &h866F
#define GL_MAP2_VERTEX_ATTRIB0_4_NV       &h8670
#define GL_MAP2_VERTEX_ATTRIB1_4_NV       &h8671
#define GL_MAP2_VERTEX_ATTRIB2_4_NV       &h8672
#define GL_MAP2_VERTEX_ATTRIB3_4_NV       &h8673
#define GL_MAP2_VERTEX_ATTRIB4_4_NV       &h8674
#define GL_MAP2_VERTEX_ATTRIB5_4_NV       &h8675
#define GL_MAP2_VERTEX_ATTRIB6_4_NV       &h8676
#define GL_MAP2_VERTEX_ATTRIB7_4_NV       &h8677
#define GL_MAP2_VERTEX_ATTRIB8_4_NV       &h8678
#define GL_MAP2_VERTEX_ATTRIB9_4_NV       &h8679
#define GL_MAP2_VERTEX_ATTRIB10_4_NV      &h867A
#define GL_MAP2_VERTEX_ATTRIB11_4_NV      &h867B
#define GL_MAP2_VERTEX_ATTRIB12_4_NV      &h867C
#define GL_MAP2_VERTEX_ATTRIB13_4_NV      &h867D
#define GL_MAP2_VERTEX_ATTRIB14_4_NV      &h867E
#define GL_MAP2_VERTEX_ATTRIB15_4_NV      &h867F
#EndIf

#Ifndef GL_SGIX_texture_coordinate_clamp
#define GL_TEXTURE_MAX_CLAMP_S_SGIX       &h8369
#define GL_TEXTURE_MAX_CLAMP_T_SGIX       &h836A
#define GL_TEXTURE_MAX_CLAMP_R_SGIX       &h836B
#EndIf

#Ifndef GL_SGIX_scalebias_hint
#define GL_SCALEBIAS_HINT_SGIX            &h8322
#EndIf

#Ifndef GL_OML_interlace
#define GL_INTERLACE_OML                  &h8980
#define GL_INTERLACE_READ_OML             &h8981
#EndIf

#Ifndef GL_OML_subsample
#define GL_FORMAT_SUBSAMPLE_24_24_OML     &h8982
#define GL_FORMAT_SUBSAMPLE_244_244_OML   &h8983
#EndIf

#Ifndef GL_OML_resample
#define GL_PACK_RESAMPLE_OML              &h8984
#define GL_UNPACK_RESAMPLE_OML            &h8985
#define GL_RESAMPLE_REPLICATE_OML         &h8986
#define GL_RESAMPLE_ZERO_FILL_OML         &h8987
#define GL_RESAMPLE_AVERAGE_OML           &h8988
#define GL_RESAMPLE_DECIMATE_OML          &h8989
#EndIf

#Ifndef GL_NV_copy_depth_to_color
#define GL_DEPTH_STENCIL_TO_RGBA_NV       &h886E
#define GL_DEPTH_STENCIL_TO_BGRA_NV       &h886F
#EndIf

#Ifndef GL_ATI_envmap_bumpmap
#define GL_BUMP_ROT_MATRIX_ATI            &h8775
#define GL_BUMP_ROT_MATRIX_SIZE_ATI       &h8776
#define GL_BUMP_NUM_TEX_UNITS_ATI         &h8777
#define GL_BUMP_TEX_UNITS_ATI             &h8778
#define GL_DUDV_ATI                       &h8779
#define GL_DU8DV8_ATI                     &h877A
#define GL_BUMP_ENVMAP_ATI                &h877B
#define GL_BUMP_TARGET_ATI                &h877C
#EndIf

#Ifndef GL_ATI_fragment_shader
#define GL_FRAGMENT_SHADER_ATI            &h8920
#define GL_REG_0_ATI                      &h8921
#define GL_REG_1_ATI                      &h8922
#define GL_REG_2_ATI                      &h8923
#define GL_REG_3_ATI                      &h8924
#define GL_REG_4_ATI                      &h8925
#define GL_REG_5_ATI                      &h8926
#define GL_REG_6_ATI                      &h8927
#define GL_REG_7_ATI                      &h8928
#define GL_REG_8_ATI                      &h8929
#define GL_REG_9_ATI                      &h892A
#define GL_REG_10_ATI                     &h892B
#define GL_REG_11_ATI                     &h892C
#define GL_REG_12_ATI                     &h892D
#define GL_REG_13_ATI                     &h892E
#define GL_REG_14_ATI                     &h892F
#define GL_REG_15_ATI                     &h8930
#define GL_REG_16_ATI                     &h8931
#define GL_REG_17_ATI                     &h8932
#define GL_REG_18_ATI                     &h8933
#define GL_REG_19_ATI                     &h8934
#define GL_REG_20_ATI                     &h8935
#define GL_REG_21_ATI                     &h8936
#define GL_REG_22_ATI                     &h8937
#define GL_REG_23_ATI                     &h8938
#define GL_REG_24_ATI                     &h8939
#define GL_REG_25_ATI                     &h893A
#define GL_REG_26_ATI                     &h893B
#define GL_REG_27_ATI                     &h893C
#define GL_REG_28_ATI                     &h893D
#define GL_REG_29_ATI                     &h893E
#define GL_REG_30_ATI                     &h893F
#define GL_REG_31_ATI                     &h8940
#define GL_CON_0_ATI                      &h8941
#define GL_CON_1_ATI                      &h8942
#define GL_CON_2_ATI                      &h8943
#define GL_CON_3_ATI                      &h8944
#define GL_CON_4_ATI                      &h8945
#define GL_CON_5_ATI                      &h8946
#define GL_CON_6_ATI                      &h8947
#define GL_CON_7_ATI                      &h8948
#define GL_CON_8_ATI                      &h8949
#define GL_CON_9_ATI                      &h894A
#define GL_CON_10_ATI                     &h894B
#define GL_CON_11_ATI                     &h894C
#define GL_CON_12_ATI                     &h894D
#define GL_CON_13_ATI                     &h894E
#define GL_CON_14_ATI                     &h894F
#define GL_CON_15_ATI                     &h8950
#define GL_CON_16_ATI                     &h8951
#define GL_CON_17_ATI                     &h8952
#define GL_CON_18_ATI                     &h8953
#define GL_CON_19_ATI                     &h8954
#define GL_CON_20_ATI                     &h8955
#define GL_CON_21_ATI                     &h8956
#define GL_CON_22_ATI                     &h8957
#define GL_CON_23_ATI                     &h8958
#define GL_CON_24_ATI                     &h8959
#define GL_CON_25_ATI                     &h895A
#define GL_CON_26_ATI                     &h895B
#define GL_CON_27_ATI                     &h895C
#define GL_CON_28_ATI                     &h895D
#define GL_CON_29_ATI                     &h895E
#define GL_CON_30_ATI                     &h895F
#define GL_CON_31_ATI                     &h8960
#define GL_MOV_ATI                        &h8961
#define GL_ADD_ATI                        &h8963
#define GL_MUL_ATI                        &h8964
#define GL_SUB_ATI                        &h8965
#define GL_DOT3_ATI                       &h8966
#define GL_DOT4_ATI                       &h8967
#define GL_MAD_ATI                        &h8968
#define GL_LERP_ATI                       &h8969
#define GL_CND_ATI                        &h896A
#define GL_CND0_ATI                       &h896B
#define GL_DOT2_ADD_ATI                   &h896C
#define GL_SECONDARY_INTERPOLATOR_ATI     &h896D
#define GL_NUM_FRAGMENT_REGISTERS_ATI     &h896E
#define GL_NUM_FRAGMENT_CONSTANTS_ATI     &h896F
#define GL_NUM_PASSES_ATI                 &h8970
#define GL_NUM_INSTRUCTIONS_PER_PASS_ATI  &h8971
#define GL_NUM_INSTRUCTIONS_TOTAL_ATI     &h8972
#define GL_NUM_INPUT_INTERPOLATOR_COMPONENTS_ATI &h8973
#define GL_NUM_LOOPBACK_COMPONENTS_ATI    &h8974
#define GL_COLOR_ALPHA_PAIRING_ATI        &h8975
#define GL_SWIZZLE_STR_ATI                &h8976
#define GL_SWIZZLE_STQ_ATI                &h8977
#define GL_SWIZZLE_STR_DR_ATI             &h8978
#define GL_SWIZZLE_STQ_DQ_ATI             &h8979
#define GL_SWIZZLE_STRQ_ATI               &h897A
#define GL_SWIZZLE_STRQ_DQ_ATI            &h897B
#define GL_RED_BIT_ATI                    &h00000001
#define GL_GREEN_BIT_ATI                  &h00000002
#define GL_BLUE_BIT_ATI                   &h00000004
#define GL_2X_BIT_ATI                     &h00000001
#define GL_4X_BIT_ATI                     &h00000002
#define GL_8X_BIT_ATI                     &h00000004
#define GL_HALF_BIT_ATI                   &h00000008
#define GL_QUARTER_BIT_ATI                &h00000010
#define GL_EIGHTH_BIT_ATI                 &h00000020
#define GL_SATURATE_BIT_ATI               &h00000040
#define GL_COMP_BIT_ATI                   &h00000002
#define GL_NEGATE_BIT_ATI                 &h00000004
#define GL_BIAS_BIT_ATI                   &h00000008
#EndIf

#Ifndef GL_ATI_pn_triangles
#define GL_PN_TRIANGLES_ATI               &h87F0
#define GL_MAX_PN_TRIANGLES_TESSELATION_LEVEL_ATI &h87F1
#define GL_PN_TRIANGLES_POINT_MODE_ATI    &h87F2
#define GL_PN_TRIANGLES_NORMAL_MODE_ATI   &h87F3
#define GL_PN_TRIANGLES_TESSELATION_LEVEL_ATI &h87F4
#define GL_PN_TRIANGLES_POINT_MODE_LINEAR_ATI &h87F5
#define GL_PN_TRIANGLES_POINT_MODE_CUBIC_ATI &h87F6
#define GL_PN_TRIANGLES_NORMAL_MODE_LINEAR_ATI &h87F7
#define GL_PN_TRIANGLES_NORMAL_MODE_QUADRATIC_ATI &h87F8
#EndIf

#Ifndef GL_ATI_vertex_array_object
#define GL_STATIC_ATI                     &h8760
#define GL_DYNAMIC_ATI                    &h8761
#define GL_PRESERVE_ATI                   &h8762
#define GL_DISCARD_ATI                    &h8763
#define GL_OBJECT_BUFFER_SIZE_ATI         &h8764
#define GL_OBJECT_BUFFER_USAGE_ATI        &h8765
#define GL_ARRAY_OBJECT_BUFFER_ATI        &h8766
#define GL_ARRAY_OBJECT_OFFSET_ATI        &h8767
#EndIf

#Ifndef GL_EXT_vertex_shader
#define GL_VERTEX_SHADER_EXT              &h8780
#define GL_VERTEX_SHADER_BINDING_EXT      &h8781
#define GL_OP_INDEX_EXT                   &h8782
#define GL_OP_NEGATE_EXT                  &h8783
#define GL_OP_DOT3_EXT                    &h8784
#define GL_OP_DOT4_EXT                    &h8785
#define GL_OP_MUL_EXT                     &h8786
#define GL_OP_ADD_EXT                     &h8787
#define GL_OP_MADD_EXT                    &h8788
#define GL_OP_FRAC_EXT                    &h8789
#define GL_OP_MAX_EXT                     &h878A
#define GL_OP_MIN_EXT                     &h878B
#define GL_OP_SET_GE_EXT                  &h878C
#define GL_OP_SET_LT_EXT                  &h878D
#define GL_OP_CLAMP_EXT                   &h878E
#define GL_OP_FLOOR_EXT                   &h878F
#define GL_OP_ROUND_EXT                   &h8790
#define GL_OP_EXP_BASE_2_EXT              &h8791
#define GL_OP_LOG_BASE_2_EXT              &h8792
#define GL_OP_POWER_EXT                   &h8793
#define GL_OP_RECIP_EXT                   &h8794
#define GL_OP_RECIP_SQRT_EXT              &h8795
#define GL_OP_SUB_EXT                     &h8796
#define GL_OP_CROSS_PRODUCT_EXT           &h8797
#define GL_OP_MULTIPLY_MATRIX_EXT         &h8798
#define GL_OP_MOV_EXT                     &h8799
#define GL_OUTPUT_VERTEX_EXT              &h879A
#define GL_OUTPUT_COLOR0_EXT              &h879B
#define GL_OUTPUT_COLOR1_EXT              &h879C
#define GL_OUTPUT_TEXTURE_COORD0_EXT      &h879D
#define GL_OUTPUT_TEXTURE_COORD1_EXT      &h879E
#define GL_OUTPUT_TEXTURE_COORD2_EXT      &h879F
#define GL_OUTPUT_TEXTURE_COORD3_EXT      &h87A0
#define GL_OUTPUT_TEXTURE_COORD4_EXT      &h87A1
#define GL_OUTPUT_TEXTURE_COORD5_EXT      &h87A2
#define GL_OUTPUT_TEXTURE_COORD6_EXT      &h87A3
#define GL_OUTPUT_TEXTURE_COORD7_EXT      &h87A4
#define GL_OUTPUT_TEXTURE_COORD8_EXT      &h87A5
#define GL_OUTPUT_TEXTURE_COORD9_EXT      &h87A6
#define GL_OUTPUT_TEXTURE_COORD10_EXT     &h87A7
#define GL_OUTPUT_TEXTURE_COORD11_EXT     &h87A8
#define GL_OUTPUT_TEXTURE_COORD12_EXT     &h87A9
#define GL_OUTPUT_TEXTURE_COORD13_EXT     &h87AA
#define GL_OUTPUT_TEXTURE_COORD14_EXT     &h87AB
#define GL_OUTPUT_TEXTURE_COORD15_EXT     &h87AC
#define GL_OUTPUT_TEXTURE_COORD16_EXT     &h87AD
#define GL_OUTPUT_TEXTURE_COORD17_EXT     &h87AE
#define GL_OUTPUT_TEXTURE_COORD18_EXT     &h87AF
#define GL_OUTPUT_TEXTURE_COORD19_EXT     &h87B0
#define GL_OUTPUT_TEXTURE_COORD20_EXT     &h87B1
#define GL_OUTPUT_TEXTURE_COORD21_EXT     &h87B2
#define GL_OUTPUT_TEXTURE_COORD22_EXT     &h87B3
#define GL_OUTPUT_TEXTURE_COORD23_EXT     &h87B4
#define GL_OUTPUT_TEXTURE_COORD24_EXT     &h87B5
#define GL_OUTPUT_TEXTURE_COORD25_EXT     &h87B6
#define GL_OUTPUT_TEXTURE_COORD26_EXT     &h87B7
#define GL_OUTPUT_TEXTURE_COORD27_EXT     &h87B8
#define GL_OUTPUT_TEXTURE_COORD28_EXT     &h87B9
#define GL_OUTPUT_TEXTURE_COORD29_EXT     &h87BA
#define GL_OUTPUT_TEXTURE_COORD30_EXT     &h87BB
#define GL_OUTPUT_TEXTURE_COORD31_EXT     &h87BC
#define GL_OUTPUT_FOG_EXT                 &h87BD
#define GL_SCALAR_EXT                     &h87BE
#define GL_VECTOR_EXT                     &h87BF
#define GL_MATRIX_EXT                     &h87C0
#define GL_VARIANT_EXT                    &h87C1
#define GL_INVARIANT_EXT                  &h87C2
#define GL_LOCAL_CONSTANT_EXT             &h87C3
#define GL_LOCAL_EXT                      &h87C4
#define GL_MAX_VERTEX_SHADER_INSTRUCTIONS_EXT &h87C5
#define GL_MAX_VERTEX_SHADER_VARIANTS_EXT &h87C6
#define GL_MAX_VERTEX_SHADER_INVARIANTS_EXT &h87C7
#define GL_MAX_VERTEX_SHADER_LOCAL_CONSTANTS_EXT &h87C8
#define GL_MAX_VERTEX_SHADER_LOCALS_EXT   &h87C9
#define GL_MAX_OPTIMIZED_VERTEX_SHADER_INSTRUCTIONS_EXT &h87CA
#define GL_MAX_OPTIMIZED_VERTEX_SHADER_VARIANTS_EXT &h87CB
#define GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCAL_CONSTANTS_EXT &h87CC
#define GL_MAX_OPTIMIZED_VERTEX_SHADER_INVARIANTS_EXT &h87CD
#define GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCALS_EXT &h87CE
#define GL_VERTEX_SHADER_INSTRUCTIONS_EXT &h87CF
#define GL_VERTEX_SHADER_VARIANTS_EXT     &h87D0
#define GL_VERTEX_SHADER_INVARIANTS_EXT   &h87D1
#define GL_VERTEX_SHADER_LOCAL_CONSTANTS_EXT &h87D2
#define GL_VERTEX_SHADER_LOCALS_EXT       &h87D3
#define GL_VERTEX_SHADER_OPTIMIZED_EXT    &h87D4
#define GL_X_EXT                          &h87D5
#define GL_Y_EXT                          &h87D6
#define GL_Z_EXT                          &h87D7
#define GL_W_EXT                          &h87D8
#define GL_NEGATIVE_X_EXT                 &h87D9
#define GL_NEGATIVE_Y_EXT                 &h87DA
#define GL_NEGATIVE_Z_EXT                 &h87DB
#define GL_NEGATIVE_W_EXT                 &h87DC
#define GL_ZERO_EXT                       &h87DD
#define GL_ONE_EXT                        &h87DE
#define GL_NEGATIVE_ONE_EXT               &h87DF
#define GL_NORMALIZED_RANGE_EXT           &h87E0
#define GL_FULL_RANGE_EXT                 &h87E1
#define GL_CURRENT_VERTEX_EXT             &h87E2
#define GL_MVP_MATRIX_EXT                 &h87E3
#define GL_VARIANT_VALUE_EXT              &h87E4
#define GL_VARIANT_DATATYPE_EXT           &h87E5
#define GL_VARIANT_ARRAY_STRIDE_EXT       &h87E6
#define GL_VARIANT_ARRAY_TYPE_EXT         &h87E7
#define GL_VARIANT_ARRAY_EXT              &h87E8
#define GL_VARIANT_ARRAY_POINTER_EXT      &h87E9
#define GL_INVARIANT_VALUE_EXT            &h87EA
#define GL_INVARIANT_DATATYPE_EXT         &h87EB
#define GL_LOCAL_CONSTANT_VALUE_EXT       &h87EC
#define GL_LOCAL_CONSTANT_DATATYPE_EXT    &h87ED
#EndIf

#Ifndef GL_ATI_vertex_streams
#define GL_MAX_VERTEX_STREAMS_ATI         &h876B
#define GL_VERTEX_STREAM0_ATI             &h876C
#define GL_VERTEX_STREAM1_ATI             &h876D
#define GL_VERTEX_STREAM2_ATI             &h876E
#define GL_VERTEX_STREAM3_ATI             &h876F
#define GL_VERTEX_STREAM4_ATI             &h8770
#define GL_VERTEX_STREAM5_ATI             &h8771
#define GL_VERTEX_STREAM6_ATI             &h8772
#define GL_VERTEX_STREAM7_ATI             &h8773
#define GL_VERTEX_SOURCE_ATI              &h8774
#EndIf

#Ifndef GL_ATI_element_array
#define GL_ELEMENT_ARRAY_ATI              &h8768
#define GL_ELEMENT_ARRAY_TYPE_ATI         &h8769
#define GL_ELEMENT_ARRAY_POINTER_ATI      &h876A
#EndIf

#Ifndef GL_SUN_mesh_array
#define GL_QUAD_MESH_SUN                  &h8614
#define GL_TRIANGLE_MESH_SUN              &h8615
#EndIf

#Ifndef GL_SUN_slice_accum
#define GL_SLICE_ACCUM_SUN                &h85CC
#EndIf

#Ifndef GL_NV_multisample_filter_hint
#define GL_MULTISAMPLE_FILTER_HINT_NV     &h8534
#EndIf

#Ifndef GL_NV_depth_clamp
#define GL_DEPTH_CLAMP_NV                 &h864F
#EndIf

#Ifndef GL_NV_occlusion_query
#define GL_PIXEL_COUNTER_BITS_NV          &h8864
#define GL_CURRENT_OCCLUSION_QUERY_ID_NV  &h8865
#define GL_PIXEL_COUNT_NV                 &h8866
#define GL_PIXEL_COUNT_AVAILABLE_NV       &h8867
#EndIf

#Ifndef GL_NV_point_sprite
#define GL_POINT_SPRITE_NV                &h8861
#define GL_COORD_REPLACE_NV               &h8862
#define GL_POINT_SPRITE_R_MODE_NV         &h8863
#EndIf

#Ifndef GL_NV_texture_shader3
#define GL_OFFSET_PROJECTIVE_TEXTURE_2D_NV &h8850
#define GL_OFFSET_PROJECTIVE_TEXTURE_2D_SCALE_NV &h8851
#define GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_NV &h8852
#define GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_SCALE_NV &h8853
#define GL_OFFSET_HILO_TEXTURE_2D_NV      &h8854
#define GL_OFFSET_HILO_TEXTURE_RECTANGLE_NV &h8855
#define GL_OFFSET_HILO_PROJECTIVE_TEXTURE_2D_NV &h8856
#define GL_OFFSET_HILO_PROJECTIVE_TEXTURE_RECTANGLE_NV &h8857
#define GL_DEPENDENT_HILO_TEXTURE_2D_NV   &h8858
#define GL_DEPENDENT_RGB_TEXTURE_3D_NV    &h8859
#define GL_DEPENDENT_RGB_TEXTURE_CUBE_MAP_NV &h885A
#define GL_DOT_PRODUCT_PASS_THROUGH_NV    &h885B
#define GL_DOT_PRODUCT_TEXTURE_1D_NV      &h885C
#define GL_DOT_PRODUCT_AFFINE_DEPTH_REPLACE_NV &h885D
#define GL_HILO8_NV                       &h885E
#define GL_SIGNED_HILO8_NV                &h885F
#define GL_FORCE_BLUE_TO_ONE_NV           &h8860
#EndIf

#Ifndef GL_NV_vertex_program1_1
#EndIf

#Ifndef GL_EXT_shadow_funcs
#EndIf

#Ifndef GL_EXT_stencil_two_side
#define GL_STENCIL_TEST_TWO_SIDE_EXT      &h8910
#define GL_ACTIVE_STENCIL_FACE_EXT        &h8911
#EndIf

#Ifndef GL_ATI_text_fragment_shader
#define GL_TEXT_FRAGMENT_SHADER_ATI       &h8200
#EndIf

#Ifndef GL_APPLE_client_storage
#define GL_UNPACK_CLIENT_STORAGE_APPLE    &h85B2
#EndIf

#Ifndef GL_APPLE_element_array
#define GL_ELEMENT_ARRAY_APPLE            &h8A0C
#define GL_ELEMENT_ARRAY_TYPE_APPLE       &h8A0D
#define GL_ELEMENT_ARRAY_POINTER_APPLE    &h8A0E
#EndIf

#Ifndef GL_APPLE_fence
#define GL_DRAW_PIXELS_APPLE              &h8A0A
#define GL_FENCE_APPLE                    &h8A0B
#EndIf

#Ifndef GL_APPLE_vertex_array_object
#define GL_VERTEX_ARRAY_BINDING_APPLE     &h85B5
#EndIf

#Ifndef GL_APPLE_vertex_array_range
#define GL_VERTEX_ARRAY_RANGE_APPLE       &h851D
#define GL_VERTEX_ARRAY_RANGE_LENGTH_APPLE &h851E
#define GL_VERTEX_ARRAY_STORAGE_HINT_APPLE &h851F
#define GL_VERTEX_ARRAY_RANGE_POINTER_APPLE &h8521
#define GL_STORAGE_CLIENT_APPLE           &h85B4
#define GL_STORAGE_CACHED_APPLE           &h85BE
#define GL_STORAGE_SHARED_APPLE           &h85BF
#EndIf

#Ifndef GL_APPLE_ycbcr_422
#define GL_YCBCR_422_APPLE                &h85B9
#define GL_UNSIGNED_SHORT_8_8_APPLE       &h85BA
#define GL_UNSIGNED_SHORT_8_8_REV_APPLE   &h85BB
#EndIf

#Ifndef GL_S3_s3tc
#define GL_RGB_S3TC                       &h83A0
#define GL_RGB4_S3TC                      &h83A1
#define GL_RGBA_S3TC                      &h83A2
#define GL_RGBA4_S3TC                     &h83A3
#EndIf

#Ifndef GL_ATI_draw_buffers
#define GL_MAX_DRAW_BUFFERS_ATI           &h8824
#define GL_DRAW_BUFFER0_ATI               &h8825
#define GL_DRAW_BUFFER1_ATI               &h8826
#define GL_DRAW_BUFFER2_ATI               &h8827
#define GL_DRAW_BUFFER3_ATI               &h8828
#define GL_DRAW_BUFFER4_ATI               &h8829
#define GL_DRAW_BUFFER5_ATI               &h882A
#define GL_DRAW_BUFFER6_ATI               &h882B
#define GL_DRAW_BUFFER7_ATI               &h882C
#define GL_DRAW_BUFFER8_ATI               &h882D
#define GL_DRAW_BUFFER9_ATI               &h882E
#define GL_DRAW_BUFFER10_ATI              &h882F
#define GL_DRAW_BUFFER11_ATI              &h8830
#define GL_DRAW_BUFFER12_ATI              &h8831
#define GL_DRAW_BUFFER13_ATI              &h8832
#define GL_DRAW_BUFFER14_ATI              &h8833
#define GL_DRAW_BUFFER15_ATI              &h8834
#EndIf

#Ifndef GL_ATI_pixel_format_float
#define GL_TYPE_RGBA_FLOAT_ATI            &h8820
#define GL_COLOR_CLEAR_UNCLAMPED_VALUE_ATI &h8835
#EndIf

#Ifndef GL_ATI_texture_env_combine3
#define GL_MODULATE_ADD_ATI               &h8744
#define GL_MODULATE_SIGNED_ADD_ATI        &h8745
#define GL_MODULATE_SUBTRACT_ATI          &h8746
#EndIf

#Ifndef GL_ATI_texture_float
#define GL_RGBA_FLOAT32_ATI               &h8814
#define GL_RGB_FLOAT32_ATI                &h8815
#define GL_ALPHA_FLOAT32_ATI              &h8816
#define GL_INTENSITY_FLOAT32_ATI          &h8817
#define GL_LUMINANCE_FLOAT32_ATI          &h8818
#define GL_LUMINANCE_ALPHA_FLOAT32_ATI    &h8819
#define GL_RGBA_FLOAT16_ATI               &h881A
#define GL_RGB_FLOAT16_ATI                &h881B
#define GL_ALPHA_FLOAT16_ATI              &h881C
#define GL_INTENSITY_FLOAT16_ATI          &h881D
#define GL_LUMINANCE_FLOAT16_ATI          &h881E
#define GL_LUMINANCE_ALPHA_FLOAT16_ATI    &h881F
#EndIf

#Ifndef GL_NV_float_buffer
#define GL_FLOAT_R_NV                     &h8880
#define GL_FLOAT_RG_NV                    &h8881
#define GL_FLOAT_RGB_NV                   &h8882
#define GL_FLOAT_RGBA_NV                  &h8883
#define GL_FLOAT_R16_NV                   &h8884
#define GL_FLOAT_R32_NV                   &h8885
#define GL_FLOAT_RG16_NV                  &h8886
#define GL_FLOAT_RG32_NV                  &h8887
#define GL_FLOAT_RGB16_NV                 &h8888
#define GL_FLOAT_RGB32_NV                 &h8889
#define GL_FLOAT_RGBA16_NV                &h888A
#define GL_FLOAT_RGBA32_NV                &h888B
#define GL_TEXTURE_FLOAT_COMPONENTS_NV    &h888C
#define GL_FLOAT_CLEAR_COLOR_VALUE_NV     &h888D
#define GL_FLOAT_RGBA_MODE_NV             &h888E
#EndIf

#Ifndef GL_NV_fragment_program
#define GL_MAX_FRAGMENT_PROGRAM_LOCAL_PARAMETERS_NV &h8868
#define GL_FRAGMENT_PROGRAM_NV            &h8870
#define GL_MAX_TEXTURE_COORDS_NV          &h8871
#define GL_MAX_TEXTURE_IMAGE_UNITS_NV     &h8872
#define GL_FRAGMENT_PROGRAM_BINDING_NV    &h8873
#define GL_PROGRAM_ERROR_STRING_NV        &h8874
#EndIf

#Ifndef GL_NV_half_float
#define GL_HALF_FLOAT_NV                  &h140B
#EndIf

#Ifndef GL_NV_pixel_data_range
#define GL_WRITE_PIXEL_DATA_RANGE_NV      &h8878
#define GL_READ_PIXEL_DATA_RANGE_NV       &h8879
#define GL_WRITE_PIXEL_DATA_RANGE_LENGTH_NV &h887A
#define GL_READ_PIXEL_DATA_RANGE_LENGTH_NV &h887B
#define GL_WRITE_PIXEL_DATA_RANGE_POINTER_NV &h887C
#define GL_READ_PIXEL_DATA_RANGE_POINTER_NV &h887D
#EndIf

#Ifndef GL_NV_primitive_restart
#define GL_PRIMITIVE_RESTART_NV           &h8558
#define GL_PRIMITIVE_RESTART_INDEX_NV     &h8559
#EndIf

#Ifndef GL_NV_texture_expand_normal
#define GL_TEXTURE_UNSIGNED_REMAP_MODE_NV &h888F
#EndIf

#Ifndef GL_NV_vertex_program2
#EndIf

#Ifndef GL_ATI_map_object_buffer
#EndIf

#Ifndef GL_ATI_separate_stencil
#define GL_STENCIL_BACK_FUNC_ATI          &h8800
#define GL_STENCIL_BACK_FAIL_ATI          &h8801
#define GL_STENCIL_BACK_PASS_DEPTH_FAIL_ATI &h8802
#define GL_STENCIL_BACK_PASS_DEPTH_PASS_ATI &h8803
#EndIf

#Ifndef GL_ATI_vertex_attrib_array_object
#EndIf

#Ifndef GL_OES_read_format
#define GL_IMPLEMENTATION_COLOR_READ_TYPE_OES &h8B9A
#define GL_IMPLEMENTATION_COLOR_READ_FORMAT_OES &h8B9B
#EndIf

#Ifndef GL_EXT_depth_bounds_test
#define GL_DEPTH_BOUNDS_TEST_EXT          &h8890
#define GL_DEPTH_BOUNDS_EXT               &h8891
#EndIf

#Ifndef GL_EXT_texture_mirror_clamp
#define GL_MIRROR_CLAMP_EXT               &h8742
#define GL_MIRROR_CLAMP_TO_EDGE_EXT       &h8743
#define GL_MIRROR_CLAMP_TO_BORDER_EXT     &h8912
#EndIf

#Ifndef GL_EXT_blend_equation_separate
#define GL_BLEND_EQUATION_RGB_EXT         &h8009
#define GL_BLEND_EQUATION_ALPHA_EXT       &h883D
#EndIf

#Ifndef GL_MESA_pack_invert
#define GL_PACK_INVERT_MESA               &h8758
#EndIf

#Ifndef GL_MESA_ycbcr_texture
#define GL_UNSIGNED_SHORT_8_8_MESA        &h85BA
#define GL_UNSIGNED_SHORT_8_8_REV_MESA    &h85BB
#define GL_YCBCR_MESA                     &h8757
#EndIf

#Ifndef GL_EXT_pixel_buffer_object
#define GL_PIXEL_PACK_BUFFER_EXT          &h88EB
#define GL_PIXEL_UNPACK_BUFFER_EXT        &h88EC
#define GL_PIXEL_PACK_BUFFER_BINDING_EXT  &h88ED
#define GL_PIXEL_UNPACK_BUFFER_BINDING_EXT &h88EF
#EndIf

#Ifndef GL_NV_fragment_program_option
#EndIf

#Ifndef GL_NV_fragment_program2
#define GL_MAX_PROGRAM_EXEC_INSTRUCTIONS_NV &h88F4
#define GL_MAX_PROGRAM_CALL_DEPTH_NV      &h88F5
#define GL_MAX_PROGRAM_IF_DEPTH_NV        &h88F6
#define GL_MAX_PROGRAM_LOOP_DEPTH_NV      &h88F7
#define GL_MAX_PROGRAM_LOOP_COUNT_NV      &h88F8
#EndIf

#Ifndef GL_NV_vertex_program2_option
/' reuse GL_MAX_PROGRAM_EXEC_INSTRUCTIONS_NV '/
/' reuse GL_MAX_PROGRAM_CALL_DEPTH_NV '/
#EndIf

#Ifndef GL_NV_vertex_program3
/' reuse GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB '/
#EndIf

#Ifndef GL_EXT_framebuffer_object
#define GL_INVALID_FRAMEBUFFER_OPERATION_EXT &h0506
#define GL_MAX_RENDERBUFFER_SIZE_EXT      &h84E8
#define GL_FRAMEBUFFER_BINDING_EXT        &h8CA6
#define GL_RENDERBUFFER_BINDING_EXT       &h8CA7
#define GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE_EXT &h8CD0
#define GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME_EXT &h8CD1
#define GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL_EXT &h8CD2
#define GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE_EXT &h8CD3
#define GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_3D_ZOFFSET_EXT &h8CD4
#define GL_FRAMEBUFFER_COMPLETE_EXT       &h8CD5
#define GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT_EXT &h8CD6
#define GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_EXT &h8CD7
#define GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_EXT &h8CD9
#define GL_FRAMEBUFFER_INCOMPLETE_FORMATS_EXT &h8CDA
#define GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER_EXT &h8CDB
#define GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER_EXT &h8CDC
#define GL_FRAMEBUFFER_UNSUPPORTED_EXT    &h8CDD
#define GL_MAX_COLOR_ATTACHMENTS_EXT      &h8CDF
#define GL_COLOR_ATTACHMENT0_EXT          &h8CE0
#define GL_COLOR_ATTACHMENT1_EXT          &h8CE1
#define GL_COLOR_ATTACHMENT2_EXT          &h8CE2
#define GL_COLOR_ATTACHMENT3_EXT          &h8CE3
#define GL_COLOR_ATTACHMENT4_EXT          &h8CE4
#define GL_COLOR_ATTACHMENT5_EXT          &h8CE5
#define GL_COLOR_ATTACHMENT6_EXT          &h8CE6
#define GL_COLOR_ATTACHMENT7_EXT          &h8CE7
#define GL_COLOR_ATTACHMENT8_EXT          &h8CE8
#define GL_COLOR_ATTACHMENT9_EXT          &h8CE9
#define GL_COLOR_ATTACHMENT10_EXT         &h8CEA
#define GL_COLOR_ATTACHMENT11_EXT         &h8CEB
#define GL_COLOR_ATTACHMENT12_EXT         &h8CEC
#define GL_COLOR_ATTACHMENT13_EXT         &h8CED
#define GL_COLOR_ATTACHMENT14_EXT         &h8CEE
#define GL_COLOR_ATTACHMENT15_EXT         &h8CEF
#define GL_DEPTH_ATTACHMENT_EXT           &h8D00
#define GL_STENCIL_ATTACHMENT_EXT         &h8D20
#define GL_FRAMEBUFFER_EXT                &h8D40
#define GL_RENDERBUFFER_EXT               &h8D41
#define GL_RENDERBUFFER_WIDTH_EXT         &h8D42
#define GL_RENDERBUFFER_HEIGHT_EXT        &h8D43
#define GL_RENDERBUFFER_INTERNAL_FORMAT_EXT &h8D44
#define GL_STENCIL_INDEX1_EXT             &h8D46
#define GL_STENCIL_INDEX4_EXT             &h8D47
#define GL_STENCIL_INDEX8_EXT             &h8D48
#define GL_STENCIL_INDEX16_EXT            &h8D49
#define GL_RENDERBUFFER_RED_SIZE_EXT      &h8D50
#define GL_RENDERBUFFER_GREEN_SIZE_EXT    &h8D51
#define GL_RENDERBUFFER_BLUE_SIZE_EXT     &h8D52
#define GL_RENDERBUFFER_ALPHA_SIZE_EXT    &h8D53
#define GL_RENDERBUFFER_DEPTH_SIZE_EXT    &h8D54
#define GL_RENDERBUFFER_STENCIL_SIZE_EXT  &h8D55
#EndIf

#Ifndef GL_GREMEDY_string_marker
#EndIf

#Ifndef GL_EXT_packed_depth_stencil
#define GL_DEPTH_STENCIL_EXT              &h84F9
#define GL_UNSIGNED_INT_24_8_EXT          &h84FA
#define GL_DEPTH24_STENCIL8_EXT           &h88F0
#define GL_TEXTURE_STENCIL_SIZE_EXT       &h88F1
#EndIf

#Ifndef GL_EXT_stencil_clear_tag
#define GL_STENCIL_TAG_BITS_EXT           &h88F2
#define GL_STENCIL_CLEAR_TAG_VALUE_EXT    &h88F3
#EndIf

#Ifndef GL_EXT_texture_sRGB
#define GL_SRGB_EXT                       &h8C40
#define GL_SRGB8_EXT                      &h8C41
#define GL_SRGB_ALPHA_EXT                 &h8C42
#define GL_SRGB8_ALPHA8_EXT               &h8C43
#define GL_SLUMINANCE_ALPHA_EXT           &h8C44
#define GL_SLUMINANCE8_ALPHA8_EXT         &h8C45
#define GL_SLUMINANCE_EXT                 &h8C46
#define GL_SLUMINANCE8_EXT                &h8C47
#define GL_COMPRESSED_SRGB_EXT            &h8C48
#define GL_COMPRESSED_SRGB_ALPHA_EXT      &h8C49
#define GL_COMPRESSED_SLUMINANCE_EXT      &h8C4A
#define GL_COMPRESSED_SLUMINANCE_ALPHA_EXT &h8C4B
#define GL_COMPRESSED_SRGB_S3TC_DXT1_EXT  &h8C4C
#define GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT1_EXT &h8C4D
#define GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT3_EXT &h8C4E
#define GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT &h8C4F
#EndIf

#Ifndef GL_EXT_framebuffer_blit
#define GL_READ_FRAMEBUFFER_EXT           &h8CA8
#define GL_DRAW_FRAMEBUFFER_EXT           &h8CA9
#define GL_DRAW_FRAMEBUFFER_BINDING_EXT   GL_FRAMEBUFFER_BINDING_EXT
#define GL_READ_FRAMEBUFFER_BINDING_EXT   &h8CAA
#EndIf

#Ifndef GL_EXT_framebuffer_multisample
#define GL_RENDERBUFFER_SAMPLES_EXT       &h8CAB
#define GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_EXT &h8D56
#define GL_MAX_SAMPLES_EXT                &h8D57
#EndIf

#Ifndef GL_MESAX_texture_stack
#define GL_TEXTURE_1D_STACK_MESAX         &h8759
#define GL_TEXTURE_2D_STACK_MESAX         &h875A
#define GL_PROXY_TEXTURE_1D_STACK_MESAX   &h875B
#define GL_PROXY_TEXTURE_2D_STACK_MESAX   &h875C
#define GL_TEXTURE_1D_STACK_BINDING_MESAX &h875D
#define GL_TEXTURE_2D_STACK_BINDING_MESAX &h875E
#EndIf

#Ifndef GL_EXT_timer_query
#define GL_TIME_ELAPSED_EXT               &h88BF
#EndIf

#Ifndef GL_EXT_gpu_program_parameters
#EndIf

#Ifndef GL_APPLE_flush_buffer_range
#define GL_BUFFER_SERIALIZED_MODIFY_APPLE &h8A12
#define GL_BUFFER_FLUSHING_UNMAP_APPLE    &h8A13
#EndIf

#Ifndef GL_NV_gpu_program4
#define GL_MIN_PROGRAM_TEXEL_OFFSET_NV    &h8904
#define GL_MAX_PROGRAM_TEXEL_OFFSET_NV    &h8905
#define GL_PROGRAM_ATTRIB_COMPONENTS_NV   &h8906
#define GL_PROGRAM_RESULT_COMPONENTS_NV   &h8907
#define GL_MAX_PROGRAM_ATTRIB_COMPONENTS_NV &h8908
#define GL_MAX_PROGRAM_RESULT_COMPONENTS_NV &h8909
#define GL_MAX_PROGRAM_GENERIC_ATTRIBS_NV &h8DA5
#define GL_MAX_PROGRAM_GENERIC_RESULTS_NV &h8DA6
#EndIf

#Ifndef GL_NV_geometry_program4
#define GL_LINES_ADJACENCY_EXT            &h000A
#define GL_LINE_STRIP_ADJACENCY_EXT       &h000B
#define GL_TRIANGLES_ADJACENCY_EXT        &h000C
#define GL_TRIANGLE_STRIP_ADJACENCY_EXT   &h000D
#define GL_GEOMETRY_PROGRAM_NV            &h8C26
#define GL_MAX_PROGRAM_OUTPUT_VERTICES_NV &h8C27
#define GL_MAX_PROGRAM_TOTAL_OUTPUT_COMPONENTS_NV &h8C28
#define GL_GEOMETRY_VERTICES_OUT_EXT      &h8DDA
#define GL_GEOMETRY_INPUT_TYPE_EXT        &h8DDB
#define GL_GEOMETRY_OUTPUT_TYPE_EXT       &h8DDC
#define GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT &h8C29
#define GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT &h8DA7
#define GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_EXT &h8DA8
#define GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_EXT &h8DA9
#define GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT &h8CD4
#define GL_PROGRAM_POINT_SIZE_EXT         &h8642
#EndIf

#Ifndef GL_EXT_geometry_shader4
#define GL_GEOMETRY_SHADER_EXT            &h8DD9
/' reuse GL_GEOMETRY_VERTICES_OUT_EXT '/
/' reuse GL_GEOMETRY_INPUT_TYPE_EXT '/
/' reuse GL_GEOMETRY_OUTPUT_TYPE_EXT '/
/' reuse GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT '/
#define GL_MAX_GEOMETRY_VARYING_COMPONENTS_EXT &h8DDD
#define GL_MAX_VERTEX_VARYING_COMPONENTS_EXT &h8DDE
#define GL_MAX_VARYING_COMPONENTS_EXT     &h8B4B
#define GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT &h8DDF
#define GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT &h8DE0
#define GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT &h8DE1
/' reuse GL_LINES_ADJACENCY_EXT '/
/' reuse GL_LINE_STRIP_ADJACENCY_EXT '/
/' reuse GL_TRIANGLES_ADJACENCY_EXT '/
/' reuse GL_TRIANGLE_STRIP_ADJACENCY_EXT '/
/' reuse GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_EXT '/
/' reuse GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_EXT '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT '/
/' reuse GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT '/
/' reuse GL_PROGRAM_POINT_SIZE_EXT '/
#EndIf

#Ifndef GL_NV_vertex_program4
#define GL_VERTEX_ATTRIB_ARRAY_INTEGER_NV &h88FD
#EndIf

#Ifndef GL_EXT_gpu_shader4
#define GL_SAMPLER_1D_ARRAY_EXT           &h8DC0
#define GL_SAMPLER_2D_ARRAY_EXT           &h8DC1
#define GL_SAMPLER_BUFFER_EXT             &h8DC2
#define GL_SAMPLER_1D_ARRAY_SHADOW_EXT    &h8DC3
#define GL_SAMPLER_2D_ARRAY_SHADOW_EXT    &h8DC4
#define GL_SAMPLER_CUBE_SHADOW_EXT        &h8DC5
#define GL_UNSIGNED_INT_VEC2_EXT          &h8DC6
#define GL_UNSIGNED_INT_VEC3_EXT          &h8DC7
#define GL_UNSIGNED_INT_VEC4_EXT          &h8DC8
#define GL_INT_SAMPLER_1D_EXT             &h8DC9
#define GL_INT_SAMPLER_2D_EXT             &h8DCA
#define GL_INT_SAMPLER_3D_EXT             &h8DCB
#define GL_INT_SAMPLER_CUBE_EXT           &h8DCC
#define GL_INT_SAMPLER_2D_RECT_EXT        &h8DCD
#define GL_INT_SAMPLER_1D_ARRAY_EXT       &h8DCE
#define GL_INT_SAMPLER_2D_ARRAY_EXT       &h8DCF
#define GL_INT_SAMPLER_BUFFER_EXT         &h8DD0
#define GL_UNSIGNED_INT_SAMPLER_1D_EXT    &h8DD1
#define GL_UNSIGNED_INT_SAMPLER_2D_EXT    &h8DD2
#define GL_UNSIGNED_INT_SAMPLER_3D_EXT    &h8DD3
#define GL_UNSIGNED_INT_SAMPLER_CUBE_EXT  &h8DD4
#define GL_UNSIGNED_INT_SAMPLER_2D_RECT_EXT &h8DD5
#define GL_UNSIGNED_INT_SAMPLER_1D_ARRAY_EXT &h8DD6
#define GL_UNSIGNED_INT_SAMPLER_2D_ARRAY_EXT &h8DD7
#define GL_UNSIGNED_INT_SAMPLER_BUFFER_EXT &h8DD8
#EndIf

#Ifndef GL_EXT_draw_instanced
#EndIf

#Ifndef GL_EXT_packed_float
#define GL_R11F_G11F_B10F_EXT             &h8C3A
#define GL_UNSIGNED_INT_10F_11F_11F_REV_EXT &h8C3B
#define GL_RGBA_SIGNED_COMPONENTS_EXT     &h8C3C
#EndIf

#Ifndef GL_EXT_texture_array
#define GL_TEXTURE_1D_ARRAY_EXT           &h8C18
#define GL_PROXY_TEXTURE_1D_ARRAY_EXT     &h8C19
#define GL_TEXTURE_2D_ARRAY_EXT           &h8C1A
#define GL_PROXY_TEXTURE_2D_ARRAY_EXT     &h8C1B
#define GL_TEXTURE_BINDING_1D_ARRAY_EXT   &h8C1C
#define GL_TEXTURE_BINDING_2D_ARRAY_EXT   &h8C1D
#define GL_MAX_ARRAY_TEXTURE_LAYERS_EXT   &h88FF
#define GL_COMPARE_REF_DEPTH_TO_TEXTURE_EXT &h884E
/' reuse GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT '/
#EndIf

#Ifndef GL_EXT_texture_buffer_object
#define GL_TEXTURE_BUFFER_EXT             &h8C2A
#define GL_MAX_TEXTURE_BUFFER_SIZE_EXT    &h8C2B
#define GL_TEXTURE_BINDING_BUFFER_EXT     &h8C2C
#define GL_TEXTURE_BUFFER_DATA_STORE_BINDING_EXT &h8C2D
#define GL_TEXTURE_BUFFER_FORMAT_EXT      &h8C2E
#EndIf

#Ifndef GL_EXT_texture_compression_latc
#define GL_COMPRESSED_LUMINANCE_LATC1_EXT &h8C70
#define GL_COMPRESSED_SIGNED_LUMINANCE_LATC1_EXT &h8C71
#define GL_COMPRESSED_LUMINANCE_ALPHA_LATC2_EXT &h8C72
#define GL_COMPRESSED_SIGNED_LUMINANCE_ALPHA_LATC2_EXT &h8C73
#EndIf

#Ifndef GL_EXT_texture_compression_rgtc
#define GL_COMPRESSED_RED_RGTC1_EXT       &h8DBB
#define GL_COMPRESSED_SIGNED_RED_RGTC1_EXT &h8DBC
#define GL_COMPRESSED_RED_GREEN_RGTC2_EXT &h8DBD
#define GL_COMPRESSED_SIGNED_RED_GREEN_RGTC2_EXT &h8DBE
#EndIf

#Ifndef GL_EXT_texture_shared_exponent
#define GL_RGB9_E5_EXT                    &h8C3D
#define GL_UNSIGNED_INT_5_9_9_9_REV_EXT   &h8C3E
#define GL_TEXTURE_SHARED_SIZE_EXT        &h8C3F
#EndIf

#Ifndef GL_NV_depth_buffer_float
#define GL_DEPTH_COMPONENT32F_NV          &h8DAB
#define GL_DEPTH32F_STENCIL8_NV           &h8DAC
#define GL_FLOAT_32_UNSIGNED_INT_24_8_REV_NV &h8DAD
#define GL_DEPTH_BUFFER_FLOAT_MODE_NV     &h8DAF
#EndIf

#Ifndef GL_NV_fragment_program4
#EndIf

#Ifndef GL_NV_framebuffer_multisample_coverage
#define GL_RENDERBUFFER_COVERAGE_SAMPLES_NV &h8CAB
#define GL_RENDERBUFFER_COLOR_SAMPLES_NV  &h8E10
#define GL_MAX_MULTISAMPLE_COVERAGE_MODES_NV &h8E11
#define GL_MULTISAMPLE_COVERAGE_MODES_NV  &h8E12
#EndIf

#Ifndef GL_EXT_framebuffer_sRGB
#define GL_FRAMEBUFFER_SRGB_EXT           &h8DB9
#define GL_FRAMEBUFFER_SRGB_CAPABLE_EXT   &h8DBA
#EndIf

#Ifndef GL_NV_geometry_shader4
#EndIf

#Ifndef GL_NV_parameter_buffer_object
#define GL_MAX_PROGRAM_PARAMETER_BUFFER_BINDINGS_NV &h8DA0
#define GL_MAX_PROGRAM_PARAMETER_BUFFER_SIZE_NV &h8DA1
#define GL_VERTEX_PROGRAM_PARAMETER_BUFFER_NV &h8DA2
#define GL_GEOMETRY_PROGRAM_PARAMETER_BUFFER_NV &h8DA3
#define GL_FRAGMENT_PROGRAM_PARAMETER_BUFFER_NV &h8DA4
#EndIf

#Ifndef GL_EXT_draw_buffers2
#EndIf

#Ifndef GL_NV_transform_feedback
#define GL_BACK_PRIMARY_COLOR_NV          &h8C77
#define GL_BACK_SECONDARY_COLOR_NV        &h8C78
#define GL_TEXTURE_COORD_NV               &h8C79
#define GL_CLIP_DISTANCE_NV               &h8C7A
#define GL_VERTEX_ID_NV                   &h8C7B
#define GL_PRIMITIVE_ID_NV                &h8C7C
#define GL_GENERIC_ATTRIB_NV              &h8C7D
#define GL_TRANSFORM_FEEDBACK_ATTRIBS_NV  &h8C7E
#define GL_TRANSFORM_FEEDBACK_BUFFER_MODE_NV &h8C7F
#define GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_NV &h8C80
#define GL_ACTIVE_VARYINGS_NV             &h8C81
#define GL_ACTIVE_VARYING_MAX_LENGTH_NV   &h8C82
#define GL_TRANSFORM_FEEDBACK_VARYINGS_NV &h8C83
#define GL_TRANSFORM_FEEDBACK_BUFFER_START_NV &h8C84
#define GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_NV &h8C85
#define GL_TRANSFORM_FEEDBACK_RECORD_NV   &h8C86
#define GL_PRIMITIVES_GENERATED_NV        &h8C87
#define GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_NV &h8C88
#define GL_RASTERIZER_DISCARD_NV          &h8C89
#define GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_ATTRIBS_NV &h8C8A
#define GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_NV &h8C8B
#define GL_INTERLEAVED_ATTRIBS_NV         &h8C8C
#define GL_SEPARATE_ATTRIBS_NV            &h8C8D
#define GL_TRANSFORM_FEEDBACK_BUFFER_NV   &h8C8E
#define GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_NV &h8C8F
#define GL_LAYER_NV                       &h8DAA
#define GL_NEXT_BUFFER_NV                 -2
#define GL_SKIP_COMPONENTS4_NV            -3
#define GL_SKIP_COMPONENTS3_NV            -4
#define GL_SKIP_COMPONENTS2_NV            -5
#define GL_SKIP_COMPONENTS1_NV            -6
#EndIf

#Ifndef GL_EXT_bindable_uniform
#define GL_MAX_VERTEX_BINDABLE_UNIFORMS_EXT &h8DE2
#define GL_MAX_FRAGMENT_BINDABLE_UNIFORMS_EXT &h8DE3
#define GL_MAX_GEOMETRY_BINDABLE_UNIFORMS_EXT &h8DE4
#define GL_MAX_BINDABLE_UNIFORM_SIZE_EXT  &h8DED
#define GL_UNIFORM_BUFFER_EXT             &h8DEE
#define GL_UNIFORM_BUFFER_BINDING_EXT     &h8DEF
#EndIf

#Ifndef GL_EXT_texture_integer
#define GL_RGBA32UI_EXT                   &h8D70
#define GL_RGB32UI_EXT                    &h8D71
#define GL_ALPHA32UI_EXT                  &h8D72
#define GL_INTENSITY32UI_EXT              &h8D73
#define GL_LUMINANCE32UI_EXT              &h8D74
#define GL_LUMINANCE_ALPHA32UI_EXT        &h8D75
#define GL_RGBA16UI_EXT                   &h8D76
#define GL_RGB16UI_EXT                    &h8D77
#define GL_ALPHA16UI_EXT                  &h8D78
#define GL_INTENSITY16UI_EXT              &h8D79
#define GL_LUMINANCE16UI_EXT              &h8D7A
#define GL_LUMINANCE_ALPHA16UI_EXT        &h8D7B
#define GL_RGBA8UI_EXT                    &h8D7C
#define GL_RGB8UI_EXT                     &h8D7D
#define GL_ALPHA8UI_EXT                   &h8D7E
#define GL_INTENSITY8UI_EXT               &h8D7F
#define GL_LUMINANCE8UI_EXT               &h8D80
#define GL_LUMINANCE_ALPHA8UI_EXT         &h8D81
#define GL_RGBA32I_EXT                    &h8D82
#define GL_RGB32I_EXT                     &h8D83
#define GL_ALPHA32I_EXT                   &h8D84
#define GL_INTENSITY32I_EXT               &h8D85
#define GL_LUMINANCE32I_EXT               &h8D86
#define GL_LUMINANCE_ALPHA32I_EXT         &h8D87
#define GL_RGBA16I_EXT                    &h8D88
#define GL_RGB16I_EXT                     &h8D89
#define GL_ALPHA16I_EXT                   &h8D8A
#define GL_INTENSITY16I_EXT               &h8D8B
#define GL_LUMINANCE16I_EXT               &h8D8C
#define GL_LUMINANCE_ALPHA16I_EXT         &h8D8D
#define GL_RGBA8I_EXT                     &h8D8E
#define GL_RGB8I_EXT                      &h8D8F
#define GL_ALPHA8I_EXT                    &h8D90
#define GL_INTENSITY8I_EXT                &h8D91
#define GL_LUMINANCE8I_EXT                &h8D92
#define GL_LUMINANCE_ALPHA8I_EXT          &h8D93
#define GL_RED_INTEGER_EXT                &h8D94
#define GL_GREEN_INTEGER_EXT              &h8D95
#define GL_BLUE_INTEGER_EXT               &h8D96
#define GL_ALPHA_INTEGER_EXT              &h8D97
#define GL_RGB_INTEGER_EXT                &h8D98
#define GL_RGBA_INTEGER_EXT               &h8D99
#define GL_BGR_INTEGER_EXT                &h8D9A
#define GL_BGRA_INTEGER_EXT               &h8D9B
#define GL_LUMINANCE_INTEGER_EXT          &h8D9C
#define GL_LUMINANCE_ALPHA_INTEGER_EXT    &h8D9D
#define GL_RGBA_INTEGER_MODE_EXT          &h8D9E
#EndIf

#Ifndef GL_GREMEDY_frame_terminator
#EndIf

#Ifndef GL_NV_conditional_render
#define GL_QUERY_WAIT_NV                  &h8E13
#define GL_QUERY_NO_WAIT_NV               &h8E14
#define GL_QUERY_BY_REGION_WAIT_NV        &h8E15
#define GL_QUERY_BY_REGION_NO_WAIT_NV     &h8E16
#EndIf

#Ifndef GL_NV_present_video
#define GL_FRAME_NV                       &h8E26
#define GL_FIELDS_NV                      &h8E27
#define GL_CURRENT_TIME_NV                &h8E28
#define GL_NUM_FILL_STREAMS_NV            &h8E29
#define GL_PRESENT_TIME_NV                &h8E2A
#define GL_PRESENT_DURATION_NV            &h8E2B
#EndIf

#Ifndef GL_EXT_transform_feedback
#define GL_TRANSFORM_FEEDBACK_BUFFER_EXT  &h8C8E
#define GL_TRANSFORM_FEEDBACK_BUFFER_START_EXT &h8C84
#define GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_EXT &h8C85
#define GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_EXT &h8C8F
#define GL_INTERLEAVED_ATTRIBS_EXT        &h8C8C
#define GL_SEPARATE_ATTRIBS_EXT           &h8C8D
#define GL_PRIMITIVES_GENERATED_EXT       &h8C87
#define GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_EXT &h8C88
#define GL_RASTERIZER_DISCARD_EXT         &h8C89
#define GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_EXT &h8C8A
#define GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_EXT &h8C8B
#define GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_EXT &h8C80
#define GL_TRANSFORM_FEEDBACK_VARYINGS_EXT &h8C83
#define GL_TRANSFORM_FEEDBACK_BUFFER_MODE_EXT &h8C7F
#define GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH_EXT &h8C76
#EndIf

#Ifndef GL_EXT_direct_state_access
#define GL_PROGRAM_MATRIX_EXT             &h8E2D
#define GL_TRANSPOSE_PROGRAM_MATRIX_EXT   &h8E2E
#define GL_PROGRAM_MATRIX_STACK_DEPTH_EXT &h8E2F
#EndIf

#Ifndef GL_EXT_vertex_array_bgra
/' reuse GL_BGRA '/
#EndIf

#Ifndef GL_EXT_texture_swizzle
#define GL_TEXTURE_SWIZZLE_R_EXT          &h8E42
#define GL_TEXTURE_SWIZZLE_G_EXT          &h8E43
#define GL_TEXTURE_SWIZZLE_B_EXT          &h8E44
#define GL_TEXTURE_SWIZZLE_A_EXT          &h8E45
#define GL_TEXTURE_SWIZZLE_RGBA_EXT       &h8E46
#EndIf

#Ifndef GL_NV_explicit_multisample
#define GL_SAMPLE_POSITION_NV             &h8E50
#define GL_SAMPLE_MASK_NV                 &h8E51
#define GL_SAMPLE_MASK_VALUE_NV           &h8E52
#define GL_TEXTURE_BINDING_RENDERBUFFER_NV &h8E53
#define GL_TEXTURE_RENDERBUFFER_DATA_STORE_BINDING_NV &h8E54
#define GL_TEXTURE_RENDERBUFFER_NV        &h8E55
#define GL_SAMPLER_RENDERBUFFER_NV        &h8E56
#define GL_INT_SAMPLER_RENDERBUFFER_NV    &h8E57
#define GL_UNSIGNED_INT_SAMPLER_RENDERBUFFER_NV &h8E58
#define GL_MAX_SAMPLE_MASK_WORDS_NV       &h8E59
#EndIf

#Ifndef GL_NV_transform_feedback2
#define GL_TRANSFORM_FEEDBACK_NV          &h8E22
#define GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED_NV &h8E23
#define GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE_NV &h8E24
#define GL_TRANSFORM_FEEDBACK_BINDING_NV  &h8E25
#EndIf

#Ifndef GL_ATI_meminfo
#define GL_VBO_FREE_MEMORY_ATI            &h87FB
#define GL_TEXTURE_FREE_MEMORY_ATI        &h87FC
#define GL_RENDERBUFFER_FREE_MEMORY_ATI   &h87FD
#EndIf

#Ifndef GL_AMD_performance_monitor
#define GL_COUNTER_TYPE_AMD               &h8BC0
#define GL_COUNTER_RANGE_AMD              &h8BC1
#define GL_UNSIGNED_INT64_AMD             &h8BC2
#define GL_PERCENTAGE_AMD                 &h8BC3
#define GL_PERFMON_RESULT_AVAILABLE_AMD   &h8BC4
#define GL_PERFMON_RESULT_SIZE_AMD        &h8BC5
#define GL_PERFMON_RESULT_AMD             &h8BC6
#EndIf

#Ifndef GL_AMD_texture_texture4
#EndIf

#Ifndef GL_AMD_vertex_shader_tesselator
#define GL_SAMPLER_BUFFER_AMD             &h9001
#define GL_INT_SAMPLER_BUFFER_AMD         &h9002
#define GL_UNSIGNED_INT_SAMPLER_BUFFER_AMD &h9003
#define GL_TESSELLATION_MODE_AMD          &h9004
#define GL_TESSELLATION_FACTOR_AMD        &h9005
#define GL_DISCRETE_AMD                   &h9006
#define GL_CONTINUOUS_AMD                 &h9007
#EndIf

#Ifndef GL_EXT_provoking_vertex
#define GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION_EXT &h8E4C
#define GL_FIRST_VERTEX_CONVENTION_EXT    &h8E4D
#define GL_LAST_VERTEX_CONVENTION_EXT     &h8E4E
#define GL_PROVOKING_VERTEX_EXT           &h8E4F
#EndIf

#Ifndef GL_EXT_texture_snorm
#define GL_ALPHA_SNORM                    &h9010
#define GL_LUMINANCE_SNORM                &h9011
#define GL_LUMINANCE_ALPHA_SNORM          &h9012
#define GL_INTENSITY_SNORM                &h9013
#define GL_ALPHA8_SNORM                   &h9014
#define GL_LUMINANCE8_SNORM               &h9015
#define GL_LUMINANCE8_ALPHA8_SNORM        &h9016
#define GL_INTENSITY8_SNORM               &h9017
#define GL_ALPHA16_SNORM                  &h9018
#define GL_LUMINANCE16_SNORM              &h9019
#define GL_LUMINANCE16_ALPHA16_SNORM      &h901A
#define GL_INTENSITY16_SNORM              &h901B
/' reuse GL_RED_SNORM '/
/' reuse GL_RG_SNORM '/
/' reuse GL_RGB_SNORM '/
/' reuse GL_RGBA_SNORM '/
/' reuse GL_R8_SNORM '/
/' reuse GL_RG8_SNORM '/
/' reuse GL_RGB8_SNORM '/
/' reuse GL_RGBA8_SNORM '/
/' reuse GL_R16_SNORM '/
/' reuse GL_RG16_SNORM '/
/' reuse GL_RGB16_SNORM '/
/' reuse GL_RGBA16_SNORM '/
/' reuse GL_SIGNED_NORMALIZED '/
#EndIf

#Ifndef GL_AMD_draw_buffers_blend
#EndIf

#Ifndef GL_APPLE_texture_range
#define GL_TEXTURE_RANGE_LENGTH_APPLE     &h85B7
#define GL_TEXTURE_RANGE_POINTER_APPLE    &h85B8
#define GL_TEXTURE_STORAGE_HINT_APPLE     &h85BC
#define GL_STORAGE_PRIVATE_APPLE          &h85BD
/' reuse GL_STORAGE_CACHED_APPLE '/
/' reuse GL_STORAGE_SHARED_APPLE '/
#EndIf

#Ifndef GL_APPLE_float_pixels
#define GL_HALF_APPLE                     &h140B
#define GL_RGBA_FLOAT32_APPLE             &h8814
#define GL_RGB_FLOAT32_APPLE              &h8815
#define GL_ALPHA_FLOAT32_APPLE            &h8816
#define GL_INTENSITY_FLOAT32_APPLE        &h8817
#define GL_LUMINANCE_FLOAT32_APPLE        &h8818
#define GL_LUMINANCE_ALPHA_FLOAT32_APPLE  &h8819
#define GL_RGBA_FLOAT16_APPLE             &h881A
#define GL_RGB_FLOAT16_APPLE              &h881B
#define GL_ALPHA_FLOAT16_APPLE            &h881C
#define GL_INTENSITY_FLOAT16_APPLE        &h881D
#define GL_LUMINANCE_FLOAT16_APPLE        &h881E
#define GL_LUMINANCE_ALPHA_FLOAT16_APPLE  &h881F
#define GL_COLOR_FLOAT_APPLE              &h8A0F
#EndIf

#Ifndef GL_APPLE_vertex_program_evaluators
#define GL_VERTEX_ATTRIB_MAP1_APPLE       &h8A00
#define GL_VERTEX_ATTRIB_MAP2_APPLE       &h8A01
#define GL_VERTEX_ATTRIB_MAP1_SIZE_APPLE  &h8A02
#define GL_VERTEX_ATTRIB_MAP1_COEFF_APPLE &h8A03
#define GL_VERTEX_ATTRIB_MAP1_ORDER_APPLE &h8A04
#define GL_VERTEX_ATTRIB_MAP1_DOMAIN_APPLE &h8A05
#define GL_VERTEX_ATTRIB_MAP2_SIZE_APPLE  &h8A06
#define GL_VERTEX_ATTRIB_MAP2_COEFF_APPLE &h8A07
#define GL_VERTEX_ATTRIB_MAP2_ORDER_APPLE &h8A08
#define GL_VERTEX_ATTRIB_MAP2_DOMAIN_APPLE &h8A09
#EndIf

#Ifndef GL_APPLE_aux_depth_stencil
#define GL_AUX_DEPTH_STENCIL_APPLE        &h8A14
#EndIf

#Ifndef GL_APPLE_object_purgeable
#define GL_BUFFER_OBJECT_APPLE            &h85B3
#define GL_RELEASED_APPLE                 &h8A19
#define GL_VOLATILE_APPLE                 &h8A1A
#define GL_RETAINED_APPLE                 &h8A1B
#define GL_UNDEFINED_APPLE                &h8A1C
#define GL_PURGEABLE_APPLE                &h8A1D
#EndIf

#Ifndef GL_APPLE_row_bytes
#define GL_PACK_ROW_BYTES_APPLE           &h8A15
#define GL_UNPACK_ROW_BYTES_APPLE         &h8A16
#EndIf

#Ifndef GL_APPLE_rgb_422
#define GL_RGB_422_APPLE                  &h8A1F
/' reuse GL_UNSIGNED_SHORT_8_8_APPLE '/
/' reuse GL_UNSIGNED_SHORT_8_8_REV_APPLE '/
#EndIf

#Ifndef GL_NV_video_capture
#define GL_VIDEO_BUFFER_NV                &h9020
#define GL_VIDEO_BUFFER_BINDING_NV        &h9021
#define GL_FIELD_UPPER_NV                 &h9022
#define GL_FIELD_LOWER_NV                 &h9023
#define GL_NUM_VIDEO_CAPTURE_STREAMS_NV   &h9024
#define GL_NEXT_VIDEO_CAPTURE_BUFFER_STATUS_NV &h9025
#define GL_VIDEO_CAPTURE_TO_422_SUPPORTED_NV &h9026
#define GL_LAST_VIDEO_CAPTURE_STATUS_NV   &h9027
#define GL_VIDEO_BUFFER_PITCH_NV          &h9028
#define GL_VIDEO_COLOR_CONVERSION_MATRIX_NV &h9029
#define GL_VIDEO_COLOR_CONVERSION_MAX_NV  &h902A
#define GL_VIDEO_COLOR_CONVERSION_MIN_NV  &h902B
#define GL_VIDEO_COLOR_CONVERSION_OFFSET_NV &h902C
#define GL_VIDEO_BUFFER_INTERNAL_FORMAT_NV &h902D
#define GL_PARTIAL_SUCCESS_NV             &h902E
#define GL_SUCCESS_NV                     &h902F
#define GL_FAILURE_NV                     &h9030
#define GL_YCBYCR8_422_NV                 &h9031
#define GL_YCBAYCR8A_4224_NV              &h9032
#define GL_Z6Y10Z6CB10Z6Y10Z6CR10_422_NV  &h9033
#define GL_Z6Y10Z6CB10Z6A10Z6Y10Z6CR10Z6A10_4224_NV &h9034
#define GL_Z4Y12Z4CB12Z4Y12Z4CR12_422_NV  &h9035
#define GL_Z4Y12Z4CB12Z4A12Z4Y12Z4CR12Z4A12_4224_NV &h9036
#define GL_Z4Y12Z4CB12Z4CR12_444_NV       &h9037
#define GL_VIDEO_CAPTURE_FRAME_WIDTH_NV   &h9038
#define GL_VIDEO_CAPTURE_FRAME_HEIGHT_NV  &h9039
#define GL_VIDEO_CAPTURE_FIELD_UPPER_HEIGHT_NV &h903A
#define GL_VIDEO_CAPTURE_FIELD_LOWER_HEIGHT_NV &h903B
#define GL_VIDEO_CAPTURE_SURFACE_ORIGIN_NV &h903C
#EndIf

#Ifndef GL_NV_copy_image
#EndIf

#Ifndef GL_EXT_separate_shader_objects
#define GL_ACTIVE_PROGRAM_EXT             &h8B8D
#EndIf

#Ifndef GL_NV_parameter_buffer_object2
#EndIf

#Ifndef GL_NV_shader_buffer_load
#define GL_BUFFER_GPU_ADDRESS_NV          &h8F1D
#define GL_GPU_ADDRESS_NV                 &h8F34
#define GL_MAX_SHADER_BUFFER_ADDRESS_NV   &h8F35
#EndIf

#Ifndef GL_NV_vertex_buffer_unified_memory
#define GL_VERTEX_ATTRIB_ARRAY_UNIFIED_NV &h8F1E
#define GL_ELEMENT_ARRAY_UNIFIED_NV       &h8F1F
#define GL_VERTEX_ATTRIB_ARRAY_ADDRESS_NV &h8F20
#define GL_VERTEX_ARRAY_ADDRESS_NV        &h8F21
#define GL_NORMAL_ARRAY_ADDRESS_NV        &h8F22
#define GL_COLOR_ARRAY_ADDRESS_NV         &h8F23
#define GL_INDEX_ARRAY_ADDRESS_NV         &h8F24
#define GL_TEXTURE_COORD_ARRAY_ADDRESS_NV &h8F25
#define GL_EDGE_FLAG_ARRAY_ADDRESS_NV     &h8F26
#define GL_SECONDARY_COLOR_ARRAY_ADDRESS_NV &h8F27
#define GL_FOG_COORD_ARRAY_ADDRESS_NV     &h8F28
#define GL_ELEMENT_ARRAY_ADDRESS_NV       &h8F29
#define GL_VERTEX_ATTRIB_ARRAY_LENGTH_NV  &h8F2A
#define GL_VERTEX_ARRAY_LENGTH_NV         &h8F2B
#define GL_NORMAL_ARRAY_LENGTH_NV         &h8F2C
#define GL_COLOR_ARRAY_LENGTH_NV          &h8F2D
#define GL_INDEX_ARRAY_LENGTH_NV          &h8F2E
#define GL_TEXTURE_COORD_ARRAY_LENGTH_NV  &h8F2F
#define GL_EDGE_FLAG_ARRAY_LENGTH_NV      &h8F30
#define GL_SECONDARY_COLOR_ARRAY_LENGTH_NV &h8F31
#define GL_FOG_COORD_ARRAY_LENGTH_NV      &h8F32
#define GL_ELEMENT_ARRAY_LENGTH_NV        &h8F33
#define GL_DRAW_INDIRECT_UNIFIED_NV       &h8F40
#define GL_DRAW_INDIRECT_ADDRESS_NV       &h8F41
#define GL_DRAW_INDIRECT_LENGTH_NV        &h8F42
#EndIf

#Ifndef GL_NV_texture_barrier
#EndIf

#Ifndef GL_AMD_shader_stencil_export
#EndIf

#Ifndef GL_AMD_seamless_cubemap_per_texture
/' reuse GL_TEXTURE_CUBE_MAP_SEAMLESS '/
#EndIf

#Ifndef GL_AMD_conservative_depth
#EndIf

#Ifndef GL_EXT_shader_image_load_store
#define GL_MAX_IMAGE_UNITS_EXT            &h8F38
#define GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS_EXT &h8F39
#define GL_IMAGE_BINDING_NAME_EXT         &h8F3A
#define GL_IMAGE_BINDING_LEVEL_EXT        &h8F3B
#define GL_IMAGE_BINDING_LAYERED_EXT      &h8F3C
#define GL_IMAGE_BINDING_LAYER_EXT        &h8F3D
#define GL_IMAGE_BINDING_ACCESS_EXT       &h8F3E
#define GL_IMAGE_1D_EXT                   &h904C
#define GL_IMAGE_2D_EXT                   &h904D
#define GL_IMAGE_3D_EXT                   &h904E
#define GL_IMAGE_2D_RECT_EXT              &h904F
#define GL_IMAGE_CUBE_EXT                 &h9050
#define GL_IMAGE_BUFFER_EXT               &h9051
#define GL_IMAGE_1D_ARRAY_EXT             &h9052
#define GL_IMAGE_2D_ARRAY_EXT             &h9053
#define GL_IMAGE_CUBE_MAP_ARRAY_EXT       &h9054
#define GL_IMAGE_2D_MULTISAMPLE_EXT       &h9055
#define GL_IMAGE_2D_MULTISAMPLE_ARRAY_EXT &h9056
#define GL_INT_IMAGE_1D_EXT               &h9057
#define GL_INT_IMAGE_2D_EXT               &h9058
#define GL_INT_IMAGE_3D_EXT               &h9059
#define GL_INT_IMAGE_2D_RECT_EXT          &h905A
#define GL_INT_IMAGE_CUBE_EXT             &h905B
#define GL_INT_IMAGE_BUFFER_EXT           &h905C
#define GL_INT_IMAGE_1D_ARRAY_EXT         &h905D
#define GL_INT_IMAGE_2D_ARRAY_EXT         &h905E
#define GL_INT_IMAGE_CUBE_MAP_ARRAY_EXT   &h905F
#define GL_INT_IMAGE_2D_MULTISAMPLE_EXT   &h9060
#define GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT &h9061
#define GL_UNSIGNED_INT_IMAGE_1D_EXT      &h9062
#define GL_UNSIGNED_INT_IMAGE_2D_EXT      &h9063
#define GL_UNSIGNED_INT_IMAGE_3D_EXT      &h9064
#define GL_UNSIGNED_INT_IMAGE_2D_RECT_EXT &h9065
#define GL_UNSIGNED_INT_IMAGE_CUBE_EXT    &h9066
#define GL_UNSIGNED_INT_IMAGE_BUFFER_EXT  &h9067
#define GL_UNSIGNED_INT_IMAGE_1D_ARRAY_EXT &h9068
#define GL_UNSIGNED_INT_IMAGE_2D_ARRAY_EXT &h9069
#define GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY_EXT &h906A
#define GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_EXT &h906B
#define GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT &h906C
#define GL_MAX_IMAGE_SAMPLES_EXT          &h906D
#define GL_IMAGE_BINDING_FORMAT_EXT       &h906E
#define GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT_EXT &h00000001
#define GL_ELEMENT_ARRAY_BARRIER_BIT_EXT  &h00000002
#define GL_UNIFORM_BARRIER_BIT_EXT        &h00000004
#define GL_TEXTURE_FETCH_BARRIER_BIT_EXT  &h00000008
#define GL_SHADER_IMAGE_ACCESS_BARRIER_BIT_EXT &h00000020
#define GL_COMMAND_BARRIER_BIT_EXT        &h00000040
#define GL_PIXEL_BUFFER_BARRIER_BIT_EXT   &h00000080
#define GL_TEXTURE_UPDATE_BARRIER_BIT_EXT &h00000100
#define GL_BUFFER_UPDATE_BARRIER_BIT_EXT  &h00000200
#define GL_FRAMEBUFFER_BARRIER_BIT_EXT    &h00000400
#define GL_TRANSFORM_FEEDBACK_BARRIER_BIT_EXT &h00000800
#define GL_ATOMIC_COUNTER_BARRIER_BIT_EXT &h00001000
#define GL_ALL_BARRIER_BITS_EXT           &hFFFFFFFF
#EndIf

#Ifndef GL_EXT_vertex_attrib_64bit
/' reuse GL_DOUBLE '/
#define GL_DOUBLE_VEC2_EXT                &h8FFC
#define GL_DOUBLE_VEC3_EXT                &h8FFD
#define GL_DOUBLE_VEC4_EXT                &h8FFE
#define GL_DOUBLE_MAT2_EXT                &h8F46
#define GL_DOUBLE_MAT3_EXT                &h8F47
#define GL_DOUBLE_MAT4_EXT                &h8F48
#define GL_DOUBLE_MAT2x3_EXT              &h8F49
#define GL_DOUBLE_MAT2x4_EXT              &h8F4A
#define GL_DOUBLE_MAT3x2_EXT              &h8F4B
#define GL_DOUBLE_MAT3x4_EXT              &h8F4C
#define GL_DOUBLE_MAT4x2_EXT              &h8F4D
#define GL_DOUBLE_MAT4x3_EXT              &h8F4E
#EndIf

#Ifndef GL_NV_gpu_program5
#define GL_MAX_GEOMETRY_PROGRAM_INVOCATIONS_NV &h8E5A
#define GL_MIN_FRAGMENT_INTERPOLATION_OFFSET_NV &h8E5B
#define GL_MAX_FRAGMENT_INTERPOLATION_OFFSET_NV &h8E5C
#define GL_FRAGMENT_PROGRAM_INTERPOLATION_OFFSET_BITS_NV &h8E5D
#define GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_NV &h8E5E
#define GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_NV &h8E5F
#define GL_MAX_PROGRAM_SUBROUTINE_PARAMETERS_NV &h8F44
#define GL_MAX_PROGRAM_SUBROUTINE_NUM_NV  &h8F45
#EndIf

#Ifndef GL_NV_gpu_shader5
#define GL_INT64_NV                       &h140E
#define GL_UNSIGNED_INT64_NV              &h140F
#define GL_INT8_NV                        &h8FE0
#define GL_INT8_VEC2_NV                   &h8FE1
#define GL_INT8_VEC3_NV                   &h8FE2
#define GL_INT8_VEC4_NV                   &h8FE3
#define GL_INT16_NV                       &h8FE4
#define GL_INT16_VEC2_NV                  &h8FE5
#define GL_INT16_VEC3_NV                  &h8FE6
#define GL_INT16_VEC4_NV                  &h8FE7
#define GL_INT64_VEC2_NV                  &h8FE9
#define GL_INT64_VEC3_NV                  &h8FEA
#define GL_INT64_VEC4_NV                  &h8FEB
#define GL_UNSIGNED_INT8_NV               &h8FEC
#define GL_UNSIGNED_INT8_VEC2_NV          &h8FED
#define GL_UNSIGNED_INT8_VEC3_NV          &h8FEE
#define GL_UNSIGNED_INT8_VEC4_NV          &h8FEF
#define GL_UNSIGNED_INT16_NV              &h8FF0
#define GL_UNSIGNED_INT16_VEC2_NV         &h8FF1
#define GL_UNSIGNED_INT16_VEC3_NV         &h8FF2
#define GL_UNSIGNED_INT16_VEC4_NV         &h8FF3
#define GL_UNSIGNED_INT64_VEC2_NV         &h8FF5
#define GL_UNSIGNED_INT64_VEC3_NV         &h8FF6
#define GL_UNSIGNED_INT64_VEC4_NV         &h8FF7
#define GL_FLOAT16_NV                     &h8FF8
#define GL_FLOAT16_VEC2_NV                &h8FF9
#define GL_FLOAT16_VEC3_NV                &h8FFA
#define GL_FLOAT16_VEC4_NV                &h8FFB
/' reuse GL_PATCHES '/
#EndIf

#Ifndef GL_NV_shader_buffer_store
#define GL_SHADER_GLOBAL_ACCESS_BARRIER_BIT_NV &h00000010
/' reuse GL_READ_WRITE '/
/' reuse GL_WRITE_ONLY '/
#EndIf

#Ifndef GL_NV_tessellation_program5
#define GL_MAX_PROGRAM_PATCH_ATTRIBS_NV   &h86D8
#define GL_TESS_CONTROL_PROGRAM_NV        &h891E
#define GL_TESS_EVALUATION_PROGRAM_NV     &h891F
#define GL_TESS_CONTROL_PROGRAM_PARAMETER_BUFFER_NV &h8C74
#define GL_TESS_EVALUATION_PROGRAM_PARAMETER_BUFFER_NV &h8C75
#EndIf

#Ifndef GL_NV_vertex_attrib_integer_64bit
/' reuse GL_INT64_NV '/
/' reuse GL_UNSIGNED_INT64_NV '/
#EndIf

#Ifndef GL_NV_multisample_coverage
#define GL_COVERAGE_SAMPLES_NV            &h80A9
#define GL_COLOR_SAMPLES_NV               &h8E20
#EndIf

#Ifndef GL_AMD_name_gen_delete
#define GL_DATA_BUFFER_AMD                &h9151
#define GL_PERFORMANCE_MONITOR_AMD        &h9152
#define GL_QUERY_OBJECT_AMD               &h9153
#define GL_VERTEX_ARRAY_OBJECT_AMD        &h9154
#define GL_SAMPLER_OBJECT_AMD             &h9155
#EndIf

#Ifndef GL_AMD_debug_output
#define GL_MAX_DEBUG_LOGGED_MESSAGES_AMD  &h9144
#define GL_DEBUG_LOGGED_MESSAGES_AMD      &h9145
#define GL_DEBUG_SEVERITY_HIGH_AMD        &h9146
#define GL_DEBUG_SEVERITY_MEDIUM_AMD      &h9147
#define GL_DEBUG_SEVERITY_LOW_AMD         &h9148
#define GL_DEBUG_CATEGORY_API_ERROR_AMD   &h9149
#define GL_DEBUG_CATEGORY_WINDOW_SYSTEM_AMD &h914A
#define GL_DEBUG_CATEGORY_DEPRECATION_AMD &h914B
#define GL_DEBUG_CATEGORY_UNDEFINED_BEHAVIOR_AMD &h914C
#define GL_DEBUG_CATEGORY_PERFORMANCE_AMD &h914D
#define GL_DEBUG_CATEGORY_SHADER_COMPILER_AMD &h914E
#define GL_DEBUG_CATEGORY_APPLICATION_AMD &h914F
#define GL_DEBUG_CATEGORY_OTHER_AMD       &h9150
#EndIf

#Ifndef GL_NV_vdpau_interop
#define GL_SURFACE_STATE_NV               &h86EB
#define GL_SURFACE_REGISTERED_NV          &h86FD
#define GL_SURFACE_MAPPED_NV              &h8700
#define GL_WRITE_DISCARD_NV               &h88BE
#EndIf

#Ifndef GL_AMD_transform_feedback3_lines_triangles
#EndIf

#Ifndef GL_AMD_depth_clamp_separate
#define GL_DEPTH_CLAMP_NEAR_AMD           &h901E
#define GL_DEPTH_CLAMP_FAR_AMD            &h901F
#EndIf

#Ifndef GL_EXT_texture_sRGB_decode
#define GL_TEXTURE_SRGB_DECODE_EXT        &h8A48
#define GL_DECODE_EXT                     &h8A49
#define GL_SKIP_DECODE_EXT                &h8A4A
#EndIf

#Ifndef GL_NV_texture_multisample
#define GL_TEXTURE_COVERAGE_SAMPLES_NV    &h9045
#define GL_TEXTURE_COLOR_SAMPLES_NV       &h9046
#EndIf

#Ifndef GL_AMD_blend_minmax_factor
#define GL_FACTOR_MIN_AMD                 &h901C
#define GL_FACTOR_MAX_AMD                 &h901D
#EndIf

#Ifndef GL_AMD_sample_positions
#define GL_SUBSAMPLE_DISTANCE_AMD         &h883F
#EndIf

#Ifndef GL_EXT_x11_sync_object
#define GL_SYNC_X11_FENCE_EXT             &h90E1
#EndIf

#Ifndef GL_AMD_multi_draw_indirect
#EndIf

#Ifndef GL_EXT_framebuffer_multisample_blit_scaled
#define GL_SCALED_RESOLVE_FASTEST_EXT     &h90BA
#define GL_SCALED_RESOLVE_NICEST_EXT      &h90BB
#EndIf


/'***********************************************************'/

#Ifndef GL_VERSION_2_0
/' GL type for program/shader text '/
Type As Byte GLchar
#EndIf

#Ifndef GL_VERSION_1_5
/' GL types for handling large vertex buffer objects '/
Type As ptrdiff_t GLintptr
Type As ptrdiff_t GLsizeiptr
#EndIf

#Ifndef GL_ARB_vertex_buffer_object
/' GL types for handling large vertex buffer objects '/
Type As ptrdiff_t GLintptrARB
Type As ptrdiff_t GLsizeiptrARB
#EndIf

#Ifndef GL_ARB_shader_objects
/' GL types for program/shader text and shader object handles '/
Type As Byte GLcharARB
Type As UInteger GLhandleARB
#EndIf

/' GL type for "half" precision (s10e5) float data in host memory '/
#Ifndef GL_ARB_half_float_pixel
Type As UShort GLhalfARB
#EndIf

#Ifndef GL_NV_half_float
Type As UShort GLhalfNV
#EndIf

#Ifndef GLEXT_64_TYPES_DEFINED
#Define GLEXT_64_TYPES_DEFINED
/' This code block is duplicated in glxext.h, so must be protected '/
Type As Integer int32_t
Type As LongInt int64_t
Type As ULongInt uint64_t
#EndIf

#Ifndef GL_EXT_timer_query
Type As int64_t GLint64EXT
Type As uint64_t GLuint64EXT
#EndIf

#Ifndef GL_ARB_sync
Type As int64_t GLint64
Type As uint64_t GLuint64
Type As __GLsync Ptr GLsync
#EndIf

#Ifndef GL_ARB_cl_event
'' These incomplete types let us declare types compatible with OpenCL's cl_context and cl_event ''
Type As Any _cl_context
Type As Any _cl_event
#EndIf

#Ifndef GL_ARB_debug_output
Type GLDEBUGPROCARB As Sub(ByVal source As GLenum, ByVal Type As GLenum, ByVal id As GLuint, ByVal severity As GLenum, ByVal length As GLsizei, ByVal message As GLchar Ptr, ByVal userParam As GLvoid Ptr)
#EndIf

#Ifndef GL_AMD_debug_output
Type GLDEBUGPROCAMD As Sub(ByVal id As GLuint, ByVal category As GLenum, ByVal severity As GLenum, ByVal length As GLsizei, ByVal message As GLchar Ptr, ByVal userParam As GLvoid Ptr)
#EndIf

#Ifndef GL_NV_vdpau_interop
Type As GLintptr GLvdpauSurfaceNV
#EndIf

#Ifndef GL_VERSION_1_2
#define GL_VERSION_1_2 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBlendColor(ByVal red As GLclampf, ByVal green As GLclampf, ByVal blue As GLclampf, ByVal Alpha As GLclampf)
Declare Sub glBlendEquation(ByVal mode As GLenum)
Declare Sub glDrawRangeElements(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr)
Declare Sub glTexImage3D(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glTexSubImage3D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glCopyTexSubImage3D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBLENDCOLORPROC As Sub(ByVal red As GLclampf, ByVal green As GLclampf, ByVal blue As GLclampf, ByVal Alpha As GLclampf)
Type PFNGLBLENDEQUATIONPROC As Sub(ByVal mode As GLenum)
Type PFNGLDRAWRANGEELEMENTSPROC As Sub(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr)
Type PFNGLTEXIMAGE3DPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLTEXSUBIMAGE3DPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLCOPYTEXSUBIMAGE3DPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
#EndIf

#Ifndef GL_VERSION_1_2_DEPRECATED
#define GL_VERSION_1_2_DEPRECATED 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glColorTable(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal table As GLvoid Ptr)
Declare Sub glColorTableParameterfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glColorTableParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glCopyColorTable(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Declare Sub glGetColorTable(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal table As GLvoid Ptr)
Declare Sub glGetColorTableParameterfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetColorTableParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glColorSubTable(ByVal target As GLenum, ByVal start As GLsizei, ByVal count As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal Data As GLvoid Ptr)
Declare Sub glCopyColorSubTable(ByVal target As GLenum, ByVal start As GLsizei, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
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
Declare Sub glGetSeparableFilter(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal row As GLvoid Ptr, ByVal column As GLvoid Ptr, ByVal span As GLvoid Ptr)
Declare Sub glSeparableFilter2D(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal row As GLvoid Ptr, ByVal column As GLvoid Ptr)
Declare Sub glGetHistogram(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal values As GLvoid Ptr)
Declare Sub glGetHistogramParameterfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetHistogramParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetMinmax(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal values As GLvoid Ptr)
Declare Sub glGetMinmaxParameterfv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetMinmaxParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glHistogram(ByVal target As GLenum, ByVal Width As GLsizei, ByVal internalformat As GLenum, ByVal sink As GLboolean)
Declare Sub glMinmax(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal sink As GLboolean)
Declare Sub glResetHistogram(ByVal target As GLenum)
Declare Sub glResetMinmax(ByVal target As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOLORTABLEPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal table As GLvoid Ptr)
Type PFNGLCOLORTABLEPARAMETERFVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLCOLORTABLEPARAMETERIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLCOPYCOLORTABLEPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Type PFNGLGETCOLORTABLEPROC As Sub(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal table As GLvoid Ptr)
Type PFNGLGETCOLORTABLEPARAMETERFVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETCOLORTABLEPARAMETERIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLCOLORSUBTABLEPROC As Sub(ByVal target As GLenum, ByVal start As GLsizei, ByVal count As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal Data As GLvoid Ptr)
Type PFNGLCOPYCOLORSUBTABLEPROC As Sub(ByVal target As GLenum, ByVal start As GLsizei, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Type PFNGLCONVOLUTIONFILTER1DPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal image As GLvoid Ptr)
Type PFNGLCONVOLUTIONFILTER2DPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal image As GLvoid Ptr)
Type PFNGLCONVOLUTIONPARAMETERFPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat)
Type PFNGLCONVOLUTIONPARAMETERFVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLCONVOLUTIONPARAMETERIPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint)
Type PFNGLCONVOLUTIONPARAMETERIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLCOPYCONVOLUTIONFILTER1DPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Type PFNGLCOPYCONVOLUTIONFILTER2DPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLGETCONVOLUTIONFILTERPROC As Sub(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal image As GLvoid Ptr)
Type PFNGLGETCONVOLUTIONPARAMETERFVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETCONVOLUTIONPARAMETERIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETSEPARABLEFILTERPROC As Sub(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal row As GLvoid Ptr, ByVal column As GLvoid Ptr, ByVal span As GLvoid Ptr)
Type PFNGLSEPARABLEFILTER2DPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal row As GLvoid Ptr, ByVal column As GLvoid Ptr)
Type PFNGLGETHISTOGRAMPROC As Sub(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal values As GLvoid Ptr)
Type PFNGLGETHISTOGRAMPARAMETERFVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETHISTOGRAMPARAMETERIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETMINMAXPROC As Sub(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal values As GLvoid Ptr)
Type PFNGLGETMINMAXPARAMETERFVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETMINMAXPARAMETERIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLHISTOGRAMPROC As Sub(ByVal target As GLenum, ByVal Width As GLsizei, ByVal internalformat As GLenum, ByVal sink As GLboolean)
Type PFNGLMINMAXPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal sink As GLboolean)
Type PFNGLRESETHISTOGRAMPROC As Sub(ByVal target As GLenum)
Type PFNGLRESETMINMAXPROC As Sub(ByVal target As GLenum)
#EndIf

#Ifndef GL_VERSION_1_3
#define GL_VERSION_1_3 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glActiveTexture(ByVal texture As GLenum)
Declare Sub glSampleCoverage(ByVal value As GLclampf, ByVal invert As GLboolean)
Declare Sub glCompressedTexImage3D(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexImage2D(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexImage1D(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexSubImage3D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexSubImage2D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexSubImage1D(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glGetCompressedTexImage(ByVal target As GLenum, ByVal level As GLint, ByVal img As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLACTIVETEXTUREPROC As Sub(ByVal texture As GLenum)
Type PFNGLSAMPLECOVERAGEPROC As Sub(ByVal value As GLclampf, ByVal invert As GLboolean)
Type PFNGLCOMPRESSEDTEXIMAGE3DPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXIMAGE2DPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXIMAGE1DPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLGETCOMPRESSEDTEXIMAGEPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal img As GLvoid Ptr)
#EndIf

#Ifndef GL_VERSION_1_3_DEPRECATED
#define GL_VERSION_1_3_DEPRECATED 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glClientActiveTexture(ByVal texture As GLenum)
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
Declare Sub glLoadTransposeMatrixf(ByVal m As GLfloat Ptr)
Declare Sub glLoadTransposeMatrixd(ByVal m As GLdouble Ptr)
Declare Sub glMultTransposeMatrixf(ByVal m As GLfloat Ptr)
Declare Sub glMultTransposeMatrixd(ByVal m As GLdouble Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCLIENTACTIVETEXTUREPROC As Sub(ByVal texture As GLenum)
Type PFNGLMULTITEXCOORD1DPROC As Sub(ByVal target As GLenum, ByVal s As GLdouble)
Type PFNGLMULTITEXCOORD1DVPROC As Sub(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Type PFNGLMULTITEXCOORD1FPROC As Sub(ByVal target As GLenum, ByVal s As GLfloat)
Type PFNGLMULTITEXCOORD1FVPROC As Sub(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Type PFNGLMULTITEXCOORD1IPROC As Sub(ByVal target As GLenum, ByVal s As GLint)
Type PFNGLMULTITEXCOORD1IVPROC As Sub(ByVal target As GLenum, ByVal v As GLint Ptr)
Type PFNGLMULTITEXCOORD1SPROC As Sub(ByVal target As GLenum, ByVal s As GLshort)
Type PFNGLMULTITEXCOORD1SVPROC As Sub(ByVal target As GLenum, ByVal v As GLshort Ptr)
Type PFNGLMULTITEXCOORD2DPROC As Sub(ByVal target As GLenum, ByVal s As GLdouble, ByVal t As GLdouble)
Type PFNGLMULTITEXCOORD2DVPROC As Sub(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Type PFNGLMULTITEXCOORD2FPROC As Sub(ByVal target As GLenum, ByVal s As GLfloat, ByVal t As GLfloat)
Type PFNGLMULTITEXCOORD2FVPROC As Sub(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Type PFNGLMULTITEXCOORD2IPROC As Sub(ByVal target As GLenum, ByVal s As GLint, ByVal t As GLint)
Type PFNGLMULTITEXCOORD2IVPROC As Sub(ByVal target As GLenum, ByVal v As GLint Ptr)
Type PFNGLMULTITEXCOORD2SPROC As Sub(ByVal target As GLenum, ByVal s As GLshort, ByVal t As GLshort)
Type PFNGLMULTITEXCOORD2SVPROC As Sub(ByVal target As GLenum, ByVal v As GLshort Ptr)
Type PFNGLMULTITEXCOORD3DPROC As Sub(ByVal target As GLenum, ByVal s As GLdouble, ByVal t As GLdouble, ByVal r As GLdouble)
Type PFNGLMULTITEXCOORD3DVPROC As Sub(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Type PFNGLMULTITEXCOORD3FPROC As Sub(ByVal target As GLenum, ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat)
Type PFNGLMULTITEXCOORD3FVPROC As Sub(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Type PFNGLMULTITEXCOORD3IPROC As Sub(ByVal target As GLenum, ByVal s As GLint, ByVal t As GLint, ByVal r As GLint)
Type PFNGLMULTITEXCOORD3IVPROC As Sub(ByVal target As GLenum, ByVal v As GLint Ptr)
Type PFNGLMULTITEXCOORD3SPROC As Sub(ByVal target As GLenum, ByVal s As GLshort, ByVal t As GLshort, ByVal r As GLshort)
Type PFNGLMULTITEXCOORD3SVPROC As Sub(ByVal target As GLenum, ByVal v As GLshort Ptr)
Type PFNGLMULTITEXCOORD4DPROC As Sub(ByVal target As GLenum, ByVal s As GLdouble, ByVal t As GLdouble, ByVal r As GLdouble, ByVal q As GLdouble)
Type PFNGLMULTITEXCOORD4DVPROC As Sub(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Type PFNGLMULTITEXCOORD4FPROC As Sub(ByVal target As GLenum, ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat, ByVal q As GLfloat)
Type PFNGLMULTITEXCOORD4FVPROC As Sub(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Type PFNGLMULTITEXCOORD4IPROC As Sub(ByVal target As GLenum, ByVal s As GLint, ByVal t As GLint, ByVal r As GLint, ByVal q As GLint)
Type PFNGLMULTITEXCOORD4IVPROC As Sub(ByVal target As GLenum, ByVal v As GLint Ptr)
Type PFNGLMULTITEXCOORD4SPROC As Sub(ByVal target As GLenum, ByVal s As GLshort, ByVal t As GLshort, ByVal r As GLshort, ByVal q As GLshort)
Type PFNGLMULTITEXCOORD4SVPROC As Sub(ByVal target As GLenum, ByVal v As GLshort Ptr)
Type PFNGLLOADTRANSPOSEMATRIXFPROC As Sub(ByVal m As GLfloat Ptr)
Type PFNGLLOADTRANSPOSEMATRIXDPROC As Sub(ByVal m As GLdouble Ptr)
Type PFNGLMULTTRANSPOSEMATRIXFPROC As Sub(ByVal m As GLfloat Ptr)
Type PFNGLMULTTRANSPOSEMATRIXDPROC As Sub(ByVal m As GLdouble Ptr)
#EndIf

#Ifndef GL_VERSION_1_4
#define GL_VERSION_1_4 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBlendFuncSeparate(ByVal sfactorRGB As GLenum, ByVal dfactorRGB As GLenum, ByVal sfactorAlpha As GLenum, ByVal dfactorAlpha As GLenum)
Declare Sub glMultiDrawArrays(ByVal mode As GLenum, ByVal first As GLint Ptr, ByVal count As GLsizei Ptr, ByVal primcount As GLsizei)
Declare Sub glMultiDrawElements(ByVal mode As GLenum, ByVal count As GLsizei Ptr, ByVal Type As GLenum, ByVal indices As GLvoid Ptr Ptr, ByVal primcount As GLsizei)
Declare Sub glPointParameterf(ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glPointParameterfv(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glPointParameteri(ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glPointParameteriv(ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBLENDFUNCSEPARATEPROC As Sub(ByVal sfactorRGB As GLenum, ByVal dfactorRGB As GLenum, ByVal sfactorAlpha As GLenum, ByVal dfactorAlpha As GLenum)
Type PFNGLMULTIDRAWARRAYSPROC As Sub(ByVal mode As GLenum, ByVal first As GLint Ptr, ByVal count As GLsizei Ptr, ByVal primcount As GLsizei)
Type PFNGLMULTIDRAWELEMENTSPROC As Sub(ByVal mode As GLenum, ByVal count As GLsizei Ptr, ByVal Type As GLenum, ByVal indices As GLvoid Ptr Ptr, ByVal primcount As GLsizei)
Type PFNGLPOINTPARAMETERFPROC As Sub(ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLPOINTPARAMETERFVPROC As Sub(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLPOINTPARAMETERIPROC As Sub(ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLPOINTPARAMETERIVPROC As Sub(ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_VERSION_1_4_DEPRECATED
#define GL_VERSION_1_4_DEPRECATED 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glFogCoordf(ByVal coord As GLfloat)
Declare Sub glFogCoordfv(ByVal coord As GLfloat Ptr)
Declare Sub glFogCoordd(ByVal coord As GLdouble)
Declare Sub glFogCoorddv(ByVal coord As GLdouble Ptr)
Declare Sub glFogCoordPointer(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glSecondaryColor3b(ByVal red As GLbyte, ByVal green As GLbyte, ByVal blue As GLbyte)
Declare Sub glSecondaryColor3bv(ByVal v As GLbyte Ptr)
Declare Sub glSecondaryColor3d(ByVal red As GLdouble, ByVal green As GLdouble, ByVal blue As GLdouble)
Declare Sub glSecondaryColor3dv(ByVal v As GLdouble Ptr)
Declare Sub glSecondaryColor3f(ByVal red As GLfloat, ByVal green As GLfloat, ByVal blue As GLfloat)
Declare Sub glSecondaryColor3fv(ByVal v As GLfloat Ptr)
Declare Sub glSecondaryColor3i(ByVal red As GLint, ByVal green As GLint, ByVal blue As GLint)
Declare Sub glSecondaryColor3iv(ByVal v As GLint Ptr)
Declare Sub glSecondaryColor3s(ByVal red As GLshort, ByVal green As GLshort, ByVal blue As GLshort)
Declare Sub glSecondaryColor3sv(ByVal v As GLshort Ptr)
Declare Sub glSecondaryColor3ub(ByVal red As GLubyte, ByVal green As GLubyte, ByVal blue As GLubyte)
Declare Sub glSecondaryColor3ubv(ByVal v As GLubyte Ptr)
Declare Sub glSecondaryColor3ui(ByVal red As GLuint, ByVal green As GLuint, ByVal blue As GLuint)
Declare Sub glSecondaryColor3uiv(ByVal v As GLuint Ptr)
Declare Sub glSecondaryColor3us(ByVal red As GLushort, ByVal green As GLushort, ByVal blue As GLushort)
Declare Sub glSecondaryColor3usv(ByVal v As GLushort Ptr)
Declare Sub glSecondaryColorPointer(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glWindowPos2d(ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glWindowPos2dv(ByVal v As GLdouble Ptr)
Declare Sub glWindowPos2f(ByVal x As GLfloat, ByVal y As GLfloat)
Declare Sub glWindowPos2fv(ByVal v As GLfloat Ptr)
Declare Sub glWindowPos2i(ByVal x As GLint, ByVal y As GLint)
Declare Sub glWindowPos2iv(ByVal v As GLint Ptr)
Declare Sub glWindowPos2s(ByVal x As GLshort, ByVal y As GLshort)
Declare Sub glWindowPos2sv(ByVal v As GLshort Ptr)
Declare Sub glWindowPos3d(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glWindowPos3dv(ByVal v As GLdouble Ptr)
Declare Sub glWindowPos3f(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glWindowPos3fv(ByVal v As GLfloat Ptr)
Declare Sub glWindowPos3i(ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Declare Sub glWindowPos3iv(ByVal v As GLint Ptr)
Declare Sub glWindowPos3s(ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Declare Sub glWindowPos3sv(ByVal v As GLshort Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLFOGCOORDFPROC As Sub(ByVal coord As GLfloat)
Type PFNGLFOGCOORDFVPROC As Sub(ByVal coord As GLfloat Ptr)
Type PFNGLFOGCOORDDPROC As Sub(ByVal coord As GLdouble)
Type PFNGLFOGCOORDDVPROC As Sub(ByVal coord As GLdouble Ptr)
Type PFNGLFOGCOORDPOINTERPROC As Sub(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLSECONDARYCOLOR3BPROC As Sub(ByVal red As GLbyte, ByVal green As GLbyte, ByVal blue As GLbyte)
Type PFNGLSECONDARYCOLOR3BVPROC As Sub(ByVal v As GLbyte Ptr)
Type PFNGLSECONDARYCOLOR3DPROC As Sub(ByVal red As GLdouble, ByVal green As GLdouble, ByVal blue As GLdouble)
Type PFNGLSECONDARYCOLOR3DVPROC As Sub(ByVal v As GLdouble Ptr)
Type PFNGLSECONDARYCOLOR3FPROC As Sub(ByVal red As GLfloat, ByVal green As GLfloat, ByVal blue As GLfloat)
Type PFNGLSECONDARYCOLOR3FVPROC As Sub(ByVal v As GLfloat Ptr)
Type PFNGLSECONDARYCOLOR3IPROC As Sub(ByVal red As GLint, ByVal green As GLint, ByVal blue As GLint)
Type PFNGLSECONDARYCOLOR3IVPROC As Sub(ByVal v As GLint Ptr)
Type PFNGLSECONDARYCOLOR3SPROC As Sub(ByVal red As GLshort, ByVal green As GLshort, ByVal blue As GLshort)
Type PFNGLSECONDARYCOLOR3SVPROC As Sub(ByVal v As GLshort Ptr)
Type PFNGLSECONDARYCOLOR3UBPROC As Sub(ByVal red As GLubyte, ByVal green As GLubyte, ByVal blue As GLubyte)
Type PFNGLSECONDARYCOLOR3UBVPROC As Sub(ByVal v As GLubyte Ptr)
Type PFNGLSECONDARYCOLOR3UIPROC As Sub(ByVal red As GLuint, ByVal green As GLuint, ByVal blue As GLuint)
Type PFNGLSECONDARYCOLOR3UIVPROC As Sub(ByVal v As GLuint Ptr)
Type PFNGLSECONDARYCOLOR3USPROC As Sub(ByVal red As GLushort, ByVal green As GLushort, ByVal blue As GLushort)
Type PFNGLSECONDARYCOLOR3USVPROC As Sub(ByVal v As GLushort Ptr)
Type PFNGLSECONDARYCOLORPOINTERPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLWINDOWPOS2DPROC As Sub(ByVal x As GLdouble, ByVal y As GLdouble)
Type PFNGLWINDOWPOS2DVPROC As Sub(ByVal v As GLdouble Ptr)
Type PFNGLWINDOWPOS2FPROC As Sub(ByVal x As GLfloat, ByVal y As GLfloat)
Type PFNGLWINDOWPOS2FVPROC As Sub(ByVal v As GLfloat Ptr)
Type PFNGLWINDOWPOS2IPROC As Sub(ByVal x As GLint, ByVal y As GLint)
Type PFNGLWINDOWPOS2IVPROC As Sub(ByVal v As GLint Ptr)
Type PFNGLWINDOWPOS2SPROC As Sub(ByVal x As GLshort, ByVal y As GLshort)
Type PFNGLWINDOWPOS2SVPROC As Sub(ByVal v As GLshort Ptr)
Type PFNGLWINDOWPOS3DPROC As Sub(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLWINDOWPOS3DVPROC As Sub(ByVal v As GLdouble Ptr)
Type PFNGLWINDOWPOS3FPROC As Sub(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLWINDOWPOS3FVPROC As Sub(ByVal v As GLfloat Ptr)
Type PFNGLWINDOWPOS3IPROC As Sub(ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Type PFNGLWINDOWPOS3IVPROC As Sub(ByVal v As GLint Ptr)
Type PFNGLWINDOWPOS3SPROC As Sub(ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Type PFNGLWINDOWPOS3SVPROC As Sub(ByVal v As GLshort Ptr)
#EndIf

#Ifndef GL_VERSION_1_5
#define GL_VERSION_1_5 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGenQueries(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Declare Sub glDeleteQueries(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Declare Function glIsQuery(ByVal id As GLuint) As GLboolean
Declare Sub glBeginQuery(ByVal target As GLenum, ByVal id As GLuint)
Declare Sub glEndQuery(ByVal target As GLenum)
Declare Sub glGetQueryiv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetQueryObjectiv(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetQueryObjectuiv(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Declare Sub glBindBuffer(ByVal target As GLenum, ByVal buffer As GLuint)
Declare Sub glDeleteBuffers(ByVal n As GLsizei, ByVal buffers As GLuint Ptr)
Declare Sub glGenBuffers(ByVal n As GLsizei, ByVal buffers As GLuint Ptr)
Declare Function glIsBuffer(ByVal buffer As GLuint) As GLboolean
Declare Sub glBufferData(ByVal target As GLenum, ByVal size As GLsizeiptr, ByVal Data As GLvoid Ptr, ByVal usage As GLenum)
Declare Sub glBufferSubData(ByVal target As GLenum, ByVal offset As GLintptr, ByVal size As GLsizeiptr, ByVal Data As GLvoid Ptr)
Declare Sub glGetBufferSubData(ByVal target As GLenum, ByVal offset As GLintptr, ByVal size As GLsizeiptr, ByVal Data As GLvoid Ptr)
Declare Function glMapBuffer(ByVal target As GLenum, ByVal Access As GLenum) As GLvoid Ptr
Declare Function glUnmapBuffer(ByVal target As GLenum) As GLboolean
Declare Sub glGetBufferParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetBufferPointerv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLvoid Ptr Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGENQUERIESPROC As Sub(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Type PFNGLDELETEQUERIESPROC As Sub(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Type PFNGLISQUERYPROC As Function(ByVal id As GLuint) As GLboolean
Type PFNGLBEGINQUERYPROC As Sub(ByVal target As GLenum, ByVal id As GLuint)
Type PFNGLENDQUERYPROC As Sub(ByVal target As GLenum)
Type PFNGLGETQUERYIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETQUERYOBJECTIVPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETQUERYOBJECTUIVPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Type PFNGLBINDBUFFERPROC As Sub(ByVal target As GLenum, ByVal buffer As GLuint)
Type PFNGLDELETEBUFFERSPROC As Sub(ByVal n As GLsizei, ByVal buffers As GLuint Ptr)
Type PFNGLGENBUFFERSPROC As Sub(ByVal n As GLsizei, ByVal buffers As GLuint Ptr)
Type PFNGLISBUFFERPROC As Function(ByVal buffer As GLuint) As GLboolean
Type PFNGLBUFFERDATAPROC As Sub(ByVal target As GLenum, ByVal size As GLsizeiptr, ByVal Data As GLvoid Ptr, ByVal usage As GLenum)
Type PFNGLBUFFERSUBDATAPROC As Sub(ByVal target As GLenum, ByVal offset As GLintptr, ByVal size As GLsizeiptr, ByVal Data As GLvoid Ptr)
Type PFNGLGETBUFFERSUBDATAPROC As Sub(ByVal target As GLenum, ByVal offset As GLintptr, ByVal size As GLsizeiptr, ByVal Data As GLvoid Ptr)
Type PFNGLMAPBUFFERPROC As Function(ByVal target As GLenum, ByVal Access As GLenum) As GLvoid Ptr
Type PFNGLUNMAPBUFFERPROC As Function(ByVal target As GLenum) As GLboolean
Type PFNGLGETBUFFERPARAMETERIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETBUFFERPOINTERVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLvoid Ptr Ptr)
#EndIf

#Ifndef GL_VERSION_2_0
#define GL_VERSION_2_0 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBlendEquationSeparate(ByVal modeRGB As GLenum, ByVal modeAlpha As GLenum)
Declare Sub glDrawBuffers(ByVal n As GLsizei, ByVal bufs As GLenum Ptr)
Declare Sub glStencilOpSeparate(ByVal face As GLenum, ByVal sfail As GLenum, ByVal dpfail As GLenum, ByVal dppass As GLenum)
Declare Sub glStencilFuncSeparate(ByVal face As GLenum, ByVal func As GLenum, ByVal ref As GLint, ByVal mask As GLuint)
Declare Sub glStencilMaskSeparate(ByVal face As GLenum, ByVal mask As GLuint)
Declare Sub glAttachShader(ByVal program As GLuint, ByVal shader As GLuint)
Declare Sub glBindAttribLocation(ByVal program As GLuint, ByVal index As GLuint, ByVal Name As GLchar Ptr)
Declare Sub glCompileShader(ByVal shader As GLuint)
Declare Function glCreateProgram() As GLuint
Declare Function glCreateShader(ByVal Type As GLenum) As GLuint
Declare Sub glDeleteProgram(ByVal program As GLuint)
Declare Sub glDeleteShader(ByVal shader As GLuint)
Declare Sub glDetachShader(ByVal program As GLuint, ByVal shader As GLuint)
Declare Sub glDisableVertexAttribArray(ByVal index As GLuint)
Declare Sub glEnableVertexAttribArray(ByVal index As GLuint)
Declare Sub glGetActiveAttrib(ByVal program As GLuint, ByVal index As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLint Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLchar Ptr)
Declare Sub glGetActiveUniform(ByVal program As GLuint, ByVal index As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLint Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLchar Ptr)
Declare Sub glGetAttachedShaders(ByVal program As GLuint, ByVal maxCount As GLsizei, ByVal count As GLsizei Ptr, ByVal obj As GLuint Ptr)
Declare Function glGetAttribLocation(ByVal program As GLuint, ByVal Name As GLchar Ptr) As GLint
Declare Sub glGetProgramiv(ByVal program As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetProgramInfoLog(ByVal program As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal infoLog As GLchar Ptr)
Declare Sub glGetShaderiv(ByVal shader As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetShaderInfoLog(ByVal shader As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal infoLog As GLchar Ptr)
Declare Sub glGetShaderSource(ByVal shader As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal source As GLchar Ptr)
Declare Function glGetUniformLocation(ByVal program As GLuint, ByVal Name As GLchar Ptr) As GLint
Declare Sub glGetUniformfv(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLfloat Ptr)
Declare Sub glGetUniformiv(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLint Ptr)
Declare Sub glGetVertexAttribdv(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Declare Sub glGetVertexAttribfv(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetVertexAttribiv(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetVertexAttribPointerv(ByVal index As GLuint, ByVal pname As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
Declare Function glIsProgram(ByVal program As GLuint) As GLboolean
Declare Function glIsShader(ByVal shader As GLuint) As GLboolean
Declare Sub glLinkProgram(ByVal program As GLuint)
Declare Sub glShaderSource(ByVal shader As GLuint, ByVal count As GLsizei, ByVal String As GLchar Ptr Ptr, ByVal length As GLint Ptr)
Declare Sub glUseProgram(ByVal program As GLuint)
Declare Sub glUniform1f(ByVal location As GLint, ByVal v0 As GLfloat)
Declare Sub glUniform2f(ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat)
Declare Sub glUniform3f(ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat)
Declare Sub glUniform4f(ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal v3 As GLfloat)
Declare Sub glUniform1i(ByVal location As GLint, ByVal v0 As GLint)
Declare Sub glUniform2i(ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint)
Declare Sub glUniform3i(ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint)
Declare Sub glUniform4i(ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint, ByVal v3 As GLint)
Declare Sub glUniform1fv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glUniform2fv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glUniform3fv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glUniform4fv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glUniform1iv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glUniform2iv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glUniform3iv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glUniform4iv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glUniformMatrix2fv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glUniformMatrix3fv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glUniformMatrix4fv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glValidateProgram(ByVal program As GLuint)
Declare Sub glVertexAttrib1d(ByVal index As GLuint, ByVal x As GLdouble)
Declare Sub glVertexAttrib1dv(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttrib1f(ByVal index As GLuint, ByVal x As GLfloat)
Declare Sub glVertexAttrib1fv(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttrib1s(ByVal index As GLuint, ByVal x As GLshort)
Declare Sub glVertexAttrib1sv(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib2d(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glVertexAttrib2dv(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttrib2f(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat)
Declare Sub glVertexAttrib2fv(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttrib2s(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort)
Declare Sub glVertexAttrib2sv(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib3d(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glVertexAttrib3dv(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttrib3f(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glVertexAttrib3fv(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttrib3s(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Declare Sub glVertexAttrib3sv(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib4Nbv(ByVal index As GLuint, ByVal v As GLbyte Ptr)
Declare Sub glVertexAttrib4Niv(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glVertexAttrib4Nsv(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib4Nub(ByVal index As GLuint, ByVal x As GLubyte, ByVal y As GLubyte, ByVal z As GLubyte, ByVal w As GLubyte)
Declare Sub glVertexAttrib4Nubv(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Declare Sub glVertexAttrib4Nuiv(ByVal index As GLuint, ByVal v As GLuint Ptr)
Declare Sub glVertexAttrib4Nusv(ByVal index As GLuint, ByVal v As GLushort Ptr)
Declare Sub glVertexAttrib4bv(ByVal index As GLuint, ByVal v As GLbyte Ptr)
Declare Sub glVertexAttrib4d(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glVertexAttrib4dv(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttrib4f(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glVertexAttrib4fv(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttrib4iv(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glVertexAttrib4s(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort, ByVal w As GLshort)
Declare Sub glVertexAttrib4sv(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib4ubv(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Declare Sub glVertexAttrib4uiv(ByVal index As GLuint, ByVal v As GLuint Ptr)
Declare Sub glVertexAttrib4usv(ByVal index As GLuint, ByVal v As GLushort Ptr)
Declare Sub glVertexAttribPointer(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBLENDEQUATIONSEPARATEPROC As Sub(ByVal modeRGB As GLenum, ByVal modeAlpha As GLenum)
Type PFNGLDRAWBUFFERSPROC As Sub(ByVal n As GLsizei, ByVal bufs As GLenum Ptr)
Type PFNGLSTENCILOPSEPARATEPROC As Sub(ByVal face As GLenum, ByVal sfail As GLenum, ByVal dpfail As GLenum, ByVal dppass As GLenum)
Type PFNGLSTENCILFUNCSEPARATEPROC As Sub(ByVal face As GLenum, ByVal func As GLenum, ByVal ref As GLint, ByVal mask As GLuint)
Type PFNGLSTENCILMASKSEPARATEPROC As Sub(ByVal face As GLenum, ByVal mask As GLuint)
Type PFNGLATTACHSHADERPROC As Sub(ByVal program As GLuint, ByVal shader As GLuint)
Type PFNGLBINDATTRIBLOCATIONPROC As Sub(ByVal program As GLuint, ByVal index As GLuint, ByVal Name As GLchar Ptr)
Type PFNGLCOMPILESHADERPROC As Sub(ByVal shader As GLuint)
Type PFNGLCREATEPROGRAMPROC As Function() As GLuint
Type PFNGLCREATESHADERPROC As Function(ByVal Type As GLenum) As GLuint
Type PFNGLDELETEPROGRAMPROC As Sub(ByVal program As GLuint)
Type PFNGLDELETESHADERPROC As Sub(ByVal shader As GLuint)
Type PFNGLDETACHSHADERPROC As Sub(ByVal program As GLuint, ByVal shader As GLuint)
Type PFNGLDISABLEVERTEXATTRIBARRAYPROC As Sub(ByVal index As GLuint)
Type PFNGLENABLEVERTEXATTRIBARRAYPROC As Sub(ByVal index As GLuint)
Type PFNGLGETACTIVEATTRIBPROC As Sub(ByVal program As GLuint, ByVal index As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLint Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLchar Ptr)
Type PFNGLGETACTIVEUNIFORMPROC As Sub(ByVal program As GLuint, ByVal index As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLint Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLchar Ptr)
Type PFNGLGETATTACHEDSHADERSPROC As Sub(ByVal program As GLuint, ByVal maxCount As GLsizei, ByVal count As GLsizei Ptr, ByVal obj As GLuint Ptr)
Type PFNGLGETATTRIBLOCATIONPROC As Function(ByVal program As GLuint, ByVal Name As GLchar Ptr) As GLint
Type PFNGLGETPROGRAMIVPROC As Sub(ByVal program As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETPROGRAMINFOLOGPROC As Sub(ByVal program As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal infoLog As GLchar Ptr)
Type PFNGLGETSHADERIVPROC As Sub(ByVal shader As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETSHADERINFOLOGPROC As Sub(ByVal shader As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal infoLog As GLchar Ptr)
Type PFNGLGETSHADERSOURCEPROC As Sub(ByVal shader As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal source As GLchar Ptr)
Type PFNGLGETUNIFORMLOCATIONPROC As Function(ByVal program As GLuint, ByVal Name As GLchar Ptr) As GLint
Type PFNGLGETUNIFORMFVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLfloat Ptr)
Type PFNGLGETUNIFORMIVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLint Ptr)
Type PFNGLGETVERTEXATTRIBDVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Type PFNGLGETVERTEXATTRIBFVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETVERTEXATTRIBIVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETVERTEXATTRIBPOINTERVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
Type PFNGLISPROGRAMPROC As Function(ByVal program As GLuint) As GLboolean
Type PFNGLISSHADERPROC As Function(ByVal shader As GLuint) As GLboolean
Type PFNGLLINKPROGRAMPROC As Sub(ByVal program As GLuint)
Type PFNGLSHADERSOURCEPROC As Sub(ByVal shader As GLuint, ByVal count As GLsizei, ByVal String As GLchar Ptr Ptr, ByVal length As GLint Ptr)
Type PFNGLUSEPROGRAMPROC As Sub(ByVal program As GLuint)
Type PFNGLUNIFORM1FPROC As Sub(ByVal location As GLint, ByVal v0 As GLfloat)
Type PFNGLUNIFORM2FPROC As Sub(ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat)
Type PFNGLUNIFORM3FPROC As Sub(ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat)
Type PFNGLUNIFORM4FPROC As Sub(ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal v3 As GLfloat)
Type PFNGLUNIFORM1IPROC As Sub(ByVal location As GLint, ByVal v0 As GLint)
Type PFNGLUNIFORM2IPROC As Sub(ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint)
Type PFNGLUNIFORM3IPROC As Sub(ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint)
Type PFNGLUNIFORM4IPROC As Sub(ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint, ByVal v3 As GLint)
Type PFNGLUNIFORM1FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORM2FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORM3FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORM4FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORM1IVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLUNIFORM2IVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLUNIFORM3IVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLUNIFORM4IVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLUNIFORMMATRIX2FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORMMATRIX3FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORMMATRIX4FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLVALIDATEPROGRAMPROC As Sub(ByVal program As GLuint)
Type PFNGLVERTEXATTRIB1DPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble)
Type PFNGLVERTEXATTRIB1DVPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIB1FPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat)
Type PFNGLVERTEXATTRIB1FVPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIB1SPROC As Sub(ByVal index As GLuint, ByVal x As GLshort)
Type PFNGLVERTEXATTRIB1SVPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB2DPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble)
Type PFNGLVERTEXATTRIB2DVPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIB2FPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat)
Type PFNGLVERTEXATTRIB2FVPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIB2SPROC As Sub(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort)
Type PFNGLVERTEXATTRIB2SVPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB3DPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLVERTEXATTRIB3DVPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIB3FPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLVERTEXATTRIB3FVPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIB3SPROC As Sub(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Type PFNGLVERTEXATTRIB3SVPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB4NBVPROC As Sub(ByVal index As GLuint, ByVal v As GLbyte Ptr)
Type PFNGLVERTEXATTRIB4NIVPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLVERTEXATTRIB4NSVPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB4NUBPROC As Sub(ByVal index As GLuint, ByVal x As GLubyte, ByVal y As GLubyte, ByVal z As GLubyte, ByVal w As GLubyte)
Type PFNGLVERTEXATTRIB4NUBVPROC As Sub(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Type PFNGLVERTEXATTRIB4NUIVPROC As Sub(ByVal index As GLuint, ByVal v As GLuint Ptr)
Type PFNGLVERTEXATTRIB4NUSVPROC As Sub(ByVal index As GLuint, ByVal v As GLushort Ptr)
Type PFNGLVERTEXATTRIB4BVPROC As Sub(ByVal index As GLuint, ByVal v As GLbyte Ptr)
Type PFNGLVERTEXATTRIB4DPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLVERTEXATTRIB4DVPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIB4FPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Type PFNGLVERTEXATTRIB4FVPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIB4IVPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLVERTEXATTRIB4SPROC As Sub(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort, ByVal w As GLshort)
Type PFNGLVERTEXATTRIB4SVPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB4UBVPROC As Sub(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Type PFNGLVERTEXATTRIB4UIVPROC As Sub(ByVal index As GLuint, ByVal v As GLuint Ptr)
Type PFNGLVERTEXATTRIB4USVPROC As Sub(ByVal index As GLuint, ByVal v As GLushort Ptr)
Type PFNGLVERTEXATTRIBPOINTERPROC As Sub(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf

#Ifndef GL_VERSION_2_1
#define GL_VERSION_2_1 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glUniformMatrix2x3fv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glUniformMatrix3x2fv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glUniformMatrix2x4fv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glUniformMatrix4x2fv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glUniformMatrix3x4fv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glUniformMatrix4x3fv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLUNIFORMMATRIX2X3FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORMMATRIX3X2FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORMMATRIX2X4FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORMMATRIX4X2FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORMMATRIX3X4FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORMMATRIX4X3FVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
#EndIf

#Ifndef GL_VERSION_3_0
#define GL_VERSION_3_0 1
/' OpenGL 3.0 also reuses entry points from these extensions: '/
/' ARB_framebuffer_object '/
/' ARB_map_buffer_range '/
/' ARB_vertex_array_object '/
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glColorMaski(ByVal index As GLuint, ByVal r As GLboolean, ByVal g As GLboolean, ByVal b As GLboolean, ByVal a As GLboolean)
Declare Sub glGetBooleani_v(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLboolean Ptr)
Declare Sub glGetIntegeri_v(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLint Ptr)
Declare Sub glEnablei(ByVal target As GLenum, ByVal index As GLuint)
Declare Sub glDisablei(ByVal target As GLenum, ByVal index As GLuint)
Declare Function glIsEnabledi(ByVal target As GLenum, ByVal index As GLuint) As GLboolean
Declare Sub glBeginTransformFeedback(ByVal primitiveMode As GLenum)
Declare Sub glEndTransformFeedback()
Declare Sub glBindBufferRange(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal size As GLsizeiptr)
Declare Sub glBindBufferBase(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint)
Declare Sub glTransformFeedbackVaryings(ByVal program As GLuint, ByVal count As GLsizei, ByVal varyings As GLchar Ptr Ptr, ByVal bufferMode As GLenum)
Declare Sub glGetTransformFeedbackVarying(ByVal program As GLuint, ByVal index As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLsizei Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLchar Ptr)
Declare Sub glClampColor(ByVal target As GLenum, ByVal clamp As GLenum)
Declare Sub glBeginConditionalRender(ByVal id As GLuint, ByVal mode As GLenum)
Declare Sub glEndConditionalRender()
Declare Sub glVertexAttribIPointer(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glGetVertexAttribIiv(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetVertexAttribIuiv(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Declare Sub glVertexAttribI1i(ByVal index As GLuint, ByVal x As GLint)
Declare Sub glVertexAttribI2i(ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint)
Declare Sub glVertexAttribI3i(ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Declare Sub glVertexAttribI4i(ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Declare Sub glVertexAttribI1ui(ByVal index As GLuint, ByVal x As GLuint)
Declare Sub glVertexAttribI2ui(ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint)
Declare Sub glVertexAttribI3ui(ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint)
Declare Sub glVertexAttribI4ui(ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint, ByVal w As GLuint)
Declare Sub glVertexAttribI1iv(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glVertexAttribI2iv(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glVertexAttribI3iv(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glVertexAttribI4iv(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glVertexAttribI1uiv(ByVal index As GLuint, ByVal v As GLuint Ptr)
Declare Sub glVertexAttribI2uiv(ByVal index As GLuint, ByVal v As GLuint Ptr)
Declare Sub glVertexAttribI3uiv(ByVal index As GLuint, ByVal v As GLuint Ptr)
Declare Sub glVertexAttribI4uiv(ByVal index As GLuint, ByVal v As GLuint Ptr)
Declare Sub glVertexAttribI4bv(ByVal index As GLuint, ByVal v As GLbyte Ptr)
Declare Sub glVertexAttribI4sv(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttribI4ubv(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Declare Sub glVertexAttribI4usv(ByVal index As GLuint, ByVal v As GLushort Ptr)
Declare Sub glGetUniformuiv(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLuint Ptr)
Declare Sub glBindFragDataLocation(ByVal program As GLuint, ByVal Color As GLuint, ByVal Name As GLchar Ptr)
Declare Function glGetFragDataLocation(ByVal program As GLuint, ByVal Name As GLchar Ptr) As GLint
Declare Sub glUniform1ui(ByVal location As GLint, ByVal v0 As GLuint)
Declare Sub glUniform2ui(ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint)
Declare Sub glUniform3ui(ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint)
Declare Sub glUniform4ui(ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint, ByVal v3 As GLuint)
Declare Sub glUniform1uiv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glUniform2uiv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glUniform3uiv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glUniform4uiv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glTexParameterIiv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glTexParameterIuiv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Declare Sub glGetTexParameterIiv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetTexParameterIuiv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Declare Sub glClearBufferiv(ByVal buffer As GLenum, ByVal drawbuffer As GLint, ByVal value As GLint Ptr)
Declare Sub glClearBufferuiv(ByVal buffer As GLenum, ByVal drawbuffer As GLint, ByVal value As GLuint Ptr)
Declare Sub glClearBufferfv(ByVal buffer As GLenum, ByVal drawbuffer As GLint, ByVal value As GLfloat Ptr)
Declare Sub glClearBufferfi(ByVal buffer As GLenum, ByVal drawbuffer As GLint, ByVal depth As GLfloat, ByVal stencil As GLint)
Declare Function glGetStringi(ByVal Name As GLenum, ByVal index As GLuint) As ZString Ptr
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOLORMASKIPROC As Sub(ByVal index As GLuint, ByVal r As GLboolean, ByVal g As GLboolean, ByVal b As GLboolean, ByVal a As GLboolean)
Type PFNGLGETBOOLEANI_VPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLboolean Ptr)
Type PFNGLGETINTEGERI_VPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLint Ptr)
Type PFNGLENABLEIPROC As Sub(ByVal target As GLenum, ByVal index As GLuint)
Type PFNGLDISABLEIPROC As Sub(ByVal target As GLenum, ByVal index As GLuint)
Type PFNGLISENABLEDIPROC As Function(ByVal target As GLenum, ByVal index As GLuint) As GLboolean
Type PFNGLBEGINTRANSFORMFEEDBACKPROC As Sub(ByVal primitiveMode As GLenum)
Type PFNGLENDTRANSFORMFEEDBACKPROC As Sub()
Type PFNGLBINDBUFFERRANGEPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal size As GLsizeiptr)
Type PFNGLBINDBUFFERBASEPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint)
Type PFNGLTRANSFORMFEEDBACKVARYINGSPROC As Sub(ByVal program As GLuint, ByVal count As GLsizei, ByVal varyings As GLchar Ptr Ptr, ByVal bufferMode As GLenum)
Type PFNGLGETTRANSFORMFEEDBACKVARYINGPROC As Sub(ByVal program As GLuint, ByVal index As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLsizei Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLchar Ptr)
Type PFNGLCLAMPCOLORPROC As Sub(ByVal target As GLenum, ByVal clamp As GLenum)
Type PFNGLBEGINCONDITIONALRENDERPROC As Sub(ByVal id As GLuint, ByVal mode As GLenum)
Type PFNGLENDCONDITIONALRENDERPROC As Sub()
Type PFNGLVERTEXATTRIBIPOINTERPROC As Sub(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLGETVERTEXATTRIBIIVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETVERTEXATTRIBIUIVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Type PFNGLVERTEXATTRIBI1IPROC As Sub(ByVal index As GLuint, ByVal x As GLint)
Type PFNGLVERTEXATTRIBI2IPROC As Sub(ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint)
Type PFNGLVERTEXATTRIBI3IPROC As Sub(ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Type PFNGLVERTEXATTRIBI4IPROC As Sub(ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Type PFNGLVERTEXATTRIBI1UIPROC As Sub(ByVal index As GLuint, ByVal x As GLuint)
Type PFNGLVERTEXATTRIBI2UIPROC As Sub(ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint)
Type PFNGLVERTEXATTRIBI3UIPROC As Sub(ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint)
Type PFNGLVERTEXATTRIBI4UIPROC As Sub(ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint, ByVal w As GLuint)
Type PFNGLVERTEXATTRIBI1IVPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLVERTEXATTRIBI2IVPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLVERTEXATTRIBI3IVPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLVERTEXATTRIBI4IVPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLVERTEXATTRIBI1UIVPROC As Sub(ByVal index As GLuint, ByVal v As GLuint Ptr)
Type PFNGLVERTEXATTRIBI2UIVPROC As Sub(ByVal index As GLuint, ByVal v As GLuint Ptr)
Type PFNGLVERTEXATTRIBI3UIVPROC As Sub(ByVal index As GLuint, ByVal v As GLuint Ptr)
Type PFNGLVERTEXATTRIBI4UIVPROC As Sub(ByVal index As GLuint, ByVal v As GLuint Ptr)
Type PFNGLVERTEXATTRIBI4BVPROC As Sub(ByVal index As GLuint, ByVal v As GLbyte Ptr)
Type PFNGLVERTEXATTRIBI4SVPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIBI4UBVPROC As Sub(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Type PFNGLVERTEXATTRIBI4USVPROC As Sub(ByVal index As GLuint, ByVal v As GLushort Ptr)
Type PFNGLGETUNIFORMUIVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLuint Ptr)
Type PFNGLBINDFRAGDATALOCATIONPROC As Sub(ByVal program As GLuint, ByVal Color As GLuint, ByVal Name As GLchar Ptr)
Type PFNGLGETFRAGDATALOCATIONPROC As Function(ByVal program As GLuint, ByVal Name As GLchar Ptr) As GLint
Type PFNGLUNIFORM1UIPROC As Sub(ByVal location As GLint, ByVal v0 As GLuint)
Type PFNGLUNIFORM2UIPROC As Sub(ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint)
Type PFNGLUNIFORM3UIPROC As Sub(ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint)
Type PFNGLUNIFORM4UIPROC As Sub(ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint, ByVal v3 As GLuint)
Type PFNGLUNIFORM1UIVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLUNIFORM2UIVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLUNIFORM3UIVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLUNIFORM4UIVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLTEXPARAMETERIIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLTEXPARAMETERIUIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Type PFNGLGETTEXPARAMETERIIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETTEXPARAMETERIUIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Type PFNGLCLEARBUFFERIVPROC As Sub(ByVal buffer As GLenum, ByVal drawbuffer As GLint, ByVal value As GLint Ptr)
Type PFNGLCLEARBUFFERUIVPROC As Sub(ByVal buffer As GLenum, ByVal drawbuffer As GLint, ByVal value As GLuint Ptr)
Type PFNGLCLEARBUFFERFVPROC As Sub(ByVal buffer As GLenum, ByVal drawbuffer As GLint, ByVal value As GLfloat Ptr)
Type PFNGLCLEARBUFFERFIPROC As Sub(ByVal buffer As GLenum, ByVal drawbuffer As GLint, ByVal depth As GLfloat, ByVal stencil As GLint)
Type PFNGLGETSTRINGIPROC As Function(ByVal Name As GLenum, ByVal index As GLuint) As ZString Ptr
#EndIf

#Ifndef GL_VERSION_3_1
#define GL_VERSION_3_1 1
/' OpenGL 3.1 also reuses entry points from these extensions: '/
/' ARB_copy_buffer '/
/' ARB_uniform_buffer_object '/
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDrawArraysInstanced(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei, ByVal primcount As GLsizei)
Declare Sub glDrawElementsInstanced(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr, ByVal primcount As GLsizei)
Declare Sub glTexBuffer(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal buffer As GLuint)
Declare Sub glPrimitiveRestartIndex(ByVal index As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDRAWARRAYSINSTANCEDPROC As Sub(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei, ByVal primcount As GLsizei)
Type PFNGLDRAWELEMENTSINSTANCEDPROC As Sub(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr, ByVal primcount As GLsizei)
Type PFNGLTEXBUFFERPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal buffer As GLuint)
Type PFNGLPRIMITIVERESTARTINDEXPROC As Sub(ByVal index As GLuint)
#EndIf

#Ifndef GL_VERSION_3_2
#define GL_VERSION_3_2 1
/' OpenGL 3.2 also reuses entry points from these extensions: '/
/' ARB_draw_elements_base_vertex '/
/' ARB_provoking_vertex '/
/' ARB_sync '/
/' ARB_texture_multisample '/
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGetInteger64i_v(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLint64 Ptr)
Declare Sub glGetBufferParameteri64v(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint64 Ptr)
Declare Sub glFramebufferTexture(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETINTEGER64I_VPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLint64 Ptr)
Type PFNGLGETBUFFERPARAMETERI64VPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint64 Ptr)
Type PFNGLFRAMEBUFFERTEXTUREPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint)
#EndIf

#Ifndef GL_VERSION_3_3
#define GL_VERSION_3_3 1
/' OpenGL 3.3 also reuses entry points from these extensions: '/
/' ARB_blend_func_extended '/
/' ARB_sampler_objects '/
/' ARB_explicit_attrib_location, but it has none '/
/' ARB_occlusion_query2 (no entry points) '/
/' ARB_shader_bit_encoding (no entry points) '/
/' ARB_texture_rgb10_a2ui (no entry points) '/
/' ARB_texture_swizzle (no entry points) '/
/' ARB_timer_query '/
/' ARB_vertex_type_2_10_10_10_rev '/
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexAttribDivisor(ByVal index As GLuint, ByVal divisor As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXATTRIBDIVISORPROC As Sub(ByVal index As GLuint, ByVal divisor As GLuint)
#EndIf

#Ifndef GL_VERSION_4_0
#define GL_VERSION_4_0 1
/' OpenGL 4.0 also reuses entry points from these extensions: '/
/' ARB_texture_query_lod (no entry points) '/
/' ARB_draw_indirect '/
/' ARB_gpu_shader5 (no entry points) '/
/' ARB_gpu_shader_fp64 '/
/' ARB_shader_subroutine '/
/' ARB_tessellation_shader '/
/' ARB_texture_buffer_object_rgb32 (no entry points) '/
/' ARB_texture_cube_map_array (no entry points) '/
/' ARB_texture_gather (no entry points) '/
/' ARB_transform_feedback2 '/
/' ARB_transform_feedback3 '/
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glMinSampleShading(ByVal value As GLclampf)
Declare Sub glBlendEquationi(ByVal buf As GLuint, ByVal mode As GLenum)
Declare Sub glBlendEquationSeparatei(ByVal buf As GLuint, ByVal modeRGB As GLenum, ByVal modeAlpha As GLenum)
Declare Sub glBlendFunci(ByVal buf As GLuint, ByVal src As GLenum, ByVal dst As GLenum)
Declare Sub glBlendFuncSeparatei(ByVal buf As GLuint, ByVal srcRGB As GLenum, ByVal dstRGB As GLenum, ByVal srcAlpha As GLenum, ByVal dstAlpha As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLMINSAMPLESHADINGPROC As Sub(ByVal value As GLclampf)
Type PFNGLBLENDEQUATIONIPROC As Sub(ByVal buf As GLuint, ByVal mode As GLenum)
Type PFNGLBLENDEQUATIONSEPARATEIPROC As Sub(ByVal buf As GLuint, ByVal modeRGB As GLenum, ByVal modeAlpha As GLenum)
Type PFNGLBLENDFUNCIPROC As Sub(ByVal buf As GLuint, ByVal src As GLenum, ByVal dst As GLenum)
Type PFNGLBLENDFUNCSEPARATEIPROC As Sub(ByVal buf As GLuint, ByVal srcRGB As GLenum, ByVal dstRGB As GLenum, ByVal srcAlpha As GLenum, ByVal dstAlpha As GLenum)
#EndIf

#Ifndef GL_VERSION_4_1
#define GL_VERSION_4_1 1
/' OpenGL 4.1 reuses entry points from these extensions: '/
/' ARB_ES2_compatibility '/
/' ARB_get_program_binary '/
/' ARB_separate_shader_objects '/
/' ARB_shader_precision (no entry points) '/
/' ARB_vertex_attrib_64bit '/
/' ARB_viewport_array '/
#EndIf

#Ifndef GL_VERSION_4_2
#define GL_VERSION_4_2 1
/' OpenGL 4.2 reuses entry points from these extensions: '/
/' ARB_base_instance '/
/' ARB_shading_language_420pack (no entry points) '/
/' ARB_transform_feedback_instanced '/
/' ARB_compressed_texture_pixel_storage (no entry points) '/
/' ARB_conservative_depth (no entry points) '/
/' ARB_internalformat_query '/
/' ARB_map_buffer_alignment (no entry points) '/
/' ARB_shader_atomic_counters '/
/' ARB_shader_image_load_store '/
/' ARB_shading_language_packing (no entry points) '/
/' ARB_texture_storage '/
#EndIf

#Ifndef GL_ARB_multitexture
#define GL_ARB_multitexture 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glActiveTextureARB(ByVal texture As GLenum)
Declare Sub glClientActiveTextureARB(ByVal texture As GLenum)
Declare Sub glMultiTexCoord1dARB(ByVal target As GLenum, ByVal s As GLdouble)
Declare Sub glMultiTexCoord1dvARB(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Declare Sub glMultiTexCoord1fARB(ByVal target As GLenum, ByVal s As GLfloat)
Declare Sub glMultiTexCoord1fvARB(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Declare Sub glMultiTexCoord1iARB(ByVal target As GLenum, ByVal s As GLint)
Declare Sub glMultiTexCoord1ivARB(ByVal target As GLenum, ByVal v As GLint Ptr)
Declare Sub glMultiTexCoord1sARB(ByVal target As GLenum, ByVal s As GLshort)
Declare Sub glMultiTexCoord1svARB(ByVal target As GLenum, ByVal v As GLshort Ptr)
Declare Sub glMultiTexCoord2dARB(ByVal target As GLenum, ByVal s As GLdouble, ByVal t As GLdouble)
Declare Sub glMultiTexCoord2dvARB(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Declare Sub glMultiTexCoord2fARB(ByVal target As GLenum, ByVal s As GLfloat, ByVal t As GLfloat)
Declare Sub glMultiTexCoord2fvARB(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Declare Sub glMultiTexCoord2iARB(ByVal target As GLenum, ByVal s As GLint, ByVal t As GLint)
Declare Sub glMultiTexCoord2ivARB(ByVal target As GLenum, ByVal v As GLint Ptr)
Declare Sub glMultiTexCoord2sARB(ByVal target As GLenum, ByVal s As GLshort, ByVal t As GLshort)
Declare Sub glMultiTexCoord2svARB(ByVal target As GLenum, ByVal v As GLshort Ptr)
Declare Sub glMultiTexCoord3dARB(ByVal target As GLenum, ByVal s As GLdouble, ByVal t As GLdouble, ByVal r As GLdouble)
Declare Sub glMultiTexCoord3dvARB(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Declare Sub glMultiTexCoord3fARB(ByVal target As GLenum, ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat)
Declare Sub glMultiTexCoord3fvARB(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Declare Sub glMultiTexCoord3iARB(ByVal target As GLenum, ByVal s As GLint, ByVal t As GLint, ByVal r As GLint)
Declare Sub glMultiTexCoord3ivARB(ByVal target As GLenum, ByVal v As GLint Ptr)
Declare Sub glMultiTexCoord3sARB(ByVal target As GLenum, ByVal s As GLshort, ByVal t As GLshort, ByVal r As GLshort)
Declare Sub glMultiTexCoord3svARB(ByVal target As GLenum, ByVal v As GLshort Ptr)
Declare Sub glMultiTexCoord4dARB(ByVal target As GLenum, ByVal s As GLdouble, ByVal t As GLdouble, ByVal r As GLdouble, ByVal q As GLdouble)
Declare Sub glMultiTexCoord4dvARB(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Declare Sub glMultiTexCoord4fARB(ByVal target As GLenum, ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat, ByVal q As GLfloat)
Declare Sub glMultiTexCoord4fvARB(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Declare Sub glMultiTexCoord4iARB(ByVal target As GLenum, ByVal s As GLint, ByVal t As GLint, ByVal r As GLint, ByVal q As GLint)
Declare Sub glMultiTexCoord4ivARB(ByVal target As GLenum, ByVal v As GLint Ptr)
Declare Sub glMultiTexCoord4sARB(ByVal target As GLenum, ByVal s As GLshort, ByVal t As GLshort, ByVal r As GLshort, ByVal q As GLshort)
Declare Sub glMultiTexCoord4svARB(ByVal target As GLenum, ByVal v As GLshort Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLACTIVETEXTUREARBPROC As Sub(ByVal texture As GLenum)
Type PFNGLCLIENTACTIVETEXTUREARBPROC As Sub(ByVal texture As GLenum)
Type PFNGLMULTITEXCOORD1DARBPROC As Sub(ByVal target As GLenum, ByVal s As GLdouble)
Type PFNGLMULTITEXCOORD1DVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Type PFNGLMULTITEXCOORD1FARBPROC As Sub(ByVal target As GLenum, ByVal s As GLfloat)
Type PFNGLMULTITEXCOORD1FVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Type PFNGLMULTITEXCOORD1IARBPROC As Sub(ByVal target As GLenum, ByVal s As GLint)
Type PFNGLMULTITEXCOORD1IVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLint Ptr)
Type PFNGLMULTITEXCOORD1SARBPROC As Sub(ByVal target As GLenum, ByVal s As GLshort)
Type PFNGLMULTITEXCOORD1SVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLshort Ptr)
Type PFNGLMULTITEXCOORD2DARBPROC As Sub(ByVal target As GLenum, ByVal s As GLdouble, ByVal t As GLdouble)
Type PFNGLMULTITEXCOORD2DVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Type PFNGLMULTITEXCOORD2FARBPROC As Sub(ByVal target As GLenum, ByVal s As GLfloat, ByVal t As GLfloat)
Type PFNGLMULTITEXCOORD2FVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Type PFNGLMULTITEXCOORD2IARBPROC As Sub(ByVal target As GLenum, ByVal s As GLint, ByVal t As GLint)
Type PFNGLMULTITEXCOORD2IVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLint Ptr)
Type PFNGLMULTITEXCOORD2SARBPROC As Sub(ByVal target As GLenum, ByVal s As GLshort, ByVal t As GLshort)
Type PFNGLMULTITEXCOORD2SVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLshort Ptr)
Type PFNGLMULTITEXCOORD3DARBPROC As Sub(ByVal target As GLenum, ByVal s As GLdouble, ByVal t As GLdouble, ByVal r As GLdouble)
Type PFNGLMULTITEXCOORD3DVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Type PFNGLMULTITEXCOORD3FARBPROC As Sub(ByVal target As GLenum, ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat)
Type PFNGLMULTITEXCOORD3FVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Type PFNGLMULTITEXCOORD3IARBPROC As Sub(ByVal target As GLenum, ByVal s As GLint, ByVal t As GLint, ByVal r As GLint)
Type PFNGLMULTITEXCOORD3IVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLint Ptr)
Type PFNGLMULTITEXCOORD3SARBPROC As Sub(ByVal target As GLenum, ByVal s As GLshort, ByVal t As GLshort, ByVal r As GLshort)
Type PFNGLMULTITEXCOORD3SVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLshort Ptr)
Type PFNGLMULTITEXCOORD4DARBPROC As Sub(ByVal target As GLenum, ByVal s As GLdouble, ByVal t As GLdouble, ByVal r As GLdouble, ByVal q As GLdouble)
Type PFNGLMULTITEXCOORD4DVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLdouble Ptr)
Type PFNGLMULTITEXCOORD4FARBPROC As Sub(ByVal target As GLenum, ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat, ByVal q As GLfloat)
Type PFNGLMULTITEXCOORD4FVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLfloat Ptr)
Type PFNGLMULTITEXCOORD4IARBPROC As Sub(ByVal target As GLenum, ByVal s As GLint, ByVal t As GLint, ByVal r As GLint, ByVal q As GLint)
Type PFNGLMULTITEXCOORD4IVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLint Ptr)
Type PFNGLMULTITEXCOORD4SARBPROC As Sub(ByVal target As GLenum, ByVal s As GLshort, ByVal t As GLshort, ByVal r As GLshort, ByVal q As GLshort)
Type PFNGLMULTITEXCOORD4SVARBPROC As Sub(ByVal target As GLenum, ByVal v As GLshort Ptr)
#EndIf

#Ifndef GL_ARB_transpose_matrix
#define GL_ARB_transpose_matrix 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glLoadTransposeMatrixfARB(ByVal m As GLfloat Ptr)
Declare Sub glLoadTransposeMatrixdARB(ByVal m As GLdouble Ptr)
Declare Sub glMultTransposeMatrixfARB(ByVal m As GLfloat Ptr)
Declare Sub glMultTransposeMatrixdARB(ByVal m As GLdouble Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLLOADTRANSPOSEMATRIXFARBPROC As Sub(ByVal m As GLfloat Ptr)
Type PFNGLLOADTRANSPOSEMATRIXDARBPROC As Sub(ByVal m As GLdouble Ptr)
Type PFNGLMULTTRANSPOSEMATRIXFARBPROC As Sub(ByVal m As GLfloat Ptr)
Type PFNGLMULTTRANSPOSEMATRIXDARBPROC As Sub(ByVal m As GLdouble Ptr)
#EndIf

#Ifndef GL_ARB_multisample
#define GL_ARB_multisample 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glSampleCoverageARB(ByVal value As GLclampf, ByVal invert As GLboolean)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLSAMPLECOVERAGEARBPROC As Sub(ByVal value As GLclampf, ByVal invert As GLboolean)
#EndIf

#Ifndef GL_ARB_texture_env_add
#define GL_ARB_texture_env_add 1
#EndIf

#Ifndef GL_ARB_texture_cube_map
#define GL_ARB_texture_cube_map 1
#EndIf

#Ifndef GL_ARB_texture_compression
#define GL_ARB_texture_compression 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glCompressedTexImage3DARB(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexImage2DARB(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexImage1DARB(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexSubImage3DARB(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexSubImage2DARB(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glCompressedTexSubImage1DARB(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glGetCompressedTexImageARB(ByVal target As GLenum, ByVal level As GLint, ByVal img As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOMPRESSEDTEXIMAGE3DARBPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXIMAGE2DARBPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXIMAGE1DARBPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXSUBIMAGE3DARBPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXSUBIMAGE2DARBPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXSUBIMAGE1DARBPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLGETCOMPRESSEDTEXIMAGEARBPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal img As GLvoid Ptr)
#EndIf

#Ifndef GL_ARB_texture_border_clamp
#define GL_ARB_texture_border_clamp 1
#EndIf

#Ifndef GL_ARB_point_parameters
#define GL_ARB_point_parameters 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPointParameterfARB(ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glPointParameterfvARB(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPOINTPARAMETERFARBPROC As Sub(ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLPOINTPARAMETERFVARBPROC As Sub(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf

#Ifndef GL_ARB_vertex_blend
#define GL_ARB_vertex_blend 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glWeightbvARB(ByVal size As GLint, ByVal weights As GLbyte Ptr)
Declare Sub glWeightsvARB(ByVal size As GLint, ByVal weights As GLshort Ptr)
Declare Sub glWeightivARB(ByVal size As GLint, ByVal weights As GLint Ptr)
Declare Sub glWeightfvARB(ByVal size As GLint, ByVal weights As GLfloat Ptr)
Declare Sub glWeightdvARB(ByVal size As GLint, ByVal weights As GLdouble Ptr)
Declare Sub glWeightubvARB(ByVal size As GLint, ByVal weights As GLubyte Ptr)
Declare Sub glWeightusvARB(ByVal size As GLint, ByVal weights As GLushort Ptr)
Declare Sub glWeightuivARB(ByVal size As GLint, ByVal weights As GLuint Ptr)
Declare Sub glWeightPointerARB(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glVertexBlendARB(ByVal count As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLWEIGHTBVARBPROC As Sub(ByVal size As GLint, ByVal weights As GLbyte Ptr)
Type PFNGLWEIGHTSVARBPROC As Sub(ByVal size As GLint, ByVal weights As GLshort Ptr)
Type PFNGLWEIGHTIVARBPROC As Sub(ByVal size As GLint, ByVal weights As GLint Ptr)
Type PFNGLWEIGHTFVARBPROC As Sub(ByVal size As GLint, ByVal weights As GLfloat Ptr)
Type PFNGLWEIGHTDVARBPROC As Sub(ByVal size As GLint, ByVal weights As GLdouble Ptr)
Type PFNGLWEIGHTUBVARBPROC As Sub(ByVal size As GLint, ByVal weights As GLubyte Ptr)
Type PFNGLWEIGHTUSVARBPROC As Sub(ByVal size As GLint, ByVal weights As GLushort Ptr)
Type PFNGLWEIGHTUIVARBPROC As Sub(ByVal size As GLint, ByVal weights As GLuint Ptr)
Type PFNGLWEIGHTPOINTERARBPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLVERTEXBLENDARBPROC As Sub(ByVal count As GLint)
#EndIf

#Ifndef GL_ARB_matrix_palette
#define GL_ARB_matrix_palette 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glCurrentPaletteMatrixARB(ByVal index As GLint)
Declare Sub glMatrixIndexubvARB(ByVal size As GLint, ByVal indices As GLubyte Ptr)
Declare Sub glMatrixIndexusvARB(ByVal size As GLint, ByVal indices As GLushort Ptr)
Declare Sub glMatrixIndexuivARB(ByVal size As GLint, ByVal indices As GLuint Ptr)
Declare Sub glMatrixIndexPointerARB(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCURRENTPALETTEMATRIXARBPROC As Sub(ByVal index As GLint)
Type PFNGLMATRIXINDEXUBVARBPROC As Sub(ByVal size As GLint, ByVal indices As GLubyte Ptr)
Type PFNGLMATRIXINDEXUSVARBPROC As Sub(ByVal size As GLint, ByVal indices As GLushort Ptr)
Type PFNGLMATRIXINDEXUIVARBPROC As Sub(ByVal size As GLint, ByVal indices As GLuint Ptr)
Type PFNGLMATRIXINDEXPOINTERARBPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf

#Ifndef GL_ARB_texture_env_combine
#define GL_ARB_texture_env_combine 1
#EndIf

#Ifndef GL_ARB_texture_env_crossbar
#define GL_ARB_texture_env_crossbar 1
#EndIf

#Ifndef GL_ARB_texture_env_dot3
#define GL_ARB_texture_env_dot3 1
#EndIf

#Ifndef GL_ARB_texture_mirrored_repeat
#define GL_ARB_texture_mirrored_repeat 1
#EndIf

#Ifndef GL_ARB_depth_texture
#define GL_ARB_depth_texture 1
#EndIf

#Ifndef GL_ARB_shadow
#define GL_ARB_shadow 1
#EndIf

#Ifndef GL_ARB_shadow_ambient
#define GL_ARB_shadow_ambient 1
#EndIf

#Ifndef GL_ARB_window_pos
#define GL_ARB_window_pos 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glWindowPos2dARB(ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glWindowPos2dvARB(ByVal v As GLdouble Ptr)
Declare Sub glWindowPos2fARB(ByVal x As GLfloat, ByVal y As GLfloat)
Declare Sub glWindowPos2fvARB(ByVal v As GLfloat Ptr)
Declare Sub glWindowPos2iARB(ByVal x As GLint, ByVal y As GLint)
Declare Sub glWindowPos2ivARB(ByVal v As GLint Ptr)
Declare Sub glWindowPos2sARB(ByVal x As GLshort, ByVal y As GLshort)
Declare Sub glWindowPos2svARB(ByVal v As GLshort Ptr)
Declare Sub glWindowPos3dARB(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glWindowPos3dvARB(ByVal v As GLdouble Ptr)
Declare Sub glWindowPos3fARB(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glWindowPos3fvARB(ByVal v As GLfloat Ptr)
Declare Sub glWindowPos3iARB(ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Declare Sub glWindowPos3ivARB(ByVal v As GLint Ptr)
Declare Sub glWindowPos3sARB(ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Declare Sub glWindowPos3svARB(ByVal v As GLshort Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLWINDOWPOS2DARBPROC As Sub(ByVal x As GLdouble, ByVal y As GLdouble)
Type PFNGLWINDOWPOS2DVARBPROC As Sub(ByVal v As GLdouble Ptr)
Type PFNGLWINDOWPOS2FARBPROC As Sub(ByVal x As GLfloat, ByVal y As GLfloat)
Type PFNGLWINDOWPOS2FVARBPROC As Sub(ByVal v As GLfloat Ptr)
Type PFNGLWINDOWPOS2IARBPROC As Sub(ByVal x As GLint, ByVal y As GLint)
Type PFNGLWINDOWPOS2IVARBPROC As Sub(ByVal v As GLint Ptr)
Type PFNGLWINDOWPOS2SARBPROC As Sub(ByVal x As GLshort, ByVal y As GLshort)
Type PFNGLWINDOWPOS2SVARBPROC As Sub(ByVal v As GLshort Ptr)
Type PFNGLWINDOWPOS3DARBPROC As Sub(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLWINDOWPOS3DVARBPROC As Sub(ByVal v As GLdouble Ptr)
Type PFNGLWINDOWPOS3FARBPROC As Sub(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLWINDOWPOS3FVARBPROC As Sub(ByVal v As GLfloat Ptr)
Type PFNGLWINDOWPOS3IARBPROC As Sub(ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Type PFNGLWINDOWPOS3IVARBPROC As Sub(ByVal v As GLint Ptr)
Type PFNGLWINDOWPOS3SARBPROC As Sub(ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Type PFNGLWINDOWPOS3SVARBPROC As Sub(ByVal v As GLshort Ptr)
#EndIf

#Ifndef GL_ARB_vertex_program
#define GL_ARB_vertex_program 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexAttrib1dARB(ByVal index As GLuint, ByVal x As GLdouble)
Declare Sub glVertexAttrib1dvARB(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttrib1fARB(ByVal index As GLuint, ByVal x As GLfloat)
Declare Sub glVertexAttrib1fvARB(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttrib1sARB(ByVal index As GLuint, ByVal x As GLshort)
Declare Sub glVertexAttrib1svARB(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib2dARB(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glVertexAttrib2dvARB(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttrib2fARB(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat)
Declare Sub glVertexAttrib2fvARB(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttrib2sARB(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort)
Declare Sub glVertexAttrib2svARB(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib3dARB(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glVertexAttrib3dvARB(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttrib3fARB(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glVertexAttrib3fvARB(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttrib3sARB(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Declare Sub glVertexAttrib3svARB(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib4NbvARB(ByVal index As GLuint, ByVal v As GLbyte Ptr)
Declare Sub glVertexAttrib4NivARB(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glVertexAttrib4NsvARB(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib4NubARB(ByVal index As GLuint, ByVal x As GLubyte, ByVal y As GLubyte, ByVal z As GLubyte, ByVal w As GLubyte)
Declare Sub glVertexAttrib4NubvARB(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Declare Sub glVertexAttrib4NuivARB(ByVal index As GLuint, ByVal v As GLuint Ptr)
Declare Sub glVertexAttrib4NusvARB(ByVal index As GLuint, ByVal v As GLushort Ptr)
Declare Sub glVertexAttrib4bvARB(ByVal index As GLuint, ByVal v As GLbyte Ptr)
Declare Sub glVertexAttrib4dARB(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glVertexAttrib4dvARB(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttrib4fARB(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glVertexAttrib4fvARB(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttrib4ivARB(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glVertexAttrib4sARB(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort, ByVal w As GLshort)
Declare Sub glVertexAttrib4svARB(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib4ubvARB(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Declare Sub glVertexAttrib4uivARB(ByVal index As GLuint, ByVal v As GLuint Ptr)
Declare Sub glVertexAttrib4usvARB(ByVal index As GLuint, ByVal v As GLushort Ptr)
Declare Sub glVertexAttribPointerARB(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glEnableVertexAttribArrayARB(ByVal index As GLuint)
Declare Sub glDisableVertexAttribArrayARB(ByVal index As GLuint)
Declare Sub glProgramStringARB(ByVal target As GLenum, ByVal Format As GLenum, ByVal Len As GLsizei, ByVal String As GLvoid Ptr)
Declare Sub glBindProgramARB(ByVal target As GLenum, ByVal program As GLuint)
Declare Sub glDeleteProgramsARB(ByVal n As GLsizei, ByVal programs As GLuint Ptr)
Declare Sub glGenProgramsARB(ByVal n As GLsizei, ByVal programs As GLuint Ptr)
Declare Sub glProgramEnvParameter4dARB(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glProgramEnvParameter4dvARB(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLdouble Ptr)
Declare Sub glProgramEnvParameter4fARB(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glProgramEnvParameter4fvARB(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLfloat Ptr)
Declare Sub glProgramLocalParameter4dARB(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glProgramLocalParameter4dvARB(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLdouble Ptr)
Declare Sub glProgramLocalParameter4fARB(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glProgramLocalParameter4fvARB(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLfloat Ptr)
Declare Sub glGetProgramEnvParameterdvARB(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLdouble Ptr)
Declare Sub glGetProgramEnvParameterfvARB(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLfloat Ptr)
Declare Sub glGetProgramLocalParameterdvARB(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLdouble Ptr)
Declare Sub glGetProgramLocalParameterfvARB(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLfloat Ptr)
Declare Sub glGetProgramivARB(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetProgramStringARB(ByVal target As GLenum, ByVal pname As GLenum, ByVal String As GLvoid Ptr)
Declare Sub glGetVertexAttribdvARB(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Declare Sub glGetVertexAttribfvARB(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetVertexAttribivARB(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetVertexAttribPointervARB(ByVal index As GLuint, ByVal pname As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
Declare Function glIsProgramARB(ByVal program As GLuint) As GLboolean
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXATTRIB1DARBPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble)
Type PFNGLVERTEXATTRIB1DVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIB1FARBPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat)
Type PFNGLVERTEXATTRIB1FVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIB1SARBPROC As Sub(ByVal index As GLuint, ByVal x As GLshort)
Type PFNGLVERTEXATTRIB1SVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB2DARBPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble)
Type PFNGLVERTEXATTRIB2DVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIB2FARBPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat)
Type PFNGLVERTEXATTRIB2FVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIB2SARBPROC As Sub(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort)
Type PFNGLVERTEXATTRIB2SVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB3DARBPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLVERTEXATTRIB3DVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIB3FARBPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLVERTEXATTRIB3FVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIB3SARBPROC As Sub(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Type PFNGLVERTEXATTRIB3SVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB4NBVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLbyte Ptr)
Type PFNGLVERTEXATTRIB4NIVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLVERTEXATTRIB4NSVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB4NUBARBPROC As Sub(ByVal index As GLuint, ByVal x As GLubyte, ByVal y As GLubyte, ByVal z As GLubyte, ByVal w As GLubyte)
Type PFNGLVERTEXATTRIB4NUBVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Type PFNGLVERTEXATTRIB4NUIVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLuint Ptr)
Type PFNGLVERTEXATTRIB4NUSVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLushort Ptr)
Type PFNGLVERTEXATTRIB4BVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLbyte Ptr)
Type PFNGLVERTEXATTRIB4DARBPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLVERTEXATTRIB4DVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIB4FARBPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Type PFNGLVERTEXATTRIB4FVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIB4IVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLVERTEXATTRIB4SARBPROC As Sub(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort, ByVal w As GLshort)
Type PFNGLVERTEXATTRIB4SVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB4UBVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Type PFNGLVERTEXATTRIB4UIVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLuint Ptr)
Type PFNGLVERTEXATTRIB4USVARBPROC As Sub(ByVal index As GLuint, ByVal v As GLushort Ptr)
Type PFNGLVERTEXATTRIBPOINTERARBPROC As Sub(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLENABLEVERTEXATTRIBARRAYARBPROC As Sub(ByVal index As GLuint)
Type PFNGLDISABLEVERTEXATTRIBARRAYARBPROC As Sub(ByVal index As GLuint)
Type PFNGLPROGRAMSTRINGARBPROC As Sub(ByVal target As GLenum, ByVal Format As GLenum, ByVal Len As GLsizei, ByVal String As GLvoid Ptr)
Type PFNGLBINDPROGRAMARBPROC As Sub(ByVal target As GLenum, ByVal program As GLuint)
Type PFNGLDELETEPROGRAMSARBPROC As Sub(ByVal n As GLsizei, ByVal programs As GLuint Ptr)
Type PFNGLGENPROGRAMSARBPROC As Sub(ByVal n As GLsizei, ByVal programs As GLuint Ptr)
Type PFNGLPROGRAMENVPARAMETER4DARBPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLPROGRAMENVPARAMETER4DVARBPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLdouble Ptr)
Type PFNGLPROGRAMENVPARAMETER4FARBPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Type PFNGLPROGRAMENVPARAMETER4FVARBPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLfloat Ptr)
Type PFNGLPROGRAMLOCALPARAMETER4DARBPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLPROGRAMLOCALPARAMETER4DVARBPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLdouble Ptr)
Type PFNGLPROGRAMLOCALPARAMETER4FARBPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Type PFNGLPROGRAMLOCALPARAMETER4FVARBPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLfloat Ptr)
Type PFNGLGETPROGRAMENVPARAMETERDVARBPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLdouble Ptr)
Type PFNGLGETPROGRAMENVPARAMETERFVARBPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLfloat Ptr)
Type PFNGLGETPROGRAMLOCALPARAMETERDVARBPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLdouble Ptr)
Type PFNGLGETPROGRAMLOCALPARAMETERFVARBPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLfloat Ptr)
Type PFNGLGETPROGRAMIVARBPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETPROGRAMSTRINGARBPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal String As GLvoid Ptr)
Type PFNGLGETVERTEXATTRIBDVARBPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Type PFNGLGETVERTEXATTRIBFVARBPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETVERTEXATTRIBIVARBPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETVERTEXATTRIBPOINTERVARBPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
Type PFNGLISPROGRAMARBPROC As Function(ByVal program As GLuint) As GLboolean
#EndIf

#Ifndef GL_ARB_fragment_program
#define GL_ARB_fragment_program 1
/' All ARB_fragment_program entry points are shared with ARB_vertex_program. '/
#EndIf

#Ifndef GL_ARB_vertex_buffer_object
#define GL_ARB_vertex_buffer_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBindBufferARB(ByVal target As GLenum, ByVal buffer As GLuint)
Declare Sub glDeleteBuffersARB(ByVal n As GLsizei, ByVal buffers As GLuint Ptr)
Declare Sub glGenBuffersARB(ByVal n As GLsizei, ByVal buffers As GLuint Ptr)
Declare Function glIsBufferARB(ByVal buffer As GLuint) As GLboolean
Declare Sub glBufferDataARB(ByVal target As GLenum, ByVal size As GLsizeiptrARB, ByVal Data As GLvoid Ptr, ByVal usage As GLenum)
Declare Sub glBufferSubDataARB(ByVal target As GLenum, ByVal offset As GLintptrARB, ByVal size As GLsizeiptrARB, ByVal Data As GLvoid Ptr)
Declare Sub glGetBufferSubDataARB(ByVal target As GLenum, ByVal offset As GLintptrARB, ByVal size As GLsizeiptrARB, ByVal Data As GLvoid Ptr)
Declare Function glMapBufferARB(ByVal target As GLenum, ByVal Access As GLenum) As GLvoid Ptr
Declare Function glUnmapBufferARB(ByVal target As GLenum) As GLboolean
Declare Sub glGetBufferParameterivARB(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetBufferPointervARB(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLvoid Ptr Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBINDBUFFERARBPROC As Sub(ByVal target As GLenum, ByVal buffer As GLuint)
Type PFNGLDELETEBUFFERSARBPROC As Sub(ByVal n As GLsizei, ByVal buffers As GLuint Ptr)
Type PFNGLGENBUFFERSARBPROC As Sub(ByVal n As GLsizei, ByVal buffers As GLuint Ptr)
Type PFNGLISBUFFERARBPROC As Function(ByVal buffer As GLuint) As GLboolean
Type PFNGLBUFFERDATAARBPROC As Sub(ByVal target As GLenum, ByVal size As GLsizeiptrARB, ByVal Data As GLvoid Ptr, ByVal usage As GLenum)
Type PFNGLBUFFERSUBDATAARBPROC As Sub(ByVal target As GLenum, ByVal offset As GLintptrARB, ByVal size As GLsizeiptrARB, ByVal Data As GLvoid Ptr)
Type PFNGLGETBUFFERSUBDATAARBPROC As Sub(ByVal target As GLenum, ByVal offset As GLintptrARB, ByVal size As GLsizeiptrARB, ByVal Data As GLvoid Ptr)
Type PFNGLMAPBUFFERARBPROC As Function(ByVal target As GLenum, ByVal Access As GLenum) As GLvoid Ptr
Type PFNGLUNMAPBUFFERARBPROC As Function(ByVal target As GLenum) As GLboolean
Type PFNGLGETBUFFERPARAMETERIVARBPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETBUFFERPOINTERVARBPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLvoid Ptr Ptr)
#EndIf

#Ifndef GL_ARB_occlusion_query
#define GL_ARB_occlusion_query 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGenQueriesARB(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Declare Sub glDeleteQueriesARB(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Declare Function glIsQueryARB(ByVal id As GLuint) As GLboolean
Declare Sub glBeginQueryARB(ByVal target As GLenum, ByVal id As GLuint)
Declare Sub glEndQueryARB(ByVal target As GLenum)
Declare Sub glGetQueryivARB(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetQueryObjectivARB(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetQueryObjectuivARB(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGENQUERIESARBPROC As Sub(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Type PFNGLDELETEQUERIESARBPROC As Sub(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Type PFNGLISQUERYARBPROC As Function(ByVal id As GLuint) As GLboolean
Type PFNGLBEGINQUERYARBPROC As Sub(ByVal target As GLenum, ByVal id As GLuint)
Type PFNGLENDQUERYARBPROC As Sub(ByVal target As GLenum)
Type PFNGLGETQUERYIVARBPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETQUERYOBJECTIVARBPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETQUERYOBJECTUIVARBPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
#EndIf

#Ifndef GL_ARB_shader_objects
#define GL_ARB_shader_objects 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDeleteObjectARB(ByVal obj As GLhandleARB)
Declare Function glGetHandleARB(ByVal pname As GLenum) As GLhandleARB
Declare Sub glDetachObjectARB(ByVal containerObj As GLhandleARB, ByVal attachedObj As GLhandleARB)
Declare Function glCreateShaderObjectARB(ByVal shaderType As GLenum) As GLhandleARB
Declare Sub glShaderSourceARB(ByVal shaderObj As GLhandleARB, ByVal count As GLsizei, ByVal String As GLcharARB Ptr Ptr, ByVal length As GLint Ptr)
Declare Sub glCompileShaderARB(ByVal shaderObj As GLhandleARB)
Declare Function glCreateProgramObjectARB() As GLhandleARB
Declare Sub glAttachObjectARB(ByVal containerObj As GLhandleARB, ByVal obj As GLhandleARB)
Declare Sub glLinkProgramARB(ByVal programObj As GLhandleARB)
Declare Sub glUseProgramObjectARB(ByVal programObj As GLhandleARB)
Declare Sub glValidateProgramARB(ByVal programObj As GLhandleARB)
Declare Sub glUniform1fARB(ByVal location As GLint, ByVal v0 As GLfloat)
Declare Sub glUniform2fARB(ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat)
Declare Sub glUniform3fARB(ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat)
Declare Sub glUniform4fARB(ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal v3 As GLfloat)
Declare Sub glUniform1iARB(ByVal location As GLint, ByVal v0 As GLint)
Declare Sub glUniform2iARB(ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint)
Declare Sub glUniform3iARB(ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint)
Declare Sub glUniform4iARB(ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint, ByVal v3 As GLint)
Declare Sub glUniform1fvARB(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glUniform2fvARB(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glUniform3fvARB(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glUniform4fvARB(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glUniform1ivARB(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glUniform2ivARB(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glUniform3ivARB(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glUniform4ivARB(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glUniformMatrix2fvARB(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glUniformMatrix3fvARB(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glUniformMatrix4fvARB(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glGetObjectParameterfvARB(ByVal obj As GLhandleARB, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetObjectParameterivARB(ByVal obj As GLhandleARB, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetInfoLogARB(ByVal obj As GLhandleARB, ByVal maxLength As GLsizei, ByVal length As GLsizei Ptr, ByVal infoLog As GLcharARB Ptr)
Declare Sub glGetAttachedObjectsARB(ByVal containerObj As GLhandleARB, ByVal maxCount As GLsizei, ByVal count As GLsizei Ptr, ByVal obj As GLhandleARB Ptr)
Declare Function glGetUniformLocationARB(ByVal programObj As GLhandleARB, ByVal Name As GLcharARB Ptr) As GLint
Declare Sub glGetActiveUniformARB(ByVal programObj As GLhandleARB, ByVal index As GLuint, ByVal maxLength As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLint Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLcharARB Ptr)
Declare Sub glGetUniformfvARB(ByVal programObj As GLhandleARB, ByVal location As GLint, ByVal params As GLfloat Ptr)
Declare Sub glGetUniformivARB(ByVal programObj As GLhandleARB, ByVal location As GLint, ByVal params As GLint Ptr)
Declare Sub glGetShaderSourceARB(ByVal obj As GLhandleARB, ByVal maxLength As GLsizei, ByVal length As GLsizei Ptr, ByVal source As GLcharARB Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDELETEOBJECTARBPROC As Sub(ByVal obj As GLhandleARB)
Type PFNGLGETHANDLEARBPROC As Function(ByVal pname As GLenum) As GLhandleARB
Type PFNGLDETACHOBJECTARBPROC As Sub(ByVal containerObj As GLhandleARB, ByVal attachedObj As GLhandleARB)
Type PFNGLCREATESHADEROBJECTARBPROC As Function(ByVal shaderType As GLenum) As GLhandleARB
Type PFNGLSHADERSOURCEARBPROC As Sub(ByVal shaderObj As GLhandleARB, ByVal count As GLsizei, ByVal String As GLcharARB Ptr Ptr, ByVal length As GLint Ptr)
Type PFNGLCOMPILESHADERARBPROC As Sub(ByVal shaderObj As GLhandleARB)
Type PFNGLCREATEPROGRAMOBJECTARBPROC As Function() As GLhandleARB
Type PFNGLATTACHOBJECTARBPROC As Sub(ByVal containerObj As GLhandleARB, ByVal obj As GLhandleARB)
Type PFNGLLINKPROGRAMARBPROC As Sub(ByVal programObj As GLhandleARB)
Type PFNGLUSEPROGRAMOBJECTARBPROC As Sub(ByVal programObj As GLhandleARB)
Type PFNGLVALIDATEPROGRAMARBPROC As Sub(ByVal programObj As GLhandleARB)
Type PFNGLUNIFORM1FARBPROC As Sub(ByVal location As GLint, ByVal v0 As GLfloat)
Type PFNGLUNIFORM2FARBPROC As Sub(ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat)
Type PFNGLUNIFORM3FARBPROC As Sub(ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat)
Type PFNGLUNIFORM4FARBPROC As Sub(ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal v3 As GLfloat)
Type PFNGLUNIFORM1IARBPROC As Sub(ByVal location As GLint, ByVal v0 As GLint)
Type PFNGLUNIFORM2IARBPROC As Sub(ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint)
Type PFNGLUNIFORM3IARBPROC As Sub(ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint)
Type PFNGLUNIFORM4IARBPROC As Sub(ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint, ByVal v3 As GLint)
Type PFNGLUNIFORM1FVARBPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORM2FVARBPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORM3FVARBPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORM4FVARBPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORM1IVARBPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLUNIFORM2IVARBPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLUNIFORM3IVARBPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLUNIFORM4IVARBPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLUNIFORMMATRIX2FVARBPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORMMATRIX3FVARBPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLUNIFORMMATRIX4FVARBPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLGETOBJECTPARAMETERFVARBPROC As Sub(ByVal obj As GLhandleARB, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETOBJECTPARAMETERIVARBPROC As Sub(ByVal obj As GLhandleARB, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETINFOLOGARBPROC As Sub(ByVal obj As GLhandleARB, ByVal maxLength As GLsizei, ByVal length As GLsizei Ptr, ByVal infoLog As GLcharARB Ptr)
Type PFNGLGETATTACHEDOBJECTSARBPROC As Sub(ByVal containerObj As GLhandleARB, ByVal maxCount As GLsizei, ByVal count As GLsizei Ptr, ByVal obj As GLhandleARB Ptr)
Type PFNGLGETUNIFORMLOCATIONARBPROC As Function(ByVal programObj As GLhandleARB, ByVal Name As GLcharARB Ptr) As GLint
Type PFNGLGETACTIVEUNIFORMARBPROC As Sub(ByVal programObj As GLhandleARB, ByVal index As GLuint, ByVal maxLength As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLint Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLcharARB Ptr)
Type PFNGLGETUNIFORMFVARBPROC As Sub(ByVal programObj As GLhandleARB, ByVal location As GLint, ByVal params As GLfloat Ptr)
Type PFNGLGETUNIFORMIVARBPROC As Sub(ByVal programObj As GLhandleARB, ByVal location As GLint, ByVal params As GLint Ptr)
Type PFNGLGETSHADERSOURCEARBPROC As Sub(ByVal obj As GLhandleARB, ByVal maxLength As GLsizei, ByVal length As GLsizei Ptr, ByVal source As GLcharARB Ptr)
#EndIf

#Ifndef GL_ARB_vertex_shader
#define GL_ARB_vertex_shader 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBindAttribLocationARB(ByVal programObj As GLhandleARB, ByVal index As GLuint, ByVal Name As GLcharARB Ptr)
Declare Sub glGetActiveAttribARB(ByVal programObj As GLhandleARB, ByVal index As GLuint, ByVal maxLength As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLint Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLcharARB Ptr)
Declare Function glGetAttribLocationARB(ByVal programObj As GLhandleARB, ByVal Name As GLcharARB Ptr) As GLint
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBINDATTRIBLOCATIONARBPROC As Sub(ByVal programObj As GLhandleARB, ByVal index As GLuint, ByVal Name As GLcharARB Ptr)
Type PFNGLGETACTIVEATTRIBARBPROC As Sub(ByVal programObj As GLhandleARB, ByVal index As GLuint, ByVal maxLength As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLint Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLcharARB Ptr)
Type PFNGLGETATTRIBLOCATIONARBPROC As Function(ByVal programObj As GLhandleARB, ByVal Name As GLcharARB Ptr) As GLint
#EndIf

#Ifndef GL_ARB_fragment_shader
#define GL_ARB_fragment_shader 1
#EndIf

#Ifndef GL_ARB_shading_language_100
#define GL_ARB_shading_language_100 1
#EndIf

#Ifndef GL_ARB_texture_non_power_of_two
#define GL_ARB_texture_non_power_of_two 1
#EndIf

#Ifndef GL_ARB_point_sprite
#define GL_ARB_point_sprite 1
#EndIf

#Ifndef GL_ARB_fragment_program_shadow
#define GL_ARB_fragment_program_shadow 1
#EndIf

#Ifndef GL_ARB_draw_buffers
#define GL_ARB_draw_buffers 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDrawBuffersARB(ByVal n As GLsizei, ByVal bufs As GLenum Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDRAWBUFFERSARBPROC As Sub(ByVal n As GLsizei, ByVal bufs As GLenum Ptr)
#EndIf

#Ifndef GL_ARB_texture_rectangle
#define GL_ARB_texture_rectangle 1
#EndIf

#Ifndef GL_ARB_color_buffer_float
#define GL_ARB_color_buffer_float 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glClampColorARB(ByVal target As GLenum, ByVal clamp As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCLAMPCOLORARBPROC As Sub(ByVal target As GLenum, ByVal clamp As GLenum)
#EndIf

#Ifndef GL_ARB_half_float_pixel
#define GL_ARB_half_float_pixel 1
#EndIf

#Ifndef GL_ARB_texture_float
#define GL_ARB_texture_float 1
#EndIf

#Ifndef GL_ARB_pixel_buffer_object
#define GL_ARB_pixel_buffer_object 1
#EndIf

#Ifndef GL_ARB_depth_buffer_float
#define GL_ARB_depth_buffer_float 1
#EndIf

#Ifndef GL_ARB_draw_instanced
#define GL_ARB_draw_instanced 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDrawArraysInstancedARB(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei, ByVal primcount As GLsizei)
Declare Sub glDrawElementsInstancedARB(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr, ByVal primcount As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDRAWARRAYSINSTANCEDARBPROC As Sub(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei, ByVal primcount As GLsizei)
Type PFNGLDRAWELEMENTSINSTANCEDARBPROC As Sub(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr, ByVal primcount As GLsizei)
#EndIf

#Ifndef GL_ARB_framebuffer_object
#define GL_ARB_framebuffer_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glIsRenderbuffer(ByVal renderbuffer As GLuint) As GLboolean
Declare Sub glBindRenderbuffer(ByVal target As GLenum, ByVal renderbuffer As GLuint)
Declare Sub glDeleteRenderbuffers(ByVal n As GLsizei, ByVal renderbuffers As GLuint Ptr)
Declare Sub glGenRenderbuffers(ByVal n As GLsizei, ByVal renderbuffers As GLuint Ptr)
Declare Sub glRenderbufferStorage(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glGetRenderbufferParameteriv(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Function glIsFramebuffer(ByVal framebuffer As GLuint) As GLboolean
Declare Sub glBindFramebuffer(ByVal target As GLenum, ByVal framebuffer As GLuint)
Declare Sub glDeleteFramebuffers(ByVal n As GLsizei, ByVal framebuffers As GLuint Ptr)
Declare Sub glGenFramebuffers(ByVal n As GLsizei, ByVal framebuffers As GLuint Ptr)
Declare Function glCheckFramebufferStatus(ByVal target As GLenum) As GLenum
Declare Sub glFramebufferTexture1D(ByVal target As GLenum, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Declare Sub glFramebufferTexture2D(ByVal target As GLenum, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Declare Sub glFramebufferTexture3D(ByVal target As GLenum, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal zoffset As GLint)
Declare Sub glFramebufferRenderbuffer(ByVal target As GLenum, ByVal attachment As GLenum, ByVal renderbuffertarget As GLenum, ByVal renderbuffer As GLuint)
Declare Sub glGetFramebufferAttachmentParameteriv(ByVal target As GLenum, ByVal attachment As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGenerateMipmap(ByVal target As GLenum)
Declare Sub glBlitFramebuffer(ByVal srcX0 As GLint, ByVal srcY0 As GLint, ByVal srcX1 As GLint, ByVal srcY1 As GLint, ByVal dstX0 As GLint, ByVal dstY0 As GLint, ByVal dstX1 As GLint, ByVal dstY1 As GLint, ByVal mask As GLbitfield, ByVal filter As GLenum)
Declare Sub glRenderbufferStorageMultisample(ByVal target As GLenum, ByVal samples As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glFramebufferTextureLayer(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal layer As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLISRENDERBUFFERPROC As Function(ByVal renderbuffer As GLuint) As GLboolean
Type PFNGLBINDRENDERBUFFERPROC As Sub(ByVal target As GLenum, ByVal renderbuffer As GLuint)
Type PFNGLDELETERENDERBUFFERSPROC As Sub(ByVal n As GLsizei, ByVal renderbuffers As GLuint Ptr)
Type PFNGLGENRENDERBUFFERSPROC As Sub(ByVal n As GLsizei, ByVal renderbuffers As GLuint Ptr)
Type PFNGLRENDERBUFFERSTORAGEPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLGETRENDERBUFFERPARAMETERIVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLISFRAMEBUFFERPROC As Function(ByVal framebuffer As GLuint) As GLboolean
Type PFNGLBINDFRAMEBUFFERPROC As Sub(ByVal target As GLenum, ByVal framebuffer As GLuint)
Type PFNGLDELETEFRAMEBUFFERSPROC As Sub(ByVal n As GLsizei, ByVal framebuffers As GLuint Ptr)
Type PFNGLGENFRAMEBUFFERSPROC As Sub(ByVal n As GLsizei, ByVal framebuffers As GLuint Ptr)
Type PFNGLCHECKFRAMEBUFFERSTATUSPROC As Function(ByVal target As GLenum) As GLenum
Type PFNGLFRAMEBUFFERTEXTURE1DPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Type PFNGLFRAMEBUFFERTEXTURE2DPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Type PFNGLFRAMEBUFFERTEXTURE3DPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal zoffset As GLint)
Type PFNGLFRAMEBUFFERRENDERBUFFERPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal renderbuffertarget As GLenum, ByVal renderbuffer As GLuint)
Type PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGENERATEMIPMAPPROC As Sub(ByVal target As GLenum)
Type PFNGLBLITFRAMEBUFFERPROC As Sub(ByVal srcX0 As GLint, ByVal srcY0 As GLint, ByVal srcX1 As GLint, ByVal srcY1 As GLint, ByVal dstX0 As GLint, ByVal dstY0 As GLint, ByVal dstX1 As GLint, ByVal dstY1 As GLint, ByVal mask As GLbitfield, ByVal filter As GLenum)
Type PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC As Sub(ByVal target As GLenum, ByVal samples As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLFRAMEBUFFERTEXTURELAYERPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal layer As GLint)
#EndIf

#Ifndef GL_ARB_framebuffer_sRGB
#define GL_ARB_framebuffer_sRGB 1
#EndIf

#Ifndef GL_ARB_geometry_shader4
#define GL_ARB_geometry_shader4 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glProgramParameteriARB(ByVal program As GLuint, ByVal pname As GLenum, ByVal value As GLint)
Declare Sub glFramebufferTextureARB(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Declare Sub glFramebufferTextureLayerARB(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal layer As GLint)
Declare Sub glFramebufferTextureFaceARB(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal face As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPROGRAMPARAMETERIARBPROC As Sub(ByVal program As GLuint, ByVal pname As GLenum, ByVal value As GLint)
Type PFNGLFRAMEBUFFERTEXTUREARBPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Type PFNGLFRAMEBUFFERTEXTURELAYERARBPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal layer As GLint)
Type PFNGLFRAMEBUFFERTEXTUREFACEARBPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal face As GLenum)
#EndIf

#Ifndef GL_ARB_half_float_vertex
#define GL_ARB_half_float_vertex 1
#EndIf

#Ifndef GL_ARB_instanced_arrays
#define GL_ARB_instanced_arrays 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexAttribDivisorARB(ByVal index As GLuint, ByVal divisor As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXATTRIBDIVISORARBPROC As Sub(ByVal index As GLuint, ByVal divisor As GLuint)
#EndIf

#Ifndef GL_ARB_map_buffer_range
#define GL_ARB_map_buffer_range 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glMapBufferRange(ByVal target As GLenum, ByVal offset As GLintptr, ByVal length As GLsizeiptr, ByVal Access As GLbitfield) As GLvoid Ptr
Declare Sub glFlushMappedBufferRange(ByVal target As GLenum, ByVal offset As GLintptr, ByVal length As GLsizeiptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLMAPBUFFERRANGEPROC As Function(ByVal target As GLenum, ByVal offset As GLintptr, ByVal length As GLsizeiptr, ByVal Access As GLbitfield) As GLvoid Ptr
Type PFNGLFLUSHMAPPEDBUFFERRANGEPROC As Sub(ByVal target As GLenum, ByVal offset As GLintptr, ByVal length As GLsizeiptr)
#EndIf

#Ifndef GL_ARB_texture_buffer_object
#define GL_ARB_texture_buffer_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTexBufferARB(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal buffer As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXBUFFERARBPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal buffer As GLuint)
#EndIf

#Ifndef GL_ARB_texture_compression_rgtc
#define GL_ARB_texture_compression_rgtc 1
#EndIf

#Ifndef GL_ARB_texture_rg
#define GL_ARB_texture_rg 1
#EndIf

#Ifndef GL_ARB_vertex_array_object
#define GL_ARB_vertex_array_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBindVertexArray(ByVal array As GLuint)
Declare Sub glDeleteVertexArrays(ByVal n As GLsizei, ByVal arrays As GLuint Ptr)
Declare Sub glGenVertexArrays(ByVal n As GLsizei, ByVal arrays As GLuint Ptr)
Declare Function glIsVertexArray(ByVal array As GLuint) As GLboolean
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBINDVERTEXARRAYPROC As Sub(ByVal array As GLuint)
Type PFNGLDELETEVERTEXARRAYSPROC As Sub(ByVal n As GLsizei, ByVal arrays As GLuint Ptr)
Type PFNGLGENVERTEXARRAYSPROC As Sub(ByVal n As GLsizei, ByVal arrays As GLuint Ptr)
Type PFNGLISVERTEXARRAYPROC As Function(ByVal array As GLuint) As GLboolean
#EndIf

#Ifndef GL_ARB_uniform_buffer_object
#define GL_ARB_uniform_buffer_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGetUniformIndices(ByVal program As GLuint, ByVal uniformCount As GLsizei, ByVal uniformNames As GLchar Ptr Ptr, ByVal uniformIndices As GLuint Ptr)
Declare Sub glGetActiveUniformsiv(ByVal program As GLuint, ByVal uniformCount As GLsizei, ByVal uniformIndices As GLuint Ptr, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetActiveUniformName(ByVal program As GLuint, ByVal uniformIndex As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal uniformName As GLchar Ptr)
Declare Function glGetUniformBlockIndex(ByVal program As GLuint, ByVal uniformBlockName As GLchar Ptr) As GLuint
Declare Sub glGetActiveUniformBlockiv(ByVal program As GLuint, ByVal uniformBlockIndex As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetActiveUniformBlockName(ByVal program As GLuint, ByVal uniformBlockIndex As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal uniformBlockName As GLchar Ptr)
Declare Sub glUniformBlockBinding(ByVal program As GLuint, ByVal uniformBlockIndex As GLuint, ByVal uniformBlockBinding As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETUNIFORMINDICESPROC As Sub(ByVal program As GLuint, ByVal uniformCount As GLsizei, ByVal uniformNames As GLchar Ptr Ptr, ByVal uniformIndices As GLuint Ptr)
Type PFNGLGETACTIVEUNIFORMSIVPROC As Sub(ByVal program As GLuint, ByVal uniformCount As GLsizei, ByVal uniformIndices As GLuint Ptr, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETACTIVEUNIFORMNAMEPROC As Sub(ByVal program As GLuint, ByVal uniformIndex As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal uniformName As GLchar Ptr)
Type PFNGLGETUNIFORMBLOCKINDEXPROC As Function(ByVal program As GLuint, ByVal uniformBlockName As GLchar Ptr) As GLuint
Type PFNGLGETACTIVEUNIFORMBLOCKIVPROC As Sub(ByVal program As GLuint, ByVal uniformBlockIndex As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC As Sub(ByVal program As GLuint, ByVal uniformBlockIndex As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal uniformBlockName As GLchar Ptr)
Type PFNGLUNIFORMBLOCKBINDINGPROC As Sub(ByVal program As GLuint, ByVal uniformBlockIndex As GLuint, ByVal uniformBlockBinding As GLuint)
#EndIf

#Ifndef GL_ARB_compatibility
#define GL_ARB_compatibility 1
#EndIf

#Ifndef GL_ARB_copy_buffer
#define GL_ARB_copy_buffer 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glCopyBufferSubData(ByVal readTarget As GLenum, ByVal writeTarget As GLenum, ByVal readOffset As GLintptr, ByVal writeOffset As GLintptr, ByVal size As GLsizeiptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOPYBUFFERSUBDATAPROC As Sub(ByVal readTarget As GLenum, ByVal writeTarget As GLenum, ByVal readOffset As GLintptr, ByVal writeOffset As GLintptr, ByVal size As GLsizeiptr)
#EndIf

#Ifndef GL_ARB_shader_texture_lod
#define GL_ARB_shader_texture_lod 1
#EndIf

#Ifndef GL_ARB_depth_clamp
#define GL_ARB_depth_clamp 1
#EndIf

#Ifndef GL_ARB_draw_elements_base_vertex
#define GL_ARB_draw_elements_base_vertex 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDrawElementsBaseVertex(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr, ByVal basevertex As GLint)
Declare Sub glDrawRangeElementsBaseVertex(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr, ByVal basevertex As GLint)
Declare Sub glDrawElementsInstancedBaseVertex(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr, ByVal primcount As GLsizei, ByVal basevertex As GLint)
Declare Sub glMultiDrawElementsBaseVertex(ByVal mode As GLenum, ByVal count As GLsizei Ptr, ByVal Type As GLenum, ByVal indices As GLvoid Ptr Ptr, ByVal primcount As GLsizei, ByVal basevertex As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDRAWELEMENTSBASEVERTEXPROC As Sub(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr, ByVal basevertex As GLint)
Type PFNGLDRAWRANGEELEMENTSBASEVERTEXPROC As Sub(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr, ByVal basevertex As GLint)
Type PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC As Sub(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr, ByVal primcount As GLsizei, ByVal basevertex As GLint)
Type PFNGLMULTIDRAWELEMENTSBASEVERTEXPROC As Sub(ByVal mode As GLenum, ByVal count As GLsizei Ptr, ByVal Type As GLenum, ByVal indices As GLvoid Ptr Ptr, ByVal primcount As GLsizei, ByVal basevertex As GLint Ptr)
#EndIf

#Ifndef GL_ARB_fragment_coord_conventions
#define GL_ARB_fragment_coord_conventions 1
#EndIf

#Ifndef GL_ARB_provoking_vertex
#define GL_ARB_provoking_vertex 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glProvokingVertex(ByVal mode As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPROVOKINGVERTEXPROC As Sub(ByVal mode As GLenum)
#EndIf

#Ifndef GL_ARB_seamless_cube_map
#define GL_ARB_seamless_cube_map 1
#EndIf

#Ifndef GL_ARB_sync
#define GL_ARB_sync 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glFenceSync(ByVal condition As GLenum, ByVal flags As GLbitfield) As GLsync
Declare Function glIsSync(ByVal sync As GLsync) As GLboolean
Declare Sub glDeleteSync(ByVal sync As GLsync)
Declare Function glClientWaitSync(ByVal sync As GLsync, ByVal flags As GLbitfield, ByVal timeout As GLuint64) As GLenum
Declare Sub glWaitSync(ByVal sync As GLsync, ByVal flags As GLbitfield, ByVal timeout As GLuint64)
Declare Sub glGetInteger64v(ByVal pname As GLenum, ByVal params As GLint64 Ptr)
Declare Sub glGetSynciv(ByVal sync As GLsync, ByVal pname As GLenum, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal values As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLFENCESYNCPROC As Function(ByVal condition As GLenum, ByVal flags As GLbitfield) As GLsync
Type PFNGLISSYNCPROC As Function(ByVal sync As GLsync) As GLboolean
Type PFNGLDELETESYNCPROC As Sub(ByVal sync As GLsync)
Type PFNGLCLIENTWAITSYNCPROC As Function(ByVal sync As GLsync, ByVal flags As GLbitfield, ByVal timeout As GLuint64) As GLenum
Type PFNGLWAITSYNCPROC As Sub(ByVal sync As GLsync, ByVal flags As GLbitfield, ByVal timeout As GLuint64)
Type PFNGLGETINTEGER64VPROC As Sub(ByVal pname As GLenum, ByVal params As GLint64 Ptr)
Type PFNGLGETSYNCIVPROC As Sub(ByVal sync As GLsync, ByVal pname As GLenum, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal values As GLint Ptr)
#EndIf

#Ifndef GL_ARB_texture_multisample
#define GL_ARB_texture_multisample 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTexImage2DMultisample(ByVal target As GLenum, ByVal samples As GLsizei, ByVal internalformat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal fixedsamplelocations As GLboolean)
Declare Sub glTexImage3DMultisample(ByVal target As GLenum, ByVal samples As GLsizei, ByVal internalformat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal fixedsamplelocations As GLboolean)
Declare Sub glGetMultisamplefv(ByVal pname As GLenum, ByVal index As GLuint, ByVal Val As GLfloat Ptr)
Declare Sub glSampleMaski(ByVal index As GLuint, ByVal mask As GLbitfield)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXIMAGE2DMULTISAMPLEPROC As Sub(ByVal target As GLenum, ByVal samples As GLsizei, ByVal internalformat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal fixedsamplelocations As GLboolean)
Type PFNGLTEXIMAGE3DMULTISAMPLEPROC As Sub(ByVal target As GLenum, ByVal samples As GLsizei, ByVal internalformat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal fixedsamplelocations As GLboolean)
Type PFNGLGETMULTISAMPLEFVPROC As Sub(ByVal pname As GLenum, ByVal index As GLuint, ByVal Val As GLfloat Ptr)
Type PFNGLSAMPLEMASKIPROC As Sub(ByVal index As GLuint, ByVal mask As GLbitfield)
#EndIf

#Ifndef GL_ARB_vertex_array_bgra
#define GL_ARB_vertex_array_bgra 1
#EndIf

#Ifndef GL_ARB_draw_buffers_blend
#define GL_ARB_draw_buffers_blend 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBlendEquationiARB(ByVal buf As GLuint, ByVal mode As GLenum)
Declare Sub glBlendEquationSeparateiARB(ByVal buf As GLuint, ByVal modeRGB As GLenum, ByVal modeAlpha As GLenum)
Declare Sub glBlendFunciARB(ByVal buf As GLuint, ByVal src As GLenum, ByVal dst As GLenum)
Declare Sub glBlendFuncSeparateiARB(ByVal buf As GLuint, ByVal srcRGB As GLenum, ByVal dstRGB As GLenum, ByVal srcAlpha As GLenum, ByVal dstAlpha As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBLENDEQUATIONIARBPROC As Sub(ByVal buf As GLuint, ByVal mode As GLenum)
Type PFNGLBLENDEQUATIONSEPARATEIARBPROC As Sub(ByVal buf As GLuint, ByVal modeRGB As GLenum, ByVal modeAlpha As GLenum)
Type PFNGLBLENDFUNCIARBPROC As Sub(ByVal buf As GLuint, ByVal src As GLenum, ByVal dst As GLenum)
Type PFNGLBLENDFUNCSEPARATEIARBPROC As Sub(ByVal buf As GLuint, ByVal srcRGB As GLenum, ByVal dstRGB As GLenum, ByVal srcAlpha As GLenum, ByVal dstAlpha As GLenum)
#EndIf

#Ifndef GL_ARB_sample_shading
#define GL_ARB_sample_shading 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glMinSampleShadingARB(ByVal value As GLclampf)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLMINSAMPLESHADINGARBPROC As Sub(ByVal value As GLclampf)
#EndIf

#Ifndef GL_ARB_texture_cube_map_array
#define GL_ARB_texture_cube_map_array 1
#EndIf

#Ifndef GL_ARB_texture_gather
#define GL_ARB_texture_gather 1
#EndIf

#Ifndef GL_ARB_texture_query_lod
#define GL_ARB_texture_query_lod 1
#EndIf

#Ifndef GL_ARB_shading_language_include
#define GL_ARB_shading_language_include 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glNamedStringARB(ByVal Type As GLenum, ByVal namelen As GLint, ByVal Name As GLchar Ptr, ByVal stringlen As GLint, ByVal String As GLchar Ptr)
Declare Sub glDeleteNamedStringARB(ByVal namelen As GLint, ByVal Name As GLchar Ptr)
Declare Sub glCompileShaderIncludeARB(ByVal shader As GLuint, ByVal count As GLsizei, ByVal path As GLchar Ptr Ptr, ByVal length As GLint Ptr)
Declare Function glIsNamedStringARB(ByVal namelen As GLint, ByVal Name As GLchar Ptr) As GLboolean
Declare Sub glGetNamedStringARB(ByVal namelen As GLint, ByVal Name As GLchar Ptr, ByVal bufSize As GLsizei, ByVal stringlen As GLint Ptr, ByVal String As GLchar Ptr)
Declare Sub glGetNamedStringivARB(ByVal namelen As GLint, ByVal Name As GLchar Ptr, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLNAMEDSTRINGARBPROC As Sub(ByVal Type As GLenum, ByVal namelen As GLint, ByVal Name As GLchar Ptr, ByVal stringlen As GLint, ByVal String As GLchar Ptr)
Type PFNGLDELETENAMEDSTRINGARBPROC As Sub(ByVal namelen As GLint, ByVal Name As GLchar Ptr)
Type PFNGLCOMPILESHADERINCLUDEARBPROC As Sub(ByVal shader As GLuint, ByVal count As GLsizei, ByVal path As GLchar Ptr Ptr, ByVal length As GLint Ptr)
Type PFNGLISNAMEDSTRINGARBPROC As Function(ByVal namelen As GLint, ByVal Name As GLchar Ptr) As GLboolean
Type PFNGLGETNAMEDSTRINGARBPROC As Sub(ByVal namelen As GLint, ByVal Name As GLchar Ptr, ByVal bufSize As GLsizei, ByVal stringlen As GLint Ptr, ByVal String As GLchar Ptr)
Type PFNGLGETNAMEDSTRINGIVARBPROC As Sub(ByVal namelen As GLint, ByVal Name As GLchar Ptr, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_ARB_texture_compression_bptc
#define GL_ARB_texture_compression_bptc 1
#EndIf

#Ifndef GL_ARB_blend_func_extended
#define GL_ARB_blend_func_extended 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBindFragDataLocationIndexed(ByVal program As GLuint, ByVal colorNumber As GLuint, ByVal index As GLuint, ByVal Name As GLchar Ptr)
Declare Function glGetFragDataIndex(ByVal program As GLuint, ByVal Name As GLchar Ptr) As GLint
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBINDFRAGDATALOCATIONINDEXEDPROC As Sub(ByVal program As GLuint, ByVal colorNumber As GLuint, ByVal index As GLuint, ByVal Name As GLchar Ptr)
Type PFNGLGETFRAGDATAINDEXPROC As Function(ByVal program As GLuint, ByVal Name As GLchar Ptr) As GLint
#EndIf

#Ifndef GL_ARB_explicit_attrib_location
#define GL_ARB_explicit_attrib_location 1
#EndIf

#Ifndef GL_ARB_occlusion_query2
#define GL_ARB_occlusion_query2 1
#EndIf

#Ifndef GL_ARB_sampler_objects
#define GL_ARB_sampler_objects 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGenSamplers(ByVal count As GLsizei, ByVal samplers As GLuint Ptr)
Declare Sub glDeleteSamplers(ByVal count As GLsizei, ByVal samplers As GLuint Ptr)
Declare Function glIsSampler(ByVal sampler As GLuint) As GLboolean
Declare Sub glBindSampler(ByVal unit As GLuint, ByVal sampler As GLuint)
Declare Sub glSamplerParameteri(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glSamplerParameteriv(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal param As GLint Ptr)
Declare Sub glSamplerParameterf(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glSamplerParameterfv(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal param As GLfloat Ptr)
Declare Sub glSamplerParameterIiv(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal param As GLint Ptr)
Declare Sub glSamplerParameterIuiv(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal param As GLuint Ptr)
Declare Sub glGetSamplerParameteriv(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetSamplerParameterIiv(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetSamplerParameterfv(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetSamplerParameterIuiv(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGENSAMPLERSPROC As Sub(ByVal count As GLsizei, ByVal samplers As GLuint Ptr)
Type PFNGLDELETESAMPLERSPROC As Sub(ByVal count As GLsizei, ByVal samplers As GLuint Ptr)
Type PFNGLISSAMPLERPROC As Function(ByVal sampler As GLuint) As GLboolean
Type PFNGLBINDSAMPLERPROC As Sub(ByVal unit As GLuint, ByVal sampler As GLuint)
Type PFNGLSAMPLERPARAMETERIPROC As Sub(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLSAMPLERPARAMETERIVPROC As Sub(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal param As GLint Ptr)
Type PFNGLSAMPLERPARAMETERFPROC As Sub(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLSAMPLERPARAMETERFVPROC As Sub(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal param As GLfloat Ptr)
Type PFNGLSAMPLERPARAMETERIIVPROC As Sub(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal param As GLint Ptr)
Type PFNGLSAMPLERPARAMETERIUIVPROC As Sub(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal param As GLuint Ptr)
Type PFNGLGETSAMPLERPARAMETERIVPROC As Sub(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETSAMPLERPARAMETERIIVPROC As Sub(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETSAMPLERPARAMETERFVPROC As Sub(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETSAMPLERPARAMETERIUIVPROC As Sub(ByVal sampler As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
#EndIf

#Ifndef GL_ARB_shader_bit_encoding
#define GL_ARB_shader_bit_encoding 1
#EndIf

#Ifndef GL_ARB_texture_rgb10_a2ui
#define GL_ARB_texture_rgb10_a2ui 1
#EndIf

#Ifndef GL_ARB_texture_swizzle
#define GL_ARB_texture_swizzle 1
#EndIf

#Ifndef GL_ARB_timer_query
#define GL_ARB_timer_query 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glQueryCounter(ByVal id As GLuint, ByVal target As GLenum)
Declare Sub glGetQueryObjecti64v(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint64 Ptr)
Declare Sub glGetQueryObjectui64v(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLuint64 Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLQUERYCOUNTERPROC As Sub(ByVal id As GLuint, ByVal target As GLenum)
Type PFNGLGETQUERYOBJECTI64VPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint64 Ptr)
Type PFNGLGETQUERYOBJECTUI64VPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLuint64 Ptr)
#EndIf

#Ifndef GL_ARB_vertex_type_2_10_10_10_rev
#define GL_ARB_vertex_type_2_10_10_10_rev 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexP2ui(ByVal Type As GLenum, ByVal value As GLuint)
Declare Sub glVertexP2uiv(ByVal Type As GLenum, ByVal value As GLuint Ptr)
Declare Sub glVertexP3ui(ByVal Type As GLenum, ByVal value As GLuint)
Declare Sub glVertexP3uiv(ByVal Type As GLenum, ByVal value As GLuint Ptr)
Declare Sub glVertexP4ui(ByVal Type As GLenum, ByVal value As GLuint)
Declare Sub glVertexP4uiv(ByVal Type As GLenum, ByVal value As GLuint Ptr)
Declare Sub glTexCoordP1ui(ByVal Type As GLenum, ByVal coords As GLuint)
Declare Sub glTexCoordP1uiv(ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Declare Sub glTexCoordP2ui(ByVal Type As GLenum, ByVal coords As GLuint)
Declare Sub glTexCoordP2uiv(ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Declare Sub glTexCoordP3ui(ByVal Type As GLenum, ByVal coords As GLuint)
Declare Sub glTexCoordP3uiv(ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Declare Sub glTexCoordP4ui(ByVal Type As GLenum, ByVal coords As GLuint)
Declare Sub glTexCoordP4uiv(ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Declare Sub glMultiTexCoordP1ui(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint)
Declare Sub glMultiTexCoordP1uiv(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Declare Sub glMultiTexCoordP2ui(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint)
Declare Sub glMultiTexCoordP2uiv(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Declare Sub glMultiTexCoordP3ui(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint)
Declare Sub glMultiTexCoordP3uiv(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Declare Sub glMultiTexCoordP4ui(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint)
Declare Sub glMultiTexCoordP4uiv(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Declare Sub glNormalP3ui(ByVal Type As GLenum, ByVal coords As GLuint)
Declare Sub glNormalP3uiv(ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Declare Sub glColorP3ui(ByVal Type As GLenum, ByVal Color As GLuint)
Declare Sub glColorP3uiv(ByVal Type As GLenum, ByVal Color As GLuint Ptr)
Declare Sub glColorP4ui(ByVal Type As GLenum, ByVal Color As GLuint)
Declare Sub glColorP4uiv(ByVal Type As GLenum, ByVal Color As GLuint Ptr)
Declare Sub glSecondaryColorP3ui(ByVal Type As GLenum, ByVal Color As GLuint)
Declare Sub glSecondaryColorP3uiv(ByVal Type As GLenum, ByVal Color As GLuint Ptr)
Declare Sub glVertexAttribP1ui(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint)
Declare Sub glVertexAttribP1uiv(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint Ptr)
Declare Sub glVertexAttribP2ui(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint)
Declare Sub glVertexAttribP2uiv(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint Ptr)
Declare Sub glVertexAttribP3ui(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint)
Declare Sub glVertexAttribP3uiv(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint Ptr)
Declare Sub glVertexAttribP4ui(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint)
Declare Sub glVertexAttribP4uiv(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXP2UIPROC As Sub(ByVal Type As GLenum, ByVal value As GLuint)
Type PFNGLVERTEXP2UIVPROC As Sub(ByVal Type As GLenum, ByVal value As GLuint Ptr)
Type PFNGLVERTEXP3UIPROC As Sub(ByVal Type As GLenum, ByVal value As GLuint)
Type PFNGLVERTEXP3UIVPROC As Sub(ByVal Type As GLenum, ByVal value As GLuint Ptr)
Type PFNGLVERTEXP4UIPROC As Sub(ByVal Type As GLenum, ByVal value As GLuint)
Type PFNGLVERTEXP4UIVPROC As Sub(ByVal Type As GLenum, ByVal value As GLuint Ptr)
Type PFNGLTEXCOORDP1UIPROC As Sub(ByVal Type As GLenum, ByVal coords As GLuint)
Type PFNGLTEXCOORDP1UIVPROC As Sub(ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Type PFNGLTEXCOORDP2UIPROC As Sub(ByVal Type As GLenum, ByVal coords As GLuint)
Type PFNGLTEXCOORDP2UIVPROC As Sub(ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Type PFNGLTEXCOORDP3UIPROC As Sub(ByVal Type As GLenum, ByVal coords As GLuint)
Type PFNGLTEXCOORDP3UIVPROC As Sub(ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Type PFNGLTEXCOORDP4UIPROC As Sub(ByVal Type As GLenum, ByVal coords As GLuint)
Type PFNGLTEXCOORDP4UIVPROC As Sub(ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Type PFNGLMULTITEXCOORDP1UIPROC As Sub(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint)
Type PFNGLMULTITEXCOORDP1UIVPROC As Sub(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Type PFNGLMULTITEXCOORDP2UIPROC As Sub(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint)
Type PFNGLMULTITEXCOORDP2UIVPROC As Sub(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Type PFNGLMULTITEXCOORDP3UIPROC As Sub(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint)
Type PFNGLMULTITEXCOORDP3UIVPROC As Sub(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Type PFNGLMULTITEXCOORDP4UIPROC As Sub(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint)
Type PFNGLMULTITEXCOORDP4UIVPROC As Sub(ByVal texture As GLenum, ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Type PFNGLNORMALP3UIPROC As Sub(ByVal Type As GLenum, ByVal coords As GLuint)
Type PFNGLNORMALP3UIVPROC As Sub(ByVal Type As GLenum, ByVal coords As GLuint Ptr)
Type PFNGLCOLORP3UIPROC As Sub(ByVal Type As GLenum, ByVal Color As GLuint)
Type PFNGLCOLORP3UIVPROC As Sub(ByVal Type As GLenum, ByVal Color As GLuint Ptr)
Type PFNGLCOLORP4UIPROC As Sub(ByVal Type As GLenum, ByVal Color As GLuint)
Type PFNGLCOLORP4UIVPROC As Sub(ByVal Type As GLenum, ByVal Color As GLuint Ptr)
Type PFNGLSECONDARYCOLORP3UIPROC As Sub(ByVal Type As GLenum, ByVal Color As GLuint)
Type PFNGLSECONDARYCOLORP3UIVPROC As Sub(ByVal Type As GLenum, ByVal Color As GLuint Ptr)
Type PFNGLVERTEXATTRIBP1UIPROC As Sub(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint)
Type PFNGLVERTEXATTRIBP1UIVPROC As Sub(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint Ptr)
Type PFNGLVERTEXATTRIBP2UIPROC As Sub(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint)
Type PFNGLVERTEXATTRIBP2UIVPROC As Sub(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint Ptr)
Type PFNGLVERTEXATTRIBP3UIPROC As Sub(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint)
Type PFNGLVERTEXATTRIBP3UIVPROC As Sub(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint Ptr)
Type PFNGLVERTEXATTRIBP4UIPROC As Sub(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint)
Type PFNGLVERTEXATTRIBP4UIVPROC As Sub(ByVal index As GLuint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal value As GLuint Ptr)
#EndIf

#Ifndef GL_ARB_draw_indirect
#define GL_ARB_draw_indirect 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDrawArraysIndirect(ByVal mode As GLenum, ByVal indirect As GLvoid Ptr)
Declare Sub glDrawElementsIndirect(ByVal mode As GLenum, ByVal Type As GLenum, ByVal indirect As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDRAWARRAYSINDIRECTPROC As Sub(ByVal mode As GLenum, ByVal indirect As GLvoid Ptr)
Type PFNGLDRAWELEMENTSINDIRECTPROC As Sub(ByVal mode As GLenum, ByVal Type As GLenum, ByVal indirect As GLvoid Ptr)
#EndIf

#Ifndef GL_ARB_gpu_shader5
#define GL_ARB_gpu_shader5 1
#EndIf

#Ifndef GL_ARB_gpu_shader_fp64
#define GL_ARB_gpu_shader_fp64 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glUniform1d(ByVal location As GLint, ByVal x As GLdouble)
Declare Sub glUniform2d(ByVal location As GLint, ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glUniform3d(ByVal location As GLint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glUniform4d(ByVal location As GLint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glUniform1dv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Declare Sub glUniform2dv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Declare Sub glUniform3dv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Declare Sub glUniform4dv(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Declare Sub glUniformMatrix2dv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glUniformMatrix3dv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glUniformMatrix4dv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glUniformMatrix2x3dv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glUniformMatrix2x4dv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glUniformMatrix3x2dv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glUniformMatrix3x4dv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glUniformMatrix4x2dv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glUniformMatrix4x3dv(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glGetUniformdv(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLdouble Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLUNIFORM1DPROC As Sub(ByVal location As GLint, ByVal x As GLdouble)
Type PFNGLUNIFORM2DPROC As Sub(ByVal location As GLint, ByVal x As GLdouble, ByVal y As GLdouble)
Type PFNGLUNIFORM3DPROC As Sub(ByVal location As GLint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLUNIFORM4DPROC As Sub(ByVal location As GLint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLUNIFORM1DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Type PFNGLUNIFORM2DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Type PFNGLUNIFORM3DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Type PFNGLUNIFORM4DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Type PFNGLUNIFORMMATRIX2DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLUNIFORMMATRIX3DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLUNIFORMMATRIX4DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLUNIFORMMATRIX2X3DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLUNIFORMMATRIX2X4DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLUNIFORMMATRIX3X2DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLUNIFORMMATRIX3X4DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLUNIFORMMATRIX4X2DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLUNIFORMMATRIX4X3DVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLGETUNIFORMDVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLdouble Ptr)
#EndIf

#Ifndef GL_ARB_shader_subroutine
#define GL_ARB_shader_subroutine 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glGetSubroutineUniformLocation(ByVal program As GLuint, ByVal shadertype As GLenum, ByVal Name As GLchar Ptr) As GLint
Declare Function glGetSubroutineIndex(ByVal program As GLuint, ByVal shadertype As GLenum, ByVal Name As GLchar Ptr) As GLuint
Declare Sub glGetActiveSubroutineUniformiv(ByVal program As GLuint, ByVal shadertype As GLenum, ByVal index As GLuint, ByVal pname As GLenum, ByVal values As GLint Ptr)
Declare Sub glGetActiveSubroutineUniformName(ByVal program As GLuint, ByVal shadertype As GLenum, ByVal index As GLuint, ByVal bufsize As GLsizei, ByVal length As GLsizei Ptr, ByVal Name As GLchar Ptr)
Declare Sub glGetActiveSubroutineName(ByVal program As GLuint, ByVal shadertype As GLenum, ByVal index As GLuint, ByVal bufsize As GLsizei, ByVal length As GLsizei Ptr, ByVal Name As GLchar Ptr)
Declare Sub glUniformSubroutinesuiv(ByVal shadertype As GLenum, ByVal count As GLsizei, ByVal indices As GLuint Ptr)
Declare Sub glGetUniformSubroutineuiv(ByVal shadertype As GLenum, ByVal location As GLint, ByVal params As GLuint Ptr)
Declare Sub glGetProgramStageiv(ByVal program As GLuint, ByVal shadertype As GLenum, ByVal pname As GLenum, ByVal values As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETSUBROUTINEUNIFORMLOCATIONPROC As Function(ByVal program As GLuint, ByVal shadertype As GLenum, ByVal Name As GLchar Ptr) As GLint
Type PFNGLGETSUBROUTINEINDEXPROC As Function(ByVal program As GLuint, ByVal shadertype As GLenum, ByVal Name As GLchar Ptr) As GLuint
Type PFNGLGETACTIVESUBROUTINEUNIFORMIVPROC As Sub(ByVal program As GLuint, ByVal shadertype As GLenum, ByVal index As GLuint, ByVal pname As GLenum, ByVal values As GLint Ptr)
Type PFNGLGETACTIVESUBROUTINEUNIFORMNAMEPROC As Sub(ByVal program As GLuint, ByVal shadertype As GLenum, ByVal index As GLuint, ByVal bufsize As GLsizei, ByVal length As GLsizei Ptr, ByVal Name As GLchar Ptr)
Type PFNGLGETACTIVESUBROUTINENAMEPROC As Sub(ByVal program As GLuint, ByVal shadertype As GLenum, ByVal index As GLuint, ByVal bufsize As GLsizei, ByVal length As GLsizei Ptr, ByVal Name As GLchar Ptr)
Type PFNGLUNIFORMSUBROUTINESUIVPROC As Sub(ByVal shadertype As GLenum, ByVal count As GLsizei, ByVal indices As GLuint Ptr)
Type PFNGLGETUNIFORMSUBROUTINEUIVPROC As Sub(ByVal shadertype As GLenum, ByVal location As GLint, ByVal params As GLuint Ptr)
Type PFNGLGETPROGRAMSTAGEIVPROC As Sub(ByVal program As GLuint, ByVal shadertype As GLenum, ByVal pname As GLenum, ByVal values As GLint Ptr)
#EndIf

#Ifndef GL_ARB_tessellation_shader
#define GL_ARB_tessellation_shader 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPatchParameteri(ByVal pname As GLenum, ByVal value As GLint)
Declare Sub glPatchParameterfv(ByVal pname As GLenum, ByVal values As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPATCHPARAMETERIPROC As Sub(ByVal pname As GLenum, ByVal value As GLint)
Type PFNGLPATCHPARAMETERFVPROC As Sub(ByVal pname As GLenum, ByVal values As GLfloat Ptr)
#EndIf

#Ifndef GL_ARB_texture_buffer_object_rgb32
#define GL_ARB_texture_buffer_object_rgb32 1
#EndIf

#Ifndef GL_ARB_transform_feedback2
#define GL_ARB_transform_feedback2 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBindTransformFeedback(ByVal target As GLenum, ByVal id As GLuint)
Declare Sub glDeleteTransformFeedbacks(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Declare Sub glGenTransformFeedbacks(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Declare Function glIsTransformFeedback(ByVal id As GLuint) As GLboolean
Declare Sub glPauseTransformFeedback()
Declare Sub glResumeTransformFeedback()
Declare Sub glDrawTransformFeedback(ByVal mode As GLenum, ByVal id As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBINDTRANSFORMFEEDBACKPROC As Sub(ByVal target As GLenum, ByVal id As GLuint)
Type PFNGLDELETETRANSFORMFEEDBACKSPROC As Sub(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Type PFNGLGENTRANSFORMFEEDBACKSPROC As Sub(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Type PFNGLISTRANSFORMFEEDBACKPROC As Function(ByVal id As GLuint) As GLboolean
Type PFNGLPAUSETRANSFORMFEEDBACKPROC As Sub()
Type PFNGLRESUMETRANSFORMFEEDBACKPROC As Sub()
Type PFNGLDRAWTRANSFORMFEEDBACKPROC As Sub(ByVal mode As GLenum, ByVal id As GLuint)
#EndIf

#Ifndef GL_ARB_transform_feedback3
#define GL_ARB_transform_feedback3 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDrawTransformFeedbackStream(ByVal mode As GLenum, ByVal id As GLuint, ByVal stream As GLuint)
Declare Sub glBeginQueryIndexed(ByVal target As GLenum, ByVal index As GLuint, ByVal id As GLuint)
Declare Sub glEndQueryIndexed(ByVal target As GLenum, ByVal index As GLuint)
Declare Sub glGetQueryIndexediv(ByVal target As GLenum, ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDRAWTRANSFORMFEEDBACKSTREAMPROC As Sub(ByVal mode As GLenum, ByVal id As GLuint, ByVal stream As GLuint)
Type PFNGLBEGINQUERYINDEXEDPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal id As GLuint)
Type PFNGLENDQUERYINDEXEDPROC As Sub(ByVal target As GLenum, ByVal index As GLuint)
Type PFNGLGETQUERYINDEXEDIVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_ARB_ES2_compatibility
#define GL_ARB_ES2_compatibility 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glReleaseShaderCompiler()
Declare Sub glShaderBinary(ByVal count As GLsizei, ByVal shaders As GLuint Ptr, ByVal binaryformat As GLenum, ByVal Binary As GLvoid Ptr, ByVal length As GLsizei)
Declare Sub glGetShaderPrecisionFormat(ByVal shadertype As GLenum, ByVal precisiontype As GLenum, ByVal range As GLint Ptr, ByVal precision As GLint Ptr)
Declare Sub glDepthRangef(ByVal n As GLclampf, ByVal f As GLclampf)
Declare Sub glClearDepthf(ByVal d As GLclampf)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLRELEASESHADERCOMPILERPROC As Sub()
Type PFNGLSHADERBINARYPROC As Sub(ByVal count As GLsizei, ByVal shaders As GLuint Ptr, ByVal binaryformat As GLenum, ByVal Binary As GLvoid Ptr, ByVal length As GLsizei)
Type PFNGLGETSHADERPRECISIONFORMATPROC As Sub(ByVal shadertype As GLenum, ByVal precisiontype As GLenum, ByVal range As GLint Ptr, ByVal precision As GLint Ptr)
Type PFNGLDEPTHRANGEFPROC As Sub(ByVal n As GLclampf, ByVal f As GLclampf)
Type PFNGLCLEARDEPTHFPROC As Sub(ByVal d As GLclampf)
#EndIf

#Ifndef GL_ARB_get_program_binary
#define GL_ARB_get_program_binary 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGetProgramBinary(ByVal program As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal binaryFormat As GLenum Ptr, ByVal Binary As GLvoid Ptr)
Declare Sub glProgramBinary(ByVal program As GLuint, ByVal binaryFormat As GLenum, ByVal Binary As GLvoid Ptr, ByVal length As GLsizei)
Declare Sub glProgramParameteri(ByVal program As GLuint, ByVal pname As GLenum, ByVal value As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETPROGRAMBINARYPROC As Sub(ByVal program As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal binaryFormat As GLenum Ptr, ByVal Binary As GLvoid Ptr)
Type PFNGLPROGRAMBINARYPROC As Sub(ByVal program As GLuint, ByVal binaryFormat As GLenum, ByVal Binary As GLvoid Ptr, ByVal length As GLsizei)
Type PFNGLPROGRAMPARAMETERIPROC As Sub(ByVal program As GLuint, ByVal pname As GLenum, ByVal value As GLint)
#EndIf

#Ifndef GL_ARB_separate_shader_objects
#define GL_ARB_separate_shader_objects 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glUseProgramStages(ByVal pipeline As GLuint, ByVal stages As GLbitfield, ByVal program As GLuint)
Declare Sub glActiveShaderProgram(ByVal pipeline As GLuint, ByVal program As GLuint)
Declare Function glCreateShaderProgramv(ByVal Type As GLenum, ByVal count As GLsizei, ByVal strings As GLchar Ptr Ptr) As GLuint
Declare Sub glBindProgramPipeline(ByVal pipeline As GLuint)
Declare Sub glDeleteProgramPipelines(ByVal n As GLsizei, ByVal pipelines As GLuint Ptr)
Declare Sub glGenProgramPipelines(ByVal n As GLsizei, ByVal pipelines As GLuint Ptr)
Declare Function glIsProgramPipeline(ByVal pipeline As GLuint) As GLboolean
Declare Sub glGetProgramPipelineiv(ByVal pipeline As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glProgramUniform1i(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint)
Declare Sub glProgramUniform1iv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glProgramUniform1f(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat)
Declare Sub glProgramUniform1fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniform1d(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLdouble)
Declare Sub glProgramUniform1dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniform1ui(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint)
Declare Sub glProgramUniform1uiv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glProgramUniform2i(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint)
Declare Sub glProgramUniform2iv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glProgramUniform2f(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat)
Declare Sub glProgramUniform2fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniform2d(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLdouble, ByVal v1 As GLdouble)
Declare Sub glProgramUniform2dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniform2ui(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint)
Declare Sub glProgramUniform2uiv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glProgramUniform3i(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint)
Declare Sub glProgramUniform3iv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glProgramUniform3f(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat)
Declare Sub glProgramUniform3fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniform3d(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLdouble, ByVal v1 As GLdouble, ByVal v2 As GLdouble)
Declare Sub glProgramUniform3dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniform3ui(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint)
Declare Sub glProgramUniform3uiv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glProgramUniform4i(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint, ByVal v3 As GLint)
Declare Sub glProgramUniform4iv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glProgramUniform4f(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal v3 As GLfloat)
Declare Sub glProgramUniform4fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniform4d(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLdouble, ByVal v1 As GLdouble, ByVal v2 As GLdouble, ByVal v3 As GLdouble)
Declare Sub glProgramUniform4dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniform4ui(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint, ByVal v3 As GLuint)
Declare Sub glProgramUniform4uiv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glProgramUniformMatrix2fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix3fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix4fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix2dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix3dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix4dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix2x3fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix3x2fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix2x4fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix4x2fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix3x4fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix4x3fv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix2x3dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix3x2dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix2x4dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix4x2dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix3x4dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix4x3dv(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glValidateProgramPipeline(ByVal pipeline As GLuint)
Declare Sub glGetProgramPipelineInfoLog(ByVal pipeline As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal infoLog As GLchar Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLUSEPROGRAMSTAGESPROC As Sub(ByVal pipeline As GLuint, ByVal stages As GLbitfield, ByVal program As GLuint)
Type PFNGLACTIVESHADERPROGRAMPROC As Sub(ByVal pipeline As GLuint, ByVal program As GLuint)
Type PFNGLCREATESHADERPROGRAMVPROC As Function(ByVal Type As GLenum, ByVal count As GLsizei, ByVal strings As GLchar Ptr Ptr) As GLuint
Type PFNGLBINDPROGRAMPIPELINEPROC As Sub(ByVal pipeline As GLuint)
Type PFNGLDELETEPROGRAMPIPELINESPROC As Sub(ByVal n As GLsizei, ByVal pipelines As GLuint Ptr)
Type PFNGLGENPROGRAMPIPELINESPROC As Sub(ByVal n As GLsizei, ByVal pipelines As GLuint Ptr)
Type PFNGLISPROGRAMPIPELINEPROC As Function(ByVal pipeline As GLuint) As GLboolean
Type PFNGLGETPROGRAMPIPELINEIVPROC As Sub(ByVal pipeline As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLPROGRAMUNIFORM1IPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint)
Type PFNGLPROGRAMUNIFORM1IVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLPROGRAMUNIFORM1FPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat)
Type PFNGLPROGRAMUNIFORM1FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORM1DPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLdouble)
Type PFNGLPROGRAMUNIFORM1DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORM1UIPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint)
Type PFNGLPROGRAMUNIFORM1UIVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLPROGRAMUNIFORM2IPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint)
Type PFNGLPROGRAMUNIFORM2IVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLPROGRAMUNIFORM2FPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat)
Type PFNGLPROGRAMUNIFORM2FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORM2DPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLdouble, ByVal v1 As GLdouble)
Type PFNGLPROGRAMUNIFORM2DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORM2UIPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint)
Type PFNGLPROGRAMUNIFORM2UIVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLPROGRAMUNIFORM3IPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint)
Type PFNGLPROGRAMUNIFORM3IVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLPROGRAMUNIFORM3FPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat)
Type PFNGLPROGRAMUNIFORM3FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORM3DPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLdouble, ByVal v1 As GLdouble, ByVal v2 As GLdouble)
Type PFNGLPROGRAMUNIFORM3DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORM3UIPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint)
Type PFNGLPROGRAMUNIFORM3UIVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLPROGRAMUNIFORM4IPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint, ByVal v3 As GLint)
Type PFNGLPROGRAMUNIFORM4IVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLPROGRAMUNIFORM4FPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal v3 As GLfloat)
Type PFNGLPROGRAMUNIFORM4FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORM4DPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLdouble, ByVal v1 As GLdouble, ByVal v2 As GLdouble, ByVal v3 As GLdouble)
Type PFNGLPROGRAMUNIFORM4DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORM4UIPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint, ByVal v3 As GLuint)
Type PFNGLPROGRAMUNIFORM4UIVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX2FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX3FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX4FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX2DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX3DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX4DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX2X3FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX3X2FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX2X4FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX4X2FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX3X4FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX4X3FVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX2X3DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX3X2DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX2X4DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX4X2DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX3X4DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX4X3DVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLVALIDATEPROGRAMPIPELINEPROC As Sub(ByVal pipeline As GLuint)
Type PFNGLGETPROGRAMPIPELINEINFOLOGPROC As Sub(ByVal pipeline As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal infoLog As GLchar Ptr)
#EndIf

#Ifndef GL_ARB_vertex_attrib_64bit
#define GL_ARB_vertex_attrib_64bit 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexAttribL1d(ByVal index As GLuint, ByVal x As GLdouble)
Declare Sub glVertexAttribL2d(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glVertexAttribL3d(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glVertexAttribL4d(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glVertexAttribL1dv(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttribL2dv(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttribL3dv(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttribL4dv(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttribLPointer(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glGetVertexAttribLdv(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXATTRIBL1DPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble)
Type PFNGLVERTEXATTRIBL2DPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble)
Type PFNGLVERTEXATTRIBL3DPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLVERTEXATTRIBL4DPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLVERTEXATTRIBL1DVPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIBL2DVPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIBL3DVPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIBL4DVPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIBLPOINTERPROC As Sub(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLGETVERTEXATTRIBLDVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
#EndIf

#Ifndef GL_ARB_viewport_array
#define GL_ARB_viewport_array 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glViewportArrayv(ByVal first As GLuint, ByVal count As GLsizei, ByVal v As GLfloat Ptr)
Declare Sub glViewportIndexedf(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal w As GLfloat, ByVal h As GLfloat)
Declare Sub glViewportIndexedfv(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glScissorArrayv(ByVal first As GLuint, ByVal count As GLsizei, ByVal v As GLint Ptr)
Declare Sub glScissorIndexed(ByVal index As GLuint, ByVal Left As GLint, ByVal bottom As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glScissorIndexedv(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glDepthRangeArrayv(ByVal first As GLuint, ByVal count As GLsizei, ByVal v As GLclampd Ptr)
Declare Sub glDepthRangeIndexed(ByVal index As GLuint, ByVal n As GLclampd, ByVal f As GLclampd)
Declare Sub glGetFloati_v(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLfloat Ptr)
Declare Sub glGetDoublei_v(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLdouble Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVIEWPORTARRAYVPROC As Sub(ByVal first As GLuint, ByVal count As GLsizei, ByVal v As GLfloat Ptr)
Type PFNGLVIEWPORTINDEXEDFPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal w As GLfloat, ByVal h As GLfloat)
Type PFNGLVIEWPORTINDEXEDFVPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLSCISSORARRAYVPROC As Sub(ByVal first As GLuint, ByVal count As GLsizei, ByVal v As GLint Ptr)
Type PFNGLSCISSORINDEXEDPROC As Sub(ByVal index As GLuint, ByVal Left As GLint, ByVal bottom As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLSCISSORINDEXEDVPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLDEPTHRANGEARRAYVPROC As Sub(ByVal first As GLuint, ByVal count As GLsizei, ByVal v As GLclampd Ptr)
Type PFNGLDEPTHRANGEINDEXEDPROC As Sub(ByVal index As GLuint, ByVal n As GLclampd, ByVal f As GLclampd)
Type PFNGLGETFLOATI_VPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLfloat Ptr)
Type PFNGLGETDOUBLEI_VPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLdouble Ptr)
#EndIf

#Ifndef GL_ARB_cl_event
#define GL_ARB_cl_event 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glCreateSyncFromCLeventARB(ByVal context As struct_cl_context Ptr, ByVal event As struct_cl_event Ptr, ByVal flags As GLbitfield) As GLsync
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCREATESYNCFROMCLEVENTARBPROC As Function(ByVal context As _cl_context Ptr, ByVal event As _cl_event Ptr, ByVal flags As GLbitfield) As GLsync
#EndIf

#Ifndef GL_ARB_debug_output
#define GL_ARB_debug_output 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDebugMessageControlARB(ByVal source As GLenum, ByVal Type As GLenum, ByVal severity As GLenum, ByVal count As GLsizei, ByVal ids As GLuint Ptr, ByVal enabled As GLboolean)
Declare Sub glDebugMessageInsertARB(ByVal source As GLenum, ByVal Type As GLenum, ByVal id As GLuint, ByVal severity As GLenum, ByVal length As GLsizei, ByVal buf As GLchar Ptr)
Declare Sub glDebugMessageCallbackARB(ByVal callback As GLDEBUGPROCARB, ByVal userParam As GLvoid Ptr)
Declare Function glGetDebugMessageLogARB(ByVal count As GLuint, ByVal bufsize As GLsizei, ByVal sources As GLenum Ptr, ByVal types As GLenum Ptr, ByVal ids As GLuint Ptr, ByVal severities As GLenum Ptr, ByVal lengths As GLsizei Ptr, ByVal messageLog As GLchar Ptr) As GLuint
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDEBUGMESSAGECONTROLARBPROC As Sub(ByVal source As GLenum, ByVal Type As GLenum, ByVal severity As GLenum, ByVal count As GLsizei, ByVal ids As GLuint Ptr, ByVal enabled As GLboolean)
Type PFNGLDEBUGMESSAGEINSERTARBPROC As Sub(ByVal source As GLenum, ByVal Type As GLenum, ByVal id As GLuint, ByVal severity As GLenum, ByVal length As GLsizei, ByVal buf As GLchar Ptr)
Type PFNGLDEBUGMESSAGECALLBACKARBPROC As Sub(ByVal callback As GLDEBUGPROCARB, ByVal userParam As GLvoid Ptr)
Type PFNGLGETDEBUGMESSAGELOGARBPROC As Function(ByVal count As GLuint, ByVal bufsize As GLsizei, ByVal sources As GLenum Ptr, ByVal types As GLenum Ptr, ByVal ids As GLuint Ptr, ByVal severities As GLenum Ptr, ByVal lengths As GLsizei Ptr, ByVal messageLog As GLchar Ptr) As GLuint
#EndIf

#Ifndef GL_ARB_robustness
#define GL_ARB_robustness 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glGetGraphicsResetStatusARB() As GLenum
Declare Sub glGetnMapdvARB(ByVal target As GLenum, ByVal query As GLenum, ByVal bufSize As GLsizei, ByVal v As GLdouble Ptr)
Declare Sub glGetnMapfvARB(ByVal target As GLenum, ByVal query As GLenum, ByVal bufSize As GLsizei, ByVal v As GLfloat Ptr)
Declare Sub glGetnMapivARB(ByVal target As GLenum, ByVal query As GLenum, ByVal bufSize As GLsizei, ByVal v As GLint Ptr)
Declare Sub glGetnPixelMapfvARB(ByVal map As GLenum, ByVal bufSize As GLsizei, ByVal values As GLfloat Ptr)
Declare Sub glGetnPixelMapuivARB(ByVal map As GLenum, ByVal bufSize As GLsizei, ByVal values As GLuint Ptr)
Declare Sub glGetnPixelMapusvARB(ByVal map As GLenum, ByVal bufSize As GLsizei, ByVal values As GLushort Ptr)
Declare Sub glGetnPolygonStippleARB(ByVal bufSize As GLsizei, ByVal pattern As GLubyte Ptr)
Declare Sub glGetnColorTableARB(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal bufSize As GLsizei, ByVal table As GLvoid Ptr)
Declare Sub glGetnConvolutionFilterARB(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal bufSize As GLsizei, ByVal image As GLvoid Ptr)
Declare Sub glGetnSeparableFilterARB(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal rowBufSize As GLsizei, ByVal row As GLvoid Ptr, ByVal columnBufSize As GLsizei, ByVal column As GLvoid Ptr, ByVal span As GLvoid Ptr)
Declare Sub glGetnHistogramARB(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal bufSize As GLsizei, ByVal values As GLvoid Ptr)
Declare Sub glGetnMinmaxARB(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal bufSize As GLsizei, ByVal values As GLvoid Ptr)
Declare Sub glGetnTexImageARB(ByVal target As GLenum, ByVal level As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal bufSize As GLsizei, ByVal img As GLvoid Ptr)
Declare Sub glReadnPixelsARB(ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal bufSize As GLsizei, ByVal Data As GLvoid Ptr)
Declare Sub glGetnCompressedTexImageARB(ByVal target As GLenum, ByVal lod As GLint, ByVal bufSize As GLsizei, ByVal img As GLvoid Ptr)
Declare Sub glGetnUniformfvARB(ByVal program As GLuint, ByVal location As GLint, ByVal bufSize As GLsizei, ByVal params As GLfloat Ptr)
Declare Sub glGetnUniformivARB(ByVal program As GLuint, ByVal location As GLint, ByVal bufSize As GLsizei, ByVal params As GLint Ptr)
Declare Sub glGetnUniformuivARB(ByVal program As GLuint, ByVal location As GLint, ByVal bufSize As GLsizei, ByVal params As GLuint Ptr)
Declare Sub glGetnUniformdvARB(ByVal program As GLuint, ByVal location As GLint, ByVal bufSize As GLsizei, ByVal params As GLdouble Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETGRAPHICSRESETSTATUSARBPROC As Function() As GLenum
Type PFNGLGETNMAPDVARBPROC As Sub(ByVal target As GLenum, ByVal query As GLenum, ByVal bufSize As GLsizei, ByVal v As GLdouble Ptr)
Type PFNGLGETNMAPFVARBPROC As Sub(ByVal target As GLenum, ByVal query As GLenum, ByVal bufSize As GLsizei, ByVal v As GLfloat Ptr)
Type PFNGLGETNMAPIVARBPROC As Sub(ByVal target As GLenum, ByVal query As GLenum, ByVal bufSize As GLsizei, ByVal v As GLint Ptr)
Type PFNGLGETNPIXELMAPFVARBPROC As Sub(ByVal map As GLenum, ByVal bufSize As GLsizei, ByVal values As GLfloat Ptr)
Type PFNGLGETNPIXELMAPUIVARBPROC As Sub(ByVal map As GLenum, ByVal bufSize As GLsizei, ByVal values As GLuint Ptr)
Type PFNGLGETNPIXELMAPUSVARBPROC As Sub(ByVal map As GLenum, ByVal bufSize As GLsizei, ByVal values As GLushort Ptr)
Type PFNGLGETNPOLYGONSTIPPLEARBPROC As Sub(ByVal bufSize As GLsizei, ByVal pattern As GLubyte Ptr)
Type PFNGLGETNCOLORTABLEARBPROC As Sub(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal bufSize As GLsizei, ByVal table As GLvoid Ptr)
Type PFNGLGETNCONVOLUTIONFILTERARBPROC As Sub(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal bufSize As GLsizei, ByVal image As GLvoid Ptr)
Type PFNGLGETNSEPARABLEFILTERARBPROC As Sub(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal rowBufSize As GLsizei, ByVal row As GLvoid Ptr, ByVal columnBufSize As GLsizei, ByVal column As GLvoid Ptr, ByVal span As GLvoid Ptr)
Type PFNGLGETNHISTOGRAMARBPROC As Sub(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal bufSize As GLsizei, ByVal values As GLvoid Ptr)
Type PFNGLGETNMINMAXARBPROC As Sub(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal bufSize As GLsizei, ByVal values As GLvoid Ptr)
Type PFNGLGETNTEXIMAGEARBPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal bufSize As GLsizei, ByVal img As GLvoid Ptr)
Type PFNGLREADNPIXELSARBPROC As Sub(ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal bufSize As GLsizei, ByVal Data As GLvoid Ptr)
Type PFNGLGETNCOMPRESSEDTEXIMAGEARBPROC As Sub(ByVal target As GLenum, ByVal lod As GLint, ByVal bufSize As GLsizei, ByVal img As GLvoid Ptr)
Type PFNGLGETNUNIFORMFVARBPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal bufSize As GLsizei, ByVal params As GLfloat Ptr)
Type PFNGLGETNUNIFORMIVARBPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal bufSize As GLsizei, ByVal params As GLint Ptr)
Type PFNGLGETNUNIFORMUIVARBPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal bufSize As GLsizei, ByVal params As GLuint Ptr)
Type PFNGLGETNUNIFORMDVARBPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal bufSize As GLsizei, ByVal params As GLdouble Ptr)
#EndIf

#Ifndef GL_ARB_shader_stencil_export
#define GL_ARB_shader_stencil_export 1
#EndIf

#Ifndef GL_ARB_base_instance
#define GL_ARB_base_instance 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDrawArraysInstancedBaseInstance(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei, ByVal primcount As GLsizei, ByVal baseinstance As GLuint)
Declare Sub glDrawElementsInstancedBaseInstance(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As void Ptr, ByVal primcount As GLsizei, ByVal baseinstance As GLuint)
Declare Sub glDrawElementsInstancedBaseVertexBaseInstance(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As void Ptr, ByVal primcount As GLsizei, ByVal basevertex As GLint, ByVal baseinstance As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDRAWARRAYSINSTANCEDBASEINSTANCEPROC As Sub(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei, ByVal primcount As GLsizei, ByVal baseinstance As GLuint)
Type PFNGLDRAWELEMENTSINSTANCEDBASEINSTANCEPROC As Sub(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As Any Ptr, ByVal primcount As GLsizei, ByVal baseinstance As GLuint)
Type PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXBASEINSTANCEPROC As Sub(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As Any Ptr, ByVal primcount As GLsizei, ByVal basevertex As GLint, ByVal baseinstance As GLuint)
#EndIf

#Ifndef GL_ARB_shading_language_420pack
#define GL_ARB_shading_language_420pack 1
#EndIf

#Ifndef GL_ARB_transform_feedback_instanced
#define GL_ARB_transform_feedback_instanced 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDrawTransformFeedbackInstanced(ByVal mode As GLenum, ByVal id As GLuint, ByVal primcount As GLsizei)
Declare Sub glDrawTransformFeedbackStreamInstanced(ByVal mode As GLenum, ByVal id As GLuint, ByVal stream As GLuint, ByVal primcount As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDRAWTRANSFORMFEEDBACKINSTANCEDPROC As Sub(ByVal mode As GLenum, ByVal id As GLuint, ByVal primcount As GLsizei)
Type PFNGLDRAWTRANSFORMFEEDBACKSTREAMINSTANCEDPROC As Sub(ByVal mode As GLenum, ByVal id As GLuint, ByVal stream As GLuint, ByVal primcount As GLsizei)
#EndIf

#Ifndef GL_ARB_compressed_texture_pixel_storage
#define GL_ARB_compressed_texture_pixel_storage 1
#EndIf

#Ifndef GL_ARB_conservative_depth
#define GL_ARB_conservative_depth 1
#EndIf

#Ifndef GL_ARB_internalformat_query
#define GL_ARB_internalformat_query 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGetInternalformativ(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal pname As GLenum, ByVal bufSize As GLsizei, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETINTERNALFORMATIVPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal pname As GLenum, ByVal bufSize As GLsizei, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_ARB_map_buffer_alignment
#define GL_ARB_map_buffer_alignment 1
#EndIf

#Ifndef GL_ARB_shader_atomic_counters
#define GL_ARB_shader_atomic_counters 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGetActiveAtomicCounterBufferiv(ByVal program As GLuint, ByVal bufferIndex As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETACTIVEATOMICCOUNTERBUFFERIVPROC As Sub(ByVal program As GLuint, ByVal bufferIndex As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_ARB_shader_image_load_store
#define GL_ARB_shader_image_load_store 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBindImageTexture(ByVal unit As GLuint, ByVal texture As GLuint, ByVal level As GLint, ByVal layered As GLboolean, ByVal layer As GLint, ByVal Access As GLenum, ByVal Format As GLenum)
Declare Sub glMemoryBarrier(ByVal barriers As GLbitfield)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBINDIMAGETEXTUREPROC As Sub(ByVal unit As GLuint, ByVal texture As GLuint, ByVal level As GLint, ByVal layered As GLboolean, ByVal layer As GLint, ByVal Access As GLenum, ByVal Format As GLenum)
Type PFNGLMEMORYBARRIERPROC As Sub(ByVal barriers As GLbitfield)
#EndIf

#Ifndef GL_ARB_shading_language_packing
#define GL_ARB_shading_language_packing 1
#EndIf

#Ifndef GL_ARB_texture_storage
#define GL_ARB_texture_storage 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTexStorage1D(ByVal target As GLenum, ByVal levels As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei)
Declare Sub glTexStorage2D(ByVal target As GLenum, ByVal levels As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glTexStorage3D(ByVal target As GLenum, ByVal levels As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei)
Declare Sub glTextureStorage1DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal levels As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei)
Declare Sub glTextureStorage2DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal levels As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glTextureStorage3DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal levels As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXSTORAGE1DPROC As Sub(ByVal target As GLenum, ByVal levels As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei)
Type PFNGLTEXSTORAGE2DPROC As Sub(ByVal target As GLenum, ByVal levels As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLTEXSTORAGE3DPROC As Sub(ByVal target As GLenum, ByVal levels As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei)
Type PFNGLTEXTURESTORAGE1DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal levels As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei)
Type PFNGLTEXTURESTORAGE2DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal levels As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLTEXTURESTORAGE3DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal levels As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei)
#EndIf

#Ifndef GL_EXT_abgr
#define GL_EXT_abgr 1
#EndIf

#Ifndef GL_EXT_blend_color
#define GL_EXT_blend_color 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBlendColorEXT(ByVal red As GLclampf, ByVal green As GLclampf, ByVal blue As GLclampf, ByVal Alpha As GLclampf)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBLENDCOLOREXTPROC As Sub(ByVal red As GLclampf, ByVal green As GLclampf, ByVal blue As GLclampf, ByVal Alpha As GLclampf)
#EndIf

#Ifndef GL_EXT_polygon_offset
#define GL_EXT_polygon_offset 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPolygonOffsetEXT(ByVal factor As GLfloat, ByVal bias As GLfloat)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPOLYGONOFFSETEXTPROC As Sub(ByVal factor As GLfloat, ByVal bias As GLfloat)
#EndIf

#Ifndef GL_EXT_texture
#define GL_EXT_texture 1
#EndIf

#Ifndef GL_EXT_texture3D
#define GL_EXT_texture3D 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTexImage3DEXT(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glTexSubImage3DEXT(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXIMAGE3DEXTPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLTEXSUBIMAGE3DEXTPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
#EndIf

#Ifndef GL_SGIS_texture_filter4
#define GL_SGIS_texture_filter4 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGetTexFilterFuncSGIS(ByVal target As GLenum, ByVal filter As GLenum, ByVal weights As GLfloat Ptr)
Declare Sub glTexFilterFuncSGIS(ByVal target As GLenum, ByVal filter As GLenum, ByVal n As GLsizei, ByVal weights As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETTEXFILTERFUNCSGISPROC As Sub(ByVal target As GLenum, ByVal filter As GLenum, ByVal weights As GLfloat Ptr)
Type PFNGLTEXFILTERFUNCSGISPROC As Sub(ByVal target As GLenum, ByVal filter As GLenum, ByVal n As GLsizei, ByVal weights As GLfloat Ptr)
#EndIf

#Ifndef GL_EXT_subtexture
#define GL_EXT_subtexture 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTexSubImage1DEXT(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glTexSubImage2DEXT(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXSUBIMAGE1DEXTPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLTEXSUBIMAGE2DEXTPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
#EndIf

#Ifndef GL_EXT_copy_texture
#define GL_EXT_copy_texture 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glCopyTexImage1DEXT(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal border As GLint)
Declare Sub glCopyTexImage2DEXT(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint)
Declare Sub glCopyTexSubImage1DEXT(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Declare Sub glCopyTexSubImage2DEXT(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glCopyTexSubImage3DEXT(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOPYTEXIMAGE1DEXTPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal border As GLint)
Type PFNGLCOPYTEXIMAGE2DEXTPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint)
Type PFNGLCOPYTEXSUBIMAGE1DEXTPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Type PFNGLCOPYTEXSUBIMAGE2DEXTPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLCOPYTEXSUBIMAGE3DEXTPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
#EndIf

#Ifndef GL_EXT_histogram
#define GL_EXT_histogram 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGetHistogramEXT(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal values As GLvoid Ptr)
Declare Sub glGetHistogramParameterfvEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetHistogramParameterivEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetMinmaxEXT(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal values As GLvoid Ptr)
Declare Sub glGetMinmaxParameterfvEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetMinmaxParameterivEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glHistogramEXT(ByVal target As GLenum, ByVal Width As GLsizei, ByVal internalformat As GLenum, ByVal sink As GLboolean)
Declare Sub glMinmaxEXT(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal sink As GLboolean)
Declare Sub glResetHistogramEXT(ByVal target As GLenum)
Declare Sub glResetMinmaxEXT(ByVal target As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETHISTOGRAMEXTPROC As Sub(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal values As GLvoid Ptr)
Type PFNGLGETHISTOGRAMPARAMETERFVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETHISTOGRAMPARAMETERIVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETMINMAXEXTPROC As Sub(ByVal target As GLenum, ByVal Reset As GLboolean, ByVal Format As GLenum, ByVal Type As GLenum, ByVal values As GLvoid Ptr)
Type PFNGLGETMINMAXPARAMETERFVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETMINMAXPARAMETERIVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLHISTOGRAMEXTPROC As Sub(ByVal target As GLenum, ByVal Width As GLsizei, ByVal internalformat As GLenum, ByVal sink As GLboolean)
Type PFNGLMINMAXEXTPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal sink As GLboolean)
Type PFNGLRESETHISTOGRAMEXTPROC As Sub(ByVal target As GLenum)
Type PFNGLRESETMINMAXEXTPROC As Sub(ByVal target As GLenum)
#EndIf

#Ifndef GL_EXT_convolution
#define GL_EXT_convolution 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glConvolutionFilter1DEXT(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal image As GLvoid Ptr)
Declare Sub glConvolutionFilter2DEXT(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal image As GLvoid Ptr)
Declare Sub glConvolutionParameterfEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat)
Declare Sub glConvolutionParameterfvEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glConvolutionParameteriEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint)
Declare Sub glConvolutionParameterivEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glCopyConvolutionFilter1DEXT(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Declare Sub glCopyConvolutionFilter2DEXT(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glGetConvolutionFilterEXT(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal image As GLvoid Ptr)
Declare Sub glGetConvolutionParameterfvEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetConvolutionParameterivEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetSeparableFilterEXT(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal row As GLvoid Ptr, ByVal column As GLvoid Ptr, ByVal span As GLvoid Ptr)
Declare Sub glSeparableFilter2DEXT(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal row As GLvoid Ptr, ByVal column As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCONVOLUTIONFILTER1DEXTPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal image As GLvoid Ptr)
Type PFNGLCONVOLUTIONFILTER2DEXTPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal image As GLvoid Ptr)
Type PFNGLCONVOLUTIONPARAMETERFEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat)
Type PFNGLCONVOLUTIONPARAMETERFVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLCONVOLUTIONPARAMETERIEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint)
Type PFNGLCONVOLUTIONPARAMETERIVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLCOPYCONVOLUTIONFILTER1DEXTPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Type PFNGLCOPYCONVOLUTIONFILTER2DEXTPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLGETCONVOLUTIONFILTEREXTPROC As Sub(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal image As GLvoid Ptr)
Type PFNGLGETCONVOLUTIONPARAMETERFVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETCONVOLUTIONPARAMETERIVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETSEPARABLEFILTEREXTPROC As Sub(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal row As GLvoid Ptr, ByVal column As GLvoid Ptr, ByVal span As GLvoid Ptr)
Type PFNGLSEPARABLEFILTER2DEXTPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal row As GLvoid Ptr, ByVal column As GLvoid Ptr)
#EndIf

#Ifndef GL_SGI_color_matrix
#define GL_SGI_color_matrix 1
#EndIf

#Ifndef GL_SGI_color_table
#define GL_SGI_color_table 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glColorTableSGI(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal table As GLvoid Ptr)
Declare Sub glColorTableParameterfvSGI(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glColorTableParameterivSGI(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glCopyColorTableSGI(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Declare Sub glGetColorTableSGI(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal table As GLvoid Ptr)
Declare Sub glGetColorTableParameterfvSGI(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetColorTableParameterivSGI(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOLORTABLESGIPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal table As GLvoid Ptr)
Type PFNGLCOLORTABLEPARAMETERFVSGIPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLCOLORTABLEPARAMETERIVSGIPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLCOPYCOLORTABLESGIPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Type PFNGLGETCOLORTABLESGIPROC As Sub(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal table As GLvoid Ptr)
Type PFNGLGETCOLORTABLEPARAMETERFVSGIPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETCOLORTABLEPARAMETERIVSGIPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_SGIX_pixel_texture
#define GL_SGIX_pixel_texture 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPixelTexGenSGIX(ByVal mode As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPIXELTEXGENSGIXPROC As Sub(ByVal mode As GLenum)
#EndIf

#Ifndef GL_SGIS_pixel_texture
#define GL_SGIS_pixel_texture 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPixelTexGenParameteriSGIS(ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glPixelTexGenParameterivSGIS(ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glPixelTexGenParameterfSGIS(ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glPixelTexGenParameterfvSGIS(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetPixelTexGenParameterivSGIS(ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetPixelTexGenParameterfvSGIS(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPIXELTEXGENPARAMETERISGISPROC As Sub(ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLPIXELTEXGENPARAMETERIVSGISPROC As Sub(ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLPIXELTEXGENPARAMETERFSGISPROC As Sub(ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLPIXELTEXGENPARAMETERFVSGISPROC As Sub(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETPIXELTEXGENPARAMETERIVSGISPROC As Sub(ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETPIXELTEXGENPARAMETERFVSGISPROC As Sub(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf

#Ifndef GL_SGIS_texture4D
#define GL_SGIS_texture4D 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTexImage4DSGIS(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal size4d As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glTexSubImage4DSGIS(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal woffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal size4d As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXIMAGE4DSGISPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal size4d As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLTEXSUBIMAGE4DSGISPROC As Sub(ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal woffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal size4d As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
#EndIf

#Ifndef GL_SGI_texture_color_table
#define GL_SGI_texture_color_table 1
#EndIf

#Ifndef GL_EXT_cmyka
#define GL_EXT_cmyka 1
#EndIf

#Ifndef GL_EXT_texture_object
#define GL_EXT_texture_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glAreTexturesResidentEXT(ByVal n As GLsizei, ByVal textures As GLuint Ptr, ByVal residences As GLboolean Ptr) As GLboolean
Declare Sub glBindTextureEXT(ByVal target As GLenum, ByVal texture As GLuint)
Declare Sub glDeleteTexturesEXT(ByVal n As GLsizei, ByVal textures As GLuint Ptr)
Declare Sub glGenTexturesEXT(ByVal n As GLsizei, ByVal textures As GLuint Ptr)
Declare Function glIsTextureEXT(ByVal texture As GLuint) As GLboolean
Declare Sub glPrioritizeTexturesEXT(ByVal n As GLsizei, ByVal textures As GLuint Ptr, ByVal priorities As GLclampf Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLARETEXTURESRESIDENTEXTPROC As Function(ByVal n As GLsizei, ByVal textures As GLuint Ptr, ByVal residences As GLboolean Ptr) As GLboolean
Type PFNGLBINDTEXTUREEXTPROC As Sub(ByVal target As GLenum, ByVal texture As GLuint)
Type PFNGLDELETETEXTURESEXTPROC As Sub(ByVal n As GLsizei, ByVal textures As GLuint Ptr)
Type PFNGLGENTEXTURESEXTPROC As Sub(ByVal n As GLsizei, ByVal textures As GLuint Ptr)
Type PFNGLISTEXTUREEXTPROC As Function(ByVal texture As GLuint) As GLboolean
Type PFNGLPRIORITIZETEXTURESEXTPROC As Sub(ByVal n As GLsizei, ByVal textures As GLuint Ptr, ByVal priorities As GLclampf Ptr)
#EndIf

#Ifndef GL_SGIS_detail_texture
#define GL_SGIS_detail_texture 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDetailTexFuncSGIS(ByVal target As GLenum, ByVal n As GLsizei, ByVal points As GLfloat Ptr)
Declare Sub glGetDetailTexFuncSGIS(ByVal target As GLenum, ByVal points As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDETAILTEXFUNCSGISPROC As Sub(ByVal target As GLenum, ByVal n As GLsizei, ByVal points As GLfloat Ptr)
Type PFNGLGETDETAILTEXFUNCSGISPROC As Sub(ByVal target As GLenum, ByVal points As GLfloat Ptr)
#EndIf

#Ifndef GL_SGIS_sharpen_texture
#define GL_SGIS_sharpen_texture 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glSharpenTexFuncSGIS(ByVal target As GLenum, ByVal n As GLsizei, ByVal points As GLfloat Ptr)
Declare Sub glGetSharpenTexFuncSGIS(ByVal target As GLenum, ByVal points As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLSHARPENTEXFUNCSGISPROC As Sub(ByVal target As GLenum, ByVal n As GLsizei, ByVal points As GLfloat Ptr)
Type PFNGLGETSHARPENTEXFUNCSGISPROC As Sub(ByVal target As GLenum, ByVal points As GLfloat Ptr)
#EndIf

#Ifndef GL_EXT_packed_pixels
#define GL_EXT_packed_pixels 1
#EndIf

#Ifndef GL_SGIS_texture_lod
#define GL_SGIS_texture_lod 1
#EndIf

#Ifndef GL_SGIS_multisample
#define GL_SGIS_multisample 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glSampleMaskSGIS(ByVal value As GLclampf, ByVal invert As GLboolean)
Declare Sub glSamplePatternSGIS(ByVal pattern As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLSAMPLEMASKSGISPROC As Sub(ByVal value As GLclampf, ByVal invert As GLboolean)
Type PFNGLSAMPLEPATTERNSGISPROC As Sub(ByVal pattern As GLenum)
#EndIf

#Ifndef GL_EXT_rescale_normal
#define GL_EXT_rescale_normal 1
#EndIf

#Ifndef GL_EXT_vertex_array
#define GL_EXT_vertex_array 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glArrayElementEXT(ByVal i As GLint)
Declare Sub glColorPointerEXT(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal count As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glDrawArraysEXT(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei)
Declare Sub glEdgeFlagPointerEXT(ByVal stride As GLsizei, ByVal count As GLsizei, ByVal Pointer As GLboolean Ptr)
Declare Sub glGetPointervEXT(ByVal pname As GLenum, ByVal params As GLvoid Ptr Ptr)
Declare Sub glIndexPointerEXT(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal count As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glNormalPointerEXT(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal count As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glTexCoordPointerEXT(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal count As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glVertexPointerEXT(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal count As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLARRAYELEMENTEXTPROC As Sub(ByVal i As GLint)
Type PFNGLCOLORPOINTEREXTPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal count As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLDRAWARRAYSEXTPROC As Sub(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei)
Type PFNGLEDGEFLAGPOINTEREXTPROC As Sub(ByVal stride As GLsizei, ByVal count As GLsizei, ByVal Pointer As GLboolean Ptr)
Type PFNGLGETPOINTERVEXTPROC As Sub(ByVal pname As GLenum, ByVal params As GLvoid Ptr Ptr)
Type PFNGLINDEXPOINTEREXTPROC As Sub(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal count As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLNORMALPOINTEREXTPROC As Sub(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal count As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLTEXCOORDPOINTEREXTPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal count As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLVERTEXPOINTEREXTPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal count As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf

#Ifndef GL_EXT_misc_attribute
#define GL_EXT_misc_attribute 1
#EndIf

#Ifndef GL_SGIS_generate_mipmap
#define GL_SGIS_generate_mipmap 1
#EndIf

#Ifndef GL_SGIX_clipmap
#define GL_SGIX_clipmap 1
#EndIf

#Ifndef GL_SGIX_shadow
#define GL_SGIX_shadow 1
#EndIf

#Ifndef GL_SGIS_texture_edge_clamp
#define GL_SGIS_texture_edge_clamp 1
#EndIf

#Ifndef GL_SGIS_texture_border_clamp
#define GL_SGIS_texture_border_clamp 1
#EndIf

#Ifndef GL_EXT_blend_minmax
#define GL_EXT_blend_minmax 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBlendEquationEXT(ByVal mode As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBLENDEQUATIONEXTPROC As Sub(ByVal mode As GLenum)
#EndIf

#Ifndef GL_EXT_blend_subtract
#define GL_EXT_blend_subtract 1
#EndIf

#Ifndef GL_EXT_blend_logic_op
#define GL_EXT_blend_logic_op 1
#EndIf

#Ifndef GL_SGIX_interlace
#define GL_SGIX_interlace 1
#EndIf

#Ifndef GL_SGIX_pixel_tiles
#define GL_SGIX_pixel_tiles 1
#EndIf

#Ifndef GL_SGIX_texture_select
#define GL_SGIX_texture_select 1
#EndIf

#Ifndef GL_SGIX_sprite
#define GL_SGIX_sprite 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glSpriteParameterfSGIX(ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glSpriteParameterfvSGIX(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glSpriteParameteriSGIX(ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glSpriteParameterivSGIX(ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLSPRITEPARAMETERFSGIXPROC As Sub(ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLSPRITEPARAMETERFVSGIXPROC As Sub(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLSPRITEPARAMETERISGIXPROC As Sub(ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLSPRITEPARAMETERIVSGIXPROC As Sub(ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_SGIX_texture_multi_buffer
#define GL_SGIX_texture_multi_buffer 1
#EndIf

#Ifndef GL_EXT_point_parameters
#define GL_EXT_point_parameters 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPointParameterfEXT(ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glPointParameterfvEXT(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPOINTPARAMETERFEXTPROC As Sub(ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLPOINTPARAMETERFVEXTPROC As Sub(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf

#Ifndef GL_SGIS_point_parameters
#define GL_SGIS_point_parameters 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPointParameterfSGIS(ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glPointParameterfvSGIS(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPOINTPARAMETERFSGISPROC As Sub(ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLPOINTPARAMETERFVSGISPROC As Sub(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf

#Ifndef GL_SGIX_instruments
#define GL_SGIX_instruments 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glGetInstrumentsSGIX() As GLint
Declare Sub glInstrumentsBufferSGIX(ByVal size As GLsizei, ByVal buffer As GLint Ptr)
Declare Function glPollInstrumentsSGIX(ByVal marker_p As GLint Ptr) As GLint
Declare Sub glReadInstrumentsSGIX(ByVal marker As GLint)
Declare Sub glStartInstrumentsSGIX()
Declare Sub glStopInstrumentsSGIX(ByVal marker As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETINSTRUMENTSSGIXPROC As Function() As GLint
Type PFNGLINSTRUMENTSBUFFERSGIXPROC As Sub(ByVal size As GLsizei, ByVal buffer As GLint Ptr)
Type PFNGLPOLLINSTRUMENTSSGIXPROC As Function(ByVal marker_p As GLint Ptr) As GLint
Type PFNGLREADINSTRUMENTSSGIXPROC As Sub(ByVal marker As GLint)
Type PFNGLSTARTINSTRUMENTSSGIXPROC As Sub()
Type PFNGLSTOPINSTRUMENTSSGIXPROC As Sub(ByVal marker As GLint)
#EndIf

#Ifndef GL_SGIX_texture_scale_bias
#define GL_SGIX_texture_scale_bias 1
#EndIf

#Ifndef GL_SGIX_framezoom
#define GL_SGIX_framezoom 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glFrameZoomSGIX(ByVal factor As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLFRAMEZOOMSGIXPROC As Sub(ByVal factor As GLint)
#EndIf

#Ifndef GL_SGIX_tag_sample_buffer
#define GL_SGIX_tag_sample_buffer 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTagSampleBufferSGIX()
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTAGSAMPLEBUFFERSGIXPROC As Sub()
#EndIf

#Ifndef GL_SGIX_polynomial_ffd
#define GL_SGIX_polynomial_ffd 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDeformationMap3dSGIX(ByVal target As GLenum, ByVal u1 As GLdouble, ByVal u2 As GLdouble, ByVal ustride As GLint, ByVal uorder As GLint, ByVal v1 As GLdouble, ByVal v2 As GLdouble, ByVal vstride As GLint, ByVal vorder As GLint, ByVal w1 As GLdouble, ByVal w2 As GLdouble, ByVal wstride As GLint, ByVal worder As GLint, ByVal points As GLdouble Ptr)
Declare Sub glDeformationMap3fSGIX(ByVal target As GLenum, ByVal u1 As GLfloat, ByVal u2 As GLfloat, ByVal ustride As GLint, ByVal uorder As GLint, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal vstride As GLint, ByVal vorder As GLint, ByVal w1 As GLfloat, ByVal w2 As GLfloat, ByVal wstride As GLint, ByVal worder As GLint, ByVal points As GLfloat Ptr)
Declare Sub glDeformSGIX(ByVal mask As GLbitfield)
Declare Sub glLoadIdentityDeformationMapSGIX(ByVal mask As GLbitfield)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDEFORMATIONMAP3DSGIXPROC As Sub(ByVal target As GLenum, ByVal u1 As GLdouble, ByVal u2 As GLdouble, ByVal ustride As GLint, ByVal uorder As GLint, ByVal v1 As GLdouble, ByVal v2 As GLdouble, ByVal vstride As GLint, ByVal vorder As GLint, ByVal w1 As GLdouble, ByVal w2 As GLdouble, ByVal wstride As GLint, ByVal worder As GLint, ByVal points As GLdouble Ptr)
Type PFNGLDEFORMATIONMAP3FSGIXPROC As Sub(ByVal target As GLenum, ByVal u1 As GLfloat, ByVal u2 As GLfloat, ByVal ustride As GLint, ByVal uorder As GLint, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal vstride As GLint, ByVal vorder As GLint, ByVal w1 As GLfloat, ByVal w2 As GLfloat, ByVal wstride As GLint, ByVal worder As GLint, ByVal points As GLfloat Ptr)
Type PFNGLDEFORMSGIXPROC As Sub(ByVal mask As GLbitfield)
Type PFNGLLOADIDENTITYDEFORMATIONMAPSGIXPROC As Sub(ByVal mask As GLbitfield)
#EndIf

#Ifndef GL_SGIX_reference_plane
#define GL_SGIX_reference_plane 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glReferencePlaneSGIX(ByVal equation As GLdouble Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLREFERENCEPLANESGIXPROC As Sub(ByVal equation As GLdouble Ptr)
#EndIf

#Ifndef GL_SGIX_flush_raster
#define GL_SGIX_flush_raster 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glFlushRasterSGIX()
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLFLUSHRASTERSGIXPROC As Sub()
#EndIf

#Ifndef GL_SGIX_depth_texture
#define GL_SGIX_depth_texture 1
#EndIf

#Ifndef GL_SGIS_fog_function
#define GL_SGIS_fog_function 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glFogFuncSGIS(ByVal n As GLsizei, ByVal points As GLfloat Ptr)
Declare Sub glGetFogFuncSGIS(ByVal points As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLFOGFUNCSGISPROC As Sub(ByVal n As GLsizei, ByVal points As GLfloat Ptr)
Type PFNGLGETFOGFUNCSGISPROC As Sub(ByVal points As GLfloat Ptr)
#EndIf

#Ifndef GL_SGIX_fog_offset
#define GL_SGIX_fog_offset 1
#EndIf

#Ifndef GL_HP_image_transform
#define GL_HP_image_transform 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glImageTransformParameteriHP(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glImageTransformParameterfHP(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glImageTransformParameterivHP(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glImageTransformParameterfvHP(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetImageTransformParameterivHP(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetImageTransformParameterfvHP(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLIMAGETRANSFORMPARAMETERIHPPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLIMAGETRANSFORMPARAMETERFHPPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLIMAGETRANSFORMPARAMETERIVHPPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLIMAGETRANSFORMPARAMETERFVHPPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETIMAGETRANSFORMPARAMETERIVHPPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETIMAGETRANSFORMPARAMETERFVHPPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf

#Ifndef GL_HP_convolution_border_modes
#define GL_HP_convolution_border_modes 1
#EndIf

#Ifndef GL_SGIX_texture_add_env
#define GL_SGIX_texture_add_env 1
#EndIf

#Ifndef GL_EXT_color_subtable
#define GL_EXT_color_subtable 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glColorSubTableEXT(ByVal target As GLenum, ByVal start As GLsizei, ByVal count As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal Data As GLvoid Ptr)
Declare Sub glCopyColorSubTableEXT(ByVal target As GLenum, ByVal start As GLsizei, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOLORSUBTABLEEXTPROC As Sub(ByVal target As GLenum, ByVal start As GLsizei, ByVal count As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal Data As GLvoid Ptr)
Type PFNGLCOPYCOLORSUBTABLEEXTPROC As Sub(ByVal target As GLenum, ByVal start As GLsizei, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
#EndIf

#Ifndef GL_PGI_vertex_hints
#define GL_PGI_vertex_hints 1
#EndIf

#Ifndef GL_PGI_misc_hints
#define GL_PGI_misc_hints 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glHintPGI(ByVal target As GLenum, ByVal mode As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLHINTPGIPROC As Sub(ByVal target As GLenum, ByVal mode As GLint)
#EndIf

#Ifndef GL_EXT_paletted_texture
#define GL_EXT_paletted_texture 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glColorTableEXT(ByVal target As GLenum, ByVal internalFormat As GLenum, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal table As GLvoid Ptr)
Declare Sub glGetColorTableEXT(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal Data As GLvoid Ptr)
Declare Sub glGetColorTableParameterivEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetColorTableParameterfvEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOLORTABLEEXTPROC As Sub(ByVal target As GLenum, ByVal internalFormat As GLenum, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal table As GLvoid Ptr)
Type PFNGLGETCOLORTABLEEXTPROC As Sub(ByVal target As GLenum, ByVal Format As GLenum, ByVal Type As GLenum, ByVal Data As GLvoid Ptr)
Type PFNGLGETCOLORTABLEPARAMETERIVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETCOLORTABLEPARAMETERFVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf

#Ifndef GL_EXT_clip_volume_hint
#define GL_EXT_clip_volume_hint 1
#EndIf

#Ifndef GL_SGIX_list_priority
#define GL_SGIX_list_priority 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGetListParameterfvSGIX(ByVal list As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetListParameterivSGIX(ByVal list As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glListParameterfSGIX(ByVal list As GLuint, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glListParameterfvSGIX(ByVal list As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glListParameteriSGIX(ByVal list As GLuint, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glListParameterivSGIX(ByVal list As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETLISTPARAMETERFVSGIXPROC As Sub(ByVal list As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETLISTPARAMETERIVSGIXPROC As Sub(ByVal list As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLLISTPARAMETERFSGIXPROC As Sub(ByVal list As GLuint, ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLLISTPARAMETERFVSGIXPROC As Sub(ByVal list As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLLISTPARAMETERISGIXPROC As Sub(ByVal list As GLuint, ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLLISTPARAMETERIVSGIXPROC As Sub(ByVal list As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_SGIX_ir_instrument1
#define GL_SGIX_ir_instrument1 1
#EndIf

#Ifndef GL_SGIX_calligraphic_fragment
#define GL_SGIX_calligraphic_fragment 1
#EndIf

#Ifndef GL_SGIX_texture_lod_bias
#define GL_SGIX_texture_lod_bias 1
#EndIf

#Ifndef GL_SGIX_shadow_ambient
#define GL_SGIX_shadow_ambient 1
#EndIf

#Ifndef GL_EXT_index_texture
#define GL_EXT_index_texture 1
#EndIf

#Ifndef GL_EXT_index_material
#define GL_EXT_index_material 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glIndexMaterialEXT(ByVal face As GLenum, ByVal mode As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLINDEXMATERIALEXTPROC As Sub(ByVal face As GLenum, ByVal mode As GLenum)
#EndIf

#Ifndef GL_EXT_index_func
#define GL_EXT_index_func 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glIndexFuncEXT(ByVal func As GLenum, ByVal ref As GLclampf)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLINDEXFUNCEXTPROC As Sub(ByVal func As GLenum, ByVal ref As GLclampf)
#EndIf

#Ifndef GL_EXT_index_array_formats
#define GL_EXT_index_array_formats 1
#EndIf

#Ifndef GL_EXT_compiled_vertex_array
#define GL_EXT_compiled_vertex_array 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glLockArraysEXT(ByVal first As GLint, ByVal count As GLsizei)
Declare Sub glUnlockArraysEXT()
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLLOCKARRAYSEXTPROC As Sub(ByVal first As GLint, ByVal count As GLsizei)
Type PFNGLUNLOCKARRAYSEXTPROC As Sub()
#EndIf

#Ifndef GL_EXT_cull_vertex
#define GL_EXT_cull_vertex 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glCullParameterdvEXT(ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Declare Sub glCullParameterfvEXT(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCULLPARAMETERDVEXTPROC As Sub(ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Type PFNGLCULLPARAMETERFVEXTPROC As Sub(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf

#Ifndef GL_SGIX_ycrcb
#define GL_SGIX_ycrcb 1
#EndIf

#Ifndef GL_SGIX_fragment_lighting
#define GL_SGIX_fragment_lighting 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glFragmentColorMaterialSGIX(ByVal face As GLenum, ByVal mode As GLenum)
Declare Sub glFragmentLightfSGIX(ByVal light As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glFragmentLightfvSGIX(ByVal light As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glFragmentLightiSGIX(ByVal light As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glFragmentLightivSGIX(ByVal light As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glFragmentLightModelfSGIX(ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glFragmentLightModelfvSGIX(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glFragmentLightModeliSGIX(ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glFragmentLightModelivSGIX(ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glFragmentMaterialfSGIX(ByVal face As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glFragmentMaterialfvSGIX(ByVal face As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glFragmentMaterialiSGIX(ByVal face As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glFragmentMaterialivSGIX(ByVal face As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetFragmentLightfvSGIX(ByVal light As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetFragmentLightivSGIX(ByVal light As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetFragmentMaterialfvSGIX(ByVal face As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetFragmentMaterialivSGIX(ByVal face As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glLightEnviSGIX(ByVal pname As GLenum, ByVal param As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLFRAGMENTCOLORMATERIALSGIXPROC As Sub(ByVal face As GLenum, ByVal mode As GLenum)
Type PFNGLFRAGMENTLIGHTFSGIXPROC As Sub(ByVal light As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLFRAGMENTLIGHTFVSGIXPROC As Sub(ByVal light As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLFRAGMENTLIGHTISGIXPROC As Sub(ByVal light As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLFRAGMENTLIGHTIVSGIXPROC As Sub(ByVal light As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLFRAGMENTLIGHTMODELFSGIXPROC As Sub(ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLFRAGMENTLIGHTMODELFVSGIXPROC As Sub(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLFRAGMENTLIGHTMODELISGIXPROC As Sub(ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLFRAGMENTLIGHTMODELIVSGIXPROC As Sub(ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLFRAGMENTMATERIALFSGIXPROC As Sub(ByVal face As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLFRAGMENTMATERIALFVSGIXPROC As Sub(ByVal face As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLFRAGMENTMATERIALISGIXPROC As Sub(ByVal face As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLFRAGMENTMATERIALIVSGIXPROC As Sub(ByVal face As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETFRAGMENTLIGHTFVSGIXPROC As Sub(ByVal light As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETFRAGMENTLIGHTIVSGIXPROC As Sub(ByVal light As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETFRAGMENTMATERIALFVSGIXPROC As Sub(ByVal face As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETFRAGMENTMATERIALIVSGIXPROC As Sub(ByVal face As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLLIGHTENVISGIXPROC As Sub(ByVal pname As GLenum, ByVal param As GLint)
#EndIf

#Ifndef GL_IBM_rasterpos_clip
#define GL_IBM_rasterpos_clip 1
#EndIf

#Ifndef GL_HP_texture_lighting
#define GL_HP_texture_lighting 1
#EndIf

#Ifndef GL_EXT_draw_range_elements
#define GL_EXT_draw_range_elements 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDrawRangeElementsEXT(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDRAWRANGEELEMENTSEXTPROC As Sub(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr)
#EndIf

#Ifndef GL_WIN_phong_shading
#define GL_WIN_phong_shading 1
#EndIf

#Ifndef GL_WIN_specular_fog
#define GL_WIN_specular_fog 1
#EndIf

#Ifndef GL_EXT_light_texture
#define GL_EXT_light_texture 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glApplyTextureEXT(ByVal mode As GLenum)
Declare Sub glTextureLightEXT(ByVal pname As GLenum)
Declare Sub glTextureMaterialEXT(ByVal face As GLenum, ByVal mode As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLAPPLYTEXTUREEXTPROC As Sub(ByVal mode As GLenum)
Type PFNGLTEXTURELIGHTEXTPROC As Sub(ByVal pname As GLenum)
Type PFNGLTEXTUREMATERIALEXTPROC As Sub(ByVal face As GLenum, ByVal mode As GLenum)
#EndIf

#Ifndef GL_SGIX_blend_alpha_minmax
#define GL_SGIX_blend_alpha_minmax 1
#EndIf

#Ifndef GL_EXT_bgra
#define GL_EXT_bgra 1
#EndIf

#Ifndef GL_SGIX_async
#define GL_SGIX_async 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glAsyncMarkerSGIX(ByVal marker As GLuint)
Declare Function glFinishAsyncSGIX(ByVal markerp As GLuint Ptr) As GLint
Declare Function glPollAsyncSGIX(ByVal markerp As GLuint Ptr) As GLint
Declare Function glGenAsyncMarkersSGIX(ByVal range As GLsizei) As GLuint
Declare Sub glDeleteAsyncMarkersSGIX(ByVal marker As GLuint, ByVal range As GLsizei)
Declare Function glIsAsyncMarkerSGIX(ByVal marker As GLuint) As GLboolean
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLASYNCMARKERSGIXPROC As Sub(ByVal marker As GLuint)
Type PFNGLFINISHASYNCSGIXPROC As Function(ByVal markerp As GLuint Ptr) As GLint
Type PFNGLPOLLASYNCSGIXPROC As Function(ByVal markerp As GLuint Ptr) As GLint
Type PFNGLGENASYNCMARKERSSGIXPROC As Function(ByVal range As GLsizei) As GLuint
Type PFNGLDELETEASYNCMARKERSSGIXPROC As Sub(ByVal marker As GLuint, ByVal range As GLsizei)
Type PFNGLISASYNCMARKERSGIXPROC As Function(ByVal marker As GLuint) As GLboolean
#EndIf

#Ifndef GL_SGIX_async_pixel
#define GL_SGIX_async_pixel 1
#EndIf

#Ifndef GL_SGIX_async_histogram
#define GL_SGIX_async_histogram 1
#EndIf

#Ifndef GL_INTEL_parallel_arrays
#define GL_INTEL_parallel_arrays 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexPointervINTEL(ByVal size As GLint, ByVal Type As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
Declare Sub glNormalPointervINTEL(ByVal Type As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
Declare Sub glColorPointervINTEL(ByVal size As GLint, ByVal Type As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
Declare Sub glTexCoordPointervINTEL(ByVal size As GLint, ByVal Type As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXPOINTERVINTELPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
Type PFNGLNORMALPOINTERVINTELPROC As Sub(ByVal Type As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
Type PFNGLCOLORPOINTERVINTELPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
Type PFNGLTEXCOORDPOINTERVINTELPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
#EndIf

#Ifndef GL_HP_occlusion_test
#define GL_HP_occlusion_test 1
#EndIf

#Ifndef GL_EXT_pixel_transform
#define GL_EXT_pixel_transform 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPixelTransformParameteriEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glPixelTransformParameterfEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glPixelTransformParameterivEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glPixelTransformParameterfvEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPIXELTRANSFORMPARAMETERIEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLPIXELTRANSFORMPARAMETERFEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLPIXELTRANSFORMPARAMETERIVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLPIXELTRANSFORMPARAMETERFVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf

#Ifndef GL_EXT_pixel_transform_color_table
#define GL_EXT_pixel_transform_color_table 1
#EndIf

#Ifndef GL_EXT_shared_texture_palette
#define GL_EXT_shared_texture_palette 1
#EndIf

#Ifndef GL_EXT_separate_specular_color
#define GL_EXT_separate_specular_color 1
#EndIf

#Ifndef GL_EXT_secondary_color
#define GL_EXT_secondary_color 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glSecondaryColor3bEXT(ByVal red As GLbyte, ByVal green As GLbyte, ByVal blue As GLbyte)
Declare Sub glSecondaryColor3bvEXT(ByVal v As GLbyte Ptr)
Declare Sub glSecondaryColor3dEXT(ByVal red As GLdouble, ByVal green As GLdouble, ByVal blue As GLdouble)
Declare Sub glSecondaryColor3dvEXT(ByVal v As GLdouble Ptr)
Declare Sub glSecondaryColor3fEXT(ByVal red As GLfloat, ByVal green As GLfloat, ByVal blue As GLfloat)
Declare Sub glSecondaryColor3fvEXT(ByVal v As GLfloat Ptr)
Declare Sub glSecondaryColor3iEXT(ByVal red As GLint, ByVal green As GLint, ByVal blue As GLint)
Declare Sub glSecondaryColor3ivEXT(ByVal v As GLint Ptr)
Declare Sub glSecondaryColor3sEXT(ByVal red As GLshort, ByVal green As GLshort, ByVal blue As GLshort)
Declare Sub glSecondaryColor3svEXT(ByVal v As GLshort Ptr)
Declare Sub glSecondaryColor3ubEXT(ByVal red As GLubyte, ByVal green As GLubyte, ByVal blue As GLubyte)
Declare Sub glSecondaryColor3ubvEXT(ByVal v As GLubyte Ptr)
Declare Sub glSecondaryColor3uiEXT(ByVal red As GLuint, ByVal green As GLuint, ByVal blue As GLuint)
Declare Sub glSecondaryColor3uivEXT(ByVal v As GLuint Ptr)
Declare Sub glSecondaryColor3usEXT(ByVal red As GLushort, ByVal green As GLushort, ByVal blue As GLushort)
Declare Sub glSecondaryColor3usvEXT(ByVal v As GLushort Ptr)
Declare Sub glSecondaryColorPointerEXT(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLSECONDARYCOLOR3BEXTPROC As Sub(ByVal red As GLbyte, ByVal green As GLbyte, ByVal blue As GLbyte)
Type PFNGLSECONDARYCOLOR3BVEXTPROC As Sub(ByVal v As GLbyte Ptr)
Type PFNGLSECONDARYCOLOR3DEXTPROC As Sub(ByVal red As GLdouble, ByVal green As GLdouble, ByVal blue As GLdouble)
Type PFNGLSECONDARYCOLOR3DVEXTPROC As Sub(ByVal v As GLdouble Ptr)
Type PFNGLSECONDARYCOLOR3FEXTPROC As Sub(ByVal red As GLfloat, ByVal green As GLfloat, ByVal blue As GLfloat)
Type PFNGLSECONDARYCOLOR3FVEXTPROC As Sub(ByVal v As GLfloat Ptr)
Type PFNGLSECONDARYCOLOR3IEXTPROC As Sub(ByVal red As GLint, ByVal green As GLint, ByVal blue As GLint)
Type PFNGLSECONDARYCOLOR3IVEXTPROC As Sub(ByVal v As GLint Ptr)
Type PFNGLSECONDARYCOLOR3SEXTPROC As Sub(ByVal red As GLshort, ByVal green As GLshort, ByVal blue As GLshort)
Type PFNGLSECONDARYCOLOR3SVEXTPROC As Sub(ByVal v As GLshort Ptr)
Type PFNGLSECONDARYCOLOR3UBEXTPROC As Sub(ByVal red As GLubyte, ByVal green As GLubyte, ByVal blue As GLubyte)
Type PFNGLSECONDARYCOLOR3UBVEXTPROC As Sub(ByVal v As GLubyte Ptr)
Type PFNGLSECONDARYCOLOR3UIEXTPROC As Sub(ByVal red As GLuint, ByVal green As GLuint, ByVal blue As GLuint)
Type PFNGLSECONDARYCOLOR3UIVEXTPROC As Sub(ByVal v As GLuint Ptr)
Type PFNGLSECONDARYCOLOR3USEXTPROC As Sub(ByVal red As GLushort, ByVal green As GLushort, ByVal blue As GLushort)
Type PFNGLSECONDARYCOLOR3USVEXTPROC As Sub(ByVal v As GLushort Ptr)
Type PFNGLSECONDARYCOLORPOINTEREXTPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf

#Ifndef GL_EXT_texture_perturb_normal
#define GL_EXT_texture_perturb_normal 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTextureNormalEXT(ByVal mode As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXTURENORMALEXTPROC As Sub(ByVal mode As GLenum)
#EndIf

#Ifndef GL_EXT_multi_draw_arrays
#define GL_EXT_multi_draw_arrays 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glMultiDrawArraysEXT(ByVal mode As GLenum, ByVal first As GLint Ptr, ByVal count As GLsizei Ptr, ByVal primcount As GLsizei)
Declare Sub glMultiDrawElementsEXT(ByVal mode As GLenum, ByVal count As GLsizei Ptr, ByVal Type As GLenum, ByVal indices As GLvoid Ptr Ptr, ByVal primcount As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLMULTIDRAWARRAYSEXTPROC As Sub(ByVal mode As GLenum, ByVal first As GLint Ptr, ByVal count As GLsizei Ptr, ByVal primcount As GLsizei)
Type PFNGLMULTIDRAWELEMENTSEXTPROC As Sub(ByVal mode As GLenum, ByVal count As GLsizei Ptr, ByVal Type As GLenum, ByVal indices As GLvoid Ptr Ptr, ByVal primcount As GLsizei)
#EndIf

#Ifndef GL_EXT_fog_coord
#define GL_EXT_fog_coord 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glFogCoordfEXT(ByVal coord As GLfloat)
Declare Sub glFogCoordfvEXT(ByVal coord As GLfloat Ptr)
Declare Sub glFogCoorddEXT(ByVal coord As GLdouble)
Declare Sub glFogCoorddvEXT(ByVal coord As GLdouble Ptr)
Declare Sub glFogCoordPointerEXT(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLFOGCOORDFEXTPROC As Sub(ByVal coord As GLfloat)
Type PFNGLFOGCOORDFVEXTPROC As Sub(ByVal coord As GLfloat Ptr)
Type PFNGLFOGCOORDDEXTPROC As Sub(ByVal coord As GLdouble)
Type PFNGLFOGCOORDDVEXTPROC As Sub(ByVal coord As GLdouble Ptr)
Type PFNGLFOGCOORDPOINTEREXTPROC As Sub(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf

#Ifndef GL_REND_screen_coordinates
#define GL_REND_screen_coordinates 1
#EndIf

#Ifndef GL_EXT_coordinate_frame
#define GL_EXT_coordinate_frame 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTangent3bEXT(ByVal tx As GLbyte, ByVal ty As GLbyte, ByVal tz As GLbyte)
Declare Sub glTangent3bvEXT(ByVal v As GLbyte Ptr)
Declare Sub glTangent3dEXT(ByVal tx As GLdouble, ByVal ty As GLdouble, ByVal tz As GLdouble)
Declare Sub glTangent3dvEXT(ByVal v As GLdouble Ptr)
Declare Sub glTangent3fEXT(ByVal tx As GLfloat, ByVal ty As GLfloat, ByVal tz As GLfloat)
Declare Sub glTangent3fvEXT(ByVal v As GLfloat Ptr)
Declare Sub glTangent3iEXT(ByVal tx As GLint, ByVal ty As GLint, ByVal tz As GLint)
Declare Sub glTangent3ivEXT(ByVal v As GLint Ptr)
Declare Sub glTangent3sEXT(ByVal tx As GLshort, ByVal ty As GLshort, ByVal tz As GLshort)
Declare Sub glTangent3svEXT(ByVal v As GLshort Ptr)
Declare Sub glBinormal3bEXT(ByVal bx As GLbyte, ByVal by As GLbyte, ByVal bz As GLbyte)
Declare Sub glBinormal3bvEXT(ByVal v As GLbyte Ptr)
Declare Sub glBinormal3dEXT(ByVal bx As GLdouble, ByVal by As GLdouble, ByVal bz As GLdouble)
Declare Sub glBinormal3dvEXT(ByVal v As GLdouble Ptr)
Declare Sub glBinormal3fEXT(ByVal bx As GLfloat, ByVal by As GLfloat, ByVal bz As GLfloat)
Declare Sub glBinormal3fvEXT(ByVal v As GLfloat Ptr)
Declare Sub glBinormal3iEXT(ByVal bx As GLint, ByVal by As GLint, ByVal bz As GLint)
Declare Sub glBinormal3ivEXT(ByVal v As GLint Ptr)
Declare Sub glBinormal3sEXT(ByVal bx As GLshort, ByVal by As GLshort, ByVal bz As GLshort)
Declare Sub glBinormal3svEXT(ByVal v As GLshort Ptr)
Declare Sub glTangentPointerEXT(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glBinormalPointerEXT(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTANGENT3BEXTPROC As Sub(ByVal tx As GLbyte, ByVal ty As GLbyte, ByVal tz As GLbyte)
Type PFNGLTANGENT3BVEXTPROC As Sub(ByVal v As GLbyte Ptr)
Type PFNGLTANGENT3DEXTPROC As Sub(ByVal tx As GLdouble, ByVal ty As GLdouble, ByVal tz As GLdouble)
Type PFNGLTANGENT3DVEXTPROC As Sub(ByVal v As GLdouble Ptr)
Type PFNGLTANGENT3FEXTPROC As Sub(ByVal tx As GLfloat, ByVal ty As GLfloat, ByVal tz As GLfloat)
Type PFNGLTANGENT3FVEXTPROC As Sub(ByVal v As GLfloat Ptr)
Type PFNGLTANGENT3IEXTPROC As Sub(ByVal tx As GLint, ByVal ty As GLint, ByVal tz As GLint)
Type PFNGLTANGENT3IVEXTPROC As Sub(ByVal v As GLint Ptr)
Type PFNGLTANGENT3SEXTPROC As Sub(ByVal tx As GLshort, ByVal ty As GLshort, ByVal tz As GLshort)
Type PFNGLTANGENT3SVEXTPROC As Sub(ByVal v As GLshort Ptr)
Type PFNGLBINORMAL3BEXTPROC As Sub(ByVal bx As GLbyte, ByVal by As GLbyte, ByVal bz As GLbyte)
Type PFNGLBINORMAL3BVEXTPROC As Sub(ByVal v As GLbyte Ptr)
Type PFNGLBINORMAL3DEXTPROC As Sub(ByVal bx As GLdouble, ByVal by As GLdouble, ByVal bz As GLdouble)
Type PFNGLBINORMAL3DVEXTPROC As Sub(ByVal v As GLdouble Ptr)
Type PFNGLBINORMAL3FEXTPROC As Sub(ByVal bx As GLfloat, ByVal by As GLfloat, ByVal bz As GLfloat)
Type PFNGLBINORMAL3FVEXTPROC As Sub(ByVal v As GLfloat Ptr)
Type PFNGLBINORMAL3IEXTPROC As Sub(ByVal bx As GLint, ByVal by As GLint, ByVal bz As GLint)
Type PFNGLBINORMAL3IVEXTPROC As Sub(ByVal v As GLint Ptr)
Type PFNGLBINORMAL3SEXTPROC As Sub(ByVal bx As GLshort, ByVal by As GLshort, ByVal bz As GLshort)
Type PFNGLBINORMAL3SVEXTPROC As Sub(ByVal v As GLshort Ptr)
Type PFNGLTANGENTPOINTEREXTPROC As Sub(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLBINORMALPOINTEREXTPROC As Sub(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf

#Ifndef GL_EXT_texture_env_combine
#define GL_EXT_texture_env_combine 1
#EndIf

#Ifndef GL_APPLE_specular_vector
#define GL_APPLE_specular_vector 1
#EndIf

#Ifndef GL_APPLE_transform_hint
#define GL_APPLE_transform_hint 1
#EndIf

#Ifndef GL_SGIX_fog_scale
#define GL_SGIX_fog_scale 1
#EndIf

#Ifndef GL_SUNX_constant_data
#define GL_SUNX_constant_data 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glFinishTextureSUNX()
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLFINISHTEXTURESUNXPROC As Sub()
#EndIf

#Ifndef GL_SUN_global_alpha
#define GL_SUN_global_alpha 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGlobalAlphaFactorbSUN(ByVal factor As GLbyte)
Declare Sub glGlobalAlphaFactorsSUN(ByVal factor As GLshort)
Declare Sub glGlobalAlphaFactoriSUN(ByVal factor As GLint)
Declare Sub glGlobalAlphaFactorfSUN(ByVal factor As GLfloat)
Declare Sub glGlobalAlphaFactordSUN(ByVal factor As GLdouble)
Declare Sub glGlobalAlphaFactorubSUN(ByVal factor As GLubyte)
Declare Sub glGlobalAlphaFactorusSUN(ByVal factor As GLushort)
Declare Sub glGlobalAlphaFactoruiSUN(ByVal factor As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGLOBALALPHAFACTORBSUNPROC As Sub(ByVal factor As GLbyte)
Type PFNGLGLOBALALPHAFACTORSSUNPROC As Sub(ByVal factor As GLshort)
Type PFNGLGLOBALALPHAFACTORISUNPROC As Sub(ByVal factor As GLint)
Type PFNGLGLOBALALPHAFACTORFSUNPROC As Sub(ByVal factor As GLfloat)
Type PFNGLGLOBALALPHAFACTORDSUNPROC As Sub(ByVal factor As GLdouble)
Type PFNGLGLOBALALPHAFACTORUBSUNPROC As Sub(ByVal factor As GLubyte)
Type PFNGLGLOBALALPHAFACTORUSSUNPROC As Sub(ByVal factor As GLushort)
Type PFNGLGLOBALALPHAFACTORUISUNPROC As Sub(ByVal factor As GLuint)
#EndIf

#Ifndef GL_SUN_triangle_list
#define GL_SUN_triangle_list 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glReplacementCodeuiSUN(ByVal code As GLuint)
Declare Sub glReplacementCodeusSUN(ByVal code As GLushort)
Declare Sub glReplacementCodeubSUN(ByVal code As GLubyte)
Declare Sub glReplacementCodeuivSUN(ByVal code As GLuint Ptr)
Declare Sub glReplacementCodeusvSUN(ByVal code As GLushort Ptr)
Declare Sub glReplacementCodeubvSUN(ByVal code As GLubyte Ptr)
Declare Sub glReplacementCodePointerSUN(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLREPLACEMENTCODEUISUNPROC As Sub(ByVal code As GLuint)
Type PFNGLREPLACEMENTCODEUSSUNPROC As Sub(ByVal code As GLushort)
Type PFNGLREPLACEMENTCODEUBSUNPROC As Sub(ByVal code As GLubyte)
Type PFNGLREPLACEMENTCODEUIVSUNPROC As Sub(ByVal code As GLuint Ptr)
Type PFNGLREPLACEMENTCODEUSVSUNPROC As Sub(ByVal code As GLushort Ptr)
Type PFNGLREPLACEMENTCODEUBVSUNPROC As Sub(ByVal code As GLubyte Ptr)
Type PFNGLREPLACEMENTCODEPOINTERSUNPROC As Sub(ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr Ptr)
#EndIf

#Ifndef GL_SUN_vertex
#define GL_SUN_vertex 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glColor4ubVertex2fSUN(ByVal r As GLubyte, ByVal g As GLubyte, ByVal b As GLubyte, ByVal a As GLubyte, ByVal x As GLfloat, ByVal y As GLfloat)
Declare Sub glColor4ubVertex2fvSUN(ByVal c As GLubyte Ptr, ByVal v As GLfloat Ptr)
Declare Sub glColor4ubVertex3fSUN(ByVal r As GLubyte, ByVal g As GLubyte, ByVal b As GLubyte, ByVal a As GLubyte, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glColor4ubVertex3fvSUN(ByVal c As GLubyte Ptr, ByVal v As GLfloat Ptr)
Declare Sub glColor3fVertex3fSUN(ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glColor3fVertex3fvSUN(ByVal c As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glNormal3fVertex3fSUN(ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glNormal3fVertex3fvSUN(ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glColor4fNormal3fVertex3fSUN(ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal a As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glColor4fNormal3fVertex3fvSUN(ByVal c As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glTexCoord2fVertex3fSUN(ByVal s As GLfloat, ByVal t As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glTexCoord2fVertex3fvSUN(ByVal tc As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glTexCoord4fVertex4fSUN(ByVal s As GLfloat, ByVal t As GLfloat, ByVal p As GLfloat, ByVal q As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glTexCoord4fVertex4fvSUN(ByVal tc As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glTexCoord2fColor4ubVertex3fSUN(ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLubyte, ByVal g As GLubyte, ByVal b As GLubyte, ByVal a As GLubyte, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glTexCoord2fColor4ubVertex3fvSUN(ByVal tc As GLfloat Ptr, ByVal c As GLubyte Ptr, ByVal v As GLfloat Ptr)
Declare Sub glTexCoord2fColor3fVertex3fSUN(ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glTexCoord2fColor3fVertex3fvSUN(ByVal tc As GLfloat Ptr, ByVal c As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glTexCoord2fNormal3fVertex3fSUN(ByVal s As GLfloat, ByVal t As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glTexCoord2fNormal3fVertex3fvSUN(ByVal tc As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glTexCoord2fColor4fNormal3fVertex3fSUN(ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal a As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glTexCoord2fColor4fNormal3fVertex3fvSUN(ByVal tc As GLfloat Ptr, ByVal c As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glTexCoord4fColor4fNormal3fVertex4fSUN(ByVal s As GLfloat, ByVal t As GLfloat, ByVal p As GLfloat, ByVal q As GLfloat, ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal a As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glTexCoord4fColor4fNormal3fVertex4fvSUN(ByVal tc As GLfloat Ptr, ByVal c As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glReplacementCodeuiVertex3fSUN(ByVal rc As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glReplacementCodeuiVertex3fvSUN(ByVal rc As GLuint Ptr, ByVal v As GLfloat Ptr)
Declare Sub glReplacementCodeuiColor4ubVertex3fSUN(ByVal rc As GLuint, ByVal r As GLubyte, ByVal g As GLubyte, ByVal b As GLubyte, ByVal a As GLubyte, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glReplacementCodeuiColor4ubVertex3fvSUN(ByVal rc As GLuint Ptr, ByVal c As GLubyte Ptr, ByVal v As GLfloat Ptr)
Declare Sub glReplacementCodeuiColor3fVertex3fSUN(ByVal rc As GLuint, ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glReplacementCodeuiColor3fVertex3fvSUN(ByVal rc As GLuint Ptr, ByVal c As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glReplacementCodeuiNormal3fVertex3fSUN(ByVal rc As GLuint, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glReplacementCodeuiNormal3fVertex3fvSUN(ByVal rc As GLuint Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glReplacementCodeuiColor4fNormal3fVertex3fSUN(ByVal rc As GLuint, ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal a As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glReplacementCodeuiColor4fNormal3fVertex3fvSUN(ByVal rc As GLuint Ptr, ByVal c As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glReplacementCodeuiTexCoord2fVertex3fSUN(ByVal rc As GLuint, ByVal s As GLfloat, ByVal t As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glReplacementCodeuiTexCoord2fVertex3fvSUN(ByVal rc As GLuint Ptr, ByVal tc As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN(ByVal rc As GLuint, ByVal s As GLfloat, ByVal t As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN(ByVal rc As GLuint Ptr, ByVal tc As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Declare Sub glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN(ByVal rc As GLuint, ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal a As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN(ByVal rc As GLuint Ptr, ByVal tc As GLfloat Ptr, ByVal c As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOLOR4UBVERTEX2FSUNPROC As Sub(ByVal r As GLubyte, ByVal g As GLubyte, ByVal b As GLubyte, ByVal a As GLubyte, ByVal x As GLfloat, ByVal y As GLfloat)
Type PFNGLCOLOR4UBVERTEX2FVSUNPROC As Sub(ByVal c As GLubyte Ptr, ByVal v As GLfloat Ptr)
Type PFNGLCOLOR4UBVERTEX3FSUNPROC As Sub(ByVal r As GLubyte, ByVal g As GLubyte, ByVal b As GLubyte, ByVal a As GLubyte, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLCOLOR4UBVERTEX3FVSUNPROC As Sub(ByVal c As GLubyte Ptr, ByVal v As GLfloat Ptr)
Type PFNGLCOLOR3FVERTEX3FSUNPROC As Sub(ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLCOLOR3FVERTEX3FVSUNPROC As Sub(ByVal c As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLNORMAL3FVERTEX3FSUNPROC As Sub(ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLNORMAL3FVERTEX3FVSUNPROC As Sub(ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLCOLOR4FNORMAL3FVERTEX3FSUNPROC As Sub(ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal a As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLCOLOR4FNORMAL3FVERTEX3FVSUNPROC As Sub(ByVal c As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLTEXCOORD2FVERTEX3FSUNPROC As Sub(ByVal s As GLfloat, ByVal t As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLTEXCOORD2FVERTEX3FVSUNPROC As Sub(ByVal tc As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLTEXCOORD4FVERTEX4FSUNPROC As Sub(ByVal s As GLfloat, ByVal t As GLfloat, ByVal p As GLfloat, ByVal q As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Type PFNGLTEXCOORD4FVERTEX4FVSUNPROC As Sub(ByVal tc As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLTEXCOORD2FCOLOR4UBVERTEX3FSUNPROC As Sub(ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLubyte, ByVal g As GLubyte, ByVal b As GLubyte, ByVal a As GLubyte, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLTEXCOORD2FCOLOR4UBVERTEX3FVSUNPROC As Sub(ByVal tc As GLfloat Ptr, ByVal c As GLubyte Ptr, ByVal v As GLfloat Ptr)
Type PFNGLTEXCOORD2FCOLOR3FVERTEX3FSUNPROC As Sub(ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLTEXCOORD2FCOLOR3FVERTEX3FVSUNPROC As Sub(ByVal tc As GLfloat Ptr, ByVal c As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLTEXCOORD2FNORMAL3FVERTEX3FSUNPROC As Sub(ByVal s As GLfloat, ByVal t As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLTEXCOORD2FNORMAL3FVERTEX3FVSUNPROC As Sub(ByVal tc As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLTEXCOORD2FCOLOR4FNORMAL3FVERTEX3FSUNPROC As Sub(ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal a As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLTEXCOORD2FCOLOR4FNORMAL3FVERTEX3FVSUNPROC As Sub(ByVal tc As GLfloat Ptr, ByVal c As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLTEXCOORD4FCOLOR4FNORMAL3FVERTEX4FSUNPROC As Sub(ByVal s As GLfloat, ByVal t As GLfloat, ByVal p As GLfloat, ByVal q As GLfloat, ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal a As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Type PFNGLTEXCOORD4FCOLOR4FNORMAL3FVERTEX4FVSUNPROC As Sub(ByVal tc As GLfloat Ptr, ByVal c As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLREPLACEMENTCODEUIVERTEX3FSUNPROC As Sub(ByVal rc As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLREPLACEMENTCODEUIVERTEX3FVSUNPROC As Sub(ByVal rc As GLuint Ptr, ByVal v As GLfloat Ptr)
Type PFNGLREPLACEMENTCODEUICOLOR4UBVERTEX3FSUNPROC As Sub(ByVal rc As GLuint, ByVal r As GLubyte, ByVal g As GLubyte, ByVal b As GLubyte, ByVal a As GLubyte, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLREPLACEMENTCODEUICOLOR4UBVERTEX3FVSUNPROC As Sub(ByVal rc As GLuint Ptr, ByVal c As GLubyte Ptr, ByVal v As GLfloat Ptr)
Type PFNGLREPLACEMENTCODEUICOLOR3FVERTEX3FSUNPROC As Sub(ByVal rc As GLuint, ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLREPLACEMENTCODEUICOLOR3FVERTEX3FVSUNPROC As Sub(ByVal rc As GLuint Ptr, ByVal c As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLREPLACEMENTCODEUINORMAL3FVERTEX3FSUNPROC As Sub(ByVal rc As GLuint, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLREPLACEMENTCODEUINORMAL3FVERTEX3FVSUNPROC As Sub(ByVal rc As GLuint Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLREPLACEMENTCODEUICOLOR4FNORMAL3FVERTEX3FSUNPROC As Sub(ByVal rc As GLuint, ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal a As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLREPLACEMENTCODEUICOLOR4FNORMAL3FVERTEX3FVSUNPROC As Sub(ByVal rc As GLuint Ptr, ByVal c As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLREPLACEMENTCODEUITEXCOORD2FVERTEX3FSUNPROC As Sub(ByVal rc As GLuint, ByVal s As GLfloat, ByVal t As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLREPLACEMENTCODEUITEXCOORD2FVERTEX3FVSUNPROC As Sub(ByVal rc As GLuint Ptr, ByVal tc As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLREPLACEMENTCODEUITEXCOORD2FNORMAL3FVERTEX3FSUNPROC As Sub(ByVal rc As GLuint, ByVal s As GLfloat, ByVal t As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLREPLACEMENTCODEUITEXCOORD2FNORMAL3FVERTEX3FVSUNPROC As Sub(ByVal rc As GLuint Ptr, ByVal tc As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
Type PFNGLREPLACEMENTCODEUITEXCOORD2FCOLOR4FNORMAL3FVERTEX3FSUNPROC As Sub(ByVal rc As GLuint, ByVal s As GLfloat, ByVal t As GLfloat, ByVal r As GLfloat, ByVal g As GLfloat, ByVal b As GLfloat, ByVal a As GLfloat, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLREPLACEMENTCODEUITEXCOORD2FCOLOR4FNORMAL3FVERTEX3FVSUNPROC As Sub(ByVal rc As GLuint Ptr, ByVal tc As GLfloat Ptr, ByVal c As GLfloat Ptr, ByVal n As GLfloat Ptr, ByVal v As GLfloat Ptr)
#EndIf

#Ifndef GL_EXT_blend_func_separate
#define GL_EXT_blend_func_separate 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBlendFuncSeparateEXT(ByVal sfactorRGB As GLenum, ByVal dfactorRGB As GLenum, ByVal sfactorAlpha As GLenum, ByVal dfactorAlpha As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBLENDFUNCSEPARATEEXTPROC As Sub(ByVal sfactorRGB As GLenum, ByVal dfactorRGB As GLenum, ByVal sfactorAlpha As GLenum, ByVal dfactorAlpha As GLenum)
#EndIf

#Ifndef GL_INGR_blend_func_separate
#define GL_INGR_blend_func_separate 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBlendFuncSeparateINGR(ByVal sfactorRGB As GLenum, ByVal dfactorRGB As GLenum, ByVal sfactorAlpha As GLenum, ByVal dfactorAlpha As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBLENDFUNCSEPARATEINGRPROC As Sub(ByVal sfactorRGB As GLenum, ByVal dfactorRGB As GLenum, ByVal sfactorAlpha As GLenum, ByVal dfactorAlpha As GLenum)
#EndIf

#Ifndef GL_INGR_color_clamp
#define GL_INGR_color_clamp 1
#EndIf

#Ifndef GL_INGR_interlace_read
#define GL_INGR_interlace_read 1
#EndIf

#Ifndef GL_EXT_stencil_wrap
#define GL_EXT_stencil_wrap 1
#EndIf

#Ifndef GL_EXT_422_pixels
#define GL_EXT_422_pixels 1
#EndIf

#Ifndef GL_NV_texgen_reflection
#define GL_NV_texgen_reflection 1
#EndIf

#Ifndef GL_SUN_convolution_border_modes
#define GL_SUN_convolution_border_modes 1
#EndIf

#Ifndef GL_EXT_texture_env_add
#define GL_EXT_texture_env_add 1
#EndIf

#Ifndef GL_EXT_texture_lod_bias
#define GL_EXT_texture_lod_bias 1
#EndIf

#Ifndef GL_EXT_texture_filter_anisotropic
#define GL_EXT_texture_filter_anisotropic 1
#EndIf

#Ifndef GL_EXT_vertex_weighting
#define GL_EXT_vertex_weighting 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexWeightfEXT(ByVal weight As GLfloat)
Declare Sub glVertexWeightfvEXT(ByVal weight As GLfloat Ptr)
Declare Sub glVertexWeightPointerEXT(ByVal size As GLsizei, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXWEIGHTFEXTPROC As Sub(ByVal weight As GLfloat)
Type PFNGLVERTEXWEIGHTFVEXTPROC As Sub(ByVal weight As GLfloat Ptr)
Type PFNGLVERTEXWEIGHTPOINTEREXTPROC As Sub(ByVal size As GLsizei, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf

#Ifndef GL_NV_light_max_exponent
#define GL_NV_light_max_exponent 1
#EndIf

#Ifndef GL_NV_vertex_array_range
#define GL_NV_vertex_array_range 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glFlushVertexArrayRangeNV()
Declare Sub glVertexArrayRangeNV(ByVal length As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLFLUSHVERTEXARRAYRANGENVPROC As Sub()
Type PFNGLVERTEXARRAYRANGENVPROC As Sub(ByVal length As GLsizei, ByVal Pointer As GLvoid Ptr)
#EndIf

#Ifndef GL_NV_register_combiners
#define GL_NV_register_combiners 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glCombinerParameterfvNV(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glCombinerParameterfNV(ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glCombinerParameterivNV(ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glCombinerParameteriNV(ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glCombinerInputNV(ByVal stage As GLenum, ByVal portion As GLenum, ByVal variable As GLenum, ByVal Input As GLenum, ByVal mapping As GLenum, ByVal componentUsage As GLenum)
Declare Sub glCombinerOutputNV(ByVal stage As GLenum, ByVal portion As GLenum, ByVal abOutput As GLenum, ByVal cdOutput As GLenum, ByVal sumOutput As GLenum, ByVal scale As GLenum, ByVal bias As GLenum, ByVal abDotProduct As GLboolean, ByVal cdDotProduct As GLboolean, ByVal muxSum As GLboolean)
Declare Sub glFinalCombinerInputNV(ByVal variable As GLenum, ByVal Input As GLenum, ByVal mapping As GLenum, ByVal componentUsage As GLenum)
Declare Sub glGetCombinerInputParameterfvNV(ByVal stage As GLenum, ByVal portion As GLenum, ByVal variable As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetCombinerInputParameterivNV(ByVal stage As GLenum, ByVal portion As GLenum, ByVal variable As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetCombinerOutputParameterfvNV(ByVal stage As GLenum, ByVal portion As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetCombinerOutputParameterivNV(ByVal stage As GLenum, ByVal portion As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetFinalCombinerInputParameterfvNV(ByVal variable As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetFinalCombinerInputParameterivNV(ByVal variable As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOMBINERPARAMETERFVNVPROC As Sub(ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLCOMBINERPARAMETERFNVPROC As Sub(ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLCOMBINERPARAMETERIVNVPROC As Sub(ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLCOMBINERPARAMETERINVPROC As Sub(ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLCOMBINERINPUTNVPROC As Sub(ByVal stage As GLenum, ByVal portion As GLenum, ByVal variable As GLenum, ByVal Input As GLenum, ByVal mapping As GLenum, ByVal componentUsage As GLenum)
Type PFNGLCOMBINEROUTPUTNVPROC As Sub(ByVal stage As GLenum, ByVal portion As GLenum, ByVal abOutput As GLenum, ByVal cdOutput As GLenum, ByVal sumOutput As GLenum, ByVal scale As GLenum, ByVal bias As GLenum, ByVal abDotProduct As GLboolean, ByVal cdDotProduct As GLboolean, ByVal muxSum As GLboolean)
Type PFNGLFINALCOMBINERINPUTNVPROC As Sub(ByVal variable As GLenum, ByVal Input As GLenum, ByVal mapping As GLenum, ByVal componentUsage As GLenum)
Type PFNGLGETCOMBINERINPUTPARAMETERFVNVPROC As Sub(ByVal stage As GLenum, ByVal portion As GLenum, ByVal variable As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETCOMBINERINPUTPARAMETERIVNVPROC As Sub(ByVal stage As GLenum, ByVal portion As GLenum, ByVal variable As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETCOMBINEROUTPUTPARAMETERFVNVPROC As Sub(ByVal stage As GLenum, ByVal portion As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETCOMBINEROUTPUTPARAMETERIVNVPROC As Sub(ByVal stage As GLenum, ByVal portion As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETFINALCOMBINERINPUTPARAMETERFVNVPROC As Sub(ByVal variable As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETFINALCOMBINERINPUTPARAMETERIVNVPROC As Sub(ByVal variable As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_NV_fog_distance
#define GL_NV_fog_distance 1
#EndIf

#Ifndef GL_NV_texgen_emboss
#define GL_NV_texgen_emboss 1
#EndIf

#Ifndef GL_NV_blend_square
#define GL_NV_blend_square 1
#EndIf

#Ifndef GL_NV_texture_env_combine4
#define GL_NV_texture_env_combine4 1
#EndIf

#Ifndef GL_MESA_resize_buffers
#define GL_MESA_resize_buffers 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glResizeBuffersMESA()
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLRESIZEBUFFERSMESAPROC As Sub()
#EndIf

#Ifndef GL_MESA_window_pos
#define GL_MESA_window_pos 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glWindowPos2dMESA(ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glWindowPos2dvMESA(ByVal v As GLdouble Ptr)
Declare Sub glWindowPos2fMESA(ByVal x As GLfloat, ByVal y As GLfloat)
Declare Sub glWindowPos2fvMESA(ByVal v As GLfloat Ptr)
Declare Sub glWindowPos2iMESA(ByVal x As GLint, ByVal y As GLint)
Declare Sub glWindowPos2ivMESA(ByVal v As GLint Ptr)
Declare Sub glWindowPos2sMESA(ByVal x As GLshort, ByVal y As GLshort)
Declare Sub glWindowPos2svMESA(ByVal v As GLshort Ptr)
Declare Sub glWindowPos3dMESA(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glWindowPos3dvMESA(ByVal v As GLdouble Ptr)
Declare Sub glWindowPos3fMESA(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glWindowPos3fvMESA(ByVal v As GLfloat Ptr)
Declare Sub glWindowPos3iMESA(ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Declare Sub glWindowPos3ivMESA(ByVal v As GLint Ptr)
Declare Sub glWindowPos3sMESA(ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Declare Sub glWindowPos3svMESA(ByVal v As GLshort Ptr)
Declare Sub glWindowPos4dMESA(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glWindowPos4dvMESA(ByVal v As GLdouble Ptr)
Declare Sub glWindowPos4fMESA(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glWindowPos4fvMESA(ByVal v As GLfloat Ptr)
Declare Sub glWindowPos4iMESA(ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Declare Sub glWindowPos4ivMESA(ByVal v As GLint Ptr)
Declare Sub glWindowPos4sMESA(ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort, ByVal w As GLshort)
Declare Sub glWindowPos4svMESA(ByVal v As GLshort Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLWINDOWPOS2DMESAPROC As Sub(ByVal x As GLdouble, ByVal y As GLdouble)
Type PFNGLWINDOWPOS2DVMESAPROC As Sub(ByVal v As GLdouble Ptr)
Type PFNGLWINDOWPOS2FMESAPROC As Sub(ByVal x As GLfloat, ByVal y As GLfloat)
Type PFNGLWINDOWPOS2FVMESAPROC As Sub(ByVal v As GLfloat Ptr)
Type PFNGLWINDOWPOS2IMESAPROC As Sub(ByVal x As GLint, ByVal y As GLint)
Type PFNGLWINDOWPOS2IVMESAPROC As Sub(ByVal v As GLint Ptr)
Type PFNGLWINDOWPOS2SMESAPROC As Sub(ByVal x As GLshort, ByVal y As GLshort)
Type PFNGLWINDOWPOS2SVMESAPROC As Sub(ByVal v As GLshort Ptr)
Type PFNGLWINDOWPOS3DMESAPROC As Sub(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLWINDOWPOS3DVMESAPROC As Sub(ByVal v As GLdouble Ptr)
Type PFNGLWINDOWPOS3FMESAPROC As Sub(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLWINDOWPOS3FVMESAPROC As Sub(ByVal v As GLfloat Ptr)
Type PFNGLWINDOWPOS3IMESAPROC As Sub(ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Type PFNGLWINDOWPOS3IVMESAPROC As Sub(ByVal v As GLint Ptr)
Type PFNGLWINDOWPOS3SMESAPROC As Sub(ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Type PFNGLWINDOWPOS3SVMESAPROC As Sub(ByVal v As GLshort Ptr)
Type PFNGLWINDOWPOS4DMESAPROC As Sub(ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLWINDOWPOS4DVMESAPROC As Sub(ByVal v As GLdouble Ptr)
Type PFNGLWINDOWPOS4FMESAPROC As Sub(ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Type PFNGLWINDOWPOS4FVMESAPROC As Sub(ByVal v As GLfloat Ptr)
Type PFNGLWINDOWPOS4IMESAPROC As Sub(ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Type PFNGLWINDOWPOS4IVMESAPROC As Sub(ByVal v As GLint Ptr)
Type PFNGLWINDOWPOS4SMESAPROC As Sub(ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort, ByVal w As GLshort)
Type PFNGLWINDOWPOS4SVMESAPROC As Sub(ByVal v As GLshort Ptr)
#EndIf

#Ifndef GL_IBM_cull_vertex
#define GL_IBM_cull_vertex 1
#EndIf

#Ifndef GL_IBM_multimode_draw_arrays
#define GL_IBM_multimode_draw_arrays 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glMultiModeDrawArraysIBM(ByVal mode As GLenum Ptr, ByVal first As GLint Ptr, ByVal count As GLsizei Ptr, ByVal primcount As GLsizei, ByVal modestride As GLint)
Declare Sub glMultiModeDrawElementsIBM(ByVal mode As GLenum Ptr, ByVal count As GLsizei Ptr, ByVal Type As GLenum, ByVal indices As GLvoid Ptr Ptr, ByVal primcount As GLsizei, ByVal modestride As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLMULTIMODEDRAWARRAYSIBMPROC As Sub(ByVal mode As GLenum Ptr, ByVal first As GLint Ptr, ByVal count As GLsizei Ptr, ByVal primcount As GLsizei, ByVal modestride As GLint)
Type PFNGLMULTIMODEDRAWELEMENTSIBMPROC As Sub(ByVal mode As GLenum Ptr, ByVal count As GLsizei Ptr, ByVal Type As GLenum, ByVal indices As GLvoid Ptr Ptr, ByVal primcount As GLsizei, ByVal modestride As GLint)
#EndIf

#Ifndef GL_IBM_vertex_array_lists
#define GL_IBM_vertex_array_lists 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glColorPointerListIBM(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
Declare Sub glSecondaryColorPointerListIBM(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
Declare Sub glEdgeFlagPointerListIBM(ByVal stride As GLint, ByVal Pointer As GLboolean Ptr Ptr, ByVal ptrstride As GLint)
Declare Sub glFogCoordPointerListIBM(ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
Declare Sub glIndexPointerListIBM(ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
Declare Sub glNormalPointerListIBM(ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
Declare Sub glTexCoordPointerListIBM(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
Declare Sub glVertexPointerListIBM(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOLORPOINTERLISTIBMPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
Type PFNGLSECONDARYCOLORPOINTERLISTIBMPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
Type PFNGLEDGEFLAGPOINTERLISTIBMPROC As Sub(ByVal stride As GLint, ByVal Pointer As GLboolean Ptr Ptr, ByVal ptrstride As GLint)
Type PFNGLFOGCOORDPOINTERLISTIBMPROC As Sub(ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
Type PFNGLINDEXPOINTERLISTIBMPROC As Sub(ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
Type PFNGLNORMALPOINTERLISTIBMPROC As Sub(ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
Type PFNGLTEXCOORDPOINTERLISTIBMPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
Type PFNGLVERTEXPOINTERLISTIBMPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLint, ByVal Pointer As GLvoid Ptr Ptr, ByVal ptrstride As GLint)
#EndIf

#Ifndef GL_SGIX_subsample
#define GL_SGIX_subsample 1
#EndIf

#Ifndef GL_SGIX_ycrcba
#define GL_SGIX_ycrcba 1
#EndIf

#Ifndef GL_SGIX_ycrcb_subsample
#define GL_SGIX_ycrcb_subsample 1
#EndIf

#Ifndef GL_SGIX_depth_pass_instrument
#define GL_SGIX_depth_pass_instrument 1
#EndIf

#Ifndef GL_3DFX_texture_compression_FXT1
#define GL_3DFX_texture_compression_FXT1 1
#EndIf

#Ifndef GL_3DFX_multisample
#define GL_3DFX_multisample 1
#EndIf

#Ifndef GL_3DFX_tbuffer
#define GL_3DFX_tbuffer 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTbufferMask3DFX(ByVal mask As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTBUFFERMASK3DFXPROC As Sub(ByVal mask As GLuint)
#EndIf

#Ifndef GL_EXT_multisample
#define GL_EXT_multisample 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glSampleMaskEXT(ByVal value As GLclampf, ByVal invert As GLboolean)
Declare Sub glSamplePatternEXT(ByVal pattern As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLSAMPLEMASKEXTPROC As Sub(ByVal value As GLclampf, ByVal invert As GLboolean)
Type PFNGLSAMPLEPATTERNEXTPROC As Sub(ByVal pattern As GLenum)
#EndIf

#Ifndef GL_SGIX_vertex_preclip
#define GL_SGIX_vertex_preclip 1
#EndIf

#Ifndef GL_SGIX_convolution_accuracy
#define GL_SGIX_convolution_accuracy 1
#EndIf

#Ifndef GL_SGIX_resample
#define GL_SGIX_resample 1
#EndIf

#Ifndef GL_SGIS_point_line_texgen
#define GL_SGIS_point_line_texgen 1
#EndIf

#Ifndef GL_SGIS_texture_color_mask
#define GL_SGIS_texture_color_mask 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTextureColorMaskSGIS(ByVal red As GLboolean, ByVal green As GLboolean, ByVal blue As GLboolean, ByVal Alpha As GLboolean)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXTURECOLORMASKSGISPROC As Sub(ByVal red As GLboolean, ByVal green As GLboolean, ByVal blue As GLboolean, ByVal Alpha As GLboolean)
#EndIf

#Ifndef GL_SGIX_igloo_interface
#define GL_SGIX_igloo_interface 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glIglooInterfaceSGIX(ByVal pname As GLenum, ByVal params As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLIGLOOINTERFACESGIXPROC As Sub(ByVal pname As GLenum, ByVal params As GLvoid Ptr)
#EndIf

#Ifndef GL_EXT_texture_env_dot3
#define GL_EXT_texture_env_dot3 1
#EndIf

#Ifndef GL_ATI_texture_mirror_once
#define GL_ATI_texture_mirror_once 1
#EndIf

#Ifndef GL_NV_fence
#define GL_NV_fence 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDeleteFencesNV(ByVal n As GLsizei, ByVal fences As GLuint Ptr)
Declare Sub glGenFencesNV(ByVal n As GLsizei, ByVal fences As GLuint Ptr)
Declare Function glIsFenceNV(ByVal fence As GLuint) As GLboolean
Declare Function glTestFenceNV(ByVal fence As GLuint) As GLboolean
Declare Sub glGetFenceivNV(ByVal fence As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glFinishFenceNV(ByVal fence As GLuint)
Declare Sub glSetFenceNV(ByVal fence As GLuint, ByVal condition As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDELETEFENCESNVPROC As Sub(ByVal n As GLsizei, ByVal fences As GLuint Ptr)
Type PFNGLGENFENCESNVPROC As Sub(ByVal n As GLsizei, ByVal fences As GLuint Ptr)
Type PFNGLISFENCENVPROC As Function(ByVal fence As GLuint) As GLboolean
Type PFNGLTESTFENCENVPROC As Function(ByVal fence As GLuint) As GLboolean
Type PFNGLGETFENCEIVNVPROC As Sub(ByVal fence As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLFINISHFENCENVPROC As Sub(ByVal fence As GLuint)
Type PFNGLSETFENCENVPROC As Sub(ByVal fence As GLuint, ByVal condition As GLenum)
#EndIf

#Ifndef GL_NV_evaluators
#define GL_NV_evaluators 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glMapControlPointsNV(ByVal target As GLenum, ByVal index As GLuint, ByVal Type As GLenum, ByVal ustride As GLsizei, ByVal vstride As GLsizei, ByVal uorder As GLint, ByVal vorder As GLint, ByVal packed As GLboolean, ByVal points As GLvoid Ptr)
Declare Sub glMapParameterivNV(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glMapParameterfvNV(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetMapControlPointsNV(ByVal target As GLenum, ByVal index As GLuint, ByVal Type As GLenum, ByVal ustride As GLsizei, ByVal vstride As GLsizei, ByVal packed As GLboolean, ByVal points As GLvoid Ptr)
Declare Sub glGetMapParameterivNV(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetMapParameterfvNV(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetMapAttribParameterivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetMapAttribParameterfvNV(ByVal target As GLenum, ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glEvalMapsNV(ByVal target As GLenum, ByVal mode As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLMAPCONTROLPOINTSNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal Type As GLenum, ByVal ustride As GLsizei, ByVal vstride As GLsizei, ByVal uorder As GLint, ByVal vorder As GLint, ByVal packed As GLboolean, ByVal points As GLvoid Ptr)
Type PFNGLMAPPARAMETERIVNVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLMAPPARAMETERFVNVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETMAPCONTROLPOINTSNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal Type As GLenum, ByVal ustride As GLsizei, ByVal vstride As GLsizei, ByVal packed As GLboolean, ByVal points As GLvoid Ptr)
Type PFNGLGETMAPPARAMETERIVNVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETMAPPARAMETERFVNVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETMAPATTRIBPARAMETERIVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETMAPATTRIBPARAMETERFVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLEVALMAPSNVPROC As Sub(ByVal target As GLenum, ByVal mode As GLenum)
#EndIf

#Ifndef GL_NV_packed_depth_stencil
#define GL_NV_packed_depth_stencil 1
#EndIf

#Ifndef GL_NV_register_combiners2
#define GL_NV_register_combiners2 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glCombinerStageParameterfvNV(ByVal stage As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetCombinerStageParameterfvNV(ByVal stage As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOMBINERSTAGEPARAMETERFVNVPROC As Sub(ByVal stage As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETCOMBINERSTAGEPARAMETERFVNVPROC As Sub(ByVal stage As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
#EndIf

#Ifndef GL_NV_texture_compression_vtc
#define GL_NV_texture_compression_vtc 1
#EndIf

#Ifndef GL_NV_texture_rectangle
#define GL_NV_texture_rectangle 1
#EndIf

#Ifndef GL_NV_texture_shader
#define GL_NV_texture_shader 1
#EndIf

#Ifndef GL_NV_texture_shader2
#define GL_NV_texture_shader2 1
#EndIf

#Ifndef GL_NV_vertex_array_range2
#define GL_NV_vertex_array_range2 1
#EndIf

#Ifndef GL_NV_vertex_program
#define GL_NV_vertex_program 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glAreProgramsResidentNV(ByVal n As GLsizei, ByVal programs As GLuint Ptr, ByVal residences As GLboolean Ptr) As GLboolean
Declare Sub glBindProgramNV(ByVal target As GLenum, ByVal id As GLuint)
Declare Sub glDeleteProgramsNV(ByVal n As GLsizei, ByVal programs As GLuint Ptr)
Declare Sub glExecuteProgramNV(ByVal target As GLenum, ByVal id As GLuint, ByVal params As GLfloat Ptr)
Declare Sub glGenProgramsNV(ByVal n As GLsizei, ByVal programs As GLuint Ptr)
Declare Sub glGetProgramParameterdvNV(ByVal target As GLenum, ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Declare Sub glGetProgramParameterfvNV(ByVal target As GLenum, ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetProgramivNV(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetProgramStringNV(ByVal id As GLuint, ByVal pname As GLenum, ByVal program As GLubyte Ptr)
Declare Sub glGetTrackMatrixivNV(ByVal target As GLenum, ByVal address As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetVertexAttribdvNV(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Declare Sub glGetVertexAttribfvNV(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetVertexAttribivNV(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetVertexAttribPointervNV(ByVal index As GLuint, ByVal pname As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
Declare Function glIsProgramNV(ByVal id As GLuint) As GLboolean
Declare Sub glLoadProgramNV(ByVal target As GLenum, ByVal id As GLuint, ByVal Len As GLsizei, ByVal program As GLubyte Ptr)
Declare Sub glProgramParameter4dNV(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glProgramParameter4dvNV(ByVal target As GLenum, ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glProgramParameter4fNV(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glProgramParameter4fvNV(ByVal target As GLenum, ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glProgramParameters4dvNV(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLdouble Ptr)
Declare Sub glProgramParameters4fvNV(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLfloat Ptr)
Declare Sub glRequestResidentProgramsNV(ByVal n As GLsizei, ByVal programs As GLuint Ptr)
Declare Sub glTrackMatrixNV(ByVal target As GLenum, ByVal address As GLuint, ByVal matrix As GLenum, ByVal transform As GLenum)
Declare Sub glVertexAttribPointerNV(ByVal index As GLuint, ByVal fsize As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glVertexAttrib1dNV(ByVal index As GLuint, ByVal x As GLdouble)
Declare Sub glVertexAttrib1dvNV(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttrib1fNV(ByVal index As GLuint, ByVal x As GLfloat)
Declare Sub glVertexAttrib1fvNV(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttrib1sNV(ByVal index As GLuint, ByVal x As GLshort)
Declare Sub glVertexAttrib1svNV(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib2dNV(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glVertexAttrib2dvNV(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttrib2fNV(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat)
Declare Sub glVertexAttrib2fvNV(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttrib2sNV(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort)
Declare Sub glVertexAttrib2svNV(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib3dNV(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glVertexAttrib3dvNV(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttrib3fNV(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glVertexAttrib3fvNV(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttrib3sNV(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Declare Sub glVertexAttrib3svNV(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib4dNV(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glVertexAttrib4dvNV(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttrib4fNV(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glVertexAttrib4fvNV(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttrib4sNV(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort, ByVal w As GLshort)
Declare Sub glVertexAttrib4svNV(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttrib4ubNV(ByVal index As GLuint, ByVal x As GLubyte, ByVal y As GLubyte, ByVal z As GLubyte, ByVal w As GLubyte)
Declare Sub glVertexAttrib4ubvNV(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Declare Sub glVertexAttribs1dvNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttribs1fvNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttribs1svNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLshort Ptr)
Declare Sub glVertexAttribs2dvNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttribs2fvNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttribs2svNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLshort Ptr)
Declare Sub glVertexAttribs3dvNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttribs3fvNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttribs3svNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLshort Ptr)
Declare Sub glVertexAttribs4dvNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttribs4fvNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLfloat Ptr)
Declare Sub glVertexAttribs4svNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLshort Ptr)
Declare Sub glVertexAttribs4ubvNV(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLubyte Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLAREPROGRAMSRESIDENTNVPROC As Function(ByVal n As GLsizei, ByVal programs As GLuint Ptr, ByVal residences As GLboolean Ptr) As GLboolean
Type PFNGLBINDPROGRAMNVPROC As Sub(ByVal target As GLenum, ByVal id As GLuint)
Type PFNGLDELETEPROGRAMSNVPROC As Sub(ByVal n As GLsizei, ByVal programs As GLuint Ptr)
Type PFNGLEXECUTEPROGRAMNVPROC As Sub(ByVal target As GLenum, ByVal id As GLuint, ByVal params As GLfloat Ptr)
Type PFNGLGENPROGRAMSNVPROC As Sub(ByVal n As GLsizei, ByVal programs As GLuint Ptr)
Type PFNGLGETPROGRAMPARAMETERDVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Type PFNGLGETPROGRAMPARAMETERFVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETPROGRAMIVNVPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETPROGRAMSTRINGNVPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal program As GLubyte Ptr)
Type PFNGLGETTRACKMATRIXIVNVPROC As Sub(ByVal target As GLenum, ByVal address As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETVERTEXATTRIBDVNVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Type PFNGLGETVERTEXATTRIBFVNVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETVERTEXATTRIBIVNVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETVERTEXATTRIBPOINTERVNVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal Pointer As GLvoid Ptr Ptr)
Type PFNGLISPROGRAMNVPROC As Function(ByVal id As GLuint) As GLboolean
Type PFNGLLOADPROGRAMNVPROC As Sub(ByVal target As GLenum, ByVal id As GLuint, ByVal Len As GLsizei, ByVal program As GLubyte Ptr)
Type PFNGLPROGRAMPARAMETER4DNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLPROGRAMPARAMETER4DVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLPROGRAMPARAMETER4FNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Type PFNGLPROGRAMPARAMETER4FVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLPROGRAMPARAMETERS4DVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLdouble Ptr)
Type PFNGLPROGRAMPARAMETERS4FVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLfloat Ptr)
Type PFNGLREQUESTRESIDENTPROGRAMSNVPROC As Sub(ByVal n As GLsizei, ByVal programs As GLuint Ptr)
Type PFNGLTRACKMATRIXNVPROC As Sub(ByVal target As GLenum, ByVal address As GLuint, ByVal matrix As GLenum, ByVal transform As GLenum)
Type PFNGLVERTEXATTRIBPOINTERNVPROC As Sub(ByVal index As GLuint, ByVal fsize As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLVERTEXATTRIB1DNVPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble)
Type PFNGLVERTEXATTRIB1DVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIB1FNVPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat)
Type PFNGLVERTEXATTRIB1FVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIB1SNVPROC As Sub(ByVal index As GLuint, ByVal x As GLshort)
Type PFNGLVERTEXATTRIB1SVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB2DNVPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble)
Type PFNGLVERTEXATTRIB2DVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIB2FNVPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat)
Type PFNGLVERTEXATTRIB2FVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIB2SNVPROC As Sub(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort)
Type PFNGLVERTEXATTRIB2SVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB3DNVPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLVERTEXATTRIB3DVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIB3FNVPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLVERTEXATTRIB3FVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIB3SNVPROC As Sub(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Type PFNGLVERTEXATTRIB3SVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB4DNVPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLVERTEXATTRIB4DVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIB4FNVPROC As Sub(ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Type PFNGLVERTEXATTRIB4FVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIB4SNVPROC As Sub(ByVal index As GLuint, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort, ByVal w As GLshort)
Type PFNGLVERTEXATTRIB4SVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIB4UBNVPROC As Sub(ByVal index As GLuint, ByVal x As GLubyte, ByVal y As GLubyte, ByVal z As GLubyte, ByVal w As GLubyte)
Type PFNGLVERTEXATTRIB4UBVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Type PFNGLVERTEXATTRIBS1DVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIBS1FVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIBS1SVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIBS2DVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIBS2FVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIBS2SVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIBS3DVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIBS3FVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIBS3SVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIBS4DVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIBS4FVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLfloat Ptr)
Type PFNGLVERTEXATTRIBS4SVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIBS4UBVNVPROC As Sub(ByVal index As GLuint, ByVal count As GLsizei, ByVal v As GLubyte Ptr)
#EndIf

#Ifndef GL_SGIX_texture_coordinate_clamp
#define GL_SGIX_texture_coordinate_clamp 1
#EndIf

#Ifndef GL_SGIX_scalebias_hint
#define GL_SGIX_scalebias_hint 1
#EndIf

#Ifndef GL_OML_interlace
#define GL_OML_interlace 1
#EndIf

#Ifndef GL_OML_subsample
#define GL_OML_subsample 1
#EndIf

#Ifndef GL_OML_resample
#define GL_OML_resample 1
#EndIf

#Ifndef GL_NV_copy_depth_to_color
#define GL_NV_copy_depth_to_color 1
#EndIf

#Ifndef GL_ATI_envmap_bumpmap
#define GL_ATI_envmap_bumpmap 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTexBumpParameterivATI(ByVal pname As GLenum, ByVal param As GLint Ptr)
Declare Sub glTexBumpParameterfvATI(ByVal pname As GLenum, ByVal param As GLfloat Ptr)
Declare Sub glGetTexBumpParameterivATI(ByVal pname As GLenum, ByVal param As GLint Ptr)
Declare Sub glGetTexBumpParameterfvATI(ByVal pname As GLenum, ByVal param As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXBUMPPARAMETERIVATIPROC As Sub(ByVal pname As GLenum, ByVal param As GLint Ptr)
Type PFNGLTEXBUMPPARAMETERFVATIPROC As Sub(ByVal pname As GLenum, ByVal param As GLfloat Ptr)
Type PFNGLGETTEXBUMPPARAMETERIVATIPROC As Sub(ByVal pname As GLenum, ByVal param As GLint Ptr)
Type PFNGLGETTEXBUMPPARAMETERFVATIPROC As Sub(ByVal pname As GLenum, ByVal param As GLfloat Ptr)
#EndIf

#Ifndef GL_ATI_fragment_shader
#define GL_ATI_fragment_shader 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glGenFragmentShadersATI(ByVal range As GLuint) As GLuint
Declare Sub glBindFragmentShaderATI(ByVal id As GLuint)
Declare Sub glDeleteFragmentShaderATI(ByVal id As GLuint)
Declare Sub glBeginFragmentShaderATI()
Declare Sub glEndFragmentShaderATI()
Declare Sub glPassTexCoordATI(ByVal dst As GLuint, ByVal coord As GLuint, ByVal swizzle As GLenum)
Declare Sub glSampleMapATI(ByVal dst As GLuint, ByVal interp As GLuint, ByVal swizzle As GLenum)
Declare Sub glColorFragmentOp1ATI(ByVal op As GLenum, ByVal dst As GLuint, ByVal dstMask As GLuint, ByVal dstMod As GLuint, ByVal arg1 As GLuint, ByVal arg1Rep As GLuint, ByVal arg1Mod As GLuint)
Declare Sub glColorFragmentOp2ATI(ByVal op As GLenum, ByVal dst As GLuint, ByVal dstMask As GLuint, ByVal dstMod As GLuint, ByVal arg1 As GLuint, ByVal arg1Rep As GLuint, ByVal arg1Mod As GLuint, ByVal arg2 As GLuint, ByVal arg2Rep As GLuint, ByVal arg2Mod As GLuint)
Declare Sub glColorFragmentOp3ATI(ByVal op As GLenum, ByVal dst As GLuint, ByVal dstMask As GLuint, ByVal dstMod As GLuint, ByVal arg1 As GLuint, ByVal arg1Rep As GLuint, ByVal arg1Mod As GLuint, ByVal arg2 As GLuint, ByVal arg2Rep As GLuint, ByVal arg2Mod As GLuint, ByVal arg3 As GLuint, ByVal arg3Rep As GLuint, ByVal arg3Mod As GLuint)
Declare Sub glAlphaFragmentOp1ATI(ByVal op As GLenum, ByVal dst As GLuint, ByVal dstMod As GLuint, ByVal arg1 As GLuint, ByVal arg1Rep As GLuint, ByVal arg1Mod As GLuint)
Declare Sub glAlphaFragmentOp2ATI(ByVal op As GLenum, ByVal dst As GLuint, ByVal dstMod As GLuint, ByVal arg1 As GLuint, ByVal arg1Rep As GLuint, ByVal arg1Mod As GLuint, ByVal arg2 As GLuint, ByVal arg2Rep As GLuint, ByVal arg2Mod As GLuint)
Declare Sub glAlphaFragmentOp3ATI(ByVal op As GLenum, ByVal dst As GLuint, ByVal dstMod As GLuint, ByVal arg1 As GLuint, ByVal arg1Rep As GLuint, ByVal arg1Mod As GLuint, ByVal arg2 As GLuint, ByVal arg2Rep As GLuint, ByVal arg2Mod As GLuint, ByVal arg3 As GLuint, ByVal arg3Rep As GLuint, ByVal arg3Mod As GLuint)
Declare Sub glSetFragmentShaderConstantATI(ByVal dst As GLuint, ByVal value As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGENFRAGMENTSHADERSATIPROC As Function(ByVal range As GLuint) As GLuint
Type PFNGLBINDFRAGMENTSHADERATIPROC As Sub(ByVal id As GLuint)
Type PFNGLDELETEFRAGMENTSHADERATIPROC As Sub(ByVal id As GLuint)
Type PFNGLBEGINFRAGMENTSHADERATIPROC As Sub()
Type PFNGLENDFRAGMENTSHADERATIPROC As Sub()
Type PFNGLPASSTEXCOORDATIPROC As Sub(ByVal dst As GLuint, ByVal coord As GLuint, ByVal swizzle As GLenum)
Type PFNGLSAMPLEMAPATIPROC As Sub(ByVal dst As GLuint, ByVal interp As GLuint, ByVal swizzle As GLenum)
Type PFNGLCOLORFRAGMENTOP1ATIPROC As Sub(ByVal op As GLenum, ByVal dst As GLuint, ByVal dstMask As GLuint, ByVal dstMod As GLuint, ByVal arg1 As GLuint, ByVal arg1Rep As GLuint, ByVal arg1Mod As GLuint)
Type PFNGLCOLORFRAGMENTOP2ATIPROC As Sub(ByVal op As GLenum, ByVal dst As GLuint, ByVal dstMask As GLuint, ByVal dstMod As GLuint, ByVal arg1 As GLuint, ByVal arg1Rep As GLuint, ByVal arg1Mod As GLuint, ByVal arg2 As GLuint, ByVal arg2Rep As GLuint, ByVal arg2Mod As GLuint)
Type PFNGLCOLORFRAGMENTOP3ATIPROC As Sub(ByVal op As GLenum, ByVal dst As GLuint, ByVal dstMask As GLuint, ByVal dstMod As GLuint, ByVal arg1 As GLuint, ByVal arg1Rep As GLuint, ByVal arg1Mod As GLuint, ByVal arg2 As GLuint, ByVal arg2Rep As GLuint, ByVal arg2Mod As GLuint, ByVal arg3 As GLuint, ByVal arg3Rep As GLuint, ByVal arg3Mod As GLuint)
Type PFNGLALPHAFRAGMENTOP1ATIPROC As Sub(ByVal op As GLenum, ByVal dst As GLuint, ByVal dstMod As GLuint, ByVal arg1 As GLuint, ByVal arg1Rep As GLuint, ByVal arg1Mod As GLuint)
Type PFNGLALPHAFRAGMENTOP2ATIPROC As Sub(ByVal op As GLenum, ByVal dst As GLuint, ByVal dstMod As GLuint, ByVal arg1 As GLuint, ByVal arg1Rep As GLuint, ByVal arg1Mod As GLuint, ByVal arg2 As GLuint, ByVal arg2Rep As GLuint, ByVal arg2Mod As GLuint)
Type PFNGLALPHAFRAGMENTOP3ATIPROC As Sub(ByVal op As GLenum, ByVal dst As GLuint, ByVal dstMod As GLuint, ByVal arg1 As GLuint, ByVal arg1Rep As GLuint, ByVal arg1Mod As GLuint, ByVal arg2 As GLuint, ByVal arg2Rep As GLuint, ByVal arg2Mod As GLuint, ByVal arg3 As GLuint, ByVal arg3Rep As GLuint, ByVal arg3Mod As GLuint)
Type PFNGLSETFRAGMENTSHADERCONSTANTATIPROC As Sub(ByVal dst As GLuint, ByVal value As GLfloat Ptr)
#EndIf

#Ifndef GL_ATI_pn_triangles
#define GL_ATI_pn_triangles 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPNTrianglesiATI(ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glPNTrianglesfATI(ByVal pname As GLenum, ByVal param As GLfloat)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPNTRIANGLESIATIPROC As Sub(ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLPNTRIANGLESFATIPROC As Sub(ByVal pname As GLenum, ByVal param As GLfloat)
#EndIf

#Ifndef GL_ATI_vertex_array_object
#define GL_ATI_vertex_array_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glNewObjectBufferATI(ByVal size As GLsizei, ByVal Pointer As GLvoid Ptr, ByVal usage As GLenum) As GLuint
Declare Function glIsObjectBufferATI(ByVal buffer As GLuint) As GLboolean
Declare Sub glUpdateObjectBufferATI(ByVal buffer As GLuint, ByVal offset As GLuint, ByVal size As GLsizei, ByVal Pointer As GLvoid Ptr, ByVal Preserve As GLenum)
Declare Sub glGetObjectBufferfvATI(ByVal buffer As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetObjectBufferivATI(ByVal buffer As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glFreeObjectBufferATI(ByVal buffer As GLuint)
Declare Sub glArrayObjectATI(ByVal array As GLenum, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal buffer As GLuint, ByVal offset As GLuint)
Declare Sub glGetArrayObjectfvATI(ByVal array As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetArrayObjectivATI(ByVal array As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glVariantArrayObjectATI(ByVal id As GLuint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal buffer As GLuint, ByVal offset As GLuint)
Declare Sub glGetVariantArrayObjectfvATI(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetVariantArrayObjectivATI(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLNEWOBJECTBUFFERATIPROC As Function(ByVal size As GLsizei, ByVal Pointer As GLvoid Ptr, ByVal usage As GLenum) As GLuint
Type PFNGLISOBJECTBUFFERATIPROC As Function(ByVal buffer As GLuint) As GLboolean
Type PFNGLUPDATEOBJECTBUFFERATIPROC As Sub(ByVal buffer As GLuint, ByVal offset As GLuint, ByVal size As GLsizei, ByVal Pointer As GLvoid Ptr, ByVal Preserve As GLenum)
Type PFNGLGETOBJECTBUFFERFVATIPROC As Sub(ByVal buffer As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETOBJECTBUFFERIVATIPROC As Sub(ByVal buffer As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLFREEOBJECTBUFFERATIPROC As Sub(ByVal buffer As GLuint)
Type PFNGLARRAYOBJECTATIPROC As Sub(ByVal array As GLenum, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal buffer As GLuint, ByVal offset As GLuint)
Type PFNGLGETARRAYOBJECTFVATIPROC As Sub(ByVal array As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETARRAYOBJECTIVATIPROC As Sub(ByVal array As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLVARIANTARRAYOBJECTATIPROC As Sub(ByVal id As GLuint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal buffer As GLuint, ByVal offset As GLuint)
Type PFNGLGETVARIANTARRAYOBJECTFVATIPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETVARIANTARRAYOBJECTIVATIPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_EXT_vertex_shader
#define GL_EXT_vertex_shader 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBeginVertexShaderEXT()
Declare Sub glEndVertexShaderEXT()
Declare Sub glBindVertexShaderEXT(ByVal id As GLuint)
Declare Function glGenVertexShadersEXT(ByVal range As GLuint) As GLuint
Declare Sub glDeleteVertexShaderEXT(ByVal id As GLuint)
Declare Sub glShaderOp1EXT(ByVal op As GLenum, ByVal res As GLuint, ByVal arg1 As GLuint)
Declare Sub glShaderOp2EXT(ByVal op As GLenum, ByVal res As GLuint, ByVal arg1 As GLuint, ByVal arg2 As GLuint)
Declare Sub glShaderOp3EXT(ByVal op As GLenum, ByVal res As GLuint, ByVal arg1 As GLuint, ByVal arg2 As GLuint, ByVal arg3 As GLuint)
Declare Sub glSwizzleEXT(ByVal res As GLuint, ByVal in As GLuint, ByVal outX As GLenum, ByVal outY As GLenum, ByVal outZ As GLenum, ByVal outW As GLenum)
Declare Sub glWriteMaskEXT(ByVal res As GLuint, ByVal in As GLuint, ByVal outX As GLenum, ByVal outY As GLenum, ByVal outZ As GLenum, ByVal outW As GLenum)
Declare Sub glInsertComponentEXT(ByVal res As GLuint, ByVal src As GLuint, ByVal num As GLuint)
Declare Sub glExtractComponentEXT(ByVal res As GLuint, ByVal src As GLuint, ByVal num As GLuint)
Declare Function glGenSymbolsEXT(ByVal datatype As GLenum, ByVal storagetype As GLenum, ByVal range As GLenum, ByVal components As GLuint) As GLuint
Declare Sub glSetInvariantEXT(ByVal id As GLuint, ByVal Type As GLenum, ByVal addr As GLvoid Ptr)
Declare Sub glSetLocalConstantEXT(ByVal id As GLuint, ByVal Type As GLenum, ByVal addr As GLvoid Ptr)
Declare Sub glVariantbvEXT(ByVal id As GLuint, ByVal addr As GLbyte Ptr)
Declare Sub glVariantsvEXT(ByVal id As GLuint, ByVal addr As GLshort Ptr)
Declare Sub glVariantivEXT(ByVal id As GLuint, ByVal addr As GLint Ptr)
Declare Sub glVariantfvEXT(ByVal id As GLuint, ByVal addr As GLfloat Ptr)
Declare Sub glVariantdvEXT(ByVal id As GLuint, ByVal addr As GLdouble Ptr)
Declare Sub glVariantubvEXT(ByVal id As GLuint, ByVal addr As GLubyte Ptr)
Declare Sub glVariantusvEXT(ByVal id As GLuint, ByVal addr As GLushort Ptr)
Declare Sub glVariantuivEXT(ByVal id As GLuint, ByVal addr As GLuint Ptr)
Declare Sub glVariantPointerEXT(ByVal id As GLuint, ByVal Type As GLenum, ByVal stride As GLuint, ByVal addr As GLvoid Ptr)
Declare Sub glEnableVariantClientStateEXT(ByVal id As GLuint)
Declare Sub glDisableVariantClientStateEXT(ByVal id As GLuint)
Declare Function glBindLightParameterEXT(ByVal light As GLenum, ByVal value As GLenum) As GLuint
Declare Function glBindMaterialParameterEXT(ByVal face As GLenum, ByVal value As GLenum) As GLuint
Declare Function glBindTexGenParameterEXT(ByVal unit As GLenum, ByVal coord As GLenum, ByVal value As GLenum) As GLuint
Declare Function glBindTextureUnitParameterEXT(ByVal unit As GLenum, ByVal value As GLenum) As GLuint
Declare Function glBindParameterEXT(ByVal value As GLenum) As GLuint
Declare Function glIsVariantEnabledEXT(ByVal id As GLuint, ByVal cap As GLenum) As GLboolean
Declare Sub glGetVariantBooleanvEXT(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLboolean Ptr)
Declare Sub glGetVariantIntegervEXT(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLint Ptr)
Declare Sub glGetVariantFloatvEXT(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLfloat Ptr)
Declare Sub glGetVariantPointervEXT(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLvoid Ptr Ptr)
Declare Sub glGetInvariantBooleanvEXT(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLboolean Ptr)
Declare Sub glGetInvariantIntegervEXT(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLint Ptr)
Declare Sub glGetInvariantFloatvEXT(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLfloat Ptr)
Declare Sub glGetLocalConstantBooleanvEXT(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLboolean Ptr)
Declare Sub glGetLocalConstantIntegervEXT(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLint Ptr)
Declare Sub glGetLocalConstantFloatvEXT(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBEGINVERTEXSHADEREXTPROC As Sub()
Type PFNGLENDVERTEXSHADEREXTPROC As Sub()
Type PFNGLBINDVERTEXSHADEREXTPROC As Sub(ByVal id As GLuint)
Type PFNGLGENVERTEXSHADERSEXTPROC As Function(ByVal range As GLuint) As GLuint
Type PFNGLDELETEVERTEXSHADEREXTPROC As Sub(ByVal id As GLuint)
Type PFNGLSHADEROP1EXTPROC As Sub(ByVal op As GLenum, ByVal res As GLuint, ByVal arg1 As GLuint)
Type PFNGLSHADEROP2EXTPROC As Sub(ByVal op As GLenum, ByVal res As GLuint, ByVal arg1 As GLuint, ByVal arg2 As GLuint)
Type PFNGLSHADEROP3EXTPROC As Sub(ByVal op As GLenum, ByVal res As GLuint, ByVal arg1 As GLuint, ByVal arg2 As GLuint, ByVal arg3 As GLuint)
Type PFNGLSWIZZLEEXTPROC As Sub(ByVal res As GLuint, ByVal in As GLuint, ByVal outX As GLenum, ByVal outY As GLenum, ByVal outZ As GLenum, ByVal outW As GLenum)
Type PFNGLWRITEMASKEXTPROC As Sub(ByVal res As GLuint, ByVal in As GLuint, ByVal outX As GLenum, ByVal outY As GLenum, ByVal outZ As GLenum, ByVal outW As GLenum)
Type PFNGLINSERTCOMPONENTEXTPROC As Sub(ByVal res As GLuint, ByVal src As GLuint, ByVal num As GLuint)
Type PFNGLEXTRACTCOMPONENTEXTPROC As Sub(ByVal res As GLuint, ByVal src As GLuint, ByVal num As GLuint)
Type PFNGLGENSYMBOLSEXTPROC As Function(ByVal datatype As GLenum, ByVal storagetype As GLenum, ByVal range As GLenum, ByVal components As GLuint) As GLuint
Type PFNGLSETINVARIANTEXTPROC As Sub(ByVal id As GLuint, ByVal Type As GLenum, ByVal addr As GLvoid Ptr)
Type PFNGLSETLOCALCONSTANTEXTPROC As Sub(ByVal id As GLuint, ByVal Type As GLenum, ByVal addr As GLvoid Ptr)
Type PFNGLVARIANTBVEXTPROC As Sub(ByVal id As GLuint, ByVal addr As GLbyte Ptr)
Type PFNGLVARIANTSVEXTPROC As Sub(ByVal id As GLuint, ByVal addr As GLshort Ptr)
Type PFNGLVARIANTIVEXTPROC As Sub(ByVal id As GLuint, ByVal addr As GLint Ptr)
Type PFNGLVARIANTFVEXTPROC As Sub(ByVal id As GLuint, ByVal addr As GLfloat Ptr)
Type PFNGLVARIANTDVEXTPROC As Sub(ByVal id As GLuint, ByVal addr As GLdouble Ptr)
Type PFNGLVARIANTUBVEXTPROC As Sub(ByVal id As GLuint, ByVal addr As GLubyte Ptr)
Type PFNGLVARIANTUSVEXTPROC As Sub(ByVal id As GLuint, ByVal addr As GLushort Ptr)
Type PFNGLVARIANTUIVEXTPROC As Sub(ByVal id As GLuint, ByVal addr As GLuint Ptr)
Type PFNGLVARIANTPOINTEREXTPROC As Sub(ByVal id As GLuint, ByVal Type As GLenum, ByVal stride As GLuint, ByVal addr As GLvoid Ptr)
Type PFNGLENABLEVARIANTCLIENTSTATEEXTPROC As Sub(ByVal id As GLuint)
Type PFNGLDISABLEVARIANTCLIENTSTATEEXTPROC As Sub(ByVal id As GLuint)
Type PFNGLBINDLIGHTPARAMETEREXTPROC As Function(ByVal light As GLenum, ByVal value As GLenum) As GLuint
Type PFNGLBINDMATERIALPARAMETEREXTPROC As Function(ByVal face As GLenum, ByVal value As GLenum) As GLuint
Type PFNGLBINDTEXGENPARAMETEREXTPROC As Function(ByVal unit As GLenum, ByVal coord As GLenum, ByVal value As GLenum) As GLuint
Type PFNGLBINDTEXTUREUNITPARAMETEREXTPROC As Function(ByVal unit As GLenum, ByVal value As GLenum) As GLuint
Type PFNGLBINDPARAMETEREXTPROC As Function(ByVal value As GLenum) As GLuint
Type PFNGLISVARIANTENABLEDEXTPROC As Function(ByVal id As GLuint, ByVal cap As GLenum) As GLboolean
Type PFNGLGETVARIANTBOOLEANVEXTPROC As Sub(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLboolean Ptr)
Type PFNGLGETVARIANTINTEGERVEXTPROC As Sub(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLint Ptr)
Type PFNGLGETVARIANTFLOATVEXTPROC As Sub(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLfloat Ptr)
Type PFNGLGETVARIANTPOINTERVEXTPROC As Sub(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLvoid Ptr Ptr)
Type PFNGLGETINVARIANTBOOLEANVEXTPROC As Sub(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLboolean Ptr)
Type PFNGLGETINVARIANTINTEGERVEXTPROC As Sub(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLint Ptr)
Type PFNGLGETINVARIANTFLOATVEXTPROC As Sub(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLfloat Ptr)
Type PFNGLGETLOCALCONSTANTBOOLEANVEXTPROC As Sub(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLboolean Ptr)
Type PFNGLGETLOCALCONSTANTINTEGERVEXTPROC As Sub(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLint Ptr)
Type PFNGLGETLOCALCONSTANTFLOATVEXTPROC As Sub(ByVal id As GLuint, ByVal value As GLenum, ByVal Data As GLfloat Ptr)
#EndIf

#Ifndef GL_ATI_vertex_streams
#define GL_ATI_vertex_streams 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexStream1sATI(ByVal stream As GLenum, ByVal x As GLshort)
Declare Sub glVertexStream1svATI(ByVal stream As GLenum, ByVal coords As GLshort Ptr)
Declare Sub glVertexStream1iATI(ByVal stream As GLenum, ByVal x As GLint)
Declare Sub glVertexStream1ivATI(ByVal stream As GLenum, ByVal coords As GLint Ptr)
Declare Sub glVertexStream1fATI(ByVal stream As GLenum, ByVal x As GLfloat)
Declare Sub glVertexStream1fvATI(ByVal stream As GLenum, ByVal coords As GLfloat Ptr)
Declare Sub glVertexStream1dATI(ByVal stream As GLenum, ByVal x As GLdouble)
Declare Sub glVertexStream1dvATI(ByVal stream As GLenum, ByVal coords As GLdouble Ptr)
Declare Sub glVertexStream2sATI(ByVal stream As GLenum, ByVal x As GLshort, ByVal y As GLshort)
Declare Sub glVertexStream2svATI(ByVal stream As GLenum, ByVal coords As GLshort Ptr)
Declare Sub glVertexStream2iATI(ByVal stream As GLenum, ByVal x As GLint, ByVal y As GLint)
Declare Sub glVertexStream2ivATI(ByVal stream As GLenum, ByVal coords As GLint Ptr)
Declare Sub glVertexStream2fATI(ByVal stream As GLenum, ByVal x As GLfloat, ByVal y As GLfloat)
Declare Sub glVertexStream2fvATI(ByVal stream As GLenum, ByVal coords As GLfloat Ptr)
Declare Sub glVertexStream2dATI(ByVal stream As GLenum, ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glVertexStream2dvATI(ByVal stream As GLenum, ByVal coords As GLdouble Ptr)
Declare Sub glVertexStream3sATI(ByVal stream As GLenum, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Declare Sub glVertexStream3svATI(ByVal stream As GLenum, ByVal coords As GLshort Ptr)
Declare Sub glVertexStream3iATI(ByVal stream As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Declare Sub glVertexStream3ivATI(ByVal stream As GLenum, ByVal coords As GLint Ptr)
Declare Sub glVertexStream3fATI(ByVal stream As GLenum, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glVertexStream3fvATI(ByVal stream As GLenum, ByVal coords As GLfloat Ptr)
Declare Sub glVertexStream3dATI(ByVal stream As GLenum, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glVertexStream3dvATI(ByVal stream As GLenum, ByVal coords As GLdouble Ptr)
Declare Sub glVertexStream4sATI(ByVal stream As GLenum, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort, ByVal w As GLshort)
Declare Sub glVertexStream4svATI(ByVal stream As GLenum, ByVal coords As GLshort Ptr)
Declare Sub glVertexStream4iATI(ByVal stream As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Declare Sub glVertexStream4ivATI(ByVal stream As GLenum, ByVal coords As GLint Ptr)
Declare Sub glVertexStream4fATI(ByVal stream As GLenum, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glVertexStream4fvATI(ByVal stream As GLenum, ByVal coords As GLfloat Ptr)
Declare Sub glVertexStream4dATI(ByVal stream As GLenum, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glVertexStream4dvATI(ByVal stream As GLenum, ByVal coords As GLdouble Ptr)
Declare Sub glNormalStream3bATI(ByVal stream As GLenum, ByVal nx As GLbyte, ByVal ny As GLbyte, ByVal nz As GLbyte)
Declare Sub glNormalStream3bvATI(ByVal stream As GLenum, ByVal coords As GLbyte Ptr)
Declare Sub glNormalStream3sATI(ByVal stream As GLenum, ByVal nx As GLshort, ByVal ny As GLshort, ByVal nz As GLshort)
Declare Sub glNormalStream3svATI(ByVal stream As GLenum, ByVal coords As GLshort Ptr)
Declare Sub glNormalStream3iATI(ByVal stream As GLenum, ByVal nx As GLint, ByVal ny As GLint, ByVal nz As GLint)
Declare Sub glNormalStream3ivATI(ByVal stream As GLenum, ByVal coords As GLint Ptr)
Declare Sub glNormalStream3fATI(ByVal stream As GLenum, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat)
Declare Sub glNormalStream3fvATI(ByVal stream As GLenum, ByVal coords As GLfloat Ptr)
Declare Sub glNormalStream3dATI(ByVal stream As GLenum, ByVal nx As GLdouble, ByVal ny As GLdouble, ByVal nz As GLdouble)
Declare Sub glNormalStream3dvATI(ByVal stream As GLenum, ByVal coords As GLdouble Ptr)
Declare Sub glClientActiveVertexStreamATI(ByVal stream As GLenum)
Declare Sub glVertexBlendEnviATI(ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glVertexBlendEnvfATI(ByVal pname As GLenum, ByVal param As GLfloat)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXSTREAM1SATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLshort)
Type PFNGLVERTEXSTREAM1SVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLshort Ptr)
Type PFNGLVERTEXSTREAM1IATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLint)
Type PFNGLVERTEXSTREAM1IVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLint Ptr)
Type PFNGLVERTEXSTREAM1FATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLfloat)
Type PFNGLVERTEXSTREAM1FVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLfloat Ptr)
Type PFNGLVERTEXSTREAM1DATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLdouble)
Type PFNGLVERTEXSTREAM1DVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLdouble Ptr)
Type PFNGLVERTEXSTREAM2SATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLshort, ByVal y As GLshort)
Type PFNGLVERTEXSTREAM2SVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLshort Ptr)
Type PFNGLVERTEXSTREAM2IATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLint, ByVal y As GLint)
Type PFNGLVERTEXSTREAM2IVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLint Ptr)
Type PFNGLVERTEXSTREAM2FATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLfloat, ByVal y As GLfloat)
Type PFNGLVERTEXSTREAM2FVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLfloat Ptr)
Type PFNGLVERTEXSTREAM2DATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLdouble, ByVal y As GLdouble)
Type PFNGLVERTEXSTREAM2DVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLdouble Ptr)
Type PFNGLVERTEXSTREAM3SATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort)
Type PFNGLVERTEXSTREAM3SVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLshort Ptr)
Type PFNGLVERTEXSTREAM3IATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Type PFNGLVERTEXSTREAM3IVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLint Ptr)
Type PFNGLVERTEXSTREAM3FATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLVERTEXSTREAM3FVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLfloat Ptr)
Type PFNGLVERTEXSTREAM3DATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLVERTEXSTREAM3DVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLdouble Ptr)
Type PFNGLVERTEXSTREAM4SATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLshort, ByVal y As GLshort, ByVal z As GLshort, ByVal w As GLshort)
Type PFNGLVERTEXSTREAM4SVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLshort Ptr)
Type PFNGLVERTEXSTREAM4IATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Type PFNGLVERTEXSTREAM4IVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLint Ptr)
Type PFNGLVERTEXSTREAM4FATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Type PFNGLVERTEXSTREAM4FVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLfloat Ptr)
Type PFNGLVERTEXSTREAM4DATIPROC As Sub(ByVal stream As GLenum, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLVERTEXSTREAM4DVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLdouble Ptr)
Type PFNGLNORMALSTREAM3BATIPROC As Sub(ByVal stream As GLenum, ByVal nx As GLbyte, ByVal ny As GLbyte, ByVal nz As GLbyte)
Type PFNGLNORMALSTREAM3BVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLbyte Ptr)
Type PFNGLNORMALSTREAM3SATIPROC As Sub(ByVal stream As GLenum, ByVal nx As GLshort, ByVal ny As GLshort, ByVal nz As GLshort)
Type PFNGLNORMALSTREAM3SVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLshort Ptr)
Type PFNGLNORMALSTREAM3IATIPROC As Sub(ByVal stream As GLenum, ByVal nx As GLint, ByVal ny As GLint, ByVal nz As GLint)
Type PFNGLNORMALSTREAM3IVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLint Ptr)
Type PFNGLNORMALSTREAM3FATIPROC As Sub(ByVal stream As GLenum, ByVal nx As GLfloat, ByVal ny As GLfloat, ByVal nz As GLfloat)
Type PFNGLNORMALSTREAM3FVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLfloat Ptr)
Type PFNGLNORMALSTREAM3DATIPROC As Sub(ByVal stream As GLenum, ByVal nx As GLdouble, ByVal ny As GLdouble, ByVal nz As GLdouble)
Type PFNGLNORMALSTREAM3DVATIPROC As Sub(ByVal stream As GLenum, ByVal coords As GLdouble Ptr)
Type PFNGLCLIENTACTIVEVERTEXSTREAMATIPROC As Sub(ByVal stream As GLenum)
Type PFNGLVERTEXBLENDENVIATIPROC As Sub(ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLVERTEXBLENDENVFATIPROC As Sub(ByVal pname As GLenum, ByVal param As GLfloat)
#EndIf

#Ifndef GL_ATI_element_array
#define GL_ATI_element_array 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glElementPointerATI(ByVal Type As GLenum, ByVal Pointer As GLvoid Ptr)
Declare Sub glDrawElementArrayATI(ByVal mode As GLenum, ByVal count As GLsizei)
Declare Sub glDrawRangeElementArrayATI(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal count As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLELEMENTPOINTERATIPROC As Sub(ByVal Type As GLenum, ByVal Pointer As GLvoid Ptr)
Type PFNGLDRAWELEMENTARRAYATIPROC As Sub(ByVal mode As GLenum, ByVal count As GLsizei)
Type PFNGLDRAWRANGEELEMENTARRAYATIPROC As Sub(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal count As GLsizei)
#EndIf

#Ifndef GL_SUN_mesh_array
#define GL_SUN_mesh_array 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDrawMeshArraysSUN(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei, ByVal Width As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDRAWMESHARRAYSSUNPROC As Sub(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei, ByVal Width As GLsizei)
#EndIf

#Ifndef GL_SUN_slice_accum
#define GL_SUN_slice_accum 1
#EndIf

#Ifndef GL_NV_multisample_filter_hint
#define GL_NV_multisample_filter_hint 1
#EndIf

#Ifndef GL_NV_depth_clamp
#define GL_NV_depth_clamp 1
#EndIf

#Ifndef GL_NV_occlusion_query
#define GL_NV_occlusion_query 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGenOcclusionQueriesNV(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Declare Sub glDeleteOcclusionQueriesNV(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Declare Function glIsOcclusionQueryNV(ByVal id As GLuint) As GLboolean
Declare Sub glBeginOcclusionQueryNV(ByVal id As GLuint)
Declare Sub glEndOcclusionQueryNV()
Declare Sub glGetOcclusionQueryivNV(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetOcclusionQueryuivNV(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGENOCCLUSIONQUERIESNVPROC As Sub(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Type PFNGLDELETEOCCLUSIONQUERIESNVPROC As Sub(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Type PFNGLISOCCLUSIONQUERYNVPROC As Function(ByVal id As GLuint) As GLboolean
Type PFNGLBEGINOCCLUSIONQUERYNVPROC As Sub(ByVal id As GLuint)
Type PFNGLENDOCCLUSIONQUERYNVPROC As Sub()
Type PFNGLGETOCCLUSIONQUERYIVNVPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETOCCLUSIONQUERYUIVNVPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
#EndIf

#Ifndef GL_NV_point_sprite
#define GL_NV_point_sprite 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPointParameteriNV(ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glPointParameterivNV(ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPOINTPARAMETERINVPROC As Sub(ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLPOINTPARAMETERIVNVPROC As Sub(ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_NV_texture_shader3
#define GL_NV_texture_shader3 1
#EndIf

#Ifndef GL_NV_vertex_program1_1
#define GL_NV_vertex_program1_1 1
#EndIf

#Ifndef GL_EXT_shadow_funcs
#define GL_EXT_shadow_funcs 1
#EndIf

#Ifndef GL_EXT_stencil_two_side
#define GL_EXT_stencil_two_side 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glActiveStencilFaceEXT(ByVal face As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLACTIVESTENCILFACEEXTPROC As Sub(ByVal face As GLenum)
#EndIf

#Ifndef GL_ATI_text_fragment_shader
#define GL_ATI_text_fragment_shader 1
#EndIf

#Ifndef GL_APPLE_client_storage
#define GL_APPLE_client_storage 1
#EndIf

#Ifndef GL_APPLE_element_array
#define GL_APPLE_element_array 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glElementPointerAPPLE(ByVal Type As GLenum, ByVal Pointer As GLvoid Ptr)
Declare Sub glDrawElementArrayAPPLE(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei)
Declare Sub glDrawRangeElementArrayAPPLE(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal first As GLint, ByVal count As GLsizei)
Declare Sub glMultiDrawElementArrayAPPLE(ByVal mode As GLenum, ByVal first As GLint Ptr, ByVal count As GLsizei Ptr, ByVal primcount As GLsizei)
Declare Sub glMultiDrawRangeElementArrayAPPLE(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal first As GLint Ptr, ByVal count As GLsizei Ptr, ByVal primcount As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLELEMENTPOINTERAPPLEPROC As Sub(ByVal Type As GLenum, ByVal Pointer As GLvoid Ptr)
Type PFNGLDRAWELEMENTARRAYAPPLEPROC As Sub(ByVal mode As GLenum, ByVal first As GLint, ByVal count As GLsizei)
Type PFNGLDRAWRANGEELEMENTARRAYAPPLEPROC As Sub(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal first As GLint, ByVal count As GLsizei)
Type PFNGLMULTIDRAWELEMENTARRAYAPPLEPROC As Sub(ByVal mode As GLenum, ByVal first As GLint Ptr, ByVal count As GLsizei Ptr, ByVal primcount As GLsizei)
Type PFNGLMULTIDRAWRANGEELEMENTARRAYAPPLEPROC As Sub(ByVal mode As GLenum, ByVal start As GLuint, ByVal End As GLuint, ByVal first As GLint Ptr, ByVal count As GLsizei Ptr, ByVal primcount As GLsizei)
#EndIf

#Ifndef GL_APPLE_fence
#define GL_APPLE_fence 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGenFencesAPPLE(ByVal n As GLsizei, ByVal fences As GLuint Ptr)
Declare Sub glDeleteFencesAPPLE(ByVal n As GLsizei, ByVal fences As GLuint Ptr)
Declare Sub glSetFenceAPPLE(ByVal fence As GLuint)
Declare Function glIsFenceAPPLE(ByVal fence As GLuint) As GLboolean
Declare Function glTestFenceAPPLE(ByVal fence As GLuint) As GLboolean
Declare Sub glFinishFenceAPPLE(ByVal fence As GLuint)
Declare Function glTestObjectAPPLE(ByVal object As GLenum, ByVal Name As GLuint) As GLboolean
Declare Sub glFinishObjectAPPLE(ByVal object As GLenum, ByVal Name As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGENFENCESAPPLEPROC As Sub(ByVal n As GLsizei, ByVal fences As GLuint Ptr)
Type PFNGLDELETEFENCESAPPLEPROC As Sub(ByVal n As GLsizei, ByVal fences As GLuint Ptr)
Type PFNGLSETFENCEAPPLEPROC As Sub(ByVal fence As GLuint)
Type PFNGLISFENCEAPPLEPROC As Function(ByVal fence As GLuint) As GLboolean
Type PFNGLTESTFENCEAPPLEPROC As Function(ByVal fence As GLuint) As GLboolean
Type PFNGLFINISHFENCEAPPLEPROC As Sub(ByVal fence As GLuint)
Type PFNGLTESTOBJECTAPPLEPROC As Function(ByVal object As GLenum, ByVal Name As GLuint) As GLboolean
Type PFNGLFINISHOBJECTAPPLEPROC As Sub(ByVal object As GLenum, ByVal Name As GLint)
#EndIf

#Ifndef GL_APPLE_vertex_array_object
#define GL_APPLE_vertex_array_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBindVertexArrayAPPLE(ByVal array As GLuint)
Declare Sub glDeleteVertexArraysAPPLE(ByVal n As GLsizei, ByVal arrays As GLuint Ptr)
Declare Sub glGenVertexArraysAPPLE(ByVal n As GLsizei, ByVal arrays As GLuint Ptr)
Declare Function glIsVertexArrayAPPLE(ByVal array As GLuint) As GLboolean
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBINDVERTEXARRAYAPPLEPROC As Sub(ByVal array As GLuint)
Type PFNGLDELETEVERTEXARRAYSAPPLEPROC As Sub(ByVal n As GLsizei, ByVal arrays As GLuint Ptr)
Type PFNGLGENVERTEXARRAYSAPPLEPROC As Sub(ByVal n As GLsizei, ByVal arrays As GLuint Ptr)
Type PFNGLISVERTEXARRAYAPPLEPROC As Function(ByVal array As GLuint) As GLboolean
#EndIf

#Ifndef GL_APPLE_vertex_array_range
#define GL_APPLE_vertex_array_range 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexArrayRangeAPPLE(ByVal length As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glFlushVertexArrayRangeAPPLE(ByVal length As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glVertexArrayParameteriAPPLE(ByVal pname As GLenum, ByVal param As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXARRAYRANGEAPPLEPROC As Sub(ByVal length As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLFLUSHVERTEXARRAYRANGEAPPLEPROC As Sub(ByVal length As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLVERTEXARRAYPARAMETERIAPPLEPROC As Sub(ByVal pname As GLenum, ByVal param As GLint)
#EndIf

#Ifndef GL_APPLE_ycbcr_422
#define GL_APPLE_ycbcr_422 1
#EndIf

#Ifndef GL_S3_s3tc
#define GL_S3_s3tc 1
#EndIf

#Ifndef GL_ATI_draw_buffers
#define GL_ATI_draw_buffers 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDrawBuffersATI(ByVal n As GLsizei, ByVal bufs As GLenum Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDRAWBUFFERSATIPROC As Sub(ByVal n As GLsizei, ByVal bufs As GLenum Ptr)
#EndIf

#Ifndef GL_ATI_pixel_format_float
#define GL_ATI_pixel_format_float 1
/' This is really a WGL extension, but defines some associated GL enums.
 * ATI does not export "GL_ATI_pixel_format_float" in the GL_EXTENSIONS string.
 '/
#EndIf

#Ifndef GL_ATI_texture_env_combine3
#define GL_ATI_texture_env_combine3 1
#EndIf

#Ifndef GL_ATI_texture_float
#define GL_ATI_texture_float 1
#EndIf

#Ifndef GL_NV_float_buffer
#define GL_NV_float_buffer 1
#EndIf

#Ifndef GL_NV_fragment_program
#define GL_NV_fragment_program 1
/' Some NV_fragment_program entry points are shared with ARB_vertex_program. '/
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glProgramNamedParameter4fNV(ByVal id As GLuint, ByVal Len As GLsizei, ByVal Name As GLubyte Ptr, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glProgramNamedParameter4dNV(ByVal id As GLuint, ByVal Len As GLsizei, ByVal Name As GLubyte Ptr, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glProgramNamedParameter4fvNV(ByVal id As GLuint, ByVal Len As GLsizei, ByVal Name As GLubyte Ptr, ByVal v As GLfloat Ptr)
Declare Sub glProgramNamedParameter4dvNV(ByVal id As GLuint, ByVal Len As GLsizei, ByVal Name As GLubyte Ptr, ByVal v As GLdouble Ptr)
Declare Sub glGetProgramNamedParameterfvNV(ByVal id As GLuint, ByVal Len As GLsizei, ByVal Name As GLubyte Ptr, ByVal params As GLfloat Ptr)
Declare Sub glGetProgramNamedParameterdvNV(ByVal id As GLuint, ByVal Len As GLsizei, ByVal Name As GLubyte Ptr, ByVal params As GLdouble Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPROGRAMNAMEDPARAMETER4FNVPROC As Sub(ByVal id As GLuint, ByVal Len As GLsizei, ByVal Name As GLubyte Ptr, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Type PFNGLPROGRAMNAMEDPARAMETER4DNVPROC As Sub(ByVal id As GLuint, ByVal Len As GLsizei, ByVal Name As GLubyte Ptr, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLPROGRAMNAMEDPARAMETER4FVNVPROC As Sub(ByVal id As GLuint, ByVal Len As GLsizei, ByVal Name As GLubyte Ptr, ByVal v As GLfloat Ptr)
Type PFNGLPROGRAMNAMEDPARAMETER4DVNVPROC As Sub(ByVal id As GLuint, ByVal Len As GLsizei, ByVal Name As GLubyte Ptr, ByVal v As GLdouble Ptr)
Type PFNGLGETPROGRAMNAMEDPARAMETERFVNVPROC As Sub(ByVal id As GLuint, ByVal Len As GLsizei, ByVal Name As GLubyte Ptr, ByVal params As GLfloat Ptr)
Type PFNGLGETPROGRAMNAMEDPARAMETERDVNVPROC As Sub(ByVal id As GLuint, ByVal Len As GLsizei, ByVal Name As GLubyte Ptr, ByVal params As GLdouble Ptr)
#EndIf

#Ifndef GL_NV_half_float
#define GL_NV_half_float 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertex2hNV(ByVal x As GLhalfNV, ByVal y As GLhalfNV)
Declare Sub glVertex2hvNV(ByVal v As GLhalfNV Ptr)
Declare Sub glVertex3hNV(ByVal x As GLhalfNV, ByVal y As GLhalfNV, ByVal z As GLhalfNV)
Declare Sub glVertex3hvNV(ByVal v As GLhalfNV Ptr)
Declare Sub glVertex4hNV(ByVal x As GLhalfNV, ByVal y As GLhalfNV, ByVal z As GLhalfNV, ByVal w As GLhalfNV)
Declare Sub glVertex4hvNV(ByVal v As GLhalfNV Ptr)
Declare Sub glNormal3hNV(ByVal nx As GLhalfNV, ByVal ny As GLhalfNV, ByVal nz As GLhalfNV)
Declare Sub glNormal3hvNV(ByVal v As GLhalfNV Ptr)
Declare Sub glColor3hNV(ByVal red As GLhalfNV, ByVal green As GLhalfNV, ByVal blue As GLhalfNV)
Declare Sub glColor3hvNV(ByVal v As GLhalfNV Ptr)
Declare Sub glColor4hNV(ByVal red As GLhalfNV, ByVal green As GLhalfNV, ByVal blue As GLhalfNV, ByVal Alpha As GLhalfNV)
Declare Sub glColor4hvNV(ByVal v As GLhalfNV Ptr)
Declare Sub glTexCoord1hNV(ByVal s As GLhalfNV)
Declare Sub glTexCoord1hvNV(ByVal v As GLhalfNV Ptr)
Declare Sub glTexCoord2hNV(ByVal s As GLhalfNV, ByVal t As GLhalfNV)
Declare Sub glTexCoord2hvNV(ByVal v As GLhalfNV Ptr)
Declare Sub glTexCoord3hNV(ByVal s As GLhalfNV, ByVal t As GLhalfNV, ByVal r As GLhalfNV)
Declare Sub glTexCoord3hvNV(ByVal v As GLhalfNV Ptr)
Declare Sub glTexCoord4hNV(ByVal s As GLhalfNV, ByVal t As GLhalfNV, ByVal r As GLhalfNV, ByVal q As GLhalfNV)
Declare Sub glTexCoord4hvNV(ByVal v As GLhalfNV Ptr)
Declare Sub glMultiTexCoord1hNV(ByVal target As GLenum, ByVal s As GLhalfNV)
Declare Sub glMultiTexCoord1hvNV(ByVal target As GLenum, ByVal v As GLhalfNV Ptr)
Declare Sub glMultiTexCoord2hNV(ByVal target As GLenum, ByVal s As GLhalfNV, ByVal t As GLhalfNV)
Declare Sub glMultiTexCoord2hvNV(ByVal target As GLenum, ByVal v As GLhalfNV Ptr)
Declare Sub glMultiTexCoord3hNV(ByVal target As GLenum, ByVal s As GLhalfNV, ByVal t As GLhalfNV, ByVal r As GLhalfNV)
Declare Sub glMultiTexCoord3hvNV(ByVal target As GLenum, ByVal v As GLhalfNV Ptr)
Declare Sub glMultiTexCoord4hNV(ByVal target As GLenum, ByVal s As GLhalfNV, ByVal t As GLhalfNV, ByVal r As GLhalfNV, ByVal q As GLhalfNV)
Declare Sub glMultiTexCoord4hvNV(ByVal target As GLenum, ByVal v As GLhalfNV Ptr)
Declare Sub glFogCoordhNV(ByVal fog As GLhalfNV)
Declare Sub glFogCoordhvNV(ByVal fog As GLhalfNV Ptr)
Declare Sub glSecondaryColor3hNV(ByVal red As GLhalfNV, ByVal green As GLhalfNV, ByVal blue As GLhalfNV)
Declare Sub glSecondaryColor3hvNV(ByVal v As GLhalfNV Ptr)
Declare Sub glVertexWeighthNV(ByVal weight As GLhalfNV)
Declare Sub glVertexWeighthvNV(ByVal weight As GLhalfNV Ptr)
Declare Sub glVertexAttrib1hNV(ByVal index As GLuint, ByVal x As GLhalfNV)
Declare Sub glVertexAttrib1hvNV(ByVal index As GLuint, ByVal v As GLhalfNV Ptr)
Declare Sub glVertexAttrib2hNV(ByVal index As GLuint, ByVal x As GLhalfNV, ByVal y As GLhalfNV)
Declare Sub glVertexAttrib2hvNV(ByVal index As GLuint, ByVal v As GLhalfNV Ptr)
Declare Sub glVertexAttrib3hNV(ByVal index As GLuint, ByVal x As GLhalfNV, ByVal y As GLhalfNV, ByVal z As GLhalfNV)
Declare Sub glVertexAttrib3hvNV(ByVal index As GLuint, ByVal v As GLhalfNV Ptr)
Declare Sub glVertexAttrib4hNV(ByVal index As GLuint, ByVal x As GLhalfNV, ByVal y As GLhalfNV, ByVal z As GLhalfNV, ByVal w As GLhalfNV)
Declare Sub glVertexAttrib4hvNV(ByVal index As GLuint, ByVal v As GLhalfNV Ptr)
Declare Sub glVertexAttribs1hvNV(ByVal index As GLuint, ByVal n As GLsizei, ByVal v As GLhalfNV Ptr)
Declare Sub glVertexAttribs2hvNV(ByVal index As GLuint, ByVal n As GLsizei, ByVal v As GLhalfNV Ptr)
Declare Sub glVertexAttribs3hvNV(ByVal index As GLuint, ByVal n As GLsizei, ByVal v As GLhalfNV Ptr)
Declare Sub glVertexAttribs4hvNV(ByVal index As GLuint, ByVal n As GLsizei, ByVal v As GLhalfNV Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEX2HNVPROC As Sub(ByVal x As GLhalfNV, ByVal y As GLhalfNV)
Type PFNGLVERTEX2HVNVPROC As Sub(ByVal v As GLhalfNV Ptr)
Type PFNGLVERTEX3HNVPROC As Sub(ByVal x As GLhalfNV, ByVal y As GLhalfNV, ByVal z As GLhalfNV)
Type PFNGLVERTEX3HVNVPROC As Sub(ByVal v As GLhalfNV Ptr)
Type PFNGLVERTEX4HNVPROC As Sub(ByVal x As GLhalfNV, ByVal y As GLhalfNV, ByVal z As GLhalfNV, ByVal w As GLhalfNV)
Type PFNGLVERTEX4HVNVPROC As Sub(ByVal v As GLhalfNV Ptr)
Type PFNGLNORMAL3HNVPROC As Sub(ByVal nx As GLhalfNV, ByVal ny As GLhalfNV, ByVal nz As GLhalfNV)
Type PFNGLNORMAL3HVNVPROC As Sub(ByVal v As GLhalfNV Ptr)
Type PFNGLCOLOR3HNVPROC As Sub(ByVal red As GLhalfNV, ByVal green As GLhalfNV, ByVal blue As GLhalfNV)
Type PFNGLCOLOR3HVNVPROC As Sub(ByVal v As GLhalfNV Ptr)
Type PFNGLCOLOR4HNVPROC As Sub(ByVal red As GLhalfNV, ByVal green As GLhalfNV, ByVal blue As GLhalfNV, ByVal Alpha As GLhalfNV)
Type PFNGLCOLOR4HVNVPROC As Sub(ByVal v As GLhalfNV Ptr)
Type PFNGLTEXCOORD1HNVPROC As Sub(ByVal s As GLhalfNV)
Type PFNGLTEXCOORD1HVNVPROC As Sub(ByVal v As GLhalfNV Ptr)
Type PFNGLTEXCOORD2HNVPROC As Sub(ByVal s As GLhalfNV, ByVal t As GLhalfNV)
Type PFNGLTEXCOORD2HVNVPROC As Sub(ByVal v As GLhalfNV Ptr)
Type PFNGLTEXCOORD3HNVPROC As Sub(ByVal s As GLhalfNV, ByVal t As GLhalfNV, ByVal r As GLhalfNV)
Type PFNGLTEXCOORD3HVNVPROC As Sub(ByVal v As GLhalfNV Ptr)
Type PFNGLTEXCOORD4HNVPROC As Sub(ByVal s As GLhalfNV, ByVal t As GLhalfNV, ByVal r As GLhalfNV, ByVal q As GLhalfNV)
Type PFNGLTEXCOORD4HVNVPROC As Sub(ByVal v As GLhalfNV Ptr)
Type PFNGLMULTITEXCOORD1HNVPROC As Sub(ByVal target As GLenum, ByVal s As GLhalfNV)
Type PFNGLMULTITEXCOORD1HVNVPROC As Sub(ByVal target As GLenum, ByVal v As GLhalfNV Ptr)
Type PFNGLMULTITEXCOORD2HNVPROC As Sub(ByVal target As GLenum, ByVal s As GLhalfNV, ByVal t As GLhalfNV)
Type PFNGLMULTITEXCOORD2HVNVPROC As Sub(ByVal target As GLenum, ByVal v As GLhalfNV Ptr)
Type PFNGLMULTITEXCOORD3HNVPROC As Sub(ByVal target As GLenum, ByVal s As GLhalfNV, ByVal t As GLhalfNV, ByVal r As GLhalfNV)
Type PFNGLMULTITEXCOORD3HVNVPROC As Sub(ByVal target As GLenum, ByVal v As GLhalfNV Ptr)
Type PFNGLMULTITEXCOORD4HNVPROC As Sub(ByVal target As GLenum, ByVal s As GLhalfNV, ByVal t As GLhalfNV, ByVal r As GLhalfNV, ByVal q As GLhalfNV)
Type PFNGLMULTITEXCOORD4HVNVPROC As Sub(ByVal target As GLenum, ByVal v As GLhalfNV Ptr)
Type PFNGLFOGCOORDHNVPROC As Sub(ByVal fog As GLhalfNV)
Type PFNGLFOGCOORDHVNVPROC As Sub(ByVal fog As GLhalfNV Ptr)
Type PFNGLSECONDARYCOLOR3HNVPROC As Sub(ByVal red As GLhalfNV, ByVal green As GLhalfNV, ByVal blue As GLhalfNV)
Type PFNGLSECONDARYCOLOR3HVNVPROC As Sub(ByVal v As GLhalfNV Ptr)
Type PFNGLVERTEXWEIGHTHNVPROC As Sub(ByVal weight As GLhalfNV)
Type PFNGLVERTEXWEIGHTHVNVPROC As Sub(ByVal weight As GLhalfNV Ptr)
Type PFNGLVERTEXATTRIB1HNVPROC As Sub(ByVal index As GLuint, ByVal x As GLhalfNV)
Type PFNGLVERTEXATTRIB1HVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLhalfNV Ptr)
Type PFNGLVERTEXATTRIB2HNVPROC As Sub(ByVal index As GLuint, ByVal x As GLhalfNV, ByVal y As GLhalfNV)
Type PFNGLVERTEXATTRIB2HVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLhalfNV Ptr)
Type PFNGLVERTEXATTRIB3HNVPROC As Sub(ByVal index As GLuint, ByVal x As GLhalfNV, ByVal y As GLhalfNV, ByVal z As GLhalfNV)
Type PFNGLVERTEXATTRIB3HVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLhalfNV Ptr)
Type PFNGLVERTEXATTRIB4HNVPROC As Sub(ByVal index As GLuint, ByVal x As GLhalfNV, ByVal y As GLhalfNV, ByVal z As GLhalfNV, ByVal w As GLhalfNV)
Type PFNGLVERTEXATTRIB4HVNVPROC As Sub(ByVal index As GLuint, ByVal v As GLhalfNV Ptr)
Type PFNGLVERTEXATTRIBS1HVNVPROC As Sub(ByVal index As GLuint, ByVal n As GLsizei, ByVal v As GLhalfNV Ptr)
Type PFNGLVERTEXATTRIBS2HVNVPROC As Sub(ByVal index As GLuint, ByVal n As GLsizei, ByVal v As GLhalfNV Ptr)
Type PFNGLVERTEXATTRIBS3HVNVPROC As Sub(ByVal index As GLuint, ByVal n As GLsizei, ByVal v As GLhalfNV Ptr)
Type PFNGLVERTEXATTRIBS4HVNVPROC As Sub(ByVal index As GLuint, ByVal n As GLsizei, ByVal v As GLhalfNV Ptr)
#EndIf

#Ifndef GL_NV_pixel_data_range
#define GL_NV_pixel_data_range 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPixelDataRangeNV(ByVal target As GLenum, ByVal length As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glFlushPixelDataRangeNV(ByVal target As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPIXELDATARANGENVPROC As Sub(ByVal target As GLenum, ByVal length As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLFLUSHPIXELDATARANGENVPROC As Sub(ByVal target As GLenum)
#EndIf

#Ifndef GL_NV_primitive_restart
#define GL_NV_primitive_restart 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPrimitiveRestartNV()
Declare Sub glPrimitiveRestartIndexNV(ByVal index As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPRIMITIVERESTARTNVPROC As Sub()
Type PFNGLPRIMITIVERESTARTINDEXNVPROC As Sub(ByVal index As GLuint)
#EndIf

#Ifndef GL_NV_texture_expand_normal
#define GL_NV_texture_expand_normal 1
#EndIf

#Ifndef GL_NV_vertex_program2
#define GL_NV_vertex_program2 1
#EndIf

#Ifndef GL_ATI_map_object_buffer
#define GL_ATI_map_object_buffer 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glMapObjectBufferATI(ByVal buffer As GLuint) As GLvoid Ptr
Declare Sub glUnmapObjectBufferATI(ByVal buffer As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLMAPOBJECTBUFFERATIPROC As Function(ByVal buffer As GLuint) As GLvoid Ptr
Type PFNGLUNMAPOBJECTBUFFERATIPROC As Sub(ByVal buffer As GLuint)
#EndIf

#Ifndef GL_ATI_separate_stencil
#define GL_ATI_separate_stencil 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glStencilOpSeparateATI(ByVal face As GLenum, ByVal sfail As GLenum, ByVal dpfail As GLenum, ByVal dppass As GLenum)
Declare Sub glStencilFuncSeparateATI(ByVal frontfunc As GLenum, ByVal backfunc As GLenum, ByVal ref As GLint, ByVal mask As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLSTENCILOPSEPARATEATIPROC As Sub(ByVal face As GLenum, ByVal sfail As GLenum, ByVal dpfail As GLenum, ByVal dppass As GLenum)
Type PFNGLSTENCILFUNCSEPARATEATIPROC As Sub(ByVal frontfunc As GLenum, ByVal backfunc As GLenum, ByVal ref As GLint, ByVal mask As GLuint)
#EndIf

#Ifndef GL_ATI_vertex_attrib_array_object
#define GL_ATI_vertex_attrib_array_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexAttribArrayObjectATI(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal stride As GLsizei, ByVal buffer As GLuint, ByVal offset As GLuint)
Declare Sub glGetVertexAttribArrayObjectfvATI(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetVertexAttribArrayObjectivATI(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXATTRIBARRAYOBJECTATIPROC As Sub(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal stride As GLsizei, ByVal buffer As GLuint, ByVal offset As GLuint)
Type PFNGLGETVERTEXATTRIBARRAYOBJECTFVATIPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETVERTEXATTRIBARRAYOBJECTIVATIPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_OES_read_format
#define GL_OES_read_format 1
#EndIf

#Ifndef GL_EXT_depth_bounds_test
#define GL_EXT_depth_bounds_test 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDepthBoundsEXT(ByVal zmin As GLclampd, ByVal zmax As GLclampd)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDEPTHBOUNDSEXTPROC As Sub(ByVal zmin As GLclampd, ByVal zmax As GLclampd)
#EndIf

#Ifndef GL_EXT_texture_mirror_clamp
#define GL_EXT_texture_mirror_clamp 1
#EndIf

#Ifndef GL_EXT_blend_equation_separate
#define GL_EXT_blend_equation_separate 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBlendEquationSeparateEXT(ByVal modeRGB As GLenum, ByVal modeAlpha As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBLENDEQUATIONSEPARATEEXTPROC As Sub(ByVal modeRGB As GLenum, ByVal modeAlpha As GLenum)
#EndIf

#Ifndef GL_MESA_pack_invert
#define GL_MESA_pack_invert 1
#EndIf

#Ifndef GL_MESA_ycbcr_texture
#define GL_MESA_ycbcr_texture 1
#EndIf

#Ifndef GL_EXT_pixel_buffer_object
#define GL_EXT_pixel_buffer_object 1
#EndIf

#Ifndef GL_NV_fragment_program_option
#define GL_NV_fragment_program_option 1
#EndIf

#Ifndef GL_NV_fragment_program2
#define GL_NV_fragment_program2 1
#EndIf

#Ifndef GL_NV_vertex_program2_option
#define GL_NV_vertex_program2_option 1
#EndIf

#Ifndef GL_NV_vertex_program3
#define GL_NV_vertex_program3 1
#EndIf

#Ifndef GL_EXT_framebuffer_object
#define GL_EXT_framebuffer_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glIsRenderbufferEXT(ByVal renderbuffer As GLuint) As GLboolean
Declare Sub glBindRenderbufferEXT(ByVal target As GLenum, ByVal renderbuffer As GLuint)
Declare Sub glDeleteRenderbuffersEXT(ByVal n As GLsizei, ByVal renderbuffers As GLuint Ptr)
Declare Sub glGenRenderbuffersEXT(ByVal n As GLsizei, ByVal renderbuffers As GLuint Ptr)
Declare Sub glRenderbufferStorageEXT(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glGetRenderbufferParameterivEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Function glIsFramebufferEXT(ByVal framebuffer As GLuint) As GLboolean
Declare Sub glBindFramebufferEXT(ByVal target As GLenum, ByVal framebuffer As GLuint)
Declare Sub glDeleteFramebuffersEXT(ByVal n As GLsizei, ByVal framebuffers As GLuint Ptr)
Declare Sub glGenFramebuffersEXT(ByVal n As GLsizei, ByVal framebuffers As GLuint Ptr)
Declare Function glCheckFramebufferStatusEXT(ByVal target As GLenum) As GLenum
Declare Sub glFramebufferTexture1DEXT(ByVal target As GLenum, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Declare Sub glFramebufferTexture2DEXT(ByVal target As GLenum, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Declare Sub glFramebufferTexture3DEXT(ByVal target As GLenum, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal zoffset As GLint)
Declare Sub glFramebufferRenderbufferEXT(ByVal target As GLenum, ByVal attachment As GLenum, ByVal renderbuffertarget As GLenum, ByVal renderbuffer As GLuint)
Declare Sub glGetFramebufferAttachmentParameterivEXT(ByVal target As GLenum, ByVal attachment As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGenerateMipmapEXT(ByVal target As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLISRENDERBUFFEREXTPROC As Function(ByVal renderbuffer As GLuint) As GLboolean
Type PFNGLBINDRENDERBUFFEREXTPROC As Sub(ByVal target As GLenum, ByVal renderbuffer As GLuint)
Type PFNGLDELETERENDERBUFFERSEXTPROC As Sub(ByVal n As GLsizei, ByVal renderbuffers As GLuint Ptr)
Type PFNGLGENRENDERBUFFERSEXTPROC As Sub(ByVal n As GLsizei, ByVal renderbuffers As GLuint Ptr)
Type PFNGLRENDERBUFFERSTORAGEEXTPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLGETRENDERBUFFERPARAMETERIVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLISFRAMEBUFFEREXTPROC As Function(ByVal framebuffer As GLuint) As GLboolean
Type PFNGLBINDFRAMEBUFFEREXTPROC As Sub(ByVal target As GLenum, ByVal framebuffer As GLuint)
Type PFNGLDELETEFRAMEBUFFERSEXTPROC As Sub(ByVal n As GLsizei, ByVal framebuffers As GLuint Ptr)
Type PFNGLGENFRAMEBUFFERSEXTPROC As Sub(ByVal n As GLsizei, ByVal framebuffers As GLuint Ptr)
Type PFNGLCHECKFRAMEBUFFERSTATUSEXTPROC As Function(ByVal target As GLenum) As GLenum
Type PFNGLFRAMEBUFFERTEXTURE1DEXTPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Type PFNGLFRAMEBUFFERTEXTURE2DEXTPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Type PFNGLFRAMEBUFFERTEXTURE3DEXTPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal zoffset As GLint)
Type PFNGLFRAMEBUFFERRENDERBUFFEREXTPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal renderbuffertarget As GLenum, ByVal renderbuffer As GLuint)
Type PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGENERATEMIPMAPEXTPROC As Sub(ByVal target As GLenum)
#EndIf

#Ifndef GL_GREMEDY_string_marker
#define GL_GREMEDY_string_marker 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glStringMarkerGREMEDY(ByVal Len As GLsizei, ByVal String As GLvoid Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLSTRINGMARKERGREMEDYPROC As Sub(ByVal Len As GLsizei, ByVal String As GLvoid Ptr)
#EndIf

#Ifndef GL_EXT_packed_depth_stencil
#define GL_EXT_packed_depth_stencil 1
#EndIf

#Ifndef GL_EXT_stencil_clear_tag
#define GL_EXT_stencil_clear_tag 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glStencilClearTagEXT(ByVal stencilTagBits As GLsizei, ByVal stencilClearTag As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLSTENCILCLEARTAGEXTPROC As Sub(ByVal stencilTagBits As GLsizei, ByVal stencilClearTag As GLuint)
#EndIf

#Ifndef GL_EXT_texture_sRGB
#define GL_EXT_texture_sRGB 1
#EndIf

#Ifndef GL_EXT_framebuffer_blit
#define GL_EXT_framebuffer_blit 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBlitFramebufferEXT(ByVal srcX0 As GLint, ByVal srcY0 As GLint, ByVal srcX1 As GLint, ByVal srcY1 As GLint, ByVal dstX0 As GLint, ByVal dstY0 As GLint, ByVal dstX1 As GLint, ByVal dstY1 As GLint, ByVal mask As GLbitfield, ByVal filter As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBLITFRAMEBUFFEREXTPROC As Sub(ByVal srcX0 As GLint, ByVal srcY0 As GLint, ByVal srcX1 As GLint, ByVal srcY1 As GLint, ByVal dstX0 As GLint, ByVal dstY0 As GLint, ByVal dstX1 As GLint, ByVal dstY1 As GLint, ByVal mask As GLbitfield, ByVal filter As GLenum)
#EndIf

#Ifndef GL_EXT_framebuffer_multisample
#define GL_EXT_framebuffer_multisample 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glRenderbufferStorageMultisampleEXT(ByVal target As GLenum, ByVal samples As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC As Sub(ByVal target As GLenum, ByVal samples As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
#EndIf

#Ifndef GL_MESAX_texture_stack
#define GL_MESAX_texture_stack 1
#EndIf

#Ifndef GL_EXT_timer_query
#define GL_EXT_timer_query 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGetQueryObjecti64vEXT(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint64EXT Ptr)
Declare Sub glGetQueryObjectui64vEXT(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLuint64EXT Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETQUERYOBJECTI64VEXTPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLint64EXT Ptr)
Type PFNGLGETQUERYOBJECTUI64VEXTPROC As Sub(ByVal id As GLuint, ByVal pname As GLenum, ByVal params As GLuint64EXT Ptr)
#EndIf

#Ifndef GL_EXT_gpu_program_parameters
#define GL_EXT_gpu_program_parameters 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glProgramEnvParameters4fvEXT(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLfloat Ptr)
Declare Sub glProgramLocalParameters4fvEXT(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPROGRAMENVPARAMETERS4FVEXTPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLfloat Ptr)
Type PFNGLPROGRAMLOCALPARAMETERS4FVEXTPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLfloat Ptr)
#EndIf

#Ifndef GL_APPLE_flush_buffer_range
#define GL_APPLE_flush_buffer_range 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBufferParameteriAPPLE(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glFlushMappedBufferRangeAPPLE(ByVal target As GLenum, ByVal offset As GLintptr, ByVal size As GLsizeiptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBUFFERPARAMETERIAPPLEPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLFLUSHMAPPEDBUFFERRANGEAPPLEPROC As Sub(ByVal target As GLenum, ByVal offset As GLintptr, ByVal size As GLsizeiptr)
#EndIf

#Ifndef GL_NV_gpu_program4
#define GL_NV_gpu_program4 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glProgramLocalParameterI4iNV(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Declare Sub glProgramLocalParameterI4ivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLint Ptr)
Declare Sub glProgramLocalParametersI4ivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLint Ptr)
Declare Sub glProgramLocalParameterI4uiNV(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint, ByVal w As GLuint)
Declare Sub glProgramLocalParameterI4uivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLuint Ptr)
Declare Sub glProgramLocalParametersI4uivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLuint Ptr)
Declare Sub glProgramEnvParameterI4iNV(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Declare Sub glProgramEnvParameterI4ivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLint Ptr)
Declare Sub glProgramEnvParametersI4ivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLint Ptr)
Declare Sub glProgramEnvParameterI4uiNV(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint, ByVal w As GLuint)
Declare Sub glProgramEnvParameterI4uivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLuint Ptr)
Declare Sub glProgramEnvParametersI4uivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLuint Ptr)
Declare Sub glGetProgramLocalParameterIivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLint Ptr)
Declare Sub glGetProgramLocalParameterIuivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLuint Ptr)
Declare Sub glGetProgramEnvParameterIivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLint Ptr)
Declare Sub glGetProgramEnvParameterIuivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLuint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPROGRAMLOCALPARAMETERI4INVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Type PFNGLPROGRAMLOCALPARAMETERI4IVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLint Ptr)
Type PFNGLPROGRAMLOCALPARAMETERSI4IVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLint Ptr)
Type PFNGLPROGRAMLOCALPARAMETERI4UINVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint, ByVal w As GLuint)
Type PFNGLPROGRAMLOCALPARAMETERI4UIVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLuint Ptr)
Type PFNGLPROGRAMLOCALPARAMETERSI4UIVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLuint Ptr)
Type PFNGLPROGRAMENVPARAMETERI4INVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Type PFNGLPROGRAMENVPARAMETERI4IVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLint Ptr)
Type PFNGLPROGRAMENVPARAMETERSI4IVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLint Ptr)
Type PFNGLPROGRAMENVPARAMETERI4UINVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint, ByVal w As GLuint)
Type PFNGLPROGRAMENVPARAMETERI4UIVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLuint Ptr)
Type PFNGLPROGRAMENVPARAMETERSI4UIVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLuint Ptr)
Type PFNGLGETPROGRAMLOCALPARAMETERIIVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLint Ptr)
Type PFNGLGETPROGRAMLOCALPARAMETERIUIVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLuint Ptr)
Type PFNGLGETPROGRAMENVPARAMETERIIVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLint Ptr)
Type PFNGLGETPROGRAMENVPARAMETERIUIVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLuint Ptr)
#EndIf

#Ifndef GL_NV_geometry_program4
#define GL_NV_geometry_program4 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glProgramVertexLimitNV(ByVal target As GLenum, ByVal limit As GLint)
Declare Sub glFramebufferTextureEXT(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Declare Sub glFramebufferTextureLayerEXT(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal layer As GLint)
Declare Sub glFramebufferTextureFaceEXT(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal face As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPROGRAMVERTEXLIMITNVPROC As Sub(ByVal target As GLenum, ByVal limit As GLint)
Type PFNGLFRAMEBUFFERTEXTUREEXTPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Type PFNGLFRAMEBUFFERTEXTURELAYEREXTPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal layer As GLint)
Type PFNGLFRAMEBUFFERTEXTUREFACEEXTPROC As Sub(ByVal target As GLenum, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal face As GLenum)
#EndIf

#Ifndef GL_EXT_geometry_shader4
#define GL_EXT_geometry_shader4 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glProgramParameteriEXT(ByVal program As GLuint, ByVal pname As GLenum, ByVal value As GLint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPROGRAMPARAMETERIEXTPROC As Sub(ByVal program As GLuint, ByVal pname As GLenum, ByVal value As GLint)
#EndIf

#Ifndef GL_NV_vertex_program4
#define GL_NV_vertex_program4 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexAttribI1iEXT(ByVal index As GLuint, ByVal x As GLint)
Declare Sub glVertexAttribI2iEXT(ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint)
Declare Sub glVertexAttribI3iEXT(ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Declare Sub glVertexAttribI4iEXT(ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Declare Sub glVertexAttribI1uiEXT(ByVal index As GLuint, ByVal x As GLuint)
Declare Sub glVertexAttribI2uiEXT(ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint)
Declare Sub glVertexAttribI3uiEXT(ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint)
Declare Sub glVertexAttribI4uiEXT(ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint, ByVal w As GLuint)
Declare Sub glVertexAttribI1ivEXT(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glVertexAttribI2ivEXT(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glVertexAttribI3ivEXT(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glVertexAttribI4ivEXT(ByVal index As GLuint, ByVal v As GLint Ptr)
Declare Sub glVertexAttribI1uivEXT(ByVal index As GLuint, ByVal v As GLuint Ptr)
Declare Sub glVertexAttribI2uivEXT(ByVal index As GLuint, ByVal v As GLuint Ptr)
Declare Sub glVertexAttribI3uivEXT(ByVal index As GLuint, ByVal v As GLuint Ptr)
Declare Sub glVertexAttribI4uivEXT(ByVal index As GLuint, ByVal v As GLuint Ptr)
Declare Sub glVertexAttribI4bvEXT(ByVal index As GLuint, ByVal v As GLbyte Ptr)
Declare Sub glVertexAttribI4svEXT(ByVal index As GLuint, ByVal v As GLshort Ptr)
Declare Sub glVertexAttribI4ubvEXT(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Declare Sub glVertexAttribI4usvEXT(ByVal index As GLuint, ByVal v As GLushort Ptr)
Declare Sub glVertexAttribIPointerEXT(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glGetVertexAttribIivEXT(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetVertexAttribIuivEXT(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXATTRIBI1IEXTPROC As Sub(ByVal index As GLuint, ByVal x As GLint)
Type PFNGLVERTEXATTRIBI2IEXTPROC As Sub(ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint)
Type PFNGLVERTEXATTRIBI3IEXTPROC As Sub(ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint)
Type PFNGLVERTEXATTRIBI4IEXTPROC As Sub(ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Type PFNGLVERTEXATTRIBI1UIEXTPROC As Sub(ByVal index As GLuint, ByVal x As GLuint)
Type PFNGLVERTEXATTRIBI2UIEXTPROC As Sub(ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint)
Type PFNGLVERTEXATTRIBI3UIEXTPROC As Sub(ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint)
Type PFNGLVERTEXATTRIBI4UIEXTPROC As Sub(ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint, ByVal w As GLuint)
Type PFNGLVERTEXATTRIBI1IVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLVERTEXATTRIBI2IVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLVERTEXATTRIBI3IVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLVERTEXATTRIBI4IVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLint Ptr)
Type PFNGLVERTEXATTRIBI1UIVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLuint Ptr)
Type PFNGLVERTEXATTRIBI2UIVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLuint Ptr)
Type PFNGLVERTEXATTRIBI3UIVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLuint Ptr)
Type PFNGLVERTEXATTRIBI4UIVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLuint Ptr)
Type PFNGLVERTEXATTRIBI4BVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLbyte Ptr)
Type PFNGLVERTEXATTRIBI4SVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLshort Ptr)
Type PFNGLVERTEXATTRIBI4UBVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLubyte Ptr)
Type PFNGLVERTEXATTRIBI4USVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLushort Ptr)
Type PFNGLVERTEXATTRIBIPOINTEREXTPROC As Sub(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLGETVERTEXATTRIBIIVEXTPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETVERTEXATTRIBIUIVEXTPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
#EndIf

#Ifndef GL_EXT_gpu_shader4
#define GL_EXT_gpu_shader4 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGetUniformuivEXT(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLuint Ptr)
Declare Sub glBindFragDataLocationEXT(ByVal program As GLuint, ByVal Color As GLuint, ByVal Name As GLchar Ptr)
Declare Function glGetFragDataLocationEXT(ByVal program As GLuint, ByVal Name As GLchar Ptr) As GLint
Declare Sub glUniform1uiEXT(ByVal location As GLint, ByVal v0 As GLuint)
Declare Sub glUniform2uiEXT(ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint)
Declare Sub glUniform3uiEXT(ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint)
Declare Sub glUniform4uiEXT(ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint, ByVal v3 As GLuint)
Declare Sub glUniform1uivEXT(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glUniform2uivEXT(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glUniform3uivEXT(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glUniform4uivEXT(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETUNIFORMUIVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLuint Ptr)
Type PFNGLBINDFRAGDATALOCATIONEXTPROC As Sub(ByVal program As GLuint, ByVal Color As GLuint, ByVal Name As GLchar Ptr)
Type PFNGLGETFRAGDATALOCATIONEXTPROC As Function(ByVal program As GLuint, ByVal Name As GLchar Ptr) As GLint
Type PFNGLUNIFORM1UIEXTPROC As Sub(ByVal location As GLint, ByVal v0 As GLuint)
Type PFNGLUNIFORM2UIEXTPROC As Sub(ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint)
Type PFNGLUNIFORM3UIEXTPROC As Sub(ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint)
Type PFNGLUNIFORM4UIEXTPROC As Sub(ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint, ByVal v3 As GLuint)
Type PFNGLUNIFORM1UIVEXTPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLUNIFORM2UIVEXTPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLUNIFORM3UIVEXTPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLUNIFORM4UIVEXTPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
#EndIf

#Ifndef GL_EXT_draw_instanced
#define GL_EXT_draw_instanced 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDrawArraysInstancedEXT(ByVal mode As GLenum, ByVal start As GLint, ByVal count As GLsizei, ByVal primcount As GLsizei)
Declare Sub glDrawElementsInstancedEXT(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr, ByVal primcount As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDRAWARRAYSINSTANCEDEXTPROC As Sub(ByVal mode As GLenum, ByVal start As GLint, ByVal count As GLsizei, ByVal primcount As GLsizei)
Type PFNGLDRAWELEMENTSINSTANCEDEXTPROC As Sub(ByVal mode As GLenum, ByVal count As GLsizei, ByVal Type As GLenum, ByVal indices As GLvoid Ptr, ByVal primcount As GLsizei)
#EndIf

#Ifndef GL_EXT_packed_float
#define GL_EXT_packed_float 1
#EndIf

#Ifndef GL_EXT_texture_array
#define GL_EXT_texture_array 1
#EndIf

#Ifndef GL_EXT_texture_buffer_object
#define GL_EXT_texture_buffer_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTexBufferEXT(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal buffer As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXBUFFEREXTPROC As Sub(ByVal target As GLenum, ByVal internalformat As GLenum, ByVal buffer As GLuint)
#EndIf

#Ifndef GL_EXT_texture_compression_latc
#define GL_EXT_texture_compression_latc 1
#EndIf

#Ifndef GL_EXT_texture_compression_rgtc
#define GL_EXT_texture_compression_rgtc 1
#EndIf

#Ifndef GL_EXT_texture_shared_exponent
#define GL_EXT_texture_shared_exponent 1
#EndIf

#Ifndef GL_NV_depth_buffer_float
#define GL_NV_depth_buffer_float 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDepthRangedNV(ByVal zNear As GLdouble, ByVal zFar As GLdouble)
Declare Sub glClearDepthdNV(ByVal depth As GLdouble)
Declare Sub glDepthBoundsdNV(ByVal zmin As GLdouble, ByVal zmax As GLdouble)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDEPTHRANGEDNVPROC As Sub(ByVal zNear As GLdouble, ByVal zFar As GLdouble)
Type PFNGLCLEARDEPTHDNVPROC As Sub(ByVal depth As GLdouble)
Type PFNGLDEPTHBOUNDSDNVPROC As Sub(ByVal zmin As GLdouble, ByVal zmax As GLdouble)
#EndIf

#Ifndef GL_NV_fragment_program4
#define GL_NV_fragment_program4 1
#EndIf

#Ifndef GL_NV_framebuffer_multisample_coverage
#define GL_NV_framebuffer_multisample_coverage 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glRenderbufferStorageMultisampleCoverageNV(ByVal target As GLenum, ByVal coverageSamples As GLsizei, ByVal colorSamples As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLRENDERBUFFERSTORAGEMULTISAMPLECOVERAGENVPROC As Sub(ByVal target As GLenum, ByVal coverageSamples As GLsizei, ByVal colorSamples As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
#EndIf

#Ifndef GL_EXT_framebuffer_sRGB
#define GL_EXT_framebuffer_sRGB 1
#EndIf

#Ifndef GL_NV_geometry_shader4
#define GL_NV_geometry_shader4 1
#EndIf

#Ifndef GL_NV_parameter_buffer_object
#define GL_NV_parameter_buffer_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glProgramBufferParametersfvNV(ByVal target As GLenum, ByVal buffer As GLuint, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLfloat Ptr)
Declare Sub glProgramBufferParametersIivNV(ByVal target As GLenum, ByVal buffer As GLuint, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLint Ptr)
Declare Sub glProgramBufferParametersIuivNV(ByVal target As GLenum, ByVal buffer As GLuint, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLuint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPROGRAMBUFFERPARAMETERSFVNVPROC As Sub(ByVal target As GLenum, ByVal buffer As GLuint, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLfloat Ptr)
Type PFNGLPROGRAMBUFFERPARAMETERSIIVNVPROC As Sub(ByVal target As GLenum, ByVal buffer As GLuint, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLint Ptr)
Type PFNGLPROGRAMBUFFERPARAMETERSIUIVNVPROC As Sub(ByVal target As GLenum, ByVal buffer As GLuint, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLuint Ptr)
#EndIf

#Ifndef GL_EXT_draw_buffers2
#define GL_EXT_draw_buffers2 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glColorMaskIndexedEXT(ByVal index As GLuint, ByVal r As GLboolean, ByVal g As GLboolean, ByVal b As GLboolean, ByVal a As GLboolean)
Declare Sub glGetBooleanIndexedvEXT(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLboolean Ptr)
Declare Sub glGetIntegerIndexedvEXT(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLint Ptr)
Declare Sub glEnableIndexedEXT(ByVal target As GLenum, ByVal index As GLuint)
Declare Sub glDisableIndexedEXT(ByVal target As GLenum, ByVal index As GLuint)
Declare Function glIsEnabledIndexedEXT(ByVal target As GLenum, ByVal index As GLuint) As GLboolean
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOLORMASKINDEXEDEXTPROC As Sub(ByVal index As GLuint, ByVal r As GLboolean, ByVal g As GLboolean, ByVal b As GLboolean, ByVal a As GLboolean)
Type PFNGLGETBOOLEANINDEXEDVEXTPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLboolean Ptr)
Type PFNGLGETINTEGERINDEXEDVEXTPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLint Ptr)
Type PFNGLENABLEINDEXEDEXTPROC As Sub(ByVal target As GLenum, ByVal index As GLuint)
Type PFNGLDISABLEINDEXEDEXTPROC As Sub(ByVal target As GLenum, ByVal index As GLuint)
Type PFNGLISENABLEDINDEXEDEXTPROC As Function(ByVal target As GLenum, ByVal index As GLuint) As GLboolean
#EndIf

#Ifndef GL_NV_transform_feedback
#define GL_NV_transform_feedback 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBeginTransformFeedbackNV(ByVal primitiveMode As GLenum)
Declare Sub glEndTransformFeedbackNV()
Declare Sub glTransformFeedbackAttribsNV(ByVal count As GLuint, ByVal attribs As GLint Ptr, ByVal bufferMode As GLenum)
Declare Sub glBindBufferRangeNV(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal size As GLsizeiptr)
Declare Sub glBindBufferOffsetNV(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint, ByVal offset As GLintptr)
Declare Sub glBindBufferBaseNV(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint)
Declare Sub glTransformFeedbackVaryingsNV(ByVal program As GLuint, ByVal count As GLsizei, ByVal locations As GLint Ptr, ByVal bufferMode As GLenum)
Declare Sub glActiveVaryingNV(ByVal program As GLuint, ByVal Name As GLchar Ptr)
Declare Function glGetVaryingLocationNV(ByVal program As GLuint, ByVal Name As GLchar Ptr) As GLint
Declare Sub glGetActiveVaryingNV(ByVal program As GLuint, ByVal index As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLsizei Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLchar Ptr)
Declare Sub glGetTransformFeedbackVaryingNV(ByVal program As GLuint, ByVal index As GLuint, ByVal location As GLint Ptr)
Declare Sub glTransformFeedbackStreamAttribsNV(ByVal count As GLsizei, ByVal attribs As GLint Ptr, ByVal nbuffers As GLsizei, ByVal bufstreams As GLint Ptr, ByVal bufferMode As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBEGINTRANSFORMFEEDBACKNVPROC As Sub(ByVal primitiveMode As GLenum)
Type PFNGLENDTRANSFORMFEEDBACKNVPROC As Sub()
Type PFNGLTRANSFORMFEEDBACKATTRIBSNVPROC As Sub(ByVal count As GLuint, ByVal attribs As GLint Ptr, ByVal bufferMode As GLenum)
Type PFNGLBINDBUFFERRANGENVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal size As GLsizeiptr)
Type PFNGLBINDBUFFEROFFSETNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint, ByVal offset As GLintptr)
Type PFNGLBINDBUFFERBASENVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint)
Type PFNGLTRANSFORMFEEDBACKVARYINGSNVPROC As Sub(ByVal program As GLuint, ByVal count As GLsizei, ByVal locations As GLint Ptr, ByVal bufferMode As GLenum)
Type PFNGLACTIVEVARYINGNVPROC As Sub(ByVal program As GLuint, ByVal Name As GLchar Ptr)
Type PFNGLGETVARYINGLOCATIONNVPROC As Function(ByVal program As GLuint, ByVal Name As GLchar Ptr) As GLint
Type PFNGLGETACTIVEVARYINGNVPROC As Sub(ByVal program As GLuint, ByVal index As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLsizei Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLchar Ptr)
Type PFNGLGETTRANSFORMFEEDBACKVARYINGNVPROC As Sub(ByVal program As GLuint, ByVal index As GLuint, ByVal location As GLint Ptr)
Type PFNGLTRANSFORMFEEDBACKSTREAMATTRIBSNVPROC As Sub(ByVal count As GLsizei, ByVal attribs As GLint Ptr, ByVal nbuffers As GLsizei, ByVal bufstreams As GLint Ptr, ByVal bufferMode As GLenum)
#EndIf

#Ifndef GL_EXT_bindable_uniform
#define GL_EXT_bindable_uniform 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glUniformBufferEXT(ByVal program As GLuint, ByVal location As GLint, ByVal buffer As GLuint)
Declare Function glGetUniformBufferSizeEXT(ByVal program As GLuint, ByVal location As GLint) As GLint
Declare Function glGetUniformOffsetEXT(ByVal program As GLuint, ByVal location As GLint) As GLintptr
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLUNIFORMBUFFEREXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal buffer As GLuint)
Type PFNGLGETUNIFORMBUFFERSIZEEXTPROC As Function(ByVal program As GLuint, ByVal location As GLint) As GLint
Type PFNGLGETUNIFORMOFFSETEXTPROC As Function(ByVal program As GLuint, ByVal location As GLint) As GLintptr
#EndIf

#Ifndef GL_EXT_texture_integer
#define GL_EXT_texture_integer 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTexParameterIivEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glTexParameterIuivEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Declare Sub glGetTexParameterIivEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetTexParameterIuivEXT(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Declare Sub glClearColorIiEXT(ByVal red As GLint, ByVal green As GLint, ByVal blue As GLint, ByVal Alpha As GLint)
Declare Sub glClearColorIuiEXT(ByVal red As GLuint, ByVal green As GLuint, ByVal blue As GLuint, ByVal Alpha As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXPARAMETERIIVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLTEXPARAMETERIUIVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Type PFNGLGETTEXPARAMETERIIVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETTEXPARAMETERIUIVEXTPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Type PFNGLCLEARCOLORIIEXTPROC As Sub(ByVal red As GLint, ByVal green As GLint, ByVal blue As GLint, ByVal Alpha As GLint)
Type PFNGLCLEARCOLORIUIEXTPROC As Sub(ByVal red As GLuint, ByVal green As GLuint, ByVal blue As GLuint, ByVal Alpha As GLuint)
#EndIf

#Ifndef GL_GREMEDY_frame_terminator
#define GL_GREMEDY_frame_terminator 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glFrameTerminatorGREMEDY()
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLFRAMETERMINATORGREMEDYPROC As Sub()
#EndIf

#Ifndef GL_NV_conditional_render
#define GL_NV_conditional_render 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBeginConditionalRenderNV(ByVal id As GLuint, ByVal mode As GLenum)
Declare Sub glEndConditionalRenderNV()
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBEGINCONDITIONALRENDERNVPROC As Sub(ByVal id As GLuint, ByVal mode As GLenum)
Type PFNGLENDCONDITIONALRENDERNVPROC As Sub()
#EndIf

#Ifndef GL_NV_present_video
#define GL_NV_present_video 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glPresentFrameKeyedNV(ByVal video_slot As GLuint, ByVal minPresentTime As GLuint64EXT, ByVal beginPresentTimeId As GLuint, ByVal presentDurationId As GLuint, ByVal Type As GLenum, ByVal target0 As GLenum, ByVal fill0 As GLuint, ByVal key0 As GLuint, ByVal target1 As GLenum, ByVal fill1 As GLuint, ByVal key1 As GLuint)
Declare Sub glPresentFrameDualFillNV(ByVal video_slot As GLuint, ByVal minPresentTime As GLuint64EXT, ByVal beginPresentTimeId As GLuint, ByVal presentDurationId As GLuint, ByVal Type As GLenum, ByVal target0 As GLenum, ByVal fill0 As GLuint, ByVal target1 As GLenum, ByVal fill1 As GLuint, ByVal target2 As GLenum, ByVal fill2 As GLuint, ByVal target3 As GLenum, ByVal fill3 As GLuint)
Declare Sub glGetVideoivNV(ByVal video_slot As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetVideouivNV(ByVal video_slot As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Declare Sub glGetVideoi64vNV(ByVal video_slot As GLuint, ByVal pname As GLenum, ByVal params As GLint64EXT Ptr)
Declare Sub glGetVideoui64vNV(ByVal video_slot As GLuint, ByVal pname As GLenum, ByVal params As GLuint64EXT Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPRESENTFRAMEKEYEDNVPROC As Sub(ByVal video_slot As GLuint, ByVal minPresentTime As GLuint64EXT, ByVal beginPresentTimeId As GLuint, ByVal presentDurationId As GLuint, ByVal Type As GLenum, ByVal target0 As GLenum, ByVal fill0 As GLuint, ByVal key0 As GLuint, ByVal target1 As GLenum, ByVal fill1 As GLuint, ByVal key1 As GLuint)
Type PFNGLPRESENTFRAMEDUALFILLNVPROC As Sub(ByVal video_slot As GLuint, ByVal minPresentTime As GLuint64EXT, ByVal beginPresentTimeId As GLuint, ByVal presentDurationId As GLuint, ByVal Type As GLenum, ByVal target0 As GLenum, ByVal fill0 As GLuint, ByVal target1 As GLenum, ByVal fill1 As GLuint, ByVal target2 As GLenum, ByVal fill2 As GLuint, ByVal target3 As GLenum, ByVal fill3 As GLuint)
Type PFNGLGETVIDEOIVNVPROC As Sub(ByVal video_slot As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETVIDEOUIVNVPROC As Sub(ByVal video_slot As GLuint, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Type PFNGLGETVIDEOI64VNVPROC As Sub(ByVal video_slot As GLuint, ByVal pname As GLenum, ByVal params As GLint64EXT Ptr)
Type PFNGLGETVIDEOUI64VNVPROC As Sub(ByVal video_slot As GLuint, ByVal pname As GLenum, ByVal params As GLuint64EXT Ptr)
#EndIf

#Ifndef GL_EXT_transform_feedback
#define GL_EXT_transform_feedback 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBeginTransformFeedbackEXT(ByVal primitiveMode As GLenum)
Declare Sub glEndTransformFeedbackEXT()
Declare Sub glBindBufferRangeEXT(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal size As GLsizeiptr)
Declare Sub glBindBufferOffsetEXT(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint, ByVal offset As GLintptr)
Declare Sub glBindBufferBaseEXT(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint)
Declare Sub glTransformFeedbackVaryingsEXT(ByVal program As GLuint, ByVal count As GLsizei, ByVal varyings As GLchar Ptr Ptr, ByVal bufferMode As GLenum)
Declare Sub glGetTransformFeedbackVaryingEXT(ByVal program As GLuint, ByVal index As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLsizei Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLchar Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBEGINTRANSFORMFEEDBACKEXTPROC As Sub(ByVal primitiveMode As GLenum)
Type PFNGLENDTRANSFORMFEEDBACKEXTPROC As Sub()
Type PFNGLBINDBUFFERRANGEEXTPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal size As GLsizeiptr)
Type PFNGLBINDBUFFEROFFSETEXTPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint, ByVal offset As GLintptr)
Type PFNGLBINDBUFFERBASEEXTPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal buffer As GLuint)
Type PFNGLTRANSFORMFEEDBACKVARYINGSEXTPROC As Sub(ByVal program As GLuint, ByVal count As GLsizei, ByVal varyings As GLchar Ptr Ptr, ByVal bufferMode As GLenum)
Type PFNGLGETTRANSFORMFEEDBACKVARYINGEXTPROC As Sub(ByVal program As GLuint, ByVal index As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal size As GLsizei Ptr, ByVal Type As GLenum Ptr, ByVal Name As GLchar Ptr)
#EndIf

#Ifndef GL_EXT_direct_state_access
#define GL_EXT_direct_state_access 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glClientAttribDefaultEXT(ByVal mask As GLbitfield)
Declare Sub glPushClientAttribDefaultEXT(ByVal mask As GLbitfield)
Declare Sub glMatrixLoadfEXT(ByVal mode As GLenum, ByVal m As GLfloat Ptr)
Declare Sub glMatrixLoaddEXT(ByVal mode As GLenum, ByVal m As GLdouble Ptr)
Declare Sub glMatrixMultfEXT(ByVal mode As GLenum, ByVal m As GLfloat Ptr)
Declare Sub glMatrixMultdEXT(ByVal mode As GLenum, ByVal m As GLdouble Ptr)
Declare Sub glMatrixLoadIdentityEXT(ByVal mode As GLenum)
Declare Sub glMatrixRotatefEXT(ByVal mode As GLenum, ByVal angle As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glMatrixRotatedEXT(ByVal mode As GLenum, ByVal angle As GLdouble, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glMatrixScalefEXT(ByVal mode As GLenum, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glMatrixScaledEXT(ByVal mode As GLenum, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glMatrixTranslatefEXT(ByVal mode As GLenum, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Declare Sub glMatrixTranslatedEXT(ByVal mode As GLenum, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glMatrixFrustumEXT(ByVal mode As GLenum, ByVal Left As GLdouble, ByVal Right As GLdouble, ByVal bottom As GLdouble, ByVal top As GLdouble, ByVal zNear As GLdouble, ByVal zFar As GLdouble)
Declare Sub glMatrixOrthoEXT(ByVal mode As GLenum, ByVal Left As GLdouble, ByVal Right As GLdouble, ByVal bottom As GLdouble, ByVal top As GLdouble, ByVal zNear As GLdouble, ByVal zFar As GLdouble)
Declare Sub glMatrixPopEXT(ByVal mode As GLenum)
Declare Sub glMatrixPushEXT(ByVal mode As GLenum)
Declare Sub glMatrixLoadTransposefEXT(ByVal mode As GLenum, ByVal m As GLfloat Ptr)
Declare Sub glMatrixLoadTransposedEXT(ByVal mode As GLenum, ByVal m As GLdouble Ptr)
Declare Sub glMatrixMultTransposefEXT(ByVal mode As GLenum, ByVal m As GLfloat Ptr)
Declare Sub glMatrixMultTransposedEXT(ByVal mode As GLenum, ByVal m As GLdouble Ptr)
Declare Sub glTextureParameterfEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glTextureParameterfvEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glTextureParameteriEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glTextureParameterivEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glTextureImage1DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glTextureImage2DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glTextureSubImage1DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glTextureSubImage2DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glCopyTextureImage1DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal border As GLint)
Declare Sub glCopyTextureImage2DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint)
Declare Sub glCopyTextureSubImage1DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Declare Sub glCopyTextureSubImage2DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glGetTextureImageEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glGetTextureParameterfvEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetTextureParameterivEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetTextureLevelParameterfvEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetTextureLevelParameterivEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glTextureImage3DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glTextureSubImage3DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glCopyTextureSubImage3DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glMultiTexParameterfEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glMultiTexParameterfvEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glMultiTexParameteriEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glMultiTexParameterivEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glMultiTexImage1DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glMultiTexImage2DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glMultiTexSubImage1DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glMultiTexSubImage2DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glCopyMultiTexImage1DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal border As GLint)
Declare Sub glCopyMultiTexImage2DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint)
Declare Sub glCopyMultiTexSubImage1DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Declare Sub glCopyMultiTexSubImage2DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glGetMultiTexImageEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glGetMultiTexParameterfvEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetMultiTexParameterivEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetMultiTexLevelParameterfvEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetMultiTexLevelParameterivEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glMultiTexImage3DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glMultiTexSubImage3DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Declare Sub glCopyMultiTexSubImage3DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glBindMultiTextureEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal texture As GLuint)
Declare Sub glEnableClientStateIndexedEXT(ByVal array As GLenum, ByVal index As GLuint)
Declare Sub glDisableClientStateIndexedEXT(ByVal array As GLenum, ByVal index As GLuint)
Declare Sub glMultiTexCoordPointerEXT(ByVal texunit As GLenum, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glMultiTexEnvfEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glMultiTexEnvfvEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glMultiTexEnviEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glMultiTexEnvivEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glMultiTexGendEXT(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal param As GLdouble)
Declare Sub glMultiTexGendvEXT(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Declare Sub glMultiTexGenfEXT(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Declare Sub glMultiTexGenfvEXT(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glMultiTexGeniEXT(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Declare Sub glMultiTexGenivEXT(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetMultiTexEnvfvEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetMultiTexEnvivEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetMultiTexGendvEXT(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Declare Sub glGetMultiTexGenfvEXT(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetMultiTexGenivEXT(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetFloatIndexedvEXT(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLfloat Ptr)
Declare Sub glGetDoubleIndexedvEXT(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLdouble Ptr)
Declare Sub glGetPointerIndexedvEXT(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLvoid Ptr Ptr)
Declare Sub glCompressedTextureImage3DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Declare Sub glCompressedTextureImage2DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Declare Sub glCompressedTextureImage1DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Declare Sub glCompressedTextureSubImage3DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Declare Sub glCompressedTextureSubImage2DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Declare Sub glCompressedTextureSubImage1DEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Declare Sub glGetCompressedTextureImageEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal lod As GLint, ByVal img As GLvoid Ptr)
Declare Sub glCompressedMultiTexImage3DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Declare Sub glCompressedMultiTexImage2DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Declare Sub glCompressedMultiTexImage1DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Declare Sub glCompressedMultiTexSubImage3DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Declare Sub glCompressedMultiTexSubImage2DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Declare Sub glCompressedMultiTexSubImage1DEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Declare Sub glGetCompressedMultiTexImageEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal lod As GLint, ByVal img As GLvoid Ptr)
Declare Sub glNamedProgramStringEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal Format As GLenum, ByVal Len As GLsizei, ByVal String As GLvoid Ptr)
Declare Sub glNamedProgramLocalParameter4dEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glNamedProgramLocalParameter4dvEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLdouble Ptr)
Declare Sub glNamedProgramLocalParameter4fEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Declare Sub glNamedProgramLocalParameter4fvEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLfloat Ptr)
Declare Sub glGetNamedProgramLocalParameterdvEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLdouble Ptr)
Declare Sub glGetNamedProgramLocalParameterfvEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLfloat Ptr)
Declare Sub glGetNamedProgramivEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetNamedProgramStringEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal String As GLvoid Ptr)
Declare Sub glNamedProgramLocalParameters4fvEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLfloat Ptr)
Declare Sub glNamedProgramLocalParameterI4iEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Declare Sub glNamedProgramLocalParameterI4ivEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLint Ptr)
Declare Sub glNamedProgramLocalParametersI4ivEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLint Ptr)
Declare Sub glNamedProgramLocalParameterI4uiEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint, ByVal w As GLuint)
Declare Sub glNamedProgramLocalParameterI4uivEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLuint Ptr)
Declare Sub glNamedProgramLocalParametersI4uivEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLuint Ptr)
Declare Sub glGetNamedProgramLocalParameterIivEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLint Ptr)
Declare Sub glGetNamedProgramLocalParameterIuivEXT(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLuint Ptr)
Declare Sub glTextureParameterIivEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glTextureParameterIuivEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Declare Sub glGetTextureParameterIivEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetTextureParameterIuivEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Declare Sub glMultiTexParameterIivEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glMultiTexParameterIuivEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Declare Sub glGetMultiTexParameterIivEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetMultiTexParameterIuivEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Declare Sub glProgramUniform1fEXT(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat)
Declare Sub glProgramUniform2fEXT(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat)
Declare Sub glProgramUniform3fEXT(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat)
Declare Sub glProgramUniform4fEXT(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal v3 As GLfloat)
Declare Sub glProgramUniform1iEXT(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint)
Declare Sub glProgramUniform2iEXT(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint)
Declare Sub glProgramUniform3iEXT(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint)
Declare Sub glProgramUniform4iEXT(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint, ByVal v3 As GLint)
Declare Sub glProgramUniform1fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniform2fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniform3fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniform4fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniform1ivEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glProgramUniform2ivEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glProgramUniform3ivEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glProgramUniform4ivEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Declare Sub glProgramUniformMatrix2fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix3fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix4fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix2x3fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix3x2fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix2x4fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix4x2fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix3x4fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniformMatrix4x3fvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Declare Sub glProgramUniform1uiEXT(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint)
Declare Sub glProgramUniform2uiEXT(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint)
Declare Sub glProgramUniform3uiEXT(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint)
Declare Sub glProgramUniform4uiEXT(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint, ByVal v3 As GLuint)
Declare Sub glProgramUniform1uivEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glProgramUniform2uivEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glProgramUniform3uivEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glProgramUniform4uivEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Declare Sub glNamedBufferDataEXT(ByVal buffer As GLuint, ByVal size As GLsizeiptr, ByVal Data As GLvoid Ptr, ByVal usage As GLenum)
Declare Sub glNamedBufferSubDataEXT(ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal size As GLsizeiptr, ByVal Data As GLvoid Ptr)
Declare Function glMapNamedBufferEXT(ByVal buffer As GLuint, ByVal Access As GLenum) As GLvoid Ptr
Declare Function glUnmapNamedBufferEXT(ByVal buffer As GLuint) As GLboolean
Declare Function glMapNamedBufferRangeEXT(ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal length As GLsizeiptr, ByVal Access As GLbitfield) As GLvoid Ptr
Declare Sub glFlushMappedNamedBufferRangeEXT(ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal length As GLsizeiptr)
Declare Sub glNamedCopyBufferSubDataEXT(ByVal readBuffer As GLuint, ByVal writeBuffer As GLuint, ByVal readOffset As GLintptr, ByVal writeOffset As GLintptr, ByVal size As GLsizeiptr)
Declare Sub glGetNamedBufferParameterivEXT(ByVal buffer As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetNamedBufferPointervEXT(ByVal buffer As GLuint, ByVal pname As GLenum, ByVal params As GLvoid Ptr Ptr)
Declare Sub glGetNamedBufferSubDataEXT(ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal size As GLsizeiptr, ByVal Data As GLvoid Ptr)
Declare Sub glTextureBufferEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal internalformat As GLenum, ByVal buffer As GLuint)
Declare Sub glMultiTexBufferEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal internalformat As GLenum, ByVal buffer As GLuint)
Declare Sub glNamedRenderbufferStorageEXT(ByVal renderbuffer As GLuint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glGetNamedRenderbufferParameterivEXT(ByVal renderbuffer As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Function glCheckNamedFramebufferStatusEXT(ByVal framebuffer As GLuint, ByVal target As GLenum) As GLenum
Declare Sub glNamedFramebufferTexture1DEXT(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Declare Sub glNamedFramebufferTexture2DEXT(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Declare Sub glNamedFramebufferTexture3DEXT(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal zoffset As GLint)
Declare Sub glNamedFramebufferRenderbufferEXT(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal renderbuffertarget As GLenum, ByVal renderbuffer As GLuint)
Declare Sub glGetNamedFramebufferAttachmentParameterivEXT(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGenerateTextureMipmapEXT(ByVal texture As GLuint, ByVal target As GLenum)
Declare Sub glGenerateMultiTexMipmapEXT(ByVal texunit As GLenum, ByVal target As GLenum)
Declare Sub glFramebufferDrawBufferEXT(ByVal framebuffer As GLuint, ByVal mode As GLenum)
Declare Sub glFramebufferDrawBuffersEXT(ByVal framebuffer As GLuint, ByVal n As GLsizei, ByVal bufs As GLenum Ptr)
Declare Sub glFramebufferReadBufferEXT(ByVal framebuffer As GLuint, ByVal mode As GLenum)
Declare Sub glGetFramebufferParameterivEXT(ByVal framebuffer As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glNamedRenderbufferStorageMultisampleEXT(ByVal renderbuffer As GLuint, ByVal samples As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glNamedRenderbufferStorageMultisampleCoverageEXT(ByVal renderbuffer As GLuint, ByVal coverageSamples As GLsizei, ByVal colorSamples As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Declare Sub glNamedFramebufferTextureEXT(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Declare Sub glNamedFramebufferTextureLayerEXT(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal layer As GLint)
Declare Sub glNamedFramebufferTextureFaceEXT(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal face As GLenum)
Declare Sub glTextureRenderbufferEXT(ByVal texture As GLuint, ByVal target As GLenum, ByVal renderbuffer As GLuint)
Declare Sub glMultiTexRenderbufferEXT(ByVal texunit As GLenum, ByVal target As GLenum, ByVal renderbuffer As GLuint)
Declare Sub glProgramUniform1dEXT(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLdouble)
Declare Sub glProgramUniform2dEXT(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glProgramUniform3dEXT(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glProgramUniform4dEXT(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glProgramUniform1dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniform2dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniform3dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniform4dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix2dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix3dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix4dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix2x3dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix2x4dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix3x2dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix3x4dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix4x2dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Declare Sub glProgramUniformMatrix4x3dvEXT(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCLIENTATTRIBDEFAULTEXTPROC As Sub(ByVal mask As GLbitfield)
Type PFNGLPUSHCLIENTATTRIBDEFAULTEXTPROC As Sub(ByVal mask As GLbitfield)
Type PFNGLMATRIXLOADFEXTPROC As Sub(ByVal mode As GLenum, ByVal m As GLfloat Ptr)
Type PFNGLMATRIXLOADDEXTPROC As Sub(ByVal mode As GLenum, ByVal m As GLdouble Ptr)
Type PFNGLMATRIXMULTFEXTPROC As Sub(ByVal mode As GLenum, ByVal m As GLfloat Ptr)
Type PFNGLMATRIXMULTDEXTPROC As Sub(ByVal mode As GLenum, ByVal m As GLdouble Ptr)
Type PFNGLMATRIXLOADIDENTITYEXTPROC As Sub(ByVal mode As GLenum)
Type PFNGLMATRIXROTATEFEXTPROC As Sub(ByVal mode As GLenum, ByVal angle As GLfloat, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLMATRIXROTATEDEXTPROC As Sub(ByVal mode As GLenum, ByVal angle As GLdouble, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLMATRIXSCALEFEXTPROC As Sub(ByVal mode As GLenum, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLMATRIXSCALEDEXTPROC As Sub(ByVal mode As GLenum, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLMATRIXTRANSLATEFEXTPROC As Sub(ByVal mode As GLenum, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat)
Type PFNGLMATRIXTRANSLATEDEXTPROC As Sub(ByVal mode As GLenum, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLMATRIXFRUSTUMEXTPROC As Sub(ByVal mode As GLenum, ByVal Left As GLdouble, ByVal Right As GLdouble, ByVal bottom As GLdouble, ByVal top As GLdouble, ByVal zNear As GLdouble, ByVal zFar As GLdouble)
Type PFNGLMATRIXORTHOEXTPROC As Sub(ByVal mode As GLenum, ByVal Left As GLdouble, ByVal Right As GLdouble, ByVal bottom As GLdouble, ByVal top As GLdouble, ByVal zNear As GLdouble, ByVal zFar As GLdouble)
Type PFNGLMATRIXPOPEXTPROC As Sub(ByVal mode As GLenum)
Type PFNGLMATRIXPUSHEXTPROC As Sub(ByVal mode As GLenum)
Type PFNGLMATRIXLOADTRANSPOSEFEXTPROC As Sub(ByVal mode As GLenum, ByVal m As GLfloat Ptr)
Type PFNGLMATRIXLOADTRANSPOSEDEXTPROC As Sub(ByVal mode As GLenum, ByVal m As GLdouble Ptr)
Type PFNGLMATRIXMULTTRANSPOSEFEXTPROC As Sub(ByVal mode As GLenum, ByVal m As GLfloat Ptr)
Type PFNGLMATRIXMULTTRANSPOSEDEXTPROC As Sub(ByVal mode As GLenum, ByVal m As GLdouble Ptr)
Type PFNGLTEXTUREPARAMETERFEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLTEXTUREPARAMETERFVEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLTEXTUREPARAMETERIEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLTEXTUREPARAMETERIVEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLTEXTUREIMAGE1DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLTEXTUREIMAGE2DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLTEXTURESUBIMAGE1DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLTEXTURESUBIMAGE2DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLCOPYTEXTUREIMAGE1DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal border As GLint)
Type PFNGLCOPYTEXTUREIMAGE2DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint)
Type PFNGLCOPYTEXTURESUBIMAGE1DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Type PFNGLCOPYTEXTURESUBIMAGE2DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLGETTEXTUREIMAGEEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLGETTEXTUREPARAMETERFVEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETTEXTUREPARAMETERIVEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETTEXTURELEVELPARAMETERFVEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETTEXTURELEVELPARAMETERIVEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLTEXTUREIMAGE3DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLTEXTURESUBIMAGE3DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLCOPYTEXTURESUBIMAGE3DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLMULTITEXPARAMETERFEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLMULTITEXPARAMETERFVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLMULTITEXPARAMETERIEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLMULTITEXPARAMETERIVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLMULTITEXIMAGE1DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLMULTITEXIMAGE2DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLMULTITEXSUBIMAGE1DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLMULTITEXSUBIMAGE2DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLCOPYMULTITEXIMAGE1DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal border As GLint)
Type PFNGLCOPYMULTITEXIMAGE2DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint)
Type PFNGLCOPYMULTITEXSUBIMAGE1DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei)
Type PFNGLCOPYMULTITEXSUBIMAGE2DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLGETMULTITEXIMAGEEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLGETMULTITEXPARAMETERFVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETMULTITEXPARAMETERIVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETMULTITEXLEVELPARAMETERFVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETMULTITEXLEVELPARAMETERIVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLMULTITEXIMAGE3DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLMULTITEXSUBIMAGE3DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal Type As GLenum, ByVal pixels As GLvoid Ptr)
Type PFNGLCOPYMULTITEXSUBIMAGE3DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal x As GLint, ByVal y As GLint, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLBINDMULTITEXTUREEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal texture As GLuint)
Type PFNGLENABLECLIENTSTATEINDEXEDEXTPROC As Sub(ByVal array As GLenum, ByVal index As GLuint)
Type PFNGLDISABLECLIENTSTATEINDEXEDEXTPROC As Sub(ByVal array As GLenum, ByVal index As GLuint)
Type PFNGLMULTITEXCOORDPOINTEREXTPROC As Sub(ByVal texunit As GLenum, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLMULTITEXENVFEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLMULTITEXENVFVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLMULTITEXENVIEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLMULTITEXENVIVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLMULTITEXGENDEXTPROC As Sub(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal param As GLdouble)
Type PFNGLMULTITEXGENDVEXTPROC As Sub(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Type PFNGLMULTITEXGENFEXTPROC As Sub(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal param As GLfloat)
Type PFNGLMULTITEXGENFVEXTPROC As Sub(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLMULTITEXGENIEXTPROC As Sub(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal param As GLint)
Type PFNGLMULTITEXGENIVEXTPROC As Sub(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETMULTITEXENVFVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETMULTITEXENVIVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETMULTITEXGENDVEXTPROC As Sub(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Type PFNGLGETMULTITEXGENFVEXTPROC As Sub(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETMULTITEXGENIVEXTPROC As Sub(ByVal texunit As GLenum, ByVal coord As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETFLOATINDEXEDVEXTPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLfloat Ptr)
Type PFNGLGETDOUBLEINDEXEDVEXTPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLdouble Ptr)
Type PFNGLGETPOINTERINDEXEDVEXTPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal Data As GLvoid Ptr Ptr)
Type PFNGLCOMPRESSEDTEXTUREIMAGE3DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXTUREIMAGE2DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXTUREIMAGE1DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXTURESUBIMAGE3DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXTURESUBIMAGE2DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Type PFNGLCOMPRESSEDTEXTURESUBIMAGE1DEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Type PFNGLGETCOMPRESSEDTEXTUREIMAGEEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal lod As GLint, ByVal img As GLvoid Ptr)
Type PFNGLCOMPRESSEDMULTITEXIMAGE3DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Type PFNGLCOMPRESSEDMULTITEXIMAGE2DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Type PFNGLCOMPRESSEDMULTITEXIMAGE1DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal border As GLint, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Type PFNGLCOMPRESSEDMULTITEXSUBIMAGE3DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal zoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Type PFNGLCOMPRESSEDMULTITEXSUBIMAGE2DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal yoffset As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Type PFNGLCOMPRESSEDMULTITEXSUBIMAGE1DEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal level As GLint, ByVal xoffset As GLint, ByVal Width As GLsizei, ByVal Format As GLenum, ByVal imageSize As GLsizei, ByVal bits As GLvoid Ptr)
Type PFNGLGETCOMPRESSEDMULTITEXIMAGEEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal lod As GLint, ByVal img As GLvoid Ptr)
Type PFNGLNAMEDPROGRAMSTRINGEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal Format As GLenum, ByVal Len As GLsizei, ByVal String As GLvoid Ptr)
Type PFNGLNAMEDPROGRAMLOCALPARAMETER4DEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLNAMEDPROGRAMLOCALPARAMETER4DVEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLdouble Ptr)
Type PFNGLNAMEDPROGRAMLOCALPARAMETER4FEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLfloat, ByVal y As GLfloat, ByVal z As GLfloat, ByVal w As GLfloat)
Type PFNGLNAMEDPROGRAMLOCALPARAMETER4FVEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLfloat Ptr)
Type PFNGLGETNAMEDPROGRAMLOCALPARAMETERDVEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLdouble Ptr)
Type PFNGLGETNAMEDPROGRAMLOCALPARAMETERFVEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLfloat Ptr)
Type PFNGLGETNAMEDPROGRAMIVEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETNAMEDPROGRAMSTRINGEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal String As GLvoid Ptr)
Type PFNGLNAMEDPROGRAMLOCALPARAMETERS4FVEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLfloat Ptr)
Type PFNGLNAMEDPROGRAMLOCALPARAMETERI4IEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLint, ByVal y As GLint, ByVal z As GLint, ByVal w As GLint)
Type PFNGLNAMEDPROGRAMLOCALPARAMETERI4IVEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLint Ptr)
Type PFNGLNAMEDPROGRAMLOCALPARAMETERSI4IVEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLint Ptr)
Type PFNGLNAMEDPROGRAMLOCALPARAMETERI4UIEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal x As GLuint, ByVal y As GLuint, ByVal z As GLuint, ByVal w As GLuint)
Type PFNGLNAMEDPROGRAMLOCALPARAMETERI4UIVEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLuint Ptr)
Type PFNGLNAMEDPROGRAMLOCALPARAMETERSI4UIVEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal count As GLsizei, ByVal params As GLuint Ptr)
Type PFNGLGETNAMEDPROGRAMLOCALPARAMETERIIVEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLint Ptr)
Type PFNGLGETNAMEDPROGRAMLOCALPARAMETERIUIVEXTPROC As Sub(ByVal program As GLuint, ByVal target As GLenum, ByVal index As GLuint, ByVal params As GLuint Ptr)
Type PFNGLTEXTUREPARAMETERIIVEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLTEXTUREPARAMETERIUIVEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Type PFNGLGETTEXTUREPARAMETERIIVEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETTEXTUREPARAMETERIUIVEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Type PFNGLMULTITEXPARAMETERIIVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLMULTITEXPARAMETERIUIVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Type PFNGLGETMULTITEXPARAMETERIIVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETMULTITEXPARAMETERIUIVEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint Ptr)
Type PFNGLPROGRAMUNIFORM1FEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat)
Type PFNGLPROGRAMUNIFORM2FEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat)
Type PFNGLPROGRAMUNIFORM3FEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat)
Type PFNGLPROGRAMUNIFORM4FEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLfloat, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal v3 As GLfloat)
Type PFNGLPROGRAMUNIFORM1IEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint)
Type PFNGLPROGRAMUNIFORM2IEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint)
Type PFNGLPROGRAMUNIFORM3IEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint)
Type PFNGLPROGRAMUNIFORM4IEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLint, ByVal v1 As GLint, ByVal v2 As GLint, ByVal v3 As GLint)
Type PFNGLPROGRAMUNIFORM1FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORM2FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORM3FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORM4FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORM1IVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLPROGRAMUNIFORM2IVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLPROGRAMUNIFORM3IVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLPROGRAMUNIFORM4IVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX2FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX3FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX4FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX2X3FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX3X2FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX2X4FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX4X2FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX3X4FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX4X3FVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLfloat Ptr)
Type PFNGLPROGRAMUNIFORM1UIEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint)
Type PFNGLPROGRAMUNIFORM2UIEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint)
Type PFNGLPROGRAMUNIFORM3UIEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint)
Type PFNGLPROGRAMUNIFORM4UIEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal v0 As GLuint, ByVal v1 As GLuint, ByVal v2 As GLuint, ByVal v3 As GLuint)
Type PFNGLPROGRAMUNIFORM1UIVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLPROGRAMUNIFORM2UIVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLPROGRAMUNIFORM3UIVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLPROGRAMUNIFORM4UIVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint Ptr)
Type PFNGLNAMEDBUFFERDATAEXTPROC As Sub(ByVal buffer As GLuint, ByVal size As GLsizeiptr, ByVal Data As GLvoid Ptr, ByVal usage As GLenum)
Type PFNGLNAMEDBUFFERSUBDATAEXTPROC As Sub(ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal size As GLsizeiptr, ByVal Data As GLvoid Ptr)
Type PFNGLMAPNAMEDBUFFEREXTPROC As Function(ByVal buffer As GLuint, ByVal Access As GLenum) As GLvoid Ptr
Type PFNGLUNMAPNAMEDBUFFEREXTPROC As Function(ByVal buffer As GLuint) As GLboolean
Type PFNGLMAPNAMEDBUFFERRANGEEXTPROC As Function(ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal length As GLsizeiptr, ByVal Access As GLbitfield) As GLvoid Ptr
Type PFNGLFLUSHMAPPEDNAMEDBUFFERRANGEEXTPROC As Sub(ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal length As GLsizeiptr)
Type PFNGLNAMEDCOPYBUFFERSUBDATAEXTPROC As Sub(ByVal readBuffer As GLuint, ByVal writeBuffer As GLuint, ByVal readOffset As GLintptr, ByVal writeOffset As GLintptr, ByVal size As GLsizeiptr)
Type PFNGLGETNAMEDBUFFERPARAMETERIVEXTPROC As Sub(ByVal buffer As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETNAMEDBUFFERPOINTERVEXTPROC As Sub(ByVal buffer As GLuint, ByVal pname As GLenum, ByVal params As GLvoid Ptr Ptr)
Type PFNGLGETNAMEDBUFFERSUBDATAEXTPROC As Sub(ByVal buffer As GLuint, ByVal offset As GLintptr, ByVal size As GLsizeiptr, ByVal Data As GLvoid Ptr)
Type PFNGLTEXTUREBUFFEREXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal internalformat As GLenum, ByVal buffer As GLuint)
Type PFNGLMULTITEXBUFFEREXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal internalformat As GLenum, ByVal buffer As GLuint)
Type PFNGLNAMEDRENDERBUFFERSTORAGEEXTPROC As Sub(ByVal renderbuffer As GLuint, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLGETNAMEDRENDERBUFFERPARAMETERIVEXTPROC As Sub(ByVal renderbuffer As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLCHECKNAMEDFRAMEBUFFERSTATUSEXTPROC As Function(ByVal framebuffer As GLuint, ByVal target As GLenum) As GLenum
Type PFNGLNAMEDFRAMEBUFFERTEXTURE1DEXTPROC As Sub(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Type PFNGLNAMEDFRAMEBUFFERTEXTURE2DEXTPROC As Sub(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Type PFNGLNAMEDFRAMEBUFFERTEXTURE3DEXTPROC As Sub(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal textarget As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal zoffset As GLint)
Type PFNGLNAMEDFRAMEBUFFERRENDERBUFFEREXTPROC As Sub(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal renderbuffertarget As GLenum, ByVal renderbuffer As GLuint)
Type PFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC As Sub(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGENERATETEXTUREMIPMAPEXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum)
Type PFNGLGENERATEMULTITEXMIPMAPEXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum)
Type PFNGLFRAMEBUFFERDRAWBUFFEREXTPROC As Sub(ByVal framebuffer As GLuint, ByVal mode As GLenum)
Type PFNGLFRAMEBUFFERDRAWBUFFERSEXTPROC As Sub(ByVal framebuffer As GLuint, ByVal n As GLsizei, ByVal bufs As GLenum Ptr)
Type PFNGLFRAMEBUFFERREADBUFFEREXTPROC As Sub(ByVal framebuffer As GLuint, ByVal mode As GLenum)
Type PFNGLGETFRAMEBUFFERPARAMETERIVEXTPROC As Sub(ByVal framebuffer As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC As Sub(ByVal renderbuffer As GLuint, ByVal samples As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLECOVERAGEEXTPROC As Sub(ByVal renderbuffer As GLuint, ByVal coverageSamples As GLsizei, ByVal colorSamples As GLsizei, ByVal internalformat As GLenum, ByVal Width As GLsizei, ByVal height As GLsizei)
Type PFNGLNAMEDFRAMEBUFFERTEXTUREEXTPROC As Sub(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint)
Type PFNGLNAMEDFRAMEBUFFERTEXTURELAYEREXTPROC As Sub(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal layer As GLint)
Type PFNGLNAMEDFRAMEBUFFERTEXTUREFACEEXTPROC As Sub(ByVal framebuffer As GLuint, ByVal attachment As GLenum, ByVal texture As GLuint, ByVal level As GLint, ByVal face As GLenum)
Type PFNGLTEXTURERENDERBUFFEREXTPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal renderbuffer As GLuint)
Type PFNGLMULTITEXRENDERBUFFEREXTPROC As Sub(ByVal texunit As GLenum, ByVal target As GLenum, ByVal renderbuffer As GLuint)
Type PFNGLPROGRAMUNIFORM1DEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLdouble)
Type PFNGLPROGRAMUNIFORM2DEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLdouble, ByVal y As GLdouble)
Type PFNGLPROGRAMUNIFORM3DEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLPROGRAMUNIFORM4DEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLPROGRAMUNIFORM1DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORM2DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORM3DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORM4DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX2DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX3DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX4DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX2X3DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX2X4DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX3X2DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX3X4DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX4X2DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
Type PFNGLPROGRAMUNIFORMMATRIX4X3DVEXTPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal transpose As GLboolean, ByVal value As GLdouble Ptr)
#EndIf

#Ifndef GL_EXT_vertex_array_bgra
#define GL_EXT_vertex_array_bgra 1
#EndIf

#Ifndef GL_EXT_texture_swizzle
#define GL_EXT_texture_swizzle 1
#EndIf

#Ifndef GL_NV_explicit_multisample
#define GL_NV_explicit_multisample 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGetMultisamplefvNV(ByVal pname As GLenum, ByVal index As GLuint, ByVal Val As GLfloat Ptr)
Declare Sub glSampleMaskIndexedNV(ByVal index As GLuint, ByVal mask As GLbitfield)
Declare Sub glTexRenderbufferNV(ByVal target As GLenum, ByVal renderbuffer As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETMULTISAMPLEFVNVPROC As Sub(ByVal pname As GLenum, ByVal index As GLuint, ByVal Val As GLfloat Ptr)
Type PFNGLSAMPLEMASKINDEXEDNVPROC As Sub(ByVal index As GLuint, ByVal mask As GLbitfield)
Type PFNGLTEXRENDERBUFFERNVPROC As Sub(ByVal target As GLenum, ByVal renderbuffer As GLuint)
#EndIf

#Ifndef GL_NV_transform_feedback2
#define GL_NV_transform_feedback2 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBindTransformFeedbackNV(ByVal target As GLenum, ByVal id As GLuint)
Declare Sub glDeleteTransformFeedbacksNV(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Declare Sub glGenTransformFeedbacksNV(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Declare Function glIsTransformFeedbackNV(ByVal id As GLuint) As GLboolean
Declare Sub glPauseTransformFeedbackNV()
Declare Sub glResumeTransformFeedbackNV()
Declare Sub glDrawTransformFeedbackNV(ByVal mode As GLenum, ByVal id As GLuint)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBINDTRANSFORMFEEDBACKNVPROC As Sub(ByVal target As GLenum, ByVal id As GLuint)
Type PFNGLDELETETRANSFORMFEEDBACKSNVPROC As Sub(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Type PFNGLGENTRANSFORMFEEDBACKSNVPROC As Sub(ByVal n As GLsizei, ByVal ids As GLuint Ptr)
Type PFNGLISTRANSFORMFEEDBACKNVPROC As Function(ByVal id As GLuint) As GLboolean
Type PFNGLPAUSETRANSFORMFEEDBACKNVPROC As Sub()
Type PFNGLRESUMETRANSFORMFEEDBACKNVPROC As Sub()
Type PFNGLDRAWTRANSFORMFEEDBACKNVPROC As Sub(ByVal mode As GLenum, ByVal id As GLuint)
#EndIf

#Ifndef GL_ATI_meminfo
#define GL_ATI_meminfo 1
#EndIf

#Ifndef GL_AMD_performance_monitor
#define GL_AMD_performance_monitor 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGetPerfMonitorGroupsAMD(ByVal numGroups As GLint Ptr, ByVal groupsSize As GLsizei, ByVal groups As GLuint Ptr)
Declare Sub glGetPerfMonitorCountersAMD(ByVal group As GLuint, ByVal numCounters As GLint Ptr, ByVal maxActiveCounters As GLint Ptr, ByVal counterSize As GLsizei, ByVal counters As GLuint Ptr)
Declare Sub glGetPerfMonitorGroupStringAMD(ByVal group As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal groupString As GLchar Ptr)
Declare Sub glGetPerfMonitorCounterStringAMD(ByVal group As GLuint, ByVal counter As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal counterString As GLchar Ptr)
Declare Sub glGetPerfMonitorCounterInfoAMD(ByVal group As GLuint, ByVal counter As GLuint, ByVal pname As GLenum, ByVal Data As GLvoid Ptr)
Declare Sub glGenPerfMonitorsAMD(ByVal n As GLsizei, ByVal monitors As GLuint Ptr)
Declare Sub glDeletePerfMonitorsAMD(ByVal n As GLsizei, ByVal monitors As GLuint Ptr)
Declare Sub glSelectPerfMonitorCountersAMD(ByVal monitor As GLuint, ByVal enable As GLboolean, ByVal group As GLuint, ByVal numCounters As GLint, ByVal counterList As GLuint Ptr)
Declare Sub glBeginPerfMonitorAMD(ByVal monitor As GLuint)
Declare Sub glEndPerfMonitorAMD(ByVal monitor As GLuint)
Declare Sub glGetPerfMonitorCounterDataAMD(ByVal monitor As GLuint, ByVal pname As GLenum, ByVal dataSize As GLsizei, ByVal Data As GLuint Ptr, ByVal bytesWritten As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGETPERFMONITORGROUPSAMDPROC As Sub(ByVal numGroups As GLint Ptr, ByVal groupsSize As GLsizei, ByVal groups As GLuint Ptr)
Type PFNGLGETPERFMONITORCOUNTERSAMDPROC As Sub(ByVal group As GLuint, ByVal numCounters As GLint Ptr, ByVal maxActiveCounters As GLint Ptr, ByVal counterSize As GLsizei, ByVal counters As GLuint Ptr)
Type PFNGLGETPERFMONITORGROUPSTRINGAMDPROC As Sub(ByVal group As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal groupString As GLchar Ptr)
Type PFNGLGETPERFMONITORCOUNTERSTRINGAMDPROC As Sub(ByVal group As GLuint, ByVal counter As GLuint, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal counterString As GLchar Ptr)
Type PFNGLGETPERFMONITORCOUNTERINFOAMDPROC As Sub(ByVal group As GLuint, ByVal counter As GLuint, ByVal pname As GLenum, ByVal Data As GLvoid Ptr)
Type PFNGLGENPERFMONITORSAMDPROC As Sub(ByVal n As GLsizei, ByVal monitors As GLuint Ptr)
Type PFNGLDELETEPERFMONITORSAMDPROC As Sub(ByVal n As GLsizei, ByVal monitors As GLuint Ptr)
Type PFNGLSELECTPERFMONITORCOUNTERSAMDPROC As Sub(ByVal monitor As GLuint, ByVal enable As GLboolean, ByVal group As GLuint, ByVal numCounters As GLint, ByVal counterList As GLuint Ptr)
Type PFNGLBEGINPERFMONITORAMDPROC As Sub(ByVal monitor As GLuint)
Type PFNGLENDPERFMONITORAMDPROC As Sub(ByVal monitor As GLuint)
Type PFNGLGETPERFMONITORCOUNTERDATAAMDPROC As Sub(ByVal monitor As GLuint, ByVal pname As GLenum, ByVal dataSize As GLsizei, ByVal Data As GLuint Ptr, ByVal bytesWritten As GLint Ptr)
#EndIf

#Ifndef GL_AMD_texture_texture4
#define GL_AMD_texture_texture4 1
#EndIf

#Ifndef GL_AMD_vertex_shader_tesselator
#define GL_AMD_vertex_shader_tesselator 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTessellationFactorAMD(ByVal factor As GLfloat)
Declare Sub glTessellationModeAMD(ByVal mode As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTESSELLATIONFACTORAMDPROC As Sub(ByVal factor As GLfloat)
Type PFNGLTESSELLATIONMODEAMDPROC As Sub(ByVal mode As GLenum)
#EndIf

#Ifndef GL_EXT_provoking_vertex
#define GL_EXT_provoking_vertex 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glProvokingVertexEXT(ByVal mode As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPROVOKINGVERTEXEXTPROC As Sub(ByVal mode As GLenum)
#EndIf

#Ifndef GL_EXT_texture_snorm
#define GL_EXT_texture_snorm 1
#EndIf

#Ifndef GL_AMD_draw_buffers_blend
#define GL_AMD_draw_buffers_blend 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBlendFuncIndexedAMD(ByVal buf As GLuint, ByVal src As GLenum, ByVal dst As GLenum)
Declare Sub glBlendFuncSeparateIndexedAMD(ByVal buf As GLuint, ByVal srcRGB As GLenum, ByVal dstRGB As GLenum, ByVal srcAlpha As GLenum, ByVal dstAlpha As GLenum)
Declare Sub glBlendEquationIndexedAMD(ByVal buf As GLuint, ByVal mode As GLenum)
Declare Sub glBlendEquationSeparateIndexedAMD(ByVal buf As GLuint, ByVal modeRGB As GLenum, ByVal modeAlpha As GLenum)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBLENDFUNCINDEXEDAMDPROC As Sub(ByVal buf As GLuint, ByVal src As GLenum, ByVal dst As GLenum)
Type PFNGLBLENDFUNCSEPARATEINDEXEDAMDPROC As Sub(ByVal buf As GLuint, ByVal srcRGB As GLenum, ByVal dstRGB As GLenum, ByVal srcAlpha As GLenum, ByVal dstAlpha As GLenum)
Type PFNGLBLENDEQUATIONINDEXEDAMDPROC As Sub(ByVal buf As GLuint, ByVal mode As GLenum)
Type PFNGLBLENDEQUATIONSEPARATEINDEXEDAMDPROC As Sub(ByVal buf As GLuint, ByVal modeRGB As GLenum, ByVal modeAlpha As GLenum)
#EndIf

#Ifndef GL_APPLE_texture_range
#define GL_APPLE_texture_range 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTextureRangeAPPLE(ByVal target As GLenum, ByVal length As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glGetTexParameterPointervAPPLE(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLvoid Ptr Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXTURERANGEAPPLEPROC As Sub(ByVal target As GLenum, ByVal length As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLGETTEXPARAMETERPOINTERVAPPLEPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLvoid Ptr Ptr)
#EndIf

#Ifndef GL_APPLE_float_pixels
#define GL_APPLE_float_pixels 1
#EndIf

#Ifndef GL_APPLE_vertex_program_evaluators
#define GL_APPLE_vertex_program_evaluators 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glEnableVertexAttribAPPLE(ByVal index As GLuint, ByVal pname As GLenum)
Declare Sub glDisableVertexAttribAPPLE(ByVal index As GLuint, ByVal pname As GLenum)
Declare Function glIsVertexAttribEnabledAPPLE(ByVal index As GLuint, ByVal pname As GLenum) As GLboolean
Declare Sub glMapVertexAttrib1dAPPLE(ByVal index As GLuint, ByVal size As GLuint, ByVal u1 As GLdouble, ByVal u2 As GLdouble, ByVal stride As GLint, ByVal order As GLint, ByVal points As GLdouble Ptr)
Declare Sub glMapVertexAttrib1fAPPLE(ByVal index As GLuint, ByVal size As GLuint, ByVal u1 As GLfloat, ByVal u2 As GLfloat, ByVal stride As GLint, ByVal order As GLint, ByVal points As GLfloat Ptr)
Declare Sub glMapVertexAttrib2dAPPLE(ByVal index As GLuint, ByVal size As GLuint, ByVal u1 As GLdouble, ByVal u2 As GLdouble, ByVal ustride As GLint, ByVal uorder As GLint, ByVal v1 As GLdouble, ByVal v2 As GLdouble, ByVal vstride As GLint, ByVal vorder As GLint, ByVal points As GLdouble Ptr)
Declare Sub glMapVertexAttrib2fAPPLE(ByVal index As GLuint, ByVal size As GLuint, ByVal u1 As GLfloat, ByVal u2 As GLfloat, ByVal ustride As GLint, ByVal uorder As GLint, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal vstride As GLint, ByVal vorder As GLint, ByVal points As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLENABLEVERTEXATTRIBAPPLEPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum)
Type PFNGLDISABLEVERTEXATTRIBAPPLEPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum)
Type PFNGLISVERTEXATTRIBENABLEDAPPLEPROC As Function(ByVal index As GLuint, ByVal pname As GLenum) As GLboolean
Type PFNGLMAPVERTEXATTRIB1DAPPLEPROC As Sub(ByVal index As GLuint, ByVal size As GLuint, ByVal u1 As GLdouble, ByVal u2 As GLdouble, ByVal stride As GLint, ByVal order As GLint, ByVal points As GLdouble Ptr)
Type PFNGLMAPVERTEXATTRIB1FAPPLEPROC As Sub(ByVal index As GLuint, ByVal size As GLuint, ByVal u1 As GLfloat, ByVal u2 As GLfloat, ByVal stride As GLint, ByVal order As GLint, ByVal points As GLfloat Ptr)
Type PFNGLMAPVERTEXATTRIB2DAPPLEPROC As Sub(ByVal index As GLuint, ByVal size As GLuint, ByVal u1 As GLdouble, ByVal u2 As GLdouble, ByVal ustride As GLint, ByVal uorder As GLint, ByVal v1 As GLdouble, ByVal v2 As GLdouble, ByVal vstride As GLint, ByVal vorder As GLint, ByVal points As GLdouble Ptr)
Type PFNGLMAPVERTEXATTRIB2FAPPLEPROC As Sub(ByVal index As GLuint, ByVal size As GLuint, ByVal u1 As GLfloat, ByVal u2 As GLfloat, ByVal ustride As GLint, ByVal uorder As GLint, ByVal v1 As GLfloat, ByVal v2 As GLfloat, ByVal vstride As GLint, ByVal vorder As GLint, ByVal points As GLfloat Ptr)
#EndIf

#Ifndef GL_APPLE_aux_depth_stencil
#define GL_APPLE_aux_depth_stencil 1
#EndIf

#Ifndef GL_APPLE_object_purgeable
#define GL_APPLE_object_purgeable 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glObjectPurgeableAPPLE(ByVal objectType As GLenum, ByVal Name As GLuint, ByVal option As GLenum) As GLenum
Declare Function glObjectUnpurgeableAPPLE(ByVal objectType As GLenum, ByVal Name As GLuint, ByVal option As GLenum) As GLenum
Declare Sub glGetObjectParameterivAPPLE(ByVal objectType As GLenum, ByVal Name As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLOBJECTPURGEABLEAPPLEPROC As Function(ByVal objectType As GLenum, ByVal Name As GLuint, ByVal option As GLenum) As GLenum
Type PFNGLOBJECTUNPURGEABLEAPPLEPROC As Function(ByVal objectType As GLenum, ByVal Name As GLuint, ByVal option As GLenum) As GLenum
Type PFNGLGETOBJECTPARAMETERIVAPPLEPROC As Sub(ByVal objectType As GLenum, ByVal Name As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
#EndIf

#Ifndef GL_APPLE_row_bytes
#define GL_APPLE_row_bytes 1
#EndIf

#Ifndef GL_APPLE_rgb_422
#define GL_APPLE_rgb_422 1
#EndIf

#Ifndef GL_NV_video_capture
#define GL_NV_video_capture 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBeginVideoCaptureNV(ByVal video_capture_slot As GLuint)
Declare Sub glBindVideoCaptureStreamBufferNV(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal frame_region As GLenum, ByVal offset As GLintptrARB)
Declare Sub glBindVideoCaptureStreamTextureNV(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal frame_region As GLenum, ByVal target As GLenum, ByVal texture As GLuint)
Declare Sub glEndVideoCaptureNV(ByVal video_capture_slot As GLuint)
Declare Sub glGetVideoCaptureivNV(ByVal video_capture_slot As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetVideoCaptureStreamivNV(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glGetVideoCaptureStreamfvNV(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glGetVideoCaptureStreamdvNV(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Declare Function glVideoCaptureNV(ByVal video_capture_slot As GLuint, ByVal sequence_num As GLuint Ptr, ByVal capture_time As GLuint64EXT Ptr) As GLenum
Declare Sub glVideoCaptureStreamParameterivNV(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Declare Sub glVideoCaptureStreamParameterfvNV(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Declare Sub glVideoCaptureStreamParameterdvNV(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBEGINVIDEOCAPTURENVPROC As Sub(ByVal video_capture_slot As GLuint)
Type PFNGLBINDVIDEOCAPTURESTREAMBUFFERNVPROC As Sub(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal frame_region As GLenum, ByVal offset As GLintptrARB)
Type PFNGLBINDVIDEOCAPTURESTREAMTEXTURENVPROC As Sub(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal frame_region As GLenum, ByVal target As GLenum, ByVal texture As GLuint)
Type PFNGLENDVIDEOCAPTURENVPROC As Sub(ByVal video_capture_slot As GLuint)
Type PFNGLGETVIDEOCAPTUREIVNVPROC As Sub(ByVal video_capture_slot As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETVIDEOCAPTURESTREAMIVNVPROC As Sub(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLGETVIDEOCAPTURESTREAMFVNVPROC As Sub(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLGETVIDEOCAPTURESTREAMDVNVPROC As Sub(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Type PFNGLVIDEOCAPTURENVPROC As Function(ByVal video_capture_slot As GLuint, ByVal sequence_num As GLuint Ptr, ByVal capture_time As GLuint64EXT Ptr) As GLenum
Type PFNGLVIDEOCAPTURESTREAMPARAMETERIVNVPROC As Sub(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal pname As GLenum, ByVal params As GLint Ptr)
Type PFNGLVIDEOCAPTURESTREAMPARAMETERFVNVPROC As Sub(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal pname As GLenum, ByVal params As GLfloat Ptr)
Type PFNGLVIDEOCAPTURESTREAMPARAMETERDVNVPROC As Sub(ByVal video_capture_slot As GLuint, ByVal stream As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
#EndIf

#Ifndef GL_NV_copy_image
#define GL_NV_copy_image 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glCopyImageSubDataNV(ByVal srcName As GLuint, ByVal srcTarget As GLenum, ByVal srcLevel As GLint, ByVal srcX As GLint, ByVal srcY As GLint, ByVal srcZ As GLint, ByVal dstName As GLuint, ByVal dstTarget As GLenum, ByVal dstLevel As GLint, ByVal dstX As GLint, ByVal dstY As GLint, ByVal dstZ As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLCOPYIMAGESUBDATANVPROC As Sub(ByVal srcName As GLuint, ByVal srcTarget As GLenum, ByVal srcLevel As GLint, ByVal srcX As GLint, ByVal srcY As GLint, ByVal srcZ As GLint, ByVal dstName As GLuint, ByVal dstTarget As GLenum, ByVal dstLevel As GLint, ByVal dstX As GLint, ByVal dstY As GLint, ByVal dstZ As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei)
#EndIf

#Ifndef GL_EXT_separate_shader_objects
#define GL_EXT_separate_shader_objects 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glUseShaderProgramEXT(ByVal Type As GLenum, ByVal program As GLuint)
Declare Sub glActiveProgramEXT(ByVal program As GLuint)
Declare Function glCreateShaderProgramEXT(ByVal Type As GLenum, ByVal String As GLchar Ptr) As GLuint
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLUSESHADERPROGRAMEXTPROC As Sub(ByVal Type As GLenum, ByVal program As GLuint)
Type PFNGLACTIVEPROGRAMEXTPROC As Sub(ByVal program As GLuint)
Type PFNGLCREATESHADERPROGRAMEXTPROC As Function(ByVal Type As GLenum, ByVal String As GLchar Ptr) As GLuint
#EndIf

#Ifndef GL_NV_parameter_buffer_object2
#define GL_NV_parameter_buffer_object2 1
#EndIf

#Ifndef GL_NV_shader_buffer_load
#define GL_NV_shader_buffer_load 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glMakeBufferResidentNV(ByVal target As GLenum, ByVal Access As GLenum)
Declare Sub glMakeBufferNonResidentNV(ByVal target As GLenum)
Declare Function glIsBufferResidentNV(ByVal target As GLenum) As GLboolean
Declare Sub glMakeNamedBufferResidentNV(ByVal buffer As GLuint, ByVal Access As GLenum)
Declare Sub glMakeNamedBufferNonResidentNV(ByVal buffer As GLuint)
Declare Function glIsNamedBufferResidentNV(ByVal buffer As GLuint) As GLboolean
Declare Sub glGetBufferParameterui64vNV(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint64EXT Ptr)
Declare Sub glGetNamedBufferParameterui64vNV(ByVal buffer As GLuint, ByVal pname As GLenum, ByVal params As GLuint64EXT Ptr)
Declare Sub glGetIntegerui64vNV(ByVal value As GLenum, ByVal result As GLuint64EXT Ptr)
Declare Sub glUniformui64NV(ByVal location As GLint, ByVal value As GLuint64EXT)
Declare Sub glUniformui64vNV(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Declare Sub glGetUniformui64vNV(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLuint64EXT Ptr)
Declare Sub glProgramUniformui64NV(ByVal program As GLuint, ByVal location As GLint, ByVal value As GLuint64EXT)
Declare Sub glProgramUniformui64vNV(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLMAKEBUFFERRESIDENTNVPROC As Sub(ByVal target As GLenum, ByVal Access As GLenum)
Type PFNGLMAKEBUFFERNONRESIDENTNVPROC As Sub(ByVal target As GLenum)
Type PFNGLISBUFFERRESIDENTNVPROC As Function(ByVal target As GLenum) As GLboolean
Type PFNGLMAKENAMEDBUFFERRESIDENTNVPROC As Sub(ByVal buffer As GLuint, ByVal Access As GLenum)
Type PFNGLMAKENAMEDBUFFERNONRESIDENTNVPROC As Sub(ByVal buffer As GLuint)
Type PFNGLISNAMEDBUFFERRESIDENTNVPROC As Function(ByVal buffer As GLuint) As GLboolean
Type PFNGLGETBUFFERPARAMETERUI64VNVPROC As Sub(ByVal target As GLenum, ByVal pname As GLenum, ByVal params As GLuint64EXT Ptr)
Type PFNGLGETNAMEDBUFFERPARAMETERUI64VNVPROC As Sub(ByVal buffer As GLuint, ByVal pname As GLenum, ByVal params As GLuint64EXT Ptr)
Type PFNGLGETINTEGERUI64VNVPROC As Sub(ByVal value As GLenum, ByVal result As GLuint64EXT Ptr)
Type PFNGLUNIFORMUI64NVPROC As Sub(ByVal location As GLint, ByVal value As GLuint64EXT)
Type PFNGLUNIFORMUI64VNVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Type PFNGLGETUNIFORMUI64VNVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLuint64EXT Ptr)
Type PFNGLPROGRAMUNIFORMUI64NVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal value As GLuint64EXT)
Type PFNGLPROGRAMUNIFORMUI64VNVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
#EndIf

#Ifndef GL_NV_vertex_buffer_unified_memory
#define GL_NV_vertex_buffer_unified_memory 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBufferAddressRangeNV(ByVal pname As GLenum, ByVal index As GLuint, ByVal address As GLuint64EXT, ByVal length As GLsizeiptr)
Declare Sub glVertexFormatNV(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei)
Declare Sub glNormalFormatNV(ByVal Type As GLenum, ByVal stride As GLsizei)
Declare Sub glColorFormatNV(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei)
Declare Sub glIndexFormatNV(ByVal Type As GLenum, ByVal stride As GLsizei)
Declare Sub glTexCoordFormatNV(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei)
Declare Sub glEdgeFlagFormatNV(ByVal stride As GLsizei)
Declare Sub glSecondaryColorFormatNV(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei)
Declare Sub glFogCoordFormatNV(ByVal Type As GLenum, ByVal stride As GLsizei)
Declare Sub glVertexAttribFormatNV(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal stride As GLsizei)
Declare Sub glVertexAttribIFormatNV(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei)
Declare Sub glGetIntegerui64i_vNV(ByVal value As GLenum, ByVal index As GLuint, ByVal result As GLuint64EXT Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBUFFERADDRESSRANGENVPROC As Sub(ByVal pname As GLenum, ByVal index As GLuint, ByVal address As GLuint64EXT, ByVal length As GLsizeiptr)
Type PFNGLVERTEXFORMATNVPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei)
Type PFNGLNORMALFORMATNVPROC As Sub(ByVal Type As GLenum, ByVal stride As GLsizei)
Type PFNGLCOLORFORMATNVPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei)
Type PFNGLINDEXFORMATNVPROC As Sub(ByVal Type As GLenum, ByVal stride As GLsizei)
Type PFNGLTEXCOORDFORMATNVPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei)
Type PFNGLEDGEFLAGFORMATNVPROC As Sub(ByVal stride As GLsizei)
Type PFNGLSECONDARYCOLORFORMATNVPROC As Sub(ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei)
Type PFNGLFOGCOORDFORMATNVPROC As Sub(ByVal Type As GLenum, ByVal stride As GLsizei)
Type PFNGLVERTEXATTRIBFORMATNVPROC As Sub(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal normalized As GLboolean, ByVal stride As GLsizei)
Type PFNGLVERTEXATTRIBIFORMATNVPROC As Sub(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei)
Type PFNGLGETINTEGERUI64I_VNVPROC As Sub(ByVal value As GLenum, ByVal index As GLuint, ByVal result As GLuint64EXT Ptr)
#EndIf

#Ifndef GL_NV_texture_barrier
#define GL_NV_texture_barrier 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTextureBarrierNV()
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXTUREBARRIERNVPROC As Sub()
#EndIf

#Ifndef GL_AMD_shader_stencil_export
#define GL_AMD_shader_stencil_export 1
#EndIf

#Ifndef GL_AMD_seamless_cubemap_per_texture
#define GL_AMD_seamless_cubemap_per_texture 1
#EndIf

#Ifndef GL_AMD_conservative_depth
#define GL_AMD_conservative_depth 1
#EndIf

#Ifndef GL_EXT_shader_image_load_store
#define GL_EXT_shader_image_load_store 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glBindImageTextureEXT(ByVal index As GLuint, ByVal texture As GLuint, ByVal level As GLint, ByVal layered As GLboolean, ByVal layer As GLint, ByVal Access As GLenum, ByVal Format As GLint)
Declare Sub glMemoryBarrierEXT(ByVal barriers As GLbitfield)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLBINDIMAGETEXTUREEXTPROC As Sub(ByVal index As GLuint, ByVal texture As GLuint, ByVal level As GLint, ByVal layered As GLboolean, ByVal layer As GLint, ByVal Access As GLenum, ByVal Format As GLint)
Type PFNGLMEMORYBARRIEREXTPROC As Sub(ByVal barriers As GLbitfield)
#EndIf

#Ifndef GL_EXT_vertex_attrib_64bit
#define GL_EXT_vertex_attrib_64bit 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexAttribL1dEXT(ByVal index As GLuint, ByVal x As GLdouble)
Declare Sub glVertexAttribL2dEXT(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble)
Declare Sub glVertexAttribL3dEXT(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Declare Sub glVertexAttribL4dEXT(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Declare Sub glVertexAttribL1dvEXT(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttribL2dvEXT(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttribL3dvEXT(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttribL4dvEXT(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Declare Sub glVertexAttribLPointerEXT(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Declare Sub glGetVertexAttribLdvEXT(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Declare Sub glVertexArrayVertexAttribLOffsetEXT(ByVal vaobj As GLuint, ByVal buffer As GLuint, ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal offset As GLintptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXATTRIBL1DEXTPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble)
Type PFNGLVERTEXATTRIBL2DEXTPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble)
Type PFNGLVERTEXATTRIBL3DEXTPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble)
Type PFNGLVERTEXATTRIBL4DEXTPROC As Sub(ByVal index As GLuint, ByVal x As GLdouble, ByVal y As GLdouble, ByVal z As GLdouble, ByVal w As GLdouble)
Type PFNGLVERTEXATTRIBL1DVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIBL2DVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIBL3DVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIBL4DVEXTPROC As Sub(ByVal index As GLuint, ByVal v As GLdouble Ptr)
Type PFNGLVERTEXATTRIBLPOINTEREXTPROC As Sub(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal Pointer As GLvoid Ptr)
Type PFNGLGETVERTEXATTRIBLDVEXTPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLdouble Ptr)
Type PFNGLVERTEXARRAYVERTEXATTRIBLOFFSETEXTPROC As Sub(ByVal vaobj As GLuint, ByVal buffer As GLuint, ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei, ByVal offset As GLintptr)
#EndIf

#Ifndef GL_NV_gpu_program5
#define GL_NV_gpu_program5 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glProgramSubroutineParametersuivNV(ByVal target As GLenum, ByVal count As GLsizei, ByVal params As GLuint Ptr)
Declare Sub glGetProgramSubroutineParameteruivNV(ByVal target As GLenum, ByVal index As GLuint, ByVal param As GLuint Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLPROGRAMSUBROUTINEPARAMETERSUIVNVPROC As Sub(ByVal target As GLenum, ByVal count As GLsizei, ByVal params As GLuint Ptr)
Type PFNGLGETPROGRAMSUBROUTINEPARAMETERUIVNVPROC As Sub(ByVal target As GLenum, ByVal index As GLuint, ByVal param As GLuint Ptr)
#EndIf

#Ifndef GL_NV_gpu_shader5
#define GL_NV_gpu_shader5 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glUniform1i64NV(ByVal location As GLint, ByVal x As GLint64EXT)
Declare Sub glUniform2i64NV(ByVal location As GLint, ByVal x As GLint64EXT, ByVal y As GLint64EXT)
Declare Sub glUniform3i64NV(ByVal location As GLint, ByVal x As GLint64EXT, ByVal y As GLint64EXT, ByVal z As GLint64EXT)
Declare Sub glUniform4i64NV(ByVal location As GLint, ByVal x As GLint64EXT, ByVal y As GLint64EXT, ByVal z As GLint64EXT, ByVal w As GLint64EXT)
Declare Sub glUniform1i64vNV(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Declare Sub glUniform2i64vNV(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Declare Sub glUniform3i64vNV(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Declare Sub glUniform4i64vNV(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Declare Sub glUniform1ui64NV(ByVal location As GLint, ByVal x As GLuint64EXT)
Declare Sub glUniform2ui64NV(ByVal location As GLint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT)
Declare Sub glUniform3ui64NV(ByVal location As GLint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT, ByVal z As GLuint64EXT)
Declare Sub glUniform4ui64NV(ByVal location As GLint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT, ByVal z As GLuint64EXT, ByVal w As GLuint64EXT)
Declare Sub glUniform1ui64vNV(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Declare Sub glUniform2ui64vNV(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Declare Sub glUniform3ui64vNV(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Declare Sub glUniform4ui64vNV(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Declare Sub glGetUniformi64vNV(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLint64EXT Ptr)
Declare Sub glProgramUniform1i64NV(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLint64EXT)
Declare Sub glProgramUniform2i64NV(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLint64EXT, ByVal y As GLint64EXT)
Declare Sub glProgramUniform3i64NV(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLint64EXT, ByVal y As GLint64EXT, ByVal z As GLint64EXT)
Declare Sub glProgramUniform4i64NV(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLint64EXT, ByVal y As GLint64EXT, ByVal z As GLint64EXT, ByVal w As GLint64EXT)
Declare Sub glProgramUniform1i64vNV(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Declare Sub glProgramUniform2i64vNV(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Declare Sub glProgramUniform3i64vNV(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Declare Sub glProgramUniform4i64vNV(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Declare Sub glProgramUniform1ui64NV(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLuint64EXT)
Declare Sub glProgramUniform2ui64NV(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT)
Declare Sub glProgramUniform3ui64NV(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT, ByVal z As GLuint64EXT)
Declare Sub glProgramUniform4ui64NV(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT, ByVal z As GLuint64EXT, ByVal w As GLuint64EXT)
Declare Sub glProgramUniform1ui64vNV(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Declare Sub glProgramUniform2ui64vNV(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Declare Sub glProgramUniform3ui64vNV(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Declare Sub glProgramUniform4ui64vNV(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLUNIFORM1I64NVPROC As Sub(ByVal location As GLint, ByVal x As GLint64EXT)
Type PFNGLUNIFORM2I64NVPROC As Sub(ByVal location As GLint, ByVal x As GLint64EXT, ByVal y As GLint64EXT)
Type PFNGLUNIFORM3I64NVPROC As Sub(ByVal location As GLint, ByVal x As GLint64EXT, ByVal y As GLint64EXT, ByVal z As GLint64EXT)
Type PFNGLUNIFORM4I64NVPROC As Sub(ByVal location As GLint, ByVal x As GLint64EXT, ByVal y As GLint64EXT, ByVal z As GLint64EXT, ByVal w As GLint64EXT)
Type PFNGLUNIFORM1I64VNVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Type PFNGLUNIFORM2I64VNVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Type PFNGLUNIFORM3I64VNVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Type PFNGLUNIFORM4I64VNVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Type PFNGLUNIFORM1UI64NVPROC As Sub(ByVal location As GLint, ByVal x As GLuint64EXT)
Type PFNGLUNIFORM2UI64NVPROC As Sub(ByVal location As GLint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT)
Type PFNGLUNIFORM3UI64NVPROC As Sub(ByVal location As GLint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT, ByVal z As GLuint64EXT)
Type PFNGLUNIFORM4UI64NVPROC As Sub(ByVal location As GLint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT, ByVal z As GLuint64EXT, ByVal w As GLuint64EXT)
Type PFNGLUNIFORM1UI64VNVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Type PFNGLUNIFORM2UI64VNVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Type PFNGLUNIFORM3UI64VNVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Type PFNGLUNIFORM4UI64VNVPROC As Sub(ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Type PFNGLGETUNIFORMI64VNVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal params As GLint64EXT Ptr)
Type PFNGLPROGRAMUNIFORM1I64NVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLint64EXT)
Type PFNGLPROGRAMUNIFORM2I64NVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLint64EXT, ByVal y As GLint64EXT)
Type PFNGLPROGRAMUNIFORM3I64NVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLint64EXT, ByVal y As GLint64EXT, ByVal z As GLint64EXT)
Type PFNGLPROGRAMUNIFORM4I64NVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLint64EXT, ByVal y As GLint64EXT, ByVal z As GLint64EXT, ByVal w As GLint64EXT)
Type PFNGLPROGRAMUNIFORM1I64VNVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Type PFNGLPROGRAMUNIFORM2I64VNVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Type PFNGLPROGRAMUNIFORM3I64VNVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Type PFNGLPROGRAMUNIFORM4I64VNVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLint64EXT Ptr)
Type PFNGLPROGRAMUNIFORM1UI64NVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLuint64EXT)
Type PFNGLPROGRAMUNIFORM2UI64NVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT)
Type PFNGLPROGRAMUNIFORM3UI64NVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT, ByVal z As GLuint64EXT)
Type PFNGLPROGRAMUNIFORM4UI64NVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT, ByVal z As GLuint64EXT, ByVal w As GLuint64EXT)
Type PFNGLPROGRAMUNIFORM1UI64VNVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Type PFNGLPROGRAMUNIFORM2UI64VNVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Type PFNGLPROGRAMUNIFORM3UI64VNVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
Type PFNGLPROGRAMUNIFORM4UI64VNVPROC As Sub(ByVal program As GLuint, ByVal location As GLint, ByVal count As GLsizei, ByVal value As GLuint64EXT Ptr)
#EndIf

#Ifndef GL_NV_shader_buffer_store
#define GL_NV_shader_buffer_store 1
#EndIf

#Ifndef GL_NV_tessellation_program5
#define GL_NV_tessellation_program5 1
#EndIf

#Ifndef GL_NV_vertex_attrib_integer_64bit
#define GL_NV_vertex_attrib_integer_64bit 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVertexAttribL1i64NV(ByVal index As GLuint, ByVal x As GLint64EXT)
Declare Sub glVertexAttribL2i64NV(ByVal index As GLuint, ByVal x As GLint64EXT, ByVal y As GLint64EXT)
Declare Sub glVertexAttribL3i64NV(ByVal index As GLuint, ByVal x As GLint64EXT, ByVal y As GLint64EXT, ByVal z As GLint64EXT)
Declare Sub glVertexAttribL4i64NV(ByVal index As GLuint, ByVal x As GLint64EXT, ByVal y As GLint64EXT, ByVal z As GLint64EXT, ByVal w As GLint64EXT)
Declare Sub glVertexAttribL1i64vNV(ByVal index As GLuint, ByVal v As GLint64EXT Ptr)
Declare Sub glVertexAttribL2i64vNV(ByVal index As GLuint, ByVal v As GLint64EXT Ptr)
Declare Sub glVertexAttribL3i64vNV(ByVal index As GLuint, ByVal v As GLint64EXT Ptr)
Declare Sub glVertexAttribL4i64vNV(ByVal index As GLuint, ByVal v As GLint64EXT Ptr)
Declare Sub glVertexAttribL1ui64NV(ByVal index As GLuint, ByVal x As GLuint64EXT)
Declare Sub glVertexAttribL2ui64NV(ByVal index As GLuint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT)
Declare Sub glVertexAttribL3ui64NV(ByVal index As GLuint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT, ByVal z As GLuint64EXT)
Declare Sub glVertexAttribL4ui64NV(ByVal index As GLuint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT, ByVal z As GLuint64EXT, ByVal w As GLuint64EXT)
Declare Sub glVertexAttribL1ui64vNV(ByVal index As GLuint, ByVal v As GLuint64EXT Ptr)
Declare Sub glVertexAttribL2ui64vNV(ByVal index As GLuint, ByVal v As GLuint64EXT Ptr)
Declare Sub glVertexAttribL3ui64vNV(ByVal index As GLuint, ByVal v As GLuint64EXT Ptr)
Declare Sub glVertexAttribL4ui64vNV(ByVal index As GLuint, ByVal v As GLuint64EXT Ptr)
Declare Sub glGetVertexAttribLi64vNV(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint64EXT Ptr)
Declare Sub glGetVertexAttribLui64vNV(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLuint64EXT Ptr)
Declare Sub glVertexAttribLFormatNV(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVERTEXATTRIBL1I64NVPROC As Sub(ByVal index As GLuint, ByVal x As GLint64EXT)
Type PFNGLVERTEXATTRIBL2I64NVPROC As Sub(ByVal index As GLuint, ByVal x As GLint64EXT, ByVal y As GLint64EXT)
Type PFNGLVERTEXATTRIBL3I64NVPROC As Sub(ByVal index As GLuint, ByVal x As GLint64EXT, ByVal y As GLint64EXT, ByVal z As GLint64EXT)
Type PFNGLVERTEXATTRIBL4I64NVPROC As Sub(ByVal index As GLuint, ByVal x As GLint64EXT, ByVal y As GLint64EXT, ByVal z As GLint64EXT, ByVal w As GLint64EXT)
Type PFNGLVERTEXATTRIBL1I64VNVPROC As Sub(ByVal index As GLuint, ByVal v As GLint64EXT Ptr)
Type PFNGLVERTEXATTRIBL2I64VNVPROC As Sub(ByVal index As GLuint, ByVal v As GLint64EXT Ptr)
Type PFNGLVERTEXATTRIBL3I64VNVPROC As Sub(ByVal index As GLuint, ByVal v As GLint64EXT Ptr)
Type PFNGLVERTEXATTRIBL4I64VNVPROC As Sub(ByVal index As GLuint, ByVal v As GLint64EXT Ptr)
Type PFNGLVERTEXATTRIBL1UI64NVPROC As Sub(ByVal index As GLuint, ByVal x As GLuint64EXT)
Type PFNGLVERTEXATTRIBL2UI64NVPROC As Sub(ByVal index As GLuint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT)
Type PFNGLVERTEXATTRIBL3UI64NVPROC As Sub(ByVal index As GLuint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT, ByVal z As GLuint64EXT)
Type PFNGLVERTEXATTRIBL4UI64NVPROC As Sub(ByVal index As GLuint, ByVal x As GLuint64EXT, ByVal y As GLuint64EXT, ByVal z As GLuint64EXT, ByVal w As GLuint64EXT)
Type PFNGLVERTEXATTRIBL1UI64VNVPROC As Sub(ByVal index As GLuint, ByVal v As GLuint64EXT Ptr)
Type PFNGLVERTEXATTRIBL2UI64VNVPROC As Sub(ByVal index As GLuint, ByVal v As GLuint64EXT Ptr)
Type PFNGLVERTEXATTRIBL3UI64VNVPROC As Sub(ByVal index As GLuint, ByVal v As GLuint64EXT Ptr)
Type PFNGLVERTEXATTRIBL4UI64VNVPROC As Sub(ByVal index As GLuint, ByVal v As GLuint64EXT Ptr)
Type PFNGLGETVERTEXATTRIBLI64VNVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLint64EXT Ptr)
Type PFNGLGETVERTEXATTRIBLUI64VNVPROC As Sub(ByVal index As GLuint, ByVal pname As GLenum, ByVal params As GLuint64EXT Ptr)
Type PFNGLVERTEXATTRIBLFORMATNVPROC As Sub(ByVal index As GLuint, ByVal size As GLint, ByVal Type As GLenum, ByVal stride As GLsizei)
#EndIf

#Ifndef GL_NV_multisample_coverage
#define GL_NV_multisample_coverage 1
#EndIf

#Ifndef GL_AMD_name_gen_delete
#define GL_AMD_name_gen_delete 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glGenNamesAMD(ByVal identifier As GLenum, ByVal num As GLuint, ByVal names As GLuint Ptr)
Declare Sub glDeleteNamesAMD(ByVal identifier As GLenum, ByVal num As GLuint, ByVal names As GLuint Ptr)
Declare Function glIsNameAMD(ByVal identifier As GLenum, ByVal Name As GLuint) As GLboolean
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLGENNAMESAMDPROC As Sub(ByVal identifier As GLenum, ByVal num As GLuint, ByVal names As GLuint Ptr)
Type PFNGLDELETENAMESAMDPROC As Sub(ByVal identifier As GLenum, ByVal num As GLuint, ByVal names As GLuint Ptr)
Type PFNGLISNAMEAMDPROC As Function(ByVal identifier As GLenum, ByVal Name As GLuint) As GLboolean
#EndIf

#Ifndef GL_AMD_debug_output
#define GL_AMD_debug_output 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glDebugMessageEnableAMD(ByVal category As GLenum, ByVal severity As GLenum, ByVal count As GLsizei, ByVal ids As GLuint Ptr, ByVal enabled As GLboolean)
Declare Sub glDebugMessageInsertAMD(ByVal category As GLenum, ByVal severity As GLenum, ByVal id As GLuint, ByVal length As GLsizei, ByVal buf As GLchar Ptr)
Declare Sub glDebugMessageCallbackAMD(ByVal callback As GLDEBUGPROCAMD, ByVal userParam As GLvoid Ptr)
Declare Function glGetDebugMessageLogAMD(ByVal count As GLuint, ByVal bufsize As GLsizei, ByVal categories As GLenum Ptr, ByVal severities As GLuint Ptr, ByVal ids As GLuint Ptr, ByVal lengths As GLsizei Ptr, ByVal message As GLchar Ptr) As GLuint
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLDEBUGMESSAGEENABLEAMDPROC As Sub(ByVal category As GLenum, ByVal severity As GLenum, ByVal count As GLsizei, ByVal ids As GLuint Ptr, ByVal enabled As GLboolean)
Type PFNGLDEBUGMESSAGEINSERTAMDPROC As Sub(ByVal category As GLenum, ByVal severity As GLenum, ByVal id As GLuint, ByVal length As GLsizei, ByVal buf As GLchar Ptr)
Type PFNGLDEBUGMESSAGECALLBACKAMDPROC As Sub(ByVal callback As GLDEBUGPROCAMD, ByVal userParam As GLvoid Ptr)
Type PFNGLGETDEBUGMESSAGELOGAMDPROC As Function(ByVal count As GLuint, ByVal bufsize As GLsizei, ByVal categories As GLenum Ptr, ByVal severities As GLuint Ptr, ByVal ids As GLuint Ptr, ByVal lengths As GLsizei Ptr, ByVal message As GLchar Ptr) As GLuint
#EndIf

#Ifndef GL_NV_vdpau_interop
#define GL_NV_vdpau_interop 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glVDPAUInitNV(ByVal vdpDevice As GLvoid Ptr, ByVal getProcAddress As GLvoid Ptr)
Declare Sub glVDPAUFiniNV()
Declare Function glVDPAURegisterVideoSurfaceNV(ByVal vdpSurface As GLvoid Ptr, ByVal target As GLenum, ByVal numTextureNames As GLsizei, ByVal textureNames As GLuint Ptr) As GLvdpauSurfaceNV
Declare Function glVDPAURegisterOutputSurfaceNV(ByVal vdpSurface As GLvoid Ptr, ByVal target As GLenum, ByVal numTextureNames As GLsizei, ByVal textureNames As GLuint Ptr) As GLvdpauSurfaceNV
Declare Sub glVDPAUIsSurfaceNV(ByVal surface As GLvdpauSurfaceNV)
Declare Sub glVDPAUUnregisterSurfaceNV(ByVal surface As GLvdpauSurfaceNV)
Declare Sub glVDPAUGetSurfaceivNV(ByVal surface As GLvdpauSurfaceNV, ByVal pname As GLenum, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal values As GLint Ptr)
Declare Sub glVDPAUSurfaceAccessNV(ByVal surface As GLvdpauSurfaceNV, ByVal Access As GLenum)
Declare Sub glVDPAUMapSurfacesNV(ByVal numSurfaces As GLsizei, ByVal surfaces As GLvdpauSurfaceNV Ptr)
Declare Sub glVDPAUUnmapSurfacesNV(ByVal numSurface As GLsizei, ByVal surfaces As GLvdpauSurfaceNV Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLVDPAUINITNVPROC As Sub(ByVal vdpDevice As GLvoid Ptr, ByVal getProcAddress As GLvoid Ptr)
Type PFNGLVDPAUFININVPROC As Sub()
Type PFNGLVDPAUREGISTERVIDEOSURFACENVPROC As Function(ByVal vdpSurface As GLvoid Ptr, ByVal target As GLenum, ByVal numTextureNames As GLsizei, ByVal textureNames As GLuint Ptr) As GLvdpauSurfaceNV
Type PFNGLVDPAUREGISTEROUTPUTSURFACENVPROC As Function(ByVal vdpSurface As GLvoid Ptr, ByVal target As GLenum, ByVal numTextureNames As GLsizei, ByVal textureNames As GLuint Ptr) As GLvdpauSurfaceNV
Type PFNGLVDPAUISSURFACENVPROC As Sub(ByVal surface As GLvdpauSurfaceNV)
Type PFNGLVDPAUUNREGISTERSURFACENVPROC As Sub(ByVal surface As GLvdpauSurfaceNV)
Type PFNGLVDPAUGETSURFACEIVNVPROC As Sub(ByVal surface As GLvdpauSurfaceNV, ByVal pname As GLenum, ByVal bufSize As GLsizei, ByVal length As GLsizei Ptr, ByVal values As GLint Ptr)
Type PFNGLVDPAUSURFACEACCESSNVPROC As Sub(ByVal surface As GLvdpauSurfaceNV, ByVal Access As GLenum)
Type PFNGLVDPAUMAPSURFACESNVPROC As Sub(ByVal numSurfaces As GLsizei, ByVal surfaces As GLvdpauSurfaceNV Ptr)
Type PFNGLVDPAUUNMAPSURFACESNVPROC As Sub(ByVal numSurface As GLsizei, ByVal surfaces As GLvdpauSurfaceNV Ptr)
#EndIf

#Ifndef GL_AMD_transform_feedback3_lines_triangles
#define GL_AMD_transform_feedback3_lines_triangles 1
#EndIf

#Ifndef GL_AMD_depth_clamp_separate
#define GL_AMD_depth_clamp_separate 1
#EndIf

#Ifndef GL_EXT_texture_sRGB_decode
#define GL_EXT_texture_sRGB_decode 1
#EndIf

#Ifndef GL_NV_texture_multisample
#define GL_NV_texture_multisample 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glTexImage2DMultisampleCoverageNV(ByVal target As GLenum, ByVal coverageSamples As GLsizei, ByVal colorSamples As GLsizei, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal fixedSampleLocations As GLboolean)
Declare Sub glTexImage3DMultisampleCoverageNV(ByVal target As GLenum, ByVal coverageSamples As GLsizei, ByVal colorSamples As GLsizei, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal fixedSampleLocations As GLboolean)
Declare Sub glTextureImage2DMultisampleNV(ByVal texture As GLuint, ByVal target As GLenum, ByVal samples As GLsizei, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal fixedSampleLocations As GLboolean)
Declare Sub glTextureImage3DMultisampleNV(ByVal texture As GLuint, ByVal target As GLenum, ByVal samples As GLsizei, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal fixedSampleLocations As GLboolean)
Declare Sub glTextureImage2DMultisampleCoverageNV(ByVal texture As GLuint, ByVal target As GLenum, ByVal coverageSamples As GLsizei, ByVal colorSamples As GLsizei, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal fixedSampleLocations As GLboolean)
Declare Sub glTextureImage3DMultisampleCoverageNV(ByVal texture As GLuint, ByVal target As GLenum, ByVal coverageSamples As GLsizei, ByVal colorSamples As GLsizei, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal fixedSampleLocations As GLboolean)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLTEXIMAGE2DMULTISAMPLECOVERAGENVPROC As Sub(ByVal target As GLenum, ByVal coverageSamples As GLsizei, ByVal colorSamples As GLsizei, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal fixedSampleLocations As GLboolean)
Type PFNGLTEXIMAGE3DMULTISAMPLECOVERAGENVPROC As Sub(ByVal target As GLenum, ByVal coverageSamples As GLsizei, ByVal colorSamples As GLsizei, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal fixedSampleLocations As GLboolean)
Type PFNGLTEXTUREIMAGE2DMULTISAMPLENVPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal samples As GLsizei, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal fixedSampleLocations As GLboolean)
Type PFNGLTEXTUREIMAGE3DMULTISAMPLENVPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal samples As GLsizei, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal fixedSampleLocations As GLboolean)
Type PFNGLTEXTUREIMAGE2DMULTISAMPLECOVERAGENVPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal coverageSamples As GLsizei, ByVal colorSamples As GLsizei, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal fixedSampleLocations As GLboolean)
Type PFNGLTEXTUREIMAGE3DMULTISAMPLECOVERAGENVPROC As Sub(ByVal texture As GLuint, ByVal target As GLenum, ByVal coverageSamples As GLsizei, ByVal colorSamples As GLsizei, ByVal internalFormat As GLint, ByVal Width As GLsizei, ByVal height As GLsizei, ByVal depth As GLsizei, ByVal fixedSampleLocations As GLboolean)
#EndIf

#Ifndef GL_AMD_blend_minmax_factor
#define GL_AMD_blend_minmax_factor 1
#EndIf

#Ifndef GL_AMD_sample_positions
#define GL_AMD_sample_positions 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glSetMultisamplefvAMD(ByVal pname As GLenum, ByVal index As GLuint, ByVal Val As GLfloat Ptr)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLSETMULTISAMPLEFVAMDPROC As Sub(ByVal pname As GLenum, ByVal index As GLuint, ByVal Val As GLfloat Ptr)
#EndIf

#Ifndef GL_EXT_x11_sync_object
#define GL_EXT_x11_sync_object 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Function glImportSyncEXT(ByVal external_sync_type As GLenum, ByVal external_sync As GLintptr, ByVal flags As GLbitfield) As GLsync
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLIMPORTSYNCEXTPROC As Function(ByVal external_sync_type As GLenum, ByVal external_sync As GLintptr, ByVal flags As GLbitfield) As GLsync
#EndIf

#Ifndef GL_AMD_multi_draw_indirect
#define GL_AMD_multi_draw_indirect 1
#Ifdef GL_GLEXT_PROTOTYPES
Declare Sub glMultiDrawArraysIndirectAMD(ByVal mode As GLenum, ByVal indirect As GLvoid Ptr, ByVal primcount As GLsizei, ByVal stride As GLsizei)
Declare Sub glMultiDrawElementsIndirectAMD(ByVal mode As GLenum, ByVal Type As GLenum, ByVal indirect As GLvoid Ptr, ByVal primcount As GLsizei, ByVal stride As GLsizei)
#EndIf /' GL_GLEXT_PROTOTYPES '/
Type PFNGLMULTIDRAWARRAYSINDIRECTAMDPROC As Sub(ByVal mode As GLenum, ByVal indirect As GLvoid Ptr, ByVal primcount As GLsizei, ByVal stride As GLsizei)
Type PFNGLMULTIDRAWELEMENTSINDIRECTAMDPROC As Sub(ByVal mode As GLenum, ByVal Type As GLenum, ByVal indirect As GLvoid Ptr, ByVal primcount As GLsizei, ByVal stride As GLsizei)
#EndIf

#Ifndef GL_EXT_framebuffer_multisample_blit_scaled
#define GL_EXT_framebuffer_multisample_blit_scaled 1
#EndIf


End Extern

#EndIf
