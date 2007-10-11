''
''
'' wxstring -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_wxstring_bi__
#define __wxc_wxstring_bi__

#include once "wx.bi"

declare function wxString alias "wxString_ctor" (byval str as zstring ptr) as wxString ptr
declare sub wxString_dtor (byval self as wxString ptr)
declare function wxString_mb_str (byval self as wxString ptr) as zstring ptr
declare function wxString_Length (byval self as wxString ptr) as integer
declare function wxString_CharAt (byval self as wxString ptr, byval i as integer) as byte
declare function wxString_CharAtInt (byval self as wxString ptr, byval i as integer) as integer

#endif
