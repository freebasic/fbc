'         ______   ___    ___
'        /\  _  \ /\_ \  /\_ \
'        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
'         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
'          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
'           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
'            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
'                                           /\____/
'                                           \_/__/
'
'      Configuration file access routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_CONFIG_H
#define ALLEGRO_CONFIG_H

#include "allegro/base.bi"

Declare Sub set_config_file CDecl Alias "set_config_file" (byval filename as zstring ptr)
Declare Sub set_config_data CDecl Alias "set_config_data" (byval sdata as zstring ptr, ByVal length As Integer)
Declare Sub override_config_file CDecl Alias "override_config_file" (byval filename as zstring ptr)
Declare Sub override_config_data CDecl Alias "override_config_data" (byval sdata as zstring ptr, ByVal length As Integer)
Declare Sub flush_config_file CDecl Alias "flush_config_file" ()
Declare Sub reload_config_texts CDecl Alias "reload_config_texts" (byval new_language as zstring ptr)

Declare Sub push_config_state CDecl Alias "push_config_state" ()
Declare Sub pop_config_state CDecl Alias "pop_config_state" ()

Declare Sub hook_config_section CDecl Alias "hook_config_section" (byval section as zstring ptr, ByVal intgetter As Function(byval name as zstring ptr, ByVal idef As Integer) As Integer, ByVal stringgetter As Function(byval name as zstring ptr, byval sdef as zstring ptr) As Integer, ByVal stringsetter As Sub (byval name as zstring ptr, byval value as zstring ptr))
Declare Function config_is_hooked CDecl Alias "config_is_hooked" (byval section as zstring ptr) As Integer

Declare Function get_config_string CDecl Alias "get_config_string" (byval section as zstring ptr, byval name as zstring ptr, byval sdef as zstring ptr) as zstring ptr
Declare Function get_config_int CDecl Alias "get_config_int" (byval section as zstring ptr, byval name as zstring ptr, ByVal idef As Integer) As Integer
Declare Function get_config_hex CDecl Alias "get_config_hex" (byval section as zstring ptr, byval name as zstring ptr, ByVal idef As Integer) As Integer
Declare Function get_config_float CDecl Alias "get_config_float" (byval section as zstring ptr, byval name as zstring ptr, ByVal fdef As Single) As Single
Declare Function get_config_id CDecl Alias "get_config_id" (byval section as zstring ptr, byval name as zstring ptr, ByVal idef As Integer) As Integer
Declare Function get_config_argv CDecl Alias "get_config_argv" (byval section as zstring ptr, byval s_name as zstring ptr, ByVal argc As Integer Ptr) as zstring ptr Ptr
Declare Function get_config_text CDecl Alias "get_config_text" (byval msg as zstring ptr) as zstring ptr

Declare Sub set_config_string CDecl Alias "set_config_string" (byval section as zstring ptr, byval name as zstring ptr, byval val as zstring ptr)
Declare Sub set_config_int CDecl Alias "set_config_int" (byval section as zstring ptr, byval name as zstring ptr, ByVal val As Integer)
Declare Sub set_config_hex CDecl Alias "set_config_hex" (byval section as zstring ptr, byval name as zstring ptr, ByVal val As Integer)
Declare Sub set_config_float CDecl Alias "set_config_float" (byval section as zstring ptr, byval name as zstring ptr, ByVal val As Single)
Declare Sub set_config_id CDecl Alias "set_config_id" (byval section as zstring ptr, byval name as zstring ptr, ByVal val As Integer)

#endif
