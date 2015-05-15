'' FreeBASIC binding for alpng13
''
'' based on the C header files:
''   AllegroPNG
''
''   Copyright (c) 2006 Michal Molhanec
''
''   This software is provided 'as-is', without any express or implied
''   warranty. In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute
''   it freely, subject to the following restrictions:
''
''     1. The origin of this software must not be misrepresented;
''        you must not claim that you wrote the original software.
''        If you use this software in a product, an acknowledgment
''        in the product documentation would be appreciated but
''        is not required.
''
''     2. Altered source versions must be plainly marked as such,
''        and must not be misrepresented as being the original software.
''
''     3. This notice may not be removed or altered from any
''        source distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "alpng"

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
