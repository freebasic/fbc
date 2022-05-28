#include "fbcunit.bi"
#include once "fbgfx.bi"
#include once "fbc-int/system.bi"
#include once "fbc-int/gfx.bi"

'' test some alpha blending C versus MMX
'' we can't test all blenders because some are declared static in gfxlib
'' so we can't call directly

#define MASK_RB_32          &h00FF00FF
#define MASK_G_32           &h0000FF00
#define MASK_GA_32          &hFF00FF00
#define MASK_A_32           &hFF000000
#define MASK_RGB_32         &h00FFFFFF

#macro foreach ? ( varname, args... )
	__fb_uniqueid_push__( __foreach_array )
	#if( __FB_ARG_COUNT__( args ) = 0 )
		dim __fb_uniqueid__( __foreach_array ) (0 to ...) _
		as __FB_ARG_RIGHTOF__( _
		__FB_ARG_LEFTOF__( varname, IN, varname ), AS, integer ) _
		= { __FB_ARG_RIGHTOF__( varname, IN ) }
	#else
		dim __fb_uniqueid__( __foreach_array ) (0 to ...) _
		as __FB_ARG_RIGHTOF__( _
		__FB_ARG_LEFTOF__( varname, IN, varname ), AS, integer ) _
		= { __FB_ARG_RIGHTOF__( varname, IN ), args }
	#endif
	for __foreach_index as integer = _
		lbound( __fb_uniqueid__( __foreach_array ) ) _
		to ubound( __fb_uniqueid__( __foreach_array ) )
		var byref __FB_ARG_LEFTOF__( varname, AS, varname ) = _
		__fb_uniqueid__( __foreach_array )( __foreach_index )
#endmacro

extern "c"
	declare function fb_hPixelSetAlpha4 cdecl alias "fb_hPixelSetAlpha4" _
		( _
			byval dest as any ptr, byval clr as long, byval size as ulong _
		) as any ptr

#if 0
	'' !!!TODO!!!- we can't actually declare this to test because it is static in GFX
	'' we would need to change gfxlib to test all blenders / putters / blitters

	declare sub fb_hPutPixelAlpha4 cdecl alias "fb_hPutPixelAlpha4" _
		( _
			byval ctx as fbgfx.FB_GFXCTX ptr, byval x as ulong, byval y as ulong, byval clr as ulong _
		)
#endif
	#ifdef __FB_X86__
	declare function fb_hPixelSetAlpha4MMX cdecl alias "fb_hPixelSetAlpha4MMX" _
		( _
			byval dest as any ptr, byval clr as long, byval size as ulong _
		) as any ptr

	declare sub fb_hPutPixelAlpha4MMX cdecl alias "fb_hPutPixelAlpha4MMX" _
		( _
			byval ctx as fbgfxlib.FB_GFXCTX ptr, byval x as ulong, byval y as ulong, byval clr as ulong _
		)
	#endif
end extern

SUITE( fbc_tests.gfx.blender_alpha4 )

	'' translation of fb_hPixelSetAlpha4
	sub AlphaC _
		( _
			byval dst as ulong ptr, _
			byval clr as ulong, _
			byval length as ulong _
		)

		dim as ulong dc, srb, sg, drb, dg, a
		for i as integer = 0 to length-1
			dc = dst[i]
			a = clr shr 24
			srb = clr and MASK_RB_32
			sg  = clr and MASK_G_32
			drb = dc  and MASK_RB_32
			dg  = dc  and MASK_G_32
			srb = ((srb - drb) * a ) shr 8
			sg  = ((sg - dg) * a ) shr 8
			dc  = ((drb + srb) and MASK_RB_32)
			dc or= ((dg + sg) and MASK_G_32)
			dc or= (clr and MASK_A_32)
			dst[i] = dc
		next
	end sub

	TEST( setAlpha )

		dim dc1(0 to 9) as ulong
		dim dc2(0 to 9) as ulong

		#define VALUE_LIST 0, 1, 128, 255

		foreach  a as ubyte in VALUE_LIST
		foreach sr as ubyte in VALUE_LIST
		foreach sg as ubyte in VALUE_LIST
		foreach sb as ubyte in VALUE_LIST
		foreach dr as ubyte in VALUE_LIST
		foreach dg as ubyte in VALUE_LIST
		foreach db as ubyte in VALUE_LIST
			dim as ulong sc = rgba(sr,sg,sb,a)
			dim as ulong dc = rgba(dr,dg,db,0)

			for length as integer = 1 to 7
				for i as integer = 0 to length-1
					dc1(i) = dc
				next
				AlphaC( @dc1(0), sc, length )

				for i as integer = 0 to length-1
					dc2(i) = dc
				next
				fb_hPixelSetAlpha4( @dc2(0), sc, length )
				for i as integer = 0 to length-1
					CU_ASSERT_EQUAL( dc1(i), dc2(i) )
				next

#ifdef __FB_X86__
#ifndef __FB_64BIT__
				if( fb_CpuDetect() and &h800000 ) then
					for i as integer = 0 to length-1
						dc2(i) = dc
					next
					fb_hPixelSetAlpha4MMX( @dc2(0), sc, length )
					for i as integer = 0 to length-1
						CU_ASSERT_EQUAL( dc1(i), dc2(i) )
					next
				endif
#endif
#endif
			next
		next
		next
		next
		next
		next
		next
		next

	END_TEST

	sub CreateFakeGfxContext _
		( _
			byval ctx as fbgfxlib.FB_GFXCTX ptr, _
			byval buffer as any ptr, _
			byval w as long, byval h as long, byval bpp as long _
		)

		ctx->id = 0
		ctx->work_page = 0
		ctx->line = callocate( h * sizeof( ubyte ptr ) )
		for index as integer = 0 to h-1
			ctx->line[index] = cptr( ubyte ptr, buffer + w * index * bpp )
		next
		ctx->max_h = h
		ctx->target_bpp = 4        '' 4 bytes per pixel
		ctx->last_target = 0       '' NULL
		ctx->last_x = 0
		ctx->last_y = 0
		ctx->view_x = 0            '' viewport
		ctx->view_y = 0            '' viewport
		ctx->view_w = w            '' viewport
		ctx->view_h = h            '' viewport
		ctx->old_view_x = 0        '' viewport
		ctx->old_view_y = 0        '' viewport
		ctx->old_view_w = w        '' viewport
		ctx->old_view_h = h        '' viewport
		ctx->win_x = 0             '' scaling (not enable since flags are zero)
		ctx->win_x = 0.0           '' scaling (not enable since flags are zero)
		ctx->win_y = 0.0           '' scaling (not enable since flags are zero)
		ctx->win_w = 0.0           '' scaling (not enable since flags are zero)
		ctx->win_h = 0.0           '' scaling (not enable since flags are zero)
		ctx->fg_color = 0          '' forecolor - not used
		ctx->bg_color = 0          '' backcolor - not used
		ctx->put_pixel = 0         '' not used - we are calling directly
		ctx->get_pixel = 0         '' not used
		ctx->pixel_set = 0         '' not used - we are calling directly
		'' ctx->putter()[0 to 3]   '' not used - we are calling directly
		ctx->flags = 0             '' not used - we are calling directly

	end sub

	sub DestroyFakeGfxContext( byval ctx as fbgfxlib.FB_GFXCTX ptr, byval buffer as ubyte ptr )
		deallocate( ctx->line )
		if( buffer ) then
			deallocate( buffer )
		end if
	end sub

	TEST( putAlpha )

		'' build a fake context, just enough to call in to the blender functions
		dim as fbgfxlib.FB_GFXCTX ctx_data
		dim as fbgfxlib.FB_GFXCTX ptr ctx = @ctx_data

		dim as ulong dc1
		dim as ulong dc2
		CreateFakeGfxContext( ctx, @dc2, 1, 1, 4 ) '' 1 x 1 x 4-bpp

		#define VALUE_LIST 0, 1, 128, 255

		foreach  a as ubyte in VALUE_LIST
		foreach sr as ubyte in VALUE_LIST
		foreach sg as ubyte in VALUE_LIST
		foreach sb as ubyte in VALUE_LIST
		foreach dr as ubyte in VALUE_LIST
		foreach dg as ubyte in VALUE_LIST
		foreach db as ubyte in VALUE_LIST
			dim as ulong sc = rgba(sr,sg,sb,a)
			dc1 = rgba(dr,dg,db,0)
			AlphaC( @dc1, sc, 1 )

#if 0
	'' !!!TODO!!!- we can't actually declare this to test because it is static in GFX
			dc2 = rgba(dr,dg,db,0)
			fb_hPutPixelAlpha4( ctx, 0, 0, sc )
			CU_ASSERT_EQUAL( dc1, dc2 )
#endif

#ifdef __FB_X86__
#ifndef __FB_64BIT__
			dc2 = rgba(dr,dg,db,0)
			if( fb_CpuDetect() and &h800000 ) then
				fb_hPutPixelAlpha4MMX( ctx, 0, 0, sc )
				CU_ASSERT_EQUAL( dc1, dc2 )
			end if
#endif
#endif
		next
		next
		next
		next
		next
		next
		next

		DestroyFakeGfxContext( ctx, 0 )
	END_TEST

END_SUITE
