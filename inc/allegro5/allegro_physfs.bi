#pragma once

#if defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#inclib "allegro_physfs-5.0.10-static-md"
#elseif defined(__FB_WIN32__) and (not defined(ALLEGRO_STATICLINK))
	#inclib "allegro_physfs-5.0.10-md"
#else
	#inclib "allegro_physfs"
#endif

#include once "allegro5/allegro.bi"

extern "C"

#define __al_included_allegro5_allegro_physfs_h
declare sub al_set_physfs_file_interface()
declare function al_get_allegro_physfs_version() as ulong

end extern
