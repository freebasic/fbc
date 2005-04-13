''
''
'' image -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __image_bi__
#define __image_bi__

#include once "wx-c/wx.bi"

declare function wxImage cdecl alias "wxImage_ctor" () as wxImage ptr
declare function wxImage_ctorByName cdecl alias "wxImage_ctorByName" (byval name as string, byval type as integer) as wxImage ptr
declare function wxImage_ctorintintbool cdecl alias "wxImage_ctorintintbool" (byval width as integer, byval height as integer, byval clear as integer) as wxImage ptr
declare function wxImage_ctorByImage cdecl alias "wxImage_ctorByImage" (byval image as wxImage ptr) as wxImage ptr
declare sub wxImage_dtor cdecl alias "wxImage_dtor" (byval self as wxImage ptr)
declare sub wxImage_Destroy cdecl alias "wxImage_Destroy" (byval self as wxImage ptr)
declare function wxImage_GetHeight cdecl alias "wxImage_GetHeight" (byval self as wxImage ptr) as integer
declare function wxImage_GetWidth cdecl alias "wxImage_GetWidth" (byval self as wxImage ptr) as integer
declare sub wxImage_InitAllHandlers cdecl alias "wxImage_InitAllHandlers" ()
declare function wxImage_LoadFileByTypeId cdecl alias "wxImage_LoadFileByTypeId" (byval self as wxImage ptr, byval name as string, byval type as integer, byval index as integer) as integer
declare function wxImage_LoadFileByMimeTypeId cdecl alias "wxImage_LoadFileByMimeTypeId" (byval self as wxImage ptr, byval name as string, byval mimetype as string, byval index as integer) as integer
declare function wxImage_SaveFileByType cdecl alias "wxImage_SaveFileByType" (byval self as wxImage ptr, byval name as string, byval type as integer) as integer
declare function wxImage_SaveFileByMimeType cdecl alias "wxImage_SaveFileByMimeType" (byval self as wxImage ptr, byval name as string, byval mimetype as string) as integer
declare function wxImage_Rescale cdecl alias "wxImage_Rescale" (byval self as wxImage ptr, byval width as integer, byval height as integer) as wxImage ptr
declare function wxImage_Scale cdecl alias "wxImage_Scale" (byval self as wxImage ptr, byval width as integer, byval height as integer) as wxImage ptr
declare sub wxImage_SetMaskColour cdecl alias "wxImage_SetMaskColour" (byval self as wxImage ptr, byval r as ubyte, byval g as ubyte, byval b as ubyte)
declare sub wxImage_SetMask cdecl alias "wxImage_SetMask" (byval self as wxImage ptr, byval mask as integer)
declare function wxImage_HasMask cdecl alias "wxImage_HasMask" (byval self as wxImage ptr) as integer
declare function wxImage_Copy cdecl alias "wxImage_Copy" (byval self as wxImage ptr) as wxImage ptr
declare function wxImage_GetSubImage cdecl alias "wxImage_GetSubImage" (byval self as wxImage ptr, byval rect as wxRect ptr) as wxImage ptr
declare sub wxImage_Paste cdecl alias "wxImage_Paste" (byval self as wxImage ptr, byval image as wxImage ptr, byval x as integer, byval y as integer)
declare function wxImage_ShrinkBy cdecl alias "wxImage_ShrinkBy" (byval self as wxImage ptr, byval xFactor as integer, byval yFactor as integer) as wxImage ptr
declare function wxImage_Rotate cdecl alias "wxImage_Rotate" (byval self as wxImage ptr, byval angle as double, byval centre_of_rotation as wxPoint ptr, byval interpolating as integer, byval offset_after_rotation as wxPoint ptr) as wxImage ptr
declare function wxImage_Rotate90 cdecl alias "wxImage_Rotate90" (byval self as wxImage ptr, byval clockwise as integer) as wxImage ptr
declare function wxImage_Mirror cdecl alias "wxImage_Mirror" (byval self as wxImage ptr, byval horizontally as integer) as wxImage ptr
declare sub wxImage_Replace cdecl alias "wxImage_Replace" (byval self as wxImage ptr, byval r1 as ubyte, byval g1 as ubyte, byval b1 as ubyte, byval r2 as ubyte, byval g2 as ubyte, byval b2 as ubyte)
declare function wxImage_ConvertToMono cdecl alias "wxImage_ConvertToMono" (byval self as wxImage ptr, byval r as ubyte, byval g as ubyte, byval b as ubyte) as wxImage ptr
declare sub wxImage_SetRGB cdecl alias "wxImage_SetRGB" (byval self as wxImage ptr, byval x as integer, byval y as integer, byval r as ubyte, byval g as ubyte, byval b as ubyte)
declare function wxImage_GetRed cdecl alias "wxImage_GetRed" (byval self as wxImage ptr, byval x as integer, byval y as integer) as ubyte
declare function wxImage_GetGreen cdecl alias "wxImage_GetGreen" (byval self as wxImage ptr, byval x as integer, byval y as integer) as ubyte
declare function wxImage_GetBlue cdecl alias "wxImage_GetBlue" (byval self as wxImage ptr, byval x as integer, byval y as integer) as ubyte
declare sub wxImage_SetAlpha cdecl alias "wxImage_SetAlpha" (byval self as wxImage ptr, byval x as integer, byval y as integer, byval alpha as ubyte)
declare function wxImage_GetAlpha cdecl alias "wxImage_GetAlpha" (byval self as wxImage ptr, byval x as integer, byval y as integer) as ubyte
declare function wxImage_FindFirstUnusedColour cdecl alias "wxImage_FindFirstUnusedColour" (byval self as wxImage ptr, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval startR as ubyte, byval startG as ubyte, byval startB as ubyte) as integer
declare function wxImage_SetMaskFromImage cdecl alias "wxImage_SetMaskFromImage" (byval self as wxImage ptr, byval mask as wxImage ptr, byval mr as ubyte, byval mg as ubyte, byval mb as ubyte) as integer
declare function wxImage_ConvertAlphaToMask cdecl alias "wxImage_ConvertAlphaToMask" (byval self as wxImage ptr, byval threshold as ubyte) as integer
declare function wxImage_CanRead cdecl alias "wxImage_CanRead" (byval name as string) as integer
declare function wxImage_GetImageCount cdecl alias "wxImage_GetImageCount" (byval name as string, byval type as integer) as integer
declare function wxImage_Ok cdecl alias "wxImage_Ok" (byval self as wxImage ptr) as integer
declare function wxImage_GetMaskRed cdecl alias "wxImage_GetMaskRed" (byval self as wxImage ptr) as ubyte
declare function wxImage_GetMaskGreen cdecl alias "wxImage_GetMaskGreen" (byval self as wxImage ptr) as ubyte
declare function wxImage_GetMaskBlue cdecl alias "wxImage_GetMaskBlue" (byval self as wxImage ptr) as ubyte
declare function wxImage_HasPalette cdecl alias "wxImage_HasPalette" (byval self as wxImage ptr) as integer
declare function wxImage_GetPalette cdecl alias "wxImage_GetPalette" (byval self as wxImage ptr) as wxPalette ptr
declare sub wxImage_SetPalette cdecl alias "wxImage_SetPalette" (byval self as wxImage ptr, byval palette as wxPalette ptr)
declare sub wxImage_SetOption cdecl alias "wxImage_SetOption" (byval self as wxImage ptr, byval name as string, byval value as string)
declare sub wxImage_SetOption2 cdecl alias "wxImage_SetOption2" (byval self as wxImage ptr, byval name as string, byval value as integer)
declare function wxImage_GetOption cdecl alias "wxImage_GetOption" (byval self as wxImage ptr, byval name as string) as wxString ptr
declare function wxImage_GetOptionInt cdecl alias "wxImage_GetOptionInt" (byval self as wxImage ptr, byval name as string) as integer
declare function wxImage_HasOption cdecl alias "wxImage_HasOption" (byval self as wxImage ptr, byval name as string) as integer
declare function wxImage_CountColours cdecl alias "wxImage_CountColours" (byval self as wxImage ptr, byval stopafter as uinteger) as uinteger
declare function wxImage_ComputeHistogram cdecl alias "wxImage_ComputeHistogram" (byval self as wxImage ptr, byval h as wxImageHistogram ptr) as uinteger
declare function wxImage_GetHandlers cdecl alias "wxImage_GetHandlers" () as wxList ptr
declare sub wxImage_AddHandler cdecl alias "wxImage_AddHandler" (byval handler as wxImageHandler ptr)
declare sub wxImage_InsertHandler cdecl alias "wxImage_InsertHandler" (byval handler as wxImageHandler ptr)
declare function wxImage_RemoveHandler cdecl alias "wxImage_RemoveHandler" (byval name as string) as integer
declare function wxImage_FindHandler cdecl alias "wxImage_FindHandler" (byval name as string) as wxImageHandler ptr
declare function wxImage_FindHandler2 cdecl alias "wxImage_FindHandler2" (byval name as string, byval imageType as integer) as wxImageHandler ptr
declare function wxImage_FindHandler3 cdecl alias "wxImage_FindHandler3" (byval imageType as integer) as wxImageHandler ptr
declare function wxImage_FindHandlerMime cdecl alias "wxImage_FindHandlerMime" (byval mimetype as string) as wxImageHandler ptr
declare function wxImage_GetImageExtWildcard cdecl alias "wxImage_GetImageExtWildcard" () as wxString ptr
declare sub wxImage_CleanUpHandlers cdecl alias "wxImage_CleanUpHandlers" ()
declare sub wxImage_InitStandardHandlers cdecl alias "wxImage_InitStandardHandlers" ()
declare sub wxImageHandler_SetName cdecl alias "wxImageHandler_SetName" (byval self as wxImageHandler ptr, byval name as string)
declare sub wxImageHandler_SetExtension cdecl alias "wxImageHandler_SetExtension" (byval self as wxImageHandler ptr, byval ext as string)
declare sub wxImageHandler_SetType cdecl alias "wxImageHandler_SetType" (byval self as wxImageHandler ptr, byval type as integer)
declare sub wxImageHandler_SetMimeType cdecl alias "wxImageHandler_SetMimeType" (byval self as wxImageHandler ptr, byval type as string)
declare function wxImageHandler_GetName cdecl alias "wxImageHandler_GetName" (byval self as wxImageHandler ptr) as wxString ptr
declare function wxImageHandler_GetExtension cdecl alias "wxImageHandler_GetExtension" (byval self as wxImageHandler ptr) as wxString ptr
declare function wxImageHandler_GetType cdecl alias "wxImageHandler_GetType" (byval self as wxImageHandler ptr) as integer
declare function wxImageHandler_GetMimeType cdecl alias "wxImageHandler_GetMimeType" (byval self as wxImageHandler ptr) as wxString ptr
declare function wxImageHistogramEntry cdecl alias "wxImageHistogramEntry_ctor" () as wxImageHistogramEntry ptr
declare sub wxImageHistogramEntry_dtor cdecl alias "wxImageHistogramEntry_dtor" (byval self as wxImageHistogramEntry ptr)
declare function wxImageHistogramEntry_index cdecl alias "wxImageHistogramEntry_index" (byval self as wxImageHistogramEntry ptr) as uinteger
declare sub wxImageHistogramEntry_Setindex cdecl alias "wxImageHistogramEntry_Setindex" (byval self as wxImageHistogramEntry ptr, byval v as uinteger)
declare function wxImageHistogramEntry_value cdecl alias "wxImageHistogramEntry_value" (byval self as wxImageHistogramEntry ptr) as uinteger
declare sub wxImageHistogramEntry_Setvalue cdecl alias "wxImageHistogramEntry_Setvalue" (byval self as wxImageHistogramEntry ptr, byval v as uinteger)
declare function wxImageHistogram cdecl alias "wxImageHistogram_ctor" () as wxImageHistogram ptr
declare sub wxImageHistogram_dtor cdecl alias "wxImageHistogram_dtor" (byval self as wxImageHistogram ptr)
declare function wxImageHistogram_MakeKey cdecl alias "wxImageHistogram_MakeKey" (byval r as ubyte, byval g as ubyte, byval b as ubyte) as uinteger
declare function wxImageHistogram_FindFirstUnusedColour cdecl alias "wxImageHistogram_FindFirstUnusedColour" (byval self as wxImageHistogram ptr, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval startR as ubyte, byval startG as ubyte, byval startB as ubyte) as integer

#endif
