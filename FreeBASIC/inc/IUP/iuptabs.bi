''
''
'' iuptabs -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iuptabs_bi__
#define __iuptabs_bi__

#define ICTL_TOP "TOP"
#define ICTL_BOTTOM "BOTTOM"
#define ICTL_LEFT "LEFT"
#define ICTL_RIGHT "RIGHT"
#define ICTL_TABTYPE "TABTYPE"
#define ICTL_TABTITLE "TABTITLE"
#define ICTL_TABSIZE "TABSIZE"
#define ICTL_TABCHANGE_CB "TABCHANGE_CB"
#define ICTL_FONT "FONT"
#define ICTL_FONT_ACTIVE "FONT_ACTIVE"
#define ICTL_FONT_INACTIVE "FONT_INACTIVE"

extern "c"
declare sub IupTabsOpen ()
declare function IupTabsv (byval params as Ihandle ptr ptr) as Ihandle ptr
declare function IupTabs (byval first as Ihandle ptr, ...) as Ihandle ptr
end extern

#endif
