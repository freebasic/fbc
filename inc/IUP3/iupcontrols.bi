/'** \file
 * \brief initializes dial, gauge, colorbrowser, colorbar controls.
 *
 * See Copyright Notice in "iup.h"
 *'/

#ifndef __iupcontrols_bi__
#define __iupcontrols_bi__

extern "C"

declare function IupControlsOpen () as integer

declare function IupColorbar () as Ihandle ptr
declare function IupCells () as Ihandle ptr
declare function IupColorBrowser () as Ihandle ptr
declare function IupColorBrowser () as Ihandle ptr
declare function IupGauge () as Ihandle ptr
declare function IupDial (byval type as zstring ptr) as Ihandle ptr
declare function IupMatrix (byval action as zstring ptr) as Ihandle ptr

'/* IupMatrix utilities */
declare sub IupMatSetAttribute (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer, byval value as zstring ptr)
declare sub IupMatStoreAttribute (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer, byval value as zstring ptr)
declare function IupMatGetAttribute (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer) as zstring ptr
declare function IupMatGetInt (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer) as integer
declare function IupMatGetFloat (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer) as single
declare sub IupMatSetfAttribute (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer, byval format as zstring ptr, ...)

'/* Used by IupColorbar */
#define IUP_PRIMARY -1
#define IUP_SECONDARY -2

end extern

#endif
