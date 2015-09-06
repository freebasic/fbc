'' FreeBASIC binding for im-3.9.1
''
'' based on the C header files:
''   Copyright (C) 1994-2014 Tecgraf, PUC-Rio.                                
''                                                                            
''   Permission is hereby granted, free of charge, to any person obtaining    
''   a copy of this software and associated documentation files (the          
''   "Software"), to deal in the Software without restriction, including      
''   without limitation the rights to use, copy, modify, merge, publish,      
''   distribute, sublicense, and/or sell copies of the Software, and to       
''   permit persons to whom the Software is furnished to do so, subject to    
''   the following conditions:                                                
''                                                                            
''   The above copyright notice and this permission notice shall be           
''   included in all copies or substantial portions of the Software.          
''                                                                            
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,          
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF       
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.   
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY     
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,     
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE        
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                   
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "im"

#include once "crt/long.bi"

extern "C"

#define __IM_H

type imDataType as long
enum
	IM_BYTE
	IM_SHORT
	IM_USHORT
	IM_INT
	IM_FLOAT
	IM_DOUBLE
	IM_CFLOAT
	IM_CDOUBLE
end enum

type imColorSpace as long
enum
	IM_RGB
	IM_MAP
	IM_GRAY
	IM_BINARY
	IM_CMYK
	IM_YCBCR
	IM_LAB
	IM_LUV
	IM_XYZ
end enum

type imColorModeConfig as long
enum
	IM_ALPHA = &h100
	IM_PACKED = &h200
	IM_TOPDOWN = &h400
end enum

type imErrorCodes as long
enum
	IM_ERR_NONE
	IM_ERR_OPEN
	IM_ERR_ACCESS
	IM_ERR_FORMAT
	IM_ERR_DATA
	IM_ERR_COMPRESS
	IM_ERR_MEM
	IM_ERR_COUNTER
end enum

type imFile as _imFile
declare function imFileOpen(byval file_name as const zstring ptr, byval error as long ptr) as imFile ptr
declare function imFileOpenAs(byval file_name as const zstring ptr, byval format as const zstring ptr, byval error as long ptr) as imFile ptr
declare function imFileNew(byval file_name as const zstring ptr, byval format as const zstring ptr, byval error as long ptr) as imFile ptr
declare sub imFileClose(byval ifile as imFile ptr)
declare function imFileHandle(byval ifile as imFile ptr, byval index as long) as any ptr
declare sub imFileGetInfo(byval ifile as imFile ptr, byval format as zstring ptr, byval compression as zstring ptr, byval image_count as long ptr)
declare sub imFileSetInfo(byval ifile as imFile ptr, byval compression as const zstring ptr)
declare sub imFileSetAttribute(byval ifile as imFile ptr, byval attrib as const zstring ptr, byval data_type as long, byval count as long, byval data as const any ptr)
declare sub imFileSetAttribInteger(byval ifile as const imFile ptr, byval attrib as const zstring ptr, byval data_type as long, byval value as long)
declare sub imFileSetAttribReal(byval ifile as const imFile ptr, byval attrib as const zstring ptr, byval data_type as long, byval value as double)
declare sub imFileSetAttribString(byval ifile as const imFile ptr, byval attrib as const zstring ptr, byval value as const zstring ptr)
declare function imFileGetAttribute(byval ifile as imFile ptr, byval attrib as const zstring ptr, byval data_type as long ptr, byval count as long ptr) as const any ptr
declare function imFileGetAttribInteger(byval ifile as const imFile ptr, byval attrib as const zstring ptr, byval index as long) as long
declare function imFileGetAttribReal(byval ifile as const imFile ptr, byval attrib as const zstring ptr, byval index as long) as double
declare function imFileGetAttribString(byval ifile as const imFile ptr, byval attrib as const zstring ptr) as const zstring ptr
declare sub imFileGetAttributeList(byval ifile as imFile ptr, byval attrib as zstring ptr ptr, byval attrib_count as long ptr)
declare sub imFileGetPalette(byval ifile as imFile ptr, byval palette as clong ptr, byval palette_count as long ptr)
declare sub imFileSetPalette(byval ifile as imFile ptr, byval palette as clong ptr, byval palette_count as long)
declare function imFileReadImageInfo(byval ifile as imFile ptr, byval index as long, byval width as long ptr, byval height as long ptr, byval file_color_mode as long ptr, byval file_data_type as long ptr) as long
declare function imFileWriteImageInfo(byval ifile as imFile ptr, byval width as long, byval height as long, byval user_color_mode as long, byval user_data_type as long) as long
declare function imFileReadImageData(byval ifile as imFile ptr, byval data as any ptr, byval convert2bitmap as long, byval color_mode_flags as long) as long
declare function imFileWriteImageData(byval ifile as imFile ptr, byval data as any ptr) as long
declare sub imFormatRegisterInternal()
declare sub imFormatRemoveAll()
declare sub imFormatList(byval format_list as zstring ptr ptr, byval format_count as long ptr)
declare function imFormatInfo(byval format as const zstring ptr, byval desc as zstring ptr, byval ext as zstring ptr, byval can_sequence as long ptr) as long
declare function imFormatInfoExtra(byval format as const zstring ptr, byval extra as zstring ptr) as long
declare function imFormatCompressions(byval format as const zstring ptr, byval comp as zstring ptr ptr, byval comp_count as long ptr, byval color_mode as long, byval data_type as long) as long
declare function imFormatCanWriteImage(byval format as const zstring ptr, byval compression as const zstring ptr, byval color_mode as long, byval data_type as long) as long

end extern

#include once "old_im.bi"
