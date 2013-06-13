''
''
'' old_im -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __old_im_bi__
#define __old_im_bi__

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

declare function imEncodeColor cdecl alias "imEncodeColor" (byval red as ubyte, byval green as ubyte, byval blue as ubyte) as integer
declare sub imDecodeColor cdecl alias "imDecodeColor" (byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval palette as integer)
declare function imFileFormat cdecl alias "imFileFormat" (byval filename as zstring ptr, byval format as integer ptr) as integer
declare function imImageInfo cdecl alias "imImageInfo" (byval filename as zstring ptr, byval width as integer ptr, byval height as integer ptr, byval type as integer ptr, byval palette_count as integer ptr) as integer
declare function imLoadRGB cdecl alias "imLoadRGB" (byval filename as zstring ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr) as integer
declare function imSaveRGB cdecl alias "imSaveRGB" (byval width as integer, byval height as integer, byval format as integer, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval filename as zstring ptr) as integer
declare function imLoadMap cdecl alias "imLoadMap" (byval filename as zstring ptr, byval map as ubyte ptr, byval palette as integer ptr) as integer
declare function imSaveMap cdecl alias "imSaveMap" (byval width as integer, byval height as integer, byval format as integer, byval map as ubyte ptr, byval palette_count as integer, byval palette as integer ptr, byval filename as zstring ptr) as integer
declare sub imRGB2Map cdecl alias "imRGB2Map" (byval width as integer, byval height as integer, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval map as ubyte ptr, byval palette_count as integer, byval palette as integer ptr)
declare sub imMap2RGB cdecl alias "imMap2RGB" (byval width as integer, byval height as integer, byval map as ubyte ptr, byval palette_count as integer, byval colors as integer ptr, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr)
declare sub imRGB2Gray cdecl alias "imRGB2Gray" (byval width as integer, byval height as integer, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval map as ubyte ptr, byval grays as integer ptr)
declare sub imMap2Gray cdecl alias "imMap2Gray" (byval width as integer, byval height as integer, byval map as ubyte ptr, byval palette_count as integer, byval colors as integer ptr, byval grey_map as ubyte ptr, byval grays as integer ptr)
declare sub imResize cdecl alias "imResize" (byval src_width as integer, byval src_height as integer, byval src_map as ubyte ptr, byval dst_width as integer, byval dst_height as integer, byval dst_map as ubyte ptr)
declare sub imStretch cdecl alias "imStretch" (byval src_width as integer, byval src_height as integer, byval src_map as ubyte ptr, byval dst_width as integer, byval dst_height as integer, byval dst_map as ubyte ptr)

type imCallback as function cdecl(byval as zstring ptr) as integer

declare function imRegisterCallback cdecl alias "imRegisterCallback" (byval cb as imCallback, byval cb_id as integer, byval format as integer) as integer

#define IM_INTERRUPTED -1
#define IM_ALL -1
#define IM_COUNTER_CB 0

type imFileCounterCallback as function cdecl(byval as zstring ptr, byval as integer, byval as integer) as integer

#define IM_RESOLUTION_CB 1

type imResolutionCallback as function cdecl(byval as zstring ptr, byval as double ptr, byval as double ptr, byval as integer ptr) as integer

enum 
	IM_RES_NONE
	IM_RES_DPI
	IM_RES_DPC
end enum

#define IM_GIF_TRANSPARENT_COLOR_CB 0

type imGifTranspIndex as function cdecl(byval as zstring ptr, byval as ubyte ptr) as integer

#define IM_TIF_IMAGE_DESCRIPTION_CB 0

type imTiffImageDesc as function cdecl(byval as zstring ptr, byval as zstring ptr) as integer

#endif
