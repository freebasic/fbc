'' FreeBASIC binding for iup-3.11.2

#pragma once

extern "C"

#define __IUPTUIO_H
declare function IupTuioOpen() as long
declare function IupTuioClient(byval port as long) as Ihandle ptr

end extern
