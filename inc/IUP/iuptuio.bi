#pragma once

extern "C"

#define __IUPTUIO_H
declare function IupTuioOpen() as long
declare function IupTuioClient(byval port as long) as Ihandle ptr

end extern
