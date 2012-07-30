#Ifndef __messagedialog_bi__
#Define __messagedialog_bi__

#Include Once "common.bi"

Declare Function wxMsgBox WXCALL Alias "wxMsgBox" (parent  As wxWindow Ptr, _
              message As wxString Ptr, _
              caption As wxString Ptr, _
              style   As  wxUint, _
              x       As  wxInt, _
              y       As  wxInt) As wxInt
Declare Function wxMessageDialog_ctor WXCALL Alias "wxMessageDialog_ctor" (parent  As wxWindow Ptr, _
                          message As wxString Ptr, _
                          caption As wxString Ptr, _
                          style   As  wxUInt, _
                          x       As  wxInt, _
                          y       As  wxInt) As wxMessageDialog Ptr
Declare Function wxMessageDialog_ShowModal WXCALL Alias "wxMessageDialog_ShowModal" (self As wxMessageDialog Ptr) As wxInt

#EndIf ' __messagedialog_bi__

