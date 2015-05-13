#Ifndef __fontmisc_bi__
#Define __fontmisc_bi__

#Include Once "common.bi"

Type Virtual_EnumerateFacenames As Function WXCALL (enc       As wxFontEncoding, b As wxBool) As wxBool
Type Virtual_EnumerateEncodings As Function WXCALL (facename  As wxString Ptr) As wxBool
Type Virtual_OnFacename         As Function WXCALL (facename  As wxString Ptr) As wxBool
Type Virtual_OnFontEncoding     As Function WXCALL (facename  As wxString Ptr, enc  As wxString Ptr) As wxBool

' class wxFontMapper
Declare Function wxFontMapper_ctor WXCALL Alias "wxFontMapper_ctor" () As wxFontMapper Ptr
Declare Sub wxFontMapper_dtor WXCALL Alias "wxFontMapper_dtor" (self As wxFontMapper Ptr)
Declare Function wxFontMapper_Get WXCALL Alias "wxFontMapper_Get" () As wxFontMapper Ptr
Declare Function wxFontMapper_Set WXCALL Alias "wxFontMapper_Set" (mapper As wxFontMapper Ptr) As wxFontMapper Ptr
Declare Function wxFontMapper_GetSupportedEncodingsCount WXCALL Alias "wxFontMapper_GetSupportedEncodingsCount" () As size_t
Declare Function wxFontMapper_GetEncoding WXCALL Alias "wxFontMapper_GetEncoding" (n As size_t) As wxFontEncoding
Declare Function wxFontMapper_GetEncodingName WXCALL Alias "wxFontMapper_GetEncodingName" (enc As wxFontEncoding) As wxString Ptr
Declare Function wxFontMapper_GetEncodingFromName WXCALL Alias "wxFontMapper_GetEncodingFromName" (nameArg As wxString Ptr) As wxFontEncoding
Declare Function wxFontMapper_CharsetToEncoding WXCALL Alias "wxFontMapper_CharsetToEncoding" (self As wxFontMapper Ptr, charset As wxString Ptr, interactive As wxBool) As wxFontEncoding
Declare Function wxFontMapper_IsEncodingAvailable WXCALL Alias "wxFontMapper_IsEncodingAvailable" (self As wxFontMapper Ptr, enc As wxFontEncoding, facename As wxString Ptr) As wxBool 
Declare Function wxFontMapper_GetAltForEncoding WXCALL Alias "wxFontMapper_GetAltForEncoding" (self As wxFontMapper Ptr, enc As wxFontEncoding, alt_enc As wxFontEncoding, facename As wxString Ptr, interactive As wxBool) As wxBool
Declare Function wxFontMapper_GetEncodingDescription WXCALL Alias "wxFontMapper_GetEncodingDescription" (enc As wxFontEncoding) As wxString Ptr
Declare Sub wxFontMapper_SetDialogParent WXCALL Alias "wxFontMapper_SetDialogParent" (self As wxFontMapper Ptr, parent As wxWindow Ptr)
Declare Sub wxFontMapper_SetDialogTitle WXCALL Alias "wxFontMapper_SetDialogTitle" (self As wxFontMapper Ptr, title As wxString Ptr)

' class wxEncodingConverter
Declare Function wxEncodingConverter_ctor WXCALL Alias "wxEncodingConverter_ctor" () As wxEncodingConverter Ptr
Declare Function wxEncodingConverter_Init WXCALL Alias "wxEncodingConverter_Init" (self As wxEncodingConverter Ptr, in_enc As wxFontEncoding, out_enc As wxFontEncoding, method As wxInt) As wxBool
Declare Function wxEncodingConverter_Convert WXCALL Alias "wxEncodingConverter_Convert" (self As wxEncodingConverter Ptr, in As wxString Ptr) As wxString Ptr

' class wxFontEnumerator
Declare Function wxFontEnumerator_ctor WXCALL Alias "wxFontEnumerator_ctor" () As wxFontEnumerator Ptr
Declare Sub wxFontEnumerator_dtor WXCALL Alias "wxFontEnumerator_dtor" (self As wxFontEnumerator Ptr)
Declare Sub wxFontEnumerator_RegisterVirtual WXCALL Alias "wxFontEnumerator_RegisterVirtual" ( _
									  self            As wxFontEnumerator Ptr, _
                                      on_Dispose      As Virtual_Dispose, _
                                      fEnumFaceNames  As Virtual_EnumerateFacenames, _
                                      fEnumEncodings  As Virtual_EnumerateEncodings, _
                                      on_Facename     As Virtual_OnFacename, _
                                      on_FontEncoding As Virtual_OnFontEncoding)
Declare Function wxFontEnumerator_GetFacenames WXCALL Alias "wxFontEnumerator_GetFacenames" (self As wxFontEnumerator Ptr) As wxArrayString Ptr
Declare Function wxFontEnumerator_GetEncodings WXCALL Alias "wxFontEnumerator_GetEncodings" (self As wxFontEnumerator Ptr) As wxArrayString Ptr
Declare Function wxFontEnumerator_OnFacename WXCALL Alias "wxFontEnumerator_OnFacename" (self As wxFontEnumerator Ptr, facename As wxString Ptr) As wxBool
Declare Function wxFontEnumerator_OnFontEncoding WXCALL Alias "wxFontEnumerator_OnFontEncoding" (self As wxFontEnumerator Ptr, facename As wxString Ptr, enc As wxString Ptr) As wxBool
Declare Function wxFontEnumerator_EnumerateFacenames WXCALL Alias "wxFontEnumerator_EnumerateFacenames" (self As wxFontEnumerator Ptr, enc As wxFontEncoding, fixedWidthOnly As wxBool) As wxBool
Declare Function wxFontEnumerator_EnumerateEncodings WXCALL Alias "wxFontEnumerator_EnumerateEncodings" (self As wxFontEnumerator Ptr, facenameArg As wxString Ptr) As wxBool

#EndIf ' __fontmisc_bi__

