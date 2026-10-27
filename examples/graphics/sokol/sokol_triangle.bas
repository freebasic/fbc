''  sokol_triangle.bas - one window, one pipeline, one triangle
''
''  This is the smallest program that uses inc/sokol/ end to end: sokol_app
''  creates the window and the event loop, sokol_gfx owns the GPU pipeline, and
''  every call below goes through the generated FreeBASIC binding.  It closes
''  itself after 180 frames, so it can run unattended.
''
''  sokol is header-only.  The implementation lives in sokol_impl.m (macOS) or
''  sokol_impl.c (Windows, Linux) and is compiled separately; there is no sokol
''  library to link against.  See README.txt.
''
'  Build:   ./build-macos.sh
''  Output:  "sokol: backend=..." then "sokol: 180 frames".  Both are printed
''           from the callbacks: on macOS sapp_run() never returns (sokol_app
''           terminates the process from its NSApplication delegate).

#include once "sokol/sokol_gfx.bi"
#include once "sokol/sokol_app.bi"
#include once "sokol/sokol_log.bi"

const QUIT_AFTER_FRAMES = 180

dim shared as sg_pipeline g_pipeline
dim shared as ulongint    g_frames
dim shared as long        g_backend
dim shared as boolean     g_failed

sub on_init()
	dim desc as sg_desc
	desc.environment.defaults.color_format = cast( sg_pixel_format, sapp_color_format() )
	desc.environment.defaults.depth_format = cast( sg_pixel_format, sapp_depth_format() )
	desc.environment.defaults.sample_count = sapp_sample_count()
	desc.environment.metal.device = sapp_metal_get_device()
	desc.logger.func = @slog_func
	sg_setup( @desc )

	g_backend = sg_query_backend()
	print "sokol: backend=" & g_backend
	if sg_isvalid() = 0 then
		print "sokol: sg_setup failed"
		g_failed = true
		sapp_quit()
		exit sub
	end if

	'' The shader source is backend-specific: Metal takes MSL, the GL backends
	'' take GLSL.  A D3D11 build needs precompiled HLSL bytecode and is not
	'' covered here.  The strings stay alive until sg_make_shader() returns.

	dim as string msl_vs = _
		!"#include <metal_stdlib>\n" & _
		!"using namespace metal;\n" & _
		!"struct vs_out {\n" & _
		!"    float4 pos [[position]];\n" & _
		!"    float4 color;\n" & _
		!"};\n" & _
		!"vertex vs_out vs_main(uint vid [[vertex_id]]) {\n" & _
		!"    float4 p[3] = { float4( 0.0,  0.5, 0.0, 1.0),\n" & _
		!"                    float4( 0.5, -0.5, 0.0, 1.0),\n" & _
		!"                    float4(-0.5, -0.5, 0.0, 1.0) };\n" & _
		!"    vs_out o;\n" & _
		!"    o.pos = p[vid];\n" & _
		!"    o.color = float4(1.0, 0.45, 0.10, 1.0);\n" & _
		!"    return o;\n" & _
		!"}\n"

	dim as string msl_fs = _
		!"#include <metal_stdlib>\n" & _
		!"using namespace metal;\n" & _
		!"struct vs_out {\n" & _
		!"    float4 pos [[position]];\n" & _
		!"    float4 color;\n" & _
		!"};\n" & _
		!"fragment float4 fs_main(vs_out in [[stage_in]]) {\n" & _
		!"    return in.color;\n" & _
		!"}\n"

	dim as string glsl_vs = _
		!"#version 330 core\n" & _
		!"out vec4 vcolor;\n" & _
		!"void main() {\n" & _
		!"    vec2 p[3] = vec2[3]( vec2( 0.0,  0.5),\n" & _
		!"                        vec2( 0.5, -0.5),\n" & _
		!"                        vec2(-0.5, -0.5) );\n" & _
		!"    gl_Position = vec4(p[gl_VertexID], 0.0, 1.0);\n" & _
		!"    vcolor = vec4(1.0, 0.45, 0.10, 1.0);\n" & _
		!"}\n"

	dim as string glsl_fs = _
		!"#version 330 core\n" & _
		!"in vec4 vcolor;\n" & _
		!"out vec4 frag_color;\n" & _
		!"void main() {\n" & _
		!"    frag_color = vcolor;\n" & _
		!"}\n"

	dim shd as sg_shader_desc
	select case g_backend
	case SG_BACKEND_METAL_IOS, SG_BACKEND_METAL_MACOS, SG_BACKEND_METAL_SIMULATOR
		shd.vs.source = strptr( msl_vs )
		shd.fs.source = strptr( msl_fs )
	case SG_BACKEND_GLCORE, SG_BACKEND_GLES3
		shd.vs.source = strptr( glsl_vs )
		shd.fs.source = strptr( glsl_fs )
	case else
		print "sokol: no shader source for backend " & g_backend
		g_failed = true
		sapp_quit()
		exit sub
	end select
	shd.vs.entry = @"vs_main"
	shd.fs.entry = @"fs_main"

	dim shader as sg_shader = sg_make_shader( @shd )
	if sg_query_shader_state( shader ) <> SG_RESOURCESTATE_VALID then
		print "sokol: shader creation failed"
		g_failed = true
		sapp_quit()
		exit sub
	end if

	dim pdesc as sg_pipeline_desc
	pdesc.shader = shader
	pdesc.depth.pixel_format = cast( sg_pixel_format, sapp_depth_format() )
	pdesc.sample_count = sapp_sample_count()
	pdesc.primitive_type = SG_PRIMITIVETYPE_TRIANGLES
	g_pipeline = sg_make_pipeline( @pdesc )
	if sg_query_pipeline_state( g_pipeline ) <> SG_RESOURCESTATE_VALID then
		print "sokol: pipeline creation failed"
		g_failed = true
		sapp_quit()
	end if
end sub

sub on_frame()
	if g_failed then
		sapp_quit()
		exit sub
	end if

	'' sokol_app owns the swapchain pieces per backend; filling them here is
	'' what sokol_glue's sglue_swapchain() does.  Doing it in BASIC keeps the
	'' example free of an extra C header and shows exactly what sokol needs.
	dim pass as sg_pass
	pass.action.colors(0).load_action = SG_LOADACTION_CLEAR
	pass.action.colors(0).clear_value.r = 0.10
	pass.action.colors(0).clear_value.g = 0.12
	pass.action.colors(0).clear_value.b = 0.16
	pass.action.colors(0).clear_value.a = 1.0
	pass.swapchain.width = sapp_width()
	pass.swapchain.height = sapp_height()
	pass.swapchain.sample_count = sapp_sample_count()
	pass.swapchain.color_format = cast( sg_pixel_format, sapp_color_format() )
	pass.swapchain.depth_format = cast( sg_pixel_format, sapp_depth_format() )
	pass.swapchain.metal.current_drawable = sapp_metal_get_current_drawable()
	pass.swapchain.metal.depth_stencil_texture = sapp_metal_get_depth_stencil_texture()
	pass.swapchain.metal.msaa_color_texture = sapp_metal_get_msaa_color_texture()

	sg_begin_pass( @pass )
	sg_apply_pipeline( g_pipeline )
	sg_draw( 0, 3, 1 )
	sg_end_pass()
	sg_commit()

	g_frames += 1
	if g_frames >= QUIT_AFTER_FRAMES then
		print "sokol: " & g_frames & " frames"
		sapp_quit()
	end if
end sub

sub on_cleanup()
	sg_shutdown()
end sub

dim desc as sapp_desc
desc.init_cb = @on_init
desc.frame_cb = @on_frame
desc.cleanup_cb = @on_cleanup
desc.width = 640
desc.height = 480
desc.window_title = @"sokol triangle"
desc.logger.func = @slog_func

sapp_run( @desc )

'' On macOS sapp_run() does not return: sokol_app ends the process from
'' applicationWillTerminate.  Everything worth printing happens in the
'' callbacks above so the program behaves the same on every backend.
'' On Linux and Windows sapp_run() does return, and the process ends here.
end 0
