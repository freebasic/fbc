#pragma once

extern "C"

#define __IUPCONTROLS_H
declare function IupControlsOpen() as long
declare sub IupControlsClose()
declare function IupColorbar() as Ihandle ptr
declare function IupCells() as Ihandle ptr
declare function IupColorBrowser() as Ihandle ptr
declare function IupGauge() as Ihandle ptr
declare function IupDial(byval type as const zstring ptr) as Ihandle ptr
declare function IupMatrix(byval action as const zstring ptr) as Ihandle ptr
declare function IupMatrixList() as Ihandle ptr
declare sub IupMatSetAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval value as const zstring ptr)
declare sub IupMatStoreAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval value as const zstring ptr)
declare function IupMatGetAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long) as zstring ptr
declare function IupMatGetInt(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long) as long
declare function IupMatGetFloat(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long) as single
declare sub IupMatSetfAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval format as const zstring ptr, ...)
#define IUP_PRIMARY (-1)
#define IUP_SECONDARY (-2)

end extern
