#Ifndef __dataobject_bi__
#Define __dataobject_bi__

#Include Once "common.bi"

' class wxDataObject
Declare Sub wxDataObject_dtor WXCALL Alias "wxDataObject_dtor" (self As wxDataObject Ptr)
Declare Sub wxDataObject_GetPreferredFormat WXCALL Alias "wxDataObject_GetPreferredFormat" (self As wxDataObject Ptr, datadir As wxDataObjectDirection, datafmt As wxDataFormat Ptr)
Declare Function wxDataObject_GetFormatCount WXCALL Alias "wxDataObject_GetFormatCount" (self As wxDataObject Ptr, datadir As wxDataObjectDirection) As size_t
Declare Sub wxDataObject_GetAllFormats WXCALL Alias "wxDataObject_GetAllFormats" (self As wxDataObject Ptr, formats As wxDataFormat Ptr, datadir As wxDataObjectDirection)
Declare Function wxDataObject_GetDataSize WXCALL Alias "wxDataObject_GetDataSize" (self As wxDataObject Ptr, datafmt As wxDataFormat Ptr) As size_t 
Declare Function wxDataObject_GetDataHere WXCALL Alias "wxDataObject_GetDataHere" (self As wxDataObject Ptr, datafmt As wxDataFormat Ptr, pBuffer As Any Ptr) As wxBool
Declare Function wxDataObject_SetData WXCALL Alias "wxDataObject_SetData" (self As wxDataObject Ptr, datafmt As wxDataFormat Ptr, length As size_t, pBuffer As Any Ptr) As wxBool
Declare Function wxDataObject_IsSupported WXCALL Alias "wxDataObject_IsSupported" (self As wxDataObject Ptr, datafmt As wxDataFormat Ptr, datadir As wxDataObjectDirection) As wxBool

' class wxDataObjectSimple
Declare Function wxDataObjectSimple_ctor WXCALL Alias "wxDataObjectSimple_ctor" (datafmt As wxDataFormat Ptr) As wxDataObjectSimple Ptr
Declare Sub wxDataObjectSimple_dtor WXCALL Alias "wxDataObjectSimple_dtor" (self As wxDataObjectSimple Ptr)
Declare Sub wxDataObjectSimple_SetFormat WXCALL Alias "wxDataObjectSimple_SetFormat" (self As wxDataObjectSimple Ptr, datafmt As wxDataFormat Ptr)
Declare Function wxDataObjectSimple_GetDataSize WXCALL Alias "wxDataObjectSimple_GetDataSize" (self As wxDataObjectSimple Ptr) As size_t
Declare Function wxDataObjectSimple_GetDataHere WXCALL Alias "wxDataObjectSimple_GetDataHere" (self As wxDataObjectSimple Ptr, pBuffer As Any Ptr) As wxBool
Declare Function wxDataObjectSimple_SetData WXCALL Alias "wxDataObjectSimple_SetData" (self As wxDataObjectSimple Ptr, length As size_t, pBuffer As Any Ptr) As wxBool

' class wxTextDataObject
Declare Function wxTextDataObject_ctor WXCALL Alias "wxTextDataObject_ctor" (self As wxString Ptr) As wxTextDataObject Ptr
Declare Sub wxTextDataObject_dtor WXCALL Alias "wxTextDataObject_dtor" (self As wxTextDataObject Ptr)
Declare Sub wxTextDataObject_RegisterDisposable WXCALL Alias "wxTextDataObject_RegisterDisposable" (self As wxTextDataObject Ptr, on_dispose As Virtual_Dispose)
Declare Function wxTextDataObject_GetTextLength WXCALL Alias "wxTextDataObject_GetTextLength" (self As wxTextDataObject Ptr) As size_t
Declare Function wxTextDataObject_GetText WXCALL Alias "wxTextDataObject_GetText" (self As wxTextDataObject Ptr) As wxString Ptr
Declare Sub wxTextDataObject_SetText WXCALL Alias "wxTextDataObject_SetText" (self As wxTextDataObject Ptr, txt As wxString Ptr)

' class wxFileDataObject
Declare Function wxFileDataObject_ctor WXCALL Alias "wxFileDataObject_ctor" () As wxFileDataObject Ptr
Declare Sub wxFileDataObject_dtor WXCALL Alias "wxFileDataObject_dtor" (self As wxFileDataObject Ptr)
Declare Sub wxFileDataObject_RegisterDisposable WXCALL Alias "wxFileDataObject_RegisterDisposable" (self As wxFileDataObject Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxFileDataObject_AddFile WXCALL Alias "wxFileDataObject_AddFile" (self As wxFileDataObject Ptr, filename As wxString Ptr)
Declare Function wxFileDataObject_GetFilenames WXCALL Alias "wxFileDataObject_GetFilenames" (self As wxFileDataObject Ptr) As wxArrayString Ptr

' class wxDataObjectComposite
Declare Function wxDataObjectComposite_ctor WXCALL Alias "wxDataObjectComposite_ctor" () As wxDataObjectComposite Ptr
Declare Sub wxDataObjectComposite_RegisterDisposable WXCALL Alias "wxDataObjectComposite_RegisterDisposable" (self As wxDataObjectComposite Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxDataObjectComposite_Add WXCALL Alias "wxDataObjectComposite_Add" (self As wxDataObjectComposite Ptr, obj As wxDataObjectSimple Ptr, preferred As wxBool)
Declare Function wxDataObjectComposite_GetReceivedFormat WXCALL Alias "wxDataObjectComposite_GetReceivedFormat" (self As wxDataObjectComposite Ptr) As wxDataFormat Ptr

' class wxBitmapDataObject
Declare Function wxBitmapDataObject_ctor WXCALL Alias "wxBitmapDataObject_ctor" (bitmap As wxBitmap Ptr) As wxBitmapDataObject Ptr
Declare Sub wxBitmapDataObject_RegisterDisposable WXCALL Alias "wxBitmapDataObject_RegisterDisposable" (self As wxBitmapDataObject Ptr, on_dispose As Virtual_Dispose)
Declare Function wxBitmapDataObject_GetBitmap WXCALL Alias "wxBitmapDataObject_GetBitmap" (self As wxBitmapDataObject Ptr) As wxBitmap Ptr
Declare Sub wxBitmapDataObject_SetBitmap WXCALL Alias "wxBitmapDataObject_SetBitmap" (self As wxBitmapDataObject Ptr, bitmap As wxBitmap Ptr)

#EndIf ' __dataobject_bi__

