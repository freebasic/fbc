'
'         __   _____    ______   ______   ___    ___
'        /\ \ /\  _ `\ /\  ___\ /\  _  \ /\_ \  /\_ \
'        \ \ \\ \ \L\ \\ \ \__/ \ \ \L\ \\//\ \ \//\ \      __     __
'      __ \ \ \\ \  __| \ \ \  __\ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\
'     /\ \_\/ / \ \ \/   \ \ \L\ \\ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \
'     \ \____//  \ \_\    \ \____/ \ \_\ \_\/\____\/\____\ \____\ \____ \
'      \/____/    \/_/     \/___/   \/_/\/_/\/____/\/____/\/____/\/___L\ \
'                                                                  /\____/
'                                                                  \_/__/
'
'      Version 2.5, by Angelo Mottola, 2000-2004
'
'      Public header file.
'
'      See the readme.txt file for instructions on using this package in your
'      own programs.
'

#ifndef _JPGALLEG_H_
#define _JPGALLEG_H_

#include "allegro.bi"

#inclib "jpgal"

' Library version constat and string
#define JPGALLEG_VERSION &H0205
#define JPGALLEG_VERSION_STRING			"JPGalleg 2.5, by Angelo Mottola, 2000-2004"


' Subsampling mode
#define JPG_SAMPLING_444			0
#define JPG_SAMPLING_422			1
#define JPG_SAMPLING_411			2

' Force greyscale when saving
#define JPG_GREYSCALE				&H10

' Use optimized encoding
#define JPG_OPTIMIZE				&H20


' Error codes
#define JPG_ERROR_NONE				0
#define JPG_ERROR_READING_FILE			-1
#define JPG_ERROR_WRITING_FILE			-2
#define JPG_ERROR_INPUT_BUFFER_TOO_SMALL	-3
#define JPG_ERROR_OUTPUT_BUFFER_TOO_SMALL	-4
#define JPG_ERROR_HUFFMAN			-5
#define JPG_ERROR_NOT_JPEG			-6
#define JPG_ERROR_UNSUPPORTED_ENCODING		-7
#define JPG_ERROR_UNSUPPORTED_COLOR_SPACE	-8
#define JPG_ERROR_UNSUPPORTED_DATA_PRECISION	-9
#define JPG_ERROR_BAD_IMAGE			-10
#define JPG_ERROR_OUT_OF_MEMORY			-11


' Datafile object type for JPG images
#define DAT_JPEG				DAT_ID(Asc("J"),Asc("P"),Asc("E"),Asc("G"))

Declare Function jpgalleg_init CDecl Alias "jpgalleg_init" () As Integer

Declare Function load_jpg CDecl Alias "load_jpg" (byval filename as zstring ptr, ByVal palette As RGB Ptr) As BITMAP Ptr
Declare Function load_jpg_ex CDecl Alias "load_jpg_ex" (byval filename as zstring ptr, ByVal palette As RGB Ptr, ByVal callback As Sub(ByVal progress As Integer)) As BITMAP Ptr
Declare Function load_memory_jpg CDecl Alias "load_memory_jpg" (ByVal buffer As Any Ptr, ByVal size As Integer, ByVal palette As RGB Ptr) As BITMAP Ptr
Declare Function load_memory_jpg_ex CDecl Alias "load_memory_jpg_ex" (ByVal buffer As Any Ptr, ByVal size As Integer, ByVal palette As RGB Ptr, ByVal callback As Sub(ByVal progress As Integer)) As BITMAP Ptr

Declare Function save_jpg CDecl Alias "save_jpg" (byval filename as zstring ptr, ByVal image As BITMAP Ptr, ByVal palette As RGB Ptr) As Integer
Declare Function save_jpg_ex CDecl Alias "save_jpg_ex" (byval filename as zstring ptr, ByVal image As BITMAP Ptr, ByVal palette As RGB Ptr, ByVal quality As Integer, ByVal flags As Integer, ByVal callback As Sub(ByVal progress As Integer)) As Integer
Declare Function save_memory_jpg CDecl Alias "save_memory_jpg" (ByVal buffer As Any Ptr, ByVal size As Integer Ptr, ByVal image As BITMAP Ptr, ByVal palette As RGB Ptr) As Integer
Declare Function save_memory_jpg_ex CDecl Alias "save_memory_jpg_ex" (ByVal buffer As Any Ptr, ByVal size As Integer Ptr, ByVal image As BITMAP Ptr, ByVal palette As RGB Ptr, ByVal quality As Integer, ByVal flags As Integer, BYVal callback as Sub(ByVal progress As Integer)) As Integer

Extern jpgalleg_error Alias "jpgalleg_error" As Integer

#endif
