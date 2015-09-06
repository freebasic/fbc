'' FreeBASIC binding for libXft-2.3.2
''
'' based on the C header files:
''   Copyright © 2000 Keith Packard
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name of Keith Packard not be used in
''   advertising or publicity pertaining to distribution of the software without
''   specific, written prior permission.  Keith Packard makes no
''   representations about the suitability of this software for any purpose.  It
''   is provided "as is" without express or implied warranty.
''
''   KEITH PACKARD DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
''   INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
''   EVENT SHALL KEITH PACKARD BE LIABLE FOR ANY SPECIAL, INDIRECT OR
''   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
''   TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
''   PERFORMANCE OF THIS SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "crt/stdarg.bi"
#include once "freetype2/freetype.bi"
#include once "fontconfig/fontconfig.bi"
#include once "X11/extensions/Xrender.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/Xft/XftCompat.bi"

extern "C"

#define _XFT_H_
const XFT_MAJOR = 2
const XFT_MINOR = 3
const XFT_REVISION = 2
const XFT_VERSION = ((XFT_MAJOR * 10000) + (XFT_MINOR * 100)) + XFT_REVISION
const XftVersion = XFT_VERSION
#define XFT_CORE "core"
#define XFT_RENDER "render"
#define XFT_XLFD "xlfd"
#define XFT_MAX_GLYPH_MEMORY "maxglyphmemory"
#define XFT_MAX_UNREF_FONTS "maxunreffonts"
extern _XftFTlibrary as FT_Library
type XftFontInfo as _XftFontInfo

type _XftFont
	ascent as long
	descent as long
	height as long
	max_advance_width as long
	charset as FcCharSet ptr
	pattern as FcPattern ptr
end type

type XftFont as _XftFont
type XftDraw as _XftDraw

type _XftColor
	pixel as culong
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
declare function XftColorAllocName(byval dpy as Display ptr, byval visual as const Visual ptr, byval cmap as Colormap, byval name as const zstring ptr, byval result as XftColor ptr) as long
declare function XftColorAllocValue(byval dpy as Display ptr, byval visual as Visual ptr, byval cmap as Colormap, byval color as const XRenderColor ptr, byval result as XftColor ptr) as long
declare sub XftColorFree(byval dpy as Display ptr, byval visual as Visual ptr, byval cmap as Colormap, byval color as XftColor ptr)
declare function XftDefaultHasRender(byval dpy as Display ptr) as long
declare function XftDefaultSet(byval dpy as Display ptr, byval defaults as FcPattern ptr) as long
declare sub XftDefaultSubstitute(byval dpy as Display ptr, byval screen as long, byval pattern as FcPattern ptr)
declare function XftDrawCreate(byval dpy as Display ptr, byval drawable as Drawable, byval visual as Visual ptr, byval colormap as Colormap) as XftDraw ptr
declare function XftDrawCreateBitmap(byval dpy as Display ptr, byval bitmap as Pixmap) as XftDraw ptr
declare function XftDrawCreateAlpha(byval dpy as Display ptr, byval pixmap as Pixmap, byval depth as long) as XftDraw ptr
declare sub XftDrawChange(byval draw as XftDraw ptr, byval drawable as Drawable)
declare function XftDrawDisplay(byval draw as XftDraw ptr) as Display ptr
declare function XftDrawDrawable(byval draw as XftDraw ptr) as Drawable
declare function XftDrawColormap(byval draw as XftDraw ptr) as Colormap
declare function XftDrawVisual(byval draw as XftDraw ptr) as Visual ptr
declare sub XftDrawDestroy(byval draw as XftDraw ptr)
declare function XftDrawPicture(byval draw as XftDraw ptr) as Picture
declare function XftDrawSrcPicture(byval draw as XftDraw ptr, byval color as const XftColor ptr) as Picture
declare sub XftDrawGlyphs(byval draw as XftDraw ptr, byval color as const XftColor ptr, byval pub as XftFont ptr, byval x as long, byval y as long, byval glyphs as const FT_UInt ptr, byval nglyphs as long)
declare sub XftDrawString8(byval draw as XftDraw ptr, byval color as const XftColor ptr, byval pub as XftFont ptr, byval x as long, byval y as long, byval string as const FcChar8 ptr, byval len as long)
declare sub XftDrawString16(byval draw as XftDraw ptr, byval color as const XftColor ptr, byval pub as XftFont ptr, byval x as long, byval y as long, byval string as const FcChar16 ptr, byval len as long)
declare sub XftDrawString32(byval draw as XftDraw ptr, byval color as const XftColor ptr, byval pub as XftFont ptr, byval x as long, byval y as long, byval string as const FcChar32 ptr, byval len as long)
declare sub XftDrawStringUtf8(byval draw as XftDraw ptr, byval color as const XftColor ptr, byval pub as XftFont ptr, byval x as long, byval y as long, byval string as const FcChar8 ptr, byval len as long)
declare sub XftDrawStringUtf16(byval draw as XftDraw ptr, byval color as const XftColor ptr, byval pub as XftFont ptr, byval x as long, byval y as long, byval string as const FcChar8 ptr, byval endian as FcEndian, byval len as long)
declare sub XftDrawCharSpec(byval draw as XftDraw ptr, byval color as const XftColor ptr, byval pub as XftFont ptr, byval chars as const XftCharSpec ptr, byval len as long)
declare sub XftDrawCharFontSpec(byval draw as XftDraw ptr, byval color as const XftColor ptr, byval chars as const XftCharFontSpec ptr, byval len as long)
declare sub XftDrawGlyphSpec(byval draw as XftDraw ptr, byval color as const XftColor ptr, byval pub as XftFont ptr, byval glyphs as const XftGlyphSpec ptr, byval len as long)
declare sub XftDrawGlyphFontSpec(byval draw as XftDraw ptr, byval color as const XftColor ptr, byval glyphs as const XftGlyphFontSpec ptr, byval len as long)
declare sub XftDrawRect(byval draw as XftDraw ptr, byval color as const XftColor ptr, byval x as long, byval y as long, byval width as ulong, byval height as ulong)
declare function XftDrawSetClip(byval draw as XftDraw ptr, byval r as Region) as long
declare function XftDrawSetClipRectangles(byval draw as XftDraw ptr, byval xOrigin as long, byval yOrigin as long, byval rects as const XRectangle ptr, byval n as long) as long
declare sub XftDrawSetSubwindowMode(byval draw as XftDraw ptr, byval mode as long)
declare sub XftGlyphExtents(byval dpy as Display ptr, byval pub as XftFont ptr, byval glyphs as const FT_UInt ptr, byval nglyphs as long, byval extents as XGlyphInfo ptr)
declare sub XftTextExtents8(byval dpy as Display ptr, byval pub as XftFont ptr, byval string as const FcChar8 ptr, byval len as long, byval extents as XGlyphInfo ptr)
declare sub XftTextExtents16(byval dpy as Display ptr, byval pub as XftFont ptr, byval string as const FcChar16 ptr, byval len as long, byval extents as XGlyphInfo ptr)
declare sub XftTextExtents32(byval dpy as Display ptr, byval pub as XftFont ptr, byval string as const FcChar32 ptr, byval len as long, byval extents as XGlyphInfo ptr)
declare sub XftTextExtentsUtf8(byval dpy as Display ptr, byval pub as XftFont ptr, byval string as const FcChar8 ptr, byval len as long, byval extents as XGlyphInfo ptr)
declare sub XftTextExtentsUtf16(byval dpy as Display ptr, byval pub as XftFont ptr, byval string as const FcChar8 ptr, byval endian as FcEndian, byval len as long, byval extents as XGlyphInfo ptr)
declare function XftFontMatch(byval dpy as Display ptr, byval screen as long, byval pattern as const FcPattern ptr, byval result as FcResult ptr) as FcPattern ptr
declare function XftFontOpen(byval dpy as Display ptr, byval screen as long, ...) as XftFont ptr
declare function XftFontOpenName(byval dpy as Display ptr, byval screen as long, byval name as const zstring ptr) as XftFont ptr
declare function XftFontOpenXlfd(byval dpy as Display ptr, byval screen as long, byval xlfd as const zstring ptr) as XftFont ptr
declare function XftLockFace(byval pub as XftFont ptr) as FT_Face
declare sub XftUnlockFace(byval pub as XftFont ptr)
declare function XftFontInfoCreate(byval dpy as Display ptr, byval pattern as const FcPattern ptr) as XftFontInfo ptr
declare sub XftFontInfoDestroy(byval dpy as Display ptr, byval fi as XftFontInfo ptr)
declare function XftFontInfoHash(byval fi as const XftFontInfo ptr) as FcChar32
declare function XftFontInfoEqual(byval a as const XftFontInfo ptr, byval b as const XftFontInfo ptr) as FcBool
declare function XftFontOpenInfo(byval dpy as Display ptr, byval pattern as FcPattern ptr, byval fi as XftFontInfo ptr) as XftFont ptr
declare function XftFontOpenPattern(byval dpy as Display ptr, byval pattern as FcPattern ptr) as XftFont ptr
declare function XftFontCopy(byval dpy as Display ptr, byval pub as XftFont ptr) as XftFont ptr
declare sub XftFontClose(byval dpy as Display ptr, byval pub as XftFont ptr)
declare function XftInitFtLibrary() as FcBool
declare sub XftFontLoadGlyphs(byval dpy as Display ptr, byval pub as XftFont ptr, byval need_bitmaps as FcBool, byval glyphs as const FT_UInt ptr, byval nglyph as long)
declare sub XftFontUnloadGlyphs(byval dpy as Display ptr, byval pub as XftFont ptr, byval glyphs as const FT_UInt ptr, byval nglyph as long)
const XFT_NMISSING = 256
declare function XftFontCheckGlyph(byval dpy as Display ptr, byval pub as XftFont ptr, byval need_bitmaps as FcBool, byval glyph as FT_UInt, byval missing as FT_UInt ptr, byval nmissing as long ptr) as FcBool
declare function XftCharExists(byval dpy as Display ptr, byval pub as XftFont ptr, byval ucs4 as FcChar32) as FcBool
declare function XftGlyphExists alias "XftCharExists"(byval dpy as Display ptr, byval pub as XftFont ptr, byval ucs4 as FcChar32) as FcBool
declare function XftCharIndex(byval dpy as Display ptr, byval pub as XftFont ptr, byval ucs4 as FcChar32) as FT_UInt
declare function XftInit(byval config as const zstring ptr) as FcBool
declare function XftGetVersion() as long
declare function XftListFonts(byval dpy as Display ptr, byval screen as long, ...) as FcFontSet ptr
declare function XftNameParse(byval name as const zstring ptr) as FcPattern ptr
declare sub XftGlyphRender(byval dpy as Display ptr, byval op as long, byval src as Picture, byval pub as XftFont ptr, byval dst as Picture, byval srcx as long, byval srcy as long, byval x as long, byval y as long, byval glyphs as const FT_UInt ptr, byval nglyphs as long)
declare sub XftGlyphSpecRender(byval dpy as Display ptr, byval op as long, byval src as Picture, byval pub as XftFont ptr, byval dst as Picture, byval srcx as long, byval srcy as long, byval glyphs as const XftGlyphSpec ptr, byval nglyphs as long)
declare sub XftCharSpecRender(byval dpy as Display ptr, byval op as long, byval src as Picture, byval pub as XftFont ptr, byval dst as Picture, byval srcx as long, byval srcy as long, byval chars as const XftCharSpec ptr, byval len as long)
declare sub XftGlyphFontSpecRender(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval srcx as long, byval srcy as long, byval glyphs as const XftGlyphFontSpec ptr, byval nglyphs as long)
declare sub XftCharFontSpecRender(byval dpy as Display ptr, byval op as long, byval src as Picture, byval dst as Picture, byval srcx as long, byval srcy as long, byval chars as const XftCharFontSpec ptr, byval len as long)
declare sub XftTextRender8(byval dpy as Display ptr, byval op as long, byval src as Picture, byval pub as XftFont ptr, byval dst as Picture, byval srcx as long, byval srcy as long, byval x as long, byval y as long, byval string as const FcChar8 ptr, byval len as long)
declare sub XftTextRender16(byval dpy as Display ptr, byval op as long, byval src as Picture, byval pub as XftFont ptr, byval dst as Picture, byval srcx as long, byval srcy as long, byval x as long, byval y as long, byval string as const FcChar16 ptr, byval len as long)
declare sub XftTextRender16BE(byval dpy as Display ptr, byval op as long, byval src as Picture, byval pub as XftFont ptr, byval dst as Picture, byval srcx as long, byval srcy as long, byval x as long, byval y as long, byval string as const FcChar8 ptr, byval len as long)
declare sub XftTextRender16LE(byval dpy as Display ptr, byval op as long, byval src as Picture, byval pub as XftFont ptr, byval dst as Picture, byval srcx as long, byval srcy as long, byval x as long, byval y as long, byval string as const FcChar8 ptr, byval len as long)
declare sub XftTextRender32(byval dpy as Display ptr, byval op as long, byval src as Picture, byval pub as XftFont ptr, byval dst as Picture, byval srcx as long, byval srcy as long, byval x as long, byval y as long, byval string as const FcChar32 ptr, byval len as long)
declare sub XftTextRender32BE(byval dpy as Display ptr, byval op as long, byval src as Picture, byval pub as XftFont ptr, byval dst as Picture, byval srcx as long, byval srcy as long, byval x as long, byval y as long, byval string as const FcChar8 ptr, byval len as long)
declare sub XftTextRender32LE(byval dpy as Display ptr, byval op as long, byval src as Picture, byval pub as XftFont ptr, byval dst as Picture, byval srcx as long, byval srcy as long, byval x as long, byval y as long, byval string as const FcChar8 ptr, byval len as long)
declare sub XftTextRenderUtf8(byval dpy as Display ptr, byval op as long, byval src as Picture, byval pub as XftFont ptr, byval dst as Picture, byval srcx as long, byval srcy as long, byval x as long, byval y as long, byval string as const FcChar8 ptr, byval len as long)
declare sub XftTextRenderUtf16(byval dpy as Display ptr, byval op as long, byval src as Picture, byval pub as XftFont ptr, byval dst as Picture, byval srcx as long, byval srcy as long, byval x as long, byval y as long, byval string as const FcChar8 ptr, byval endian as FcEndian, byval len as long)
declare function XftXlfdParse(byval xlfd_orig as const zstring ptr, byval ignore_scalable as long, byval complete as long) as FcPattern ptr

end extern
