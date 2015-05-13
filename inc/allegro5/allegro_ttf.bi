#pragma once
#inclib "allegro_ttf"

#include once "allegro5/allegro.bi"
#include once "allegro5/allegro_font.bi"

extern "C"

#define __al_included_allegro5_allegro_ttf_h
#define ALLEGRO_TTF_NO_KERNING 1
#define ALLEGRO_TTF_MONOCHROME 2
#define ALLEGRO_TTF_NO_AUTOHINT 4

declare function al_load_ttf_font(byval filename as const zstring ptr, byval size as long, byval flags as long) as ALLEGRO_FONT ptr
declare function al_load_ttf_font_f(byval file as ALLEGRO_FILE ptr, byval filename as const zstring ptr, byval size as long, byval flags as long) as ALLEGRO_FONT ptr
declare function al_load_ttf_font_stretch(byval filename as const zstring ptr, byval w as long, byval h as long, byval flags as long) as ALLEGRO_FONT ptr
declare function al_load_ttf_font_stretch_f(byval file as ALLEGRO_FILE ptr, byval filename as const zstring ptr, byval w as long, byval h as long, byval flags as long) as ALLEGRO_FONT ptr
declare function al_init_ttf_addon() as byte
declare sub al_shutdown_ttf_addon()
declare function al_get_allegro_ttf_version() as ulong

end extern
