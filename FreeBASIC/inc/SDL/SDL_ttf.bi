#ifndef SDLTTF_BI
#define SDLTTF_BI
''
'' constants and types for SDL_TTF functions (sdl_ttf.h)
'' brought to you by
'' Matthias Faust (Fausti)

#inclib "SDL"
#inclib "SDL_ttf"

#include once "SDL/SDL.bi"
#include "SDL/begin_code.bi"

#define SDL_TTF_MAJOR_VERSION	2
#define SDL_TTF_MINOR_VERSION	0
#define SDL_TTF_PATCHLEVEL	7

#define SDL_TTF_VERSION(X) X->major = SDL_TTF_MAJOR_VERSION : X->minor = SDL_TTF_MINOR_VERSION : X->patch = SDL_TTF_PATCHLEVEL

#define TTF_MAJOR_VERSION	SDL_TTF_MAJOR_VERSION
#define TTF_MINOR_VERSION	SDL_TTF_MINOR_VERSION
#define TTF_PATCHLEVEL		SDL_TTF_PATCHLEVEL
#define TTF_VERSION(X) 		SDL_TTF_VERSION(X)

declare function TTF_Linked_Version SDLCALL alias "TTF_Linked_Version" () as SDL_version ptr


const UNICODE_BOM_NATIVE = &Hfeff
const UNICODE_BOM_SWAPPED = &Hfffe

Declare Sub TTF_ByteSwappedUNICODE SDLCALL alias "TTF_ByteSwappedUNICODE" (byval swapped as integer)

#define TTF_Font any ptr

Declare Function TTF_Init SDLCALL alias "TTF_Init" () as integer

Declare Function TTF_OpenFont SDLCALL alias "TTF_OpenFont" (byval file as string, byval ptsize as integer) as TTF_Font
Declare Function TTF_OpenFontIndex SDLCALL alias "TTF_OpenFontIndex" (byval file as string, byval ptsize as integer, byval index as integer) as TTF_Font
Declare Function TTF_OpenFontRW SDLCALL alias "TTF_OpenFontRW" (byval src as SDL_RWops ptr, byval freesrc as integer, byval ptsize as integer) as TTF_Font
Declare Function TTF_OpenFontIndexRW SDLCALL alias "TTF_OpenFontIndexRW" (byval src as SDL_RWops ptr, byval freesrc as integer, byval ptsize as integer, byval index as integer) as TTF_Font

const TTF_STYLE_NORMAL = 0
const TTF_STYLE_BOLD = 1
const TTF_STYLE_ITALIC = 2
const TTF_STYLE_UNDERLINE = 4

Declare Function TTF_GetFontStyle SDLCALL alias "TTF_GetFontStyle" (byval font as TTF_Font) as integer
Declare Sub TTF_SetFontStyle SDLCALL alias "TTF_SetFontStyle" (byval font as TTF_Font, byval style as integer)

Declare Function TTF_FontHeight SDLCALL alias "TTF_FontHeight" (byval font as TTF_Font) as integer
Declare Function TTF_FontAscent SDLCALL alias "TTF_FontAscent" (byval font as TTF_Font) as integer
Declare Function TTF_FontDescent SDLCALL alias "TTF_FontDescent" (byval font as TTF_Font) as integer
Declare Function TTF_FontLineSkip SDLCALL alias "TTF_FontLineSkip" (byval font as TTF_Font) as integer
Declare Function TTF_FontFaces SDLCALL alias "TTF_FontFaces" (byval font as TTF_Font) as integer
Declare Function TTF_FontFaceIsFixedWidth SDLCALL alias "TTF_FontFaceIsFixedWidth" (byval font as TTF_Font) as integer
Declare Function TTF_FontFaceFamilyName SDLCALL alias "TTF_FontFaceFamilyName" (byval font as TTF_Font) as byte ptr
Declare Function TTF_FontFaceStyleName SDLCALL alias "TTF_FontFaceStyleName" (byval font as TTF_Font) as byte ptr

Declare Function TTF_GlyphMetrics SDLCALL alias "TTF_GlyphMetrics" (byval font as TTF_Font, byval ch as Uint16, byval minx as integer ptr, byval maxx as integer ptr, byval miny as integer ptr, byval maxy as integer ptr, byval advance as integer ptr) as integer

Declare Function TTF_SizeText SDLCALL alias "TTF_SizeText" (byval font as TTF_Font, byval text as string, byval w as integer ptr, byval h as integer ptr) as integer
Declare Function TTF_SizeUTF8 SDLCALL alias "TTF_SizeUTF8" (byval font as TTF_Font, byval text as string, byval w as integer ptr, byval h as integer ptr) as integer
Declare Function TTF_SizeUNICODE SDLCALL alias "TTF_SizeUNICODE" (byval font as TTF_Font, byval text as Uint16 ptr, byval w as integer ptr, byval h as integer ptr) as integer

Declare Function TTF_RenderText_Solid SDLCALL alias "TTF_RenderText_Solid" (byval font as TTF_Font, byval text as string, byval fg as SDL_Color) as SDL_Surface ptr
Declare Function TTF_RenderUTF8_Solid SDLCALL alias "TTF_RenderUTF8_Solid" (byval font as TTF_Font, byval text as string, byval fg as SDL_Color) as SDL_Surface ptr
Declare Function TTF_RenderUNICODE_Solid SDLCALL alias "TTF_RenderUNICODE_Solid" (byval font as TTF_Font, byval text as Uint16 ptr, byval fg as SDL_Color) as SDL_Surface ptr

Declare Function TTF_RenderGlyph_Solid SDLCALL alias "TTF_RenderGlyph_Solid" (byval font as TTF_Font, byval ch as Uint16, byval fg as SDL_Color) as SDL_Surface ptr

Declare Function TTF_RenderText_Shaded SDLCALL alias "TTF_RenderText_Shaded" (byval font as TTF_Font, byval text as string, byval fg as SDL_Color, byval bg as SDL_Color) as SDL_Surface ptr
Declare Function TTF_RenderUTF8_Shaded SDLCALL alias "TTF_RenderUTF8_Shaded" (byval font as TTF_Font, byval text as string, byval fg as SDL_Color, byval bg as SDL_Color) as SDL_Surface ptr
Declare Function TTF_RenderUNICODE_Shaded SDLCALL alias "TTF_RenderUNICODE_Shaded" (byval font as TTF_Font, byval text as Uint16 ptr, byval fg as SDL_Color, byval bg as SDL_Color) as SDL_Surface ptr

Declare Function TTF_RenderGlyph_Shaded SDLCALL alias "TTF_RenderGlyph_Shaded" (byval font as TTF_Font, byval ch as Uint16, byval fg as SDL_Color, byval bg as SDL_Color) as SDL_Surface ptr

Declare Function TTF_RenderText_Blended SDLCALL alias "TTF_RenderText_Blended" (byval font as TTF_Font, byval text as string, byval fg as SDL_Color) as SDL_Surface ptr
Declare Function TTF_RenderUTF8_Blended SDLCALL alias "TTF_RenderUTF8_Blended" (byval font as TTF_Font, byval text as string, byval fg as SDL_Color) as SDL_Surface ptr
Declare Function TTF_RenderUNICODE_Blended SDLCALL alias "TTF_RenderUNICODE_Blended" (byval font as TTF_Font, byval text as Uint16 ptr, byval fg as SDL_Color) as SDL_Surface ptr

Declare Function TTF_RenderGlyph_Blended SDLCALL alias "TTF_RenderGlyph_Blended" (byval font as TTF_Font, byval ch as Uint16, byval fg as SDL_Color) as SDL_Surface ptr

Declare Sub TTF_CloseFont SDLCALL alias "TTF_CloseFont" (byval font as TTF_Font)
Declare Sub TTF_Quit SDLCALL alias "TTF_Quit" ()
Declare Function TTF_WasInit SDLCALL alias "TTF_WasInit" () as integer

#include "SDL/close_code.bi"

#endif ''SDLTTF_BI