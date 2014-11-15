#pragma once

#include once "allegro.bi"

extern "C"

#define ALPNG_H

extern alpng_error_msg as zstring ptr

declare sub alpng_init()
declare function load_png(byval filename as const zstring ptr, byval pal as RGB ptr) as BITMAP ptr
declare function load_png_pf(byval f as PACKFILE ptr, byval pal as RGB ptr) as BITMAP ptr
declare function save_png(byval filename as const zstring ptr, byval bmp as BITMAP ptr, byval pal as const RGB ptr) as long
declare function save_png_pf(byval f as PACKFILE ptr, byval bmp as BITMAP ptr, byval pal as const RGB ptr) as long

end extern
