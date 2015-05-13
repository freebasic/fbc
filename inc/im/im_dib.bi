''
''
'' im_dib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_dib_bi__
#define __im_dib_bi__

type _imDib
	handle as HGLOBAL
	dib as BYTE ptr
	size as integer
	bmi as BITMAPINFO ptr
	bmih as BITMAPINFOHEADER ptr
	bmic as RGBQUAD ptr
	bits as BYTE ptr
	palette_count as integer
	bits_size as integer
	line_size as integer
	pad_size as integer
	is_reference as integer
end type

type imDib as _imDib

declare function imDibCreate cdecl alias "imDibCreate" (byval width as integer, byval height as integer, byval bpp as integer) as imDib ptr
declare function imDibCreateCopy cdecl alias "imDibCreateCopy" (byval dib as imDib ptr) as imDib ptr
declare function imDibCreateReference cdecl alias "imDibCreateReference" (byval bmi as BYTE ptr, byval bits as BYTE ptr) as imDib ptr
declare function imDibCreateSection cdecl alias "imDibCreateSection" (byval hDC as HDC, byval image as HBITMAP ptr, byval width as integer, byval height as integer, byval bpp as integer) as imDib ptr
declare sub imDibDestroy cdecl alias "imDibDestroy" (byval dib as imDib ptr)

type imDibLineGetPixel as function cdecl(byval as ubyte ptr, byval as integer) as uinteger

declare function imDibLineGetPixelFunc cdecl alias "imDibLineGetPixelFunc" (byval bpp as integer) as imDibLineGetPixel

type imDibLineSetPixel as sub cdecl(byval as ubyte ptr, byval as integer, byval as uinteger)

declare function imDibLineSetPixelFunc cdecl alias "imDibLineSetPixelFunc" (byval bpp as integer) as imDibLineSetPixel
declare function imDibFromHBitmap cdecl alias "imDibFromHBitmap" (byval image as HBITMAP, byval hPalette as HPALETTE) as imDib ptr
declare function imDibToHBitmap cdecl alias "imDibToHBitmap" (byval dib as imDib ptr) as HBITMAP
declare function imDibLogicalPalette cdecl alias "imDibLogicalPalette" (byval dib as imDib ptr) as HPALETTE
declare function imDibCaptureScreen cdecl alias "imDibCaptureScreen" (byval x as integer, byval y as integer, byval width as integer, byval height as integer) as imDib ptr
declare sub imDibCopyClipboard cdecl alias "imDibCopyClipboard" (byval dib as imDib ptr)
declare function imDibPasteClipboard cdecl alias "imDibPasteClipboard" () as imDib ptr
declare function imDibIsClipboardAvailable cdecl alias "imDibIsClipboardAvailable" () as integer
declare function imDibSaveFile cdecl alias "imDibSaveFile" (byval dib as imDib ptr, byval filename as zstring ptr) as integer
declare function imDibLoadFile cdecl alias "imDibLoadFile" (byval filename as zstring ptr) as imDib ptr
declare sub imDibDecodeToRGBA cdecl alias "imDibDecodeToRGBA" (byval dib as imDib ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval alpha as ubyte ptr)
declare sub imDibDecodeToMap cdecl alias "imDibDecodeToMap" (byval dib as imDib ptr, byval map as ubyte ptr, byval palette as integer ptr)
declare sub imDibEncodeFromRGBA cdecl alias "imDibEncodeFromRGBA" (byval dib as imDib ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval alpha as ubyte ptr)
declare sub imDibEncodeFromMap cdecl alias "imDibEncodeFromMap" (byval dib as imDib ptr, byval map as ubyte ptr, byval palette as integer ptr, byval palette_count as integer)
declare sub imDibEncodeFromBitmap cdecl alias "imDibEncodeFromBitmap" (byval dib as imDib ptr, byval data as ubyte ptr)
declare sub imDibDecodeToBitmap cdecl alias "imDibDecodeToBitmap" (byval dib as imDib ptr, byval data as ubyte ptr)

#endif
