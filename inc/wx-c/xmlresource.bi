#Ifndef __xmlresource_bi__
#Define __xmlresource_bi__

#Include Once "common.bi"

Enum XmlResourceFlags
  XRC_USE_LOCALE     = 1
  XRC_NO_SUBCLASSING = 2
End Enum

Type XmlSubclassCreate As Function WXCALL (nam As wxString Ptr) As wxObject Ptr 

' class wxXmlSubclassFactory
Declare Sub wxXmlSubclassFactory_ctor WXCALL Alias "wxXmlSubclassFactory_ctor" (create As XmlSubclassCreate)

' class wxXmlResource
Declare Function wxXmlResource_ctor WXCALL Alias "wxXmlResource_ctor" (flags As XmlResourceFlags) As wxXmlResource Ptr
Declare Function wxXmlResource_ctorByFilemask WXCALL Alias "wxXmlResource_ctorByFilemask" (filemask As wxString Ptr, flags As XmlResourceFlags = XRC_USE_LOCALE) As wxXmlResource Ptr
Declare Sub wxXmlResource_InitAllHandlers WXCALL Alias "wxXmlResource_InitAllHandlers" (self As wxXmlResource Ptr)
Declare Function wxXmlResource_Load WXCALL Alias "wxXmlResource_Load" (self As wxXmlResource Ptr, filemask As wxString Ptr) As wxChar
Declare Function wxXmlResource_LoadFromByteArray WXCALL Alias "wxXmlResource_LoadFromByteArray" (self As wxXmlResource Ptr, filemask As wxString Ptr, pData As wxChar Ptr, length As size_t) As wxChar
Declare Function wxXmlResource_LoadDialog WXCALL Alias "wxXmlResource_LoadDialog" (self As wxXmlResource Ptr, parent As wxWindow Ptr, nam As wxString Ptr) As wxDialog Ptr
Declare Function wxXmlResource_LoadDialogDlg WXCALL Alias "wxXmlResource_LoadDialogDlg" (self As wxXmlResource Ptr, dlg As wxDialog Ptr, parent As wxWindow Ptr, nam As wxString Ptr) As wxChar
Declare Function wxXmlResource_GetXRCID WXCALL Alias "wxXmlResource_GetXRCID" (cstrid As wxString Ptr) As wxInt
Declare Function wxXmlResource_GetVersion WXCALL Alias "wxXmlResource_GetVersion" (self As wxXmlResource Ptr) As wxInt
Declare Function wxXmlResource_LoadFrameWithFrame WXCALL Alias "wxXmlResource_LoadFrameWithFrame" (self As wxXmlResource Ptr, frame As wxFrame Ptr, parent As wxWindow Ptr, nam As wxString Ptr) As wxChar
Declare Function wxXmlResource_LoadFrame WXCALL Alias "wxXmlResource_LoadFrame" (self As wxXmlResource Ptr, parent As wxWindow Ptr, nam As wxString Ptr) As wxFrame Ptr
Declare Function wxXmlResource_LoadBitmap WXCALL Alias "wxXmlResource_LoadBitmap" (self As wxXmlResource Ptr, nam As wxString Ptr) As wxBitmap Ptr
Declare Function wxXmlResource_LoadIcon WXCALL Alias "wxXmlResource_LoadIcon" (self As wxXmlResource Ptr, nam As wxString Ptr) As wxIcon Ptr
Declare Function wxXmlResource_LoadMenu WXCALL Alias "wxXmlResource_LoadMenu" (self As wxXmlResource Ptr, nam As wxString Ptr) As wxMenu Ptr
Declare Function wxXmlResource_LoadMenuBarWithParent WXCALL Alias "wxXmlResource_LoadMenuBarWithParent" (self As wxXmlResource Ptr, parent As wxWindow Ptr, nam As wxString Ptr) As wxMenuBar Ptr
Declare Function wxXmlResource_LoadMenuBar WXCALL Alias "wxXmlResource_LoadMenuBar" (self As wxXmlResource Ptr, nam As wxString Ptr) As wxMenuBar Ptr
Declare Function wxXmlResource_LoadPanelWithPanel WXCALL Alias "wxXmlResource_LoadPanelWithPanel" (self As wxXmlResource Ptr,panel As wxPanel Ptr, parent As wxWindow Ptr, nam As wxString Ptr) As wxChar
Declare Function wxXmlResource_LoadPanel WXCALL Alias "wxXmlResource_LoadPanel" (self As wxXmlResource Ptr, parent As wxWindow Ptr, nam As wxString Ptr) As wxPanel Ptr
Declare Function wxXmlResource_LoadToolBar WXCALL Alias "wxXmlResource_LoadToolBar" (self As wxXmlResource Ptr, parent As wxWindow Ptr, nam As wxString Ptr) As wxToolBar Ptr
Declare Sub wxXmlResource_SetFlags WXCALL Alias "wxXmlResource_SetFlags" (self As wxXmlResource Ptr, flags As wxInt)
Declare Function wxXmlResource_GetFlags WXCALL Alias "wxXmlResource_GetFlags" (self As wxXmlResource Ptr) As wxInt
Declare Function wxXmlResource_CompareVersion WXCALL Alias "wxXmlResource_CompareVersion" (self As wxXmlResource Ptr, major As wxInt, minor As wxInt, release As wxInt, revision As wxInt) As wxInt
'Declare Sub wxXmlResource_UpdateResources WXCALL Alias "wxXmlResource_UpdateResources" (self As wxXmlResource Ptr)
Declare Function wxXmlResource_AttachUnknownControl WXCALL Alias "wxXmlResource_AttachUnknownControl" (self As wxXmlResource Ptr, nam As wxString Ptr, control As wxWindow Ptr, parent As wxWindow Ptr) As wxChar

#EndIf ' __xmlresource_bi__

