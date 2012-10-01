#Ifndef __textdialog_bi__
#Define __textdialog_bi__

#Include Once "common.bi"

Declare Function wxTextEntryDialog_ctor WXCALL Alias "wxTextEntryDialog_ctor" (parent As wxWindow Ptr, _
                            messageArg As wxString Ptr, _
                            captionArg As wxString Ptr, _
                            valueArg   As wxString Ptr, _
                            style      As wxUInt, _
                            x          As wxInt, _
                            y          As wxInt) As wxTextEntryDialog Ptr
Declare Sub wxTextEntryDialog_dtor WXCALL Alias "wxTextEntryDialog_dtor" (self As wxTextEntryDialog Ptr)
Declare Function wxTextEntryDialog_ShowModal WXCALL Alias "wxTextEntryDialog_ShowModal" (self As wxTextEntryDialog Ptr) As wxInt
Declare Sub wxTextEntryDialog_SetValue WXCALL Alias "wxTextEntryDialog_SetValue" (self As wxTextEntryDialog Ptr, value As wxString Ptr)
Declare Function wxTextEntryDialog_GetValue WXCALL Alias "wxTextEntryDialog_GetValue" (self As wxTextEntryDialog Ptr) As wxString Ptr
Declare Function wxGetPasswordFromUser_func WXCALL Alias "wxGetPasswordFromUser_func" (messageArg As wxString Ptr, _
                                captionArg As wxString Ptr, _
                                ValueArg   As wxString Ptr, _
                                parent     As wxWindow Ptr) As wxString Ptr
Declare Function wxGetTextFromUser_func WXCALL Alias "wxGetTextFromUser_func" (messageArg As wxString Ptr, _
                            captionArg As wxString Ptr, _
                            ValueArg   As wxString Ptr, _
                            parent     As wxWindow Ptr, _
                            x          As  wxInt, _
                            y          As  wxInt, _
                            bCenter    As wxBool) As wxString Ptr

#EndIf '__textdialog_bi__
