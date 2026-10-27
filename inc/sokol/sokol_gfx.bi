'' FreeBASIC binding for sokol_gfx
''
'' Generated with fbfrog from sokol_gfx.h; do not edit by hand.
'' Pinned source: sokol 79611ab0d5e9 (2024-05-11), sokol_gfx.h
'' sha256 34dcb2c5e0df3904bbe1e3da3f045b5a87a6a39531eea425bc03d16c0d15743e
''
'' Regenerate:
''   fbfrog sokol_gfx.h -o sokol_gfx.bi \
''       -fbfroginclude stdbool.h -removeinclude stdbool.h
''
'' sokol is header-only: the application compiles the implementation
'' itself (see examples/graphics/sokol/README.txt).  There is no
'' sokol library to link against, so this binding emits no #inclib.

#pragma once

#include once "crt/stddef.bi"
#include once "crt/stdint.bi"

extern "C"

const SOKOL_GFX_INCLUDED = 1
'' TODO: #define SOKOL_GFX_API_DECL extern

type sg_buffer
	id as ulong
end type

type sg_image
	id as ulong
end type

type sg_sampler
	id as ulong
end type

type sg_shader
	id as ulong
end type

type sg_pipeline
	id as ulong
end type

type sg_attachments
	id as ulong
end type

type sg_range
	ptr as const any ptr
	size as uinteger
end type

'' TODO: #define SG_RANGE(x) (sg_range){ &x, sizeof(x) }
'' TODO: #define SG_RANGE_REF(x) &(sg_range){ &x, sizeof(x) }

enum
	SG_INVALID_ID = 0
	SG_NUM_SHADER_STAGES = 2
	SG_NUM_INFLIGHT_FRAMES = 2
	SG_MAX_COLOR_ATTACHMENTS = 4
	SG_MAX_VERTEX_BUFFERS = 8
	SG_MAX_SHADERSTAGE_IMAGES = 12
	SG_MAX_SHADERSTAGE_SAMPLERS = 8
	SG_MAX_SHADERSTAGE_IMAGESAMPLERPAIRS = 12
	SG_MAX_SHADERSTAGE_STORAGEBUFFERS = 8
	SG_MAX_SHADERSTAGE_UBS = 4
	SG_MAX_UB_MEMBERS = 16
	SG_MAX_VERTEX_ATTRIBUTES = 16
	SG_MAX_MIPMAPS = 16
	SG_MAX_TEXTUREARRAY_LAYERS = 128
end enum

type sg_color
	r as single
	g as single
	b as single
	a as single
end type

type sg_backend as long
enum
	SG_BACKEND_GLCORE
	SG_BACKEND_GLES3
	SG_BACKEND_D3D11
	SG_BACKEND_METAL_IOS
	SG_BACKEND_METAL_MACOS
	SG_BACKEND_METAL_SIMULATOR
	SG_BACKEND_WGPU
	SG_BACKEND_DUMMY
end enum

type sg_pixel_format as long
enum
	_SG_PIXELFORMAT_DEFAULT
	SG_PIXELFORMAT_NONE
	SG_PIXELFORMAT_R8
	SG_PIXELFORMAT_R8SN
	SG_PIXELFORMAT_R8UI
	SG_PIXELFORMAT_R8SI
	SG_PIXELFORMAT_R16
	SG_PIXELFORMAT_R16SN
	SG_PIXELFORMAT_R16UI
	SG_PIXELFORMAT_R16SI
	SG_PIXELFORMAT_R16F
	SG_PIXELFORMAT_RG8
	SG_PIXELFORMAT_RG8SN
	SG_PIXELFORMAT_RG8UI
	SG_PIXELFORMAT_RG8SI
	SG_PIXELFORMAT_R32UI
	SG_PIXELFORMAT_R32SI
	SG_PIXELFORMAT_R32F
	SG_PIXELFORMAT_RG16
	SG_PIXELFORMAT_RG16SN
	SG_PIXELFORMAT_RG16UI
	SG_PIXELFORMAT_RG16SI
	SG_PIXELFORMAT_RG16F
	SG_PIXELFORMAT_RGBA8
	SG_PIXELFORMAT_SRGB8A8
	SG_PIXELFORMAT_RGBA8SN
	SG_PIXELFORMAT_RGBA8UI
	SG_PIXELFORMAT_RGBA8SI
	SG_PIXELFORMAT_BGRA8
	SG_PIXELFORMAT_RGB10A2
	SG_PIXELFORMAT_RG11B10F
	SG_PIXELFORMAT_RGB9E5
	SG_PIXELFORMAT_RG32UI
	SG_PIXELFORMAT_RG32SI
	SG_PIXELFORMAT_RG32F
	SG_PIXELFORMAT_RGBA16
	SG_PIXELFORMAT_RGBA16SN
	SG_PIXELFORMAT_RGBA16UI
	SG_PIXELFORMAT_RGBA16SI
	SG_PIXELFORMAT_RGBA16F
	SG_PIXELFORMAT_RGBA32UI
	SG_PIXELFORMAT_RGBA32SI
	SG_PIXELFORMAT_RGBA32F
	SG_PIXELFORMAT_DEPTH
	SG_PIXELFORMAT_DEPTH_STENCIL
	SG_PIXELFORMAT_BC1_RGBA
	SG_PIXELFORMAT_BC2_RGBA
	SG_PIXELFORMAT_BC3_RGBA
	SG_PIXELFORMAT_BC3_SRGBA
	SG_PIXELFORMAT_BC4_R
	SG_PIXELFORMAT_BC4_RSN
	SG_PIXELFORMAT_BC5_RG
	SG_PIXELFORMAT_BC5_RGSN
	SG_PIXELFORMAT_BC6H_RGBF
	SG_PIXELFORMAT_BC6H_RGBUF
	SG_PIXELFORMAT_BC7_RGBA
	SG_PIXELFORMAT_BC7_SRGBA
	SG_PIXELFORMAT_PVRTC_RGB_2BPP
	SG_PIXELFORMAT_PVRTC_RGB_4BPP
	SG_PIXELFORMAT_PVRTC_RGBA_2BPP
	SG_PIXELFORMAT_PVRTC_RGBA_4BPP
	SG_PIXELFORMAT_ETC2_RGB8
	SG_PIXELFORMAT_ETC2_SRGB8
	SG_PIXELFORMAT_ETC2_RGB8A1
	SG_PIXELFORMAT_ETC2_RGBA8
	SG_PIXELFORMAT_ETC2_SRGB8A8
	SG_PIXELFORMAT_EAC_R11
	SG_PIXELFORMAT_EAC_R11SN
	SG_PIXELFORMAT_EAC_RG11
	SG_PIXELFORMAT_EAC_RG11SN
	SG_PIXELFORMAT_ASTC_4x4_RGBA
	SG_PIXELFORMAT_ASTC_4x4_SRGBA
	_SG_PIXELFORMAT_NUM
	_SG_PIXELFORMAT_FORCE_U32 = &h7FFFFFFF
end enum

type sg_pixelformat_info
	sample as byte
	filter as byte
	render as byte
	blend as byte
	msaa as byte
	depth as byte
	compressed as byte
	bytes_per_pixel as long
end type

type sg_features
	origin_top_left as byte
	image_clamp_to_border as byte
	mrt_independent_blend_state as byte
	mrt_independent_write_mask as byte
	storage_buffer as byte
end type

type sg_limits
	max_image_size_2d as long
	max_image_size_cube as long
	max_image_size_3d as long
	max_image_size_array as long
	max_image_array_layers as long
	max_vertex_attrs as long
	gl_max_vertex_uniform_components as long
	gl_max_combined_texture_image_units as long
end type

type sg_resource_state as long
enum
	SG_RESOURCESTATE_INITIAL
	SG_RESOURCESTATE_ALLOC
	SG_RESOURCESTATE_VALID
	SG_RESOURCESTATE_FAILED
	SG_RESOURCESTATE_INVALID
	_SG_RESOURCESTATE_FORCE_U32 = &h7FFFFFFF
end enum

type sg_usage as long
enum
	_SG_USAGE_DEFAULT
	SG_USAGE_IMMUTABLE
	SG_USAGE_DYNAMIC
	SG_USAGE_STREAM
	_SG_USAGE_NUM
	_SG_USAGE_FORCE_U32 = &h7FFFFFFF
end enum

type sg_buffer_type as long
enum
	_SG_BUFFERTYPE_DEFAULT
	SG_BUFFERTYPE_VERTEXBUFFER
	SG_BUFFERTYPE_INDEXBUFFER
	SG_BUFFERTYPE_STORAGEBUFFER
	_SG_BUFFERTYPE_NUM
	_SG_BUFFERTYPE_FORCE_U32 = &h7FFFFFFF
end enum

type sg_index_type as long
enum
	_SG_INDEXTYPE_DEFAULT
	SG_INDEXTYPE_NONE
	SG_INDEXTYPE_UINT16
	SG_INDEXTYPE_UINT32
	_SG_INDEXTYPE_NUM
	_SG_INDEXTYPE_FORCE_U32 = &h7FFFFFFF
end enum

type sg_image_type as long
enum
	_SG_IMAGETYPE_DEFAULT
	SG_IMAGETYPE_2D
	SG_IMAGETYPE_CUBE
	SG_IMAGETYPE_3D
	SG_IMAGETYPE_ARRAY
	_SG_IMAGETYPE_NUM
	_SG_IMAGETYPE_FORCE_U32 = &h7FFFFFFF
end enum

type sg_image_sample_type as long
enum
	_SG_IMAGESAMPLETYPE_DEFAULT
	SG_IMAGESAMPLETYPE_FLOAT
	SG_IMAGESAMPLETYPE_DEPTH
	SG_IMAGESAMPLETYPE_SINT
	SG_IMAGESAMPLETYPE_UINT
	SG_IMAGESAMPLETYPE_UNFILTERABLE_FLOAT
	_SG_IMAGESAMPLETYPE_NUM
	_SG_IMAGESAMPLETYPE_FORCE_U32 = &h7FFFFFFF
end enum

type sg_sampler_type as long
enum
	_SG_SAMPLERTYPE_DEFAULT
	SG_SAMPLERTYPE_FILTERING
	SG_SAMPLERTYPE_NONFILTERING
	SG_SAMPLERTYPE_COMPARISON
	_SG_SAMPLERTYPE_NUM
	_SG_SAMPLERTYPE_FORCE_U32
end enum

type sg_cube_face as long
enum
	SG_CUBEFACE_POS_X
	SG_CUBEFACE_NEG_X
	SG_CUBEFACE_POS_Y
	SG_CUBEFACE_NEG_Y
	SG_CUBEFACE_POS_Z
	SG_CUBEFACE_NEG_Z
	SG_CUBEFACE_NUM
	_SG_CUBEFACE_FORCE_U32 = &h7FFFFFFF
end enum

type sg_shader_stage as long
enum
	SG_SHADERSTAGE_VS
	SG_SHADERSTAGE_FS
	_SG_SHADERSTAGE_FORCE_U32 = &h7FFFFFFF
end enum

type sg_primitive_type as long
enum
	_SG_PRIMITIVETYPE_DEFAULT
	SG_PRIMITIVETYPE_POINTS
	SG_PRIMITIVETYPE_LINES
	SG_PRIMITIVETYPE_LINE_STRIP
	SG_PRIMITIVETYPE_TRIANGLES
	SG_PRIMITIVETYPE_TRIANGLE_STRIP
	_SG_PRIMITIVETYPE_NUM
	_SG_PRIMITIVETYPE_FORCE_U32 = &h7FFFFFFF
end enum

type sg_filter as long
enum
	_SG_FILTER_DEFAULT
	SG_FILTER_NONE
	SG_FILTER_NEAREST
	SG_FILTER_LINEAR
	_SG_FILTER_NUM
	_SG_FILTER_FORCE_U32 = &h7FFFFFFF
end enum

type sg_wrap as long
enum
	_SG_WRAP_DEFAULT
	SG_WRAP_REPEAT
	SG_WRAP_CLAMP_TO_EDGE
	SG_WRAP_CLAMP_TO_BORDER
	SG_WRAP_MIRRORED_REPEAT
	_SG_WRAP_NUM
	_SG_WRAP_FORCE_U32 = &h7FFFFFFF
end enum

type sg_border_color as long
enum
	_SG_BORDERCOLOR_DEFAULT
	SG_BORDERCOLOR_TRANSPARENT_BLACK
	SG_BORDERCOLOR_OPAQUE_BLACK
	SG_BORDERCOLOR_OPAQUE_WHITE
	_SG_BORDERCOLOR_NUM
	_SG_BORDERCOLOR_FORCE_U32 = &h7FFFFFFF
end enum

type sg_vertex_format as long
enum
	SG_VERTEXFORMAT_INVALID
	SG_VERTEXFORMAT_FLOAT
	SG_VERTEXFORMAT_FLOAT2
	SG_VERTEXFORMAT_FLOAT3
	SG_VERTEXFORMAT_FLOAT4
	SG_VERTEXFORMAT_BYTE4
	SG_VERTEXFORMAT_BYTE4N
	SG_VERTEXFORMAT_UBYTE4
	SG_VERTEXFORMAT_UBYTE4N
	SG_VERTEXFORMAT_SHORT2
	SG_VERTEXFORMAT_SHORT2N
	SG_VERTEXFORMAT_USHORT2N
	SG_VERTEXFORMAT_SHORT4
	SG_VERTEXFORMAT_SHORT4N
	SG_VERTEXFORMAT_USHORT4N
	SG_VERTEXFORMAT_UINT10_N2
	SG_VERTEXFORMAT_HALF2
	SG_VERTEXFORMAT_HALF4
	_SG_VERTEXFORMAT_NUM
	_SG_VERTEXFORMAT_FORCE_U32 = &h7FFFFFFF
end enum

type sg_vertex_step as long
enum
	_SG_VERTEXSTEP_DEFAULT
	SG_VERTEXSTEP_PER_VERTEX
	SG_VERTEXSTEP_PER_INSTANCE
	_SG_VERTEXSTEP_NUM
	_SG_VERTEXSTEP_FORCE_U32 = &h7FFFFFFF
end enum

type sg_uniform_type as long
enum
	SG_UNIFORMTYPE_INVALID
	SG_UNIFORMTYPE_FLOAT
	SG_UNIFORMTYPE_FLOAT2
	SG_UNIFORMTYPE_FLOAT3
	SG_UNIFORMTYPE_FLOAT4
	SG_UNIFORMTYPE_INT
	SG_UNIFORMTYPE_INT2
	SG_UNIFORMTYPE_INT3
	SG_UNIFORMTYPE_INT4
	SG_UNIFORMTYPE_MAT4
	_SG_UNIFORMTYPE_NUM
	_SG_UNIFORMTYPE_FORCE_U32 = &h7FFFFFFF
end enum

type sg_uniform_layout as long
enum
	_SG_UNIFORMLAYOUT_DEFAULT
	SG_UNIFORMLAYOUT_NATIVE
	SG_UNIFORMLAYOUT_STD140
	_SG_UNIFORMLAYOUT_NUM
	_SG_UNIFORMLAYOUT_FORCE_U32 = &h7FFFFFFF
end enum

type sg_cull_mode as long
enum
	_SG_CULLMODE_DEFAULT
	SG_CULLMODE_NONE
	SG_CULLMODE_FRONT
	SG_CULLMODE_BACK
	_SG_CULLMODE_NUM
	_SG_CULLMODE_FORCE_U32 = &h7FFFFFFF
end enum

type sg_face_winding as long
enum
	_SG_FACEWINDING_DEFAULT
	SG_FACEWINDING_CCW
	SG_FACEWINDING_CW
	_SG_FACEWINDING_NUM
	_SG_FACEWINDING_FORCE_U32 = &h7FFFFFFF
end enum

type sg_compare_func as long
enum
	_SG_COMPAREFUNC_DEFAULT
	SG_COMPAREFUNC_NEVER
	SG_COMPAREFUNC_LESS
	SG_COMPAREFUNC_EQUAL
	SG_COMPAREFUNC_LESS_EQUAL
	SG_COMPAREFUNC_GREATER
	SG_COMPAREFUNC_NOT_EQUAL
	SG_COMPAREFUNC_GREATER_EQUAL
	SG_COMPAREFUNC_ALWAYS
	_SG_COMPAREFUNC_NUM
	_SG_COMPAREFUNC_FORCE_U32 = &h7FFFFFFF
end enum

type sg_stencil_op as long
enum
	_SG_STENCILOP_DEFAULT
	SG_STENCILOP_KEEP
	SG_STENCILOP_ZERO
	SG_STENCILOP_REPLACE
	SG_STENCILOP_INCR_CLAMP
	SG_STENCILOP_DECR_CLAMP
	SG_STENCILOP_INVERT
	SG_STENCILOP_INCR_WRAP
	SG_STENCILOP_DECR_WRAP
	_SG_STENCILOP_NUM
	_SG_STENCILOP_FORCE_U32 = &h7FFFFFFF
end enum

type sg_blend_factor as long
enum
	_SG_BLENDFACTOR_DEFAULT
	SG_BLENDFACTOR_ZERO
	SG_BLENDFACTOR_ONE
	SG_BLENDFACTOR_SRC_COLOR
	SG_BLENDFACTOR_ONE_MINUS_SRC_COLOR
	SG_BLENDFACTOR_SRC_ALPHA
	SG_BLENDFACTOR_ONE_MINUS_SRC_ALPHA
	SG_BLENDFACTOR_DST_COLOR
	SG_BLENDFACTOR_ONE_MINUS_DST_COLOR
	SG_BLENDFACTOR_DST_ALPHA
	SG_BLENDFACTOR_ONE_MINUS_DST_ALPHA
	SG_BLENDFACTOR_SRC_ALPHA_SATURATED
	SG_BLENDFACTOR_BLEND_COLOR
	SG_BLENDFACTOR_ONE_MINUS_BLEND_COLOR
	SG_BLENDFACTOR_BLEND_ALPHA
	SG_BLENDFACTOR_ONE_MINUS_BLEND_ALPHA
	_SG_BLENDFACTOR_NUM
	_SG_BLENDFACTOR_FORCE_U32 = &h7FFFFFFF
end enum

type sg_blend_op as long
enum
	_SG_BLENDOP_DEFAULT
	SG_BLENDOP_ADD
	SG_BLENDOP_SUBTRACT
	SG_BLENDOP_REVERSE_SUBTRACT
	_SG_BLENDOP_NUM
	_SG_BLENDOP_FORCE_U32 = &h7FFFFFFF
end enum

type sg_color_mask as long
enum
	_SG_COLORMASK_DEFAULT = 0
	SG_COLORMASK_NONE = &h10
	SG_COLORMASK_R = &h1
	SG_COLORMASK_G = &h2
	SG_COLORMASK_RG = &h3
	SG_COLORMASK_B = &h4
	SG_COLORMASK_RB = &h5
	SG_COLORMASK_GB = &h6
	SG_COLORMASK_RGB = &h7
	SG_COLORMASK_A = &h8
	SG_COLORMASK_RA = &h9
	SG_COLORMASK_GA = &hA
	SG_COLORMASK_RGA = &hB
	SG_COLORMASK_BA = &hC
	SG_COLORMASK_RBA = &hD
	SG_COLORMASK_GBA = &hE
	SG_COLORMASK_RGBA = &hF
	_SG_COLORMASK_FORCE_U32 = &h7FFFFFFF
end enum

type sg_load_action as long
enum
	_SG_LOADACTION_DEFAULT
	SG_LOADACTION_CLEAR
	SG_LOADACTION_LOAD
	SG_LOADACTION_DONTCARE
	_SG_LOADACTION_FORCE_U32 = &h7FFFFFFF
end enum

type sg_store_action as long
enum
	_SG_STOREACTION_DEFAULT
	SG_STOREACTION_STORE
	SG_STOREACTION_DONTCARE
	_SG_STOREACTION_FORCE_U32 = &h7FFFFFFF
end enum

type sg_color_attachment_action
	load_action as sg_load_action
	store_action as sg_store_action
	clear_value as sg_color
end type

type sg_depth_attachment_action
	load_action as sg_load_action
	store_action as sg_store_action
	clear_value as single
end type

type sg_stencil_attachment_action
	load_action as sg_load_action
	store_action as sg_store_action
	clear_value as ubyte
end type

type sg_pass_action
	colors(0 to SG_MAX_COLOR_ATTACHMENTS - 1) as sg_color_attachment_action
	depth as sg_depth_attachment_action
	stencil as sg_stencil_attachment_action
end type

type sg_metal_swapchain
	current_drawable as const any ptr
	depth_stencil_texture as const any ptr
	msaa_color_texture as const any ptr
end type

type sg_d3d11_swapchain
	render_view as const any ptr
	resolve_view as const any ptr
	depth_stencil_view as const any ptr
end type

type sg_wgpu_swapchain
	render_view as const any ptr
	resolve_view as const any ptr
	depth_stencil_view as const any ptr
end type

type sg_gl_swapchain
	framebuffer as ulong
end type

type sg_swapchain
	width as long
	height as long
	sample_count as long
	color_format as sg_pixel_format
	depth_format as sg_pixel_format
	metal as sg_metal_swapchain
	d3d11 as sg_d3d11_swapchain
	wgpu as sg_wgpu_swapchain
	gl as sg_gl_swapchain
end type

type sg_pass
	_start_canary as ulong
	action as sg_pass_action
	attachments as sg_attachments
	swapchain as sg_swapchain
	label as const zstring ptr
	_end_canary as ulong
end type

type sg_stage_bindings
	images(0 to SG_MAX_SHADERSTAGE_IMAGES - 1) as sg_image
	samplers(0 to SG_MAX_SHADERSTAGE_SAMPLERS - 1) as sg_sampler
	storage_buffers(0 to SG_MAX_SHADERSTAGE_STORAGEBUFFERS - 1) as sg_buffer
end type

type sg_bindings
	_start_canary as ulong
	vertex_buffers(0 to SG_MAX_VERTEX_BUFFERS - 1) as sg_buffer
	vertex_buffer_offsets(0 to SG_MAX_VERTEX_BUFFERS - 1) as long
	index_buffer as sg_buffer
	index_buffer_offset as long
	vs as sg_stage_bindings
	fs as sg_stage_bindings
	_end_canary as ulong
end type

type sg_buffer_desc
	_start_canary as ulong
	size as uinteger
	as sg_buffer_type type
	usage as sg_usage
	data as sg_range
	label as const zstring ptr
	gl_buffers(0 to SG_NUM_INFLIGHT_FRAMES - 1) as ulong
	mtl_buffers(0 to SG_NUM_INFLIGHT_FRAMES - 1) as const any ptr
	d3d11_buffer as const any ptr
	wgpu_buffer as const any ptr
	_end_canary as ulong
end type

type sg_image_data
	subimage(0 to SG_CUBEFACE_NUM - 1, 0 to SG_MAX_MIPMAPS - 1) as sg_range
end type

type sg_image_desc
	_start_canary as ulong
	as sg_image_type type
	render_target as byte
	width as long
	height as long
	num_slices as long
	num_mipmaps as long
	usage as sg_usage
	pixel_format as sg_pixel_format
	sample_count as long
	data as sg_image_data
	label as const zstring ptr
	gl_textures(0 to SG_NUM_INFLIGHT_FRAMES - 1) as ulong
	gl_texture_target as ulong
	mtl_textures(0 to SG_NUM_INFLIGHT_FRAMES - 1) as const any ptr
	d3d11_texture as const any ptr
	d3d11_shader_resource_view as const any ptr
	wgpu_texture as const any ptr
	wgpu_texture_view as const any ptr
	_end_canary as ulong
end type

type sg_sampler_desc
	_start_canary as ulong
	min_filter as sg_filter
	mag_filter as sg_filter
	mipmap_filter as sg_filter
	wrap_u as sg_wrap
	wrap_v as sg_wrap
	wrap_w as sg_wrap
	min_lod as single
	max_lod as single
	border_color as sg_border_color
	compare as sg_compare_func
	max_anisotropy as ulong
	label as const zstring ptr
	gl_sampler as ulong
	mtl_sampler as const any ptr
	d3d11_sampler as const any ptr
	wgpu_sampler as const any ptr
	_end_canary as ulong
end type

type sg_shader_attr_desc
	name as const zstring ptr
	sem_name as const zstring ptr
	sem_index as long
end type

type sg_shader_uniform_desc
	name as const zstring ptr
	as sg_uniform_type type
	array_count as long
end type

type sg_shader_uniform_block_desc
	size as uinteger
	layout as sg_uniform_layout
	uniforms(0 to SG_MAX_UB_MEMBERS - 1) as sg_shader_uniform_desc
end type

type sg_shader_storage_buffer_desc
	used as byte
	readonly as byte
end type

type sg_shader_image_desc
	used as byte
	multisampled as byte
	image_type as sg_image_type
	sample_type as sg_image_sample_type
end type

type sg_shader_sampler_desc
	used as byte
	sampler_type as sg_sampler_type
end type

type sg_shader_image_sampler_pair_desc
	used as byte
	image_slot as long
	sampler_slot as long
	glsl_name as const zstring ptr
end type

type sg_shader_stage_desc
	source as const zstring ptr
	bytecode as sg_range
	entry as const zstring ptr
	d3d11_target as const zstring ptr
	uniform_blocks(0 to SG_MAX_SHADERSTAGE_UBS - 1) as sg_shader_uniform_block_desc
	storage_buffers(0 to SG_MAX_SHADERSTAGE_STORAGEBUFFERS - 1) as sg_shader_storage_buffer_desc
	images(0 to SG_MAX_SHADERSTAGE_IMAGES - 1) as sg_shader_image_desc
	samplers(0 to SG_MAX_SHADERSTAGE_SAMPLERS - 1) as sg_shader_sampler_desc
	image_sampler_pairs(0 to SG_MAX_SHADERSTAGE_IMAGESAMPLERPAIRS - 1) as sg_shader_image_sampler_pair_desc
end type

type sg_shader_desc
	_start_canary as ulong
	attrs(0 to SG_MAX_VERTEX_ATTRIBUTES - 1) as sg_shader_attr_desc
	vs as sg_shader_stage_desc
	fs as sg_shader_stage_desc
	label as const zstring ptr
	_end_canary as ulong
end type

type sg_vertex_buffer_layout_state
	stride as long
	step_func as sg_vertex_step
	step_rate as long
end type

type sg_vertex_attr_state
	buffer_index as long
	offset as long
	format as sg_vertex_format
end type

type sg_vertex_layout_state
	buffers(0 to SG_MAX_VERTEX_BUFFERS - 1) as sg_vertex_buffer_layout_state
	attrs(0 to SG_MAX_VERTEX_ATTRIBUTES - 1) as sg_vertex_attr_state
end type

type sg_stencil_face_state
	compare as sg_compare_func
	fail_op as sg_stencil_op
	depth_fail_op as sg_stencil_op
	pass_op as sg_stencil_op
end type

type sg_stencil_state
	enabled as byte
	front as sg_stencil_face_state
	back as sg_stencil_face_state
	read_mask as ubyte
	write_mask as ubyte
	ref as ubyte
end type

type sg_depth_state
	pixel_format as sg_pixel_format
	compare as sg_compare_func
	write_enabled as byte
	bias as single
	bias_slope_scale as single
	bias_clamp as single
end type

type sg_blend_state
	enabled as byte
	src_factor_rgb as sg_blend_factor
	dst_factor_rgb as sg_blend_factor
	op_rgb as sg_blend_op
	src_factor_alpha as sg_blend_factor
	dst_factor_alpha as sg_blend_factor
	op_alpha as sg_blend_op
end type

type sg_color_target_state
	pixel_format as sg_pixel_format
	write_mask as sg_color_mask
	blend as sg_blend_state
end type

type sg_pipeline_desc
	_start_canary as ulong
	shader as sg_shader
	layout as sg_vertex_layout_state
	depth as sg_depth_state
	stencil as sg_stencil_state
	color_count as long
	colors(0 to SG_MAX_COLOR_ATTACHMENTS - 1) as sg_color_target_state
	primitive_type as sg_primitive_type
	index_type as sg_index_type
	cull_mode as sg_cull_mode
	face_winding as sg_face_winding
	sample_count as long
	blend_color as sg_color
	alpha_to_coverage_enabled as byte
	label as const zstring ptr
	_end_canary as ulong
end type

type sg_attachment_desc
	image as sg_image
	mip_level as long
	slice as long
end type

type sg_attachments_desc
	_start_canary as ulong
	colors(0 to SG_MAX_COLOR_ATTACHMENTS - 1) as sg_attachment_desc
	resolves(0 to SG_MAX_COLOR_ATTACHMENTS - 1) as sg_attachment_desc
	depth_stencil as sg_attachment_desc
	label as const zstring ptr
	_end_canary as ulong
end type

type sg_trace_hooks
	user_data as any ptr
	reset_state_cache as sub(byval user_data as any ptr)
	make_buffer as sub(byval desc as const sg_buffer_desc ptr, byval result as sg_buffer, byval user_data as any ptr)
	make_image as sub(byval desc as const sg_image_desc ptr, byval result as sg_image, byval user_data as any ptr)
	make_sampler as sub(byval desc as const sg_sampler_desc ptr, byval result as sg_sampler, byval user_data as any ptr)
	make_shader as sub(byval desc as const sg_shader_desc ptr, byval result as sg_shader, byval user_data as any ptr)
	make_pipeline as sub(byval desc as const sg_pipeline_desc ptr, byval result as sg_pipeline, byval user_data as any ptr)
	make_attachments as sub(byval desc as const sg_attachments_desc ptr, byval result as sg_attachments, byval user_data as any ptr)
	destroy_buffer as sub(byval buf as sg_buffer, byval user_data as any ptr)
	destroy_image as sub(byval img as sg_image, byval user_data as any ptr)
	destroy_sampler as sub(byval smp as sg_sampler, byval user_data as any ptr)
	destroy_shader as sub(byval shd as sg_shader, byval user_data as any ptr)
	destroy_pipeline as sub(byval pip as sg_pipeline, byval user_data as any ptr)
	destroy_attachments as sub(byval atts as sg_attachments, byval user_data as any ptr)
	update_buffer as sub(byval buf as sg_buffer, byval data as const sg_range ptr, byval user_data as any ptr)
	update_image as sub(byval img as sg_image, byval data as const sg_image_data ptr, byval user_data as any ptr)
	append_buffer as sub(byval buf as sg_buffer, byval data as const sg_range ptr, byval result as long, byval user_data as any ptr)
	begin_pass as sub(byval pass as const sg_pass ptr, byval user_data as any ptr)
	apply_viewport as sub(byval x as long, byval y as long, byval width as long, byval height as long, byval origin_top_left as byte, byval user_data as any ptr)
	apply_scissor_rect as sub(byval x as long, byval y as long, byval width as long, byval height as long, byval origin_top_left as byte, byval user_data as any ptr)
	apply_pipeline as sub(byval pip as sg_pipeline, byval user_data as any ptr)
	apply_bindings as sub(byval bindings as const sg_bindings ptr, byval user_data as any ptr)
	apply_uniforms as sub(byval stage as sg_shader_stage, byval ub_index as long, byval data as const sg_range ptr, byval user_data as any ptr)
	draw as sub(byval base_element as long, byval num_elements as long, byval num_instances as long, byval user_data as any ptr)
	end_pass as sub(byval user_data as any ptr)
	commit as sub(byval user_data as any ptr)
	alloc_buffer as sub(byval result as sg_buffer, byval user_data as any ptr)
	alloc_image as sub(byval result as sg_image, byval user_data as any ptr)
	alloc_sampler as sub(byval result as sg_sampler, byval user_data as any ptr)
	alloc_shader as sub(byval result as sg_shader, byval user_data as any ptr)
	alloc_pipeline as sub(byval result as sg_pipeline, byval user_data as any ptr)
	alloc_attachments as sub(byval result as sg_attachments, byval user_data as any ptr)
	dealloc_buffer as sub(byval buf_id as sg_buffer, byval user_data as any ptr)
	dealloc_image as sub(byval img_id as sg_image, byval user_data as any ptr)
	dealloc_sampler as sub(byval smp_id as sg_sampler, byval user_data as any ptr)
	dealloc_shader as sub(byval shd_id as sg_shader, byval user_data as any ptr)
	dealloc_pipeline as sub(byval pip_id as sg_pipeline, byval user_data as any ptr)
	dealloc_attachments as sub(byval atts_id as sg_attachments, byval user_data as any ptr)
	init_buffer as sub(byval buf_id as sg_buffer, byval desc as const sg_buffer_desc ptr, byval user_data as any ptr)
	init_image as sub(byval img_id as sg_image, byval desc as const sg_image_desc ptr, byval user_data as any ptr)
	init_sampler as sub(byval smp_id as sg_sampler, byval desc as const sg_sampler_desc ptr, byval user_data as any ptr)
	init_shader as sub(byval shd_id as sg_shader, byval desc as const sg_shader_desc ptr, byval user_data as any ptr)
	init_pipeline as sub(byval pip_id as sg_pipeline, byval desc as const sg_pipeline_desc ptr, byval user_data as any ptr)
	init_attachments as sub(byval atts_id as sg_attachments, byval desc as const sg_attachments_desc ptr, byval user_data as any ptr)
	uninit_buffer as sub(byval buf_id as sg_buffer, byval user_data as any ptr)
	uninit_image as sub(byval img_id as sg_image, byval user_data as any ptr)
	uninit_sampler as sub(byval smp_id as sg_sampler, byval user_data as any ptr)
	uninit_shader as sub(byval shd_id as sg_shader, byval user_data as any ptr)
	uninit_pipeline as sub(byval pip_id as sg_pipeline, byval user_data as any ptr)
	uninit_attachments as sub(byval atts_id as sg_attachments, byval user_data as any ptr)
	fail_buffer as sub(byval buf_id as sg_buffer, byval user_data as any ptr)
	fail_image as sub(byval img_id as sg_image, byval user_data as any ptr)
	fail_sampler as sub(byval smp_id as sg_sampler, byval user_data as any ptr)
	fail_shader as sub(byval shd_id as sg_shader, byval user_data as any ptr)
	fail_pipeline as sub(byval pip_id as sg_pipeline, byval user_data as any ptr)
	fail_attachments as sub(byval atts_id as sg_attachments, byval user_data as any ptr)
	push_debug_group as sub(byval name as const zstring ptr, byval user_data as any ptr)
	pop_debug_group as sub(byval user_data as any ptr)
end type

type sg_slot_info
	state as sg_resource_state
	res_id as ulong
end type

type sg_buffer_info
	slot as sg_slot_info
	update_frame_index as ulong
	append_frame_index as ulong
	append_pos as long
	append_overflow as byte
	num_slots as long
	active_slot as long
end type

type sg_image_info
	slot as sg_slot_info
	upd_frame_index as ulong
	num_slots as long
	active_slot as long
end type

type sg_sampler_info
	slot as sg_slot_info
end type

type sg_shader_info
	slot as sg_slot_info
end type

type sg_pipeline_info
	slot as sg_slot_info
end type

type sg_attachments_info
	slot as sg_slot_info
end type

type sg_frame_stats_gl
	num_bind_buffer as ulong
	num_active_texture as ulong
	num_bind_texture as ulong
	num_bind_sampler as ulong
	num_use_program as ulong
	num_render_state as ulong
	num_vertex_attrib_pointer as ulong
	num_vertex_attrib_divisor as ulong
	num_enable_vertex_attrib_array as ulong
	num_disable_vertex_attrib_array as ulong
	num_uniform as ulong
end type

type sg_frame_stats_d3d11_pass
	num_om_set_render_targets as ulong
	num_clear_render_target_view as ulong
	num_clear_depth_stencil_view as ulong
	num_resolve_subresource as ulong
end type

type sg_frame_stats_d3d11_pipeline
	num_rs_set_state as ulong
	num_om_set_depth_stencil_state as ulong
	num_om_set_blend_state as ulong
	num_ia_set_primitive_topology as ulong
	num_ia_set_input_layout as ulong
	num_vs_set_shader as ulong
	num_vs_set_constant_buffers as ulong
	num_ps_set_shader as ulong
	num_ps_set_constant_buffers as ulong
end type

type sg_frame_stats_d3d11_bindings
	num_ia_set_vertex_buffers as ulong
	num_ia_set_index_buffer as ulong
	num_vs_set_shader_resources as ulong
	num_ps_set_shader_resources as ulong
	num_vs_set_samplers as ulong
	num_ps_set_samplers as ulong
end type

type sg_frame_stats_d3d11_uniforms
	num_update_subresource as ulong
end type

type sg_frame_stats_d3d11_draw
	num_draw_indexed_instanced as ulong
	num_draw_indexed as ulong
	num_draw_instanced as ulong
	num_draw as ulong
end type

type sg_frame_stats_d3d11
	pass as sg_frame_stats_d3d11_pass
	pipeline as sg_frame_stats_d3d11_pipeline
	bindings as sg_frame_stats_d3d11_bindings
	uniforms as sg_frame_stats_d3d11_uniforms
	draw as sg_frame_stats_d3d11_draw
	num_map as ulong
	num_unmap as ulong
end type

type sg_frame_stats_metal_idpool
	num_added as ulong
	num_released as ulong
	num_garbage_collected as ulong
end type

type sg_frame_stats_metal_pipeline
	num_set_blend_color as ulong
	num_set_cull_mode as ulong
	num_set_front_facing_winding as ulong
	num_set_stencil_reference_value as ulong
	num_set_depth_bias as ulong
	num_set_render_pipeline_state as ulong
	num_set_depth_stencil_state as ulong
end type

type sg_frame_stats_metal_bindings
	num_set_vertex_buffer as ulong
	num_set_vertex_texture as ulong
	num_set_vertex_sampler_state as ulong
	num_set_fragment_buffer as ulong
	num_set_fragment_texture as ulong
	num_set_fragment_sampler_state as ulong
end type

type sg_frame_stats_metal_uniforms
	num_set_vertex_buffer_offset as ulong
	num_set_fragment_buffer_offset as ulong
end type

type sg_frame_stats_metal
	idpool as sg_frame_stats_metal_idpool
	pipeline as sg_frame_stats_metal_pipeline
	bindings as sg_frame_stats_metal_bindings
	uniforms as sg_frame_stats_metal_uniforms
end type

type sg_frame_stats_wgpu_uniforms
	num_set_bindgroup as ulong
	size_write_buffer as ulong
end type

type sg_frame_stats_wgpu_bindings
	num_set_vertex_buffer as ulong
	num_skip_redundant_vertex_buffer as ulong
	num_set_index_buffer as ulong
	num_skip_redundant_index_buffer as ulong
	num_create_bindgroup as ulong
	num_discard_bindgroup as ulong
	num_set_bindgroup as ulong
	num_skip_redundant_bindgroup as ulong
	num_bindgroup_cache_hits as ulong
	num_bindgroup_cache_misses as ulong
	num_bindgroup_cache_collisions as ulong
	num_bindgroup_cache_hash_vs_key_mismatch as ulong
end type

type sg_frame_stats_wgpu
	uniforms as sg_frame_stats_wgpu_uniforms
	bindings as sg_frame_stats_wgpu_bindings
end type

type sg_frame_stats
	frame_index as ulong
	num_passes as ulong
	num_apply_viewport as ulong
	num_apply_scissor_rect as ulong
	num_apply_pipeline as ulong
	num_apply_bindings as ulong
	num_apply_uniforms as ulong
	num_draw as ulong
	num_update_buffer as ulong
	num_append_buffer as ulong
	num_update_image as ulong
	size_apply_uniforms as ulong
	size_update_buffer as ulong
	size_append_buffer as ulong
	size_update_image as ulong
	gl as sg_frame_stats_gl
	d3d11 as sg_frame_stats_d3d11
	metal as sg_frame_stats_metal
	wgpu as sg_frame_stats_wgpu
end type

'' TODO: #define _SG_LOG_ITEMS _SG_LOGITEM_XMACRO(OK, "Ok") _SG_LOGITEM_XMACRO(MALLOC_FAILED, "memory allocation failed") _SG_LOGITEM_XMACRO(GL_TEXTURE_FORMAT_NOT_SUPPORTED, "pixel format not supported for texture (gl)") _SG_LOGITEM_XMACRO(GL_3D_TEXTURES_NOT_SUPPORTED, "3d textures not supported (gl)") _SG_LOGITEM_XMACRO(GL_ARRAY_TEXTURES_NOT_SUPPORTED, "array textures not supported (gl)") _SG_LOGITEM_XMACRO(GL_SHADER_COMPILATION_FAILED, "shader compilation failed (gl)") _SG_LOGITEM_XMACRO(GL_SHADER_LINKING_FAILED, "shader linking failed (gl)") _SG_LOGITEM_XMACRO(GL_VERTEX_ATTRIBUTE_NOT_FOUND_IN_SHADER, "vertex attribute not found in shader (gl)") _SG_LOGITEM_XMACRO(GL_TEXTURE_NAME_NOT_FOUND_IN_SHADER, "texture name not found in shader (gl)") _SG_LOGITEM_XMACRO(GL_FRAMEBUFFER_STATUS_UNDEFINED, "framebuffer completeness check failed with GL_FRAMEBUFFER_UNDEFINED (gl)") _SG_LOGITEM_XMACRO(GL_FRAMEBUFFER_STATUS_INCOMPLETE_ATTACHMENT, "framebuffer completeness check failed with GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT (gl)") _SG_LOGITEM_XMACRO(GL_FRAMEBUFFER_STATUS_INCOMPLETE_MISSING_ATTACHMENT, "framebuffer completeness check failed with GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT (gl)") _SG_LOGITEM_XMACRO(GL_FRAMEBUFFER_STATUS_UNSUPPORTED, "framebuffer completeness check failed with GL_FRAMEBUFFER_UNSUPPORTED (gl)") _SG_LOGITEM_XMACRO(GL_FRAMEBUFFER_STATUS_INCOMPLETE_MULTISAMPLE, "framebuffer completeness check failed with GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE (gl)") _SG_LOGITEM_XMACRO(GL_FRAMEBUFFER_STATUS_UNKNOWN, "framebuffer completeness check failed (unknown reason) (gl)") _SG_LOGITEM_XMACRO(D3D11_CREATE_BUFFER_FAILED, "CreateBuffer() failed (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_BUFFER_SRV_FAILED, "CreateShaderResourceView() failed for storage buffer (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_DEPTH_TEXTURE_UNSUPPORTED_PIXEL_FORMAT, "pixel format not supported for depth-stencil texture (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_DEPTH_TEXTURE_FAILED, "CreateTexture2D() failed for depth-stencil texture (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_2D_TEXTURE_UNSUPPORTED_PIXEL_FORMAT, "pixel format not supported for 2d-, cube- or array-texture (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_2D_TEXTURE_FAILED, "CreateTexture2D() failed for 2d-, cube- or array-texture (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_2D_SRV_FAILED, "CreateShaderResourceView() failed for 2d-, cube- or array-texture (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_3D_TEXTURE_UNSUPPORTED_PIXEL_FORMAT, "pixel format not supported for 3D texture (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_3D_TEXTURE_FAILED, "CreateTexture3D() failed (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_3D_SRV_FAILED, "CreateShaderResourceView() failed for 3d texture (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_MSAA_TEXTURE_FAILED, "CreateTexture2D() failed for MSAA render target texture (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_SAMPLER_STATE_FAILED, "CreateSamplerState() failed (d3d11)") _SG_LOGITEM_XMACRO(D3D11_LOAD_D3DCOMPILER_47_DLL_FAILED, "loading d3dcompiler_47.dll failed (d3d11)") _SG_LOGITEM_XMACRO(D3D11_SHADER_COMPILATION_FAILED, "shader compilation failed (d3d11)") _SG_LOGITEM_XMACRO(D3D11_SHADER_COMPILATION_OUTPUT, "") _SG_LOGITEM_XMACRO(D3D11_CREATE_CONSTANT_BUFFER_FAILED, "CreateBuffer() failed for uniform constant buffer (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_INPUT_LAYOUT_FAILED, "CreateInputLayout() failed (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_RASTERIZER_STATE_FAILED, "CreateRasterizerState() failed (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_DEPTH_STENCIL_STATE_FAILED, "CreateDepthStencilState() failed (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_BLEND_STATE_FAILED, "CreateBlendState() failed (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_RTV_FAILED, "CreateRenderTargetView() failed (d3d11)") _SG_LOGITEM_XMACRO(D3D11_CREATE_DSV_FAILED, "CreateDepthStencilView() failed (d3d11)") _SG_LOGITEM_XMACRO(D3D11_MAP_FOR_UPDATE_BUFFER_FAILED, "Map() failed when updating buffer (d3d11)") _SG_LOGITEM_XMACRO(D3D11_MAP_FOR_APPEND_BUFFER_FAILED, "Map() failed when appending to buffer (d3d11)") _SG_LOGITEM_XMACRO(D3D11_MAP_FOR_UPDATE_IMAGE_FAILED, "Map() failed when updating image (d3d11)") _SG_LOGITEM_XMACRO(METAL_CREATE_BUFFER_FAILED, "failed to create buffer object (metal)") _SG_LOGITEM_XMACRO(METAL_TEXTURE_FORMAT_NOT_SUPPORTED, "pixel format not supported for texture (metal)") _SG_LOGITEM_XMACRO(METAL_CREATE_TEXTURE_FAILED, "failed to create texture object (metal)") _SG_LOGITEM_XMACRO(METAL_CREATE_SAMPLER_FAILED, "failed to create sampler object (metal)") _SG_LOGITEM_XMACRO(METAL_SHADER_COMPILATION_FAILED, "shader compilation failed (metal)") _SG_LOGITEM_XMACRO(METAL_SHADER_CREATION_FAILED, "shader creation failed (metal)") _SG_LOGITEM_XMACRO(METAL_SHADER_COMPILATION_OUTPUT, "") _SG_LOGITEM_XMACRO(METAL_VERTEX_SHADER_ENTRY_NOT_FOUND, "vertex shader entry function not found (metal)") _SG_LOGITEM_XMACRO(METAL_FRAGMENT_SHADER_ENTRY_NOT_FOUND, "fragment shader entry not found (metal)") _SG_LOGITEM_XMACRO(METAL_CREATE_RPS_FAILED, "failed to create render pipeline state (metal)") _SG_LOGITEM_XMACRO(METAL_CREATE_RPS_OUTPUT, "") _SG_LOGITEM_XMACRO(METAL_CREATE_DSS_FAILED, "failed to create depth stencil state (metal)") _SG_LOGITEM_XMACRO(WGPU_BINDGROUPS_POOL_EXHAUSTED, "bindgroups pool exhausted (increase sg_desc.bindgroups_cache_size) (wgpu)") _SG_LOGITEM_XMACRO(WGPU_BINDGROUPSCACHE_SIZE_GREATER_ONE, "sg_desc.wgpu_bindgroups_cache_size must be > 1 (wgpu)") _SG_LOGITEM_XMACRO(WGPU_BINDGROUPSCACHE_SIZE_POW2, "sg_desc.wgpu_bindgroups_cache_size must be a power of 2 (wgpu)") _SG_LOGITEM_XMACRO(WGPU_CREATEBINDGROUP_FAILED, "wgpuDeviceCreateBindGroup failed") _SG_LOGITEM_XMACRO(WGPU_CREATE_BUFFER_FAILED, "wgpuDeviceCreateBuffer() failed") _SG_LOGITEM_XMACRO(WGPU_CREATE_TEXTURE_FAILED, "wgpuDeviceCreateTexture() failed") _SG_LOGITEM_XMACRO(WGPU_CREATE_TEXTURE_VIEW_FAILED, "wgpuTextureCreateView() failed") _SG_LOGITEM_XMACRO(WGPU_CREATE_SAMPLER_FAILED, "wgpuDeviceCreateSampler() failed") _SG_LOGITEM_XMACRO(WGPU_CREATE_SHADER_MODULE_FAILED, "wgpuDeviceCreateShaderModule() failed") _SG_LOGITEM_XMACRO(WGPU_SHADER_TOO_MANY_IMAGES, "shader uses too many sampled images on shader stage (wgpu)") _SG_LOGITEM_XMACRO(WGPU_SHADER_TOO_MANY_SAMPLERS, "shader uses too many samplers on shader stage (wgpu)") _SG_LOGITEM_XMACRO(WGPU_SHADER_TOO_MANY_STORAGEBUFFERS, "shader uses too many storage buffer bindings on shader stage (wgpu)") _SG_LOGITEM_XMACRO(WGPU_SHADER_CREATE_BINDGROUP_LAYOUT_FAILED, "wgpuDeviceCreateBindGroupLayout() for shader stage failed") _SG_LOGITEM_XMACRO(WGPU_CREATE_PIPELINE_LAYOUT_FAILED, "wgpuDeviceCreatePipelineLayout() failed") _SG_LOGITEM_XMACRO(WGPU_CREATE_RENDER_PIPELINE_FAILED, "wgpuDeviceCreateRenderPipeline() failed") _SG_LOGITEM_XMACRO(WGPU_ATTACHMENTS_CREATE_TEXTURE_VIEW_FAILED, "wgpuTextureCreateView() failed in create attachments") _SG_LOGITEM_XMACRO(IDENTICAL_COMMIT_LISTENER, "attempting to add identical commit listener") _SG_LOGITEM_XMACRO(COMMIT_LISTENER_ARRAY_FULL, "commit listener array full") _SG_LOGITEM_XMACRO(TRACE_HOOKS_NOT_ENABLED, "sg_install_trace_hooks() called, but SG_TRACE_HOOKS is not defined") _SG_LOGITEM_XMACRO(DEALLOC_BUFFER_INVALID_STATE, "sg_dealloc_buffer(): buffer must be in ALLOC state") _SG_LOGITEM_XMACRO(DEALLOC_IMAGE_INVALID_STATE, "sg_dealloc_image(): image must be in alloc state") _SG_LOGITEM_XMACRO(DEALLOC_SAMPLER_INVALID_STATE, "sg_dealloc_sampler(): sampler must be in alloc state") _SG_LOGITEM_XMACRO(DEALLOC_SHADER_INVALID_STATE, "sg_dealloc_shader(): shader must be in ALLOC state") _SG_LOGITEM_XMACRO(DEALLOC_PIPELINE_INVALID_STATE, "sg_dealloc_pipeline(): pipeline must be in ALLOC state") _SG_LOGITEM_XMACRO(DEALLOC_ATTACHMENTS_INVALID_STATE, "sg_dealloc_attachments(): attachments must be in ALLOC state") _SG_LOGITEM_XMACRO(INIT_BUFFER_INVALID_STATE, "sg_init_buffer(): buffer must be in ALLOC state") _SG_LOGITEM_XMACRO(INIT_IMAGE_INVALID_STATE, "sg_init_image(): image must be in ALLOC state") _SG_LOGITEM_XMACRO(INIT_SAMPLER_INVALID_STATE, "sg_init_sampler(): sampler must be in ALLOC state") _SG_LOGITEM_XMACRO(INIT_SHADER_INVALID_STATE, "sg_init_shader(): shader must be in ALLOC state") _SG_LOGITEM_XMACRO(INIT_PIPELINE_INVALID_STATE, "sg_init_pipeline(): pipeline must be in ALLOC state") _SG_LOGITEM_XMACRO(INIT_ATTACHMENTS_INVALID_STATE, "sg_init_attachments(): pass must be in ALLOC state") _SG_LOGITEM_XMACRO(UNINIT_BUFFER_INVALID_STATE, "sg_uninit_buffer(): buffer must be in VALID or FAILED state") _SG_LOGITEM_XMACRO(UNINIT_IMAGE_INVALID_STATE, "sg_uninit_image(): image must be in VALID or FAILED state") _SG_LOGITEM_XMACRO(UNINIT_SAMPLER_INVALID_STATE, "sg_uninit_sampler(): sampler must be in VALID or FAILED state") _SG_LOGITEM_XMACRO(UNINIT_SHADER_INVALID_STATE, "sg_uninit_shader(): shader must be in VALID or FAILED state") _SG_LOGITEM_XMACRO(UNINIT_PIPELINE_INVALID_STATE, "sg_uninit_pipeline(): pipeline must be in VALID or FAILED state") _SG_LOGITEM_XMACRO(UNINIT_ATTACHMENTS_INVALID_STATE, "sg_uninit_attachments(): attachments must be in VALID or FAILED state") _SG_LOGITEM_XMACRO(FAIL_BUFFER_INVALID_STATE, "sg_fail_buffer(): buffer must be in ALLOC state") _SG_LOGITEM_XMACRO(FAIL_IMAGE_INVALID_STATE, "sg_fail_image(): image must be in ALLOC state") _SG_LOGITEM_XMACRO(FAIL_SAMPLER_INVALID_STATE, "sg_fail_sampler(): sampler must be in ALLOC state") _SG_LOGITEM_XMACRO(FAIL_SHADER_INVALID_STATE, "sg_fail_shader(): shader must be in ALLOC state") _SG_LOGITEM_XMACRO(FAIL_PIPELINE_INVALID_STATE, "sg_fail_pipeline(): pipeline must be in ALLOC state") _SG_LOGITEM_XMACRO(FAIL_ATTACHMENTS_INVALID_STATE, "sg_fail_attachments(): attachments must be in ALLOC state") _SG_LOGITEM_XMACRO(BUFFER_POOL_EXHAUSTED, "buffer pool exhausted") _SG_LOGITEM_XMACRO(IMAGE_POOL_EXHAUSTED, "image pool exhausted") _SG_LOGITEM_XMACRO(SAMPLER_POOL_EXHAUSTED, "sampler pool exhausted") _SG_LOGITEM_XMACRO(SHADER_POOL_EXHAUSTED, "shader pool exhausted") _SG_LOGITEM_XMACRO(PIPELINE_POOL_EXHAUSTED, "pipeline pool exhausted") _SG_LOGITEM_XMACRO(PASS_POOL_EXHAUSTED, "pass pool exhausted") _SG_LOGITEM_XMACRO(BEGINPASS_ATTACHMENT_INVALID, "sg_begin_pass: an attachment was provided that no longer exists") _SG_LOGITEM_XMACRO(DRAW_WITHOUT_BINDINGS, "attempting to draw without resource bindings") _SG_LOGITEM_XMACRO(VALIDATE_BUFFERDESC_CANARY, "sg_buffer_desc not initialized") _SG_LOGITEM_XMACRO(VALIDATE_BUFFERDESC_SIZE, "sg_buffer_desc.size and .data.size cannot both be 0") _SG_LOGITEM_XMACRO(VALIDATE_BUFFERDESC_DATA, "immutable buffers must be initialized with data (sg_buffer_desc.data.ptr and sg_buffer_desc.data.size)") _SG_LOGITEM_XMACRO(VALIDATE_BUFFERDESC_DATA_SIZE, "immutable buffer data size differs from buffer size") _SG_LOGITEM_XMACRO(VALIDATE_BUFFERDESC_NO_DATA, "dynamic/stream usage buffers cannot be initialized with data") _SG_LOGITEM_XMACRO(VALIDATE_BUFFERDESC_STORAGEBUFFER_SUPPORTED, "storage buffers not supported by the backend 3D API (requires OpenGL >= 4.3)") _SG_LOGITEM_XMACRO(VALIDATE_BUFFERDESC_STORAGEBUFFER_SIZE_MULTIPLE_4, "size of storage buffers must be a multiple of 4") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDATA_NODATA, "sg_image_data: no data (.ptr and/or .size is zero)") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDATA_DATA_SIZE, "sg_image_data: data size doesn't match expected surface size") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_CANARY, "sg_image_desc not initialized") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_WIDTH, "sg_image_desc.width must be > 0") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_HEIGHT, "sg_image_desc.height must be > 0") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_RT_PIXELFORMAT, "invalid pixel format for render-target image") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_NONRT_PIXELFORMAT, "invalid pixel format for non-render-target image") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_MSAA_BUT_NO_RT, "non-render-target images cannot be multisampled") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_NO_MSAA_RT_SUPPORT, "MSAA not supported for this pixel format") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_MSAA_NUM_MIPMAPS, "MSAA images must have num_mipmaps == 1") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_MSAA_3D_IMAGE, "3D images cannot have a sample_count > 1") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_DEPTH_3D_IMAGE, "3D images cannot have a depth/stencil image format") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_RT_IMMUTABLE, "render target images must be SG_USAGE_IMMUTABLE") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_RT_NO_DATA, "render target images cannot be initialized with data") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_INJECTED_NO_DATA, "images with injected textures cannot be initialized with data") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_DYNAMIC_NO_DATA, "dynamic/stream images cannot be initialized with data") _SG_LOGITEM_XMACRO(VALIDATE_IMAGEDESC_COMPRESSED_IMMUTABLE, "compressed images must be immutable") _SG_LOGITEM_XMACRO(VALIDATE_SAMPLERDESC_CANARY, "sg_sampler_desc not initialized") _SG_LOGITEM_XMACRO(VALIDATE_SAMPLERDESC_MINFILTER_NONE, "sg_sampler_desc.min_filter cannot be SG_FILTER_NONE") _SG_LOGITEM_XMACRO(VALIDATE_SAMPLERDESC_MAGFILTER_NONE, "sg_sampler_desc.mag_filter cannot be SG_FILTER_NONE") _SG_LOGITEM_XMACRO(VALIDATE_SAMPLERDESC_ANISTROPIC_REQUIRES_LINEAR_FILTERING, "sg_sampler_desc.max_anisotropy > 1 requires min/mag/mipmap_filter to be SG_FILTER_LINEAR") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_CANARY, "sg_shader_desc not initialized") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_SOURCE, "shader source code required") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_BYTECODE, "shader byte code required") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_SOURCE_OR_BYTECODE, "shader source or byte code required") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_NO_BYTECODE_SIZE, "shader byte code length (in bytes) required") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_NO_CONT_UBS, "shader uniform blocks must occupy continuous slots") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_NO_CONT_UB_MEMBERS, "uniform block members must occupy continuous slots") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_NO_UB_MEMBERS, "GL backend requires uniform block member declarations") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_UB_MEMBER_NAME, "uniform block member name missing") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_UB_SIZE_MISMATCH, "size of uniform block members doesn't match uniform block size") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_UB_ARRAY_COUNT, "uniform array count must be >= 1") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_UB_STD140_ARRAY_TYPE, "uniform arrays only allowed for FLOAT4, INT4, MAT4 in std140 layout") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_NO_CONT_STORAGEBUFFERS, "shader stage storage buffers must occupy continuous slots (sg_shader_desc.vs|fs.storage_buffers[])") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_STORAGEBUFFER_READONLY, "shader stage storage buffers must be readonly (sg_shader_desc.vs|fs.storage_buffers[].readonly)") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_NO_CONT_IMAGES, "shader stage images must occupy continuous slots (sg_shader_desc.vs|fs.images[])") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_NO_CONT_SAMPLERS, "shader stage samplers must occupy continuous slots (sg_shader_desc.vs|fs.samplers[])") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_IMAGE_SAMPLER_PAIR_IMAGE_SLOT_OUT_OF_RANGE, "shader stage: image-sampler-pair image slot index is out of range (sg_shader_desc.vs|fs.image_sampler_pairs[].image_slot)") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_IMAGE_SAMPLER_PAIR_SAMPLER_SLOT_OUT_OF_RANGE, "shader stage: image-sampler-pair image slot index is out of range (sg_shader_desc.vs|fs.image_sampler_pairs[].sampler_slot)") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_IMAGE_SAMPLER_PAIR_NAME_REQUIRED_FOR_GL, "shader stage: image-sampler-pairs must be named in GL (sg_shader_desc.vs|fs.image_sampler_pairs[].name)") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_IMAGE_SAMPLER_PAIR_HAS_NAME_BUT_NOT_USED, "shader stage: image-sampler-pair has name but .used field not true") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_IMAGE_SAMPLER_PAIR_HAS_IMAGE_BUT_NOT_USED, "shader stage: image-sampler-pair has .image_slot != 0 but .used field not true") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_IMAGE_SAMPLER_PAIR_HAS_SAMPLER_BUT_NOT_USED, "shader stage: image-sampler-pair .sampler_slot != 0 but .used field not true") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_NONFILTERING_SAMPLER_REQUIRED, "shader stage: image sample type UNFILTERABLE_FLOAT, UINT, SINT can only be used with NONFILTERING sampler") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_COMPARISON_SAMPLER_REQUIRED, "shader stage: image sample type DEPTH can only be used with COMPARISON sampler") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_IMAGE_NOT_REFERENCED_BY_IMAGE_SAMPLER_PAIRS, "shader stage: one or more images are note referenced by  (sg_shader_desc.vs|fs.image_sampler_pairs[].image_slot)") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_SAMPLER_NOT_REFERENCED_BY_IMAGE_SAMPLER_PAIRS, "shader stage: one or more samplers are not referenced by image-sampler-pairs (sg_shader_desc.vs|fs.image_sampler_pairs[].sampler_slot)") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_NO_CONT_IMAGE_SAMPLER_PAIRS, "shader stage image-sampler-pairs must occupy continuous slots (sg_shader_desc.vs|fs.image_samplers[])") _SG_LOGITEM_XMACRO(VALIDATE_SHADERDESC_ATTR_STRING_TOO_LONG, "vertex attribute name/semantic string too long (max len 16)") _SG_LOGITEM_XMACRO(VALIDATE_PIPELINEDESC_CANARY, "sg_pipeline_desc not initialized") _SG_LOGITEM_XMACRO(VALIDATE_PIPELINEDESC_SHADER, "sg_pipeline_desc.shader missing or invalid") _SG_LOGITEM_XMACRO(VALIDATE_PIPELINEDESC_NO_CONT_ATTRS, "sg_pipeline_desc.layout.attrs is not continuous") _SG_LOGITEM_XMACRO(VALIDATE_PIPELINEDESC_LAYOUT_STRIDE4, "sg_pipeline_desc.layout.buffers[].stride must be multiple of 4") _SG_LOGITEM_XMACRO(VALIDATE_PIPELINEDESC_ATTR_SEMANTICS, "D3D11 missing vertex attribute semantics in shader") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_CANARY, "sg_attachments_desc not initialized") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_NO_ATTACHMENTS, "sg_attachments_desc no color or depth-stencil attachments") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_NO_CONT_COLOR_ATTS, "color attachments must occupy continuous slots") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_IMAGE, "pass attachment image is not valid") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_MIPLEVEL, "pass attachment mip level is bigger than image has mipmaps") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_FACE, "pass attachment image is cubemap, but face index is too big") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_LAYER, "pass attachment image is array texture, but layer index is too big") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_SLICE, "pass attachment image is 3d texture, but slice value is too big") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_IMAGE_NO_RT, "pass attachment image must be have render_target=true") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_COLOR_INV_PIXELFORMAT, "pass color-attachment images must be renderable color pixel format") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_DEPTH_INV_PIXELFORMAT, "pass depth-attachment image must be depth or depth-stencil pixel format") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_IMAGE_SIZES, "all pass attachments must have the same size") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_IMAGE_SAMPLE_COUNTS, "all pass attachments must have the same sample count") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_RESOLVE_COLOR_IMAGE_MSAA, "pass resolve attachments must have a color attachment image with sample count > 1") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_RESOLVE_IMAGE, "pass resolve attachment image not valid") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_RESOLVE_SAMPLE_COUNT, "pass resolve attachment image sample count must be 1") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_RESOLVE_MIPLEVEL, "pass resolve attachment mip level is bigger than image has mipmaps") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_RESOLVE_FACE, "pass resolve attachment is cubemap, but face index is too big") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_RESOLVE_LAYER, "pass resolve attachment is array texture, but layer index is too big") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_RESOLVE_SLICE, "pass resolve attachment is 3d texture, but slice value is too big") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_RESOLVE_IMAGE_NO_RT, "pass resolve attachment image must have render_target=true") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_RESOLVE_IMAGE_SIZES, "pass resolve attachment size must match color attachment image size") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_RESOLVE_IMAGE_FORMAT, "pass resolve attachment pixel format must match color attachment pixel format") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_DEPTH_IMAGE, "pass depth attachment image is not valid") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_DEPTH_MIPLEVEL, "pass depth attachment mip level is bigger than image has mipmaps") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_DEPTH_FACE, "pass depth attachment image is cubemap, but face index is too big") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_DEPTH_LAYER, "pass depth attachment image is array texture, but layer index is too big") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_DEPTH_SLICE, "pass depth attachment image is 3d texture, but slice value is too big") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_DEPTH_IMAGE_NO_RT, "pass depth attachment image must be have render_target=true") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_DEPTH_IMAGE_SIZES, "pass depth attachment image size must match color attachment image size") _SG_LOGITEM_XMACRO(VALIDATE_ATTACHMENTSDESC_DEPTH_IMAGE_SAMPLE_COUNT, "pass depth attachment sample count must match color attachment sample count") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_CANARY, "sg_begin_pass: pass struct not initialized") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_ATTACHMENTS_EXISTS, "sg_begin_pass: attachments object no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_ATTACHMENTS_VALID, "sg_begin_pass: attachments object not in resource state VALID") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_COLOR_ATTACHMENT_IMAGE, "sg_begin_pass: one or more color attachment images are not valid") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_RESOLVE_ATTACHMENT_IMAGE, "sg_begin_pass: one or more resolve attachment images are not valid") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_DEPTHSTENCIL_ATTACHMENT_IMAGE, "sg_begin_pass: one or more depth-stencil attachment images are not valid") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_WIDTH, "sg_begin_pass: expected pass.swapchain.width > 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_WIDTH_NOTSET, "sg_begin_pass: expected pass.swapchain.width == 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_HEIGHT, "sg_begin_pass: expected pass.swapchain.height > 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_HEIGHT_NOTSET, "sg_begin_pass: expected pass.swapchain.height == 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_SAMPLECOUNT, "sg_begin_pass: expected pass.swapchain.sample_count > 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_SAMPLECOUNT_NOTSET, "sg_begin_pass: expected pass.swapchain.sample_count == 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_COLORFORMAT, "sg_begin_pass: expected pass.swapchain.color_format to be valid") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_COLORFORMAT_NOTSET, "sg_begin_pass: expected pass.swapchain.color_format to be unset") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_DEPTHFORMAT_NOTSET, "sg_begin_pass: expected pass.swapchain.depth_format to be unset") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_METAL_EXPECT_CURRENTDRAWABLE, "sg_begin_pass: expected pass.swapchain.metal.current_drawable != 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_METAL_EXPECT_CURRENTDRAWABLE_NOTSET, "sg_begin_pass: expected pass.swapchain.metal.current_drawable == 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_METAL_EXPECT_DEPTHSTENCILTEXTURE, "sg_begin_pass: expected pass.swapchain.metal.depth_stencil_texture != 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_METAL_EXPECT_DEPTHSTENCILTEXTURE_NOTSET, "sg_begin_pass: expected pass.swapchain.metal.depth_stencil_texture == 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_METAL_EXPECT_MSAACOLORTEXTURE, "sg_begin_pass: expected pass.swapchain.metal.msaa_color_texture != 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_METAL_EXPECT_MSAACOLORTEXTURE_NOTSET, "sg_begin_pass: expected pass.swapchain.metal.msaa_color_texture == 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_D3D11_EXPECT_RENDERVIEW, "sg_begin_pass: expected pass.swapchain.d3d11.render_view != 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_D3D11_EXPECT_RENDERVIEW_NOTSET, "sg_begin_pass: expected pass.swapchain.d3d11.render_view == 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_D3D11_EXPECT_RESOLVEVIEW, "sg_begin_pass: expected pass.swapchain.d3d11.resolve_view != 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_D3D11_EXPECT_RESOLVEVIEW_NOTSET, "sg_begin_pass: expected pass.swapchain.d3d11.resolve_view == 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_D3D11_EXPECT_DEPTHSTENCILVIEW, "sg_begin_pass: expected pass.swapchain.d3d11.depth_stencil_view != 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_D3D11_EXPECT_DEPTHSTENCILVIEW_NOTSET, "sg_begin_pass: expected pass.swapchain.d3d11.depth_stencil_view == 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_WGPU_EXPECT_RENDERVIEW, "sg_begin_pass: expected pass.swapchain.wgpu.render_view != 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_WGPU_EXPECT_RENDERVIEW_NOTSET, "sg_begin_pass: expected pass.swapchain.wgpu.render_view == 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_WGPU_EXPECT_RESOLVEVIEW, "sg_begin_pass: expected pass.swapchain.wgpu.resolve_view != 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_WGPU_EXPECT_RESOLVEVIEW_NOTSET, "sg_begin_pass: expected pass.swapchain.wgpu.resolve_view == 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_WGPU_EXPECT_DEPTHSTENCILVIEW, "sg_begin_pass: expected pass.swapchain.wgpu.depth_stencil_view != 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_WGPU_EXPECT_DEPTHSTENCILVIEW_NOTSET, "sg_begin_pass: expected pass.swapchain.wgpu.depth_stencil_view == 0") _SG_LOGITEM_XMACRO(VALIDATE_BEGINPASS_SWAPCHAIN_GL_EXPECT_FRAMEBUFFER_NOTSET, "sg_begin_pass: expected pass.swapchain.gl.framebuffer == 0") _SG_LOGITEM_XMACRO(VALIDATE_APIP_PIPELINE_VALID_ID, "sg_apply_pipeline: invalid pipeline id provided") _SG_LOGITEM_XMACRO(VALIDATE_APIP_PIPELINE_EXISTS, "sg_apply_pipeline: pipeline object no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_APIP_PIPELINE_VALID, "sg_apply_pipeline: pipeline object not in valid state") _SG_LOGITEM_XMACRO(VALIDATE_APIP_SHADER_EXISTS, "sg_apply_pipeline: shader object no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_APIP_SHADER_VALID, "sg_apply_pipeline: shader object not in valid state") _SG_LOGITEM_XMACRO(VALIDATE_APIP_CURPASS_ATTACHMENTS_EXISTS, "sg_apply_pipeline: current pass attachments no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_APIP_CURPASS_ATTACHMENTS_VALID, "sg_apply_pipeline: current pass attachments not in valid state") _SG_LOGITEM_XMACRO(VALIDATE_APIP_ATT_COUNT, "sg_apply_pipeline: number of pipeline color attachments doesn't match number of pass color attachments") _SG_LOGITEM_XMACRO(VALIDATE_APIP_COLOR_FORMAT, "sg_apply_pipeline: pipeline color attachment pixel format doesn't match pass color attachment pixel format") _SG_LOGITEM_XMACRO(VALIDATE_APIP_DEPTH_FORMAT, "sg_apply_pipeline: pipeline depth pixel_format doesn't match pass depth attachment pixel format") _SG_LOGITEM_XMACRO(VALIDATE_APIP_SAMPLE_COUNT, "sg_apply_pipeline: pipeline MSAA sample count doesn't match render pass attachment sample count") _SG_LOGITEM_XMACRO(VALIDATE_ABND_PIPELINE, "sg_apply_bindings: must be called after sg_apply_pipeline") _SG_LOGITEM_XMACRO(VALIDATE_ABND_PIPELINE_EXISTS, "sg_apply_bindings: currently applied pipeline object no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_ABND_PIPELINE_VALID, "sg_apply_bindings: currently applied pipeline object not in valid state") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VBS, "sg_apply_bindings: number of vertex buffers doesn't match number of pipeline vertex layouts") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VB_EXISTS, "sg_apply_bindings: vertex buffer no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VB_TYPE, "sg_apply_bindings: buffer in vertex buffer slot is not a SG_BUFFERTYPE_VERTEXBUFFER") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VB_OVERFLOW, "sg_apply_bindings: buffer in vertex buffer slot is overflown") _SG_LOGITEM_XMACRO(VALIDATE_ABND_NO_IB, "sg_apply_bindings: pipeline object defines indexed rendering, but no index buffer provided") _SG_LOGITEM_XMACRO(VALIDATE_ABND_IB, "sg_apply_bindings: pipeline object defines non-indexed rendering, but index buffer provided") _SG_LOGITEM_XMACRO(VALIDATE_ABND_IB_EXISTS, "sg_apply_bindings: index buffer no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_ABND_IB_TYPE, "sg_apply_bindings: buffer in index buffer slot is not a SG_BUFFERTYPE_INDEXBUFFER") _SG_LOGITEM_XMACRO(VALIDATE_ABND_IB_OVERFLOW, "sg_apply_bindings: buffer in index buffer slot is overflown") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_EXPECTED_IMAGE_BINDING, "sg_apply_bindings: image binding on vertex stage is missing or the image handle is invalid") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_IMG_EXISTS, "sg_apply_bindings: image bound to vertex stage no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_IMAGE_TYPE_MISMATCH, "sg_apply_bindings: type of image bound to vertex stage doesn't match shader desc") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_IMAGE_MSAA, "sg_apply_bindings: cannot bind image with sample_count>1 to vertex stage") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_EXPECTED_FILTERABLE_IMAGE, "sg_apply_bindings: filterable image expected on vertex stage") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_EXPECTED_DEPTH_IMAGE, "sg_apply_bindings: depth image expected on vertex stage") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_UNEXPECTED_IMAGE_BINDING, "sg_apply_bindings: unexpected image binding on vertex stage") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_EXPECTED_SAMPLER_BINDING, "sg_apply_bindings: sampler binding on vertex stage is missing or the sampler handle is invalid") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_UNEXPECTED_SAMPLER_COMPARE_NEVER, "sg_apply_bindings: shader expects SG_SAMPLERTYPE_COMPARISON on vertex stage but sampler has SG_COMPAREFUNC_NEVER") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_EXPECTED_SAMPLER_COMPARE_NEVER, "sg_apply_bindings: shader expects SG_SAMPLERTYPE_FILTERING or SG_SAMPLERTYPE_NONFILTERING on vertex stage but sampler doesn't have SG_COMPAREFUNC_NEVER") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_EXPECTED_NONFILTERING_SAMPLER, "sg_apply_bindings: shader expected SG_SAMPLERTYPE_NONFILTERING on vertex stage, but sampler has SG_FILTER_LINEAR filters") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_UNEXPECTED_SAMPLER_BINDING, "sg_apply_bindings: unexpected sampler binding on vertex stage") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_SMP_EXISTS, "sg_apply_bindings: sampler bound to vertex stage no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_EXPECTED_STORAGEBUFFER_BINDING, "sg_apply_bindings: storage buffer binding on vertex stage is missing or the buffer handle is invalid") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_STORAGEBUFFER_EXISTS, "sg_apply_bindings: storage buffer bound to vertex stage no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_STORAGEBUFFER_BINDING_BUFFERTYPE, "sg_apply_bindings: buffer bound to vertex stage storage buffer slot is not of type storage buffer") _SG_LOGITEM_XMACRO(VALIDATE_ABND_VS_UNEXPECTED_STORAGEBUFFER_BINDING, "sg_apply_bindings: unexpected storage buffer binding on vertex stage") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_EXPECTED_IMAGE_BINDING, "sg_apply_bindings: image binding on fragment stage is missing or the image handle is invalid") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_IMG_EXISTS, "sg_apply_bindings: image bound to fragment stage no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_IMAGE_TYPE_MISMATCH, "sg_apply_bindings: type of image bound to fragment stage doesn't match shader desc") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_IMAGE_MSAA, "sg_apply_bindings: cannot bind image with sample_count>1 to fragment stage") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_EXPECTED_FILTERABLE_IMAGE, "sg_apply_bindings: filterable image expected on fragment stage") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_EXPECTED_DEPTH_IMAGE, "sg_apply_bindings: depth image expected on fragment stage") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_UNEXPECTED_IMAGE_BINDING, "sg_apply_bindings: unexpected image binding on fragment stage") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_EXPECTED_SAMPLER_BINDING, "sg_apply_bindings: sampler binding on fragment stage is missing or the sampler handle is invalid") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_UNEXPECTED_SAMPLER_COMPARE_NEVER, "sg_apply_bindings: shader expects SG_SAMPLERTYPE_COMPARISON on fragment stage but sampler has SG_COMPAREFUNC_NEVER") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_EXPECTED_SAMPLER_COMPARE_NEVER, "sg_apply_bindings: shader expects SG_SAMPLERTYPE_FILTERING on fragment stage but sampler doesn't have SG_COMPAREFUNC_NEVER") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_EXPECTED_NONFILTERING_SAMPLER, "sg_apply_bindings: shader expected SG_SAMPLERTYPE_NONFILTERING on fragment stage, but sampler has SG_FILTER_LINEAR filters") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_UNEXPECTED_SAMPLER_BINDING, "sg_apply_bindings: unexpected sampler binding on fragment stage") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_SMP_EXISTS, "sg_apply_bindings: sampler bound to fragment stage no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_EXPECTED_STORAGEBUFFER_BINDING, "sg_apply_bindings: storage buffer binding on fragment stage is missing or the buffer handle is invalid") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_STORAGEBUFFER_EXISTS, "sg_apply_bindings: storage buffer bound to fragment stage no longer alive") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_STORAGEBUFFER_BINDING_BUFFERTYPE, "sg_apply_bindings: buffer bound to frahment stage storage buffer slot is not of type storage buffer") _SG_LOGITEM_XMACRO(VALIDATE_ABND_FS_UNEXPECTED_STORAGEBUFFER_BINDING, "sg_apply_bindings: unexpected storage buffer binding on fragment stage") _SG_LOGITEM_XMACRO(VALIDATE_AUB_NO_PIPELINE, "sg_apply_uniforms: must be called after sg_apply_pipeline()") _SG_LOGITEM_XMACRO(VALIDATE_AUB_NO_UB_AT_SLOT, "sg_apply_uniforms: no uniform block declaration at this shader stage UB slot") _SG_LOGITEM_XMACRO(VALIDATE_AUB_SIZE, "sg_apply_uniforms: data size doesn't match declared uniform block size") _SG_LOGITEM_XMACRO(VALIDATE_UPDATEBUF_USAGE, "sg_update_buffer: cannot update immutable buffer") _SG_LOGITEM_XMACRO(VALIDATE_UPDATEBUF_SIZE, "sg_update_buffer: update size is bigger than buffer size") _SG_LOGITEM_XMACRO(VALIDATE_UPDATEBUF_ONCE, "sg_update_buffer: only one update allowed per buffer and frame") _SG_LOGITEM_XMACRO(VALIDATE_UPDATEBUF_APPEND, "sg_update_buffer: cannot call sg_update_buffer and sg_append_buffer in same frame") _SG_LOGITEM_XMACRO(VALIDATE_APPENDBUF_USAGE, "sg_append_buffer: cannot append to immutable buffer") _SG_LOGITEM_XMACRO(VALIDATE_APPENDBUF_SIZE, "sg_append_buffer: overall appended size is bigger than buffer size") _SG_LOGITEM_XMACRO(VALIDATE_APPENDBUF_UPDATE, "sg_append_buffer: cannot call sg_append_buffer and sg_update_buffer in same frame") _SG_LOGITEM_XMACRO(VALIDATE_UPDIMG_USAGE, "sg_update_image: cannot update immutable image") _SG_LOGITEM_XMACRO(VALIDATE_UPDIMG_ONCE, "sg_update_image: only one update allowed per image and frame") _SG_LOGITEM_XMACRO(VALIDATION_FAILED, "validation layer checks failed")
'' TODO: #define _SG_LOGITEM_XMACRO(item,msg) SG_LOGITEM_##item,

type sg_log_item as long
enum
	SG_LOGITEM_OK
	SG_LOGITEM_MALLOC_FAILED
	SG_LOGITEM_GL_TEXTURE_FORMAT_NOT_SUPPORTED
	SG_LOGITEM_GL_3D_TEXTURES_NOT_SUPPORTED
	SG_LOGITEM_GL_ARRAY_TEXTURES_NOT_SUPPORTED
	SG_LOGITEM_GL_SHADER_COMPILATION_FAILED
	SG_LOGITEM_GL_SHADER_LINKING_FAILED
	SG_LOGITEM_GL_VERTEX_ATTRIBUTE_NOT_FOUND_IN_SHADER
	SG_LOGITEM_GL_TEXTURE_NAME_NOT_FOUND_IN_SHADER
	SG_LOGITEM_GL_FRAMEBUFFER_STATUS_UNDEFINED
	SG_LOGITEM_GL_FRAMEBUFFER_STATUS_INCOMPLETE_ATTACHMENT
	SG_LOGITEM_GL_FRAMEBUFFER_STATUS_INCOMPLETE_MISSING_ATTACHMENT
	SG_LOGITEM_GL_FRAMEBUFFER_STATUS_UNSUPPORTED
	SG_LOGITEM_GL_FRAMEBUFFER_STATUS_INCOMPLETE_MULTISAMPLE
	SG_LOGITEM_GL_FRAMEBUFFER_STATUS_UNKNOWN
	SG_LOGITEM_D3D11_CREATE_BUFFER_FAILED
	SG_LOGITEM_D3D11_CREATE_BUFFER_SRV_FAILED
	SG_LOGITEM_D3D11_CREATE_DEPTH_TEXTURE_UNSUPPORTED_PIXEL_FORMAT
	SG_LOGITEM_D3D11_CREATE_DEPTH_TEXTURE_FAILED
	SG_LOGITEM_D3D11_CREATE_2D_TEXTURE_UNSUPPORTED_PIXEL_FORMAT
	SG_LOGITEM_D3D11_CREATE_2D_TEXTURE_FAILED
	SG_LOGITEM_D3D11_CREATE_2D_SRV_FAILED
	SG_LOGITEM_D3D11_CREATE_3D_TEXTURE_UNSUPPORTED_PIXEL_FORMAT
	SG_LOGITEM_D3D11_CREATE_3D_TEXTURE_FAILED
	SG_LOGITEM_D3D11_CREATE_3D_SRV_FAILED
	SG_LOGITEM_D3D11_CREATE_MSAA_TEXTURE_FAILED
	SG_LOGITEM_D3D11_CREATE_SAMPLER_STATE_FAILED
	SG_LOGITEM_D3D11_LOAD_D3DCOMPILER_47_DLL_FAILED
	SG_LOGITEM_D3D11_SHADER_COMPILATION_FAILED
	SG_LOGITEM_D3D11_SHADER_COMPILATION_OUTPUT
	SG_LOGITEM_D3D11_CREATE_CONSTANT_BUFFER_FAILED
	SG_LOGITEM_D3D11_CREATE_INPUT_LAYOUT_FAILED
	SG_LOGITEM_D3D11_CREATE_RASTERIZER_STATE_FAILED
	SG_LOGITEM_D3D11_CREATE_DEPTH_STENCIL_STATE_FAILED
	SG_LOGITEM_D3D11_CREATE_BLEND_STATE_FAILED
	SG_LOGITEM_D3D11_CREATE_RTV_FAILED
	SG_LOGITEM_D3D11_CREATE_DSV_FAILED
	SG_LOGITEM_D3D11_MAP_FOR_UPDATE_BUFFER_FAILED
	SG_LOGITEM_D3D11_MAP_FOR_APPEND_BUFFER_FAILED
	SG_LOGITEM_D3D11_MAP_FOR_UPDATE_IMAGE_FAILED
	SG_LOGITEM_METAL_CREATE_BUFFER_FAILED
	SG_LOGITEM_METAL_TEXTURE_FORMAT_NOT_SUPPORTED
	SG_LOGITEM_METAL_CREATE_TEXTURE_FAILED
	SG_LOGITEM_METAL_CREATE_SAMPLER_FAILED
	SG_LOGITEM_METAL_SHADER_COMPILATION_FAILED
	SG_LOGITEM_METAL_SHADER_CREATION_FAILED
	SG_LOGITEM_METAL_SHADER_COMPILATION_OUTPUT
	SG_LOGITEM_METAL_VERTEX_SHADER_ENTRY_NOT_FOUND
	SG_LOGITEM_METAL_FRAGMENT_SHADER_ENTRY_NOT_FOUND
	SG_LOGITEM_METAL_CREATE_RPS_FAILED
	SG_LOGITEM_METAL_CREATE_RPS_OUTPUT
	SG_LOGITEM_METAL_CREATE_DSS_FAILED
	SG_LOGITEM_WGPU_BINDGROUPS_POOL_EXHAUSTED
	SG_LOGITEM_WGPU_BINDGROUPSCACHE_SIZE_GREATER_ONE
	SG_LOGITEM_WGPU_BINDGROUPSCACHE_SIZE_POW2
	SG_LOGITEM_WGPU_CREATEBINDGROUP_FAILED
	SG_LOGITEM_WGPU_CREATE_BUFFER_FAILED
	SG_LOGITEM_WGPU_CREATE_TEXTURE_FAILED
	SG_LOGITEM_WGPU_CREATE_TEXTURE_VIEW_FAILED
	SG_LOGITEM_WGPU_CREATE_SAMPLER_FAILED
	SG_LOGITEM_WGPU_CREATE_SHADER_MODULE_FAILED
	SG_LOGITEM_WGPU_SHADER_TOO_MANY_IMAGES
	SG_LOGITEM_WGPU_SHADER_TOO_MANY_SAMPLERS
	SG_LOGITEM_WGPU_SHADER_TOO_MANY_STORAGEBUFFERS
	SG_LOGITEM_WGPU_SHADER_CREATE_BINDGROUP_LAYOUT_FAILED
	SG_LOGITEM_WGPU_CREATE_PIPELINE_LAYOUT_FAILED
	SG_LOGITEM_WGPU_CREATE_RENDER_PIPELINE_FAILED
	SG_LOGITEM_WGPU_ATTACHMENTS_CREATE_TEXTURE_VIEW_FAILED
	SG_LOGITEM_IDENTICAL_COMMIT_LISTENER
	SG_LOGITEM_COMMIT_LISTENER_ARRAY_FULL
	SG_LOGITEM_TRACE_HOOKS_NOT_ENABLED
	SG_LOGITEM_DEALLOC_BUFFER_INVALID_STATE
	SG_LOGITEM_DEALLOC_IMAGE_INVALID_STATE
	SG_LOGITEM_DEALLOC_SAMPLER_INVALID_STATE
	SG_LOGITEM_DEALLOC_SHADER_INVALID_STATE
	SG_LOGITEM_DEALLOC_PIPELINE_INVALID_STATE
	SG_LOGITEM_DEALLOC_ATTACHMENTS_INVALID_STATE
	SG_LOGITEM_INIT_BUFFER_INVALID_STATE
	SG_LOGITEM_INIT_IMAGE_INVALID_STATE
	SG_LOGITEM_INIT_SAMPLER_INVALID_STATE
	SG_LOGITEM_INIT_SHADER_INVALID_STATE
	SG_LOGITEM_INIT_PIPELINE_INVALID_STATE
	SG_LOGITEM_INIT_ATTACHMENTS_INVALID_STATE
	SG_LOGITEM_UNINIT_BUFFER_INVALID_STATE
	SG_LOGITEM_UNINIT_IMAGE_INVALID_STATE
	SG_LOGITEM_UNINIT_SAMPLER_INVALID_STATE
	SG_LOGITEM_UNINIT_SHADER_INVALID_STATE
	SG_LOGITEM_UNINIT_PIPELINE_INVALID_STATE
	SG_LOGITEM_UNINIT_ATTACHMENTS_INVALID_STATE
	SG_LOGITEM_FAIL_BUFFER_INVALID_STATE
	SG_LOGITEM_FAIL_IMAGE_INVALID_STATE
	SG_LOGITEM_FAIL_SAMPLER_INVALID_STATE
	SG_LOGITEM_FAIL_SHADER_INVALID_STATE
	SG_LOGITEM_FAIL_PIPELINE_INVALID_STATE
	SG_LOGITEM_FAIL_ATTACHMENTS_INVALID_STATE
	SG_LOGITEM_BUFFER_POOL_EXHAUSTED
	SG_LOGITEM_IMAGE_POOL_EXHAUSTED
	SG_LOGITEM_SAMPLER_POOL_EXHAUSTED
	SG_LOGITEM_SHADER_POOL_EXHAUSTED
	SG_LOGITEM_PIPELINE_POOL_EXHAUSTED
	SG_LOGITEM_PASS_POOL_EXHAUSTED
	SG_LOGITEM_BEGINPASS_ATTACHMENT_INVALID
	SG_LOGITEM_DRAW_WITHOUT_BINDINGS
	SG_LOGITEM_VALIDATE_BUFFERDESC_CANARY
	SG_LOGITEM_VALIDATE_BUFFERDESC_SIZE
	SG_LOGITEM_VALIDATE_BUFFERDESC_DATA
	SG_LOGITEM_VALIDATE_BUFFERDESC_DATA_SIZE
	SG_LOGITEM_VALIDATE_BUFFERDESC_NO_DATA
	SG_LOGITEM_VALIDATE_BUFFERDESC_STORAGEBUFFER_SUPPORTED
	SG_LOGITEM_VALIDATE_BUFFERDESC_STORAGEBUFFER_SIZE_MULTIPLE_4
	SG_LOGITEM_VALIDATE_IMAGEDATA_NODATA
	SG_LOGITEM_VALIDATE_IMAGEDATA_DATA_SIZE
	SG_LOGITEM_VALIDATE_IMAGEDESC_CANARY
	SG_LOGITEM_VALIDATE_IMAGEDESC_WIDTH
	SG_LOGITEM_VALIDATE_IMAGEDESC_HEIGHT
	SG_LOGITEM_VALIDATE_IMAGEDESC_RT_PIXELFORMAT
	SG_LOGITEM_VALIDATE_IMAGEDESC_NONRT_PIXELFORMAT
	SG_LOGITEM_VALIDATE_IMAGEDESC_MSAA_BUT_NO_RT
	SG_LOGITEM_VALIDATE_IMAGEDESC_NO_MSAA_RT_SUPPORT
	SG_LOGITEM_VALIDATE_IMAGEDESC_MSAA_NUM_MIPMAPS
	SG_LOGITEM_VALIDATE_IMAGEDESC_MSAA_3D_IMAGE
	SG_LOGITEM_VALIDATE_IMAGEDESC_DEPTH_3D_IMAGE
	SG_LOGITEM_VALIDATE_IMAGEDESC_RT_IMMUTABLE
	SG_LOGITEM_VALIDATE_IMAGEDESC_RT_NO_DATA
	SG_LOGITEM_VALIDATE_IMAGEDESC_INJECTED_NO_DATA
	SG_LOGITEM_VALIDATE_IMAGEDESC_DYNAMIC_NO_DATA
	SG_LOGITEM_VALIDATE_IMAGEDESC_COMPRESSED_IMMUTABLE
	SG_LOGITEM_VALIDATE_SAMPLERDESC_CANARY
	SG_LOGITEM_VALIDATE_SAMPLERDESC_MINFILTER_NONE
	SG_LOGITEM_VALIDATE_SAMPLERDESC_MAGFILTER_NONE
	SG_LOGITEM_VALIDATE_SAMPLERDESC_ANISTROPIC_REQUIRES_LINEAR_FILTERING
	SG_LOGITEM_VALIDATE_SHADERDESC_CANARY
	SG_LOGITEM_VALIDATE_SHADERDESC_SOURCE
	SG_LOGITEM_VALIDATE_SHADERDESC_BYTECODE
	SG_LOGITEM_VALIDATE_SHADERDESC_SOURCE_OR_BYTECODE
	SG_LOGITEM_VALIDATE_SHADERDESC_NO_BYTECODE_SIZE
	SG_LOGITEM_VALIDATE_SHADERDESC_NO_CONT_UBS
	SG_LOGITEM_VALIDATE_SHADERDESC_NO_CONT_UB_MEMBERS
	SG_LOGITEM_VALIDATE_SHADERDESC_NO_UB_MEMBERS
	SG_LOGITEM_VALIDATE_SHADERDESC_UB_MEMBER_NAME
	SG_LOGITEM_VALIDATE_SHADERDESC_UB_SIZE_MISMATCH
	SG_LOGITEM_VALIDATE_SHADERDESC_UB_ARRAY_COUNT
	SG_LOGITEM_VALIDATE_SHADERDESC_UB_STD140_ARRAY_TYPE
	SG_LOGITEM_VALIDATE_SHADERDESC_NO_CONT_STORAGEBUFFERS
	SG_LOGITEM_VALIDATE_SHADERDESC_STORAGEBUFFER_READONLY
	SG_LOGITEM_VALIDATE_SHADERDESC_NO_CONT_IMAGES
	SG_LOGITEM_VALIDATE_SHADERDESC_NO_CONT_SAMPLERS
	SG_LOGITEM_VALIDATE_SHADERDESC_IMAGE_SAMPLER_PAIR_IMAGE_SLOT_OUT_OF_RANGE
	SG_LOGITEM_VALIDATE_SHADERDESC_IMAGE_SAMPLER_PAIR_SAMPLER_SLOT_OUT_OF_RANGE
	SG_LOGITEM_VALIDATE_SHADERDESC_IMAGE_SAMPLER_PAIR_NAME_REQUIRED_FOR_GL
	SG_LOGITEM_VALIDATE_SHADERDESC_IMAGE_SAMPLER_PAIR_HAS_NAME_BUT_NOT_USED
	SG_LOGITEM_VALIDATE_SHADERDESC_IMAGE_SAMPLER_PAIR_HAS_IMAGE_BUT_NOT_USED
	SG_LOGITEM_VALIDATE_SHADERDESC_IMAGE_SAMPLER_PAIR_HAS_SAMPLER_BUT_NOT_USED
	SG_LOGITEM_VALIDATE_SHADERDESC_NONFILTERING_SAMPLER_REQUIRED
	SG_LOGITEM_VALIDATE_SHADERDESC_COMPARISON_SAMPLER_REQUIRED
	SG_LOGITEM_VALIDATE_SHADERDESC_IMAGE_NOT_REFERENCED_BY_IMAGE_SAMPLER_PAIRS
	SG_LOGITEM_VALIDATE_SHADERDESC_SAMPLER_NOT_REFERENCED_BY_IMAGE_SAMPLER_PAIRS
	SG_LOGITEM_VALIDATE_SHADERDESC_NO_CONT_IMAGE_SAMPLER_PAIRS
	SG_LOGITEM_VALIDATE_SHADERDESC_ATTR_STRING_TOO_LONG
	SG_LOGITEM_VALIDATE_PIPELINEDESC_CANARY
	SG_LOGITEM_VALIDATE_PIPELINEDESC_SHADER
	SG_LOGITEM_VALIDATE_PIPELINEDESC_NO_CONT_ATTRS
	SG_LOGITEM_VALIDATE_PIPELINEDESC_LAYOUT_STRIDE4
	SG_LOGITEM_VALIDATE_PIPELINEDESC_ATTR_SEMANTICS
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_CANARY
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_NO_ATTACHMENTS
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_NO_CONT_COLOR_ATTS
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_IMAGE
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_MIPLEVEL
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_FACE
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_LAYER
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_SLICE
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_IMAGE_NO_RT
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_COLOR_INV_PIXELFORMAT
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_DEPTH_INV_PIXELFORMAT
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_IMAGE_SIZES
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_IMAGE_SAMPLE_COUNTS
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_RESOLVE_COLOR_IMAGE_MSAA
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_RESOLVE_IMAGE
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_RESOLVE_SAMPLE_COUNT
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_RESOLVE_MIPLEVEL
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_RESOLVE_FACE
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_RESOLVE_LAYER
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_RESOLVE_SLICE
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_RESOLVE_IMAGE_NO_RT
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_RESOLVE_IMAGE_SIZES
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_RESOLVE_IMAGE_FORMAT
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_DEPTH_IMAGE
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_DEPTH_MIPLEVEL
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_DEPTH_FACE
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_DEPTH_LAYER
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_DEPTH_SLICE
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_DEPTH_IMAGE_NO_RT
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_DEPTH_IMAGE_SIZES
	SG_LOGITEM_VALIDATE_ATTACHMENTSDESC_DEPTH_IMAGE_SAMPLE_COUNT
	SG_LOGITEM_VALIDATE_BEGINPASS_CANARY
	SG_LOGITEM_VALIDATE_BEGINPASS_ATTACHMENTS_EXISTS
	SG_LOGITEM_VALIDATE_BEGINPASS_ATTACHMENTS_VALID
	SG_LOGITEM_VALIDATE_BEGINPASS_COLOR_ATTACHMENT_IMAGE
	SG_LOGITEM_VALIDATE_BEGINPASS_RESOLVE_ATTACHMENT_IMAGE
	SG_LOGITEM_VALIDATE_BEGINPASS_DEPTHSTENCIL_ATTACHMENT_IMAGE
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_WIDTH
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_WIDTH_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_HEIGHT
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_HEIGHT_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_SAMPLECOUNT
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_SAMPLECOUNT_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_COLORFORMAT
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_COLORFORMAT_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_EXPECT_DEPTHFORMAT_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_METAL_EXPECT_CURRENTDRAWABLE
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_METAL_EXPECT_CURRENTDRAWABLE_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_METAL_EXPECT_DEPTHSTENCILTEXTURE
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_METAL_EXPECT_DEPTHSTENCILTEXTURE_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_METAL_EXPECT_MSAACOLORTEXTURE
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_METAL_EXPECT_MSAACOLORTEXTURE_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_D3D11_EXPECT_RENDERVIEW
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_D3D11_EXPECT_RENDERVIEW_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_D3D11_EXPECT_RESOLVEVIEW
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_D3D11_EXPECT_RESOLVEVIEW_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_D3D11_EXPECT_DEPTHSTENCILVIEW
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_D3D11_EXPECT_DEPTHSTENCILVIEW_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_WGPU_EXPECT_RENDERVIEW
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_WGPU_EXPECT_RENDERVIEW_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_WGPU_EXPECT_RESOLVEVIEW
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_WGPU_EXPECT_RESOLVEVIEW_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_WGPU_EXPECT_DEPTHSTENCILVIEW
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_WGPU_EXPECT_DEPTHSTENCILVIEW_NOTSET
	SG_LOGITEM_VALIDATE_BEGINPASS_SWAPCHAIN_GL_EXPECT_FRAMEBUFFER_NOTSET
	SG_LOGITEM_VALIDATE_APIP_PIPELINE_VALID_ID
	SG_LOGITEM_VALIDATE_APIP_PIPELINE_EXISTS
	SG_LOGITEM_VALIDATE_APIP_PIPELINE_VALID
	SG_LOGITEM_VALIDATE_APIP_SHADER_EXISTS
	SG_LOGITEM_VALIDATE_APIP_SHADER_VALID
	SG_LOGITEM_VALIDATE_APIP_CURPASS_ATTACHMENTS_EXISTS
	SG_LOGITEM_VALIDATE_APIP_CURPASS_ATTACHMENTS_VALID
	SG_LOGITEM_VALIDATE_APIP_ATT_COUNT
	SG_LOGITEM_VALIDATE_APIP_COLOR_FORMAT
	SG_LOGITEM_VALIDATE_APIP_DEPTH_FORMAT
	SG_LOGITEM_VALIDATE_APIP_SAMPLE_COUNT
	SG_LOGITEM_VALIDATE_ABND_PIPELINE
	SG_LOGITEM_VALIDATE_ABND_PIPELINE_EXISTS
	SG_LOGITEM_VALIDATE_ABND_PIPELINE_VALID
	SG_LOGITEM_VALIDATE_ABND_VBS
	SG_LOGITEM_VALIDATE_ABND_VB_EXISTS
	SG_LOGITEM_VALIDATE_ABND_VB_TYPE
	SG_LOGITEM_VALIDATE_ABND_VB_OVERFLOW
	SG_LOGITEM_VALIDATE_ABND_NO_IB
	SG_LOGITEM_VALIDATE_ABND_IB
	SG_LOGITEM_VALIDATE_ABND_IB_EXISTS
	SG_LOGITEM_VALIDATE_ABND_IB_TYPE
	SG_LOGITEM_VALIDATE_ABND_IB_OVERFLOW
	SG_LOGITEM_VALIDATE_ABND_VS_EXPECTED_IMAGE_BINDING
	SG_LOGITEM_VALIDATE_ABND_VS_IMG_EXISTS
	SG_LOGITEM_VALIDATE_ABND_VS_IMAGE_TYPE_MISMATCH
	SG_LOGITEM_VALIDATE_ABND_VS_IMAGE_MSAA
	SG_LOGITEM_VALIDATE_ABND_VS_EXPECTED_FILTERABLE_IMAGE
	SG_LOGITEM_VALIDATE_ABND_VS_EXPECTED_DEPTH_IMAGE
	SG_LOGITEM_VALIDATE_ABND_VS_UNEXPECTED_IMAGE_BINDING
	SG_LOGITEM_VALIDATE_ABND_VS_EXPECTED_SAMPLER_BINDING
	SG_LOGITEM_VALIDATE_ABND_VS_UNEXPECTED_SAMPLER_COMPARE_NEVER
	SG_LOGITEM_VALIDATE_ABND_VS_EXPECTED_SAMPLER_COMPARE_NEVER
	SG_LOGITEM_VALIDATE_ABND_VS_EXPECTED_NONFILTERING_SAMPLER
	SG_LOGITEM_VALIDATE_ABND_VS_UNEXPECTED_SAMPLER_BINDING
	SG_LOGITEM_VALIDATE_ABND_VS_SMP_EXISTS
	SG_LOGITEM_VALIDATE_ABND_VS_EXPECTED_STORAGEBUFFER_BINDING
	SG_LOGITEM_VALIDATE_ABND_VS_STORAGEBUFFER_EXISTS
	SG_LOGITEM_VALIDATE_ABND_VS_STORAGEBUFFER_BINDING_BUFFERTYPE
	SG_LOGITEM_VALIDATE_ABND_VS_UNEXPECTED_STORAGEBUFFER_BINDING
	SG_LOGITEM_VALIDATE_ABND_FS_EXPECTED_IMAGE_BINDING
	SG_LOGITEM_VALIDATE_ABND_FS_IMG_EXISTS
	SG_LOGITEM_VALIDATE_ABND_FS_IMAGE_TYPE_MISMATCH
	SG_LOGITEM_VALIDATE_ABND_FS_IMAGE_MSAA
	SG_LOGITEM_VALIDATE_ABND_FS_EXPECTED_FILTERABLE_IMAGE
	SG_LOGITEM_VALIDATE_ABND_FS_EXPECTED_DEPTH_IMAGE
	SG_LOGITEM_VALIDATE_ABND_FS_UNEXPECTED_IMAGE_BINDING
	SG_LOGITEM_VALIDATE_ABND_FS_EXPECTED_SAMPLER_BINDING
	SG_LOGITEM_VALIDATE_ABND_FS_UNEXPECTED_SAMPLER_COMPARE_NEVER
	SG_LOGITEM_VALIDATE_ABND_FS_EXPECTED_SAMPLER_COMPARE_NEVER
	SG_LOGITEM_VALIDATE_ABND_FS_EXPECTED_NONFILTERING_SAMPLER
	SG_LOGITEM_VALIDATE_ABND_FS_UNEXPECTED_SAMPLER_BINDING
	SG_LOGITEM_VALIDATE_ABND_FS_SMP_EXISTS
	SG_LOGITEM_VALIDATE_ABND_FS_EXPECTED_STORAGEBUFFER_BINDING
	SG_LOGITEM_VALIDATE_ABND_FS_STORAGEBUFFER_EXISTS
	SG_LOGITEM_VALIDATE_ABND_FS_STORAGEBUFFER_BINDING_BUFFERTYPE
	SG_LOGITEM_VALIDATE_ABND_FS_UNEXPECTED_STORAGEBUFFER_BINDING
	SG_LOGITEM_VALIDATE_AUB_NO_PIPELINE
	SG_LOGITEM_VALIDATE_AUB_NO_UB_AT_SLOT
	SG_LOGITEM_VALIDATE_AUB_SIZE
	SG_LOGITEM_VALIDATE_UPDATEBUF_USAGE
	SG_LOGITEM_VALIDATE_UPDATEBUF_SIZE
	SG_LOGITEM_VALIDATE_UPDATEBUF_ONCE
	SG_LOGITEM_VALIDATE_UPDATEBUF_APPEND
	SG_LOGITEM_VALIDATE_APPENDBUF_USAGE
	SG_LOGITEM_VALIDATE_APPENDBUF_SIZE
	SG_LOGITEM_VALIDATE_APPENDBUF_UPDATE
	SG_LOGITEM_VALIDATE_UPDIMG_USAGE
	SG_LOGITEM_VALIDATE_UPDIMG_ONCE
	SG_LOGITEM_VALIDATION_FAILED
end enum

#undef _SG_LOGITEM_XMACRO

type sg_environment_defaults
	color_format as sg_pixel_format
	depth_format as sg_pixel_format
	sample_count as long
end type

type sg_metal_environment
	device as const any ptr
end type

type sg_d3d11_environment
	device as const any ptr
	device_context as const any ptr
end type

type sg_wgpu_environment
	device as const any ptr
end type

type sg_environment
	defaults as sg_environment_defaults
	metal as sg_metal_environment
	d3d11 as sg_d3d11_environment
	wgpu as sg_wgpu_environment
end type

type sg_commit_listener
	func as sub(byval user_data as any ptr)
	user_data as any ptr
end type

type sg_allocator
	alloc_fn as function(byval size as uinteger, byval user_data as any ptr) as any ptr
	free_fn as sub(byval ptr as any ptr, byval user_data as any ptr)
	user_data as any ptr
end type

type sg_logger
	func as sub(byval tag as const zstring ptr, byval log_level as ulong, byval log_item_id as ulong, byval message_or_null as const zstring ptr, byval line_nr as ulong, byval filename_or_null as const zstring ptr, byval user_data as any ptr)
	user_data as any ptr
end type

type sg_desc
	_start_canary as ulong
	buffer_pool_size as long
	image_pool_size as long
	sampler_pool_size as long
	shader_pool_size as long
	pipeline_pool_size as long
	attachments_pool_size as long
	uniform_buffer_size as long
	max_commit_listeners as long
	disable_validation as byte
	mtl_force_managed_storage_mode as byte
	mtl_use_command_buffer_with_retained_references as byte
	wgpu_disable_bindgroups_cache as byte
	wgpu_bindgroups_cache_size as long
	allocator as sg_allocator
	logger as sg_logger
	environment as sg_environment
	_end_canary as ulong
end type

declare sub sg_setup(byval desc as const sg_desc ptr)
declare sub sg_shutdown()
declare function sg_isvalid() as byte
declare sub sg_reset_state_cache()
declare function sg_install_trace_hooks(byval trace_hooks as const sg_trace_hooks ptr) as sg_trace_hooks
declare sub sg_push_debug_group(byval name as const zstring ptr)
declare sub sg_pop_debug_group()
declare function sg_add_commit_listener(byval listener as sg_commit_listener) as byte
declare function sg_remove_commit_listener(byval listener as sg_commit_listener) as byte
declare function sg_make_buffer(byval desc as const sg_buffer_desc ptr) as sg_buffer
declare function sg_make_image(byval desc as const sg_image_desc ptr) as sg_image
declare function sg_make_sampler(byval desc as const sg_sampler_desc ptr) as sg_sampler
declare function sg_make_shader(byval desc as const sg_shader_desc ptr) as sg_shader
declare function sg_make_pipeline(byval desc as const sg_pipeline_desc ptr) as sg_pipeline
declare function sg_make_attachments(byval desc as const sg_attachments_desc ptr) as sg_attachments
declare sub sg_destroy_buffer(byval buf as sg_buffer)
declare sub sg_destroy_image(byval img as sg_image)
declare sub sg_destroy_sampler(byval smp as sg_sampler)
declare sub sg_destroy_shader(byval shd as sg_shader)
declare sub sg_destroy_pipeline(byval pip as sg_pipeline)
declare sub sg_destroy_attachments(byval atts as sg_attachments)
declare sub sg_update_buffer(byval buf as sg_buffer, byval data as const sg_range ptr)
declare sub sg_update_image(byval img as sg_image, byval data as const sg_image_data ptr)
declare function sg_append_buffer(byval buf as sg_buffer, byval data as const sg_range ptr) as long
declare function sg_query_buffer_overflow(byval buf as sg_buffer) as byte
declare function sg_query_buffer_will_overflow(byval buf as sg_buffer, byval size as uinteger) as byte
declare sub sg_begin_pass(byval pass as const sg_pass ptr)
declare sub sg_apply_viewport(byval x as long, byval y as long, byval width as long, byval height as long, byval origin_top_left as byte)
declare sub sg_apply_viewportf(byval x as single, byval y as single, byval width as single, byval height as single, byval origin_top_left as byte)
declare sub sg_apply_scissor_rect(byval x as long, byval y as long, byval width as long, byval height as long, byval origin_top_left as byte)
declare sub sg_apply_scissor_rectf(byval x as single, byval y as single, byval width as single, byval height as single, byval origin_top_left as byte)
declare sub sg_apply_pipeline(byval pip as sg_pipeline)
declare sub sg_apply_bindings(byval bindings as const sg_bindings ptr)
declare sub sg_apply_uniforms(byval stage as sg_shader_stage, byval ub_index as long, byval data as const sg_range ptr)
declare sub sg_draw(byval base_element as long, byval num_elements as long, byval num_instances as long)
declare sub sg_end_pass()
declare sub sg_commit()
declare function sg_query_desc() as sg_desc
declare function sg_query_backend() as sg_backend
declare function sg_query_features() as sg_features
declare function sg_query_limits() as sg_limits
declare function sg_query_pixelformat(byval fmt as sg_pixel_format) as sg_pixelformat_info
declare function sg_query_row_pitch(byval fmt as sg_pixel_format, byval width as long, byval row_align_bytes as long) as long
declare function sg_query_surface_pitch(byval fmt as sg_pixel_format, byval width as long, byval height as long, byval row_align_bytes as long) as long
declare function sg_query_buffer_state(byval buf as sg_buffer) as sg_resource_state
declare function sg_query_image_state(byval img as sg_image) as sg_resource_state
declare function sg_query_sampler_state(byval smp as sg_sampler) as sg_resource_state
declare function sg_query_shader_state(byval shd as sg_shader) as sg_resource_state
declare function sg_query_pipeline_state(byval pip as sg_pipeline) as sg_resource_state
declare function sg_query_attachments_state(byval atts as sg_attachments) as sg_resource_state
declare function sg_query_buffer_info(byval buf as sg_buffer) as sg_buffer_info
declare function sg_query_image_info(byval img as sg_image) as sg_image_info
declare function sg_query_sampler_info(byval smp as sg_sampler) as sg_sampler_info
declare function sg_query_shader_info(byval shd as sg_shader) as sg_shader_info
declare function sg_query_pipeline_info(byval pip as sg_pipeline) as sg_pipeline_info
declare function sg_query_attachments_info(byval atts as sg_attachments) as sg_attachments_info
declare function sg_query_buffer_desc(byval buf as sg_buffer) as sg_buffer_desc
declare function sg_query_image_desc(byval img as sg_image) as sg_image_desc
declare function sg_query_sampler_desc(byval smp as sg_sampler) as sg_sampler_desc
declare function sg_query_shader_desc(byval shd as sg_shader) as sg_shader_desc
declare function sg_query_pipeline_desc(byval pip as sg_pipeline) as sg_pipeline_desc
declare function sg_query_attachments_desc(byval atts as sg_attachments) as sg_attachments_desc
declare function sg_query_buffer_defaults(byval desc as const sg_buffer_desc ptr) as sg_buffer_desc
declare function sg_query_image_defaults(byval desc as const sg_image_desc ptr) as sg_image_desc
declare function sg_query_sampler_defaults(byval desc as const sg_sampler_desc ptr) as sg_sampler_desc
declare function sg_query_shader_defaults(byval desc as const sg_shader_desc ptr) as sg_shader_desc
declare function sg_query_pipeline_defaults(byval desc as const sg_pipeline_desc ptr) as sg_pipeline_desc
declare function sg_query_attachments_defaults(byval desc as const sg_attachments_desc ptr) as sg_attachments_desc
declare function sg_alloc_buffer() as sg_buffer
declare function sg_alloc_image() as sg_image
declare function sg_alloc_sampler() as sg_sampler
declare function sg_alloc_shader() as sg_shader
declare function sg_alloc_pipeline() as sg_pipeline
declare function sg_alloc_attachments() as sg_attachments
declare sub sg_dealloc_buffer(byval buf as sg_buffer)
declare sub sg_dealloc_image(byval img as sg_image)
declare sub sg_dealloc_sampler(byval smp as sg_sampler)
declare sub sg_dealloc_shader(byval shd as sg_shader)
declare sub sg_dealloc_pipeline(byval pip as sg_pipeline)
declare sub sg_dealloc_attachments(byval attachments as sg_attachments)
declare sub sg_init_buffer(byval buf as sg_buffer, byval desc as const sg_buffer_desc ptr)
declare sub sg_init_image(byval img as sg_image, byval desc as const sg_image_desc ptr)
declare sub sg_init_sampler(byval smg as sg_sampler, byval desc as const sg_sampler_desc ptr)
declare sub sg_init_shader(byval shd as sg_shader, byval desc as const sg_shader_desc ptr)
declare sub sg_init_pipeline(byval pip as sg_pipeline, byval desc as const sg_pipeline_desc ptr)
declare sub sg_init_attachments(byval attachments as sg_attachments, byval desc as const sg_attachments_desc ptr)
declare sub sg_uninit_buffer(byval buf as sg_buffer)
declare sub sg_uninit_image(byval img as sg_image)
declare sub sg_uninit_sampler(byval smp as sg_sampler)
declare sub sg_uninit_shader(byval shd as sg_shader)
declare sub sg_uninit_pipeline(byval pip as sg_pipeline)
declare sub sg_uninit_attachments(byval atts as sg_attachments)
declare sub sg_fail_buffer(byval buf as sg_buffer)
declare sub sg_fail_image(byval img as sg_image)
declare sub sg_fail_sampler(byval smp as sg_sampler)
declare sub sg_fail_shader(byval shd as sg_shader)
declare sub sg_fail_pipeline(byval pip as sg_pipeline)
declare sub sg_fail_attachments(byval atts as sg_attachments)
declare sub sg_enable_frame_stats()
declare sub sg_disable_frame_stats()
declare function sg_frame_stats_enabled() as byte
declare function sg_query_frame_stats() as sg_frame_stats

type sg_d3d11_buffer_info
	buf as const any ptr
end type

type sg_d3d11_image_info
	tex2d as const any ptr
	tex3d as const any ptr
	res as const any ptr
	srv as const any ptr
end type

type sg_d3d11_sampler_info
	smp as const any ptr
end type

type sg_d3d11_shader_info
	vs_cbufs(0 to SG_MAX_SHADERSTAGE_UBS - 1) as const any ptr
	fs_cbufs(0 to SG_MAX_SHADERSTAGE_UBS - 1) as const any ptr
	vs as const any ptr
	fs as const any ptr
end type

type sg_d3d11_pipeline_info
	il as const any ptr
	rs as const any ptr
	dss as const any ptr
	bs as const any ptr
end type

type sg_d3d11_attachments_info
	color_rtv(0 to SG_MAX_COLOR_ATTACHMENTS - 1) as const any ptr
	resolve_rtv(0 to SG_MAX_COLOR_ATTACHMENTS - 1) as const any ptr
	dsv as const any ptr
end type

type sg_mtl_buffer_info
	buf(0 to SG_NUM_INFLIGHT_FRAMES - 1) as const any ptr
	active_slot as long
end type

type sg_mtl_image_info
	tex(0 to SG_NUM_INFLIGHT_FRAMES - 1) as const any ptr
	active_slot as long
end type

type sg_mtl_sampler_info
	smp as const any ptr
end type

type sg_mtl_shader_info
	vs_lib as const any ptr
	fs_lib as const any ptr
	vs_func as const any ptr
	fs_func as const any ptr
end type

type sg_mtl_pipeline_info
	rps as const any ptr
	dss as const any ptr
end type

type sg_wgpu_buffer_info
	buf as const any ptr
end type

type sg_wgpu_image_info
	tex as const any ptr
	view as const any ptr
end type

type sg_wgpu_sampler_info
	smp as const any ptr
end type

type sg_wgpu_shader_info
	vs_mod as const any ptr
	fs_mod as const any ptr
	bgl as const any ptr
end type

type sg_wgpu_pipeline_info
	pip as const any ptr
end type

type sg_wgpu_attachments_info
	color_view(0 to SG_MAX_COLOR_ATTACHMENTS - 1) as const any ptr
	resolve_view(0 to SG_MAX_COLOR_ATTACHMENTS - 1) as const any ptr
	ds_view as const any ptr
end type

type sg_gl_buffer_info
	buf(0 to SG_NUM_INFLIGHT_FRAMES - 1) as ulong
	active_slot as long
end type

type sg_gl_image_info
	tex(0 to SG_NUM_INFLIGHT_FRAMES - 1) as ulong
	tex_target as ulong
	msaa_render_buffer as ulong
	active_slot as long
end type

type sg_gl_sampler_info
	smp as ulong
end type

type sg_gl_shader_info
	prog as ulong
end type

type sg_gl_attachments_info
	framebuffer as ulong
	msaa_resolve_framebuffer(0 to SG_MAX_COLOR_ATTACHMENTS - 1) as ulong
end type

declare function sg_d3d11_device() as const any ptr
declare function sg_d3d11_device_context() as const any ptr
declare function sg_d3d11_query_buffer_info(byval buf as sg_buffer) as sg_d3d11_buffer_info
declare function sg_d3d11_query_image_info(byval img as sg_image) as sg_d3d11_image_info
declare function sg_d3d11_query_sampler_info(byval smp as sg_sampler) as sg_d3d11_sampler_info
declare function sg_d3d11_query_shader_info(byval shd as sg_shader) as sg_d3d11_shader_info
declare function sg_d3d11_query_pipeline_info(byval pip as sg_pipeline) as sg_d3d11_pipeline_info
declare function sg_d3d11_query_attachments_info(byval atts as sg_attachments) as sg_d3d11_attachments_info
declare function sg_mtl_device() as const any ptr
declare function sg_mtl_render_command_encoder() as const any ptr
declare function sg_mtl_query_buffer_info(byval buf as sg_buffer) as sg_mtl_buffer_info
declare function sg_mtl_query_image_info(byval img as sg_image) as sg_mtl_image_info
declare function sg_mtl_query_sampler_info(byval smp as sg_sampler) as sg_mtl_sampler_info
declare function sg_mtl_query_shader_info(byval shd as sg_shader) as sg_mtl_shader_info
declare function sg_mtl_query_pipeline_info(byval pip as sg_pipeline) as sg_mtl_pipeline_info
declare function sg_wgpu_device() as const any ptr
declare function sg_wgpu_queue() as const any ptr
declare function sg_wgpu_command_encoder() as const any ptr
declare function sg_wgpu_render_pass_encoder() as const any ptr
declare function sg_wgpu_query_buffer_info(byval buf as sg_buffer) as sg_wgpu_buffer_info
declare function sg_wgpu_query_image_info(byval img as sg_image) as sg_wgpu_image_info
declare function sg_wgpu_query_sampler_info(byval smp as sg_sampler) as sg_wgpu_sampler_info
declare function sg_wgpu_query_shader_info(byval shd as sg_shader) as sg_wgpu_shader_info
declare function sg_wgpu_query_pipeline_info(byval pip as sg_pipeline) as sg_wgpu_pipeline_info
declare function sg_wgpu_query_attachments_info(byval atts as sg_attachments) as sg_wgpu_attachments_info
declare function sg_gl_query_buffer_info(byval buf as sg_buffer) as sg_gl_buffer_info
declare function sg_gl_query_image_info(byval img as sg_image) as sg_gl_image_info
declare function sg_gl_query_sampler_info(byval smp as sg_sampler) as sg_gl_sampler_info
declare function sg_gl_query_shader_info(byval shd as sg_shader) as sg_gl_shader_info
declare function sg_gl_query_attachments_info(byval atts as sg_attachments) as sg_gl_attachments_info

end extern
