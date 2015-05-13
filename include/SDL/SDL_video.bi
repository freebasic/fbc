''
''
'' SDL_video -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_video_bi__
#define __SDL_video_bi__

#include once "crt/stdio.bi"
#include once "SDL_types.bi"
#include once "SDL_mutex.bi"
#include once "SDL_rwops.bi"
#include once "begin_code.bi"

#define SDL_ALPHA_OPAQUE 255
#define SDL_ALPHA_TRANSPARENT 0

type SDL_Rect
	x as Sint16
	y as Sint16
	w as Uint16
	h as Uint16
end type

type SDL_Color
	r as Uint8
	g as Uint8
	b as Uint8
	unused as Uint8
end type

type SDL_Palette
	ncolors as integer
	colors as SDL_Color ptr
end type

type SDL_PixelFormat
	palette as SDL_Palette ptr
	BitsPerPixel as Uint8
	BytesPerPixel as Uint8
	Rloss as Uint8
	Gloss as Uint8
	Bloss as Uint8
	Aloss as Uint8
	Rshift as Uint8
	Gshift as Uint8
	Bshift as Uint8
	Ashift as Uint8
	Rmask as Uint32
	Gmask as Uint32
	Bmask as Uint32
	Amask as Uint32
	colorkey as Uint32
	alpha as Uint8
end type

type SDL_BlitMap as _SDL_BlitMap

type SDL_Surface
	flags as Uint32
	format as SDL_PixelFormat ptr
	w as integer
	h as integer
	pitch as Uint16
	pixels as any ptr
	offset as integer
	hwdata as any ptr
	clip_rect as SDL_Rect
	unused1 as Uint32
	locked as Uint32
	map as SDL_BlitMap ptr
	format_version as uinteger
	refcount as integer
end type

#define SDL_SWSURFACE &h00000000
#define SDL_HWSURFACE &h00000001
#define SDL_ASYNCBLIT &h00000004
#define SDL_ANYFORMAT &h10000000
#define SDL_HWPALETTE &h20000000
#define SDL_DOUBLEBUF &h40000000
#define SDL_FULLSCREEN &h80000000
#define SDL_OPENGL &h00000002
#define SDL_OPENGLBLIT &h0000000A
#define SDL_RESIZABLE &h00000010
#define SDL_NOFRAME &h00000020
#define SDL_HWACCEL &h00000100
#define SDL_SRCCOLORKEY &h00001000
#define SDL_RLEACCELOK &h00002000
#define SDL_RLEACCEL &h00004000
#define SDL_SRCALPHA &h00010000
#define SDL_PREALLOC &h01000000

#define SDL_MUSTLOCK(surface) (surface->offset or ((surface->flags and (SDL_HWSURFACE or SDL_ASYNCBLIT or SDL_RLEACCEL)) <> 0))

type SDL_blit as function cdecl(byval as SDL_Surface ptr, byval as SDL_Rect ptr, byval as SDL_Surface ptr, byval as SDL_Rect ptr) as integer

type SDL_VideoInfo
	hw_available:1 as Uint32
	wm_available:1 as Uint32
	UnusedBits1:6 as Uint32
	UnusedBits2:1 as Uint32
	blit_hw:1 as Uint32
	blit_hw_CC:1 as Uint32
	blit_hw_A:1 as Uint32
	blit_sw:1 as Uint32
	blit_sw_CC:1 as Uint32
	blit_sw_A:1 as Uint32
	blit_fill:1 as Uint32
	UnusedBits3:16 as Uint32
	video_mem as Uint32
	vfmt as SDL_PixelFormat ptr
end type

#define SDL_YV12_OVERLAY &h32315659
#define SDL_IYUV_OVERLAY &h56555949
#define SDL_YUY2_OVERLAY &h32595559
#define SDL_UYVY_OVERLAY &h59565955
#define SDL_YVYU_OVERLAY &h55595659

type SDL_Overlay
	format as Uint32
	w as integer
	h as integer
	planes as integer
	pitches as Uint16 ptr
	pixels as Uint8 ptr ptr
	hwfuncs as any ptr
	hwdata as any ptr
	hw_overlay:1 as Uint32
	UnusedBits:31 as Uint32
end type

enum SDL_GLattr
	SDL_GL_RED_SIZE
	SDL_GL_GREEN_SIZE
	SDL_GL_BLUE_SIZE
	SDL_GL_ALPHA_SIZE
	SDL_GL_BUFFER_SIZE
	SDL_GL_DOUBLEBUFFER
	SDL_GL_DEPTH_SIZE
	SDL_GL_STENCIL_SIZE
	SDL_GL_ACCUM_RED_SIZE
	SDL_GL_ACCUM_GREEN_SIZE
	SDL_GL_ACCUM_BLUE_SIZE
	SDL_GL_ACCUM_ALPHA_SIZE
	SDL_GL_STEREO
	SDL_GL_MULTISAMPLEBUFFERS
	SDL_GL_MULTISAMPLESAMPLES
end enum


#define SDL_LOGPAL &h01
#define SDL_PHYSPAL &h02

#define SDL_AllocSurface SDL_CreateRGBSurface
#define SDL_LoadBMP(file) SDL_LoadBMP_RW(SDL_RWFromFile(file, "rb"), 1)
#define SDL_SaveBMP(surface,file) SDL_SaveBMP_Rw(surface, SDL_RWFromFile(file, "wb"), 1)
#define SDL_BlitSurface SDL_UpperBlit

enum SDL_GrabMode
	SDL_GRAB_QUERY = -1
	SDL_GRAB_OFF = 0
	SDL_GRAB_ON = 1
	SDL_GRAB_FULLSCREEN
end enum

extern "c"
declare function SDL_VideoInit (byval driver_name as zstring ptr, byval flags as Uint32) as integer
declare sub SDL_VideoQuit ()
declare function SDL_VideoDriverName (byval namebuf as zstring ptr, byval maxlen as integer) as zstring ptr
declare function SDL_GetVideoSurface () as SDL_Surface ptr
declare function SDL_GetVideoInfo () as SDL_VideoInfo ptr
declare function SDL_VideoModeOK (byval width as integer, byval height as integer, byval bpp as integer, byval flags as Uint32) as integer
declare function SDL_ListModes (byval format as SDL_PixelFormat ptr, byval flags as Uint32) as SDL_Rect ptr ptr
declare function SDL_SetVideoMode (byval width as integer, byval height as integer, byval bpp as integer, byval flags as Uint32) as SDL_Surface ptr
declare sub SDL_UpdateRects (byval screen as SDL_Surface ptr, byval numrects as integer, byval rects as SDL_Rect ptr)
declare sub SDL_UpdateRect (byval screen as SDL_Surface ptr, byval x as Sint32, byval y as Sint32, byval w as Uint32, byval h as Uint32)
declare function SDL_Flip (byval screen as SDL_Surface ptr) as integer
declare function SDL_SetGamma (byval red as single, byval green as single, byval blue as single) as integer
declare function SDL_SetGammaRamp (byval red as Uint16 ptr, byval green as Uint16 ptr, byval blue as Uint16 ptr) as integer
declare function SDL_GetGammaRamp (byval red as Uint16 ptr, byval green as Uint16 ptr, byval blue as Uint16 ptr) as integer
declare function SDL_SetColors (byval surface as SDL_Surface ptr, byval colors as SDL_Color ptr, byval firstcolor as integer, byval ncolors as integer) as integer
declare function SDL_SetPalette (byval surface as SDL_Surface ptr, byval flags as integer, byval colors as SDL_Color ptr, byval firstcolor as integer, byval ncolors as integer) as integer
declare function SDL_MapRGB (byval format as SDL_PixelFormat ptr, byval r as Uint8, byval g as Uint8, byval b as Uint8) as Uint32
declare function SDL_MapRGBA (byval format as SDL_PixelFormat ptr, byval r as Uint8, byval g as Uint8, byval b as Uint8, byval a as Uint8) as Uint32
declare sub SDL_GetRGB (byval pixel as Uint32, byval fmt as SDL_PixelFormat ptr, byval r as Uint8 ptr, byval g as Uint8 ptr, byval b as Uint8 ptr)
declare sub SDL_GetRGBA (byval pixel as Uint32, byval fmt as SDL_PixelFormat ptr, byval r as Uint8 ptr, byval g as Uint8 ptr, byval b as Uint8 ptr, byval a as Uint8 ptr)
declare function SDL_CreateRGBSurface (byval flags as Uint32, byval width as integer, byval height as integer, byval depth as integer, byval Rmask as Uint32, byval Gmask as Uint32, byval Bmask as Uint32, byval Amask as Uint32) as SDL_Surface ptr
declare function SDL_CreateRGBSurfaceFrom (byval pixels as any ptr, byval width as integer, byval height as integer, byval depth as integer, byval pitch as integer, byval Rmask as Uint32, byval Gmask as Uint32, byval Bmask as Uint32, byval Amask as Uint32) as SDL_Surface ptr
declare sub SDL_FreeSurface (byval surface as SDL_Surface ptr)
declare function SDL_LockSurface (byval surface as SDL_Surface ptr) as integer
declare sub SDL_UnlockSurface (byval surface as SDL_Surface ptr)
declare function SDL_LoadBMP_RW (byval src as SDL_RWops ptr, byval freesrc as integer) as SDL_Surface ptr
declare function SDL_SaveBMP_RW (byval surface as SDL_Surface ptr, byval dst as SDL_RWops ptr, byval freedst as integer) as integer
declare function SDL_SetColorKey (byval surface as SDL_Surface ptr, byval flag as Uint32, byval key as Uint32) as integer
declare function SDL_SetAlpha (byval surface as SDL_Surface ptr, byval flag as Uint32, byval alpha as Uint8) as integer
declare function SDL_SetClipRect (byval surface as SDL_Surface ptr, byval rect as SDL_Rect ptr) as SDL_bool
declare sub SDL_GetClipRect (byval surface as SDL_Surface ptr, byval rect as SDL_Rect ptr)
declare function SDL_ConvertSurface (byval src as SDL_Surface ptr, byval fmt as SDL_PixelFormat ptr, byval flags as Uint32) as SDL_Surface ptr
declare function SDL_UpperBlit (byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as integer
declare function SDL_LowerBlit (byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as integer
declare function SDL_FillRect (byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr, byval color as Uint32) as integer
declare function SDL_DisplayFormat (byval surface as SDL_Surface ptr) as SDL_Surface ptr
declare function SDL_DisplayFormatAlpha (byval surface as SDL_Surface ptr) as SDL_Surface ptr
declare function SDL_CreateYUVOverlay (byval width as integer, byval height as integer, byval format as Uint32, byval display as SDL_Surface ptr) as SDL_Overlay ptr
declare function SDL_LockYUVOverlay (byval overlay as SDL_Overlay ptr) as integer
declare sub SDL_UnlockYUVOverlay (byval overlay as SDL_Overlay ptr)
declare function SDL_DisplayYUVOverlay (byval overlay as SDL_Overlay ptr, byval dstrect as SDL_Rect ptr) as integer
declare sub SDL_FreeYUVOverlay (byval overlay as SDL_Overlay ptr)
declare function SDL_GL_LoadLibrary (byval path as zstring ptr) as integer
declare function SDL_GL_GetProcAddress (byval proc as zstring ptr) as any ptr
declare function SDL_GL_SetAttribute (byval attr as SDL_GLattr, byval value as integer) as integer
declare function SDL_GL_GetAttribute (byval attr as SDL_GLattr, byval value as integer ptr) as integer
declare sub SDL_GL_SwapBuffers ()
declare sub SDL_GL_UpdateRects (byval numrects as integer, byval rects as SDL_Rect ptr)
declare sub SDL_GL_Lock ()
declare sub SDL_GL_Unlock ()
declare sub SDL_WM_SetCaption (byval title as zstring ptr, byval icon as zstring ptr)
declare sub SDL_WM_GetCaption (byval title as byte ptr ptr, byval icon as byte ptr ptr)
declare sub SDL_WM_SetIcon (byval icon as SDL_Surface ptr, byval mask as Uint8 ptr)
declare function SDL_WM_IconifyWindow () as integer
declare function SDL_WM_ToggleFullScreen (byval surface as SDL_Surface ptr) as integer
declare function SDL_WM_GrabInput (byval mode as SDL_GrabMode) as SDL_GrabMode
declare function SDL_SoftStretch (byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as integer
end extern

#include once "close_code.bi"

#endif
