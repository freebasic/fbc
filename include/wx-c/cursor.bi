#Ifndef __cursor_bi__
#Define __cursor_bi__

#Include Once "common.bi"

Declare Function wxCursor_ctorImage WXCALL Alias "wxCursor_ctorImage" (image As wxImage Ptr) As wxCursor Ptr
Declare Function wxCursor_ctorCopy WXCALL Alias "wxCursor_ctorCopy" (other As wxCursor Ptr) As wxCursor Ptr
Declare Function wxCursor_ctorById WXCALL Alias "wxCursor_ctorById" (id As wxInt) As wxCursor Ptr
Declare Function wxCursor_Ok WXCALL Alias "wxCursor_Ok" (self As wxCursor Ptr) As wxBool
Declare Sub wxCursor_SetCursor WXCALL Alias "wxCursor_SetCursor" (cursor As wxCursor Ptr)

#EndIf ' __cursor_bi__

