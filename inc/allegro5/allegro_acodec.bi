'' FreeBASIC binding for allegro-5.0.11

#pragma once

#if defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#inclib "allegro_acodec-5.0.10-static-md"
#elseif defined(__FB_WIN32__) and (not defined(ALLEGRO_STATICLINK))
	#inclib "allegro_acodec-5.0.10-md"
#else
	#inclib "allegro_acodec"
#endif

#include once "allegro5/allegro.bi"
#include once "allegro5/allegro_audio.bi"

extern "C"

#define __al_included_allegro5_allegro_acodec_h
declare function al_init_acodec_addon() as byte
declare function al_get_allegro_acodec_version() as ulong

end extern
