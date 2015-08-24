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
	#inclib "allegro_dialog"
#elseif defined(__FB_WIN32__) and defined(ALLEGRO_STATICLINK)
	#inclib "allegro_dialog-5.0.10-static-md"
#else
	#inclib "allegro_dialog-5.0.10-md"
#endif

#include once "allegro5/allegro.bi"

extern "C"

#define __al_included_allegro5_allegro_native_dialog_h
declare function al_init_native_dialog_addon() as byte
declare sub al_shutdown_native_dialog_addon()
type ALLEGRO_FILECHOOSER as ALLEGRO_FILECHOOSER_
declare function al_create_native_file_dialog(byval initial_path as const zstring ptr, byval title as const zstring ptr, byval patterns as const zstring ptr, byval mode as long) as ALLEGRO_FILECHOOSER ptr
declare function al_show_native_file_dialog(byval display as ALLEGRO_DISPLAY ptr, byval dialog as ALLEGRO_FILECHOOSER ptr) as byte
declare function al_get_native_file_dialog_count(byval dialog as const ALLEGRO_FILECHOOSER ptr) as long
declare function al_get_native_file_dialog_path(byval dialog as const ALLEGRO_FILECHOOSER ptr, byval index as uinteger) as const zstring ptr
declare sub al_destroy_native_file_dialog(byval dialog as ALLEGRO_FILECHOOSER ptr)
declare function al_show_native_message_box(byval display as ALLEGRO_DISPLAY ptr, byval title as const zstring ptr, byval heading as const zstring ptr, byval text as const zstring ptr, byval buttons as const zstring ptr, byval flags as long) as long
type ALLEGRO_TEXTLOG as ALLEGRO_TEXTLOG_
declare function al_open_native_text_log(byval title as const zstring ptr, byval flags as long) as ALLEGRO_TEXTLOG ptr
declare sub al_close_native_text_log(byval textlog as ALLEGRO_TEXTLOG ptr)
declare sub al_append_native_text_log(byval textlog as ALLEGRO_TEXTLOG ptr, byval format as const zstring ptr, ...)
declare function al_get_native_text_log_event_source(byval textlog as ALLEGRO_TEXTLOG ptr) as ALLEGRO_EVENT_SOURCE ptr
declare function al_get_allegro_native_dialog_version() as ulong

enum
	ALLEGRO_FILECHOOSER_FILE_MUST_EXIST = 1
	ALLEGRO_FILECHOOSER_SAVE = 2
	ALLEGRO_FILECHOOSER_FOLDER = 4
	ALLEGRO_FILECHOOSER_PICTURES = 8
	ALLEGRO_FILECHOOSER_SHOW_HIDDEN = 16
	ALLEGRO_FILECHOOSER_MULTIPLE = 32
end enum

enum
	ALLEGRO_MESSAGEBOX_WARN = 1 shl 0
	ALLEGRO_MESSAGEBOX_ERROR = 1 shl 1
	ALLEGRO_MESSAGEBOX_OK_CANCEL = 1 shl 2
	ALLEGRO_MESSAGEBOX_YES_NO = 1 shl 3
	ALLEGRO_MESSAGEBOX_QUESTION = 1 shl 4
end enum

enum
	ALLEGRO_TEXTLOG_NO_CLOSE = 1 shl 0
	ALLEGRO_TEXTLOG_MONOSPACE = 1 shl 1
end enum

enum
	ALLEGRO_EVENT_NATIVE_DIALOG_CLOSE = 600
end enum

end extern
