'AllegroPNG - http://alpng.sf.net
'
'Copyright (c) 2006 Michal Molhanec
'
'This software is provided 'as-is', without any express or implied
'warranty. In no event will the authors be held liable for any damages
'arising from the use of this software.
'
'Permission is granted to anyone to use this software for any purpose,
'including commercial applications, and to alter it and redistribute
'it freely, subject to the following restrictions:
'
'  1. The origin of this software must not be misrepresented;
'     you must not claim that you wrote the original software.
'     If you use this software in a product, an acknowledgment
'     in the product documentation would be appreciated but
'     is not required.
'
'  2. Altered source versions must be plainly marked as such,
'     and must not be misrepresented as being the original software.
'
'  3. This notice may not be removed or altered from any
'     source distribution.
'

#Ifndef _alpng_bi_
#define _alpng_bi_ -1

#include once "allegro.bi"

#inclib "alpng"

extern "C"

Extern ALPNG_PNG_HEADER As UByte ptr
Extern ALPNG_PNG_HEADER_LEN as Integer

Type alpng_chunk
	type As UInteger
	length As UInteger
End Type

Type alpng_header
	Width As UInteger
	height As UInteger
	byte_width As UInteger
	depth As UByte
	thetype As UByte
	interlace As UByte
	pal As RGB Ptr
	has_palette As Integer
End Type

Type alpng_fake_headers
	h(0 To 6)  As alpng_header
	fake_raw_data_length(0 To 6) As UInteger
End Type


Declare Function alpng_draw (ByVal As alpng_header Ptr, ByVal As UByte Ptr, ByVal As UInteger) As BITMAP Ptr
Declare Function alpng_draw_interlaced Cdecl Alias "alpng_draw_interlaced"(ByVal As alpng_header Ptr, ByVal As UByte Ptr, ByVal As alpng_fake_headers Ptr) As BITMAP Ptr

Declare Sub alpng_fill_fake_headers Cdecl Alias " alpng_fill_fake_headers" (ByVal As alpng_header Ptr, ByVal As alpng_fake_headers Ptr)
Declare Function alpng_calc_raw_data_length Cdecl Alias "alpng_calc_raw_data_length"(ByVal As alpng_header Ptr) As UInteger
Declare Function alpng_unfilter Cdecl Alias "alpng_unfilter" (ByVal As UByte Ptr, ByVal As alpng_header Ptr) As Integer
Declare Function alpng_filter Cdecl Alias "alpng_filter" (ByVal As UByte Ptr, ByVal As UInteger, ByVal As UInteger, ByVal As UInteger) As UByte Ptr

Extern alpng_error_msg As ZString Ptr

' registers PNG extension for load/save_bitmap
Declare Sub alpng_init ()

Declare Function load_png Cdecl Alias "load_png" (ByVal As ZString Ptr, ByVal As RGB Ptr) As BITMAP Ptr
Declare Function load_png_pf Cdecl Alias "load_png_pf" (ByVal As PACKFILE Ptr, ByVal As RGB Ptr) As BITMAP Ptr
Declare Function save_png Cdecl Alias "save_png" (ByVal As ZString Ptr, ByVal As RGB Ptr) As Integer
Declare Function save_png_pf Cdecl Alias "save_png_pf" (ByVal As PACKFILE Ptr, ByVal As BITMAP Ptr, ByVal As RGB Ptr) As Integer

end extern

#EndIf