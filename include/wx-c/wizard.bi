#Ifndef __wizard_bi__
#Define __wizard_bi__

#Include Once "common.bi"

' class wxWizard
Declare Function wxWizard_ctor WXCALL Alias "wxWizard_ctor" (parent As wxWindow Ptr, _
                                id       As wxInt, _
                                titleArg As wxString Ptr, _
                                bitmap   As wxBitmap Ptr, _
                                x        As wxInt, _
                                y        As wxInt) As wxWizard Ptr
Declare Function wxWizard_RunWizard WXCALL Alias "wxWizard_RunWizard" (self As wxWizard Ptr, firstpage As wxWizardPage Ptr) As wxChar
Declare Sub wxWizard_SetPageSize WXCALL Alias "wxWizard_SetPageSize" (self As wxWizard Ptr,size As wxSize Ptr)
Declare Function wxWizardEvent_GetDirection WXCALL Alias "wxWizardEvent_GetDirection" (self As wxWizardEvent Ptr) As wxChar
Declare Function wxWizardEvent_GetPage WXCALL Alias "wxWizardEvent_GetPage" (self As wxWizardEvent Ptr) As wxWizardPage Ptr

#EndIf ' __wizard_bi__

