/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001-2003 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy) http://fsr.sf.net/forum     *
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


type dNearCallback as sub cdecl (lpData as any ptr, _
                                 o1 as dGeomID, _
                                 o2 as dGeomID) ptr

extern "C"

declare function dSimpleSpaceCreate   (byval s as dSpaceID) as dSpaceID
declare function dHashSpaceCreate     (byval s as dSpaceID) as dSpaceID
declare function dQuadTreeSpaceCreate (byval s as dSpaceID, byval Center as dVector3, byval Extents as dVector3, byval Depth as integer) as dSpaceID
declare sub      dSpaceDestroy        (byval s as dSpaceID)

declare sub      dHashSpaceSetLevels  (byval s as dSpaceID, byval minlevel as integer    , byval maxlevel as integer)
declare sub      dHashSpaceGetLevels  (byval s as dSpaceID, byval minlevel as integer ptr, byval maxlevel as integer ptr)

declare sub      dSpaceSetCleanup     (byval s as dSpaceID, byval mode     as integer)
declare function dSpaceGetCleanup     (byval s as dSpaceID) as integer

declare sub      dSpaceAdd            (byval s as dSpaceID, byval as dGeomID)
declare sub      dSpaceRemove         (byval s as dSpaceID, byval as dGeomID)
declare function dSpaceQuery          (byval s as dSpaceID, byval as dGeomID) as integer
declare sub      dSpaceClean          (byval s as dSpaceID)
declare function dSpaceGetNumGeoms    (byval s as dSpaceID) as integer
declare function dSpaceGetGeom        (byval s as dSpaceID, byval i as integer) as dGeomID

end extern
#endif ' __ode_collision_space_bi__
