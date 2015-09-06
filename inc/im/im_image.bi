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

#define __IM_IMAGE_H

type _imImage
	width as long
	height as long
	color_space as long
	data_type as long
	has_alpha as long
	depth as long
	line_size as long
	plane_size as long
	size as long
	count as long
	data as any ptr ptr
	palette as clong ptr
	palette_count as long
	attrib_table as any ptr
end type

type imImage as _imImage
declare function imImageCreate(byval width as long, byval height as long, byval color_space as long, byval data_type as long) as imImage ptr
declare function imImageInit(byval width as long, byval height as long, byval color_mode as long, byval data_type as long, byval data_buffer as any ptr, byval palette as clong ptr, byval palette_count as long) as imImage ptr
declare function imImageCreateBased(byval image as const imImage ptr, byval width as long, byval height as long, byval color_space as long, byval data_type as long) as imImage ptr
declare sub imImageDestroy(byval image as imImage ptr)
declare sub imImageAddAlpha(byval image as imImage ptr)
declare sub imImageSetAlpha(byval image as imImage ptr, byval alpha as single)
declare sub imImageRemoveAlpha(byval image as imImage ptr)
declare sub imImageReshape(byval image as imImage ptr, byval width as long, byval height as long)
declare sub imImageCopy(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imImageCopyData(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imImageCopyAttributes(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imImageMergeAttributes(byval src_image as const imImage ptr, byval dst_image as imImage ptr)
declare sub imImageCopyPlane(byval src_image as const imImage ptr, byval src_plane as long, byval dst_image as imImage ptr, byval dst_plane as long)
declare function imImageDuplicate(byval image as const imImage ptr) as imImage ptr
declare function imImageClone(byval image as const imImage ptr) as imImage ptr
declare sub imImageSetAttribute(byval image as const imImage ptr, byval attrib as const zstring ptr, byval data_type as long, byval count as long, byval data as const any ptr)
declare sub imImageSetAttribInteger(byval image as const imImage ptr, byval attrib as const zstring ptr, byval data_type as long, byval value as long)
declare sub imImageSetAttribReal(byval image as const imImage ptr, byval attrib as const zstring ptr, byval data_type as long, byval value as double)
declare sub imImageSetAttribString(byval image as const imImage ptr, byval attrib as const zstring ptr, byval value as const zstring ptr)
declare function imImageGetAttribute(byval image as const imImage ptr, byval attrib as const zstring ptr, byval data_type as long ptr, byval count as long ptr) as const any ptr
declare function imImageGetAttribInteger(byval image as const imImage ptr, byval attrib as const zstring ptr, byval index as long) as long
declare function imImageGetAttribReal(byval image as const imImage ptr, byval attrib as const zstring ptr, byval index as long) as double
declare function imImageGetAttribString(byval image as const imImage ptr, byval attrib as const zstring ptr) as const zstring ptr
declare sub imImageGetAttributeList(byval image as const imImage ptr, byval attrib as zstring ptr ptr, byval attrib_count as long ptr)
declare sub imImageClear(byval image as imImage ptr)
declare function imImageIsBitmap(byval image as const imImage ptr) as long
declare sub imImageSetPalette(byval image as imImage ptr, byval palette as clong ptr, byval palette_count as long)
declare function imImageMatchSize(byval image1 as const imImage ptr, byval image2 as const imImage ptr) as long
declare function imImageMatchColor(byval image1 as const imImage ptr, byval image2 as const imImage ptr) as long
declare function imImageMatchDataType(byval image1 as const imImage ptr, byval image2 as const imImage ptr) as long
declare function imImageMatchColorSpace(byval image1 as const imImage ptr, byval image2 as const imImage ptr) as long
declare function imImageMatch(byval image1 as const imImage ptr, byval image2 as const imImage ptr) as long
declare sub imImageSetMap(byval image as imImage ptr)
declare sub imImageSetBinary(byval image as imImage ptr)
declare sub imImageSetGray(byval image as imImage ptr)
declare sub imImageMakeBinary(byval image as imImage ptr)
declare sub imImageMakeGray(byval image as imImage ptr)
declare function imFileLoadImage(byval ifile as imFile ptr, byval index as long, byval error as long ptr) as imImage ptr
declare sub imFileLoadImageFrame(byval ifile as imFile ptr, byval index as long, byval image as imImage ptr, byval error as long ptr)
declare function imFileLoadBitmap(byval ifile as imFile ptr, byval index as long, byval error as long ptr) as imImage ptr
declare function imFileLoadImageRegion(byval ifile as imFile ptr, byval index as long, byval bitmap as long, byval error as long ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long, byval width as long, byval height as long) as imImage ptr
declare sub imFileLoadBitmapFrame(byval ifile as imFile ptr, byval index as long, byval image as imImage ptr, byval error as long ptr)
declare function imFileSaveImage(byval ifile as imFile ptr, byval image as const imImage ptr) as long
declare function imFileImageLoad(byval file_name as const zstring ptr, byval index as long, byval error as long ptr) as imImage ptr
declare function imFileImageLoadBitmap(byval file_name as const zstring ptr, byval index as long, byval error as long ptr) as imImage ptr
declare function imFileImageLoadRegion(byval file_name as const zstring ptr, byval index as long, byval bitmap as long, byval error as long ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long, byval width as long, byval height as long) as imImage ptr
declare function imFileImageSave(byval file_name as const zstring ptr, byval format as const zstring ptr, byval image as const imImage ptr) as long
#macro imcdCanvasPutImage(_canvas, _image, _x, _y, _w, _h, _xmin, _xmax, _ymin, _ymax)
	if _image->color_space = IM_RGB then
		if _image->has_alpha then
			cdCanvasPutImageRectRGBA(_canvas, _image->width, _image->height, cptr(ubyte ptr, _image->data[0]), cptr(ubyte ptr, _image->data[1]), cptr(ubyte ptr, _image->data[2]), cptr(ubyte ptr, _image->data[3]), _x, _y, _w, _h, _xmin, _xmax, _ymin, _ymax)
		else
			cdCanvasPutImageRectRGB(_canvas, _image->width, _image->height, cptr(ubyte ptr, _image->data[0]), cptr(ubyte ptr, _image->data[1]), cptr(ubyte ptr, _image->data[2]), _x, _y, _w, _h, _xmin, _xmax, _ymin, _ymax)
		end if
	else
		cdCanvasPutImageRectMap(_canvas, _image->width, _image->height, cptr(ubyte ptr, _image->data[0]), _image->palette, _x, _y, _w, _h, _xmin, _xmax, _ymin, _ymax)
	end if
#endmacro

end extern
