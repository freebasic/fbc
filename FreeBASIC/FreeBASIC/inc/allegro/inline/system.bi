''
''
'' allegro\system -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_inline_system_bi__
#define __allegro_inline_system_bi__

#include once "allegro/debug.bi"

declare sub set_window_title cdecl alias "set_window_title" (byval name as zstring ptr)

#define ALLEGRO_WINDOW_CLOSE_MESSAGE "Warning: forcing program shutdown may lead to data loss and unexpected results. It is preferable to use the exit command inside the window. Proceed anyway?"

declare function set_window_close_button cdecl alias "set_window_close_button" (byval enable as integer) as integer
declare sub set_window_close_hook cdecl alias "set_window_close_hook" (byval proc as sub cdecl())
declare function desktop_color_depth cdecl alias "desktop_color_depth" () as integer
declare function get_desktop_resolution cdecl alias "get_desktop_resolution" (byval width as integer ptr, byval height as integer ptr) as integer
declare sub yield_timeslice cdecl alias "yield_timeslice" ()


#endif