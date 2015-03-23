#pragma once

#inclib "allegro_acodec"

#include once "allegro5/allegro.bi"
#include once "allegro5/allegro_audio.bi"

extern "C"

#define __al_included_allegro5_allegro_acodec_h
declare function al_init_acodec_addon() as byte
declare function al_get_allegro_acodec_version() as ulong

end extern
