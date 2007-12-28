''
''
'' tipwindow -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_tipwindow_bi__
#define __wxc_tipwindow_bi__

#include once "wx.bi"


declare function wxTipWindow alias "wxTipWindow_ctor" (byval parent as wxWindow ptr, byval text as zstring ptr, byval maxLength as wxCoord, byval rectBound as wxRect ptr) as wxTipWindow ptr
declare function wxTipWindow_ctorNoRect (byval parent as wxWindow ptr, byval text as zstring ptr, byval maxLength as wxCoord) as wxTipWindow ptr
declare sub wxTipWindow_SetBoundingRect (byval self as wxTipWindow ptr, byval rectBound as wxRect ptr)

#endif
