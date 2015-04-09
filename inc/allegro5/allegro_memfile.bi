'' FreeBASIC binding for allegro-5.0.11

#pragma once

#if defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#inclib "allegro_memfile-5.0.10-static-md"
#elseif defined(__FB_WIN32__) and (not defined(ALLEGRO_STATICLINK))
	#inclib "allegro_memfile-5.0.10-md"
#else
	#inclib "allegro_memfile"
#endif

#include once "allegro5/allegro.bi"

extern "C"

#define __al_included_allegro5_memfile_h
declare function al_open_memfile(byval mem as any ptr, byval size as longint, byval mode as const zstring ptr) as ALLEGRO_FILE ptr
declare function al_get_allegro_memfile_version() as ulong

end extern
