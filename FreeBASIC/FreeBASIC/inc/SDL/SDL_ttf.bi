''
''
'' SDL_ttf -- TrueType fonts rendering library
''			  (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_ttf_bi__
#define __SDL_ttf_bi__

#inclib "SDL_ttf"

#include once "SDL.bi"
#include once "begin_code.bi"

#define SDL_TTF_MAJOR_VERSION 2
#define SDL_TTF_MINOR_VERSION 0
#define SDL_TTF_PATCHLEVEL 7

#define SDL_TTF_VERSION(X)						_
	(X)->major = SDL_TTF_MAJOR_VERSION			:_
	(X)->minor = SDL_TTF_MINOR_VERSION			:_
	(X)->patch = SDL_TTF_PATCHLEVEL

#define TTF_MAJOR_VERSION	SDL_TTF_MAJOR_VERSION
#define TTF_MINOR_VERSION	SDL_TTF_MINOR_VERSION
#define TTF_PATCHLEVEL		SDL_TTF_PATCHLEVEL
#define TTF_VERSION(X)		SDL_TTF_VERSION(X)

#define UNICODE_BOM_NATIVE &hFEFF
#define UNICODE_BOM_SWAPPED &hFFFE

type TTF_Font as _TTF_Font

#define TTF_STYLE_NORMAL &h00
#define TTF_STYLE_BOLD &h01
#define TTF_STYLE_ITALIC &h02
#define TTF_STYLE_UNDERLINE &h04

extern "c"
declare function TTF_Linked_Version () as SDL_version ptr
declare sub TTF_ByteSwappedUNICODE (byval swapped as integer)
declare function TTF_Init () as integer
declare function TTF_OpenFont (byval file as zstring ptr, byval ptsize as integer) as TTF_Font ptr
declare function TTF_OpenFontIndex (byval file as zstring ptr, byval ptsize as integer, byval index as integer) as TTF_Font ptr
declare function TTF_OpenFontRW (byval src as SDL_RWops ptr, byval freesrc as integer, byval ptsize as integer) as TTF_Font ptr
declare function TTF_OpenFontIndexRW (byval src as SDL_RWops ptr, byval freesrc as integer, byval ptsize as integer, byval index as integer) as TTF_Font ptr
declare function TTF_GetFontStyle (byval font as TTF_Font ptr) as integer
declare sub TTF_SetFontStyle (byval font as TTF_Font ptr, byval style as integer)
declare function TTF_FontHeight (byval font as TTF_Font ptr) as integer
declare function TTF_FontAscent (byval font as TTF_Font ptr) as integer
declare function TTF_FontDescent (byval font as TTF_Font ptr) as integer
declare function TTF_FontLineSkip (byval font as TTF_Font ptr) as integer
declare function TTF_FontFaces (byval font as TTF_Font ptr) as integer
declare function TTF_FontFaceIsFixedWidth (byval font as TTF_Font ptr) as integer
declare function TTF_FontFaceFamilyName (byval font as TTF_Font ptr) as zstring ptr
declare function TTF_FontFaceStyleName (byval font as TTF_Font ptr) as zstring ptr
declare function TTF_GlyphMetrics (byval font as TTF_Font ptr, byval ch as Uint16, byval minx as integer ptr, byval maxx as integer ptr, byval miny as integer ptr, byval maxy as integer ptr, byval advance as integer ptr) as integer
declare function TTF_SizeText (byval font as TTF_Font ptr, byval text as zstring ptr, byval w as integer ptr, byval h as integer ptr) as integer
declare function TTF_SizeUTF8 (byval font as TTF_Font ptr, byval text as zstring ptr, byval w as integer ptr, byval h as integer ptr) as integer
declare function TTF_SizeUNICODE (byval font as TTF_Font ptr, byval text as Uint16 ptr, byval w as integer ptr, byval h as integer ptr) as integer
declare function TTF_RenderText_Solid (byval font as TTF_Font ptr, byval text as zstring ptr, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderUTF8_Solid (byval font as TTF_Font ptr, byval text as zstring ptr, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderUNICODE_Solid (byval font as TTF_Font ptr, byval text as Uint16 ptr, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderGlyph_Solid (byval font as TTF_Font ptr, byval ch as Uint16, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderText_Shaded (byval font as TTF_Font ptr, byval text as zstring ptr, byval fg as SDL_Color, byval bg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderUTF8_Shaded (byval font as TTF_Font ptr, byval text as zstring ptr, byval fg as SDL_Color, byval bg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderUNICODE_Shaded (byval font as TTF_Font ptr, byval text as Uint16 ptr, byval fg as SDL_Color, byval bg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderGlyph_Shaded (byval font as TTF_Font ptr, byval ch as Uint16, byval fg as SDL_Color, byval bg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderText_Blended (byval font as TTF_Font ptr, byval text as zstring ptr, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderUTF8_Blended (byval font as TTF_Font ptr, byval text as zstring ptr, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderUNICODE_Blended (byval font as TTF_Font ptr, byval text as Uint16 ptr, byval fg as SDL_Color) as SDL_Surface ptr
declare function TTF_RenderGlyph_Blended (byval font as TTF_Font ptr, byval ch as Uint16, byval fg as SDL_Color) as SDL_Surface ptr
declare sub TTF_CloseFont (byval font as TTF_Font ptr)
declare sub TTF_Quit ()
declare function TTF_WasInit () as integer
end extern

#include once "close_code.bi"

#endif
