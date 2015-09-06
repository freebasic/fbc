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

#include once "crt/long.bi"
#include once "im.bi"

extern "C"

#define __IM_FILE_H

type _imFile
	is_new as long
	attrib_table as any ptr
	line_buffer as any ptr
	line_buffer_size as long
	line_buffer_extra as long
	line_buffer_alloc as long
	counter as long
	convert_bpp as long
	switch_type as long
	palette(0 to 255) as clong
	palette_count as long
	user_color_mode as long
	user_data_type as long
	file_color_mode as long
	file_data_type as long
	compression as zstring * 10
	image_count as long
	image_index as long
	width as long
	height as long
end type

declare sub imFileClear(byval ifile as imFile ptr)
declare sub imFileLineBufferInit(byval ifile as imFile ptr)
declare function imFileCheckConversion(byval ifile as imFile ptr) as long
declare function imFileLineBufferCount(byval ifile as imFile ptr) as long
declare sub imFileLineBufferInc(byval ifile as imFile ptr, byval row as long ptr, byval plane as long ptr)
declare sub imFileLineBufferRead(byval ifile as imFile ptr, byval data as any ptr, byval line as long, byval plane as long)
declare sub imFileLineBufferWrite(byval ifile as imFile ptr, byval data as const any ptr, byval line as long, byval plane as long)
declare function imFileLineSizeAligned(byval width as long, byval bpp as long, byval align as long) as long
declare sub imFileSetBaseAttributes(byval ifile as imFile ptr)

end extern
