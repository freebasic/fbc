#Ifndef __wizardpagesimple_bi__
#Define __wizardpagesimple_bi__

#Include Once "common.bi"

' class wxWizPageSimp
Declare Function wxWizPageSimp_ctor WXCALL Alias "wxWizPageSimp_ctor" (parent As wxWizard Ptr, prev As wxWizardPage Ptr, nex As wxWizardPage Ptr) As wxWizardPageSimple Ptr
Declare Sub wxWizPageSimp_Chain WXCALL Alias "wxWizPageSimp_Chain" (page1 As wxWizardPageSimple Ptr,page2 As wxWizardPageSimple Ptr)

#EndIf ' __wizardpagesimple_bi__

