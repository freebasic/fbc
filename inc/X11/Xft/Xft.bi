''
''
'' Xft -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xft_bi__
#define __Xft_bi__

#define XFT_MAJOR 2
#define XFT_MINOR 1
#define XFT_REVISION 13
#define XFT_VERSION ((2*10000) +(1*100) +(13))
#define XftVersion ((2*10000) +(1*100) +(13))
#define XFT_CORE "core"
#define XFT_RENDER "render"
#define XFT_XLFD "xlfd"
#define XFT_MAX_GLYPH_MEMORY "maxglyphmemory"
#define XFT_MAX_UNREF_FONTS "maxunreffonts"
extern _XftFTlibrary alias "_XftFTlibrary" as FT_Library

type XftFontInfo as _XftFontInfo

type _XftFont
	ascent as integer
	descent as integer
	height as integer
	max_advance_width as integer
	charset as FcCharSet ptr
	pattern as FcPattern ptr
end type

type XftFont as _XftFont
type XftDraw as _XftDraw

type _XftColor
	pixel as uinteger
	color as XRenderColor
end type

type XftColor as _XftColor

type _XftCharSpec
	ucs4 as FcChar32
	x as short
	y as short
end type

type XftCharSpec as _XftCharSpec

type _XftCharFontSpec
	font as XftFont ptr
	ucs4 as FcChar32
	x as short
	y as short
end type

type XftCharFontSpec as _XftCharFontSpec

type _XftGlyphSpec
	glyph as FT_UInt
	x as short
	y as short
end type

type XftGlyphSpec as _XftGlyphSpec

type _XftGlyphFontSpec
	font as XftFont ptr
	glyph as FT_UInt
	x as short
	y as short
end type

type XftGlyphFontSpec as _XftGlyphFontSpec

declare sub XftColorFree cdecl alias "XftColorFree" (byval dpy as Display ptr, byval visual as Visual ptr, byval cmap as Colormap, byval color as XftColor ptr)
declare function XftDefaultHasRender cdecl alias "XftDefaultHasRender" (byval dpy as Display ptr) as Bool
declare function XftDefaultSet cdecl alias "XftDefaultSet" (byval dpy as Display ptr, byval defaults as FcPattern ptr) as Bool
declare sub XftDefaultSubstitute cdecl alias "XftDefaultSubstitute" (byval dpy as Display ptr, byval screen as integer, byval pattern as FcPattern ptr)
declare function XftDrawCreate cdecl alias "XftDrawCreate" (byval dpy as Display ptr, byval drawable as Drawable, byval visual as Visual ptr, byval colormap as Colormap) as XftDraw ptr
declare function XftDrawCreateBitmap cdecl alias "XftDrawCreateBitmap" (byval dpy as Display ptr, byval bitmap as Pixmap) as XftDraw ptr
declare function XftDrawCreateAlpha cdecl alias "XftDrawCreateAlpha" (byval dpy as Display ptr, byval pixmap as Pixmap, byval depth as integer) as XftDraw ptr
declare sub XftDrawChange cdecl alias "XftDrawChange" (byval draw as XftDraw ptr, byval drawable as Drawable)
declare function XftDrawDisplay cdecl alias "XftDrawDisplay" (byval draw as XftDraw ptr) as Display ptr
declare function XftDrawDrawable cdecl alias "XftDrawDrawable" (byval draw as XftDraw ptr) as Drawable
declare function XftDrawColormap cdecl alias "XftDrawColormap" (byval draw as XftDraw ptr) as Colormap
declare function XftDrawVisual cdecl alias "XftDrawVisual" (byval draw as XftDraw ptr) as Visual ptr
declare sub XftDrawDestroy cdecl alias "XftDrawDestroy" (byval draw as XftDraw ptr)
declare function XftDrawPicture cdecl alias "XftDrawPicture" (byval draw as XftDraw ptr) as Picture
declare function XftDrawSetClip cdecl alias "XftDrawSetClip" (byval draw as XftDraw ptr, byval r as Region) as Bool
declare sub XftDrawSetSubwindowMode cdecl alias "XftDrawSetSubwindowMode" (byval draw as XftDraw ptr, byval mode as integer)
declare function XftFontOpen cdecl alias "XftFontOpen" (byval dpy as Display ptr, byval screen as integer, ...) as XftFont ptr
declare function XftLockFace cdecl alias "XftLockFace" (byval pub as XftFont ptr) as FT_Face
declare sub XftUnlockFace cdecl alias "XftUnlockFace" (byval pub as XftFont ptr)
declare sub XftFontInfoDestroy cdecl alias "XftFontInfoDestroy" (byval dpy as Display ptr, byval fi as XftFontInfo ptr)
declare function XftFontOpenInfo cdecl alias "XftFontOpenInfo" (byval dpy as Display ptr, byval pattern as FcPattern ptr, byval fi as XftFontInfo ptr) as XftFont ptr
declare function XftFontOpenPattern cdecl alias "XftFontOpenPattern" (byval dpy as Display ptr, byval pattern as FcPattern ptr) as XftFont ptr
declare function XftFontCopy cdecl alias "XftFontCopy" (byval dpy as Display ptr, byval pub as XftFont ptr) as XftFont ptr
declare sub XftFontClose cdecl alias "XftFontClose" (byval dpy as Display ptr, byval pub as XftFont ptr)
declare function XftInitFtLibrary cdecl alias "XftInitFtLibrary" () as FcBool

#define XFT_NMISSING 256

declare function XftFontCheckGlyph cdecl alias "XftFontCheckGlyph" (byval dpy as Display ptr, byval pub as XftFont ptr, byval need_bitmaps as FcBool, byval glyph as FT_UInt, byval missing as FT_UInt ptr, byval nmissing as integer ptr) as FcBool
declare function XftCharExists cdecl alias "XftCharExists" (byval dpy as Display ptr, byval pub as XftFont ptr, byval ucs4 as FcChar32) as FcBool
declare function XftCharIndex cdecl alias "XftCharIndex" (byval dpy as Display ptr, byval pub as XftFont ptr, byval ucs4 as FcChar32) as FT_UInt
declare function XftGetVersion cdecl alias "XftGetVersion" () as integer
declare function XftListFonts cdecl alias "XftListFonts" (byval dpy as Display ptr, byval screen as integer, ...) as FcFontSet ptr

#endif
