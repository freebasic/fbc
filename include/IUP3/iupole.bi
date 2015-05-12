/'** \file
 * \brief Ole control.
 *
 * See Copyright Notice in "iup.h"
 *'/

#ifndef __iupole_bi__
#define __iupole_bi__

#inclib "iupole"

extern "C"

declare function IupOleControl (byval progid as zstring ptr) as Ihandle ptr
declare function IupOleControlOpen () as integer

end extern

#endif
