' SDL_video.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_video_bi_
#define SDL_video_bi_

'$include: 'SDL/SDL_types.bi'
'$include: 'SDL/SDL_mutex.bi'
'$include: 'SDL/SDL_rwops.bi'

'$include: 'SDL/begin_code.bi'

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
    n as Uint8
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

    colorKey as Uint32
    alpha as Uint8
end type

type SDL_Surface
	flags as Uint32
	format as SDL_PixelFormat ptr
	w as integer
	h as integer
	pitch as Uint16
	pixels as any ptr
	offset as integer
   
    #define private_hwdata any
	hwdata as private_hwdata ptr
   
	clip_rect as SDL_Rect
	unused1 as Uint32
    
	locked as Uint32
    
	#define SDL_BlitMap any
	map as SDL_BlitMap ptr
    
	format_version as uinteger
    
	refcount as integer
end type

#define SDL_blit function _
   (src as SDL_Surface ptr, srcrect as SDL_Rect ptr, dst as SDL_Surface ptr, _
   dstrect as SDL_Rect ptr) as integer

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
#define SDL_SRCCOLORKEY	&h00001000
#define SDL_RLEACCELOK &h00002000
#define SDL_RLEACCEL &h00004000
#define SDL_SRCALPHA &h00010000
#define SDL_PREALLOC &h01000000

private function SDL_MUSTLOCK (surface as SDL_Surface ptr)
    SDL_MUSTLOCK = (surface->offset or ((surface->flags and (SDL_HWSURFACE or _
       SDL_ASYNCBLIT or SDL_RLEACCEL)) <> 0))
end function

type SDL_VideoInfo
	hw_available as Uint32
	wm_available as Uint32
	UnusedBits1 as Uint32
	UnusedBits2 as Uint32
	blit_hw as Uint32
	blit_hw_CC as Uint32
	blit_hw_A as Uint32
	blit_sw as Uint32
	blit_sw_CC as Uint32
	blit_sw_A as Uint32
	blit_fill as Uint32
	UnusedBits3 as Uint32
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
    
	#define private_yuvhwfuncs any
    hwfuncs as private_yuvhwfuncs ptr
	#define private_yuvhwdata any
    hwdata as private_yuvhwdata ptr

    hw_overlay as Uint32
    UnusedBits as Uint32
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
end enum

#define SDL_LOGPAL &h01
#define SDL_PHYSPAL &h02

declare function SDL_VideoInit SDLCALL alias "SDL_VideoInit" _
   (byval driver_name as string, byval flags as uint32) as integer
declare sub SDL_VideoQuit SDLCALL alias "SDL_VideoQuit" ()

declare function SDL_VideoDriverName SDLCALL alias "SDL_VideoDriverName" _
   (byval namebuf as byte ptr, byval maxlen as integer) as byte ptr

declare function SDL_GetVideoSurface SDLCALL alias "SDL_GetVideoSurface" _
   () as SDL_Surface ptr

declare function SDL_GetVideoInfo SDLCALL alias "SDL_GetVideoInfo" _
   () as SDL_VideoInfo ptr

declare function SDL_VideoModeOk SDLCALL alias "SDL_VideoModeOk" _
   (byval width as integer, byval height as integer, byval bpp as integer, _
   byval flags as Uint32) as integer

declare function SDL_ListModes SDLCALL alias "SDL_ListModes" _
   (byval format as SDL_PixelFormat ptr, byval flags as Uint32) as SDL_Rect ptr ptr

declare function SDL_SetVideoMode SDLCALL alias "SDL_SetVideoMode" _
   (byval width as integer, byval height as integer, byval bpp as integer, _
   byval flags as Uint32) as SDL_Surface ptr

declare sub SDL_UpdateRects SDLCALL alias "SDL_UpdateRects" _
   (byval screen as SDL_Surface ptr, byval numrects as integer, _
   byval rects as SDL_Rect ptr)
declare sub SDL_UpdateRect SDLCALL alias "SDL_UpdateRect" _
   (byval screen as SDL_Surface ptr, byval x as Sint32, byval y as Sint32, _
   byval w as Uint32, byval h as Uint32)

declare function SDL_Flip SDLCALL alias "SDL_Flip" _
   (byval screen as SDL_Surface ptr) as integer

declare function SDL_SetGamma SDLCALL alias "SDL_SetGamma" _
   (byval red as single, byval green as single, byval blue as single) as integer

declare function SDL_SetGammaRamp SDLCALL alias "SDL_SetGammaRamp" _
   (byval red as Uint16 ptr, byval green as Uint16 ptr, _
   byval blue as Uint16 ptr) as integer

declare function SDL_GetGammaRamp SDLCALL alias "SDL_GetGammaRamp" _
   (byval red as Uint16 ptr, byval green as Uint16 ptr, _
   byval blue as Uint16 ptr) as integer

declare function SDL_SetColors SDLCALL alias "SDL_SetColors" _
   (surface as SDL_Surface ptr, colors as SDL_Color ptr, _
   firstcolor as integer, ncolors as integer) as integer

declare function SDL_SetPalette SDLCALL alias "SDL_SetPalette" _
   (byval surface as SDL_Surface ptr, byval flags as integer, _
   byval colros as SDL_Color ptr, byval firstcolor as integer, _
   byval ncolors as integer) as integer

declare function SDL_MapRGB SDLCALL alias "SDL_MapRGB" _
   (byval format as SDL_PixelFormat ptr, byval r as Uint8, byval g as Uint8, _
   byval b as Uint8) as Uint32

declare function SDL_MapRGBA SDLCALL alias "SDL_MapRGBA" _
   (byval format as SDL_PixelFormat ptr, byval r as Uint8, byval g as Uint8, _
   b as Uint8, byval a as Uint8) as Uint32

declare sub SDL_GetRGB SDLCALL alias "SDL_GetRGB" _
   (byval pixel as Uint32, byval fmt as SDL_PixelFormat ptr, _
   byval r as Uint8 ptr, byval g as Uint8 ptr, byval b as Uint8 ptr)

declare sub SDL_GetRGBA SDLCALL alias "SDL_GetRGBA" _
   (byval pixel as Uint32, byval fmt as SDL_PixelFormat ptr, _
   byval r as Uint8 ptr, byval g as Uint8 ptr, byval b as Uint8 ptr, _
   byval a as Uint8 ptr)

#define SDL_AllocSurface SDL_CreateRGBSurface
declare function SDL_CreateRGBSurface SDLCALL alias "SDL_CreateRGBSurface" _
   (byval flags as Uint32, width as integer, byval height as integer, _
   byval depth as integer, byval Rmask as Uint32, byval Gmask as Uint32, _
   byval Bmask as Uint32, byval Amask as Uint32) as SDL_Surface ptr
declare function SDL_CreateRGBSurfaceFrom SDLCALL _
   alias "SDL_CreateRGBSurfaceFrom" _
   (byval pixels as any ptr, byval width as integer, byval height as integer, _
   byval depth as integer, byval pitch as integer, byval Rmask as Uint32, _
   byval Gmask as uinteger, byval Bmask as Uint32, byval Amask as Uint32) _
   as SDL_Surface ptr
declare sub SDL_FreeSurface SDLCALL alias "SDL_FreeSurface" _
   (byval surface as SDL_Surface ptr)

declare function SDL_LockSurface SDLCALL alias "SDL_LockSurface" _
   (byval surface as SDL_Surface ptr) as integer
declare sub SDL_UnlockSurface SDLCALL alias "SDL_UnlockSurface"_
    (byval surface as SDL_Surface ptr)

declare function SDL_LoadBMP_RW SDLCALL alias "SDL_LoadBMP_RW" _
   (byval src as SDL_RWops ptr, byval freesrc as integer) as SDL_Surface ptr

private function SDL_LoadBMP (byref file as string) as SDL_Surface ptr 
    SDL_LoadBMP = SDL_LoadBMP_RW(SDL_RWFromFile(file, "rb"), 1)
end function

declare function SDL_SaveBMP_RW SDLCALL alias "SDL_SaveBMP_RW" _
   (byval surface as SDL_Surface ptr, byval dst as SDL_RWops ptr, _
   byval freedst as integer) as integer

private function SDL_SaveBMP _
   (byval surface as SDL_Surface ptr, byref file as string) as integer
    SDL_SaveBMP_Rw(surface, SDL_RWFromFile(file, "wb"), 1)
end function

declare function SDL_SetColorKey SDLCALL alias "SDL_SetColorKey" _
   (byval surface as SDL_Surface ptr, byval flag as Uint32, _
   byval key as Uint32) as integer

declare function SDL_SetAlpha SDLCALL alias "SDL_SetAlpha" _
   (byval surface as SDL_Surface ptr, byval flag as Uint32, _
   byval alpha as Uint8) as integer

declare function SDL_SetClipRect SDLCALL alias "SDL_SetClipRect" _
   (byval surface as SDL_Surface ptr, byval rect as SDL_Rect ptr) as SDL_bool

declare sub SDL_GetClipRect SDLCALL alias "SDL_GetClipRect" _
   (byval surface as SDL_Surface ptr, byval rect as SDL_Rect ptr)

declare function SDL_ConvertSurface SDLCALL alias "SDL_ConvertSurface" _
   (byval src as SDL_Surface ptr, byval fmt as SDL_PixelFormat ptr, _
   byval flags as Uint32) as SDL_Surface ptr

#define SDL_BlitSurface SDL_UpperBlit

declare function SDL_UpperBlit SDLCALL alias "SDL_UpperBlit" _
   (byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, _
   byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as integer

declare function SDL_LowerBlit SDLCALL alias "SDL_LowerBlit" _
   (byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, _
   byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as integer

declare function SDL_FillRect SDLCALL alias "SDL_FillRect" _
   (byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr, _
   byval color as Uint32) as integer

declare function SDL_DisplayFormat SDLCALL alias "SDL_DisplayFormat" _
   (byval surface as SDL_Surface ptr) as SDL_Surface ptr

declare function SDL_DisplayFormatAlpha SDLCALL alias "SDL_DisplayFormatAlpha" _
   (byval surface as SDL_Surface ptr) as SDL_Surface ptr

declare function SDL_CreateYUVOverlay SDLCALL alias "SDL_CreateYUVOverlay" _
   (byval width as integer, byval height as integer, byval format as Uint32, _
   byval display as SDL_Surface ptr) as SDL_Overlay ptr

declare function SDL_LockYUVOverlay SDLCALL alias "SDL_LockYUVOverlay" _
   (byval overlay as SDL_Overlay ptr) as integer
declare sub SDL_UnlockYUVOverlay SDLCALL alias "SDL_UnlockYUVOverlay" _
   (byval overlay as SDL_Overlay ptr)

declare function SDL_DisplayYUVOverlay SDLCALL alias "SDL_DisplayYUVOverlay" _
   (byval overlay as SDL_Overlay ptr, byval dstrect as SDL_Rect ptr) as integer

declare sub SDL_FreeYUVOverlay SDLCALL alias "SDL_FreeYUVOverlay" _
   (byval overlay as SDL_Overlay ptr)

declare function SDL_GL_LoadLibrary SDLCALL alias "SDL_GL_LoadLibrary" _
   (byval path as string) as integer

declare function SDL_GL_GetProcAddress SDLCALL alias "SDL_GL_GetProcAdress" _
   (byval proc as string) as any ptr

declare function SDL_GL_SetAttribute SDLCALL alias "SDL_GL_SetAttribute" _
   (byval attr as SDL_GLattr, byval value as integer) as integer

declare function  SDL_GL_GetAttribute SDLCALL alias "SDL_GL_GetAttribute" _
   (byval attr as SDL_GLattr, byval value as integer ptr) as integer

declare sub SDL_GL_SwapBuffers SDLCALL alias "SDL_GL_SwapBuffers" ()
   
declare sub SDL_GL_UpdateRects SDLCALL alias "SDL_GL_UpdateRects" _
   (byval numrects as integer, byval rects as SDL_Rect ptr)
declare sub SDL_GL_Lock SDLCALL alias "SDL_GL_Lock" ()
declare sub SDL_GL_Unlock SDLCALL alias "SDL_GL_Unlock" ()

declare sub SDL_WM_SetCaption SDLCALL alias "SDL_WM_SetCaption" _
   (byval title as string, byval icon as string)
declare sub SDL_WM_GetCaption SDLCALL alias "SDL_WM_GetCaption" _
   (byval title as byte ptr, byval icon as byte ptr)

declare sub SDL_WM_SetIcon SDLCALL alias "SDL_WM_SetIcon" _
   (byval icon as SDL_Surface ptr, byval mask as Uint8 ptr)

declare function SDL_WM_IconifyWindow SDLCALL alias "SDL_WM_IconifyWindow" _
   () as integer

declare function SDL_WM_ToggleFullScreen SDLCALL _
   alias "SDL_WM_ToggleFullScreen" (byval surface as SDL_Surface ptr) as integer

enum SDL_GrabMode
   SDL_GRAB_QUERY = -1
	SDL_GRAB_OFF = 0
	SDL_GRAB_ON = 1
	SDL_GRAB_FULLSCREEN
end enum

declare function SDL_WM_GrabInput SDLCALL alias "SDL_WM_GrabInput" _
   (byval mode as SDL_GrabMode) as SDL_GrabMode

declare function SDL_SoftStretch SDLCALL alias "SDL_SoftStretch" _
   (byval src as SDL_Surface ptr, byval srcrect as SDL_Rect ptr, _
   byval dst as SDL_Surface ptr, byval dstrect as SDL_Rect ptr) as integer

'$include: 'SDL/close_code.bi'

#endif