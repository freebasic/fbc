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

extern "C"

#define __IM_OLD_H

enum
	IM_BMP
	IM_PCX
	IM_GIF
	IM_TIF
	IM_RAS
	IM_SGI
	IM_JPG
	IM_LED
	IM_TGA
end enum

enum
	IM_NONE = &h0000
	IM_DEFAULT = &h0100
	IM_COMPRESSED = &h0200
end enum

const IM_ERR_READ = IM_ERR_ACCESS
const IM_ERR_WRITE = IM_ERR_ACCESS
const IM_ERR_TYPE = IM_ERR_DATA
const IM_ERR_COMP = IM_ERR_COMPRESS

declare function imEncodeColor(byval red as ubyte, byval green as ubyte, byval blue as ubyte) as clong
declare sub imDecodeColor(byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval palette as clong)
declare function imFileFormat(byval filename as zstring ptr, byval format as long ptr) as long
declare function imImageInfo(byval filename as zstring ptr, byval width as long ptr, byval height as long ptr, byval type as long ptr, byval palette_count as long ptr) as long
declare function imLoadRGB(byval filename as zstring ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr) as long
declare function imSaveRGB(byval width as long, byval height as long, byval format as long, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval filename as zstring ptr) as long
declare function imLoadMap(byval filename as zstring ptr, byval map as ubyte ptr, byval palette as clong ptr) as long
declare function imSaveMap(byval width as long, byval height as long, byval format as long, byval map as ubyte ptr, byval palette_count as long, byval palette as clong ptr, byval filename as zstring ptr) as long
declare sub imRGB2Map(byval width as long, byval height as long, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval map as ubyte ptr, byval palette_count as long, byval palette as clong ptr)
declare sub imMap2RGB(byval width as long, byval height as long, byval map as ubyte ptr, byval palette_count as long, byval colors as clong ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr)
declare sub imRGB2Gray(byval width as long, byval height as long, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval map as ubyte ptr, byval grays as clong ptr)
declare sub imMap2Gray(byval width as long, byval height as long, byval map as ubyte ptr, byval palette_count as long, byval colors as clong ptr, byval grey_map as ubyte ptr, byval grays as clong ptr)
declare sub imResize(byval src_width as long, byval src_height as long, byval src_map as ubyte ptr, byval dst_width as long, byval dst_height as long, byval dst_map as ubyte ptr)
declare sub imStretch(byval src_width as long, byval src_height as long, byval src_map as ubyte ptr, byval dst_width as long, byval dst_height as long, byval dst_map as ubyte ptr)
type imCallback as function(byval filename as zstring ptr) as long
declare function imRegisterCallback(byval cb as imCallback, byval cb_id as long, byval format as long) as long

const IM_INTERRUPTED = -1
const IM_ALL = -1
const IM_COUNTER_CB = 0
type imFileCounterCallback as function(byval filename as zstring ptr, byval percent as long, byval io as long) as long
const IM_RESOLUTION_CB = 1
type imResolutionCallback as function(byval filename as zstring ptr, byval xres as double ptr, byval yres as double ptr, byval res_unit as long ptr) as long

enum
	IM_RES_NONE
	IM_RES_DPI
	IM_RES_DPC
end enum

const IM_GIF_TRANSPARENT_COLOR_CB = 0
type imGifTranspIndex as function(byval filename as zstring ptr, byval transp_index as ubyte ptr) as long
const IM_TIF_IMAGE_DESCRIPTION_CB = 0
type imTiffImageDesc as function(byval filename as zstring ptr, byval img_desc as zstring ptr) as long

end extern
