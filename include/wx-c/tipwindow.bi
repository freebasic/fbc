#Ifndef __tipwindow_bi__
#Define __tipwindow_bi__

#Include Once "common.bi"

Declare Function wxTipWindow_ctor WXCALL Alias "wxTipWindow_ctor" (parent As wxWindow Ptr, _
                      txt       As wxString Ptr, _
                      maxLength As  wxCoord , _
                      x         As  wxInt, _
                      y         As  wxInt, _
                      w         As  wxInt, _
                      h         As  wxInt) As wxTipWindow Ptr
Declare Function wxTipWindow_ctorNoRect WXCALL Alias "wxTipWindow_ctorNoRect" (parent As wxWindow Ptr, _
                            txt       As wxString Ptr, _
                            maxLength As  wxCoord) As wxTipWindow Ptr
Declare Sub wxTipWindow_SetBoundingRect WXCALL Alias "wxTipWindow_SetBoundingRect" (self As wxTipWindow Ptr, r As wxRect Ptr)

#EndIf ' __tipwindow_bi__

