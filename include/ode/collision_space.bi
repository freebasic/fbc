/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001-2003 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy)                             *
 *                                                                       *
 * This library is free software; you can redistribute it and/or         *
 * modify it under the terms of EITHER:                                  *
 *   (1) The GNU Lesser General Public License as published by the Free  *
 *       Software Foundation; either version 2.1 of the License, or (at  *
 *       your option) any later version. The text of the GNU Lesser      *
 *       General Public License is included with this library in the     *
 *       file LICENSE.TXT.                                               *
 *   (2) The BSD-style license that is included with this library in     *
 *       the file LICENSE-BSD.TXT.                                       *
 *                                                                       *
 * This library is distributed in the hope that it will be useful,       *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the files    *
 * LICENSE.TXT and LICENSE-BSD.TXT for more details.                     *
 *                                                                       *
 ************************************************************************'/
#ifndef __ode_collision_space_bi__
#define __ode_collision_space_bi__

#include "common.bi"

type dNearCallback as any

declare function dSimpleSpaceCreate   cdecl alias "dSimpleSpaceCreate"   (byval s as dSpaceID) as dSpaceID
declare function dHashSpaceCreate     cdecl alias "dHashSpaceCreate"     (byval s as dSpaceID) as dSpaceID
declare function dQuadTreeSpaceCreate cdecl alias "dQuadTreeSpaceCreate" (byval s as dSpaceID, byval Center as dVector3, byval Extents as dVector3, byval Depth as integer) as dSpaceID
declare sub      dSpaceDestroy        cdecl alias "dSpaceDestroy"       (byval s as dSpaceID)


' SAP
' Order XZY or ZXY usually works best, if your Y is up.
#define dSAP_AXES_XYZ  ((0) or (1 shl 2) or (2 shl 4))
#define dSAP_AXES_XZY  ((0) or (2 shl 2) or (1 shl 4))
#define dSAP_AXES_YXZ  ((1) or (0 shl 2) or (2 shl 4))
#define dSAP_AXES_YZX  ((1) or (2 shl 2) or (0 shl 4))
#define dSAP_AXES_ZXY  ((2) or (0 shl 2) or (1 shl 4))
#define dSAP_AXES_ZYX  ((2) or (1 shl 2) or (0 shl 4))

declare function dSweepAndPruneSpaceCreate cdecl alias "dSweepAndPruneSpaceCreate" (byval s as dSpaceID,byval axisorder as integer) as dSpaceID

declare sub      dHashSpaceSetLevels  cdecl alias "dHashSpaceSetLevels" (byval s as dSpaceID, byval minlevel as integer    , byval maxlevel as integer)
declare sub      dHashSpaceGetLevels  cdecl alias "dHashSpaceGetLevels" (byval s as dSpaceID, byval minlevel as integer ptr, byval maxlevel as integer ptr)

declare sub      dSpaceSetCleanup     cdecl alias "dSpaceSetCleanup"    (byval s as dSpaceID, byval mode     as integer)
declare function dSpaceGetCleanup     cdecl alias "dSpaceGetCleanup"    (byval s as dSpaceID) as integer

declare sub      dSpaceSetSublevel    cdecl alias "dSpaceSetSublevel"   (byval s as dSpaceID,byval sublevel as integer)
declare function dSpaceGetSublevel    cdecl alias "dSpaceGetSublevel"   (byval s as dSpaceID) as integer

declare sub      dSpaceSetManualCleanup cdecl alias "dSpaceSetManualCleanup" (byval s as dSpaceID, mode as integer)
declare function dSpaceGetManualCleanup cdecl alias "dSpaceGetManualCleanup" (byval s as dSpaceID) as integer

declare sub      dSpaceAdd            cdecl alias "dSpaceAdd"           (byval s as dSpaceID, byval as dGeomID)
declare sub      dSpaceRemove         cdecl alias "dSpaceRemove"        (byval s as dSpaceID, byval as dGeomID)
declare function dSpaceQuery          cdecl alias "dSpaceQuery"         (byval s as dSpaceID, byval as dGeomID) as integer
declare sub      dSpaceClean          cdecl alias "dSpaceClean"         (byval s as dSpaceID)
declare function dSpaceGetNumGeoms    cdecl alias "dSpaceGetNumGeoms"   (byval s as dSpaceID) as integer
declare function dSpaceGetGeom        cdecl alias "dSpaceGetGeom"       (byval s as dSpaceID, byval i as integer) as dGeomID

declare function dSpaceGetClass       cdecl alias "dSpaceGetClass"      (byval a as dSpaceID) as integer

#endif ' __ode_collision_space_bi__
