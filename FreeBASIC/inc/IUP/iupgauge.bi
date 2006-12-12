''
''
'' iupgauge -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupgauge_bi__
#define __iupgauge_bi__

#define ICTL_SHOW_TEXT "SHOW_TEXT"
#define ICTL_DASHED "DASHED"
#define ICTL_MARGIN "MARGIN"
#define ICTL_TEXT "TEXT"

extern "c"
declare function IupGauge () as Ihandle ptr
declare sub IupGaugeOpen ()
end extern

#endif
