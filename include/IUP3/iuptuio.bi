/'** \file
 * \brief IupTuioClient control
 *
 * See Copyright Notice in "iup.h"
 *'/
#ifndef __iuptuio_bi__
#define __iuptuio_bi__

extern "C"

declare function IupTuioOpen () as integer
declare function IupTuioClient (byval port as integer) as Ihandle ptr

end extern
#endif
