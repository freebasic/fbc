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
'      Datafile access routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_DATAFILE_H
#define ALLEGRO_DATAFILE_H

#include "allegro/base.bi"

#define DAT_ID(a,b,c,d)    AL_ID(a,b,c,d)

#define DAT_MAGIC          DAT_ID(asc("A"),asc("L"),asc("L"),asc("."))
#define DAT_FILE           DAT_ID(asc("F"),asc("I"),asc("L"),asc("E"))
#define DAT_DATA           DAT_ID(asc("D"),asc("A"),asc("T"),asc("A"))
#define DAT_FONT           DAT_ID(asc("F"),asc("O"),asc("N"),asc("T"))
#define DAT_SAMPLE         DAT_ID(asc("S"),asc("A"),asc("M"),asc("P"))
#define DAT_MIDI           DAT_ID(asc("M"),asc("I"),asc("D"),asc("I"))
#define DAT_PATCH          DAT_ID(asc("P"),asc("A"),asc("T"),asc(" "))
#define DAT_FLI            DAT_ID(asc("F"),asc("L"),asc("I"),asc("C"))
#define DAT_BITMAP         DAT_ID(asc("B"),asc("M"),asc("P"),asc(" "))
#define DAT_RLE_SPRITE     DAT_ID(asc("R"),asc("L"),asc("E"),asc(" "))
#define DAT_C_SPRITE       DAT_ID(asc("C"),asc("M"),asc("P"),asc(" "))
#define DAT_XC_SPRITE      DAT_ID(asc("X"),asc("C"),asc("M"),asc("P"))
#define DAT_PALETTE        DAT_ID(asc("P"),asc("A"),asc("L"),asc(" "))
#define DAT_PROPERTY       DAT_ID(asc("p"),asc("r"),asc("o"),asc("p"))
#define DAT_NAME           DAT_ID(asc("N"),asc("A"),asc("M"),asc("E"))
#define DAT_END            -1

Type DATAFILE_PROPERTY
	dat As UByte Ptr			' pointer to the data
	p_type As Integer			' property type - note - changed from 'type' in allegro
End Type

Type DATAFILE
	dat As UByte Ptr			' pointer to the data
	type As Integer				' object type
	size As Long				' size of the object
	prop As DATAFILE_PROPERTY Ptr		' object properties
End Type

Declare Function load_datafile CDecl Alias "load_datafile" (byval filename as zstring ptr) As DATAFILE Ptr
Declare Function load_datafile_callback CDecl Alias "load_datafile_callback" (byval filename as zstring ptr, ByVal callback As Sub(ByVal d As DATAFILE Ptr)) As DATAFILE Ptr
Declare Sub unload_datafile CDecl Alias "unload_datafile" (ByVal dat As DATAFILE Ptr)

Declare Function load_datafile_object CDecl Alias "load_datafile_object" (byval filename as zstring ptr, byval objectname as zstring ptr) As DATAFILE Ptr
Declare Sub unload_datafile_object CDecl Alias "unload_datafile_object" (ByVal dat As DATAFILE Ptr)

Declare Function find_datafile_object CDecl Alias "find_datafile_object" (ByVal dat As DATAFILE Ptr, byval objectname as zstring ptr) As DATAFILE Ptr
Declare Function get_datafile_property CDecl Alias "get_datafile_property" (ByVal dat As DATAFILE Ptr, ByVal typ As Integer) as zstring ptr
Declare Sub register_datafile_object CDecl Alias "register_datafile_object" (ByVal id As Integer, ByVal load As Sub(ByVal f As PACKFILE Ptr, ByVal size As Long), ByVal destroy As Sub(ByVal dat As Integer))

Declare Sub fixup_datafile CDecl Alias "fixup_datafile" (ByVal dat As DATAFILE Ptr)

Declare Function load_bitmap CDecl Alias "load_bitmap" (byval filename as zstring ptr, ByVal pal As RGB Ptr) As BITMAP Ptr
Declare Function load_bmp CDecl Alias "load_bmp" (byval filename as zstring ptr, ByVal pal As RGB Ptr) As BITMAP Ptr
Declare Function load_lbm CDecl Alias "load_lbm" (byval filename as zstring ptr, ByVal pal As RGB Ptr) As BITMAP Ptr
Declare Function load_pcx CDecl Alias "load_pcx" (byval filename as zstring ptr, ByVal pal As RGB Ptr) As BITMAP Ptr
Declare Function load_tga CDecl Alias "load_tga" (byval filename as zstring ptr, ByVal pal As RGB Ptr) As BITMAP Ptr

Declare Function save_bitmap CDecl Alias "save_bitmap" (byval filename as zstring ptr, ByVal bmp As BITMAP Ptr, ByVal pal As RGB Ptr) As Integer
Declare Function save_bmp CDecl Alias "save_bmp" (byval filename as zstring ptr, ByVal bmp As BITMAP Ptr, ByVal pal As RGB Ptr) As Integer
Declare Function save_pcx CDecl Alias "save_pcx" (byval filename as zstring ptr, ByVal bmp As BITMAP Ptr, ByVal pal As RGB Ptr) As Integer
Declare Function save_tga CDecl Alias "save_tga" (byval filename as zstring ptr, ByVal bmp As BITMAP Ptr, ByVal pal As RGB Ptr) As Integer

Declare Sub register_bitmap_file_type CDecl Alias "register_bitmap_file_type" (byval ext as zstring ptr, ByVal load As Function(byval filename as zstring ptr, ByVal pal As RGB Ptr) As BITMAP Ptr, ByVal save As sub(byval filename as zstring ptr, ByVal bmp As BITMAP Ptr, ByVal pal As RGB Ptr))

#endif

