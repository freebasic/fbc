''
''
'' notebooksizer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __notebooksizer_bi__
#define __notebooksizer_bi__

#include once "wx-c/wx.bi"
#include once "wx-c/sizer.bi"

declare function wxNotebookSizer cdecl alias "wxNotebookSizer_ctor" (byval nb as wxNotebook ptr) as wxNotebookSizer ptr
declare sub wxNotebookSizer_RecalcSizes cdecl alias "wxNotebookSizer_RecalcSizes" (byval self as wxNotebookSizer ptr)
declare sub wxNotebookSizer_CalcMin cdecl alias "wxNotebookSizer_CalcMin" (byval self as wxNotebookSizer ptr, byval size as wxSize ptr)
declare function wxNotebookSizer_GetNotebook cdecl alias "wxNotebookSizer_GetNotebook" (byval self as wxNotebookSizer ptr) as wxNotebook ptr

#endif
