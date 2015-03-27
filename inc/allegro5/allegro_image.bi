#pragma once

#if defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#inclib "allegro_image-5.0.10-static-md"
#elseif defined(__FB_WIN32__) and (not defined(ALLEGRO_STATICLINK))
	#inclib "allegro_image-5.0.10-md"
#else
	#inclib "allegro_image"
#endif

extern "C"

#define __al_included_allegro5_allegro_image_h
declare function al_init_image_addon() as byte
declare sub al_shutdown_image_addon()
declare function al_get_allegro_image_version() as ulong

end extern
