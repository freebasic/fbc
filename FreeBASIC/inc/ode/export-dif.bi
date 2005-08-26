''
''
'' export-dif -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __export_dif_bi__
#define __export_dif_bi__

#include once "ode/common.bi"

declare sub dWorldExportDIF cdecl alias "dWorldExportDIF" (byval w as dWorldID, byval file as FILE ptr, byval world_name as zstring ptr)

#endif
