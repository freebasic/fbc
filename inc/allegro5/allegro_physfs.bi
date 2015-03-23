#pragma once
#inclib "allegro_physfs"

#include once "allegro5/allegro.bi"

extern "C"

#define __al_included_allegro5_allegro_physfs_h
declare sub al_set_physfs_file_interface()
declare function al_get_allegro_physfs_version() as ulong

end extern
