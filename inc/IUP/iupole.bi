'' FreeBASIC binding for iup-3.11.2

#pragma once

extern "C"

#define __IUPOLE_H
declare function IupOleControl(byval progid as const zstring ptr) as Ihandle ptr
declare function IupOleControlOpen() as long

end extern
