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

Declare Sub set_config_file CDecl Alias "set_config_file" (ByVal filename As String)
Declare Sub set_config_data CDecl Alias "set_config_data" (ByVal sdata As String, ByVal length As Integer)
Declare Sub override_config_file CDecl Alias "override_config_file" (ByVal filename As String)
Declare Sub override_config_data CDecl Alias "override_config_data" (ByVal sdata As String, ByVal length As Integer)
Declare Sub flush_config_file CDecl Alias "flush_config_file" ()
Declare Sub reload_config_texts CDecl Alias "reload_config_texts" (ByVal new_language As String)

Declare Sub push_config_state CDecl Alias "push_config_state" ()
Declare Sub pop_config_state CDecl Alias "pop_config_state" ()

Declare Sub hook_config_section CDecl Alias "hook_config_section" (ByVal section As String, ByVal intgetter As Function(ByVal name As String, ByVal idef As Integer) As Integer, ByVal stringgetter As Function(ByVal name As String, ByVal sdef As String) As Integer, ByVal stringsetter As Sub (ByVal name As String, ByVal value As String))
Declare Function config_is_hooked CDecl Alias "config_is_hooked" (ByVal section As String) As Integer

Declare Function get_config_string CDecl Alias "get_config_string" (ByVal section As String, ByVal name As String, Byval sdef As String) as zstring ptr
Declare Function get_config_int CDecl Alias "get_config_int" (ByVal section As String, ByVal name As String, ByVal idef As Integer) As Integer
Declare Function get_config_hex CDecl Alias "get_config_hex" (ByVal section As String, ByVal name As String, ByVal idef As Integer) As Integer
Declare Function get_config_float CDecl Alias "get_config_float" (ByVal section As String, ByVal name As String, ByVal fdef As Single) As Single
Declare Function get_config_id CDecl Alias "get_config_id" (ByVal section As String, ByVal name As String, ByVal idef As Integer) As Integer
Declare Function get_config_argv CDecl Alias "get_config_argv" (ByVal section As String, ByVal s_name As String, ByVal argc As Integer Ptr) as zstring ptr Ptr
Declare Function get_config_text CDecl Alias "get_config_text" (ByVal msg As String) as zstring ptr

Declare Sub set_config_string CDecl Alias "set_config_string" (ByVal section As String, ByVal name As String, ByVal val As String)
Declare Sub set_config_int CDecl Alias "set_config_int" (ByVal section As String, ByVal name As String, ByVal val As Integer)
Declare Sub set_config_hex CDecl Alias "set_config_hex" (ByVal section As String, ByVal name As String, ByVal val As Integer)
Declare Sub set_config_float CDecl Alias "set_config_float" (ByVal section As String, ByVal name As String, ByVal val As Single)
Declare Sub set_config_id CDecl Alias "set_config_id" (ByVal section As String, ByVal name As String, ByVal val As Integer)

#endif
