''
''
'' progdlg -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_progdlg_bi__
#define __wxc_progdlg_bi__

#include once "wx.bi"


declare function wxProgressDialog alias "wxProgressDialog_ctor" (byval title as zstring ptr, byval message as zstring ptr, byval maximum as integer, byval parent as wxWindow ptr, byval style as integer) as wxProgressDialog ptr
declare sub wxProgressDialog_dtor (byval self as wxProgressDialog ptr)
declare function wxProgressDialog_Update (byval self as wxProgressDialog ptr, byval value as integer, byval newmsg as zstring ptr) as integer
declare sub wxProgressDialog_Resume (byval self as wxProgressDialog ptr)
declare function wxProgressDialog_Show (byval self as wxProgressDialog ptr, byval show as integer) as integer

#endif
