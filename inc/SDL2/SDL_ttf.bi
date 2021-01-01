'' FreeBASIC binding for SDL2_ttf-2.0.15
''
'' based on the C header files:
''   SDL_ttf:  A companion library to SDL for working with TrueType (tm) fonts
''   Copyright (C) 2001-2019 Sam Lantinga <slouken@libsdl.org>
''
''   This software is provided 'as-is', without any express or implied
''   warranty.  In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''   1. The origin of this software must not be misrepresented; you must not
''      claim that you wrote the original software. If you use this software
''      in a product, an acknowledgment in the product documentation would be
''      appreciated but is not required.
''   2. Altered source versions must be plainly marked as such, and must not be
''      misrepresented as being the original software.
''   3. This notice may not be removed or altered from any source distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2020 FreeBASIC development team

#pragma once

#inclib "SDL2_ttf"

#include once "crt/long.bi"
#include once "SDL.bi"

extern "C"

#define SDL_TTF_H_
const SDL_TTF_MAJOR_VERSION = 2
const SDL_TTF_MINOR_VERSION = 0
const SDL_TTF_PATCHLEVEL = 15
#macro SDL_TTF_VERSION(X)
	scope
		(X)->major = SDL_TTF_MAJOR_VERSION
		(X)->minor = SDL_TTF_MINOR_VERSION
		(X)->patch = SDL_TTF_PATCHLEVEL
	end scope
#endmacro
const TTF_MAJOR_VERSION = SDL_TTF_MAJOR_VERSION
const TTF_MINOR_VERSION = SDL_TTF_MINOR_VERSION
const TTF_PATCHLEVEL = SDL_TTF_PATCHLEVEL
#define TTF_VERSION(X) SDL_TTF_VERSION(X)
#define SDL_TTF_COMPILEDVERSION SDL_VERSIONNUM(SDL_TTF_MAJOR_VERSION, SDL_TTF_MINOR_VERSION, SDL_TTF_PATCHLEVEL)
#define SDL_TTF_VERSION_ATLEAST(X, Y, Z) (SDL_TTF_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z))
declare function TTF_Linked_Version() as const SDL_version ptr
const UNICODE_BOM_NATIVE = &hFEFF
const UNICODE_BOM_SWAPPED = &hFFFE
declare sub TTF_ByteSwappedUNICODE(byval swapped as long)
type TTF_Font as _TTF_Font

declare function TTF_Init() as long
declare function TTF_OpenFont(byval file as const zstring ptr, byval ptsize as long) as TTF_Font ptr
declare function TTF_OpenFontIndex(byval file as const zstring ptr, byval ptsize as long, byval index as clong) as TTF_Font ptr
declare function TTF_OpenFontRW(byval src as SDL_RWops ptr, byval freesrc as long, byval ptsize as long) as TTF_Font ptr
declare function TTF_OpenFontIndexRW(byval src as SDL_RWops ptr, byval freesrc as long, byval ptsize as long, byval index as clong) as TTF_Font ptr

const TTF_STYLE_NORMAL = &h00
const TTF_STYLE_BOLD = &h01
const TTF_STYLE_ITALIC = &h02
const TTF_STYLE_UNDERLINE = &h04
const TTF_STYLE_STRIKETHROUGH = &h08

declare function TTF_GetFontStyle(byval font as const TTF_Font ptr) as long
declare sub TTF_SetFontStyle(byval font as TTF_Font ptr, byval style as long)
declare function TTF_GetFontOutline(byval font as const TTF_Font ptr) as long
declare sub TTF_SetFontOutline(byval font as TTF_Font ptr, byval outline as long)

const TTF_HINTING_NORMAL = 0
const TTF_HINTING_LIGHT = 1
const TTF_HINTING_MONO = 2
const TTF_HINTING_NONE = 3

declare function TTF_GetFontHinting(byval font as const TTF_Font ptr) as long
declare sub TTF_SetFontHinting(byval font as TTF_Font ptr, byval hinting as long)
declare function TTF_FontHeight(byval font as const TTF_Font ptr) as long
declare function TTF_FontAscent(byval font as const TTF_Font ptr) as long
declare function TTF_FontDescent(byval font as const TTF_Font ptr) as long
declare function TTF_FontLineSkip(byval font as const TTF_Font ptr) as long
declare function TTF_GetFontKerning(byval font as const TTF_Font ptr) as long
declare sub TTF_SetFontKerning(byval font as TTF_Font ptr, byval allowed as long)
declare function TTF_FontFaces(byval font as const TTF_Font ptr) as clong
declare function TTF_FontFaceIsFixedWidth(byval font as const TTF_Font ptr) as long
declare function TTF_FontFaceFamilyName(byval font as const TTF_Font ptr) as zstring ptr
declare function TTF_FontFaceStyleName(byval font as const TTF_Font ptr) as zstring ptr
declare function TTF_GlyphIsProvided(byval font as const TTF_Font ptr, byval ch as Uint16) as long
declare function TTF_GlyphMetrics(byval font as TTF_Font ptr, byval ch as Uint16, byval minx as long ptr, byval maxx as long ptr, byval miny as long ptr, byval maxy as long ptr, byval advance as long ptr) as long
declare function TTF_SizeText(byval font as TTF_Font ptr, byval text as const zstring ptr, byval w as long ptr, byval h as long ptr) as long
declare function TTF_SizeUTF8(byval font as TTF_Font ptr, byval text as const zstring ptr, byval w as long ptr, byval h as long ptr) as long
declare function TTF_SizeUNICODE(byval font as TTF_Font ptr, byval text as const Uint16 ptr, byval w as long ptr, byval h as long ptr) as long
declare function TTF_RenderText_Solid(byval font as TTF_Font ptr, byval text as const zstring ptr, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderUTF8_Solid(byval font as TTF_Font ptr, byval text as const zstring ptr, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderUNICODE_Solid(byval font as TTF_Font ptr, byval text as const Uint16 ptr, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderGlyph_Solid(byval font as TTF_Font ptr, byval ch as Uint16, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderText_Shaded(byval font as TTF_Font ptr, byval text as const zstring ptr, byval fg as SDL_Color, byval bg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderUTF8_Shaded(byval font as TTF_Font ptr, byval text as const zstring ptr, byval fg as SDL_Color, byval bg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderUNICODE_Shaded(byval font as TTF_Font ptr, byval text as const Uint16 ptr, byval fg as SDL_Color, byval bg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderGlyph_Shaded(byval font as TTF_Font ptr, byval ch as Uint16, byval fg as SDL_Color, byval bg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderText_Blended(byval font as TTF_Font ptr, byval text as const zstring ptr, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderUTF8_Blended(byval font as TTF_Font ptr, byval text as const zstring ptr, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderUNICODE_Blended(byval font as TTF_Font ptr, byval text as const Uint16 ptr, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderText_Blended_Wrapped(byval font as TTF_Font ptr, byval text as const zstring ptr, byval fg as SDL_Color, byval wrapLength as Uint32) as SDL_Surface ptr
declare function TTF_RenderUTF8_Blended_Wrapped(byval font as TTF_Font ptr, byval text as const zstring ptr, byval fg as SDL_Color, byval wrapLength as Uint32) as SDL_Surface ptr
declare function TTF_RenderUNICODE_Blended_Wrapped(byval font as TTF_Font ptr, byval text as const Uint16 ptr, byval fg as SDL_Color, byval wrapLength as Uint32) as SDL_Surface ptr
declare function TTF_RenderGlyph_Blended(byval font as TTF_Font ptr, byval ch as Uint16, byval fg as SDL_Color) as SDL_Surface ptr

#define TTF_RenderText(font, text, fg, bg) TTF_RenderText_Shaded(font, text, fg, bg)
#define TTF_RenderUTF8(font, text, fg, bg) TTF_RenderUTF8_Shaded(font, text, fg, bg)
#define TTF_RenderUNICODE(font, text, fg, bg) TTF_RenderUNICODE_Shaded(font, text, fg, bg)

declare sub TTF_CloseFont(byval font as TTF_Font ptr)
declare sub TTF_Quit()
declare function TTF_WasInit() as long
declare function TTF_GetFontKerningSize(byval font as TTF_Font ptr, byval prev_index as long, byval index as long) as long
declare function TTF_GetFontKerningSizeGlyphs(byval font as TTF_Font ptr, byval previous_ch as Uint16, byval ch as Uint16) as long
declare function TTF_SetError alias "SDL_SetError"(byval fmt as const zstring ptr, ...) as long
declare function TTF_GetError alias "SDL_GetError"() as const zstring ptr

end extern
