#Ifndef __wxstring_bi__
#Define __wxstring_bi__

#Include Once "common.bi"

Enum wxString_Encoding
  Encoding_UTF8
  Encoding_Local
End Enum

' class wxString
Declare Function wxString_ctorUTF8 WXCALL Alias "wxString_ctorUTF8" (buf  As ZString Ptr) As wxString Ptr
Declare Function wxString_ctorUTF16 WXCALL Alias "wxString_ctorUTF16" (buf  As wchar_t Ptr) As wxString Ptr
Declare Sub wxString_dtor WXCALL Alias "wxString_dtor" (self As wxString Ptr)
Declare Function wxString_Conversion WXCALL Alias "wxString_Conversion" (self As wxString Ptr) As wxWCharBuffer Ptr
Declare Function wxString_ConversionUTF8 WXCALL Alias "wxString_ConversionUTF8" (self As wxString Ptr) As wxWCharBuffer Ptr
Declare Function wxString_GetLength WXCALL Alias "wxString_GetLength" (self As wxString Ptr) As size_t
Declare Function wxString_CharAtUTF16 WXCALL Alias "wxString_CharAtUTF16" (self As wxString Ptr, index As size_t) As wchar_t

' class DisposableStringBox
Declare Function DisposableStringBox_CTor WXCALL Alias "DisposableStringBox_CTor" (pStr As wxString Ptr) As _DisposableStringBox Ptr
Declare Sub DisposableStringBox_RegisterDispose WXCALL Alias "DisposableStringBox_RegisterDispose" (self As _DisposableStringBox Ptr,on_dispose As Virtual_Dispose)

' class wxWCharBuffer
Declare Function wxWCharBuffer_ctorUTF8 WXCALL Alias "wxWCharBuffer_ctorUTF8" (buffer As wxChar Ptr) As wxWCharBuffer Ptr
Declare Function wxWCharBuffer_ctorUTF16 WXCALL Alias "wxWCharBuffer_ctorUTF16" (buffer As wxChar Ptr) As wxWCharBuffer Ptr
Declare Sub wxWCharBuffer_dtor WXCALL Alias "wxWCharBuffer_dtor" (self As wxWCharBuffer Ptr)
Declare Function wxWCharBuffer_IsEmpty WXCALL Alias "wxWCharBuffer_IsEmpty" (self As wxWCharBuffer Ptr) As wxBool
Declare Function wxWCharBuffer_GetLength WXCALL Alias "wxWCharBuffer_GetLength" (self As wxWCharBuffer Ptr) As size_t
Declare Function wxWCharBuffer_WideCharAt WXCALL Alias "wxWCharBuffer_WideCharAt" (self As wxWCharBuffer Ptr,index As size_t) As wchar_t

#EndIf ' __wxstring_bi__

