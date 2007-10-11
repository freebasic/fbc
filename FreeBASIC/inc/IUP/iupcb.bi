''
''
'' iupcb -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupcb_bi__
#define __iupcb_bi__

extern "c"
declare sub IupColorBrowserOpen ()
declare function IupColorBrowser () as Ihandle ptr
end extern

#define IUP_RGB "RGB"
#define IUP_CHANGE_CB "CHANGE_CB"
#define IUP_DRAG_CB "DRAG_CB"

#endif
