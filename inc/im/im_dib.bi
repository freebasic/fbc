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

#define __IM_DIB_H

type _imDib
	handle as HGLOBAL
	dib as BYTE ptr
	size as long
	bmi as BITMAPINFO ptr
	bmih as BITMAPINFOHEADER ptr
	bmic as RGBQUAD ptr
	bits as BYTE ptr
	palette_count as long
	bits_size as long
	line_size as long
	pad_size as long
	is_reference as long
end type

type imDib as _imDib
declare function imDibCreate(byval width as long, byval height as long, byval bpp as long) as imDib ptr
declare function imDibCreateCopy(byval dib as const imDib ptr) as imDib ptr
declare function imDibCreateReference(byval bmi as BYTE ptr, byval bits as BYTE ptr) as imDib ptr
declare function imDibCreateSection(byval hDC as HDC, byval image as HBITMAP ptr, byval width as long, byval height as long, byval bpp as long) as imDib ptr
declare sub imDibDestroy(byval dib as imDib ptr)
type imDibLineGetPixel as function(byval line as ubyte ptr, byval col as long) as ulong
declare function imDibLineGetPixelFunc(byval bpp as long) as imDibLineGetPixel
type imDibLineSetPixel as sub(byval line as ubyte ptr, byval col as long, byval pixel as ulong)
declare function imDibLineSetPixelFunc(byval bpp as long) as imDibLineSetPixel
declare function imDibFromHBitmap(byval image as const HBITMAP, byval hPalette as const HPALETTE) as imDib ptr
declare function imDibToHBitmap(byval dib as const imDib ptr) as HBITMAP
declare function imDibLogicalPalette(byval dib as const imDib ptr) as HPALETTE
declare function imDibCaptureScreen(byval x as long, byval y as long, byval width as long, byval height as long) as imDib ptr
declare sub imDibCopyClipboard(byval dib as imDib ptr)
declare function imDibPasteClipboard() as imDib ptr
declare function imDibIsClipboardAvailable() as long
declare function imDibSaveFile(byval dib as const imDib ptr, byval filename as const zstring ptr) as long
declare function imDibLoadFile(byval filename as const zstring ptr) as imDib ptr
declare sub imDibDecodeToRGBA(byval dib as const imDib ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval alpha as ubyte ptr)
declare sub imDibDecodeToMap(byval dib as const imDib ptr, byval map as ubyte ptr, byval palette as clong ptr)
declare sub imDibEncodeFromRGBA(byval dib as imDib ptr, byval red as const ubyte ptr, byval green as const ubyte ptr, byval blue as const ubyte ptr, byval alpha as const ubyte ptr)
declare sub imDibEncodeFromMap(byval dib as imDib ptr, byval map as const ubyte ptr, byval palette as const clong ptr, byval palette_count as long)
declare sub imDibEncodeFromBitmap(byval dib as imDib ptr, byval data as const ubyte ptr)
declare sub imDibDecodeToBitmap(byval dib as const imDib ptr, byval data as ubyte ptr)
declare function imDibToImage(byval dib as const imDib ptr) as imImage ptr
declare function imDibFromImage(byval image as const imImage ptr) as imDib ptr
declare function imImageLoadFromResource(byval module as HMODULE, byval name as LPCTSTR, byval index as long, byval error as long ptr) as imImage ptr

end extern
