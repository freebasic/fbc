#Ifndef __tipdialog_bi__
#Define __tipdialog_bi__

#Include Once "common.bi"

Declare Function wxTipProvider_GetCurrentTip WXCALL Alias "wxTipProvider_GetCurrentTip" () As size_t
Declare Function wxCreateFileTipProvider_func WXCALL Alias "wxCreateFileTipProvider_func" (filename As wxString Ptr, currentTip As  size_t) As wxTipProvider Ptr
Declare Function wxShowTip_func WXCALL Alias "wxShowTip_func" (parent As wxWindow Ptr, showAtStartup As wxBool) As wxBool

#EndIf ' __tipdialog_bi__

