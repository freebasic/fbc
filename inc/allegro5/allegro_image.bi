#pragma once
#inclib "allegro_image"

extern "C"

#define __al_included_allegro5_allegro_image_h
declare function al_init_image_addon() as byte
declare sub al_shutdown_image_addon()
declare function al_get_allegro_image_version() as ulong

end extern
