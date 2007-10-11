''
''
'' allegro\config -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_config_bi__
#define __allegro_config_bi__

#include once "allegro/base.bi"

declare sub set_config_file cdecl alias "set_config_file" (byval filename as zstring ptr)
declare sub set_config_data cdecl alias "set_config_data" (byval data as zstring ptr, byval length as integer)
declare sub override_config_file cdecl alias "override_config_file" (byval filename as zstring ptr)
declare sub override_config_data cdecl alias "override_config_data" (byval data as zstring ptr, byval length as integer)
declare sub flush_config_file cdecl alias "flush_config_file" ()
declare sub reload_config_texts cdecl alias "reload_config_texts" (byval new_language as zstring ptr)
declare sub push_config_state cdecl alias "push_config_state" ()
declare sub pop_config_state cdecl alias "pop_config_state" ()
declare sub hook_config_section cdecl alias "hook_config_section" (byval section as zstring ptr, byval intgetter as function cdecl(byval as zstring ptr, byval as integer) as integer, byval stringgetter as function cdecl(byval as zstring ptr, byval as zstring ptr) as byte ptr, byval stringsetter as sub cdecl(byval as zstring ptr, byval as zstring ptr))
declare function config_is_hooked cdecl alias "config_is_hooked" (byval section as zstring ptr) as integer
declare function get_config_string cdecl alias "get_config_string" (byval section as zstring ptr, byval name as zstring ptr, byval def as zstring ptr) as zstring ptr
declare function get_config_int cdecl alias "get_config_int" (byval section as zstring ptr, byval name as zstring ptr, byval def as integer) as integer
declare function get_config_hex cdecl alias "get_config_hex" (byval section as zstring ptr, byval name as zstring ptr, byval def as integer) as integer
declare function get_config_float cdecl alias "get_config_float" (byval section as zstring ptr, byval name as zstring ptr, byval def as single) as single
declare function get_config_id cdecl alias "get_config_id" (byval section as zstring ptr, byval name as zstring ptr, byval def as integer) as integer
declare function get_config_argv cdecl alias "get_config_argv" (byval section as zstring ptr, byval name as zstring ptr, byval argc as integer ptr) as byte ptr ptr
declare function get_config_text cdecl alias "get_config_text" (byval msg as zstring ptr) as zstring ptr
declare sub set_config_string cdecl alias "set_config_string" (byval section as zstring ptr, byval name as zstring ptr, byval val as zstring ptr)
declare sub set_config_int cdecl alias "set_config_int" (byval section as zstring ptr, byval name as zstring ptr, byval val as integer)
declare sub set_config_hex cdecl alias "set_config_hex" (byval section as zstring ptr, byval name as zstring ptr, byval val as integer)
declare sub set_config_float cdecl alias "set_config_float" (byval section as zstring ptr, byval name as zstring ptr, byval val as single)
declare sub set_config_id cdecl alias "set_config_id" (byval section as zstring ptr, byval name as zstring ptr, byval val as integer)

#endif
