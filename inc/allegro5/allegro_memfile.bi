#pragma once

#inclib "allegro_memfile"

#include once "allegro5/allegro.bi"

extern "C"

#define __al_included_allegro5_memfile_h
declare function al_open_memfile(byval mem as any ptr, byval size as longint, byval mode as const zstring ptr) as ALLEGRO_FILE ptr
declare function al_get_allegro_memfile_version() as ulong

end extern
