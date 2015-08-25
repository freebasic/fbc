'' FreeBASIC binding for allegro-5.0.11
''
'' based on the C header files:
''   Copyright (c) 2004-2011 the Allegro 5 Development Team
''
''   This software is provided 'as-is', without any express or implied
''   warranty. In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''       1. The origin of this software must not be misrepresented; you must not
''       claim that you wrote the original software. If you use this software
''       in a product, an acknowledgment in the product documentation would be
''       appreciated but is not required.
''
''       2. Altered source versions must be plainly marked as such, and must not be
''       misrepresented as being the original software.
''
''       3. This notice may not be removed or altered from any source
''       distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef __FB_UNIX__
	#inclib "allegro_physfs"
#elseif defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#inclib "allegro_physfs-5.0.10-static-md"
#else
	#inclib "allegro_physfs-5.0.10-md"
#endif

#include once "allegro5/allegro.bi"

extern "C"

#define __al_included_allegro5_allegro_physfs_h
declare sub al_set_physfs_file_interface()
declare function al_get_allegro_physfs_version() as ulong

end extern
