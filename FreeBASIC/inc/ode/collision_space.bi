''
''
'' collision_space -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ode_collision_space_bi__
#define __ode_collision_space_bi__

#include once "ode/common.bi"

type dNearCallback as any

declare function dSimpleSpaceCreate cdecl alias "dSimpleSpaceCreate" (byval space as dSpaceID) as dSpaceID
declare function dHashSpaceCreate cdecl alias "dHashSpaceCreate" (byval space as dSpaceID) as dSpaceID
declare function dQuadTreeSpaceCreate cdecl alias "dQuadTreeSpaceCreate" (byval space as dSpaceID, byval Center as dVector3, byval Extents as dVector3, byval Depth as integer) as dSpaceID
declare sub dSpaceDestroy cdecl alias "dSpaceDestroy" (byval as dSpaceID)
declare sub dHashSpaceSetLevels cdecl alias "dHashSpaceSetLevels" (byval space as dSpaceID, byval minlevel as integer, byval maxlevel as integer)
declare sub dHashSpaceGetLevels cdecl alias "dHashSpaceGetLevels" (byval space as dSpaceID, byval minlevel as integer ptr, byval maxlevel as integer ptr)
declare sub dSpaceSetCleanup cdecl alias "dSpaceSetCleanup" (byval space as dSpaceID, byval mode as integer)
declare function dSpaceGetCleanup cdecl alias "dSpaceGetCleanup" (byval space as dSpaceID) as integer
declare sub dSpaceAdd cdecl alias "dSpaceAdd" (byval as dSpaceID, byval as dGeomID)
declare sub dSpaceRemove cdecl alias "dSpaceRemove" (byval as dSpaceID, byval as dGeomID)
declare function dSpaceQuery cdecl alias "dSpaceQuery" (byval as dSpaceID, byval as dGeomID) as integer
declare sub dSpaceClean cdecl alias "dSpaceClean" (byval as dSpaceID)
declare function dSpaceGetNumGeoms cdecl alias "dSpaceGetNumGeoms" (byval as dSpaceID) as integer
declare function dSpaceGetGeom cdecl alias "dSpaceGetGeom" (byval as dSpaceID, byval i as integer) as dGeomID

#endif
