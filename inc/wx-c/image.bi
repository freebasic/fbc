#Ifndef __image_bi__
#Define __image_bi__

#Include Once "common.bi"


Declare Sub wxImage_InitAllHandlers WXCALL Alias "wxImage_InitAllHandlers" ()
Declare Sub wxImage_InitStandardHandlers WXCALL Alias "wxImage_InitStandardHandlers" ()
Declare Sub wxImage_CleanUpHandlers WXCALL Alias "wxImage_CleanUpHandlers" ()
Declare Function wxImage_GetFirstHandlerNode WXCALL Alias "wxImage_GetFirstHandlerNode" () As wxNode Ptr
Declare Function wxNode_GetData WXCALL Alias "wxNode_GetData" (node As wxNode Ptr) As wxObject Ptr
Declare Function wxNode_GetNext WXCALL Alias "wxNode_GetNext" (node As wxNode Ptr) As wxNode Ptr
Declare Function wxNode_GetPrevious WXCALL Alias "wxNode_GetPrevious" (node As wxNode Ptr) As wxNode Ptr
Declare Sub wxImage_AddHandler WXCALL Alias "wxImage_AddHandler" (handler As wxImageHandler Ptr)
Declare Sub wxImage_InsertHandler WXCALL Alias "wxImage_InsertHandler" (handler As wxImageHandler Ptr)
Declare Function wxImage_RemoveHandler WXCALL Alias "wxImage_RemoveHandler" (nam As wxString Ptr) As wxBool
Declare Function wxImage_GetImageExtWildcard WXCALL Alias "wxImage_GetImageExtWildcard" () As wxString Ptr 

' class wxImage
Declare Function wxImage_ctor WXCALL Alias "wxImage_ctor" () As wxImage Ptr
Declare Function wxImage_ctorByName WXCALL Alias "wxImage_ctorByName" (nam As wxString Ptr, typ As wxInt) As wxImage Ptr
Declare Function wxImage_ctorByByteArray WXCALL Alias "wxImage_ctorByByteArray" (pData As wxChar Ptr, length As wxInt, typ As wxInt) As wxImage Ptr
Declare Function wxImage_ctorintintbool WXCALL Alias "wxImage_ctorintintbool" (w As wxInt, h As wxInt, DoClear As wxBool) As wxImage Ptr
Declare Function wxImage_ctorByImage WXCALL Alias "wxImage_ctorByImage" (image As wxImage Ptr) As wxImage Ptr
Declare Sub wxImage_dtor WXCALL Alias "wxImage_dtor" (self As wxImage Ptr)
Declare Sub wxImage_Destroy WXCALL Alias "wxImage_Destroy" (self As wxImage Ptr)
Declare Function wxImage_GetHeight WXCALL Alias "wxImage_GetHeight" (self As wxImage Ptr) As wxInt
Declare Function wxImage_GetWidth WXCALL Alias "wxImage_GetWidth" (self As wxImage Ptr) As wxInt
Declare Function wxImage_LoadFileByTypeId WXCALL Alias "wxImage_LoadFileByTypeId" (self As wxImage Ptr, nam As wxString Ptr, typ As wxInt, ind As wxInt) As wxBool
Declare Function wxImage_LoadFileByMimeTypeId WXCALL Alias "wxImage_LoadFileByMimeTypeId" (self As wxImage Ptr, nam As wxString Ptr, mimetyp As wxString Ptr, ind As wxInt) As wxBool
Declare Function wxImage_SaveFileByType WXCALL Alias "wxImage_SaveFileByType" (self As wxImage Ptr, nam As wxString Ptr, typ As wxInt) As wxBool
Declare Function wxImage_SaveFileByMimeType WXCALL Alias "wxImage_SaveFileByMimeType" (self As wxImage Ptr, nam As wxString Ptr, mimetyp As wxString Ptr) As wxBool
Declare Function wxImage_Rescale WXCALL Alias "wxImage_Rescale" (self As wxImage Ptr, w As wxInt, h As wxInt) As wxImage Ptr
Declare Function wxImage_Scale WXCALL Alias "wxImage_Scale" (self As wxImage Ptr, w As wxInt, h As wxInt) As wxImage Ptr
Declare Sub wxImage_SetMaskColour WXCALL Alias "wxImage_SetMaskColour" (self As wxImage Ptr, r As wxChar, g As wxChar, b As wxChar)
Declare Sub wxImage_SetMask WXCALL Alias "wxImage_SetMask" (self As wxImage Ptr, mask As wxBool)
Declare Function wxImage_HasMask WXCALL Alias "wxImage_HasMask" (self As wxImage Ptr) As wxBool
Declare Function wxImage_Copy WXCALL Alias "wxImage_Copy" (self As wxImage Ptr) As wxImage Ptr
Declare Function wxImage_GetSubImage WXCALL Alias "wxImage_GetSubImage" (self As wxImage Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt) As wxImage Ptr
Declare Sub wxImage_Paste WXCALL Alias "wxImage_Paste" (self As wxImage Ptr, image As wxImage Ptr, x As wxInt, y As wxInt)
Declare Function wxImage_ShrinkBy WXCALL Alias "wxImage_ShrinkBy" (self As wxImage Ptr, xFactor As wxInt, yFactor As wxInt) As wxImage Ptr
Declare Function wxImage_Rotate WXCALL Alias "wxImage_Rotate" (self As wxImage Ptr, angle As wxDouble, centre_of_rotation As wxPoint Ptr, interpolating As wxBool, offset_after_rotation As wxPoint Ptr) As wxImage Ptr
Declare Function wxImage_Rotate90 WXCALL Alias "wxImage_Rotate90" (self As wxImage Ptr, clockwise As wxBool) As wxImage Ptr
Declare Function wxImage_Mirror WXCALL Alias "wxImage_Mirror" (self As wxImage Ptr, horizontally As wxBool) As wxImage Ptr
Declare Sub wxImage_Replace WXCALL Alias "wxImage_Replace" (self As wxImage Ptr, r1 As wxChar, g1 As wxChar, b1 As wxChar, r2 As wxChar, g2 As wxChar, b2 As wxChar)
Declare Function wxImage_ConvertToMono WXCALL Alias "wxImage_ConvertToMono" (self As wxImage Ptr, r As wxChar, g As wxChar, b As wxChar) As wxImage Ptr
Declare Sub wxImage_SetRGB WXCALL Alias "wxImage_SetRGB" (self As wxImage Ptr, x As wxInt, y As wxInt, r As wxChar, g As wxChar, b As wxChar)
Declare Function wxImage_GetRed WXCALL Alias "wxImage_GetRed" (self As wxImage Ptr, x As wxInt, y As wxInt) As wxChar
Declare Function wxImage_GetGreen WXCALL Alias "wxImage_GetGreen" (self As wxImage Ptr, x As wxInt, y As wxInt) As wxChar
Declare Function wxImage_GetBlue WXCALL Alias "wxImage_GetBlue" (self As wxImage Ptr, x As wxInt, y As wxInt) As wxChar
Declare Sub wxImage_SetAlpha WXCALL Alias "wxImage_SetAlpha" (self As wxImage Ptr, x As wxInt, y As wxInt, a As wxChar)
Declare Function wxImage_GetAlpha WXCALL Alias "wxImage_GetAlpha" (self As wxImage Ptr, x As wxInt, y As wxInt) As wxChar
Declare Function wxImage_FindFirstUnusedColour WXCALL Alias "wxImage_FindFirstUnusedColour" (self As wxImage Ptr, r As wxChar Ptr, g As wxChar Ptr, b As wxChar Ptr, startR As wxChar, startG As wxChar, startB As wxChar) As wxBool
Declare Function wxImage_SetMaskFromImage WXCALL Alias "wxImage_SetMaskFromImage" (self As wxImage Ptr, mask As wxImage Ptr, r As wxChar, g As wxChar, b As wxChar) As wxBool
Declare Function wxImage_ConvertAlphaToMask WXCALL Alias "wxImage_ConvertAlphaToMask" (self As wxImage Ptr, threshold As wxChar) As wxBool
Declare Function wxImage_CanRead WXCALL Alias "wxImage_CanRead" (nam As wxString Ptr) As wxBool
Declare Function wxImage_GetImageCount WXCALL Alias "wxImage_GetImageCount" (nam As wxString Ptr, typ As wxInt) As wxInt
Declare Function wxImage_Ok WXCALL Alias "wxImage_Ok" (self As wxImage Ptr) As wxBool
Declare Function wxImage_GetMaskRed WXCALL Alias "wxImage_GetMaskRed" (self As wxImage Ptr) As wxBool
Declare Function wxImage_GetMaskGreen WXCALL Alias "wxImage_GetMaskGreen" (self As wxImage Ptr) As wxBool
Declare Function wxImage_GetMaskBlue WXCALL Alias "wxImage_GetMaskBlue" (self As wxImage Ptr) As wxBool
Declare Function wxImage_HasPalette WXCALL Alias "wxImage_HasPalette" (self As wxImage Ptr) As wxBool
Declare Function wxImage_GetPalette WXCALL Alias "wxImage_GetPalette" (self As wxImage Ptr) As wxPalette Ptr
Declare Sub wxImage_SetPalette WXCALL Alias "wxImage_SetPalette" (self As wxImage Ptr, pal As wxPalette Ptr)
Declare Sub wxImage_SetOption WXCALL Alias "wxImage_SetOption" (self As wxImage Ptr, nam As wxString Ptr, value As wxString Ptr)
Declare Sub wxImage_SetOption2 WXCALL Alias "wxImage_SetOption2" (self As wxImage Ptr, nam As wxString Ptr, value As wxInt)
Declare Function wxImage_GetOption WXCALL Alias "wxImage_GetOption" (self As wxImage Ptr, nam As wxString Ptr) As wxString Ptr
Declare Function wxImage_GetOptionInt WXCALL Alias "wxImage_GetOptionInt" (self As wxImage Ptr, nam As wxString Ptr) As wxInt
Declare Function wxImage_HasOption WXCALL Alias "wxImage_HasOption" (self As wxImage Ptr, nam As wxString Ptr) As wxBool
Declare Function wxImage_CountColours WXCALL Alias "wxImage_CountColours" (self As wxImage Ptr, stopafter As wxUint) As wxUInt

' class wxImageHandler
Declare Function wxImage_FindHandler WXCALL Alias "wxImage_FindHandler" (nam As wxString Ptr) As wxImageHandler Ptr
Declare Function wxImage_FindHandler2 WXCALL Alias "wxImage_FindHandler2" (nam As wxString Ptr, imageType As wxInt) As wxImageHandler Ptr
Declare Function wxImage_FindHandler3 WXCALL Alias "wxImage_FindHandler3" (imageType As wxInt) As wxImageHandler Ptr
Declare Function wxImage_FindHandlerMime WXCALL Alias "wxImage_FindHandlerMime" (mimetyp As wxString Ptr) As wxImageHandler Ptr
Declare Sub wxImageHandler_SetName WXCALL Alias "wxImageHandler_SetName" (self As wxImageHandler Ptr, nam As wxString Ptr)
Declare Function wxImageHandler_GetName WXCALL Alias "wxImageHandler_GetName" (self As wxImageHandler Ptr) As wxString Ptr
Declare Sub wxImageHandler_SetExtension WXCALL Alias "wxImageHandler_SetExtension" (self As wxImageHandler Ptr, ext As wxString Ptr)
Declare Function wxImageHandler_GetExtension WXCALL Alias "wxImageHandler_GetExtension" (self As wxImageHandler Ptr) As wxString Ptr
Declare Sub wxImageHandler_SetType WXCALL Alias "wxImageHandler_SetType" (self As wxImageHandler Ptr, typ As wxInt)
Declare Function wxImageHandler_GetType WXCALL Alias "wxImageHandler_GetType" (self As wxImageHandler Ptr) As wxInt
Declare Sub wxImageHandler_SetMimeType WXCALL Alias "wxImageHandler_SetMimeType" (self As wxImageHandler Ptr, typ As wxString Ptr)
Declare Function wxImageHandler_GetMimeType WXCALL Alias "wxImageHandler_GetMimeType" (self As wxImageHandler Ptr) As wxString Ptr
Declare Function wxImageHandler_CanReadFilename WXCALL Alias "wxImageHandler_CanReadFilename" (self As wxImageHandler Ptr, filename As wxString Ptr) As wxBool
Declare Function wxImageHandler_CanReadBuffer WXCALL Alias "wxImageHandler_CanReadBuffer" (self As wxImageHandler Ptr, bytestring As wxChar Ptr , size As size_t) As wxBool

' class wxImageHistogramEntry
Declare Function wxImageHistogramEntry_ctor WXCALL Alias "wxImageHistogramEntry_ctor" () As wxImageHistogramEntry Ptr
Declare Sub wxImageHistogramEntry_dtor WXCALL Alias "wxImageHistogramEntry_dtor" (self As wxImageHistogramEntry Ptr)
Declare Function wxImageHistogramEntry_index WXCALL Alias "wxImageHistogramEntry_index" (self As wxImageHistogramEntry Ptr) As wxUInt
Declare Sub wxImageHistogramEntry_Setindex WXCALL Alias "wxImageHistogramEntry_Setindex" (self As wxImageHistogramEntry Ptr, v As wxUInt)
Declare Function wxImageHistogramEntry_value WXCALL Alias "wxImageHistogramEntry_value" (self As wxImageHistogramEntry Ptr) As wxUInt
Declare Sub wxImageHistogramEntry_Setvalue WXCALL Alias "wxImageHistogramEntry_Setvalue" (self As wxImageHistogramEntry Ptr, v As wxUInt)

' clas wxImageHistogram
Declare Function wxImageHistogram_MakeKey WXCALL Alias "wxImageHistogram_MakeKey" (r As wxChar, g As wxChar, b As wxChar) As wxUInt
Declare Function wxImageHistogram_ctor WXCALL Alias "wxImageHistogram_ctor" () As wxImageHistogram Ptr
Declare Sub wxImageHistogram_dtor WXCALL Alias "wxImageHistogram_dtor" (self As wxImageHistogram Ptr)
Declare Function wxImage_ComputeHistogram WXCALL Alias "wxImage_ComputeHistogram" (self As wxImage Ptr, h As wxImageHistogram Ptr) As wxUInt
Declare Function wxImageHistogram_FindFirstUnusedColour WXCALL Alias "wxImageHistogram_FindFirstUnusedColour" (self As wxImageHistogram Ptr, r As wxChar Ptr, g As wxChar Ptr, b As wxChar Ptr, startR As wxChar, startG As wxChar, startB As wxChar) As wxBool

#EndIf ' __image_bi__

