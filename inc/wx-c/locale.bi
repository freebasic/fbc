#Ifndef __locale_bi__
#Define __locale_bi__

#Include Once "common.bi"

' class wxLanguageInfo
Declare Function wxLanguageInfo_ctor WXCALL Alias "wxLanguageInfo_ctor" () As wxLanguageInfo Ptr
Declare Sub wxLanguageInfo_dtor WXCALL Alias "wxLanguageInfo_dtor" (self As wxLanguageInfo Ptr)
Declare Sub wxLanguageInfo_SetLanguage WXCALL Alias "wxLanguageInfo_SetLanguage" (self As wxLanguageInfo Ptr, value As wxInt)
Declare Function wxLanguageInfo_GetLanguage WXCALL Alias "wxLanguageInfo_GetLanguage" (self As wxLanguageInfo Ptr) As wxInt
Declare Sub wxLanguageInfo_SetCanonicalName WXCALL Alias "wxLanguageInfo_SetCanonicalName" (self As wxLanguageInfo Ptr, nam As wxString Ptr)
Declare Function wxLanguageInfo_GetCanonicalName WXCALL Alias "wxLanguageInfo_GetCanonicalName" (self As wxLanguageInfo Ptr) As wxString Ptr
Declare Sub wxLanguageInfo_SetDescription WXCALL Alias "wxLanguageInfo_SetDescription" (self As wxLanguageInfo Ptr, nam As wxString Ptr)
Declare Function wxLanguageInfo_GetDescription WXCALL Alias "wxLanguageInfo_GetDescription" (self As wxLanguageInfo Ptr) As wxString Ptr

' class wxLocale
Declare Function wxLocale_ctor WXCALL Alias "wxLocale_ctor" () As wxLocale Ptr
Declare Function wxLocale_ctor2 WXCALL Alias "wxLocale_ctor2" (iLanguage As wxInt, iFlags As wxInt) As wxLocale Ptr
Declare Sub wxLocale_dtor WXCALL Alias "wxLocale_dtor" (self As wxLocale Ptr)
Declare Function wxLocale_Init WXCALL Alias "wxLocale_Init" (self As wxLocale Ptr, iLanguage As wxInt, iFlags As wxInt) As wxInt
Declare Function wxLocale_AddCatalog WXCALL Alias "wxLocale_AddCatalog" (self As wxLocale Ptr, domain As wxString Ptr) As wxInt
Declare Function wxLocale_AddCatalog2 WXCALL Alias "wxLocale_AddCatalog2" (self As wxLocale Ptr, domain As wxString Ptr, msgIdLanguage As wxLanguage, msgIdCharset As wxString Ptr) As wxInt
Declare Sub wxLocale_AddCatalogLookupPathPrefix WXCALL Alias "wxLocale_AddCatalogLookupPathPrefix" (self As wxLocale Ptr, prefix As wxString Ptr)
Declare Sub wxLocale_AddLanguage WXCALL Alias "wxLocale_AddLanguage" (info As wxLanguageInfo Ptr)
Declare Function wxLocale_FindLanguageInfo WXCALL Alias "wxLocale_FindLanguageInfo" (locale As wxString Ptr) As wxLanguageInfo Ptr
Declare Function wxLocale_GetCanonicalName WXCALL Alias "wxLocale_GetCanonicalName" (self As wxLocale Ptr) As wxString Ptr
Declare Function wxLocale_GetLanguage WXCALL Alias "wxLocale_GetLanguage" (self As wxLocale Ptr) As wxInt
Declare Function wxLocale_GetLanguageInfo WXCALL Alias "wxLocale_GetLanguageInfo" (iLang As wxInt) As wxLanguageInfo Ptr
Declare Function wxLocale_GetLanguageName WXCALL Alias "wxLocale_GetLanguageName" (iLang As wxInt) As wxString Ptr
Declare Function wxLocale_GetLocale WXCALL Alias "wxLocale_GetLocale" (self As wxLocale Ptr) As wxString Ptr
Declare Function wxLocale_GetName WXCALL Alias "wxLocale_GetName" (self As wxLocale Ptr) As wxString Ptr

' szDomain might be NULL
Declare Function wxLocale_GetString WXCALL Alias "wxLocale_GetString" (self As wxLocale Ptr, szOrigString As wxString Ptr, domain As wxString Ptr) As wxString Ptr
Declare Function wxLocale_GetHeaderValue WXCALL Alias "wxLocale_GetHeaderValue" (self As wxLocale Ptr, szHeader As wxString Ptr, domain As wxString Ptr) As wxString Ptr
Declare Function wxLocale_GetSysName WXCALL Alias "wxLocale_GetSysName" (self As wxLocale Ptr) As wxString Ptr
Declare Function wxLocale_GetSystemEncoding WXCALL Alias "wxLocale_GetSystemEncoding" () As wxFontEncoding
Declare Function wxLocale_GetSystemEncodingName WXCALL Alias "wxLocale_GetSystemEncodingName" () As wxString Ptr
Declare Function wxLocale_GetSystemLanguage WXCALL Alias "wxLocale_GetSystemLanguage" () As wxInt
Declare Function wxLocale_IsLoaded WXCALL Alias "wxLocale_IsLoaded" (self As wxLocale Ptr, domain As wxString Ptr) As wxInt
Declare Function wxLocale_IsOk WXCALL Alias "wxLocale_IsOk" (self As wxLocale Ptr) As wxInt

#EndIf ' __locale_bi__

