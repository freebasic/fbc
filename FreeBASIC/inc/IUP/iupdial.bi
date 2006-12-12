''
''
'' iupdial -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupdial_bi__
#define __iupdial_bi__

#define ICTL_MOUSEMOVE_CB "MOUSEMOVE_CB"
#define ICTL_BUTTON_PRESS_CB "BUTTON_PRESS_CB"
#define ICTL_BUTTON_RELEASE_CB "BUTTON_RELEASE_CB"
#define ICTL_DENSITY "DENSITY"
#define ICTL_HORIZONTAL "HORIZONTAL"
#define ICTL_VERTICAL "VERTICAL"
#define ICTL_CIRCULAR "CIRCULAR"
#define ICTL_UNIT "UNIT"

extern "c"
declare function IupDial (byval as zstring ptr) as Ihandle ptr
declare sub IupDialOpen ()
end extern

#endif
