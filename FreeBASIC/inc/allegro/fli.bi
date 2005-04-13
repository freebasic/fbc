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
'      FLI/FLC routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_FLI_H
#define ALLEGRO_FLI_H

#include "allegro/base.bi"
#include "allegro/palette.bi"

#define FLI_OK          0              ' FLI player return values
#define FLI_EOF         -1
#define FLI_ERROR       -2
#define FLI_NOT_OPEN    -3

Declare Function play_fli CDecl Alias "play_fli" (ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal iloop As Integer, ByVal callback As Function() As Integer) As Integer
Declare Function play_memory_fli CDecl Alias "play_memory_fli" (ByVal fli_data As Integer, ByVal bmp As BITMAP Ptr, ByVal iloop As Integer, ByVal callback As Function() As Integer) As Integer

Declare Function open_fli CDecl Alias "open_fli" (ByVal filename As String) As Integer
Declare Function open_memory_fli CDecl Alias "open_memory_fli" (ByVal fli_data As Integer) As Integer
Declare Sub close_fli CDecl Alias "close_fli" ()
Declare Function next_fli_frame CDecl Alias "next_fli_frame" (ByVal iloop As Integer) As Integer
Declare Sub reset_fli_variables CDecl Alias "reset_fli_variables" ()

Extern Import fli_bitmap Alias "fli_bitmap" As BITMAP Ptr
Extern Import fli_palette Alias "fli_palette" As RGB Ptr

Extern Import fli_bmp_dirty_from Alias "fli_bmp_dirty_from" As Integer
Extern Import fli_bmp_dirty_to Alias "fli_bmp_dirty_to" As Integer
extern import fli_pal_dirty_from alias "fli_pal_dirty_from" as integer
extern import fli_pal_dirty_to alias "fli_pal_dirty_to" as integer

Extern Import fli_frame alias "fli_frame" as integer

Extern Import fli_timer Alias "fli_timer" As Integer

#endif