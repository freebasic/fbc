'' FreeBASIC binding for iup-3.11.2

#pragma once

extern "C"

#define __IUPMATRIXEX_H
declare sub IupMatrixExOpen()
declare function IupMatrixEx() as Ihandle ptr
declare sub IupMatrixExInit(byval ih as Ihandle ptr)

end extern
